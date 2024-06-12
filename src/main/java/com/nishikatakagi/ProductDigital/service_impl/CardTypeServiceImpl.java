package com.nishikatakagi.ProductDigital.service_impl;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nishikatakagi.ProductDigital.model.CardType;
import com.nishikatakagi.ProductDigital.repository.CardTypeRepository;
import com.nishikatakagi.ProductDigital.service.CardTypeService;

@Service
public class CardTypeServiceImpl implements CardTypeService {

    @Autowired
    CardTypeRepository cardTypeRepository;

    @Override
    public List<CardType> findAllCardTypes() {
        return cardTypeRepository.findAll();
    }

    @Override

    public CardType findById(int id) {
        Optional<CardType> optionalCardType = cardTypeRepository.findById(id);
        return optionalCardType.orElseThrow(); // Corrected
    }

    @Override
    public List<CardType> getCardTypeByPublisher(int publisherId) {
        return cardTypeRepository.findByPublisherId(publisherId);
    }

    @Override
    public CardType findCardTypeByPublisherAndMoney(Integer publisherId, Integer moneyId) {
        List<CardType> cardTypes = cardTypeRepository.findAll();
        for (CardType cardType : cardTypes) {
            if (cardType.getPublisher().getId() == publisherId && cardType.getMoney().getId() == moneyId) {
                return cardType;
            }
        }
        return null;
    }

}
