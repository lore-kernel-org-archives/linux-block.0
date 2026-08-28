Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474911C69D
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 04:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787891036; cv=none; b=ERMFLczrzKRVlYEhvznUskPWc6PRn47KQM3T3hpeMfj2DriWUnEjc4CrsISmegOQCETmn1hcU9N6RUVq3plAE1p44zRG43HKu0i0IjpmAAVQzkwDombGkBNGu1S+iO2rsk1TYBmlz1jnsbbHhVBtgQO2IqIfDrnPOA81hkbEMDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787891036; c=relaxed/simple;
	bh=DnZkF4y22JAJTSK2MwWTqrc1Kr8ta5ni+z0wpRWAhpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrOn4LeyOequZwHq3rRfm7o77I+WZRsRU69VF4PubmPWalM+30RPhbSNr+LPHtU0R55TeIrcypy4vT8Y8gjb6N+rNMXqHP9C0vwB1OZkJ/N3nPuWbIVNHkSXmF5vtontg1gxXOrSg7o6KXnDyrlnpKor5+FbeorbT4lprR3YAzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CuSEpZN0; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CuSEpZN0"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so499975a12.3
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 21:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787891034; x=1788495834; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VWPkFKtjckaHQlGnKFt7IY0lwvB1Zo3ZClT5DILJKpE=;
        b=CuSEpZN0pUsz+nThtjJ7CWtrdh4ucaAkZQAQL7inUMZwOPCiOOxe+YKQ2+FyGu8XZx
         QLB6YXU89U0Dwf0Q5U9Du3Mz6/oaP1lR20ug/ZxVXPlDkvQebAoJG0zSjT/XUW8R5SCc
         9HLtWsJGmBlRSFAX0MvaYLHTLew+CHEy7rSas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787891034; x=1788495834;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VWPkFKtjckaHQlGnKFt7IY0lwvB1Zo3ZClT5DILJKpE=;
        b=IeQ+64QW0jQUP9rICAbprxvWOEzDBlZwj2qdz5VKdITyw+nk+24W+xEFE9OtJZyhK9
         OaocUG6s454M/ovTZcS6cw07NYEE/lp6CVFp/wTEeLJBKaMpbN1o22w8BElOI429HC1g
         0qTLe6bfDmSSA92AbZjRmNa8cLEWbtzoCKkEyBI7ovWZdQv0L9qtWW1QagE+YA35hLJm
         axrcA9cexbO3dR8ADE58io4AqrBA2P4vUTi3ePTeJFIo0XBrSKeWoT1XDlZnCBjf93i2
         +Rf9i4qmIovOcrIqOF01S7nUTbLxyG0Aynqd6rN0xWQET3764Q3YsO6BBsZoIhp7sCZ5
         UXtQ==
X-Forwarded-Encrypted: i=1; AHgh+Rryk4gYK5FazXbTtyh2p5C1mR4vqu5m1Uq6cHz/CRLOsvok2uWKsF6YhhTADp/aMy391zh/NxDHB14RrQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nZOZXvG3qagFe9b4mZa2zUUgFRCHlCYGOKi4EukCxqeDcJcV81
	n9T2WCYy4WxJ7oprZb35BQXksy0BVbBzdNA7bt2KItz0B4Ut3Q8QE24XUxiiB/jDZw==
X-Gm-Gg: AR+sD138OZah8GIhjgIL/6k+BPCFBDxnjWfW8+EWcQZebTrR+YbYU+DKpLDhqdK/hRv
	0KDl4aqk2vzy2HSY7k+rjCOZ7zEZ8awDwiqeh1k/GJnZRQ6rKppL1AWkX1fM9XrTsdrThcghyjA
	VEQB5cRHnNXxoGqIS2LDzEiq/uz0gfUfbcVUqUnTxSOAebzbvyYV1eVZvTMkSYHwnGScouXaVSO
	RcFH3cDsCBo5da2qzfx7R5QIrl/7144XKsXsAV2e0KzFKDhbNAS8OibtN8wbFwR5HKHWqUmx5kq
	aDJCgzLCtXFn5t1D8wjkVcTRSZzTfFjh1ekzHuar7PwvN8vFLYaorfEp+WWp/lWRG7puRtBoQXE
	0JaLYXb8nnbYV72SMZjY1O8jQFujqd7fki+sUHKw6/UO1QEqwstGhXtdkOuZNj/Dcnh5/3b8gAl
	RSKUbRK7B1X5knO5xn+31m/w4AFrB87IsiKnXYMkdUqvBUcTTiXexuiuwiQIz8RzTGfTgJzVENa
	48x1uSWHEfTF4Ru0KGLKuQoaSgl4Xb8klaAYA==
X-Received: by 2002:a17:90b:1d46:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-396d0f8d841mr8257407a91.14.1787891034541;
        Thu, 27 Aug 2026 21:23:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:ff0:ad84:24b0:9e52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396ddc08266sm823074a91.11.2026.08.27.21.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 21:23:53 -0700 (PDT)
Date: Fri, 28 Aug 2026 13:23:49 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Brian Geffon <bgeffon@google.com>, minchan@kernel.org, 
	senozhatsky@chromium.org, axboe@kernel.dk, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Subject: Re: [PATCH] zram: fix idle age_sec underflow in idle_store()
Message-ID: <apEK-yRTQR8VdT3e@google.com>
References: <20260825092316.69658-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825092316.69658-1-jiahao.kernel@gmail.com>

Adding Brian.

On (26/08/25 17:23), Hao Jia wrote:
> After commit 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking"),
> idle_store() computes the idle cutoff as follows:
> 
> 	cutoff = ktime_sub((u32)ktime_get_boottime_seconds(), age_sec);
> 
> Because the left operand is cast to a 32-bit unsigned integer, when
> age_sec exceeds the current uptime, the subtraction wraps modulo 2^32
> and the huge result is zero-extended into the s64 cutoff.  mark_idle()
> subsequently marks every entry as idle instead of matching nothing,
> breaking the intended semantics of /sys/block/zramX/idle.  For instance,
> running echo 86400 > idle on a machine up for only two minutes causes
> all newly written pages to be marked as idle and handed over to idle
> writeback and recompression.
> 
> Drop the explicit cast to perform the subtraction in signed arithmetic
> again, restoring the previous behavior: an age_sec greater than uptime
> yields a negative cutoff, and one equal to uptime yields 0. Since a
> cutoff of 0 is now a valid computed value, it can no longer double as
> the "all" sentinel. Switch to KTIME_MIN instead, which no ac_time can
> be after.

Can we instead just reject such cases?   It should be an error to
request writeback of pages that are 2y old on a system that has
uptime of 2d.

Maybe something like this:

+             time64_t uptime;

-             if (IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) &&
-                 !kstrtouint(buf, 0, &age_sec))
-                     cutoff = ktime_sub((u32)ktime_get_boottime_seconds(),
-                                        age_sec);
-             else
+             if (!IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) ||
+                 kstrtouint(buf, 0, &age_sec))
                      return -EINVAL;
+
+             /* No slot can be older than the system uptime */
+             uptime = ktime_get_boottime_seconds();
+             if (age_sec >= uptime)
+                     return -ERANGE;
+
+             cutoff = uptime - age_sec;
      }

We are probably fine doing just basic arithmetics operations on those two.
One is u32 the other one is s64: we should be fine just doing >= and sub.
I guess we also can use plain comparison
	cutoff > zram->table[index].attr.ac_time
in mark_idle().  Or am I hallucinating?

[keeping the rest of the original patch]

> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index a9b3bb1d3bef..da51f70b7121 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -438,7 +438,7 @@ static void mark_idle(struct zram *zram, ktime_t cutoff)
>  		}
>  
>  #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
> -		is_idle = !cutoff ||
> +		is_idle = cutoff == KTIME_MIN ||
>  			ktime_after(cutoff, zram->table[index].attr.ac_time);
>  #endif
>  		if (is_idle)
> @@ -453,7 +453,7 @@ static ssize_t idle_store(struct device *dev, struct device_attribute *attr,
>  			  const char *buf, size_t len)
>  {
>  	struct zram *zram = dev_to_zram(dev);
> -	ktime_t cutoff = 0;
> +	ktime_t cutoff = KTIME_MIN;
>  
>  	if (!sysfs_streq(buf, "all")) {
>  		/*
> @@ -464,7 +464,7 @@ static ssize_t idle_store(struct device *dev, struct device_attribute *attr,
>  
>  		if (IS_ENABLED(CONFIG_ZRAM_TRACK_ENTRY_ACTIME) &&
>  		    !kstrtouint(buf, 0, &age_sec))
> -			cutoff = ktime_sub((u32)ktime_get_boottime_seconds(),
> +			cutoff = ktime_sub(ktime_get_boottime_seconds(),
>  					   age_sec);
>  		else
>  			return -EINVAL;
> @@ -475,7 +475,7 @@ static ssize_t idle_store(struct device *dev, struct device_attribute *attr,
>  		return -EINVAL;
>  
>  	/*
> -	 * A cutoff of 0 marks everything as idle, this is the
> +	 * A cutoff of KTIME_MIN marks everything as idle, this is the
>  	 * "all" behavior.
>  	 */
>  	mark_idle(zram, cutoff);
> -- 
> 2.34.1
> 
