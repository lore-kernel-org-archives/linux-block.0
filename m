Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AD6C433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 17:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiK3R0h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 12:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiK3R0g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 12:26:36 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0D02C12B
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 09:26:35 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id h17so8409178ila.6
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 09:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04jXt74UY1VtpJun8zJvpOrg9ETd91QGiWVG7jWf27c=;
        b=WvC3pO7A3ARpOpPdif1K6HiRZlgxJ/CstMca+FL0z0mtnmuUqcKoo7VHwcnziQbl//
         jS+djIEAMLc6lTGvZY5l0345olBTCWEhjjBf2AwIsCgolZ6/oYAs4nRaDpNER5dVBDPX
         sMq55sqJV6jv7gUnQ9T9wCK5Ot9OmPWvJe6nVfnuDVVJ+yNpvB/rXR2CIqms+BoXDt/b
         cGMgh+Qnr74STBe8oISOcViGmkm95U61eut4IMPTZSmbN6vEEryfhATvELwBBA7mu2HZ
         M7HY7WxOOE05iMNJM1kZSIrGpPhFMAAZ6Ge2hcwHMejCi8rVAVCBXTEKfKbjqBx7pnTT
         MOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04jXt74UY1VtpJun8zJvpOrg9ETd91QGiWVG7jWf27c=;
        b=ABUXGup/jP8drUpSub55XwULirqbmJZplzz+nrzJPBQfyNKDqpI8gJaMqoOpsfRtrE
         rrX5+8wmCoK5VAZZaP2QDL705mclJ1KIONQlaeXsuV37LnkFn9lBhsL+q0ccejXnWUG1
         3yAkd9pspOqIN4/G1LuuPXzX+5+YlOgNLGhVJlQUZv3EV0UavY60lSqLs2UgRmRepkEh
         +ktSTpC3hodpYMNZ0af9kubgTTaS80WYXcEqtxd+DlYjlNW/W9oAT5LuLA738Y5EiiHq
         Lt7wLzm6HIaeaDOwqgOd8pcsCnD49rBYr7uACiaCHDPGG+kfaaiwRc/EGMWWj05Tcr13
         7Avg==
X-Gm-Message-State: ANoB5pmAuecFOw5o7ho0IuVVNupZNX36k5F4lNXojYNUBsvIDPMPfLDJ
        tqlwppxOLnjbEiXyHvNaO8W8Kg==
X-Google-Smtp-Source: AA0mqf4+xJx0hE4uVatQ7H6ZQopio6F/vICz5HPoG9dJxBEnflwG6PUOg4lYyFxT+ASdvPdJ5OKkrg==
X-Received: by 2002:a05:6e02:80d:b0:303:afb:a98d with SMTP id u13-20020a056e02080d00b003030afba98dmr8960568ilm.74.1669829194557;
        Wed, 30 Nov 2022 09:26:34 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a92-20020a029465000000b003633748c95dsm750543jai.163.2022.11.30.09.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 09:26:34 -0800 (PST)
Message-ID: <c8a2fc0f-0bd3-b276-646f-cab97ba5bc34@kernel.dk>
Date:   Wed, 30 Nov 2022 10:26:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH -next v2 0/9] iocost bugfix
Content-Language: en-US
To:     Li Nan <linan122@huawei.com>, tj@kernel.org, josef@toxicpanda.com
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
References: <20221130132156.2836184-1-linan122@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221130132156.2836184-1-linan122@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/22 6:21 AM, Li Nan wrote:
> Li Nan (4):
>   blk-iocost: fix divide by 0 error in calc_lcoefs()
>   blk-iocost: change div64_u64 to DIV64_U64_ROUND_UP in
>     ioc_refresh_params()
>   blk-iocost: fix UAF in ioc_pd_free
>   block: fix null-pointer dereference in ioc_pd_init
> 
> Yu Kuai (5):
>   blk-iocost: cleanup ioc_qos_write() and ioc_cost_model_write()
>   blk-iocost: improve hanlder of match_u64()
>   blk-iocost: don't allow to configure bio based device
>   blk-iocost: read params inside lock in sysfs apis
>   blk-iocost: fix walk_list corruption
> 
>  block/blk-iocost.c | 117 ++++++++++++++++++++++++++++-----------------
>  block/genhd.c      |   2 +-
>  2 files changed, 75 insertions(+), 44 deletions(-)

Please include a changelog when posting later versions of a patchset.

-- 
Jens Axboe


