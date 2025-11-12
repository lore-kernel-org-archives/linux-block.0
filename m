Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBFD1F09B3
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762924689; cv=none; b=JtLSitRuU8w2QJwoDhTgaBbIL6Tf9pjlIv3CfXeBE80J2RhDZDYzmOIAye/NxQc7X0rQzveDoysfYKdbrHSWFz+bSWkxfOJgCooKU0d/L1hLyOxoxxqpX66Gek62iOIbD2jnv5LoOAhN2/dr7BrCbuxKUDT0AAs0fVeQ37YyQtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762924689; c=relaxed/simple;
	bh=N2i7mYhy/wako5FItulAn51gZ+92I+axWJfXi+cvC60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7GWxH5lKyhTPWtJxTlnXvfqadrCFlhxx1XOGBwn8dMEdIDaREGJqEpKXYEMeF3glwhlVrHgLXW1/OfwXOO8myZ0+mf1x0p/xCEZ31CYxzLJEYjJDxZEbkjPA+BIhKItwng1GO3NU9wBpqBqjE04FD17JaCoRrWL1W8vpQROTCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nVEg4d4H; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nVEg4d4H"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297e982506fso5196265ad.2
        for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 21:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762924687; x=1763529487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kJv5UmqfgHdkO0lr5oB99ha660rGNd0N5LAs+dq++Iw=;
        b=nVEg4d4HFceVmE6td0hEsE1pz6FLQdDsA7zlIePdMeu8XFli/T7Owb0EmJ1tnoUDeE
         3PIT+yiFk9ZfTQlm4d9hfwnkPPNcHi4PfQ/t170txOTcL484VoqPv47gSe/dc2EztecI
         1LeIbBUB1qt2O2gDEx0pqsC3jp/Dv1XUhQX8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762924687; x=1763529487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJv5UmqfgHdkO0lr5oB99ha660rGNd0N5LAs+dq++Iw=;
        b=Erf1lhVngA1YIPXpst8z246n/Im4SCA/jus4L9nlwKbyXuNDXA2IEq2tjpfWmDafal
         YfQ7lF9FyvRsVN6+omx9PBvrVKH5QYlbjP9TOVZpLOuRMYZ6e6VnNzU+LoEJm5ltJFHj
         N5fc9f+AcsY7KRk5fg92OzBd+bNSWcMNX6TB6NNSniiBnkRRyosKJUzcHDnt/zj9apNr
         EYt3HHLfyNDu+TNd5zxeCWhURELGv+kU+LOQegXlDL/Rbs+hlwgJK9omMFBYAgVvZ0bY
         J1PWBujL/Cc5fC2EJuTyOw2p5STjxj2KxAcJNZyeIGGbMmj0aquvMhM1xMK1/yhz5/aB
         ZEjA==
X-Forwarded-Encrypted: i=1; AJvYcCXF4V/B27W8uw1GibiAmyQT19aMhbIKUbV60e7iFJOuifAAaSwQv06bKrBknKh9mwiWHeIqEp7d4Wdzgg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv/E6asFCtxESYI6V5jWRMdhJ1TiKI13Jigp9pYdj/MIdHjIeG
	yq/1HB2FdnGpasUqzuRdQ0TVubGtYp5amlcvckVjNfXWdiTNu732xemFrDaIQLGuHA==
X-Gm-Gg: ASbGnctirwvyUnO8vXu+Rx+Zfg/HZWoWZApcCPAwLkct0ezRypPGnLrERr8t7NFHaV8
	EVuyyysOsQu7ff5aY+h9ImBggqYWKvmvHDpgSs9PqRmfje4RRsb0QpymyPbbRt0+Da1t93boPCR
	m1w69COp4aH/gYfR7lCvDphDqJxWvJFl0iUw9f3jUkqkcHnAYldR2HG7r7dsvcvivjzEYBr0zgo
	SLHX9g/N1Lxd4l950O2xj6fYMaZh2IgrPId5RDAACjm7T3awaVvJlCpfx7h6wA+Xb0gZ7MdHlcF
	x5rPL06HWah1RhdxjNSI/Yd3BjA3zVKGEvKvuKjDtuS0dvw9pwpmXKcWa9+Ju3T01sELIPRqTKn
	DqwPr3U37N4uOfdfJcqjsMOXBVNpfczauNmJIcW6I09uJPJX4c5dZcyrHld6HREOhF5+Kn8y+Ew
	6UTWaH0aIrcYvWiQA=
X-Google-Smtp-Source: AGHT+IGbKMmfp62moQ55XqRXlYknpv7VsvU1R/1ooo2QU9Rce7Cy8tcLuOmjURe+U+W+1KDGa9Khaw==
X-Received: by 2002:a17:902:e5d0:b0:295:1aa7:edbe with SMTP id d9443c01a7336-2984ee021demr25227455ad.41.1762924686858;
        Tue, 11 Nov 2025 21:18:06 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2495:f9c3:243d:2a7e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf550bsm15774345ad.33.2025.11.11.21.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 21:18:06 -0800 (PST)
Date: Wed, 12 Nov 2025 14:18:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, richardycc@google.com, 
	senozhatsky@chromium.org
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <htycvrcqbnkk7ldhpaqxesy7uhz3lssymwqm7nzkhyhnid3krm@mfju626njxvb>
References: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
 <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>

On (25/11/06 09:49), Yuwen Chen wrote:
[..]
> +	blk_start_plug(&plug);
> +	while ((req->pps = select_pp_slot(ctl))) {
>  		spin_lock(&zram->wb_limit_lock);
>  		if (zram->wb_limit_enable && !zram->bd_wb_limit) {
>  			spin_unlock(&zram->wb_limit_lock);
> @@ -774,15 +884,15 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
>  		}
>  		spin_unlock(&zram->wb_limit_lock);
>  
> -		if (!blk_idx) {
> -			blk_idx = alloc_block_bdev(zram);
> -			if (!blk_idx) {
> +		if (!req->blk_idx) {
> +			req->blk_idx = alloc_block_bdev(zram);
> +			if (!req->blk_idx) {
>  				ret = -ENOSPC;
>  				break;
>  			}
>  		}
>  
> -		index = pps->index;
> +		index = req->pps->index;
>  		zram_slot_lock(zram, index);
>  		/*
>  		 * scan_slots() sets ZRAM_PP_SLOT and relases slot lock, so
> @@ -792,22 +902,32 @@ static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
>  		 */
>  		if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
>  			goto next;
> -		if (zram_read_from_zspool(zram, page, index))
> +		if (zram_read_from_zspool(zram, req->page, index))
>  			goto next;
>  		zram_slot_unlock(zram, index);
>  
> -		bio_init(&bio, zram->bdev, &bio_vec, 1,
> +		bio_init(&req->bio, zram->bdev, &req->bio_vec, 1,
>  			 REQ_OP_WRITE | REQ_SYNC);
> -		bio.bi_iter.bi_sector = blk_idx * (PAGE_SIZE >> 9);
> -		__bio_add_page(&bio, page, PAGE_SIZE, 0);
> -
> -		/*
> -		 * XXX: A single page IO would be inefficient for write
> -		 * but it would be not bad as starter.
> -		 */
> -		err = submit_bio_wait(&bio);
> +		req->bio.bi_iter.bi_sector = req->blk_idx * (PAGE_SIZE >> 9);
> +		req->bio.bi_end_io = zram_writeback_endio;
> +		req->bio.bi_private = req;
> +		__bio_add_page(&req->bio, req->page, PAGE_SIZE, 0);
> +
> +		list_del_init(&req->pps->entry);
> +		submit_bio(&req->bio);
> +
> +		do {
> +			req = zram_writeback_next_request(req_pool, req_pool_cnt, &cnt_off);
> +			if (!req) {
> +				blk_finish_plug(&plug);
> +				wait_for_completion_io(&done);
> +				blk_start_plug(&plug);
> +			}
> +		} while (!req);

Why do you do this do-while loop here?
