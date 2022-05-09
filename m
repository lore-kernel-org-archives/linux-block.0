Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F34C433EF
	for <linux-block@archiver.kernel.org>; Mon,  9 May 2022 11:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiEIL5E (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 May 2022 07:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbiEIL5D (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 May 2022 07:57:03 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C23248E3
        for <linux-block@vger.kernel.org>; Mon,  9 May 2022 04:53:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VCkPC54_1652097185;
Received: from 30.82.254.134(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0VCkPC54_1652097185)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 09 May 2022 19:53:06 +0800
Message-ID: <2ed84b17-e9cf-973f-170c-f56eb90517ba@linux.alibaba.com>
Date:   Mon, 9 May 2022 19:53:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: Follow up on UBD discussion
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        joseph.qi@linux.alibaba.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <874k27rfwm.fsf@collabora.com> <YnDhorlKgOKiWkiz@T590>
 <8a52ed85-3ffa-44a4-3e28-e13cdc793732@linux.alibaba.com>
 <YnaonsoDjQjrutRb@T590>
 <55edea6e-e7dc-054a-b79b-fcfc40c22f2f@linux.alibaba.com>
 <YnjEaM5T2aO0mlyi@T590>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
In-Reply-To: <YnjEaM5T2aO0mlyi@T590>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hi,

>
>>>> Second, I'd like to share some ideas on UBD. I'm not sure if they are
>>>> reasonable so please figure out my mistakes.
>>>>
>>>> 1) UBD issues one sqe to commit last completed request and fetch a new
>>>> one. Then, blk-mq's queue_rq() issues a new UBD IO request and completes
>>>> one cqe for the fetch command. We have evaluated that io_submit_sqes()
>>>> costs some CPU and steps of building a new sqe may lower throughput.
>>>> Here I'd like to give a new solution: never submit sqe but trump up a
>>>> cqe(with information of new UBD IO request) when calling queue_rq(). I
>>>> am inspired by one io_uring flag: IORING_POLL_ADD_MULTI, with which a
>>>> user issues only one sqe for polling an fd and repeatedly gets multiple
>>>> cqes when new events occur. Dose this solution break the architecture of
>>>> UBD?
>>> But each cqe has to be associated with one sqe, if I understand
>>> correctly.
>> Yeah, for current io_uring implementation, it is. But if io_uring offers below
>> helper:
>> void io_gen_cqe_direct(struct file *file, u64 user_data, s32 res, u32 cflags)
>> {
>>         struct io_ring_ctx *ctx;
>>         ctx = file->private_data;
>>
>>         spin_lock(&ctx->completion_lock);
>>         __io_fill_cqe(ctx, user_data, res, cflags);
>>         io_commit_cqring(ctx);
>>         spin_unlock(&ctx->completion_lock);
>>         io_cqring_ev_posted(ctx);
>> }
>>
>> Then in ubd driver:
>> 1) device setup stage
>> We attach io_uring files and user_data to every ubd hard queue.
>>
>> 2) when blk-mq->queue_rq() is called.
>> io_gen_cqe_direct() will be called in ubd's queue_rq, and we put ubd io request's
>> qid and tag info into cqe's res field, then we don't need to issue sqe to fetch io cmds.
> The above way is actually anti io_uring design, and I don't think it may
> improve much since submitting UBD_IO_COMMIT_AND_FETCH_REQ is pretty lightweight.
Actually I don't come up with this idea mostly for performance reason :) Just try to
simplify codes a bit:
1) In current implementation, ubdsrv will need to submit queue depth number of
sqes firstly, and ubd_ctrl_start_dev() will also need to wait all sqes to be submitted.
2) Try to make ubd_queue_rq simpler, it maybe just call one io_gen_cqe_direct().

>
> Also without re-submitting UBD_IO_COMMIT_AND_FETCH_REQ command, how can you
> commit io handling result from ubd server and ask ubd driver to complete
> io request?
No, I don't mean to remove COMMIT command, we still need io_uring async
command feature to support ubd COMMIT or GETDATA command.

I have another concern that currently there are may flags in ubd kernel or
ubdsrv, such as:
#define UBDSRV_NEED_FETCH_RQ (1UL << 0)
#define UBDSRV_NEED_COMMIT_RQ_COMP (1UL << 1)
#define UBDSRV_IO_FREE (1UL << 2)
#define UBDSRV_IO_HANDLING (1UL << 3)
#define UBDSRV_NEED_GET_DATA (1UL << 4)

Some of their names looks weird, for example UBDSRV_IO_FREE. I think
more flags may result in more state machine error.

Regards,
Xiaoguang Wang
>
>
> Thanks, 
> Ming

