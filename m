Received: from sg-1-17.ptr.blmpb.com (sg-1-17.ptr.blmpb.com [118.26.132.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F66B22D785
	for <linux-block@vger.kernel.org>; Wed, 31 Dec 2025 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767160766; cv=none; b=TPAhrkXFBp4YvNb0zKo2qr/OQIct5iK0HMnzsp0uXMDbfkmTfYyXRMkbUqOYT7EfPwFLhavenpSX7SYzqWU0RkznMyVTpMEoopV5hjoRNPCBcTSvbk2My4XjNGOu9BsLxfRTiYYnyaV3TPTGSVDX/+rtgLX2iZAdxzRFPOIkeRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767160766; c=relaxed/simple;
	bh=su2ChLjuI8qvhm0tt1x3zzoUbx4XI57ZsU1eNNZL/q8=;
	h=Content-Type:Date:Message-Id:In-Reply-To:To:From:Subject:
	 Mime-Version:References; b=SV1mQ8VHKT8TGDZAO3S5E3Q/EBisPxLoZumknp7fXac0i0x1iG+knZHCmDYNRb6f71vP/Xko+fc54nI1QKu+nSU2ovsX1pvoYO0k5t4xS3oITvUAOkVaBVMAzV+OP30qfwfMcR0yDwbMgdIdawkVM63E78sFFnaPEYFS+jq5NEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=kceDuQpJ; arc=none smtp.client-ip=118.26.132.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="kceDuQpJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1767160752;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=ol2y0kVVQT0TWCYWTJqlF6JEaapZAZdu837XWI6RtMc=;
 b=kceDuQpJ922GJIwhJG4+5zIRg7ccejHA8kgQVuGLUtwSFKiPSUb0ViQhMSlaB0DsocTitD
 dSfK1diKZckmm3TvtDOzBJ/uuWATmBuRXzd2Wtb8Dkyt3T4bVslcKFf5jFmYPJz1QQZSwf
 vytEnz4HnOnljtlbTRIcNoVvuo6Hw3IXyhTIssW0m3V2B51SfZhlFskGcUSB8T8AstspYu
 A1uX6LH7PMokOZyBpy9Mcn8GiEklH3HiZ98bHFPgYoqh9IMibf8ydnbYyR1VHEwDtiyAuX
 WhGFpBPMfLgANb3DDiJMD+LOJVazNPF60i/D/pYcQVvnn6fTy7oQ7WtUKvZR0w==
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.1.104] ([39.182.0.136]) by smtp.feishu.cn with ESMTPS; Wed, 31 Dec 2025 13:59:09 +0800
Content-Transfer-Encoding: quoted-printable
Reply-To: yukuai@fnnas.com
Date: Wed, 31 Dec 2025 13:59:06 +0800
Message-Id: <ce2e12ed-83e4-4f58-927b-35236feb7778@fnnas.com>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26954bbae+668176+vger.kernel.org+yukuai@fnnas.com>
In-Reply-To: <f7ad88e3-1ed7-40a7-9756-346649a8071d@linux.ibm.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Language: en-US
To: "Nilay Shroff" <nilay@linux.ibm.com>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>, <tj@kernel.org>, <ming.lei@redhat.com>, 
	<yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCH v6 07/13] blk-mq-debugfs: warn about possible deadlock
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251225103248.1303397-1-yukuai@fnnas.com> <20251225103248.1303397-8-yukuai@fnnas.com> <f7ad88e3-1ed7-40a7-9756-346649a8071d@linux.ibm.com>

Hi,

=E5=9C=A8 2025/12/30 21:05, Nilay Shroff =E5=86=99=E9=81=93:
>
> On 12/25/25 4:02 PM, Yu Kuai wrote:
>> -static void debugfs_create_files(struct dentry *parent, void *data,
>> +static void debugfs_create_files(struct request_queue *q, struct dentry=
 *parent,
>> +				 void *data,
>>   				 const struct blk_mq_debugfs_attr *attr)
>>   {
>> +	lockdep_assert_held(&q->debugfs_mutex);
>> +	/*
>> +	 * Creating new debugfs entries with queue freezed has the risk of
>> +	 * deadlock.
>> +	 */
>> +	WARN_ON_ONCE(q->mq_freeze_depth !=3D 0);
>> +	/*
>> +	 * debugfs_mutex should not be nested under other locks that can be
>> +	 * grabbed while queue is frozen.
>> +	 */
>> +	lockdep_assert_not_held(&q->elevator_lock);
>> +	lockdep_assert_not_held(&q->rq_qos_mutex);
>> +
>>   	if (IS_ERR_OR_NULL(parent))
>>   		return;
> I just saw that we've nr_hw_queue update code path which is
> calling into the above function while registering debugfs
> entries for the hctx but it doesn't acquire ->debugfs_mutex.
> So that triggers the lockdep warning. We need to fix nr_hw_queue
> update path so that it enters into the above function after
> acquiring ->debugfs_mutex. In fact, kernel test robot also
> complains about the same.

Sure, I missed that. I'll fix it in the next version.

>
> Thanks,
> --Nilay
>
--=20
Thansk,
Kuai
