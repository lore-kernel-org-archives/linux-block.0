Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8CD4D6C29
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792070728; cv=none; b=U29Bur6lOG2f4xH+XmRbAdeKQFGkOllnT9NQFH4bsSFQ+YGQoc9pjmyCL40XaLVqhIN95yFRU2EonCjHtYK64fkugV5d3IkWCKp2vj9evQXyb6XhCAnUf4onUd1pCf1xiprrI0pu8WjBzGi3LQ2+u92VEFqJnwQRQSg5FqOe4mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792070728; c=relaxed/simple;
	bh=OKl8FxF8IEbfAFyPdAhMBb2ftzDCnYFKMb5F9NMa5dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FnpVvok+Z23xUW+FeMSpj0mrI/4L/C+ESLoeUggaQ3+TxTLsACR3oxjYRngg0+7+AG8tYGz5KbdEnYGlBVmsZNbHdvJjEi09qo4sSu5qbuPzLgPyNN/pzWMEm7f6oJx4ol2gkKAtAu9eZCSp9uuQbQ2ldWv0HnKh/iOAjiR4vSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ddDE0uF9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LbK9FDGe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ddDE0uF9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LbK9FDGe"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9jZJj2966434
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 13:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gCJfok3rHI2nfv7ozMgYv1Bh87GJoQXCUXkmVH8cksM=; b=ddDE0uF9JmMiZi89
	0pSWhIStLk91p2Oa3mAq/K1DHJ/UGyhTK7OBu9A1DP5NMKgCP1x+0lmeuCgCm2Bu
	Hsp6velGQMQyWu00dsapalMCS0WjjRbF8S2f5a2Scz2e1i/k1pTD5vQmEHhdzAc4
	WVdM0z0TYH09b3weQM+SRt7JJh2Ad1VaxmNtzQnRGkjN/gZv5x9ZLYPJQDy04Nt6
	RupmY9mF3nzlHgRIy0X9bnYJ4P0KH3AAMW+bSDEvcE9kwcR9ircbLGBCyCZ70Ff6
	f+uUBrmaeMyxIuWe+yLHg4gZltdylfDn3As63uqQgvGlgAubXYV5h0e1mQG6eP7e
	J8SkgQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hae4wv808-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 13:25:25 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-97c7e1d8bbeso289052241.1
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792070725; x=1792675525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gCJfok3rHI2nfv7ozMgYv1Bh87GJoQXCUXkmVH8cksM=;
        b=LbK9FDGeeul3ZXiFJAkavP8OF2Qi8QtX4pI6552Yf3nYGpUXCo9iRTEX7/jYQdsMte
         7LkZqExCS+PfhL4zSwaE/ryRkwTkdvXwNDGAR+TKIikJ+7zBqbFKviPySIrN0eaHfhAa
         42XAfDl7NK6VaTeXiFQKcd+/WbInSJkEyvcqc+RfBPTms7JuZ8c5aI0EHn/+dM6nERsD
         iE5G2FsLU5p9wxXM7M4VlqGsgKEXmvFGIJ6kvWZLgjMy5eOJRCBySpIC3x7HvHupWB1g
         Lurq65BMHtm4rHIiR4fG5snehKFR0Qxwrnfj5gCjoaP0I8pWuU8s1xeN0k1YfJNoG29i
         xOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792070725; x=1792675525;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gCJfok3rHI2nfv7ozMgYv1Bh87GJoQXCUXkmVH8cksM=;
        b=vvEtlP1hABmnSiSgEVuVlF8zjjCTxRrCTTg3er4RFGu5qjBKnmoiYdDj3tgNgYvGEG
         bRUuQEtX9q5J0UscmWF6Z2EL15aylUPlRrAJ/T0yfkIA2igUKrSbmQWREi1SApyz2v6B
         l8ddTQXJwf3CagHf1Jlv3lfjGveKFqC4h2Hfve64XvIxqhh5PhV/sRE+7+YTfry9HOhq
         cfYYHcJmjRKCpdxfj6xXCG3dj983IPtY/+sA1+l6W9W7Zi781qyNHzKaNrMY9ut9g66T
         FP+Ymt1I8Gb0Rr0BQQ38HVnlG1FEyK1RDdHaJ8+kkDne/pBdq4D6K408/vz5QnIpDzCn
         eZtQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3RAUiniYrddIYnEd2QKcjEC7bEl9bNMyyEI38f90YVp9ccKKJrp193BS2eTnKY26xJZg+SM67nXfrLQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJcogB6VVJKEjok0zDcH6l2xf2Wd7Kkx/sUJFr4TpR9pPFy04j7
	qtWlhsrPe89WAQXvDZ49eKCU2OKWFYjj8mEwLxtSw17vxkROttyIhLE3TpebqBUtiTNP84o2S+C
	I3RffqGFmUjDPZ+JuAfUB2UXWJVPFR/Nxw6412BK2rOECm0sopRorRp5CNrTYKdlEvQ==
X-Gm-Gg: AYBFou0LVaDhHJo4RV/7D+OSGYNHdySUbJCTbCmexxBtfok94hJFesdjJF7tmqV/7YV
	4xH18Bkr3hZ3kFI6mtA4M0/6/5SMqC7dwNNKZtUgJ6DBP86o9lXbH85bQey2fnEfdaosUFhup8p
	B/vKCLrfmYSvzi1YyCFKVMYm8sK973vGRFCLdt9+9HqgUUz8Jnw++jBqzEJOZpHU5gODDe6BFSL
	yL7W/WAQTmPsIAdCxUgce04Fz/J4Rj6SuHzVkQWx2fcwiwJoJGNSodNNiMYDIJqfYXGLjroXVOr
	0A1AMNa1/t742r2JK3WY3UpT7rB3VRJ34rEyTI14hN3bRGr39OXqj1eFMSYGZ/jB8jIkHr3I78f
	MwBMDPN4jXiWVL6tFmf2zm8LotcvTeQ==
X-Received: by 2002:a05:6102:41ac:b0:7cc:1045:610 with SMTP id ada2fe7eead31-7cc10451036mr217337137.27.1792070724704;
        Thu, 15 Oct 2026 06:25:24 -0700 (PDT)
X-Received: by 2002:a05:6102:41ac:b0:7cc:1045:610 with SMTP id ada2fe7eead31-7cc10451036mr217320137.27.1792070724111;
        Thu, 15 Oct 2026 06:25:24 -0700 (PDT)
Received: from [192.168.0.31] ([212.5.153.243])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd66ab3dsm65873415e9.2.2026.10.15.06.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 06:25:23 -0700 (PDT)
Message-ID: <f44df63d-155e-41ad-8652-36d770efcdb6@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 16:25:21 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] soc: qcom: qpace: Add Qualcomm Page Compression
 Engine driver
To: Krzysztof Kozlowski <krzk@kernel.org>, senozhatsky@chromium.org
Cc: andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        minchan@kernel.org, axboe@kernel.dk, rostedt@goodmis.org,
        mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, djakov@kernel.org
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-3-georgi.djakov@oss.qualcomm.com>
 <20261001-hopping-belligerent-spider-876e7b@quoll>
Content-Language: en-US
From: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
In-Reply-To: <20261001-hopping-belligerent-spider-876e7b@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MyBTYWx0ZWRfXxHu9f/JZjU8A
 8apFrGxOe3T6w1R68Df2x/5L9Y0vghSuRTRr5W+H7O4kIhxJCv7di20e0NDyso5g/+FuvkyKe7u
 fQU+VaXR8H5+aJOl4YQpE/snTmjZwEk=
X-Proofpoint-ORIG-GUID: 7jbbhXCi7KZ6tcHTwK7Ub-lNcveuH5zB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MyBTYWx0ZWRfX59A3vz9tBMpO
 AdTOG0UPMP2z0ydmISHJQ/ImYvyxge4fzfszjE3HEvlbdlxuj0HCChn5NBZRiUFXLOMjHuv7Rni
 p5yj5QESmd0KuLVVRi3cCo92BhpUFd3h8lB+xfmEQyxYS9EV6DOspyyvmYx8t7xvhCqwisULXa/
 tYxyw/PhNFEcKUYVGELKaLKeIyUrO//hTtmTcVvUH9H15gX9IJhIGQQ+65SZtzZQW0hSfsgN/Y0
 YvNUep7MvNRJYTBwtALrtDEShFEI2hsWW5Gt2yNFvmDJfouTgdb4Wq5+k4R6O42QRUsxm2kWA11
 wS6QCI3S+VcvFvHLpMwWrLPxUbXZadtyNgeVzZ14cj32F0axF42DQZHCZNt4Y28c+VDs/czHPh5
 O/IySe0v3iZwRdVfLWQDC7Pui8spCYnqCh+bTajHyuhiWDf9tsfTDejkfejixYt0YUTyQxx1LrP
 z34LFmQ9sAfPBJNVRwA==
X-Authority-Analysis: v=2.4 cv=E8BYNqdl c=1 sm=1 tr=0 ts=6ad0d445 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=douLNevBrtimd63D7eljNA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=vTTj8iH6AlmXu0jsvGYA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: 7jbbhXCi7KZ6tcHTwK7Ub-lNcveuH5zB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150053

On 10/1/2026 11:50 AM, Krzysztof Kozlowski wrote:
> On Wed, Sep 30, 2026 at 07:52:11AM -0700, Georgi Djakov wrote:
>> Add a platform driver for the Qualcomm Page Compression Engine (QPaCE), a
>> hardware block that accelerates compression and decompression of memory
>> pages.
>>
>> Provide the urgent command path for synchronous single-page compression and
>> decompression. This exposes the low-latency operations needed by
>> compressed-memory users such as zram, especially for page decompression on
>> the read path.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
>> ---
>>  drivers/soc/qcom/Kconfig          |  14 +
>>  drivers/soc/qcom/Makefile         |   1 +
>>  drivers/soc/qcom/qpace.c          | 764 ++++++++++++++++++++++++++++++
>>  drivers/soc/qcom/qpace_internal.h |  84 ++++
>>  include/linux/soc/qcom/qpace.h    | 154 ++++++
>>  5 files changed, 1017 insertions(+)
>>  create mode 100644 drivers/soc/qcom/qpace.c
>>  create mode 100644 drivers/soc/qcom/qpace_internal.h
>>  create mode 100644 include/linux/soc/qcom/qpace.h
>>
>> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
>> index 535c8619197b..6bcb86dcd726 100644
>> --- a/drivers/soc/qcom/Kconfig
> 
> Sorry, but no. Soc is not a dumping ground. This has clear function of
> compression offload, so it should have some dedicated maintainers like
> other offload engines.

Thanks Krzysztof, and thanks Sergey for the input on the zram side. Before
I respin, let me elaborate on a possible structure, so we can choose the
direction we want to go.

The QPaCE driver splits into one engine and (up to) two consumers, following
the IAA/idxd driver model split where the engine exports an in-kernel API and
the crypto side is a separate, thin layer:

Engine: drivers/soc/qcom/qpace.c + include/linux/soc/qcom/qpace.h - decompress
primitives. It stays under soc/qcom, interacts with LLCC slices etc.

zram: drivers/block/zram/backend_qpace.c - A zcomp backend calling the
engine's in-kernel API directly. The zram intentionally does not use the
crypto API today (917a59e81c34).

zswap (?): drivers/crypto/qcom/qpace_crypto.c - Registers qpace-lz4 as a
crypto acomp algorithm for crypto consumers (zswap maybe?). It will share
the engine's primitives, so this would be a thin wrapper.

If zram switches to the acomp API in the future, zram can use QPaCE through
the acomp algorithm and backend_qpace.c simply goes away - so this will be
compatible with that direction without depending on it.

Krzysztof, does engine-in-soc/qcom + the crypto acomp address your concern?
Or would you still prefer the engine live somewhere other than soc/qcom?
An alternative would be to put it in drivers/crypto/qcom/ as a crypto
driver - register with acomp, but there will be no user, and zram would
still use the exported in-kernel API.

Sergey, is a native backend_qpace.c the right thing for zram now, with
acomp left as the future path rather than something I add to zram core
today?

Thanks,
Georgi
