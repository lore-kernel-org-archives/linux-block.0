Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18679C48BCF
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 15:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E057B61351
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 15:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbhFIPpG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbhFIPoZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 11:44:25 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD87FC06175F
        for <linux-block@vger.kernel.org>; Wed,  9 Jun 2021 08:42:30 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso3802411pjx.1
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 08:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Z+kgbcTthKkRaTLerI5LIt6g96eR6yyPJbyK3XBw3oU=;
        b=h60acMdnntT8zv6JMmqModd/J93zqAuVPxGRVBgALmvY3TyZQfVmb9+Fcr6CUWePjU
         oJbw7fe78PBe8M+JQ+2cLcBiXtOD0dyG7c9hvh0WHJJueT4kybrq4RiEaCvAtqdEL/Vb
         Prj7uhAkqoSE2LLYJJntt3IPg8qQHJ8lBDfIN5vY9MS10iotcj2BuagXHhkTfKhFbhXM
         iT9InmJeOQpgDS+f/pywkFdOkKUKStlh1uFv+DF7qMUWolcLPDyFbec/2Xn8wkoNV5w2
         gAXaUHi9O/O9DW8EprS8om8twyMCX2bu281slztLMGf6PTG8ntiYgEkyP13U78zUkAYa
         BAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z+kgbcTthKkRaTLerI5LIt6g96eR6yyPJbyK3XBw3oU=;
        b=YMONyrM7aKjYgAWcSj4wNcSg2bjHw+dgT9nH+BuBEgyW0uxXjrbv6VZGPOsO1ssHfg
         NDAxHYzXSJpRnE1hZwqDk3hCoMU67J0wR17k9P8rWH87cUhYSMgKHPjJNKt+35zbE22U
         8eLsDzbV8sbeKPAKUJjTFxKWB1+m40bXU1iGr+nqP4pYUwdtk2/teKYdhvbZpdp3N9gg
         DvLZEdEteWskEZ93OBJ2kfuRwjcbBGjzclhZyl6HEFvNPa0t2DmBR497h8UbmvlsNJuF
         bW0XB7A/OlHHhI4y5vg/0thRUaWhPGA4GLVfD2ZJA4fbMsdmHuQay4muCoAfeVTQSJ5E
         1Zfw==
X-Gm-Message-State: AOAM5337x7S4huowFcmPobot5u5cgFwVI/bYgW9XWnZM6jNw8w5IE/TB
        i6n/J08KbK2fD4vminveZz7qPeN/wsdQDg==
X-Google-Smtp-Source: ABdhPJwQ9FRzOk3nVmVPhkujmABcn64QD25jQWXFfZeJB8P/CBSyiQIZWrINGKD7uv2O5zl4kOT2Lg==
X-Received: by 2002:a17:90a:4e4a:: with SMTP id t10mr124420pjl.173.1623253350154;
        Wed, 09 Jun 2021 08:42:30 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id x33sm45811pfh.108.2021.06.09.08.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 08:42:29 -0700 (PDT)
Subject: Re: [PATCH 1/1] drbd: remove unnecessary oom message
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev <drbd-dev@lists.linbit.com>,
        linux-block <linux-block@vger.kernel.org>
References: <20210609121426.13936-1-thunder.leizhen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aefad024-73b0-26b2-f02c-fe534df16bbb@kernel.dk>
Date:   Wed, 9 Jun 2021 09:42:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210609121426.13936-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 6:14 AM, Zhen Lei wrote:
> Fixes scripts/checkpatch.pl warning:
> WARNING: Possible unnecessary 'out of memory' message
> 
> Remove it can help us save a bit of memory.

Applied, thanks.

-- 
Jens Axboe

