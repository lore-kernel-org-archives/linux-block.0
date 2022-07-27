Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59FEC19F21
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 03:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240121AbiG0DJX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 23:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240033AbiG0DJT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 23:09:19 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA013C8FD
        for <linux-block@vger.kernel.org>; Tue, 26 Jul 2022 20:09:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=ziyangzhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VKYkXbj_1658891353;
Received: from 30.227.91.92(mailfrom:ZiyangZhang@linux.alibaba.com fp:SMTPD_---0VKYkXbj_1658891353)
          by smtp.aliyun-inc.com;
          Wed, 27 Jul 2022 11:09:14 +0800
Message-ID: <60bc9e53-605e-ee1d-9bd2-020693768339@linux.alibaba.com>
Date:   Wed, 27 Jul 2022 11:09:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH V2 2/2] ublk_drv: add support for UBLK_IO_NEED_GET_DATA
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com
References: <20220726114405.116013-1-ZiyangZhang@linux.alibaba.com>
 <20220726114405.116013-3-ZiyangZhang@linux.alibaba.com>
 <YuCdYsWw9+k7nCAF@T590>
From:   Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
In-Reply-To: <YuCdYsWw9+k7nCAF@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/7/27 10:05, Ming Lei wrote:
> On Tue, Jul 26, 2022 at 07:44:05PM +0800, ZiyangZhang wrote:
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
>>  drivers/block/ublk_drv.c | 88 ++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 79 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 255b2de46a24..c2d2cd5ab25c 100644
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
>> @@ -163,11 +174,19 @@ static struct miscdevice ublk_misc;
>>  static inline bool ublk_can_use_task_work(const struct ublk_queue *ubq)
>>  {
>>  	if (IS_BUILTIN(CONFIG_BLK_DEV_UBLK) &&
>> +			!(ubq->flags & UBLK_F_NEED_GET_DATA) &&
>>  			!(ubq->flags & UBLK_F_URING_CMD_COMP_IN_TASK))
>>  		return true;
>>  	return false;
> 
> NEED_GET_DATA isn't related with using task work.
> 
> That said if use task work return true, you use task work to handle
> GET_DATA, otherwise use io_uring_cmd_complete_in_task() to handle
> it, then either we use task work or use io_uring_cmd_complete_in_task,
> not mix the two.
> 
> BTW, in my test, it is observed reliably that task work can get better iops.

Ok, I will check whether UBLK_F_NEED_GET_DATA works with task_work_add().

I find that checking flags of ublk_io must stay in current ubq process.
Otherwise there may be potential data race while aborting IOs.
So whatever I use NEED_GET_DATA or not, task work is necessary. 

Using task_work_add() or io_uring_cmd_complete_in_task() depends on:
 (1) the module is built-in or not
 (2) the user requires the feature: UBLK_F_URING_CMD_COMP_IN_TASK

In the future, in our case, we may choose
UBLK_F_URING_CMD_COMP_IN_TASK | UBLK_F_NEED_GET_DATA as an option.

> 
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
>> @@ -509,6 +528,21 @@ static void __ublk_fail_req(struct ublk_io *io, struct request *req)
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
>> @@ -531,6 +565,20 @@ static inline void __ublk_rq_task_work(struct request *req)
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
>> @@ -553,17 +601,13 @@ static inline void __ublk_rq_task_work(struct request *req)
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
>>  
>> -	/* tell ublksrv one io request is coming */
>> -	io_uring_cmd_done(io->cmd, UBLK_IO_RES_OK, 0);
>> +	ubq_complete_io_cmd(io, UBLK_IO_RES_OK);
>>  }
>>  
>>  static void ublk_rq_task_work_cb(struct io_uring_cmd *cmd)
>> @@ -846,6 +890,16 @@ static void ublk_mark_io_ready(struct ublk_device *ub, struct ublk_queue *ubq)
>>  	mutex_unlock(&ub->mutex);
>>  }
>>  
>> +static void ublk_handle_need_get_data(struct ublk_device *ub, int q_id,
>> +		int tag, struct io_uring_cmd *cmd)
>> +{
>> +	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
>> +	struct request *req = blk_mq_tag_to_rq(ub->tag_set.tags[q_id], tag);
>> +
>> +	pdu->req = req;
>> +	io_uring_cmd_complete_in_task(cmd, ublk_rq_task_work_cb);
>> +}
> 
> Here you can choose to use task work or io_uring_cmd_complete_in_task() by
> checking ublk_can_use_task_work(), just like what ublk_queue_rq() does.

OK, I will add a check on ublk_can_use_task_work().

> 
>> +
>>  static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>>  {
>>  	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->cmd;
>> @@ -884,6 +938,14 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>>  		goto out;
>>  	}
>>  
>> +	/*
>> +	 * ensure that the user issues UBLK_IO_NEED_GET_DATA
>> +	 * iff the driver have set the UBLK_IO_FLAG_NEED_GET_DATA.
>> +	 */
>> +	if ((!!(io->flags & UBLK_IO_FLAG_NEED_GET_DATA))
>> +			^ (cmd_op == UBLK_IO_NEED_GET_DATA))
>> +		goto out;
>> +
>>  	switch (cmd_op) {
>>  	case UBLK_IO_FETCH_REQ:
>>  		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
>> @@ -917,6 +979,14 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>>  		io->cmd = cmd;
>>  		ublk_commit_completion(ub, ub_cmd);
>>  		break;
>> +	case UBLK_IO_NEED_GET_DATA:
>> +		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
>> +			goto out;
>> +		io->addr = ub_cmd->addr;
>> +		io->cmd = cmd;
>> +		io->flags |= UBLK_IO_FLAG_ACTIVE;
>> +		ublk_handle_need_get_data(ub, ub_cmd->q_id, ub_cmd->tag, cmd);
> 
> You still need to clear UBLK_IO_FLAG_OWNED_BY_SRV here.

If ublk_drv gets one UBLK_IO_NEED_GET_DATA command, it should immediately call
io_uring_cmd_complete_in_task() and handling NEED_GET_DATA logic in the task work.

Since UBLK_IO_FLAG_OWNED_BY_SRV means the "slot" is owned by nbd driver or ublk driver,
I don't think UBLK_IO_FLAG_OWNED_BY_SRV should be cleared.

BTW, UBLK_IO_FLAG_OWNED_BY_SRV is set in the task work finally.
> 
> In future, UBLK_IO_FLAG_OWNED_BY_SRV can be removed actually.

Agree. UBLK_IO_FLAG_OWNED_BY_SRV should be integrated with UBLK_IO_FLAG_ACTIVE.

Now I am trying to implement crash recovery mechanism and I concern about memory order
while operating these IO flags. IMO, too many IO flags looks dangerous
and I made mistakes on flags while developing UBLK_NEED_GET_DATA. :(

Thanks,
Zhang
