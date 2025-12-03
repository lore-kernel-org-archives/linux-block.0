Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C79330277D
	for <linux-block@vger.kernel.org>; Wed,  3 Dec 2025 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773592; cv=none; b=JLdrIwW1rpZ/IghwjAWii7YzuBTDFTq6AG8xYhhHlyEXuiHFMv6cxs65L6NDkAdLT+T+yFNdj3cnH9JYMzcTSebtHg+VfDSrLHewilWfGogLq4ybOYYo2ppkOdoBhWJOeQ1iawVBuucVTVCGSTYCIh+sypao4TZw4zXq+2Lkzms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773592; c=relaxed/simple;
	bh=/dlgosCW9GUsslAbHwFPh8Ee01Cg0/05hvo05R32Gnk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cYlGM0MHDcTMlTZCTxAvcibBY9snArUpdkjBv3KY+JowyfvszakmoAPfF3QimIeU3roc9wY5iePgv+HMH7ALWUTlj4L7ZqzAeJczw2OHjlTC7PD08qWzn1fpnvPGFYmOEiyAfZNp0DZgL5wtglpoKUxR6zm563FAkD8TuD+yDTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PNtdXzjf; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PNtdXzjf"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3ec96ee3dabso5410421fac.1
        for <linux-block@vger.kernel.org>; Wed, 03 Dec 2025 06:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764773590; x=1765378390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjBJHqQOm6jTlPHN89r0KExcde4KSSrOjv2M6KzpQRI=;
        b=PNtdXzjfCyBKVmN7/ZIRCt+AnxsDKbJS0E4JqymBNy+zxQE6MUeeQiniJvbSl335eL
         xSolZm9qJOJSmfmBkZentR8G68GQnqHoGfCROh+DDuvVNObCZ68HBwqb6cVEjrJT0/FO
         fHTOsqhBcFPmmzvEU/E8iBQCk+0li9c//hbkdgMnF2Vq34+USeaBZBIqBP9bI1LzG481
         l1JOc37jlNf08rdx/SMvX9qzaHjEqHFks67GimjQmp3BW+m+WBtV9OrAfLi1H49O+0Ax
         S2zXh5MvbJwaIPH5DoumSFVYLJaWCHzIN2qBaeXPUtC5nQAWOIkvwvKq2ItB/phtlbdI
         h3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764773590; x=1765378390;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cjBJHqQOm6jTlPHN89r0KExcde4KSSrOjv2M6KzpQRI=;
        b=iCfSEOkx6AClgCCeo8AcgBclqYJpIRPeWxaq9bRcoFz1tpOifHQmsAoJWTHpr12vte
         GsrccRwdHa+q+QWK8AIxvRmsStwv5dAhtpONI45reYLvjIT5CdC5GPRlBLAFhOZblH9g
         g/2wBTFl8M6mNRRrE2w8JU9qkyAqNcdy0yUyu67RD4FH+YGAHzQO7rr3hp+CQBK45Gum
         PgYbxfILu7hUqec2Vfgj1bLxoiWithRKS2WZGD3khv1216VO+7OM/zgUbkAFS5HrRW+W
         ITgH9tqJFB5/avC1n0HOeWY9GpW4x8zxQ8o+GR/rxGVRTutlyR2ZbFxVDs9QDAK/Ygi+
         03HQ==
X-Gm-Message-State: AOJu0YwNI5H+mblqWdiHgRY27gCxcVUipKqXzkTWgzsODz9n88eyejUi
	SGoLfNaqWKW/+vUJ5hjstyBUzJgYj7cO5BZL+kX2OUgXyX5xJw1uL1qZJeood7L4BBmyKhSQul/
	VVYRqRhY=
X-Gm-Gg: ASbGncvh1N4HkatYA618fSuX+7Qcch6UlzemfGIX2N6AXozm+EwthcEC6RuKivK7eZy
	dR1eRF/AgTsssVGDCGiOnPQZCRxcUaYhY8hXpbRIdnnUqj4U9Bq2Q/7AFkxlpEKL74CRtzAbeBD
	A02ZGjm8YkhMnhQ1CG40RdZt01JybEcAtGuVVZIouy8o+E7yHnhkylbYeVSdJBNSZWr7HGBarsx
	pIRQAN6FlF66OxrFHTWNrvyRbEHrp8Rc64QaPxEcn9OlnQtBSRX0KJFns+cmaecs+Qj3cIlT0CX
	CNsTpazGV+w5Ilv8e6b6g1j464KMyHxiVIYwbm22FAH+nnjLMisQ1/4ghpiT3LIchC5p2clFZDy
	JsphljH3su1qG+UmGMTJOG+b6EW82Q2uldHmQUJ7WAX5LxLL7Lx38SeD47wOPRSRQZDddfhz2YR
	+K3Q==
X-Google-Smtp-Source: AGHT+IEogtBhL6Qh+VZYCTBc7uuSnM6kuDVWVJM6Uz3RoA/fUUhcpYqUvqIXLGoJVvEtdDugBfZuOw==
X-Received: by 2002:a05:6808:c193:b0:450:5af2:2d94 with SMTP id 5614622812f47-4536e5a7be8mr1239027b6e.61.1764773590254;
        Wed, 03 Dec 2025 06:53:10 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933cc55bfsm5953139eaf.9.2025.12.03.06.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 06:53:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: kbusch@kernel.org, hch@lst.de, dlemoal@kernel.org, 
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-block@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
In-Reply-To: <20251203035809.30610-1-ckulkarnilinux@gmail.com>
References: <20251203035809.30610-1-ckulkarnilinux@gmail.com>
Subject: Re: [PATCH V3] blk-mq: add blk_rq_nr_bvec() helper
Message-Id: <176477358912.834078.16047979897477546741.b4-ty@kernel.dk>
Date: Wed, 03 Dec 2025 07:53:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 02 Dec 2025 19:58:09 -0800, Chaitanya Kulkarni wrote:
> Add a new helper function blk_rq_nr_bvec() that returns the number of
> bvecs in a request. This count represents the number of iterations
> rq_for_each_bvec() would perform on a request.
> 
> Drivers need to pre-allocate bvec arrays before iterating through
> a request's bvecs. Currently, they manually count bvecs using
> rq_for_each_bvec() in a loop, which is repetitive. The new helper
> centralizes this logic.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: add blk_rq_nr_bvec() helper
      commit: 2b2414f706263fb65dac62d34865b9d6889e9409

Best regards,
-- 
Jens Axboe



