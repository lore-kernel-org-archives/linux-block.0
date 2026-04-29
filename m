Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9B40B6E0
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479757; cv=pass; b=fSQLqhWY4wX6GUB6dMhyzGsrNIprnwtQhW7tMlXdYAqO1mWpf79nWoHAMSndU5w61hTkpB4kE3xwLweD9E4MrLuAAtHXe1aWnBfu98sTDsQnSzzz7peo8t388BcH4vE6ZfJBjCwKDPBCCzGeTC0sh4+wNrvrN6daRCl/WFVoCn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479757; c=relaxed/simple;
	bh=zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gV3129qFrlEYZJhmPOeLVAQaHDX4cDuGW1Mz6P8ffjOTWeIQ/c+gxy9Wep9u3lFcPU4B17Jc2As/OwL/JRAdE5omhjbdCWC+hWIS8GcWTfu7TgIJsn9JHRD1JzO+nETK9uKIn9STC0xK7ogVNYa34YfLZGe1nQT3GZyDvCNcV7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jzRi40++; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GkK2GDLC; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jzRi40++";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GkK2GDLC"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TFgPCU901799
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 16:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=; b=jzRi40++qm9IKV3W
	DFhl2OnAx5ljK0yTl5sdGb4NA1HEADBLS++TGqlMn+WPdwX2/6sEnm3lmv9ZYp99
	LlEcReCx/bYzwF9NLAtO7bcrJFlciMJRn4aPd4eD+Stm98eR/lZ9R/efJuSpDVl6
	p4AC2qFIxVW4C9vjed4kHsoulcpLPjlt7B+SFd8FKtUQRBzBx/9/HZp7wa0xKWjF
	8rM2KO4apJFk/+YVNR4yaMCdO560y5Z1GaPSB3DeLIl+du/7wdBMFdHNxChQbTN3
	j6zhYqIDgiwDKkVDo/UJGD/sin4FGYQlmLRq69LZ29Ly82bOVP73uBopj5ec+ouI
	5qGwVQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dubq9jk4v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 16:22:29 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dcd603855aso1696006a34.0
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 09:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777479749; cv=none;
        d=google.com; s=arc-20240605;
        b=SM0mCAUNA1b0ulJ9IfjS+l4BfVdATWbeoisuDte5K2lf4y5A65lXDQF0yqinvLYomR
         knOrC0KeQ6k2E+pBzGA31aOMZytDaSK/oLoO2XWOkAINALa+MLtn5nEUQSw38wEInGuA
         9DMnsRHgGC7WguEaixzpst8qfEArEbSKFqA2FO9vShSLYqkLZxmUgkihrMREwfArp0o0
         Z7EsaUPNekuSIZPxYBEBOeoe7AT6P3dlOKNAhEGK1KP1H/TLpgHmSaNxgaDF9XbjMW0O
         rugIjNJod5tGGR/3ggEh6Pp79MB+extIO3e4Ln9JoNcxzZSgcnykqaQ4rgQfV2xvBI7k
         o8fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=;
        fh=Qd4CgvRE3ec7h87FtWPbMm4Hy9ao73CAX/i+U5o8emo=;
        b=ZbC+xJZ4I1k3CWBlZT7xVog4tZp/enlZrzXG7+nSNhoA807JKJbvIPEUFsonkLczyY
         hRZqWwwrnLdziDax0v/s1kp87m92pzzDm8/B2cAnj+tHzXI3ogqT2TqDcbc5bHD+pO94
         +EacDoeW82s45d8OxMDSeu1Pm+jzSpe/Gv+jztcWrpTuvj0+osSdWFxZLjTd6ZewsZ5f
         7ppwUvKhrMR/QZJK9OOzNgQNA/6TduqTdxmLVuOGnr2YXEf3XXDe+H5z6r62IyLBQCRC
         g3f/EPcXiJ0JOomH3BoHXeziVN66Xy2QHjtdwazWpF+ttvUCwpQxND3WCZ1boMhoK7nJ
         mpnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777479749; x=1778084549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=;
        b=GkK2GDLCkQqfYx6JvKVq9FxU+hMrvsfGpUfPRavqDCLTUpLBKUdKe5rLsqys6FDmtP
         hIOvvEfK9Q6faBvDu4cyfg+UhizleVr7xWuPGM+/O/Smc7rzLbfFpORp6rQ6R9u9TB42
         YPliTBBJ/jTM060xEkWFeIHanPsz3QjsND1QRwNRc75XReEhwvQYDq/sOJ5sAZqqa09m
         mGS5XsOIV6arpJMMcEf7lnuj1cFn5E1nVJlL9a//ZJIk7eITAA7hTvndy26W2QBSoky3
         Dia8pdzWoCz5Ns+Xld2S5VTzXxMwdwCZB56H5G8oStRP0rifd4r3PNpyuomi6/FBTwRr
         emew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479749; x=1778084549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zeHlRNAL/iq8k8oB+OXu5Y2acD+IRikshmtnJE9EZ2k=;
        b=HzK6svNNWP2rbwIY9R0rY+juNKz0cauxlU/bQJoOYYI+D8aAGudUnQOgz5Z1QfEPqe
         t3bUk9qgxzeVjqxrhIdp8/nMfBkh8FWzzFq7eP0iM5QKnYdcREEzf80nUdwJqdaf4N2L
         qkq7U5+OlD2FaxWpXO6WDOFNFvsUO6NqxQMWZaVTrCdMjUYCwWiMCUlz69UGm3e75li8
         QbUtxy2IpyHpCaYkcT8zgkPex8ieQesUg+asb6kZib4rcPoZCAvtMdRKCB/nPjiWKDck
         VKtX5J+Qq9y+EMDnShmD9FIPA92+OVPi96BNh3DV+fAAYEu+xGL0PwFafpfi30Sf0sPR
         Rhig==
X-Forwarded-Encrypted: i=1; AFNElJ9lOcVdBAxSVTrrsKMHx4ODESVicLMya0sPlvsRfQlnE6Ji2AReZDwydEeBFqOFqsjhfXmnUBe9+kxahA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4rKnw0SB8G9DN0cfD/1uk0j63V3N+AUTeTCu9eNwUNipyMaAg
	WpAPlOMQxHuM5U37tGDfXSnEUlu4UJYHMwqo4bZmXzgfY8Z8dcBxz3qtIH0FIP+0auOyGhACNKM
	1jSpjlWLocBHSXHJsxRj8jpVqpWolr+ttXsvyyz6w1bInEUT3tZZI4C3x3oykqeam256NICBTFv
	iqigjJIGYKzN1Km1pR/5nWH8uNnkaOJfGq4Xind0eg
X-Gm-Gg: AeBDievpc7QLobGH1Bqjd1Hb55SyeM4C+29AuTx9ODxNEU/iFkwfUuhtBsmp/C4hgt+
	3cqRsyPY97IrRnyY9GgaJa5E6bwXyg8f02sNcEFOpFD5xrESy9LEYK/Z0YM1v1et5lWuWClGNOx
	/UyCsOMQj6MOqYNW0s3EmmBR52WQCnlt/RhE143GStABJjcmTNDZQM2yYufsVF+l50hVVDFFAmj
	6RC1g0i/AK5aXCJ2X+aa/RAd/1D7gm/GVtfX+OawZZRvrIr3Q==
X-Received: by 2002:a05:6820:1014:b0:696:6e28:8c19 with SMTP id 006d021491bc7-6966e288f89mr732609eaf.20.1777479748802;
        Wed, 29 Apr 2026 09:22:28 -0700 (PDT)
X-Received: by 2002:a05:6820:1014:b0:696:6e28:8c19 with SMTP id
 006d021491bc7-6966e288f89mr732600eaf.20.1777479748427; Wed, 29 Apr 2026
 09:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-7-6ad23e75190a@oss.qualcomm.com>
 <CAMRc=Me9G9vd06a39vi_UrXCTkUtJQRogm2MqgnwLS_r3Thyzg@mail.gmail.com> <e0adaf64-10d7-4e28-8403-769e3070ec30@lunn.ch>
In-Reply-To: <e0adaf64-10d7-4e28-8403-769e3070ec30@lunn.ch>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 18:22:16 +0200
X-Gm-Features: AVHnY4IKbhM_HKhU56A0ru1z2waWryyeh9i-sfRAmlk4QJVuWsNhvXilz3QVxic
Message-ID: <CAFEp6-26sVj21JVECREORdq+UeFTB22MoqAm6Pd2fTosCQau9Q@mail.gmail.com>
Subject: Re: [PATCH 7/9] Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
To: Andrew Lunn <andrew@lunn.ch>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
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
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: WK-oAQsnJbG62lABpBfhNp0md5-tzpFO
X-Proofpoint-ORIG-GUID: WK-oAQsnJbG62lABpBfhNp0md5-tzpFO
X-Authority-Analysis: v=2.4 cv=Wak8rUhX c=1 sm=1 tr=0 ts=69f23045 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=J1Chn9sQg74BwZjCRdUA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2NSBTYWx0ZWRfX6yM/lbjpGz69
 L4Og0yiA5dmpwRGbUXjxzOymukH3SyfDGcirSUXoVdTtV4tNQfR7hU6NjgcDhQPJGrnp0QbtaD8
 xwFcFMATm41ZUm2g2mGaHeGiDMoOf47YFlmrfD2OmX2ZLe/KubekYLCqoykdBmwZRKgDzHgr46y
 nLxWcIg4poZf2j2Sh8eFp+Gyf2zsRLtZ3TBHOrDv1o3l0FR/GLAIo+FPuqBedpw3GXjbHu2GEEu
 f95Zq/velUKi6EvxsOkMYfUdN/Tgl2+lfPZpqwjn2B+68hgiKMceq3PDT3EICQsBXWxk947Udb9
 dzlpedfIOeEUrCWq6ITrBUOa8Dsw/lu7Rv+IBilsjjIyJ9KIMwpFhUmtF6YVPj8moZ9VmGUB44G
 x7PcjiW/JL6+ZdfHTHHP0Zn9l35CFSFl73RM9yJwPPOmpuOw6rbkVaVehMxoHUQUVPvAJviY+sF
 +tYunFYAe6RmEDx0nrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290165

Hi Bartosz, Andrew,

On Wed, Apr 29, 2026 at 3:15=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Apr 29, 2026 at 10:53:13AM +0200, Bartosz Golaszewski wrote:
> > On Tue, Apr 28, 2026 at 4:23=E2=80=AFPM Loic Poulain
> > <loic.poulain@oss.qualcomm.com> wrote:
> > >
> > > Some devices store the Bluetooth BD address in non-volatile
> > > memory, which can be accessed through the NVMEM framework.
> > > Similar to Ethernet or WiFi MAC addresses, add support for
> > > reading the BD address from a 'local-bd-address' NVMEM cell.
> > >
> > > As with the device-tree provided BD address, add a quirk to
> > > indicate whether a device or platform should attempt to read
> > > the address from NVMEM when no valid in-chip address is present.
> > > Also add a quirk to indicate if the address is stored in
> > > big-endian byte order.
> > >
> > > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > > ---
> >
> > Is there any reason why we can't extend the existing
> > of_get_mac_address() with another property name and use it here? It
> > already has support for mac addresses from nvmem.
>
> Does it even need to be a different property name? Is a bluetooth MAC
> address somehow different to an Ethernet MAC address? Isn't it just a
> EUI-48, independent of it being Ethernet, Bluetooth, wifi, fddi, token
> ring, homing pigeon?

In terms of naming, I followed the pattern of the existing DT
properties: for Ethernet/WiFi there is mac-address property, and for
Bluetooth a local-bd-address property. So it seems reasonable to reuse
the same naming for the NVMEM labelling. Also One thing to keep in
mind is that Bluetooth has historically handled addresses in
little-endian format, while Ethernet MAC addresses are typically
stored in big-endian format (as far as I know).

That said, a more generic EUI-48 identifier could also make sense if
we want to go in that direction, with expected property/nvmem-cell
name(s) as parameters?

Regards,
Loic
