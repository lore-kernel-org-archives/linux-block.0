Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8B3603DB
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909973; cv=pass; b=T4Wv7cvCUZfzSQOaJHwb4LHDEok8TNTPAwO9FQdb6BI9z0/HDdpGj/4zFuyrTuKXTNPIeNxdReUImpbCO3jNDMG3Ighx/P7y1tc4szp/AqqoNLOQHSKoD1qsjtLuy4OVnIQQat5/pAuXMUQrFgBErnfufvQMlr2JtFcwhFmGNaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909973; c=relaxed/simple;
	bh=2Pz7yi8VnRHhiqlQrvwuFgDpKz5CVC4Q8lP2Pw68SCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qARWRdhl+gOEVaMXzXTSvv3mtA5we70/bAU0XVBzzUh5gWO3SL73/cBpGwEXGZRgUoE2t900Mb+XxXFaANlM/gqO6hi2cmNxFimQcgPVdxhzljZSLyzXVEgRsjHVjzKxwM4GpWlgw4aHQm3qOUfO/1+78TwQb8zE7ULNE0pKHlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nbVcHouG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBnWBs8p; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nbVcHouG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBnWBs8p"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbtvC3198184
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 16:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FuTrxtmptBklBXvMb0kKcU77gZb2KY5onwBT7j6J+nk=; b=nbVcHouGe6Z+VeOs
	h7qeGBArJI327t86C+PrctOZsyltv748m/ScDV0HsPpenC1z3jFTg4LyiV6J/FyZ
	owGOr/4SL9LTo2UqQvKh0uDL88gNcHr0uVKuOvntU6WpM2VT9F00DWYccU7reCNf
	3W+Shr4Az7Cj3bgZwWT10I5+AfeG1ieAsn6FNNauwF6wH+zK8KT/3uOxiM0PKJA5
	g5hCgpfIWj021uazh1SKvG5t/yYiUeiG3mZT3crN8cA/gFB3Nd8A8h8MQQObHNWx
	CXusUmB8HAJeYd6rra2az3epDYLosYNDbtF7F4WrLTpOgjM4yHXPbGflsMaEgVX3
	My6sdw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0p52kb1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 16:19:17 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e5fc4c7e9so62866485a.3
        for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 09:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784909956; cv=none;
        d=google.com; s=arc-20260327;
        b=qtXjTewpCQrLfOHdSXToEhMWfXoGPjLfsRgUbUBXt7bIhO3NAx0HNh4Z++DT/lGTtJ
         Jik2TiXhVvv5wU4hI0HeeWIvx6LFSsPWa/CMsk7AL5UTb9wZbiV24x5op4hcUfKccwZG
         W200UW7LI7/+RHGvzY3OAVxumnv4DBW+aj/grfiDIubHaFHxLIFs8Ljnu7h6/8pOU8GP
         MXdDAowEkXLoQOdR4ur6RzP2uYqx44f3XrdqJ0mC9MRvZ1AXA/hWYC+y614L7TUIMPKz
         RHuIKAkNUdswU3zXT31TH3UpRUPtBoao53D97jYqT04l8D1hnHLcvkgx+idDa2OVcho/
         yIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FuTrxtmptBklBXvMb0kKcU77gZb2KY5onwBT7j6J+nk=;
        fh=JGirPJPuae/CagWGrat4uFCq1cXEViJLNltA3WMxqwc=;
        b=o6v8FVn2/Cn9b3ik+RUpNgoAoHvKsGBN0+wh10QsM5vOjz9VPy+p7mBxcVwcps0atI
         MFow9IIAjZeVPP/z1zvtkBtZRS54KuXYg4k1DqDAtkB4LgfdVApzpZpV33LorOQPhQmq
         Sz4VGNnw6pab0G4fX4b0UBpRolZohfUSdA6cXv6gi37OOZ+JLYZ5c+fsQIK/ol0nO3JV
         Z54N4obkJYUHQOOXQqLqWNS5BqRRjrbk1kwSM07i9E8E4r5qCYzRoO8Vo6nIx3/7Zn06
         UkV6wHQT7e0FkSmCrFz66oISdmTuz+mhfe3abLC8LeH3JtDh8sTJ+NTNWC8/RnXRhA8I
         Bh0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784909956; x=1785514756; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FuTrxtmptBklBXvMb0kKcU77gZb2KY5onwBT7j6J+nk=;
        b=QBnWBs8pQw5wzNA8WwdaOkxUQQF7Ena/XK3A2pUYAMvQPPyb581gO2Mi/SAXt4VDxb
         pJNJe7B3v2OfgFRxwFEEBcaCxpmAOIGWUzmyQuttmynAImfQD73xIZdZl4l0P0rERPJP
         /lpeco0LGrc68SVmmkfXDi/Aiw6UgwokLKaftWKsyA4eseUOQuApP6mrpcFDoGn1Wdp2
         XzAotZjdfQ0eU3U+C+NtkPomPdCRd4j8kHoXIpQM7ncqY9xHNmrgaWVaQoVZS3puy+79
         pPlDzrHQ7WmKBGJy7BPyjCLZwlU5rtEpJaNSb/4DoSuZoS5RoR+vhvY0bbEDi+a4G8IK
         uohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784909956; x=1785514756;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuTrxtmptBklBXvMb0kKcU77gZb2KY5onwBT7j6J+nk=;
        b=f2dcQw/HMXX1i+eVPEBgfwFdbr/hqYgpSpqJM0m0mHai5lyfuKio+Qau932/DN7QH+
         KuYjHDSOfbazMYv3fLIKr04u7679gCiS16hCp6vLVTITeKTXTi56fpJp/2sFsqX6xzEA
         s6epY10PCNrc38IAvC+DLSmrAWd3thx1GHLuRceu1iSX0Wan8tNrhksEYljZqCb3aRGS
         NhYjG0eFUFFIXS14MnQhLIdq/Bzae4TBAcytwGpVFfphkk3vtzljFD5x/EefZH/UDK4O
         z8pwceZQJXKIRJI/OKK/zTJGLZ/BtYZelfnFb6m6oU+e3rEhjSMRnGj0L2tj758eTfkO
         h0FQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp55Y+52+VS2vb+ueOMToL8jzHbQG7A9r20Vf8a1998Sh1OMR8DTcMunhSt6qEuObgBeSkNfg4lwUqEMQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9u6fgs79ngILI22I49iVCmIW5zdd/I1lPov91afWFxjZXCO32
	CTKbKxnNchur2i3p6ySFk5dUG4m+GE/mQAx0tvPPuT1jbrJe8bGAgEQGXisGKvvdEuD4pU0kW6o
	tWgS+vYYF8nDakTKoFldLuxUCXCKLNPglhMCZkZcfrWJJUjDet3FtLCaZ1nrEecglJwXJ0oxcAr
	hdgewIY6fe8sMU6pcuDL4u/vV0xq63AKt9EXH00adu
X-Gm-Gg: AR+sD12eNveqjguhMjDtyt12yYDnafCVKgpPpfklgW5wXB3XCnn5Hjrc/osX++nd3zY
	vjTz5V3iJ/U6EeNKcPhqQEWcmdkMWJ8niuCEeHXWStO4MtFvsj+9yZ7zUjHKNsxJG86kJDPvvkn
	4uLOkeH9c+1b1+z49ikPvtcc+x4MXLtX8SYLGoaFgQGNAbXrz3JghuaDyFOFa5+a3AsKoX6now5
	p7EGHDGoaLgI0Q7TCEzwVhCOxXf2iBuI5PUnKFy4mGrkVO/FN/4UWYPgLfMVUBJtPgqV/gzkig=
X-Received: by 2002:a05:620a:a29b:10b0:928:f440:2dc7 with SMTP id af79cd13be357-93103608240mr655010885a.35.1784909956452;
        Fri, 24 Jul 2026 09:19:16 -0700 (PDT)
X-Received: by 2002:a05:620a:a29b:10b0:928:f440:2dc7 with SMTP id
 af79cd13be357-93103608240mr655005485a.35.1784909955860; Fri, 24 Jul 2026
 09:19:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com>
 <20260703-block-as-nvmem-v8-5-98ae32bfc49a@oss.qualcomm.com>
 <amLwz6WuHYUwKKJo@infradead.org> <CAFEp6-1_iariDyqWj0KezHAtULSO+piPHX0F=Z46Rx4KDNLmXw@mail.gmail.com>
 <amNkX6HV7c_8jRUa@infradead.org>
In-Reply-To: <amNkX6HV7c_8jRUa@infradead.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 18:19:04 +0200
X-Gm-Features: AUfX_my698y_ctqeRF24VMWwW_1w27mTDvVkuG8C8ZhXfnEBEfynx8DYsYuY-cE
Message-ID: <CAFEp6-2sZTBba4isNDmykh1X0HCxoeWQb5_bJp7AGQHU1E+MLQ@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] block: implement NVMEM provider
To: Christoph Hellwig <hch@infradead.org>
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
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Pq6jqQM3 c=1 sm=1 tr=0 ts=6a639085 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=JfrnYn6hAAAA:8 a=-e8Xlw_gh5nxI56MKtwA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: vAPAh88HZVYzcfDGptVJ7Iiy-3wlB5Qf
X-Proofpoint-ORIG-GUID: vAPAh88HZVYzcfDGptVJ7Iiy-3wlB5Qf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE0NiBTYWx0ZWRfX3IK8Rwyz/kSu
 wco1kdLwE63sW5YTT6Sn6wWN8fOROPjCPfk5yGVZLW2LVC6qjJ2zvukO7/8aOde2SN8wgN687ls
 5n5AtwMkajnrWeu0o29LRZ8HKHIIxBo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE0NiBTYWx0ZWRfX5cDEEOtF70v7
 gPBHVe9dV2Cg01oJf8b/vUGlRW67ddI8HZa/ukRRUlZ4GpJzY8ynWsp/BfNdBR+cTabxhYEBnbe
 ukeBrorL0z03VcjznxShNmXebZD+OZun2vzdf4rKx2k3DxiyNnTm9AzxoSyqn+kac3xhXs2ogMU
 AFGzx9ylvghtiR0/eT6PQ29niZzOphkCVIdN0RE0sd/cHP9+6F/GrxYRIDS3kaMUJL6JSE5IB7j
 YV8E4mTH7Tx3hE1zRLHctLkQuuOpND5ATX+8zrY7UTmhBC9g6BmNa2fi1+ZHQ91lq8EZjJe90Cc
 pmRh4H45wIkHRrU5st09fV3jibT82FVTI2OED4bRfd2VnoepmSZeaeiQ1Zi8zcTayJz6tsnIvV0
 AvFm3gudIII6PEaaJ+P3g/CE+CE3m5pc6BkBGx34v2+yZHcEdlM1pQIvOGThD5ERYFr2BG6V7BJ
 s4oYT8k8raJqC9PZv5Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240146

On Fri, Jul 24, 2026 at 3:11=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Jul 24, 2026 at 11:10:58AM +0200, Loic Poulain wrote:
> > Right, I was planning to add partition support in a follow-up series.
> > But since this is really supposed to be a block-agnostic feature,
> > whether it's a disk or a partition, I'll include partition in v8.
>
> Please include the partitions, as including them or not matters for
> the interfaces.  What is holding that support back now?  fwnode
> magic?

Yes, there is a bit of fwnode magic involved in partitions of/core,
but adding it is fairly straightforward.

>
> > > Also once you register the whole devices as nvmem provider, we really
> > > should keep it from being used a block device, shouldn't we?
> >
> >
> > I'm not sure, the whole concept is block backed NVMEM, so we still
> > need to add that block as base layer, though we could discuss
> > suppressing uevent for it. Preventing block usage would make the
> > feature much more intrusive than other NVMEM providers like MTD, where
> > the underlying device stays accessible. And we may genuinely still
> > want to write the disk (e.g. for factory provisioning), updating the
> > very data the cells point to, etc. There's also the layering aspect,
> > if a disk (e.g. mmcblk0) has logical partitions on top (mmcblk0pX), we
> > still register/expose the whole disk mmcblk0 as a block device
> > regardless. So if a disk contains NVMEM cells, I think it should still
> > be exposed as a block device as well.
>
> So we now get two unsynchronized ways to access the same device?
> At least we need to prevent exclusive openers on the block device
> side.  And document the side channel very well.

Yes, effectively, so the simpler is to open it exclusively per read
in reg_read with a holder (exclusive). This gives us proper exclusion
against other holders, but only transiently for the duration of the read.
It's the simpler solution if acceptable.

Another option would be to claim the device for the whole NVMEM
lifetime, but currently we can't bdev/open the block device from
nvmem_register(). That path runs early, while the disk/partition setup
already holds disk->open_mutex. So that would require a larger change.

Regards,
Loic
