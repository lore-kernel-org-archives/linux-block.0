Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149C43E51DE
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782912968; cv=pass; b=EhabI2qokpAthwbWwFJH/QtAEahWqTchm/2Rmw7KnfNnENSdQxJK9LPfA2O2ToU+9AcWwlbGHsTcHdI0wrbJYhaEpDvbxeD0O2nxB6soF99I38//0beq/pHXv9j6eofu0B6xyvWtI0sNgiiFEPyQ9pgCj7mupjOr2wwcN8b3ltg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782912968; c=relaxed/simple;
	bh=N+n/R/mlFs2wkRiMkBtopMW3wGbtfZ47UIAhPinzCC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoPyDn3tt96EuqcjMGTMObkOD3aK7ZjpTDUbgqAW+3W5c7dyhMFAxoHIp0tCMB2e3kLXGcpgZUCPuw8C0ewdaGSUP3s4SLRKlyaCW/+NHxRjPwCnvrVsetcO9SOD0CC03Ti6Xb2aw26Fi2kx0y5M3+UTY+Eq7YelRav8K2/fnVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D0TYYJLh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J/Hzkdi7; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D0TYYJLh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J/Hzkdi7"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8kUl762137
	for <linux-block@vger.kernel.org>; Wed, 1 Jul 2026 13:36:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=; b=D0TYYJLhf1Zwu2jk
	spVTvuXD1DtrAeoeC2o9zHuxnGi5L2oNStqdVlMFzAka42qve3FCqsZ0imRiSjGS
	wY7ttgiTuQozDBsloMvMWMZ7rH/qOR9G1lDsmLiF7+3AQRgTZm29mCqmNwGw2zKN
	vUeqWlghwM2RkTREn3uRhASvg6bSZRMNTxyjChtRcJbcOyj43Bn47PrPRgooNtem
	izYRe/87MwRcAlgJr+M4KcqpvbGLoJprSrbUKhtWlVLLmIPX48qaTHAE596YlbJv
	Qs74Yv6HObEi99FocjmPI1rDGZPAdejjSZRzvLFUsQfNCiXq1CiD5iYcCYaKTrC8
	PAdhXw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sd0vm6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 13:36:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e68cb7a3eso137116985a.2
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 06:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782912964; cv=none;
        d=google.com; s=arc-20260327;
        b=I9S2wVRKGXHJX8Qgw0TpTXQOKpQv4W4o13jJT84vu8+BDF/HmeC4NKG1bdUX111Bbs
         /QEyOSZJVmqWR0sZ2IYcIpHRupZe8TLnQH4dcWEnof5gxAU26Cap1gZ9lK4cbyTbmbqQ
         QzVBtcO3/H4wtXxv965Yuy6d+eRhV2UlrlHHllWQNpR/v6AaE/A2pu6Lfx00zmI4m99B
         mBj+UUKiOIkFQifyCyd2SDsu9C3RVX9ZqhwOyqqAfPtDSYduG2+9KEw9K7qHhLSGvM0r
         Cydisgl6Y+yNesennaK4FPniglFUmzXBWYSnj4fxzVblMWhbeTWUL69KZ2Qkw+SRamev
         6NMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=;
        fh=M+TrkfU8F2iVNUZCRuXBwQOHyiyDGaewnmjz6Sjxhus=;
        b=T2/Y7r7CymHRlIQ55ZP0AzuHUKZIzAD3TDfa4eaTjsh9RIZcMJ1MfmWtsPuOdkGFFQ
         JNScjyuEZA9V6XJQg1SczFCWX7+CdMQmzZmh2VVMNMDjU5MCwlR4FbSwB0Pj1RRIPwEl
         pLPFnE9K3hOPskpXx011+BR4S+QyngiUOlN2sLORep7xmJfWiLhRhZHoQfFtQayg4SD2
         gjph7E4RtDfGPLoGyOddCID3LULOQDYAGWnG+BzhmDpltFyOAJQhY814vvcZsZkkXwu3
         PLcQP3UOGmVLKkj8G5/SzWaFp9WvCfj1RH6iO7Nfp2tIHnS8SpGlXqzCeSGS4lL4CEai
         WVRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782912964; x=1783517764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=;
        b=J/Hzkdi7UAfkvQ3JS+pBNsS3Qmx4/AV7Wjuw2Oh8ju62IMD4QCIsi8DVpTbiouooBM
         Rcm2GJbEmdUbxy+Tc3ChOTTQm7hJOvM938TBwM5bFgA4o2C2AO2+lMAO5TMybnLRSHmF
         QLShWKLlcjvI5yKmQ6Mwu4jxcPhKVXtkg+uo2PRdBGokaoUPmnFlQQW49W+GI91P/mM8
         737P8Heu+Qg3/8bZhhpaNqZxmFsxiIS3IqmrucpJR22QrEYxEOYX4bOgxfGLNUTycXxA
         1HWSCdbIzTxZKs7dwvsBdnBCIeB2WMujN8Wii1CvgsQCQmMwEdU3daGY5Pwffj5LsOHs
         hBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782912964; x=1783517764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ViDlik4RCW62sl/RLk3cKzJ5UtFbYqrOCQjRpG10ly0=;
        b=cDDUmNRF4vbibxeDWlXqpzwGilTsIsj6SgGhl/aNxCpKy+MBDD8/0ddBz8gOIO3j1Y
         RmX1XC5fpG3UaKcrYPBUaJqV/iYIdATUCImHMQvnzwtffv5v9GWpiziK79di3bPyTOIR
         AJC6wZlHftaaDFsUsp3TRkbe/A+4iVwsM3EBvdAnWIizFiGC7xtibDMJtDCQXF7nq2/B
         40b2STgwA2HOM0QzloA7UdHu9kUn4czAD72jZoV9whzXBe0xdA0/V4N7Giw5Pg3RMENz
         H8Py6ldA2JNL4dzDjnAs8mveMIGfBIQ517dazrH0+yKcPIuOvV4O04G2m5EDZ29Ihgtk
         DFuA==
X-Forwarded-Encrypted: i=1; AFNElJ8C4d+eH0KaKuN5cHYS0aRyNKlgn57YHYOEJ998vuiS0sJ6leCd8B4ben++l5uV+7MrR9U+PaiE88A3Yw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMei3H5QyH5N/qS6TooEZ+Wbar5yUI+GmZwVRrHu4WYxq1x3BW
	qtCl5EFPClXdvDfx2xGnJZv4wg0GgQp4SpIUOXUIBrDAHmOpTYkZEqa9OmKdjHcQauaErsTdZ2Y
	+yG+dEe7+4p2oIJsNGbkDkX+MNJEPy5NoqH0Rz8lI2vk5zj079Bv88ljeBpxL7kchAIFFYCKLuh
	bbRZnQzfeKK4sCy1s0R77PL3RzB49W8I3l9Pp6GeYd
X-Gm-Gg: AfdE7cn85TEWialjc+bFslVAFBJyMom9L2LpyVuNUjNMy5LQ6iz4fDBj6BtKlN3C7fz
	ongxAXQ8YKtgNOWqi+vbmd7yY/S62L6Z3KHhLT4s0fOalsWpbCABt1DegMhkh/0iJ5O5MJ9zTHN
	cn4ZXeuBSJi/iGkW9z2Hs+3mHV5uyFrQLu//wMc6rvZhjgDZTdJBU8f0dPkrg+N6IkFjBSZIue3
	9fl4sW/nEx8JUWQSGUIxHTNCYF6TmO66XYB/VJn10N1VDzv1xCnz4sl8qy+A3tbTER9uW17G9EF
	ZnRntMaPUw==
X-Received: by 2002:a05:620a:28d3:b0:92b:6805:91be with SMTP id af79cd13be357-92e7853d109mr199456985a.70.1782912946725;
        Wed, 01 Jul 2026 06:35:46 -0700 (PDT)
X-Received: by 2002:a05:620a:28d3:b0:92b:6805:91be with SMTP id
 af79cd13be357-92e7853d109mr199161785a.70.1782912918609; Wed, 01 Jul 2026
 06:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629-block-as-nvmem-v6-0-f02513dcd46d@oss.qualcomm.com>
 <20260629-block-as-nvmem-v6-1-f02513dcd46d@oss.qualcomm.com>
 <20260630180219.GA4139943-robh@kernel.org> <CAFEp6-163adAq8-H_pCzGnq+Fo4jpyKGs6Jv25j3fSpZg3COjQ@mail.gmail.com>
 <CAL_JsqKFjk-mdaAAOzNB6rFiJbw5gd4eDpRBLQL-4q+uJKnp3g@mail.gmail.com>
In-Reply-To: <CAL_JsqKFjk-mdaAAOzNB6rFiJbw5gd4eDpRBLQL-4q+uJKnp3g@mail.gmail.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 15:35:07 +0200
X-Gm-Features: AVVi8CfNT2AJJTgPBXfFVJQmZjW_-a9Isbc3rycVEtJcwbZkpqGBU1gJZohgDaU
Message-ID: <CAFEp6-20FXTOKQ6EPuR8OUDkqE4JXcUbXaFy7kRFt4fzszPQCA@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] block: partitions: of: Skip child nodes without
 reg property
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
        daniel@makrotopia.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a4517c5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=bM2Xkg4KEcMkddnjsM8A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: j8Y-dREdX8ch4_N7wiOLmWepHvwKNdUi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE0MiBTYWx0ZWRfXydgNHr5fUFGW
 K2qFnPQ3jFbuqkWdsjgdMZtz49sgilIUaiovDBZuaYcl0XhbFYraAjoYhfSOBB2Yg4AZiD+ZSTE
 XeXwNWD6H4tM2psc5CiKm0/zsjXkGCc=
X-Proofpoint-GUID: j8Y-dREdX8ch4_N7wiOLmWepHvwKNdUi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE0MiBTYWx0ZWRfX9JUxXnK9tr3B
 FJESOIGLUXDNz4XOTO5tpRuPLAP/jumdodbHpyhGmvrWusXc6TRqE54UvzZSWmkPXLZRaX/6tSc
 HxACkbo24OrlmfQQJnh3g8cZHn3qYHdB+oNhvAsVfRfEls/b22aVyCjYDAgG9P0K3hNpYBH9K8v
 rqafzKFIO1F/v3pk+0w11nZq9RLpzqdprrZFS3X5FzwIQB2WLWFWEEjfG4gL9lP96S3pZiQJNpb
 0BPflnafdaTd8coahFL9ofqULGqLs0jrsHZDmJm1YDDebKQRFu3DZA5fFGhppnKZ9bGJw7L72o4
 0P1HWGD1Pyx6QA4mvtyK0h+MFKhvnc7qo6PIccucFSTbZZdcb2bXvZAsc73B9xr8MZTF0NiSKw0
 YsdONgIgOJgcLz0dkkuCexkindSNnCBUXsZqEiWJqO2oXsb2lFolqSkMdr2cBdcOATRqDV5ykpF
 t/FCMlZKY4YLCf5TSEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010142

On Tue, Jun 30, 2026 at 11:46=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Tue, Jun 30, 2026 at 2:59=E2=80=AFPM Loic Poulain
> <loic.poulain@oss.qualcomm.com> wrote:
> >
> > Hi Rob,
> >
> > On Tue, Jun 30, 2026 at 8:02=E2=80=AFPM Rob Herring <robh@kernel.org> w=
rote:
> > >
> > > On Mon, Jun 29, 2026 at 10:55:20AM +0200, Loic Poulain wrote:
> > > > Child nodes of a fixed-partitions node are not necessarily partitio=
n
> > > > entries, for example an nvmem-layout node has no reg property. The
> > > > current code passes a NULL reg pointer and uninitialized len to the
> > > > length check, which can result in a kernel panic or silent failure =
to
> > > > register any partitions.
> > >
> > > That does not sound right to me. A fixed-partitions node should only =
be
> > > defining partitions with address ranges. I would expect a partition n=
ode
> > > could be nvmem-layout, but not the whole address range. If you wanted
> > > the latter, then just do:
> > >
> > > partitions {
> > >   ...
> > > };
> > >
> > > nvmem-layout {
> > >   ...
> > > };
> >
> > In our case, the nvmem-layout needs to be associated with a specific
> > eMMC hardware partition, nvmem cells can be a simple sub-range within
> > the global eMMC, each hardware partition (boot0, boot1, user...)
> > having its own address spaces.
> >
> > That said, your point about not abusing fixed-partitions is valid. I
> > initially dropped the compatible =3D "fixed-partitions" from the
> > partitions-boot1 node when it only carries an nvmem-layout and no
> > actual partition entries, making it a plain named container node. But
> > it's a bit fragile if we want to support both nvmem-layout and
> > fixed-partitions.
> >
> > Regarding your expectation of a partition node being a nvmem-layout,
> > do you mean that the nvmem-layout should live under a fixed-partitions
> > node? Something along these lines:
> >
> > partitions-boot1 {
> >       compatible =3D "fixed-partitions";
> >       #address-cells =3D <1>;
> >       #size-cells =3D <1>;
> >
> >       nvmem@4400 {
>
> partition@4400
>
> >           reg =3D <0x4400 0x1000>;
> >
> >           nvmem-layout {
> >               compatible =3D "fixed-layout";
> >               #address-cells =3D <1>;
> >               #size-cells =3D <1>;
> >
> >               wifi_mac_addr: mac-addr@0 {
> >                   compatible =3D "mac-base";
> >                   reg =3D <0x0 0x6>;
> >                   #nvmem-cell-cells =3D <1>;
> >               };
> >       [...]
>
> Either this or replacing "fixed-partitions" with "fixed-layout" if you
> want to make the whole boot1 partition nvmem-layout looks like the
> right way to me.

Well, now I think both approaches make sense. We should support a
fixed-layout on the entire hw-part/block, while also allowing it
within individual logical partitions.
Support for the former would only require a small rework/addition in
this series (to have the hw boot partition a fixed-layout) . The
latter could come in a follow-up series, as it would require some
additional fwnode logic.

>
> > That makes some sense, this would require extra work for the
> > emmc/block layer to also associate fwnodes with logical partitions,
> > not just the whole disk/hw (hw part), Is that the direction you'd like
> > us to go?
>
> Yes.
>
> > Also, Note that regardless of which approach we settle on, this
> > specific fix/patch remains necessary to validate the partition node
> > and prevent NULL-deref.
>
> Fair enough, though the reasoning for it would be different and
> perhaps should give a warning.

Sure.

Thanks,
Loic
