Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF963CA9EA0
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 11:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A4F21D7F
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 11:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfKDLqm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:46:42 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40052 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbfKDLql (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 Nov 2019 06:46:41 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 04D2911319F6B9EDF8A4;
        Mon,  4 Nov 2019 19:46:40 +0800 (CST)
Received: from [127.0.0.1] (10.133.210.141) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Mon, 4 Nov 2019
 19:46:33 +0800
Subject: Re: [RFC] io_uring: stop only support read/write for ctx with
 IORING_SETUP_IOPOLL
To:     Bob Liu <bob.liu@oracle.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yi.zhang@huawei.com>
References: <20191104085608.44816-1-yangerkun@huawei.com>
 <a01cc299-69e7-daa2-6894-1c60aaa64e67@oracle.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <3fd0dee1-52d6-4ea8-53d8-2c88b7fedce6@huawei.com>
Date:   Mon, 4 Nov 2019 19:46:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <a01cc299-69e7-daa2-6894-1c60aaa64e67@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.210.141]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019/11/4 18:09, Bob Liu wrote:
> On 11/4/19 4:56 PM, yangerkun wrote:
>> There is no problem to support other type request for the ctx with
>> IORING_SETUP_IOPOLL.
> 
> Could you describe the benefit of doing this?

Hi,

I am trying to replace libaio with io_uring in InnoDB/MariaDB(which
build on xfs/nvme). And in order to simulate the timeout mechanism
like io_getevents, firstly, to use the poll function of io_uring's fd 
has been selected and it really did work. But while trying to enable
IORING_SETUP_IOPOLL since xfs has iopoll function interface, the
mechanism will fail since io_uring_poll does check the cq.head between
cached_cq_tail, which will not update until we call io_uring_enter and
do the poll. So, instead, I decide to use timeout requests in
io_uring but will return -EINVAL since we enable IORING_SETUP_IOPOLL
at the same time. I think this combination is a normal scene so as
the other combination descibed in this patch. I am not sure does it a
good solution for this problem, and maybe there exists some better way.

Thanks,
Kun.



> 
>> What we should do is just insert read/write
>> requests to poll list, and protect cqes with comopletion_lock in
>> io_iopoll_complete since other requests now can be completed as the same
>> time while we do io_iopoll_complete.
>>
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> ---
>>   fs/io_uring.c | 29 +++++++++--------------------
>>   1 file changed, 9 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index f9a38998f2fc..8bf52d9a2c55 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -753,9 +753,11 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
>>   {
>>   	void *reqs[IO_IOPOLL_BATCH];
>>   	struct io_kiocb *req;
>> +	unsigned long flags;
>>   	int to_free;
>>   
>>   	to_free = 0;
>> +	spin_lock_irqsave(&ctx->completion_lock, flags);
>>   	while (!list_empty(done)) {
>>   		req = list_first_entry(done, struct io_kiocb, list);
>>   		list_del(&req->list);
>> @@ -781,6 +783,7 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
>>   	}
>>   
>>   	io_commit_cqring(ctx);
>> +	spin_unlock_irqrestore(&ctx->completion_lock, flags);
>>   	io_free_req_many(ctx, reqs, &to_free);
>>   }
>>   
>> @@ -1517,9 +1520,6 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
>>   	struct io_ring_ctx *ctx = req->ctx;
>>   	long err = 0;
>>   
>> -	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
>> -		return -EINVAL;
>> -
>>   	io_cqring_add_event(ctx, user_data, err);
>>   	io_put_req(req);
>>   	return 0;
>> @@ -1527,13 +1527,9 @@ static int io_nop(struct io_kiocb *req, u64 user_data)
>>   
>>   static int io_prep_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>   {
>> -	struct io_ring_ctx *ctx = req->ctx;
>> -
>>   	if (!req->file)
>>   		return -EBADF;
>>   
>> -	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
>> -		return -EINVAL;
>>   	if (unlikely(sqe->addr || sqe->ioprio || sqe->buf_index))
>>   		return -EINVAL;
>>   
>> @@ -1574,14 +1570,11 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>>   
>>   static int io_prep_sfr(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>   {
>> -	struct io_ring_ctx *ctx = req->ctx;
>>   	int ret = 0;
>>   
>>   	if (!req->file)
>>   		return -EBADF;
>>   
>> -	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
>> -		return -EINVAL;
>>   	if (unlikely(sqe->addr || sqe->ioprio || sqe->buf_index))
>>   		return -EINVAL;
>>   
>> @@ -1627,9 +1620,6 @@ static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>>   	struct socket *sock;
>>   	int ret;
>>   
>> -	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
>> -		return -EINVAL;
>> -
>>   	sock = sock_from_file(req->file, &ret);
>>   	if (sock) {
>>   		struct user_msghdr __user *msg;
>> @@ -1712,8 +1702,6 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>   	struct io_kiocb *poll_req, *next;
>>   	int ret = -ENOENT;
>>   
>> -	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
>> -		return -EINVAL;
>>   	if (sqe->ioprio || sqe->off || sqe->len || sqe->buf_index ||
>>   	    sqe->poll_events)
>>   		return -EINVAL;
>> @@ -1833,8 +1821,6 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>   	__poll_t mask;
>>   	u16 events;
>>   
>> -	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
>> -		return -EINVAL;
>>   	if (sqe->addr || sqe->ioprio || sqe->off || sqe->len || sqe->buf_index)
>>   		return -EINVAL;
>>   	if (!poll->file)
>> @@ -1932,8 +1918,6 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>   	struct timespec64 ts;
>>   	unsigned span = 0;
>>   
>> -	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
>> -		return -EINVAL;
>>   	if (sqe->flags || sqe->ioprio || sqe->buf_index || sqe->timeout_flags ||
>>   	    sqe->len != 1)
>>   		return -EINVAL;
>> @@ -2032,6 +2016,7 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>>   			   const struct sqe_submit *s, bool force_nonblock)
>>   {
>>   	int ret, opcode;
>> +	bool poll = false;
>>   
>>   	req->user_data = READ_ONCE(s->sqe->user_data);
>>   
>> @@ -2046,17 +2031,21 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>>   	case IORING_OP_READV:
>>   		if (unlikely(s->sqe->buf_index))
>>   			return -EINVAL;
>> +		poll = true;
>>   		ret = io_read(req, s, force_nonblock);
>>   		break;
>>   	case IORING_OP_WRITEV:
>>   		if (unlikely(s->sqe->buf_index))
>>   			return -EINVAL;
>> +		poll = true;
>>   		ret = io_write(req, s, force_nonblock);
>>   		break;
>>   	case IORING_OP_READ_FIXED:
>> +		poll = true;
>>   		ret = io_read(req, s, force_nonblock);
>>   		break;
>>   	case IORING_OP_WRITE_FIXED:
>> +		poll = true;
>>   		ret = io_write(req, s, force_nonblock);
>>   		break;
>>   	case IORING_OP_FSYNC:
>> @@ -2088,7 +2077,7 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
>>   	if (ret)
>>   		return ret;
>>   
>> -	if (ctx->flags & IORING_SETUP_IOPOLL) {
>> +	if ((ctx->flags & IORING_SETUP_IOPOLL) && poll) {
>>   		if (req->result == -EAGAIN)
>>   			return -EAGAIN;
>>   
>>
> 
> 
> .
> 

