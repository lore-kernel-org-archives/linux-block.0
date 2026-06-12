Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF439C657
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255557; cv=none; b=RGGZYmwZBnhERFyH6Fh0yoZkKhEQKH9xSTIxufGyAFUlngBozv7MuUpCp1XJUTC+24tE5eEGDKqlbkp4KTXOsUgagaUnh3HpCvB67YjKHjtGUxFnUGZLbxggDpfFojH/HP83ZEh3PH5KZH5EurDDc26+hy5+YFcGwiYmzWIQV/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255557; c=relaxed/simple;
	bh=J1AFntJO8yn66Ges7ZIJc4qYkwhNSJYwQcAxHEZv4U0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2WvgCpVMZT7weuGaKR9ZklfyCEeEtn25jJtR6l3Ij/dQIYLe6Tc4KCVrYRGE8m/6mqZuvi6WqQD7b0E+3lbZ5lDeWr0ZAMFb7djV8SYSrZ7oFgLTiPGOunHlh0dttATJHGBubZarx0KuRFR6jFUghvJ8qbh6RxJQki/8aDTbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jFNQOBw0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=drLPnYJ5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jFNQOBw0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="drLPnYJ5"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C39WwB2475924
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 09:12:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fQHHtK59LcboT6pjvqkOS+sy
	sywNj2Fo6GwGmNW3Glg=; b=jFNQOBw0YkLzDcDJnKXoiojTKiEGuD6hPTR+kfeE
	2ss4OSCbPpXkPqcf78P9LgzYKAqxaVmcPlAGqnC4mH8u2xP+ivX8Z1JKJgYJEiuu
	tFZy4jkbxlMuHM8OS5TEILW7PcEy6XJ+vVd8MXZaQ873NJ+HB+Ao1D4o1bO/TyIV
	VgTKANxBx0aZTaKWlh9+1fxOJPmQWkduGpSZMoSm+IRWKyDvfkHt0jY1Y3IgaWBK
	15jG+1HAywMpEhomeAzvahK6xEPIWgg+hnoa6czhQ64d/fuNWtlXMgaVvJnAfehT
	+9DqgRSqF6u6zfiAclJrVi8a4I0g7mc3Ush60MbZ8QcBMw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2r5tbeh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 09:12:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5176cc5bf2aso9093741cf.1
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781255552; x=1781860352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fQHHtK59LcboT6pjvqkOS+sysywNj2Fo6GwGmNW3Glg=;
        b=drLPnYJ5yqlmaM0EM6PNqUTJ6HiVq+kvG/T1wFAH2kUnZ2tVnif0r5RKLShknjLTUc
         bKZve+jU8sSnJCorzQyzrYbhN8Yv1KORbXN2eQKnyx+y+wWtqZGsQPoD6l5MF6pnvsrJ
         TAIOM6tJwIvZolezRdba8WH5CFfV4SJqrUhpqkhcqVJXdMaEUHPRosyXntGIATOfogyq
         2Gf4DQ/29JlYoVxSPUF2CmhMm1Dnh7n2qzG5lJ7JW2pMMGBmDu62Yuh/A3E0MXjb2T2i
         OPZ4OI7ZBIafLfSb1iCV23fA7uXN7Rs+gNMUNF7P4w/LEsMZ1g7xF45TAn/NB4WCWrQn
         qv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781255552; x=1781860352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQHHtK59LcboT6pjvqkOS+sysywNj2Fo6GwGmNW3Glg=;
        b=Uo8lp5mqDmEWflqtBtEeV7103B2xsuAJrynpIGnY1As6utKNnMtvYNp6s+WIPP6w1Z
         SqZqnH9233DB7x9pF17kN4GsYTo66OdA9WqFnbf23BjHV12q4joVv7g1G4x2Lt0Ho2+8
         j29kjK/sCJHkcLR9waPk/UuQsQLtB5Su7xUzcenWaRTkdShouwdnbCgOCL/REVqdENMD
         oyfk8dXpAF5/ovW/FDlJtvQWSRpKRfa7K9eWHR0d8ejtb6yP3TT5dNug89xlB6cWUZ9z
         +0dVONKKpbzGUoabT2vRRqnxJi9y4BcUJTuLrm/qqizYsgTFO0LiP25c+AE1/HxdSTXc
         z/iQ==
X-Forwarded-Encrypted: i=1; AFNElJ/FvGweGRZU9a9IqqO5Y1456/dUmrIRtiBmHFkXKtvn4pc0SJ+AwaY0cEGt5RsRS23ejFFpypufDBevyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkOFEefcwzXDiSZn0ZJrXX/d2IlrVtZd6C8pkDvzb4mh+4SOMC
	uQEDp1N2Z6DRXVlNnzys2N/eA3x9G3ZDlYzt0J+wu7euuyCa0yPXVn2AxmmgCBbc7z14epZSZYh
	rUhZOHNway0kLsBhEYJJWyPz5ogY00S9XJt9KIGHSuTzM3/2AP5kgAf3+r5P3EpzmBg==
X-Gm-Gg: Acq92OFn2nKWyAW9EXs/ogZ7SokSZMjC1BgvqpqQH+l5y7OgOkcBNsLfilZupQTDlTR
	rOYIqVDf1D86yH8zWx8PZR3lzqMfycJ3C+2N+WsLfEvsayiepQGObwaf9AzRCqyGw0kWEx2fMj3
	xjHEXTmDKMctMoFqU4w89xLrdj5qP7KQTIu9Flvhj0VQdfSb7eGElqFC50Z0e1zHFverDBJZT16
	fKp7lqEs09nUsbMHu4sRYoFrU9JT5Ao4kO+iTQsqr+I3OeeoyM0/OQSUVIU+RaP1ZM+deTrPWQj
	whm3/BMgNByL03nKN5G+d6hykP2d5/AnWZuB2VG4GQ6AdmlQz2rcOThXh3JAKiL4wMPClDyf62G
	dt+vZDLuRr8p615oCg2gz0euHTgPL3912MbY76julpzBduDEnBf0WUU0wys/HNHcyfF8B60rcrE
	3Bml5OOFq90+UQnpH532RvNlIR9dCOOyxyq/c=
X-Received: by 2002:a05:622a:1109:b0:50f:b257:9301 with SMTP id d75a77b69052e-517fe566319mr24249441cf.52.1781255551628;
        Fri, 12 Jun 2026 02:12:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1109:b0:50f:b257:9301 with SMTP id d75a77b69052e-517fe566319mr24248931cf.52.1781255551221;
        Fri, 12 Jun 2026 02:12:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1a7357sm381663e87.42.2026.06.12.02.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:12:29 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:12:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
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
Subject: Re: [PATCH v4 7/8] Bluetooth: qca: Set NVMEM BD address quirks when
 address is invalid
Message-ID: <uybyiffu2czpzhycp6x7w2pptzmhajxlx3ogglshamppo66kqn@izztlisgr2xc>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-7-45712e6b22c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-block-as-nvmem-v4-7-45712e6b22c6@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Gq3g8SwVVXwRKIZo4GTzHzxvDYOPUmGA
X-Proofpoint-GUID: Gq3g8SwVVXwRKIZo4GTzHzxvDYOPUmGA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA4MiBTYWx0ZWRfXzjUzetde2PIU
 ByCMvljzFOjvY314Cn7QDxplYfjX/mYXHNVOhEwtbA2E7j3p7YckcUvZN4/PHcyxIDyRIncZ/Gr
 4SdjjehF2leuPsN8MSF8hkfD1AE+JDY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA4MiBTYWx0ZWRfX5FOvyNx3VnL9
 MOEtICWLFoSeaJx1HbDXz/nQNFtv3oUqn4Pu+mQORKfV8EyuJJbg8d3ilVa+IVY6i+ddKi+r8R4
 Z0+p1BYBFsgHQn4GDqPQP7Qlgjp8Dg9sjwHA7wR/jy5v4fDWqnlNL9C1CChiE/FchVr4hI05xPL
 HS7MW8Sx/H7H9rF4+l9GvR27TYUqz0/NUfSEoDTgK51p50RvxvfeDK8maBj5oLcU0RVL1BI0Toq
 Wk2lFHGGWSqJj7dwDWepHbXCvKnSS4yhi4JwFB/CqSASzLyhhFiuJ96Tw6UZQYioFzyG34N2GUT
 ABg+FZcGhGuPWo8ho9akOO3sJFtNSLJbdkptURrIiVK0+XMCv3iBNX2K8WfiFZfV5VU6jta9GRV
 W/DelRpkCjH/PPefSb3Dg+OXroI+B0z51Ce18yQjp3b2VR4+HYLeKUlQikixmwBqPNZTUxvojNP
 1V1lvU9NY9RbziivumQ==
X-Authority-Analysis: v=2.4 cv=M6p97Sws c=1 sm=1 tr=0 ts=6a2bcd80 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=m9cM9ScjmTDVYK95jDAA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1011 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120082

On Tue, Jun 09, 2026 at 09:52:32AM +0200, Loic Poulain wrote:
> When the controller BD address is invalid (zero or default),
> set the NVMEM quirks to allow retrieving the address from a
> 'local-bd-address' NVMEM cell. The BD address is often stored
> alongside the WiFi MAC address in big-endian format, so also
> set the big-endian quirk.

Okay, this answers my question to the previous patch. We need to support
BE addresses.

> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btqca.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry
