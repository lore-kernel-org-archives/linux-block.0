Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368DF425CF2
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902453; cv=none; b=pugJFf2LOyUChVLaN+Rde1CQlgyUWGZn9giHzKOwvsgH4I7hgmr91TJiuGykIBsuOKtNuFYMZbyh6MVx7rWF4I3AKb1cSYDGZrcCKj7OSxMugKFBYIElS3xD3D1Rxig/BoNASIPZ+3+6ZIGlRnkFXT8O2X4v4FqKp6cWQkJFRgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902453; c=relaxed/simple;
	bh=HOn0CaCePfNgAAG9q0s3jJIiPvvFTH5KrOgQqhOkSqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d02GlFfgCDR8pPlqAN3C7GAuEr2YpwYTNLaqJUsTNVSyAHrImyV5N7Eo4mX31Ay022lsIlU/BTZfDNGfVoc2pZebH6yZAW9p2eiCHlH2rnk+gL9AuPL899KPyvkV+h0hmYbI2Lxg9SZCwnTVqDuZtd4F3DgknELZad85UXx+vHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nsg+7PGS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GyL4FosQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nsg+7PGS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GyL4FosQ"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661A8wQ6644881
	for <linux-block@vger.kernel.org>; Wed, 1 Jul 2026 10:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m/6nkzPv+WrZ0PcEEcEQEu660EWyt8TZ3LWKgMKw0Bc=; b=nsg+7PGSN9LMaaHb
	vP7qwVAt0LvmfNhpwCNGGrHCO3fVvstLF7mT3Di+sWTZork4SslT9bHt26h9Mi92
	IaYhXfMfqJWclBMkqxErZVX/sXvQ1vvohbsCRngPa0TuPp5VB+JOzvndmxfZnSkJ
	ieUI1piKVL7WKls80+Aju0hIxcycUnroOorlyO/9M8hEMVrMg9Pyrww7Lxd0qWPN
	ZqzULmqFpA7/z9kemgHxgGkpVUbrJUSJzUqeFMWkqUtdHdrWDrwwRvgol4kD4Mps
	FMcvtl/2AdFVVCEzWSJDZwHSG2iEjIVD+UGCQ4/eUewg5ouFQT6h713Po8G7SAkB
	+O7xfA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4hbd4bp1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 10:40:49 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c267931ebso1500391cf.2
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 03:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782902448; x=1783507248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m/6nkzPv+WrZ0PcEEcEQEu660EWyt8TZ3LWKgMKw0Bc=;
        b=GyL4FosQWSFeMIENYzn5k8JSIEfI2ZrGYNpC1fKjjmS6BTMlrw4rxicSfTG4qjXnIS
         9+CZ3gwlOkhoeRZcwnQ0b6/iEy4VFcwtGAfWMcCC6SddQdXl7UZc862VOOwZn/5Y34Mw
         FA59JJ+0GbiFvCry5GBqdGRKHBNyXTjoCEPdFTN7jrt7Tp1GF/CsiBad/vFQWNmP2Q8U
         +6JzkSpZsT3BOUv9RqiZzOYkPZcdR0S+7Odk37PqsVEGPqI1rCzZfz6VT5Don0LtgZen
         rSOTEplzWuWhvChXWd4lm9B0fx0lROoKOZLkV5qzDxDiADLi6Fy0zCPvHzltp3aRKxnt
         rscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782902448; x=1783507248;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m/6nkzPv+WrZ0PcEEcEQEu660EWyt8TZ3LWKgMKw0Bc=;
        b=O5l2nOsM1rPtvNxJdnkOJSgNlI5CHD0M9oxRBBsJ1pBbDgmiP3RrNFxgMdHFmWhIln
         PM4jIqNP+09Q5ODrBF1Siy741VuzBJpanKGxQjxfIO8PgB0C0qWBMsL6MOAhl4LNdEMf
         vdCE6vkSI2lWQGJNzDbu6dwsB7VLz2Ev0EI6pAHjsPr57rO7ok1tQ/PUZ3CyZy/8m/nt
         6AWcu9Z1ZTDg0msxKYHiZnkNeuYBcdNUkRSKtgwgfhia5B9XL81opjH8m1SLj0SyrBEX
         Ka9xEporuyspQ7bBtu9KobrEGcUgj/RTsHZMp038113cyjhrv+9mEf8Z1lyQbaM1rFtu
         wV3w==
X-Gm-Message-State: AOJu0Ywrw2/c1iWrtrYHnCLUevXrGaW+6WJCFMSOF4a8eePrIlEIefAk
	sJWNwQ0JrXgdGTZmn4+1RRgZV8W7ghHWJRZ1lznq3PNDUO9lWloLrfrcjM7KQAwE24jz7HNS77x
	EYv5Kmkctv7YhBMlrtWJgScUKgfuM0Qn8kUjV5cKYek0VdhDNmKfKD/muP04rR9nIFg==
X-Gm-Gg: AfdE7cn9p5QPsrH7+GWBrvcnavQSS4IXcN+drYddYMVh8oO9LUZstIP18h0vRokGcm7
	3PRuv5ugyI/OIb4P0/MsLKTn3RMH3aSXZ6dKxwT7Hf77AGu7g78IOAFrh/NADB8TIjE589CFRpN
	l2gdE52hyh6R5v6cisZKW0cRtLkhjwU8ZjLTeYniKVxmZTzhUohrrPIcjWqFAY0ILiPah8NzD94
	QGG2yHhV+KpGfw0milxJB5wo7fW93fKxZt3hU7m2L1TpoVgbJ5oDNGp9Cu6SIx81Bgr+3PBO9fw
	pMOQz74A3JmClcW/N6Uvak966uPpYhSKJS5k1gDkR7yje0shmRD7ou4z+cDJPxh91CNKbDE8+Bb
	F1Exuilm7YZX/tmmIkfFbhMKSpiVAbw7Msys=
X-Received: by 2002:ac8:590d:0:b0:51a:8c9b:6492 with SMTP id d75a77b69052e-51c26b25d63mr7031841cf.9.1782902448035;
        Wed, 01 Jul 2026 03:40:48 -0700 (PDT)
X-Received: by 2002:ac8:590d:0:b0:51a:8c9b:6492 with SMTP id d75a77b69052e-51c26b25d63mr7031251cf.9.1782902447419;
        Wed, 01 Jul 2026 03:40:47 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1296b1f9cesm165809466b.16.2026.07.01.03.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 03:40:45 -0700 (PDT)
Message-ID: <175f7835-df18-4bc6-8267-ceef35696af8@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 12:40:42 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] firmware: qcom: scm: Add support for setting
 Bluetooth power modes
To: george.moussalem@outlook.com, Jens Axboe <axboe@kernel.dk>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Saravana Kannan
 <saravanak@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20260629-ipq5018-bluetooth-v2-0-02770f03b6bb@outlook.com>
 <20260629-ipq5018-bluetooth-v2-3-02770f03b6bb@outlook.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260629-ipq5018-bluetooth-v2-3-02770f03b6bb@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfXz4Z+3fXUQj1u
 m0fTEMVS+lMRS+8Mabk/BKNoTmPyTzUGUQq8qcBtRGBpvsYW/2XmYTu8QTkMzmRzsnSlzfbZgpC
 U36Q7E5yzUJZS32RYATyKFg3vi7eJ9U=
X-Authority-Analysis: v=2.4 cv=MpJiLWae c=1 sm=1 tr=0 ts=6a44eeb1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=UqCG9HQmAAAA:8 a=506_Lbxh6H-Y4vAdgPkA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: oDOH-Mgnbjvy6tDme1DA4bqrMmx1nDyd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfXwUyp7aQjc3P4
 lhh8FEmiansjthqW6Cii+ucvwJKFXb/dfkKF/eGlrZ/sSWEdwFLEw7sPQucyO6jNi6PLBcnJyEd
 G+eoOm/viiaQZdkVQfP+bdPv1FOO2wiqnBQz8Mvz3GTjTzd2ltVNypMU+tf4gAEAJVRRGT5LILV
 JzXh5hGu0Gu1MSmitEN4GTr55RxYxdywrW6XJShaBkAAG+3X6r3lua7Q9Zvps2lNwLS1ifRaqVl
 NlfbSCl1YZe7iQCt3lw+nfGzuKmflSseewzlsSOJ3fmyJ40ynBu8XlGiESf7HB8gSe++HqOZijk
 CLbtD9C+G2f3RnsC63gVvbjOUQAY7o0kJxJLpn7k6/RZ4IzR5C16H86UwUNBANhtBd3zpRfOHvj
 4gcLKGPA5wpMp+8JFIFZujEqFIc+FSL+1L7J9EwiO5xIjZLZ7esUZoj8zA1KUfohyiK21PxynL/
 Ep5awnB+9hq60ektTEg==
X-Proofpoint-GUID: oDOH-Mgnbjvy6tDme1DA4bqrMmx1nDyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010111

On 6/29/26 3:01 PM, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> The Bluetooth subsystem (BTSS) on the IPQ5018 SoC supports setting power
> modes which are required to be configured through a Secure Channel
> Manager (SCM) call to TrustZone. However, not all Trusted Execution
> Environment (QSEE) images support this call, so first check if the call
> is available.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---

I'm amazed changing this setting is a secure operation

[...]

> +/**
> + * qcom_scm_pas_set_bluetooth_power_mode() - Configure power optimization mode
> + *					     for the Bluetooth subsystem (BTSS)
> + * @pas_id:	peripheral authentication service id
> + * @val:	0x0 for normal operation, 0x4 for ECO mode

If there's just two values, maybe we should make this take a `bool eco_mode`?

> + *
> + * Return: 0 on success, negative errno on failure.
> + * Returns -EOPNOTSUPP if the firmware configuration call is unavailable.
> + */
> +int qcom_scm_pas_set_bluetooth_power_mode(u32 pas_id, u32 val)
> +{
> +	if (!__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_PIL,
> +					  QCOM_SCM_PIL_PAS_BT_PWR_MODE))
> +		return -EOPNOTSUPP;
> +
> +	return __qcom_scm_pas_set_bluetooth_power_mode(pas_id, val);

Let's just inline the whole definition here - it's single-use anyway

Konrad
