Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2E2360ED7
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 12:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782734418; cv=none; b=hgqtPNT07/JiElGRJfJB/wZN692hiZXm+Bdes8Sk8Cz0Ag0KV3+ycLmBVKZ+Dw31/io0vjGUzC96FRQKCxrFY9z1xM6a504Ro+jB8c6Wnr0O4l3fvvPAP5Wks+PYODvXpUl2GE+zWqJ9TSZaoPWdqQuzojeYARX2QPmxe+c+eE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782734418; c=relaxed/simple;
	bh=hEfee0791xBzCRT9V06HDlt2RFRTgmlr8nCPYbLSNwE=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XsPZorqM0qz/9iGoVqABJEjgLwFAvVbpifkuwDj6KZ900KydnSeV6sjMPOT0EK8YpLBSQKy/gY4H59I5dn609qc6i5lFpKAMhvCvdXTK2am/BdoWX78qZudRfSkdZJHog6X8hHA8GeosnEU3Gd876obOLwWKzU6xxDFveYAzJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gplF32RD1zYQtwp
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 19:59:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5B13B40586
	for <linux-block@vger.kernel.org>; Mon, 29 Jun 2026 20:00:10 +0800 (CST)
Received: from [10.174.178.185] (unknown [10.174.178.185])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgCHWodIXkJqQ4j3AA--.50413S3;
	Mon, 29 Jun 2026 20:00:10 +0800 (CST)
Subject: Re: [PATCH] blk-flush: fix possibe deadlock when process
 nvme_timeout()
To: axboe@kernel.dk, linux-block@vger.kernel.org, yebin10@huawei.com
References: <20260608113923.3893518-1-yebin@huaweicloud.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
From: yebin <yebin@huaweicloud.com>
Message-ID: <6A425E48.3050109@huaweicloud.com>
Date: Mon, 29 Jun 2026 20:00:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260608113923.3893518-1-yebin@huaweicloud.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCHWodIXkJqQ4j3AA--.50413S3
X-Coremail-Antispam: 1UD129KBjvJXoW3JFW8CF18Ww1UKF48tw17trb_yoW7WFy7pF
	WYqa90krn5Wr1ktr4xJw4kAw1v9ws2yF43JF1Skr13Ars5C392kFyrtryFqF13AwnYvrWr
	WF4qgF4DXFWqv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

Friendly ping ...

This issue occurs once every week in our product's live network environment.
The root cause is certainly triggered by firmware issues. The kernel still
needs to reinforce this scenario to prevent system hangs caused by dead loops.


In `blk_mq_tagset_wait_completed_request()`, the reference count is continuously
acquired and released, and there is still a chance for the request to be in the
MQ_RQ_IDLE state. Therefore, the race condition pointed out by sashiko exists,
but in this scenario, it can still be handled correctly in the end.

[1] https://sashiko.dev/#/patchset/20260608113923.3893518-1-yebin%40huaweicloud.com

On 2026/6/8 19:39, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
>
>   There's when process nvme_timeout():
>   [  206.734601][ T8184] nvme nvme0: I/O tag 512 (1200) opcode 0x0 (I/O Cmd) QID 3 timeout, aborting req_op:FLUSH(2) size:0
>   [  206.736112][    C0] nvme nvme0: Abort status: 0x0
>   [  208.094637][ T8184] nvme nvme0: I/O tag 512 (1200) opcode 0x0 (I/O Cmd) QID 3 timeout, reset controller
>
>   [root@localhost ~]# cat /proc/8184/stack
>   [<0>] msleep+0x37/0x50
>   [<0>] blk_mq_tagset_wait_completed_request+0x6f/0xe0
>   [<0>] nvme_cancel_tagset+0x79/0xa0
>   [<0>] nvme_dev_disable+0x55c/0x7e0
>   [<0>] nvme_timeout+0x25b/0x1530
>   [<0>] blk_mq_handle_expired+0x210/0x2c0
>   [<0>] bt_iter+0x2bb/0x360
>   [<0>] blk_mq_queue_tag_busy_iter+0x9f8/0x1f30
>   [<0>] blk_mq_timeout_work+0x5dc/0x7d0
>   [<0>] process_one_work+0xa08/0x1d00
>   [<0>] worker_thread+0x698/0xeb0
>   [<0>] kthread+0x408/0x540
>   [<0>] ret_from_fork+0xa4d/0xdd0
>   [<0>] ret_from_fork_asm+0x1a/0x30
>
>   Above issue may happen as follows:
>   nvme_timeout  // tag 512 request's flush request the first timeout
>     iod->aborted = 1;
>     abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
>            BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);  // Abort tag 512 flush request
>     blk_execute_rq_nowait(abort_req->q, NULL, abort_req, 0, abort_endio);
>        // Abort request completion, will no wait
>           ....
>    ****'abort_req' not complete***
>           ....
>   nvme_timeout  // tag 512 request's flush request the second timeout
>    if (!nvmeq->qid || (iod->flags & IOD_ABORTED))
>      nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>      goto disable;
>        ...
>      **** tag 512 request's flush request end ****
>           nvme_try_complete_req
>            blk_mq_complete_request_remote(req);
>             WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
>              ...
>               nvme_end_req(req);
>                blk_mq_end_request(req, status);
>                 __blk_mq_end_request(rq, error);
>                  if (rq->end_io)
>                   rq->end_io(rq, error);
>                    flush_end_io(rq, error);
>                    // The timeout process holds the reference count.
>                    // so request keep MQ_RQ_COMPLETE state
>                     if (!refcount_dec_and_test(&flush_rq->ref))
>                      fq->rq_status = error;
>                      return;
>      **** tag 512 flush request is MQ_RQ_COMPLETE state ****
>   disable:
>     nvme_dev_disable(dev, false);
>       nvme_cancel_tagset(&dev->ctrl);
>         blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request,
>                                 &dev->ctrl);
>           nvme_cancel_request
>             if (blk_mq_request_completed(req))
>               return true;
>        blk_mq_tagset_wait_completed_request(&dev->tagset);
>          while (true)
>            blk_mq_tagset_busy_iter(tagset,
>                             blk_mq_tagset_count_completed_rqs, &count);
>               blk_mq_tagset_count_completed_rqs();
>               // request is MQ_RQ_COMPLETE state
>                  if (blk_mq_request_completed(rq))   // return true
>                    (*count)++;
>            if (!count) // So the value of 'count' is never 0, loop endless
>                break;
>            msleep(5);
> The preceding problem occurs because the timeout processing flow holds
> the reference count of the request, and the flush request is always in
> the MQ_RQ_COMPLETE state due to the special nature of the flush request.
> As a result, a dead loop occurs in the nvme_dev_disable() process.
> To solve the preceding problem, if only the timeout processing flow holds
> the reference count when the flush request times out, the request status
> must be changed to MQ_RQ_IDLE in advance. In this way, it is safe to call
> blk_mq_tagset_wait_completed_request () during the timeout processing.
>
> Fixes: e1569a16180a ("nvme: do not restart the request timeout if we're resetting the controller")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>   block/blk-flush.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/block/blk-flush.c b/block/blk-flush.c
> index 403a46c86411..d12839b1fcb5 100644
> --- a/block/blk-flush.c
> +++ b/block/blk-flush.c
> @@ -213,6 +213,18 @@ static enum rq_end_io_ret flush_end_io(struct request *flush_rq,
>
>   	if (!req_ref_put_and_test(flush_rq)) {
>   		fq->rq_status = error;
> +
> +		/*
> +		 * The timeout processing flow holds the reference count
> +		 * of flush_rq. If the last reference count is held by the
> +		 * timeout processing flow, the status of flush_rq must be
> +		 * changed to MQ_RQ_IDLE in advance. Otherwise, a deadlock
> +		 * occurs when blk_mq_tagset_wait_completed_request() is
> +		 * called in the timeout processing flow.
> +		 */
> +		if (req_ref_read(flush_rq) == 1 &&
> +		    flush_rq->rq_flags & RQF_TIMED_OUT)
> +			WRITE_ONCE(flush_rq->state, MQ_RQ_IDLE);
>   		spin_unlock_irqrestore(&fq->mq_flush_lock, flags);
>   		return RQ_END_IO_NONE;
>   	}
>

