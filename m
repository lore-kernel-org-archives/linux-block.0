Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57D438A29A
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777494032; cv=pass; b=dz245Vv+2bo9k/kq+B+d4WJ/ix6p0e9/CbzUooy+MWLly3vZ6/Y5N4fD1Lv1ojAYSJoT+7rAWNtAPDgXLTYJmxqoAA4UuDzH9ek+1h3wNQn3x8d5RPUKqCjTLCggee4RtpjGqQgAAPkwGDCsQ36FDmpg0I9DdSJRsNxCdsm5rFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777494032; c=relaxed/simple;
	bh=4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gig7OppLseqxeLVJDQpfa7iVFrb34x4YUfKqLWiWpPRMV127AnzrFXiwP/eqlHxwmDsNNP349Mw9GfHDgghuehDOA8CCZJrm/y674tGS47xvKUOqbhlrJ8XXNQnwPZNgixqVK0G+WxsuuWO0p0SrYClYuigYO2R8r9q5POzw/PY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZJ1yil7R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T24P9Fi6; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZJ1yil7R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T24P9Fi6"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TF7Urq1641654
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 20:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=; b=ZJ1yil7RRd4FYxIp
	p7Iy/QHM4zbRhNpPA0hYLTXJPDkjEZpj0nlJd1/gcn1CaWRIma04TC5JKe3D81SW
	vVeiRZzWMnD6h1j+/NrrML/N1EdSQ9j/g1w/HfPjcjKblwHioKNVvbPOTS7wMt1g
	t0Gzh5vN5ormYORSYWNaDzPSF5QRW2Nn76i06d+SpiMnh38SIooyjOtYhh5AvjdN
	CZmgTmQB8ODoWqmGpsdbBkWvdolXxWGtqhvkZLbyynEZ4or8H895Tf9JexmnCUm7
	KfrnoxvQeAAeJ1xqAifF8YREdrGH3wXxomLatFCwx3CMWJQTzOX/W5W2A3BAs683
	leNRfg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj83c35-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 20:20:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50da529ff48so2962251cf.3
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 13:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777494029; cv=none;
        d=google.com; s=arc-20240605;
        b=Var45/FBvClf0x4jWR0YM78ZMwJKWiPSPI80Syfh3o1ry9qC1k+vhs48z7DYs+G+yK
         CmJVGVDfXHxdZPdOCF+82HTfXy8gOHUm9wZyuFHUFx24Kl+QmSIli/LKbTfVIGTBz41K
         /s86DeVqH8K/50rmge/sXXSqG8f+9nZze0K42VIYVMBZTePlFjJJniURYkVBrCafpy1d
         +YcxU8LgqYikeiEFnZA+ruWqcbYa1QiPxydSdAkJv62WDi9rfOsS56cqjyT7bF5aILae
         wWXdH2IzaHbQLW7DQjnc//5uwv7JwlFWu3B3V1lGiYR0ZKBQG5WGjNypY5BAtaA6ULhF
         m/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=;
        fh=LRRIxHAcs9Lw/oMQ7d+vgBagSL23tDsQocvjPRIS4X8=;
        b=IG369VQyQn9kMWCMjxXP5luRcug3/sSBSgB1NDfC2GUWftbq6qaxP314qdAXRV85Zh
         DhTLy2yIq4N3p4WR7A3OPkZOTJUxK8FGyADrLsvNRnqNA71eWcfwWY7yEktWPK5AnKw9
         11Aiv1/RcFyDyltBxHOMtpsNvyuo1TeR7HOeC5wSxOuVL4uO2dLbqh2gAo3STugJwv4k
         Zc4Dn4f7Kc6srUljp+TuW4N7zqIudt3PqgTCXqndRWhOFqm+0eLp4lkZpZPR+XrYWuFO
         u3dh+2/qLQVfp+Mzj6UZOl1DO59bqJwtkVL0FgFwi6zmHNw5pq3alpBtwFblVFdRG7ZQ
         eNDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777494029; x=1778098829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=;
        b=T24P9Fi6Gf9Zjk4iMavuKmXO+S0kBOW1j11fp+tN8dJeMhZ7AyIwSiSIil0oREiY7O
         aft2bmgLO5PlC+vWwAwD/jJscZIZdBXEOtHD1hbtYl1+yd33QyWzyFG8C+UyzydLmKAN
         ctxniHxGmG2dGtuWcGQ1RiUsyXYmdx+3Lq58ciWRCYw7n30BGnGWxPewjF7M0CB26raa
         n+CKzEGTcjioh1vWjBETZ2SAzyYVBB4IQvLZTAtHnk1MRQLSBN2P7EGZ6G2Hx2w8mHrq
         Bn0dIxMgTFx2Y7H3gtVcdOZq1Dsw1ffCJbqJUversd03uc+fk7UXUZM+4L94JeprgeeY
         ltUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777494029; x=1778098829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Aw2ShP6ftvHuS4AfDxVpzaTpHpMJuiVnhHUXu+8jX8=;
        b=GaRx4PyPQXyrxLq8ADy8NOkGlWscZ3oQZeji6gb5b+TA8h+PyMWOlCUV+q8mh12rmC
         uZazTRaA8xwHnm4ejUwkafIF45UrjYZ+IBlfaZQWNHW8f7/dVuBAH03jYDQfEiBtgGxH
         lsxXoFy/zmmiiRpPcbc/DpVj7RtlEri2ifQAGeOe5fkChzujRNLGqLMp2wMlveRS6+cU
         RXnM0ZD6Me8Pdu4XIxQerpQ1OjueEbgkJUA44dm2iP9J9uUKoVBOSzarivY4bPLZN5kg
         SuB+3qCitthDN6mFfBg5Zd0HITAFmokqTFhlFl8cjbbXDo0sJdAOCOi7mP2kvVTZUNvN
         U+uw==
X-Forwarded-Encrypted: i=1; AFNElJ/oVJ83k7S+cuH/X2kXYTZA5rLjoroV50bzI1K46co5BYW4/HcwvjotEV0hP4XABs5/IKoqPUR+oCrMSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhzljYD26mH+PtKuVTcosEdzQGOwVSP+V3x6weTCqAGYWXuU7y
	Mysdskk9IF3dGBeAW/DVRr+qFxbZZHhDMQC9n2j+q7OBABPOA1CG51lk8TR0N5bAlpPKNON0gLU
	dCLDHCEx9Y4TIwn6c81I1Lbhe7Pf3DCSHUjxKatUQyCaQUtaOC/u8mVBp7T9KiUau524ZrDhA1+
	SIA0wFPBpOJikvt58zU3X/l7nodccJlAiN2hpoumW4
X-Gm-Gg: AeBDietjPnJxSkE9GOTfmmvI3xBdPmTX8zz9slZDSC8qAtjlqphxQltl5NGpPB96UB+
	N0QwYafZbV8GpEnMih686FxodeSMfdwSYX08za3unLeXHqKUKONsDUogBmBt5JpSqeC++luopaR
	Fye/xt1SvCB7FrDMrdnAsd90BFPy2yWpsjgjzgEqXsvEUttfwoB8KWTYALCg+E8xkyqCNh9eqSQ
	X1tiHpdusj4NA3ZDSdtPJrctFQ6sOvRbsh4agz7rCLRBAJllw==
X-Received: by 2002:a05:622a:4cc6:b0:50e:89e9:271c with SMTP id d75a77b69052e-5100e10eb2fmr114762601cf.17.1777494029284;
        Wed, 29 Apr 2026 13:20:29 -0700 (PDT)
X-Received: by 2002:a05:622a:4cc6:b0:50e:89e9:271c with SMTP id
 d75a77b69052e-5100e10eb2fmr114762001cf.17.1777494028820; Wed, 29 Apr 2026
 13:20:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com> <b4de6c89-dd89-4e02-8d79-911e4f9f0813@lunn.ch>
In-Reply-To: <b4de6c89-dd89-4e02-8d79-911e4f9f0813@lunn.ch>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 22:20:17 +0200
X-Gm-Features: AVHnY4IQns7j5YMIXICXGX8mkvbJAvEU7QYVILcU5HpEGI8Bxfo-jvWggVlQrrA
Message-ID: <CAFEp6-1GdaJd6Ua15TsyQC07QDbArXO2JZa9nKVFoCG=4xBpWQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Support for block device NVMEM providers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
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
X-Proofpoint-ORIG-GUID: VKTaWT2qk4LBZfc8hXNDBv4u6lW-lAs4
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f2680d cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=P-IC7800AAAA:8 a=ICsrgdoeZ6IjgJzXnBsA:9
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: VKTaWT2qk4LBZfc8hXNDBv4u6lW-lAs4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIwMiBTYWx0ZWRfXwfdgZxH6UtHL
 h1IBFiC7JsHZwOSQwq+Enoe0+3veFZGUqvJjRdxmdeYUecN05ZrAigOcMDdkTrZqQBa4Sw0/eCX
 a3y8aE7EcFsCziPZW0Ql15pGzWhLNmtWeUlyUOcTQ5ID+o+ZcQvFyvEDYFQSNp6F/Ulfliv0P7l
 gB64/q7wqgnQMwy5HZMrYNbJbZljZXQXjbBwiKuoJDiSeaWi0fOEknsNZtCSl4+V/wNcUISSiny
 bdS+waLO0TbL6hSaDhkfWziptWGkFHOWf62pPw8vEspuvyV+865y9dvS7p8JIRltYBiVg8+0P4X
 ch0XHE2FlKKsT5gu6024ulNajOL4Rz5tpcrFnBE5LPrYRzEAnaCOI1PNLfaNbCd9W4Cm8Ma2X1c
 ZQhzsIshcCPYWVSS+WbqYlwii+EJJ/qQSRrsF1bnMa+yRS7vgU3zeXcpbQI6sJus4bJk7+CF8qL
 eiLIHTN0UGWGLB1P6YA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290202

Hi Andrew,

On Wed, Apr 29, 2026 at 3:06=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Note that this is currently limited to eMMC-backed block devices, as
> > only the eMMC core associates a firmware node with the block device
> > (add_disk_fwnode). This can be easily extended in the future to
> > support additional block drivers.
>
> Would this be
>
> https://elixir.bootlin.com/linux/v7.0.1/source/drivers/mmc/core/block.c#L=
2641
>
> Looking at that function, mmc_blk_alloc_req() i don't see it doing
> anything different between an eMMC and MMC.

Yes, that=E2=80=99s correct, in the previous sentence I should have referre=
d
to MMC-backed storage rather than specifically eMMC, since the MMC
scope also includes removable MMC/SD cards. That said, eMMC is more
likely to be used as an NVMEM area.

>
> An eMMC you don't expect to go away, since it is soldered
> down. However an MMC can be ejected. Is the code prepared for that?

I was about to say this wouldn=E2=80=99t be an issue, since the NVMEM devic=
e
would be unregistered along with the MMC card removal. However,
looking at nvmem_unregister(), it simply performs a kref_put(). This
means that if a consumer still holds a reference, e.g. through an
nvmem_cell, it might still be able to access the NVMEM reg_read
callback after the NVMEM device has been unregistered and the
NVMEM provider data (bnv) has been freed...

I guess I need to try and dig into this but at first glance it seems to be =
a
general NVMEM issue, since even though most NVMEM providers are
not hard-removable, there is nothing that fundamentally prevents them
from being logically removed/unbound at runtime.

Regards,
Loic
