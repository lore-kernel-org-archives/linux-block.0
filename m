Return-Path: <SRS0=GE/Q=S5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF36C43219
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 16:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C312087F
	for <linux-block@archiver.kernel.org>; Sat, 27 Apr 2019 16:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=stbuehler.de header.i=@stbuehler.de header.b="rMsRMqDC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfD0QFs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Apr 2019 12:05:48 -0400
Received: from mail.stbuehler.de ([5.9.32.208]:56948 "EHLO mail.stbuehler.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD0QFs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Apr 2019 12:05:48 -0400
Received: from [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6] (unknown [IPv6:2a02:8070:a29c:5000:823f:5dff:fe0f:b5b6])
        by mail.stbuehler.de (Postfix) with ESMTPSA id 4044AC00AD7;
        Sat, 27 Apr 2019 16:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stbuehler.de;
        s=stbuehler1; t=1556381146;
        bh=2aDIRT40jN0x7yXFPvlwlyjY4FL3cGNxBbJpbs5+vn4=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=rMsRMqDCXhP7zGJwkfNXAgH09HExn3KGjbxbn2xA3v+KoJ1LZMZoLk2XMWZqL68Gi
         aypc5KvD3NAlZX7/OxcvjmRZBCCJGhEWhUEP5omtIbqYLNtzFJvUiNFEaRxqVS29K9
         B5Pz4HVjpOs2o/rOsLR1c7wmWC+T5KcoHT48dxAc=
Subject: Re: io_uring: RWF_NOWAIT support
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <366484f9-cc5b-e477-6cc5-6c65f21afdcb@stbuehler.de>
 <37071226-375a-07a6-d3d3-21323145de71@kernel.dk>
 <bc077192-56cc-7497-ee43-6a0bcc369d16@kernel.dk>
 <740192f8-1d64-9e64-0aea-a73e5d6d4d46@kernel.dk>
From:   =?UTF-8?Q?Stefan_B=c3=bchler?= <source@stbuehler.de>
Message-ID: <7bcb0eb3-46d1-70e4-1108-dfd9a348bb7c@stbuehler.de>
Date:   Sat, 27 Apr 2019 18:05:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <740192f8-1d64-9e64-0aea-a73e5d6d4d46@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 24.04.19 18:09, Jens Axboe wrote:
> On 4/23/19 4:07 PM, Jens Axboe wrote:
>>>> (Also RWF_NOWAIT doesn't work in io_uring right now: IOCB_NOWAIT is
>>>> always removed in the workqueue context, and I don't see an early EAGAIN
>>>> completion).
>>>
>>> That's a case I didn't consider, that you'd want to see EAGAIN after
>>> it's been punted. Once punted, we're not going to return EAGAIN since
>>> we can now block. Not sure how you'd want to handle that any better...
>>
>> I think I grok this one too now - what you're saying is that if the
>> caller has RWF_NOWAIT set, then the EAGAIN should be returned instead of
>> being punted to the workqueue? I totally agree with that, that's a bug.
> 
> This should do it for the EAGAIN part, if the user has set RWF_NOWAIT
> in the sqe, then we don't do the automatic punt to workqueue. We just
> return the EAGAIN instead.
> 
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 58ec6e449fd8..6c0d49c3736b 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -822,7 +822,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct sqe_submit *s,
>  	ret = kiocb_set_rw_flags(kiocb, READ_ONCE(sqe->rw_flags));
>  	if (unlikely(ret))
>  		return ret;
> -	if (force_nonblock) {
> +	if (force_nonblock && !(kiocb->ki_flags & IOCB_NOWAIT)) {
>  		kiocb->ki_flags |= IOCB_NOWAIT;
>  		req->flags |= REQ_F_FORCE_NONBLOCK;
>  	}
> @@ -1828,7 +1828,7 @@ static int io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
>  	}
>  
>  	ret = __io_submit_sqe(ctx, req, s, true);
> -	if (ret == -EAGAIN) {
> +	if (ret == -EAGAIN && (req->flags & REQ_F_FORCE_NONBLOCK)) {
>  		struct io_uring_sqe *sqe_copy;
>  
>  		sqe_copy = kmalloc(sizeof(*sqe_copy), GFP_KERNEL);
> 

I think this breaks other request types.

Only io_prep_rw ever sets REQ_F_FORCE_NONBLOCK, but e.g. IORING_OP_FSYNC
always wants to punt.

Given that REQ_F_FORCE_NONBLOCK wasn't actually used before (never read
afaict), maybe remove it and insert a new flag REQ_F_NOWAIT that will
prevent the punt (inverted semantics!), e.g:

> -	if (ret == -EAGAIN) {
> +	if (ret == -EAGAIN && !(req->flags & REQ_F_NOWAIT)) {

And set this flag in io_prep_rw if RWF_NOWAIT is set.

cheers,
Stefan
