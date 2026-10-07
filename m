Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E818C547046
	for <linux-block@vger.kernel.org>; Wed,  7 Oct 2026 00:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791331436; cv=none; b=A9CMy6knd+aahK1pGbc782nNUKtGVqzp9Yf1UBt0kZO6uc2IYK0NqRCxm4V8XRizA72nN8AEuX0IzsqQKEzXCn/6OiVqw+l2LhiZwX2pwMihbSek8XWgNC5Beg9bZzWYt3W/sWIZl1Lu/y0XGV6cX82hL3jr6785lXhPNaTc0y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791331436; c=relaxed/simple;
	bh=ruCjfSGct3MizqSDE0TmtgUXUHy5mBaRnQhxTHqCOrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1JcdMlALaUL9fxCAMNvltTfGaqN4Xu1DSiWJKckHph5Q+YEmdgdcxjWKswZPq/0rQpFlzCEHO5WIi7h9EmekxiKRAuwtxXC5MQSe/IMvyg9/OLLn5GiVJZgusq9wzhyaxx6hGpQEjuXRAhZFaF3DwWFYjProgemmhZF9XQ21bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DODPSc5e; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bC2yYrx9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DODPSc5e";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bC2yYrx9"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696Lekx62011602
	for <linux-block@vger.kernel.org>; Wed, 7 Oct 2026 00:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mEBVU7YoQnA6oJNQRreS9t217ifY2fL30vwizF+wfYU=; b=DODPSc5en+vzuHMX
	iBSMHbRqul1ViSDbLqtkcEm95A1obvei5t67JLIFPs6+sjiclHmd5FxRgvnLJS/i
	wxP2/q3a1cOkYwWRHaSgkhGkbog/jrszRKceroPxgurwIdIosJVGT9oZvpyewfC/
	A9u6zIXH45mg3s4hRMf5jImfGjSH6ugMcEQ7byo+h2ZVr3P/32Wouidvt2Mp0sX9
	kCJzoJQ/u5u4bM2h+kLD3Sx4hoZHN5Jf2Ns+qnq/SaytMgaINVXedWlVeSLS0wld
	M4NIxKvoR6C8FLOYX63x5gyugRTczckyXb68rasnQ5XihftwqMvBP+3660dUpz97
	8fSwyw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc9u8y6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 07 Oct 2026 00:03:53 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-14fed306427so12439310c88.1
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 17:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791331433; x=1791936233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mEBVU7YoQnA6oJNQRreS9t217ifY2fL30vwizF+wfYU=;
        b=bC2yYrx9Rq+c2auo1nWGfnU0Kv+vyliHZjGkFdzXlDBrTW7o+XWb3515KKZ9wKp+4u
         abZlM1opRy3LOUqYStpozoLjNwPRg8S+7aQPzUr4UdmoI2q8HQw0gefp46MAwQbPyXs2
         2L/c9POsKWIgp1mMYk5/Z++FHa0monMNlO67kyLCOOdj3/aQ4QZGPXe7juS8aEmX5AHL
         FXdTB9r01Cc78sR2wsEBGqbVVk2EFRvMIwL9FIb/hnsf5EdgH5wrOqznmZIA5n62Blp5
         ZR3RoQznEIUkgWyBHx/VYtEJUk2CdRp6RgGySf9nTLFuDgec0uuye1UzPwHSPOh3hWOT
         VaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791331433; x=1791936233;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mEBVU7YoQnA6oJNQRreS9t217ifY2fL30vwizF+wfYU=;
        b=HIQJdrjnTXFJqs+gH9zyFlSi1UoOeMXOGyoY2kUwP74iojBxkqmP/0u6B77A+dS7UO
         +ReBvufr6+W88/8ojU7Odv9qk66jb0MRJ9CBW2uPw51o831Evi3IxTQUbpnxV/xpmC4u
         DqRlGreOhbA2tGR0qmttbdnmIH2W/C+AwpCNqBzRm9gOZnG16TMr/J6owUg+zGF/Ydfv
         ndT39+rAfW6uA+daztni3pDpbZarrx6foMjXdQ8nqOKTh5u2S3v0ENWqdJWcG0PYa4XD
         anc7AydRVzK1KBC3v4nvB5da+p7MSu/DXpjsY1DWm4RSSu2LiMXtlbw4F66AiXPwhhzc
         3F0g==
X-Forwarded-Encrypted: i=1; AKwUvBztJNN5JSBrWcRLy3YnKEL+WErEjPD+KFYgSh+NW4hD5WFskf4TeX7Irwx9BolOOlKfFa4RZ2tg6I/E3Q==@vger.kernel.org
X-Gm-Message-State: AFuF++kdvxgyJu/NoZc5JwsqF3uMbVS0xhZe3Y4VFAxSz4hyAJ/cbLfs
	sGkoIFex5IomKIpJhCcBiH4u1iTUU3WFBmNfbbwN4IlUhqe8aKv7peRoxFDLrcPWVBeHI8Rz2Jh
	BxfdA0qKx7eoSjXmymmDAO/Y8Vccy+LvwXnJeTJwmmpDWkw39itd8rsBrX2lvKLXjhg==
X-Gm-Gg: AYBFou2klN7/hMEaGS/w9ZE0lkZq7GCDNpilbT1N2tMnt70cf0ikSfY4avlOT3Fm4Rr
	cjEmYSMXTY+23YRMFPYuR6fZNOEG1I0p0Pb7ikWRnPTQdbBbGYpa0Ej+HL6SD2BdAsVNPxf26JW
	2mFJ6MBMJD9Hck7PqHIDeTE4Tm+niHIK2Ao+33vTKDXWwBwDhDYBNyoTHOVDRYMhhPx/kUXB6c6
	5sia1LBWwdYXnngz9e2tRjNKG3uDk7Uc9Tlrs53itPvfts0+TArOb0a13T0MP/XKAqdr6do0ROX
	EhJdWcBaXXVi5pQF6y+ck95VNkGL0FxKlF6NFSq211mGJwGwStXXLE8VbcQilxZ6fFgRs18em5n
	GcSSuAUsCBztN6vvC1/TrPe1Vn/L4j4zr0T+zp9PvCoP/+F1FLzA2c+FMvaLpvKM=
X-Received: by 2002:a05:7022:43a5:b0:148:306c:971 with SMTP id a92af1059eb24-16206f0616bmr619792c88.22.1791331432293;
        Tue, 06 Oct 2026 17:03:52 -0700 (PDT)
X-Received: by 2002:a05:7022:43a5:b0:148:306c:971 with SMTP id a92af1059eb24-16206f0616bmr619459c88.22.1791331425354;
        Tue, 06 Oct 2026 17:03:45 -0700 (PDT)
Received: from [10.71.184.34] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1615f1ac8c5sm3343825c88.2.2026.10.06.17.03.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 17:03:44 -0700 (PDT)
Message-ID: <6d16d5fe-3165-4026-a3e1-27be256f5378@oss.qualcomm.com>
Date: Tue, 6 Oct 2026 17:03:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] zram: Add QPaCE zcomp backend
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
 <20260930145215.3380977-5-georgi.djakov@oss.qualcomm.com>
 <20261001-dramatic-hasty-pug-68ebfd@quoll>
Content-Language: en-US
From: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
In-Reply-To: <20261001-dramatic-hasty-pug-68ebfd@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ctMOAF4i c=1 sm=1 tr=0 ts=6ac58c69 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=DSiY3orsq6dgR2GKpvQA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA5NSBTYWx0ZWRfX3yTUOXKCQEn/
 pp+ZU2/X3nK6q5N905uUVcfjXFNIpOKau2/COCqcJFsz/ZyR5o4EKWtEFl/R/SW6LjVLjD5TtKg
 hMlGLeZBy9ZinUD6Y3+fbxVqyiDnIls=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA5NSBTYWx0ZWRfX7AcS4Y4rMuO1
 vaL8qgk1tydz8LSn8PNcg6LGlZf3LIdSInU9cL/w0+OvItB51Gf4eaBhfCKMVM+7zIHfvwEuDS/
 MnzPXwZCGAU9a/+qNpZqmC+U6ERk5gK0P36yq0vDkDPg2deRZvAwThn7Efm/GQijiuucARmm+/R
 5yCNKUS2Urf67UYmX4mhlZw3nEv1JCggx63uWgJwNnR+4QopkaL2idhXRrNRK/hye5Ti1AEGDwt
 +2kCz4MnfgPhDG7d6n971ikedP7aqPMFOoQZnDnQvT+HPjM1a1s+/I10w4a5adpbT7jdCEV9UUT
 Vhc68EQ41KTmDJw3GiS8eblNo5ua2Av7DQOunEanaZPsVY5BZVsEpT9Xjwh+wZFiQ8dnmSD7gXr
 8jloLr/sDh5dDAbZiSp4JTOrQnEcdYggclFopkuOKo27/LKVJErs5QEdz08ta7MwWWBc/OzrSop
 eedX2i4HSZUc7mVsfeA==
X-Proofpoint-ORIG-GUID: ZPXq4wPmEbsILQXVR7m6tVsfpYWhY78Y
X-Proofpoint-GUID: ZPXq4wPmEbsILQXVR7m6tVsfpYWhY78Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060095

On 10/1/2026 1:51 AM, Krzysztof Kozlowski wrote:
> On Wed, Sep 30, 2026 at 07:52:13AM -0700, Georgi Djakov wrote:
>> Add a zcomp backend for the Qualcomm Page Compression Engine (QPaCE) so
>> zram can expose qpace-lz4 as a selectable compression algorithm when the
>> QPaCE driver is available.
>>
>> Compress and decompress operations are handled via the QPaCE urgent
>> synchronous path: each request DMA-maps the source and destination
>> buffers, issues a blocking hardware command, and returns the result size.
>>
>> Signed-off-by: Georgi Djakov <georgi.djakov@oss.qualcomm.com>
>> ---
>>   drivers/block/zram/Kconfig         |  11 +++
>>   drivers/block/zram/Makefile        |   1 +
>>   drivers/block/zram/backend_qpace.c | 134 +++++++++++++++++++++++++++++
> 
> So entire qpace should go here, no? Why did you create this entire layer
> of indirection, singleton management under drivers/soc?
> 

Since the qpace driver is not specific to zram and may be utilized by 
other kernel components, it should remain independent of drivers/zram.
Consolidating everything under drivers/zram would couple the 
implementation to a single use case and reduce its reusability.

The backend_qpace implementation was intended to setup zram as a user of 
qpace and follow the structure of the zcomp frameowork. As per your 
comment in the other patches, we will check if this can be done through 
the crypto framework.

>>   drivers/block/zram/backend_qpace.h |  13 +++
>>   drivers/block/zram/zcomp.c         |  11 ++-
>>   5 files changed, 168 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/block/zram/backend_qpace.c
>>   create mode 100644 drivers/block/zram/backend_qpace.h

Thanks,
Oreoluwa
