Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AC2C77B78
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 15:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjEDPJl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 May 2023 11:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjEDPJ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 11:09:29 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB234209
        for <linux-block@vger.kernel.org>; Thu,  4 May 2023 08:08:59 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64382139ebaso462285b3a.2
        for <linux-block@vger.kernel.org>; Thu, 04 May 2023 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683212939; x=1685804939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFa1D5Tpf/QrQJM5h3CrUwGz4UKarPH+tDSx3KZiqW0=;
        b=DNqvvH4fVrTxxmy3uWocPqMrVQzGrvn1bKV/DBRhuLaJP6xVuRfHqmbHfrevd1owR/
         jiCrzjiOJ6WKw3SidjtKGTAo3Kw6pc6zVNOe6oEJ3Q7NwivVlUyL5fyWvqWOdTYm67kg
         bB8EjQA5ooh95ZqFlEOhksFT0f1AAMr4Zq0N5VHLOQUfiSYQ2Jc4c9mMxf5zpl9GlztJ
         79At54zrwpPkmPzu2hgVlWkTkzYQtfrDyMp6XW8rtYcSI5MAQsYKVXYMVqd667juw5MI
         6RoawcuDBmVVXahW627FRVPS71JWh8CGrpk9MFh7Dh0Tq7PtZCP2VYWXY72KPg5byozj
         1LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683212939; x=1685804939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OFa1D5Tpf/QrQJM5h3CrUwGz4UKarPH+tDSx3KZiqW0=;
        b=WWfzSUDrg6YGTpE1r3hn8/hqkUexPrC6T/skn2u93cx5xZWNwV0aQCOH1DUcLQ1w4E
         jKcDUFbQYfeyUq/iwYhH8glGB89D8kMVMN9QjIvdnWtmAlVbOv0wEM1W/sA+cz0CuBEt
         58TJSSg5/cMzoZYU7MMVQBhcCOJ82PO/cCmSd0hBfNomeH91YTiLLjzc8kAVjU0i7gv4
         16/IM1tay3BMzx6KxPXHSKtCw8B9B8+P6DfhfU4CmlRbbyltiVK+ZHQMJGQ4Uhiar1d0
         0LW9l/EyTC4J6GKxadGgVkipZxRXpqclCfz8HZblLRVIxU3T+UANYMoXqDJXYRSvJjNL
         3WHg==
X-Gm-Message-State: AC+VfDxr5UtheSNeqNeLhFY2mQ1If6oLuRKn60Ve8zVtnt3b14ogDSbJ
        ddDt2cnpJW2QOkxCBwgOruVFDQ==
X-Google-Smtp-Source: ACHHUZ7b8yMStegf41qN6JKvTRQVyQ3nCGCRxb9QEu/dI4w/6IChTI343PJi8jI6S37UwLLoQfMuuQ==
X-Received: by 2002:a05:6a00:23d1:b0:63d:311a:a16b with SMTP id g17-20020a056a0023d100b0063d311aa16bmr2998351pfc.23.1683212939365;
        Thu, 04 May 2023 08:08:59 -0700 (PDT)
Received: from [10.255.14.217] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id u21-20020aa78495000000b0063d24fcc2besm1753144pfn.125.2023.05.04.08.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 08:08:58 -0700 (PDT)
Message-ID: <eb2eeb6b-07da-4e98-142c-da1e7ea35c2b@bytedance.com>
Date:   Thu, 4 May 2023 23:08:53 +0800
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
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <ZEwY5Oo+5inO9UFf@righiandr-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

Sorry for delay（Chinese Labor Day holiday).

在 2023/4/29 上午3:05, Andrea Righi 写道:
> On Sat, Apr 01, 2023 at 05:47:08PM +0800, Jinke Han wrote:
>> From: Jinke Han <hanjinke.666@bytedance.com>
>>
>> After commit f382fb0bcef4 ("block: remove legacy IO schedulers"),
>> blkio.throttle.io_serviced and blkio.throttle.io_service_bytes become
>> the only stable io stats interface of cgroup v1, and these statistics
>> are done in the blk-throttle code. But the current code only counts the
>> bios that are actually throttled. When the user does not add the throttle
>> limit, the io stats for cgroup v1 has nothing. I fix it according to the
>> statistical method of v2, and made it count all ios accurately.
>>
>> Fixes: a7b36ee6ba29 ("block: move blk-throtl fast path inline")
>> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
> 
> Thanks for fixing this!
> 
> The code looks correct to me, but this seems to report io statistics
> only if at least one throttling limit is defined. IIRC with cgroup v1 it
> was possible to see the io statistics inside a cgroup also with no
> throttling limits configured.
> 
> Basically to restore the old behavior we would need to drop the
> cgroup_subsys_on_dfl() check, something like the following (on top of
> your patch).
> 
> But I'm not sure if we're breaking other behaviors in this way...
> opinions?
> 
>   block/blk-cgroup.c   |  3 ---
>   block/blk-throttle.h | 12 +++++-------
>   2 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 79138bfc6001..43af86db7cf3 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -2045,9 +2045,6 @@ void blk_cgroup_bio_start(struct bio *bio)
>   	struct blkg_iostat_set *bis;
>   	unsigned long flags;
>   
> -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
> -		return;
> -
>   	/* Root-level stats are sourced from system-wide IO stats */
>   	if (!cgroup_parent(blkcg->css.cgroup))
>   		return;
> diff --git a/block/blk-throttle.h b/block/blk-throttle.h
> index d1ccbfe9f797..bcb40ee2eeba 100644
> --- a/block/blk-throttle.h
> +++ b/block/blk-throttle.h
> @@ -185,14 +185,12 @@ static inline bool blk_should_throtl(struct bio *bio)
>   	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
>   	int rw = bio_data_dir(bio);
>   
> -	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
> -		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
> -			bio_set_flag(bio, BIO_CGROUP_ACCT);
> -			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
> -					bio->bi_iter.bi_size);
> -		}
> -		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
> +	if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
> +		bio_set_flag(bio, BIO_CGROUP_ACCT);
> +		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
> +				bio->bi_iter.bi_size);
>   	}
> +	blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);

It seems that statistics have been carried out in both v1 and v2，we can 
get the statistics of v2 from io.stat, is it necessary to count v2 here?


