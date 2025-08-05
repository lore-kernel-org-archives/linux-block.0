Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4623C4EA
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380123; cv=none; b=L2Ib9uDkSX1kTyLqzSzgdOITLcaNqVLlw6V47udJ04TQTaQLih2sKpYewjp9JMyWU8S5jXTfFsHI+eCPDmfagE19oZmOWdA81Q4vpWyG9xexEvqxOYJDKDEMmMqPgnQOIiUZVsPH8Jy5PyUjFW7YXDhIgcrcLm2f0yI5h6GKePY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380123; c=relaxed/simple;
	bh=H+mx0u8D6L9/t6eJ2kVYSphix2Moxey3TUL/CZsZjvs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FCN1qan6K1zKeALALdNGByTrzMBWXyPiUA9RloZ1VJHedKLrqTmHAwmCrlE4NxaQYB9G04GlXN5/NBvqXKu0kdaBCn8RmULXybLhFIHQKlottGn+alcKGQyvJGfZOlXx1+zCMIkvDp6KG2V8ZjBRCzhaOv+V1mH6NfcHysIU7Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bx5CC6bDczKHMcg
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 15:48:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EEFB31A07BB
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 15:48:38 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgA3sxNVt5FoeBOJCg--.17017S3;
	Tue, 05 Aug 2025 15:48:38 +0800 (CST)
Subject: Re: [PATCH 2/5] blk-mq: Pass tag_set to blk_mq_free_rq_map/tags
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: John Garry <john.garry@huawei.com>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-3-ming.lei@redhat.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <8a06e0e7-40c8-287a-6c02-605cf8849f48@huaweicloud.com>
Date: Tue, 5 Aug 2025 15:48:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250801114440.722286-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3sxNVt5FoeBOJCg--.17017S3
X-Coremail-Antispam: 1UD129KBjvdXoWrurWxCry7WryrWF1rAF47urg_yoW3Crg_ur
	4Ikw48Jw4DJ34Sya1YkayUArWxKw4UJry0gryqqrWS9rn3ZF4DJanI9w48Jr43Wan7Can5
	Zr1DXry3Jrn7WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UK2N
	tUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/08/01 19:44, Ming Lei Ð´µÀ:
> To prepare for converting the tag->rqs freeing to be SRCU-based, the
> tag_set is needed in the freeing helper functions.
> 
> This patch adds 'struct blk_mq_tag_set *' as the first parameter to
> blk_mq_free_rq_map() and blk_mq_free_tags(), and updates all their call
> sites.
> 
> This allows access to the tag_set's SRCU structure in the next step,
> which will be used to free the tag maps after a grace period.
> 
> No functional change is intended in this patch.
> 
> Signed-off-by: Ming Lei<ming.lei@redhat.com>
> ---
>   block/blk-mq-sched.c |  4 ++--
>   block/blk-mq-tag.c   |  2 +-
>   block/blk-mq.c       | 10 +++++-----
>   block/blk-mq.h       |  4 ++--
>   4 files changed, 10 insertions(+), 10 deletions(-)

LGTM
Reviewed-by: Yu Kuai <yukuai3@huawei.com>

