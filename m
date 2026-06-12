Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431BF27A107
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781258895; cv=pass; b=NA/x1/x+5c1CZIvUkwhJF/xuprcsQXwUOSUnJp0ztsx6I3DhwSTbk+1rjsmIzoF8VB6LFAwbIRARpsnZEXXGwKx+xMSQIoNLOyoq0dugOj2/9hV7GxRhkX+Q16g7jdbvo1FvdhYToTLOa7TmIya3lColdAWqBXUG3cFEFBBylPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781258895; c=relaxed/simple;
	bh=cHw3EhfIxeFggCpzm6CPqEcKG4hAZv5HGwcoAKqnwaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ek6NmEKA5NMyJxr2uHvutPO8mMkvu2RKmpOAoOsgik0dK+/N+fRqBACFKkt8/gHqqgo+TZDkXgZYS/ls04ZaBlgGq8C+LNZD8hxBr7A5zxR5FGHgNEIhtYGF6ZY6kyOICYMYKyWpy8gq61zMsHU0E7WENAA6L/IJX3wpTQFy8Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IgFMujEY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cN+e08iF; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IgFMujEY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cN+e08iF"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C3C9AS2534242
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 10:08:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oInph8sZQ8Ma5X0t6VxxpBWehRn7abdgTsEpHVxvEAw=; b=IgFMujEYL7nMZWpd
	KLt4YyRgH50+k1NpU1LggBs55SiDEHrC2/PN+/ZHCO7nPlyoEzT+W2Q6BK8LBbmR
	yCFP6p6SX0zKBq5OLLfmZp1tpnnRXVuRO1slxq2z4FMsarT+TYAMGo2sUFtuDXpA
	drZVZb4R+8gJtgY6prfUwMyHi47ZNvlK15W3OkA7E9sECp+s0r8FBguCM6giwm7b
	cc3j4TnyGUf3YiDyV6hYMrMW5MolB0YP+vKbEQ05H/yq7f3IzUnkHzadp4N788ug
	Z32fgVOfw+kG9QHI1EZIkUCeJWo5e77pNo7NA0LP7ntclwZLFH32bN4HLE8YiNn+
	b5HnOg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er2u42ec4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 10:08:12 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-915ba226a9bso205007385a.2
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 03:08:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781258892; cv=none;
        d=google.com; s=arc-20240605;
        b=hlKE9j5ugfi9Gk3UDHMMm1zTnAGEouut1M9rhxtUqwTkbVOcJZvvQB6kAk1VsjMIPy
         7Je4UeCr7MXybX+Jv+Ib5d1T7ZvHM0uPEI4QVm7X/qL2fPKFJRV/m504RoMUaQ24NzLM
         89SgqCCd+xvu7QIeKN7Y5io1AZokVVfpb4N49mw3S5PiQ780ep9gPZ3lQ2VSPN4N+RJv
         rlO4buMgwdrrKLDH9EHN69tJyR39TJOVylse4/fGuZGbVceEWdx6IAGS1Pv9FM6nzk9o
         wy6GNqSEy7p8C//zAmDsCzI9vTQo29fb6YRNr2Hu2MutJ3frOu/+XFZJ2YXjX/YOr53l
         M//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oInph8sZQ8Ma5X0t6VxxpBWehRn7abdgTsEpHVxvEAw=;
        fh=auyVphrrLzFeURO6MPqb46/yO6vEN76TwcDt7+GADqQ=;
        b=WGGf8VYGWcRO0jaXqCLQWONMTVUmaOGxVZoPNYifa+th59rtJf2M3/WcyJB4+XlNHY
         QWE9ZEK7p1JXJecZ/zkJxjlAVepJOTCzZWYmvse9LhW5jG2gyvcaDI6pxaEqUjg7MtK8
         L3WWGhQkSmZ58lq34WbPi0jYhvjd01gtTXlmkLYDyNtfODBQmhufa7jqnH9XXUpYPwZv
         8N0MIrII2stOWt9uWG/YsunwgB+lTQP8VIU/hDyObH8wP4cT0KgB5FltgFVBtL18m/IW
         n4QAPVu24osZC3Lri/jrNhTmMxyFNIRkmJBZY7aoirs0T/y6vvyDTzJ32clqY4+uu070
         0/Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781258892; x=1781863692; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oInph8sZQ8Ma5X0t6VxxpBWehRn7abdgTsEpHVxvEAw=;
        b=cN+e08iFOjssDcMEMRiNZ4OP3pZLd3ZO8Ja1gWe68m3kbBIyThJTWX9hYHJAaZRNJZ
         9EOuopkE4z7rct6+QAsnmWHHpT6sc8XOOuwpVT0popT3ge8mzAD8/b2b7bWGIXcK0HFp
         e0hfyKPwJjXqV/0ITZ7dZM+olqPbWqFEMjcg8wOy883s/NrWohq/veq9D2G/JCIcwAOO
         6S3ddy8jdkboNC3+XjEeBaSuXDe54qxlJcblF4R+v4XBCgZLVg+dvNU1f0miIdAkc10W
         OkIoZU8L4zI768ykIugtP3OF51iC/FRZFVDJ+tou0FdmS0b8IjzIvEd9qFCpw4aW7eP/
         zXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781258892; x=1781863692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oInph8sZQ8Ma5X0t6VxxpBWehRn7abdgTsEpHVxvEAw=;
        b=RtRT2XZn4KwZjW1flQZ2HYdeZkX9yL/saYYN3s5xYbGiDIHpfEZJhUw/Jotzb1Lm4y
         BoEpBg01H5JLQmKdcSW5I4UYxE7xRd/0sfeLuGvTluaQMRyJC6vgd0QzW+k3TzWB5WQZ
         mVn7+XkKUMCw3qI6CsiLsKPa6VyZhXmZmEktC/Zr/NPPk5RRDbXM8Ap5Jkqh03hL7+WR
         wUiH+CSInAZazAgmysisoOk0PKeJJhaKh1wPM1oNZjmHPEBSNJ7P4wIGpYjSOQSYqKli
         kiu0R+yiOtmaplDhn4lbmGWp7k3Yt1wjbg3PXPvaDwtxglbk7bEB0x5QZwHrJTRiRmzE
         9VJw==
X-Forwarded-Encrypted: i=1; AFNElJ+jkShJpopzV4G7qW2ozgPwc6Mb2XttjuEcvalg2Mk64Hrfndmloruxr5LOlwh/sMi7hrIbNnYOjsJGxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAPGrl1yRQFi7Y/gHF4AOr8WoOq88xh236/LtOJjPeZCZWVi9k
	ycTpioL2aVn3FaBDsM4u5U3pA/RHSWRHp9wg6VsZ5mq62E9b9OThk5bE+UggWv4MIrJTjggnKbV
	UuyT97hPD7fcD9/nZ8hv0MVJ/UYnIZ4pq8hEdbfdS6F4yZlxIWmipRAPWPdYpQfKoxU4rOBM1U8
	8cSnkYzwlvZ5tk1UnNePqWd5jQGtZsUPU7yBZCltjy
X-Gm-Gg: Acq92OGLlgJlWbgkhHZS7horYXv5qKcvggMbaQ5wL3uN3MvT3Kc6nYdKqhLkfbmCEaK
	HKl+JETiZQvKaoCSlDoN7zz2AAl35SpgTeoKBntv4MnriGGPN2IErVeWRoYXOMPJ1VdwwchY87X
	bqVzDrGKYFW6P8l6cCBXkaiDNDscfI3FfHja5VLbPBKW9U6PW3x1oCpaIIZFxzspcmId1tCZ5pI
	UKLlZs/gNzGGmDUwzbYx8S1Cn1/g35tPZ1UI2tGx2XSPfSMcd0QRCwXN/FWffeV8vIzBwu6r2sr
	olVRDAVBvmcdg3Kd1BOG
X-Received: by 2002:a05:622a:8d12:b0:517:9f03:a659 with SMTP id d75a77b69052e-517fdf182c1mr24882231cf.12.1781258892385;
        Fri, 12 Jun 2026 03:08:12 -0700 (PDT)
X-Received: by 2002:a05:620a:2948:b0:915:bac0:fc2d with SMTP id
 af79cd13be357-9161bc13cc7mr245131985a.7.1781258430139; Fri, 12 Jun 2026
 03:00:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-6-45712e6b22c6@oss.qualcomm.com> <sy2ofvdbcxspxtmfdavjvdz7oes5ieuep4znf4ayknmuwhrlgk@7lp3bkegaeif>
In-Reply-To: <sy2ofvdbcxspxtmfdavjvdz7oes5ieuep4znf4ayknmuwhrlgk@7lp3bkegaeif>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 12:00:19 +0200
X-Gm-Features: AVVi8CcCaLmOad_JBtnFjekoAUWHpnzgbbLT7l_V3SVx5j2zNp67A6Sx6we9iz0
Message-ID: <CAFEp6-3Z92KNVv6hbG_zrzan4+cP-TCkoc693orKwvQyvP_YHA@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
X-Proofpoint-GUID: jGuKfeC9dpUq0VIZIpWt7dRPMmr5Ud9X
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfX8jbnx5qXBzyj
 YGQ4kRK/WBAFllub//F7EZh+OTZ8N9AcIkeZtRfKASLk6MsJU8+HKn794faB6sw2UXrmqh208fL
 Uk90wjBy/CgSvQGUZD3Qd4R+NP8uu7Y=
X-Proofpoint-ORIG-GUID: jGuKfeC9dpUq0VIZIpWt7dRPMmr5Ud9X
X-Authority-Analysis: v=2.4 cv=N94Z0W9B c=1 sm=1 tr=0 ts=6a2bda8d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=dtGr58D_ptlPQ1E9saEA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA5MSBTYWx0ZWRfX6pEG7IFyXj8z
 OQvgemDhfty44tSUtk1VJ6mA8+0dr43NkR2tAXuiIQAZt6v2kF0C5vN+LbwbLj+Z/MLRkZE8fLc
 GxEZwXax18rNcQX8ex8TaZNmeyyNjgDuobB/YH24/HPwqIkEjYGVWnL05VrW2/pGFAYRHkUIWnz
 1N+PeT/yBOgwCxfhRrRgDZqGExaLh73Vu5XSmDbPS8aV07r42EudhEr6yVQ/GZp52jfZcjmAImc
 FEIcY1oj8lGsSXmo3aqr4VOYhPD1uY2dlygj8gVgX5M+l7dcNIgkdtYO6qn9j6zqYJfoqHj2SfI
 mvxZtwUiX3aUHTrsKg1/SJ97uMH/AbMU3L0HWy+oe8fyb3fEnDKizyrbeQUE4h3XjfKF3Hpg++U
 2pGsMzu9adpPVtvDSyUrDV7bZfvcl/zZg6JgSXqgESCQA7fevXpmexU9LPVAqcA4vWbLUIjlymx
 RiaKWvNTYzj+5C4uenw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120091

On Fri, Jun 12, 2026 at 11:11=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Jun 09, 2026 at 09:52:31AM +0200, Loic Poulain wrote:
> > Some devices store the Bluetooth BD address in non-volatile
> > memory, which can be accessed through the NVMEM framework.
> > Similar to Ethernet or WiFi MAC addresses, add support for
> > reading the BD address from a 'local-bd-address' NVMEM cell.
> >
> > As with the device-tree provided BD address, add a quirk to
> > indicate whether a device or platform should attempt to read
> > the address from NVMEM when no valid in-chip address is present.
> > Also add a quirk to indicate if the address is stored in
> > big-endian byte order.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  include/net/bluetooth/hci.h | 18 ++++++++++++++++++
> >  net/bluetooth/hci_sync.c    | 39 +++++++++++++++++++++++++++++++++++++=
+-
> >  2 files changed, 56 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 572b1c620c5d653a1fe10b26c1b0ba33e8f4968f..7686466d1109253b0d75ede=
b5f6a99fb98ce4cc6 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -164,6 +164,24 @@ enum {
> >        */
> >       HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
> >
> > +     /* When this quirk is set, the public Bluetooth address
> > +      * initially reported by HCI Read BD Address command
> > +      * is considered invalid. The public BD Address can be
> > +      * retrieved via a 'local-bd-address' NVMEM cell.
>
> Why do we need a quirk here? Can't we always assume that if there is an
> NVMEM cell, it contains a correct address, even if HCI command returned
> a seemingly-sensible one?

The pattern follows HCI_QUIRK_USE_BDADDR_PROPERTY, the quirk indicates
that the address returned by the HCI Read BD Address command is
invalid and should be overridden using a fwnode property. Without this
quirk, even a valid fwnode-provided address is ignored. So here this
is primarily done to align with that established behavior, although
whether that design choice is ideal is a good question.

This also raises the question of why an explicit HCI_QUIRK_USE_* flag
is required to allow reading from NVMEM when the controller-provided
address is known to be invalid, rather than attempting to use any
available backend (fwnode-prop or NVMEM). but this remains
consistent with the behavior established by the fwnode-based quirk.

So, I think these aspects could be revisited in a Bluetooth follow-up
series if there is interest in reworking the overall addr fallback
design.

Regards,
Loic



>
> > +      *
> > +      * This quirk can be set before hci_register_dev is called or
> > +      * during the hdev->setup vendor callback.
> > +      */
> > +     HCI_QUIRK_USE_BDADDR_NVMEM,
> > +
> > +     /* When this quirk is set, the Bluetooth Device Address provided =
by
> > +      * the 'local-bd-address' NVMEM is stored in big-endian order.
> > +      *
> > +      * This quirk can be set before hci_register_dev is called or
> > +      * during the hdev->setup vendor callback.
> > +      */
> > +     HCI_QUIRK_BDADDR_NVMEM_BE,
>
> Also, is this necessary? Are the devices which store the address in the
> wrong format in the NVMEM?
>
> > +
> >       /* When this quirk is set, the duplicate filtering during
> >        * scanning is based on Bluetooth devices addresses. To allow
> >        * RSSI based updates, restart scanning if needed.
>
> --
> With best wishes
> Dmitry
