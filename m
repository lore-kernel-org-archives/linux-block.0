Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AFE8C0B
	for <linux-block@vger.kernel.org>; Fri, 29 Aug 2025 04:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756441601; cv=none; b=rbQJjypit0+pOF2CLlsVI6jEdQmwq1v+6saix/Equw41VLF+Cv+NUjxSdyKwnuCa0fjv6QKt/6qXd20WBV1R88WpM0EgfY8ZgDEAQL0NrqwSo7nEDnJFQa8K6v/X3C0T/y/UbdpgZN/i+l+5zesIDnI8mOWGF5ptU7cumTe3NOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756441601; c=relaxed/simple;
	bh=EkoqvOV7dM9ZRk2hSBU1HXFUVM807mm71e5eGg2wvoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFXqmBxLiK2RNlkaF16zSdEcMNHBvr94//lDpPgQJAeLYmE27CGhVeNKFyLM0tOhs46BsZkvTUHc5ELYaUkMaCZ9wFvtOF1gw7Up0zaUcNFrQ38TvsTgMSErWE0NrR4sP8LGvGp4M8VdSEZn4Dx0fVb7QDjMZ2GANZtQ1vBdAEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FkayMsRw; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FkayMsRw"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30cceb749d7so718378fac.2
        for <linux-block@vger.kernel.org>; Thu, 28 Aug 2025 21:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756441599; x=1757046399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l4MHI2CvzdDIWL3MJRQiUQ6XLwUHQ6bTI5Rtl+9YzQg=;
        b=FkayMsRw1nhaL5c6tizQXkoEh7yrCFhYpojD0dnfln4mlh6vSh1D+pWbFkkmFdtMoG
         m35gUDjc41GX/9BxBDcCME/hu++HvndCyTt2sx9TmEVV6H71+0jUKIKAe2HdMiIw+v9K
         T9cbP6mnO/1MDFCFo8PNY9Ae6cRS6dyNcN0uLqFmnhcVWo8PV/VIJoPbc5+G3+IEJ3t/
         2GAgdgRC/QaFUQDYXEPIoKZfMKul4jpG6O7vQq10DthshgsYwjwlbO2dCUSclc9FVQTE
         Cb42uJxzFXx0PzCOUn822Zbnna0YWgDJODPf6sJuqeBir4yLTfbrowUvIXL4jpDbXooV
         Rybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756441599; x=1757046399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l4MHI2CvzdDIWL3MJRQiUQ6XLwUHQ6bTI5Rtl+9YzQg=;
        b=Uwq07n6TKum+prl4zaBQM0V4MxitclncEo7LtT/ceRqBbAhuJl2VqwaNNLPPV6FZ9A
         9somzLcvAUS1kyaz2GjT0Qq9xM+2CsrBA2ZuVTECF/bPCCX4pE38uTb0wNWwsMB6VeLI
         x22CWEKdsglp9N1PULbVJqArBVnKL9+j5cRpTgtRetGUPGeUiI/uDmGTuQiGNwyZIoST
         H9DKqm7mpFFT0JcJLg5ZEOCA8GEfcxbwIHaH0Twh9uljc/oKkS8mmvRCLYV4m2XrNkkh
         cmGR2PqPtYu7FCB7FonacP7FQZOJl2GzEwzj5dFUvxGJi/AuAwuXSlOHWlGDO6NQA+Oe
         y0MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzA4471sx6GC/7XOvAK8bUj4igyFVSAhBm1fT6iN3yma1alVGaLJQkrxdL7DMVZHEn2f5hb/nkf4Nrcw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5+bXJHJk2dISjQLhT/YV5qCA1DWMs95q8WTwpJm8W/a3LZg3c
	coGmmU0aVy+j4WGPgI69S5y7he5OySlw8KY8JBmQ27MnwSy7CuRu8ijiOyAKqaSRJ5XYpvE7EbD
	nNWSOGZaglkVEkEesUZkYKkQfT4SzFgQf0stbmHGB5hoG9eCg+q6bDOw=
X-Gm-Gg: ASbGnctlXquguXuHiOamcg4NbNAHKI7Nd5d/DrokbL6bQOa9ZuyNosFkhw+1Z1WBsqa
	uJnXqoqmCvJcD2Yukilo/JflveYqExd3eNWupuBgIDQ4U7chD+CNtbLKyUBwIS0gXg9+KoxEl5g
	OEfmWzJy7J9ZQj7kLgKZfa4Eo3HqhOziFR5DouTYfnVOkBc314CZf0eMZlkuH7L9pvZT9XKH8X5
	GxRSQ32/YX6eHN00twL
X-Google-Smtp-Source: AGHT+IFf4FjrlA+yJNoGwfHCxy5AzxXYoQmbOwMzox76J9uWS3VmXyQrRB8vf/VsxwQIM47CtDWnG0sD/EIc57wMe1I=
X-Received: by 2002:a05:6808:640b:b0:437:e919:7c69 with SMTP id
 5614622812f47-437e9198366mr694154b6e.28.1756441598826; Thu, 28 Aug 2025
 21:26:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822082606.66375-1-changfengnan@bytedance.com>
 <20250822150550.GP7942@frogsfrogsfrogs> <aKiP966iRv5gEBwm@casper.infradead.org>
 <877byv9w6z.fsf@gmail.com> <aKif_644529sRXhN@casper.infradead.org>
 <874ityad1d.fsf@gmail.com> <CAPFOzZufTPCT_56-7LCc6oGHYiaPixix30yFNEsiFfN1s9ySMQ@mail.gmail.com>
 <aKwq_QoiEvtK89vY@infradead.org> <CAPFOzZvBvHWHUwNLnH+Ss90OMdu91oZsSD0D7_ncjVh0pF29rQ@mail.gmail.com>
 <878qj6qb2m.fsf@gmail.com>
In-Reply-To: <878qj6qb2m.fsf@gmail.com>
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Fri, 29 Aug 2025 12:26:27 +0800
X-Gm-Features: Ac12FXzlKhRKFlcX7iMwV0JQwPE6st56qbCxyRHYK6cyh9oqTXOg70UqWcq9vqw
Message-ID: <CAPFOzZuLQK-2fKHsy79MyeKeUSNRU2YR-o48w4Qj1rfLAMcR4A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, Need to wait a few more days for this, too busy recently.

Ritesh Harjani <ritesh.list@gmail.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=8827=
=E6=97=A5=E5=91=A8=E4=B8=89 01:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Fengnan Chang <changfengnan@bytedance.com> writes:
>
> > Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B48=E6=9C=882=
5=E6=97=A5=E5=91=A8=E4=B8=80 17:21=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> On Mon, Aug 25, 2025 at 04:51:27PM +0800, Fengnan Chang wrote:
> >> > No restrictions for now, I think we can enable this by default.
> >> > Maybe better solution is modify in bio.c?  Let me do some test first=
.
>
> If there are other implications to consider, for using per-cpu bio cache
> by default, then maybe we can first get the optimizations for iomap in
> for at least REQ_ALLOC_CACHE users and later work on to see if this
> can be enabled by default for other users too.
> Unless someone else thinks otherwise.
>
> Why I am thinking this is - due to limited per-cpu bio cache if everyone
> uses it for their bio submission, we may not get the best performance
> where needed. So that might require us to come up with a different
> approach.
>
> >>
> >> Any kind of numbers you see where this makes a different, including
> >> the workloads would also be very valuable here.
> > I'm test random direct read performance on  io_uring+ext4, and try
> > compare to io_uring+ raw blkdev,  io_uring+ext4 is quite poor, I'm try =
to
> > improve this, I found ext4 is quite different with blkdev when run
> > bio_alloc_bioset. It's beacuse blkdev ext4  use percpu bio cache, but e=
xt4
> > path not. So I make this modify.
>
> I am assuming you meant to say - DIO with iouring+raw_blkdev uses
> per-cpu bio cache where as iouring+(ext4/xfs) does not use it.
> Hence you added this patch which will enable the use of it - which
> should also improve the performance of iouring+(ext4/xfs).
>
> That make sense to me.
>
> > My test command is:
> > /fio/t/io_uring -p0 -d128 -b4096 -s1 -c1 -F1 -B1 -R1 -X1 -n1 -P1 -t0
> > /data01/testfile
> > Without this patch:
> > BW is 1950MB
> > with this patch
> > BW is 2001MB.
>
> Ok. That's around 2.6% improvement.. Is that what you were expecting to
> see too? Is that because you were testing with -p0 (non-polled I/O)?
>
> Looking at the numbers here [1] & [2], I was hoping this could give
> maybe around 5-6% improvement ;)
>
> [1]: https://lore.kernel.org/io-uring/cover.1666347703.git.asml.silence@g=
mail.com/
> [2]: https://lore.kernel.org/all/20220806152004.382170-3-axboe@kernel.dk/
>
>
> -ritesh
