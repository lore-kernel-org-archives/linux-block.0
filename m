Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89D7220F3E
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471855; cv=none; b=AaKo77A/T/qbPcOtR5ON6xPvyzCoHAc0e1lNjQH/EW8wCVoa+qz+3Yip10YScofAX2ztWi7R49Mn/1t8bikEWS2mu3gPPQ3pYOAE+G0uX00FMMqD24mW/84f33sT8UzY3BiiHL4Tg/0qx0+dRvVVDHNRqqwvJn5WV+7rZsPO7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471855; c=relaxed/simple;
	bh=ljJIUgXelMkK8fzFgvLCDowBJFYTpSZTJHiz9OjPK48=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HTQG1mSzWFNuPmgx144LFztBGhlDvgFAYL8a0aSeg0mExi++zh2V6BnDO2o4iHJZVDXB1XlZS8FbDLFVJt9kcItewGxhcbfXJVx2rTSZfyclVUkV9ODZBlInz5RUwa6w8Dcu7wTuSOJl5soLdlNZ2CnpFvJGT7ri5X2BrIQdVAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bxl7G61M5zYQvGT
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 17:17:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7A4F01A0359
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 17:17:29 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgD3chOnHZNokRMHCw--.845S3;
	Wed, 06 Aug 2025 17:17:29 +0800 (CST)
Subject: Re: [PATCH 4/5] blk-mq: Defer freeing flush queue to SRCU callback
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: John Garry <john.garry@huawei.com>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-5-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <fa2107e6-5d0b-22df-f823-04c3877f1a81@huaweicloud.com>
Date: Wed, 6 Aug 2025 17:17:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250801114440.722286-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3chOnHZNokRMHCw--.845S3
X-Coremail-Antispam: 1UD129KBjvdXoWrurWfJrWrZFW3Cw43KFy3Arb_yoWDtrg_Zr
	n7t34Iqa17GFWSva45GFnYvFWSgayUGry5uayUJryft34fAFn8WF4qg3yavr4ru3y2ka98
	Zrs5Xw47Ar12qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UZSdgUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/08/01 19:44, Ming Lei Ð´µÀ:
> The freeing of the flush queue/request in blk_mq_exit_hctx() can race with
> tag iterators that may still be accessing it. To prevent a potential
> use-after-free, the deallocation should be deferred until after a grace
> period. With this way, we can replace the big tags->lock in tags iterator
> code path with srcu for solving the issue.
> 
> This patch introduces an SRCU-based deferred freeing mechanism for the
> flush queue.
> 
> The changes include:
> - Adding a `rcu_head` to `struct blk_flush_queue`.
> - Creating a new callback function, `blk_free_flush_queue_callback`,
>    to handle the actual freeing.
> - Replacing the direct call to `blk_free_flush_queue()` in
>    `blk_mq_exit_hctx()` with `call_srcu()`, using the `tags_srcu`
>    instance to ensure synchronization with tag iterators.
> 
> Signed-off-by: Ming Lei<ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 11 ++++++++++-
>   block/blk.h    |  1 +
>   2 files changed, 11 insertions(+), 1 deletion(-)

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

