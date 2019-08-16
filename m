Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E919C3A589
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 00:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164B12086C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 00:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfHPAsN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 20:48:13 -0400
Received: from smtpbgeu1.qq.com ([52.59.177.22]:42468 "EHLO smtpbgeu1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfHPAsN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 20:48:13 -0400
X-QQ-mid: bizesmtp25t1565916486tsazjz13
Received: from [192.168.142.168] (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Fri, 16 Aug 2019 08:48:05 +0800 (CST)
X-QQ-SSF: 00400000002000R0XR80B00A0000000
X-QQ-FEAT: 2UlNO5OcGzn4EhUU3HuLRyzBowu7/dHYBcZ+yF33wKUJvgdVxOD/J+V0WJx11
        lXixha+KTk/cAQU6IGH5rgPX5+p9BJI7fr+l7H6iL0KXfEAY3nqkKn2TAWShOk5uHMYLG4C
        7LjMbEbLVRDC0px9hEo1XTDuaTr8AIaHB7VF45k0CyY91m6H5qhjV4R8ctVuIZphcn0H10k
        OTDF98yq9gbd2C1hSQbyA88cQLyy9BvUTE+QoP59xVrH5thxr9frh7BeGn//8jskEZHLgeU
        cnobfp8RXoxvoZjVf73jvompaF6WMw+stzcKDmsv2tbXMxlvXcr6Oxiw/445wn7yoDiGu75
        b4ljvgoX0jJiVANc7VF5WBhhqG9/g==
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=gb2312
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 1/2] io_uring: fix issue when IOSQE_IO_DRAIN pass with
 IOSQE_IO_LINK
From:   Jackie Liu <liuyun01@kylinos.cn>
In-Reply-To: <d72a6911-d1fb-5c88-7992-8d4715ddbcc8@kernel.dk>
Date:   Fri, 16 Aug 2019 08:48:05 +0800
Cc:     linux-block@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <6EC9DDF3-3142-4FE1-831B-E5A823FBFC51@kylinos.cn>
References: <1565775322-10296-1-git-send-email-liuyun01@kylinos.cn>
 <d72a6911-d1fb-5c88-7992-8d4715ddbcc8@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


在 2019年8月16日，01:07，Jens Axboe <axboe@kernel.dk> 写道：

> 
> On 8/14/19 3:35 AM, Jackie Liu wrote:
>> Suppose there are three IOs here, and their order is as follows:
>> 
>> Submit:
>> 	[1] IO_LINK
>> 	    |
>> 	    |---  [2] IO_LINK | IO_DRAIN
>> 		      |
>> 		      |- [3] NORMAL_IO
>> 
>> In theory, they all need to be inserted into the Link-list, but flag
>> IO_DRAIN we have, io[2] and io[3] will be inserted into the defer_list,
>> and finally, io[3] and io[2] will be processed at the same time.
>> 
>> Now, it is directly forbidden to pass these two flags at the same time.
>> 
>> Fixes: 9e645e1105c ("io_uring: add support for sqe links")
>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>> ---
>>  fs/io_uring.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>> 
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index d542f1c..05ee628 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -2074,10 +2074,13 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
>>  {
>>  	struct io_uring_sqe *sqe_copy;
>>  	struct io_kiocb *req;
>> +	unsigned int flags;
>>  	int ret;
>> 
>> +	flags = READ_ONCE(s->sqe->flags);
>>  	/* enforce forwards compatibility on users */
>> -	if (unlikely(s->sqe->flags & ~SQE_VALID_FLAGS)) {
>> +	if (unlikely((flags & ~SQE_VALID_FLAGS) ||
>> +		     (flags & (IOSQE_IO_DRAIN | IOSQE_IO_LINK)))) {
> 
> This doesn't look right, as any setting of either DRAIN or LINK would now
> fail?
> 
> Did you mean something ala:
> 
> 	if ((flags & (IOSQE_IO_DRAIN | IOSQE_IO_LINK)) ==
> 	    (IOSQE_IO_DRAIN | IOSQE_IO_LINK)) {
> 		... fail ...
> 	}
> 
> which makes me worried that you didn't test this at all...
> 
> -- 
> Jens Axboe

Oh, yes, it's my fault, I just simulated it in my head, thank you for pointing out.
I think I'd add an [RFC PATCH] next time. 

For this issue, I have two solutions, first is this, just avoid passing DRAIN and LINK at
the same time; second is allow, let the SQE following LINK inherit the DRAIN flag, but
It's more complicated, I prefer the first one.

I will rewrite this patch later, with a real test. Thanks again.

--
Jackie Liu



