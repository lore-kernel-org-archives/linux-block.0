Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1886CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 15:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352559AbiFUPNF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 11:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352564AbiFUPMt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 11:12:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADF82CCB4
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 08:11:49 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z19so2965993edb.11
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 08:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zVQKmLoB1TE6Nbdx5DcwofeJrMYlMY+7K4pclCDmSBc=;
        b=LOIl8kjOyJQ3llX8OxuesXKBKy1iwa9RmSznPkD1MRX7bYNQAyqOXIUwaLrPK04Gvk
         YI0/Vxqb5xn6D/4UUTAW+R9+udYQ3WucNV3sU8hU/4w83q/eBddtaO9wQ1lvs5mMCD4d
         FvTjM5suFscac6J1FKD0Uq/HAbOmNC8YifF/td1b01lkxo2e8P0Z/Z6OUQTih8sFvZYT
         vZuEnaKcavEGPxz14nvlEh4m7hsBQbG7ubOBdoRWr3fLVqYf1vkY+yze1nWtKLezODVi
         hSHAjCe3EVOip/r9gpI1I+XftZ9rnG/M4m2KyDNQoZ68Mx8GMoRuziMDATso5WiOhRSU
         9uJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zVQKmLoB1TE6Nbdx5DcwofeJrMYlMY+7K4pclCDmSBc=;
        b=tOShiFv37Q8+OiGN6BbNgVKt81DKvHAJNrgdsc8RZp+OzSiWCUJKOHMFwFBQ9r3uHy
         s0sVoOyhiKkHEt4/zA08pS3GnSm8y9gX/IV8LkGswJ8IKgFjesor6Dotnl1TL21w7YLG
         g1D4itFuphDznnvnVCNMNVb4UWT1zqSIATogdSo5ikUdHmyJZUOMDBPz08mErme37NF8
         auHfc0aVa2RuAVv4+bwwradxAQWH5+czpLrKrpMxN9ssFu0zYoi4mqH4th86ChtRO/85
         QMRp+vsJnnLLeUSsI+22XeuUvTPj4b911njNgkk5FW3kAveE7wajcnJeHaHFv6PcrhoE
         Nvng==
X-Gm-Message-State: AJIora/xTNrOgX6sF6oRKGinfYIuu6VDWAB9fefYlu5lXWlendqTFFBB
        kE0eUd691I1qBBkE6zH00jaANefmJbx9lMY0xJ0MiQ==
X-Google-Smtp-Source: AGRyM1tci2sochviIgiO2vkmMvtbPndJnBwhN3rk8Lc/C1Y6oqMGJYBVaGJkknqNgDhlnScvCE4Ft62vIiLkACr6iqg=
X-Received: by 2002:a05:6402:5193:b0:435:9a5f:50a8 with SMTP id
 q19-20020a056402519300b004359a5f50a8mr3373449edd.212.1655824285815; Tue, 21
 Jun 2022 08:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220620034923.35633-1-guoqing.jiang@linux.dev> <20220620034923.35633-2-guoqing.jiang@linux.dev>
In-Reply-To: <20220620034923.35633-2-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 21 Jun 2022 17:11:15 +0200
Message-ID: <CAMGffEn9_FPgX_RLds7RwPL_TSft0NHFXTsR_AjyeQF=mXQwkA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/6] rnbd-clt: open code send_msg_open in rnbd_clt_map_device
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 20, 2022 at 5:49 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> Let's open code it in rnbd_clt_map_device, then we can use information
> from rsp to setup gendisk and request_queue in next commits. After that,
> we can remove some members (wc, fua and max_hw_sectors etc) from struct
> rnbd_clt_dev.
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
> ---
>  drivers/block/rnbd/rnbd-clt.c | 44 +++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 409c76b81aed..0396532da742 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -1562,7 +1562,14 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
>  {
>         struct rnbd_clt_session *sess;
>         struct rnbd_clt_dev *dev;
> -       int ret;
> +       int ret, errno;
> +       struct rnbd_msg_open_rsp *rsp;
> +       struct rnbd_msg_open msg;
> +       struct rnbd_iu *iu;
> +       struct kvec vec = {
> +               .iov_base = &msg,
> +               .iov_len  = sizeof(msg)
> +       };
>
>         if (exists_devpath(pathname, sessname))
>                 return ERR_PTR(-EEXIST);
> @@ -1582,13 +1589,46 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
>                 ret = -EEXIST;
>                 goto put_dev;
>         }
> -       ret = send_msg_open(dev, RTRS_PERMIT_WAIT);
> +
> +       rsp = kzalloc(sizeof(*rsp), GFP_KERNEL);
> +       if (!rsp) {
> +               ret = -ENOMEM;
> +               goto del_dev;
> +       }
> +
> +       iu = rnbd_get_iu(sess, RTRS_ADMIN_CON, RTRS_PERMIT_WAIT);
> +       if (!iu) {
> +               ret = -ENOMEM;
> +               kfree(rsp);
> +               goto del_dev;
> +       }
> +       iu->buf = rsp;
> +       iu->dev = dev;
> +       sg_init_one(iu->sgt.sgl, rsp, sizeof(*rsp));
> +
> +       msg.hdr.type    = cpu_to_le16(RNBD_MSG_OPEN);
> +       msg.access_mode = dev->access_mode;
> +       strscpy(msg.dev_name, dev->pathname, sizeof(msg.dev_name));
> +
> +       WARN_ON(!rnbd_clt_get_dev(dev));
> +       ret = send_usr_msg(sess->rtrs, READ, iu,
> +                          &vec, sizeof(*rsp), iu->sgt.sgl, 1,
> +                          msg_open_conf, &errno, RTRS_PERMIT_WAIT);
> +       if (ret) {
> +               rnbd_clt_put_dev(dev);
> +               rnbd_put_iu(sess, iu);
> +               kfree(rsp);
> +       } else {
> +               ret = errno;
> +       }
> +       rnbd_put_iu(sess, iu);
>         if (ret) {
>                 rnbd_clt_err(dev,
>                               "map_device: failed, can't open remote device, err: %d\n",
>                               ret);
>                 goto del_dev;
>         }
> +
looks ok, except this new line seems not needed.

Thx!
>         mutex_lock(&dev->lock);
>         pr_debug("Opened remote device: session=%s, path='%s'\n",
>                  sess->sessname, pathname);
> --
> 2.34.1
>
