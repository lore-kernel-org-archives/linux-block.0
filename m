Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58B4C47082
	for <linux-block@archiver.kernel.org>; Wed, 26 May 2021 08:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCDB6143E
	for <linux-block@archiver.kernel.org>; Wed, 26 May 2021 08:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbhEZIta (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 04:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbhEZItW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 04:49:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6075DC061761
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 01:47:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so8109996wmq.2
        for <linux-block@vger.kernel.org>; Wed, 26 May 2021 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCSkBSvzfP1tQL/xuysG7GaKjz/QYEyGy+/ZR44/MpI=;
        b=Kz25S1AjIss1JudYM2S4TtdSeANHutDr9XSb/t+lsyI4XF32T608KZIVw6rx0PeJHV
         bHQPAf6NPDfwahUDau+GYCaaSZM5jSBzdXZpZLmbdyqIpgojSb3Kxly382KYQxRo186g
         EtwsbXKVnUI+ZhQe1gZH/Uhl/YCLtjOntpYb8ZDiQv/Moj0VzfHaXbwCHKIwV3D9KoNs
         e9x8qQU9LD3FkAV7YU/ICS7g/0GRBKlfN8gME1C8ROjmrnPEiU61JTtn3PILhMCuUkDF
         cC/235xUWLWXaR7WPia81u7DTDkoQ26CqUYcDXKXXU0sjELiTkZLDkIxQw6o+8fmxLcg
         s9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCSkBSvzfP1tQL/xuysG7GaKjz/QYEyGy+/ZR44/MpI=;
        b=tz/IBBU5x0ODHa3CrGlZJIcrfBfzyvC4k/0apldnRrJ0sXbMjviQkJky/sU1dUKXmK
         ZucAc1Q56hT35IwWqAzkpH8NEt/NfkY+x04Qzk/m2PU4ba2oem0R33JrDWDGYoSF7AO4
         7MF3CUAA3IOXRhfgLdBI9iPDfK6I409Ty4vpSrOtNpEuVr0xxnA+sMyvoyoHXsA5lOID
         JWMsVxeyvRldLWLoomaOoRaVs/0G8IJGX1QG9DE7VGKUbgXF2+hOK9z6bdFVdMEdtfLP
         6Y3CWpjJxQ8LJ1XltsbiZTCloBxCPDGJNZsAqhLxcok9jummsWHkgUBrnXtUtH3YerQX
         jpqA==
X-Gm-Message-State: AOAM530N0CQv7NVb/G8ea1/Fw7ZzrHRHddf1NoS6c3Mi841oMGdJezeX
        GV1Lpxli260dURJdbZBMoZBQb4XY2zpup2gU/2Q=
X-Google-Smtp-Source: ABdhPJzEaZz77g5pREKeKLYuDF6x5VBcjS4q7bhAOnDUvid+sQ13JtScj1DKIF1vmxJYosL3pFKwxD7rRl4qbDvvkgI=
X-Received: by 2002:a05:600c:b58:: with SMTP id k24mr2280461wmr.155.1622018869929;
 Wed, 26 May 2021 01:47:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210521202145.3674904-1-kbusch@kernel.org> <20210521202145.3674904-3-kbusch@kernel.org>
In-Reply-To: <20210521202145.3674904-3-kbusch@kernel.org>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Wed, 26 May 2021 14:17:23 +0530
Message-ID: <CA+1E3rJM3sGLsOuPbYVH6kaTR8S9ogfe+wryuyWpqnA-pgDsEw@mail.gmail.com>
Subject: Re: [PATCHv3 2/4] nvme: use blk_execute_rq() for passthrough commands
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Yuanyuan Zhong <yzhong@purestorage.com>,
        Casey Chen <cachen@purestorage.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, May 22, 2021 at 2:05 AM Keith Busch <kbusch@kernel.org> wrote:
>
> The generic blk_execute_rq() knows how to handle polled completions. Use
> that instead of implementing an nvme specific handler.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> No changes since v2
>
>  drivers/nvme/host/core.c    | 38 +++++--------------------------------
>  drivers/nvme/host/fabrics.c | 13 ++++++-------
>  drivers/nvme/host/fabrics.h |  2 +-
>  drivers/nvme/host/fc.c      |  2 +-
>  drivers/nvme/host/nvme.h    |  2 +-
>  drivers/nvme/host/rdma.c    |  3 +--
>  drivers/nvme/host/tcp.c     |  2 +-
>  drivers/nvme/target/loop.c  |  2 +-
>  8 files changed, 17 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 762125f2905f..1a73eed61eee 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1012,31 +1012,6 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
>  }
>  EXPORT_SYMBOL_GPL(nvme_setup_cmd);
>
> -static void nvme_end_sync_rq(struct request *rq, blk_status_t error)
> -{
> -       struct completion *waiting = rq->end_io_data;
> -
> -       rq->end_io_data = NULL;
> -       complete(waiting);
> -}
> -
> -static void nvme_execute_rq_polled(struct request_queue *q,
> -               struct gendisk *bd_disk, struct request *rq, int at_head)
> -{
> -       DECLARE_COMPLETION_ONSTACK(wait);
> -
> -       WARN_ON_ONCE(!test_bit(QUEUE_FLAG_POLL, &q->queue_flags));
> -
> -       rq->cmd_flags |= REQ_HIPRI;

The new code doesn't retain this flag.
Looks good otherwise.

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>.


-- 
Kanchan
