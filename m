Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BED485927
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015909; cv=pass; b=rwLxkzlcWLG3r0tJ00P47KeQ3cpyGNRoHgxfLpo0ynbZ5jDd/aosFQpgK2ddyHne36p+gDWknlq/iWBNjg8WSNtD0JxWRpdUEiPzg4fU+X3XtZivC291aY7Vxsy7d/8GNBv8z6Bgi9u20+oRQBju2Dkcy3zusiLKyYq+xeOZKwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015909; c=relaxed/simple;
	bh=Rz3gk+t2gTIpEruf5cYRb9cjm2N8Aq614pRL1iSoQAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSOU/dbNRP4rWBY8KVH6/yBUorCHs5tkfQRS/upktJL1HxXqfhjqZoD6Sjke3IrHxSzN3S5qRxKZiY7nlj/uXqpTHxr+sLzWd/5MR1AfFlzyv7bO3YzD0hpVo/sG+Hx3rjFK1segSzhQMBL26//rfUPRD9dgmWwrzuwiKEr/r94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B1WsHYks; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pUpt2+I4; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1WsHYks";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pUpt2+I4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790015906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4OT+zFbvIRL6MoOWethE1XT3ogQfB2tHN5k5VD3xeE=;
	b=B1WsHYksk38a/oQjhngCTye224zqY96NmPqA643Iq+1OLym043uhdcXgg8d7ZxoqGZ4+XT
	7KCJNYk+SNM66mXBGp9ZEkxzcUto7x8zhc8fax8GOV1acbeF9BU0OJuP7WJm3R1WzDKEvw
	1+r1EId6SdlBXNy6QWHc+yi7VoZCiCA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-OjM_EtzNPBuVjOaSQzM1sg-1; Mon, 21 Sep 2026 14:38:25 -0400
X-MC-Unique: OjM_EtzNPBuVjOaSQzM1sg-1
X-Mimecast-MFC-AGG-ID: OjM_EtzNPBuVjOaSQzM1sg_1790015904
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4870142fd5cso1713673f8f.0
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 11:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790015904; cv=none;
        d=google.com; s=arc-20260327;
        b=QqIlbl0KmYkjJa71IqmWCmzykaaH82hRE9zNjFvIoAA21fvwl8nzrxJY5Bpdg7vLto
         gKjCH4Wbhm73lrVGa8ZusW/cI56AUGlhBLopxJ0uuBLjfS5kuaj7VusZHhVLvMiG01wR
         2rexyMvz1+pzbXH96vx2Ee2Q/hn3zfpWHl7i+JKEqYUjv9xNkh0bNjoF/kLOHHa2JN50
         pkJwWsoL1BEUK4/uRLwnVArl/V2ri85jju9ErtMtp2iEWHs97lBpEAOVm8o9KnuSRUsw
         jDr4XXu1/2TbngftiWDbzNse8WzMRcY/bGTm+9d3QKVrObHETIjEOiQlc9sm2aYeh97R
         HnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/4OT+zFbvIRL6MoOWethE1XT3ogQfB2tHN5k5VD3xeE=;
        fh=uT0i16xmV8Z4H7vOfdiGNazh+ksHCbGw+anAkg2zjyM=;
        b=i9oRSIzjvUOmhyeZq8XX28Pus3aMAYAKrO5VFij2un84zgyjcv61ymErVpWZMov4Fd
         sz111rR5C4wbIwkslSyc7KMNkDqMN00yAzgIcAsdvW+/g7fmPmbr/svjIOA7TOC84U3s
         TUB6Ff6XGdhBJqez6noGPbNZiOQxTx3qxGZXC7dxztjrDurKBruCc1+w7h0Dyqn+FK2F
         jVasYIZYPk2a3k+zJ5YZp1XsNwasvBtsMyy6to+SSqJYIymNxRl9AayMvMsasZ+ZOGOc
         Xxfk7Wevq0aIKq9/CHOVlHBfjhnCYxWBxxhX9S/LQF8ak8beXkg1w6p5p16+J/SdECdd
         Uyew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790015904; x=1790620704; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/4OT+zFbvIRL6MoOWethE1XT3ogQfB2tHN5k5VD3xeE=;
        b=pUpt2+I46iXigxHpOk8UDs+5deG4FgNOuo+11UkY1AxxFk6bDsdjHSEc+ZIqGGmPPg
         QmgG/VZ23kK3IGTCAlPo6MVH8hvDs+g3p5Dw8oHL09Din2NBO2QFKXuXhnW8hMgSTriJ
         K64eZMVi4zOElY4z5BxAz888sn+J59HsD6dfgVPA/eNpmbscIGknhI8K0tB1A56MZpCs
         lLWSBaiJdL4PLQ+SIuXd67tGc1RnKL+plWk/AKgarp7KjdtFRITPCJ7QxYHsIJjQH8bj
         zNXQKdakQF76AyOotWVCTJLRtoEIuhjp2+4hNl2+tW9wcJbt3kPEKpCvieLMhz1FeQee
         pFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015904; x=1790620704;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4OT+zFbvIRL6MoOWethE1XT3ogQfB2tHN5k5VD3xeE=;
        b=cL7NQcWQwEP2tNDW78Pa8x1s/IL6gc6gTMHyHQildavXA1lBFED+Kw1xJCE7BZQ+s0
         YrHHF8BBaT+h816vcbf1nBi4cHWBDr+44y9ghMMc5AHuMf/lo42OvuCczhULeBjFvYch
         iFrlI14TFFS5rl+N64jNrZhyI2lUQVt2czZBxIFqIObLwh1Lhx5ATKconlar7gRJAIH9
         3/GoqEPk+vdk7Rr//HeEPpvqf0nOBZQZLlsaifki3bzmkQM29vt8bZOdcyl5cgChthKr
         +H0eFBsgfeCQip2i65Fh4f4QxX7mNWFsqSmTY5VaApuK6N1/oIbFdPAlm+hxGzyCQbYy
         D9UQ==
X-Gm-Message-State: AFuF++l4qF1t7RouEMWDCS11iUtkk3BPWsbs54J3q27+i8/g28EVkFUH
	L3hDc7N4G4BTplG2+8VVzhje0AWvTYGJJLkDv29www7R8mCYMSDrP0bAisYWHS0GVh8K1z2JJal
	nY25EVLgOyXiCMlJQEJ5xEqp7yQVCKMNQOEoMHyGVTQuuqy/Eor8h1VFQBIIsjx6kk4cfDd0RKX
	k4uL68MILnIdkjP4lIhIUccXgeP3i0fNI/+V4x7pY=
X-Gm-Gg: AYBFou0MOzs64vZ/o9W5ljaum5Bcen/n0N9qzijY1WgQQW8JuRAz1yQYZwdwdWNok49
	NzoUfxosOiEk+J8nldmJ7dM44eGRTGSpS0kpK78YfOmwbLA+hw3wl+7gAMV+DQOIFBC1cx/dHtj
	Qgtqto1AQAmFc5n6hot3Kyf3cjuKL7/i99PEJFzHQhkxHjEBKnt2J81rD9aDj68vnOCResJP++Q
	FWTRkHhsp5UHsN0ug==
X-Received: by 2002:a05:6000:4006:b0:487:57d:18e4 with SMTP id ffacd0b85a97d-4871e363793mr15829656f8f.41.1790015903878;
        Mon, 21 Sep 2026 11:38:23 -0700 (PDT)
X-Received: by 2002:a05:6000:4006:b0:487:57d:18e4 with SMTP id
 ffacd0b85a97d-4871e363793mr15829627f8f.41.1790015903503; Mon, 21 Sep 2026
 11:38:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917020752.1672578-1-mkhalfella@purestorage.com> <20260917020752.1672578-5-mkhalfella@purestorage.com>
In-Reply-To: <20260917020752.1672578-5-mkhalfella@purestorage.com>
From: Jesse Taube <jtaubepe@redhat.com>
Date: Mon, 21 Sep 2026 14:38:12 -0400
X-Gm-Features: AcwNN1WLYkOhb5XXJ2iBpkmeUmW0NDs5tSaAOIXsu8yann3IfOsz4cNIX2pAaN4
Message-ID: <CADRr4bdUDLcrV62TXimdhsXZ0GU=DPrBOXFJRix7BADw34TT7g@mail.gmail.com>
Subject: Re: [PATCH blktests 4/5] src/nvme-ghost-write-detector: add an ABA
 ghost write detector
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com, 
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>, 
	Randy Jennings <randyj@purestorage.com>, Dhaval Giani <dgiani@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 10:09=E2=80=AFPM Mohamed Khalfella
<mkhalfella@purestorage.com> wrote:
>
> Consider a write X that is issued to an LBA and times out without ever
> being acknowledged. The initiator retries it on another path, where it
> lands. A write Y to the same LBA follows and lands as well. The original
> X is still in flight somewhere in the fabric, and when it finally
> reaches the device it overwrites Y. A read now returns X, a write the
> initiator gave up on long ago.
>
> Add a program to catch this. It opens the device O_DIRECT and, on each
> iteration, issues a series of writes of distinct byte patterns to the
> same LBA, the 4k block at offset 0, waits, then reads that block back
> and checks every byte holds the pattern written last. Because the
> patterns differ, the value that comes back identifies which write
> reappeared.
>
> Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
> ---
>  src/.gitignore                  |  1 +
>  src/Makefile                    |  1 +
>  src/nvme-ghost-write-detector.c | 86 +++++++++++++++++++++++++++++++++
>  3 files changed, 88 insertions(+)
>  create mode 100644 src/nvme-ghost-write-detector.c
>
> diff --git a/src/.gitignore b/src/.gitignore
> index e9869e1..9673be8 100644
> --- a/src/.gitignore
> +++ b/src/.gitignore
> @@ -15,6 +15,7 @@
>  /zbdioctl
>  /miniublk
>  /nvme-passthrough-meta
> +/nvme-ghost-write-detector
>  /ioctl-lbmd-query
>  /nvme-passthru-admin-uring
>  /nvme-delay-ioctl
> diff --git a/src/Makefile b/src/Makefile
> index dd64694..92b4d0c 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -24,6 +24,7 @@ C_TARGETS :=3D \
>         mount_clear_sock \
>         nvme-delay-ioctl \
>         nvme-passthrough-meta \
> +       nvme-ghost-write-detector \
>         ioctl-lbmd-query \
>         nbdsetsize \
>         openclose \
> diff --git a/src/nvme-ghost-write-detector.c b/src/nvme-ghost-write-detec=
tor.c
> new file mode 100644
> index 0000000..bd42dde
> --- /dev/null
> +++ b/src/nvme-ghost-write-detector.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-3.0+
> +// Copyright (C) 2026 Mohamed Khalfella
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <malloc.h>
> +#include <errno.h>
> +#include <libgen.h>

We don't need to include malloc.h
> +
> +#define BUF_SIZE       4096
> +#define ITERATIONS     10
> +#define DELAY          3               /* seconds delay between iteratio=
ns */
> +#define WRITE_COUNT    10
> +
> +#define WRITE_OFFSET   0
> +#define READ_OFFSET    WRITE_OFFSET
> +
> +int main(int argc, char **argv)
> +{
> +       int fd, i, w, off, ret;
> +       char *buff;
> +

This is a bit pedantic but:

if (argc < 1)
  return 1;

> +       fprintf(stdout, "starting %s test program\n", basename(argv[0]));
> +
> +       if (argc < 2) {
> +               fprintf(stderr, "usage: %s /dev/nvmeXnY", argv[0]);
> +               return 1;
> +       }
> +
> +       fd =3D open(argv[1], O_RDWR | O_DIRECT);
> +       if (fd < 0) {
> +               fprintf(stderr, "failed to open device, errno =3D %d\n", =
errno);
> +               return 1;
> +       }
> +
> +       ret =3D posix_memalign((void **)&buff, BUF_SIZE, BUF_SIZE);
> +       if (ret) {
> +               fprintf(stderr, "failed to allocate buffer, ret =3D %d\n"=
, ret);
> +               goto out;
> +       }
> +
> +       for (i =3D 0; i < ITERATIONS; i++) {
> +               fprintf(stdout, "iteration number %d, writing data\n", i)=
;
> +
> +               for (w =3D 0; w < WRITE_COUNT; w++) {
> +                       memset(buff, w, BUF_SIZE);
> +                       ret =3D pwrite(fd, buff, BUF_SIZE, WRITE_OFFSET);
> +                       if (ret !=3D BUF_SIZE) {
> +                               fprintf(stderr, "failed to write buff, "
> +                                               "ret =3D %d, errno =3D %d=
\n",
> +                                               ret, errno);
> +                               goto out;
> +                       }
> +               }
> +
> +               sleep(5);

There should be a macro for this.

Thanks,
Jesse Taube

> +               fprintf(stdout, "validating written data\n");
> +
> +               ret =3D pread(fd, buff, BUF_SIZE, READ_OFFSET);
> +               if (ret !=3D BUF_SIZE) {
> +                       fprintf(stderr, "failed to read buff, "
> +                                       "ret =3D %d, errno =3D %d\n",
> +                                       ret, errno);
> +                       goto out;
> +               }
> +
> +               for (off =3D 0; off < BUF_SIZE; off++) {
> +                       if (buff[off] !=3D WRITE_COUNT - 1) {
> +                               fprintf(stdout, "validation failed\n");
> +                               goto out;
> +                       }
> +               }
> +
> +               fprintf(stdout, "successfully validated\n");
> +               sleep(DELAY);
> +       }
> +
> +out:
> +       fprintf(stdout, "finished %s test program\n", basename(argv[0]));
> +       close(fd);
> +       return ret;
> +}
> --
> 2.55.0
>

