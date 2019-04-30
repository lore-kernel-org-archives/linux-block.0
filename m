Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66199C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 15:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2742021734
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 15:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pMof5wcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbfD3Pkn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:40:43 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50284 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfD3Pkn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 11:40:43 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so5420489itk.0
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2019 08:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XNf8bzdAk7mxTr6wScNWfO8BGhgDHiA4fX/BoxjAgcg=;
        b=pMof5wcmJ0LUqTFWWx4o2UtD3ppRgg7wMYsJig8GBxGxFsaz8YDswmVyFuUC8L9haM
         bWTgvhVjsU7i2tU5J5gY8uHiQab/D4HZfxpO8YYD9fAjqoS1HHfSt/RGl4j7LBfQur/h
         +NCs/7bcJt/sz/jlshrOdNKgR3eS8+TtkAkJfoQvXm5vxZnfymtzkVwupVD7qfR8ntIq
         1lALHnkb1nwY16vTa96XC6oOTdS0oDV/8f3ObhmGAuv4UMsPpWmR6lYZbp5v1GDjYRxn
         CqBmKZ0W/9QcYSaX37tnpp7TfeTvlqNb3yQTNIYEBV/8DrVPscX8x/MfDSW+2AG6eEeW
         YDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XNf8bzdAk7mxTr6wScNWfO8BGhgDHiA4fX/BoxjAgcg=;
        b=kuRecHXKDi+0+aJvHdpcupA5T1uAd3QVVXFSLYs0QwpnVBDTG40ioSUseR0YqhKbqA
         lLDj0/q6j9ArFI5px6v1eImmKq0m2rV4mr6XIB1O5fDBy/gtscZPxPmSVxclBxj7woyd
         OtAiTb4GVaOY+qLQiZA+A+VG+EzKV0jUhkE+qbglV3el0wNjl8wZytaLKXMNfc1xoBEL
         H1b/NZuLhSIk5jtnJDNGYSBa6WhjPBWbJsYWqXpU5WiUZGNd427r1dLTsJ3wahRe3qHB
         tVYkqS3laY8zFxpkFXPnHSzpQjSiqornJjC1B5i8k9S6nLrh3t3OnP7zPS3Hqy6wv0qS
         Ag/A==
X-Gm-Message-State: APjAAAVBskBrjoNV1JXcXfBoB0VouyWN7UgrttFOW/D9eB3Hp4LDKs2A
        byVTFlMqLaSj1ksJ87pBerOFPw==
X-Google-Smtp-Source: APXvYqxfp6Ww8YqTZgXv2Jj5nFCT4fYt1D4ewxgCPh/R9FaoqX4KHB9Mz9oRto40hSaRFi8+0OXZnA==
X-Received: by 2002:a24:690f:: with SMTP id e15mr4476417itc.42.1556638842645;
        Tue, 30 Apr 2019 08:40:42 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c13sm10047157ioi.28.2019.04.30.08.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 08:40:41 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] [io_uring] fix handling SQEs requesting NOWAIT
To:     =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <7bcb0eb3-46d1-70e4-1108-dfd9a348bb7c@stbuehler.de>
 <20190427183419.5971-1-source@stbuehler.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b5d0c13a-8cd3-4744-524b-d63b7355c60a@kernel.dk>
Date:   Tue, 30 Apr 2019 09:40:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190427183419.5971-1-source@stbuehler.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/27/19 12:34 PM, Stefan Bühler wrote:
> Not all request types set REQ_F_FORCE_NONBLOCK when they needed async
> punting; reverse logic instead and set REQ_F_NOWAIT if request mustn't
> be punted.

I like doing it this way, so we don't have to touch the other callers.
I've merged this one with my patch, no need to have two separate fixes
for it.

-- 
Jens Axboe

