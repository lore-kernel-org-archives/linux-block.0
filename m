Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5654818CC13
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 02:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753323572; cv=none; b=EnBhzy01sgEdxH3cscQMtZRKxzwUrFk4n8nF5EBFlNbfNlOTyjT7FICDalV7RZCUbvOvPqaY5LxKsOP722e00sq8WzdlnqkLNisdbg3xxMnedFaK706tcTJ6xVvrOHczL5Jt2A5yDvpBuVJKQ6KH4sUUGGjme2kIjnuNpL80Cbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753323572; c=relaxed/simple;
	bh=XpjK2s2eq0vOz9AoLtVoSpGBT2DYbN0Q7OdV6MxZooU=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FjDI8XxONlqxVK8VegRfFuGoYsfhNVfwVCr8DZXuGI1jxAoXcfCj18POtcSlvqiJCgJ+LIF2cNosaq/zOg+9ZmatFyRfGuIo/QbNgD1vTrLXWl12QlcST3Gn5oHVWpw0/ojxdBOAjsFjr30kUoF8WVT2GNuxCJmwlDoRtOoibNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bnZSt4W0YzYQtxV
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 10:19:26 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5AB6B1A1447
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 10:19:25 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgCnIxQrmIFog0MnBQ--.51554S3;
	Thu, 24 Jul 2025 10:19:25 +0800 (CST)
Subject: Re: [PATCHv3 1/2] lib/sbitmap: fix kernel crash observed when sbitmap
 depth is zero
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: hch@lst.de, dlemoal@kernel.org, yukuai1@huaweicloud.com, hare@suse.de,
 ming.lei@redhat.com, axboe@kernel.dk, johannes.thumshirn@wdc.com,
 gjoyce@ibm.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20250723134442.1283664-1-nilay@linux.ibm.com>
 <20250723134442.1283664-2-nilay@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ec93c0a4-4237-f4d8-67e0-4307be05397d@huaweicloud.com>
Date: Thu, 24 Jul 2025 10:19:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250723134442.1283664-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnIxQrmIFog0MnBQ--.51554S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXryDCF45AFW7Gry8tryUGFg_yoW5CrWkpF
	ZrGFWIkr40q34Uuw4UJFyxuFy8uFs0kF9rG3sayr1Y9a1qgr95WF1DCFW7XFWUGr1kAF1r
	tas8Cw17K34DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

ÔÚ 2025/07/23 21:43, Nilay Shroff Ð´µÀ:
> We observed a kernel crash when the I/O scheduler allocates an sbitmap
> for a hardware queue (hctx) that has no associated software queues (ctx),
> and later attempts to free it. When no software queues are mapped to a
> hardware queue, the sbitmap is initialized with a depth of zero. In such
> cases, the sbitmap_init_node() function should set sb->alloc_hint to NULL.
> However, if this is not done, sb->alloc_hint may contain garbage, and
> calling sbitmap_free() will pass this invalid pointer to free_percpu(),
> resulting in a kernel crash.
> 
> Example crash trace:
> ==================================================================
> Kernel attempted to read user page (28) - exploit attempt? (uid: 0)
> BUG: Kernel NULL pointer dereference on read at 0x00000028
> Faulting instruction address: 0xc000000000708f88
> Oops: Kernel access of bad area, sig: 11 [#1]
> LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=2048 NUMA pSeries
> [...]
> CPU: 5 UID: 0 PID: 5491 Comm: mk_nullb_shared Kdump: loaded Tainted: G    B               6.16.0-rc5+ #294 VOLUNTARY
> Tainted: [B]=BAD_PAGE
> Hardware name: IBM,9043-MRX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.00 (NM1060_028) hv:phyp pSeries
> [...]
> NIP [c000000000708f88] free_percpu+0x144/0xba8
> LR [c000000000708f84] free_percpu+0x140/0xba8
> Call Trace:
>      free_percpu+0x140/0xba8 (unreliable)
>      kyber_exit_hctx+0x94/0x124
>      blk_mq_exit_sched+0xe4/0x214
>      elevator_exit+0xa8/0xf4
>      elevator_switch+0x3b8/0x5d8
>      elv_update_nr_hw_queues+0x14c/0x300
>      blk_mq_update_nr_hw_queues+0x5cc/0x670
>      nullb_update_nr_hw_queues+0x118/0x1f8 [null_blk]
>      nullb_device_submit_queues_store+0xac/0x170 [null_blk]
>      configfs_write_iter+0x1dc/0x2d0
>      vfs_write+0x5b0/0x77c
>      ksys_write+0xa0/0x180
>      system_call_exception+0x1b0/0x4f0
>      system_call_vectored_common+0x15c/0x2ec
> 
> If the sbitmap depth is zero, sb->alloc_hint memory is NOT allocated, but
> the pointer is not explicitly set to NULL. Later, during sbitmap_free(),
> the kernel attempts to free sb->alloc_hint, which is a per cpu pointer
> variable, regardless of whether it was valid, leading to a crash.
> 
> This patch ensures that sb->alloc_hint is explicitly set to NULL in
> sbitmap_init_node() when the requested depth is zero. This prevents
> free_percpu() from freeing sb->alloc_hint and thus avoids the observed
> crash.
> 
> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   lib/sbitmap.c | 1 +
>   1 file changed, 1 insertion(+)
> 
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Thanks

> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index d3412984170c..aa8b6ca76169 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -119,6 +119,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>   
>   	if (depth == 0) {
>   		sb->map = NULL;
> +		sb->alloc_hint = NULL;
>   		return 0;
>   	}
>   
> 

