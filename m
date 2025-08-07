Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777389461
	for <linux-block@vger.kernel.org>; Thu,  7 Aug 2025 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754529813; cv=none; b=IdaHayho17anlPDN803/Vz1glV1164Z8K3zTvgc2x8idyfzNwjGFgoxSvq1H0XcfSEgNRK+RYQq5mlCIORFYYLfPJurIYV50sH3VgoTSRdAX+VDwCIB6Wnj2ZICa5kfhKYf7zWVlI6LURhPV7NTOX27/Z1LuUuHNr28HV2L9u44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754529813; c=relaxed/simple;
	bh=gqg73dssoY/xyJ1FVJU0O80U6MVUxHxe8u120jNe9yk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TNrh+5Ao5WAAFp/k8dqAU2lcmqgaXS31kT+RdLRQ89WjMG/hTVJ+9hIZuHT252n6qxu//RqTXpPuSu0Ph7Jvw8Bz2UgZ4MC5XkTouaXaOy72VFF0Kh+RunE1ZAu/YEsnzAmr1zXAAj9H8Zn7Msxl8yU7pzKyu3Gq+v3iXMStxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4by8Yq2JsWzKHMts
	for <linux-block@vger.kernel.org>; Thu,  7 Aug 2025 09:23:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 675531A07BB
	for <linux-block@vger.kernel.org>; Thu,  7 Aug 2025 09:23:26 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDnrxAMAJRoJM5SCw--.15840S3;
	Thu, 07 Aug 2025 09:23:26 +0800 (CST)
Subject: Re: [PATCH 5/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators
To: Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 John Garry <john.garry@huawei.com>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20250801114440.722286-1-ming.lei@redhat.com>
 <20250801114440.722286-6-ming.lei@redhat.com>
 <c86b6974-fcd6-0a96-a69a-1831f6c6d8d8@huaweicloud.com>
 <aJNYmjoJsarvObBy@fedora>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <700b6ab7-c0c0-58ea-fccf-fd9c3d806d59@huaweicloud.com>
Date: Thu, 7 Aug 2025 09:23:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aJNYmjoJsarvObBy@fedora>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnrxAMAJRoJM5SCw--.15840S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCryDXF18ArW3Jw4DJF4xZwb_yoW5Kw1DpF
	W3G3ZIkwn5X3W0grnrJ397Xr1Fvws5Cr4fAr15Kr129rn0kryrJr4xta10vFyxtr97Ar1v
	vF1093WkCF4vkrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbSfO7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/08/06 21:28, Ming Lei 写道:
> On Wed, Aug 06, 2025 at 05:21:32PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2025/08/01 19:44, Ming Lei 写道:
>>> Replace the spinlock in blk_mq_find_and_get_req() with an SRCU read lock
>>> around the tag iterators.
>>>
>>> This is done by:
>>>
>>> - Holding the SRCU read lock in blk_mq_queue_tag_busy_iter(),
>>> blk_mq_tagset_busy_iter(), and blk_mq_hctx_has_requests().
>>>
>>> - Removing the now-redundant tags->lock from blk_mq_find_and_get_req().
>>>
>>> This change improves performance by replacing a spinlock with a more
>>> scalable SRCU lock, and fixes lockup issue in scsi_host_busy() in case of
>>> shost->host_blocked.
>>>
>>> Meantime it becomes possible to use blk_mq_in_driver_rw() for io
>>> accounting.
>>>
>>> Signed-off-by: Ming Lei<ming.lei@redhat.com>
>>> ---
>>>    block/blk-mq-tag.c | 12 ++++++++----
>>>    block/blk-mq.c     | 24 ++++--------------------
>>>    2 files changed, 12 insertions(+), 24 deletions(-)
>>
>> I think it's not good to use blk_mq_in_driver_rw() for io accounting, we
>> start io accounting from blk_account_io_start(), where such io is not in
>> driver yet.
> 
> In blk_account_io_start(), the current IO is _not_ taken into account in
> update_io_ticks() yet.

However, this is exactly what we did from coding for a long time, for
example, consider just one IO:

t1: blk_account_io_start
t2: blk_mq_start_request
t3: blk_account_io_done

The update_io_ticks() is called from blk_account_io_start() and
blk_account_io_done(), the time (t3 - t1) will be accounted into
io_ticks.

And if we consider more IO, there will be a mess:

t1: IO a: blk_account_io_start
t2: IO b: blk_account_io_start
t3: IO a: blk_mq_start_request
t4: IO b: blk_mq_start_request
t5: IO a: blk_account_io_done
t6: IO b: blk_account_io_done

In the old cases that IO is inflight untill blk_mq_start_request, the
io_ticks accounted is t6 - t2, which is werid. That's the reason I
changed the IO accouting, and consider IO inflight from
blk_account_io_start, and this will unify all the fields in iostat.
> 
> Also please look at 'man iostat':
> 
>      %util  Percentage  of  elapsed time during which I/O requests were issued to the device (bandwidth utilization for the device). Device
>             saturation occurs when this value is close to 100% for devices serving requests serially.  But for devices serving requests  in
>             parallel, such as RAID arrays and modern SSDs, this number does not reflect their performance limits.
> 
> which shows %util in device level, not from queuing IO to complete io from device.
> 
> That said the current approach for counting inflight IO via percpu counter
> from blk_account_io_start() is not correct from %util viewpoint from
> request based driver.
> 

I'll prefer to update the documents, on the one hand, util is not
accurate for a long time until today; on the other hand, AFAIK, iostat
is not suitable for raw disk, as the IO latency, aqusz, etc are all
accounted based on request lifetime, which include elevator and hctx.

In downstream kernels, we recieve lots of reports about slow disks,
a typical scenario is that if there are multiple disks in one scsi
host, and one of the disk has problem, all IOs to the host will be
stuck in the hctx->dispatch until host recovery is done, and after
the recovery is done, iostat will observe huge latency, aqusz, util
for other disks while these disks are just fine.

BTW, we do add IO accounting for bio lifetime and device lifetime
in downstream kernels, and this really helps for slow disk detection.

Thanks,
Kuai

> 
> Thanks,
> Ming
> 
> 
> .
> 

