Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D9B339392
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907347; cv=pass; b=tmERDrTaR3GfYlrLx8gEu0pQKVi7gkmJNJlssAfwnbNuPf+43PdO5QAFeJeO1q+NbxMb0EooaeMDccRFQegBOrV+QjVpuJpyuu83aTuSDdNLU4xozOAZnBEpKP44QXLl8+z2n1pOydfJQ66i3SZv87mi5KTyhsn4l1jLM5PLqSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907347; c=relaxed/simple;
	bh=0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RWSPFlIUZ5DKkFsvjEmeUr78E7PiAWuxb328gZe11qtYg/8KSeo8uE1cDopbkhFHL8rXN4NZu0JUVsjE3Imv6Z/pQTpAwMgNF7jDBqBGXGGEGqUmCPzxYJ9XMcoNPBcJoUnaVmXndHHi0mJvT5No8slvCql1wIzN/8IHVEBlK9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U0UZBLpm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Mh26x3LK; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U0UZBLpm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mh26x3LK"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OEHQX13467854
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 15:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=; b=U0UZBLpmLfPDvk4s
	5VVXy1GRsf9VjasKo9AZa15zarTyGa1QjJqnsNNIcbBeIhq1YHNQb+NLdvyNnDBN
	7R2Qp6iSbQ65AuK6J6JrFFQ1KCQdPr2+h/xLiVb0Y/MG478NDq04DnEdkLa8RE0C
	q+9xAuEvlxgPwplct6yAF7BlP/BSC51W0qX4xC1wqPCC2kNiVj4k938GrWe9if+u
	71b3BDT2ouTx0lPbmDcd2jAvWSKlChEuLO3YlNrfAItJPh+7d33op3mu57wYkF5k
	m5xvoz86F6mTz6U79nCSLiaxF3eZb68e4/ZCxZPnHU/bjNLEQ39PFmoJr1mgXWyD
	Gn0Tzg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm9pd09f0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 15:35:44 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8e9489f62bfso8677726d6.2
        for <linux-block@vger.kernel.org>; Fri, 24 Jul 2026 08:35:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784907344; cv=none;
        d=google.com; s=arc-20260327;
        b=HYfXxqSC4Cv0M51cAl0sGs3bJIDgryDIvPZxqrtpVKgF7CF0B4yBd/oYOREKY7mn94
         UvY1PkCNx5ZWmh3FyNQ04txUJgyd60QHsI9Fm4vvchshN04m0cucDmiN746m8PCeqcGy
         mQDj7iov7OWZ1jz+IXJhtHRlfYMizFNFc+OE7p1ps3uDud6zCHhUmn1FcpmMUQ2+5XX0
         /5E9IaxJKVa0vDPcj1JsCvse+Lp0aM2rGGp5IWwRaeGal368RTNCiYqDGl8jKuZrmGxN
         T3G4sUWRpqI+MjIsG1v2WwX5NjYQbJmiNdTRFQ/hiw+O8JEQ6e7Ny82U8ypHlJwIRB7K
         U9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=;
        fh=WwqmCXD2KnfC2oyt87M3jbQQaruMDkLK9cVie3AVrmk=;
        b=jWOrrVpXhhHqjBvsIt7SQEbN7F0GsgebYem16N73nrKy5BQIteyGK9taRH+/CThB2C
         /vX+BrslxbEdgTcaEjGbtD4ndAHnF8Lo6BqSI1O/MM4v515gbyZOKpUZztylyWG+/bqT
         6IYUPEgPGAlVe7EysAVvYg5Ry8ABlmDmiAjwFuxSE+Bp4V9fw607Io4NIjLK1zIK6Br6
         HdWJsRSPfjwr9tnCP15lOKSKxyqPBrVq7U0kpUVwzgXJe+uyov51NCXdbu83J2Xynnit
         +NxxrBU6cRxh5tWxpXWNg0dAj56vb6su7a0caZm5P8W6gizto4o/sma2MhR0IbMqdXnI
         Pjmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784907343; x=1785512143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=;
        b=Mh26x3LKlUfjMyUTMsdPzBsSIeHZkdI+mvNO7yint5/pGl5OhGKGzyUhVm4cwzUhP8
         ByS+yjWITK1i3sYzP0P77bSL6q6Vr0M5GLkpA6K0FB9VXq6660zEBGCsjMZi0ZgKaEyF
         gWvk4HYyBCw9GSwJVBa1EQB6KJxkUcxFZamUuH2IRWXAtfdcL3SuFVwWMh4tx4OXMZH3
         Md7ZkQvgwbnuaG1kyvFOiB3SRvHuQi7whrPblAn6CuEp9/NRGs4eky9fg0R783/J79sN
         1mnUAWmrAxBie3kHUD9RnHxWTycPzad+sEga7XvGUy95zriVZo/XQBC03Ya41b3iKMIZ
         Hqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784907343; x=1785512143;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0AxRvCjS4SeGauYtGrq3Gxj0CFvSuzE9MU+SB8VxZqM=;
        b=LIA/9JjmXEpaFlS7y6/1/EfzYlvM5dwPMsAeun8Hb5sHu/moAg1C3KfwP+kneT/99y
         UMiIm3Xq6+YWmX2/xTa1DuKzOhqjeKtH0qlVU/r+/QAUcuPSw+1PkGX+vsJicS4pPZrl
         sYbcZcDKxFOMIZH3EHA4IB6F8mqu+1HQTs4ISpc4g1/5m7pxYXEWpqfWTT7RsX+81eoS
         LYaNDBNOcq3m2oRt5TyqSxgfDWbt2FJQPaqhbYZbh7sCkxxfHLek7I2dNDf/023D/ATH
         gzupVyZRrWWdlWKZYeWfWE6lBzJwhmmuEHMm8daCYpHHJcRJf0KbFd22sMJHrGLOterX
         ILdw==
X-Forwarded-Encrypted: i=1; AHgh+RogMIqdyoXUccw8koAdu491mL+Iwev8RPnAZYLVuKXxmrgqMjf3F/ndUWDVN3SIJIvEy3G2w3+9FFazCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjE4xGWxBJrIJ9XJZkWhQt950a346RtwU21AtOjdjGN+8ocYt9
	eWieI69Uz6G+K2Hq5Flfq4hiUkbOQbndeyQaebolUPKoCoLkmXrXpG1828P8Vszseg+JtIFpRIn
	spSgSXtiAr94Zpg4duT2hCTrZAsJqfIaS9yOJztY/qvmRbI2agcPWk6Xm+VrI4uovNT8kL9iXw4
	KHdhzaIJmilyVGfhVliZffjUhVrflz0D27eYQGvPgp
X-Gm-Gg: AR+sD107Ro91v/zdkX9Q3MG1BWIdE83ycKRve1dtxmBzADhRD8wTvh+48vguqUtsKI2
	B9sagKChtRpm5nkVf4YjHortndfSfiWYsfCJ6kZZk8VIWVHHgTFuec0kMOZYM+QJ2ls8ZcpoQyX
	HKrBCDtx/l9r9F79uRTMGmX7OoADKrxZ9Ct2Y7oj36jXSw4yrsrKKiVTZvbw==
X-Received: by 2002:a05:622a:228a:b0:51c:1241:3b09 with SMTP id d75a77b69052e-5283de54e1fmr76891371cf.39.1784907343559;
        Fri, 24 Jul 2026 08:35:43 -0700 (PDT)
X-Received: by 2002:a05:622a:228a:b0:51c:1241:3b09 with SMTP id
 d75a77b69052e-5283de54e1fmr76890551cf.39.1784907342860; Fri, 24 Jul 2026
 08:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703-block-as-nvmem-v8-0-98ae32bfc49a@oss.qualcomm.com> <3d954cdd-6dde-4be6-84c9-2f2f7d008f5b@kernel.org>
In-Reply-To: <3d954cdd-6dde-4be6-84c9-2f2f7d008f5b@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:35:31 +0200
X-Gm-Features: AUfX_mwd1WNIZvdvXqoWeMIN9Hp4kEAy8VC-hn59NszviBxEKOIP4_juVgFnXVE
Message-ID: <CAPx+jO8-9YSJtXNfnTrUX_JiCyddXHn=wHek9=c99+fNp22Zog@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] Support for block device NVMEM providers
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
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
        Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: WLPvkqCiQJJZHbWHnBzz1WQhivt_5t5a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzOSBTYWx0ZWRfX6Ynwc9nqyblO
 wWOJwfB1/omXaObX9JS5uXFblqt2lcA0snCXZcM5m8h5sbR6wils3Xi+Ld8SqW9UkWiVeh+ywhm
 JY+tJ3251fy4PaJaVD+BVrQqNYuiJ2XugKyAEYBehOSgO1R3MRHm6jX4YceuXkOgQMo5QffAIEe
 3/cKbK4gJYyQf0MtDX4v55tk3SUyKcGg2e3RnDHdzbyBVCCC0gR4YQQY8mVRIfyzxZwaJdevoxN
 n9Nv3f19cl0HQPnV8dl7Px4T/1xdwqHP7bbHqCnfojd35x/adYDq0GEwp32/Q5mxrlOAle2S+0c
 rQ1dIfxWFi2Gj02JfDr8xhR0bnJcT7ftC4jB0oWJn2fJA8qdfn1MwTXNMwh4Y1RJI7B+9F8C58d
 H3mIIeURKE13Lf85n7jJ9jDuSBcujodnJhBFOJEAPurxyl505SnxKZHGrLBejoBu4r+7J0ipD4a
 bX4VXlgTVhPjzXePq8g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzOSBTYWx0ZWRfXzHYVNBmvpMci
 Lb2sZSe750rnZiuBWso8s8NYpUVcEpkKm1y3uDzob2yuaZ0c1Yrs/OMV8OLnJ55IzTaZcH+dEwq
 ISgH8bEeOIlrIoQkx+Qte9Hmgq2nBs8=
X-Authority-Analysis: v=2.4 cv=DLW/JSNb c=1 sm=1 tr=0 ts=6a638650 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8
 a=XoVDlNqzt-XzKL8N3f0A:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-ORIG-GUID: WLPvkqCiQJJZHbWHnBzz1WQhivt_5t5a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240139

On Wed, Jul 22, 2026 at 3:56=E2=80=AFPM Srinivas Kandagatla <srini@kernel.o=
rg> wrote:
>
>
>
> On 7/3/26 2:45 PM, Loic Poulain wrote:
> > On embedded devices, it is common for factory provisioning to store
> > device-specific information, such as Ethernet or WiFi MAC addresses,
> > in a dedicated area of an eMMC partition. This avoids the need for
> > and additional EEPROM/OTP and leverages the persistence of eMMC.
> >
> > One example is the Arduino UNO-Q, where the WiFi MAC address and the
> > Bluetooth Device address are stored in the eMMC Boot1 partition.
> >
> > Until now, accessing this information required a custom bootloader
> > to read the data and inject it into the Device Tree before handing
> > control over to the kernel. This approach is fragile and leads to
> > device-specific workarounds.
> >
> > Rather than adding a new NVMEM provider specifically to the eMMC
> > subsystem, the new support operates at the block layer, allowing any
> > block device to behave like other non-volatile memories such as EEPROM
> > or OTP.
> >
> > This series builds on earlier work by Daniel Golle that enables block
> > devices to act as NVMEM providers:
> > https://lore.kernel.org/all/6061aa4201030b9bb2f8d03ef32a564fdb786ed1.17=
09667858.git.daniel@makrotopia.org/
> >
> > It also introduces an NVMEM layout description for the Arduino UNO-Q,
> > allowing device-specific data stored in the eMMC Boot1 partition to
> > be accessed in a standard way.
> >
> > WiFi and Ethernet already support retrieving MAC addresses from NVMEM.
> > Bluetooth requires similar support, which is also addressed.
> >
> > Note that this is currently limited to MMC-backed block devices, as
> > only the MMC core associates a firmware node with the block device
> > (add_disk_fwnode). This can be easily extended in the future to
> > support additional block drivers.
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
>
> What is the merge strategy here, Am happy to take it via nvmem tree if
> all the non nvmem patches are acked or reviewed-by.

I am planning to pick up patch1 (dt), but waiting until all the
complete series is ready to go.

[...]

Kind regards
Uffe
