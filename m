Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B69C433EF
	for <linux-block@archiver.kernel.org>; Wed, 22 Jun 2022 10:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353204AbiFVK7A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jun 2022 06:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353440AbiFVK6W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jun 2022 06:58:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7E9165B7
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 03:58:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h23so33331913ejj.12
        for <linux-block@vger.kernel.org>; Wed, 22 Jun 2022 03:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xVXVUCVrx9T7gToLuzws6IAdgE4BgTCq8bWjRWB2+8o=;
        b=UPFGklVc7f9C07cI/CohhTmtRlRrCIIpAjEUDXdiiqTLaGlcgCWocax6UOI0wuA4uN
         XFDMUwzjJQ04iQV3d0p3FdTVwISdLNNbIyKDL2CRPG3Y33OYLVmyNN5RWTiwFRujqaUb
         ZvIn4cvGTb5mzI/22eSLJtBRhsm+T2b+N4JDPUrn9oGBmNWi7MAk0+2GY0v/Eo6uhlGs
         u1BljrkUmvBLe/rR8JC7zTtSy9cWMLT5nuJWjeyRxmpDWZ2nr7ohpU33fXnLgeYhycdh
         V6mUa7kMviaIurQosNrdqdUbqFMwd4kWLelIwLKIJoi5s932ofATeoXtCcOVH57cclri
         Vb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xVXVUCVrx9T7gToLuzws6IAdgE4BgTCq8bWjRWB2+8o=;
        b=Jce/iA6W9MXSGOLKUbzCrr0FYsLVNbxf86NUaOWxj8iy+yV2FV0+R9lDoEoTI93y9f
         edz+MaU+6m0QD8Oyn/LLR2yv8srn5+aEnfcbEH2Zz4T/Xtu1Aj1g7f+MWnqAMaMWhCTq
         9z4LORhMd/6Hqrc/byJhQk9ETQ21MTRpfYPe2jZXkS/j36wmNLB4dUoZ+M7EiLsQ+O3T
         RdXC/4g02zFtKJkn6+e3yeIJQfquP+RUxRar1x67jtzfn4+JClXQ9rqiqocZXi/SSIEY
         z72rtHF/bT16WGVbRZpdE5KYM6ElQlRoZ+LmEpnqd7vA5GJsLBT2scMnfxm7BeDmDBUE
         3Fbw==
X-Gm-Message-State: AJIora90S/rwVAMb1zpULUGfnanydNUkR0CXg9MRI6NbRBPIjYXGSLIz
        7CoCHITnaPbliBklv7vXPI85s1NPEt26Qvswv5m5cBlN6JA=
X-Google-Smtp-Source: AGRyM1sTCUy1vod46zGEyHMQEr0lAZcfQ4KbdTIo4MQztlPbv9tPD7Gt3NejCNQlFnK2PrasxsemSZ3m65ZJ6iG8mrc=
X-Received: by 2002:a17:906:cc87:b0:722:fb3e:9f9c with SMTP id
 oq7-20020a170906cc8700b00722fb3e9f9cmr97868ejb.624.1655895498057; Wed, 22 Jun
 2022 03:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220620034923.35633-1-guoqing.jiang@linux.dev> <20220620034923.35633-6-guoqing.jiang@linux.dev>
In-Reply-To: <20220620034923.35633-6-guoqing.jiang@linux.dev>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 22 Jun 2022 12:58:07 +0200
Message-ID: <CAMGffEk-M1FOLpez4qkiHLb1ms9rhye2XRXGaqzrSohL0Aoi4w@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] rnbd-clt: adjust the layout of struct rnbd_clt_dev
To:     Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     haris.iqbal@ionos.com, axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 20, 2022 at 5:50 AM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>
> While at it, let re-arrange the struct to remove holes.
>
> Before, pahole reports
>
>         /* size: 232, cachelines: 4, members: 17 */
>         /* sum members: 224, holes: 2, sum holes: 8 */
>         /* last cacheline: 40 bytes */
>
> After the change, the report changes to
>
>         /* size: 224, cachelines: 4, members: 17 */
>         /* last cacheline: 32 bytes */
>
> Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
lgtm
Acked-by: Jack Wang <jinpu.wang@ionos.com>

> ---
>  drivers/block/rnbd/rnbd-clt.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
> index 7520272541b1..df237d2ea0d9 100644
> --- a/drivers/block/rnbd/rnbd-clt.h
> +++ b/drivers/block/rnbd/rnbd-clt.h
> @@ -106,6 +106,7 @@ struct rnbd_queue {
>  };
>
>  struct rnbd_clt_dev {
> +       struct kobject          kobj;
>         struct rnbd_clt_session *sess;
>         struct request_queue    *queue;
>         struct rnbd_queue       *hw_queues;
> @@ -114,15 +115,14 @@ struct rnbd_clt_dev {
>         u32                     clt_device_id;
>         struct mutex            lock;
>         enum rnbd_clt_dev_state dev_state;
> +       refcount_t              refcount;
>         char                    *pathname;
>         enum rnbd_access_mode   access_mode;
>         u32                     nr_poll_queues;
>         u64                     size;           /* device size in bytes */
>         struct list_head        list;
>         struct gendisk          *gd;
> -       struct kobject          kobj;
>         char                    *blk_symlink_name;
> -       refcount_t              refcount;
>         struct work_struct      unmap_on_rmmod_work;
>  };
>
> --
> 2.34.1
>
