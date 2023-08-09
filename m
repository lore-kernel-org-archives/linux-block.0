Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5084C001E0
	for <linux-block@archiver.kernel.org>; Wed,  9 Aug 2023 22:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjHIWI4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Aug 2023 18:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjHIWI4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Aug 2023 18:08:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C39F10C0
        for <linux-block@vger.kernel.org>; Wed,  9 Aug 2023 15:08:55 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bbb7c3d0f5so700025ad.1
        for <linux-block@vger.kernel.org>; Wed, 09 Aug 2023 15:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691618935; x=1692223735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Uzn7iiANgsupHywDv/72GtXrEumTbsw+OT2gpEL+aY=;
        b=u+xAB0RZaSkonBzG/RsKAgtENUDjoe8v+gh6FUUtjkX4rUCUtSE1DGI9Jh+E9g97zj
         kiwwG3jUIo77AEXd7Ns31ou3pYVgNgAI5Z/db9GdTfh5P9W7mLXLPeR/rEM0Ha15CywJ
         JszZ4+lgusTz5gYvnIu7crL/6Y55j+8cZvC6IuGJ/ixoJvd8QUOftiSc4i4GC0TflxeK
         BXP4saTGYw9p5YE1rupsDXzbeWbFBb0SfFZ1Anx2l3HVAy3uveILp59p3nFX40rvprK1
         cqI6EmlBiF2J2qnThDPghGZdPugiMFWR2IBpsAyj1ZGyG3x/w3x3lOULKF4VPIFOoBas
         VQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691618935; x=1692223735;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Uzn7iiANgsupHywDv/72GtXrEumTbsw+OT2gpEL+aY=;
        b=hJQkuB4SwqfGPYC3YmAcuG8WLKf8eA63b+2nmqhMX0CQCw6SgwqBTAUfWGfss1jeUV
         1dlgDoQ4RO3YAcJQlg4BL/+kMOQXe7/MhsSdxPFSDEA7/0sbYoCW/NAAFrl4joATVWqM
         7v0RcmGFisOwXf3/So2ssuqesSd2Zmkp0e/9xwsxy3vxMU0GnGuPv19aQv1l5l7Y6RZA
         eFCNjnyvNtci3ubeVwAylSsn/FMGwh/hbSqpn7ZmHSf4U+xukTF1StvfPgp+pMwul4p6
         gJL5n6YuXLhJoYLItKdbfqBxlS/68OLDUDvv0m32+J/N353sm/qt1uyn4VDcImZSlJxN
         zHgw==
X-Gm-Message-State: AOJu0Yx+eIZd4At0WhTm8i+YEjCAH8/BouLAoFsZ+GBkFtjacK+HBt5W
        Szj49tltuYFyNNprxH4lNCE7bA==
X-Google-Smtp-Source: AGHT+IGL34d9XlQ2VMdBk6Ss1oOIGVwRxDv2b6ZuBUD8gInXOHPVIp9CxDo1vptLvcsk+e/xwvAQuA==
X-Received: by 2002:a17:902:e744:b0:1b1:9272:55e2 with SMTP id p4-20020a170902e74400b001b1927255e2mr484792plf.3.1691618934738;
        Wed, 09 Aug 2023 15:08:54 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902724b00b001b246dcffb7sm19206pll.300.2023.08.09.15.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 15:08:54 -0700 (PDT)
Message-ID: <94c661a6-442b-4ca2-b9e8-198069d8b635@kernel.dk>
Date:   Wed, 9 Aug 2023 16:08:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blk-crypto: dynamically allocate fallback profile
Content-Language: en-US
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
        Satya Tangirala <satyat@google.com>,
        linux-block@vger.kernel.org, kernel-team@meta.com,
        ebiggers@kernel.org
Cc:     stable@vger.kernel.org
References: <20230809125628.529884-1-sweettea-kernel@dorminy.me>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230809125628.529884-1-sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/9/23 6:56 AM, Sweet Tea Dorminy wrote:
> blk_crypto_profile_init() calls lockdep_register_key(), which warns and
> does not register if the provided memory is a static object.
> blk-crypto-fallback currently has a static blk_crypto_profile and calls
> blk_crypto_profile_init() thereupon, resulting in the warning and
> failure to register.
> 
> Fortunately it is simple enough to use a dynamically allocated profile
> and make lockdep function correctly.
> 
> Fixes: 2fb48d88e77f ("blk-crypto: use dynamic lock class for blk_crypto_profile::lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>

The offending commit went into 6.5, so there should be no need for a
stable tag on this one. But I can edit that while applying, waiting on
Eric to ack it.

-- 
Jens Axboe

