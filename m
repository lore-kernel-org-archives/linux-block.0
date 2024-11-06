Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1233F9D2;
	Wed,  6 Nov 2024 03:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730865118; cv=none; b=RSB5uooYBddMPSGqpcvoOsa5y/oCpCfYJ5TrRoAFmhVCc5whxap4WnixukWsFSWf1srpTDHwTdpkozkFVDPRo9e0fiGIKZez+DC4VnEcUVSn4APEbOelgy9sJS60rZDL4MzQ3yjquaBJFD2j4O9drSRyjT+bam4vcAoHmDg+NLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730865118; c=relaxed/simple;
	bh=421yXcSo87qm7ia7Au+iiWKQbg6r3jBOD8eDSpDQ3Ao=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QptAFCEBAdGs5fkNYt6fhoRj/Qctq4E/uORYY2JyQJkUkpM9KA59/F01hN8IE4KGFOX+QvdMvA5SmZ985wcmrEAW3kJ4/7b8AbQwIk/rCV4wlHwPA3V6nKkwPgc/wFsQufha3oxuLiW6qHS1nNZiJfHB0/UVENx1H182M6wAfZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xjrq72v4Qz4f3lfV;
	Wed,  6 Nov 2024 11:51:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3D52F1A06DA;
	Wed,  6 Nov 2024 11:51:50 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgB3U4fU5ypnqEvuAw--.23323S3;
	Wed, 06 Nov 2024 11:51:50 +0800 (CST)
Subject: Re: [PATCH -next] block: fix uaf for flush rq while iterating tags
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20241104110005.1412161-1-yukuai1@huaweicloud.com>
 <Zyn_RGV2i9COvNQl@infradead.org>
 <217f242b-b4e2-89f7-3b0f-3337c251a603@huaweicloud.com>
 <ZyreVTWn2no-WCC3@fedora>
 <43ed2c81-7e86-a106-3592-7f1944ce0f25@huaweicloud.com>
 <ZyrkTB0-SKjrQaiZ@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <78c19006-e4c1-ef19-e930-9d5dc1cb295d@huaweicloud.com>
Date: Wed, 6 Nov 2024 11:51:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZyrkTB0-SKjrQaiZ@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3U4fU5ypnqEvuAw--.23323S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZry7Aw17CrWDAw4Uuw4DJwb_yoW5ZF4UpF
	ZxG3W3Kr4DJrnFvFn2vw4xXryIvrnrJrZ5XF15AryaqF1qgFyIgr97Gr4ruF97Xr48C3y0
	gw4jqr9Fvry0yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
	Y487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2024/11/06 11:36, Ming Lei 写道:
> On Wed, Nov 06, 2024 at 11:25:07AM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2024/11/06 11:11, Ming Lei 写道:
>>> On Wed, Nov 06, 2024 at 10:58:40AM +0800, Yu Kuai wrote:
>>>> Hi,Ming and Christoph
>>>>
>>>> 在 2024/11/05 19:19, Christoph Hellwig 写道:
>>>>> On Mon, Nov 04, 2024 at 07:00:05PM +0800, Yu Kuai wrote:
>>>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>>>
>>>>>> blk_mq_clear_flush_rq_mapping() is not called during scsi probe, by
>>>>>> checking blk_queue_init_done(). However, QUEUE_FLAG_INIT_DONE is cleared
>>>>>> in del_gendisk by commit aec89dc5d421 ("block: keep q_usage_counter in
>>>>>> atomic mode after del_gendisk"), hence for disk like scsi, following
>>>>>> blk_mq_destroy_queue() will not clear flush rq from tags->rqs[] as well,
>>>>>> cause following uaf that is found by our syzkaller for v6.6:
>>>>>
>>>>> Which means we leave the flush request lingering after del_gendisk,
>>>>> which sounds like the real bug.  I suspect we just need to move the
>>>>> call to blk_mq_clear_flush_rq_mapping so that it is called from
>>>>> del_gendisk and doesn't leave the flush tag lingering around.
>>>>>
>>>>
>>>> This remind me that del_gendisk is still too late to do that. Noted that
>>>> flush_rq can acquire different tags, so if the multiple flush_rq is done
>>>> and those tags are not reused, the flush_rq can exist in multiple
>>>> entries in tags->rqs[]. The consequence I can think of is that iterating
>>>> tags can found the same flush_rq multiple times, and the flush_rq can be
>>>> inflight.
>>>
>>> How can that be one problem?
>>>
>>> Please look at
>>>
>>> commit 364b61818f65 ("blk-mq: clearing flush request reference in tags->rqs[]")
>>> commit bd63141d585b ("blk-mq: clear stale request in tags->rq[] before freeing one request pool")
>>>
>>> and understand the motivation.
>>>
>>> That also means it is just fine to delay blk_mq_clear_flush_rq_mapping()
>>> after disk is deleted.
>>
>> I do understand what you mean. Let's see if you want this to be avoided,
>> for example(no disk is deleted):
> 
> It is definitely another issue, and not supposed to be covered by
> blk_mq_clear_flush_rq_mapping().
> 
>>
>> 1) issue a flush, and tag 0 is used, after the flush is done,
>> tags->rqs[0] = flush_rq
>> 2) issue another flush, and tag 1 is used, after the flush is done,
>> tags->rqs[1] = flush_rq
>> 3) issue a flush again, and tag 2 is used, and the flush_rq is
>> dispatched to disk;
> 
> Yes, this kind of thing exists since blk-mq begins, and you can't expect
> blk_mq_in_flight_rw() to get accurate inflight requests.
> 
>> 4) Then in this case, blk_mq_in_flight_rw() will found the same flush_rq
>> 3 times and think there are 3 inflight request, same for
>> hctx_busy_show()...
> 
> But we have tried to avoid it, such as in blk_mq_find_and_get_req()
> req->tag is checked against the current 'bitnr' of sbitmap when walking
> over tags. Then the same flush_rq won't be counted 3 times.

Yes, I missed that req->tag is checked. Looks like there is no porblem
now. :)

Just to make sure, we're still on the same page for this patch, right?

Thanks for the explanation.
Kuai

> 
> 
> 
> Thanks,
> Ming
> 
> 
> .
> 

