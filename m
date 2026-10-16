Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F52C17A3
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792120260; cv=none; b=fe/o9aP+Mi9ldR/mBgv5k2bf1M8zgqPd2DOvv4000jX1E35ZZfdEdviA/tUXt4jihP74x/HpeB5CSokkhnl7SgYUnDVUHJW+s/rzFl0dwA5Jbmc6V6uRxoDOfOKHzqeaOa22Vf42U0i5MkRAgHd8DEPN67O67jiy3eQm4qWwuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792120260; c=relaxed/simple;
	bh=im7pIHmLGu2JTSMAFlfXE1tyYmgalGp9vfdBetRxTCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uijXOUk73kqf6t0vuFn77rj+FBQDZeuH4G2aM0RuoirB6TlrRBVQRY5qkl5cQoQpAexnTQrdaUPYdWjfBrHZdABCa0GCVQihFcWtQDLpirC02660kxTQpl2GpAfEbLFrouMOvYb9OybKRDGa0O7ghrBlHajXy6zldHxzLVav90s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cu+pJStA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cu+pJStA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E32F1F000C7
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 03:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792120259;
	bh=1fiKC2aTmvE0OeIcVC/v1BvJFGUG2CBHWahegQLQaL0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Cu+pJStAFWrWfCf4ssC/P2a0EtKOC4/+S3a0tNA5nXaYOvxLTt9v4plEc6J+6qwW5
	 iVq7RyouyPT8s/NXzp9pibDhmdN0xBD0XaLf2rJxEm8T6xppg39/+QeYjqSpw0261b
	 5SyTnHtWEt13zgvscJV8LhCloJiMaRcUM6HZ3eDyvWbgSTCQv3zDXrf7ZBfEt8QjGS
	 uc/7J/a0v15TZmnedQZBIxj775TpTERTQRX5CdMdHuEThaQicyqbrbDP5JrD3m25zc
	 v+MAdgZzItFdZLnKNoKvc4/VS+mbjLKBMmFFyKjGqg6kN0M8jctvfxNk7Xz5VGjFOF
	 SxUldGBydgiZw==
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93e706a6ba9so756522285a.2
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 20:10:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBycMKCxo+KReYZzfQbvl2TJxZuT5VytQcJuzeDILWKys2f1mGKJGP3fWBsD4qRkhWAgHi85i+Faa4X6UA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJHEcLtZUou/QBOqvcwgdWMJPwk2XbS1qaLOJ5n8rsB/umdiHtF
	07ZXNJh/slh9djwDYt2IRGH2EliaKsfpEh4rAsHiNN85QeMbmAXwesONe16iIzM2pAicWAOcVHR
	LxQLHxEQBS0SxjRP5vUX+5yJZKrUlooA=
X-Received: by 2002:a05:620a:6606:b0:93e:bcbf:4ad with SMTP id
 af79cd13be357-93ebd24d7acmr3486164085a.33.1792120258517; Thu, 15 Oct 2026
 20:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <atBh9xfpOji_A7A_@google.com> <20261015112440.1491168-1-zhangbo56@xiaomi.com>
 <atGPwJL6XzlRaMva@google.com>
In-Reply-To: <atGPwJL6XzlRaMva@google.com>
From: Barry Song <baohua@kernel.org>
Date: Fri, 16 Oct 2026 11:10:46 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4weqqSGH2JCh5EThtU8N3e96kRnhLtd9Fotia1t+7YqxQ@mail.gmail.com>
X-Gm-Features: AclHuK8Cdg4eD67RhRhItOTBH5o8vU5ld-ttYECyihZqBeuSHj7hg8nJiSsejkE
Message-ID: <CAGsJ_4weqqSGH2JCh5EThtU8N3e96kRnhLtd9Fotia1t+7YqxQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] zram: use rw_semaphore for decompression streams
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Bo Zhang <zhangbo0325@gmail.com>, akpm@linux-foundation.org, bgeffon@google.com, 
	minchan@kernel.org, richardycc@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 10:51=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/10/15 19:24), Bo Zhang wrote:
> > On Thu, 15 Oct 2026 12:19:49 +0900 Sergey Senozhatsky <senozhatsky@chro=
mium.org> wrote:
> > > Or perhaps we can avoid vm_map/unmap.  A slightly different approach.
> > > kmalloc on fast path + memcpy (zsmalloc objects are strictly less tha=
n
> > > PAGE_SIZE bytes)
> >
> > I applied the kmalloc+memcpy variant on-device and re-ran the same
> > Android A/B. It removes the exclusive path entirely in our workload.
> >
> >                       9+10       9+10 + kmalloc fastpath
> >   read contended      ~1,959     0
> >   read wait_ns total  ~12 s      0
> >   read wait_ns max    72-96 ms   0
> >   shared              76.7%      100%
> >   exclusive           23.3%      0%
> >   dpin_contended      0          0
> >
> > Every decompression now takes the shared (down_read) path, including th=
e
> > cross-page objects that previously had to go exclusive. The ~1,959
> > residual contentions on the exclusive path are gone, and pin contention
> > stays at zero, so the full read side runs concurrently with no stream
> > contention.
> >
> > Read-side contention end to end:
> >
> >                  baseline   9+10      9+10 + kmalloc
> >   read contended 24,749     ~1,959    0
> >   shared         0%         76.7%     100%
>
> Thank you.  I'll include kmalloc patch to v4 of the series.

Hi Sergey, Bo,

I assume when Sergey sent v4, could tag for the patchset with

Tested-by: Bo Zhang <zhangbo56@xiaomi.com>

?

also, Bo's data can be put in cover-letter?
