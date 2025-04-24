Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A7F293B77
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745521666; cv=none; b=fm1y3yTCKxhyfzRk+TVkk3eLO1vh42J50uUGFpFuWgmp7jZLAMoQ3OewnMwhy3xlq+4jj28AK/WeteFAeeqzlDYkI48GqwNxi70BYCTAz2MpBUKK9jaVECnRYMsGkozrvlboJ+FS0B6GkENYdV09xCUloV2E8Dy4+ONMzoyPst4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745521666; c=relaxed/simple;
	bh=PsubedB25ZGp4yNCvEKRMQWZLybzJFhUaz//mJPXLTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsLRJYaW/n5mVOPsbrVEtAI0u8polQoYk4EbBia8ts2ifL2gq1Ug1eeI583pplVgOpQWYAu2RsPcXBgeOnU8XC9K1rfXnvXmWm8ISNN1Qn7v52M/C39fZ4F/yFQOyhq749x+EsVR3QgftbTBxqAySxGtT26b67mm4dLvcfG3sUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RLJLvqal; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RLJLvqal"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-224172f32b3so2977875ad.2
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745521664; x=1746126464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsubedB25ZGp4yNCvEKRMQWZLybzJFhUaz//mJPXLTM=;
        b=RLJLvqalXUyzSPDiNyFXwSMKo2wXu16hYaxZHXOnOVPdx1Ub3N4I6/pvb3tVqPxjq/
         q0aVLSeGvGhft4M7Q/Cf2lCtxoGnOSfawbQSg4QcG16rgc+g4hl71ZB/6wm5yr5zRpnx
         6PsXHpFuTIRfAKAefgEx316AYTpsgHDxsOXgPn4lchFDELEy9NmgAXIFoM3oO6so6/Yq
         yiz2zEG1KEeHQbpO4aN7YrW2/wIB+2sOROIGWR2ExpVwzdCjEqOQ7zw5Ho2WYYICwMtB
         EEoT2HFsIjrcp7rheBpBXDxpg4ro6JQGhDHrZ8HOeXtGyllk5/V6DWmHV5CFUPd2yZg/
         UpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745521664; x=1746126464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsubedB25ZGp4yNCvEKRMQWZLybzJFhUaz//mJPXLTM=;
        b=Gk18ToL5NuDfAPV/mBOSFRW3H+HJ0Q59qW/JRJOq8IDHtpISICHUEQdEKBS+BsGFLV
         5oqrObhBoVSQF24mpKO89oc+rage7SlcauL5q40XCFLJEQvwCyI/sPU/0CwleoYW6QDX
         mpZWWnxSdBYigadYOCyxlYYTVH8QzjcGyzL3KhSZYspclJas2T+vLzofvY3o1/9w9w6S
         FD4G0GCEHNzWmp/pq8nPTw8Z1bQYHM2apCNzS5Va7pPeQXSQAC5ss/ANtGSHFiCCPCbu
         anxyc97eSp5TxJVag+4oyck2bHeQK6kAHL/Y+1cYDCQRIgrWMWSNkPoLaOqZvzN0wxm1
         jicQ==
X-Gm-Message-State: AOJu0Yz0xAzXASTkuHcWes82MWExalhCwl+B/zN522AU5h3x9Sli/+mn
	q5vy1NBYJ3Y9p4kCq6enzKUqpJUTQkdj1NGstSKx8f/mKcXU1S2pLA2lBD9R+hcNqpcpL8kgrTj
	uHw84c760BvltJgkWn6yPwB3ZxckAUVbpt6wn4g==
X-Gm-Gg: ASbGncvT7Xw3tAkqTcbBT/XdXVUSp3UKsktLFYqtZLbmeMI92lP9VZgg2LK98MW3ELH
	1rJtay1Xsfoc5gUaZsVSZi8CRRCWJ3se4HWbYi1vAz4dhYJTmXQZPcCAbvVbjxHtfQkTlzE6A3G
	2sbgkQCW2YJBKL54D82VlLdiFRxltikaM=
X-Google-Smtp-Source: AGHT+IHFgYshaQL/Wu09uZG3kLHo8Vh16tCEdLf5K15dPXi/SMkhFExslBt2aLfDXivI3M+rKAQDxNVMkF+tMrusKC8=
X-Received: by 2002:a17:90b:4b0c:b0:2fe:91d0:f781 with SMTP id
 98e67ed59e1d1-309ed24ccc0mr2033714a91.2.1745521663947; Thu, 24 Apr 2025
 12:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <IA1PR12MB606744884B96E0103570A1E9B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
 <CADUfDZo=uEno=4-3PJAD+_5sLRMaoFvMUGpckbD3tdbhCxTW4A@mail.gmail.com> <IA1PR12MB60672D37508D641368D211B8B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB60672D37508D641368D211B8B6852@IA1PR12MB6067.namprd12.prod.outlook.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 24 Apr 2025 12:07:32 -0700
X-Gm-Features: ATxdqUGWVB2nfJAIoQTzPuoo_FZ3b0YroEEifSfbv58TbvU3yKbiMC0VnrfBaSo
Message-ID: <CADUfDZqUQ+n5tr=XG+sJWR_q55fzNSzLHvUZXkysOw=c+vfVGg@mail.gmail.com>
Subject: Re: ublk: RFC fetch_req_multishot
To: Ofer Oshri <ofer@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"ming.lei@redhat.com" <ming.lei@redhat.com>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	Jared Holzman <jholzman@nvidia.com>, Yoav Cohen <yoav@nvidia.com>, 
	Guy Eisenberg <geisenberg@nvidia.com>, Omri Levi <omril@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 11:58=E2=80=AFAM Ofer Oshri <ofer@nvidia.com> wrote=
:
>
>
>
> ________________________________
> From: Caleb Sander Mateos <csander@purestorage.com>
> Sent: Thursday, April 24, 2025 9:28 PM
> To: Ofer Oshri <ofer@nvidia.com>
> Cc: linux-block@vger.kernel.org <linux-block@vger.kernel.org>; ming.lei@r=
edhat.com <ming.lei@redhat.com>; axboe@kernel.dk <axboe@kernel.dk>; Jared H=
olzman <jholzman@nvidia.com>; Yoav Cohen <yoav@nvidia.com>; Guy Eisenberg <=
geisenberg@nvidia.com>; Omri Levi <omril@nvidia.com>
> Subject: Re: ublk: RFC fetch_req_multishot
>
> External email: Use caution opening links or attachments
>
>
> On Thu, Apr 24, 2025 at 11:19=E2=80=AFAM Ofer Oshri <ofer@nvidia.com> wro=
te:
> >
> > Hi,
> >
> > Our code uses a single io_uring per core, which is shared among all blo=
ck devices - meaning each block device on a core uses the same io_uring.
> >
> > Let=E2=80=99s say the size of the io_uring is N. Each block device subm=
its M UBLK_U_IO_FETCH_REQ requests. As a result, with the current implement=
ation, we can only support up to P block devices, where P =3D N / M. This m=
eans that when we attempt to support block device P+1, it will fail due to =
io_uring exhaustion.
>
> What do you mean by "size of the io_uring", the submission queue size?
> Why can't you submit all P * M UBLK_U_IO_FETCH_REQ operations in
> batches of N?
>
> Best,
> Caleb
>
> N is the size of the submission queue, and P is not fixed and unknown at =
the time of ring initialization....

I don't think it matters whether P (the number of ublk devices) is
known ahead of time or changes dynamically. My point is that you can
submit the UBLK_U_IO_FETCH_REQ operations in batches of N to avoid
exceeding the io_uring SQ depth. (If there are other operations
potentially interleaved with the UBLK_U_IO_FETCH_REQ ones, then just
submit each time the io_uring SQ fills up.) Any values of P, M, and N
should work. Perhaps I'm misunderstanding you, because I don't know
what "io_uring exhaustion" refers to.

Multishot ublk io_uring operations don't seem like a trivial feature
to implement. Currently, incoming ublk requests are posted to the ublk
server using io_uring's "task work" mechanism, which inserts the
io_uring operation into an intrusive linked list. If you wanted a
single ublk io_uring operation to post multiple completions, it would
need to allocate some structure for each incoming request to insert
into the task work list. There is also an assumption that the ublk
io_uring operations correspond 1-1 with the blk-mq requests for the
ublk device, which would be broken by multishot ublk io_uring
operations.

Best,
Caleb
