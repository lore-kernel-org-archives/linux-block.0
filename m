Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88904C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBD520989
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Qz1Rr2vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FBD520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbeK1KtE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:49:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33617 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeK1KtE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 05:49:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so8605624pgu.0
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 15:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CsIIpjzplVIPuCvUsLsbtGis2zt2v/IKntkvVbPyQUA=;
        b=Qz1Rr2vvTbQ9dlIFm8YGq1FGAi4piU8ozLDfnC0qg2kZ4x2KmC0HRG9RPbuzVGTUpx
         U4eY5NiUC5ol0bDACp24i6xax1mn3vkXm8p8TqdXWCT6Qh/rcuHpzzjcag2XXVDoCRho
         RoCsER/jHsaxfBWd4mCYOfb1Ey1s4rkH8LmBF9eHedxShNgeru+Hb98Wgviv0DS/K52O
         MYOHnjhYB2goU521dpeJH1WbCkdhEXh1m54JPrSSN4+JIp6J5PYIYeJRIe5Xf1VjQNnY
         Qr2POxw9wokuQyT7SfkTAg7ryRSV3M7eosdYj28o5gKfIkEYm+tIWTBvA6+3D/uR+6cu
         mVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CsIIpjzplVIPuCvUsLsbtGis2zt2v/IKntkvVbPyQUA=;
        b=eAUoAdpDULjNT81cPaxHtyf5q4CbfdJrKcYHDNIfZRJ+ifWKzTwO50QwNbZ9jXzX3r
         X1pmkG47uSeWaijNJQPlPQ0BzAnaLTnEwo+zbHx6xhOpUhOIS2OTpKgZ6WbfNZENwZHo
         yKFFeUGHTteTki61qYLYLcJBLOg3z7qqoxkJGl47kF6BfrUq9VQTcI8j3M3zzLmnCwu9
         Y8sjABOveVq7zjZpeOvnZLXoXRLvEVOsWLWa1PCGA2n0GmZ3Jg79Rq9fv5RGCiHHUWEa
         sUCF/rwvPw+MBVQ3Jn4mtSo872Vgr9DOp7gGcTPfCNaH8Dlq1dyhcFzwoeX+aSPVxVjZ
         HINg==
X-Gm-Message-State: AA+aEWbrSqhRw9S1Npr0vIQVfl4Idi8gHn0hPX6qls3QVlrOmSgjcQJv
        FYgZoarpChxJwuG3ojkNG8URlg4h9tU=
X-Google-Smtp-Source: AFSGD/W7SIbOM4K0rmlRd/hO6MK+456KkP/YWJWGYS+W9WJsbPhU5G3nrreARm/Ur3UMhkXSeZXZAQ==
X-Received: by 2002:a63:85c6:: with SMTP id u189mr25490462pgd.156.1543362570208;
        Tue, 27 Nov 2018 15:49:30 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id n22sm10251375pfh.166.2018.11.27.15.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 15:49:29 -0800 (PST)
Subject: Re: [PATCH 2/8] block: improve logic around when to sort a plug list
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-3-axboe@kernel.dk> <20181127233142.GB846@vader>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b6cfc7c8-39f4-252b-8c27-3a75f561061a@kernel.dk>
Date:   Tue, 27 Nov 2018 16:49:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127233142.GB846@vader>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/27/18 4:31 PM, Omar Sandoval wrote:
> On Mon, Nov 26, 2018 at 09:35:50AM -0700, Jens Axboe wrote:
>> Do it for the nr_hw_queues == 1 case, but only do it for the multi queue
>> case if we have requests for multiple devices in the plug.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  block/blk-core.c       | 1 +
>>  block/blk-mq.c         | 7 +++++--
>>  include/linux/blkdev.h | 1 +
>>  3 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-core.c b/block/blk-core.c
>> index be9233400314..c9758d185357 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -1780,6 +1780,7 @@ void blk_start_plug(struct blk_plug *plug)
>>  	INIT_LIST_HEAD(&plug->mq_list);
>>  	INIT_LIST_HEAD(&plug->cb_list);
>>  	plug->rq_count = 0;
>> +	plug->do_sort = false;
>>  
>>  	/*
>>  	 * Store ordering should not be needed here, since a potential
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 99c66823d52f..6a249bf6ed00 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1678,7 +1678,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>>  	list_splice_init(&plug->mq_list, &list);
>>  	plug->rq_count = 0;
>>  
>> -	list_sort(NULL, &list, plug_rq_cmp);
>> +	if (plug->do_sort)
>> +		list_sort(NULL, &list, plug_rq_cmp);
>>  
>>  	this_q = NULL;
>>  	this_hctx = NULL;
>> @@ -1935,6 +1936,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>>  
>>  		list_add_tail(&rq->queuelist, &plug->mq_list);
>>  		plug->rq_count++;
>> +		plug->do_sort = true;
>>  	} else if (plug && !blk_queue_nomerges(q)) {
>>  		blk_mq_bio_to_request(rq, bio);
>>  
>> @@ -1958,7 +1960,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>>  			data.hctx = same_queue_rq->mq_hctx;
>>  			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
>>  					&cookie);
>> -		}
>> +		} else if (plug->rq_count > 1)
>> +			plug->do_sort = true;
> 
> If plug->rq_count == 2, there's no benefit to sorting, either. The
> nr_hw_queues == 1 case could also avoid sorting in that case. So maybe
> this whole patch could just be replaced with:

Heh yes, good point, it should be 3 at least. But if you look at the
later mq plug patch, we only sort for that one if we have multiple
queues. So the logic should be something ala:

if (plug->rq_count > 2 && plug->has_multiple_queues)

since that's the only case we want to sort for.

-- 
Jens Axboe

