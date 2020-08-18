Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB75C433DF
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 06:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8462D206B5
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 06:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="eJmbX1SW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgHRGzn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgHRGzn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Aug 2020 02:55:43 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08A7C061389
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2020 23:55:40 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id g19so20731485ejc.9
        for <linux-block@vger.kernel.org>; Mon, 17 Aug 2020 23:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YVVIR500ClTyfmtyOwulLE+BvxQ0gs3eNmZQyHQPmgM=;
        b=eJmbX1SWXaHlLz2f3BaAUUy7YdEU6kWkKuybjHFQ6gUZQpe/FwnP8wZnp+eEOeT2vI
         c86cRd+m4uSGPdTU9oC+0To3tpcbIyMQFeMuPAWZialvTXYdyGZEGfC0Kwdf3ZFViWqD
         X/UeZvVRDehlQuQdxP/dj9oxpJg0rHPpRBgmvmZi9Eu41pRsHXR3OzSvvrOeGxzuogkS
         0gT/8fIt+TpaMbDH1fjYUEiCRUwqd/gDH5MXk9KrgvioyMg4fcPDV5jxBEe5azhq3pE/
         2Ir054g8ZeCUPhWmfqNWBNZCBFL0Yo7SZhqHVTQtaM3fRgwvY803RdlVcKnBNv12XvCs
         8ouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YVVIR500ClTyfmtyOwulLE+BvxQ0gs3eNmZQyHQPmgM=;
        b=aHrZsIAvyFM68z46jBBsZYcHtzwxGkmKlPCQAPZ02XeDglw6HjuDdcF392oju77Aaf
         cIzphMg+121zZou8mA8ix8hLXz05jOFwqrtiqJ28i05+xjzoFrjm17uApEyjH6vxheog
         mUXqe4TDR2ObNFWLguf4NUbOD2XJVM5W7cbyeN8uegknMMl0YkJz+eKYEeNeuKyAU1Ic
         1lD3Ou1KVpfAL67Jtu8sqRLPXV3HcMB8vSgn2Tv6UV+LVte7qxPPRy3umht2EzEbBXPJ
         FkXwk5UvTuTkMaqfiOpHfZnLvkiXr9VdWNIs9UsqsY9ZClqaYYVvXMBMPJXHWB9YDbsH
         tN3A==
X-Gm-Message-State: AOAM532PioRujwwr3+U1IyjDvQlpEFSFt/E3NKCzvwgzKuUI6Hccn+Vy
        8lN5yEnjAfezj9rzPgBRr0V0ORtqbYVd5MGPDmgsWg==
X-Google-Smtp-Source: ABdhPJzIct2j4t1npMaUaYEbdOJYlgdB2lBN+97fVJlGne/OlmcZxGArD17Rlq6EzVeqPdWaAAo+tZ41oJFtCjqGiU8=
X-Received: by 2002:a17:906:a116:: with SMTP id t22mr19212136ejy.353.1597733739373;
 Mon, 17 Aug 2020 23:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAMGffE=2m7XOdKS9xG1bNY7MYR2x6AgQm9YZFHm6D4biO860sw@mail.gmail.com>
 <20200818064924.3984068-1-natechancellor@gmail.com>
In-Reply-To: <20200818064924.3984068-1-natechancellor@gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 18 Aug 2020 08:55:28 +0200
Message-ID: <CAMGffEkcDO5ubT5kJA3Gnt-dm-NXBb3qhKKS9__a4u6efRmghw@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: Ensure err is always initialized in process_rdma
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Brooke Basile <brookebasile@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 18, 2020 at 8:50 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/block/rnbd/rnbd-srv.c:150:6: warning: variable 'err' is used
> uninitialized whenever 'if' condition is true
> [-Wsometimes-uninitialized]
>         if (IS_ERR(bio)) {
>             ^~~~~~~~~~~
> drivers/block/rnbd/rnbd-srv.c:177:9: note: uninitialized use occurs here
>         return err;
>                ^~~
> drivers/block/rnbd/rnbd-srv.c:150:2: note: remove the 'if' if its
> condition is always false
>         if (IS_ERR(bio)) {
>         ^~~~~~~~~~~~~~~~~~
> drivers/block/rnbd/rnbd-srv.c:126:9: note: initialize the variable 'err'
> to silence this warning
>         int err;
>                ^
>                 = 0
> 1 warning generated.
>
> err is indeed uninitialized when this statement is taken. Ensure that it
> is assigned the error value of bio before jumping to the error handling
> label.
>
> Fixes: 735d77d4fd28 ("rnbd: remove rnbd_dev_submit_io")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1134
> Reported-by: Brooke Basile <brookebasile@gmail.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Thanks!
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
> index 0fb94843a495..1b71cb2a885d 100644
> --- a/drivers/block/rnbd/rnbd-srv.c
> +++ b/drivers/block/rnbd/rnbd-srv.c
> @@ -148,7 +148,8 @@ static int process_rdma(struct rtrs_srv *sess,
>         /* Generate bio with pages pointing to the rdma buffer */
>         bio = rnbd_bio_map_kern(data, sess_dev->rnbd_dev->ibd_bio_set, datalen, GFP_KERNEL);
>         if (IS_ERR(bio)) {
> -               rnbd_srv_err(sess_dev, "Failed to generate bio, err: %ld\n", PTR_ERR(bio));
> +               err = PTR_ERR(bio);
> +               rnbd_srv_err(sess_dev, "Failed to generate bio, err: %ld\n", err);
>                 goto sess_dev_put;
>         }
>
> --
> 2.28.0
>
