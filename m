Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED88261B92
	for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761343144; cv=none; b=Gj2nfPlDd7eycGAix/UXoAqMU4nsgYW8IITToL338+aMOvhiXB0noDGpMFWKJATvRw7DrP+U+sLtaPpKUElHnmlrg1875impsyAOQbvkpM/nghzPKNiEodYe0WHm9w58GMtJf55+SyXlCHtw99+lTC1DdNkpXOma91iJI4f19Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761343144; c=relaxed/simple;
	bh=mxdDRl5f6ypVZFwxoiySjpzvSm/XaHmi9pbQ4jbflIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HpWGLds77V9sEyWixuRhS0JHAPlkX9AYEM66lz3k28n2cP3hvhYb2/AyDCVxBA5YDOL/5d55j75oBm/LZOcCCYeJOnoGgD7OOsdqG1vxxKJH45cP0p+hufUhngJFWg+SsNDmrg6XvX3gzuLZmpeEMohaXHenLERw0Z5b+tHiTo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKmn90F3; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKmn90F3"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4e89d2eaca9so15830701cf.1
        for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 14:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761343142; x=1761947942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JSu4wYR7dGj9hekjT0Scgo7oK7p56khXcsyVLerwhg=;
        b=QKmn90F3xbYBk9WfK+osCC7TbkFMGWeGuYB9idqjQJemxKN9IqaeBRdDGM5DhnA8/T
         5fRu4lc7X68u7KXNBHgHx6zWled4MJ5GWQOYMoSihuV2ol8Bo/HN/d+AGkvBGBbSaeZx
         lqapDG/FeFxIOM34ggwhwYRQLOLTqJjmhVCBMp79sIBqjl12hR/EfPDMDjWZutFiJGdR
         BTkuB9X/aX+A8BO4M9YRWfKPqqo2bzcOiZ/2G+dixUD4wZT4+q/PhJSvVvLIveHN3LkL
         9VV0pY4neIJqsNBJB2UZjLj51CUg7LF0bxbJrK3LPqbPc3brCnsirhZAsyJ6u+U1Vs97
         C0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761343142; x=1761947942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JSu4wYR7dGj9hekjT0Scgo7oK7p56khXcsyVLerwhg=;
        b=Od8xbgOecFMI2nHourlZVBuJcSD91j5XzorLUQrNpYXEfLCLRes8xDsplzsnUiVWTj
         2RVAApAUPAx71SFoN6S6qin7guULT+vAbC6D+CIHP9L1hiZWafzXZrr4Zowysfg2t9ee
         k84eH6DY+34IdbcB6yfjbzMOgfftNJCQlFbegU3MGG08/oX1bsGH3lJCAFkQeS+KPfvy
         Eqk42GfQrj3ADI5UmYNWqHto6bNYA2jy+ckaQlg0XWqylOtb3bjt8RTO6y4TKxOJSokI
         SMWuLowmG8fytTZKhjyJj206e/tF1z9NHTgVACLx8999yItKOLnjW4aRY82D0fOCitGt
         gj9w==
X-Forwarded-Encrypted: i=1; AJvYcCW2X7Z78kNo1f/4RNEq3HqJOH6RxMP9VUwBUYnT6qqe/twShYI1LXYPiWrDrryLu/2u9u/yEIGNpBxo5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK3xxhGEfi+eJxTVxu038AwLu9RdFfwtFlYk1xoYVD3b8DgmM9
	IlUpdrreM5gGd8IEswExBL8hY51TIHDQ2ljBYXzy9QNUgG78/cskUttE8iwX9j/Q41lzvfOZnHl
	gprqmTCmNlglnalXpr9iRZjmSSzIhMdM=
X-Gm-Gg: ASbGncvBbKjPZncoI8c3cos648+8HFFmBo3vgvYO/PmVQGCm3+5dTYnA1QAc/TeJm3L
	Sh0NYkllCeKpP9zAfs0AYr8G0+UfVfn8Xldxv5bICaPyComkIQDaeKVIl0vjxASQlCUYvUza3ec
	VH5CMW9M8hgrKSOK/GmKJIjBrQLmzd2+baV7XxIlIC9Ei32VextXlnByQuTQDtBYx4zraiDb63t
	s8aZ4HxYafGJvFCAB2lXZPmcb2yXq5raoZzYe0UIcUZiraaeENDWYxQmP+0FaNEC7k+j4c97MfP
	AjR+hpAucmEjQno=
X-Google-Smtp-Source: AGHT+IEbBcSwdHcN87CM+xJKbvHNa6uFwmLTJi2BasWFhru45dH++MGND3s6/74r0tI8E8W9g7oqhkLME3Y3cb4B/Bg=
X-Received: by 2002:a05:622a:180a:b0:4e8:bbd4:99d8 with SMTP id
 d75a77b69052e-4e8bbd49fd5mr247392271cf.37.1761343142321; Fri, 24 Oct 2025
 14:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926002609.1302233-1-joannelkoong@gmail.com>
 <20250926002609.1302233-8-joannelkoong@gmail.com> <aPqDPjnIaR3EF5Lt@bfoster>
 <CAJnrk1aNrARYRS+_b0v8yckR5bO4vyJkGKZHB2788vLKOY7xPw@mail.gmail.com>
 <CAJnrk1b3bHYhbW9q0r4A0NjnMNEbtCFExosAL_rUoBupr1mO3Q@mail.gmail.com>
 <aPu1ilw6Tq6tKPrf@casper.infradead.org> <CAJnrk1az+8iFnN4+bViR0USRHzQ8OejhQNNgUT+yr+g+X4nFEA@mail.gmail.com>
 <aPvolbqCAr1Tx0Pw@casper.infradead.org>
In-Reply-To: <aPvolbqCAr1Tx0Pw@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 24 Oct 2025 14:58:51 -0700
X-Gm-Features: AS18NWApxbcNiaK6JJ1--DN9zMQLqfqvI7dAP8Den9ypsz9jSVcP9ZxOIt1Gw7w
Message-ID: <CAJnrk1YZoFSMGHRK0M_=ND1RyXPgc6Ts4hh+UMOkrGqO5G884w@mail.gmail.com>
Subject: Re: [PATCH v5 07/14] iomap: track pending read bytes more optimally
To: Matthew Wilcox <willy@infradead.org>
Cc: Brian Foster <bfoster@redhat.com>, brauner@kernel.org, miklos@szeredi.hu, 
	djwong@kernel.org, hch@infradead.org, hsiangkao@linux.alibaba.com, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 1:59=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Fri, Oct 24, 2025 at 12:22:32PM -0700, Joanne Koong wrote:
> > > Feels like more filesystem people should be enabling CONFIG_DEBUG_VM
> > > when testing (excluding performance testing of course; it'll do ugly
> > > things to your performance numbers).
> >
> > Point taken. It looks like there's a bunch of other memory debugging
> > configs as well. Do you recommend enabling all of these when testing?
> > Do you have a particular .config you use for when you run tests?
>
> Our Kconfig is far too ornate.  We could do with a "recommended for
> kernel developers" profile.  Here's what I'm currently using, though I
> know it's changed over time:
>
> CONFIG_X86_DEBUGCTLMSR=3Dy
> CONFIG_PM_DEBUG=3Dy
> CONFIG_PM_SLEEP_DEBUG=3Dy
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> CONFIG_BLK_DEBUG_FS=3Dy
> CONFIG_PNP_DEBUG_MESSAGES=3Dy
> CONFIG_SCSI_DEBUG=3Dm
> CONFIG_EXT4_DEBUG=3Dy
> CONFIG_JFS_DEBUG=3Dy
> CONFIG_XFS_DEBUG=3Dy
> CONFIG_BTRFS_DEBUG=3Dy
> CONFIG_UFS_DEBUG=3Dy
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_DEBUG_MISC=3Dy
> CONFIG_DEBUG_INFO=3Dy
> CONFIG_DEBUG_INFO_DWARF4=3Dy
> CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
> CONFIG_DEBUG_FS=3Dy
> CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
> CONFIG_ARCH_HAS_EARLY_DEBUG=3Dy
> CONFIG_SLUB_DEBUG=3Dy
> CONFIG_ARCH_HAS_DEBUG_WX=3Dy
> CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> CONFIG_SHRINKER_DEBUG=3Dy
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
> CONFIG_DEBUG_VM_IRQSOFF=3Dy
> CONFIG_DEBUG_VM=3Dy
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
> CONFIG_DEBUG_MEMORY_INIT=3Dy
> CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
> CONFIG_DEBUG_RT_MUTEXES=3Dy
> CONFIG_DEBUG_SPINLOCK=3Dy
> CONFIG_DEBUG_MUTEXES=3Dy
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dy
> CONFIG_DEBUG_RWSEMS=3Dy
> CONFIG_DEBUG_LOCK_ALLOC=3Dy
> CONFIG_DEBUG_LIST=3Dy
> CONFIG_X86_DEBUG_FPU=3Dy
> CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy
>
> (output from grep DEBUG .build/.config |grep -v ^#)

Thank you, I'll copy this.
>
