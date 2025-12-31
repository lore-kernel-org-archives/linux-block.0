Received: from sg-1-13.ptr.blmpb.com (sg-1-13.ptr.blmpb.com [118.26.132.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB9718CBE1
	for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 05:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767159556; cv=none; b=KARfI/Hf98goQ/tXEZ2sdUjaFeSP64ZyaJEPbv4GbZRzsp77rfGEZp3M6OGzCScrWDXBPiWsI+AvY1c1EdmY0FKODHJlOcI1h2fGHdSNRwCHCDhXsFDJQBqR8h/uQ5B4tsdqgbRitxMF3LOXoMwT65RcPx7ccWYu3x6dlG09QHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767159556; c=relaxed/simple;
	bh=jmO+v1hhAFkA0vt6+I7xseu2QTWBmjqhOi56+S7iUhk=;
	h=References:From:Date:Mime-Version:Message-Id:Content-Type:To:
	 Subject:In-Reply-To; b=Gwm/cpSblPkawmnd0dlhPIR1wc1uaASEowID3swSIcb2u9rc9ncJs/78536pVAUKHoKQdgYEjGSRLZB9ON0YpWGjlRvwMqKPEfm9Biga6SjgAKBWLcwEGzPBGsU0Ynxlqb/skgxtF1o9oN6fN4AGj6aQMN83eerCPjztIjaQi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=GplLRw4o; arc=none smtp.client-ip=118.26.132.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="GplLRw4o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1767159540;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=gLycpMcJbDoDv2Vj3qjGXcX/epLzhRogw3PrdsBxqfg=;
 b=GplLRw4oUAxAfQX7EfVrd5CxpVnT22HI10EP1n2lQ7BctXcfb8f0VTkkdoGT8l7+YIV7Ea
 O/rmq++CGh6x4HeTy5bcT4QFNliYJJDtYxbWns6NZMODrFjgDs56suvVhTAC/VSrQ1ZHO0
 arX/te+81ysI8uYRVYMv8n2tlNziRh4wjxS798edoHY/MOO/7vSvq7SaSrUyPmpxChXqME
 BdPZ7tA+5MZRId03PrHrYLiMCyC2fugZsJ2RnKByyA6MoXgrOXKQU7wR2RF3j8G//AGnty
 3A9s5sZ0kOdUWfKMv3WW0rscWOsz6zD6WfflLByB/xh8bJlT2VoaZIbW4g8kBg==
References: <20251225103248.1303397-1-yukuai@fnnas.com> <20251225103248.1303397-7-yukuai@fnnas.com> <5ca7b3a4-e849-4e59-a56c-7e095b0c93b9@linux.ibm.com>
Received: from [192.168.1.104] ([39.182.0.136]) by smtp.feishu.cn with ESMTPS; Wed, 31 Dec 2025 13:38:57 +0800
Content-Language: en-US
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Wed, 31 Dec 2025 13:38:54 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yu Kuai <yukuai@fnnas.com>
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@fnnas.com
Message-Id: <68bad073-c1ad-4434-b9ed-6d9aaf4fda02@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: "Nilay Shroff" <nilay@linux.ibm.com>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>, <tj@kernel.org>, <ming.lei@redhat.com>, 
	<yukuai@fnnas.com>
Subject: Re: [PATCH v6 06/13] blk-mq-debugfs: remove blk_mq_debugfs_unregister_rqos()
In-Reply-To: <5ca7b3a4-e849-4e59-a56c-7e095b0c93b9@linux.ibm.com>
X-Lms-Return-Path: <lba+26954b6f2+e2bb59+vger.kernel.org+yukuai@fnnas.com>

Hi,

=E5=9C=A8 2025/12/30 13:33, Nilay Shroff =E5=86=99=E9=81=93:
>
> On 12/25/25 4:02 PM, Yu Kuai wrote:
>> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
>> index d7ce99ce2e80..85cf74402a09 100644
>> --- a/block/blk-rq-qos.c
>> +++ b/block/blk-rq-qos.c
>> @@ -371,8 +371,4 @@ void rq_qos_del(struct rq_qos *rqos)
>>   	if (!q->rq_qos)
>>   		blk_queue_flag_clear(QUEUE_FLAG_QOS_ENABLED, q);
>>   	blk_mq_unfreeze_queue(q, memflags);
>> -
>> -	mutex_lock(&q->debugfs_mutex);
>> -	blk_mq_debugfs_unregister_rqos(rqos);
>> -	mutex_unlock(&q->debugfs_mutex);
>>   }
> This change looks good overall, but I have one comment:
>
> Do we really need to freeze the queue in rq_qos_del() here? Currently,
> rq_qos_del() is only called from blk_iocost_init() and blk_iolatency_init=
(),
> both of which run while holding ->freeze_lock. Given this, it seems
> unnecessary for rq_qos_del() to freeze and unfreeze the queue again.
> Instead, we could remove the freeze/unfreeze logic from rq_qos_del() and
> add a WARN_ON() or assertion to ensure that the caller has already frozen
> the queue before invoking it.

Sounds good.

> Moreover, with the current logic, rq_qos_del() may reverse the locking
> order between ->rq_qos_mutex and ->freeze_lock if the caller has not
> already acquired ->freeze_lock, which could lead to potential lock
> ordering issues.

Meanwhile, I see the same situation in blkcg_policy_register(), where
blk_mq_freeeze_queue() is called with rq_qos_mutex already held, I'll
clean that up as well.

>
> Thanks,
> --Nilay
>
--=20
Thansk,
Kuai
