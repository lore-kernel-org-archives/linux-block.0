Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E63AC4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 12:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270C460F35
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 12:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbhHYMp4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 08:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhHYMp4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 08:45:56 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E070BC061757
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 05:45:10 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id q3so13234581iot.3
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 05:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RxPpgSQgkKyrk1U+ReD/ytMpCzoD0QvOLZSK0vnjQYc=;
        b=zIlo9OvubEx6yRcclRQdwluKW220y9xgip9d0OUdB0aBPq2VyKAh+jdsWfeA/5Jzhn
         ilaHWw39RBBFfFkDCi+y65WBvYlAsTtbG4ccK6QAdr5J37+yYlifPvSjijyqEtCYi0zF
         QG3I1GigTn5zQ0MXwufayguZLcAVQt7ewbph2MvogtJA/PKH8LxkuxK0AetAzcuWAzms
         kxUimLSGwdLrYpYZXI00lgFNrYCBXB+Hqsr9w/zZap1xZpQuIaSLDVqztLsCvPLQIlRM
         zTb3vYAcWCsOKmCEAAkxEaNVHssbQRKnLI4UZxskaPBb7qAf2eIwTw3Oc4BXD8pVi49+
         CzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RxPpgSQgkKyrk1U+ReD/ytMpCzoD0QvOLZSK0vnjQYc=;
        b=FI8BN9nzZZ1rIl7JMvaVlICSQ+PCOUrDOOXawiUxlTB9oxIl8Fhc0ZLzSZ6Fhmgfp5
         P3vYP3vB3DHyIi48t8RJAkucAF1qB5hG/c53NEU0IROu2pMGA60ppV2f7IqxCf1KL378
         S/AT4nu6Mp1svzM9qiGeijXc4/JpXtxHSS8GdarDgqEbLW2cHRGwwZlzN36TbzOAPXwt
         tN3OrMs8/nZXXB+sMfAOoHduNpVPhRgj3lEFWiVwINtcq9tIWbB2NBRI0xdMLdc0+kwz
         hnD17lHpsxEenmpggCMeEfegeGpZlZbrSsY5UuBPODHKQ9dXJLR2PvUU/fUz7WeSEh7+
         BulA==
X-Gm-Message-State: AOAM531O9aICroJWPPKz0QwziY7np+tT1U1aqcEFZ1o5HSzhOl8pG+Wh
        hUboZEMo8WgbJHNo4QkSxo1tz6BNw/GBXA==
X-Google-Smtp-Source: ABdhPJzHR0cS72Y1ZQcMQrAoEIQaGJ7JHY35c+m6vsbCV7LyWhO0b3XT60EZ0FwQMQ1wR/+nxnnm4w==
X-Received: by 2002:a5d:8a0e:: with SMTP id w14mr22280876iod.94.1629895510182;
        Wed, 25 Aug 2021 05:45:10 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id r18sm12034556ioa.13.2021.08.25.05.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 05:45:09 -0700 (PDT)
Subject: Re: [PATCH] blk-crypto: fix check for too-large dun_bytes
To:     Eric Biggers <ebiggers@kernel.org>, linux-block@vger.kernel.org
Cc:     Satya Tangirala <satyaprateek2357@gmail.com>
References: <20210825055918.51975-1-ebiggers@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b63e482b-e69b-9f24-3dec-c4a02b46f6e1@kernel.dk>
Date:   Wed, 25 Aug 2021 06:45:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210825055918.51975-1-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/24/21 11:59 PM, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> dun_bytes needs to be less than or equal to the IV size of the
> encryption mode, not just less than or equal to BLK_CRYPTO_MAX_IV_SIZE.
> 
> Currently this doesn't matter since blk_crypto_init_key() is never
> actually passed invalid values, but we might as well fix this.

Applied, thanks.

-- 
Jens Axboe

