Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1655DC3A59D
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 06:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD9D20644
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 06:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfHPGr5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:47:57 -0400
Received: from smtpproxy19.qq.com ([184.105.206.84]:51796 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPGr5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 02:47:57 -0400
X-QQ-mid: bizesmtp27t1565938070tzai48ls
Received: from [192.168.142.168] (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Fri, 16 Aug 2019 14:47:50 +0800 (CST)
X-QQ-SSF: 00400000002000R0XR80000A0000000
X-QQ-FEAT: CZN8kOMUg8vTKr96C5yoEdQ4KYqv9QU5GfXQ01Sy0O16dCc6QeNpM82slc97r
        8UONPA5ewtPngF6HvbWfv5alu2d7salD0C8Bwv//rcXP/7IdOhXfJWghUkOfFiyOMfFXRur
        r4uNkHuHnluuudBfJ0OlmgUHWaA0jHR2rpQAPtcpmlXOL54FKunSoMhfauDUtxCby2M+brH
        FIRmZxf+W+ACn/opM1bM2dzaJE2GOHcFf/AmHpisjatobfpaWPxQIe1JdbLb4AXeJyshhzh
        0Rhs8EV4nzJ7fxKYZdt8GA9CVYj6xGzsEfxzTNz1rH+iiR537m3O82AQOt7kSGeRVge/HO5
        U6jz0ZJB9aYuW//9ggk1FONhcybHA==
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] io_uring: fix issue when IOSQE_IO_DRAIN pass with
 IOSQE_IO_LINK
From:   Jackie Liu <liuyun01@kylinos.cn>
In-Reply-To: <ebe617aa-1a63-bd70-4096-e8f67b9f8adb@kernel.dk>
Date:   Fri, 16 Aug 2019 14:47:49 +0800
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <C052542E-0AC9-4BC0-9C59-FA1F7F023A73@kylinos.cn>
References: <1565775322-10296-1-git-send-email-liuyun01@kylinos.cn>
 <d72a6911-d1fb-5c88-7992-8d4715ddbcc8@kernel.dk>
 <6EC9DDF3-3142-4FE1-831B-E5A823FBFC51@kylinos.cn>
 <ebe617aa-1a63-bd70-4096-e8f67b9f8adb@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> 在 2019年8月16日，09:21，Jens Axboe <axboe@kernel.dk> 写道：
> 
> On 8/15/19 6:48 PM, Jackie Liu wrote:
>> 
>> 在 2019年8月16日，01:07，Jens Axboe <axboe@kernel.dk> 写道：
>> 
>>> 
>>> On 8/14/19 3:35 AM, Jackie Liu wrote:
>>>> Suppose there are three IOs here, and their order is as follows:
>>>> 
>>>> Submit:
>>>> 	[1] IO_LINK
>>>> 	    |
>>>> 	    |---  [2] IO_LINK | IO_DRAIN
>>>> 		      |
>>>> 		      |- [3] NORMAL_IO
>>>> 
>>>> In theory, they all need to be inserted into the Link-list, but flag
>>>> IO_DRAIN we have, io[2] and io[3] will be inserted into the defer_list,
>>>> and finally, io[3] and io[2] will be processed at the same time.
>>>> 
>>>> Now, it is directly forbidden to pass these two flags at the same time.
>>>> 
>>>> Fixes: 9e645e1105c ("io_uring: add support for sqe links")
>>>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>>>> ---
>>>>  fs/io_uring.c | 7 ++++++-
>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>> 
>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>> index d542f1c..05ee628 100644
>>>> --- a/fs/io_uring.c
>>>> +++ b/fs/io_uring.c
>>>> @@ -2074,10 +2074,13 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
>>>>  {
>>>>  	struct io_uring_sqe *sqe_copy;
>>>>  	struct io_kiocb *req;
>>>> +	unsigned int flags;
>>>>  	int ret;
>>>> 
>>>> +	flags = READ_ONCE(s->sqe->flags);
>>>>  	/* enforce forwards compatibility on users */
>>>> -	if (unlikely(s->sqe->flags & ~SQE_VALID_FLAGS)) {
>>>> +	if (unlikely((flags & ~SQE_VALID_FLAGS) ||
>>>> +		     (flags & (IOSQE_IO_DRAIN | IOSQE_IO_LINK)))) {
>>> 
>>> This doesn't look right, as any setting of either DRAIN or LINK would now
>>> fail?
>>> 
>>> Did you mean something ala:
>>> 
>>> 	if ((flags & (IOSQE_IO_DRAIN | IOSQE_IO_LINK)) ==
>>> 	    (IOSQE_IO_DRAIN | IOSQE_IO_LINK)) {
>>> 		... fail ...
>>> 	}
>>> 
>>> which makes me worried that you didn't test this at all...
>>> 
>>> -- 
>>> Jens Axboe
>> 
>> Oh, yes, it's my fault, I just simulated it in my head, thank you for
>> pointing out.  I think I'd add an [RFC PATCH] next time.
> 
> Even for an RFC, it better be more tested than just being thought
> about... If something hasn't been run at all, it should always include
> wording to that effect ("Totally untested, but something like this
> perhaps"). I have higher expectations for even an RFC patch, I do expect
> that to be both thought about AND tested.
> 
>> For this issue, I have two solutions, first is this, just avoid
>> passing DRAIN and LINK at the same time; second is allow, let the SQE
>> following LINK inherit the DRAIN flag, but It's more complicated, I
>> prefer the first one.
>> 
>> I will rewrite this patch later, with a real test. Thanks again.
> 
> If an SQE has both set, it should first wait for any inflight sqe to
> complete, then execute the chain. Once things have drained, it should
> behave like an SQE that just had LINK set. I'd be interested in seeing a
> patch that fixes this instead of just making it illegal, it seems to be
> a valid use case.
> 

How about this, We consider link list as a whole, and any IO among them
that has drain will mark the first IO as drain, which is easy to implement.
Of course, there is no clear order between IO in link list and IO in defer_list,
so there maybe have a problems. 

If we want to keep a clear order between link list and defer_list, maybe need to
add more flags and variables. my initial implementation is very complicated. 
do you have any good idea?

First idea patch like follow. untested, just a idea.

---
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6b572c4..bc0b535 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1995,10 +1995,15 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
        flags = READ_ONCE(s->sqe->flags);
        fd = READ_ONCE(s->sqe->fd);

-       if (flags & IOSQE_IO_DRAIN) {
+       if (flags & IOSQE_IO_DRAIN)
                req->flags |= REQ_F_IO_DRAIN;
-               req->sequence = ctx->cached_sq_head - 1;
-       }
+
+       /*
+        * All io need record the previous position, if LINK vs DARIN,
+        * it can be used to mark the position of the first IO in the
+        * link list.
+        */
+       req->sequence = ctx->cached_sq_head - 1;

        if (!io_op_needs_file(s->sqe))
                return 0;
@@ -2123,6 +2128,12 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
                }

                s->sqe = sqe_copy;
+               /*
+                * Mark the first IO in link list as DRAIN, let all the following
+                * IOs enter the defer list.
+                */
+               if (s->sqe->flags & IOSQE_IO_DRAIN)
+                       prev->flags |= REQ_F_IO_DRAIN;
                memcpy(&req->submit, s, sizeof(*s));
                list_add_tail(&req->list, &prev->link_list);
        } else if (s->sqe->flags & IOSQE_IO_LINK) {


--
Jackie Liu



