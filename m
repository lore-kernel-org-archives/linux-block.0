Received: from sg-1-21.ptr.blmpb.com (sg-1-21.ptr.blmpb.com [118.26.132.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D60E2F5318
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 10:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762855377; cv=none; b=FB+pBx7hO1FPAypRN2RcgQloFOW9cnkbwfWftKGBSDZLhcAaKrJbcFpqDtEJ6MVEwmrOl+0QG5swpiuOjxdo/BGHPX5nwnNEU+35wug8r2sFxq4sTAcMTGlEqw49v/aBxbshoYia48OIqL4y7W3/SnMeYr1WPCxJeB8rR4Kp9Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762855377; c=relaxed/simple;
	bh=bhQii1XgtoyWWoxx4dQfunsUih5bm57UoSOkxnWK4OQ=;
	h=Cc:Date:From:Subject:Message-Id:To:Mime-Version:In-Reply-To:
	 Content-Type:References; b=KijlFKxjbu7xZ6sQJezAFjezAM9c38gwH8EwzEO4DNnd9fR/Y0AvtcaEBWwCq+v9qpo4eQbyyDSR0HDoBC6SovkVNcMr2nc0lz85AYJY+VH7cuyQtNNVGlhJ4poZ9LhgCdi6PmVYdz/uAAkSGz4tDOY1bSU/IPwN8yd33TF4ymA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=fail smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=y0pR9UOa; arc=none smtp.client-ip=118.26.132.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="y0pR9UOa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762855362;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=ObenrjlBFeraZnWdU5THqAeuW+WraTDNAV+Bh4+XgSw=;
 b=y0pR9UOaHmXggiocD+ikGopKLK9sTMMPXFY/iiqW2F4z/eDAwR5igvYzRjmzxJii7JfEz7
 iIHRguK3L0bMrhi3Fam/IrRDd1buSzyDLs1ET9pDF5zuMty11Fgk+YRVVcP+H1xsgVnzBD
 JYmCR0JNSSvpT5OV5BUz9Jk9jt6AdXIQF8w9u7sYuzd77T1TQ2vgDh1Q1B63p7yDi/9IiY
 fEeUxeM6XRL0StUS1SC/cQDaRyJDYLxJwN4nxXCf/iFtnlvr3F9eeWo+cfTYOnNgnRnghY
 twB5wnRMT2URLX2VX57iF+tiInbvGEsbnyVWDzF/qMUlThAUdW1iqi2sQ8FOVQ==
Reply-To: yukuai@fnnas.com
Cc: <ming.lei@redhat.com>, <hch@lst.de>, <axboe@kernel.dk>, 
	<yi.zhang@redhat.com>, <czhong@redhat.com>, <gjoyce@ibm.com>, 
	<yukuai@fnnas.com>
Date: Tue, 11 Nov 2025 18:02:37 +0800
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCHv4 1/5] block: unify elevator tags and type xarrays into struct elv_change_ctx
Message-Id: <f287b65a-1321-4662-a3e3-a906f610e037@fnnas.com>
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Tue, 11 Nov 2025 18:02:39 +0800
To: "Nilay Shroff" <nilay@linux.ibm.com>, <linux-block@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
In-Reply-To: <edc689f9-b46a-44e3-bf8d-7bbc355b9a08@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+2691309c0+df2be8+vger.kernel.org+yukuai@fnnas.com>
References: <20251110081457.1006206-1-nilay@linux.ibm.com> <20251110081457.1006206-2-nilay@linux.ibm.com> <c02eddd8-1776-4d1b-b5ef-c99a5fedc996@fnnas.com> <edc689f9-b46a-44e3-bf8d-7bbc355b9a08@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable

Hi,

=E5=9C=A8 2025/11/11 16:37, Nilay Shroff =E5=86=99=E9=81=93:
>
> On 11/11/25 12:25 PM, Yu Kuai wrote:
>>> @@ -5055,11 +5062,12 @@ static void __blk_mq_update_nr_hw_queues(struct=
 blk_mq_tag_set *set,
>>>   =20
>>>    	memflags =3D memalloc_noio_save();
>>>   =20
>>> -	xa_init(&et_tbl);
>>> -	if (blk_mq_alloc_sched_tags_batch(&et_tbl, set, nr_hw_queues) < 0)
>>> -		goto out_memalloc_restore;
>>> -
>>>    	xa_init(&elv_tbl);
>>> +	if (blk_mq_alloc_sched_ctx_batch(&elv_tbl, set) < 0)
>>> +		goto out_free_ctx;
>>> +
>>> +	if (blk_mq_alloc_sched_tags_batch(&elv_tbl, set, nr_hw_queues) < 0)
>>> +		goto out_free_ctx;
>> I fell it's not necessary to separate two helpers above, just fold
>> blk_mq_alloc_sched_tags_batch() into blk_mq_alloc_sched_ctx_batch(),
>> since blk_mq_alloc_sched_tags_batch() is never called separately in
>> following patches.
>>
> Hmm, as the name suggests, blk_mq_alloc_sched_ctx_batch() is meant to
> allocate elevator_change_ctx structures in batches. So, folding
> blk_mq_alloc_sched_tags_batch() into blk_mq_alloc_sched_ctx_batch()
> doesn=E2=80=99t look correct, since the purpose of blk_mq_alloc_sched_tag=
s_batch()
> is to allocate scheduler tags in batches.
>
> That said, we=E2=80=99ve already folded blk_mq_alloc_sched_tags_batch() i=
nto
> blk_mq_alloc_sched_res_batch(), in subsequent patch, whose purpose is
> to allocate scheduler resources in batches.
>
> So, IMO, keeping blk_mq_alloc_sched_tags_batch() as-is in this patch
> and folding it later into blk_mq_alloc_sched_res_batch() seems more
> appropriate from a function naming and logical layering point of view.

I mean just remove the helper blk_mq_alloc_sched_tags_batch() and call
blk_mq_alloc_sched_tags(or _res later) directly from
blk_mq_alloc_sched_ctx_batch().

I think at least there will be less code lines :)

blk_mq_alloc_sched_ctx_batch
  list_for_each_entry
   ctx =3D kzalloc
   xa_insert
   blk_mq_alloc_sched_res

blk_mq_free_sched_ctx_batch
  xa_for_each
   xa_erash
   blk_mq_free_sched_res
   kfree

If you don't like the name, perhaps it's fine to use
blk_mq_alloc_sched_ctx_and_res_batch.

Still, it's up to you :)

Thanks,
Kuai

>
> Thanks,
> --Nilay
