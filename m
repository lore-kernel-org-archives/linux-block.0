Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9322CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 02:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7826D60F46
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 02:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237620AbhIUCRS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbhIUBpM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 21:45:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2F0C05937B;
        Mon, 20 Sep 2021 14:14:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso691172pjb.0;
        Mon, 20 Sep 2021 14:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1F1VImRdIvsBbvyEWpPqBiAhShvFTb0xdTumKJSrr2A=;
        b=IWwN1u0CeJlMjchKkoQsLreT4pEtHmC6hiWBr5i3VnaVEr7DkjGeCaKdtoPpd78/ZH
         CeFvmonvHqKbX84wpZA6F5fIlt5VoYchxiDDREGv5KyM1PUY7kXUlndYzajye0oACuZZ
         R1vujdssg3KEJrK8tZj2HFCiq+8NPZhxMWAJsICmnxWtL0VXgLoEBID5hed4qrqwn+RQ
         FnO+Fl6B/OSrqUC9uzHFsthxrIsTXh1OhFZb8u0EXjm7631gdB4QsHLHNLReGcRlm96j
         Rt+RSnCDnzJdjhg1mjIlqFCNlkCHnkvS9zXHDQ4jnoTBGTGJHXRjWyxHkdLxkbH0O6BL
         oKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1F1VImRdIvsBbvyEWpPqBiAhShvFTb0xdTumKJSrr2A=;
        b=Y7x9QfcJPpfK4hxcdZxLfTnSMbatRwfnpE+f989tulUVZhks6kwPDAP9993YzncqFb
         MLvdli3bmBK2NOu5q1piB6Yyi+ilF/yS92JWSWQiJ+xWqVXjFBV3lGhYrKq5CFUSuCSK
         MsKTlxdzT3XFsK0bQm5fLhg8usrjWyNNYelQqVTkb5saF7CfzAJAT494f5JDU4bhvKlg
         tITcsalK1uqlfPVi3NAc33TYqL+ZI01tygMgUpnG0wqZLIrHt2YDCox8q2pWuCT6sOdx
         1pTYJypL3Lm1dJJrhRMNMAimnHWoOaTjTD+BxT3y+4sANehwRe5MrFhxKueNiL4gCWcr
         M8KA==
X-Gm-Message-State: AOAM5318sqtHUQkKVwjhcOR5AALdnrSKfVyiZPRR5FflEsqnVzumuiAc
        GJ0Yg2p4ErfFefQ83wyDc6w=
X-Google-Smtp-Source: ABdhPJxQpnttJMKpuuKcrVEeMvxH4M8+rp0sWM7+K+NqEflGk3aZehOluaqPJYAbl64h3guo3kegQQ==
X-Received: by 2002:a17:902:6185:b0:13b:76f5:8a03 with SMTP id u5-20020a170902618500b0013b76f58a03mr24477797plj.85.1632172497288;
        Mon, 20 Sep 2021 14:14:57 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:9a49:e1f0:6fe9:6fd9])
        by smtp.gmail.com with ESMTPSA id b126sm1821914pga.67.2021.09.20.14.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 14:14:56 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 20 Sep 2021 14:14:54 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Subject: Re: [PATCH] zram: Introduce an aged idle interface
Message-ID: <YUj5zkRN+N404nbe@google.com>
References: <20210917210640.214211-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917210640.214211-1-bgeffon@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Sep 17, 2021 at 02:06:40PM -0700, Brian Geffon wrote:
> This change introduces a new sysfs file for the zram idle interface.
> The current idle interface has only a single mode "all." This is
> severely limiting in that it requires that you have the foresight
> to know that you'll want to have pages idle at some point in the future
> and forces the user to mark everything as idle.
> 
> This new proposed file idle_aged takes a single integer argument which
> represents the age of the pages (in seconds since access) to mark as idle.
> Because it requires accessed tracking it is only enabled when
> CONFIG_ZRAM_MEMORY_TRACKING is enabled. There are a few
> reasons why  this is being proposed as a new file rather than extending
> the existing file. The first reason is that it wouldn't allow more code
> sharing as this change already refactors the existing code to do so.
> Secondly, having a standalone file allows a caller to quickly check if this
> idle_aged interface is supported. Finally, it simplifies the parsing
> logic because now you only need to parse an int rather than more complex
> logic which would need to parse things like "aged 50."

I am not convinced with create new sysfs node to support the aged time.
The reason I used the "all" was to have the room to support the aged
time as you suggested for the future. IOW, If the value is not "all" but
"only numeric", we could take it as "aged" value.

And then, we can write up in the doc "The age-based idle" supported by
kernel version 5.XX with CONFIG_ZRAM_MEMORY_TRACKING.
I understand the separate interface will make code simple but not sure
it's worth to create another sysfs knob.

Any thoughts?

> 
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  Documentation/admin-guide/blockdev/zram.rst | 11 ++-
>  drivers/block/zram/zram_drv.c               | 75 +++++++++++++++++----
>  2 files changed, 70 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
> index 700329d25f57..ecd1c4916a1c 100644
> --- a/Documentation/admin-guide/blockdev/zram.rst
> +++ b/Documentation/admin-guide/blockdev/zram.rst
> @@ -209,6 +209,8 @@ compact           	WO	trigger memory compaction
>  debug_stat        	RO	this file is used for zram debugging purposes
>  backing_dev	  	RW	set up backend storage for zram to write out
>  idle		  	WO	mark allocated slot as idle
> +idle_aged              WO      mark allocated slot older than 'age' seconds
> +                                as idle (see later)
>  ======================  ======  ===============================================
>  
>  
> @@ -325,8 +327,13 @@ as idle::
>  
>  	echo all > /sys/block/zramX/idle
>  
> -From now on, any pages on zram are idle pages. The idle mark
> -will be removed until someone requests access of the block.
> +Alternatively if the config option CONFIG_ZRAM_MEMORY_TRACKING is enabled
> +the idle_aged interface can be used to mark only pages older than 'age'
> +seconds as idle::
> +
> +        echo 86400 > /sys/block/zramX/idle_aged
> +
> +The idle mark will be removed until someone requests access of the block.
>  IOW, unless there is access request, those pages are still idle pages.
>  
>  Admin can request writeback of those idle pages at right timing via::
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index fcaf2750f68f..a371dc0edf9d 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
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
> @@ -314,16 +308,63 @@ static ssize_t idle_store(struct device *dev,
>  		 */
>  		zram_slot_lock(zram, index);
>  		if (zram_allocated(zram, index) &&
> -				!zram_test_flag(zram, index, ZRAM_UNDER_WB))
> -			zram_set_flag(zram, index, ZRAM_IDLE);
> +				!zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
> +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> +			is_idle = (!cutoff || cutoff >= zram->table[index].ac_time);

I am not sure it's a good idea to compare those ktime_t directly
without using the ktime API(e.g., ktime_after or ktime_before).
Maybe, we can get age_sec ktime_t directly as a argument and then
use the ktime API with ktime_get_boottime to compare them. 

> +#endif
> +			if (is_idle)
> +				zram_set_flag(zram, index, ZRAM_IDLE);
> +		}
>  		zram_slot_unlock(zram, index);
>  	}
> +}
> +
> +static ssize_t idle_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	struct zram *zram = dev_to_zram(dev);
> +
> +	if (!sysfs_streq(buf, "all"))
> +		return -EINVAL;
> +
> +	down_read(&zram->init_lock);
> +	if (!init_done(zram)) {
> +		up_read(&zram->init_lock);
> +		return -EINVAL;
> +	}
>  
> +	/* Mark everything as idle */
> +	mark_idle(zram, 0);
>  	up_read(&zram->init_lock);
>  
>  	return len;
>  }
>  
> +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> +static ssize_t idle_aged_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	struct zram *zram = dev_to_zram(dev);
> +	ktime_t cutoff_time;
> +	u64 age_sec;
> +	ssize_t rv = -EINVAL;
> +
> +	down_read(&zram->init_lock);
> +	if (!init_done(zram))
> +		goto out;
> +
> +	if (kstrtoull(buf, 10, &age_sec))
> +		goto out;
> +
> +	rv = len;
> +	cutoff_time = ktime_sub(ktime_get_boottime(), ns_to_ktime(age_sec * NSEC_PER_SEC));
> +	mark_idle(zram, cutoff_time);
> +out:
> +	up_read(&zram->init_lock);
> +	return rv;
> +}
> +#endif
> +
>  #ifdef CONFIG_ZRAM_WRITEBACK
>  static ssize_t writeback_limit_enable_store(struct device *dev,
>  		struct device_attribute *attr, const char *buf, size_t len)
> @@ -1840,6 +1881,9 @@ static DEVICE_ATTR_WO(reset);
>  static DEVICE_ATTR_WO(mem_limit);
>  static DEVICE_ATTR_WO(mem_used_max);
>  static DEVICE_ATTR_WO(idle);
> +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> +static DEVICE_ATTR_WO(idle_aged);
> +#endif
>  static DEVICE_ATTR_RW(max_comp_streams);
>  static DEVICE_ATTR_RW(comp_algorithm);
>  #ifdef CONFIG_ZRAM_WRITEBACK
> @@ -1857,6 +1901,9 @@ static struct attribute *zram_disk_attrs[] = {
>  	&dev_attr_mem_limit.attr,
>  	&dev_attr_mem_used_max.attr,
>  	&dev_attr_idle.attr,
> +#ifdef CONFIG_ZRAM_MEMORY_TRACKING
> +	&dev_attr_idle_aged.attr,
> +#endif
>  	&dev_attr_max_comp_streams.attr,
>  	&dev_attr_comp_algorithm.attr,
>  #ifdef CONFIG_ZRAM_WRITEBACK
> -- 
> 2.33.0.464.g1972c5931b-goog
> 
