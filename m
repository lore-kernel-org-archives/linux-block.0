Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F83415853B
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 11:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741777457; cv=none; b=KyBmkV/GdTu0uad8PD63ly7YnSkc8NrXvoDhTn/VaGNItRgrgSGBBs0JZ5KtvMh0Zqy6jHsqKbWof0X2v2+R99WzBe2b4AaG42MYPC1jwsYmLlfhaQqAJQK4wIEQ/oHWZ/a4+Ta2XvgadUc2WNlLOr8RmDIWQ+eJP3X5o6kNJGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741777457; c=relaxed/simple;
	bh=4C4iRr3T0+74BsUDPaSyrWPUEQ24VSingCdBNtmvW8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sFOjt2zFKDn7eWfz4QvuqTJvD5iAAI/WKi+ecgxm+mRQX6yFCN03vP5IV2QYG+4QBo7TL7ZsiBVdqXECqwl3qt8chAdVaR2b0hDZlfawlsEPMAXxyv/aRugNAZUHVjfyaZpx4F1tIgmSrxFMdPtJPUzmmit8Vxntibt/iH7wYl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fJwutQI8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fJwutQI8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C7vFBx008933;
	Wed, 12 Mar 2025 11:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OJbuRb
	sm7HHXQV55QRzEjofgE7f0i2216AeFDKox+Yc=; b=fJwutQI8Ndsbsc1q0n9c5I
	bu4kZZK1gTstl6V1Baktaed6uuO6GpJfuhcMcpL6oW6YWoFhXE2uDoYKY5Sadfdv
	I9ppGP7CLFxkkxGhr5D1IqjyweM37BhN0DZnaYx0GmtH/Jhtbe5RU9QmO8lKnn9M
	XvYOmRpYLR2/oNz8Ln/4oNDb3HvO87yAXABzMXs15oEtFOWoxmmzYhh42o1tqfIN
	Q2UPquLVLIFtTTAs6LxlUCo4Ogg0P/rXqtF24PLUPGAKRS56QLjRPNOoq1biIRvt
	O5tm7nENZQs88nJ9Fdt86JWEkE0tEhChWngHCkl4Lu0/vSVoADfJI3kFHjvV4fBQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45avk4b9fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 11:04:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52CAGPeY027072;
	Wed, 12 Mar 2025 11:04:00 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsqupq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 11:04:00 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52CB3xtQ45482460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 11:03:59 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6284158081;
	Wed, 12 Mar 2025 11:03:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 439EF5808B;
	Wed, 12 Mar 2025 11:03:57 +0000 (GMT)
Received: from [9.61.69.177] (unknown [9.61.69.177])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Mar 2025 11:03:56 +0000 (GMT)
Message-ID: <d7e0fd74-b5be-4327-8753-18a9109c14cf@linux.ibm.com>
Date: Wed, 12 Mar 2025 16:33:55 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: protect debugfs attributes using q->elevator_lock
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, axboe@kernel.dk,
        gjoyce@ibm.com
References: <20250312102903.3584358-1-nilay@linux.ibm.com>
 <3e26b52a-0bc7-438d-8ae4-29ac27268cad@kernel.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <3e26b52a-0bc7-438d-8ae4-29ac27268cad@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ahRuBIINuQY1wSdKd6HGSOl503vBfZLg
X-Proofpoint-GUID: ahRuBIINuQY1wSdKd6HGSOl503vBfZLg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_04,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503120076



On 3/12/25 4:21 PM, Damien Le Moal wrote:
> On 3/12/25 19:28, Nilay Shroff wrote:
>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>> index adf5f0697b6b..d26a6df945bd 100644
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -347,11 +347,16 @@ static int hctx_busy_show(void *data, struct seq_file *m)
>>  {
>>  	struct blk_mq_hw_ctx *hctx = data;
>>  	struct show_busy_params params = { .m = m, .hctx = hctx };
>> +	int res;
>>  
>> +	res = mutex_lock_interruptible(&hctx->queue->elevator_lock);
>> +	if (res)
>> +		goto out;
> 
> There is no need for the goto here. You can "return res;" directly.
> Same comment for all the other changes below.
> 
>>  	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy_rq,
>>  				&params);
>> -
>> -	return 0;
>> +	mutex_unlock(&hctx->queue->elevator_lock);
>> +out:
>> +	return res;
> 
> And you can keep the "return 0;" here.
> 
Yes I agree. And in fact, that's how exactly I initially prepared the patch 
however later I saw that other places in this file where we use mutex_lock_
interruptible(), we use goto when acquiring the lock fails and so I changed 
it here to match those other occurrences. So if everyone prefer, shall I use
your suggested pattern at other places as well in this file?

>>  
>>  
>>  static const char *const hctx_types[] = {
>> @@ -400,12 +405,12 @@ static int hctx_tags_show(void *data, struct seq_file *m)
>>  	struct request_queue *q = hctx->queue;
>>  	int res;
>>  
>> -	res = mutex_lock_interruptible(&q->sysfs_lock);
>> +	res = mutex_lock_interruptible(&q->elevator_lock);
>>  	if (res)
>>  		goto out;
>>  	if (hctx->tags)
>>  		blk_mq_debugfs_tags_show(m, hctx->tags);
>> -	mutex_unlock(&q->sysfs_lock);
>> +	mutex_unlock(&q->elevator_lock);
>>  
>>  out:
>>  	return res;
>> @@ -417,12 +422,12 @@ static int hctx_tags_bitmap_show(void *data, struct seq_file *m)
>>  	struct request_queue *q = hctx->queue;
>>  	int res;
>>  
>> -	res = mutex_lock_interruptible(&q->sysfs_lock);
>> +	res = mutex_lock_interruptible(&q->elevator_lock);
>>  	if (res)
>>  		goto out;
>>  	if (hctx->tags)
>>  		sbitmap_bitmap_show(&hctx->tags->bitmap_tags.sb, m);
>> -	mutex_unlock(&q->sysfs_lock);
>> +	mutex_unlock(&q->elevator_lock);
>>  
>>  out:
>>  	return res;
>> @@ -434,12 +439,12 @@ static int hctx_sched_tags_show(void *data, struct seq_file *m)
>>  	struct request_queue *q = hctx->queue;
>>  	int res;
>>  
>> -	res = mutex_lock_interruptible(&q->sysfs_lock);
>> +	res = mutex_lock_interruptible(&q->elevator_lock);
>>  	if (res)
>>  		goto out;
>>  	if (hctx->sched_tags)
>>  		blk_mq_debugfs_tags_show(m, hctx->sched_tags);
>> -	mutex_unlock(&q->sysfs_lock);
>> +	mutex_unlock(&q->elevator_lock);
>>  
>>  out:
>>  	return res;
>> @@ -451,12 +456,12 @@ static int hctx_sched_tags_bitmap_show(void *data, struct seq_file *m)
>>  	struct request_queue *q = hctx->queue;
>>  	int res;
>>  
>> -	res = mutex_lock_interruptible(&q->sysfs_lock);
>> +	res = mutex_lock_interruptible(&q->elevator_lock);
>>  	if (res)
>>  		goto out;
>>  	if (hctx->sched_tags)
>>  		sbitmap_bitmap_show(&hctx->sched_tags->bitmap_tags.sb, m);
>> -	mutex_unlock(&q->sysfs_lock);
>> +	mutex_unlock(&q->elevator_lock);
>>  
>>  out:
>>  	return res;
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 22600420799c..709a32022c78 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -568,9 +568,9 @@ struct request_queue {
>>  	 * nr_requests and wbt latency, this lock also protects the sysfs attrs
>>  	 * nr_requests and wbt_lat_usec. Additionally the nr_hw_queues update
>>  	 * may modify hctx tags, reserved-tags and cpumask, so this lock also
>> -	 * helps protect the hctx attrs. To ensure proper locking order during
>> -	 * an elevator or nr_hw_queue update, first freeze the queue, then
>> -	 * acquire ->elevator_lock.
>> +	 * helps protect the hctx sysfs/debugfs attrs. To ensure proper locking
>> +	 * order during an elevator or nr_hw_queue update, first freeze the
>> +	 * queue, then acquire ->elevator_lock.
>>  	 */
>>  	struct mutex		elevator_lock;
>>  

Thanks,
--Nilay
 


