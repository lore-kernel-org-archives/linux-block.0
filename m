Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF95FC282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 13:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998742190A
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 13:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390038AbfBMN7k convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:59:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388781AbfBMN7k (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 08:59:40 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 620F720836;
        Wed, 13 Feb 2019 13:59:39 +0000 (UTC)
Date:   Wed, 13 Feb 2019 08:59:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] blktrace: mark expected switch fall-through
Message-ID: <20190213085938.4a21e2ee@gandalf.local.home>
In-Reply-To: <20190212210311.GA24633@embeddedor>
References: <20190212210311.GA24633@embeddedor>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 12 Feb 2019 15:03:11 -0600
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warning:
> 
> kernel/trace/blktrace.c: In function ‘blk_trace_ioctl’:
> kernel/trace/blktrace.c:725:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    start = 1;
>    ~~~~~~^~~
> kernel/trace/blktrace.c:726:2: note: here
>   case BLKTRACESTOP:
>   ^~~~
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  kernel/trace/blktrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index fac0ddf8a8e2..e1c6d79fb4cc 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -723,6 +723,7 @@ int blk_trace_ioctl(struct block_device *bdev, unsigned cmd, char __user *arg)
>  #endif
>  	case BLKTRACESTART:
>  		start = 1;
> +		/* fall through */
>  	case BLKTRACESTOP:
>  		ret = __blk_trace_startstop(q, start);
>  		break;

