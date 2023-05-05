Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9651CC77B7F
	for <linux-block@archiver.kernel.org>; Fri,  5 May 2023 13:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjEENf7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 May 2023 09:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjEENf6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2023 09:35:58 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D9622694
        for <linux-block@vger.kernel.org>; Fri,  5 May 2023 06:35:27 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-63b5465fc13so1398579b3a.3
        for <linux-block@vger.kernel.org>; Fri, 05 May 2023 06:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683293727; x=1685885727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3RvOc3E8ZFO1x/9akr2bpEbHeCFqf25nGHeEQGUAU0=;
        b=C0II2oek0zykI2dzG8RkjOqVTRnziAg3YOlg88doaFXBlEhJiIQLAg034eFtxiz6vS
         g4J8GzDJnyaqmfq8f7Z0i//CSTfgoxZmlub414QeBnfVUF727nol+9PHR2yR/xbSMxlC
         o6lH+wAATQI69r76wyrPRw2nujuAx8X1wObPJk0sgB3Vz/JHn+/j7XfVEKvs6waccDv/
         CdMFmqpzeiZ/fuPIhmQYLumv7uRuc7NYm7B7r0Pqre1WB3dgAeBFdvOU/ayOFBBfZ+tn
         VfmjJuCKHmz5I3ZOVgB6eu0R670bvCMWjW2HF8jSwPMJdkvUVsLONN0m2u73Yc+tOvpQ
         7C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683293727; x=1685885727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g3RvOc3E8ZFO1x/9akr2bpEbHeCFqf25nGHeEQGUAU0=;
        b=RXIQ8hCOff8vQDYUsen3e1r4X4Mr9yNTFFvX1MbOPKefvlUP82yLBmlZH2WDjTzkcF
         qACwSu6o6llgSXkx2PQus4kiLFITQ2tg2l+wy5xfSN6yVO2nAUJ8PYTIQPJjeKLhTeFs
         3EvFfzq7YsRQJGEgw7Z3774gMBQXEWs5cZqePRycbS+Ocxjf1TwTvQMzgobwK026CMLq
         hInFv2fncQyjSA13neCe/p2smDAnZkSdGdxcGJF5BHslnc620ZwIfhbJQYhD2UK9ugOu
         NGTKDkcykzxboHSx5hotUqNB5S7Z9ACCBw4i6PCFNvRg8EDGEsP/4vyehs8ABSSV0rmW
         b+zA==
X-Gm-Message-State: AC+VfDySdb16e6WSiSdYUJRS0M3L1OP/45Iw6dxuUu9bY/0YZKh3bDCt
        16w2Ghu+5lewuC0zNFWvmRgT7YxyfAP+A4RiOC7fzQ==
X-Google-Smtp-Source: ACHHUZ7gQMBNAALjAbEgOqi206u0+0pNQfoKvfAbpiw5YTqHAEfnb7ItjMX7kIvFewN7aqFaOrs/fQ==
X-Received: by 2002:a05:6a00:1ad0:b0:63b:5f78:d6db with SMTP id f16-20020a056a001ad000b0063b5f78d6dbmr2357743pfv.21.1683293727288;
        Fri, 05 May 2023 06:35:27 -0700 (PDT)
Received: from [10.254.14.195] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b0062d859a33d1sm1650787pfm.84.2023.05.05.06.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 06:35:26 -0700 (PDT)
Message-ID: <6696100e-e838-d96a-2894-bbca9783d2a3@bytedance.com>
Date:   Fri, 5 May 2023 21:35:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [External] Re: [PATCH v2] blk-throttle: Fix io statistics for
 cgroup v1
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230401094708.77631-1-hanjinke.666@bytedance.com>
 <ZEwY5Oo+5inO9UFf@righiandr-XPS-13-7390>
 <eb2eeb6b-07da-4e98-142c-da1e7ea35c2b@bytedance.com>
 <ZFQf3TCs7DqsSR8l@righiandr-XPS-13-7390>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <ZFQf3TCs7DqsSR8l@righiandr-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



在 2023/5/5 上午5:13, Andrea Righi 写道:
> On Thu, May 04, 2023 at 11:08:53PM +0800, hanjinke wrote:
>> Hi
>>
>> Sorry for delay（Chinese Labor Day holiday).
> 
> No problem, it was also Labor Day in Italy. :)
> 
>>
>> 在 2023/4/29 上午3:05, Andrea Righi 写道:
>>> On Sat, Apr 01, 2023 at 05:47:08PM +0800, Jinke Han wrote:
>>>> From: Jinke Han <hanjinke.666@bytedance.com>
>>>>
>>>> After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
>>>> blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
>>>> the only stable io stats interface of cgroup v1, and these statistics
>>>> are done in the blk-throttle code. But the current code only counts the
>>>> bios that are actually throttled. When the user does not add the throttle
>>>> limit, the io stats for cgroup v1 has nothing. I fix it according to the
>>>> statistical method of v2, and made it count all ios accurately.
>>>>
>>>> Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")
>>>> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
>>>
>>> Thanks for fixing this!
>>>
>>> The code looks correct to me, but this seems to report io statistics
>>> only if at least one throttling limit is defined. IIRC with cgroup v1 it
>>> was possible to see the io statistics inside a cgroup also with no
>>> throttling limits configured.
>>>
>>> Basically to restore the old behavior we would need to drop the
>>> cgroup_subsys_on_dfl() check, something like the following (on top of
>>> your patch).
>>>
>>> But I'm not sure if we're breaking other behaviors in this way...
>>> opinions?
>>>
>>>    block/blk-cgroup.c   |  3 ---
>>>    block/blk-throttle.h | 12 +++++-------
>>>    2 files changed, 5 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>>> index 79138bfc6001..43af86db7cf3 100644
>>> --- a/block/blk-cgroup.c
>>> +++ b/block/blk-cgroup.c
>>> @@ -2045,9 +2045,6 @@ void blk_cgroup_bio_start(struct bio *bio)
>>>    	struct blkg_iostat_set *bis;
>>>    	unsigned long flags;
>>> -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
>>> -		return;
>>> -
>>>    	/* Root-level stats are sourced from system-wide IO stats */
>>>    	if (!cgroup_parent(blkcg->css.cgroup))
>>>    		return;
>>> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
>>> index d1ccbfe9f797..bcb40ee2eeba 100644
>>> --- a/block/blk-throttle.h
>>> +++ b/block/blk-throttle.h
>>> @@ -185,14 +185,12 @@ static inline bool blk_should_throtl(struct bio *bio)
>>>    	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
>>>    	int rw = bio_data_dir(bio);
>>> -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
>>> -		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
>>> -			bio_set_flag(bio, BIO_CGROUP_ACCT);
>>> -			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
>>> -					bio->bi_iter.bi_size);
>>> -		}
>>> -		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
>>> +	if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
>>> +		bio_set_flag(bio, BIO_CGROUP_ACCT);
>>> +		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
>>> +				bio->bi_iter.bi_size);
>>>    	}
>>> +	blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
>>

I checked the code again. If we remove cgroup_subsys_on_dfl check here, 
io statistics will still be performed in the case of v2, which I think 
is unnecessary, and this information will be counted to 
io_service_bytes/io_serviced, these two files are not visible in v2. Am 
I missing something?

Thanks.
Jinke
