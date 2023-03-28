Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E83C76196
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 18:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjC1Sfu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 14:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjC1Sfq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 14:35:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC001BE9
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 11:35:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x3so53453327edb.10
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 11:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112; t=1680028543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o2hU/6GK4yHeI2E04kJ+wsLD2zzLn1ZOn5QkCTAS5dA=;
        b=s0OoCPYdYEkWiMM8TXR/F3G9QugCTOtdgkWp/fAicaUkKXgp2XFtYk3zAUJDnqMevi
         Xf3+4b4fd5Hu48QoqkKSoCVZsT/Yu/N42Wa9Xnu6CA1219jcL+oRyO5XLEoidveTUKxo
         n9LN1JGvmoY8hBOw5A5+2YwYwtSgihqAfZHA/SSCzYsNIbb59Gr3mxUyfBoQLyigm3lG
         H5c/SlIDP4jZ6S555S4kX6KlRLshghyMMwqgBANA/rYnynD/kB+E28gcQIpx3ZCw4xvH
         0Ozo6mqt8M0TtOo4/jZmtibYgtdp6nIfHpBDsPH0Xk+R5aSBpV0qEeiqa9Sdjd6u/uQ6
         FU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680028543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2hU/6GK4yHeI2E04kJ+wsLD2zzLn1ZOn5QkCTAS5dA=;
        b=LZ9zjnfKO/gM015XTBQREBdjZ72VWfxQLtFmTS4ATIMrl+b8r5FMKngMHwMKPabxJ/
         u18hm6QQ+Z5owQu5P8wwIl4Yz9NFXbciw7kTQB/V2VGHjGBk7cjBsi2ZSi0omgnJNYnT
         S5CSWEomceQ4hT5/9YdEx6wFRaPEy/Xtqagnag9nyKG4M1Lni8kEOJmyTEVlYLLS8lH6
         9guIhOEOtMI0bmaR9aV8Mbd1DEIHuGq/gSp89dbLcAiXa2mOrna+XNxCSh7nEbia0FL6
         IN2to2mNc4IFWIuqAti87qndgXOtShjhsn0TuUisVKqRCNuKiaBjonMzYCCumaZadZ09
         5zrA==
X-Gm-Message-State: AAQBX9c2uUesao4TmJNOBJvklKOLH6I1tMm1vt2U9s4F6j//RwbGi4PO
        tz8o/xBK3U0/d6YA8DUJCw27EA==
X-Google-Smtp-Source: AKy350bYttSe2oGRVQfhpmdTk3tJEKqV5AnnS8nas8nc2Mr9yRQPwSpOo1ua8Z0xDEcEaG7DPr+yeQ==
X-Received: by 2002:a17:907:7e8e:b0:932:dae5:2af9 with SMTP id qb14-20020a1709077e8e00b00932dae52af9mr22308243ejc.51.1680028543196;
        Tue, 28 Mar 2023 11:35:43 -0700 (PDT)
Received: from localhost ([2a02:8070:6387:ab20:5139:4abd:1194:8f0e])
        by smtp.gmail.com with ESMTPSA id xh1-20020a170906da8100b0093f83562f09sm4460301ejb.87.2023.03.28.11.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 11:35:43 -0700 (PDT)
Date:   Tue, 28 Mar 2023 14:35:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v1 6/9] memcg: sleep during flushing stats in safe
 contexts
Message-ID: <ZCMzfQuo9IhWVzRA@cmpxchg.org>
References: <20230328061638.203420-1-yosryahmed@google.com>
 <20230328061638.203420-7-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328061638.203420-7-yosryahmed@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 28, 2023 at 06:16:35AM +0000, Yosry Ahmed wrote:
> @@ -642,24 +642,57 @@ static void __mem_cgroup_flush_stats(void)
>  	 * from memcg flushers (e.g. reclaim, refault, etc).
>  	 */
>  	if (atomic_xchg(&stats_flush_ongoing, 1))
> -		return;
> +		return false;
>  
>  	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
> -	cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
> +	return true;
> +}
> +
> +static void mem_cgroup_post_stats_flush(void)
> +{
>  	atomic_set(&stats_flush_threshold, 0);
>  	atomic_set(&stats_flush_ongoing, 0);
>  }
>  
> -void mem_cgroup_flush_stats(void)
> +static bool mem_cgroup_should_flush_stats(void)
>  {
> -	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
> -		__mem_cgroup_flush_stats();
> +	return atomic_read(&stats_flush_threshold) > num_online_cpus();
> +}
> +
> +/* atomic functions, safe to call from any context */
> +static void __mem_cgroup_flush_stats_atomic(void)
> +{
> +	if (mem_cgroup_pre_stats_flush()) {
> +		cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
> +		mem_cgroup_post_stats_flush();
> +	}
> +}

I'm afraid I wasn't very nuanced with my complaint about the bool
parameter in the previous version. In this case, when you can do a
common helper for a couple of API functions defined right below it,
and the callers don't spread throughout the codebase, using bools
makes things simpler while still being easily understandable:

static void do_flush_stats(bool may_sleep)
{
	if (atomic_xchg(&stats_flush_ongoing, 1))
		return;

	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
	atomic_set(&stats_flush_threshold, 0);

	if (!may_sleep)
		cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
	else
		cgroup_rstat_flush(root_mem_cgroup->css.cgroup);

	atomic_set(&stats_flush_ongoing, 0);
}

void mem_cgroup_flush_stats(void)
{
	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
		do_flush_stats(true);
}

void mem_cgroup_flush_stats_atomic(void)
{
	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
		do_flush_stats(false);
}

>  void mem_cgroup_flush_stats_ratelimited(void)
>  {
>  	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
> -		mem_cgroup_flush_stats();
> +		mem_cgroup_flush_stats_atomic();
> +}

This should probably be mem_cgroup_flush_stats_atomic_ratelimited().

(Whee, kinda long, but that's alright. Very specialized caller...)

Btw, can you guys think of a reason against moving the threshold check
into the common function? It would then apply to the time-limited
flushes as well, but that shouldn't hurt anything. This would make the
code even simpler:

static void do_flush_stats(bool may_sleep)
{
	if (atomic_read(&stats_flush_threshold) <= num_online_cpus())
		return;

	if (atomic_xchg(&stats_flush_ongoing, 1))
		return;

	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
	atomic_set(&stats_flush_threshold, 0);

	if (!may_sleep)
		cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
	else
		cgroup_rstat_flush(root_mem_cgroup->css.cgroup);

	atomic_set(&stats_flush_ongoing, 0);
}

void mem_cgroup_flush_stats(void)
{
	do_flush_stats(true);
}

void mem_cgroup_flush_stats_atomic(void)
{
	do_flush_stats(false);
}

void mem_cgroup_flush_stats_atomic_ratelimited(void)
{
	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
		do_flush_stats(false);
}

> @@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
>  	 * Flush the memory cgroup stats, so that we read accurate per-memcg
>  	 * lruvec stats for heuristics.
>  	 */
> -	mem_cgroup_flush_stats();
> +	mem_cgroup_flush_stats_atomic();

I'm thinking this one could be non-atomic as well. It's called fairly
high up in reclaim without any locks held.
