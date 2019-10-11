Return-Path: <SRS0=5xwa=YE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06661ECE58C
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 03:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D849E20B7C
	for <linux-block@archiver.kernel.org>; Fri, 11 Oct 2019 03:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfJKD1p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 23:27:45 -0400
Received: from smtpbgsg3.qq.com ([54.179.177.220]:48548 "EHLO smtpbgsg3.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfJKD1p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 23:27:45 -0400
X-Greylist: delayed 1248 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Oct 2019 23:27:42 EDT
X-QQ-mid: bizesmtp26t1570764445t7ik9c9e
Received: from [172.20.0.236] (unknown [218.76.23.26])
        by esmtp10.qq.com (ESMTP) with 
        id ; Fri, 11 Oct 2019 11:27:24 +0800 (CST)
X-QQ-SSF: 00400000002000S0ZT90000A0000000
X-QQ-FEAT: /IQJoBMttQg7wmyLtuf1wYGpcyFZWaGlZzSHPE6z0sdVbf1T5um2QqCgH9mVy
        OybdNjBik89tEuSHMlS6RGZmmBIb73DIEplpP8v+waa61ZJ/qaQUR5m9OaPB6oQGhPSvVYi
        Nu+Khlq6JJRrmpDkd1EZXLZBDTSTMMv+L/eYDf7k/9WQrAksC4YnoFcBb0Jg3lhKdV6lkwY
        eAolPAZ76RaE83vnr++L8N1mmdlq/pcgnsjh2lQHS0H1WiDwLVQkVv/H+Mr6J0gXd8rvduw
        NXS41Zzqd02iLh+qALDG9rqMfhQUQTZlfAbywbNnIJyodMKXwHXKY1ZwQcJNkckvPEI/xEh
        1V7WD7SGJKYn4+JArVRi0+mEyCvky3FfIYfTO/L
X-QQ-GoodBg: 2
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH 1/2] io_uring: make the logic clearer for
 io_sequence_defer
From:   Jackie Liu <liuyun01@kylinos.cn>
In-Reply-To: <6e1c1450-4317-7acf-dfa0-40977de4b8ea@kernel.dk>
Date:   Fri, 11 Oct 2019 11:27:24 +0800
Cc:     yangerkun <yangerkun@huawei.com>, linux-block@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <543C3771-8956-40C4-B477-6B0F2FF477F5@kylinos.cn>
References: <20191009011959.2203-1-liuyun01@kylinos.cn>
 <7af32ce6-dc8f-6683-2b99-95eefb598bff@huawei.com>
 <597dc8a4-b9db-f0b7-21b5-12050f07e766@kernel.dk>
 <544E51DB-7774-4DDF-A897-7A957AE2CDEB@kylinos.cn>
 <6e1c1450-4317-7acf-dfa0-40977de4b8ea@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3594.4.19)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> 2019年10月11日 11:17，Jens Axboe <axboe@kernel.dk> 写道：
> 
> On 10/10/19 9:06 PM, Jackie Liu wrote:
>> 
>> 
>>> 2019年10月11日 10:35，Jens Axboe <axboe@kernel.dk> 写道：
>>> 
>>> On 10/10/19 8:24 PM, yangerkun wrote:
>>>> 
>>>> 
>>>> On 2019/10/9 9:19, Jackie Liu wrote:
>>>>> __io_get_deferred_req is used to get all defer lists, including defer_list
>>>>> and timeout_list, but io_sequence_defer should be only cares about the sequence.
>>>>> 
>>>>> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
>>>>> ---
>>>>>   fs/io_uring.c | 13 +++++--------
>>>>>   1 file changed, 5 insertions(+), 8 deletions(-)
>>>>> 
>>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>>> index 8a0381f1a43b..8ec2443eb019 100644
>>>>> --- a/fs/io_uring.c
>>>>> +++ b/fs/io_uring.c
>>>>> @@ -418,9 +418,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
>>>>>   static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
>>>>>   				     struct io_kiocb *req)
>>>>>   {
>>>>> -	/* timeout requests always honor sequence */
>>>>> -	if (!(req->flags & REQ_F_TIMEOUT) &&
>>>>> -	    (req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>>>> +	if ((req->flags & (REQ_F_IO_DRAIN|REQ_F_IO_DRAINED)) != REQ_F_IO_DRAIN)
>>>>>   		return false;
>>>>> 
>>>>>   	return req->sequence != ctx->cached_cq_tail + ctx->rings->sq_dropped;
>>>>> @@ -435,12 +433,11 @@ static struct io_kiocb *__io_get_deferred_req(struct io_ring_ctx *ctx,
>>>>>   		return NULL;
>>>>> 
>>>>>   	req = list_first_entry(list, struct io_kiocb, list);
>>>>> -	if (!io_sequence_defer(ctx, req)) {
>>>>> -		list_del_init(&req->list);
>>>>> -		return req;
>>>>> -	}
>>>>> +	if (!(req->flags & REQ_F_TIMEOUT) && io_sequence_defer(ctx, req))
>>>>> +		return NULL;
>>>> Hi,
>>>> 
>>>> For timeout req, we should also compare the sequence to determine to
>>>> return NULL or the req. But now we will return req directly. Actually,
>>>> no need to compare req->flags with REQ_F_TIMEOUT.
>>> 
>>> Yes, not sure how I missed this, the patch is broken as-is. I will kill
>>> it, cleanup can be done differently.
>> 
>> Sorry for miss it, I don't wanna change the logic, it's not my
>> original meaning.
> 
> No worries, mistakes happen.
> 
>> Personal opinion, timeout list should not be mixed with defer_list,
>> which makes the code more complicated and difficult to understand.
> 
> Not sure why you feel they are mixed? They are in separate lists, but
> they share using the sequence logic. In that respet they are really not
> that different, the sequence will trigger either one of them. Either as
> a timeout, or as a "can now be issued". Hence the code handling them is
> both shared and identical.

I not sure, I think I need reread the code of timeout command.

> 
> I do agree that the check could be cleaner, which is probably how the
> mistake in this patch happened in the first place.
> 

Yes, I agree with you. io_sequence_defer should be only cares about the sequence.
Thanks for point out this mistake.

--
BR, Jackie Liu



