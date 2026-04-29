Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745038D6B1
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777455053; cv=none; b=rPN0rmODlyUFHd9l6RYH+GbnoVdEFLiPZAg0KVkEvpHXGuATQ4SERQcL/BnVHCjLaxhYjdEHDRNBN7XPjxhdVpAYc9la9i8tykvXE24fGaXNUffXLWiAAoCe7QlChg9OgIWz5EddqLpsfdkqmu2FsIZcc3qAd/RmXMqjsgm45Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777455053; c=relaxed/simple;
	bh=wC9jrPQBmpCZbW2mnXn6p/4PAelbyjfeh2Yka1RlPpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNYUBR5ClchULSp3sdLNCYOn5KsJOHMn5uQ1enj0on5Npw9zwu8PhoqjZMjM0O3ujIXgc0kw5OWGWRxBHZ1J+DDOyZIR6nfx2w6YcZ7Hw6M/22IHuh09uIbGMZ+jWpmYEGWyXIJAKbby9y3obfY0czYnnQnqozIpB3W+z2UAOYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W9VWA6S3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V4Wf0eoQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W9VWA6S3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V4Wf0eoQ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8ppuX2094110
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 09:30:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gTbNCeRSUqu4zDmkAqRY6ARTuww7wMu5rx1tnXDAf20=; b=W9VWA6S3iqRyvA7f
	IQsLcQMaUAo6MrX9KGt2ltCHppKvhII5yVDzVpDzHK2kuP0AaZslI8qh0v3tmdex
	IHtPapbJQePeiqdCjlTAhAHyEtwfT+4h6Zf8mY9rL59hDCZTT0mB7QUXD6jK/LEX
	YPlvGlHt/g2oCFgtmk6x9RRZqHkzt+idAJZfRqmiEEqUOF9drtciI0/PpY5w+sH2
	wGojjqWxaAsCUJXiE3JP1jCqQkACKt3T6EDFIM1KBOrrB9G53FbimPaNVhoSbKrh
	h3vOEeWBL3aHeQUyDP5coXfAtAd1BplIgxkVknbEbhHroHuyOjpgWPgJcKcqpcyx
	cjXoQg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dudh3rksk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 09:30:49 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-56f71af9dddso903391e0c.1
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 02:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777455048; x=1778059848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gTbNCeRSUqu4zDmkAqRY6ARTuww7wMu5rx1tnXDAf20=;
        b=V4Wf0eoQAMEva3tDdlrX9/Zl9AZ1bYSngQg/oYmbri4DFawPnSwKNq3piwSd9kYUpE
         wJMOp9YezrpOeC69LdgSX/znAt2WaolwaiJKh1MceLb025yYmwEvSmSta/Jcq35nK+WP
         wBjGkelpYxRvdJkqEWpA+vLyGKMxCRc06xoyTg6Erw8FT1e+87RjsjHtDXshS6VNG2Kt
         Vfw6sTmLtrIWtP/Jrl+IbgfcTIJU+GcNoDXYWEx8Bj3C7x33mRyb6OzLQHgUhwZUN3ui
         dNa9CIjrWBJ9N0vDukQG8M/ieGF6fxPlbBSG3TD1Wc1A6l9DWi40S3VcUuWjfYoECdMb
         W28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777455048; x=1778059848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTbNCeRSUqu4zDmkAqRY6ARTuww7wMu5rx1tnXDAf20=;
        b=U0Z7ZLrJBaDAssJhNVPfcx9D1/VbPgL1oN6uCvxoC/RgHhXEQNtKhHcD7hH8J3qwfO
         qi8hMlwiSJzcCom2cn9HBmNcUO26slbstOS6ID+u8R+EIZ31TNh9J0WzN/QF445bh8M9
         diNv+OiRrYZ5W864L7dnjs+AvmUbzQYqeUcgefAzF8ub0zv8wx7DIU4ipjZ0qxsZcUJ8
         2orn+14qHzrX0IOAgRJW2itvuDCFiP6xnzphuOGFG2eKh0vEmoPgi9WUc8fomx8YyItw
         tyYUWkzADQKTHAXtAG0WWyrITgueSpr+u3SPancHQ3GX1rIM68h99h/hRJzY3U3zY9L+
         LLfA==
X-Forwarded-Encrypted: i=1; AFNElJ9REaCDyVCY5/ZJ4RKToubYWv6CiX+OSF/EV8UGnh3KbCd6I5kaT4YHd/aGtO49AkHerR73HJ6w7/cUBw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEW3jtOlNm4WsO3OX6l+VjAD4jjoYhqI2Ix0fhWNL3qotDRiFt
	0R63PGk+eHcSmcp5s8TuRWq39tNHlOMghyE2bUu8hgWeRuLNaJGqk2KL5fKwjrptPgCNOg7gjBp
	l2EvCvzaD3FZ0kWSn/pfOSBiR02SZ5WDJT6MLR2/tK5SZhwNlYG2MX7kRZRvW3S6L/Q==
X-Gm-Gg: AeBDievhBFdjxA0KharT4EX/Db08r78oKt88OjCCe4w39kJmO+uKK4oFoIXIvEC8EjF
	VUxzk2YppMNnl9oIRWlzMCrSG+Vl8vnipjXDht/BaTAoD8sMn45cMBzLDGmZnyh6bzoHSj0PXiS
	DBT6bO05n1LZD+Us2ogAau9mxWn/qBsEvgm6JgsA9MGaZbxqxQJp5J2kwmSD0H773QtcKU9Z0Hr
	tAMiiCLi1fNYuzT/m/Tkx97PshPOtd8Nh6xzgowsdzMkePjsz4hWvMeEoCrP1q3BXIZ+zEMKpa2
	gyl+FfZ8f9FpfDwmMD6keimPmruaHQv2gUC/D/S63ipgEHZ90WVBFNGUc48c7LvC9s1PiP44lME
	gJhh1MBoDhHMHUVSTH6+eWKdsAbNs6WxWeE7gbIX7qNwdgCzwFrdWfzUAERYoE8FLxXPVaLyO+a
	4JSgcEbfwHfz6rkA==
X-Received: by 2002:ac5:c894:0:b0:56f:6edd:77ae with SMTP id 71dfb90a1353d-573a293d531mr1234260e0c.0.1777455048468;
        Wed, 29 Apr 2026 02:30:48 -0700 (PDT)
X-Received: by 2002:ac5:c894:0:b0:56f:6edd:77ae with SMTP id 71dfb90a1353d-573a293d531mr1234254e0c.0.1777455048034;
        Wed, 29 Apr 2026 02:30:48 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb985e1b108sm65753866b.50.2026.04.29.02.30.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 02:30:47 -0700 (PDT)
Message-ID: <aadfa862-a99e-4214-b19f-6854672dc8d4@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 11:30:43 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] arm64: dts: qcom: arduino-imola: Get WiFi MAC from
 NVMEM
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
 <20260428-block-as-nvmem-v1-5-6ad23e75190a@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-5-6ad23e75190a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3HaevAIEZMd9Zjf-LcybJodPMY-rSO3b
X-Authority-Analysis: v=2.4 cv=A4dc+aWG c=1 sm=1 tr=0 ts=69f1cfc9 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=vtxEUVkT7waMBiOsAPUA:9 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: 3HaevAIEZMd9Zjf-LcybJodPMY-rSO3b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA5NSBTYWx0ZWRfXwuPANqwXqINi
 ZTR5RlIIrUZSoAvY+R+iY3Vf2e68EXqdycPFXtnbDl3X6cZ/VBmVz7fXROjhYn7BPTGehUGYAVr
 4hb22qLsqkP0Qhr0ZKNbJyvhKCAO6cF5GLbYTEkNO+TZqtUlH9VXto9/rpwwAzZMXoVHToPvg+G
 Zd3JZYtlKovRWBmHO3056N55cacXtUxwHlHRYZMwqOSbaYAEGFcwu2YRpFk9l9FwgQMYuMt+zT/
 /Ynr5unTh4W/mSf3j5jGrsBhgH6/Ik4c8Cr7mVEo1SBaLYR62LwMIvOsspZB3Rzu/TmD3ufGpfI
 bVqbzDdPRlNTqXRPN/cqAMraMWXPOByddmv39AqJLXy0xLz4TzKekXXvYKo4P5eJbJ8YJo/mRme
 +f0T7zAmibgSROuCdv/XM38mYAy2r7ZvuwcxCQlgHGWzRtfPOCe1MhhNI7cQM4DNBZT44ntDofN
 EPxtOiBlNEA9e/UGi0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290095

On 4/28/26 4:23 PM, Loic Poulain wrote:
> On Arduino Uno-Q, the WiFi MAC address is stored in the eMMC
> boot1 partition. Point to the appropriate NVMEM cell to
> retrieve it.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
