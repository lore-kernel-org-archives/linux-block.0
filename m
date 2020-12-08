Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEDDC4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 13:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D8C23AAA
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 13:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgLHNZj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 08:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLHNZi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 08:25:38 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B89FC061793
        for <linux-block@vger.kernel.org>; Tue,  8 Dec 2020 05:24:52 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id a16so24594704ejj.5
        for <linux-block@vger.kernel.org>; Tue, 08 Dec 2020 05:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9dVTG4hRLVcIDRnzcurr4qm52teotk5lENsjfBIfU0U=;
        b=Z2+Dqj2D2wS2IYnxXCJGb9YsUlbSP17esuLpqJqiux8IUnQP7DqAZn1kkGxPZOAvZq
         BL+Yd+WKhuL4scgt6bexnmmJw7yZj8kru2k6mxB8RQUokYS7Kq5SS6RI9FHE/5LzZiQE
         T22AjQzlqi5JKjYwEd7bzZseWLCBnQM0bkv3u1xHPC9wX4x3nwfgZHT5HJM0yTW6hEdS
         dwIa5IbQrjmmHqFamYl3obqEkSYeTO6CkoYgncAms4iQ/cUuq7eGlCgNBmcgUSN3+WH/
         /gkpLwa+yr1H3V7DIE4744hMw9Ewxlcon3LXUkdZ+wV7qz5EO78FKaFUGU0jJpfkk4fi
         aw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9dVTG4hRLVcIDRnzcurr4qm52teotk5lENsjfBIfU0U=;
        b=W+iFg+lSN0WzNnDSPRnrG/yCstXG+LtuxG0MA3YMQugk0iuXoN7pi+KRu6VIengO8D
         VhBpZYiI9guDznPgHqYGXqOWars06pkRZD/kweUPinbBhGyzeN8DFj7dSJsROZKjP91X
         x5/6lik38YzD+2uLL97GXcS9pgonzXYqc+EVzfWH0gFkPeww/rSVhhsdo1swLIY3TDSJ
         waoVjXC9YSGeTp0bfJUYR7oLJ86EXp0PIVraUYF/t7mJXul28GMPZ7QaGAm6w7TltB3X
         QPoaB36shfF4mg/iXA7YsOIXg1jnb2UAMXnKgpotrRePrhFwvUox+q8Zz6ABsCA2caiy
         UexQ==
X-Gm-Message-State: AOAM530IqjMay10OoVVtG/Y3t8ZxvR4Rv1q6U/uQKqnkYXl+vEADtL9L
        J8uf9oJcjH8IdbQmadQTlGA+cmYv2QXv7S4yGfV8OQ==
X-Google-Smtp-Source: ABdhPJzeS04oksT0i/qnH3zDEsKggQhz+lXIDDrQkTbMFRKrVicXUkBuNojLfWDdvFj+P65zbSBVrwOqhVsdRL9umtI=
X-Received: by 2002:a17:906:2e85:: with SMTP id o5mr22975556eji.521.1607433891266;
 Tue, 08 Dec 2020 05:24:51 -0800 (PST)
MIME-Version: 1.0
References: <X89uUXoVbUFMg27k@mwanda> <CAJpMwyjwfPz-xt0VHuXzXuRROiHmy+9OFJSWsZV2ZcJS0MKS6g@mail.gmail.com>
In-Reply-To: <CAJpMwyjwfPz-xt0VHuXzXuRROiHmy+9OFJSWsZV2ZcJS0MKS6g@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 8 Dec 2020 14:24:40 +0100
Message-ID: <CAMGffEm5PaFNR-4aSRFwNBRPFo-ukFGXXrs-8UFjhPJMC=YRsw@mail.gmail.com>
Subject: Re: [bug report] block/rnbd-clt: Dynamically alloc buffer for
 pathname & blk_symlink_name
To:     Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Tue, Dec 8, 2020 at 2:21 PM Haris Iqbal <haris.iqbal@cloud.ionos.com> wrote:
>
> On Tue, Dec 8, 2020 at 5:45 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > Hello Md Haris Iqbal,
> >
> > This is a semi-automatic email about new static checker warnings.
> >
> > The patch 64e8a6ece1a5: "block/rnbd-clt: Dynamically alloc buffer for
> > pathname & blk_symlink_name" from Nov 26, 2020, leads to the
> > following Smatch complaint:
> >
> >     drivers/block/rnbd/rnbd-clt-sysfs.c:525 rnbd_clt_add_dev_symlink()
> >     error: uninitialized symbol 'ret'.
> >
> >     drivers/block/rnbd/rnbd-clt-sysfs.c:524 rnbd_clt_add_dev_symlink()
> >     error: we previously assumed 'dev->blk_symlink_name' could be null (see line 500)
> >
> > drivers/block/rnbd/rnbd-clt-sysfs.c
> >    493  static int rnbd_clt_add_dev_symlink(struct rnbd_clt_dev *dev)
> >    494  {
> >    495          struct kobject *gd_kobj = &disk_to_dev(dev->gd)->kobj;
> >    496          int ret, len;
> >    497
> >    498          len = strlen(dev->pathname) + strlen(dev->sess->sessname) + 2;
> >    499          dev->blk_symlink_name = kzalloc(len, GFP_KERNEL);
> >    500          if (!dev->blk_symlink_name) {
> >    501                  rnbd_clt_err(dev, "Failed to allocate memory for blk_symlink_name\n");
> >    502                  goto out_err;
> >
> > ret = -ENOMEM; here
> >
> >    503          }
> >    504
> >    505          ret = rnbd_clt_get_path_name(dev, dev->blk_symlink_name,
> >    506                                        len);
> >    507          if (ret) {
> >    508                  rnbd_clt_err(dev, "Failed to get /sys/block symlink path, err: %d\n",
> >    509                                ret);
> >    510                  goto out_err;
> >    511          }
> >    512
> >    513          ret = sysfs_create_link(rnbd_devs_kobj, gd_kobj,
> >    514                                  dev->blk_symlink_name);
> >    515          if (ret) {
> >    516                  rnbd_clt_err(dev, "Creating /sys/block symlink failed, err: %d\n",
> >    517                                ret);
> >    518                  goto out_err;
> >    519          }
> >    520
> >    521          return 0;
> >    522
> >    523  out_err:
> >    524          dev->blk_symlink_name[0] = '\0';
> >                 ^^^^^^^^^^^^^^^^^^^^^^^^
> > This will oops if the kzalloc() fails.
>
> Thanks. Will send a patch soon.
already fixed in block tree by Colin
>https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.11/drivers&id=733c15bd3a944b8eeaacdddf061759b6a83dd3f4
> >
> >    525          return ret;
> >    526  }
> >
> > regards,
> > dan carpenter
Thanks!
