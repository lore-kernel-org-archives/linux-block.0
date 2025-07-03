Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4599F4414
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751509192; cv=none; b=fI2B6qqCO9wJW/mX0BR4KSo/QCeQwhh4YifmHKSo7RCNsp20blz9XneXipuaZ8qtK+uX3XlpdTMwiNOqqfuxoyFi/teUQ1iv8GEQFlY5q17/lVl9Wm1Q0SnGa3xNm91E2ihoN++aGK0qS1TOduusDuH+oUb33kj8S9dbRvqOTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751509192; c=relaxed/simple;
	bh=iP2mn4LS7pmdy4/qcPFT3YwbVe/yuCwD4CSc+WE20eI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jYTswjP2U7YduL2FTh6tKH+RF/58gxGBfQM6UjSHi1JEaqnYlwb2xGWW0CvoIBJZRx5/flbwdHLcn3+acWJg2DqJ1JFfu6sYNMILoxK47Z83Zz+G3b0A1QkhbEduSrt8mBmpMdnyfTvICqbcVjFldhkwg1lP/dmUwwdVZwmbsHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bXgT02cSPzKHMxJ
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 10:19:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C345B1A1214
	for <linux-block@vger.kernel.org>; Thu,  3 Jul 2025 10:19:46 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP3 (Coremail) with SMTP id _Ch0CgB32SbB6GVoVlDsAQ--.64921S3;
	Thu, 03 Jul 2025 10:19:46 +0800 (CST)
Subject: Re: [PATCH 2/8] block: Do not run frozen queues
To: Ming Lei <ming.lei@redhat.com>, Bart Van Assche <bvanassche@acm.org>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250702203845.3844510-1-bvanassche@acm.org>
 <20250702203845.3844510-3-bvanassche@acm.org>
 <699f9f38-009f-c5da-dfd3-60531e16c1ce@huaweicloud.com>
 <93500d50-ba11-425b-8d5f-1ce1930e4160@acm.org> <aGXiH1HqSlLk-QSI@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ba64dabd-6c56-ac56-8d27-6cfeb616a6dc@huaweicloud.com>
Date: Thu, 3 Jul 2025 10:19:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aGXiH1HqSlLk-QSI@fedora>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB32SbB6GVoVlDsAQ--.64921S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4kKrWrJFW7Aw4ftrWDJwb_yoW8Cr4xpa
	y8GF15Kw4kZFWxK34xGw1xXF48WrsxCF13Kr93Jr9xJFnaqrn8Zr4fK398uFWSyr1kKay2
	vr4UG397ZryFvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUBVbkUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/07/03 9:51, Ming Lei Ð´µÀ:
> On Wed, Jul 02, 2025 at 06:30:34PM -0700, Bart Van Assche wrote:
>> On 7/2/25 6:15 PM, Yu Kuai wrote:
>>> Just a question, blk_mq_quiesce_queue also calls synchronize_rcu() to
>>> wait for inflight dispatch work to be done, is it safe in following
>>> patches? I think it's not, dispatch work can be running while there is
>>> no request pending, menas queue can be frozen with active dispatch work.
>>
>> No work is dispatched if a queue is frozen because freezing a queue only
>> finishes after q_usage_counter drops to zero. queue_rq() and queue_rqs()
>> are only called if one or more requests are being executed.
>> q_usage_counter is increased when a request is allocated and decreased
>> when a request is freed. Hence, q_usage_counter cannot be zero while
>> queue_rq() or queue_rqs() is in progress. Hence, neither queue_rq() nor
>> queue_rqs() are called while q_usage_counter is zero.
> 
> It isn't related with queue_rq() or queue_rqs() only.
> 
> The dispatch work is still in-progress when all requests are
> completed(.q_usage_counter becomes zero), because request can complete any
> time, even before queue_rq()/queue_rqs() returns.
> 
> The dispatch critical area is much _longer_ than queue_rq()/queue_rqs(),
> block layer data structure may still be accessed after .q_usage_counter drops
> to zero.

Yes, the critical area is protected by rcu/srcu, you can see this in
__blk_mq_run_dispatch_ops.

There can be request pending while blk_mq_hw_queue_need_run() is
checking, and request can complete before __blk_mq_run_dispatch_ops().

Thanks,
Kuai

> 
> Please run 'git grep', and we did fix such kind of issues several times, such as:
> 
> 662156641bc4 ("block: don't drain in-progress dispatch in blk_cleanup_queue()")
> 
> 
> Thanks,
> Ming
> 
> 
> .
> 

