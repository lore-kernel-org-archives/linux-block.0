Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945ADC43334
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 10:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353180AbiFVK6K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 06:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353225AbiFVK6D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 06:58:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AED5265B
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 03:57:56 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z11so17178396edp.9
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 03:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVhKPE95G0iQb95T7+3YKjBRVQCnwOq1zxKMgzqDjzk=;
        b=A00x2UVNvXxcsj94UM/9L6F6sAjkZVxAGmO7XL5YgaGv0BPvgo33FLvEPNrZ7Ze72a
         FP0ad/dOW1QjZYR81bCbOGoXvyjD80lhIeNh6tDJ4EFMdve6GwsEHn4vKzOxdHjRm/36
         8NVwYZ144sFM5Bcn+gaCs2TiFuPEaC7Wnrw72Y2QcdQjhHoyvzlawcdY4zFUMewG2RrF
         mshVOYY8iaBJt/eWruK0l50nLR2JBw9E+O5g47k+50LTTN+S73L0FlNtukKsGp9reRXx
         J43InDp8Jrr3/8zrtjOHV5Uzxhff7FR5lYNiTz3ZVCm1OJ9MJio6uFnsj+puxCzMDxI1
         VZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVhKPE95G0iQb95T7+3YKjBRVQCnwOq1zxKMgzqDjzk=;
        b=Q8DnWGwLY+fJD/UihTudetl99ljCTItM2FbCkFXLVwed5BZvnA55We64Mpl3lihHGA
         hzFfJY8WoXo4mtG/XL3qHYRA8rrnO8rr1J2clAr82UPv/3bAlekqx1AQbl0QlQs12Jtj
         joHHwsvNJ8x+sCKAYV+A7s3qcDEZPUgZaUfPYI7gO8LEFmmFdvNEXS4mxVx8Qci6k/gD
         VpzOGAHRG7/oWC3QDw1Hxl871WuWV514m4ZeBl6h44nEpdhfj+8OosGbTAK0WtRvWPqL
         RhIIeHfrP8K51cw6+fPZoeb+J5DCLzg+VnVaVSiPH9hn2pMdQmm+TP5Q4F+2m4jmPO+m
         hczA==
X-Gm-Message-State: AJIora9rxb22cx0/sqeSDjT8TpYLzrWdUEHxf79CCZEv9ftVlH8jiTZU
        pqa1tmxjPKdOwoxkhwZgHd+6NmR8LpLZrP+M+6XTFg==
X-Google-Smtp-Source: AGRyM1tgh1hrNjykE5irynryPpD+qx/1meWQc4cmCUItkGXAqvc8v7FPHwsu/MjmtWszjkEjCjjcSh3kIaJvSZliZGY=
X-Received: by 2002:a05:6402:5193:b0:435:9a5f:50a8 with SMTP id
 q19-20020a056402519300b004359a5f50a8mr3507404edd.212.1655895475073; Wed, 22
 Jun 2022 03:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220620034923.35633-1-guoqing.jiang@linux.dev> <20220620034923.35633-3-guoqing.jiang@linux.dev>
In-Reply-To: <20220620034923.35633-3-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 22 Jun 2022 12:57:44 +0200
Message-ID: <CAMGffEnUcUMOXocoWpPjXEt9sNwPO0-RS11SnNpaSDWrQd1esA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/6] rnbd-clt: don't free rsp in msg_open_conf for map scenario
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 20, 2022 at 5:50 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> For map scenario, rsp is freed in two places:
>
> 1. msg_open_conf frees rsp if rtrs_clt_request returns 0.
>
> 2. Otherwise, rsp is freed by the call sites of rtrs_clt_request.
>
> Now, We'd like to control full lifecycle of rsp in rnbd_clt_map_device,
> with that, it is feasible to pass rsp to rnbd_client_setup_device in
> next commit.
>
> For 1, it is possible to free rsp from the caller of send_usr_msg
> because of the synchronization of iu->comp.wait. And we put iu later
> in rnbd_clt_map_device to ensure order of release rsp and iu.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 0396532da742..6c4970878d23 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -507,6 +507,11 @@ static void msg_open_conf(struct work_struct *work)
>         struct rnbd_msg_open_rsp *rsp = iu->buf;
>         struct rnbd_clt_dev *dev = iu->dev;
>         int errno = iu->errno;
> +       bool from_map = false;
> +
> +       /* INIT state is only triggered from rnbd_clt_map_device */
> +       if (dev->dev_state == DEV_STATE_INIT)
> +               from_map = true;
>
>         if (errno) {
>                 rnbd_clt_err(dev,
> @@ -523,7 +528,9 @@ static void msg_open_conf(struct work_struct *work)
>                         send_msg_close(dev, device_id, RTRS_PERMIT_NOWAIT);
>                 }
>         }
> -       kfree(rsp);
> +       /* We free rsp in rnbd_clt_map_device for map scenario */
> +       if (!from_map)
> +               kfree(rsp);
>         wake_up_iu_comp(iu, errno);
>         rnbd_put_iu(dev->sess, iu);
>         rnbd_clt_put_dev(dev);
> @@ -1617,16 +1624,14 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
>         if (ret) {
>                 rnbd_clt_put_dev(dev);
>                 rnbd_put_iu(sess, iu);
> -               kfree(rsp);
>         } else {
>                 ret = errno;
>         }
> -       rnbd_put_iu(sess, iu);
>         if (ret) {
>                 rnbd_clt_err(dev,
>                               "map_device: failed, can't open remote device, err: %d\n",
>                               ret);
> -               goto del_dev;
> +               goto put_iu;
>         }
>
>         mutex_lock(&dev->lock);
> @@ -1651,12 +1656,17 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
>                        dev->max_hw_sectors, dev->wc, dev->fua);
>
>         mutex_unlock(&dev->lock);
> +       kfree(rsp);
> +       rnbd_put_iu(sess, iu);
>         rnbd_clt_put_sess(sess);
>
>         return dev;
>
>  send_close:
>         send_msg_close(dev, dev->device_id, RTRS_PERMIT_WAIT);
> +put_iu:
> +       kfree(rsp);
> +       rnbd_put_iu(sess, iu);
>  del_dev:
>         delete_dev(dev);
>  put_dev:
> --
> 2.34.1
>
lgtm.
Acked-by: Jack Wang <jinpu.wang@ionos.com>
