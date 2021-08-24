Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBA1C4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 16:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 075AE61357
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 16:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhHXQL3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhHXQL3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 12:11:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A267C061757
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 09:10:44 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id g9so27041548ioq.11
        for <linux-block@vger.kernel.org>; Tue, 24 Aug 2021 09:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pjgXVFaTSfw1r9Dt/9U1Pnsp8Og3rRQO2QjSt8xkqzM=;
        b=rHi4g7rRRHlBzwOc66OzBQwNo8iv5T60jSoYSQYAKl7fcT9qurY5m+nVLAQsv7Sj/P
         A1iM9b7R6EWWQlX0pp7rKJs13KmrASkdzYbvlSB1ym5L8cjfvpgcPVhQWsQD74bSxoOC
         /3fgsgUdg7a5Cafb2NHJJjuQu7H8FYM+XBUgQuIEBZCQWOdJQkIpu/H7Y3O0UIJLgkVt
         j2EzYjp+Vq/z4+Tlg6bLA3DAUHgLVSHxlNMKVvutFpSlvIeIrL8zRaUukamRZySf/LBR
         vZmyC19qOD97BQ+xo0P6NnNTTj9nsRhlfTMktKRt69zpij6HzpaiwmD39s53BLXz6hBn
         q1Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pjgXVFaTSfw1r9Dt/9U1Pnsp8Og3rRQO2QjSt8xkqzM=;
        b=WLGe3mr6cD55zJKiwdHnnIhMthKtGRZOi6+zpAfGkKavuIewFTGWyNiQ7qZaHmre5F
         sIOVGzcxXxYfeQAX/9jiCeJcIbrw/z05U2RRQ5JCpJpmND1DfVG5EIwQQsktz+Z8kxGZ
         sV7K/XnPtxFIbBJQfNn58q7acHUTFCN/H6QctUiRFmpYqG/zd+vbvawxORE3TBgiEoFY
         tq2swSC8mayuTZVRMGNxsTwnIruBNZs0ekYlRaJRF86lkciXQrSzugicv5h8IoU4kbL1
         Q51domhqNOInNdr66vDc6UrF8rrTb+YS7C/u7/eZjwfPoB5K6kGJGonyuRd0ERAcAY9s
         3ceQ==
X-Gm-Message-State: AOAM532TQta5qfreJ6T3hYPJM2TfD/96YpS8ut4YwNCKUVWhh66gll3R
        3UHOS8foO7Ts3ToKv01oPhRm1uL5vit5VQ==
X-Google-Smtp-Source: ABdhPJw0PGC8F0WvhBDyUzbuzzGJsXXDy7bxpP2NOP3r8pGSWthioO/N7/e4WTxFC5fZKlBkJC9pKg==
X-Received: by 2002:a02:6995:: with SMTP id e143mr2118804jac.3.1629821443917;
        Tue, 24 Aug 2021 09:10:43 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id k2sm10143700ior.40.2021.08.24.09.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 09:10:43 -0700 (PDT)
Subject: Re: [PATCH] block: mark blkdev_fsync static
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210824151823.1575100-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dcb7d140-7321-8f72-b45f-9b0b4102dfdd@kernel.dk>
Date:   Tue, 24 Aug 2021 10:10:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210824151823.1575100-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/24/21 9:18 AM, Christoph Hellwig wrote:
> blkdev_fsync is only used inside of block_dev.c since the
> removal of the raw drіver.

Applied, thanks.

-- 
Jens Axboe

