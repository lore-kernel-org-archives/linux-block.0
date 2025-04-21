Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D33813212A;
	Mon, 21 Apr 2025 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745238082; cv=none; b=jjxU5JZLfhtHBtUWY4QdQpqGGPryFfR3+webMfe+T5T0OaMtBK7D/DXzhDDEdS6w4xZoQthyd/YUgMtGmQDT/Krz0wtfVSNzWeTcDJU6DA/ip3MZgN0CL9sooEFDLl5kv5saXkkiiRUXSuOWSdJQZqPeGe3b0P+50DCM4PzJQOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745238082; c=relaxed/simple;
	bh=iMcOproauThzVJNK7jS09osn3yXkJVBW7zXDM1fWJWA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uUncUaAIF3UshmE4tYs9TuBoEM13mIXOxdQNKTm9sipndnXOhRMZBPdKTTr3oQkPqV6phYfPyXmAtHArA+t/3qdM9qAdM+Eme3luqeJbKd6zFj4pt3VCk33WOdST3nO8s/JQf+OIq43qUPpmeX4aQVOq9jo0DVzq5X2rPd4cNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Zh4GC2hXhz4f3jJ8;
	Mon, 21 Apr 2025 20:20:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 40C501A058E;
	Mon, 21 Apr 2025 20:21:15 +0800 (CST)
Received: from [10.174.179.143] (unknown [10.174.179.143])
	by APP4 (Coremail) with SMTP id gCh0CgDHKl85OAZoQMWNKA--.64428S3;
	Mon, 21 Apr 2025 20:21:15 +0800 (CST)
Subject: Re: 10x I/O await times in 6.12
To: Matt Fleming <mfleming@cloudflare.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-team <kernel-team@cloudflare.com>, "yukuai (C)" <yukuai3@huawei.com>
References: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <dd2db843-843f-db15-c54f-f2c44548dee3@huaweicloud.com>
Date: Mon, 21 Apr 2025 20:21:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHKl85OAZoQMWNKA--.64428S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1fur15uryxGF45Ary7KFg_yoW5WrWfpr
	Z0q3ZIyr4rZFWIga1xAa12vFyrtr1qyrW7JFW5G3ySyw1kCryfKr1FvayY9ry3Zrn5CrW7
	WFZYgas8ZanIkFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwx
	hLUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

Hi,

在 2025/04/21 16:53, Matt Fleming 写道:
> Hey there,
> 
> We're moving to 6.12 at Cloudflare and noticed that write await times
> in iostat are 10x what they were in 6.6. After a bit of bpftracing
> (script to find all plug times above 10ms below), it seems like this
> is an accounting error caused by the plug->cur_ktime optimisation
> rather than anything more material.

What is the base value? If it's microseconds, IO performance should
actually be better.
> 
> It appears as though a task can enter __submit_bio() with ->plug set
> and a very stale cur_ktime value on the order of milliseconds. Is this
> expected behaviour? It looks like it leads to inaccurate I/O times.
> 

For microseconds I think it's expected, however, I don't think
milliseconds is acceptable.
> Thanks,
> Matt
> 
> ---->8----
> $ sudo bpftrace -e 'k:__submit_bio { $p = curtask->plug; if ($p != 0)
> { if (((nsecs - $p->cur_ktime) / 1000) > 10000) { @[kstack] =
> count();}}}'

Can you drop this expensive bpftrace script which might affect IO
performance, and replace __submit_bio directly to __blk_flush_plug? If
nsecs - plug->cur_ktime is still milliseconds, can you check if the
following patch can fix your problem?

Thanks,
Kuai

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ae8494d88897..37197502147e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1095,7 +1095,9 @@ static inline void blk_account_io_start(struct 
request *req)
                 return;

         req->rq_flags |= RQF_IO_STAT;
-       req->start_time_ns = blk_time_get_ns();
+
+       if (!current->plug)
+               req->start_time_ns = blk_time_get_ns();

         /*
          * All non-passthrough requests are created from a bio with one
@@ -2874,6 +2876,7 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, 
bool from_schedule)
  {
         struct request *rq;
         unsigned int depth;
+       u64 now;

         /*
          * We may have been called recursively midway through handling
@@ -2887,6 +2890,10 @@ void blk_mq_flush_plug_list(struct blk_plug 
*plug, bool from_schedule)
         depth = plug->rq_count;
         plug->rq_count = 0;

+       now = ktime_get_ns();
+       rq_list_for_each(&plug->mq_list, rq)
+               rq->start_time_ns = now;
+
         if (!plug->multiple_queues && !plug->has_elevator && 
!from_schedule) {
                 struct request_queue *q;


> Attaching 1 probe...
> ^C
> 
> @[
>      __submit_bio+1
>      submit_bio_noacct_nocheck+390
>      submit_bio_wait+92
>      swap_writepage_bdev_sync+262
>      swap_writepage+315
>      pageout+291
>      shrink_folio_list+1835
>      shrink_lruvec+1683
>      shrink_node+784
>      balance_pgdat+877
>      kswapd+496
>      kthread+207
>      ret_from_fork+49
>      ret_from_fork_asm+26
> ]: 184
> @[
>      __submit_bio+1
>      submit_bio_noacct_nocheck+390
>      _xfs_buf_ioapply+599
>      __xfs_buf_submit+110
>      xfs_buf_delwri_submit_buffers+399
>      xfsaild+691
>      kthread+207
>      ret_from_fork+49
>      ret_from_fork_asm+26
> ]: 28123
> 
> .
> 

