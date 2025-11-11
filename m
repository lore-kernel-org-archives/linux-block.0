Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A712741B5
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762843924; cv=none; b=AuJ3LHXDxVXppenAcLxum66AXktFM6ynOdJTdI6/G1FNudzIGEqhwk7+iYOxC1Icvato7jEWKFfr5EnidZ8WujMiYccnKqDhbIpCI4M2t/UYslOKKO3zVqHwwVUt1Mc99NIQ2M+kWXPhhPyR4vF3hFkqsBn7nHK+RyFGqyly0Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762843924; c=relaxed/simple;
	bh=Yc7MHSUV4f3N8G6xKf8hpFiGo23Yx8jWAdSsOE3PXtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rjbHyLYyiGAlglWdbJMhPTPI+P5yXFJztaN25dcidJxP4QmezIBez19VqgK3mcR2XJJNFrpxxfSp5VES8g3U2orIjGISggaL6ZIBPMe3cqY88uvavnxZ8S3DC+pbeSQXr5rvdR4CO3hIXI/8kkqJkv4WkJQKqeRx0WjKnsCtXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WxkVP9I+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WxkVP9I+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB2xX78023600;
	Tue, 11 Nov 2025 06:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=riWRYG
	LjX5UZdxGhnzwN6i3D9/lHB9OLw/+Njw3nTXg=; b=WxkVP9I+vPZ6OOvEfAgNaJ
	ddU0wQwA9/swvqusbgMbjEkf3bC1WD1wM4l6sHMo7QncWSCa3JGqdDBSUrLSXjc1
	uT/pJG3VVcfj1tyGEa+h+imorK7GOoCyWeKA2PsIO348Z1oRPzH7CDddaf+lUOzN
	vcmCLy3OeRdvQozE08iOIqtR5m6FTHWbPKOGA+oWWJk/srHie/0ZfhsJR/J9Ywze
	eohdGQD+okt/2CnS9cR8cKCPbQjpI5nUOW1YaASNTAlvjJklA8aQ91xwn6LKDgB5
	UHtGJQDg2cN0GLqAqprZQ1r+EIhF3JE7nUqSdcaURQqj2gRGckiB1GidH+vAMCig
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjsk53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 06:51:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5Gl03011431;
	Tue, 11 Nov 2025 06:51:44 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1977b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 06:51:44 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AB6phoP10617478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 06:51:44 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5CAB5804E;
	Tue, 11 Nov 2025 06:51:43 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4F3A5803F;
	Tue, 11 Nov 2025 06:51:40 +0000 (GMT)
Received: from [9.109.198.139] (unknown [9.109.198.139])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Nov 2025 06:51:40 +0000 (GMT)
Message-ID: <55bc6e4c-a168-4b27-9426-f9af8193e53e@linux.ibm.com>
Date: Tue, 11 Nov 2025 12:21:39 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 4/5] block: use {alloc|free}_sched data methods
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
        yi.zhang@redhat.com, czhong@redhat.com, yukuai@fnnas.com,
        gjoyce@ibm.com
References: <20251110081457.1006206-1-nilay@linux.ibm.com>
 <20251110081457.1006206-5-nilay@linux.ibm.com> <aRKmbtp0J_VPH4v9@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aRKmbtp0J_VPH4v9@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zUdwbhYjtrDmuLp0XxtF5UwzC1TvCLJC
X-Proofpoint-ORIG-GUID: zUdwbhYjtrDmuLp0XxtF5UwzC1TvCLJC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX0oUWKXqMEjQ6
 qdVMSWMApnI0HXIWSa2D/R21dDB8DA/tUHQ90nziISKQ9t2JW++v8xjk2s7DxxpdbDJn45N7Wep
 HYOgaQlwcWIvPfvAn/Hf/8wz+zCG/Pg8hHP2QRJN2t78dBJqeZlH5riBRS3j3NFtzu0zEXiX7GZ
 3Ao5Rc/49OoQeSZ418UpYn9CtdULjoqof9EpAOvtabLtGZpZhyGqLd0m43CmiJpQmRfwFQFU5ot
 OL9JTsKV9LMeSsS2KtXxUdimwG7IlD6Czx4gmcA/Jn8cKTWYxPrLs7qCKSRUb7B66/obHn46Aty
 6YJKFKCSCa/QF9mOwqKwJds/x+36xQCSTKLabXJ8ZKNgFiOeixDjG392c9kRkJ86Ut7V60AeBdD
 xfZeuaWV+3ayL1XC5WpxBDRwtCVHqA==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=6912dd05 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=A3BirtSH8K4zbbwC25AA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099



On 11/11/25 8:28 AM, Ming Lei wrote:
>> @@ -540,15 +545,24 @@ struct elevator_tags *blk_mq_alloc_sched_tags(struct blk_mq_tag_set *set,
>>  	return NULL;
>>  }
>>  
>> -int blk_mq_alloc_sched_res(struct elevator_resources *res,
>> -		struct blk_mq_tag_set *set, unsigned int nr_hw_queues)
>> +int blk_mq_alloc_sched_res(struct request_queue *q,
>> +		struct elevator_type *type,
>> +		struct elevator_resources *res,
>> +		struct blk_mq_tag_set *set,
>> +		unsigned int nr_hw_queues)
> As mentioned, `struct request_queue *q` parameter can be added from
> beginning, then `struct blk_mq_tag_set *set` can be avoided.
> 
> Otherwise, this patch looks fine.

Ack, will address this in the next patch.

Thanks,
--Nilay
