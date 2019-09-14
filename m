Return-Path: <SRS0=imFw=XJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC488C4CECA
	for <linux-block@archiver.kernel.org>; Sat, 14 Sep 2019 17:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CB82067D
	for <linux-block@archiver.kernel.org>; Sat, 14 Sep 2019 17:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0+bxTToa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfINRcy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Sep 2019 13:32:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34737 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbfINRcx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Sep 2019 13:32:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so16983563pgc.1
        for <linux-block@vger.kernel.org>; Sat, 14 Sep 2019 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=O8OpIv/h9Xoj81JoOw7IpoqYu7lWdSRFtiFxO69rTAM=;
        b=0+bxTToacLejfNCVGMh6jt8FMYCKv1JjLTMESP6mI6B/UH3COowPwnU0ICpZb1ukWk
         4vZ1TxRfpmGAO3GBmiop27eE9B8cU/0shzMBpyQ9ttFvnEYWSxBaQmrB9Y8hbtKpEtDf
         rHaz5HewXCaXyFFyqeh07pZlphnDMay+V3U29gfv4c0cBAeJiZ5ljvaG3TNV9JahHo5F
         ZsSRriNWhgc9CKeOmFcp76uCZ/bWD5IWwi9l04F9m60NnIENgIIkpsquNpOg/2DvF2QU
         +hk2ZOjmgM+p93hqSdqnE11DCP66QlQqoQFpGTaxi9AZvQbE2dmhPwOvV/Z1CuSpzIUN
         Ad8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O8OpIv/h9Xoj81JoOw7IpoqYu7lWdSRFtiFxO69rTAM=;
        b=NALASpRcpgb+FDKF/UyHLSrex15wRZKcbMQMl10bRd9V0LutmbXhL70r3qANC9+PwK
         2VH3IhEbN8pgtF0Jii1Bf2No3v4F53UqYx+KT7lQWVvRF5ohfwIQgYARvOHhcj89IfBy
         ID9/9hG/OPa8+KK/i2GkQV8Jp9/kI+C9NLLgQ/aSmdQByxTrfRfgrI3ZPiU1vZTWwuXd
         DC39eRXoIMqvh68hnllFfr/NuaaxJ7r/BWqlG7kt8Af6wesgTm55Wu3S/GTmbMTLeeKX
         pnet4mI2H7zkXFIRG7NjB8hZyrpIuGzQkXTioOsD8fpdydW0SqPayqSfJzDEt38xFa2C
         oNXA==
X-Gm-Message-State: APjAAAUKbJgX3GTlHwbLwHg46L1/cC2qmDEluew5L3N3dRlDno2K3mTm
        zNWTB04ntOSxaI5nm7DytyQA5A==
X-Google-Smtp-Source: APXvYqxVH9CGSAYvtAb4IJznoBr8AbX407SzOpfcLVfY73UfY/mHxNKqtD1kh2XkGfONmU5PawRyaA==
X-Received: by 2002:a17:90a:a403:: with SMTP id y3mr11363720pjp.118.1568482371871;
        Sat, 14 Sep 2019 10:32:51 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:ac0e:af6d:e28f:9b10? ([2605:e000:100e:83a1:ac0e:af6d:e28f:9b10])
        by smtp.gmail.com with ESMTPSA id r12sm35993995pgb.73.2019.09.14.10.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Sep 2019 10:32:50 -0700 (PDT)
Subject: Re: [PATCH] bfq: Fix bfq linkage error
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9afc7a2cd013344290096d9dfe9355bcb57b3bbd.1568482098.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <333de59c-d4ca-3bc2-fffa-35d60bd14126@kernel.dk>
Date:   Sat, 14 Sep 2019 11:32:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9afc7a2cd013344290096d9dfe9355bcb57b3bbd.1568482098.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/14/19 11:31 AM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> Since commit 795fe54c2a828099e ("bfq: Add per-device weight"), bfq uses
> blkg_conf_prep() and blkg_conf_finish(), which are not exported. So, it
> causes linkage error if bfq compiled as a module.

Thanks, I'll apply and add the Fixes tag.

-- 
Jens Axboe

