Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218E93469F2
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767719759; cv=pass; b=kANoe2mI6+BtEd7z2IlFVVY+eUjyKsCWn49CU8yzrZPO6g9WmZDfGJeivG/kGBmLTizM6q4g4f8gFLOj9deKGm94LmPgOPKD3DhG5T/GuCbfB1M2NA9onY439GrrQ0BgJ/T720fXOKFFc8f1sHFlbyhz8RkTYoAvlzg00vY0280=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767719759; c=relaxed/simple;
	bh=BcUKT/WaKF3cc5RT8cSr1Hmp5p8kpbrtWjAK1Grl5Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=roDf1H5p0c4dzmYuMgsJyhEcL4/q3mhp78QoxKIr+7bgDW6GDpXfdZfSSKoV1xNunLcQueBESvDcn45RMdvLM0yetOYnaxcJY8NkhNkhfLmDCk6NbvVr5PG0fvXCyD5AA8g9AtM3CaDAmiwrFuXdBjfzC9tNRaLkyOIeuuD3nmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XO9wN6w3; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XO9wN6w3"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-11f1cb6cefeso37135c88.0
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 09:15:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767719756; cv=none;
        d=google.com; s=arc-20240605;
        b=Lgqc5gRRmNM+S3tZdQ2mVYkI2KwmoeJ6C8nOD/bQi8ZG/GRynup17kmQgP7qQ9dD6h
         3dEZkcGeWnWPjUK1qLCyeZJRkb+Q+yyOkVPKHT05/JydP/XqVe5NvzQBX40J0mJrZGR+
         WSFjMBRPj8S5KTBf8jaW9uHBaR/foG1Ev2HCAUnj8aZ6qCRy1k1POtKmNwc8wiso3M0r
         +eflA3+GjiwWk5LAw2HBiCBUGRZ10ivfwsaXkAnCqo5qxzU/2JGCMC023ANYLIgeJj9i
         UzOycRULLjo94o8ZIDtvqaAujQE5XQrzWM2vNm/VmSVZetFsUMTIicN2BAG4GFPy2mXF
         +iug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h0S9X35x1dPYmVywIfwy49RDgI1meLSZA2LdM4U3+6o=;
        fh=TvVbB9aHBmf30eSOU7pttDUjF9Rtrf3xvQZw5Zr4wHs=;
        b=anMqfdx3V5pTbAa0ce3Lvuj6hDgM+ypKzNdA8ZsZx6OOLytBUdloGVynp0hu5vokhx
         WVHJcw2cYdFaaACsGSpQcj4xRLWeYYIEqHHE0qC+m/I9qP6z2ssvjQlUby9uuegNA7NB
         ywOYlWa8TeUEh1RSu61MTWnR0GX+D3wm3XV1qxbqt4n2916fyz/ax+Au9tweoatRH1zh
         Ch7qUw5TQUd4avofrLh8Kg5S/bYDT5lDtaNUoMvaPlcPLLNNWp2hgXwJpCB3Rs0W4K+5
         wbyBfLdlOTuAY8csdU7dRVjdtifiIRzVZGWhhhv74k/rm3aJhZPDOtq0nX7hyYI7Cwm7
         uS4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767719756; x=1768324556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0S9X35x1dPYmVywIfwy49RDgI1meLSZA2LdM4U3+6o=;
        b=XO9wN6w3Opl7nMwLomPxLAU98QSEE6/7I4oGQQFjM3wtnqQSdRDxJalKkX2vq3OsWg
         il5XdccSJfDz+Bv9lZGLKHbLnwj8mSjjhsc2zkLmIlXuevG/AQnRKeQh6oHHc0qrVBW+
         jbkcx+Y6QPmgOM1XRyHJUcpvOM4bXFMGuD3PzfkGba0SR6NsanQfg7hQoggDguDpJX5E
         fZabPw5l81W4yK05v1oooaBtbl9uKJKCnuzAyIxyLwoBmu2to7KoRXPJ8TZhzJZ/gN6B
         N3eFZgSF6O5q0n8nPdKLdOA6295ZYXhU7U5edlXeY5Byov89mRUg+WPKcgHAD+n3IzfZ
         zuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767719756; x=1768324556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h0S9X35x1dPYmVywIfwy49RDgI1meLSZA2LdM4U3+6o=;
        b=AKdVMhvYTqDyTYkzA6KRKtbbnh39uLAM3wqavoqanmXmZPRKhewgj2EnetHUrlgxKz
         dWngNbc4L7R0VMe5Vg7AolyandTFNZk0F4WO3Kq2xhg7osD+RS1ilhxQ6EUJ/eaREo77
         8khO3nqMpkZJ3kX3wVJrjvDjzGpCV/DpW9qcZ87PRsbhyYWIts3ViDiJpEUVASaiqsJ8
         B33bqtIg80qZQtnQ5W9HzSeqCn9cp+CrZ0oqI8UgvyQoUNEdKPk7AvNmyfKKIhcer6oz
         agmeot7PRK66S6RKMtkP8Ey2HBes5//c99LpeIALyfmC+ekXKwYBOMeq3ymFZgVuUqbK
         F5dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaFaZLfro8G23acdOzyyzrsAUQbHAfLZ2BXfjoLh9cViPMxhAzRm3pdGdfxtsAOfYz+yZvJwvL2Cp+gQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5yKFXVFWY+bOVGmj6XVBplWfMloIueay1y4ErY9QgG/f/R//Q
	ElmNP2zgndmOa8IsNsv4ZYJ38ODDEBLZ3xzLbFNEiQ/UOAEe3GL7DaVDcEl8oA5/TLf3qEhWdvW
	kn+L+Ic/DGvGFfzRp2z7X5QietB8kbL4bREZ0sM+3+bpkgKdn/eCBDd4=
X-Gm-Gg: AY/fxX6uvzcFfzSjetsWeKpe9R7bEvJ9oUGzT/p3XZ1gMnwEqWFwtwci9w3or7+z68G
	oRZn4/EpQu5MCSWzT1LsnvQPUPgaYdBIk44peMZmMWEvBd0+6XPVdDNCfo1yNFmk80CTkj215fr
	0j8m9T1I39if+XR3QqoN5xdO4e9+9PkpXLpe5suZ3+POLBTvyoj5oauQojMM6ea9ZbZDQ2wy+xh
	JxoN4bBzktG+iTTrpdY0Ui2lp0Y6IBXNzddCliNQVPeG29gAMUAbEiaPJZFub5Cusrpg4kwnsiO
	yKAQ5Mw=
X-Google-Smtp-Source: AGHT+IHsx2prbXYg3j18SfdVTQFJ60Rbk1R0GsSR/Ko74ivczv03vINWOjHdxoRdXuVpHJS26gsubAcJWKCBQS4KIZA=
X-Received: by 2002:a05:7022:6195:b0:119:e56a:4fff with SMTP id
 a92af1059eb24-121f18e1ff2mr1694930c88.4.1767719756030; Tue, 06 Jan 2026
 09:15:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-20-csander@purestorage.com> <aV0Xx2vWmL5Iuls4@fedora>
In-Reply-To: <aV0Xx2vWmL5Iuls4@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 Jan 2026 09:15:44 -0800
X-Gm-Features: AQt7F2oH1KSrEU_qjpFRn21_6eSA-1DRw6ns58qu5_CQ83y4Pw0aC2-PF1SPR9A
Message-ID: <CADUfDZofEg0Q=veyihy=M-XCxoga6fkueJmLdJ4CVd6KU=GdBg@mail.gmail.com>
Subject: Re: [PATCH v3 19/19] selftests: ublk: add end-to-end integrity test
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 6:10=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Mon, Jan 05, 2026 at 05:57:51PM -0700, Caleb Sander Mateos wrote:
> > Add test case loop_08 to verify the ublk integrity data flow. It uses
> > the kublk loop target to create a ublk device with integrity on top of
> > backing data and integrity files. It then writes to the whole device
> > with fio configured to generate integrity data. Then it reads back the
> > whole device with fio configured to verify the integrity data.
> > It also verifies that injected guard, reftag, and apptag corruptions ar=
e
> > correctly detected.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  tools/testing/selftests/ublk/Makefile        |   1 +
> >  tools/testing/selftests/ublk/test_loop_08.sh | 111 +++++++++++++++++++
> >  2 files changed, 112 insertions(+)
> >  create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh
> >
> > diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/self=
tests/ublk/Makefile
> > index bfd68ae64142..ab745443fd58 100644
> > --- a/tools/testing/selftests/ublk/Makefile
> > +++ b/tools/testing/selftests/ublk/Makefile
> > @@ -33,10 +33,11 @@ TEST_PROGS +=3D test_loop_02.sh
> >  TEST_PROGS +=3D test_loop_03.sh
> >  TEST_PROGS +=3D test_loop_04.sh
> >  TEST_PROGS +=3D test_loop_05.sh
> >  TEST_PROGS +=3D test_loop_06.sh
> >  TEST_PROGS +=3D test_loop_07.sh
> > +TEST_PROGS +=3D test_loop_08.sh
> >  TEST_PROGS +=3D test_stripe_01.sh
> >  TEST_PROGS +=3D test_stripe_02.sh
> >  TEST_PROGS +=3D test_stripe_03.sh
> >  TEST_PROGS +=3D test_stripe_04.sh
> >  TEST_PROGS +=3D test_stripe_05.sh
> > diff --git a/tools/testing/selftests/ublk/test_loop_08.sh b/tools/testi=
ng/selftests/ublk/test_loop_08.sh
> > new file mode 100755
> > index 000000000000..ca289cfb2ad4
> > --- /dev/null
> > +++ b/tools/testing/selftests/ublk/test_loop_08.sh
> > @@ -0,0 +1,111 @@
> > +#!/bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > +
> > +if ! _have_program fio; then
> > +     exit $UBLK_SKIP_CODE
> > +fi
> > +
> > +fio_version=3D$(fio --version)
> > +if [[ "$fio_version" =3D~ fio-[0-9]+\.[0-9]+$ ]]; then
> > +     echo "Requires development fio version with https://github.com/ax=
boe/fio/pull/1992"
> > +     exit $UBLK_SKIP_CODE
> > +fi
> > +
> > +TID=3Dloop_08
> > +
> > +_prep_test "loop" "end-to-end integrity"
> > +
> > +_create_backfile 0 256M
> > +_create_backfile 1 32M # 256M * (64 integrity bytes / 512 data bytes)
> > +integrity_params=3D"--integrity_capable --integrity_reftag
> > +                  --metadata_size 64 --pi_offset 56 --csum_type t10dif=
"
> > +dev_id=3D$(_add_ublk_dev -t loop -u $integrity_params "${UBLK_BACKFILE=
S[@]}")
>
> I tried above setting:
>
> ./kublk add -t loop --integrity_capable --integrity_reftag --metadata_siz=
e 64 --pi_offset 56 --csum_type t10dif --foreground -u /dev/sdb /dev/sdc
> dev id 1: nr_hw_queues 2 queue_depth 128 block size 512 dev_capacity 8388=
608
>         max rq size 1048576 daemon pid 38295 flags 0x160c2 state LIVE
>         queue 0: affinity(0 )
>         queue 1: affinity(8 )
>
> However, IO error is always triggered:
>
> [ 9202.316382] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.317171] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read

Hmm, what are the initial contents of /dev/sdc? It looks like they are
nonzero, as the reftag being read for logical block 0 is 128 rather
than the expected 0 (the reftag would be read from bytes 60 to 63 of
/dev/sdc). In general, though, the partition scan may be expected to
fail the bio-integrity-auto checks if the integrity data hasn't been
initialized. I don't think this is an issue, since the partition scan
is looking for a partition table but there's no guarantee that one
exists.
You can disable the kernel integrity checks if you want by writing 0
to /sys/block/ublkb1/integrity/read_verify. However, I'm not sure it's
possible to do this soon enough to take effect before the partition
scan.
We could also use the UBLK_F_NO_AUTO_PART_SCAN feature, once it lands,
to suppress the partition scan and these error messages.

Best,
Caleb

> [ 9202.319478] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.319983] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read
> [ 9202.326332] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.326974] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read
> [ 9202.327570] ldm_validate_partition_table(): Disk read failed.
> [ 9202.336539] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.337228] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read
> [ 9202.339247] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.339779] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read
> [ 9202.344306] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.344948] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read
> [ 9202.347067] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.347558] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read
> [ 9202.348100] Dev ublkb1: unable to read RDB block 0
> [ 9202.350159] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.350642] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read
> [ 9202.354977] ublkb1: ref tag error at location 0 (rcvd 128)
> [ 9202.355539] Buffer I/O error on dev ublkb1, logical block 0, async pag=
e read
> [ 9202.356280]  ublkb1: unable to read partition table
>
>
>
> Thanks,
> Ming
>
