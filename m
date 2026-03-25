Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0451A680D
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 07:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774422250; cv=none; b=NnEbd6SW/5ekfEfi5ofZrBIGW1TxJMLHZI+WQsKz56vytgL+KGbq37/cU0TsW9fZ6fFtq0DATTGlB2pMm6lhWPSBFQWO8T8EZ530M98xn4cF/nh0iX+POvEYhR4UTFCQxCNv+tbMzZXt9O1VDIECE9BAFTNvqfYzAfQRy0QQ1MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774422250; c=relaxed/simple;
	bh=EqBOs0jRrwD3FbMvrXgC+4DO4UvpFLji0qZZL0gGPdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpebftvRD2qMhkOlCDBCLVUaJ3wnbpvK0Qd9iWIviiysENV7Y0PQXX6iMOUwWEqstaIEEDJmuQVQcv+MGNDqBxRM1CBe3Efbt1IwSwOoTMLfAEmuwxG/9J1ykUKA3FSjW/p/v42XJOlkj6Wr7Sz0kSCIdhWtq9MMSVMdtYfIOtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iBMeEJie; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DGA35KaC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iBMeEJie";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DGA35KaC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P3xHXu919627
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 07:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wL2rYIimLmWWyyTP/wOfbukZyeC2GNRpjfItV9cVfng=; b=iBMeEJietAg1y97q
	qhdsajuTN8VYuhVBVnuBss3JMk2cFTYYWXWBdCJUNUMrSZHNT0qwr12h9JbhkSOg
	OQu3aYGSOQdS6TcP/p67oVBDP5gOEHsRZEGu377z9fYCloNKz3c+18MVoXLhaNnH
	a7y/jz+P1KoTs6h/wOUBZWUs3HKENLsOXJc13yqs6VB44e4EA19gD98Oemp//e1p
	JD8PGReAmQh+KkYtV6BxUABm4FAIlZqgLrcfPhFxEotxCtdRcYJnP010ct9VTYMM
	Eb81Fq6Iz++x7X0FjNPJN5pP6A7+Gy6ecu2y2YpBhV3MAhJy/HgF0GWnWHWIl7gO
	NH2znQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d489mgjbj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 07:04:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2c16233ee11so343879eec.1
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 00:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774422248; x=1775027048; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wL2rYIimLmWWyyTP/wOfbukZyeC2GNRpjfItV9cVfng=;
        b=DGA35KaCIVy1A+sq4aLCGX9XAg3kX1Ve6yofx303c3W8C8VqlES3Kz8O3j4CNhmrGE
         okWuBLhC/o7t2VDH22gzEWUMnxmMSNb9vdYNdozisD2cjBLm/LhAVdFg86m5qf2SbDNl
         ElU4SZZQKMX5cmKwZxzDuL5p2dGCu7mosQjeiWglfPD7+6CSM3tiCZ2ZifEIg30CFjvm
         zLiKHZuwpgSHnvwSqMH33XmZ/2bEnswVpl4Y898R4Ca6/TfharwPssDEQ0dXrdIUx/Yt
         nCG5txm+JugPQ4qphs9yu61/uG7YSDQpZltxKGXmcVkPnznOMAC1uRVleMj/ALJFfiow
         mqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774422248; x=1775027048;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wL2rYIimLmWWyyTP/wOfbukZyeC2GNRpjfItV9cVfng=;
        b=g+Ha6VVvhyoT1qlpAMe0GOjxRl+NN4QHcVjBRw7aB6HWNNEsRfuHcvVwdrxtpkwn9F
         MRQaaA7yBT970FO8lP0G8IiifPEeQjHmSq2cTvpswA7a1g0q8psNDZ1xXUgzuS1QjYc8
         XHNpRLAv51hb+/ohwftx26OClRZyGg8X6vJt0aOOzjTYebmcWpIzNJkjnxoo/O84L+di
         YyCKIy+iG9cRcYw9AeWRO8d7BouqdNbi2hG0+EPBJWirEDWM2yAh77k2abuyOEGXhtdz
         9cHQeAIA6TIEtFMKzxBv8ho2U0vpTUL07jWy72V1CGgzxUyKNZbvDChWL+9QdiAA7cNa
         r/3w==
X-Gm-Message-State: AOJu0YyXcBXLDLba0+hM2VHwZ8kVaUTdC45VMgAEkL7gF2BPUqidqCBx
	ic21HR1cLxaJPIYVkeybO3/U18AwMKiN2LaZr/agWbP9ONZxepNYDjmvDczeN02GYRObMupkNDr
	Lo2ws+FmqFOHtiLgLydXTgu7qc45TnlExfa8f529++n6pTURErKFN+8zUC0xVFvRYgA==
X-Gm-Gg: ATEYQzzCAYJ2rwHqGuP1f1K9RRa422HnsEiNOUdG/gyTS/RfBQWfkKfq7g8MC0iMv1W
	bZBGICHVa0zOCcIlDpr4v8LLTZNpARfKgzGZw5EpwrkMHzuTROk6fYEeapng6rvla55VNId9MPP
	7Jm1YwqoTHVvMYVXENMbt60gauHxTpGpMITT4ApxXGZFta2M4PeyzI0mK3ce1TETkjeGm2tkCHD
	S2IvUdn+8IrZxbtpxfU6VkKdLZMxHkQMD9nsHrozV+FKEwvK+6LWjKIn05CcHwTxhSHPk0zWMo1
	3vu/SZOQlv/OiD4mAXbBYB7WhSIjx/C/Sa30rk2Dr1p5GC2Afrk6UwBiqPpJKjV6aibVeMAEZT7
	ywKvCi4eF9hmalf3bbwbCUK8TOsyDOzkhUJOWUl1ZPhrJq+ZepgPI9BboW/bIfF5BEM0XvABEF/
	sXb4Y=
X-Received: by 2002:a05:7300:6405:b0:2c1:571f:b824 with SMTP id 5a478bee46e88-2c15d4177eamr1370258eec.30.1774422248257;
        Wed, 25 Mar 2026 00:04:08 -0700 (PDT)
X-Received: by 2002:a05:7300:6405:b0:2c1:571f:b824 with SMTP id 5a478bee46e88-2c15d4177eamr1370239eec.30.1774422247741;
        Wed, 25 Mar 2026 00:04:07 -0700 (PDT)
Received: from [10.110.19.183] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b1a88e5sm22144015eec.13.2026.03.25.00.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 00:04:07 -0700 (PDT)
Message-ID: <996ba1c4-e91b-4a04-9424-7c262d45ce0a@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 15:04:03 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] dm-inlinecrypt: add target for inline block device
 encryption
To: Christoph Hellwig <hch@infradead.org>, Adrian Vovk <adrianvovk@gmail.com>
Cc: linux-block@vger.kernel.org, ebiggers@kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
        quic_mdalam@quicinc.com, gmazyland@gmail.com, israelr@nvidia.com,
        mpatocka@redhat.com
References: <20260304121729.1532469-1-linlin.zhang@oss.qualcomm.com>
 <aaguW3p3_LOeM_Dz@infradead.org>
 <CAAdYy_mSB4U39Onwa=V2e2XB0sJXV6tCGkzwV2-z7ZtMcm+8zg@mail.gmail.com>
 <aamVXAqlWGcPXCDe@infradead.org>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <aamVXAqlWGcPXCDe@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA0OCBTYWx0ZWRfX0VjoHgwDKT13
 jGhhFP8aX5XBCa4bvtuJrcHEwEbn+Wp6F/KacoP5FV2CWESD6pR93JEAcLE92N/QWlX3dDEnp+L
 AkZmN0IKpaPrKnaDHzxIRJs2Dip0gtZ3PlWtQ/ByJGiiDpBVP0jM6pZGB25dhbSPABX9SjL5qjs
 89W9Cu6E2KmPJahh+IvHJ/j3c5gyHh9kjNl33p3mMhSGunKUkgvlcMNZqoOlkGCugOZ3i8EcnA9
 BWJh7Z/nf5Hm5ew5U4PGlEOG6TAANitLJ+h8JqFgqmBKuXmGUcd30CVQMbgfMRGRYXJWHK/BGcD
 bdwL/+sri+gwd9xNAA7IAZBpAsF7A2XEmR5obkPgTKGwvV6sT2276zzZIzPPXwm6ihe47REHcrL
 +3r+5cXG3QelfJ/SxUb+L+XA+n2KIlg0OR8wEyWzuvmDgIHqIDWc6e4uve0gYVHRejZwZyW3wP5
 b7YdWNozxwJvx0gbOjA==
X-Proofpoint-GUID: yttunGiNBfu7LqapbYOrhPprcm6FB3Sa
X-Proofpoint-ORIG-GUID: yttunGiNBfu7LqapbYOrhPprcm6FB3Sa
X-Authority-Analysis: v=2.4 cv=AKSYvs3t c=1 sm=1 tr=0 ts=69c388e8 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=fqon-WgCYBziNm8ShXUA:9 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250048



On 3/5/2026 10:38 PM, Christoph Hellwig wrote:
> On Wed, Mar 04, 2026 at 01:02:41PM -0500, Adrian Vovk wrote:
>> Hello Christoph,
>>
>> Maybe I am misunderstanding something, but this seems orthogonal to
>> fscrypt? Userspace would use this to do LUKS full-disk encryption, but with
>> the hardware acceleration provided by the inline encryption hardware.
> 
> Ok, if people really still want to do that that should be ok.
> 

Thanks for your review!

Yes, this new dm-target type is designed for the Full-Disk Encryption with
inline encryption hardware used scenario.
I believe it's necessary as dm-crypt only provide software encryption, the hardware
acceleration provided by the inline encryption hardware for Full-Disk Encryption
is always what the customer wants, like File-based Encryption with Inline Crypto
Engine supported.
