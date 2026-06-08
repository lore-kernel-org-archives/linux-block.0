Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7A63655FC
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919108; cv=pass; b=WIV0fRKQvG0y/F1mBoykCbJY86db0NnPD6svbmCqdQeDvqodu7EdArKABr+kVMCPRTyMhZP55s31ByY+n3qLcIMSpvxshtq11L4VyLZizHJ+2ElUff6VrNzZolHanMDyfFh7nHFoCpjkk6XfkAKnDyusVNboL3ms2kESeuRuVkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919108; c=relaxed/simple;
	bh=hhj8Vip6KRSgrU2uE5rO79Ldiak2Rlsg6Hs6C+XmYIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fNTrfw5o7g13EwD4xnw5MKZkjITutcpETtntNGhEW4ACd+aHWj38na4cw3MDsBb3DhmBgqUEobzlU/R7lk+FWGXf64m1651aR5SYOPdX5onI939eUskI9H3tKXzbp5i7JMd85i9Ym6B1vRwlD3sZKELWmHJP2sI6Gr0vXtihItk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gyjq1X81; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RcO5O9lG; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gyjq1X81";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RcO5O9lG"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9joi2919978
	for <linux-block@vger.kernel.org>; Mon, 8 Jun 2026 11:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=; b=gyjq1X81lQIRnvcO
	G1um2E6TV7hqmLL1Crrjwm5U2JX9LsLsEKMoBAB5r9dv+Re6mmmqF2N4BlWwnJWe
	WipwNPhnPDyTaQA1648cU+hTlv0M50/vvS6qQKzliDV+B0P+UasYAt4nGWww+/2V
	Jt2hVfesaJfjYeEx6LLpZB3Zd7kugW563Aw8AhYGU9FXuGT9sI2lmrgrxr4ipjYE
	RyrKH1rZFL3kTTJ+uQ3sF56wCseXRx5Ce/219eLO3wNRU5YKKduHHRQ7HWqC5dUT
	x7K2ybfU3hPnmKnk9GZzZSnL5s9fuvmjIHV2Ao63T44wc4jwbv7XlGhlcM4VQxJB
	Ow6dcA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgyc9s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 11:45:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9157ae36434so133590985a.0
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 04:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780919105; cv=none;
        d=google.com; s=arc-20240605;
        b=MutFV6ON2mVx5ZnRyJV+QoWF9QHZ4aN7ULByrqtygCThB9LM4ej34RDrg4M/oUt7AY
         3NV5omeACbpk0ZxAJQPBulnfngQrjyYpiI5Y2P3eA/bjEGl7BMi1eu5tWCxZsLkz4lJn
         OmEd1gWLAUOSrGm82/j4r3aBZAPA9wJNFozP9neVe4bPZMn+hgwnk5GkCXBOyrFZNprP
         3Ckz5KfcpIV2wdajMtO0cC4y3WcThIEbWZNJ/QbjUYT8vvx0Mfz42FCustMRy6hS5DQB
         leoaeCTyKQo1XufaF/X0JlP+QwdLEZWKHtxgCr9W05MAniFyLgT9wl0TOJGGCjeyY5zj
         u9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=;
        fh=t36vNtcEaEKjLb003gPfabGYXuVmx2yUvz908yYXZrE=;
        b=W296jewWZc26ok6wD42UhKWE04GvRQKAdC4eNpVa7B1WFQaN7bknHjqNqvXXAza2Qb
         g0VW+0zEdEz5cEvitInEbxDrlfv7W5tAQB1GLHTosClVGCGhHznf96cmN30KXfmm4XZc
         rQeIHlx8y0Xp8pEz93nVFGuLAm8Pn9T9iSbfBWuApVSbfXNLKaP+BNeHO/Jqwc2F/Z6s
         2IpzdCKRq5rXLx+ooZme+YTK6QuyPY/oW+aaM37SuQKVzWrTj3duZA3I6bdngBjW98Qg
         K4lZWUW5nk7kzVAUe/Yx/AGYMghB9G1+/7iOfHJznvUXmYiL5Ab/8lEo+x1Wlx3nHTIZ
         rfPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780919105; x=1781523905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=;
        b=RcO5O9lGigUkcWBwngH5Wfra4pY3AIg683iEjDPu8iUitQvGL7OQVoChTSxOluDdJe
         +hSAORC1TWMgyB8XsS3ZAQFY7KgTWS5iYMxlK62hFqYhjc0ndnX9EaRRkcQijTqkY1r0
         YV1xsL0aKD023FfuillwZ3qcB9MvSonhseaSsiLWkScBlOaCA2s3mdI2kBvKree7hBwS
         zTCuF66jImfhEkiGIUv8P1cjypl2ziR+x80fXyxoz0Zm/Up+no+yC+OJn8FmtDHjGTql
         H6yt7tI8DTvpoPd8hNE1eRpZEjButzMMQak0CD/iP05MOo3AbN8OlKXglp+S8XyTSvw4
         wztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780919105; x=1781523905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pj8HGTOjIgEwJxXsqFpmeuzcGz93+i2/L//Hl7KmKx8=;
        b=Es+Dr2XEQcE0Fs5vz01CFVZOCIge6kdBWX/DWFmbWcDQ2mdphWDPYiVWu6x3upgvM1
         ZRMPL4848e/Bhtd/w5bLCEa1R7S1JH/1YDMqds/q+aCricLTxWl6p91OSaIrRICycvtm
         u3al18EnMObj2QDSyiYD4JzBcB7CKr1lnLbA+fuiObqg71p2+YLpPYjPVVSo5bn4HR4s
         vgffmfqm6jw7BD4B1A2AecJuUCwBewzLv4HpA7ptteia9ImlWH5z4I1q41TKnK4wOAbB
         YlLFdQpBDiYX5XLhFBfGak/XvrIKw3z7lBoy0tSc2yuppjOH+k25z+KBAMLG7i5VVguY
         mB+w==
X-Forwarded-Encrypted: i=1; AFNElJ8P7MkPjNIoo9Z4BrgkFv8UvmyEZLp2YSVma+0IkxqSqmJblvnST9XQk3Eak6byDNlM2gVgtZi3VADkFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzScn0Xm2SpqAdAreU6mZCVVjncXTzywUA5uyfxh+/sqtndkmU+
	0s8C7Oi4/ucs4qi+2W2iNq6vEk5Ii3gNIFtuoNAkEx4ZkLqG6ql82ZpZA653wUq7I7LzKzb93ia
	+P1bE0syiEHNNBbOI0lngMyybx1K16xd1hanNIEhM+L7bCqkk4JniKTXlVYYDiQQ5P6927HWWqR
	NEDxUBhNFk1WWAEBz2AjQ9IhJWtuoCcsC4M+hZJg5T
X-Gm-Gg: Acq92OFtFc83IXTx5u7aG+SfCc/RLB9Mwr/ybnrqPtgaSDCmZLMtrPzxrVnLah4/g5R
	1efec1i8rCporRIn9bd1bYnLZJvoihV5LDS9I8qeM+Nbw3Em9g8/V4hCSKxKUjEuMG60vRptIV3
	2U0CaGTDDg2h+83wX5DLAD25QSTqbkyzOtVhE1MXHFV6vpTO1uVJWMFC1L9M4PXbrfM8Ll+/tdB
	rRcCtPuvTvWFLNTyMtG8z2d0QosNgLbveo4sYAvLfWW9D/WjE+qPT2Ihk45EUmq+isYp/xrVWqE
	7cVIKvLoluwy0S6g6SP0aCFeHwXNjWj8
X-Received: by 2002:a05:620a:170c:b0:915:8f76:8005 with SMTP id af79cd13be357-915a9dc9a4emr2367275985a.47.1780919104840;
        Mon, 08 Jun 2026 04:45:04 -0700 (PDT)
X-Received: by 2002:a05:620a:170c:b0:915:8f76:8005 with SMTP id
 af79cd13be357-915a9dc9a4emr2367267185a.47.1780919104401; Mon, 08 Jun 2026
 04:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
 <20260608-block-as-nvmem-v3-7-82681f50aa35@oss.qualcomm.com> <f528672e-ab4f-4844-bc7c-1f8f1c4dbd3d@oss.qualcomm.com>
In-Reply-To: <f528672e-ab4f-4844-bc7c-1f8f1c4dbd3d@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 13:44:53 +0200
X-Gm-Features: AVVi8CcIivK2P5dE8YRtSTP_9u8m9dGK-3gXU3su59C5FvR4dQPnW2soKiKG5MQ
Message-ID: <CAFEp6-0u1DBhXo9DCie5HCGTjcduWcHAiifVo88vFJwjYcjCog@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a26ab41 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=4LeufcCx7mgyzPUJGOcA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: twnmIWSs6EL6-Hr1iXZrxBEQEMglTjYl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDExMCBTYWx0ZWRfX84Jnyta9lUae
 dJkYmTSyYKpZOa0wiTtKyFYGv1fuAmuNTfPYOYhoomUVy//3CGOp5lK5HnikD4PWSubM2S34ivY
 RtU2acP6JlLvxNUFim1OvFYINtyKqzhu/Hx7b5W1lu5cgy/GYFqxt9UtkXhRxLPiSPVfK8hdFgC
 HiWdrOHOpWJ84yuPBl3phq4HMoG24LHDwIpMqxfktuoC4bSvbeWTjfwrHUMZWFMxZ0roEJ6Y+h9
 rw9t/P2chyHlVHFmydRz6R2CqfMbNbN+Tuk+ucg7l8Koz9a6gEtz/RzVfBIRyiWXip8KmLGyER6
 ypUU18E/7eRnUh0XO47KfAsPN5gfwhS39AHbfoz6l5rFzwHI3IHxW18DxRONI5tBTlCKLoj7w4t
 GVH16itrSXrEJB7Fa1sj/sw4wGMUSck8gFvetGAPli5PrCqce47mmAWeV7HdbOkiWUS2QI2Y6It
 NN2tP+LNYe9bh9JjQHQ==
X-Proofpoint-ORIG-GUID: twnmIWSs6EL6-Hr1iXZrxBEQEMglTjYl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080110

On Mon, Jun 8, 2026 at 1:29=E2=80=AFPM Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 6/8/26 12:50 PM, Loic Poulain wrote:
> > When the controller BD address is invalid (zero or default),
> > set the NVMEM quirks to allow retrieving the address from a
> > 'local-bd-address' NVMEM cell. The BD address is often stored
> > alongside the WiFi MAC address in big-endian format, so also
> > set the big-endian quirk.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 39 ++++++++++++++=
++++++++
> >  drivers/bluetooth/btqca.c                          |  5 ++-
>
> Squash mistake?

Indeed, thanks Konrad.
