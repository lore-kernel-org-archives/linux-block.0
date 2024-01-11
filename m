Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DFB1366
	for <linux-block@vger.kernel.org>; Thu, 11 Jan 2024 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MwkgIMCJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704936319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ESfjQ0jWiBunyG2uBniDMtDH4nMEu78Nkty9LDM7sw=;
	b=MwkgIMCJVxai1XbfUYD5a0o6s8AvXaErFq28QnaFugBjcrZZRJaqjskaRi6gTLbSM/qgfN
	bawCJjt9o6MICB/7gPlcNCrNmMHI98bcsWfrpEcbtldBkANmtJSJCvEQsB56/K+mRMiHN4
	LR4wmaSEia4RSw+SbwsNkVHR3EDHGdk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-oRCGED-PMq-VhYB_ZsUdJw-1; Wed, 10 Jan 2024 20:25:18 -0500
X-MC-Unique: oRCGED-PMq-VhYB_ZsUdJw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5cdba9861b1so2827512a12.1
        for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 17:25:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704936317; x=1705541117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ESfjQ0jWiBunyG2uBniDMtDH4nMEu78Nkty9LDM7sw=;
        b=dfY2UnXsOcByRUw+vueq10VJHuykLwQBi5WlVj4xg5O3QOgsVk/mIrIL6Uepj8Kq8r
         e/cjwjTC/Tqa7CH+VaKIKMp1OTbjiCicp3ufo7aI3JxaKatvI2LX3m/nEsSAB3+5C8uM
         J2lf1sL14tH1yekZyPbthXbkgd9y7A07CiYf0pEKGDaK7DzostWCSYTwfc5Q2qycA/fp
         pHtl8cVfJK1BUJSb1kSO3nw/ebudXDDJJEeAAQRb/ug8qF0a9bx/OPNWjUl53iIkNnjQ
         o+o1yJJe4arc5e9llbwe4ut2veamzpE7XC0TsQKLXl8fFDpInkuR59Wbf83iGVEX2Cb4
         1IIQ==
X-Gm-Message-State: AOJu0YwI044E09DQO8P+mfHafVAr8f9ui7sA2QNFq2u3ADsX8pwnP4eg
	0gaGYo31qTwJbqbQSGfxwtHr4h6NBYnFiwkyVnfoBxkUlfO4nl/BZkSsQWeGF38qJUJDVMuax+D
	P9Gbx3ewp136MaOGykK8Q7U4JpG/nFpym5ogl8OjeYOZxDgA=
X-Received: by 2002:a05:6a20:1449:b0:19a:4fac:3e52 with SMTP id a9-20020a056a20144900b0019a4fac3e52mr132619pzi.106.1704936316962;
        Wed, 10 Jan 2024 17:25:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtPYYA8HYaVG8BNNUf2wiSlku54LRcIV6lAA2JAekRYHR9QOTY0DX907K3pIDfg8Ow+RkrC0nHuhxF9OD5bYc=
X-Received: by 2002:a05:6a20:1449:b0:19a:4fac:3e52 with SMTP id
 a9-20020a056a20144900b0019a4fac3e52mr132613pzi.106.1704936316678; Wed, 10 Jan
 2024 17:25:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110035756.9537-1-kch@nvidia.com>
In-Reply-To: <20240110035756.9537-1-kch@nvidia.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Thu, 11 Jan 2024 09:25:04 +0800
Message-ID: <CAHj4cs__ObsuA_hXHeSRPwHy-uSc558sxQy-jD2J85gQEg4BXw@mail.gmail.com>
Subject: Re: [PATCH] nvme: add nvme pci timeout testcase
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	shinichiro.kawasaki@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 11:58=E2=80=AFAM Chaitanya Kulkarni <kch@nvidia.com=
> wrote:
>
> Trigger and test nvme-pci timeout with concurrent fio jobs.
>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  tests/nvme/050     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/050.out |  2 ++
>  2 files changed, 45 insertions(+)
>  create mode 100755 tests/nvme/050
>  create mode 100644 tests/nvme/050.out
>
> diff --git a/tests/nvme/050 b/tests/nvme/050
> new file mode 100755
> index 0000000..ba54bcd
> --- /dev/null
> +++ b/tests/nvme/050
> @@ -0,0 +1,43 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2024 Chaitanya Kulkarni.
> +#
> +# Test NVMe-PCI timeout with FIO jobs by triggering the nvme_timeout fun=
ction.
> +#
> +
> +. tests/nvme/rc

How about restricting this test to pci only? just like nvme/032 did.
nvme_trtype=3Dpci

> +
> +DESCRIPTION=3D"test nvme-pci timeout with fio jobs."
> +
> +requires() {
> +       _require_nvme_trtype pci
> +       _have_fio
> +       _nvme_requires
> +}

Check the test dev is nvme:
device_requires() {
        _require_test_dev_is_nvme
}

> +
> +test() {

Use test_device() here.

> +       local dev=3D"/dev/nvme0n1"
> +
> +       echo "Running ${TEST_NAME}"
> +
> +       echo 1 > /sys/block/nvme0n1/io-timeout-fail
> +
> +       echo 99 > /sys/kernel/debug/fail_io_timeout/probability
> +       echo 10 > /sys/kernel/debug/fail_io_timeout/interval
> +       echo -1 > /sys/kernel/debug/fail_io_timeout/times
> +       echo  0 > /sys/kernel/debug/fail_io_timeout/space
> +       echo  1 > /sys/kernel/debug/fail_io_timeout/verbose
> +
> +       # shellcheck disable=3DSC2046
> +       fio --bs=3D4k --rw=3Drandread --norandommap --numjobs=3D$(nproc) =
\
> +           --name=3Dreads --direct=3D1 --filename=3D${dev} --group_repor=
ting \
> +           --time_based --runtime=3D1m 2>&1 | grep -q "Input/output erro=
r"
> +
> +       # shellcheck disable=3DSC2181
> +       if [ $? -eq 0 ]; then
> +               echo "Test complete"
> +       else
> +               echo "Test failed"
> +       fi
> +       modprobe -r nvme
> +}
> diff --git a/tests/nvme/050.out b/tests/nvme/050.out
> new file mode 100644
> index 0000000..b78b05f
> --- /dev/null
> +++ b/tests/nvme/050.out
> @@ -0,0 +1,2 @@
> +Running nvme/050
> +Test complete
> --
> 2.40.0
>
>


--=20
Best Regards,
  Yi Zhang

