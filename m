Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A765E26D4E8;
	Tue,  2 Sep 2025 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802852; cv=none; b=Z8bYCektmRBzQKa9u34xNcy1YzZMWaBbLsnjDIEeGkEGNNu/13mEh1CZUXa2gAyKfrDnEoNnKYIAQKGRz59giu5wWtGejy26UwhchwMgYxOn+12wmnyO9Ts41uIz0CtJcsw6HDvzcJUGfs8bCeFsm4GTVKbwEN9dCiRtpEBHl3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802852; c=relaxed/simple;
	bh=4OxtBTSU8U/Bj5ZHgQOORbgmwFWxlpHlvCWrFLANazk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bL/Z44VTRGT5qyHeOe34bzZhvPbvfcV/PQYVgsvME2IYcUub0mDQ3oDcI45cdsxPWrfsMt9wC8DWDyecpe1tu3+qckaBX1/EJkJ5UKkYBGyCIuCErtUbzw0f6yhn8i0Q6ddtBhTw6xJPusLyMc6PLajiKU4uiH2/ZOFm5n35A94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cGKB71pbxzKHNT0;
	Tue,  2 Sep 2025 16:47:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1D7401A1529;
	Tue,  2 Sep 2025 16:47:27 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgAXYIwdr7ZoZ4CABA--.6387S3;
	Tue, 02 Sep 2025 16:47:26 +0800 (CST)
Subject: Re: [PATCH] block: plug attempts to batch allocate tags multiple
 times
To: Xue He <xue01.he@samsung.com>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>
References: <CGME20250901082648epcas5p18f81021213f2b8a050efa25f76e0fb54@epcas5p1.samsung.com>
 <20250901082209.13349-1-xue01.he@samsung.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <345e9d6e-8bb2-3d43-4c3c-cc16fa7dd8c1@huaweicloud.com>
Date: Tue, 2 Sep 2025 16:47:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250901082209.13349-1-xue01.he@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXYIwdr7ZoZ4CABA--.6387S3
X-Coremail-Antispam: 1UD129KBjvJXoWxurWruw4xGFW8Jw48WryxAFb_yoW5ury3pF
	W3JF429w15Wr1UJa18J3y5Jr1UGayDGr17Gr1Yqr1vkw1DC3yxtr18tr48Zry0yrWkJF4U
	Grs5tFyDZw1jy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7I
	JmUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/09/01 16:22, Xue He 写道:
> From: hexue <xue01.he@samsung.com>
> 
> In the existing plug mechanism, tags are allocated in batches based on
> the number of requests. However, testing has shown that the plug only
> attempts batch allocation of tags once at the beginning of a batch of
> I/O operations. Since the tag_mask does not always have enough available
> tags to satisfy the requested number, a full batch allocation is not
> guaranteed to succeed each time. The remaining tags are then allocated
> individually (occurs frequently), leading to multiple single-tag
> allocation overheads.
> 
> This patch aims to allow the remaining I/O operations to retry batch
> allocation of tags, reducing the overhead caused by multiple
> individual tag allocations.
> 
> ------------------------------------------------------------------------
> test result
> During testing of the PCIe Gen4 SSD Samsung PM9A3, the perf tool
> observed CPU improvements. The CPU usage of the original function
> _blk_mq_alloc_requests function was 1.39%, which decreased to 0.82%
> after modification.
> 
> Additionally, performance variations were observed on different devices.
> workload:randread
> blocksize:4k
> thread:1
> ------------------------------------------------------------------------
>                    PCIe Gen3 SSD   PCIe Gen4 SSD    PCIe Gen5 SSD
> native kernel     553k iops       633k iops        793k iops
> modified          553k iops       635k iops        801k iops
> 
> with Optane SSDs, the performance like
> two device one thread
> cmd :sudo taskset -c 0 ./t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1
> -n1 -r4 /dev/nvme0n1 /dev/nvme1n1
> 

How many hw_queues and how many tags in each hw_queues in your nvme?
I feel it's unlikely that tags can be exhausted, usually cpu will become
bottleneck first.
> base: 6.4 Million IOPS
> patch: 6.49 Million IOPS
> 
> two device two thread
> cmd: sudo taskset -c 0 ./t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1
> -n1 -r4 /dev/nvme0n1 /dev/nvme1n1
> 
> base: 7.34 Million IOPS
> patch: 7.48 Million IOPS
> -------------------------------------------------------------------------
> 
> Signed-off-by: hexue <xue01.he@samsung.com>
> ---
>   block/blk-mq.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index b67d6c02eceb..1fb280764b76 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -587,9 +587,9 @@ static struct request *blk_mq_rq_cache_fill(struct request_queue *q,
>   	if (blk_queue_enter(q, flags))
>   		return NULL;
>   
> -	plug->nr_ios = 1;
> -
>   	rq = __blk_mq_alloc_requests(&data);
> +	plug->nr_ios = data.nr_tags;
> +
>   	if (unlikely(!rq))
>   		blk_queue_exit(q);
>   	return rq;
> @@ -3034,11 +3034,13 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>   
>   	if (plug) {
>   		data.nr_tags = plug->nr_ios;
> -		plug->nr_ios = 1;
>   		data.cached_rqs = &plug->cached_rqs;
>   	}
>   
>   	rq = __blk_mq_alloc_requests(&data);
> +	if (plug)
> +		plug->nr_ios = data.nr_tags;
> +
>   	if (unlikely(!rq))
>   		rq_qos_cleanup(q, bio);
>   	return rq;
> 

In __blk_mq_alloc_requests(), if __blk_mq_alloc_requests_batch() failed,
data->nr_tags is set to 1, so plug->nr_ios = data.nr_tags will still set
plug->nr_ios to 1 in this case.

What am I missing?

Thanks,
Kuai

