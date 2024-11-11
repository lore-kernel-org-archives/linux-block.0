Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F3132103
	for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731353424; cv=none; b=MJP4sTWEqCfmkjScdYeaVn5soGIHf4CiLOq9k+IJCO9bk8zInwBFun0W7ymc2v0PoqA0wV7OTHLUxUC8p4aWwdQjzzJ+tJxX8N0aGs9qCK2QzzXUEALRgrkJU1raMpjMc531ddiDq6Z8ZjGP6FWcR+BKGgbUUcar9IU3mo3yDpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731353424; c=relaxed/simple;
	bh=wR3Hk9QQjczWyoKuejIiyzXitUukvlThDbf2wAfQaSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLpuPiFj2soxpom7nnLDhDlWmI300CeO1bcbUBxj+ZBTyyueteSYc9nkeITo+yHxBK1UA84x4EUfmexPLFE/NrCSni7fC67vvGm7s3Y1KYNzzkg4AfXZqRbL47g8reTdlw7MtmRQ2lV3LIuH2hS3LXXx7ojbR6udDTRlnaGZSLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIfD111c; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIfD111c"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbd550b648so37704116d6.0
        for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 11:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731353422; x=1731958222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIPHrV/grHNzykAgYDbMyU7FEE0Nh6yMI4U0iBFfsPE=;
        b=FIfD111cK1PZfM1zRy6AJ/02k/9v6I0bshLwgFFtJe2z6GRpPXxMaRinTejxgfVa6d
         62uJm5XbrAz+Ph4jzG6sU/7qd9l5HUjenL4OWbxJMEglzGn4F+Gy31XGlGcuvIYi3VDl
         xnXy35tN0Z/HkY0Iiyd2peR6MhVJvtERVoQ+Az0vgi4k9FyeBHZTzobJbc6EnP8oxVMk
         PLadsi5Z7vYV++Jq2ivNAFSzGt3C5Fp44M6Zn9+7t5bDq+I0v4Wi+h6DIx3DoB99cvcc
         md6D2B3Xap7jfuz4c1PTzN9yRwkB4KzshV/ZtlL3XLTOcJDS7SBfQC8d1PoXdEPqlkfF
         xCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731353422; x=1731958222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIPHrV/grHNzykAgYDbMyU7FEE0Nh6yMI4U0iBFfsPE=;
        b=ZvFwvVYwRV1RUyydOEDuZGGOtZ7dYN3LcgJTx9IBr0osARyX4+51QtD8Jk09bjHog+
         CmWT8umsKINHL0HuUnctYlQa3TyF1WXaOUZTrPOo68/tWZaBiZVFzHCX7MaPuJpnxgPo
         mMKMoq4R99vuM5WrOOxoGa3WyOnV3uV/W8FDnexZbtA6GxMRK5+e+aUgl3FVp95X81VI
         gD2e0nkZbL5NoozqEuOqQvJ19EEfXbNrSpGEUXRw8Az45xlm3tZxhD+I5QTCNA88m2c/
         CEtiszRhgw09SU5XAmRWn+ZxegBeiTJrM1eklYZDHT0++TS6RBu2STjwInqTQNJQiz4g
         ww6g==
X-Forwarded-Encrypted: i=1; AJvYcCVydelbaK0VX8+KR7+2JsELXeEKeXoWCeWGyUAQ/VSdocoC/hO6oZxABYJjFE+aGGSG54S1e+e747AkPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZyv+jUQnZD0Ejgd5Q78XgyJlDwxtfHMDSdzH+ayqJ6gA3pqmW
	nVlLmv/83Chkd9CYeeLkQWkLpCsOEoodJspUz2ZAEV/m4f7I51C0M8sdKvrs5fCxXKPA2Tncy//
	aqy6v+q6a7C3K3A88uUvX/zIYiwY=
X-Google-Smtp-Source: AGHT+IF6H9uKWdhSy8hQxrLtR0220qSD5a3V16tGcZsPlk9aBUmDO2c6eRw/heN4g6WrIQ9pWxnJFDgg+cq2/NYL8dA=
X-Received: by 2002:a05:6214:3202:b0:6d3:6542:8496 with SMTP id
 6a1803df08f44-6d39e107d0fmr213458966d6.10.1731353421996; Mon, 11 Nov 2024
 11:30:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107101005.69121-1-21cnbao@gmail.com>
In-Reply-To: <20241107101005.69121-1-21cnbao@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 11 Nov 2024 11:30:10 -0800
Message-ID: <CAKEwX=OAE9r_VH38c3M0ekmBYWb5qKS-LPiBFBqToaJwEg3hJw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/2] mTHP-friendly compression in zsmalloc and zram
 based on multi-pages
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, axboe@kernel.dk, 
	bala.seshasayee@linux.intel.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, kanchana.p.sridhar@intel.com, kasong@tencent.com, 
	linux-block@vger.kernel.org, minchan@kernel.org, senozhatsky@chromium.org, 
	surenb@google.com, terrelln@fb.com, v-songbaohua@oppo.com, 
	wajdi.k.feghali@intel.com, willy@infradead.org, ying.huang@intel.com, 
	yosryahmed@google.com, yuzhao@google.com, zhengtangquan@oppo.com, 
	zhouchengming@bytedance.com, usamaarif642@gmail.com, ryan.roberts@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 2:10=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrote=
:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> When large folios are compressed at a larger granularity, we observe
> a notable reduction in CPU usage and a significant improvement in
> compression ratios.
>
> mTHP's ability to be swapped out without splitting and swapped back in
> as a whole allows compression and decompression at larger granularities.
>
> This patchset enhances zsmalloc and zram by adding support for dividing
> large folios into multi-page blocks, typically configured with a
> 2-order granularity. Without this patchset, a large folio is always
> divided into `nr_pages` 4KiB blocks.
>
> The granularity can be set using the `ZSMALLOC_MULTI_PAGES_ORDER`
> setting, where the default of 2 allows all anonymous THP to benefit.
>
> Examples include:
> * A 16KiB large folio will be compressed and stored as a single 16KiB
>   block.
> * A 64KiB large folio will be compressed and stored as four 16KiB
>   blocks.
>
> For example, swapping out and swapping in 100MiB of typical anonymous
> data 100 times (with 16KB mTHP enabled) using zstd yields the following
> results:
>
>                         w/o patches        w/ patches
> swap-out time(ms)       68711              49908
> swap-in time(ms)        30687              20685
> compression ratio       20.49%             16.9%

The data looks very promising :) My understanding is it also results
in memory saving as well right? Since zstd operates better on bigger
inputs.

Is there any end-to-end benchmarking? My intuition is that this patch
series overall will improve the situations, assuming we don't fallback
to individual zero order page swapin too often, but it'd be nice if
there is some data backing this intuition (especially with the
upstream setup, i.e without any private patches). If the fallback
scenario happens frequently, the patch series can make a page fault
more expensive (since we have to decompress the entire chunk, and
discard everything but the single page being loaded in), so it might
make a difference.

Not super qualified to comment on zram changes otherwise - just a
casual observer to see if we can adopt this for zswap. zswap has the
added complexity of not supporting THP zswap in (until Usama's patch
series lands), and the presence of mixed backing states (due to zswap
writeback), increasing the likelihood of fallback :)
