Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DBC8831
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732653099; cv=none; b=r+F9PDPrLT2s+78fTvodBgXesTKsyRO7IWnwIiHseXr2pvfbrRQOB9N5O4u8OT1U0dKJELAHSuWi5lzpOkk9VGFfUT8AagSmWl6S9VNKm3pCX3qoEuWuq1KumDqhSYe/AeonPDeUP0jCx1NBoFy71+5KXkbZGLynrLVMxpaGsJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732653099; c=relaxed/simple;
	bh=RqJfej2VcU40gX+TsjpgK/i+oU0hXQGIVgHtzWgfn60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svwgiWq6FljSzq6O9Xgm4syzbPP1Xqd/OUkhhcv2C+oqUReKST6bpYuRdQfhzIpJkAHmUxF9EukxKyZlNt05n3gP1CH/iZwym1JvWX2wpWImDmpko7HmEQMPrAX4Qk2htLM39rW9GfmhtCm6qz4cO3wKyIT5ZO/u35a5pMWI4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMoVxw25; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMoVxw25"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ee354637b4so3819664eaf.3
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 12:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732653097; x=1733257897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gjTHY0fbWwVB9qUJSPvNg/0dgFPa2rgePIKF8vPu1U=;
        b=fMoVxw25X5x5++AXl8wymnGtIUigXOQT27KuvvZHPduKTVuNUu9ytaZZfbwbABhMS5
         K7B2MAzwIygsuiw2jW1RClwKTZTk0NGbCSyBdclzRx5G/ye0yTZWM5KD62GTQFM3SCTz
         QK1o94nOejV7+YnQX2OLRVzBBlDsyii02hWSmZL8N55hZ9ERI8cDZ3E33TSCf2wQpkb4
         BisbuJLN5EDyxDr5pLGUwU9Xh2TifdyKlhBlQP1EnoNQJVgW6IF41nGLC1zh9jB/s9L+
         9KaOkM3AyulrD7wNZ2OAd3E+YAAL8l/6mSsk8tmhH1c5AmvaAkHFDC061VkIWBJqN40S
         47dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732653097; x=1733257897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gjTHY0fbWwVB9qUJSPvNg/0dgFPa2rgePIKF8vPu1U=;
        b=s9JvsYMYzg6r7HBecUfiM5eM0BNGMQ7hHNX2JqC5a/4Eq/vbWYPOOqKC8y52SlRqk8
         vD7EbSXxFhtnoQ+9kXprXteGoP6Aotddwnn7zmFch21EyGYKEFPi/s3b1fZCQ2eHWuTM
         qU/bcBULWDLEVD72apGhNDZvKHoggfxf08qTklFNZNHYIlM5Dyzc/zPcUhINr6/SP9ol
         bomX6dgVhDYWTOS80+xYrmRwMVZMEyIa9pv6YSGGk1WHK3PLe/sat7NxlkCAJ6+VTf1C
         lXDuSW9z7msBrmCrTRu91lXQJByMuKVLtv3OJAwqxmAeTBKzonoCxpFoX9U1D6GO6AJe
         3Xbw==
X-Forwarded-Encrypted: i=1; AJvYcCVTEW3gboSGmCDjvuap/WzPtGMxlO+o1/9lkA0/cF1EVwaR0DvtTwdafzdlJmi3erkl3EKu4OzX/CtIjg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdfjPMio7KwbrWltcSUXwJjQAcb5ZtkOz/gIe9+EaT2nT0neG/
	EYSJ4o9s/RPwxYm1kRajLozlEnUzerKtNg8iC7nt5yECp3uVZ+4sETOYwJe/okE+sIU1DHGsldX
	p0qeEknw0eU9FxAp9j3+zrHbmDxM=
X-Gm-Gg: ASbGnctOvLlpz+Ilc9vRqeC2yWsufooFxGkn9cTEttPAiW1EsVrIb6yH/ZeHz8B4AM3
	0zlwB0mEl1MHMsGYJ3/hMAf0ZO5TzhxLMeAl2KoZwMk+Y730p97M4S59b1438FEpRow==
X-Google-Smtp-Source: AGHT+IHX0xA90/BP+CpxOr92hSLE1ZVzAKd62w1U6QyGxX5avTxepVooRHKRvk5bnySqPf3CpUQ+GdN24c6b6SX1+Bo=
X-Received: by 2002:a05:6358:5289:b0:1ca:9839:5d1e with SMTP id
 e5c5f4694b2df-1cab15f2a96mr123649155d.12.1732653097116; Tue, 26 Nov 2024
 12:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121222521.83458-1-21cnbao@gmail.com> <20241126050917.GC440697@google.com>
 <20241126105258.GE440697@google.com>
In-Reply-To: <20241126105258.GE440697@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 27 Nov 2024 09:31:26 +1300
Message-ID: <CAGsJ_4w5WSpVUr1yybwZsp0QKapzOLW0qU0+_F-8WJnXKK9_pA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/4] mTHP-friendly compression in zsmalloc and zram
 based on multi-pages
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, axboe@kernel.dk, 
	bala.seshasayee@linux.intel.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, kanchana.p.sridhar@intel.com, kasong@tencent.com, 
	linux-block@vger.kernel.org, minchan@kernel.org, nphamcs@gmail.com, 
	ryan.roberts@arm.com, surenb@google.com, terrelln@fb.com, 
	usamaarif642@gmail.com, v-songbaohua@oppo.com, wajdi.k.feghali@intel.com, 
	willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com, 
	yuzhao@google.com, zhengtangquan@oppo.com, zhouchengming@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 11:53=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/11/26 14:09), Sergey Senozhatsky wrote:
> > > swap-out time(ms)       68711              49908
> > > swap-in time(ms)        30687              20685
> > > compression ratio       20.49%             16.9%
>
> I'm also sort of curious if you'd use zstd with pre-trained user
> dictionary [1] (e.g. based on a dump of your swap-file under most
> common workloads) would it give you desired compression ratio
> improvements (on current zram, that does single page compression).
>
> [1] https://github.com/facebook/zstd?tab=3Dreadme-ov-file#the-case-for-sm=
all-data-compression

Not yet, but it might be worth trying. A key difference between servers and
Android phones is that phones have millions of different applications
downloaded from the Google Play Store or other sources. In this case,
would using a dictionary be a feasible approach? Apologies if my question
seems too naive.

On the other hand, the advantage of a pre-trained user dictionary
doesn't outweigh the
benefits of large block compression? Can=E2=80=99t both be used together?

Thanks
Barry
