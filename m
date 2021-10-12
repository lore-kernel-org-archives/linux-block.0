Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A792CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 09:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A7C60F3A
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 09:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbhJLJKp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 05:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbhJLJKp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 05:10:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B94C06161C
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 02:08:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r7so64771725wrc.10
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 02:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5tWkOQuIl0OZJOGpfR29lXHqMPLwxRju9KQkuQAZfY=;
        b=ZLALu2ZGDCxbTc4NJwezL/z/uP2403PMM5OBJiUTNasL1aQiv47ZFhgXewWJZuY+Ix
         zBd0mCzzuYXKPSa97tjBhinDMc7qEibuOsQVCyiLHJpwIj53R778KlZOXMn0RMFST76S
         RVHqULsUBMUYy7sih5X9uG92Gdnt9bZHMv5j2u5d7dR6gNTEv3KJXiXLSJjcCXlhawnk
         IkWz5+2x+yPikT1ISoeU2XU68T1HJVv4sojfYYGl679Du6w+BX0L9milGloKgycVRUUH
         4E18oy9DoTGRmBa4KI3bKeRVX141bXb3n3lMksaxPGKLfR1wo8ntFiW3oKfjNmQ0hbXB
         pG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5tWkOQuIl0OZJOGpfR29lXHqMPLwxRju9KQkuQAZfY=;
        b=jHLlVFETyvmNXTl5ouRGRf2XKW8vzor872n8/YCkQJ1MpmCVYxwsdrUrHiZ00IYYGX
         E2RQScEcYLp9PWSJZA4lDQlAf0QCCigc7d+3RcC1p5W7w70KLNrs6h/Z9FDI0koNIqVs
         APAqx5PkGqkLLzGvKV+PIN2MR8Hh9vgP7TCJRc8nDNLTsoaJXliT//vhCa0VaA3bBEjC
         zb8h8yDuVA/KfDFvZ629xzIgEumrAZOnt7Ad/AiTOLT7JC8O7Z6RctqeEAJxIQCLMMT3
         10QxdnAyl5XKZz6s+PEky2Cz2PEkO8cz+LpvkQc5NlRcnfwkeUXLscCWHQ6NrMZyR6Yv
         e4Gg==
X-Gm-Message-State: AOAM533EypR0KTJG0SfdEvYyZxR1KmujtCYvzN4lFrmuljz1DHEBxraT
        5w0LXCvK1ldLQll8q1ArUR53y+/OqOgDJ+En8CHpIg==
X-Google-Smtp-Source: ABdhPJz3bvhG1Ws0mV6RQ8+jCUxY+7BKNPQgG+z2/+EqJb1aEZa43yvjKlXRtHUY0RkWlQH4TuVaxTU3gsalXisBwsw=
X-Received: by 2002:adf:aa96:: with SMTP id h22mr30612000wrc.405.1634029722328;
 Tue, 12 Oct 2021 02:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211012084443.GA31472@kili>
In-Reply-To: <20211012084443.GA31472@kili>
From:   Gioh Kim <gi-oh.kim@ionos.com>
Date:   Tue, 12 Oct 2021 11:08:06 +0200
Message-ID: <CAJX1Ytb+_dSxk8h2u7JYa0RGuDYe=DEqNCB_Cpxf7d0o9RSAWA@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd-clt-sysfs: fix a couple uninitialized variable bugs
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 12, 2021 at 10:45 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> These variables are printed on the error path if match_int() fails so
> they have to be initialized.
>
> Fixes: 2958a995edc9 ("block/rnbd-clt: Support polling mode for IO latency optimization")
> Fixes: 1eb54f8f5dd8 ("block/rnbd: client: sysfs interface functions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/block/rnbd/rnbd-clt-sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
> index 4b93fd83bf79..44e45af00e83 100644
> --- a/drivers/block/rnbd/rnbd-clt-sysfs.c
> +++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
> @@ -71,8 +71,10 @@ static int rnbd_clt_parse_map_options(const char *buf, size_t max_path_cnt,
>         int opt_mask = 0;
>         int token;
>         int ret = -EINVAL;
> -       int i, dest_port, nr_poll_queues;
> +       int nr_poll_queues = 0;
> +       int dest_port = 0;
>         int p_cnt = 0;
> +       int i;
>
>         options = kstrdup(buf, GFP_KERNEL);
>         if (!options)
> --
> 2.20.1
>

Thank you.
Acked-by: Gioh Kim <gi-oh.kim@ionos.com>
