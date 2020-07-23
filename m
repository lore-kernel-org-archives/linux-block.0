Return-Path: <SRS0=kKib=BC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9492DC433DF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jul 2020 06:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7050020709
	for <linux-block@archiver.kernel.org>; Thu, 23 Jul 2020 06:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Jj/kYWpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgGWGys (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jul 2020 02:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGWGys (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jul 2020 02:54:48 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3876CC0619DC
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2020 23:54:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id br7so5201555ejb.5
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2020 23:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpmLs7IIsm/Twfus3ADAkgRV+4VDyjC/3umbBTSac+Y=;
        b=Jj/kYWpc6X7N7wFpH2BBrmTAmEb4HWsQBQ0Xyr8Z0wsTylSJHh+ybeS8uJ2awvSvwz
         Sgcp/8ClMGpFpGDAUXa9TyD2lfhBnVKoQFda0V6pFKpCESbeNjl12DsxgSJNZFidGXI6
         hLAM5A5LeBhAZE//3ptox0TAqElk6YaYhJtgnU/Xru5D1vQB2p/E89yX8I+FKJou6KkC
         mwC2AAypKkZWESkWmZyfOgeCG9XmmwLpVoIJt8heQZxrF+SFCZKHF4WJOfaU/x/8MHiA
         UhKlZnYL8bqbw6BLKClEkTD8vRHVRQ4eHJzi2cfABkY9L0soGg0YWIVs11GIK+kRpqsh
         koEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpmLs7IIsm/Twfus3ADAkgRV+4VDyjC/3umbBTSac+Y=;
        b=cEvgnZahGbSn6s6XOiThsACQg/fC8R1XYhv4dtDE9VDGk+QuTCGVpCmnbhUo/uVa54
         3SpJz5x7dbXJpGdjh+u6PtD6ktey3le+PTK3dmi8Eg0Mheo7JYSZd2VgZQ8VbpezSPsf
         /bA6U5lYfwhN292Oxn7uHKUgy1g8VErJPEyaq+32mcx5jzuQHUaX+ik01vdDJ1sUHYvH
         8yVFQq3ADFwrhjtftgtgYFm+JqZf8g27qFiFGig0X+egX9N0k68sY+Unw33EX/0bwmS8
         M7t2PD095Qy7+QETkKb+bYecJrEnQZT+RuS8/t43j5gKBREpx59RY/4/5sZTz+8chaP3
         rz1A==
X-Gm-Message-State: AOAM5327UuZRvded+tf9ehDUo6Wc/IWNI8UNnDAv0nVbt8XAldNCCIt5
        b+NQ0qPaX7EYElleaYeA8jo9G5g3gdN2DjNoOnTv+g==
X-Google-Smtp-Source: ABdhPJwivqIzKo9pVePvzJzTrmIguP1+nY8JzeW4gfEBpacoYxl90qv85IPYNsaOFgj76X6qxTxKDl+Wshti4Y7R1MY=
X-Received: by 2002:a17:906:e294:: with SMTP id gg20mr2865511ejb.521.1595487286963;
 Wed, 22 Jul 2020 23:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200722102653.19224-1-guoqing.jiang@cloud.ionos.com> <20200722102653.19224-3-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20200722102653.19224-3-guoqing.jiang@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 23 Jul 2020 08:54:36 +0200
Message-ID: <CAMGffEmMy3L_Dq72M-MZMp9Sw0hE5Xrb9HMqmmeVG-bmCL8GJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rnbd: no need to set bi_end_io in rnbd_bio_map_kern
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 22, 2020 at 12:27 PM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> Since we always set bi_end_io after call rnbd_bio_map_kern, so the
> setting in rnbd_bio_map_kern is redundant.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Thanks!
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/block/rnbd/rnbd-srv-dev.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/block/rnbd/rnbd-srv-dev.c b/drivers/block/rnbd/rnbd-srv-dev.c
> index 49c62b506c9b..b241a099aeae 100644
> --- a/drivers/block/rnbd/rnbd-srv-dev.c
> +++ b/drivers/block/rnbd/rnbd-srv-dev.c
> @@ -99,6 +99,5 @@ struct bio *rnbd_bio_map_kern(void *data, struct bio_set *bs,
>                 offset = 0;
>         }
>
> -       bio->bi_end_io = bio_put;
>         return bio;
>  }
> --
> 2.17.1
>
