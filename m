Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10F13213E
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531539; cv=none; b=C5l5VqaUhV5uyHsW586qG1Ghc2e75KUrU3Dmfdb8d9ljA/UHHXMO56iMIDPIGWO+VGtPfki8MSzVocyZOdfbi/Yfb6kCNo78KX2jrCaPFK9XOLm75IqGbgVYlufrOqglK0EhwJezlyg5WAoM/53PI6Ygi0BPt4//WC5DP4tmFXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531539; c=relaxed/simple;
	bh=ufbacyvf+KnKZqgmglTvhNdMgv3BCldhYuwiRTllUcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CK44ssnt7mZPlCohE6O8X99+pP8KtYppJ4K8b3SR5kUFbeNIf0di8xuUkFyGJHEDCJ5aivvy4yiedgBx8VFKR/gjejNFWN2xOGjRgI7IaKUnZULXHry2aglzeHvAZK2IGYg+VVjUbDrhdzJRHOPjBgsDhuYZYbuy8pxik95Ipb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bwqvdAiP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bwqvdAiP"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff62f9b6e4so208094a91.0
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 14:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745531536; x=1746136336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufbacyvf+KnKZqgmglTvhNdMgv3BCldhYuwiRTllUcA=;
        b=bwqvdAiP8wwWcITxDmpuD5+/8sihaV0iImuFMfMOlo3EJTG6joKDKRzmgty20jhrPj
         MWbwBIgWpXYweZm7vK66RGmN+icYnF7FTHv4ZI37+rglEresH+r9HPkCmksJWLf7AJ/K
         fTh5Cs9qKa5LS8wiwFDdyGxBEl+cmNGinLy/dmfwcb0j36oyQeqYOpzOnpuK240qszgZ
         9UgfwzbBf2DrvjAFnDRykL1neQSesDx2Bq/sAJiqJADh+xX2kEofwSCeasJbvoA2ZCJJ
         WgRpK2csbc+tpG4WSMuq03lHJEjaonelP3KT5pxChiXjW+6IfLzGng8WBAbLBetCCx0t
         /LJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745531536; x=1746136336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufbacyvf+KnKZqgmglTvhNdMgv3BCldhYuwiRTllUcA=;
        b=QsM49q32UhtG5JphuOnBCjzGJSXzWc4Trpmu/UAesjXnKEzXl/QWmMpMLKbKUEseM6
         qw7tFG3XmQw7DTRTzS3IHyD4nmGx1qeas0ivnVdqJBneRtsUeqY3w4W01BYH+Ns5zqlj
         PSXfRQ9YdH7kD56kMxoIaCtFBH1+OGsN1bGETa1zaDW3gCRrbXJseM422oxCykNfsn35
         j5O8yV57KW+TFHOwtL/YdMpsHybMAFbsB/MfXISNGB3M2ehL3Y88wCG3NImaMIAqygdd
         DCDHyj8m3Rt8uVH3W7gXEST7FNavNufBsCspjBE9c3CSrT5T6rzN4cXtTlOX54tM0RN1
         OiOw==
X-Forwarded-Encrypted: i=1; AJvYcCVkFI/OKN8NCSGEIeFmn4lIltNh5DiIlxcuWU1/ZNjLxtvX6GZJbCBHghdLr61t6xAfK0258oIyZFB+ug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0SL9kbiQKv3Bw47v63dnGc2dIGOKSUVLPK9dEFCM0zQHzZFJt
	4NJMB+r5+mrt1QDVsz/HkkIIHU5HAKOtBHdrTAcZoEc8KXnKLe8St7MjNs6zXH1yEd2fz8Iut6M
	HySYShGs6rshJWzKTryBOlCp4w9HiAdsk1iCY5g==
X-Gm-Gg: ASbGncs2kPtWjjdyaIBsgZzba49DzLdA59AKl5hjpyLNe7xeZbQ6XXHIXhFIorhRnAg
	/6WpRwBCkgqILfaKpOg1JQkz5GjPebxKVqNwvO4hGi65C4ye7iUJ1d8wbigDN4I443k/ubpgg8q
	x/O0Zd4DmNL7VSg6IFdM2H
X-Google-Smtp-Source: AGHT+IHkjHOtRqZduVHnJZ5JdbVNTgdYDqg517AZF2AailCVGBVTApcsQ+1cOQeuOkBusvA+GAhtcVWNJtZ2iVy60B4=
X-Received: by 2002:a17:90b:1b52:b0:2fe:b45b:e7ec with SMTP id
 98e67ed59e1d1-309f7eb5d77mr34334a91.8.1745531535523; Thu, 24 Apr 2025
 14:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <IA1PR12MB606744884B96E0103570A1E9B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
 <CADUfDZo=uEno=4-3PJAD+_5sLRMaoFvMUGpckbD3tdbhCxTW4A@mail.gmail.com>
 <IA1PR12MB60672D37508D641368D211B8B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
 <CADUfDZqUQ+n5tr=XG+sJWR_q55fzNSzLHvUZXkysOw=c+vfVGg@mail.gmail.com> <5dca544d-5d23-4269-b447-6fbcda5de56e@nvidia.com>
In-Reply-To: <5dca544d-5d23-4269-b447-6fbcda5de56e@nvidia.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 24 Apr 2025 14:52:04 -0700
X-Gm-Features: ATxdqUHPJfGFQjly9sGU2brGWdTUQKBbjENIUNAsfAt51DwgQb5xOeHspnL0XKQ
Message-ID: <CADUfDZr5opUN+-eoMj_0ZUOAJJCGfrR6EFyw0YeaLDh-Omc-vg@mail.gmail.com>
Subject: Re: ublk: RFC fetch_req_multishot
To: Jared Holzman <jholzman@nvidia.com>
Cc: Ofer Oshri <ofer@nvidia.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "ming.lei@redhat.com" <ming.lei@redhat.com>, 
	"axboe@kernel.dk" <axboe@kernel.dk>, Yoav Cohen <yoav@nvidia.com>, Guy Eisenberg <geisenberg@nvidia.com>, 
	Omri Levi <omril@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 2:07=E2=80=AFPM Jared Holzman <jholzman@nvidia.com>=
 wrote:
>
> On 24/04/2025 22:07, Caleb Sander Mateos wrote:
> > On Thu, Apr 24, 2025 at 11:58=E2=80=AFAM Ofer Oshri <ofer@nvidia.com> w=
rote:
> >>
> >>
> >>
> >> ________________________________
> >> From: Caleb Sander Mateos <csander@purestorage.com>
> >> Sent: Thursday, April 24, 2025 9:28 PM
> >> To: Ofer Oshri <ofer@nvidia.com>
> >> Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>; ming.le=
i@redhat.com <ming.lei@redhat.com>; axboe@kernel.dk <axboe@kernel.dk>; Jare=
d Holzman <jholzman@nvidia.com>; Yoav Cohen <yoav@nvidia.com>; Guy Eisenber=
g <geisenberg@nvidia.com>; Omri Levi <omril@nvidia.com>
> >> Subject: Re: ublk: RFC fetch_req_multishot
> >>
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> On Thu, Apr 24, 2025 at 11:19=E2=80=AFAM Ofer Oshri <ofer@nvidia.com> =
wrote:
> >>>
> >>> Hi,
> >>>
> >>> Our code uses a single io_uring per core, which is shared among all b=
lock devices - meaning each block device on a core uses the same io_uring.
> >>>
> >>> Let=E2=80=99s say the size of the io_uring is N. Each block device su=
bmits M UBLK_U_IO_FETCH_REQ requests. As a result, with the current impleme=
ntation, we can only support up to P block devices, where P =3D N / M. This=
 means that when we attempt to support block device P+1, it will fail due t=
o io_uring exhaustion.
> >>
> >> What do you mean by "size of the io_uring", the submission queue size?
> >> Why can't you submit all P * M UBLK_U_IO_FETCH_REQ operations in
> >> batches of N?
> >>
> >> Best,
> >> Caleb
> >>
> >> N is the size of the submission queue, and P is not fixed and unknown =
at the time of ring initialization....
> >
> > I don't think it matters whether P (the number of ublk devices) is
> > known ahead of time or changes dynamically. My point is that you can
> > submit the UBLK_U_IO_FETCH_REQ operations in batches of N to avoid
> > exceeding the io_uring SQ depth. (If there are other operations
> > potentially interleaved with the UBLK_U_IO_FETCH_REQ ones, then just
> > submit each time the io_uring SQ fills up.) Any values of P, M, and N
> > should work. Perhaps I'm misunderstanding you, because I don't know
> > what "io_uring exhaustion" refers to.
> >
> > Multishot ublk io_uring operations don't seem like a trivial feature
> > to implement. Currently, incoming ublk requests are posted to the ublk
> > server using io_uring's "task work" mechanism, which inserts the
> > io_uring operation into an intrusive linked list. If you wanted a
> > single ublk io_uring operation to post multiple completions, it would
> > need to allocate some structure for each incoming request to insert
> > into the task work list. There is also an assumption that the ublk
> > io_uring operations correspond 1-1 with the blk-mq requests for the
> > ublk device, which would be broken by multishot ublk io_uring
> > operations.
> >
> > Best,
> > Caleb
>
> Hi Caleb,
>
> I think what Ofer is trying to say is that we have a scaling issue.
>
> Our deployment could consist of 100s of ublk devices, not all of which wi=
ll be dispatching IO at the same time. If we were to submit the maximum num=
ber of IO requests that our application can handle for every ublk device we=
 need to deploy, the memory requirements would be excessive.

Thanks, I see what you mean. Yes, it's certainly a reasonable concern
in principle. The memory requirements may not be as steep as you
imagine. We have a similar architecture and haven't encountered any
issues. Each of our machines has 100+ ublk devices, each with 16
queues, with the maximum of 4096 requests per queue. The per-I/O state
for ublk and io_uring is pretty small; it's nowhere near our biggest
consumer of RAM.

>
> For this reason, we would prefer to have a global pool of IO requests tha=
t can be registered with the ublk-control device that each of the ublk devi=
ces registered to it can use.

It could probably work, but I think there are some details to iron
out. First of all, a global pool wouldn't work if there are multiple
ublk server applications whose I/Os should be isolated from each
other. And to get decent performance, I think you would definitely
want to partition these I/O request pools to avoid contention. A
possible approach would be to have one pool per ublk server thread.

Best,
Caleb
