Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD8194A7C
	for <linux-block@vger.kernel.org>; Tue,  7 Jan 2025 07:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736235467; cv=none; b=Snplsp6WR32TeKuQ/qpq9/7KI56EjRfkmeTqjdPL2J2R3vZ2wuokEfeegZUlLHndErkGrpoHdudBNVNq3GBDLuKovALUEKYTZEn77+CmbSqHHX0hv/8ZzEGgLLbcZNPTGRRzdHvf2/gO057tGikrkWcwpvgbrm0SK2BfEtzV+P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736235467; c=relaxed/simple;
	bh=G0SNaoKmbujuoRbYi3RItEIAYIfkojoXo0Uyf/uEh+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RB5g1d4Rg5ZqeWzqsw+KOGVHuETmao0vWahdkpW+vTLW+hE2de5hy7ItHvNAt3miwR3LS+9nCO+5hyvI5p5iZoScUCXoWw1+Uke69NLaY4YSleCuUE+ll0OC5Nnu5KRSt8EDryTTqwcqS/sGoBXVXoU/CGd/seDz12SItamd8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=cIIse52q; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="cIIse52q"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3ce64e7e5so2844215a12.0
        for <linux-block@vger.kernel.org>; Mon, 06 Jan 2025 23:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1736235461; x=1736840261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bx+19x0B2gmDNiPmEgOxy9mSgxj2NhTgxhyx+fJPwMI=;
        b=cIIse52qF9qKKdbDe8MRc5La1gHFmZM84uUFajFRqyyoVbkCGxUOkZKV/q6bF1JMbL
         WmVMsJHiZ29qEzdyxgLhE4xEHEDwxYj6zHDr+gK9MSnJGo+6qrdA3O4b9R8E+5ZkOQTY
         FdZN3hVylVvjfLYSiyoTOknt5vHzTZ3N6yI7G/QtGZurNKy/ow4X3gQDzD9+PJachTpe
         HQpWWtzr/hH7kLrUcwx0rf599oyDVvhL/HRbuDDywTMqHddMlaOr4Pnb7Srpo6IKBHPG
         jsCACtjoxru99YL89iNd3d1CG2rtR7WIikqtj0joljKi8JtStzv6Mk8acpz1tHaQAvY9
         aOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736235461; x=1736840261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bx+19x0B2gmDNiPmEgOxy9mSgxj2NhTgxhyx+fJPwMI=;
        b=EfnqXRcr/Zxsw2iET/mVuYmw2j/NnGyXUavGjButA3VcpB7ZS3y3ifbCB1HcJW4VXO
         OKcMKx/qViYbnuLnizBzgjIY6vpJu4Lm3m+N8Y+L/TsML1goplFgAWr0enM2rQsO1QUV
         /tAEclbmU59TNZbaz+94oHvqcXjUH5CgHuD63c+pvUyqqJOtUFIjdCilRvJBmuh27LJO
         Wp+4f0+qrm6jTYClvSeJmcwu0Ei3wARXtI89Rf8mg/r0CQxqaspRu3NbdDMlOKoBKudk
         Sm0ZpM33kn4r4KGspAy2WDqu7ZSsVIKmEN+gHN8Up22oZyk4mBZoHN5pucfBavqYyaWL
         3f4g==
X-Gm-Message-State: AOJu0YyczGyC2R4pqPYm/5I7vFzrV9QgUQbNcyZ8f4dwE6JC/uYu7dXb
	Ov4DAd6tzjR6CgAspMYsp8OoY+c6+cys8aNBu5AzbfQlgkJY+iN3omnYBknFNBrjGmJIYHE/cfc
	ToiKnkdrfhzHsFNCFA2Byzt8Anxbk+fswUcgr2+SCCjYt13rB
X-Gm-Gg: ASbGnct40Z9BNaSehvDwbZNknjCl71Vr5svoJwvY+1iizJ5Us0XF86MGhI2Iy5z1piB
	vvcxlqY505NCi52rfur3ZyjrV1VjutT0VPo+2gMlU2GvIc+5H6zzYsiBmIygLFdVy0HR1SGE=
X-Google-Smtp-Source: AGHT+IFHiWN7HRV0tjVYeqqyJzr7VZvRlCA285ZkJj39Az5Q+NOXa/GqcYy3kqLT8UjvlN/1cFajXcSI9RNarU2euj8=
X-Received: by 2002:a05:6402:2790:b0:5d0:e852:dca0 with SMTP id
 4fb4d7f45d1cf-5d81de1c377mr21426236a12.11.1736235461329; Mon, 06 Jan 2025
 23:37:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107060810.91111-1-lizhijian@fujitsu.com>
In-Reply-To: <20250107060810.91111-1-lizhijian@fujitsu.com>
From: Jinpu Wang <jinpu.wang@ionos.com>
Date: Tue, 7 Jan 2025 08:37:30 +0100
Message-ID: <CAMGffEmi5odRsHvjbqXiLNvuy8AFMJBOw1vv7HHGE9kep=HGgA@mail.gmail.com>
Subject: Re: [PATCH blktests v4 1/2] tests/rnbd: Add a basic RNBD test
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com, 
	linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 7:08=E2=80=AFAM Li Zhijian <lizhijian@fujitsu.com> w=
rote:
>
> It attempts to connect and disconnect the rnbd service on localhost.
> Actually, It also reveals a real kernel issue[0].
>
> rnbd/001 (Start Stop RNBD)                                   [passed]
>     runtime  1.425s  ...  1.157s
>
> Please note that currently, only RTRS over RXE is supported.
>
> [0] https://lore.kernel.org/linux-rdma/20241231013416.1290920-1-lizhijian=
@fujitsu.com/
>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Thx for the patch, LGTM
Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> ---
> V4:
>   test start_soft_rdma # Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com=
>
> V3:
>   new patch, add a seperate basic rnbd test and simplify the _start_rnbd_=
client
>
> Copy to the RDMA/rtrs guys:
>
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> ---
>  tests/rnbd/001     | 39 ++++++++++++++++++++++++++++++++++
>  tests/rnbd/001.out |  2 ++
>  tests/rnbd/rc      | 52 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 93 insertions(+)
>  create mode 100755 tests/rnbd/001
>  create mode 100644 tests/rnbd/001.out
>  create mode 100644 tests/rnbd/rc
>
> diff --git a/tests/rnbd/001 b/tests/rnbd/001
> new file mode 100755
> index 000000000000..ace2f8ea8a2b
> --- /dev/null
> +++ b/tests/rnbd/001
> @@ -0,0 +1,39 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
> +#
> +# Basic RNBD test
> +#
> +. tests/rnbd/rc
> +
> +DESCRIPTION=3D"Start Stop RNBD"
> +CHECK_DMESG=3D1
> +QUICK=3D1
> +
> +requires() {
> +       _have_rnbd
> +       _have_loop
> +}
> +
> +test_start_stop()
> +{
> +       _setup_rnbd || return
> +
> +       local loop_dev
> +       loop_dev=3D"$(losetup -f)"
> +
> +       if _start_rnbd_client "${loop_dev}"; then
> +               sleep 0.5
> +               _stop_rnbd_client || echo "Failed to disconnect rnbd"
> +       else
> +               echo "Failed to connect rnbd"
> +       fi
> +
> +       _cleanup_rnbd
> +}
> +
> +test() {
> +       echo "Running ${TEST_NAME}"
> +       test_start_stop
> +       echo "Test complete"
> +}
> diff --git a/tests/rnbd/001.out b/tests/rnbd/001.out
> new file mode 100644
> index 000000000000..c1f9980d0f7b
> --- /dev/null
> +++ b/tests/rnbd/001.out
> @@ -0,0 +1,2 @@
> +Running rnbd/001
> +Test complete
> diff --git a/tests/rnbd/rc b/tests/rnbd/rc
> new file mode 100644
> index 000000000000..a5edc2e5ad9c
> --- /dev/null
> +++ b/tests/rnbd/rc
> @@ -0,0 +1,52 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
> +#
> +# RNBD tests.
> +
> +. common/rc
> +. common/multipath-over-rdma
> +
> +_have_rnbd() {
> +       if [[ "$USE_RXE" !=3D 1 ]]; then
> +               SKIP_REASONS+=3D("Only USE_RXE=3D1 is supported")
> +       fi
> +       _have_driver rdma_rxe
> +       _have_driver rnbd_server
> +       _have_driver rnbd_client
> +}
> +
> +_setup_rnbd() {
> +       start_soft_rdma || return $?
> +
> +       for i in $(rdma_network_interfaces)
> +       do
> +               ipv4_addr=3D$(get_ipv4_addr "$i")
> +               if [[ -n "${ipv4_addr}" ]]; then
> +                       def_traddr=3D${ipv4_addr}
> +               fi
> +       done
> +}
> +
> +_cleanup_rnbd()
> +{
> +       stop_soft_rdma
> +}
> +
> +_stop_rnbd_client() {
> +       local s sessions
> +
> +       sessions=3D$(ls -d /sys/block/rnbd* 2>/dev/null)
> +       for s in $sessions
> +       do
> +               grep -qx blktest "$s"/rnbd/session && echo "normal" > "$s=
"/rnbd/unmap_device
> +       done
> +}
> +
> +_start_rnbd_client() {
> +       local blkdev=3D$1
> +
> +       # Stop potential remaining blktest sessions first
> +       _stop_rnbd_client
> +       echo "sessname=3Dblktest path=3Dip:$def_traddr device_path=3D$blk=
dev" > /sys/devices/virtual/rnbd-client/ctl/map_device
> +}
> --
> 2.47.0
>
