Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9423126D6
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 06:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328992; cv=none; b=oigG0Ais+EtqjTtQSCLsF5JuX6RWeaIC8EHk9tnJFI441Qjv4yrVD//BVpMPFHPQNGTI92ealSpA5ubudO4YHav0I10SJc6LkRmaZHmsdQBhsEuEbusQ9ct8pwtI0pQjWVx7BpMFxrlqlKqmun7XZV1Kiw41DdSDsApGXiaflgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328992; c=relaxed/simple;
	bh=lbpHvV9nwxHUmABpWmOFrhwkTXsjfOSaP08IrwX0zyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CrCAegZVBsF+xijPru2ifOHKGFJGI9hIeKsRcT+1iVuCXH0wMWC/pV6BzpwzcuyOnB1JPE86+yznjefMJ81/qYVLTQmImT5Nxse7QRrMFw+YMcJAfLj6dm3ocuqaxpwScuwfpsJMXgEUR8Cm/459KcdP59YXbIjorFL8grmmioc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fZXk6xUH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KYonrtqb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fZXk6xUH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KYonrtqb"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6825YI0L725784
	for <linux-block@vger.kernel.org>; Wed, 2 Sep 2026 06:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EcSnLB6WKmAsBeRVJJ+St11n89Sukxc1aDDh+R8r5IQ=; b=fZXk6xUHRubKSz4v
	PWhkAY7U0kvr7kfm3f9+8ynciDF6bPIo655pYwp75e6CrJQJJSXuVoELWNyLQXKu
	8NbxmXHh9TWZ/6CUdoNfLK/3TcPzELEx2C1lr3zhU5LJLHKGVwEGqIeHC298ROwG
	Jq1+zES01/2Rj9c2aqlqx5LWp4sZf0WBJ3SLV1L4L3/pwYHF+uERoFGNRCn/y2dj
	RpMft9/++EtmMnUpM8LYJAl28inGtjTm0+E7iLKEq55Gk05aiQgUfIBuLwVOxOJq
	QQy8JuifLdoY8CpUpm922uwCMnFLLYCk5UhhatZbvpQ5NMmS1sjdohV7rxsQClfq
	omwfCw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge38w2byy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 02 Sep 2026 06:03:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-395543dc382so970256a91.0
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2026 23:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788328984; x=1788933784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EcSnLB6WKmAsBeRVJJ+St11n89Sukxc1aDDh+R8r5IQ=;
        b=KYonrtqbd7vL4151Rfih8vykYU0k/roN24sz+cq4yO91efPmrU3z4TIJW3vA0u+lF6
         y1YWpkJjn/DfE2fUAWGC+vqlXb3IAB8I5R0XrTZSChK97RRckYVfygyqcCxp9HeEKbkX
         VVEOugPTfdwy5CPQgaiBx8yEQSNUK09zBVQ04tWyQ0gTtb1XFudmHpLpota9duGmR+Am
         ub7n92/4qaH93VSMDc5jvIyWS+Duf5dVOspbC+BnIiGbpazZo/RgNTpwn7AhcR0a6VnY
         SosQUOBkymSFg9zFqNKUgwOi8Z38Gvu88cMK00R83x6WVXoNLb3CAdOtwlYTt2o5SalE
         cXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788328984; x=1788933784;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EcSnLB6WKmAsBeRVJJ+St11n89Sukxc1aDDh+R8r5IQ=;
        b=liuYwmQwhFaXP8NsZvqScesINtoCx+9ce0IVypQXzGfHrPDSHaj2GX7jIIlag9a8+E
         KFKB060FKaZ4gkVYd9icG0BsEeAqXCqV29GzPvUvaZsAYTVy2EZNYyHWCtLF0He/iZca
         G+HtkGw/6NFPmDcTHIXNlCnbPgeVFutg1v+4wczWMSQk7qFNo9N9c2/gMNgqFGCdYW+u
         ehKHbCJ5W6TawjuAVRaKvDFI+oEXHeTfLQh6wF0pDKkLtqpXlM+KJ0amw3GE+VxvNBgh
         /npMQugBk/RLyckK/2BLTJ/JdhWaVrVC1Vl7hncjRlFbeKloNinsbZsRiCa6tenYkfkp
         JUIw==
X-Forwarded-Encrypted: i=1; AKwUvBzLlE7BB+E854utJW7ZRC0dqeHZ38IJLel12JEOidCdRQ5V15bh+MTpuqWYOGqK76WLMm6cUT/ks+aisQ==@vger.kernel.org
X-Gm-Message-State: AFuF++ktz6WpQ5bWPGHp8c58xabLQU7EBnMn+n2AITQKTh9cLgmr5ndJ
	RM+kDxW6x6RvttkZCziQnJTybTk7qXtYEauzmQ+SR0lcgZMT9AYxQTlM0gvMdtGw2Q+z/y2RhjH
	nL5jznIESvVFO5KLjEZaDlE7+s2MMICdvQAXzuCoPcNJH98LMLa0bqeForyLUhtgkFA==
X-Gm-Gg: AYBFou2HXkW1CQc3+EZBz7wTt0/nzCFUcEgzFAVSUyn+6Xc+stIqmPWASAEH0ARM5+v
	AGrV3A/c7BN+LGcCdoiRV1bVksj5ew6MTK1Y6UsSydM3XGutPijm6fYdIU52o6Rrf8xFITU5YZU
	+tMXlBI3c2e14cPz//Sol6ZTVTNRg00rj4stESnoV6JHi90uiozE20B870yDcp5+CQz8CHUauT5
	jZhbt2rBwd8yCMVmApwN140rnHqO9XTtqHMXjpQxbfcElZFUDr10lg5WFfygHO6XEOM+Gxlpz5E
	2ubs4YbFC2sEdeh9fTFEmG+kRFTNl9+zbBikUakIoO3Y7nF1gRlZe/xi3gcvI5cbNBwCnXhFYGq
	t1aheD3fM60EJeQEtQ8w8byvwGwILQXrD7656ZwRnqhRU5NUrcXkybKBP
X-Received: by 2002:a17:90b:55ce:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-39aee066e9fmr3902070a91.16.1788328984239;
        Tue, 01 Sep 2026 23:03:04 -0700 (PDT)
X-Received: by 2002:a17:90b:55ce:b0:395:4de5:1054 with SMTP id 98e67ed59e1d1-39aee066e9fmr3901979a91.16.1788328983698;
        Tue, 01 Sep 2026 23:03:03 -0700 (PDT)
Received: from [10.110.50.50] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1430e9eb4dasm5534267c88.2.2026.09.01.23.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 23:03:03 -0700 (PDT)
Message-ID: <9352d44e-ef61-43f5-85c9-eae267762e84@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 14:02:56 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/11] blk-crypto: move bio_crypt_dun_increment() to
 the public header
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: ebiggers@kernel.org, axboe@kernel.dk, mst@redhat.com, jasowangio@gmail.com,
        James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-scsi@vger.kernel.org, virtualization@lists.linux.dev,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        neeraj.soni@oss.qualcomm.com, gaurav.kashyap@oss.qualcomm.com,
        mani@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        bvanassche@acm.org, alim.akhtar@samsung.com, avri.altman@sandisk.com,
        pbonzini@redhat.com, eperezma@redhat.com, xuanzhuo@linux.alibaba.com,
        linux-kernel@vger.kernel.org
References: <20260827160806.1295313-1-linlin.zhang@oss.qualcomm.com>
 <20260827160806.1295313-8-linlin.zhang@oss.qualcomm.com>
 <20260901191342.GC729142@fedora>
Content-Language: en-US
From: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
In-Reply-To: <20260901191342.GC729142@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3dKX2yPd74TyZKyX69_ojj-jVYiJmyet
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA1MSBTYWx0ZWRfX6YkxbSOg9CJU
 2BrG55c0yVEPB8uzzcpqZaJf/44nht8z3dgxNZdAnYYk9SwyHnqdfzr5KoKVCYXaxNS1h+eNTT+
 gkgFE7FZQZm0JdAmvmriD1HBrD9z/VQ=
X-Authority-Analysis: v=2.4 cv=LOpWhpW9 c=1 sm=1 tr=0 ts=6a97bc19 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=-2wExInEUDM6fBQoz8IA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 3dKX2yPd74TyZKyX69_ojj-jVYiJmyet
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA1MSBTYWx0ZWRfX8LQkWMYGFjjD
 +Ubmzj4pe/+fi2DXbuLoEBkNHdT8Y4bGQep3Z+LSro7mSzh+oHtK6dr0vRAs+SOHddpjFDeMQal
 D3w3BW9qA25RzY4v4bi2bBkkGctanuaM7HKaKrwNCMjlJZNWw9F4OiJqzqH+ojI1x7VWd923mGU
 oUYPikpjRg9M+pQ7hx16KCDnmsNzFY8/ZVQ4RDLdSR7sTa4UtEQ4vH3WgDBiJEwal0lJPGiWVRl
 Otv7JJqXIM1gX1nrXjwsrj2B7xTitQ4p+a1ivSlcFZoOkyH/o6Q2q673b6+uwELGKdP9mxZ/Tyq
 rBTl84O1TxyoPB1BV3tpJAkAWADSGIsAYyxLxur6IDLT80mPVafctEpS34D2LUyYBH/Pv0ewqa+
 ellP8wlmDw1sCDZqbwai180BAAA+DJl0Tat13kXijuWjSPIM+KzXHh5ogBKzTsLSdLLc7vqiVL3
 sMQOTMKldqtK6oto7bA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020051



On 9/2/2026 3:13 AM, Stefan Hajnoczi wrote:
> On Thu, Aug 27, 2026 at 09:07:16AM -0700, Linlin Zhang wrote:
>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>>
>> bio_crypt_dun_increment() is currently declared only in
>> block/blk-crypto-internal.h, which is not accessible to code
>> outside of block/.  Drivers that manage inline-encrypted I/O
>> directly need to advance the DUN across bio_vecs within a bio,
>> or across multiple bios in a request, and have no other way
>> to call this function.
>>
>> Move the declaration from block/blk-crypto-internal.h to
>> include/linux/blk-crypto.h alongside the existing
>> bio_crypt_dun_is_contiguous() and blk_crypto_init_key()
>> declarations. The implementation in block/blk-crypto.c is
>> unchanged.
>>
>> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
>> ---
>>  block/blk-crypto-internal.h | 3 ---
>>  include/linux/blk-crypto.h  | 3 +++
>>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> Other include/linux/blk-crypto.h functions export their symbols. Does
> bio_crypt_dun_increment() need EXPORT_SYMBOL_GPL() like
> bio_crypt_set_ctx() and friends?
> 

ACK

your're right. EXPORT_SYMBOL_GPL is needed. 
It will be added in next patch.

>>
>> diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
>> index 04035d237f03..32c720aabba7 100644
>> --- a/block/blk-crypto-internal.h
>> +++ b/block/blk-crypto-internal.h
>> @@ -26,9 +26,6 @@ int blk_crypto_sysfs_register(struct gendisk *disk);
>>  
>>  void blk_crypto_sysfs_unregister(struct gendisk *disk);
>>  
>> -void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
>> -			     unsigned int inc);
>> -
>>  bool bio_crypt_rq_ctx_compatible(struct request *rq, struct bio *bio);
>>  
>>  bool bio_crypt_ctx_mergeable(struct bio_crypt_ctx *bc1, unsigned int bc1_bytes,
>> diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
>> index 33ae52b77522..c9f436b6b2ef 100644
>> --- a/include/linux/blk-crypto.h
>> +++ b/include/linux/blk-crypto.h
>> @@ -181,6 +181,9 @@ bool bio_crypt_dun_is_contiguous(const struct bio_crypt_ctx *bc,
>>  				 unsigned int bytes,
>>  				 const u64 next_dun[BLK_CRYPTO_DUN_ARRAY_SIZE]);
>>  
>> +void bio_crypt_dun_increment(u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
>> +			     unsigned int inc);
>> +
>>  int blk_crypto_init_key(struct blk_crypto_key *blk_key,
>>  			const u8 *key_bytes, size_t key_size,
>>  			enum blk_crypto_key_type key_type,
>> -- 
>> 2.34.1
>>

