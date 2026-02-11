Received: from sg-1-39.ptr.blmpb.com (sg-1-39.ptr.blmpb.com [118.26.132.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73C34FF4C
	for <linux-block@vger.kernel.org>; Wed, 11 Feb 2026 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797219; cv=none; b=RysA52PEOPRQnRyiue/3pKZRz0R4izR6qwThj7gQVb/AE8kIuH2zrk8k8AU57ztIsywU31ykhfRTrgY/YB9yuSzC9DkAnpmSVRjknb5cJZLuwpTWyBhaHmCZb5/MCEnJkb0z0MKU73t6JdjLFj0D1htJ8oSK3YzOoG2OD2ICa2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797219; c=relaxed/simple;
	bh=mwWjITRdtLjEAbY38Jp80z8KMYw4gaSpRb8VD4QMqCM=;
	h=Content-Type:Cc:From:Mime-Version:References:To:Subject:Date:
	 Message-Id:In-Reply-To; b=bYeB/WW9yzRxbl8i6OwOVNt1ym+L+7dLTgAAkn16PIERHvSF+Xt+wozCSIXJwT6S0m4yY7xAFiJzhLzLz/8peQ4TaqC1K8m1ZpxAi4PnEhfktDFShAMw/q1I+eMEaJ2SUZd1CVdalalU8oowo7DwfMo5mkUqRij36c6GOeixTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=uxCW6gf7; arc=none smtp.client-ip=118.26.132.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="uxCW6gf7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1770797210;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=YpKc6yOuTbCEZVNyOdM6S6S4lGv43npX1qdpkXI0FR0=;
 b=uxCW6gf7lFzK5h6En8xfFA8sizOV7wFk0LvmoAIanh3B4KWgjWR0IKkbRobLyKhqQasvWV
 cU1kkmsd43cbWKRlhbfEKnapbLouRtIcQeTffLTCplcCVjOrqwW02WkhjmzyTERRkxJhNd
 05HwGx3vlzxM6dUN/A2w5lfJowEgSpTFd/aafPKOdf7hzJZP36DV0Q0oTYGci1pvcBHUWr
 e1WngX1xZ4CsPp49xlNfkNymFR7IbXDh3EfYNYwsUTpoJee7Oz5bS4e+wuOiyxkJa/NK06
 qSNY3TF+WPrJCX5nI5wxUOvd58FMj2ahcjwhjRrcZkv2uat9MDLxr9chkQzu0Q==
Content-Transfer-Encoding: quoted-printable
Received: from [192.168.1.104] ([39.182.0.137]) by smtp.feishu.cn with ESMTPS; Wed, 11 Feb 2026 16:06:48 +0800
Content-Type: text/plain; charset=UTF-8
Cc: <tj@kernel.org>, <ming.lei@redhat.com>, <neal@gompa.dev>, 
	<asahi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
From: "Yu Kuai" <yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260209082953.3053721-1-yukuai@fnnas.com> <20260209082953.3053721-5-yukuai@fnnas.com> <f5da8810-84cd-408b-a1e6-8e80c8578168@linux.ibm.com>
To: "Nilay Shroff" <nilay@linux.ibm.com>, <axboe@kernel.dk>, 
	<kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <sven@kernel.org>, 
	<j@jannau.net>, <linux-block@vger.kernel.org>, 
	<linux-nvme@lists.infradead.org>, <yukuai@fnnas.com>
Subject: Re: [PATCH 4/4] blk-mq: use blk_queue_enter/exit to protect debugfs file creation
Date: Wed, 11 Feb 2026 16:06:46 +0800
Message-Id: <5c255e26-3108-4622-b500-486c1d68d498@fnnas.com>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+2698c3899+9f55c0+vger.kernel.org+yukuai@fnnas.com>
In-Reply-To: <f5da8810-84cd-408b-a1e6-8e80c8578168@linux.ibm.com>
Reply-To: yukuai@fnnas.com
Content-Language: en-US
X-Original-From: Yu Kuai <yukuai@fnnas.com>

Hi,

=E5=9C=A8 2026/2/11 15:20, Nilay Shroff =E5=86=99=E9=81=93:
>
> On 2/9/26 1:59 PM, Yu Kuai wrote:
>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>> index faeaa1fc86a7..03583d0d3972 100644
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -613,11 +613,6 @@ static void debugfs_create_files(struct request_que=
ue *q, struct dentry *parent,
>>   				 const struct blk_mq_debugfs_attr *attr)
>>   {
>>   	lockdep_assert_held(&q->debugfs_mutex);
>> -	/*
>> -	 * Creating new debugfs entries with queue freezed has the risk of
>> -	 * deadlock.
>> -	 */
>> -	WARN_ON_ONCE(q->mq_freeze_depth !=3D 0);
>>   	/*
>>   	 * debugfs_mutex should not be nested under other locks that can be
>>   	 * grabbed while queue is frozen.
>> @@ -628,9 +623,19 @@ static void debugfs_create_files(struct request_que=
ue *q, struct dentry *parent,
>>   	if (IS_ERR_OR_NULL(parent))
>>   		return;
>>  =20
>> +	/*
>> +	 * Avoid creating debugfs files while the queue is frozen, wait for
>> +	 * the queue to be unfrozen and prevent new freeze while creating
>> +	 * debugfs files.
>> +	 */
>> +	if (blk_queue_enter(q, 0))
>> +		return;
>> +
>>   	for (; attr->name; attr++)
>>   		debugfs_create_file_aux(attr->name, attr->mode, parent,
>>   				    (void *)attr, data, &blk_mq_debugfs_fops);
>> +
>> +	blk_queue_exit(q);
>>   }
>>  =20
>>   void blk_mq_debugfs_register(struct request_queue *q)
> I also noticed that we use other debugfs helpers such as debugfs_create_d=
ir()
> from some block paths, which could run into the same fs-reclaim recursion=
 issue.
> So we may need to consider those call sites as well to ensure consistent =
handling.

Yes, sounds correct.

>
> On another note, instead of waiting for queue to be unfreezed, does it ma=
kes sense to
> wrap the debugfs code under NOIO context (as Christoph pointed in another=
 thread)?
> IMO, if fs-reclaim recursion is the only issue here we would be better of=
f using
> NOIO context instead of blocking for queue to be unfrozen from other cont=
exts.

I can try this. So far, debugfs_mutex related deadlocks are related to fs-r=
eclaim,
although I'm not that confident there won't be any other  implicit dependen=
cy.
Meanwhile, looks like the previous patches for nvme targets are not necessa=
ry anymore.

> Thanks,
> --Nilay
>
--=20
Thansk,
Kuai
