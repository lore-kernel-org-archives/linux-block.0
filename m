Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FD9C433FE
	for <linux-block@archiver.kernel.org>; Mon, 14 Nov 2022 04:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbiKNEDA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Nov 2022 23:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbiKNEC7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Nov 2022 23:02:59 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F6C13CCA
        for <linux-block@vger.kernel.org>; Sun, 13 Nov 2022 20:02:57 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q1so9218178pgl.11
        for <linux-block@vger.kernel.org>; Sun, 13 Nov 2022 20:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AZVouTJdT6m/9WEf41/GvLl8YStUJpgeqkaMfyjFk98=;
        b=bPhj18ns1d9UqFc4xmE6cjMX7LPa5LT1Hs30thmFJRKAZ2UZU4MVVJU3qTa3O+g93+
         T50wxxrdI2E77j4L26SXMiuGz6X5hbZvhKxq6vctBd/7aWw5tV1Z5dL862gA6LY/D3Gy
         GivwAD995KjW4xNlyqwcyKFrZU9dKwrb+FIao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZVouTJdT6m/9WEf41/GvLl8YStUJpgeqkaMfyjFk98=;
        b=TyYRsF41DxngpMW1sT2fq6x58t03iMimSbh9jU7Rn9aInksnUjUu+umnZ/wnwtb82G
         /IkvQuuWzwqXyhPQYlv4V9SGemve2eauakolUAt5Wz8UOXraigNK7B36Q/+hlHhtEFG2
         /jvHPSc3IIuiG/sYwz9+wdfaanClMEu46zzdtc+ZqGO7ofWcGyWdrCywgou5iKl0IXC+
         b3R3jtDfUOxf68kM6xyjWkfIAI3eNEM7X6EvaE2Cwf0wSn9ZeZHAaIxQBPyZAHC/wmpT
         ZGlDyzmEEJQaYogXoBOH/BlqNji3Z5lAU+turDZ+0oiRY/diy1aphA6LJgAo/hnfDuMZ
         TbLA==
X-Gm-Message-State: ANoB5pkSbCn2Mm0fA7uOa5wNGe/j8CspWTDsEDqigcOrf/FGoeEaJuKp
        bpuSOulbejPsbPPP15vSCcecObYQdcN0yA==
X-Google-Smtp-Source: AA0mqf7dHYQAXiJUo77CJ3XYezvkEz26h0Kg4ieqiv54LqBBcz84X6DKscefko4d01n0uAd/dzDWoQ==
X-Received: by 2002:a63:4e13:0:b0:46f:c465:5848 with SMTP id c19-20020a634e13000000b0046fc4655848mr10330801pgb.148.1668398577047;
        Sun, 13 Nov 2022 20:02:57 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:68f5:86c0:dcaa:df5])
        by smtp.gmail.com with ESMTPSA id t184-20020a625fc1000000b00562ef28aac6sm5476625pfb.185.2022.11.13.20.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 20:02:56 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:02:51 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     yang.yang29@zte.com.cn
Cc:     Andrew Morton <akpm@linux-foundation.org>, minchan@kernel.org,
        ngupta@vflare.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        xu.panda@zte.com.cn
Subject: Re: [PATCH linux-next] zram: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <Y3G9649G6j99N/F2@google.com>
References: <202211141141400847357@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211141141400847357@zte.com.cn>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (22/11/14 11:41), yang.yang29@zte.com.cn wrote:
[..]
>  static ssize_t max_comp_streams_store(struct device *dev,
> @@ -1191,8 +1191,7 @@ static ssize_t io_stat_show(struct device *dev,
>  	ssize_t ret;
> 
>  	down_read(&zram->init_lock);
> -	ret = scnprintf(buf, PAGE_SIZE,
> -			"%8llu %8llu %8llu %8llu\n",
> +	ret = sysfs_emit(buf, "%8llu %8llu %8llu %8llu\n",
>  			(u64)atomic64_read(&zram->stats.failed_reads),
>  			(u64)atomic64_read(&zram->stats.failed_writes),
>  			(u64)atomic64_read(&zram->stats.invalid_io),

sysfs_emit() params need to be realigned to match (.

> @@ -1222,8 +1221,7 @@ static ssize_t mm_stat_show(struct device *dev,
>  	orig_size = atomic64_read(&zram->stats.pages_stored);
>  	max_used = atomic_long_read(&zram->stats.max_used_pages);
> 
> -	ret = scnprintf(buf, PAGE_SIZE,
> -			"%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
> +	ret = sysfs_emit(buf, "%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
>  			orig_size << PAGE_SHIFT,
>  			(u64)atomic64_read(&zram->stats.compr_data_size),
>  			mem_used << PAGE_SHIFT,

Ditto.

> @@ -1247,8 +1245,7 @@ static ssize_t bd_stat_show(struct device *dev,
>  	ssize_t ret;
> 
>  	down_read(&zram->init_lock);
> -	ret = scnprintf(buf, PAGE_SIZE,
> -		"%8llu %8llu %8llu\n",
> +	ret = sysfs_emit(buf, "%8llu %8llu %8llu\n",
>  			FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
>  			FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
>  			FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));

Ditto.

> @@ -1266,9 +1263,7 @@ static ssize_t debug_stat_show(struct device *dev,
>  	ssize_t ret;
> 
>  	down_read(&zram->init_lock);
> -	ret = scnprintf(buf, PAGE_SIZE,
> -			"version: %d\n%8llu %8llu\n",
> -			version,
> +	ret = sysfs_emit(buf, "version: %d\n%8llu %8llu\n", version,
>  			(u64)atomic64_read(&zram->stats.writestall),
>  			(u64)atomic64_read(&zram->stats.miss_free));

Ditto.

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 01ab32f2897e..430933b73c1b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1192,10 +1192,10 @@ static ssize_t io_stat_show(struct device *dev,
 
 	down_read(&zram->init_lock);
 	ret = sysfs_emit(buf, "%8llu %8llu %8llu %8llu\n",
-			(u64)atomic64_read(&zram->stats.failed_reads),
-			(u64)atomic64_read(&zram->stats.failed_writes),
-			(u64)atomic64_read(&zram->stats.invalid_io),
-			(u64)atomic64_read(&zram->stats.notify_free));
+			 (u64)atomic64_read(&zram->stats.failed_reads),
+			 (u64)atomic64_read(&zram->stats.failed_writes),
+			 (u64)atomic64_read(&zram->stats.invalid_io),
+			 (u64)atomic64_read(&zram->stats.notify_free));
 	up_read(&zram->init_lock);
 
 	return ret;
@@ -1222,15 +1222,15 @@ static ssize_t mm_stat_show(struct device *dev,
 	max_used = atomic_long_read(&zram->stats.max_used_pages);
 
 	ret = sysfs_emit(buf, "%8llu %8llu %8llu %8lu %8ld %8llu %8lu %8llu %8llu\n",
-			orig_size << PAGE_SHIFT,
-			(u64)atomic64_read(&zram->stats.compr_data_size),
-			mem_used << PAGE_SHIFT,
-			zram->limit_pages << PAGE_SHIFT,
-			max_used << PAGE_SHIFT,
-			(u64)atomic64_read(&zram->stats.same_pages),
-			atomic_long_read(&pool_stats.pages_compacted),
-			(u64)atomic64_read(&zram->stats.huge_pages),
-			(u64)atomic64_read(&zram->stats.huge_pages_since));
+			 orig_size << PAGE_SHIFT,
+			 (u64)atomic64_read(&zram->stats.compr_data_size),
+			 mem_used << PAGE_SHIFT,
+			 zram->limit_pages << PAGE_SHIFT,
+			 max_used << PAGE_SHIFT,
+			 (u64)atomic64_read(&zram->stats.same_pages),
+			 atomic_long_read(&pool_stats.pages_compacted),
+			 (u64)atomic64_read(&zram->stats.huge_pages),
+			 (u64)atomic64_read(&zram->stats.huge_pages_since));
 	up_read(&zram->init_lock);
 
 	return ret;
@@ -1246,9 +1246,9 @@ static ssize_t bd_stat_show(struct device *dev,
 
 	down_read(&zram->init_lock);
 	ret = sysfs_emit(buf, "%8llu %8llu %8llu\n",
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
-			FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
+			 FOUR_K((u64)atomic64_read(&zram->stats.bd_count)),
+			 FOUR_K((u64)atomic64_read(&zram->stats.bd_reads)),
+			 FOUR_K((u64)atomic64_read(&zram->stats.bd_writes)));
 	up_read(&zram->init_lock);
 
 	return ret;
@@ -1264,8 +1264,8 @@ static ssize_t debug_stat_show(struct device *dev,
 
 	down_read(&zram->init_lock);
 	ret = sysfs_emit(buf, "version: %d\n%8llu %8llu\n", version,
-			(u64)atomic64_read(&zram->stats.writestall),
-			(u64)atomic64_read(&zram->stats.miss_free));
+			 (u64)atomic64_read(&zram->stats.writestall),
+			 (u64)atomic64_read(&zram->stats.miss_free));
 	up_read(&zram->init_lock);
 
 	return ret;
