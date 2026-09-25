Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65414E1C92
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361737; cv=pass; b=Hj4J3+El52GiADb4+VOAiIF4OHFnA+DGxdm8BBqeN2Yo8DA/gvbWyiMkVP+nh4jBax2I3u4j7IViSo4gCTLdlEaMqfuSH+onGec+KaXmIm4Lj/Bf6uDZ+a5SWbqhjc10Y7Et88CvaklGf3Zm94ZzpB5YiRMzmYo3iTnJbLWhvB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361737; c=relaxed/simple;
	bh=qe35OzbfSn5jxEUxVU2cmzIGiFHK7xWuk7f7gKumZ4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ep4jzqmHJ+GHq2oLkNXCawe4AXIvMvTYMhaplYT6YiaJYyF7I8QdqD/VExBmnDMNN0weTGsRzGC12kXqbecietRFD7yOyVqstDd7GB7KlWLWg0Xv4co4agZZLN66XAre/0krBoSiYHRA7TI6pmifuMBhkMnRj1pNXFJ6lGvzclk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aSlUeud9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MLqMAtOF; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aSlUeud9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MLqMAtOF"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG0Hrr1001889
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 18:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m3xDk7u5dmLP2jxW/XWS3M+3d/I4qMp3Fvvf2xNBdKY=; b=aSlUeud9MMrnTvaE
	fBNW17DTlK1pd3VcwQpUk4ojbblR/A1hMmRDFhOv4r5cy3OVu8i2q6RmCi/4vkuZ
	vUfJnemh4SMXjd7YTf5sbLQCTkc017+cBse1LMO1nsJkHCEWniirrH+WKHG39Sy8
	my8Qbas7L+ScsIZTV2pNDMGhJ3LWocXSDZvk5Td6QyumagYlnF3T/M65woH/CUay
	IGqzzkIMWOsK+Mg9kxItyfWdlSbMOxtpgASz+AMsYETe9UpdCinK6WF8DBzpNC6p
	SaGtAz+max3hYXt17goBn1g67FdMVjHnVQNwOXVfg+HpnIOlmupIwqr2msOh/dir
	1yJ5vg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwr5e9muu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 18:42:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93bd22160bbso270244585a.1
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 11:42:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790361734; cv=none;
        d=google.com; s=arc-20260327;
        b=Qww3l0np4QL7XrdQzVJzgUgxyFaDSLjWy5zxaErrrqaE7D8N9DOsOulU2CV3og/TZQ
         HtJCpYyRrufos5/+/wxMSauD/UdCti39KDBL4BOHvedpgnWHprB+AR1G1u/HY6xIuIz3
         LI71bBrjUBwNyPpE+almHjfbGaOWTwcJn7qzzTQLE1Ahjfs0anWD/5XYwYbVYzx371SH
         cEsinxEdluKRqLvQeZrkgGT12NuyvoDNtUuFV6PZDuly/AZnrb2IJHUq2o6/n95uAI3Z
         q15Of1xXydrWVkDDfQRrP1c6oPEWXAnU/preENvY3rTAzu0saW+xbXeXEVIRwtaifUXW
         Bzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m3xDk7u5dmLP2jxW/XWS3M+3d/I4qMp3Fvvf2xNBdKY=;
        fh=uNvB4iGR2Uudhg/RWIiR1/uiKm4lajCiHCy5cvdpupk=;
        b=p1J7FiU/sL2FxL7gBIAY0ENvcPA/lu2gg/XEadRfUXcxoZeB/CYMcAJtaEsE/57NK9
         LcXRRXkt+YgAkl/RHVg/CbYqAwsrLSZ5uhfXLrPSrdZWFosy0IyG2aA2Yfh40hmVhBdu
         vuiE7IZ16LfvvrFZt9Qj1xsW5Ce2ki0kPTf9HC1mbTaP1SzJ0aK/8zTdjgsV18BLFXJg
         dUd8V6cRU9DpN6EvgQbQCEGSycrBKNtHNBte7Fn75JuQD795yQXDDWSl/z0/34jaUHi2
         9JgoTVpFUBM7IlBIZWHjy/BA5f+qraSiBXzE66/1cUWudN75ajZofyTziRKo673DjIRj
         boNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790361734; x=1790966534; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m3xDk7u5dmLP2jxW/XWS3M+3d/I4qMp3Fvvf2xNBdKY=;
        b=MLqMAtOFgcfL9/esEM7x6BGxofK86YIE1Fei2550rmKgF1kyAQlJ7ay4c9AMp95V5F
         9yVqR3MeECJxN/rljFLWY8Y8cH/y9dErI1SDMfWjRP2T6c286srna7fLafAgf12jJNhb
         C3dUd0We4dWIfe51+7rlrCq4o4SInafcewYvXgEfvqw032ew14t/HA12/kHlUjnorEzT
         Xk4FEBXlguoF/nQB8KmmRq+ZkQq01LvbBb3469/GB1/ktBO+P5lX7PuPxO2z8L7DaBId
         ZzYTL9r+nufOK+2xNUxp1fhF8PNMKIoObRgTMhZiPFhlIeXx0EXSKM6iKcZYxwBqOAmy
         v8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790361734; x=1790966534;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m3xDk7u5dmLP2jxW/XWS3M+3d/I4qMp3Fvvf2xNBdKY=;
        b=mceFIJ80BY4iTpSHDI4xhK8SYHzUUAw5FbHeDFchBde1eDMgq3melkJc7lguiuFC9l
         M1wym9rWgtozjR1qPsRrnibiRVYC/NFvR8qXnGbAvX5tczGzjPraU8HetyUSw1PrujTb
         FcTg3QdaKD4M23qkMbXe5tlLus2h8Ej2zzwp1ePQ3ElqJPHX/xfShPr6RepuzzQyEcus
         TBC+PToEDrVl4riBPNAftOOiakW/A6SWIAK40vRC+jifpeYknarzjaEoL8dGOaewwmLY
         fRow1O6Cm4cILqY23l1AswbnEOO8jn/i85SORcrfkgF1tIfVIFkmyLUCQejnYb28eq5r
         1zlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMMk2rUq+1G8rCSBVxPvx73MutMCi9hIvuiibrV2LQmEwQbz8Jri7PQF8qctUYx8zl810YazMYn935cw==@vger.kernel.org
X-Gm-Message-State: AFuF++ni3FFMO87WIWAO6KM/LAMyi5T6IB9PCIArHwZMiptd01ukoq4K
	wG4giYmUHWNgupXFGiHYT73z1rLt4UrsbBCFMilnUQQv0eFzwrC3jVjJUzDSqzgcMWpCs1iFeHt
	h8iPnJJnDcMbnD2HK8Er2mOSvCbBCq+DGgH8V+EmM8z0LXsvnz+kJCG/okXYNvUPkABeB788B9O
	qLMsB+BAdPMa1rJAoeQ9M5f6OOMAYpJEO0+SbZYyeW
X-Gm-Gg: AYBFou2xNcA0q1jKduNHoG/+t56HI/X9E1JXrE3tQTvjlDctWB4CqHALNPdaNuX40bf
	vFILs+LtSjl11FRPRmq6PPvhoZTr5AxZffwbvR85RJ7Dug8BWCCDPqDb0ZcCUPJeR9dhFmO67X1
	2f98YeuwE6zygjvjC4k4fXjnNQrrFCWPJd/cD2j7a9qc9YZgWi1QJES/p91/krtlUheRWSwKQ+Q
	54yTMNNJ8jIVIH4wB21MIb2UWOGqCWXZHiPIeQyveie5Zh9rqeOW+BRO72WRVg+vfNxH6gbgV4S
	lossho4WHCBNZG57rdit6K6mnzE8
X-Received: by 2002:a05:620a:2614:b0:93c:e83:6ba4 with SMTP id af79cd13be357-93c43cfd3cdmr614936785a.25.1790361734018;
        Fri, 25 Sep 2026 11:42:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2614:b0:93c:e83:6ba4 with SMTP id
 af79cd13be357-93c43cfd3cdmr614930485a.25.1790361733529; Fri, 25 Sep 2026
 11:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com>
 <178998281449.889291.7893229102394463283.b4-ty@kernel.org>
 <CAFEp6-2P14MdYJGuH6ygRL4ZKtLnJEj=PVMx2p+b9L1RuiX1dg@mail.gmail.com> <f8815dd7-1e31-4567-8f12-1b2b1dd451f7@oss.qualcomm.com>
In-Reply-To: <f8815dd7-1e31-4567-8f12-1b2b1dd451f7@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 20:42:01 +0200
X-Gm-Features: AclHuK9eWyYSXO1LoWJtwtSLZuLm-A6-I11eiFIWKFJB95hJR5ZP3c6jJQ_Yo60
Message-ID: <CAFEp6-074kS9GO2TFcR69fMjuu7Y2Os68CzWs-KUfmZDYaPZ-g@mail.gmail.com>
Subject: Re: (subset) [PATCH v10 00/10] Support for block device NVMEM providers
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jens Axboe <axboe@kernel.dk>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ulf Hansson <ulfh@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Christoph Hellwig <hch@lst.de>,
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX8FIL8Zy8d3yq
 PCm4gpARJlnJk2pYJft4jKJ4ulFe1ykK4SBWvxFxclinfErK3jYcqgcRxgI6eJUqQqBGL9UKU/V
 kc2gqjRnPh/adb6AubMgJurX7c26oKI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3NCBTYWx0ZWRfX3uwa2ESPaZVi
 CIjq6q5kjcl+thGYGwoRPLCv6tWGicnk9TcN5LVePIFOXq9dGbpuBlWw49ev/pvVoaSx44YICzY
 A4f6nnozdVlt6AW8/zNjnHfaxY+c5i+G+hfdulfD1840saDLxtDc3pfy4NOY8310yB+1ee/br0O
 l4sCap2ElsYn3H6sZ9r+kkPvothO6MGOJ304PLVyWW7+ejptrlj9DFg3ORZ6ehYt5PvgmhR356J
 XDGNWiqr5gBJ74pdsfO+iH3zhyyER02zN99XPXB8MPhF1/Sw95MQg9cdHDArDWJzyr9ca93+yrZ
 QOeP3LVpkb6U39RZEUbzooOltShQGeHN5auUJVXd/3hpp4EpePoN4ETe9bum8TXaRVvxeHfcTFB
 YLRKIRh5toR5UZxQe9cLurjsbln9oTYERUh43qS9UUuG+QNF8Pa/pk4zUIHPla8NRQC/R8Qfi7M
 uuJIasyKKSusNLt1cIw==
X-Proofpoint-GUID: Q5YgZkCwTDP1JY_WvhPnPY-VdhwwvqAr
X-Proofpoint-ORIG-GUID: Q5YgZkCwTDP1JY_WvhPnPY-VdhwwvqAr
X-Authority-Analysis: v=2.4 cv=Hf2B3SE8 c=1 sm=1 tr=0 ts=6ab6c087 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=8pm97rweiJCjLsilNG8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250074

Hi Jeff,

On Fri, Sep 25, 2026 at 4:10=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 9/25/2026 6:38 AM, Loic Poulain wrote:
> > Hi Jens, Luiz,
> >
> > On Mon, Sep 21, 2026 at 11:27=E2=80=AFAM Srinivas Kandagatla <srini@ker=
nel.org> wrote:
> >>
> >>
> >> On Thu, 06 Aug 2026 16:38:33 +0200, Loic Poulain wrote:
> >>> On embedded devices, it is common for factory provisioning to store
> >>> device-specific information, such as Ethernet or WiFi MAC addresses,
> >>> in a dedicated area of an eMMC partition. This avoids the need for
> >>> and additional EEPROM/OTP and leverages the persistence of eMMC.
> >>>
> >>> One example is the Arduino UNO-Q, where the WiFi MAC address and the
> >>> Bluetooth Device address are stored in the eMMC Boot1 partition.
> >>>
> >>> [...]
> >>
> >> Applied, thanks!
> >>
> >> [04/10] nvmem: layouts: Support fixed-layout as the nvmem device node =
itself
> >>         commit: 9c6cab93dcd47c3075d896c777567b9d8f813d18
> >
> > If you're happy with the current state, would you mind picking up the
> > block-related and Bluetooth-related patches in the respective trees?
> > They are independent.
> Should I take the following, or someone else?
> [PATCH v10 02/10] dt-bindings: net: wireless: qcom,ath10k: Document NVMEM=
 cells

Yes, it would be great if you could take it. It=E2=80=99s mainly about addi=
ng
the possibility to source a few device-specific values, such as the
MAC address and calibration data, from the NVMEM area, regardless of
the backend, so no dependencies. Moreover, the ath10k driver already
supports those NVMEM cells.

Thanks,
Loic
