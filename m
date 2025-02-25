Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E10266562
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740478720; cv=none; b=sO5Eu4vX7tk6cZ4o+Xu2nzV63gEe8VepdjpAT21T6iruH+6wRaK7deC76UjhfMnAb/5w697JCLenTktQTPj9ZfjxBggvm9nqJUZAFq8dL4iwdUZ8wPRXtaG1LdjYHj3Gm0Y2Qi1q1CzmoikEjKZIWlcHV5lanB2+oe/7VfKEOsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740478720; c=relaxed/simple;
	bh=HZStv4nFJL+GC7BkP7OKumlPpM8azqypUtumzCoy+ZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExlkhExQRxqO8PjQoNouVI4wFp6FRKUTRaD7rTYY+t6+Y1paSepdP5JlUfqWxyXH3K3FVeh7WED6o2KOBWmAasyGaIy/DbP6DnvIHAxmEwlfcsVN4egiDlh53jE/pdY08DSwPnD59CT7l6m918FG3FCrkwclSTxzpIXYL0CxRWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B98E23lA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B98E23lA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P18mhS011408;
	Tue, 25 Feb 2025 10:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=awMLli
	djEFsZPkfYqxmNMZPxo6yzcDF9ROT/Pp2IhFk=; b=B98E23lA/Ox5I9T5JKXsmX
	B5iFWM3IyRn1LaNreWzkdHNPCIkXvu+/q2Sevia3amYe5Zn3R98zoxTrLO4bbfg3
	FIgzngLemPr25Z7qwBwQEeViWX9PsuXztViwnsD6A/ohygXL0o45D2rLIzb5pfF0
	zGcRGxp5zTZWRV0elSF7nmaVvW2ZEQnGYbZrHEMWSsnKpgathOCt+8eu2Fve9agQ
	6iTFCpPqfrmysR4wzprvU5r0+qfgQRBlREp/9zl0RoQIl7cLJa4kCzK0zooJtZgn
	qfhmTj3+MCwGZ60Fz1ioziBckjQUcAZFa19BcalZX3NKQhHl9JgRv0narhJHEGxw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4513x9t2hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 10:18:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7P62M027390;
	Tue, 25 Feb 2025 10:18:26 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdkc4ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 10:18:26 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51PAIPZL22479590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 10:18:25 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F39158056;
	Tue, 25 Feb 2025 10:18:25 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1849658067;
	Tue, 25 Feb 2025 10:18:23 +0000 (GMT)
Received: from [9.61.156.112] (unknown [9.61.156.112])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 10:18:22 +0000 (GMT)
Message-ID: <14742723-0699-4bf1-8dae-c0b9dd077c76@linux.ibm.com>
Date: Tue, 25 Feb 2025 15:48:21 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 7/7] block: protect read_ahead_kb using q->limits_lock
To: Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, dlemoal@kernel.org, axboe@kernel.dk,
        gjoyce@ibm.com
References: <20250224133102.1240146-1-nilay@linux.ibm.com>
 <20250224133102.1240146-8-nilay@linux.ibm.com>
 <4e1feba0-e4c4-44fa-a6fa-437a927dbd60@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <4e1feba0-e4c4-44fa-a6fa-437a927dbd60@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eT8F-XGVmOJ27q0HXrmZpq6Cny6ZLyFw
X-Proofpoint-GUID: eT8F-XGVmOJ27q0HXrmZpq6Cny6ZLyFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502250069



On 2/25/25 1:28 PM, Hannes Reinecke wrote:
> On 2/24/25 14:30, Nilay Shroff wrote:
>> The bdi->ra_pages could be updated under q->limits_lock because it's
>> usually calculated from the queue limits by queue_limits_commit_update.
>> So protect reading/writing the sysfs attribute read_ahead_kb using
>> q->limits_lock instead of q->sysfs_lock.
>>
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>> ---
>>   block/blk-sysfs.c | 16 ++++++++++------
>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index 8f47d9f30fbf..228f81a9060f 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -93,9 +93,9 @@ static ssize_t queue_ra_show(struct gendisk *disk, char *page)
>>   {
>>       ssize_t ret;
>>   -    mutex_lock(&disk->queue->sysfs_lock);
>> +    mutex_lock(&disk->queue->limits_lock);
>>       ret = queue_var_show(disk->bdi->ra_pages << (PAGE_SHIFT - 10), page);
>> -    mutex_unlock(&disk->queue->sysfs_lock);
>> +    mutex_unlock(&disk->queue->limits_lock);
>>         return ret;
>>   }
>> @@ -111,12 +111,15 @@ queue_ra_store(struct gendisk *disk, const char *page, size_t count)
>>       ret = queue_var_store(&ra_kb, page, count);
>>       if (ret < 0)
>>           return ret;
>> -
>> -    mutex_lock(&q->sysfs_lock);
>> +    /*
>> +     * ->ra_pages is protected by ->limits_lock because it is usually
>> +     * calculated from the queue limits by queue_limits_commit_update.
>> +     */
>> +    mutex_lock(&q->limits_lock);
>>       memflags = blk_mq_freeze_queue(q);
>>       disk->bdi->ra_pages = ra_kb >> (PAGE_SHIFT - 10);
>> +    mutex_unlock(&q->limits_lock);
>>       blk_mq_unfreeze_queue(q, memflags);
>> -    mutex_unlock(&q->sysfs_lock);
>>   
> 
> Cf my comments to the previous patch: Ordering.
> 
> Here we take the lock _before_ 'freeze', with the previous patch we took
> the lock _after_ 'freeze'.
> Why?
> 
Yes this is ->limits_lock which is different from ->elevator_lock. The ->limits_lock
is used by atomic update APIs queue_limits_start_update() and helpers. Here, the
order we follow is : acquire ->limits_lock followed by queue-freeze. 

So even here in sysfs attribute store method we follow the same locking order.

Thanks,
--Nilay



