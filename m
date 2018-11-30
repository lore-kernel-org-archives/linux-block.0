Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3712C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746C32145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HC28D3DA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746C32145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbeLAJDB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:03:01 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45335 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeLAJDA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 04:03:00 -0500
Received: by mail-io1-f65.google.com with SMTP id w7so5726911iom.12
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 13:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FtOMzODKytkybXNn/2HfK/SlINDNWQeMvzZauLkYd5s=;
        b=HC28D3DABJgq/PU9nUu32y1rOkyvIzuwviYGsHxofjkdrP8S/s1cdPFf+tVcTzC4ZB
         E1KmmQmj90HJZEm21RHzuR1afi8aBmWEZUETJQFcDb8QosGNvDmkL1P5M3oen5gexi2M
         n2lY8Zy7oe9EAyZJAaVCtUSff65ix7v0Sr2OsbYf4ExWlV0VdDC1p8Qnn0g333MfkVIQ
         uwq7+x/3iK0wndXNL80SIjXuco0dNI1JIvq+T7mMI8Uqh0JJfRDFMhaw+aGQwYEPu7wG
         UMaiKhwWqs64hdN31ygbeWKdfvYkRjj58070nlh7rJ2uc7UjBmbTsXOVuGDiewJjnfl6
         3FLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FtOMzODKytkybXNn/2HfK/SlINDNWQeMvzZauLkYd5s=;
        b=VgBGbYS6GY3Gid3R9SmUWpam27V+NY1DuADa1L2nK3Sbp8x/PiM5G/2dDixmXrVSub
         g5VDkZEUL2mLSE2TMB/+QCx+NamPse0zjMxES9ki8DGHf/e+mYKUIy2m0hD8pzSUMw98
         PT2wNt8MPJ+vYdFfrPRRQmvHDNg23ZYJOWjVLr7tWbHgpvuHmFg6XjhwoXn6iNZ94/T4
         9BPu7iLjA25fFPb1dYTiAjnnXTlFz+76sLm54mDiVm++w4JxrzqMCFbSeElW61ssxICq
         EJ1bN5SrkA4HVslO4dTrPm0GCvzfzmzRQWpJusu76/3rowV91dGEU4d28Tjj1GCGlduw
         oCkA==
X-Gm-Message-State: AA+aEWZDbJ79fBkMTqgBQhdo31nECsi+6f+dSeboQzNjyxym3c7WPV3T
        mZ8Asv5dBEVukB2eMjRTUDIUqg==
X-Google-Smtp-Source: AFSGD/V5CJHeO49PJwg6cxA+/oniOrfvInZYJ3aLJhTb3o8d4w+u6Byl3JC7Hkfjmv1bhIbte2I/+g==
X-Received: by 2002:a5e:da09:: with SMTP id x9mr6590461ioj.241.1543614738491;
        Fri, 30 Nov 2018 13:52:18 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w13sm206616itb.10.2018.11.30.13.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 13:52:17 -0800 (PST)
Subject: Re: [PATCH 2/3] block: switch to per-cpu in-flight counters
To:     Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        "Alasdair G. Kergon" <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20181128004250.325095242@debian.vm>
 <20181130214433.GA15049@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2a7c33ef-0bd0-d901-6a11-cffca1751b9e@kernel.dk>
Date:   Fri, 30 Nov 2018 14:52:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130214433.GA15049@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 2:44 PM, Mike Snitzer wrote:
> On Tue, Nov 27 2018 at  7:42pm -0500,
> Mikulas Patocka <mpatocka@redhat.com> wrote:
> 
>> Now when part_round_stats is gone, we can switch to per-cpu in-flight
>> counters.
>>
>> We use the local-atomic type local_t, so that if part_inc_in_flight or
>> part_dec_in_flight is reentrantly called from an interrupt, the value will
>> be correct.
>>
>> The other counters could be corrupted due to reentrant interrupt, but the
>> corruption only results in slight counter skew - the in_flight counter
>> must be exact, so it needs local_t.
>>
>> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>>
>> ---
>>  block/bio.c           |    4 ++--
>>  block/blk-core.c      |    4 ++--
>>  block/blk-merge.c     |    2 +-
>>  block/genhd.c         |   47 +++++++++++++++++++++++++++++++++++------------
>>  drivers/md/dm.c       |    4 +---
>>  include/linux/genhd.h |    7 ++++---
>>  6 files changed, 45 insertions(+), 23 deletions(-)
>>
>> Index: linux-block/block/genhd.c
>> ===================================================================
>> --- linux-block.orig/block/genhd.c	2018-11-28 00:09:59.000000000 +0100
>> +++ linux-block/block/genhd.c	2018-11-28 00:09:59.000000000 +0100
>> @@ -45,53 +45,76 @@ static void disk_add_events(struct gendi
>>  static void disk_del_events(struct gendisk *disk);
>>  static void disk_release_events(struct gendisk *disk);
>>  
>> -void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
>> +void part_inc_in_flight(struct request_queue *q, int cpu, struct hd_struct *part, int rw)
>>  {
>>  	if (queue_is_mq(q))
>>  		return;
>>  
>> -	atomic_inc(&part->in_flight[rw]);
>> +	local_inc(per_cpu_ptr(part->dkstats, cpu)->in_flight);
>>  	if (part->partno)
>> -		atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
>> +		local_inc(per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_flight);
>>  }
>>  
>> -void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
>> +void part_dec_in_flight(struct request_queue *q, int cpu, struct hd_struct *part, int rw)
>>  {
>>  	if (queue_is_mq(q))
>>  		return;
>>  
>> -	atomic_dec(&part->in_flight[rw]);
>> +	local_dec(per_cpu_ptr(part->dkstats, cpu)->in_flight);
>>  	if (part->partno)
>> -		atomic_dec(&part_to_disk(part)->part0.in_flight[rw]);
>> +		local_dec(per_cpu_ptr(part_to_disk(part)->part0.dkstats, cpu)->in_flight);
>>  }
> 
> 
> The above is wrong, needs this incremental fix:

Should also be using this_cpu_inc/dec instead.

-- 
Jens Axboe

