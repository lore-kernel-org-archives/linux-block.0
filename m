Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795250161;
	b=hVNTCDi+rio02GGZq7TuK/2PCZ8fDl+VVPog9wwxDpdjOEyvNXu88ZsNqNQEpnqi8tvd
	 MemSnISTqfaNWm4tn6yxqScoWP5o3rsVv5kRRgO71KIjtjw8ZLsx2O0s3T5zinvF9wkE1
	 DjIoMJipjZr6NmP42a5tCiFDEUdqT3wtArWG0gk33tsW8dc3BTt8Rf8sGT5QbQIFD8KXE
	 Sv4DMfOTn1ktVZ9NDU+Ztc9nZyDR+2JZhC+bspx8I65JkDQxwQgp8RPzT/TKgvG1tx4ub
	 1kLfZW1lVgHWHIeOiUNzUQYfLVABcHsQnR/2XplBlPuofJnZ67XGjZudljNx7zm19xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795250161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=q1d44l4EB5ZU0oAa814zHpO0T89XFHbgu/Aqd5GidKs=;
	b=trwehb43NA/M5KYc05m15yLSZYF4hy6A4pLgVRkZilVORkh96OMgtHn8+wdOScMxW8QC
	 8n5qIdh2tPasLgplYWBjDeuIEvNgLhLe9E4tM/LI1od1rhXcgt1X3Evwzavbs6lDnEijU
	 j4oWIukmj1kWybrl62rHSuCg8rnEj8JekIzuAJRpl1sdnSpffW1W3G0JUjdoJjhFwJ1Vh
	 fABYKzW4s9XtDczEPN0sdUmh/GPrDUX6U00hcVP+9wRFTFqB3Q0XOKesy3AipNJhJyQYx
	 +HdKgfRNG5/k8G6L2R+dPbARLGxbEnUAQTSiECrKIaHSOfebCs34wMVqrTeel7rz4QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fylOpPWO;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCC5606A32C
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 08:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FCC5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fylOpPWO
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b3a914e4c8so954305a91.0
        for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 00:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795250160; x=1795854960; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=q1d44l4EB5ZU0oAa814zHpO0T89XFHbgu/Aqd5GidKs=;
        b=fylOpPWOfbB8Mrzaa8jy6O6PqZYCt9WZPTMsgYGA4VPpsQ1Mv1UgBsovjDm+hc71OY
         KZzdpWzTAstESQ8MR6iPswzIo6xcJm2mqUKn7R5liNiKfGLEcJh4re82835A2RzTv9V8
         MSjXeTNCtlafTTYoQyO6X5xMQOdkhDVqBHLJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795250160; x=1795854960;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q1d44l4EB5ZU0oAa814zHpO0T89XFHbgu/Aqd5GidKs=;
        b=24EiZpDeLJJykAlTvyASx9M+xQMPjz2UceMRdA89e52F0/4YC+3ZXRQ+0ht1aSrh81
         2/P+UgMQV7ZUm7fh3zPFBj7kC4ZPQMhzpo+Ju8vK2dDoOmteqq/XQg4fQFi5kibcuhc/
         Rv7B7w6dA8wAtqHzplould3qi6HqDRaLhRY/Fncwg+pNZ04lqjQVa9+2Cp3NU4FpA2B8
         7+D77DtJH4GvlvROCs3RKTRKEyKaNQr/VXCefP0hXchfKnULAcFWnaKi14WbypyXlni8
         OC+QTwbug22JuF3MFj08VKVZasO1C68lQ/DCEFE+WZoL2hmDPnbqsndchanxK2cBKKnc
         nCOQ==
X-Forwarded-Encrypted: i=1; AL+hErHQ7f/se35Pqz9aEjXO4NJ9uTX+mcbKOktMmKzU3/lXXqtm8Tx3JlL4b0ppENUuU8iGN/kt8PX7TmvqGQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/w3TJ+sD1bRptEYgHf0Pqk//6U/M5CnTqRf3UDXGeSuEvySdcc
	Nevf5YhxpHUUIusISO6pry6js463FDlJl3txpfG+9JeIxThTW1S78KtPRY/yfhW0BA==
X-Gm-Gg: AZFdTZfOb8OdqgqhqsFv++H38BpdfztQ41M/sEhjO/pJmBTpMLjZA5wavxpX5csF218
	xAc/8Qcgt0bngu4NJhgw4KSp+5/AGq78zlnu0kCpGITH1mWkCGS5DzdGMs6AWkvYt2LCw17u0XD
	Rg2SnGFDrPaDFKESgs5mmhtQT9WiLrneSdFa3NXlvXm4E0buk8Je4ctXFPUZUlX3XEevepbpDpm
	636lxofJqc+t977YTqFzrWyDLXs0sOvRxHO/Uxx5640NXXg3LddB95xGspe9PifcvtlkPjtDGKl
	QWmZ/0j4ieQB3UpJHkr/98SgFmQGTp6KNpyfcGCoaKnqy5MbBxY4+p64GWdKhqr1c5gL0XdXLLB
	5QTn65xFBjlp0LVeO1TKiw9y0uD/Ey/zkWfq/+D/mNZtLmElJ6aZICfkdC/Aiw8+LSY//4/XUH1
	UYxhFLeTF6WUeXiJVRMAeHs8uycDa34EbVqp7s0XdX2cd8C1VS0TtD8g7rXOh79YYbH+QKPsFh1
	O6UPGf7ThFpolby6280JOSC9t6uz0AgzgYWdaOD/TZa690uXmJa20t8oKL5fqjkfOHvlyWVNX6K
	28c4WZnSBTtWWiMVSl/e8hQ+YeWbzpwkpKtoKWgtaSWqWa+c7KSMZ7KP1B/T0gKtlwjfQQ==
X-Received: by 2002:a17:90b:1a90:b0:3b0:9941:8d42 with SMTP id 98e67ed59e1d1-3b41c92a1c0mr5014603a91.33.1795250160405;
        Sat, 21 Nov 2026 00:36:00 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:2f43:ed99:516b:8dcd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c42b1sm24237865ad.17.2026.11.21.00.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 00:35:59 -0800 (PST)
Date: Sat, 21 Nov 2026 17:35:54 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Hongfeng Chen <hongfengchen@xiaomi.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Barry Song <baohua@kernel.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
	Minchan Kim <minchan@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Yosry Ahmed <yosry@kernel.org>, 
	Wenchao Hao <haowenchao@xiaomi.com>, Wenchao Hao <haowenchao22@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, chenhongfeng0212@gmail.com
Subject: Re: [RFC PATCH v4 2/2] zram: keep the hot statistics per cpu
Message-ID: <awFXOyeELHgLfy_D@google.com>
References: <20261016120927.3191690-1-hongfengchen@xiaomi.com>
 <20261017031542.3504947-1-hongfengchen@xiaomi.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017031542.3504947-1-hongfengchen@xiaomi.com>

Once again, recovered from the SPAM folder.  Sorry for the delay.

On (26/10/17 11:15), Hongfeng Chen wrote:
[..]
> +#define zram_pcpu_add(zram_dev, field, val)					\
> +do {									\
> +	struct zram *__zram = (zram_dev);				\
> +	struct zram_pcpu_stats *__stats;				\
> +									\
> +	__stats = get_cpu_ptr(__zram->pcpu_stats);			\
> +	u64_stats_update_begin(&__stats->syncp);			\
> +	WRITE_ONCE(__stats->field, __stats->field + (val));		\
> +	u64_stats_update_end(&__stats->syncp);			\
> +	put_cpu_ptr(__zram->pcpu_stats);				\
> +} while (0)
> +
> +static void zram_pcpu_sum(struct zram *zram, struct zram_stats_sum *sum)
> +{
> +	int cpu;
> +
> +	memset(sum, 0, sizeof(*sum));
> +
> +	for_each_possible_cpu(cpu) {
> +		struct zram_pcpu_stats *stats;
> +		unsigned int start;
> +		s64 pages, bytes, same, huge;
> +		u64 notify;
> +
> +		stats = per_cpu_ptr(zram->pcpu_stats, cpu);
> +		do {
> +			start = u64_stats_fetch_begin(&stats->syncp);
> +			pages = READ_ONCE(stats->pages_stored);
> +			bytes = READ_ONCE(stats->compr_data_size);
> +			same = READ_ONCE(stats->same_pages);
> +			huge = READ_ONCE(stats->huge_pages);
> +			notify = READ_ONCE(stats->notify_free);
> +		} while (u64_stats_fetch_retry(&stats->syncp, start));
> +
> +		sum->pages_stored += pages;
> +		sum->compr_data_size += bytes;
> +		sum->same_pages += same;
> +		sum->huge_pages += huge;
> +		sum->notify_free += notify;
> +	}
> +}
> +
>  #ifdef CONFIG_ZRAM_WRITEBACK
>  #define INVALID_BDEV_BLOCK		(~0UL)
>  
> @@ -919,6 +969,8 @@ static void zram_account_writeback_submit(struct zram *zram)
>  static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
>  {
>  	unsigned long index = req->pps->index;
> +	struct zram_pcpu_stats *stats;
> +	s64 huge, size;
>  	int err;
>  
>  	err = blk_status_to_errno(req->bio.bi_status);
> @@ -947,9 +999,14 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
>  	}
>  
>  	clear_slot_flag(zram, index, ZRAM_IDLE);
> -	if (test_slot_flag(zram, index, ZRAM_HUGE))
> -		atomic64_dec(&zram->stats.huge_pages);
> -	atomic64_sub(get_slot_size(zram, index), &zram->stats.compr_data_size);
> +	huge = test_slot_flag(zram, index, ZRAM_HUGE) ? -1 : 0;
> +	size = get_slot_size(zram, index);
> +	stats = get_cpu_ptr(zram->pcpu_stats);
> +	u64_stats_update_begin(&stats->syncp);
> +	WRITE_ONCE(stats->huge_pages, stats->huge_pages + huge);
> +	WRITE_ONCE(stats->compr_data_size, stats->compr_data_size - size);
> +	u64_stats_update_end(&stats->syncp);
> +	put_cpu_ptr(zram->pcpu_stats);

Thanks for reminding me that I actually looked into per-CPU stats a while
ago.  And I had much less code, IIRC, let me find and rebase that patch,
these WRITE_ONCE()-s, etc. are hard to maintain.  Let me find my patch.
