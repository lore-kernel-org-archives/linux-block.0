Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8E2324706
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763019446; cv=none; b=GV7limp7JfAfRgSR1NN2OzZvwc9Iqbgrc2TgssaMZ4OpivhjuOdBvlX1RbtvITDTKeZbypxN/DESbAnnxATmtsutZijFCLSbt11qRoUT8JoEKgYJP5E0CkQ0CimfJ+yNzmf3JS6PJnUsFOJuE8oisoNFnF7Bz+jfaS5VnphXL94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763019446; c=relaxed/simple;
	bh=SE43tPM6fuT3YpB/ury0/cKpZaVCE0iHqiuOTseBi9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlWyEYBAdGbd+qFtE+78SbcyxKEMJyCFqxN0gdeqfYszqv8lkw407P7Ie5UtbkZeH6V1H/oy/I5E6c8rNQEylgzhCshKqQ+mvttWOyOM8njlAjN1SXBYY8Dcg2BXUnZWL6CNk5NnltllRGNo77+XpCetwuyrj9sBelSnXndcXWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=joZqsfy7; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="joZqsfy7"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b9f1d0126e6so329485a12.1
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 23:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763019434; x=1763624234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PWnM74uHFaI8W0wt5Su2D27ZxngaddFBBe2OQ2Sl5xM=;
        b=joZqsfy7OPuSX+0FUd3EyvC8SNHoVc+DB4ZP/618DbCD1fhgMtXLpeaWxz1B+K8H9Q
         5ImekPkD4G2XkwucmaGKaqOWp7L9JzrHYDjkno7OfmPNX5Rg6q4mFhlKA11OQ9hTyKCC
         WzvWQR4YK0miYGi09Zb4yO0/O9Op+sWZP+h78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763019434; x=1763624234;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWnM74uHFaI8W0wt5Su2D27ZxngaddFBBe2OQ2Sl5xM=;
        b=DfVssN08QcFKKgE3Y9gFX4yIAOUpPbWzxcyIpMP8rCp4Ytwph1DC5b7/sCu1kQHMNS
         9LyDaMOhwZtCIntV/SJ+lE07pZaClE7Emil181Nq8ryhjhXYgD5PzTNER0ljt4MKLdbS
         ROSW3GgUDhESkMxTvoS3zp+NScBWJAkeScTkh5Gho0nBp41kr9Ev0tUr3DW5kzIpxIHt
         +IwI8NRPcTpSd36tQEVC43fuHaJ6t5nAaTWMLqFbc0DkMDy1htXOBMnVQMyU735b2PQF
         ZQJzSdGip081aVe2ZQoE9MsUWz3dasFjq1s2s5FsUEOGcHOekbLSmCtvyG/9j4BjdS7O
         7Zcg==
X-Forwarded-Encrypted: i=1; AJvYcCXgW3N07RAZL+52NIPyy5fuHhCzBU9cqnL/FAgVBSCQn6SpppcCUDutluNzMC2icW8aF0fr/KZU/jE4eg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnTLfn5Qhm1xE/FKIF4amGvQRrHIbwb+Dg5OlneWn600ZaU7cK
	rLL+Q8ik9Jz2jSq327AUsobVtgW7Pgtyq0HQjaRF+EFIEySdSwWf95knub8jdpDWBQ==
X-Gm-Gg: ASbGncv6ypmulmPKnvO+MWKYhjBAlycwV9G6L+W+LfDfF8/3UsBefF6N5jWvs/2ZaiE
	Jo0P57Vcdl0QHTZ5qM0z2b2RJcEbK1A+TFNLzcecg/bB47tEf6XiTmAJay7x22Qz1eXLOjZn7Hf
	FzTMZdr1GcwV7vlu3ZcM6i81oSOPjzHbAkmVIikoeBX9MIXr1eY1uTbhjSl0COCSO9DC+2vnH8q
	Iso2+YJtra9M/L9p4QEAdYIRDCmsE2sEsoujpS/I7JwNIGpye3ZJZhP3+edib6ygJ2aULNR0dM3
	aR3in4BKSFN6b6nJalDxQC/KpRhlrqCePdNBUuZPkAXiU9oJahkGCrPa/XrXIjXOd4hP/gNdwat
	pFefi8qWwHrZUkWOWCS6B/P5TOE7DKHvFE0Yfw6J4kkwNJ+h++smz6UCN77nrb7/2jngMGL38W+
	TYW9u8
X-Google-Smtp-Source: AGHT+IGcwVOQxenlEIltHqenht6mtl/LZ/PZU7x5t8ckv2TF/Hrj/8ENijWtytzcVZdM9dakholzmw==
X-Received: by 2002:a17:902:e80a:b0:266:57f7:25f5 with SMTP id d9443c01a7336-2985a4ccc61mr30548785ad.7.1763019433726;
        Wed, 12 Nov 2025 23:37:13 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343eac93449sm917504a91.3.2025.11.12.23.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 23:37:13 -0800 (PST)
Date: Thu, 13 Nov 2025 16:37:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, richardycc@google.com, 
	senozhatsky@chromium.org
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <sz4brk7ixwzud4hzcgw65au6eto2y55thcku5ouo7x6ieifvlm@t3svlkcwcjb3>
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
> +static int zram_writeback_complete(struct zram *zram, struct zram_wb_request *req)
> +{
> +	u32 index = 0;
> +	int err;
>  
> -	while ((pps = select_pp_slot(ctl))) {
> +	if (!test_and_clear_bit(ZRAM_WB_REQUEST_COMPLETED, &req->flags))
> +		return 0;
> +
> +	err = blk_status_to_errno(req->bio.bi_status);
> +	if (err)
> +		return err;
> +
> +	index = req->pps->index;
> +	atomic64_inc(&zram->stats.bd_writes);
> +	zram_slot_lock(zram, index);
> +	/*
> +	 * Same as above, we release slot lock during writeback so
> +	 * slot can change under us: slot_free() or slot_free() and
> +	 * reallocation (zram_write_page()). In both cases slot loses
> +	 * ZRAM_PP_SLOT flag. No concurrent post-processing can set
> +	 * ZRAM_PP_SLOT on such slots until current post-processing
> +	 * finishes.
> +	 */
> +	if (!zram_test_flag(zram, index, ZRAM_PP_SLOT))
> +		goto next;
> +
> +	zram_free_page(zram, index);
> +	zram_set_flag(zram, index, ZRAM_WB);
> +	zram_set_handle(zram, index, req->blk_idx);
> +	req->blk_idx = 0;
> +	atomic64_inc(&zram->stats.pages_stored);
> +	spin_lock(&zram->wb_limit_lock);
> +	if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
> +		zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
> +	spin_unlock(&zram->wb_limit_lock);

This should be done before the submission, not after the completion.
Otherwise we can significantly overshoot the wb_limit.  And we simply
need to rollback wb_limit adjustment for failed bio requests.

Will incorporate this into next iteration of the patch.
