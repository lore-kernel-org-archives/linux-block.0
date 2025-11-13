Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645FC2D3226
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762999891; cv=none; b=TyKtr3OFtuyCZS9ULQrV/2v23q+7sCByBdXms0DcJlJ9dzSPiWhp2ZBkiKQ9dJGomB8T3G4cpwysDFgFD7FFlEUwPWlbBMerQFUb7h8rdDkK4Om3dcwtBYUADFdVAO7x97ZnLtruj8wjaH5eiDrEMoM2uQ4K0t7mt2Lj490Rpic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762999891; c=relaxed/simple;
	bh=3fhVR8XK2MV+mdGcI7X+vMsh3HxOqg0SZnyqsx8Nvng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBP0gW7zkl/k/AMgEXtde2sTVk5ij67P/xvmPaqTcElUe4TsJB2SRq82oq5sRnsaK4g1Dw3ploI+0NwmCUfNN5svqKFf7fDZGRIJps/hNaMvdyFP9CQjDowCYjbeW8WQrFez+GEGMsAeMcoYJoaa4QoRhuS/xP+/zZj3UyUSUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Qad+KGMN; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Qad+KGMN"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b8c0c0cdd61so235504a12.2
        for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 18:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1762999880; x=1763604680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u5AcZX+11vgWIemSVjdLJtLigPcT6NnJiEeRxWsbcqg=;
        b=Qad+KGMN/iRtheb6IKcoQ4JY4HBbML6MjF6k3/W04vydSmrlvp4gbyFDHHf7faGDo0
         wjgbYNN0UJ+JASpZ0I9ptfkUr7FifmFX5eu3/hrnfxih656ZgdUAuKJpSoyGXJum0qpG
         Wo1C+bH6e0Teq+EPEg7f/zZUXOilrCuyuErVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762999880; x=1763604680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u5AcZX+11vgWIemSVjdLJtLigPcT6NnJiEeRxWsbcqg=;
        b=RxEE2T0OYfltCiFZRL1tC2bVAp4SGRrWaUv+SYzt3GF658QkA/bv2COMuI/59AVycu
         niaGoteQMqoYwkyQc1UdLXp3uxWEx4Dm2AfB4VZsfJHJGogh14q84KUDaJP05iTnr5az
         hfC1nP5NL4N1q0SVzFc04jOYClti4P1Lpq25oHkqb+3BoJjYvXfI2Da26y8HwbkGlR8U
         ZsyGSSNNvODF4/e4WtoSL+BouZoXSzZ3EbmieGPCzi2DqmRaqi8UpnPpPd/jjzvz2rOR
         UjutYvmTdqxAmFMDoXw6yO/K8BX780X4bQySG00ovsF4AaciOGZPS6NFZibaDFlWNF/f
         eHyg==
X-Forwarded-Encrypted: i=1; AJvYcCXKqQUP+SCyShD6HN8JME0FLHckR4d1y2TRtYO0lAzq3VTTut7UdZxEV8pzbU45S4ruOCd+RmRDRsAtfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQls/nAR3dYV+ck71CMJcEOlDx7+VBJJfcy89hHB5n5XPX61iO
	Y5s3MY2qN4sz4yOEwEni1TLvRr8h3GGePf/lKQ9s+rctP7QBctPe9f96I4IFthzpBw==
X-Gm-Gg: ASbGncsnIbpyj8HsygvHzBWdANPUwZjroWbQ0xM2cN1VdIx97rICJc0/UXVnbnfhug4
	1JlImC2sfcYf3iXQsy8OxugfDoUXW6qad9ef/RSHc3+7fD4O+B8Q6NLf0gD45mlFLe+WGqJn6E8
	GPBiQPUotSerhCVImcfagucihwWoBmrofWUvEOXYZm8/YOd7qOUvYevpBcbnsiFMAzMqMXbofP5
	ZBjm/BQ6TEB57yLUcxoi1AMvoOmltpDYaKrc6x91rbXw8le8BFgShLr+Bl3M12JX+AQ2B8g7nZU
	ozj5W1GApd8RsW/woeuDiKSRo+RGHd3a+/tiRkMyrQcgkUAa9ofQSrcUTOMzIvsqc0VSXT241rl
	SrRz7/DKCZrjug/PLV0P/4ui+6RG0cOPmwkFXZKZ94BiHAEY/jepna4HfNrieUvKhGXkUujV0fd
	BJLn6Z
X-Google-Smtp-Source: AGHT+IGYC/tpzfm6WP035R1JLH5r9YIj4B9ph9aHTGNiXUFgK9mwh2404ZnYi+GMlrhBXOVAxw8iUA==
X-Received: by 2002:a17:903:244a:b0:295:3d5d:fe37 with SMTP id d9443c01a7336-2984eddf6b0mr67014565ad.41.1762999880114;
        Wed, 12 Nov 2025 18:11:20 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2495:f9c3:243d:2a7e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc375eee433sm400380a12.25.2025.11.12.18.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 18:11:19 -0800 (PST)
Date: Thu, 13 Nov 2025 11:11:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, richardycc@google.com, 
	senozhatsky@chromium.org
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <3vua4ekiwivbeulfirygpll2vhkrtjj7ezafolwyxjuujrcelx@iyx2apjk7oay>
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
> +static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
> +{
[..]
> +	struct zram_wb_request req_prealloc[2] = {0};
[..]
> +	/* allocate memory for req_pool */
> +	req_pool = kzalloc(sizeof(*req) * ZRAM_WB_REQ_CNT, GFP_KERNEL);
> +	if (req_pool) {
> +		req_pool_cnt = ZRAM_WB_REQ_CNT;
> +	} else {
> +		req_pool = req_prealloc;
> +		req_pool_cnt = ARRAY_SIZE(req_prealloc);
> +	}

This looks like a preliminary optimization, I'd probably prefer
to not have req_prealloc entirely.
