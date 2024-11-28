Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0E91C2DA1
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732827433; cv=none; b=dOQDAtBeSzpmWfyCUL4VZQDUlv23eovBgMu/fQkm455DvKixOfXe+DZuVCtOYK6xbrYYS+je/wQkha0skSI6+TvoxpEL3MT6t3ORuy2qcelsQHwNcmZ99WVrYF3DnU6/PH8QTAnjWFvcZNFY762RlSZsPYv+wAE8X4gEVwjV07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732827433; c=relaxed/simple;
	bh=KgVadPjvtg1+peaxsOAVJ+dcqm+0ZIm90sPuUPW4dqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiNk9VoPWTyGoaAxEdV+b0ihVoeIp2mRcGYJRiuf5cu7HP9wFJTFzOb5BEJ5GAZQydYbgqY6JA4ZJBE4SP5Yh4lvrn9S5CbyUGZQSBWQhmuHtD9s+QfFbsoJRSDvc8QgLOTF/gcJmuIE/LI3Hf6z76jInVfx6MRjXMIzbuAYWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSSfYtJ7; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSSfYtJ7"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4af173cd0e5so389484137.1
        for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 12:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732827430; x=1733432230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xt25J9rLexkRSwtqiTK7ze8wNZwwl3FLbzeYYa27FBc=;
        b=lSSfYtJ7o5gTSZ3OeTslZTooVs/33Guef5EOrM0X/sqNxDNbcUs46NkQQNOHrF7aLl
         mUp8YYJlvFfRaK9Ivy0TrsaPT7XfSiIF9u6dSgT22xL4n5VqXY5JDtk13qMYUIbO+CFZ
         +/XrTJiXDgYO0l4O7QU5jSfKl4CvkTMnOVtt5xAxrnxRGt+Uw/sskEDF5Zzp+XGAUWhN
         Dvja55NEmq5yp3iA6WEhcRvlUwJi5RVHenM0nG+m+GiwWPDcUaynOWdwdGa1ugUJR71O
         RQIq/41XNqQxix1tduiFxsdJgBBW3XAf49ps3PC/xDMOz1S5SqA610tlNCNQiDnZFXRG
         /oHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732827430; x=1733432230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xt25J9rLexkRSwtqiTK7ze8wNZwwl3FLbzeYYa27FBc=;
        b=acQ6Ple1xmhFXcEjaUP4u/jQ99VkiAcEaM6tleSs2hPicedT8GxifxxIxvhy89OiYm
         uJY9UJMrfXZVD+uwEZQxrXVj52DMi1wVNjELsjjSkEvc+51YUQOogls8dRLsM0gXBBvI
         2fADckwle9nsClLYjXdkvR3qK+n8+tpT+esCpLwC/0SzlGMg+sOcH85bZyf/9vqyxYk4
         EQXXPAkLqUN+ExI3dEjP1l9z9kKk/dvq5J3woh3FGjV68bc2jWiVhqFoGzEjouzs5pIw
         EvWpZ46P8q0qhE9uVmIqGN2XRHfW6yJM4AvgQ3aQUd18+pqSsmTg+V1zYIXIJHRnU/4l
         78kg==
X-Forwarded-Encrypted: i=1; AJvYcCUB9Wgka34mijw6ElYKOuPugtbpAsDCSDMt+qkeJyQua2LPk56mscQ3jh6Xmkl20SrJg/bM5P5bX+JTLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQz4RAXXgZQR4FqlmdX3ywBp88frxu/mKQMbeIYk9svjL0m6ky
	HInzFtYr25yRWH7TKkVFoZzTGKNMoTastopcjNztljibT6v1kFaa8VQEoAcf8Dhz0J+7bIPt7Ov
	tjYn0oUAwJ+DaTQZ0aqrgW2zFxSc=
X-Gm-Gg: ASbGncs0JdCp0imZwh8znXdDMzRD+VzzfTUz4YDzJrAUwOZOrqRXWS52wL3NdJyudB2
	OEEkNaPuBzvEzioEHAiROVIEbXGEerpLLEZgL6enGf76akl70juJFbbSL9ZpQrrNgmg==
X-Google-Smtp-Source: AGHT+IEZxsMN4gvwxqUgXwCg2TXiu2HdtGvItisIinKFnidEaJWWOzGqFHgLSy3X0awccxS7eVXYxryL8u7PEmFrQoA=
X-Received: by 2002:a05:6102:6ce:b0:4af:3f27:5732 with SMTP id
 ada2fe7eead31-4af4498cb08mr11500273137.16.1732827430464; Thu, 28 Nov 2024
 12:57:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121222521.83458-1-21cnbao@gmail.com> <20241126050917.GC440697@google.com>
 <20241126105258.GE440697@google.com> <CAGsJ_4w5WSpVUr1yybwZsp0QKapzOLW0qU0+_F-8WJnXKK9_pA@mail.gmail.com>
 <20241127050445.GG440697@google.com>
In-Reply-To: <20241127050445.GG440697@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 29 Nov 2024 09:56:59 +1300
Message-ID: <CAGsJ_4yfCVuUGGGJ_WMwjEGtO5vsoJqf19XsfZUvazDa-=G+=A@mail.gmail.com>
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

On Wed, Nov 27, 2024 at 6:04=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/11/27 09:31), Barry Song wrote:
> > On Tue, Nov 26, 2024 at 11:53=E2=80=AFPM Sergey Senozhatsky
> > <senozhatsky@chromium.org> wrote:
> > >
> > > On (24/11/26 14:09), Sergey Senozhatsky wrote:
> > > > > swap-out time(ms)       68711              49908
> > > > > swap-in time(ms)        30687              20685
> > > > > compression ratio       20.49%             16.9%
> > >
> > > I'm also sort of curious if you'd use zstd with pre-trained user
> > > dictionary [1] (e.g. based on a dump of your swap-file under most
> > > common workloads) would it give you desired compression ratio
> > > improvements (on current zram, that does single page compression).
> > >
> > > [1] https://github.com/facebook/zstd?tab=3Dreadme-ov-file#the-case-fo=
r-small-data-compression
> >
> > Not yet, but it might be worth trying. A key difference between servers=
 and
> > Android phones is that phones have millions of different applications
> > downloaded from the Google Play Store or other sources.
>
> Maybe yes maybe not, I don't know.  It could be that that 99% of users
> use the same 1% apps out of those millions.
>
> > In this case, would using a dictionary be a feasible approach? Apologie=
s
> > if my question seems too naive.
>
> It's a good question, and there is probably only one way to answer
> it - through experiments, it's data dependent, so it's case-by-case.

Sure, we may collect data on the most popular apps (e.g., the top 100) and
train zstd using their anonymous data to identify patterns. We=E2=80=99ll f=
ollow up
with you afterward.

>
> > On the other hand, the advantage of a pre-trained user dictionary
> > doesn't outweigh the benefits of large block compression? Can=E2=80=99t=
 both
> > be used together?
>
> Well, so far the approach has many unmeasured unknowns and corner
> cases, I don't think I personally even understand all of them to begin

I agree we can make an effort to dig deeper and collect more data, analyzin=
g as
many corner cases as possible but many unknowns are a common characteristic
of new things :-)

> with.  Not sure if I have a way to measure and analyze, that mTHP
> swapout seems like a relatively new thing and it also seems that you
> are still fixing some of its issues/shortcomings.

A challenge is determining how to make mTHP fully transparent (e.g.,
not dependent
on sysfs controls for enabling/disabling) across various workloads.
The default policy
may not always be optimal for all workloads.

Despite that, there are certainly benefits we can gain from mTHP
within zsmalloc/zram.

Thanks
Barry
