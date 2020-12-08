Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72DFC4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 13:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0AF823AA8
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 13:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgLHNVy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 08:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgLHNVy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 08:21:54 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2112C061749
        for <linux-block@vger.kernel.org>; Tue,  8 Dec 2020 05:21:07 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id r24so23073282lfm.8
        for <linux-block@vger.kernel.org>; Tue, 08 Dec 2020 05:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5kquKLHM9ARabn+TdMTniu0G1sP/fZ5sCbF8eukA3Ck=;
        b=AKFpoH4dsY9qm8rGG1p01W6mQ91kMeUUUKTYlP6NZLko6HQMQFjVvkxRtckJ5QDiju
         fZKOl5G++vH4PZOyVBUsk1H5XYPLEaMFm0LZLJXquU+2Mu9OerVi5k1+wnXkC8d72Htd
         MHbjMnaYikbi5n8pcweOcBUPNqByem3ytVncMm6psU05nMX3GrmiwPH7dwlAMd3oMXOK
         g/TKCIkgeTJizcn+lScsNM5AhMjSEdZmpglH3P5bZrn0FE4nEc3Lewd+LfHEZD7KoaHf
         AX84kETLW7h2bfm0W+RP0sNeLsEEIHka0tJtzTStwvI2z74gy4kWk+nWyYuEde/YpYOU
         wqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kquKLHM9ARabn+TdMTniu0G1sP/fZ5sCbF8eukA3Ck=;
        b=iVuJqi9ZLn/1QtaiV3wFrq8wA51yJV8chamqOO9IXAXi8VwgMn5a7L3zhKkIPSKUbl
         E95ZBqETp4Gy21+ruPRGe14/qrAaz3kS/mw+ExJN3fVOD16+NehNm2GHtmc2qdFrQ3Zt
         bF9HY3EQT1O+rlAwVoKDLRow5mwvTLQLEEzSpIoy/YiVlKaFiK3e0JmMqewjWFmljuyM
         +Vl0XNzvUEQnFL/XRdlXt6rQZ9nJsJbqsWlKKYM+Tveo/KGhkH1SyRSyav7n0PKnOoZJ
         CO66Q1CQJAi/M5LSbVhgs5Y+pNpbiUdDFOyKfPu79p1V8NGXnc7trqH/uMzd2zmTQbYQ
         z2Fg==
X-Gm-Message-State: AOAM5323lPZuP0BWPov/w7BOKn9TjYM1Z/ahaj4aR5SXfQ2F23nX7W51
        Sf9dMatVyy4AHNrvIOEceALyPse5f9nCjWHNxkWrDQ==
X-Google-Smtp-Source: ABdhPJzdyNvfwK7pFuWiLEM4FnqLPj8cN39pUBDqrWZP2QDbv+9K+0HOFAzzh7M7kYe3WhYNsh5SLTPVerPABer0AjY=
X-Received: by 2002:a19:7b16:: with SMTP id w22mr281514lfc.657.1607433666091;
 Tue, 08 Dec 2020 05:21:06 -0800 (PST)
MIME-Version: 1.0
References: <X89uUXoVbUFMg27k@mwanda>
In-Reply-To: <X89uUXoVbUFMg27k@mwanda>
From:   Haris Iqbal <haris.iqbal@cloud.ionos.com>
Date:   Tue, 8 Dec 2020 18:50:55 +0530
Message-ID: <CAJpMwyjwfPz-xt0VHuXzXuRROiHmy+9OFJSWsZV2ZcJS0MKS6g@mail.gmail.com>
Subject: Re: [bug report] block/rnbd-clt: Dynamically alloc buffer for
 pathname & blk_symlink_name
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-block@vger.kernel.org,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 8, 2020 at 5:45 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Md Haris Iqbal,
>
> This is a semi-automatic email about new static checker warnings.
>
> The patch 64e8a6ece1a5: "block/rnbd-clt: Dynamically alloc buffer for
> pathname & blk_symlink_name" from Nov 26, 2020, leads to the
> following Smatch complaint:
>
>     drivers/block/rnbd/rnbd-clt-sysfs.c:525 rnbd_clt_add_dev_symlink()
>     error: uninitialized symbol 'ret'.
>
>     drivers/block/rnbd/rnbd-clt-sysfs.c:524 rnbd_clt_add_dev_symlink()
>     error: we previously assumed 'dev->blk_symlink_name' could be null (see line 500)
>
> drivers/block/rnbd/rnbd-clt-sysfs.c
>    493  static int rnbd_clt_add_dev_symlink(struct rnbd_clt_dev *dev)
>    494  {
>    495          struct kobject *gd_kobj = &disk_to_dev(dev->gd)->kobj;
>    496          int ret, len;
>    497
>    498          len = strlen(dev->pathname) + strlen(dev->sess->sessname) + 2;
>    499          dev->blk_symlink_name = kzalloc(len, GFP_KERNEL);
>    500          if (!dev->blk_symlink_name) {
>    501                  rnbd_clt_err(dev, "Failed to allocate memory for blk_symlink_name\n");
>    502                  goto out_err;
>
> ret = -ENOMEM; here
>
>    503          }
>    504
>    505          ret = rnbd_clt_get_path_name(dev, dev->blk_symlink_name,
>    506                                        len);
>    507          if (ret) {
>    508                  rnbd_clt_err(dev, "Failed to get /sys/block symlink path, err: %d\n",
>    509                                ret);
>    510                  goto out_err;
>    511          }
>    512
>    513          ret = sysfs_create_link(rnbd_devs_kobj, gd_kobj,
>    514                                  dev->blk_symlink_name);
>    515          if (ret) {
>    516                  rnbd_clt_err(dev, "Creating /sys/block symlink failed, err: %d\n",
>    517                                ret);
>    518                  goto out_err;
>    519          }
>    520
>    521          return 0;
>    522
>    523  out_err:
>    524          dev->blk_symlink_name[0] = '\0';
>                 ^^^^^^^^^^^^^^^^^^^^^^^^
> This will oops if the kzalloc() fails.

Thanks. Will send a patch soon.

>
>    525          return ret;
>    526  }
>
> regards,
> dan carpenter
