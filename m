Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650761C5D7B
	for <linux-block@vger.kernel.org>; Thu,  1 May 2025 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746095182; cv=none; b=QNiqL4GIHVFjFibxFxMj//WG0l7wvfW+NovQOr4B90Ob09T2pBmdrGoHqtRkTqiLZCpu97Y0HDEDWl3sILAcpuSFvkJ3GYRcSvbKCV6LKG5Wu/c06VwKhwWB33RZGmyYYNLRDjF3Byr5LBPyMkqDlZ7aFTzMd2pzPpNQZdilsVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746095182; c=relaxed/simple;
	bh=+qoZ/HpO6Ya4avpD/u8TPuzILUIPQjD9lPRrd12h5Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sVlGcb34GmO9GvLVn0GVyvttCE87NLgR+dWL3uxCG8zatUR6F/FNaAoI61b0o+HxOwDsb/oZjYy6eiarZ7J0BxWz+ubr/kT7oBkHGN20eTd00Y0lFoZJsk+gJetgLdBQSQPHTiZBeZYkQLWp0H0gpdGKbsEIx/HSK4Ige77dKwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VPF5HDpp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VPF5HDpp"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541A4QSN002340;
	Thu, 1 May 2025 10:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HicXRa
	FWNnA7IJ1H0v40bjsreVE9VZcd053EY/PRX9o=; b=VPF5HDppXtLSjLBM5AOYri
	jK9pCZdiviRaqt/7r4c6ra3uTbWJW5dTVqhxc3+Kh2JkplvWlmDMhshrwSKqMnY4
	6wIVvLKuRTVK3sHgF+9cWfoMszUUtaukvcL4IVTK8WeEuTlRNIxcD6CscWThiAc3
	9VmjQXsFMCPApQEuTojqBU/YKHSOYWMr3HROHC9F/+NDpUQvwuPivERiXF+InN9L
	RAvsLcIQVhp54+SzuufroQxMCT3TWIeMNOsReySfScGj2Gkh95H3u2tBjWDneXhW
	5RBl1aw2IA6gyPojbAmQ85DMgz8vV8WwIgXG8j52FGjxjfL+L+0u1FDc7bad0Xpg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46c6vjg1tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 10:26:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5416BWB0024612;
	Thu, 1 May 2025 10:26:08 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 469c1mc3hu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 May 2025 10:26:08 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 541AQ7N52294382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 May 2025 10:26:08 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D3DE5806A;
	Thu,  1 May 2025 10:26:07 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C449058069;
	Thu,  1 May 2025 10:26:04 +0000 (GMT)
Received: from [9.43.8.50] (unknown [9.43.8.50])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 May 2025 10:26:04 +0000 (GMT)
Message-ID: <089e64c6-ea36-409b-8771-a029e88b4972@linux.ibm.com>
Date: Thu, 1 May 2025 15:56:03 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 20/24] block: move elv_register[unregister]_queue out
 of elevator_lock
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
 <20250430043529.1950194-21-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250430043529.1950194-21-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA3NyBTYWx0ZWRfXzxMkLAJMM2sT upI/LN/TlwiiwaStmIz/l8v+wq4A3XycnyAmIWyjPTSplTmA8HpZZbqmC1yqVVkr8I3KHIj2gzj hlFBb4Hptq8HQQZi+x7RBaO04b/CbCJRuVvdRrrnAb5IjgQ65EGp3+M+ODz2nOtBVea4bYr7BKb
 E5j0HlGQERqtYRyzGPmqRZgmY/uztfrKWNdMVOe9Qez4kX2B8WYmwhfjqiMKZTrWznwopWqou+S pG29jJRrYWjUPuam7CUS5gZvhU8LXd//DBp0Lo0rRIJKY1ZU1sLpK3HQj7OkuhyZ7JEiorlBAkz GDdtULQoOEKTitFRTvIRWrym9HvM5RAThN26cLJqVrYPQf1y5SBv5YW6/jSJKM75Icv4y8lZOeL
 HkD0NvALVyAKJoyKkWIKRov1GUWVIshgTsH6iDsPELIupF+qKKwxus7t0b3Y70aKj9vD9wz7
X-Authority-Analysis: v=2.4 cv=GI8IEvNK c=1 sm=1 tr=0 ts=68134c41 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=20KFwNOVAAAA:8 a=ZaE_v6l_0-2EnHqThR8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6J-7FOjgFEZBsRznY9TWshYOnyi-ISPB
X-Proofpoint-ORIG-GUID: 6J-7FOjgFEZBsRznY9TWshYOnyi-ISPB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505010077



On 4/30/25 10:05 AM, Ming Lei wrote:
> Move elv_register[unregister]_queue out of ->elevator_lock & queue freezing,
> so we can kill many lockdep warnings.
> 
> elv_register[unregister]_queue() is serialized, and just dealing with sysfs/
> debugfs things, no need to be done with queue frozen:
> 
> - when it is called from adding disk, elevator switch isn't possible
>   because ->queue_kobj isn't added yet
> 
> - when it is called from deleting disk, disable_elv_switch() is
>   responsible for preventing new elevator switch and draining old
>   elevator switch.
> 
> - when it is called from blk_mq_update_nr_hw_queues(), adding/removing
>   disk and elevator switch can't be allowed or in-progress
> 
> With this change, elevator's ->exit() is called before calling
> elv_unregister_queue, then user may call into ->show()/store() of elevator's
> sysfs attributes, and we have covered this issue by adding `ELEVATOR_FLAG_DYNG`.
> 
> For blk-mq debugfs, hctx->sched_tags is always checked with ->elevator_lock by
> debugfs code, meantime hctx->sched_tags is updated with ->elevator_lock, so
> there isn't such issue.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq.c   |  3 +--
>  block/elevator.c | 63 ++++++++++++++++++++++++++++++++++++++----------
>  block/genhd.c    |  6 +++++
>  3 files changed, 57 insertions(+), 15 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b920eaedbaa9..a4bcfce4c4b9 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4997,11 +4997,10 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
>  		blk_mq_debugfs_register_hctxs(q);
>  	}
>  
> +	/* elv_update_nr_hw_queues() unfreeze queue for us */
>  	list_for_each_entry(q, &set->tag_list, tag_set_list)
>  		elv_update_nr_hw_queues(q);
>  
> -	list_for_each_entry(q, &set->tag_list, tag_set_list)
> -		blk_mq_unfreeze_queue_nomemrestore(q);
>  	memalloc_noio_restore(memflags);
>  
>  	/* Free the excess tags when nr_hw_queues shrink. */
> diff --git a/block/elevator.c b/block/elevator.c
> index 98a754f58de5..492a593160ae 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -49,6 +49,11 @@
>  struct elv_change_ctx {
>  	const char *name;
>  	bool no_uevent;
> +
> +	/* for unregistering old elevator */
> +	struct elevator_queue *old;
> +	/* for registering new elevator */
> +	struct elevator_queue *new;
>  };
>  
>  static DEFINE_SPINLOCK(elv_list_lock);
> @@ -158,14 +163,14 @@ static void elevator_exit(struct request_queue *q)
>  {
>  	struct elevator_queue *e = q->elevator;
>  
> +	lockdep_assert_held(&q->elevator_lock);
> +
>  	ioc_clear_queue(q);
>  	blk_mq_sched_free_rqs(q);
>  
>  	mutex_lock(&e->sysfs_lock);
>  	blk_mq_exit_sched(q, e);
>  	mutex_unlock(&e->sysfs_lock);
> -
> -	kobject_put(&e->kobj);
>  }
>  
>  static inline void __elv_rqhash_del(struct request *rq)
> @@ -466,8 +471,6 @@ static int elv_register_queue(struct request_queue *q,
>  {
>  	int error;
>  
> -	lockdep_assert_held(&q->elevator_lock);
> -
>  	error = kobject_add(&e->kobj, &q->disk->queue_kobj, "iosched");
>  	if (!error) {
>  		const struct elv_fs_entry *attr = e->type->elevator_attrs;
> @@ -494,8 +497,6 @@ static int elv_register_queue(struct request_queue *q,
>  static void elv_unregister_queue(struct request_queue *q,
>  				 struct elevator_queue *e)
>  {
> -	lockdep_assert_held(&q->elevator_lock);
> -
>  	if (e && test_and_clear_bit(ELEVATOR_FLAG_REGISTERED, &e->flags)) {
>  		kobject_uevent(&e->kobj, KOBJ_REMOVE);
>  		kobject_del(&e->kobj);
> @@ -586,7 +587,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
>  	blk_mq_quiesce_queue(q);
>  
>  	if (q->elevator) {
> -		elv_unregister_queue(q, q->elevator);
> +		ctx->old = q->elevator;
>  		elevator_exit(q);
>  	}
>  
> @@ -594,11 +595,7 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
>  		ret = blk_mq_init_sched(q, new_e);
>  		if (ret)
>  			goto out_unfreeze;
> -		ret = elv_register_queue(q, q->elevator, !ctx->no_uevent);
> -		if (ret) {
> -			elevator_exit(q);
> -			goto out_unfreeze;
> -		}
> +		ctx->new = q->elevator;
>  	} else {
>  		blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
>  		q->elevator = NULL;
> @@ -619,6 +616,38 @@ static int elevator_switch(struct request_queue *q, struct elv_change_ctx *ctx)
>  	return ret;
>  }
>  
> +static void elv_exit_and_release(struct request_queue *q)
> +{
> +	struct elevator_queue *e;
> +	unsigned memflags;
> +
> +	memflags = blk_mq_freeze_queue(q);
> +	mutex_lock(&q->elevator_lock);
> +	e = q->elevator;
> +	elevator_exit(q);
> +	mutex_unlock(&q->elevator_lock);
> +	blk_mq_unfreeze_queue(q, memflags);
> +	if (e)
> +		kobject_put(&e->kobj);
> +}
> +
> +static int elevator_change_done(struct request_queue *q,
> +				struct elv_change_ctx *ctx)
> +{
> +	int ret = 0;
> +
> +	if (ctx->old) {
> +		elv_unregister_queue(q, ctx->old);
> +		kobject_put(&ctx->old->kobj);
> +	}
> +	if (ctx->new) {
> +		ret = elv_register_queue(q, ctx->new, !ctx->no_uevent);
> +		if (ret)
> +			elv_exit_and_release(q);
> +	}
> +	return ret;
> +}
> +
>  /*
>   * Switch this queue to the given IO scheduler.
>   */
> @@ -645,6 +674,9 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
>  		ret = elevator_switch(q, ctx);
>  	mutex_unlock(&q->elevator_lock);
>  	blk_mq_unfreeze_queue(q, memflags);
> +	if (!ret)
> +		ret = elevator_change_done(q, ctx);
> +
>  	return ret;
>  }
>  
> @@ -657,6 +689,7 @@ void elv_update_nr_hw_queues(struct request_queue *q)
>  	struct elv_change_ctx ctx = {
>  		.name	= "none",
>  	};
> +	int ret = -ENODEV;
>  
>  	WARN_ON_ONCE(q->mq_freeze_depth == 0);
>  
> @@ -664,8 +697,12 @@ void elv_update_nr_hw_queues(struct request_queue *q)
>  	if (q->elevator && !blk_queue_dying(q) && !blk_queue_registered(q))
>  		ctx.name = q->elevator->type->elevator_name;
>  	/* force to reattach elevator after nr_hw_queue is updated */
> -	elevator_switch(q, &ctx);
> +	ret = elevator_switch(q, &ctx);
>  	mutex_unlock(&q->elevator_lock);
> +	blk_mq_unfreeze_queue_nomemrestore(q);
> +
> +	if (!ret)
> +		WARN_ON_ONCE(elevator_change_done(q, &ctx));
>  }
>  
>  /*
> diff --git a/block/genhd.c b/block/genhd.c
> index 0e64e7400fb4..59d9febd8c14 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -751,11 +751,17 @@ static void __del_gendisk(struct gendisk *disk)
>  
>  static void disable_elv_switch(struct request_queue *q)
>  {
> +	struct blk_mq_tag_set *set = q->tag_set;
> +
>  	WARN_ON_ONCE(!queue_is_mq(q));
>  
>  	mutex_lock(&q->elevator_lock);
>  	blk_queue_flag_set(QUEUE_FLAG_NO_ELV_SWITCH, q);
>  	mutex_unlock(&q->elevator_lock);
> +
> +	/* wait until in-progress elevator switch is done */
> +	down_write(&set->update_nr_hwq_lock);
> +	up_write(&set->update_nr_hwq_lock);
>  }
>  
>  /**

The disable_elv_switch which is now called just before __del_gendisk 
disables elevator switch using QUEUE_FLAG_NO_ELV_SWITCH. And I also see
write-lock (set->update_nr_hwq_lock) in disable_elv_switch which intends
to wait until in-progress elevator switch is finished but that may not help
because there's a small window in elv_iosched_store where it evaluates 
"elevator-switching-disabled" and then when it actually acquires the 
read-lock (set->update_nr_hwq_lock).

During the above window, if disable_elv_switch runs then we may enter into 
the race, where we'd see elv_iosched_store and __del_gendisk running 
concurrently. 

So we may want to update disable_elv_switch such that setting QUEUE_FLAG_
NO_ELV_SWITCH is protected with write-lock (set->update_nr_hwq_lock) and
if we do that then we may also not need q->elevator_lock in disable_elv_switch.
Or another way to fix it might be to move read-lock (set->update_nr_hwq_lock) 
at the top in elv_iosched_store.  

Thanks,
--Nilay
