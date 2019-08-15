Return-Path: <SRS0=WP4r=WL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AACBC3A589
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 17:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3BE205F4
	for <linux-block@archiver.kernel.org>; Thu, 15 Aug 2019 17:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mpvwOROZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfHORHY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Aug 2019 13:07:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42170 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfHORHY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Aug 2019 13:07:24 -0400
Received: by mail-io1-f67.google.com with SMTP id e20so561305iob.9
        for <linux-block@vger.kernel.org>; Thu, 15 Aug 2019 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tqXjsnmu3mRzepefueLfJqw3tofCDA+xqbiWeX+Wszs=;
        b=mpvwOROZr7aGs1tnKH+i7E6utyygNl0m7IorYtQ4JcV3RWRrIGEguiD7VmAvhDRFfB
         bFylGpzT7gY2zOT8JbABVNoyJa7toO1Vf7tqNIZxSVuxJCTaggJrWXJNIxpKx7AgkKId
         wm9qq4fKVpNR1p8axvT3fwi+A5dIs4dyRYVx+u0y3HytbRvchDc0NRUBgItaqYTtYKPb
         E9kHgdGLLGgw2jJ5QMwnUGi2daovqJF2UENC0Tf/jVfP/FDm8uLuZp1iiZX0RfztnrSQ
         WUZWINNfEkJ1fg9yZZLzGkCpIUYeH7wcKHL196nn+PGmIO2sGP4v7gbyiBQIGQDmundl
         8S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tqXjsnmu3mRzepefueLfJqw3tofCDA+xqbiWeX+Wszs=;
        b=T2KqEs+lO00N1dIuDgSHfGLiVHEqzMs56utuDz7oY00RfICJCwghMTlxG4FNd7ziD8
         Qx0Owk1LxgynMlkgcuyDBTtrIUY7X3Qt6OnagCQjuqzIvGgu184iDlFlEsxjbG5eZsWY
         Sgye2Ks35QzDtJOhhJ+aAim5YJFsm3SMX09ShfR6PNytrgr+JMY2Zap8tdzQWR+a4dd7
         YSlWDeJrglTBaXO1+WPO2D/GWr3VgjpP6yqlgNSCIBD/Bz8WDSyzbKfnNFpwhg0oiw2/
         YdoO5GHf2X5OADc7VpoJ/mM6nU0K3IM9UahAKdlH8n/HA+QoOeFMEWjUu0BDA2z3oDTZ
         bBtA==
X-Gm-Message-State: APjAAAULbKP05m5Ar1Hg7ZE8PaKOCVUMn2LcCn06UounhXEH3MK/UYTN
        JwuWmWTRqDXvNT+0HdqWZg/gR+S7qAbKHQ==
X-Google-Smtp-Source: APXvYqx9XXjrN/JH359poCceaq5BXeAOB5qWk7y2xRaL+/HjFsjmAAbl8zcbNhoYDzupu0e5uYc0cA==
X-Received: by 2002:a5d:83cd:: with SMTP id u13mr6333517ior.297.1565888842693;
        Thu, 15 Aug 2019 10:07:22 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l26sm3894218ioj.24.2019.08.15.10.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 10:07:21 -0700 (PDT)
Subject: Re: [PATCH 1/2] io_uring: fix issue when IOSQE_IO_DRAIN pass with
 IOSQE_IO_LINK
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <1565775322-10296-1-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d72a6911-d1fb-5c88-7992-8d4715ddbcc8@kernel.dk>
Date:   Thu, 15 Aug 2019 11:07:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1565775322-10296-1-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/14/19 3:35 AM, Jackie Liu wrote:
> Suppose there are three IOs here, and their order is as follows:
> 
> Submit:
> 	[1] IO_LINK
> 	    |
> 	    |---  [2] IO_LINK | IO_DRAIN
> 		      |
> 		      |- [3] NORMAL_IO
> 
> In theory, they all need to be inserted into the Link-list, but flag
> IO_DRAIN we have, io[2] and io[3] will be inserted into the defer_list,
> and finally, io[3] and io[2] will be processed at the same time.
> 
> Now, it is directly forbidden to pass these two flags at the same time.
> 
> Fixes: 9e645e1105c ("io_uring: add support for sqe links")
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>   fs/io_uring.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index d542f1c..05ee628 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2074,10 +2074,13 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
>   {
>   	struct io_uring_sqe *sqe_copy;
>   	struct io_kiocb *req;
> +	unsigned int flags;
>   	int ret;
>   
> +	flags = READ_ONCE(s->sqe->flags);
>   	/* enforce forwards compatibility on users */
> -	if (unlikely(s->sqe->flags & ~SQE_VALID_FLAGS)) {
> +	if (unlikely((flags & ~SQE_VALID_FLAGS) ||
> +		     (flags & (IOSQE_IO_DRAIN | IOSQE_IO_LINK)))) {

This doesn't look right, as any setting of either DRAIN or LINK would now
fail?

Did you mean something ala:

	if ((flags & (IOSQE_IO_DRAIN | IOSQE_IO_LINK)) ==
	    (IOSQE_IO_DRAIN | IOSQE_IO_LINK)) {
		... fail ...
	}

which makes me worried that you didn't test this at all...

-- 
Jens Axboe

