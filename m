Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08ECC04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 11:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234943AbiG1LBc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 07:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiG1LBa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 07:01:30 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BED56B9B
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 04:01:29 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VKfPZUz_1659006085;
Received: from 172.20.10.3(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VKfPZUz_1659006085)
          by smtp.aliyun-inc.com;
          Thu, 28 Jul 2022 19:01:27 +0800
Message-ID: <4ae376de-db1b-930c-1c26-c4551116ab05@linux.alibaba.com>
Date:   Thu, 28 Jul 2022 19:01:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH V3 2/2] ublk_drv: add support for UBLK_IO_NEED_GET_DATA
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com
References: <cover.1658999030.git.ZiyangZhang@linux.alibaba.com>
 <925d386f6cfaf7df3221dc7502ca8d9fb7f17538.1658999030.git.ZiyangZhang@linux.alibaba.com>
 <YuJn2lEMdYGl5An9@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <YuJn2lEMdYGl5An9@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/7/28 18:41, Ming Lei wrote:
> On Thu, Jul 28, 2022 at 05:31:24PM +0800, ZiyangZhang wrote:
>> UBLK_IO_NEED_GET_DATA is one ublk IO command. It is designed for a user
>> application who wants to allocate IO buffer and set IO buffer address
>> only after it receives an IO request from ublksrv. This is a reasonable
>> scenario because these users may use a RPC framework as one IO backend
>> to handle IO requests passed from ublksrv. And a RPC framework may
>> allocate its own buffer(or memory pool).
>>
>> This new feature (UBLK_F_NEED_GET_DATA) is optional for ublk users.
>> Related userspace code has been added in ublksrv[1] as one pull request.
>>
>> Test cases for this feature are added in ublksrv and all the tests pass.
>> The performance result shows that this new feature does bring additional
>> latency because one IO is issued back to ublk_drv once again to copy data
>> from bio vectors to user-provided data buffer. UBLK_IO_NEED_GET_DATA is
>> suitable for bigger block size such as 512B or 1MB.
>>
>> [1] https://github.com/ming1/ubdsrv
>>
>> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
>> ---
>>  drivers/block/ublk_drv.c | 96 ++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 87 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 255b2de46a24..ea60853d80a1 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -47,7 +47,9 @@
>>  #define UBLK_MINORS		(1U << MINORBITS)
>>  
>>  /* All UBLK_F_* have to be included into UBLK_F_ALL */
>> -#define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY | UBLK_F_URING_CMD_COMP_IN_TASK)
>> +#define UBLK_F_ALL (UBLK_F_SUPPORT_ZERO_COPY \
>> +		| UBLK_F_URING_CMD_COMP_IN_TASK \
>> +		| UBLK_F_NEED_GET_DATA)
>>  
>>  struct ublk_rq_data {
>>  	struct callback_head work;
>> @@ -86,6 +88,15 @@ struct ublk_uring_cmd_pdu {
>>   */
>>  #define UBLK_IO_FLAG_ABORTED 0x04
>>  
>> +/*
>> + * UBLK_IO_FLAG_NEED_GET_DATA is set because IO command requires
>> + * get data buffer address from ublksrv.
>> + *
>> + * Then, bio data could be copied into this data buffer for a WRITE request
>> + * after the IO command is issued again and UBLK_IO_FLAG_NEED_GET_DATA is unset.
>> + */
>> +#define UBLK_IO_FLAG_NEED_GET_DATA 0x08
>> +
>>  struct ublk_io {
>>  	/* userspace buffer address from io cmd */
>>  	__u64	addr;
>> @@ -168,6 +179,13 @@ static inline bool ublk_can_use_task_work(const struct ublk_queue *ubq)
>>  	return false;
>>  }
>>  
>> +static inline bool ublk_need_get_data(const struct ublk_queue *ubq)
>> +{
>> +	if (ubq->flags & UBLK_F_NEED_GET_DATA)
>> +		return true;
>> +	return false;
>> +}
>> +
>>  static struct ublk_device *ublk_get_device(struct ublk_device *ub)
>>  {
>>  	if (kobject_get_unless_zero(&ub->cdev_dev.kobj))
>> @@ -509,6 +527,21 @@ static void __ublk_fail_req(struct ublk_io *io, struct request *req)
>>  	}
>>  }
>>  
>> +static void ubq_complete_io_cmd(struct ublk_io *io, int res)
>> +{
>> +	/* mark this cmd owned by ublksrv */
>> +	io->flags |= UBLK_IO_FLAG_OWNED_BY_SRV;
>> +
>> +	/*
>> +	 * clear ACTIVE since we are done with this sqe/cmd slot
>> +	 * We can only accept io cmd in case of being not active.
>> +	 */
>> +	io->flags &= ~UBLK_IO_FLAG_ACTIVE;
>> +
>> +	/* tell ublksrv one io request is coming */
>> +	io_uring_cmd_done(io->cmd, res, 0);
>> +}
>> +
>>  #define UBLK_REQUEUE_DELAY_MS	3
>>  
>>  static inline void __ublk_rq_task_work(struct request *req)
>> @@ -531,6 +564,20 @@ static inline void __ublk_rq_task_work(struct request *req)
>>  		return;
>>  	}
>>  
>> +	if (ublk_need_get_data(ubq) &&
>> +			(req_op(req) == REQ_OP_WRITE ||
>> +			req_op(req) == REQ_OP_FLUSH) &&
>> +			!(io->flags & UBLK_IO_FLAG_NEED_GET_DATA)) {
>> +
>> +		io->flags |= UBLK_IO_FLAG_NEED_GET_DATA;
>> +
>> +		pr_devel("%s: ublk_need_get_data. op %d, qid %d tag %d io_flags %x\n",
>> +				__func__, io->cmd->cmd_op, ubq->q_id, req->tag, io->flags);
>> +
>> +		ubq_complete_io_cmd(io, UBLK_IO_RES_NEED_GET_DATA);
>> +		return;
>> +	}
>> +
>>  	mapped_bytes = ublk_map_io(ubq, req, io);
>>  
>>  	/* partially mapped, update io descriptor */
>> @@ -553,17 +600,13 @@ static inline void __ublk_rq_task_work(struct request *req)
>>  			mapped_bytes >> 9;
>>  	}
>>  
>> -	/* mark this cmd owned by ublksrv */
>> -	io->flags |= UBLK_IO_FLAG_OWNED_BY_SRV;
>> -
>>  	/*
>> -	 * clear ACTIVE since we are done with this sqe/cmd slot
>> -	 * We can only accept io cmd in case of being not active.
>> +	 * Anyway, we have handled UBLK_IO_NEED_GET_DATA for WRITE/FLUSH requests,
>> +	 * or we did nothing for other types requests.
>>  	 */
>> -	io->flags &= ~UBLK_IO_FLAG_ACTIVE;
>> +	io->flags &= ~UBLK_IO_FLAG_NEED_GET_DATA;
> 
> Please move clearing UBLK_IO_FLAG_NEED_GET_DATA into ublk_handle_need_get_data().
> 
> UBLK_IO_FLAG_NEED_GET_DATA should only be touched in case that UBLK_F_NEED_GET_DATA
> is set, also it becomes more readable.
> 
> Otherwise, this patch looks fine.
> 

Ok, it will be fixed in V4.

Thanks,
Zhang
