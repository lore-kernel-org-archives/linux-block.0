Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0164FC433B4
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 16:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2742611BF
	for <linux-block@archiver.kernel.org>; Mon, 17 May 2021 16:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242293AbhEQQwb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 May 2021 12:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240877AbhEQQwX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 May 2021 12:52:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A026BC06134E
        for <linux-block@vger.kernel.org>; Mon, 17 May 2021 09:44:19 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a4so7154173wrr.2
        for <linux-block@vger.kernel.org>; Mon, 17 May 2021 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+VtV8nX+Uzjp9W9nmFCJu2nrfmzR8I0bnxqoUhqRYCQ=;
        b=XCDef7VXfeqXqKqRbwsg7GLiUQSoUtfM70wDpmSftyUGC5VZLlm+DTZn6cjRNVLPZQ
         G3jsMNHRUNtGB1J1naBe93gwijRQ2i5Kcp0kGtiFj8X2cAgDohcD591gEWVPyc2k+Qkm
         1oLPAJU6DpHgqQMdLOsYjRMbKF76Kvhle182Wsy+SDTAvrb0DGZmsfOzhE3M+DvE6Hrl
         ClML2Ycta174wRcocZyE9py6Ngs4uuFWWQGYScTIBsqN0xQYnUC2Ie9fPs6sVf/FZBuI
         hUeBJRj76vT6cLqNxPv1Y9zISHi6dH5INjV3SGLCU0UH6f/VsFY19KQPqUCxBVfJWehU
         DCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+VtV8nX+Uzjp9W9nmFCJu2nrfmzR8I0bnxqoUhqRYCQ=;
        b=pBYPkhHi2oDiRPK4ypPN7ZvnD5mwhpYk8XFWLxk2+mvf7jx63aDJIvHC/rVMEfvNyF
         5Gq5w0MMqkfaMMp2+E/JMUE2kO8HceNbUk5gm/+kYwAfqWBvjvqkTp4I/heQO8mSA8K2
         qSR/QGT+EXbh6+JEmdBwb/mnX5qgBhhT0Q6P9W//kMmGL0Pzoo0n59otg1+DUdw5rEFs
         aKEhC0N2DTx/TfdxOEY2DezO1Lcy9qKhD2vycSFASJR5PoPamj70L8Ny0bp2q3z8Cp6e
         NQ+3VHoD/43yeyqkZOhnuZHOBudAMgQ/cJGx5cW9dwQMjn/eEdyZ8hXH0VVWT77dQCcY
         QpmQ==
X-Gm-Message-State: AOAM532esoUsAFwZ719zCBlhmDd7eSEbT6jS+w6g5r3d7mGUSfQ/2Tw6
        Q2vhrFQgpoe8mLovQ7RQ7jf8ij5ZI7ps5XsdcSpxqchRJjDpiA==
X-Google-Smtp-Source: ABdhPJyDb61mqECC+gWc/B1MpMTWknlMBd7wXO1WQfHD5X73NOFTBrqoZSArpY6r+YDZ0TO3HXMxu+IYMPYs7fLn058=
X-Received: by 2002:a5d:5508:: with SMTP id b8mr693279wrv.278.1621269858262;
 Mon, 17 May 2021 09:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210423220558.40764-1-kbusch@kernel.org> <20210423220558.40764-2-kbusch@kernel.org>
In-Reply-To: <20210423220558.40764-2-kbusch@kernel.org>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Mon, 17 May 2021 22:13:50 +0530
Message-ID: <CA+1E3r+3dDW0Hbc8MCsxAnwcpY=kWAqDLh0h9+j501VnKvgwqA@mail.gmail.com>
Subject: Re: [PATCHv2 1/5] block: support polling through blk_execute_rq
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Apr 24, 2021 at 3:37 AM Keith Busch <kbusch@kernel.org> wrote:
>
> Poll for completions if the request's hctx is a polling type.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  block/blk-exec.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-exec.c b/block/blk-exec.c
> index beae70a0e5e5..b960ad187ba5 100644
> --- a/block/blk-exec.c
> +++ b/block/blk-exec.c
> @@ -63,6 +63,11 @@ void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
>  }
>  EXPORT_SYMBOL_GPL(blk_execute_rq_nowait);
>
> +static bool blk_rq_is_poll(struct request *rq)
> +{
> +       return rq->mq_hctx && rq->mq_hctx->type == HCTX_TYPE_POLL;
> +}
> +
>  /**
>   * blk_execute_rq - insert a request into queue for execution
>   * @bd_disk:   matching gendisk
> @@ -83,7 +88,12 @@ void blk_execute_rq(struct gendisk *bd_disk, struct request *rq, int at_head)
>
>         /* Prevent hang_check timer from firing at us during very long I/O */
>         hang_check = sysctl_hung_task_timeout_secs;
> -       if (hang_check)
> +       if (blk_rq_is_poll(rq)) {
> +               do {
> +                       blk_poll(rq->q, request_to_qc_t(rq->mq_hctx, rq), true);
> +                       cond_resched();
> +               } while (!completion_done(&wait));
> +       } else if (hang_check)
>                 while (!wait_for_completion_io_timeout(&wait, hang_check * (HZ/2)));
>         else
>                 wait_for_completion_io(&wait);
> --

Looks good.
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

--
Kanchan
