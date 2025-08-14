Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5462D541B
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755162898; cv=none; b=nhQDJTFDkPeBnN0mbRpwBsQZa9gyFi9a42z3IRYVd6Es0aVomwV/J2IsrnBU0iuEf8DpKFVpbvd9HCAdnz/dTE2Tpk71DQT3viGJiTUlCt2p76Pgcz2AnO9PX+SHG9kHrWqeoKUJOLYWjZLuqL/wyYUERyJ7F0gTHd6RkDHTG0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755162898; c=relaxed/simple;
	bh=Ps9XqU8lesJoz9qnafGc/zWXZBlQeguUBTEDJ+E13ag=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PvtAUVuwr3InMDThfhOYBveL3L/FfPz+s4CaAMYFRgtMra6PuYjdll13kwIQ6TQ4syXLTry2oWaApUkicRuq0y6N819Ge2MPv8vQTZid/EqjO/xT2jN/80e6b1FzIq2mk7umEMGGguUeO4EfOvDnWi/kR2nMCdEoUlBv5jKa+5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c2fhb2C8qzYQvK7
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 17:14:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E40AA1A018D
	for <linux-block@vger.kernel.org>; Thu, 14 Aug 2025 17:14:53 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDHjxAMqZ1o51aSDg--.37342S3;
	Thu, 14 Aug 2025 17:14:53 +0800 (CST)
Subject: Re: [PATCHv3 2/3] block: decrement block_rq_qos static key in
 rq_qos_del()
To: Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.dk, ming.lei@redhat.com, yukuai1@huaweicloud.com,
 hch@lst.de, shinichiro.kawasaki@wdc.com, kch@nvidia.com, gjoyce@ibm.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
 <20250814082612.500845-3-nilay@linux.ibm.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2c85a764-5fc4-12a7-c8f1-9d42b9d7b061@huaweicloud.com>
Date: Thu, 14 Aug 2025 17:14:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250814082612.500845-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHjxAMqZ1o51aSDg--.37342S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr13GryfGFyUXr43AFyxKrg_yoW8GFyDpa
	1kKw1DCFWjgFn0gayxGw1rJrW7A3yfKrWUJry5Gw1fZr18Cw1I9F95ta1vgF9YvasFkF48
	Xr1UJrWUXr1rKa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

ÔÚ 2025/08/14 16:24, Nilay Shroff Ð´µÀ:
> rq_qos_add() increments the block_rq_qos static key when a QoS
> policy is attached. When a QoS policy is removed via rq_qos_del(),
> we must symmetrically decrement the static key. If this removal drops
> the last QoS policy from the queue (q->rq_qos becomes NULL), the
> static branch can be disabled and the jump label patched to a NOP,
> avoiding overhead on the hot path.
> 
> This change ensures rq_qos_add()/rq_qos_del() keep the
> block_rq_qos static key balanced and prevents leaving the branch
> permanently enabled after the last policy is removed.
> 

BTW, this problem is unlikely to happen in real users cases, because
rq_qos_del is only called from error path, where activate cgroup policy
failed with -ENOMEM.
> Fixes: 033b667a823e ("block: blk-rq-qos: guard rq-qos helpers by static key")
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   block/blk-rq-qos.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
> index 848591fb3c57..b1e24bb85ad2 100644
> --- a/block/blk-rq-qos.c
> +++ b/block/blk-rq-qos.c
> @@ -374,6 +374,7 @@ void rq_qos_del(struct rq_qos *rqos)
>   	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
>   		if (*cur == rqos) {
>   			*cur = rqos->next;
> +			static_branch_dec(&block_rq_qos);
>   			break;
>   		}
>   	}
> 

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Thanks

