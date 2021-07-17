Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A36C636C9
	for <linux-block@archiver.kernel.org>; Sat, 17 Jul 2021 19:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D97B96115C
	for <linux-block@archiver.kernel.org>; Sat, 17 Jul 2021 19:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhGQTKK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Jul 2021 15:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbhGQTKJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Jul 2021 15:10:09 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB73C061762
        for <linux-block@vger.kernel.org>; Sat, 17 Jul 2021 12:07:12 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h4so13941925pgp.5
        for <linux-block@vger.kernel.org>; Sat, 17 Jul 2021 12:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+jEgXhaGLl1WV0YBpjmwQduY0ocPMs5Y7r0OTUJrdDI=;
        b=E7gcyRNbXHbhoLmDnXSTK/smH8zzolsGQlxb1MH7XeyOQ6l4AepQwF2c5FvzuqLR5W
         Db8Kz6fRMpDz3GflbfhHej8HgaUtiGysHe9vPjc+xUhD0UEH0fzamjOyHMrQbJMLN9U6
         SQ2sxggJk8Av+T5qXQB6IjSuQdYWZWcGUiD2YcvNrWPbTWAZGUaJCEQZoCwddxiDP6fv
         6R3RqGpnsEnyTnvR8RqsEQp6vBVTWWX2WAu53Fr0uJCgu2fvxQ4kpgf9wUdH1tn9TmCY
         ZErpshYQagso9V90GKBMpx/5yJK8WZ5SOhH8qLpnbkQs4ellc3dL+cK95rSh41XT9jtp
         h82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+jEgXhaGLl1WV0YBpjmwQduY0ocPMs5Y7r0OTUJrdDI=;
        b=El89yuAzy00tOITqzQBCVIi92yVAtF3awKUALhsisUkkMJy7EUIx/QrxZQI4B3EWHi
         Cee7n28tLeJ0+TYz4VykMp5CuYsbVBnLBZbTagRbYvSMfeOmCFGJXULHcrjcKS4Xz4d/
         sdQ+ycI/Wg9C0SldQ2Gu3UYzvtc9cEJp4/jrSW/TdCDOz6P6z3zMC2ErQddPOGxjhvYk
         i49TgUxYU6i+iKdL2xod0vUHfJ80dzhVTY46RQFS+h6DgqFgTtBoOAKn6CZ3Obbtymj/
         W2/ub80R3xtpTewKvUzaruqhFYXnm/UsHLInnNYyh5Wy3K4WHqkPVD1MT3iXJsMUCxfb
         2xaA==
X-Gm-Message-State: AOAM532k7O016dnbX3F1+kcHKIhcatFcYBfXR/AWVbqEEftt+aDTKQW6
        0L9yuzDi6msm4EIuicbTwbNyVg==
X-Google-Smtp-Source: ABdhPJwXR1+2PXUCqmhlgSN5E+SwPcEdBtdhYFxJF+jFqOF/x+oWuU0QY4dD4GuBGdnoI9aV5O3Hmw==
X-Received: by 2002:a63:1656:: with SMTP id 22mr16342661pgw.163.1626548832088;
        Sat, 17 Jul 2021 12:07:12 -0700 (PDT)
Received: from [192.168.1.187] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id k5sm14829885pfu.142.2021.07.17.12.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 12:07:11 -0700 (PDT)
Subject: Re: [PATCH] block: increase BLKCG_MAX_POLS
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        David Jeffery <djeffery@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <20210717123328.945810-1-oleksandr@natalenko.name>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <32f6b089-46fa-55ec-ce7c-88da7e224728@kernel.dk>
Date:   Sat, 17 Jul 2021 13:07:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210717123328.945810-1-oleksandr@natalenko.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/17/21 6:33 AM, Oleksandr Natalenko wrote:
> After mq-deadline learnt to deal with cgroups, the BLKCG_MAX_POLS value
> became too small for all the elevators to be registered properly. The
> following issue is seen:
> 
> ```
> calling  bfq_init+0x0/0x8b @ 1
> blkcg_policy_register: BLKCG_MAX_POLS too small
> initcall bfq_init+0x0/0x8b returned -28 after 507 usecs
> ```
> 
> and BFQ is non-functional.
> 
> Increase BLKCG_MAX_POLS to allow space for everyone

LGTM, just needs a:

Fixes: 08a9ad8bf607 ("block/mq-deadline: Add cgroup support")

in there too, I'll add it.

-- 
Jens Axboe

