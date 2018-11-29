Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24468C04EB9
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 22:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE1A21473
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 22:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="iUfhHRug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE1A21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbeK3J3G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:29:06 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:37608 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbeK3J3F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 04:29:05 -0500
Received: by mail-it1-f193.google.com with SMTP id b5so6326169iti.2
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 14:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lOQ81fIfCBJZfAiNrSQUjANHqWXoicujO0d0updRgDI=;
        b=iUfhHRugSYRlnM3/+5JHVRB5SNBoz277p9xtxqU8bkq4ED4FYplVJzq2mxWA6/Jeff
         oTaGwnVV1qdMrAZKWl9BhewtHxicev2ZXDf6JE9l+9sCpI4JAqlDR5P7xzM+7j+OlYSP
         EcJ+iCwRe4AcH0WS4aGYrjaqWeGDoyA/bgU0wa/QmjPVKJEP0HbS87c2fY7YDbTzUac1
         uQ0pZ7QXcPTOuBMnXG/sFmDZeVMLRSDxyGlEXJjE5qe4FedkIAvFxjDh2h1swuB9AtuV
         BXx2lx5bpFH6JsPQyl7PvTXupePID961swLZt7bwpbq1UdV2DUsHB+kyL5IiTQmf/R/+
         mlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lOQ81fIfCBJZfAiNrSQUjANHqWXoicujO0d0updRgDI=;
        b=JuprOOUdVsjlrr4L8vEWR22EvzlO5rlx6m+YewYjojV2dfaOqGmmjFgQtRhiTOW0x6
         Nl1m+swHR/zUAclt2MUV8fYHLHPoOaYFDOlI0HLNKFYpdradReXaBWOCKa94EIvhQITr
         9EBBHo5eKvytntNlHiM1nEajKGDJw9JYcU73EhaFtH5gTWv25IxaHR2y/f0uJm08uAqN
         qfRCQQN3MOCQCUMtxL8XKbgdlTRvbjSQwyGUn5bf7JUkKpvHyxPlUgjg7uxPAMXmGaQY
         tJcdvMDH0PMav7Fmw3IfvYDgx/yv617DiV0mbfGQA4JwjItxt8znoC4u8Hk2j/4aUJwI
         G0wg==
X-Gm-Message-State: AA+aEWaXgX3CmOTgVEPZKTXgfwPWesisl3RTEvyeCjjrjrEPCgcnu4MI
        Br2HwV4HhOEDhBzUBtyWJ2qAtA==
X-Google-Smtp-Source: AFSGD/UtoF2vCuYKHUK+8bC/x0CYrHwOIHrW9AyDJx/Id4GVfM3EulJo1ZafMQM5PrJeNVzinpY4oA==
X-Received: by 2002:a24:b951:: with SMTP id k17mr2939152iti.147.1543530124956;
        Thu, 29 Nov 2018 14:22:04 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 134sm2158389itl.25.2018.11.29.14.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 14:22:04 -0800 (PST)
Subject: Re: [PATCH 2/3] block: switch to per-cpu in-flight counters
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        "Alasdair G. Kergon" <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20181128004250.325095242@debian.vm>
 <20181129215746.GA9226@redhat.com>
 <alpine.LRH.2.02.1811291701430.9428@file01.intranet.prod.int.rdu2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1ef58c51-eb76-d542-e752-d4cbc8903a8c@kernel.dk>
Date:   Thu, 29 Nov 2018 15:22:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1811291701430.9428@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/18 3:05 PM, Mikulas Patocka wrote:
> 
> 
> On Thu, 29 Nov 2018, Mike Snitzer wrote:
> 
>> On Tue, Nov 27 2018 at  7:42pm -0500,
>> Mikulas Patocka <mpatocka@redhat.com> wrote:
>>
>>> Now when part_round_stats is gone, we can switch to per-cpu in-flight
>>> counters.
>>>
>>> We use the local-atomic type local_t, so that if part_inc_in_flight or
>>> part_dec_in_flight is reentrantly called from an interrupt, the value will
>>> be correct.
>>>
>>> The other counters could be corrupted due to reentrant interrupt, but the
>>> corruption only results in slight counter skew - the in_flight counter
>>> must be exact, so it needs local_t.
>>>
>>> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
>>>
>>> ---
>>>  block/bio.c           |    4 ++--
>>>  block/blk-core.c      |    4 ++--
>>>  block/blk-merge.c     |    2 +-
>>>  block/genhd.c         |   47 +++++++++++++++++++++++++++++++++++------------
>>>  drivers/md/dm.c       |    4 +---
>>>  include/linux/genhd.h |    7 ++++---
>>>  6 files changed, 45 insertions(+), 23 deletions(-)
>>>
>> ...
>>> Index: linux-block/drivers/md/dm.c
>>> ===================================================================
>>> --- linux-block.orig/drivers/md/dm.c	2018-11-28 00:09:59.000000000 +0100
>>> +++ linux-block/drivers/md/dm.c	2018-11-28 00:09:59.000000000 +0100
>>> @@ -663,8 +663,7 @@ static void start_io_acct(struct dm_io *
>>>  	generic_start_io_acct(md->queue, bio_op(bio), bio_sectors(bio),
>>>  			      &dm_disk(md)->part0);
>>>  
>>> -	atomic_set(&dm_disk(md)->part0.in_flight[rw],
>>> -		   atomic_inc_return(&md->pending[rw]));
>>> +	atomic_inc(&md->pending[rw]);
>>>  
>>>  	if (unlikely(dm_stats_used(&md->stats)))
>>>  		dm_stats_account_io(&md->stats, bio_data_dir(bio),
>>> @@ -693,7 +692,6 @@ static void end_io_acct(struct dm_io *io
>>>  	 * a flush.
>>>  	 */
>>>  	pending = atomic_dec_return(&md->pending[rw]);
>>> -	atomic_set(&dm_disk(md)->part0.in_flight[rw], pending);
>>>  	pending += atomic_read(&md->pending[rw^0x1]);
>>>  
>>>  	/* nudge anyone waiting on suspend queue */
>>>
>>
>>
>> These dm.c hunks conflict with changes from you that I already staged in
>> dm-4.21, see:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.21&id=b5616f7a11592cc74860f4ec3e3c4fba6688eefa
>> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.21&id=78f95b53c203c969bbe6b86e405f7a891a43b6be
>>
>> I'd really like to get away from DM maintaining its own ->pending
>> counters.
>>
>> Mike
> 
> I know.
> 
> It depends on whether Jens takes these patches or not. If he doesn't take 
> them, dm will use percpu counters on its own and it will return zero in 
> the "/sys/block/dm-*/inflight" file.

This reply is the first I've seen of them?!

Oh, they are in gmail spam. This happened with your last patches as well,
you might want to look into that. I'll take a look at them later today.

-- 
Jens Axboe

