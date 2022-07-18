Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E511BC43334
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 12:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiGRMKr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 08:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbiGRMKq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 08:10:46 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B221BF
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 05:10:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJlvYMf_1658146240;
Received: from 30.97.56.227(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VJlvYMf_1658146240)
          by smtp.aliyun-inc.com;
          Mon, 18 Jul 2022 20:10:41 +0800
Message-ID: <2234026d-5822-71e8-0923-c43a2b5fe077@linux.alibaba.com>
Date:   Mon, 18 Jul 2022 20:10:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] ublk_drv: fix build warning with -Wmaybe-uninitialized
 and one sparse warning
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
References: <20220716095344.222674-1-ming.lei@redhat.com>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20220716095344.222674-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/7/16 17:53, Ming Lei wrote:
> After applying -Wmaybe-uninitialized manually, two build warnings are
> triggered:
> 
> drivers/block/ublk_drv.c:940:11: warning: ‘io’ may be used uninitialized [-Wmaybe-uninitialized]
>   940 |         io->flags &= ~UBLK_IO_FLAG_ACTIVE;
> 
> drivers/block/ublk_drv.c: In function ‘ublk_ctrl_uring_cmd’:
> drivers/block/ublk_drv.c:1531:9: warning: ‘ret’ may be used uninitialized [-Wmaybe-uninitialized]
> 
> Fix the 1st one by removing 'io->flags &= ~UBLK_IO_FLAG_ACTIVE;' which
> isn't needed since the function always return successfully after setting
> this flag.
> 
> Fix the 2nd one by always initializing 'ret'.
> 
> Also fix another sparse warning of 'sparse: sparse: incorrect type in return
> expression' by changing return type of ublk_setup_iod().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index f10c4319dc1f..2c1b01d7f27d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -407,7 +407,7 @@ static inline unsigned int ublk_req_build_flags(struct request *req)
>  	return flags;
>  }
>  
> -static int ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
> +static blk_status_t ublk_setup_iod(struct ublk_queue *ubq, struct request *req)
>  {
>  	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
>  	struct ublk_io *io = &ubq->ios[req->tag];
> @@ -937,7 +937,6 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  	return -EIOCBQUEUED;
>  
>   out:
> -	io->flags &= ~UBLK_IO_FLAG_ACTIVE;
>  	io_uring_cmd_done(cmd, ret, 0);

Hi Ming,

Actually I found one potential bug BEFORE this commit.

In ublk_ch_uring_cmd(), there is a check:

	/* there is pending io cmd, something must be wrong */
	if (io->flags & UBLK_IO_FLAG_ACTIVE) {
		ret = -EBUSY;
		goto out;
	}

Now assume that:

 (1) We get a second(duplicate) ublk cmd(such as UBLK_IO_COMMIT_AND_FETCH_REQ)
     on the same tag and queue from a malicious app,
     the check fails as expected because UBLK_IO_FLAG_ACTIVE has been set 
     and ublk_io is queued. 

 (2) We goto label "out" and execute: 
        io->flags &= ~UBLK_IO_FLAG_ACTIVE
           -->  "io_uring_cmd_done(cmd, ret, 0)(ret is -EBUSY)

 (2) Then, if the malicious app issues a third ublk cmd(the same cmd_op) on the same
     tag and queue, the check passes because UBLK_IO_FLAG_ACTIVE is unset
     (it should fail since it is a duplicate cmd)

In this commit you do fix it by removing "io->flags &= ~UBLK_IO_FLAG_ACTIVE"
in "out" routine for another reason.(‘io’ may be used uninitialized)

However I have just found a side effect(maybe fix a potential bug) and share it here. :)

>  	pr_devel("%s: complete: cmd op %d, tag %d ret %x io_flags %x\n",
>  			__func__, cmd_op, tag, ret, io->flags);
> @@ -1299,13 +1298,12 @@ static int ublk_ctrl_get_queue_affinity(struct io_uring_cmd *cmd)
>  	struct ublk_device *ub;
>  	unsigned long queue;
>  	unsigned int retlen;
> -	int ret;
> +	int ret = -EINVAL;
>  
>  	ub = ublk_get_device_from_id(header->dev_id);
>  	if (!ub)
>  		goto out;
>  
> -	ret = -EINVAL;
>  	queue = header->data[0];
>  	if (queue >= ub->dev_info.nr_hw_queues)
>  		goto out;
