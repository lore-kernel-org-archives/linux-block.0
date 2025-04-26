Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1B1F2361
	for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745698573; cv=none; b=geS3MnZ/4GaFnxFtu6VZcHVsGWy69yqPqQIZKQOG12Tab8VpRGXly6pWCxj4hsadJf0xSZ+UXZHRbmVaiFTEjA/4mFvhoLZduv1E0tv2PhEoYSAOW4Ng8AH3B6CFDukRyU6JLCNWISyM44Hbe0ODOgcf09HDG21FDkda+z6E/9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745698573; c=relaxed/simple;
	bh=uS1FvsIdCV+TBvBI5WG0e5+jyLrqi+IAniyMmXHg76Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1m6ParoZ9zVkIlcRZwyDDw75snqgc7PcEfB2nKA6gWZ0vwgyPY+ngKGk64DP3FERfqTVKR6m26r+b2BEVDIBDke5SiDBzSAC8jwqBdhbzWVfXE0M0OHLq/UFTfPq4ekIRHPNVqfbdxcx2bD+Rfo/QD6TI5zUENrweyT9diCzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HVotSkgf; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HVotSkgf"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223fd44daf8so7111795ad.2
        for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745698570; x=1746303370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nUG9TgKWjAmKwkY5K86HP8hqXk0iwWDJ7LAOKmpNSA=;
        b=HVotSkgfdE6Mx9jxoWdvXUPNUQ4mAT13FCtVNU3vO/CYs8q0/dGmk1Ok81nxNH/YvQ
         RVUF34pKf5eCk20+nbXIpx6BBBT0zNbvOeZJuQmLaM8wruBNHiK7lFxqqfnRGr3JOqdV
         Ji00KXRY10+FAvt5YKy8X1Sdvh6ZzW8GELjNPAMgg/udhhGm3N4BiK+eiPx0OUFVL3PD
         l/kBDpddZOoOIt9KBjO5zlM/Q4D5tBw3iIPPVn03WNCy0gXvawXG4LBIPVz0IzzGogQ2
         nv4JGGsowN1HtMAEehAcg8ctDAhwgZPhacmguSdlFuqgSg6bcPE9xbZGPWyseodzNPVh
         kQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745698570; x=1746303370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nUG9TgKWjAmKwkY5K86HP8hqXk0iwWDJ7LAOKmpNSA=;
        b=vZixJN3wOymCgbCdeAGS1I/ml2GGQzaBfslgtCfE4XCnNJWGrVe3d+bbn6v4Yd/Ojw
         a7k+4WI1KbAoXqZL3TpCviePLVvSkQ6IEQOSjCpQ4lvvQZVaWk89mCXjDsbIL8g9ap0I
         nIzSW01j731SluEHukKnPVFMlNL7nofgirk6idkNZhJ4X/WOhfxProIpJ5aVqhV6Ttzb
         uwMpJLQgvmPlejBuC9y+pj82VEb5wXpGRzTgs7Fe+n4f+tOLz8RFK3zlXMaMIs8MkSyM
         x3MNdv5W1gPFK4p8H2LSJu1gIi+BK1QOMWtmBeuyPlFF8ZogEfbIUmJW6s9ZBJvHqx3L
         vFlg==
X-Forwarded-Encrypted: i=1; AJvYcCWKWSxDPeup/ZuwmhKXh/GohawJXD22I+xBB1t9L5cGIY1xEkxl9VwMWgbEk0RqIFOwiiLBCewraZS8/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YznJRKw/pcVMjKu2ubATdtWI/+jxbTaFnIIhnI5Wi7eMvMuzkVO
	1I4h/tiv4Qnc8LlJtTnEy+K5BpohQDIJlyB74oiZebeAJjo7PccdQSF3Jc9cS+ZY5Bk9YM5bqC9
	HZZ6HpuOhnpSEgIR2BgrDCiLL7fxku+6qayJLf6HCHegBGAhUCdPgyg==
X-Gm-Gg: ASbGncvOElJ0YL7diCSQGr35BeRKjL5FZ65V5WxP/1y54grd3/4V3JtgKfw2wIjORTT
	XsgYaqwDjSMEqOJlJf+v6PKpbg2xVn1b80xXauTLrE12eDJngdQU3fRWWOI9FT3NsRf367ymBrf
	eHOjEmRbPtzGx0gTjXNARz
X-Google-Smtp-Source: AGHT+IG7XQ77dDioyQ1o8rdErZf6l2Q2aOHVA4Mz+FuRvlZXP7hOmY2Edr+bY8zx9+Ngf8d5ugHpeqklH6MJbbIfv7Y=
X-Received: by 2002:a17:90b:3504:b0:308:2a7b:547b with SMTP id
 98e67ed59e1d1-309f7d9ff09mr3838655a91.1.1745698569822; Sat, 26 Apr 2025
 13:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426094111.1292637-1-ming.lei@redhat.com> <20250426094111.1292637-2-ming.lei@redhat.com>
In-Reply-To: <20250426094111.1292637-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 26 Apr 2025 13:15:58 -0700
X-Gm-Features: ATxdqUFr4WYUbns8K5F_ttIEzlWLP474CIHCkvKcpGHUckdPSchmEBHtVtAuCQ4
Message-ID: <CADUfDZobcEmDMOYTJh5E5FFsLdYaio3xK96amLm1_MCtpyv0FA@mail.gmail.com>
Subject: Re: [PATCH 1/4] selftests: ublk: fix UBLK_F_NEED_GET_DATA
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 26, 2025 at 2:41=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Commit 57e13a2e8cd2 ("selftests: ublk: support user recovery") starts to
> support UBLK_F_NEED_GET_DATA for covering recovery feature, however the
> ublk utility implementation isn't done correctly.
>
> Fix it by supporting UBLK_F_NEED_GET_DATA correctly.
>
> Also add test generic_07 for covering UBLK_F_NEED_GET_DATA.

Looks good to me, just a few minor comments.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

>
> Fixes: 57e13a2e8cd2 ("selftests: ublk: support user recovery")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tools/testing/selftests/ublk/Makefile         |  1 +
>  tools/testing/selftests/ublk/kublk.c          | 11 +++++---
>  tools/testing/selftests/ublk/kublk.h          |  1 +
>  .../testing/selftests/ublk/test_generic_07.sh | 25 +++++++++++++++++++
>  4 files changed, 35 insertions(+), 3 deletions(-)
>  create mode 100755 tools/testing/selftests/ublk/test_generic_07.sh
>
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selfte=
sts/ublk/Makefile
> index ec4624a283bc..f34ac0bac696 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -9,6 +9,7 @@ TEST_PROGS +=3D test_generic_03.sh
>  TEST_PROGS +=3D test_generic_04.sh
>  TEST_PROGS +=3D test_generic_05.sh
>  TEST_PROGS +=3D test_generic_06.sh
> +TEST_PROGS +=3D test_generic_07.sh
>
>  TEST_PROGS +=3D test_null_01.sh
>  TEST_PROGS +=3D test_null_02.sh
> diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftes=
ts/ublk/kublk.c
> index e57a1486bb48..701b47f98902 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -538,10 +538,12 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct =
ublk_io *io, unsigned tag)
>
>         /* we issue because we need either fetching or committing */
>         if (!(io->flags &
> -               (UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP)))
> +               (UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP | UB=
LKSRV_NEED_GET_DATA)))

Comment could use an update

>                 return 0;
>
> -       if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
> +       if (io->flags & UBLKSRV_NEED_GET_DATA)
> +               cmd_op =3D UBLK_U_IO_NEED_GET_DATA;
> +       else if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
>                 cmd_op =3D UBLK_U_IO_COMMIT_AND_FETCH_REQ;
>         else if (io->flags & UBLKSRV_NEED_FETCH_RQ)
>                 cmd_op =3D UBLK_U_IO_FETCH_REQ;
> @@ -658,6 +660,9 @@ static void ublk_handle_cqe(struct io_uring *r,
>                 assert(tag < q->q_depth);
>                 if (q->tgt_ops->queue_io)
>                         q->tgt_ops->queue_io(q, tag);
> +       } else if (cqe->res =3D=3D UBLK_IO_RES_NEED_GET_DATA) {
> +               io->flags |=3D UBLKSRV_NEED_GET_DATA | UBLKSRV_IO_FREE;
> +               ublk_queue_io_cmd(q, io, tag);
>         } else {
>                 /*
>                  * COMMIT_REQ will be completed immediately since no fetc=
hing
> @@ -1313,7 +1318,7 @@ int main(int argc, char *argv[])
>
>         opterr =3D 0;
>         optind =3D 2;
> -       while ((opt =3D getopt_long(argc, argv, "t:n:d:q:r:e:i:az",
> +       while ((opt =3D getopt_long(argc, argv, "t:n:d:q:r:e:i:g:az",
>                                   longopts, &option_idx)) !=3D -1) {

It's a little strange for -g to take an argument since it's basically
a boolean flag. But it looks like several other flags behave the same
way.

>                 switch (opt) {
>                 case 'a':
> diff --git a/tools/testing/selftests/ublk/kublk.h b/tools/testing/selftes=
ts/ublk/kublk.h
> index 918db5cd633f..44ee1e4ac55b 100644
> --- a/tools/testing/selftests/ublk/kublk.h
> +++ b/tools/testing/selftests/ublk/kublk.h
> @@ -115,6 +115,7 @@ struct ublk_io {
>  #define UBLKSRV_NEED_FETCH_RQ          (1UL << 0)
>  #define UBLKSRV_NEED_COMMIT_RQ_COMP    (1UL << 1)
>  #define UBLKSRV_IO_FREE                        (1UL << 2)
> +#define UBLKSRV_NEED_GET_DATA           (1UL << 3)
>         unsigned short flags;
>         unsigned short refs;            /* used by target code only */
>
> diff --git a/tools/testing/selftests/ublk/test_generic_07.sh b/tools/test=
ing/selftests/ublk/test_generic_07.sh
> new file mode 100755
> index 000000000000..5d82b5955006
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/test_generic_07.sh
> @@ -0,0 +1,25 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> +
> +TID=3D"generic_07"
> +ERR_CODE=3D0
> +
> +_prep_test "generic" "test UBLK_F_NEED_GET_DATA"
> +
> +_create_backfile 0 256M
> +dev_id=3D$(_add_ublk_dev -t loop -q 2 -g 1 "${UBLK_BACKFILES[0]}")
> +_check_add_dev $TID $?
> +
> +# run fio over the ublk disk
> +if ! _run_fio_verify_io --filename=3D/dev/ublkb"${dev_id}" --size=3D256M=
; then
> +       _cleanup_test "generic"
> +       _show_result $TID 255

Propagate the return code from fio?

> +fi

All the other tests that use _run_fio_verify_io appear to check
_have_program fio first. Is that necessary here too?

> +
> +_mkfs_mount_test /dev/ublkb"${dev_id}"
> +ERR_CODE=3D$?
> +
> +_cleanup_test "generic"
> +_show_result $TID $ERR_CODE
> --
> 2.47.0
>
