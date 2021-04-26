Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EDBC433ED
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2651861103
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 17:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbhDZRLE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbhDZRLC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 13:11:02 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6386EC061760
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 10:10:20 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id z7so4897246oix.9
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 10:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eo5gmhYwD5sVKrcVF5GNYF0YYnYlBgHP6BRS3D74YoE=;
        b=GPw1xKitvwGmyWq/ZcCbFojhlg7PpjTPrNz9w8X//20S5tD3/S3DKwuFtKXp/IxohX
         i0EYyHezVeSfUvGZDw48bgo/aZrqsMT5p/Ni9zAniIK/f6B7w4WDs8J36pjKVc8/9cG5
         erC+wzD2S8mdRu9hl0Or2GLawn1iXM0Yker8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eo5gmhYwD5sVKrcVF5GNYF0YYnYlBgHP6BRS3D74YoE=;
        b=S0xVkEI4VnF2UOIA5g+cssCubGzO1TTPp83TGGIi0K/gBw6zBRH52UNb6+EAH57lm5
         Bxxz9ATklT/4hVfwdWHaV2c29Q93smEYaLcEjM+OU05umEHaRGxfPqo3K2g8CA3LK1gi
         3ciq5FQSNtdzYVnAhM0mpebo7s4LYRRXNS0T8s+9RDE81oi83HM0M8TNwCWtXwxhFt1q
         aEfE0VOc6f/a0RxSsXyfzpR+yIq6ngIBw0UgADkRhJGeGHEq/wKvFYJNj1XqcF3pXvpu
         S/kJohZq8pUVt8SFbJAGxotCDRcrzXT8fc7yffa8lYblHghvcK7sMz+xR/0LBH3/hmTo
         NvkQ==
X-Gm-Message-State: AOAM531RNbaPMKjnFa5Ee4iIBjdtM66ak/YOdyC5iRKZ+5gU9d7+tnLW
        6sB+M6Jb01H3RDf9mD6TPHdnmBfH+5NJgU8xRjmZdw==
X-Google-Smtp-Source: ABdhPJyKCnqjd8rFzzXlpg/8c39CgYoVfclNiK/pBOeWWt28b4Po8FC1FuVbU0zVrHhWpYEjIT3hHcBdqKdfxGRNCmo=
X-Received: by 2002:aca:31cf:: with SMTP id x198mr45382oix.71.1619457019700;
 Mon, 26 Apr 2021 10:10:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210423220558.40764-1-kbusch@kernel.org> <20210423220558.40764-5-kbusch@kernel.org>
In-Reply-To: <20210423220558.40764-5-kbusch@kernel.org>
From:   Yuanyuan Zhong <yzhong@purestorage.com>
Date:   Mon, 26 Apr 2021 10:10:09 -0700
Message-ID: <CA+AMecF+n+xVk8HcQn12oiO=YMJM08aC0AG3iM_3h8SgNxURow@mail.gmail.com>
Subject: Re: [PATCHv2 4/5] nvme: use return value from blk_execute_rq()
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me,
        Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, Casey Chen <cachen@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 23, 2021 at 3:06 PM Keith Busch <kbusch@kernel.org> wrote:
>
> We don't have an nvme status to report if the driver's .queue_rq()
> returns an error without dispatching the requested nvme command. Use the
> return value from blk_execute_rq() for all passthrough commands so the
> caller may know their command was not successful.
>
> If the command is from the target passthrough interface and fails to
> dispatch, synthesize the response back to the host as a internal target
> error.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c       | 16 ++++++++++++----
>  drivers/nvme/host/ioctl.c      |  6 +-----
>  drivers/nvme/host/nvme.h       |  2 +-
>  drivers/nvme/target/passthru.c |  8 ++++----
>  4 files changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 10bb8406e067..62af5fe7a0ce 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -972,12 +972,12 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>                         goto out;
>         }
>
> -       blk_execute_rq(NULL, req, at_head);
> +       ret = blk_execute_rq(NULL, req, at_head);
>         if (result)
>                 *result = nvme_req(req)->result;
>         if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>                 ret = -EINTR;
> -       else
> +       else if (nvme_req(req)->status)

Since nvme_req(req)->status is uninitialized for a command failed to dispatch,
it's valid only if ret from blk_execute_rq() is 0.
