Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AA5C433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 22:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4530D6124B
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 22:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243451AbhIWWym (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 18:54:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236363AbhIWWyl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 18:54:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D4EA61050;
        Thu, 23 Sep 2021 22:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1632437589;
        bh=C3SYeyDKvKpb/ztYsrD8obNOu9dSdXZY8PFIa55n+74=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KZ3gMZwg4rgJ9cLecymJdeyv6i54jC7zVxLOfjkazVUlux9mYsa73ABGN59P4idUi
         vuuJ7LslTKcm3niLg6ci5tCI5QkH6FfZMbvf+dXZp6sZAMKa4FePEb/vV/DSlnR+t8
         rrRhkFGxbVQbFrgWJXjxie+JOSrcd/pPdSnyGya8=
Date:   Thu, 23 Sep 2021 15:53:08 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Subject: Re: [PATCH v4] zram: Introduce an aged idle interface
Message-Id: <20210923155308.9b522a77a02ee13b76e9e613@linux-foundation.org>
In-Reply-To: <20210923130115.1344361-1-bgeffon@google.com>
References: <20210917210640.214211-1-bgeffon@google.com>
        <20210923130115.1344361-1-bgeffon@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 23 Sep 2021 06:01:15 -0700 Brian Geffon <bgeffon@google.com> wrote:

> This change introduces an aged idle interface to the existing
> idle sysfs file for zram.
> 
> When CONFIG_ZRAM_MEMORY_TRACKING is enabled the idle file
> now also accepts an integer argument. This integer is the
> age (in seconds) of pages to mark as idle. The idle file
> still supports 'all' as it always has. This new approach
> allows for much more control over which pages get marked
> as idle.
> 
> @@ -291,22 +291,16 @@ static ssize_t mem_used_max_store(struct device *dev,
>  	return len;
>  }
>  
> -static ssize_t idle_store(struct device *dev,
> -		struct device_attribute *attr, const char *buf, size_t len)
> +/*
> + * Mark all pages which are older than or equal to cutoff as IDLE.
> + * Callers should hold the zram init lock in read mode
> + **/

A simple "*/" is conventional.

> +static void mark_idle(struct zram *zram, ktime_t cutoff)
>  {
> -	struct zram *zram = dev_to_zram(dev);
> +	int is_idle = 1;
>  	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
>  	int index;
>  
> -	if (!sysfs_streq(buf, "all"))
> -		return -EINVAL;
> -
> -	down_read(&zram->init_lock);
> -	if (!init_done(zram)) {
> -		up_read(&zram->init_lock);
> -		return -EINVAL;
> -	}
> -
>  	for (index = 0; index < nr_pages; index++) {
>  		/*
>  		 * Do not mark ZRAM_UNDER_WB slot as ZRAM_IDLE to close race.
> @@ -314,14 +308,48 @@ static ssize_t idle_store(struct device *dev,
>  		 */
>  		zram_slot_lock(zram, index);
>  		if (zram_allocated(zram, index) &&
> -				!zram_test_flag(zram, index, ZRAM_UNDER_WB))
> -			zram_set_flag(zram, index, ZRAM_IDLE);
> +				!zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
> +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> +			is_idle = (!cutoff || ktime_after(cutoff, zram->table[index].ac_time));
> +#endif
> +			if (is_idle)
> +				zram_set_flag(zram, index, ZRAM_IDLE);
> +		}
>  		zram_slot_unlock(zram, index);
>  	}
> +}
>  
> -	up_read(&zram->init_lock);
> +static ssize_t idle_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	struct zram *zram = dev_to_zram(dev);
> +	ktime_t cutoff_time = 0;
> +	ssize_t rv = -EINVAL;
>  
> -	return len;
> +	if (!sysfs_streq(buf, "all")) {
> +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> +		u64 age_sec;
> +		/* If it did not parse as 'all' try to treat it as an integer */
> +		if (!kstrtoull(buf, 0, &age_sec))
> +			cutoff_time = ktime_sub(ktime_get_boottime(),
> +					ns_to_ktime(age_sec * NSEC_PER_SEC));
> +		else
> +#endif
> +			goto out;
> +	}

The ifdef tricks are pretty ugly.  Can things be improved with IS_ENABLED()?


