Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5E53CE49B
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647400; cv=none; b=hO9sfELoYtuk4gTQ9OpIouJLwDjATJq66VEh1aed0DUTv5D0UKmxTHhPACwQltEI5r3UFF+ojQexh7KlX2YI0XQ3STZOKjg6KbMdIPkfUkoBMw0cxdEUkL91vuKa1UtAP2yQ/Cn192nbCixJ2pnFtCJTJC32yOp6DLB5pzm0Vg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647400; c=relaxed/simple;
	bh=b3z2Q6w2vfKhXsc40dBWP44/TifLR8eOYPiKu5rSkjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFU4hHdTNWveeHy8Eqc7ZKsf5TS0oyGaVaRqZZTnE74Dyr7RtN9yUzdaG6TkqjVSeaAMxrZrswFwlVd9fzW0yTINngy13nW5lnERzkYimsSxx7aFU1MrOxKfUUwK1mN+3+TB6F4i2Lk2MFl8o63ORYJFu3CTVzGbiGPhg5KQCpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVAzsvot; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVAzsvot"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d596a96475so4201235a34.3
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 10:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772647398; x=1773252198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s081Yqcw4FMldRcUhZ32fBADnqVG0rTSkc+UZ7N5S5M=;
        b=XVAzsvotUfvQOZn3lxZRpH1uFmYnkjKjKZBwn66eMnCZ26Ie9zEYnkMUgIv7IJQ1bD
         cE5T/wI5RtK5teDTi8AkYWjoD5wdMrZOMrgiFmoHrR1u3/gDYy9us7JKH8/V6dMNut5t
         s0bFX016WUn0UU2kXSUt4sn9Oeor+VHkan6Rt7mNTNAyFPKYPxq/NNacAuhwuWNFDeLR
         OVHcXUoTDWmF7+UHgelIT1dDXJzFsdxGU176qMaJxfUQCNpE0Pbn4TYGevG3UX78cTiU
         TZtqMug8psnp3Ka9zON9tCnqkeQo5K5cv1xM/GuG60zrxRzZVpvZvGfpe+0NAGfK+5RN
         tewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772647398; x=1773252198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s081Yqcw4FMldRcUhZ32fBADnqVG0rTSkc+UZ7N5S5M=;
        b=u1ezlIfciRHFOZGEaN/bdXzVUhvPXZ2/pjpDYbsIWTwwcUvFArk7RSnyB+K2a4b2iy
         MAgk6teICllmvMj9xF7F+ExyQWBkgEwj+AvlJlP9pXUTp4yKEEx95bjdzrmcxQ2xX7tp
         Izw2/0Cx0Lavm7hgMoCk4rEQ+O4xmPff32MkcD7nP7P55yRiCE8BuZB4qfbZ8tjCPjKD
         zWyKbmheeI9f+LhdVJ6+8+siyZqoYR6b3bO1no1Y750xHEmmhWeVXz+/bRfPqv7HM7+H
         AHZ3JDcw1QQhaotaD0LEKIrEqlENayM14y9S31wR/l7DqZZ6pC+p0uVvGDkGM1hbzGZZ
         4BlQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9K068/BPmDc7A4jEgRMJ/33DpBjLR/92WmB5/m9Lendof1jgMuCXwIZAksdMGjBX2z4xjfClndEFiVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUbeaSgdk9we2QMMLQHLXmgApFKcqS9lGa1jJPEgD9MCrscN7W
	uLT9nBUltKijcyJnt/OfUzDCaaQJ5daEivcGERNDrJ/qVNWg3D5yFQL/
X-Gm-Gg: ATEYQzxxawXl/HELehC4anx18SvPwd1g1CAZZJBZkrcW8FakAWywICWLpCQpyuNWNo6
	52VXpkFtLfYUjaMoOtLRcXZiUCElBgXG6RPA943A/BrciFCEN+VDgA1xccDtd5jmilZBoCEG4t1
	Ve9Rjjk5+L61egsKj9ZokPIdo/D3P/MpHoGfQjWx3HuxK0xWrOT+6TW6OafwZNnPAAyCcm2ILpV
	83UaT8ETlff5+WA77A2ZTDX5/McOvGsk2FxNPySj6My4/Lt3kNU4//0u0gwqF5om8n62iqNALN2
	RRPnFvmuoBL4Fkl31C+P/FQZvw9sGZJyDYPaCAr5Qm6T8bWw0nm4Mgh561dCcZozYA+tFrb/k+E
	EFD9GTnsVhWq3lsoJNIE4MXJh/QOpnNQf2iFotsuFDb4Qt9/6rk+cnxEmkEH6BG7sfsugckmnzO
	cOZP8JZqhBiYeyQaIOuSAS
X-Received: by 2002:a05:6830:264e:b0:7cf:dca3:5c6f with SMTP id 46e09a7af769-7d6c7f5e661mr1785549a34.16.1772647398349;
        Wed, 04 Mar 2026 10:03:18 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:c::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58644edfbsm15582806a34.6.2026.03.04.10.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:03:17 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Yosry Ahmed <yosry@kernel.org>
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
Date: Wed,  4 Mar 2026 10:03:16 -0800
Message-ID: <20260304180316.1429892-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAO9r8zP56KdyaQjMp4PK_yS27x35s0p=aHYzT8Ey0f7bkbvNuA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 4 Mar 2026 08:58:44 -0800 Yosry Ahmed <yosry@kernel.org> wrote:

> >  static struct zspage *find_get_zspage(struct size_class *class)
> > @@ -1289,13 +1336,14 @@ static unsigned long obj_malloc(struct zs_pool *pool,
> >   * @size: size of block to allocate
> >   * @gfp: gfp flags when allocating object
> >   * @nid: The preferred node id to allocate new zspage (if needed)
> > + * @objcg: Whether the zspage should track per-object memory charging.
> >   *
> >   * On success, handle to the allocated object is returned,
> >   * otherwise an ERR_PTR().
> >   * Allocation requests with size > ZS_MAX_ALLOC_SIZE will fail.
> >   */
> >  unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp,
> > -                       const int nid)
> > +                       const int nid, bool objcg)
> 
> Instead of passing in a boolean here, what if we make it a pool
> parameter at creation time? I don't foresee I use case where some
> objects are charged and some aren't. This avoids needing to always
> pass objcg=true (for zswap) or objcg=false (for zram), and reduces
> churn. Also, it allows us to add assertions to zs_obj_write() (and
> elsewhere if needed) that an objcg is passed in when the pool should
> be charged.

Hi Yosry,

Thank you for another great idea! Makes sense to me, then I can leave most
of the existing ABI signatures alone and just make the zpool changes.

Thanks a lot again : -)
Joshua

> We can even add a zs_obj_write_objcg() variant that takes in an objcg,
> and keep the current one as-is. Both would internally call a helper
> that takes in an objcg, but that would further minimize churn to zram.
> Not sure if that's worth it though. Sergey, WDYT?
