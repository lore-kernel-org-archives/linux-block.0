Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BFF2E64D
	for <linux-block@vger.kernel.org>; Thu,  8 Oct 2026 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418137; cv=none; b=MHMEHoAgO/OF8VqdquM1d3FrV2VQUsRiSYl7qYbgRbgGERR28vPZhFHY+fgw66SmaNsc1eqPJqwMzmV0y77m16O1QyYLgtgrEB4N+/Ur8WaU9m0F5RQFsbwiUI4NRCAr6r0GIEyPWLW/EfQxHErQ+6yODwfzbGdf6ar/5lBwqSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418137; c=relaxed/simple;
	bh=x2KkVoMQI1NXabI2h0N7BvI/fSRL3yWbK0MtUn7sBiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjML2US99eo+y0H3y+BHRrm8sojlPOJ8Ohk7AHxgaQ+PP+HGb1gkoFtE97VWXeXgkjKT2vEpj/wyFeyekYTWfxvWY8UZpgxWqwe3zYKLrHIEP351yIXTqaorCGbw0zUadvOx64dyv/dzsBu80G2ayG+utEPTHy/AUMPwcZ2cJG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BiKb4yPm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aZlgjjt8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BiKb4yPm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aZlgjjt8"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697LvoSe1470261
	for <linux-block@vger.kernel.org>; Thu, 8 Oct 2026 00:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wmy83IDApREsOlkuwuGw8eMok3UVFkoyyp0K97hFwN0=; b=BiKb4yPmNEbSAUIb
	14/I5FvUmndSoBTWkx57rSDWqaiDeLehQ5sxGe1Sn98VlfxJT91h0QuQaO4On1fb
	MH6TJZXimpc3VSgdRISOrgU+mBS9Jb7TRbAEDnV4xgWCUgpHzDwsT05EcGedJ+SG
	hkUyqBPEltDltkRKzjhU54UMgC6Gc9jVkho8TxSqVVaTegarMci1ett/Xsi5ssba
	R17vmJ76UwRl6ryUN0DdPfaG12Cxs4bShJpTkqGsoofitle/EKMn5iJFB0XS7ZbD
	FhhmJbb8H8V2AlCMDyBx06SkNwRImIAdiZig1f2kskhpe+EIpbIDQP7AdvgC1SI4
	zF71uQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe40d5j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 00:08:53 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139b62317d0so16329960c88.0
        for <linux-block@vger.kernel.org>; Wed, 07 Oct 2026 17:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791418132; x=1792022932; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wmy83IDApREsOlkuwuGw8eMok3UVFkoyyp0K97hFwN0=;
        b=aZlgjjt8dRdLa14ang7d5wSHVO3Nv5zHX63nzRCgun8VoZoDwn+foFyT+bsg2yuq3y
         77BzWB+Sb4DCsoI/Renajlte6Z8i6iKSNKeQYSxcTVJEycb9WrFmhJk4NMwwLpr4fbkT
         xyCynggGnIgOgmsCUjV+aLTbpRMweCQ/uxQRvnkGXFo5BLq+t3WOK4Tzd0HTZGfd1DCI
         dfMc/Q/D9HAFJsqphrGHi3TSiF8ax6T1hHYqJTsf8oVwNggQRY66IBvRi+hpkQBhLAaX
         2MwqunqIM1NxWIp7SNu1BGfwe2tQKr5qD0baOZkFdNf3CsNgJR5sXAPTYioZ4NPYUTAr
         sBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791418132; x=1792022932;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wmy83IDApREsOlkuwuGw8eMok3UVFkoyyp0K97hFwN0=;
        b=IEtbRWgxQ3oiEHR8Xkgco7Pw4aF1d7+jGHN0TdIE2935cgmHCgU/NIueZrJytLOfTI
         hHPYO2T+7/R+juD5HVWrDygsroDB5dRGxciiNXCHelguYW9Bk33geWM+yXWdynSOpL92
         B/IFYYbZYrYqHbjJQq58Cw905Lpdm3LN+D8/IoprO6/R7YE3vF3okCrhvUmli4dDKSAB
         /aP07StT3BCF+CuReal/Ys+5TmwcggXDMcbBqly9YKZ7Rtb5QKFzpH8dNYtmZSp0FzQ6
         1DnReYGZVosndRkvp+oi1GeOhNNPI4/3bCQHjJoXFr6yV4z/jvIdWMxsrHRxXtsxOm3H
         eeKQ==
X-Forwarded-Encrypted: i=1; AKwUvBy9Xh0vtbgsufu+xnLRmZ+vPX4Jk5M9PSx6Iqbs2sEd4Jy2FIMF7uAcYDnmdKQD8V5M/ekzf8hjzrtAHw==@vger.kernel.org
X-Gm-Message-State: AFuF++nQFepgMewjhJvq0tD2kDt0TGi6Y9EJcNldJu9c7oiSE3b1SKP/
	9AYee2LvvgqVsG88Xj3reu0E8ZDcKphj5OYRqWyh0zLBPOq/FLMi5Xjxo/epbUYfHpqpKDyVPVy
	WnzafGCAactkR1oxU0KFGMgVkAfmwwlQyF+K/H5ihbx6INksVDFy3ogm7L82JHF/fdw==
X-Gm-Gg: AYBFou3tl8ewcA9Rb2cITLyCozVOqmo0d534Mo1CXUgwblXn6Sr9GOdhKIhAojyZiLS
	08MwiWnBUXsLA2UGOsKcffMR7YJ+ndPvEDSG/LpZMZGGCQOgc8AyTVSoW9WwK70NC6b7ubWqVZI
	+zFYC20xvDNQqzpGp6ZYK6Lxmx3JZaF/ejVoecpOve2y+KPlaPy1xCvulAoTNowIV3OcyS37LQF
	2GI/S3tHJUGPupLJRX6Pr4d7R+cF8zCbhbFosVpizW53TTsvpES8JIKSXqGFIu0QWcDel9dcYkW
	Jb+xC4fCKjM+etoo6JYHGL5xUbOILAuIqe3Wz4vhlnU3mEnxKNd3+KYqn2zdC+x9GjGuyCpPUmh
	nQyhjbZERKfo8EQcNCo8p5gysC4wbZcLpxDc4oVJZurJVu7dMM+eSocG5r1uGPYk=
X-Received: by 2002:a05:701b:241a:b0:151:ceb3:e105 with SMTP id a92af1059eb24-162047a17dcmr4490635c88.11.1791418132435;
        Wed, 07 Oct 2026 17:08:52 -0700 (PDT)
X-Received: by 2002:a05:701b:241a:b0:151:ceb3:e105 with SMTP id a92af1059eb24-162047a17dcmr4490583c88.11.1791418131519;
        Wed, 07 Oct 2026 17:08:51 -0700 (PDT)
Received: from [10.71.184.34] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16166216f39sm11910314c88.6.2026.10.07.17.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 17:08:51 -0700 (PDT)
Message-ID: <46903bb4-67ee-49a4-bf53-e7ba2c34256d@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 17:08:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] soc: qcom: qpace: Add Qualcomm Page Compression
 Engine driver
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <georgi.djakov@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
        rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        djakov@kernel.org
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-3-georgi.djakov@oss.qualcomm.com>
 <20261001-hopping-belligerent-spider-876e7b@quoll>
 <fed665c5-3062-462b-928d-ab60976ce839@oss.qualcomm.com>
 <b12214fc-2e06-4e52-8bda-6c6f9a76bd7a@kernel.org>
Content-Language: en-US
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <b12214fc-2e06-4e52-8bda-6c6f9a76bd7a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5A-Rc5BD_YP3A2N9Ath1Tla46W97g3S4
X-Authority-Analysis: v=2.4 cv=AbwkjHXG c=1 sm=1 tr=0 ts=6ac6df15 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=8u56npouWohDfDDlGUsA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMCBTYWx0ZWRfX+HaVL2O10/8V
 TgCa/KT6WHa/TsuiyhvwEJxt4m4XoOT2FYAHepeFKXyyU9fu5cZM4hURPFeRYRkpTWL0M7qUE+m
 3KGqcvLYw8sNyRGFPJ5MEYFoaYaa/xk=
X-Proofpoint-ORIG-GUID: 5A-Rc5BD_YP3A2N9Ath1Tla46W97g3S4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMCBTYWx0ZWRfX9BJP3se7xD+N
 ISXznPmcL0B8qWMdhyuiwZBOlTKFPQ0Hs2Gs3eD5FSIFaou2TQOZzhAHb6sAEy4zLVqYYYmmhxM
 tl46epL0zPZVpDZDMXEMBhPmpPln8rcaz5vZ22/zQODnuCHADINI1SrzQg99FChZHuXu8UsJrlK
 maJBT02RWP3ZcY5FbC3dzAbdfhSbUAVISZcKrioICpuVbVBvYN7c8rDN8lu8xGV/Qd5prJY59/x
 BjYWapn9+PkjF81yDMY88P1ccgQXa8B7Gb7yMsCmumru1JH/K5Vmk5CVkqQ3NB5q92+QF5MwJkW
 vcCgShp4DmhGDqNn91kXIR3q9l64sG/e/Ph8HvhY1fNOYVFtd/E6mYCbn2VDIlJrSczd3AltRNm
 8J09psocHeQXrbLeqdlVMaPNAns0eD68BhXqGiGsBpPlIWM9MTun8FuipSrv+1uaa6BzgFJZd05
 q6cXIR0a449+cyYrfAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080000

On 10/7/2026 12:51 AM, Krzysztof Kozlowski wrote:
> On 07/10/2026 01:51, Oreoluwa Babatunde wrote:
>> On 10/1/2026 1:50 AM, Krzysztof Kozlowski wrote:
>>> On Wed, Sep 30, 2026 at 07:52:11AM -0700, Georgi Djakov wrote:
>>>> Add a platform driver for the Qualcomm Page Compression Engine (QPaCE), a
>>>> hardware block that accelerates compression and decompression of memory
>>>> pages.
>>>>
>>>> Provide the urgent command path for synchronous single-page compression and
>>>> decompression. This exposes the low-latency operations needed by
>>>> compressed-memory users such as zram, especially for page decompression on
>>>> the read path.
>>>>
>>>> Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
>>>> ---
>>>>    drivers/soc/qcom/Kconfig          |  14 +
>>>>    drivers/soc/qcom/Makefile         |   1 +
>>>>    drivers/soc/qcom/qpace.c          | 764 ++++++++++++++++++++++++++++++
>>>>    drivers/soc/qcom/qpace_internal.h |  84 ++++
>>>>    include/linux/soc/qcom/qpace.h    | 154 ++++++
>>>>    5 files changed, 1017 insertions(+)
>>>>    create mode 100644 drivers/soc/qcom/qpace.c
>>>>    create mode 100644 drivers/soc/qcom/qpace_internal.h
>>>>    create mode 100644 include/linux/soc/qcom/qpace.h
>>>>
>>>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>>>> index 535c8619197b..6bcb86dcd726 100644
>>>> --- a/drivers/soc/qcom/Kconfig
>>>
>>> Sorry, but no. Soc is not a dumping ground. This has clear function of
>>> compression offload, so it should have some dedicated maintainers like
>>> other offload engines.
>>
>> The reason for putting this in soc/qcom is because this is a qcom HW
> 
> Every qcom HW driver is a qcom HW driver and they DO NOT go to drivers/soc.
> 
> Again: soc is not a dumping ground.
> 
ACK. We are looking at the crypto driver to see if it fits our use of 
the qpace HW block.

Do you have other suggestions for where this would better fit besides 
the crypto framework?

Thanks,
Oreoluwa

