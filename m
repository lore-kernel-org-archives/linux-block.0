Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AE71F4CA4
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 06:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745302515; cv=none; b=tDy3tuCWb69LYbAmIlJflGsu60moDP8lZ+k5OqfrDsupeUHYlRdaIprs10b+SsYVq0KRGINVed5GfqRk0J56Wj5kI1BRtC+c6MoHXUgPLeUZ9l0viEvBCnFLlXH0GWKSeWBAJF3rLTzgZOsVmEEvCaML94dUQw1zk+xhebg1d6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745302515; c=relaxed/simple;
	bh=Vs466jqbndUc0mgUrmOx51Sc4REMNetoxGTPotNGKwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LaUGemov4o5jONlep0IfUaXsIueLi65uPROXeO+WbWlbTiTAdupaf6pOBcS5y6sWDLZXQO+Hp3E3Wd7D5qsSccFkRwMGem8ilYsDXB4LgcDftoxJI0tjAhu14y6Wvnf1LGRlfOBYQMA1x/iw3i1y2qB2jGFCWoNonQxrISMaskg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SjZ/qIRj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SjZ/qIRj"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53LLgF9u028919;
	Tue, 22 Apr 2025 06:15:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9Uyt5S
	9YuMrNuCeTjbDdv/S27ehim1Ww3Yo3aONzfvQ=; b=SjZ/qIRjiFwUVtsEdWvGIW
	ALPmMmVwelECzCwxofbdOvUaDuqY9cGmun3/dyBuOesH3OrKg/EP4n/MMv2SFs2B
	rj3LjwJPDH+3AD4Ic23YxJRzQ7w6Iz24J+ns2bLh00y5m36Rig3VH1T3XCJ/bWly
	d9KgQZYjlEeA+w2vcLnFzB0SWUb6ToCej/oCvZhtrlVGpGnjeicedoEWBaxbaoQ1
	YqN3Alf+YsqLsM7CNCCXcDrVavigbl5noYN41KSz6rWFlXsp2o18SXUJPKYovb31
	O6rftGjLZ2CHnk5NNHnJMpIeaf99oANA/0IahAOs7BwI9VI3YW7bhShYtPZGNSEQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 465x5vsff2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 06:15:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53M5Go0x012490;
	Tue, 22 Apr 2025 06:15:05 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 464p5t1rwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 06:15:05 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53M6F4T513370058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 06:15:04 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 658CD5806D;
	Tue, 22 Apr 2025 06:15:04 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58CB85805A;
	Tue, 22 Apr 2025 06:15:01 +0000 (GMT)
Received: from [9.43.46.43] (unknown [9.43.46.43])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Apr 2025 06:15:00 +0000 (GMT)
Message-ID: <286f9d0e-b782-4062-b0eb-cba6fa81e388@linux.ibm.com>
Date: Tue, 22 Apr 2025 11:44:59 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 20/20] block: move wbt_enable_default() out of queue
 freezing from sched ->exit()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-21-ming.lei@redhat.com>
 <261d7b81-e611-47f4-ad55-6f7716c278c7@linux.ibm.com>
 <aAXzToqtIlAoUP7t@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aAXzToqtIlAoUP7t@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -7PU0W34OrjwfKqQGHq_F5-L8oLsyIr9
X-Proofpoint-ORIG-GUID: -7PU0W34OrjwfKqQGHq_F5-L8oLsyIr9
X-Authority-Analysis: v=2.4 cv=CuO/cm4D c=1 sm=1 tr=0 ts=680733ea cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=wgIqA3w2QWIHfQYZNoAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_03,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220045



On 4/21/25 12:57 PM, Ming Lei wrote:
> On Sat, Apr 19, 2025 at 08:09:04PM +0530, Nilay Shroff wrote:
>>
>>
>> On 4/18/25 10:07 PM, Ming Lei wrote:
>>> scheduler's ->exit() is called with queue frozen and elevator lock is held, and
>>> wbt_enable_default() can't be called with queue frozen, otherwise the
>>> following lockdep warning is triggered:
>>>
>>> 	#6 (&q->rq_qos_mutex){+.+.}-{4:4}:
>>> 	#5 (&eq->sysfs_lock){+.+.}-{4:4}:
>>> 	#4 (&q->elevator_lock){+.+.}-{4:4}:
>>> 	#3 (&q->q_usage_counter(io)#3){++++}-{0:0}:
>>> 	#2 (fs_reclaim){+.+.}-{0:0}:
>>> 	#1 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}:
>>> 	#0 (&q->debugfs_mutex){+.+.}-{4:4}:
>>>
>>> Fix the issue by moving wbt_enable_default() out of bfq's exit(), and
>>> call it from elevator_change_done().
>>>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>  block/bfq-iosched.c | 2 +-
>>>  block/elevator.c    | 5 +++++
>>>  block/elevator.h    | 1 +
>>>  3 files changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>>> index 40e4106a71e7..310ce1d8c41e 100644
>>> --- a/block/bfq-iosched.c
>>> +++ b/block/bfq-iosched.c
>>> @@ -7211,7 +7211,7 @@ static void bfq_exit_queue(struct elevator_queue *e)
>>>  
>>>  	blk_stat_disable_accounting(bfqd->queue);
>>>  	blk_queue_flag_clear(QUEUE_FLAG_DISABLE_WBT, bfqd->queue);
>>> -	wbt_enable_default(bfqd->queue->disk);
>>> +	set_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT, &e->flags);
>>>  
>>>  	kfree(bfqd);
>>>  }
>>> diff --git a/block/elevator.c b/block/elevator.c
>>> index 8652fe45a2db..378553fce5d8 100644
>>> --- a/block/elevator.c
>>> +++ b/block/elevator.c
>>> @@ -687,8 +687,13 @@ int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx)
>>>  	int ret = 0;
>>>  
>>>  	if (ctx->old) {
>>> +		bool enable_wbt = test_bit(ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT,
>>> +				&ctx->old->flags);
>>> +
>>>  		elv_unregister_queue(q, ctx->old);
>>>  		kobject_put(&ctx->old->kobj);
>>> +		if (enable_wbt)
>>> +			wbt_enable_default(q->disk);
>>>  	}
>>>  	if (ctx->new) {
>>>  		ret = elv_register_queue(q, ctx->new, ctx->uevent);
>>> diff --git a/block/elevator.h b/block/elevator.h
>>> index 486be0690499..b14c611c74b6 100644
>>> --- a/block/elevator.h
>>> +++ b/block/elevator.h
>>> @@ -122,6 +122,7 @@ struct elevator_queue
>>>  
>>>  #define ELEVATOR_FLAG_REGISTERED	0
>>>  #define ELEVATOR_FLAG_DYING		1
>>> +#define ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT	2
>>>  
>>>  /* Holding context data for changing elevator */
>>>  struct elv_change_ctx {
>>
>> It seems invoking wbt_enable_default from elevator_change_done could probably
>> still race with ioc_qos_write or queue_wb_lat_store. Both ioc_qos_write and 
>> queue_wb_lat_store run with ->freeze_lock and ->elevator_lock protection.
> 
> Actually wbt_enable_default() and wbt_init() needn't the above protection,
> especially since the patch 2/20 removes q->elevator use in
> wbt_enable_default().
> 
Yes agreed, and as I understand XXX_FLAG_DISABLE_WBT was earlier elevator_queue->flags 
but now (with patch 2/20) it has been moved to request_queue->flags. As elevator_change_done 
first puts elevator_queue object which would potentially releases/frees the  elevator_queue 
object. Next while we enable wbt (in elevator_change_done)  we may not have access to the 
elevator_queue object and so now we reference  QUEUE_FLAG_DISABLE_WBT using request_queue->flags. 
That's, I believe, the purpose of patch 2/20.

However even with patch 2/20 change, both elevator_change_done and ioc_qos_write or
queue_wb_lat_store may run in parallel, isn't it?

therad1:
blk_mq_update_nr_hw_queues
  -> __blk_mq_update_nr_hw_queues
    -> elevator_change_done
      -> wbt_enable_default
        -> wbt_init
         -> wbt_update_limits

therad2:
queue_wb_lat_store
  -> wbt_set_min_lat
   -> wbt_update_limits

Thanks,
--Nilay


 
