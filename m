Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735C2F7D0D
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762383; cv=none; b=tJyH7uQIRa9OLGzt3IDcUQjqlN+QVa6oc20YV7ejNuAK5e1HOfd/O8uAv7ePr1f7yNDUj6NbUFXzKUHn+NrtwlTXitFPR9G6pPXcnPUpln+dQMNakjYLQ8aYUDAFX03S08l0Pi19ajTB/8d2ro8xWfSYJb5HYPdjgDNlaKs1TwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762383; c=relaxed/simple;
	bh=lYs1SRSQ+fBX2ipCQLufZcVFXNvlqqzjxc/IJUuSNGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJq2r/eqzdLE4texr9yqDG2H92RS/K9ZxG21W4kSBTIC6WdqZA+l7EFdJZ/M4MJEAwCpRX7Sd8Qoe0mXFehzKtzw52RKK9pUyRfGoPqO2UmiSMlV0kFcoHetmK0yhxAKc75JUg/yu209ldL1aMkIslLF5Fi7oW0vqcjF5e2cfOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJguyPSg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJguyPSg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752762379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JkH6JWo8mTS5GsMuk57tBxlJcQGpiGIklLHcffCuBDw=;
	b=VJguyPSg+I/Sx5vbh2wgSj4GeDUMXjXvO7+JAgETBy0MK5/137UkZ/3V1jv2ZEaa/cX1U0
	3+++YmPw6ogchGltnngcHbgctD7IseEOo69naqlgNXTJIKRYBr6yRFbocn431+qlK6rFLQ
	xO/f3fGVxg9ueX/xiV5JIRP2bP/iMFU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-jYejEOh3M82eNlltCgi9ow-1; Thu, 17 Jul 2025 10:26:17 -0400
X-MC-Unique: jYejEOh3M82eNlltCgi9ow-1
X-Mimecast-MFC-AGG-ID: jYejEOh3M82eNlltCgi9ow_1752762376
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-32ca160b4bbso3245991fa.1
        for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 07:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762371; x=1753367171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkH6JWo8mTS5GsMuk57tBxlJcQGpiGIklLHcffCuBDw=;
        b=U0pjICkk6bbknpfIn6Z0bQ7SPdmfyeq1MbtuApF/PZJKhQoq75Cm+RELGb/SqIzTSJ
         QWYe3tsxBFahAX7IwaP4bqgjnWK2biBbnCk7/hBQxnJ1I0oVOWDs+Cbc8XIWYgdIWE3c
         wJroJCcKeKOxPUu+wsM/D74GuiCSu6iNHLMbpZM4wrnpysq8nt6Gh8ruRTkdmiX+TUAs
         ppsIaYY3ApF93zWl+FEPj5scZj4qKz6w959yCRSSZDeCPDAb92Z7Eo8weH3Djy2iDzWR
         g8CoFXPFlS3s9nMLJcii4HTflTroQsQTLRsUqSo+Rk01d5ImmraCUzfWvoQ+jubuU/Fp
         mBCw==
X-Forwarded-Encrypted: i=1; AJvYcCX+oOqq8q7BVnYJ/1VHmF565SJi4Y0JcwW1kWFrUzj5rwmcao5+rl3D5wTudn/+Fh1kS87afA9s7wCD2A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw84RNUEWmTOCqlRh0Dd3ayFNJx1gjjFvgZ1+TvLgY5Odni9Mvq
	S/CH4fZSMQhwNEaVp+IMiXT1cOleEO6E3TPNnjKwYQd16IKS/qrueP9xYv8i9tLX0B8HlvfKe6H
	D6dPgpyKw6/bZPLWPZsocOERkY/01VDYuxE30wT58Zvq65rSSFCFiU/kPJOLQNf58d/5m1/A6gJ
	ZTniPyggJOoDj/1xRcJW2vsOaHsjUKxWX+NaEU84OoeQ2JHR0=
X-Gm-Gg: ASbGncvv8zwPKUlE7WwvTODWoeEIlYnTXgR1lTiGIwAkLVderEwLP+uo4KmA8o78M1M
	7tYMsBLs7Mw8VB/3u8pjHy7eSmXXT45/B3U5rZeBTMSVodU4+Evg/i72nmDf5+ZwU48NWzwPLqL
	rayA7kSIed6uX1Jrn5t/jD7g==
X-Received: by 2002:a2e:b802:0:b0:32b:75f0:cfb1 with SMTP id 38308e7fff4ca-3309a57811fmr5536681fa.24.1752762370401;
        Thu, 17 Jul 2025 07:26:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlGN+kGw9glV3szRat6ao3EO+niF9BvSVt1f9JcGHmO+KbKbkzodo/5KcUMeS6rQI1lXsA4/OOVCCV+6Ufaks=
X-Received: by 2002:a2e:b802:0:b0:32b:75f0:cfb1 with SMTP id
 38308e7fff4ca-3309a57811fmr5536601fa.24.1752762369851; Thu, 17 Jul 2025
 07:26:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs8oJFvz=daCvjHM5dYCNQH4UXwSySPPU4v-WHce_kZXZA@mail.gmail.com>
 <d52a8216-dd70-4489-a645-55d174bcdd9e@kernel.dk> <08f3f802-e3c3-b851-b4ee-912eade04c6f@huaweicloud.com>
 <aHeBiu9pHZwO95vW@fedora> <99b5326f-7ef6-46d8-a423-95b1b4e7c7fb@linux.ibm.com>
 <aHg9oRFYjSsNvY0_@fedora> <d55c37f0-d21c-48e8-9856-1e3d08d6cde4@linux.ibm.com>
In-Reply-To: <d55c37f0-d21c-48e8-9856-1e3d08d6cde4@linux.ibm.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 17 Jul 2025 22:25:56 +0800
X-Gm-Features: Ac12FXxm95zBIsAwCRMu41Ez8Hu9ym05PUillPXF6BTpO8qgux9SA0GXmACZgYI
Message-ID: <CAHj4cs-hrakSa7ht_yD-CKMX5CVEs=etZWyi75Jvzj75DCxnZQ@mail.gmail.com>
Subject: Re: [bug report] kmemleak issue observed during blktests
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>, 
	Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 10:12=E2=80=AFPM Nilay Shroff <nilay@linux.ibm.com>=
 wrote:
>
>
>
> On 7/17/25 5:32 AM, Ming Lei wrote:
> > On Thu, Jul 17, 2025 at 12:54:31AM +0530, Nilay Shroff wrote:
> >>
> >>
> >> On 7/16/25 4:10 PM, Ming Lei wrote:
> >>> On Wed, Jul 16, 2025 at 03:50:34PM +0800, Yu Kuai wrote:
> >>>> Hi,
> >>>>
> >>>> =E5=9C=A8 2025/07/16 9:54, Jens Axboe =E5=86=99=E9=81=93:
> >>>>> unreferenced object 0xffff8882e7fbb000 (size 2048):
> >>>>>    comm "check", pid 10460, jiffies 4324980514
> >>>>>    hex dump (first 32 bytes):
> >>>>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .............=
...
> >>>>>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  .............=
...
> >>>>>    backtrace (crc c47e6a37):
> >>>>>      __kvmalloc_node_noprof+0x55d/0x7a0
> >>>>>      sbitmap_init_node+0x15a/0x6a0
> >>>>>      kyber_init_hctx+0x316/0xb90
> >>>>>      blk_mq_init_sched+0x416/0x580
> >>>>>      elevator_switch+0x18b/0x630
> >>>>>      elv_update_nr_hw_queues+0x219/0x2c0
> >>>>>      __blk_mq_update_nr_hw_queues+0x36a/0x6f0
> >>>>>      blk_mq_update_nr_hw_queues+0x3a/0x60
> >>>>>      find_fallback+0x510/0x540 [nbd]
> >>>>
> >>>> This is werid, and I check the code that it's impossible
> >>>> blk_mq_update_nr_hw_queues() can be called from find_fallback().
> >>>
> >>> Yes.
> >>>
> >>>> Does kmemleak show wrong backtrace?
> >>>
> >>> I tried to run blktests block/005 over nbd, but can't reproduce this
> >>> kmemleak report after setting up the detector.
> >>
> >> I have analyzed this bug and found the root cause:
> >>
> >> The issue arises while we run nr_hw_queue update,  Specifically, we fi=
rst
> >> reallocate hardware contexts (hctx) via __blk_mq_realloc_hw_ctxs(), an=
d
> >> then later invoke elevator_switch() (assuming q->elevator is not NULL)=
.
> >> The elevator switch code would first exit old elevator (elevator_exit)
> >> and then switch to new elevator. The elevator_exit loops through
> >> each hctx and invokes the elevator=E2=80=99s per-hctx exit method ->ex=
it_hctx(),
> >> which releases resources allocated during ->init_hctx().
> >>
> >> This memleak manifests when we reduce the num of h/w queues - for exam=
ple,
> >> when the initial update sets the number of queues to X, and a later up=
date
> >> reduces it to Y, where Y < X. In this case, we'd loose the access to o=
ld
> >> hctxs while we get to elevator exit code because __blk_mq_realloc_hw_c=
txs
> >> would have already released the old hctxs. As we don't now have any re=
ference
> >> left to the old hctxs, we don't have any way to free the scheduler res=
ources
> >> (which are allocate in ->init_hctx()) and kmemleak complains about it.
> >>
> >> Regarding reproduction, I was also not able to recreate it using block=
/005
> >> but then I wrote a script using null-blk driver which updates nr_hw_qu=
eue
> >> from X to Y (where Y < X) and I encountered this memleak. So this is n=
ot
> >> an issue with nbd driver.
> >>
> >> I've implemented a potential fix for the above issue and I'm unit
> >> testing it now. I will post a formal patch in some time.
> >
> > Great!
> >
> > Looks it is introduced in commit 596dce110b7d ("block: simplify elevato=
r reattachment
> > for updating nr_hw_queues"), but easy to cause panic with that patchset=
.
> >
> Yeah correct.
>
> > One simple fix is to restore to original two-stage elevator switch, mea=
ntime saving
> > elevator name in xarray for not adding boilerplate code back.
>
> Agreed, I did implement the same and the fix is on its way...
>
> Thanks,
> --Nilay
>

Hi Nilay

How about update the patch with the below trace which doesn't have nbd info=
:

unreferenced object 0xffff8881b82f7400 (size 512):
  comm "check", pid 68454, jiffies 4310588881
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 5bac8b34):
    __kvmalloc_node_noprof+0x55d/0x7a0
    sbitmap_init_node+0x15a/0x6a0
    kyber_init_hctx+0x316/0xb90
    blk_mq_init_sched+0x419/0x580
    elevator_switch+0x18b/0x630
    elv_update_nr_hw_queues+0x219/0x2c0
    __blk_mq_update_nr_hw_queues+0x36a/0x6f0
    blk_mq_update_nr_hw_queues+0x3a/0x60
    0xffffffffc09ceb80
    0xffffffffc09d7e0b
    configfs_write_iter+0x2b1/0x470
    vfs_write+0x527/0xe70
    ksys_write+0xff/0x200
    do_syscall_64+0x98/0x3c0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8881b82f6000 (size 512):
  comm "check", pid 68454, jiffies 4310588881
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 5bac8b34):
    __kvmalloc_node_noprof+0x55d/0x7a0
    sbitmap_init_node+0x15a/0x6a0
    kyber_init_hctx+0x316/0xb90
    blk_mq_init_sched+0x419/0x580
    elevator_switch+0x18b/0x630
    elv_update_nr_hw_queues+0x219/0x2c0
    __blk_mq_update_nr_hw_queues+0x36a/0x6f0
    blk_mq_update_nr_hw_queues+0x3a/0x60
    0xffffffffc09ceb80
    0xffffffffc09d7e0b
    configfs_write_iter+0x2b1/0x470
    vfs_write+0x527/0xe70
    ksys_write+0xff/0x200
    do_syscall_64+0x98/0x3c0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
unreferenced object 0xffff8881b82f5800 (size 512):
  comm "check", pid 68454, jiffies 4310588881
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 5bac8b34):
    __kvmalloc_node_noprof+0x55d/0x7a0
    sbitmap_init_node+0x15a/0x6a0
    kyber_init_hctx+0x316/0xb90
    blk_mq_init_sched+0x419/0x580
    elevator_switch+0x18b/0x630
    elv_update_nr_hw_queues+0x219/0x2c0
    __blk_mq_update_nr_hw_queues+0x36a/0x6f0
    blk_mq_update_nr_hw_queues+0x3a/0x60
    0xffffffffc09ceb80
    0xffffffffc09d7e0b
    configfs_write_iter+0x2b1/0x470
    vfs_write+0x527/0xe70

    ksys_write+0xff/0x200
    do_syscall_64+0x98/0x3c0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

--
Best Regards,
  Yi Zhang

