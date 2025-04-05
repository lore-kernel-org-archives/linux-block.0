Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966B382D98
	for <linux-block@vger.kernel.org>; Sat,  5 Apr 2025 14:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743862473; cv=none; b=K8dRsiNUpfPK6tcHdjfDOagqN8N4P/nFpeBOaFnx4BHir0aeiC3KRjQh5Xlkd+U3mNPJ4HBVE68Rqg31X2JAWJqVp/HszeiwAyUNM8BJWQSS/NFeNJJCxy5KXGyhEwDkWHjTL1Zi+ctJH4Y/aZmQpFxrxT3vTi8JRz3gps33t6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743862473; c=relaxed/simple;
	bh=b1I6rmTg9hNRVbf1MEX9Jx8pUWhs3Ji34lc8PVkA+g0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZufNGgGBrYF9/BnqjwcofveiE1l4/xeZbbwtEbfVV1Kdtl38dCYJfunqBmDIZoQfGgksMuJI0Ma4ihwABg+2Z0EiRclzxKYFhZdrbFsSPaQcrulvHY52tRB4nyWg7BUcGTNOV/2saQ/iQG5SqMSye65uod9HfcnITCMF8siNK+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AZf3BaLf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AZf3BaLf"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5359uxFL007879;
	Sat, 5 Apr 2025 14:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oXZovq
	GCegoB/hLaD8odZXAxhHMcIZ7A1+rWLxLs3cU=; b=AZf3BaLfY+nLdY1mBKpV6W
	zjOomko0SrQvRO3RbQGZ4Hu6oJoq8znH8+dTZnWddLw3LQYSI+97TlUQHIkLrxnO
	9cuu5Rz4ushWQK0hLa84qBdo4plDeJv4Pcq01ucYXSz1OjLzRq2wGnU6/0gae7WQ
	Iu0YkvDZyPnhOxdIc2VzXhEsP5ELOgQmqHpzgQRmVFGKF0Gl3GzP3LCSTksttsov
	MLwolt9gjwrwEdniba6w+psCZ9SsHebb4Nqr4XruWH9ahG2F0SELsFhuj/BqBlZx
	q5/u4QauQ6mviJsA1n4FdvMU6Mc2RJd88SL9u3E2+cI4d/lGrUHAL74h9tyIIwJQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45tv5xhnf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Apr 2025 14:14:25 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 535Adc7e021614;
	Sat, 5 Apr 2025 14:14:24 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45t2e7fmgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Apr 2025 14:14:24 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 535EEOY67340744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 5 Apr 2025 14:14:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6A455805B;
	Sat,  5 Apr 2025 14:14:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85B4558059;
	Sat,  5 Apr 2025 14:14:21 +0000 (GMT)
Received: from [9.171.30.151] (unknown [9.171.30.151])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  5 Apr 2025 14:14:21 +0000 (GMT)
Message-ID: <92feba7e-84fc-4668-92c3-aba4e8320559@linux.ibm.com>
Date: Sat, 5 Apr 2025 19:44:19 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: don't grab elevator lock during queue
 initialization
To: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        syzbot+4c7e0f9b94ad65811efb@syzkaller.appspotmail.com
References: <20250403105402.1334206-1-ming.lei@redhat.com>
 <20250404091037.GB12163@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250404091037.GB12163@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: krpVYNitDAC6sryYMb3U0SAQD25X_96r
X-Proofpoint-GUID: krpVYNitDAC6sryYMb3U0SAQD25X_96r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-05_06,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504050087



On 4/4/25 2:40 PM, Christoph Hellwig wrote:
> On Thu, Apr 03, 2025 at 06:54:02PM +0800, Ming Lei wrote:
>> Fixes the following lockdep warning:
> 
> Please spell the actual dependency out here, links are not permanent
> and also not readable for any offline reading of the commit logs.
> 
>> +static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
>> +				   struct request_queue *q, bool lock)
>> +{
>> +	if (lock) {
> 
> bool lock(ed) arguments are an anti-pattern, and regularly get Linus
> screaming at you (in this case even for the right reason :))
> 
>> +		/* protect against switching io scheduler  */
>> +		mutex_lock(&q->elevator_lock);
>> +		__blk_mq_realloc_hw_ctxs(set, q);
>> +		mutex_unlock(&q->elevator_lock);
>> +	} else {
>> +		__blk_mq_realloc_hw_ctxs(set, q);
>> +	}
> 
> I think the problem here is again that because of all the other
> dependencies elevator_lock really needs to be per-set instead of
> per-queue which will allows us to have much saner locking hierarchies.
> 
I believe you meant here q->tag_set->elevator_lock? 
If yes then it means that we should be able to grab ->elevator_lock
before freezing the queue in __blk_mq_update_nr_hw_queues and so locking
order should be in each code path,

__blk_mq_update_nr_hw_queues
    ->elevator_lock 
      ->freeze_lock
or 
blk_register_queue
    ->elevator_lock 
      -> fs_reclaim (GFP_KERNEL)
       -> freeze_lock

Other code paths using ->elevator_lock and ->freeze_lock shall be 
updated accordingly.

Thanks,
--Nilay
