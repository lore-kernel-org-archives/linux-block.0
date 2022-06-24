Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA54C433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 16:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiFXQ3b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 12:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiFXQ3a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 12:29:30 -0400
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A6B1903D
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 09:29:29 -0700 (PDT)
Received: by mail-pg1-f181.google.com with SMTP id g186so2898087pgc.1
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 09:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NzMi7W7063oeRk109aH5G+aTiRX9qAGVKiyJUyYUzi0=;
        b=bsTcXVY0WSmPI8S96gINF80pbIcx0pasj/3rUdkeSaLHDxBZotCBXg5q5EsNbsdgLw
         ezg4A9Dd7Urhybh42IZYDz8olcntAH0Vv0zVtSSTRg457onR0p0WWkXMqCkomu7p86x+
         a3PVJ1aLjlucRZmTpiQainvvM5dIQMiBaZ+hsFj/tGsWbqnajEUVNo5qxU1mX3f6/bAY
         ueNW+aLNQvWGQDi8Dy2CgDyK4530USPQd1IQ0hVioY7UCeoqrmYuutqL8f2Hv/LEynzi
         RP2kZlMaqfU/VLiNcoccYNrEfUznN+FcJ6Ek4wa9Zj625TqFmXIFU7fOyWu9kulJCZwz
         sSiQ==
X-Gm-Message-State: AJIora/tG4y7oLh0XRxfligwWAWNHlSuf440bIrM4DSqOokn229Z7bcj
        CFVoF0HkeOSnpCiwjkLPMF99cBHd20E=
X-Google-Smtp-Source: AGRyM1sTi2rd81ZW7pfrEbX+IeKR1BIw+tGe7D31aKS8I57SPNVZjNs2r4biGQFHlWpn15pGnL/bwQ==
X-Received: by 2002:a63:b449:0:b0:40c:f5b5:639f with SMTP id n9-20020a63b449000000b0040cf5b5639fmr12759565pgu.48.1656088169141;
        Fri, 24 Jun 2022 09:29:29 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:85b2:5fa3:f71e:1b43? ([2620:15c:211:201:85b2:5fa3:f71e:1b43])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709027e0700b0016a4f3ca28bsm1992720plm.274.2022.06.24.09.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 09:29:28 -0700 (PDT)
Message-ID: <14fe3446-7201-ed56-e3b0-d0a621275b66@acm.org>
Date:   Fri, 24 Jun 2022 09:29:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/6] block: Introduce a request queue flag for
 pipelining zoned writes
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20220623232603.3751912-1-bvanassche@acm.org>
 <20220623232603.3751912-4-bvanassche@acm.org>
 <3dff0f28-587e-c6f6-474e-718dc999be3a@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <3dff0f28-587e-c6f6-474e-718dc999be3a@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 17:19, Damien Le Moal wrote:
> On 6/24/22 08:26, Bart Van Assche wrote:
>> +static inline bool blk_queue_pipeline_zoned_writes(struct request_queue *q)
>> +{
>> +	return test_bit(QUEUE_FLAG_PIPELINE_ZONED_WRITES, &(q)->queue_flags);
>> +}
>> +
> 
> Since this flag will be set by an LLD to indicate that the LLD can handle
> zoned write commands in order, I would suggest a different name. Something
> like: QUEUE_FLAG_ORDERED_ZONED_WRITES ? And well, if the LLD says it can
> do that for zoned writes, it likely means that it would be the same for
> any command, so the flag could be generalized and named
> QUEUE_FLAG_ORDERED_CMD or something like that.

Zoned writes should always be submitted in order by the software that 
generates the zoned writes so I think the name 
QUEUE_FLAG_ORDERED_ZONED_WRITES would cause confusion. I'm concerned it 
would make other kernel developers wonder whether it is OK for e.g. 
filesystems to submit zoned writes out of order, which is not the case. 
I think the word "pipelining" has a well-established meaning in computer 
science and also that in this context it reflects the intent correctly. 
See also https://en.wikipedia.org/wiki/Pipeline_(computing).

Thanks,

Bart.
