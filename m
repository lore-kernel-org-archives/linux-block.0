Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57DB277020
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 11:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745320013; cv=none; b=FQ0ElaaApEAGy28sObZ8PND9nXnxUAMzoe5fn1j86Ke4sqDUDb7u9CV7zPTLnJpwB/gSGJYHcEF1xcRGtDMwMkY1fBwd3+ijtmaPHBTZyIkGOAms5IAp1jzyHQ0foNx7uf4iyu8vmIQ7JTMVmQ8r6aJv7Jb+3JcR6UePopQHKaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745320013; c=relaxed/simple;
	bh=BQ8GpN+uefifPaE3S5/pBVVKxRn+uWFyjikWCAZogKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AI4Ucr8kp42XUj1jcFpCxwQIxk3+yDf+Cnzz4BtQRk2LGxBtEnGi3M1Xk0V5G9kzdBbDxuyefMDFQKCj/oSmPlor83H4BKTPSc14odBTfKZWBPzMKANOaYpyowq+sXPjlpDQvltUMd5rnfVMybx+lBpPDudnZUmTPbCZyhCgRrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LNKOQjog; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LNKOQjog"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M87Hxd014060;
	Tue, 22 Apr 2025 11:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SSvEKn
	9BUHsDg2vQPIku7CHXiimX8VfZ/l4/PtbFQas=; b=LNKOQjogWs+3zD+7E/YekB
	chnY0ZBQBsDdXKfdB3aVFk+3RKN6b02GXvH17pc/FWZp4byrMgUMjFQOFubQNUT0
	wGgkT+SsAm4KxQC3TjbClweQGBZkdLoadMotQixDbAk9MErHklWcIFjHwLKv7s3H
	RfuwUkNceBkyDJ2B8tMh9Zuxd3S1EaPhz0/iPa80AMS0QH72nzYT4UBAi62BV7Yt
	ch5cCGnRVqd1FMFX+hzW89L/YrU+Jz8AovY1gQmt8eumIrutKkqE04lSP4iEZYo8
	8DTXWAXe/Ec/KvtS7pgszpUlXfJbK0Z24p42Ex29zxCWDXe51mg+Gv0Rwkg6Qhmg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4667ap0v13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 11:06:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53MAT9GO012575;
	Tue, 22 Apr 2025 11:06:42 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 464p5t2rqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 11:06:42 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53MB6g9523069196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 11:06:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3349958062;
	Tue, 22 Apr 2025 11:06:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C71258061;
	Tue, 22 Apr 2025 11:06:39 +0000 (GMT)
Received: from [9.43.46.43] (unknown [9.43.46.43])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Apr 2025 11:06:39 +0000 (GMT)
Message-ID: <9455fce4-3296-449b-a828-2696e2e17b16@linux.ibm.com>
Date: Tue, 22 Apr 2025 16:36:37 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 16/20] block: move elv_register[unregister]_queue out
 of elevator_lock
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-17-ming.lei@redhat.com>
 <9d15a519-c0bb-492f-9602-f3840b85dbe1@linux.ibm.com>
 <aAd1PnHtnT6jTZFE@fedora>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aAd1PnHtnT6jTZFE@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5pNKzws c=1 sm=1 tr=0 ts=68077843 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=bU1eoOUvIo09NjXHUxEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: W1m2LLiF-NY-QSzWeQpTalVSsHzw8FQy
X-Proofpoint-GUID: W1m2LLiF-NY-QSzWeQpTalVSsHzw8FQy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220083



On 4/22/25 4:23 PM, Ming Lei wrote:
> On Sat, Apr 19, 2025 at 07:25:31PM +0530, Nilay Shroff wrote:
>>
>>
>> On 4/18/25 10:06 PM, Ming Lei wrote:
>>> Move elv_register[unregister]_queue out of ->elevator_lock & queue freezing,
>>> so we can kill many lockdep warnings.
>>>
>>> elv_register[unregister]_queue() is serialized, and just dealing with sysfs/
>>> debugfs things, no need to be done with queue frozen.
>>>
>>> With this change, elevator's ->exit() is called before calling
>>> elv_unregister_queue, then user may call into ->show()/store() of elevator's
>>> sysfs attributes, and we have covered this issue by adding `ELEVATOR_FLAG_DYNG`.
>>>
>>> For blk-mq debugfs, hctx->sched_tags is always checked with ->elevator_lock by
>>> debugfs code, meantime hctx->sched_tags is updated with ->elevator_lock, so
>>> there isn't such issue.
>>>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>  block/blk-mq.c   |  9 ++++----
>>>  block/blk.h      |  1 +
>>>  block/elevator.c | 58 ++++++++++++++++++++++++++++++++++--------------
>>>  block/elevator.h |  5 +++++
>>>  4 files changed, 52 insertions(+), 21 deletions(-)
>>>
>>
>> [...]
>>
>>> +static void elevator_exit(struct request_queue *q)
>>> +{
>>> +	__elevator_exit(q);
>>> +	kobject_put(&q->elevator->kobj);
>>>  }
>>
>> [...]  
>>> +int elevator_change_done(struct request_queue *q, struct elv_change_ctx *ctx)
>>> +{
>>> +	int ret = 0;
>>> +
>>> +	if (ctx->old) {
>>> +		elv_unregister_queue(q, ctx->old);
>>> +		kobject_put(&ctx->old->kobj);
>>> +	}
>>> +	if (ctx->new) {
>>> +		ret = elv_register_queue(q, ctx->new, ctx->uevent);
>>> +		if (ret) {
>>> +			unsigned memflags = blk_mq_freeze_queue(q);
>>> +
>>> +			mutex_lock(&q->elevator_lock);
>>> +			elevator_exit(q);
>>> +			mutex_unlock(&q->elevator_lock);
>>> +			blk_mq_unfreeze_queue(q, memflags);
>>> +		}
>>> +	}
>>> +	return 0;
>>> +}
>>> +
>> It seems that we're still leaking ->elevator_lock in sysfs/kernfs with
>> the above elevator_exit call. I think we probably want to move out 
>> kobject_put(&q->elevator->kobj) from elevator_exit and invoke it 
>> after we release ->elevator_lock in elevator_change_done.
> 
> q->elevator_lock is owned by request queue instead of elevator queue, so it
> shouldn't be one issue, or can you explain in details?
> 
I meant that one of the objective of this patchset is to ensure that
we don't grab any block/queue lock and enter the kernefs/sysfs/debugfs 
code. However here in elevator_change_done() we invoke elevator_exit()
after grabbing q->elevator_lock. Now if we look at the definition of
elevator_exit() then it appears that we invoke kobject_put(&ctx->old->kobj)
from it. So that means that while holding q->elevator_lock we enter in 
kernfs/sysfs code.

So my point was to move kobject_put() out of the elevator_exit() and 
call it after we release q->elevator_lock, maybe something like shown
below:

elevator_change_done()
{
        ...
        ...
	if (ctx->new) {
		ret = elv_register_queue(q, ctx->new, ctx->uevent);
		if (ret) {
			unsigned memflags = blk_mq_freeze_queue(q);

			mutex_lock(&q->elevator_lock);
			__elevator_exit(q);
			mutex_unlock(&q->elevator_lock);

			kobject_put(&q->elevator->kobj);

			blk_mq_unfreeze_queue(q, memflags);
		}
	}    
}

Thanks,
--Nilay
