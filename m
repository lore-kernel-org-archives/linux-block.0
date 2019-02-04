Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F70C282D7
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 06:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759E320820
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 06:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eTc54Lvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfBDGZW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 01:25:22 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:42230 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbfBDGZW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 01:25:22 -0500
Received: by mail-vs1-f67.google.com with SMTP id b74so7817106vsd.9
        for <linux-block@vger.kernel.org>; Sun, 03 Feb 2019 22:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ZR3OI/eBf/ERrLxK/92kkUEr1noiKiWUaiuDsiuROI=;
        b=eTc54Lvucvz8YogIUqm9bPcKCK5L4n20X8/bOVLpDKaT/wv3OkGZdcNs9psPFzJ8cw
         AyjEQePAVW+pBCS3dxUb5FRGbnUmo8i7oAuU/UQKi7BdwzeCcmjUy2j56DJVwZeiYdIT
         IAgGsNyS4CY4YPCYZGJbRb38m3eeTn8oL+R7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ZR3OI/eBf/ERrLxK/92kkUEr1noiKiWUaiuDsiuROI=;
        b=hhBHSsiYfFFNF4wmCm1NTWKB2wHJBZ1sNHAVcuMyvyKlRvCxq1TBOvtlxo65A3XSZL
         j6NkNXxrFkCA7nODGnE3k74GqzsqPOFVXAs+oJoqwgY8CGk75cyppoxa6nuzc6NnNsav
         Ix//7JUAmfLGTduj9wjDHqxkw45ardJvzhC8RAdSSAO/fqn1DloOfXsjU/FLCOgM5bKm
         lVcDRam/vwEBS6LCveqAP/tBxBntpIRfY/YTpLiIw2EioRpK9k4Hg/H2AI8p6rTQfDkw
         ZqZIp0beq2rqggb3hlR7CcSEhPici5RjyaQ2V8qpyQCBaCdNrCmSBEfTCE9JCSygyOHU
         bc1Q==
X-Gm-Message-State: AJcUukdCb5XA44pLMykkvVULH2upMs5zJp3eiOGAGFPbMgZYPM9YkBjx
        qZ4qOABAbhpibgVfhoAMUy9bBrvKMLIR8jaL7ivbaA==
X-Google-Smtp-Source: ALg8bN7j/jZ/GeuiRYtqEjchUgAFxof8513/MjLo75Yz3p0lvqb33liHufQQBvvTZm3/iPPofPGOkFSHCE1ZwJRHxLw=
X-Received: by 2002:a67:1a84:: with SMTP id a126mr21792831vsa.165.1549261520615;
 Sun, 03 Feb 2019 22:25:20 -0800 (PST)
MIME-Version: 1.0
References: <1548965800-3080-1-git-send-email-zhays@lexmark.com>
In-Reply-To: <1548965800-3080-1-git-send-email-zhays@lexmark.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Feb 2019 07:24:43 +0100
Message-ID: <CAPDyKFpcmyKnF-QPBV1vbTfGdSYN30GayZSA5O9Gm_EbZjfdAw@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: handle complete_work on the system_highpri workqueue
To:     Zachary Hays <zhays@lexmark.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

+ Jens, Christoph, Adrian, Linus

On Thu, 31 Jan 2019 at 21:16, Zachary Hays <zhays@lexmark.com> wrote:
>
> The kblockd workqueue is created with the WQ_MEM_RECLAIM flag set.
> This generates a rescuer thread for that queue that will trigger when
> the CPU is under heavy load and collect the uncompleted work.
>
> In the case of mmc, this creates the possibility of a deadlock as
> other blk-mq is also run on the same queue. For example:
>
> - worker 0 claims the mmc host
> - worker 1 attempts to claim the host
> - worker 0 schedules complete_work to release the host
> - rescuer thread is triggered after time-out and collects the dangling
>   work
> - rescuer thread attempts to complete the work in order starting with
>   claim host
> - the task to release host is now blocked by a task to claim it and
>   will never be called
>
> The above results in multiple hung tasks that lead to failures to boot.
>
> Switching complete_work to the system_highpri queue avoids this
> because system_highpri is not flagged with WQ_MEM_RECLAIM. This allows
> the host to be released without getting blocked by other claims tasks.
>

Thanks for fix and the detailed description to the problem!

> Signed-off-by: Zachary Hays <zhays@lexmark.com>
> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index aef1185f383d..59b6b41b84c6 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2112,7 +2112,7 @@ static void mmc_blk_mq_req_done(struct mmc_request *mrq)
>                 if (waiting)
>                         wake_up(&mq->wait);
>                 else
> -                       kblockd_schedule_work(&mq->complete_work);
> +                       queue_work(system_highpri_wq, &mq->complete_work);

Even if this solves the problem, I think we need some input from some
of the block experts/maintainers to understand if this is the correct
way to fix the problem. So, I have lopped them in.

I am guessing MMC is not the only block device driver that have this
kind of locking issue. Or perhaps it is..

>
>                 return;
>         }
> --
> 2.7.4
>

Kind regards
Uffe
