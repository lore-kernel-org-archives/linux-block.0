Return-Path: <SRS0=5dBz=7E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A8DC433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 10:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4371B20757
	for <linux-block@archiver.kernel.org>; Fri, 22 May 2020 10:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="HnPluOJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgEVKBY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 May 2020 06:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbgEVKBX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 May 2020 06:01:23 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221E4C061A0E
        for <linux-block@vger.kernel.org>; Fri, 22 May 2020 03:01:22 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u188so9253668wmu.1
        for <linux-block@vger.kernel.org>; Fri, 22 May 2020 03:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RyxHtd8t+Tnym6Rgfk/b1z6/xAgAd1SgDqjswJTBPeQ=;
        b=HnPluOJFuyWZ2ZmEnp7WE34nWh83fzfZaugdRb/RgIp3B3UhhAIdNPCeePTwTkn32y
         OTCuEppurSdXNLugm1Y+bu9BGs8PW/AhkWHQ1NBM4ECKgFTUA+KHgpqd8xXXRGCZw5J4
         khAyW9C9LXtu9y7EvPqTpxXsYzMVmFPWcSWJa9OzGwG3wcyw0wN6qzA8pah3yWvZwEgS
         YfefvBkrxQrAHM++e+EgghWkvd5/DaKlvevQYJU6vjcSnFAV+kd9P4vRBr+Q7nU/oGHy
         KG4/MQJxpGMH9TajPB4/r+GGj0tiG+Xyrfn/BnwHykkZvfS3hrmUt2dpR7pzf5vCW7Ql
         S4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RyxHtd8t+Tnym6Rgfk/b1z6/xAgAd1SgDqjswJTBPeQ=;
        b=B6778rsg1lLNPKiOJ1ZZJ8E5juAZbVY0MMqLKj1PmoJfZTvJPqGtR9hZP2pPa6kgs2
         V5Yp+F/zNgyq34wXX1BgE/8Bzb6gHSnlFwJ9BASZDZBfoEM1J4ajd41jDosht+x5oGNu
         uz4jom6LMjjgok6XMwJgU4jKhJYaJW9Yw5IbtIanYwwvbbcCE4ss2Yc46QS/P1aUdzAY
         /qbNTrjSIintZAuFzcsoTRM96Pa3zKw+tgo3NhIc+OV03qmI/Ax/u6opmP1MPLm6jyye
         HpVWiRngn1MYT+DGXLT4ZUF4Lc1g+VPegiZhCqPX3ZPnt88FLW2KjFG4akWLGj6B8B/S
         Wt7g==
X-Gm-Message-State: AOAM5331/PVivP0qt0u10fHv8ini4K/yGuRnS0bNAYYVzaz1uDNIyxOK
        iPj33KG5jGPehxeGLcHKQ3QZkQVU4AvEt84iWyF6sVydUw==
X-Google-Smtp-Source: ABdhPJyCVsG6wWaF1VxfaUETpoayuVhLjiFIiH8pDZdtkv+vqCyWpNVJcDDNCjYoo2AfDxsELPltZ6BD8lCKZrMMIM4=
X-Received: by 2002:a1c:c242:: with SMTP id s63mr12990862wmf.180.1590141680757;
 Fri, 22 May 2020 03:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200522082833.1480551-1-haris.phnx@gmail.com>
In-Reply-To: <20200522082833.1480551-1-haris.phnx@gmail.com>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 22 May 2020 12:01:10 +0200
Message-ID: <CAHg0HuwK3FepXP06o-S_y6hukYmF3sMRgU+RweB6EMWdF3y9TQ@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rtrs: server: use already dereferenced rtrs_sess structure
To:     haris iqbal <haris.phnx@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 22, 2020 at 10:28 AM <haris.phnx@gmail.com> wrote:
>
> From: Md Haris Iqbal <haris.phnx@gmail.com>
>
> The rtrs_sess structure has already been extracted above from the
> rtrs_srv_sess structure. Use that to avoid redundant dereferencing.
>
> Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
> Signed-off-by: Md Haris Iqbal <haris.phnx@gmail.com>
> ---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> index 1fc6ece036ff..5ef8988ee75b 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
> @@ -1822,13 +1822,13 @@ static int rtrs_rdma_connect(struct rdma_cm_id *cm_id,
>                 /*
>                  * Sanity checks
>                  */
> -               if (con_num != sess->s.con_num || cid >= sess->s.con_num) {
> +               if (con_num != s->con_num || cid >= s->con_num) {
>                         rtrs_err(s, "Incorrect request: %d, %d\n",
>                                   cid, con_num);
>                         mutex_unlock(&srv->paths_mutex);
>                         goto reject_w_econnreset;
>                 }
> -               if (sess->s.con[cid]) {
> +               if (s->con[cid]) {
>                         rtrs_err(s, "Connection already exists: %d\n",
>                                   cid);
>                         mutex_unlock(&srv->paths_mutex);
> --
> 2.25.1
>

Acked-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>

Thanks Haris.
