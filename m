Return-Path: <SRS0=5xwa=YE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C644C4360C
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 03:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B99206A1
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 03:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfJKDHM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 23:07:12 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:57305 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbfJKDHM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 23:07:12 -0400
X-QQ-mid: bizesmtp26t1570763190t2zsd2mj
Received: from [172.20.0.236] (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Fri, 11 Oct 2019 11:06:29 +0800 (CST)
X-QQ-SSF: 00400000000000S0ZT90000A0000000
X-QQ-FEAT: IlL3FBEFeNhf2+Y44A7CG79jQ/f0DuQyZZDLs7NkHFeA+M3B36sd9Qi+fIGjm
        pGImsEz+gcz8CxIfvKnBU7dl2qXa+Qk8RBg+XeUCG5Xxia7MGYDzcM6mn7VCOQZnhrFd60H
        ByblAvQnWE6u3n1EzN5YKbRRDX56z0h09KwJI6p4lDIVE6zTU8eXu83jqCRuG0Jl6JwA+59
        zrOUlovlLQ1vD7MjjWBd/gTUzIpRwxUEVS5B6SerOcgfur8cYFBYqlc2CpXp9KytFYGzy9i
        1rHySBaXwdU95zt7S/+9Tor7Mm/Cr8MFcgUfempIfu4e1aMrsgUYln7pjOr96u5X1IAQCgS
        lU+tOO4Jwh7wBrm4b/IkNwp7q5A+Q==
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH 1/2] io_uring: make the logic clearer for
 io_sequence_defer
From:   Jackie Liu <liuyun01@kylinos.cn>
In-Reply-To: <597dc8a4-b9db-f0b7-21b5-12050f07e766@kernel.dk>
Date:   Fri, 11 Oct 2019 11:06:28 +0800
Cc:     yangerkun <yangerkun@huawei.com>, linux-block@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <544E51DB-7774-4DDF-A897-7A957AE2CDEB@kylinos.cn>
References: <20191009011959.2203-1-liuyun01@kylinos.cn>
 <7af32ce6-dc8f-6683-2b99-95eefb598bff@huawei.com>
 <597dc8a4-b9db-f0b7-21b5-12050f07e766@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3594.4.19)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> 2019年10月11日 10:35，Jens Axboe <axboe@kernel.dk> 写道：
> 
> On 10/10/19 8:24 PM, yangerkun wrote:
>> 
>> 
>> On 2019/10/9 9:19, Jackie Liu wrote:
>>> __io_get_deferred_req is used to get all defer lists, including defer_list
>>> and timeout_list, but io_sequence_defer should be only cares about the sequence.
>>> 
>>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>>> ---
>>>   fs/io_uring.c | 13 +++++--------
>>>   1 file changed, 5 insertions(+), 8 deletions(-)
>>> 
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index 8a0381f1a43b..8ec2443eb019 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -418,9 +418,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>>>   static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
>>>   				     struct io_kiocb *req)
>>>   {
>>> -	/* timeout requests always honor sequence */
>>> -	if (!(req->flags & REQ_F_TIMEOUT) &&
>>> -	    (req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>> +	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>>   		return false;
>>> 
>>>   	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
>>> @@ -435,12 +433,11 @@ static struct io_kiocb *__io_get_deferred_req(struct io_ring_ctx *ctx,
>>>   		return NULL;
>>> 
>>>   	req = list_first_entry(list, struct io_kiocb, list);
>>> -	if (!io_sequence_defer(ctx, req)) {
>>> -		list_del_init(&req->list);
>>> -		return req;
>>> -	}
>>> +	if (!(req->flags & REQ_F_TIMEOUT) && io_sequence_defer(ctx, req))
>>> +		return NULL;
>> Hi,
>> 
>> For timeout req, we should also compare the sequence to determine to
>> return NULL or the req. But now we will return req directly. Actually,
>> no need to compare req->flags with REQ_F_TIMEOUT.
> 
> Yes, not sure how I missed this, the patch is broken as-is. I will kill
> it, cleanup can be done differently.

Sorry for miss it, I don't wanna change the logic, it's not my original meaning.
Personal opinion, timeout list should not be mixed with defer_list, which makes
the code more complicated and difficult to understand.

--
BR, Jackie Liu



