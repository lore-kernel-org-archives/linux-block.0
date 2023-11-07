Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE62E3E8
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 18:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OBDN7qmB"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [IPv6:2001:41d0:203:375::ae])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718EEB0
	for <linux-block@vger.kernel.org>; Tue,  7 Nov 2023 10:19:19 -0800 (PST)
Message-ID: <c57eb649-c573-4e41-85f4-870d08cf88b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699381155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1SYU5AGliZDMiJuvJsLLE/DfMMqTHAyyyFpsXtmPwzQ=;
	b=OBDN7qmBAfW8hsrK34ClHPpDCEgqpiuozjOBcqXlHM7PEzP7b+lFLs3BUpCAP3AQHIZ4KE
	5G4dcV/X1e+pdm9WLW3kZYWPVdCEeXw566pDFhFqgQXEjz46lo1CotV4EU8X93tzKzA/bd
	aJWSY7HRFDU7Mb5N7/DnoCWH0iua2EM=
Date: Tue, 7 Nov 2023 21:19:11 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vasily Averin <vasily.averin@linux.dev>
Subject: Re: [PATCH] zram: unsafe zram_get_element call in zram_read_page()
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <d10cdf1d-4a67-48df-b389-3a51f60e9431@linux.dev>
 <20231107073911.GB11577@google.com> <20231107104041.GC11577@google.com>
Content-Language: en-US
In-Reply-To: <20231107104041.GC11577@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/7/23 13:40, Sergey Senozhatsky wrote:
> On (23/11/07 16:39), Sergey Senozhatsky wrote:
>> Hmmm,
>> We may want to do more here. Basically, we probably need to re-confirm
>> after read_from_bdev() that the entry at index still has ZRAM_WB set
>> and, if so, that it points to the same blk_idx. IOW, check that it has
>> not been free-ed and re-used under us.
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1364,14 +1364,21 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
>  		ret = zram_read_from_zspool(zram, page, index);
>  		zram_slot_unlock(zram, index);
>  	} else {
> +		unsigned long idx = zram_get_element(zram, index);
>  		/*
>  		 * The slot should be unlocked before reading from the backing
>  		 * device.
>  		 */
>  		zram_slot_unlock(zram, index);
>  
> -		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
> -				     parent);
> +		ret = read_from_bdev(zram, page, idx, parent);
> +		if (ret == 0) {
> +			zram_slot_lock(zram, index);
> +			if (!zram_test_flag(zram, index, ZRAM_WB) ||
> +			    idx != zram_get_element(zram, index))
> +				ret = -EINVAL;
> +			zram_slot_unlock(zram, index);
> +		}

Why overwritten page can not be pushed to WB to the same blk_idx? 
However I'm agree that this is VERY unlikely case, and this check is better than nothing.
 
