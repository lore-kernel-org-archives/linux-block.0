Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1FF126F0A
	for <linux-block@vger.kernel.org>; Wed, 25 Sep 2024 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727235145; cv=none; b=PwHLDqqxdm7jbpIslgUY3LmNuJA/sMrDlMW/Bh9jxKesnELsy4sxW9S9CHyTNxNCVcg6O7Doemx9QgUga4hqPrsEUTCeHEOun+69xqINPo93LmLeQd78PM7hcCz1ArvrMIHfsa5cZAva4g8xFI4c8nlXNbU8yBgJtSbGqxx2nnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727235145; c=relaxed/simple;
	bh=jrGeHLmaGXoP7HPJg6ymK/zEI2tlMLj+0evYd72bSNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e85fHIImPjSIASA5pKaA3SvH/DRafUXegYuk9lTQM63ZpwRrJ3+8/KtDfRiqS+UEwzBFatprnCDUL8rpcVKrwfWUxd1fm4Ot46qrRn2Hy0rPOJSf1D4lVHB5ILVe7PsXFpOzCk+36EOQwX02gGh9CBMzBKKPiACNxoDIIod5LcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kgJbVaYH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgJbVaYH"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c2460e885dso13071a12.0
        for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 20:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727235141; x=1727839941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvk/7U/NTWN1cWY0tbAiQksUk1hwEHyFyRyv9e8634Q=;
        b=kgJbVaYHiRtOJ/nTwDZe+UPQBFDUvB44Ocm1vh+y3R8mn7wiJl7D6U0LU10vYt/H3x
         mP8yx1kCp/fs1i8MBCy7pj6q1BYGKR3juwxvdtz0Cd9XmB2/8saWc4vyFM7WUM5s9wiR
         dBYJlXBHGaodT0ZfaxLJNTVQqTzj1RJVkSOmj7u9yfJMfBLsAvUCJSm8buyyJRfkk/41
         ZmT2Loc/uXEYmhAcn/AcyfzTpSkVE1T20MMXk/v6SzjJZL8uaN+BcdtbK6paUMH+tCS6
         5e8yzIkZ+QR3+spNPvv3sV53NdycTfKNQ4sdS8H+prv6opNkitdZaYndv7jLnCJJvUPV
         zsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727235141; x=1727839941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvk/7U/NTWN1cWY0tbAiQksUk1hwEHyFyRyv9e8634Q=;
        b=iZ8y/2q8Ma9Omihcz4WJPyW2cvkY0APM6w3V/DQd9xIAR9zTx0BBnGMMmNhEFWorxb
         U7tXY+WVKUOVUXF2jSQQpy5fcxylgJHuxipPXxoYa2gP+0D3S+zjUMWlQ8IjxQSuMGsJ
         +qIqNH2IroPTzyKU/IjsCZ/bLeOO4aT7jdOQlJrogCnEX4sTSAbTuJ68tDcp6gEhxIla
         cGdiYg2M47OMWYCVFDw2/NxUU+s0SwpYwjk2wkDbPA+fEBONcrj3WGdX4xHmk93ichCG
         hNz7gk38mXkaTSPQmDQheS0XkxrVeGePS9lRAZDjY369MYEy4LpSyQoNweAfKrHInvfq
         YpyA==
X-Forwarded-Encrypted: i=1; AJvYcCVpW6rCIMhP8chZk/6X5v0RmvWrfNPUB87J2HtMe3e6hdu0AN3DBiOyeg4J79gd6Ocb5eEZV4HhYJlmGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWk0HQsWIZ3GLTTEoMVsNxxV/bx41N21bH6r4pYRQqriajMbEu
	j7Mvb0ZvfQwfOHCseeTPbNY2/AX/LNeQaTBU7N/tgbbh/vivI7TNKXJYEdJDnsQWGrkVB0A9uXV
	3pyHwV9fdDdylo1R2HFqKoxVGcN31tp+sUUVH
X-Google-Smtp-Source: AGHT+IFhUwqaoyBBG+ib3lq6VnBAS9sON3hNxMhhOuPk7C9xAT4IhzehW/nDDjcCUQuFRxha+C6oQJ2lJr/QpZ89Uk8=
X-Received: by 2002:a05:6402:34ce:b0:5c7:18f8:38a6 with SMTP id
 4fb4d7f45d1cf-5c720fc9292mr134807a12.5.1727235140368; Tue, 24 Sep 2024
 20:32:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808162438.345884-1-ming.lei@redhat.com>
In-Reply-To: <20240808162438.345884-1-ming.lei@redhat.com>
From: Akilesh Kailash <akailash@google.com>
Date: Tue, 24 Sep 2024 20:32:08 -0700
Message-ID: <CABSDvD+zQbB69F4DW1-mKww-VrBXTzC5fWaajdq1_c6+6H+KGw@mail.gmail.com>
Subject: Re: [PATCH V5 0/8] io_uring: support sqe group and provide group kbuf
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, linux-block@vger.kernel.org, 
	Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 9:24=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> Hello,
>
> The 1st 3 patches are cleanup, and prepare for adding sqe group.
>
> The 4th patch supports generic sqe group which is like link chain, but
> allows each sqe in group to be issued in parallel and the group shares
> same IO_LINK & IO_DRAIN boundary, so N:M dependency can be supported with
> sqe group & io link together. sqe group changes nothing on
> IOSQE_IO_LINK.
>
> The 5th patch supports one variant of sqe group: allow members to depend
> on group leader, so that kernel resource lifetime can be aligned with
> group leader or group, then any kernel resource can be shared in this
> sqe group, and can be used in generic device zero copy.
>
> The 6th & 7th patches supports providing sqe group buffer via the sqe
> group variant.
>
> The 8th patch supports ublk zero copy based on io_uring providing sqe
> group buffer.
>

Hi Ming,

Thanks for working on this feature. I have tested this entire v5 series
for the Android OTA path to evaluate ublk zero copy.

Tested-by: Akilesh Kailash <akailash@google.com>

> Tests:
>
> 1) pass liburing test
> - make runtests
>
> 2) write/pass two sqe group test cases:
>
> https://github.com/axboe/liburing/compare/master...ming1:liburing:sqe_gro=
up_v2
>
> - covers related sqe flags combination and linking groups, both nop and
> one multi-destination file copy.
>
> - cover failure handling test: fail leader IO or member IO in both single
>   group and linked groups, which is done in each sqe flags combination
>   test
>
> 3) ublksrv zero copy:
>
> ublksrv userspace implements zero copy by sqe group & provide group
> kbuf:
>
>         git clone https://github.com/ublk-org/ublksrv.git -b group-provid=
e-buf_v2
>         make test T=3Dloop/009:nbd/061    #ublk zc tests
>
> When running 64KB/512KB block size test on ublk-loop('ublk add -t loop --=
buffered_io -f $backing'),
> it is observed that perf is doubled.
>
> Any comments are welcome!
>
> V5:
>         - follow Pavel's suggestion to minimize change on io_uring fast c=
ode
>           path: sqe group code is called in by single 'if (unlikely())' f=
rom
>           both issue & completion code path
>
>         - simplify & re-write group request completion
>                 avoid to touch io-wq code by completing group leader via =
tw
>                 directly, just like ->task_complete
>
>                 re-write group member & leader completion handling, one
>                 simplification is always to free leader via the last memb=
er
>
>                 simplify queueing group members, not support issuing lead=
er
>                 and members in parallel
>
>         - fail the whole group if IO_*LINK & IO_DRAIN is set on group
>           members, and test code to cover this change
>
>         - misc cleanup
>
> V4:
>         - address most comments from Pavel
>         - fix request double free
>         - don't use io_req_commit_cqe() in io_req_complete_defer()
>         - make members' REQ_F_INFLIGHT discoverable
>         - use common assembling check in submission code path
>         - drop patch 3 and don't move REQ_F_CQE_SKIP out of io_free_req()
>         - don't set .accept_group_kbuf for net send zc, in which members
>           need to be queued after buffer notification is got, and can be
>           enabled in future
>         - add .grp_leader field via union, and share storage with .grp_li=
nk
>         - move .grp_refs into one hole of io_kiocb, so that one extra
>         cacheline isn't needed for io_kiocb
>         - cleanup & document improvement
>
> V3:
>         - add IORING_FEAT_SQE_GROUP
>         - simplify group completion, and minimize change on io_req_comple=
te_defer()
>         - simplify & cleanup io_queue_group_members()
>         - fix many failure handling issues
>         - cover failure handling code in added liburing tests
>         - remove RFC
>
> V2:
>         - add generic sqe group, suggested by Kevin Wolf
>         - add REQ_F_SQE_GROUP_DEP which is based on IOSQE_SQE_GROUP, for =
sharing
>           kernel resource in group wide, suggested by Kevin Wolf
>         - remove sqe ext flag, and use the last bit for IOSQE_SQE_GROUP(P=
avel),
>         in future we still can extend sqe flags with one uring context fl=
ag
>         - initialize group requests via submit state pattern, suggested b=
y Pavel
>         - all kinds of cleanup & bug fixes
>
> Ming Lei (8):
>   io_uring: add io_link_req() helper
>   io_uring: add io_submit_fail_link() helper
>   io_uring: add helper of io_req_commit_cqe()
>   io_uring: support SQE group
>   io_uring: support sqe group with members depending on leader
>   io_uring: support providing sqe group buffer
>   io_uring/uring_cmd: support provide group kernel buffer
>   ublk: support provide io buffer
>
>  drivers/block/ublk_drv.c       | 160 ++++++++++++++-
>  include/linux/io_uring/cmd.h   |   7 +
>  include/linux/io_uring_types.h |  54 +++++
>  include/uapi/linux/io_uring.h  |  11 +-
>  include/uapi/linux/ublk_cmd.h  |   7 +-
>  io_uring/io_uring.c            | 359 ++++++++++++++++++++++++++++++---
>  io_uring/io_uring.h            |  16 ++
>  io_uring/kbuf.c                |  60 ++++++
>  io_uring/kbuf.h                |  13 ++
>  io_uring/net.c                 |  23 ++-
>  io_uring/opdef.c               |   4 +
>  io_uring/opdef.h               |   2 +
>  io_uring/rw.c                  |  20 +-
>  io_uring/timeout.c             |   2 +
>  io_uring/uring_cmd.c           |  28 +++
>  15 files changed, 720 insertions(+), 46 deletions(-)
>
> --
> 2.42.0
>
>
