Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,BIGNUM_EMAILS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1743CC4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 14:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCDC923A5B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 14:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgLHOaF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 09:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729575AbgLHOaF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 09:30:05 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE405C061793
        for <linux-block@vger.kernel.org>; Tue,  8 Dec 2020 06:29:19 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id b9so14542911ejy.0
        for <linux-block@vger.kernel.org>; Tue, 08 Dec 2020 06:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+C2KW2wqTobBKH48qlGidmo7lcCr3N6uJGaL/aSnLs=;
        b=XDlHdzsRfuYYHlbUw8mVVOGXbO6fCpm+rVcnilsX4UJYi9dNft3soFln7vtTKS8Uo3
         dZKUyajypeFPe04JS1u+Tj3ui3byq1rsP8Q+V5mfacF264eb99m8M82AROBkK/w0iwuz
         SnLya5h7vvZ6wkhCB35+vJ2tbkYVBQs7KPxVLjO76hmkjdKAQgxAcC0BiErWbDcYTMg2
         CoRzxbaEC9PEQemXm766n9CIqZhhqwUi3yGP9oEXUFT3fTJLIGpM2pjpRUYlQMSxxm62
         f8xu1nMAAzZF+eWQHQp4I3Ou0yHmfH3JY9Pnzd7pyd1hccPbovAA2moR1zTLp+OsgIRW
         /d9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+C2KW2wqTobBKH48qlGidmo7lcCr3N6uJGaL/aSnLs=;
        b=UNIsK0GzqQ6NRS09bvViebREcDfxl58PTcSbxR/abYqmPzHwXSFj0pOtx9I2QoTYJw
         YTwazn0CClBQmDqL4YDSPDurOzTVzei8p5hLz55TRvli+tSteDNrx4hr2vwUEkFzq3Hz
         oeOFXl7fmYZjc6gZuVSwr53tT1MJcGN+lY2vU0NH1W2NlFkk7Nrf+u8U38eQ2n1nsJer
         g5lH1jdYFUEvdSjJBzy56iGAL3OEX3d3qC4gzefG3AfVhGROuttoEssOVy4OhWZgtivo
         nEpmPripSsXAeV1hxb8AGB5Z1QRN0hfeie66e8UNBC/tUUa10LgLhTtsRXnQgBDi2pyn
         vX+A==
X-Gm-Message-State: AOAM530N3BUF8TVzkmghvEFtvczJ/j5iHPYJx6fztqyEsp8skUPZ8G3H
        0KAiUTydwE5eILuS3g/teb1X5RL3PVq+bnPP00BIvg==
X-Google-Smtp-Source: ABdhPJy+proj28eaKR2fCaulN8JTrHK8XAgHEBCuqWt88IhvhGR+n6n+yyUmtR6BL4HnG5aPACr+Ncy3yN92l+6v0a0=
X-Received: by 2002:a17:906:94ca:: with SMTP id d10mr22342256ejy.62.1607437758386;
 Tue, 08 Dec 2020 06:29:18 -0800 (PST)
MIME-Version: 1.0
References: <X89uUXoVbUFMg27k@mwanda> <CAJpMwyjwfPz-xt0VHuXzXuRROiHmy+9OFJSWsZV2ZcJS0MKS6g@mail.gmail.com>
 <CAMGffEm5PaFNR-4aSRFwNBRPFo-ukFGXXrs-8UFjhPJMC=YRsw@mail.gmail.com> <20201208140552.GC2789@kadam>
In-Reply-To: <20201208140552.GC2789@kadam>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 8 Dec 2020 15:29:07 +0100
Message-ID: <CAMGffEkPUhPXAFMNLCi_WYesQGGsFKkT0r1W9Kfr_4734c_87Q@mail.gmail.com>
Subject: Re: [bug report] block/rnbd-clt: Dynamically alloc buffer for
 pathname & blk_symlink_name
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        linux-block <linux-block@vger.kernel.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 8, 2020 at 3:08 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Tue, Dec 08, 2020 at 02:24:40PM +0100, Jinpu Wang wrote:
> > Hi,
> >
> > On Tue, Dec 8, 2020 at 2:21 PM Haris Iqbal <haris.iqbal@cloud.ionos.com> wrote:
> > >
> > > On Tue, Dec 8, 2020 at 5:45 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > >
> > > > Hello Md Haris Iqbal,
> > > >
> > > > This is a semi-automatic email about new static checker warnings.
> > > >
> > > > The patch 64e8a6ece1a5: "block/rnbd-clt: Dynamically alloc buffer for
> > > > pathname & blk_symlink_name" from Nov 26, 2020, leads to the
> > > > following Smatch complaint:
> > > >
> > > >     drivers/block/rnbd/rnbd-clt-sysfs.c:525 rnbd_clt_add_dev_symlink()
> > > >     error: uninitialized symbol 'ret'.
> > > >
> > > >     drivers/block/rnbd/rnbd-clt-sysfs.c:524 rnbd_clt_add_dev_symlink()
> > > >     error: we previously assumed 'dev->blk_symlink_name' could be null (see line 500)
> > > >
> > > > drivers/block/rnbd/rnbd-clt-sysfs.c
> > > >    493  static int rnbd_clt_add_dev_symlink(struct rnbd_clt_dev *dev)
> > > >    494  {
> > > >    495          struct kobject *gd_kobj = &disk_to_dev(dev->gd)->kobj;
> > > >    496          int ret, len;
> > > >    497
> > > >    498          len = strlen(dev->pathname) + strlen(dev->sess->sessname) + 2;
> > > >    499          dev->blk_symlink_name = kzalloc(len, GFP_KERNEL);
> > > >    500          if (!dev->blk_symlink_name) {
> > > >    501                  rnbd_clt_err(dev, "Failed to allocate memory for blk_symlink_name\n");
> > > >    502                  goto out_err;
> > > >
> > > > ret = -ENOMEM; here
> > > >
> > > >    503          }
> > > >    504
> > > >    505          ret = rnbd_clt_get_path_name(dev, dev->blk_symlink_name,
> > > >    506                                        len);
> > > >    507          if (ret) {
> > > >    508                  rnbd_clt_err(dev, "Failed to get /sys/block symlink path, err: %d\n",
> > > >    509                                ret);
> > > >    510                  goto out_err;
> > > >    511          }
> > > >    512
> > > >    513          ret = sysfs_create_link(rnbd_devs_kobj, gd_kobj,
> > > >    514                                  dev->blk_symlink_name);
> > > >    515          if (ret) {
> > > >    516                  rnbd_clt_err(dev, "Creating /sys/block symlink failed, err: %d\n",
> > > >    517                                ret);
> > > >    518                  goto out_err;
> > > >    519          }
> > > >    520
> > > >    521          return 0;
> > > >    522
> > > >    523  out_err:
> > > >    524          dev->blk_symlink_name[0] = '\0';
> > > >                 ^^^^^^^^^^^^^^^^^^^^^^^^
> > > > This will oops if the kzalloc() fails.
> > >
> > > Thanks. Will send a patch soon.
> > already fixed in block tree by Colin
> > >https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.11/drivers&id=733c15bd3a944b8eeaacdddf061759b6a83dd3f4
>
> It's a weird thing that we don't free dev->blk_symlink_name if there
> is an error.  It's impossible for rnbd_clt_get_path_name() to actually
> return an error in the current code, but if it did then only the last
> character of dev->blk_symlink_name[] is initialized.

right, will send out a fix soon.
>
> regards,
> dan carpenter
>
Thanks!
