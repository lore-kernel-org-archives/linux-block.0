Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B381E260A
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 05:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459266; cv=none; b=g+WOmV2MBkXV32oP2w4MJVY0eHpiP0/8MoDHLBoUQzUNv/sUZym2DPuBtgIuzs6GYvtZm56r4jsuxpAQmak5WWmT9grDpjkbazH35f2fPUgHM0HbmkVywvHkNUETJNAfmMuObm3hgaBrKeKnPFAOK+IsLZsM4jD5QX8K8bHXBYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459266; c=relaxed/simple;
	bh=ORopZbKtb47hoXzs0E1CAnRoyUFQHarNOB+TOflB6R0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnA6A+wOE6mixeVkwtxzh1kJR0NOgWXgHWIEQ/ARQHhev1AhDMVzKsJqaHEg3RzfvIgXVSVCH4FFilLVi7yBkBkjh18FcPoS0OXWpb1VsuVzKEaKFYffh2dzwh9ihGhrpY2nRl32OomoJdohLjdn0Oay1wOriBF8edWlkp3pchI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K3x+qXHU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K3x+qXHU"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575IpXe9021718;
	Wed, 6 Aug 2025 05:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4ZyT8g
	UCOc2+JYJNKaVtzhBhyMdtD+Iqw1sNwMVftDc=; b=K3x+qXHUOylMjjsavCIbqh
	9Iy6Xz7sukNUu+HC4/XkUYhOsL8J0+W1MonXJneXQcUOmzDkCKntEuoHzPBe6wjm
	qMAh4Si6wFfl3sWn44cq+HKoUgPsJkv2R1zG3FJ5Q2Y1/XEkhI73QbK6l/lFm4xb
	AKjnIUYDSgCeAB4aV4rXn5mMs4FN81O9ucpGk+QyJ97OnY9O7y3lBCNL5I1yrKTB
	bdCfHUWmkMIHPA3eUWgZe8KSmlCpxI089k0NVUOLvWdhGMobSKGg52gqq2TzcQV2
	v9EABH8zsXJvN7e95kWz4/IjHwm1Bm2dEPJyNlAVJ70JLRr9HRZVX+DbkLt2UhOA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq632a7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 05:47:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5763W8Ss031326;
	Wed, 6 Aug 2025 05:47:25 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwna6m2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Aug 2025 05:47:25 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5765lOLQ9765764
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Aug 2025 05:47:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D21358067;
	Wed,  6 Aug 2025 05:47:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0F165805B;
	Wed,  6 Aug 2025 05:47:19 +0000 (GMT)
Received: from [9.43.92.22] (unknown [9.43.92.22])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Aug 2025 05:47:19 +0000 (GMT)
Message-ID: <bb0f18f5-f89a-485a-aa16-f4cd181844c3@linux.ibm.com>
Date: Wed, 6 Aug 2025 11:17:17 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/2] block: clear QUEUE_FLAG_QOS_ENABLED in rq_qos_del()
To: Yu Kuai <yukuai1@huaweicloud.com>, linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, axboe@kernel.dk, hch@lst.de, kch@nvidia.com,
        shinichiro.kawasaki@wdc.com, gjoyce@ibm.com,
        "yukuai (C)"
 <yukuai3@huawei.com>
References: <20250805171749.3448694-1-nilay@linux.ibm.com>
 <20250805171749.3448694-3-nilay@linux.ibm.com>
 <4e13ce83-51a7-488e-e7ca-eadb431ff001@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <4e13ce83-51a7-488e-e7ca-eadb431ff001@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NInV+16g c=1 sm=1 tr=0 ts=6892ec6d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=f29z-scoVRnLdkZf2FsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6FFJ8jjYMF1owXDblOWzTFJl9REURI_D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAzMCBTYWx0ZWRfX453lxbY1ckOA
 UXJoP7R5ubwWwEoIY0qxBNkhl/g7rKpd3J6wYVrNEeYbLGdI2bUJ78H/IzAvQ4sR1BvNTofPNMi
 luDWNTffz3mdXgOvmc8329vSZExwAqceePf6/ergMhK5TFwfRRFB08ZO0wAEqXcpCQswY7xv0nQ
 v6kB52LoXbu3KW1nnLXXBRCwoqIkp+HFup6ulDl4RmqRRvffY2FEQ9DVCYTOY9E0ZVWtWcRhlcw
 K7Kb9tZocKDy/lNu1UA5Qx+Jk4anNeozKo8Cgj+3Y/NJuJUD0KMSFKPXcIbLHLNxQBPKZne7CxH
 MrsucKUcOUVii8kM1HagLQmX+VvCt59TAkAjPsIlk5uLuGw8TxVx6MOQPrCZHR4306texfkyfa4
 yu0wdnjED3bXDQ17Nnhnel+c4ZwLi9iR9jirAaPd1E5zpwAEWRJaYnjtgskV2s/cxtHI0XSi
X-Proofpoint-ORIG-GUID: 6FFJ8jjYMF1owXDblOWzTFJl9REURI_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060030



On 8/6/25 6:55 AM, Yu Kuai wrote:
> Hi,
> 
> 在 2025/08/06 1:17, Nilay Shroff 写道:
>> When a QoS function is removed via rq_qos_del(), and it happens to be the
>> last QoS function on the request queue, q->rq_qos becomes NULL. In this
>> case, the QUEUE_FLAG_QOS_ENABLED bit should also be cleared to reflect
>> that no QoS hooks remain active.
>>
>> This patch ensures that the QUEUE_FLAG_QOS_ENABLED flag is cleared if the
>> queue no longer has any associated rq_qos policies. Failing to do so
>> could cause unnecessary dereferences of a now-null q->rq_qos pointer in
>> the I/O path.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   block/blk-rq-qos.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
> There is no fixtag, and can be missing during backport easily.
> 
> I feel it's better to fix missing static_branch_dec() in rq_qos_del()
> first, and then fix the deadlock problem.
> 
Yes makes sense, will do it in v3. But again lets wait for Jens and Ming
in case they have any further comment.

Thanks,
--Nilay
