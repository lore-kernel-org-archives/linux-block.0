Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C37C433B4
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 15:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11066128C
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 15:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242770AbhDLPUw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 11:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241439AbhDLPUv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 11:20:51 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210BCC061574
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 08:20:32 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id j24so2913863oii.11
        for <linux-block@vger.kernel.org>; Mon, 12 Apr 2021 08:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zvYvEXXxCUUeTw8YVdfgvQuQNC8zksUdPOqPC0z1JlE=;
        b=PVuMW11DI3j88roUp8Yj1a9MNjgcLvPHD3Avye6nGRi5apUo4f2vpLSWUNWeZoxUhL
         2mnw0ewXdVipYxGNfwVRFtB9PY8lnzN4Fy9WCPmBPyJDnEUtlf1B+3g9m5klUIwICkFd
         ei4Ev3NPheiSVR1wSezCQv8okBD+5n4lk0DQDoseIrKkt8/g+vyX42LUM92YjiBz2gal
         GctZF70VDBrlQ6veUUbwW1BdMn5+vce5u33MWdI0MPim6epxwWD0GPeBZKZV4OiECWVE
         7d1+y7I/hhz6kl3/WkGedc1bSUtWcg45JtyGRD/8DeY85+eJJV9cSUodnhD4Bph1enXP
         PZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zvYvEXXxCUUeTw8YVdfgvQuQNC8zksUdPOqPC0z1JlE=;
        b=XzY1aY5uOdGrcGtTYYaUU9zpKmfxFT8qu6t84FdQKavYfvT7k81TzaTLAZ1HI21Di1
         oeqfory4pObV6eGYcWJHexAqX4k79wxbTrOrALVX+GeS5uZVje5+w2RhjjaflGc6cHKz
         VM+71E5FhH2qCRsG3jO6h2k5v3pIYEO7hjsMFN7c7YZaunK4wjfskNO9r8XdepGYZV7E
         TFB/vamfpfUv/GpbS7ZSSMicDfmLwtTFauIG3vJfn89iX/ivGzkpA4k2DY5s2AUuefQU
         8sUFWD+TOZdyc020aqTyU+LHIN9C2b04xkXaJWLiqqgMYDOKuNZVAo6F4IWHPuTw0BwH
         qWPw==
X-Gm-Message-State: AOAM5314byaBjhc1bN6GOiuv8zdS46czkC4mSDdrGMIO/D7j0qxTH4WO
        0XcWxTCeMbDcby7gflpfRJvlipXWnzUkqQ==
X-Google-Smtp-Source: ABdhPJxiQywS4BCzKCVuQxhAZeJIZSGeCMMavsIsPoR/v54244p9bCTznOWnP+8L0upgGc6p+F0eyg==
X-Received: by 2002:a05:6808:bca:: with SMTP id o10mr20113203oik.4.1618240831231;
        Mon, 12 Apr 2021 08:20:31 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.233.147])
        by smtp.gmail.com with ESMTPSA id s84sm2280831oie.39.2021.04.12.08.20.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Apr 2021 08:20:29 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: remove zero_fill_bio_iter
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210412134658.2623190-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <dc2b6236-8543-f93e-2013-dec7aef6c6b2@kernel.dk>
Date:   Mon, 12 Apr 2021 09:20:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210412134658.2623190-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/12/21 7:46 AM, Christoph Hellwig wrote:
> zero_fill_bio_iter is only used to implement zero_fill_bio, so
> remove the indirection.

Applied 1-2, thanks.

-- 
Jens Axboe

