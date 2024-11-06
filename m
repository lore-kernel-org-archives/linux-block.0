Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7164D;
	Wed,  6 Nov 2024 03:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730863517; cv=none; b=fTQKRWrXP78skDFkjtoQOzaUHTCwyAb9UhZnO0Abp2eZnBnYjmdK5MGe0Cp2EfatTWI9iokE0qm6DyE0vdb4AtukGoqxwIYd4g9sLSPnXZhl6PJBriPpynsJFq44FgSBkJMN/GNrIdTHVV25stPPfejVEbBOkeS0c+DRmZecFuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730863517; c=relaxed/simple;
	bh=XiaI+O/WQa0HTRDs4mpbMBnEOlZn70nBnpCnCaiy/iU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Pue+tt/kX15F9w++SOuAGLx8pfcPuDPvrRdRlJcwjbX2DL6sP4HpIeqAq+l4/jzz7xlMaj6WyjXCI3MpT8wns9bq63raBFAL+04sS3vo8xoWqWPaCkM69omyCN4jSatdGRN67qW1EWW1OYTLATZH5qFrI+xPZDMkM5pn1InoDD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XjrDS5CqXz4f3jqq;
	Wed,  6 Nov 2024 11:24:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 937E01A06D7;
	Wed,  6 Nov 2024 11:25:09 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCngYWT4SpnxITsAw--.20767S3;
	Wed, 06 Nov 2024 11:25:09 +0800 (CST)
Subject: Re: [PATCH -next] block: fix uaf for flush rq while iterating tags
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241104110005.1412161-1-yukuai1@huaweicloud.com>
 <Zyn_RGV2i9COvNQl@infradead.org>
 <217f242b-b4e2-89f7-3b0f-3337c251a603@huaweicloud.com>
 <ZyreVTWn2no-WCC3@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <43ed2c81-7e86-a106-3592-7f1944ce0f25@huaweicloud.com>
Date: Wed, 6 Nov 2024 11:25:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZyreVTWn2no-WCC3@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCngYWT4SpnxITsAw--.20767S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWxXFy8Gw18CFy5WFWUCFg_yoW8KF1rpF
	Zxt3W3Krs5JrnF9Fs2v3y8XryIvwn7JFWkGF45CryaqF1DWFy0gFWxCrWFvF97Xr4rA3y0
	gw4jvr9FvryYyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/11/06 11:11, Ming Lei 写道:
> On Wed, Nov 06, 2024 at 10:58:40AM +0800, Yu Kuai wrote:
>> Hi,Ming and Christoph
>>
>> 在 2024/11/05 19:19, Christoph Hellwig 写道:
>>> On Mon, Nov 04, 2024 at 07:00:05PM +0800, Yu Kuai wrote:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> blk_mq_clear_flush_rq_mapping() is not called during scsi probe, by
>>>> checking blk_queue_init_done(). However, QUEUE_FLAG_INIT_DONE is cleared
>>>> in del_gendisk by commit aec89dc5d421 ("block: keep q_usage_counter in
>>>> atomic mode after del_gendisk"), hence for disk like scsi, following
>>>> blk_mq_destroy_queue() will not clear flush rq from tags->rqs[] as well,
>>>> cause following uaf that is found by our syzkaller for v6.6:
>>>
>>> Which means we leave the flush request lingering after del_gendisk,
>>> which sounds like the real bug.  I suspect we just need to move the
>>> call to blk_mq_clear_flush_rq_mapping so that it is called from
>>> del_gendisk and doesn't leave the flush tag lingering around.
>>>
>>
>> This remind me that del_gendisk is still too late to do that. Noted that
>> flush_rq can acquire different tags, so if the multiple flush_rq is done
>> and those tags are not reused, the flush_rq can exist in multiple
>> entries in tags->rqs[]. The consequence I can think of is that iterating
>> tags can found the same flush_rq multiple times, and the flush_rq can be
>> inflight.
> 
> How can that be one problem?
> 
> Please look at
> 
> commit 364b61818f65 ("blk-mq: clearing flush request reference in tags->rqs[]")
> commit bd63141d585b ("blk-mq: clear stale request in tags->rq[] before freeing one request pool")
> 
> and understand the motivation.
> 
> That also means it is just fine to delay blk_mq_clear_flush_rq_mapping()
> after disk is deleted.

I do understand what you mean. Let's see if you want this to be avoided,
for example(no disk is deleted):

1) issue a flush, and tag 0 is used, after the flush is done,
tags->rqs[0] = flush_rq
2) issue another flush, and tag 1 is used, after the flush is done,
tags->rqs[1] = flush_rq
3) issue a flush again, and tag 2 is used, and the flush_rq is
dispatched to disk;
4) Then in this case, blk_mq_in_flight_rw() will found the same flush_rq
3 times and think there are 3 inflight request, same for
hctx_busy_show()...

Thanks,
Kuai

> 
> Thanks,
> Ming
> 
> 
> .
> 

