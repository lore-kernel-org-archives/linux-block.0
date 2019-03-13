Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D97C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 20:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 379912183F
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 20:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfCMU0a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 16:26:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41113 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbfCMU02 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 16:26:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id t7so3009791otk.8;
        Wed, 13 Mar 2019 13:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dC4mwXzeEHJwp1dBVVvKKcXT/wbgfzIqLo0obzEmmH0=;
        b=VANci860hzceBPj+TH9LP7zib+eXvS6heHbS75euEvx362KYzU0toSQAINrniUlEQ1
         AvrgrEg7RVzZkT6CbzwC5NHah6zK0r1X4RSqk4G7ANIE9XSmx4opkInQ6XE0LLIS98ee
         bF+vsR7/w+6Jz+GgPI1Jrg8a7e/zPBhQOjbyG11du9u6ZdYJEjR+y1S3YH3M1++s2g6y
         imZJDPxzBjmgZJi/9AxwMnUyWJHC3Zsdi5PnU3brlMjmLQgaa6TGjnkntBotGUk776It
         XGfjeLfx9tHBlUXv440agrufOn93H9XLvKcD5vip+sBQfHUd2gnrB4fQuEyhjB9l88A/
         +d0w==
X-Gm-Message-State: APjAAAWpHzP/UOAPeNXsHG+AEw4ism+q7EfDoi7aNpnSRTVsUIkQMmxk
        +/rfMA2SbZs7dZMU3l1UCIJdjDu9gfJRSyghIJw=
X-Google-Smtp-Source: APXvYqw71kFnqKbQFVXaJiAzXRqSm4HByO1jVGn6OZzIJS79MaVNIdo3Y+I0/4RGLjiDvBdeMvP5DarG+XLn8KNBJDQ=
X-Received: by 2002:a9d:7841:: with SMTP id c1mr29678992otm.354.1552508787907;
 Wed, 13 Mar 2019 13:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190114203113.16832-1-malat@debian.org>
In-Reply-To: <20190114203113.16832-1-malat@debian.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 13 Mar 2019 21:26:17 +0100
Message-ID: <CA+7wUsyrAByMiD8zYzopwFQr9Yt6nk4V=FV8Rp=uSSq7sTipCQ@mail.gmail.com>
Subject: Re: [PATCH] blkcg: annotate implicit fall through
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping ?

On Mon, Jan 14, 2019 at 9:31 PM Mathieu Malaterre <malat@debian.org> wrote:
>
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> this place in the code produced a warning (W=1).
>
> This commit remove the following warning:
>
>   kernel/trace/blktrace.c:725:9: warning: this statement may fall through [-Wimplicit-fallthrough=]
>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
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
>         case BLKTRACESTART:
>                 start = 1;
> +               /* fall through */
>         case BLKTRACESTOP:
>                 ret = __blk_trace_startstop(q, start);
>                 break;
> --
> 2.19.2
>
