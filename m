Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D91C77B73
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 23:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjDSXCt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 19:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjDSXCs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 19:02:48 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA3440EE
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 16:02:21 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-63b70ca0a84so491492b3a.2
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 16:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681945289; x=1684537289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCGGik+Dh34m/LHPIISsgDwZwS1lPtqv0VLubLC6Woo=;
        b=braqGM8s0jThG4tpLsIiH1qUqCaPHBkVw6KDMtRez2WlioTEzFcVIDS3ieYactzbCy
         Sm9/adKqdoH3qR1OaTOpXPNIe0/kgotxK9EhvPgZRcoADM1P1TVKr3fz7bClWx/hVI5i
         r2d0pmRMpH8WE4ZDQ7ZOgfWbqXdilhHdOmTCavn7gLLyxAO0E+OU/Q89/Ol2sgUVdo1a
         +5NRfvj2PgtRdCuRZ27+ZYL3svFL3yQJ9Se1q3q73C3F8IWCb8cdp6zBxApEW0XyqJcc
         DgFsYx7cb5T3fV1IZh576IvVCzC8znB6y5ZnalEAJMAJPBUj9vbUqJ/48+esAsCYSozK
         Av5Q==
X-Gm-Message-State: AAQBX9ecjV1m9ICIqbO0ccswVT3ik994NxQCa2LPCutF9wPxKGnTZDKi
        XHAxV9UVqKyzFRphCoQvzG4=
X-Google-Smtp-Source: AKy350YxcBHYwqxWw1UVaWMHNJh7TDAif06+UOMxfXBtraYc4Mrq4WCVnIGDqOEuogTFIrBrYgoanQ==
X-Received: by 2002:a05:6a20:748d:b0:d9:27f7:8c4a with SMTP id p13-20020a056a20748d00b000d927f78c4amr339551pzd.0.1681945289031;
        Wed, 19 Apr 2023 16:01:29 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:216b:53b9:f55c:cf92? ([2620:15c:211:201:216b:53b9:f55c:cf92])
        by smtp.gmail.com with ESMTPSA id q10-20020a63d60a000000b0050bcf117643sm10566740pgg.17.2023.04.19.16.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 16:01:28 -0700 (PDT)
Message-ID: <64b56eb3-bcf5-c48a-df96-bf1956f6992e@acm.org>
Date:   Wed, 19 Apr 2023 16:01:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 09/11] block: mq-deadline: Handle requeued requests
 correctly
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-10-bvanassche@acm.org>
 <20230419050758.GD25898@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230419050758.GD25898@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/18/23 22:07, Christoph Hellwig wrote:
>>   deadline_add_rq_rb(struct dd_per_prio *per_prio, struct request *rq)
>>   {
>>   	struct rb_root *root = deadline_rb_root(per_prio, rq);
>> +	struct request **next_rq __maybe_unused;
>>   
>>   	elv_rb_add(root, rq);
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +	next_rq = &per_prio->next_rq[rq_data_dir(rq)];
>> +	if (*next_rq == NULL || !blk_queue_is_zoned(rq->q))
>> +		return;
>> +	/*
>> +	 * If a request got requeued or requests have been submitted out of
>> +	 * order, make sure that per zone the request with the lowest LBA is
>> +	 * submitted first.
>> +	 */
>> +	if (blk_rq_pos(rq) < blk_rq_pos(*next_rq) &&
>> +	    blk_rq_zone_no(rq) == blk_rq_zone_no(*next_rq))
>> +		*next_rq = rq;
>> +#endif
> 
> Please key move this into a helper only called when blk_queue_is_zoned
> is true.
Hi Christoph,

I'm looking into an alternative, namely to remove the next_rq member 
from struct dd_per_prio and instead to do the following:
* Track the offset (blk_rq_pos()) of the most recently dispatched 
request ("latest_pos").
* Where the next_rq member is read, look up the request that comes after 
latest_pos in the RB-tree. This should require an effort that is similar 
to updating next_rq after having dispatched a request.

With this approach the code quoted above and that is surrounded with 
#ifdef/#endif will disappear.

Bart.
