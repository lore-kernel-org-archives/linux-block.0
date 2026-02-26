Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733723A0B20
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772142223; cv=none; b=DDeAuTZIkQsaJ1Ixbxbrk1PtuN7NZJ8w26Omtn0puzg59+ZkQVwfnFUUMS5kfeBCEREaAsVeAy+PvUFdwVTSoNtJWSawaRBFsnMvnsB8mn+2mQ7R3JuWMSoaG3UWXZBACFvYKo17HlRlRHViRi+Z509sETjqcTJpWkx4LssQQWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772142223; c=relaxed/simple;
	bh=PUQtaq9IAwaTopqfCjSiC2emBydBs9LXv6eT5EQWHYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SfEcnvVlWcPbL24BpR5bBRj07EFBoDNlvX8j1cDfmgFMLAjoJVA/5jhd55FjQkh0V9ugrFPSNG3lgg1cIxzYBYxe0eBos7aHwm0BW7P20FfnljZ9iIe9/wpQhZI36lXSYHmgPOQ6z4t2BBNYRU3sf3CPKZHHuebuorRD/5nLoHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beH5+mfx; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beH5+mfx"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d18a9d2b1aso1539863a34.2
        for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 13:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772142220; x=1772747020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YemIJbaT8kVRnq52OlqB85TuhHJUc8NZS4+MR2RkKxw=;
        b=beH5+mfxtZKa5bBDMLl4/u0aSUY5JwWKCQfu/C+2MThiEuMDWJ+kCJQzDPJwEKMbGx
         fMkjr3jJemST9bznnwd58m2+yex4kpDYnEgZWVNR0fVWf7G8dk2WPJYm5sLHEX/HABiL
         GIWJ0hg/xjPJILNonkaKCtarNw5ltShhuBm5khhfwNEcJkwWNW4PCkH+MMyopVJ1/+xO
         TcBL8jyViahD4eVvM/my97MZuipSRrHPYyqZvMakHWMDxxL3ZfPeUaIwa2VYRhXz8Xho
         /A2FlV1MFsuJVlZi8/ikXzA/NM2ZP8JS3BJvZmVgEWwXwclWTcoQThyJutHk4RWKkVDY
         3Y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772142220; x=1772747020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YemIJbaT8kVRnq52OlqB85TuhHJUc8NZS4+MR2RkKxw=;
        b=cX/VoCkP8EJOTFb9Apo7/3NfY6r5Ucg9tSeUIqdYp+sJx8pDtTufr7HXyU4SX4rEUL
         b/1vPUrWzdicrLZn7SIn9tr8OCoxfuwQ7pYVK8D5nzkuJ8IoRzExXX28C0aBa1N+XoFK
         Shur9kqxFutx+B1inuXL3JW6oD2JoWug7o4SAK1LyJYrAoIoz4UjHALgaZTwf4sVp9d6
         pvYwYvjMZErFQ2T234XxI/w8GREPS0FVNFtnUUwzxbsYEXHwebE5EsIYRbu1+KOpB2O3
         vER2kDQebXe7lhTW6QLTTR9z66/jjQaDYPcxcgMMJOJYmi5y9xLc2jD8yqDcO7oDKhOW
         mpgA==
X-Forwarded-Encrypted: i=1; AJvYcCXpsnSJgEa7ZJN7nwYH5daxuM8q82PGFuOFZbQE4sdxPS1CnxhtGHwhLiTKK/BHu1MKviHKgk5LK9hcAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrqnT3QOO6qzeDVF3ME6U26dOB/RJWaR/e9PVdiZfgfiHhHHz3
	xBlAXzfYN0LAPo0hyJypZDqSum2bks4VZ8slPx5YQdW4J78Elvkyh2RX
X-Gm-Gg: ATEYQzzNZL3mZcmh6XhC9l0kRkm7Pzwtir6pGbzgSHMk1ddTxVG0syI+7/8xBHw1G6U
	sbTMKD7FWCrmUThORh6sHe7lbdSEWhHsoEybO/SsLDnERjgfvkwHqloFV2YY2ycuByqxYBbATP5
	DKVUJQsI/qNWOYqPnIOVyXMNNMGYiwUqdlvAMlkUuOVm45fCvbSh4tEU8nRdkjRlcfZIEOVKk2e
	b57h4N8D8Nt/2FqXKhS6kcrKtRD87FrqJI6EKyZBWr26siGAXkD3NPaHNjwEv3sE3byuM0aOJ4i
	pFb3licqLMmj/vYrWqWhDGR9DfTls3p8ySnsvSEpDYBjtdx+HC6SKobCj/4S7ZLGFAuta57dKmj
	+2p+TpriVMu1uHowOmPF6Ta07vC3aqmwcIBHvB/rJc59y44eZK+B5vgPrPFyj22qLcFHxwCv5xR
	EJWcHzAl3g1eKBYAYaEAs+fA==
X-Received: by 2002:a05:6871:8908:b0:415:e487:7f29 with SMTP id 586e51a60fabf-41626ef1464mr483310fac.20.1772142220184;
        Thu, 26 Feb 2026 13:43:40 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:74::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d211b82sm2755448fac.13.2026.02.26.13.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:43:39 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jens Axboe <axboe@kernel.dk>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 3/8] mm/zsmalloc: Introduce objcgs pointer in struct zpdesc
Date: Thu, 26 Feb 2026 13:43:37 -0800
Message-ID: <20260226214338.1062367-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aaC80TsqmKpwFzQf@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Feb 2026 13:37:42 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Thu, Feb 26, 2026 at 11:29:26AM -0800, Joshua Hahn wrote:
> > --- a/mm/zpdesc.h
> > +++ b/mm/zpdesc.h
> > @@ -20,10 +20,12 @@
> >   * @zspage:		Points to the zspage this zpdesc is a part of.
> >   * @first_obj_offset:	First object offset in zsmalloc pool.
> >   * @_refcount:		The number of references to this zpdesc.
> > + * @objcgs:		Array of objcgs pointers that the stored objs
> > + *			belong to. Overlayed on top of page->memcg_data, and
> > + *			will always have first bit set if it is a valid pointer.
> >   *
> >   * This struct overlays struct page for now. Do not modify without a good
> > - * understanding of the issues. In particular, do not expand into the overlap
> > - * with memcg_data.
> > + * understanding of the issues.
> >   *
> >   * Page flags used:
> >   * * PG_private identifies the first component page.
> > @@ -47,6 +49,9 @@ struct zpdesc {
> >  	 */
> >  	unsigned int first_obj_offset;
> >  	atomic_t _refcount;
> > +#ifdef CONFIG_MEMCG
> > +	unsigned long objcgs;

Hello Shakeel, I hope you're doing well!

> Why not just strore struct obj_cgroup ** instead of unsigned long? You will not
> need to do conversions when storing or accessing.

Yeah, that makes sense to me : -)
I guess if we're going to be accessing it with the zpdesc_objcgs and
zpdesc_set_objcgs helpers anyways, we can abstract away the casting to
unsigned long and re-casting to obj_cgroup pointer away from the user.

I was just trying to skip one cast, but I think it won't matter too much
anyways since it's always hidden away. I'll change it to obj_cgroup **
in the next version!!

I hope you have a great day : -)
Joshua
