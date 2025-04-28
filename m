Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E018C78F54
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855479; cv=none; b=A/n+aNhgBBb3OovoNJTd0CoxqUPqH7G+AlVNiFbhSJy5dWmzzVK03P8xDKyHGiP1pJqZg2haL4jRC9u36UyY+X01WzwQjFUSJ7sgjgIMGYiHTPRl+/xIhhHttG3/AjOtqqwfQxgpX/f2PWmbLoGPe8g/XbTpzgI9f4Loky7FLCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855479; c=relaxed/simple;
	bh=XBcNoyZwIg5WMBfW2ia3w8quKfrQaSc18S2aPWicx3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZKP5ETzHGglrrcQdjVVnMhkTWrigDD4Wf7Sai/v52LZMuDZBjtK4gWsh5Nb7CZxrrFQdOxWo3tjfpy1PED4eaylwLWqxn8Te2yRFI/V4g5twj50jC4WDW6Fv80mkPkYoLthc3CtD8LwCrCAacCHkeYyl642oHebPJo37jgsB8VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=OZIQh30J; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="OZIQh30J"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3087a70557bso725938a91.2
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745855475; x=1746460275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSWtxTZyd4YtXuy8eeGzEnkGn7wNlK3twd7oN5tDNio=;
        b=OZIQh30JG4XDHdiDRXxQJsYvdpQUOoWYzJ9YE6Y0kwktVP2yxOYrGMdBbXyH3/xx0R
         pxP5R1CpE38FozOLX5s2qRJmQB53YzWvtq3NCG+XFIdqg9r/4tkVwVvmf/MY+HLaWpoY
         lyOhj/xMU0aO9DJDvioMsenyrwbe22pFQeVF0lKHeTKqygqHpqmI36o5FwLBaXlw+0lP
         o8d3LWwzHSR0BJzLFBDbDD2EFCCsJINtgSMpAHVAfqp12o1D02E3xRynw2xPefMQ7PQM
         U5oQak0XZsCwlOg2thorbpU5z4nYeSrmKN8cV+VFJboTS0NHEcED9+Dq2NP6gGRuYyHy
         xRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745855475; x=1746460275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSWtxTZyd4YtXuy8eeGzEnkGn7wNlK3twd7oN5tDNio=;
        b=ZRBDu1zEHEEl2mWerwBbYNqLx6rTbrBjTflgD2rekmhBlUJ2OG4mnHa/OvWNkS5Ufv
         tANUU8FjTkUiRIzSh6b8EDq+7ilcufjPSgufS/FkwGaghPF4LNZYuiVofid209DoLxSo
         +vh9eBEjeuf2B/U5oa94/qYVyLe4Vh2JWF/1mZO/J8WXNBZHoI3Pp89VOcizIN7Wqr5K
         SfdW3m1Uu/rmYJPcIDkOR9gdwyXgfkBibUtLEt0drtG/SLdZysgOqNxmg9lpeF4VqKWk
         L85IpTpNkBYMsuvnhzf4nC/8/ts45s5/W/9xnTDSMrG0YvDaXtj12SlZKnV8ptQgepGD
         wRlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7iKvGgzFXJ9WUlJv49MX4sBvukhOIQLu3AsdaGShtpmgzxg5Zd18ULOEmEm43/pPccCaUIC5LSNbt4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh6gfkEK/PkIHAIShjq5HakzPjZ9wInrpSxJ8m8Zp2AWVc6bG5
	a98uEZA8nNEDrj7YBxEwTHMD5WmTNq36a/9aovFmcrxaSaotzCEIgn20z8Ymdhfxr+/f3n8xt6A
	XPdX0fP9/mFOeTLJjVxCbXjjEyMY7gz8lGHE5gw==
X-Gm-Gg: ASbGnctxbVF9/TiIDpmLhuW8ondnjJqvAh7ai6gK9CuiWV6PzIidY8dJm3rlE3FVPIV
	avXaErwZeOJ1ujNAv/RAEFfYjIQNYsVjWo0vzygRvl1tz2WOwHOvPqMSCbAd6F3gv2LA7Ziv0WA
	l+FSMKjgv2Rv9eleelsmS1sg==
X-Google-Smtp-Source: AGHT+IFWHCudpw8Cc1p2Hd3YjzbUj3Qlw1SjPB66Di8YXf0rT7+MLBFl0XfmvRkVTTIyijl+V8t/s3aFhbE8TCw62Uw=
X-Received: by 2002:a17:90b:1b52:b0:2fe:b45b:e7ec with SMTP id
 98e67ed59e1d1-309f7eb5d77mr6406322a91.8.1745855475015; Mon, 28 Apr 2025
 08:51:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250427134932.1480893-1-ming.lei@redhat.com> <20250427134932.1480893-2-ming.lei@redhat.com>
In-Reply-To: <20250427134932.1480893-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 28 Apr 2025 08:51:03 -0700
X-Gm-Features: ATxdqUFjzop9MfwmLyKl3ACHSqy0ZzREgppCpD6eeyhApWihu9zZXbanEZ_9fng
Message-ID: <CADUfDZqd_9c191pfNSmkm2Oz544V1auOcsCJtMnpj03Y-3vohA@mail.gmail.com>
Subject: Re: [PATCH v6.15 1/3] selftests: ublk: fix UBLK_F_NEED_GET_DATA
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 6:49=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Commit 57e13a2e8cd2 ("selftests: ublk: support user recovery") starts to
> support UBLK_F_NEED_GET_DATA for covering recovery feature, however the
> ublk utility implementation isn't done correctly.
>
> Fix it by supporting UBLK_F_NEED_GET_DATA correctly.
>
> Also add test generic_07 for covering UBLK_F_NEED_GET_DATA.
>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: 57e13a2e8cd2 ("selftests: ublk: support user recovery")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  tools/testing/selftests/ublk/Makefile         |  1 +
>  tools/testing/selftests/ublk/kublk.c          | 20 ++++++++++------
>  tools/testing/selftests/ublk/kublk.h          |  1 +
>  .../testing/selftests/ublk/test_generic_07.sh | 24 +++++++++++++++++++
>  .../testing/selftests/ublk/test_stress_05.sh  |  8 +++----
>  5 files changed, 43 insertions(+), 11 deletions(-)
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
> index e57a1486bb48..3afd45d7f989 100644
> --- a/tools/testing/selftests/ublk/kublk.c
> +++ b/tools/testing/selftests/ublk/kublk.c
> @@ -536,12 +536,17 @@ int ublk_queue_io_cmd(struct ublk_queue *q, struct =
ublk_io *io, unsigned tag)
>         if (!(io->flags & UBLKSRV_IO_FREE))
>                 return 0;
>
> -       /* we issue because we need either fetching or committing */
> +       /*
> +        * we issue because we need either fetching or committing or
> +        * getting data
> +        */
>         if (!(io->flags &
> -               (UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP)))
> +               (UBLKSRV_NEED_FETCH_RQ | UBLKSRV_NEED_COMMIT_RQ_COMP | UB=
LKSRV_NEED_GET_DATA)))
>                 return 0;
>
> -       if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
> +       if (io->flags & UBLKSRV_NEED_GET_DATA)
> +               cmd_op =3D UBLK_U_IO_NEED_GET_DATA;
> +       else if (io->flags & UBLKSRV_NEED_COMMIT_RQ_COMP)
>                 cmd_op =3D UBLK_U_IO_COMMIT_AND_FETCH_REQ;
>         else if (io->flags & UBLKSRV_NEED_FETCH_RQ)
>                 cmd_op =3D UBLK_U_IO_FETCH_REQ;
> @@ -658,6 +663,9 @@ static void ublk_handle_cqe(struct io_uring *r,
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
> @@ -1313,7 +1321,7 @@ int main(int argc, char *argv[])
>
>         opterr =3D 0;
>         optind =3D 2;
> -       while ((opt =3D getopt_long(argc, argv, "t:n:d:q:r:e:i:az",
> +       while ((opt =3D getopt_long(argc, argv, "t:n:d:q:r:e:i:gaz",
>                                   longopts, &option_idx)) !=3D -1) {
>                 switch (opt) {
>                 case 'a':
> @@ -1351,9 +1359,7 @@ int main(int argc, char *argv[])
>                                 ctx.flags |=3D UBLK_F_USER_RECOVERY | UBL=
K_F_USER_RECOVERY_REISSUE;
>                         break;
>                 case 'g':
> -                       value =3D strtol(optarg, NULL, 10);
> -                       if (value)
> -                               ctx.flags |=3D UBLK_F_NEED_GET_DATA;
> +                       ctx.flags |=3D UBLK_F_NEED_GET_DATA;

The help text in __cmd_create_help() should be updated accordingly.

>                         break;
>                 case 0:
>                         if (!strcmp(longopts[option_idx].name, "debug_mas=
k"))
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
> index 000000000000..e3ad36ef7b9a
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/test_generic_07.sh
> @@ -0,0 +1,24 @@
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
> +dev_id=3D$(_add_ublk_dev -t loop -q 2 -g "${UBLK_BACKFILES[0]}")
> +_check_add_dev $TID $?
> +
> +# run fio over the ublk disk
> +_run_fio_verify_io --filename=3D/dev/ublkb"${dev_id}" --size=3D256M

I thought you were planning to add a _have_program fio check?

Best,
Caleb

> +ERR_CODE=3D$?
> +if [ "$ERR_CODE" -eq 0 ]; then
> +       _mkfs_mount_test /dev/ublkb"${dev_id}"
> +       ERR_CODE=3D$?
> +fi
> +
> +_cleanup_test "generic"
> +_show_result $TID $ERR_CODE
> diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testi=
ng/selftests/ublk/test_stress_05.sh
> index a7071b10224d..88601b48f1cd 100755
> --- a/tools/testing/selftests/ublk/test_stress_05.sh
> +++ b/tools/testing/selftests/ublk/test_stress_05.sh
> @@ -47,15 +47,15 @@ _create_backfile 0 256M
>  _create_backfile 1 256M
>
>  for reissue in $(seq 0 1); do
> -       ublk_io_and_remove 8G -t null -q 4 -g 1 -r 1 -i "$reissue" &
> -       ublk_io_and_remove 256M -t loop -q 4 -g 1 -r 1 -i "$reissue" "${U=
BLK_BACKFILES[0]}" &
> +       ublk_io_and_remove 8G -t null -q 4 -g -r 1 -i "$reissue" &
> +       ublk_io_and_remove 256M -t loop -q 4 -g -r 1 -i "$reissue" "${UBL=
K_BACKFILES[0]}" &
>         wait
>  done
>
>  if _have_feature "ZERO_COPY"; then
>         for reissue in $(seq 0 1); do
> -               ublk_io_and_remove 8G -t null -q 4 -g 1 -z -r 1 -i "$reis=
sue" &
> -               ublk_io_and_remove 256M -t loop -q 4 -g 1 -z -r 1 -i "$re=
issue" "${UBLK_BACKFILES[1]}" &
> +               ublk_io_and_remove 8G -t null -q 4 -g -z -r 1 -i "$reissu=
e" &
> +               ublk_io_and_remove 256M -t loop -q 4 -g -z -r 1 -i "$reis=
sue" "${UBLK_BACKFILES[1]}" &
>                 wait
>         done
>  fi
> --
> 2.47.0
>
