Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DAEEB64D8
	for <linux-block@archiver.kernel.org>; Tue, 20 Jun 2023 10:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjFTKDL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Jun 2023 06:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjFTKCh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Jun 2023 06:02:37 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9639E170D
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 03:01:30 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3f99aa36d18so5660545e9.1
        for <linux-block@vger.kernel.org>; Tue, 20 Jun 2023 03:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687255289; x=1689847289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yCDS4aJu5R+WDDnO8dMRPmrAcYwY3DQAbMpWRhnvmME=;
        b=Uv5uYPQNOwTbL4NYFzgOENG+GtXG58Gr8zyFkXt9SIlo4ZSU1H56R875ypTTi0Tk37
         l1lZT/Bs/w8I8wDitUk7hB9SYu9xVPqYCpIcP6mM7VyUNEY9H6PCUkAAJHlu18B4yven
         xfEgNCH3N4o2rFtm4nm7rkc9WmuAwhz9C3qxPRVKOmUDVccjgB4OfBcPrt4y32XpZHIC
         fcPa82hBNB4T6cO3ktl78RPIKVWUOIAl4f0mDKbPR8EBtxVTvp6apioq7ImoEY6v7/u8
         LKkwkPl9GytZzyHBEIzeZTC0Sn6fa/4RAHg2RL+Iq+OAF69U2BBCAAPcmUWNHUAy/r6B
         RyMA==
X-Gm-Message-State: AC+VfDy85pPkiGbYJlF0c6i4I817ObF+QmAKwcpbHtWT6VR5UbDZeqJT
        YC9WRCCVROqtzXJMuyEpO7MviZrH+NI=
X-Google-Smtp-Source: ACHHUZ55gLulHOB1ptW2A/aNbYvJALXz2obyFE+D30kJH7lwmsApJSoYxRyG5/tLoL4o70WY3rsI5Q==
X-Received: by 2002:a05:600c:6349:b0:3f9:b3f9:fac4 with SMTP id du9-20020a05600c634900b003f9b3f9fac4mr3135429wmb.1.1687255288940;
        Tue, 20 Jun 2023 03:01:28 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u23-20020a05600c00d700b003f78fd2cf5esm1900672wmm.40.2023.06.20.03.01.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 03:01:28 -0700 (PDT)
Message-ID: <b4b47027-119c-bde1-f91a-4fd0cec9edcc@grimberg.me>
Date:   Tue, 20 Jun 2023 13:01:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] blk-mq: add API of blk_mq_unfreeze_queue_force
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        linux-block@vger.kernel.org, Chunguang Xu <brookxu.cn@gmail.com>
References: <20230615143236.297456-1-ming.lei@redhat.com>
 <20230615143236.297456-2-ming.lei@redhat.com>
 <ZIsrSyEqWMw8/ikq@kbusch-mbp.dhcp.thefacebook.com>
 <ZIsxt7Q2nmiLNTX2@ovpn-8-16.pek2.redhat.com> <20230616054800.GA28499@lst.de>
 <ZIwNRu1zodp61PEO@ovpn-8-18.pek2.redhat.com> <20230620054141.GA12626@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230620054141.GA12626@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> GD_DEAD is only set if the device is really dead, then all pending IO
>>>> will be failed.
>>>
>>> del_gendisk also sets GD_DEAD early on.
>>
>> No.
>>
>> The hang happens in fsync_bdev() of del_gendisk(), and there are IOs pending on
>> bio_queue_enter().
> 
> IFF we know we can't do I/O by the time del_gendisk is called, we
> need to call mark_disk_dead first and not paper over the problem.
> 
> An API that force unfreezes is just broken and will leaves us with
> freezecount mismatches.

I absolutely agree here.
