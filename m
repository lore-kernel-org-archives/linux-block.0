Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561CDC433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 02:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKBCZf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 22:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiKBCZd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 22:25:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23C06577
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 19:25:29 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k5so7368596pjo.5
        for <linux-block@vger.kernel.org>; Tue, 01 Nov 2022 19:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NVMLoWhBO3smWYjRe8JlG4e5abrqqdBoJZY3LBsOWok=;
        b=kG99P25HjBgpLUF5bSCezusrFavecyfkWN1KtJIfVpYe9wEQpJIPP6v/vbx50FkYmF
         dZ2LXiC7+jEJR692C7ZVwuFNVlhpZntx9rNaniONrXYVz0t3wRg6mN+LdNEYxyYoQWUI
         aeU5OzPhITdHStP/h/G1t6HmHzJ6miul3TYIQWZyN0kTxqEfBVdY4gK4dsUE9xnHnkQW
         13E06uBz1NtOuL1YNOVp1XvI1lZ9VOT661qtzgPkU1C9LwkdHiGttukdtiA5dxpPw+9j
         raLt9Nxp2MJB3ek5TtDlIv4PHped/KXzHQBQXLxzeBzlU8vo1xv1q91/jrAtza/B1iAX
         o1+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVMLoWhBO3smWYjRe8JlG4e5abrqqdBoJZY3LBsOWok=;
        b=cmVROzWg1FuuqwdAeQ6e/oKIY1b2uP/ifKj/2OLPtCRcLiAhPMegK2cNc1Xk6hpERi
         702TEq+TUn7mLxTbX5J9D/k942iH6w1hpu95FSbKAIpOrfY/EO5XFEhaWry7cq+yMGq4
         ESBENbmOOqkH/l5tyNYTOlG+PvaHtGykxx3zjD/tXdhDZR1qTFNnVkq/URFCW6fsx18n
         7Qd2YCUkVYtJfN5mPRwkFS+qDSCJWTEmacndhDSq0DAmc4jQET/pK5FBebVZ8vgR4O/5
         vRU8WO+G3DJPtYXjdaF8jjYyMQkoxIBNKXnSwuBm2ZKt9TO9ow9CIih2cNFqM6Vt7qwb
         fa1w==
X-Gm-Message-State: ACrzQf1W8xPNy8IlprJC0uaOzdV86X9bIf5bYlwdYQuXe2yAEfAsLZfv
        TMSFqbiRWoGfX6fC6NNaqjWdXd3Krhp9jQhe
X-Google-Smtp-Source: AMsMyM43thENVfIBk2batYPleifjpAa4i8DNg6r23LeH0bKunT6q58WuTqC68bwwJf0yQZ9XWAuVcw==
X-Received: by 2002:a17:903:110f:b0:178:a07e:e643 with SMTP id n15-20020a170903110f00b00178a07ee643mr21757437plh.41.1667355929362;
        Tue, 01 Nov 2022 19:25:29 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g18-20020a170902869200b0017f592a7eccsm1189675plo.298.2022.11.01.19.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 19:25:28 -0700 (PDT)
Message-ID: <79c5d83f-27b2-dbe0-826b-bcb671e0766f@kernel.dk>
Date:   Tue, 1 Nov 2022 20:25:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 4/4] blk-mq: improve readability of blk_mq_alloc_request()
Content-Language: en-US
To:     Jinlong Chen <nickyc975@zju.edu.cn>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1667314759.git.nickyc975@zju.edu.cn>
 <81fcbc046c9ea96cdfd8e20d1edc8e64c4d08153.1667314759.git.nickyc975@zju.edu.cn>
 <20221101173727.GC20690@lst.de>
 <3caa5abc.16387a.1843622d8cf.Coremail.nickyc975@zju.edu.cn>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <3caa5abc.16387a.1843622d8cf.Coremail.nickyc975@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/1/22 8:19 PM, Jinlong Chen wrote:
>> On Tue, Nov 01, 2022 at 11:11:37PM +0800, Jinlong Chen wrote:
>>> Add a helper blk_mq_alloc_request_nocache() to alloc request without
>>> cache. This makes blk_mq_alloc_request() more readable.
>>>
>>> Signed-off-by: Jinlong Chen <nickyc975@zju.edu.cn>
>>> ---
>>>  block/blk-mq.c | 47 +++++++++++++++++++++++++++++------------------
>>>  1 file changed, 29 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 87a6348a0d0a..2fae111a42c8 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -572,36 +572,47 @@ static struct request *blk_mq_alloc_cached_request(struct request_queue *q,
>>>  	return rq;
>>>  }
>>>  
>>> +static struct request *blk_mq_alloc_request_nocache(struct request_queue *q,
>>> +		blk_opf_t opf, blk_mq_req_flags_t flags)
>>
>> The name is a bit odd, but I can't think off a better one.
>>
>>> +	struct blk_mq_alloc_data data = {
>>>  			.q		= q,
>>>  			.flags		= flags,
>>>  			.cmd_flags	= opf,
>>>  			.nr_tags	= 1,
>>>  		};
>>
>> And this now has superflous indenation.  Overall, while the separate
>> helper looks marginally nicer, I'm not really sure it is worth the
>> churn.
> 
> I'll drop the patch if you think it is not worth the churn. But I
> started doing this because of the following goto statement:

Please just drop it, I don't think it's an improvement.

-- 
Jens Axboe


