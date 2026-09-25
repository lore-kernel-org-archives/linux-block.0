Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D525B091
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 13:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343551; cv=pass; b=c6jqVHbDssfLS73abhZkHxaSZpTRPD4xwc2MgVg1iff6jPrJcqqVng5gNKbG6xWpnuHm16NEcxfKlFN+w6mmdx+ac3VYPBwwW3EiIQh5wQnMaicIWpb9yGWHhGwduEJVC3BX/zz9G683iAxLLuu2UDyQVSQwQvj+25WS6iYVlIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343551; c=relaxed/simple;
	bh=kqdNlwg778/987rRPFcemtjB5R0/alDQShoyszIUXi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CZxoQFvZFFEa6hgQDmI51SHQhkVyt9ONzRjqH9FMAehvJsKl9YQiLJMQZOkEKdOytO7gfTlDtUPNLH72dRal5sxn54XzxERxAwJrQT8YTQM8pJJkEbi3Hdvla7lu4H8Y0sfav1lTz9THGj80ArHSnopINKSbIReLPvOVL3X3UAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CiFirrNM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OjLnN41T; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CiFirrNM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OjLnN41T"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PDECHS1056143
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 13:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kDqgsZ4XGZtl4jjOzkJ5PS9aFgMs5r1UIrTA9EsegCY=; b=CiFirrNMJE46vkez
	ab/ALVoKzVYq3KdM+wurlRbp1B6pozl0+xZlajKqHYhciUozzuBY7HlW4B9bEgeq
	01aTayxTFbLZjXcK2kUyA4C5CGDxayVgrjT12DPiulgqZp8+24MXVbQFUBKalGN5
	p9GwIgBIhMFeCrnL/r+4yFxTmyyyZcUvwHKtmgVueHEfPC1dTHXv2IcCvaA5pY9E
	bXsatblJpbCU9xw3/A1vAwABdtqMVYDxHNRpOtBokCQv+9P5D3KSurkRHYF8jsvl
	7RxWADkv+Ho9B8J+D3C4m7HNizpmI3Gz6NL7dRH63YIWrYea4jFZFF+zLX2j8bQ9
	XChfMQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwce7akxy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 13:39:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-936aa34873bso161449685a.3
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 06:39:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790343548; cv=none;
        d=google.com; s=arc-20260327;
        b=fqV/KpflbwLYqjScUqLVU6eEIsMVm1pbAzephD1qdhG0maleAZYFHA1UJyKnx1WBgZ
         yB0wOWzjQZ6JSuFoWBtHytlVB5q+Oa5gInx5k4At+7tSih79/A8nEGrUqUTX1wtkp8TU
         fzaotjiYFvm7I1NQv/yN04x6PEAXhfMxu1kov52+Wia5XO7vaiJzM2UgkcuPq91HmjbI
         zXq/yQlwlv7BHOU6n+ynDCNw3Qx5mW8z7f0vvfHqFkXBVu/hXGA24deGSyD/mPBYeDtN
         nF46kGDrr+vuzrXS4EsyG1GKScWOr6d7ER7IW6O7vUPxECA/fgXub4GgHGoWZtrXPcDH
         13MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kDqgsZ4XGZtl4jjOzkJ5PS9aFgMs5r1UIrTA9EsegCY=;
        fh=QsxoCKmPx6o9mplWsIZBxtWh0uRj5No8TVzDMQJ+uxg=;
        b=klRCDGrP6v3tnM95h8+eZ4CTiLeZufOPwl//J6qV7yvZRhJv1ZL52xZLpkBAEft4Q6
         zMolIG75bgjQrzfDY+KpxDuB5Ds7kqsxfkvh6iVFlKlzfO0LgoyoaTDn8YO9RKuMX3DW
         RB/Vb1Lu6Yt0tI0Z7Y7s9ZvjF2G5Je7a8sS7eO8UUg9qKNxt74Pk5XPdaWONVtbYZUtb
         raMH8Tmo14V88TLRrUKzx71wyOUfDnleGqXl+PEBY3VOZHpHSHwGbgaN400o5Br9ONmx
         0KAobIjjDIibc9A7mt1+J5nwG42fiEQUF8HcSMlqRbrTDCYMmNaQ6wZunNjB1VG3YCrp
         70OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790343548; x=1790948348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kDqgsZ4XGZtl4jjOzkJ5PS9aFgMs5r1UIrTA9EsegCY=;
        b=OjLnN41TvHXUGa7MBrf9fj+CrpaWlDp6jgP20kUZ79RYwBnqHsD2K/ZHsBfxJr0C6X
         5bLg4kK6XWXCGlWpS4+g8GmhWc5sivFMkZ6UPcPR0PfTiZKGAXGfrZJAn1JrUrO9v3pL
         +o/3NTphHMc1pEr1w9tuiniwaSWa84DJXKLHsZJBOqqauXJKVeciIGSFjrUGEe+xevFE
         0tu5GV/o/wBP/LDnwxL4ckGIva0g4Fy9erhgynszry1UC2kIN6hUmqZne6dnMQMW7GsT
         RLoI9Iw1mSzZIhFcCnl5EDBJRUTgLvqYhyFIIEVyfYO8DPzOfGwQ8Vznq6kgHkRZsrq9
         XTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790343548; x=1790948348;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kDqgsZ4XGZtl4jjOzkJ5PS9aFgMs5r1UIrTA9EsegCY=;
        b=F31tOVbog7cp40hDhdW0jjdnnfmkCD+yXKHH2lobeu+pAEpgo+ZmA0rcjBCv/0cwG8
         ZaBdZYOh4iZF1Z/7uHG9xKJR27/8rBZAyEwTQ4lNApY4SH/PHq2zVq1jnhAyH3yj2d5L
         OEpi3hNrs5AIoaRN+9UNQ0t7hT6IfZ3XbGSXT5asY2lg7CAJJ9yWPbXePdckdwW5Cb/p
         TQeu19u25MYGEk3XarQEaweMU5YzKi6r7E2IeHHjndqBRdGAOPUd79lTuFfMPlW1tTD5
         K+/Vaci/3y0HLGyd8yI8TkuRe5mcPoxVBKAuUuPb4eQZYdwdVrh+PhstHxyssVf6HONJ
         nnOg==
X-Forwarded-Encrypted: i=1; AKwUvBwKP/2ppYJxvcOnAR3n5f0XPmHWMZTeVflI+nzcSnhChOj88+n5h/VpAqI6MoOe7Q8RxXukwdocytf0Ew==@vger.kernel.org
X-Gm-Message-State: AFuF++n46k9kZZIsnF1ERuL0MT/5+p71zVuk1lAKT11sJKsgytG8VjyO
	Ag42WoJsVFXWgFom0ZewZUnfW786AyEDYbjOct/5y0gjAaT6m23PGpCCmxDOl09tFCsi7j4E+cI
	s2r+tlzcmx5Fxrb4Hba6Tc2pO/+3V7+3/qLqlH3PN5uLDt5VeF3V5RVdGwL7akc9TjbN8+QJaoN
	6EYFghSCrEFQCCEaU3I2hKt2cHfn1PJ0rCMgNRQgdz
X-Gm-Gg: AYBFou2OYR+JyoKaxnc++/dRMcrLLUn4X8jIoioi5AudDiOKAbAwU6+dmgIOmstNk43
	/xxKblQwA0h9seUJzwrA7W9Sibwt1710oGkBXbIeiyghKHCjaFaWNT/OQ19+FRwcqYWYiECiwt9
	O2xc8mvon1xIXn6mMnjLLbobMV+H8cOfe7OxMVAVeJurh/W6BuVlgcNNZJpk16hNkQGlwYrZ/Bi
	vsjnp48CrHcXB+RXeBVggMjFhC6wWcUBe/Z/d74Oi463Kah8pmzHbzQBrKkxf/lWS/xUBye0nk=
X-Received: by 2002:a05:620a:4588:b0:93b:fbf0:8791 with SMTP id af79cd13be357-93c43bf1ff2mr431888685a.29.1790343547624;
        Fri, 25 Sep 2026 06:39:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4588:b0:93b:fbf0:8791 with SMTP id
 af79cd13be357-93c43bf1ff2mr431882585a.29.1790343547133; Fri, 25 Sep 2026
 06:39:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-block-as-nvmem-v10-0-be598b2a5606@oss.qualcomm.com> <178998281449.889291.7893229102394463283.b4-ty@kernel.org>
In-Reply-To: <178998281449.889291.7893229102394463283.b4-ty@kernel.org>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 15:38:56 +0200
X-Gm-Features: AclHuK99T0Ubawi22EyQadvbidnQEmVlySi-fMkWCvta4a9Udx0OX1G_I0L1lvQ
Message-ID: <CAFEp6-2P14MdYJGuH6ygRL4ZKtLnJEj=PVMx2p+b9L1RuiX1dg@mail.gmail.com>
Subject: Re: (subset) [PATCH v10 00/10] Support for block device NVMEM providers
To: Jens Axboe <axboe@kernel.dk>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Srinivas Kandagatla <srini@kernel.org>,
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
X-Proofpoint-GUID: pkWMje8MizhC_QsdYxVwoLiUx2wP4Ukn
X-Proofpoint-ORIG-GUID: pkWMje8MizhC_QsdYxVwoLiUx2wP4Ukn
X-Authority-Analysis: v=2.4 cv=NJFAaE6g c=1 sm=1 tr=0 ts=6ab6797c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8 a=MW6_J8xfeE2cRKj6bkYA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX3/7wlqpUwx3H
 GdOLXMQJKrNJdI9Ij6u7jfs/VrsysfNXrrCnj+fEQpYt8wkTAlG8AHnWXqZcvH7pkAeP4MuzvH6
 o9F9t4L1PZj7GRGLS/tj+56rQ4RUfUGBhE/0SPuTWnGHipeA7gh24d1uRYKpShSvXDBJ8f4jiXf
 sYCCzwijT1yOO+afr6drbcDDj9vxK2ioHsRTWcfqD66UPTPQHbRpACAnA72+W5FEyu+mw6a94O/
 f9oY/3NW+Ccu8XTls+bcayNhFX2SYTvtRzw+HLhSzH+LJbnKQQhO/rvBXk8tB9NdYNxNZw8evyG
 dp0476kQiLGtBFekIu6Lt7QhM8ojw28M6pysWDd15HOXFZOooSvxFFu4lWctfYedDdfaVE3JLr1
 fonKI49aSZzS8CMREeJSkW02okQgvveIlNKPzJMene4xje/818NOCO6ICj3AOq6k5V7AOJVL5dN
 YsKgWepcQP3NNgqiPcw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1NCBTYWx0ZWRfX/yfBYnOc9oxO
 hEcgSjH2wJZiqptNiiu/aiNEMF/a43EABQ8w+33fSYqFwm6Ps0tVe+9WlpijJ07DFRJ0+v78o+5
 Bl7j/oR2VXKjTy6b0klt9nDFEfHslX4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250054

Hi Jens, Luiz,

On Mon, Sep 21, 2026 at 11:27=E2=80=AFAM Srinivas Kandagatla <srini@kernel.=
org> wrote:
>
>
> On Thu, 06 Aug 2026 16:38:33 +0200, Loic Poulain wrote:
> > On embedded devices, it is common for factory provisioning to store
> > device-specific information, such as Ethernet or WiFi MAC addresses,
> > in a dedicated area of an eMMC partition. This avoids the need for
> > and additional EEPROM/OTP and leverages the persistence of eMMC.
> >
> > One example is the Arduino UNO-Q, where the WiFi MAC address and the
> > Bluetooth Device address are stored in the eMMC Boot1 partition.
> >
> > [...]
>
> Applied, thanks!
>
> [04/10] nvmem: layouts: Support fixed-layout as the nvmem device node its=
elf
>         commit: 9c6cab93dcd47c3075d896c777567b9d8f813d18

If you're happy with the current state, would you mind picking up the
block-related and Bluetooth-related patches in the respective trees?
They are independent.

Thanks,
Loic
