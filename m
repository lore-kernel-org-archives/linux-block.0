Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EBE2566F2
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472097; cv=none; b=eEJnVYnuDLH9Ukd+l1044fBjiOsPkWjxNIqPq6uDZkcirRLBC+4HDHDATJ8KxKo6hbUs311Bb4Dp9mY5BTRbEmoZwTYu7eXH3g9cAUlTBwgNLqQLNDRiGzyxxBQ6+1/alf7uXrqe/vEBfz0yvWDs8NCy1Dxdf3kyr+fjQNgrcng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472097; c=relaxed/simple;
	bh=beJY3MBXgaruF/N9m9rwdFpJG+hKhuhWU4HBhsjOMFQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=A8JN6Dv59RNZ24hby+PrpY1Ui7EQhSdLrv+Ixt71oa10RXFuUNtWjMlCutq+9zGWbF0TS1xGeA43SHIHbfp0aEz0qiYIH+WjZD+7Vc72w5y5bEaRIA/2gdpvx/WI8wDwapyIZqRva+IkEFxj0ujJXK/gy9gVhibNHMsTEVDbHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bxlCx4t9VzKHMyQ
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 17:21:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B92261A0359
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 17:21:32 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgB3QBGcHpNoX2UHCw--.36818S3;
	Wed, 06 Aug 2025 17:21:32 +0800 (CST)
Subject: Re: [PATCH 5/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: John Garry <john.garry@huawei.com>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-6-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <c86b6974-fcd6-0a96-a69a-1831f6c6d8d8@huaweicloud.com>
Date: Wed, 6 Aug 2025 17:21:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250801114440.722286-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3QBGcHpNoX2UHCw--.36818S3
X-Coremail-Antispam: 1UD129KBjvdXoWrurW3tw18CFy7uF1ftr1kXwb_yoWDtFg_uF
	y0ka4xtrW7JFWrKF12kFnrZa4rKa18GryDC34qqFW3Xwn3ArZrJr4Dt3y7Zw4DuanrCa1r
	Zrn3Zr4rAF48XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUFB
	T5DUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/01 19:44, Ming Lei Ð´µÀ:
> Replace the spinlock in blk_mq_find_and_get_req() with an SRCU read lock
> around the tag iterators.
> 
> This is done by:
> 
> - Holding the SRCU read lock in blk_mq_queue_tag_busy_iter(),
> blk_mq_tagset_busy_iter(), and blk_mq_hctx_has_requests().
> 
> - Removing the now-redundant tags->lock from blk_mq_find_and_get_req().
> 
> This change improves performance by replacing a spinlock with a more
> scalable SRCU lock, and fixes lockup issue in scsi_host_busy() in case of
> shost->host_blocked.
> 
> Meantime it becomes possible to use blk_mq_in_driver_rw() for io
> accounting.
> 
> Signed-off-by: Ming Lei<ming.lei@redhat.com>
> ---
>   block/blk-mq-tag.c | 12 ++++++++----
>   block/blk-mq.c     | 24 ++++--------------------
>   2 files changed, 12 insertions(+), 24 deletions(-)

I think it's not good to use blk_mq_in_driver_rw() for io accounting, we
start io accounting from blk_account_io_start(), where such io is not in
driver yet.

Otherwise, LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

