Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707952F2900
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 08:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889767; cv=none; b=J/2ObxaSBAPUiBV32QG0M5U7opIao4PYZICEcQ0lUk1ibzuBdOZGGRug/FFkDrYPXltnzg7+V5OthrXWEQXpmThOLsjQCfUrSebLR1nDHYJnhFZTW8lAfi2Xmj2X94Or873OFd19LliOaEq1Kz4YVJyupwObQ0NdBj51vUOPpnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889767; c=relaxed/simple;
	bh=268Ct99JjtUApKF9A6vpxfxU1JCp/9r8U9S08u1M2zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=dMTzAxTu52mh4SjPeTxkxRqKD0JQISsbuF4mD09RJYHObcqA3liJr0d5pOQCp4g8M6mYqwnY1XPELO94TmwlWmVOnCckC0C4dQB7HI6m5sNgg1rSlviZz8i0/dsVMjDfW4qBORv7zP1hxpNR0IA7vw1HgNvtHBPrqULP7tuH47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FOYvRcAa; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FOYvRcAa"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250903085556epoutp03dd2af757504992599940739747cd48c2~huezi70Ur1676916769epoutp03S
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 08:55:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250903085556epoutp03dd2af757504992599940739747cd48c2~huezi70Ur1676916769epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756889756;
	bh=bA76rll/wXeKqMGIRxAZgS5mWnhgMeLsw86yBouXkGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FOYvRcAa68wNooeH/Z3AJA/PWBgcnBOqFi/7Cz01ijBMVqcloJEe3odUurCJU4w5I
	 eYqRF3sOTHowu3wjvlK4vE+gIKJahjeZA98DFjkzHiNpsOC+rB1GF7QxqdhkdWsszw
	 0HtbzwOaCCeQ1GQtaWgOepVgUwW/agYKt5Zd0fVQ=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250903085556epcas5p3308bab41b8ae1bbe946b8cee7e35adf8~huezRTXL52834228342epcas5p3F;
	Wed,  3 Sep 2025 08:55:56 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cGxKR31lBz3hhTJ; Wed,  3 Sep
	2025 08:55:55 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250903084608epcas5p19a0ad4f0d1bad27889426e525d0c4598~huWQIIitD1722017220epcas5p1q;
	Wed,  3 Sep 2025 08:46:08 +0000 (GMT)
Received: from node122.. (unknown [109.105.118.122]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250903084608epsmtip2836f174f83877da7399e25e322ef2ca3~huWPXdGwN0822408224epsmtip21;
	Wed,  3 Sep 2025 08:46:08 +0000 (GMT)
From: Xue He <xue01.he@samsung.com>
To: yukuai1@huaweicloud.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com
Subject: Re: [PATCH] block: plug attempts to batch allocate tags multiple
 times
Date: Wed,  3 Sep 2025 08:41:35 +0000
Message-Id: <20250903084135.2860-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <345e9d6e-8bb2-3d43-4c3c-cc16fa7dd8c1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250903084608epcas5p19a0ad4f0d1bad27889426e525d0c4598
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250903084608epcas5p19a0ad4f0d1bad27889426e525d0c4598
References: <345e9d6e-8bb2-3d43-4c3c-cc16fa7dd8c1@huaweicloud.com>
	<CGME20250903084608epcas5p19a0ad4f0d1bad27889426e525d0c4598@epcas5p1.samsung.com>

On 2025/09/02 08:47 AM, Yu Kuai wrote:
>On 2025/09/01 16:22, Xue He wrote:
......
>> This patch aims to allow the remaining I/O operations to retry batch
>> allocation of tags, reducing the overhead caused by multiple
>> individual tag allocations.
>> 
>> ------------------------------------------------------------------------
>> test result
>> During testing of the PCIe Gen4 SSD Samsung PM9A3, the perf tool
>> observed CPU improvements. The CPU usage of the original function
>> _blk_mq_alloc_requests function was 1.39%, which decreased to 0.82%
>> after modification.
>> 
>> Additionally, performance variations were observed on different devices.
>> workload:randread
>> blocksize:4k
>> thread:1
>> ------------------------------------------------------------------------
>>                    PCIe Gen3 SSD   PCIe Gen4 SSD    PCIe Gen5 SSD
>> native kernel     553k iops       633k iops        793k iops
>> modified          553k iops       635k iops        801k iops
>> 
>> with Optane SSDs, the performance like
>> two device one thread
>> cmd :sudo taskset -c 0 ./t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1
>> -n1 -r4 /dev/nvme0n1 /dev/nvme1n1
>> 
>
>How many hw_queues and how many tags in each hw_queues in your nvme?
>I feel it's unlikely that tags can be exhausted, usually cpu will become
>bottleneck first.

the information of my nvme like this:
number of CPU: 16
memory: 16G
nvme nvme0: 16/0/16 default/read/poll queue
cat /sys/class/nvme/nvme0/nvme0n1/queue/nr_requests
1023

In more precise terms, I think it is not that the tags are fully exhausted,
but rather that after scanning the bitmap for free bits, the remaining
contiguous bits are nsufficient to meet the requirement (have but not enough).
The specific function involved is __sbitmap_queue_get_batch in lib/sbitmap.c.
                    get_mask = ((1UL << nr_tags) - 1) << nr;
                    if (nr_tags > 1) {
                            printk("before %ld\n", get_mask);
                    }
                    while (!atomic_long_try_cmpxchg(ptr, &val,
                                                      get_mask | val))
                            ;
                    get_mask = (get_mask & ~val) >> nr;

where during the batch acquisition of contiguous free bits, an atomic operation
is performed, resulting in the actual tag_mask obtained differing from the
originally requested one.

Am I missing something?

>> base: 6.4 Million IOPS
>> patch: 6.49 Million IOPS
>> 
>> two device two thread
>> cmd: sudo taskset -c 0 ./t/io_uring -b512 -d128 -c32 -s32 -p1 -F1 -B1
>> -n1 -r4 /dev/nvme0n1 /dev/nvme1n1
>> 
>> base: 7.34 Million IOPS
>> patch: 7.48 Million IOPS
>> -------------------------------------------------------------------------
>> 
>> Signed-off-by: hexue <xue01.he@samsung.com>
>> ---
>>   block/blk-mq.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>> 
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index b67d6c02eceb..1fb280764b76 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -587,9 +587,9 @@ static struct request *blk_mq_rq_cache_fill(struct request_queue *q,
>>   	if (blk_queue_enter(q, flags))
>>   		return NULL;
>>   
>> -	plug->nr_ios = 1;
>> -
>>   	rq = __blk_mq_alloc_requests(&data);
>> +	plug->nr_ios = data.nr_tags;
>> +
>>   	if (unlikely(!rq))
>>   		blk_queue_exit(q);
>>   	return rq;
>> @@ -3034,11 +3034,13 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
>>   
>>   	if (plug) {
>>   		data.nr_tags = plug->nr_ios;
>> -		plug->nr_ios = 1;
>>   		data.cached_rqs = &plug->cached_rqs;
>>   	}
>>   
>>   	rq = __blk_mq_alloc_requests(&data);
>> +	if (plug)
>> +		plug->nr_ios = data.nr_tags;
>> +
>>   	if (unlikely(!rq))
>>   		rq_qos_cleanup(q, bio);
>>   	return rq;
>> 
>
>In __blk_mq_alloc_requests(), if __blk_mq_alloc_requests_batch() failed,
>data->nr_tags is set to 1, so plug->nr_ios = data.nr_tags will still set
>plug->nr_ios to 1 in this case.
>
>What am I missing?

yes, you are right, if __blk_mq_alloc_requests_batch() failed, it will set
to 1. However, in this case, it did not fail to execute; instead, the
allocated number of tags was insufficient, as only a partial number were
allocated. Therefore, the function is considered successfully executed.

>Thanks,
>Kuai
>

Thanks,
Xue
