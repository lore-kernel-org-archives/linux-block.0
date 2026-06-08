Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1E124DFF9
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923700; cv=pass; b=aPRMdkxWa4NI+VUp1G+MtGsxDZmQZQqlJlHEGR+RXoUVtjwZR0BXnd+ZQc3kcPvxcrT9qkiKDEfRL0Fh5kWUlZr0NyQdpJgWkJfpuoRxc5NhUQf599l/CQPeXkdZ4G/TkFxO9uJtxtWzFaT1eAhbM4EznS812yr/GIxd07ugdoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923700; c=relaxed/simple;
	bh=vVjU3pwVlqs1eGL3LgvYGVSpYqf3o7An1hUHG7tFne0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJ+5BvYLDoTyvAJY6psTfymiSqXWzb3RRFIi0hPQN5+F/T11haZ3YpUUpT+FfWD1zPCzfjRaqUt7SHIWwvW+VK5/kSC00piPxUGNLN13CLWO6tcmoedKgY3//E/e6p5pMQwDKnRc3ixq2fguOswZoEriEMfT6+cBvIi+vtUY5vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j+rUH7yN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kgeLxsR4; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j+rUH7yN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kgeLxsR4"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658Cmo0A3593696
	for <linux-block@vger.kernel.org>; Mon, 8 Jun 2026 13:01:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1xsUP1loZg3jYdsBk6X4zW9T5zMq3W/iPnEHzKVjyxY=; b=j+rUH7yNKShbdNZr
	MqPeI10vwdoPUpfzUXM9yE67URwfG9f0JDVVLUsjGLRvD/v/a5wWvZlAOk53MIGY
	LjIAmHuiq0Y7nQzBPMV/sLmmLpmTz4Z2Fhhe/9VKFllEevVNCvaKfs8Deh5mgVbP
	XZUGYjS4x+joNYUOgYpqmjey1ARbnX7M9WqpEK2EfdQcRxxz5b4N181GIbqfv7uu
	AHI36YCPoIxY5nEoCxDPPjX9+bOXKPxuxWB9fJL6ElDeMVwZj8kFrxTqi+vtPS6B
	0U4A2fZclkQlc0vqe0jegAp6NKsUhWozFi7CmVerYMI7Q+oOXk65aSmTgo/iXTPD
	nmpo6g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enx2rr1kv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 13:01:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9157ae36434so147977485a.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 06:01:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780923695; cv=none;
        d=google.com; s=arc-20240605;
        b=ZctAXjKTqYfFyRMR7eN5cpotx61LeVmIsbY4Yv7gF3xNbRxfJWto2VZX9fa88gjRFF
         VfNYY2pnam0Foa7PxhsyXiBebvk6KZNydsQ9fwtrweMzVPPmzDCiMMMFCntLJHwXEuZY
         nLcI+UwUmbliIhynHy6IAzqSL+s9PRUQxnCa0fHVly/0Uu/b/iLjj9/ksajuoo3vYuEd
         d448cExMKKIW1FB2SzkhCJ7AI7RmR55atJzhE5RdtqVzu9ff27W7ZF1gVdg4Hww3rhn5
         tVs8B+0ladN7l4xSx6fjCM3mbkV6E6HpO2R8cSkZ4hZBIcbGMkPwcRXSCXV77s7DzV/X
         8sog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1xsUP1loZg3jYdsBk6X4zW9T5zMq3W/iPnEHzKVjyxY=;
        fh=ZKstVHb2nnwR02/2Bx+27XauQ33ou6KY+hbJs7La4Sc=;
        b=N/KHGlljfdYZb/gZvW/e8Y7xtBo0xYmyi9xhEzY1FsVE7UP7wxu8iAscJllRn3bVWp
         WH0wIh9vWF/q/GK3FS78rYFEGH2P5MaIuxSklHcGCseZ7FCv9TlgHBXumnCjcW1WYdo8
         wo812eNzOD+ayIHToi6H5pSkVRSWZrxSppOu1ipbHaiYk18wjqzeduukkRNOffe1iB99
         DYOLRRkoSOR26ki94nr7x+rJn9Z7xRFNIcHg0EwE2CDkK2RGtn9TaKIE3RQ2GPq8FlLV
         82uS0RFDqOTNuaGQynmE3joadyE85GucDL8HHzG2eVO18U2u8BBoVW+GkTmwCa93TTQ2
         t9rQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780923695; x=1781528495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xsUP1loZg3jYdsBk6X4zW9T5zMq3W/iPnEHzKVjyxY=;
        b=kgeLxsR4tjdB2/+wCRH6qqOl2NKxO1Sfj7FxeBkaimwoD2DfglXsgphc5EnOxhmnNO
         PTe0z33AhHF20/icqtbb8h1nRfGRr/53waAavMlrY8GhwLvZH0tbh5ITG5LTlLP4J0d6
         o8pHzIb0JLPhlrZw71i1d3daavCosvzyNpeY+OoMh+ozLMrBhZxtSsrM9ur2RXfj2SRd
         CulRmLTB3GGfKC41sPt8UdyMuthCNqm2vTqgATdpE4oPxlx0ffoPpcjpVOSLB6TGwVcE
         8qqmzDtgy1ZDxJycG27Bo2jyxL5GGVExdJbIsIa3pCUHukr4dyFgnTdnsXfO2/AwYHua
         PlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780923695; x=1781528495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1xsUP1loZg3jYdsBk6X4zW9T5zMq3W/iPnEHzKVjyxY=;
        b=ji5dZd55oeUVe894XF9OcQ8t2qdeITbukWbW3+VC7tOVjZXlVm7/i0NFxYwI3XzHXx
         k1ZtMEYtPXwAlW2010e7iemNvHRZzudpjR3QdyFMlfDH6fYqS4+2UM7thmSxNkKXSb+p
         G41M3J/63+GodxItDDJDpQchQcXbaS9X9fOUbLkVxmQ8IyeondIL2NzA7qJ7dW0RsgL1
         gTAhn88yd9UDlMt16V+BnEKSv2Yl7DUmTK4RxS9thg7LfBumhV/VRy/u5MJtwczsXq9t
         +xCubWHgPOQOO+b6ds0V6ERVYHg1hdL+FHjRrmHYs39CXA2bh0ImhY49sax3TY+bzSJ7
         xwOA==
X-Forwarded-Encrypted: i=1; AFNElJ8TVywLrtd5Xkz3bLrLfqRBBqvP8D4zKsNfceRbgs1Jfn+uZomNVw/WE1TFOrjRTav+gglPjg51iS+OWw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyAK64Z9zugzWyDWBowwPAW/yBKJ102W0XxqwOkEq1Ksryv4yx
	IFkYe7sx5xfCU1ThK2tgqNiMmFDB+KifzPlNuK3uZtsBPqHU2euHS0C6h0yLIWCxun+p2gdt5x1
	ITslVb1gCc1ystCcZSmq/ZjJtQW/K4r8y/6DXEWB0ThODk6Qfb+r99CrMPgSp/tLDNK4IlSVyW9
	5GfWW1+yNmSJkX6jl/v2j+q9rDIAOSSh8KEpKTI4Lq
X-Gm-Gg: Acq92OEFdDMkwi+5K8JVAaxlR5/RYEDCcKSMp3/c9ZyuVtcpQz/RoU9dI8SmG67+MIt
	IIW4EebaOGNhfRckFY5xUSdkQFSAxX/F+KhgflnCbfWlTOXG2x8FSR6kzsg0DxHpr2oLtEAkZPN
	9ev0qEw50psXukTdBrKN+atZXWZxvB1GJBesNC1DkGZaF2qN5Gm5622zzPNdF6B/UAoSyB2ZXLx
	I1azZ8PnedqlLrsVgSeVzq6hUQK5seS4wFscrjwrVSC2oFg2lHnZ2DEPqyEq+4chU1JpzrxA+Kx
	Zak2Rpqoknpq97gPbLgQpTTTCa/J5oYR
X-Received: by 2002:a05:620a:454b:b0:915:2404:bfe9 with SMTP id af79cd13be357-915a9c35852mr2535979385a.9.1780923694460;
        Mon, 08 Jun 2026 06:01:34 -0700 (PDT)
X-Received: by 2002:a05:620a:454b:b0:915:2404:bfe9 with SMTP id
 af79cd13be357-915a9c35852mr2535551485a.9.1780923662522; Mon, 08 Jun 2026
 06:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
 <20260608-block-as-nvmem-v3-4-82681f50aa35@oss.qualcomm.com> <CAMRc=McmoWvezeH05_5AR7ZbAyg1L567HsKWbuD7711LwnjV0Q@mail.gmail.com>
In-Reply-To: <CAMRc=McmoWvezeH05_5AR7ZbAyg1L567HsKWbuD7711LwnjV0Q@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 15:00:51 +0200
X-Gm-Features: AVVi8Cc-wgzw5gsLbwZHUHPYEgpxejd9uRTmITt11-0eb6tOd2NzMwDpPGAFaCc
Message-ID: <CAFEp6-0JaOd8PpqMY_21BEDyDyYx1kDfskOS4VSd8nxP4KBXZw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] block: implement NVMEM provider
To: Bartosz Golaszewski <brgl@kernel.org>, daniel@makrotopia.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: k4bPQDZXC4oSamdzxnbJcaskm5oD7pt1
X-Proofpoint-ORIG-GUID: k4bPQDZXC4oSamdzxnbJcaskm5oD7pt1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyMyBTYWx0ZWRfX4S5398CBTPfa
 puIf4dRk+VcHP0pJHRpdXMALIKfcL17gJVF09dr9acx8cjDl+HTAO0vzYtGsd/0hXygWG4c4xJl
 Q28fNrUh7PdNYP/8hPMdO/Darc0iEkOqzmHpJk2FZAmQ9fOswA7P6l/DkCnO+mmZoFNBv9SXn4F
 fnMAqVDZebxER8PlXIP+01mbSWbzTfNfci7GOIngInjM1T+Sgiar/zUBJiwMQVlI9hivkEeS3dO
 Oz2klYvHW6fgElkvSSLqsdpwqeOCI/rMqutCPvzFE55n3jvrlnM17a16n+KM8lUR10yukQCQK5k
 VZxSR83Kn0PMQNPWyG14iXXTSHPMAT/9D4tKAoawTqgiUwROOT3tKFt1HlSCXf40urr+huwlsxd
 iFXipr6QZg+wGlAApCzoWZ56pqarHg==
X-Authority-Analysis: v=2.4 cv=JdqMa0KV c=1 sm=1 tr=0 ts=6a26bd2f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VT4XjZGOAAAA:8
 a=IjnKPMcg25KrRLxKrC4A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080123

On Mon, Jun 8, 2026 at 1:17=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.org=
> wrote:
>
> On Mon, 8 Jun 2026 12:50:41 +0200, Loic Poulain
> <loic.poulain@oss.qualcomm.com> said:
> > From: Daniel Golle <daniel@makrotopia.org>
> >
> > On embedded devices using an eMMC it is common that one or more partiti=
ons
> > on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPRO=
M
> > data. Allow referencing the partition in device tree for the kernel and
> > Wi-Fi drivers accessing it via the NVMEM layer.
> >
> > To safely defer the freeing of the provider private data until all
> > consumers have released their cells, a nvmem_dev() accessor is added to
> > the NVMEM core to expose the struct device embedded in struct nvmem_dev=
ice.
> > This allows registering a devm action on the nvmem device itself, ensur=
ing
> > the private data outlives any active cell references.
> >
> > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  block/Kconfig                  |   9 +++
> >  block/Makefile                 |   1 +
> >  block/blk-nvmem.c              | 171 +++++++++++++++++++++++++++++++++=
++++++++
> >  drivers/nvmem/core.c           |  13 ++++
> >  include/linux/nvmem-consumer.h |   6 ++
> >  5 files changed, 200 insertions(+)
> >
> > diff --git a/block/Kconfig b/block/Kconfig
> > index 15027963472d7b40e27b9097a5993c457b5b3054..0b33747e16dc33473683706=
f75c92bdf8b648f7c 100644
> > --- a/block/Kconfig
> > +++ b/block/Kconfig
> > @@ -209,6 +209,15 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
> >         by falling back to the kernel crypto API when inline
> >         encryption hardware is not present.
> >
> > +config BLK_NVMEM
> > +     bool "Block device NVMEM provider"
> > +     depends on OF
> > +     depends on NVMEM
> > +     help
> > +       Allow block devices (or partitions) to act as NVMEM providers,
> > +       typically used with eMMC to store MAC addresses or Wi-Fi
> > +       calibration data on embedded devices.
> > +
> >  source "block/partitions/Kconfig"
> >
> >  config BLK_PM
> > diff --git a/block/Makefile b/block/Makefile
> > index 7dce2e44276c4274c11a0a61121c83d9c43d6e0c..d7ac389e71902bc091a8800=
ea266190a43b3e63d 100644
> > --- a/block/Makefile
> > +++ b/block/Makefile
> > @@ -36,3 +36,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION) +=3D blk-crypto.o=
 blk-crypto-profile.o \
> >                                          blk-crypto-sysfs.o
> >  obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK) +=3D blk-crypto-fallback.=
o
> >  obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)        +=3D holder.o
> > +obj-$(CONFIG_BLK_NVMEM)                +=3D blk-nvmem.o
> > diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..99c7728fb7bccdc2216780a=
73a89a9210f925049
> > --- /dev/null
> > +++ b/block/blk-nvmem.c
> > @@ -0,0 +1,171 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * block device NVMEM provider
> > + *
> > + * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + *
> > + * Useful on devices using a partition on an eMMC for MAC addresses or
> > + * Wi-Fi calibration EEPROM data.
> > + */
> > +
> > +#include <linux/cleanup.h>
> > +#include <linux/mutex.h>
> > +#include <linux/nvmem-provider.h>
> > +#include <linux/nvmem-consumer.h>
> > +#include <linux/of.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/property.h>
> > +
> > +#include "blk.h"
> > +
> > +
>
> Stray newline?
>
> > +/* List of all NVMEM devices */
> > +static LIST_HEAD(nvmem_devices);
> > +static DEFINE_MUTEX(devices_mutex);
> > +
> > +struct blk_nvmem {
> > +     struct nvmem_device     *nvmem;
> > +     dev_t                   devt;
> > +     struct list_head        list;
> > +};
> > +
> > +static int blk_nvmem_reg_read(void *priv, unsigned int from,
> > +                           void *val, size_t bytes)
> > +{
> > +     blk_mode_t mode =3D BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES;
> > +     struct blk_nvmem *bnv =3D priv;
> > +     size_t bytes_left =3D bytes;
> > +     struct file *bdev_file;
> > +     loff_t pos =3D from;
> > +     int ret =3D 0;
> > +
> > +     bdev_file =3D bdev_file_open_by_dev(bnv->devt, mode, priv, NULL);
> > +     if (!bdev_file)
> > +             return -ENODEV;
> > +
> > +     if (IS_ERR(bdev_file))
> > +             return PTR_ERR(bdev_file);
> > +
> > +     while (bytes_left) {
> > +             pgoff_t f_index =3D pos >> PAGE_SHIFT;
> > +             struct folio *folio;
> > +             size_t folio_off;
> > +             size_t to_read;
> > +
> > +             folio =3D read_mapping_folio(bdev_file->f_mapping, f_inde=
x, NULL);
> > +             if (IS_ERR(folio)) {
> > +                     ret =3D PTR_ERR(folio);
> > +                     goto err_release_bdev;
> > +             }
> > +
> > +             folio_off =3D offset_in_folio(folio, pos);
> > +             to_read =3D min(bytes_left, folio_size(folio) - folio_off=
);
> > +             memcpy_from_folio(val, folio, folio_off, to_read);
> > +             pos +=3D to_read;
> > +             bytes_left -=3D to_read;
> > +             val +=3D to_read;
> > +             folio_put(folio);
> > +     }
> > +
> > +err_release_bdev:
> > +     fput(bdev_file);
>
> There's a __free() action defined in linux/file.h so you can use:
>
>         struct file *bdev_file __free(fput) =3D ...
>
> and avoid this label.

Ok, thanks, will use.

>
> > +
> > +     return ret;
> > +}
> > +
> > +static int blk_nvmem_register(struct device *dev)
> > +{
> > +     struct device_node *child, *np =3D dev_of_node(dev);
> > +     struct block_device *bdev =3D dev_to_bdev(dev);
> > +     struct nvmem_config config =3D {};
> > +     struct blk_nvmem *bnv;
> > +
> > +     /* skip devices which do not have a device tree node */
> > +     if (!np)
> > +             return 0;
> > +
> > +     /* skip devices without an nvmem layout defined */
> > +     child =3D of_get_child_by_name(np, "nvmem-layout");
> > +     if (!child)
> > +             return 0;
> > +     of_node_put(child);
>
> Same as above, can be:
>
>         struct device_node *child __free(device_node) =3D=3D ...

Ack.

>
> > +
> > +     /*
> > +      * skip block device too large to be represented as NVMEM devices=
,
> > +      * the NVMEM reg_read callback uses an unsigned int offset
> > +      */
> > +     if (bdev_nr_bytes(bdev) > UINT_MAX)
> > +             return -EFBIG;
>
> This will mean a failed probe. Wouldn't it be better to use -ENODEV?

That would indeed be an appropriate error.

>
> > +
> > +     bnv =3D kzalloc_obj(*bnv);
> > +     if (!bnv)
> > +             return -ENOMEM;
> > +
> > +     config.id =3D NVMEM_DEVID_NONE;
> > +     config.dev =3D &bdev->bd_device;
> > +     config.name =3D dev_name(&bdev->bd_device);
> > +     config.owner =3D THIS_MODULE;
> > +     config.priv =3D bnv;
> > +     config.reg_read =3D blk_nvmem_reg_read;
> > +     config.size =3D bdev_nr_bytes(bdev);
> > +     config.word_size =3D 1;
> > +     config.stride =3D 1;
> > +     config.read_only =3D true;
> > +     config.root_only =3D true;
> > +     config.ignore_wp =3D true;
> > +     config.of_node =3D to_of_node(dev->fwnode);
> > +
> > +     bnv->devt =3D bdev->bd_device.devt;
> > +     bnv->nvmem =3D nvmem_register(&config);
> > +     if (IS_ERR(bnv->nvmem)) {
> > +             dev_err_probe(&bdev->bd_device, PTR_ERR(bnv->nvmem),
> > +                           "Failed to register NVMEM device\n");
> > +             kfree(bnv);
> > +             return PTR_ERR(bnv->nvmem);
> > +     }
> > +
> > +     scoped_guard(mutex, &devices_mutex)
> > +             list_add_tail(&bnv->list, &nvmem_devices);
>
> I'm not sure I understand the need to store these? Whatever you need to d=
o in
> remove() can be scheduled in a devres action here.

I think the devm_ approach would work fine in practice. The only
difference is that NVMEM unregistration would be delayed from
device_del() to device_release(), but during that window any read
attempt would simply return -ENODEV, so there is no real race or
safety concern AFAIU. I guess the explicit list was initially kept to
mirror the add_dev/remove_dev symmetry of the class interface. But,
except if there is no strong technical argument against devm_, I will
switch to that simpler approach in the next version.

Daniel, feel free to nack or ask for authorship removal if needed.
This patch submitted in your name has accumulated enough changes since
the original submission that the current shape may no longer reflect
your intent.

>
> > +
> > +     return 0;
> > +}
> > +
> > +static void blk_nvmem_unregister(struct device *dev)
> > +{
> > +     struct blk_nvmem *bnv_c, *bnv_t, *bnv =3D NULL;
> > +
> > +     scoped_guard(mutex, &devices_mutex) {
> > +             list_for_each_entry_safe(bnv_c, bnv_t, &nvmem_devices, li=
st) {
> > +                     if (bnv_c->devt =3D=3D dev_to_bdev(dev)->bd_devic=
e.devt) {
> > +                             bnv =3D bnv_c;
> > +                             list_del(&bnv->list);
> > +                             break;
> > +                     }
> > +             }
> > +
> > +             if (!bnv)
> > +                     return;
> > +     }
> > +
> > +     nvmem_unregister(bnv->nvmem);
> > +     kfree(bnv);
> > +}
> > +
> > +static struct class_interface blk_nvmem_bus_interface __refdata =3D {
> > +     .class =3D &block_class,
> > +     .add_dev =3D &blk_nvmem_register,
> > +     .remove_dev =3D &blk_nvmem_unregister,
> > +};
> > +
> > +static int __init blk_nvmem_init(void)
> > +{
> > +     int ret;
> > +
> > +     ret =3D class_interface_register(&blk_nvmem_bus_interface);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return 0;
> > +}
> > +device_initcall(blk_nvmem_init);
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index 311cb2e5a5c02d2c6979d7c9bbb7f94abdfbdad1..ee3481229c20b3063c86d0d=
d66aabbf6b5e29169 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -2154,6 +2154,19 @@ const char *nvmem_dev_name(struct nvmem_device *=
nvmem)
> >  }
> >  EXPORT_SYMBOL_GPL(nvmem_dev_name);
> >
> > +/**
> > + * nvmem_dev() - Get the struct device of a given nvmem device.
> > + *
> > + * @nvmem: nvmem device.
> > + *
> > + * Return: pointer to the struct device of the nvmem device.
> > + */
> > +struct device *nvmem_dev(struct nvmem_device *nvmem)
> > +{
> > +     return &nvmem->dev;
> > +}
> > +EXPORT_SYMBOL_GPL(nvmem_dev);
>
> This should still be a separate patch.

Well yes, actually I should even remove this as this is no more needed.

Regards,
Loic
