Received: from lf-1-31.ptr.blmpb.com (lf-1-31.ptr.blmpb.com [103.149.242.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECBF23BD1B
	for <linux-block@vger.kernel.org>; Thu, 25 Dec 2025 09:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766655542; cv=none; b=uO9G7JK1cANWABjKOAuSLJUe1rD4swMkr0E7ap/G2VphCDJcq7vOrLh7whFH2pDLTYgMAnC2Ul+Hf2x2D/xrPszHt+Jia131HXlz06hpBYbdBW4pYthGs88lTCZuCo0hS2O87SF7wHSpJ4bjHVDGErgD/Q9gY8bgCIP+qn25lyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766655542; c=relaxed/simple;
	bh=6hb1f6agks+u1vYbejC6Yhcy/l1CIhp6Qc8007Sbeg0=;
	h=To:In-Reply-To:References:Subject:Date:From:Message-Id:
	 Mime-Version:Content-Type; b=NqabzHjIcMR7UXrBIaUHo/jbz5GXHg+cRWmb5/R2wdYoAYH0pW06fzUcVY6EY3uCNywRCcy4q8b3p4oddOs8C6lng+0CTVpIOZbxkbFRRdqZygJ+FgHW/30o7MyGG6BZ5/ZpBcI4D4a3K9TdJ4gWR09vXx4njJ0U+6xxpeW7qXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=Bcwd1oQc; arc=none smtp.client-ip=103.149.242.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="Bcwd1oQc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1766655456;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Hol+qj4ORCwOm7RzsRfyYODATAjXKHe0lNt3mayjK0M=;
 b=Bcwd1oQcgsxK9FUpFkJuKZWS+DUUL52pyVB+DA6QdnKOdYK6RaawmiGPXG1WD5HQxuLoHI
 xcgyuzYL1icmfCTLf/pROdtXbSFRr0jZnX98j9XAWwdc9U09xFKYMoAM0DeVEh6WM7Afq1
 zLySsphsRdsY5r8uV6woIfq3+7ENAZbHniqppSMIgpca88m2nrd4uR1a4zRaOxDsBgT4W9
 iuZUyMCbmAEbqh94Qw4KtnI4ySlq3UJvZO5l6B+JPNDVsv2ytWpkty5/dDEgb9dvtJaquC
 ZanNC4kkIurfqDhMPCBoQIQdc1ncbnt1WkBECmXNEiLoOzeX0hGt7HgvOgLH9Q==
To: "Nilay Shroff" <nilay@linux.ibm.com>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>, <tj@kernel.org>, <ming.lei@redhat.com>, 
	<yukuai@fnnas.com>
In-Reply-To: <33f9030a-5c84-4e91-8c2e-247e0d691be9@linux.ibm.com>
X-Lms-Return-Path: <lba+2694d05de+268617+vger.kernel.org+yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable
References: <20251214101409.1723751-1-yukuai@fnnas.com> <20251214101409.1723751-7-yukuai@fnnas.com> <33f9030a-5c84-4e91-8c2e-247e0d691be9@linux.ibm.com>
Reply-To: yukuai@fnnas.com
Subject: Re: [PATCH v5 06/13] blk-mq-debugfs: warn about possible deadlock
Date: Thu, 25 Dec 2025 17:37:32 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Content-Language: en-US
Received: from [192.168.1.104] ([39.182.0.136]) by smtp.feishu.cn with ESMTPS; Thu, 25 Dec 2025 17:37:33 +0800
Message-Id: <6136ccd3-b4e2-4249-8000-a485d4420e12@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8

Hi,

=E5=9C=A8 2025/12/19 2:26, Nilay Shroff =E5=86=99=E9=81=93:
>
> On 12/14/25 3:44 PM, Yu Kuai wrote:
>> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
>> index 99466595c0a4..d54f8c29d2f4 100644
>> --- a/block/blk-mq-debugfs.c
>> +++ b/block/blk-mq-debugfs.c
>> @@ -610,9 +610,22 @@ static const struct blk_mq_debugfs_attr blk_mq_debu=
gfs_ctx_attrs[] =3D {
>>   	{},
>>   };
>>  =20
>> -static void debugfs_create_files(struct dentry *parent, void *data,
>> +static void debugfs_create_files(struct request_queue *q, struct dentry=
 *parent,
>> +				 void *data,
>>   				 const struct blk_mq_debugfs_attr *attr)
>>   {
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
> Shouldn't we also ensure that ->debugfs_mutex is already held by the call=
er while
> the above function is invoked? That said, I also found that we need to fi=
x the
> locking order in rq_qos_del() which is invoked just before cleaning up de=
bugfs
> entries.

I can add the assert for debugfs_mutex(), however, for rq_qos_del(), I'll p=
refer
to delete blk_mq_debugfs_unregister_rqos() directly, it's only called by io=
cost
and iolatency that don't have debugfs.

>
> Thanks,
> --Nilay
>
--=20
Thansk,
Kuai
