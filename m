Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2702030A
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752713190; cv=none; b=lFjMeCq+EkdgrCmWSizMh1N3LMWknJYNE/pv6ok6fV+mx1TQxYN7Dvn50frC6k6WrAmW1+M3MErNgpou2hRSUPwXD3hkvwolyarXrqjY7z+QsQMHkjLsnCizs9jZy4FeBYLODxlQLHb/ikhsbR/dXxuykqGEoWX4KGTcmGkaKY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752713190; c=relaxed/simple;
	bh=s1zHhdxOsSay3d0bHXkCNz47UER/biDUczkJcPaSXqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcYPCl2dAyo5EQHyG+Hadc4HIuLbavmYsDtM15VF4vxfRMMs/2PaPCqhCSCrx5YQ0V8GQLVolCQk5gl3s6h2S/lh+XeTrkl1cODtyjqFBoj0j3k4pgxRT44QsfNfyneVV9nGdZXod12aJSal5BuusQBx3NOtkLO8T18UdbJd8Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jHpiCszm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHpiCszm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752713184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bx+znTV4v7eO4ruJ6O95jsMPjGYh9KUVHvLvTAEV6JQ=;
	b=jHpiCszmM8H6evDDgjVOmsaLMAAxDPBzl87ibETGKtDA7JUHVyZfS1eHZPd7aescqMiyvQ
	Wz7dPQ2VFEaE4VYqJxxOjmhOeeRSxeaucK7qs/IPiQjC3fdaurOUyoZ3juePi7PgmYX45g
	uERRy/o0eXXIZrZULMts24jLF9KL0qE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-3cQCpWXsPSach81qwOR1lw-1; Wed, 16 Jul 2025 20:46:23 -0400
X-MC-Unique: 3cQCpWXsPSach81qwOR1lw-1
X-Mimecast-MFC-AGG-ID: 3cQCpWXsPSach81qwOR1lw_1752713182
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5550e237ad0so191091e87.0
        for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 17:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752713178; x=1753317978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bx+znTV4v7eO4ruJ6O95jsMPjGYh9KUVHvLvTAEV6JQ=;
        b=C28NNjddJ7+ypdKO8wQO2QhX9Png3b2ebaoKH2SXs7GZjCZ+Q4PwNE9jk+Dkk41vxK
         ilpWE+oOwpahe19u1tRLcK3lJHdknRYfRglMsKSqxNrNUaEraIwgxgnAQenWl2e9GFxD
         rTjMLb52xvhD/iyg1pUmq5ZYhuGPd+AwKt/BciynxFS/RCtLXDpi+sbnaiomW3EMCeUn
         hIArHtFalisGflHbX59UOaBc3ij5jbOePX+pC2WsMKn39nQI4B58AKHwd5OH5noUA1ZM
         Wf45JaGaiv1GQ5I9tBlZC+KVADeNzJAzdgFvE8Aac56XocDb8tuuxAWT4ydUsj6/yoRU
         cKmA==
X-Forwarded-Encrypted: i=1; AJvYcCUfBEp6dwkWwGrCzQc9QBYRkEsB/U2ddEoXpDpeJSpVi4f1bQnkRYnulH3AIEIay4Qa/d4Fuz/kP88ceQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Nj0uxBvoe+iM14ZcU7So1Y5P58Jg/ZtqPBfLM5ldfF7v8gNQ
	w16axuNRt2vpYQ4tAuX52We37NPupgtcgkSdvWsxON1cv/Idv7ezuq8ajTk1UZa1AdjVYonnt2k
	sOaizmkKmzf7oFs04v0nDA7+JYDVIMUseiCikDZ2lQVxMtwmyDpXveWWEDGJgwGJI0ds7olWgUB
	DRZ4RHvmW5Z2c2VyqPnKnO2KR1oWmue8PP5Yra1oA=
X-Gm-Gg: ASbGncto2WdajkT9Aez/NQmpIMk5Kz/5g1xRDFDSzSE/ux3KozQL4LtsrlIzAuK2Qjt
	UZZNjaERd+t6CTzdnflTVsbl2q2IFWMod1CJCrX09O4chD2F2ztUKeFiERSQW6deOF+npJVuaXl
	JwLCmZ7/EuFvKlTY5QE961gw==
X-Received: by 2002:a05:6512:63c4:10b0:553:ae47:685f with SMTP id 2adb3069b0e04-55a233b1914mr1366963e87.38.1752713178252;
        Wed, 16 Jul 2025 17:46:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH42MZ9KRn5Dd30bJ86EVk9cC89yIaeW/8ambW+jLuZINgiBZl3Y6WO8Uw2Mgg4S/ZTrll3opL3EZyPTfGojaY=
X-Received: by 2002:a05:6512:63c4:10b0:553:ae47:685f with SMTP id
 2adb3069b0e04-55a233b1914mr1366955e87.38.1752713177788; Wed, 16 Jul 2025
 17:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com>
 <d52a8216-dd70-4489-a645-55d174bcdd9e@kernel.dk> <08f3f802-e3c3-b851-b4ee-912eade04c6f@huaweicloud.com>
 <aHeBiu9pHZwO95vW@fedora> <99b5326f-7ef6-46d8-a423-95b1b4e7c7fb@linux.ibm.com>
 <aHg9oRFYjSsNvY0_@fedora>
In-Reply-To: <aHg9oRFYjSsNvY0_@fedora>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 17 Jul 2025 08:46:06 +0800
X-Gm-Features: Ac12FXwSLwTUy5t028h5uNQRiPyl2Bc5aPyr16VvwIshpaUZ5W1qoCOfelmK9a4
Message-ID: <CAHj4cs-WTU0Y2VbgtKL24Wxe+1CGJoPP+je_w=Xg1bu+JizHMA@mail.gmail.com>
Subject: Re: [bug report] kmemleak issue observed during blktests
To: Ming Lei <ming.lei@redhat.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai1@huaweicloud.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 8:02=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Jul 17, 2025 at 12:54:31AM +0530, Nilay Shroff wrote:
> >
> >
> > On 7/16/25 4:10 PM, Ming Lei wrote:
> > > On Wed, Jul 16, 2025 at 03:50:34PM +0800, Yu Kuai wrote:
> > >> Hi,
> > >>
> > >> =E5=9C=A8 2025/07/16 9:54, Jens Axboe =E5=86=99=E9=81=93:
> > >>> unreferenced object 0xffff8882e7fbb000 (size 2048):
> > >>>    comm "check", pid 10460, jiffies 4324980514
> > >>>    hex dump (first 32 bytes):
> > >>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .............=
...
> > >>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .............=
...
> > >>>    backtrace (crc c47e6a37):
> > >>>      __kvmalloc_node_noprof+0x55d/0x7a0
> > >>>      sbitmap_init_node+0x15a/0x6a0
> > >>>      kyber_init_hctx+0x316/0xb90
> > >>>      blk_mq_init_sched+0x416/0x580
> > >>>      elevator_switch+0x18b/0x630
> > >>>      elv_update_nr_hw_queues+0x219/0x2c0
> > >>>      __blk_mq_update_nr_hw_queues+0x36a/0x6f0
> > >>>      blk_mq_update_nr_hw_queues+0x3a/0x60
> > >>>      find_fallback+0x510/0x540 [nbd]
> > >>
> > >> This is werid, and I check the code that it's impossible
> > >> blk_mq_update_nr_hw_queues() can be called from find_fallback().
> > >
> > > Yes.
> > >
> > >> Does kmemleak show wrong backtrace?
> > >
> > > I tried to run blktests block/005 over nbd, but can't reproduce this
> > > kmemleak report after setting up the detector.
> >
> > I have analyzed this bug and found the root cause:
> >
> > The issue arises while we run nr_hw_queue update,  Specifically, we fir=
st
> > reallocate hardware contexts (hctx) via __blk_mq_realloc_hw_ctxs(), and
> > then later invoke elevator_switch() (assuming q->elevator is not NULL).
> > The elevator switch code would first exit old elevator (elevator_exit)
> > and then switch to new elevator. The elevator_exit loops through
> > each hctx and invokes the elevator=E2=80=99s per-hctx exit method ->exi=
t_hctx(),
> > which releases resources allocated during ->init_hctx().
> >
> > This memleak manifests when we reduce the num of h/w queues - for examp=
le,
> > when the initial update sets the number of queues to X, and a later upd=
ate
> > reduces it to Y, where Y < X. In this case, we'd loose the access to ol=
d
> > hctxs while we get to elevator exit code because __blk_mq_realloc_hw_ct=
xs
> > would have already released the old hctxs. As we don't now have any ref=
erence
> > left to the old hctxs, we don't have any way to free the scheduler reso=
urces
> > (which are allocate in ->init_hctx()) and kmemleak complains about it.
> >
> > Regarding reproduction, I was also not able to recreate it using block/=
005
> > but then I wrote a script using null-blk driver which updates nr_hw_que=
ue
> > from X to Y (where Y < X) and I encountered this memleak. So this is no=
t
> > an issue with nbd driver.
> >
> > I've implemented a potential fix for the above issue and I'm unit
> > testing it now. I will post a formal patch in some time.
>
> Great!
>
> Looks it is introduced in commit 596dce110b7d ("block: simplify elevator =
reattachment
> for updating nr_hw_queues"), but easy to cause panic with that patchset.
>
> One simple fix is to restore to original two-stage elevator switch, meant=
ime saving
> elevator name in xarray for not adding boilerplate code back.
>
>
> Thanks,
> Ming
>

Sorry for the late response, it takes me some time to find which case
triggered the kmemleak.
It turns out that block/040[1] triggered the kmemleak, and just
running [2] after block/040 can not trigger the kmemleak immediately.
We have to wait for more time.
[1]
[  458.175983] null_blk: disk nullb0 created
[  458.180035] null_blk: module loaded
[  458.397994] run blktests block/040 at 2025-07-16 20:31:20
[  458.571488] null_blk: disk nullb1 created
[  874.620574] kmemleak: 522 new suspected memory leaks (see
/sys/kernel/debug/kmemleak)
[2]
echo scan >/sys/kernel/debug/kmemleak

--=20
Best Regards,
  Yi Zhang

