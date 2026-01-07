Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154F82139C9
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749564; cv=none; b=TkIGkMatzvJdXzGXFFxwXf99PZhUXxsV4E788kU8JRBAVJ6h4L1lMS7veLs+v5zGs6QFxwEtwm1MEECyLoubQ67gXYY2GzgASXUwATnFbRDYn0Bk8mKGBcMhbfqRFOticOxb1ZDkv6iQklDHZlEGlzIqr+HWcnZz4dfp3mvXCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749564; c=relaxed/simple;
	bh=8L+bEy222ilcqRCXz5he8VgWUY86CDaJkk8s1OfsjNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBfiuGA/sHBq+YYMGkObyaB3XLWy0HkUIhqddbmkXAv0N8XTR1oAN1Z91NlRJemyCbRQFyqoPB5POivj19vdK/i1eFNjVxE6Ttac8TkAlWJ2Lpoq1GMFK5U4DrqacVgUdxTFAPYggi/0rsKBlhr5RG8TXkkdeMdU4ekOz5oG7ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DvJhbGOv; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DvJhbGOv"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-11f0d900dc4so48832c88.1
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 17:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767749561; x=1768354361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3s1VmNuY1vfF19RLz1g63VLcXvn3Ca3gr5Z47Y09cI=;
        b=DvJhbGOvcuRpQCI6HACFrrkqztOFP6vwMIDQrA0s8XJEjUCJD0pSSrkDE6bENFYV0v
         dvsGqaC2WSNzn24ROYXbfCrkqRGQYlonmxUSBrh59nY4WRio2H2tk5SXyBAURcSMOUwL
         UiJ6uO8LX+tFQa4EYp+pedKzVLxIDIkpOUsok3Zp/Ng7kF4gVHkeR9PcoNynT2FsxRue
         c++uJs4d+U7yJVubkKD22gT8BJjb6aiFc9/3Yc5zC8EZU6beP8ePbOLKZIU3LIC2ktMv
         g7H8xQPlkbKmAoPvJjzltvapz4fxT/YndTePd/umZ7mdIRNIhdgnNQUpMXwbDfiyp3hi
         hZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767749561; x=1768354361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i3s1VmNuY1vfF19RLz1g63VLcXvn3Ca3gr5Z47Y09cI=;
        b=EkweBnKuVZS//EEtrqWgVGG8I0mm+UgxdzOeaWQTgmCgTVY0YuWShjQjPxOrgHN+Q1
         MO33hneeumrWYdLxr2WgkFY9gnCaZaGtKWoAnXzTU4meGCTk84JMnj6zpzdQYijI/CaL
         w2hTbHqlFxhi8rPCcHd4U4rhODbn3+75+u8iuI7Jw9qjiyielozAi7JdRU73ysTB2X4q
         fASq9wLrXksHUar5khc0gg8RR+7KC1WaGFW1juc6igm1Ly8vhikqNc/hkhsNeTHyN8Fq
         smmADi/WavvEp1ycYFuIeWIcgxYdQW539SZDt3GGqD+7eUsBKU0s4N6T3+vABcaTH61O
         V9og==
X-Forwarded-Encrypted: i=1; AJvYcCXXt6iBalklYt0fEcdQdSF9wWZox1Lz6Fv3X9bpJ2sZ89LRHuo2MyXp/Dag+2ECY0gggRie3FcG60x5OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMgHzm8TglO7kyyp9fxdwaZ0E5m0wjy47yk0AmRYZ79aHDOh2o
	wbwhozDztmccwMHxKHGEP8TPz/vEl5NLYT4O9HjC+GBPRDU74LMvhOvlgFIfZMXVR67rKR2Z59P
	7bTv4rPScMqNkiQTU3uoqLQwP7H/IEpIITCD34t3pmg==
X-Gm-Gg: AY/fxX6a4jJpYs7caz9sEDiUkadRYPOkyhZNVZS2mCGBupYqKemEOliyK0qHfGQ7JC+
	RCax5AY9ow3Xe0FulNZ6WMAw/7NeVKusTgT5qhG3cmXBk1BgVwmRKP6HJAwphnqvdxAXoqJK9bB
	05bePD1z98zSRZlYGVR0vSQFdKKfhP5HKTdBN2JHXSsyoE7wNbXbspJWaah/6wpcxyl7GURg1Dd
	VZNBmUsyXMJCn2i/QWviO76g+D5a0bJZnJiqNSWqfs11171XIayWC7c4X4mZVtU9dF2jUnN
X-Google-Smtp-Source: AGHT+IEOPI+acY7C0IXlkifW4JC98BZCNn3PWd9u2Y6MY0BMihAoQo/+w9Ny3P+dRj6fBVQLt9qmegUhRWPTnfxCSkg=
X-Received: by 2002:a05:7022:4199:b0:119:e55a:95a0 with SMTP id
 a92af1059eb24-121f8aff7dcmr519688c88.2.1767749560928; Tue, 06 Jan 2026
 17:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-20-csander@purestorage.com> <aV0Xx2vWmL5Iuls4@fedora>
 <CADUfDZofEg0Q=veyihy=M-XCxoga6fkueJmLdJ4CVd6KU=GdBg@mail.gmail.com> <aV2m9yoxoTSxwCFN@fedora>
In-Reply-To: <aV2m9yoxoTSxwCFN@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 Jan 2026 17:32:29 -0800
X-Gm-Features: AQt7F2rnw9jmkH5egNXAk7mVqUOX5oluAPfQnuZ3DMmw-rYBXyZTsCcZ2xvbhhM
Message-ID: <CADUfDZr5K9WztPnek1t1xnej6ALtyG_9yf9=ZGhVcHhqmyzx3g@mail.gmail.com>
Subject: Re: [PATCH v3 19/19] selftests: ublk: add end-to-end integrity test
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 4:21=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrote=
:
>
> On Tue, Jan 06, 2026 at 09:15:44AM -0800, Caleb Sander Mateos wrote:
> > On Tue, Jan 6, 2026 at 6:10=E2=80=AFAM Ming Lei <ming.lei@redhat.com> w=
rote:
> > >
> > > On Mon, Jan 05, 2026 at 05:57:51PM -0700, Caleb Sander Mateos wrote:
> > > > Add test case loop_08 to verify the ublk integrity data flow. It us=
es
> > > > the kublk loop target to create a ublk device with integrity on top=
 of
> > > > backing data and integrity files. It then writes to the whole devic=
e
> > > > with fio configured to generate integrity data. Then it reads back =
the
> > > > whole device with fio configured to verify the integrity data.
> > > > It also verifies that injected guard, reftag, and apptag corruption=
s are
> > > > correctly detected.
> > > >
> > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > > ---
> > > >  tools/testing/selftests/ublk/Makefile        |   1 +
> > > >  tools/testing/selftests/ublk/test_loop_08.sh | 111 +++++++++++++++=
++++
> > > >  2 files changed, 112 insertions(+)
> > > >  create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh
> > > >
> > > > diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/=
selftests/ublk/Makefile
> > > > index bfd68ae64142..ab745443fd58 100644
> > > > --- a/tools/testing/selftests/ublk/Makefile
> > > > +++ b/tools/testing/selftests/ublk/Makefile
> > > > @@ -33,10 +33,11 @@ TEST_PROGS +=3D test_loop_02.sh
> > > >  TEST_PROGS +=3D test_loop_03.sh
> > > >  TEST_PROGS +=3D test_loop_04.sh
> > > >  TEST_PROGS +=3D test_loop_05.sh
> > > >  TEST_PROGS +=3D test_loop_06.sh
> > > >  TEST_PROGS +=3D test_loop_07.sh
> > > > +TEST_PROGS +=3D test_loop_08.sh
> > > >  TEST_PROGS +=3D test_stripe_01.sh
> > > >  TEST_PROGS +=3D test_stripe_02.sh
> > > >  TEST_PROGS +=3D test_stripe_03.sh
> > > >  TEST_PROGS +=3D test_stripe_04.sh
> > > >  TEST_PROGS +=3D test_stripe_05.sh
> > > > diff --git a/tools/testing/selftests/ublk/test_loop_08.sh b/tools/t=
esting/selftests/ublk/test_loop_08.sh
> > > > new file mode 100755
> > > > index 000000000000..ca289cfb2ad4
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/ublk/test_loop_08.sh
> > > > @@ -0,0 +1,111 @@
> > > > +#!/bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> > > > +
> > > > +if ! _have_program fio; then
> > > > +     exit $UBLK_SKIP_CODE
> > > > +fi
> > > > +
> > > > +fio_version=3D$(fio --version)
> > > > +if [[ "$fio_version" =3D~ fio-[0-9]+\.[0-9]+$ ]]; then
> > > > +     echo "Requires development fio version with https://github.co=
m/axboe/fio/pull/1992"
> > > > +     exit $UBLK_SKIP_CODE
> > > > +fi
> > > > +
> > > > +TID=3Dloop_08
> > > > +
> > > > +_prep_test "loop" "end-to-end integrity"
> > > > +
> > > > +_create_backfile 0 256M
> > > > +_create_backfile 1 32M # 256M * (64 integrity bytes / 512 data byt=
es)
> > > > +integrity_params=3D"--integrity_capable --integrity_reftag
> > > > +                  --metadata_size 64 --pi_offset 56 --csum_type t1=
0dif"
> > > > +dev_id=3D$(_add_ublk_dev -t loop -u $integrity_params "${UBLK_BACK=
FILES[@]}")
> > >
> > > I tried above setting:
> > >
> > > ./kublk add -t loop --integrity_capable --integrity_reftag --metadata=
_size 64 --pi_offset 56 --csum_type t10dif --foreground -u /dev/sdb /dev/sd=
c
> > > dev id 1: nr_hw_queues 2 queue_depth 128 block size 512 dev_capacity =
8388608
> > >         max rq size 1048576 daemon pid 38295 flags 0x160c2 state LIVE
> > >         queue 0: affinity(0 )
> > >         queue 1: affinity(8 )
> > >
> > > However, IO error is always triggered:
> > >
> > > [ 9202.316382] ublkb1: ref tag error at location 0 (rcvd 128)
> > > [ 9202.317171] Buffer I/O error on dev ublkb1, logical block 0, async=
 page read
> >
> > Hmm, what are the initial contents of /dev/sdc? It looks like they are
> > nonzero, as the reftag being read for logical block 0 is 128 rather
> > than the expected 0 (the reftag would be read from bytes 60 to 63 of
> > /dev/sdc). In general, though, the partition scan may be expected to
> > fail the bio-integrity-auto checks if the integrity data hasn't been
> > initialized. I don't think this is an issue, since the partition scan
> > is looking for a partition table but there's no guarantee that one
> > exists.
> > You can disable the kernel integrity checks if you want by writing 0
> > to /sys/block/ublkb1/integrity/read_verify. However, I'm not sure it's
> > possible to do this soon enough to take effect before the partition
> > scan.
> > We could also use the UBLK_F_NO_AUTO_PART_SCAN feature, once it lands,
> > to suppress the partition scan and these error messages.
>
> UBLK_F_NO_AUTO_PART_SCAN can't avoid the following read failure.

Are you saying the reads aren't coming from the partition scan? What
else would be issuing reads to the ublk device before fio is run on
it?

>
> I guess the issue can be avoided by adding small superblock to the meta
> data file, then format it in the 1st time when superblock doesn't exist.

Not sure the complexity of a superblock is necessary. Could just
initialize all the protection information with valid reftags and guard
tags.

>
> This way will make it usable from test/verify purpose.

I'm still not following why it's not "usable" currently. Only blocks
that have been written to (with protection information generated by
fio or the kernel) can be read back, but that's how block devices are
expected to be used. It seems fine to me for test purposes.
test_loop_08.sh writes to the full ublk device before verifying it, so
it shouldn't encounter any invalid reftags.

Best,
Caleb
