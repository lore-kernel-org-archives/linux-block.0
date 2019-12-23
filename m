Return-Path: <SRS0=vQdV=2N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9A0C3F68F
	for <linux-block@archiver.kernel.org>; Mon, 23 Dec 2019 08:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77E0206D3
	for <linux-block@archiver.kernel.org>; Mon, 23 Dec 2019 08:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="FHP42Sd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfLWIeB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Dec 2019 03:34:01 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:44104 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbfLWIeB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Dec 2019 03:34:01 -0500
Received: by mail-il1-f193.google.com with SMTP id z12so13359678iln.11
        for <linux-block@vger.kernel.org>; Mon, 23 Dec 2019 00:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nUppEFUZPs7oUwPsJFV/lYaU9jQhplf9lvipJD6Xpes=;
        b=FHP42Sd5Wc/XKfw3w/uA/5ThgR30ZkFwhfjVP8Yr0kTnh1wm3ZVjWVNr1vhFg8H9+y
         Gb1c/TLp9nxQFwULrxAkbPuN9GxB13/EA0jnDoIROxOdpm75AksHldeqSibYWy2Dvkc7
         BMCXvjFT0jDzt8puh6ZLkp/kAQj4h86vPUDV33xcBVfOi65iBlnvA9T/RcfcYmdxl6Uh
         n0vlhYqeHREQrmM/FAGMdXHO72ZA3gbXcbpHMqXznWimk7OOeKXwbmkpzIXPGCTm4u9t
         qOw8j+sicz1E9ztFVUwixMnpjdtP7aHBa1BqN/fwdgNxC3Fs57IenkVT5gYUBoWebDrE
         zJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nUppEFUZPs7oUwPsJFV/lYaU9jQhplf9lvipJD6Xpes=;
        b=rv+dp11+gIX+uEh+dTVhOxpOxgoIIxYRqNz+ncGPBiIqZXibXIH+LSzCFxKYLyn7dq
         tk4z3a6piA6iOpT8O3FDcU41USZEP5UwQPLwI9NmhumSnD7udMBUJnJDyqwm7qs8jwNn
         IqakVHBqZOnwPSBxivJSFNnVCM0FBwI03zK7jaVHzPnPM4VXFyKfM0wAzRyGC469sn+m
         6nVk1yyXf6Vcvd7/xBgGL/NwCA5CedcPtbQdxvoh6oxMY23/u97Kt9duKJmNHGVRP8yv
         vYX27tiunS+SAYz3ENemBYQDv8TiNtETd1hyop5DLsluXxyXjlnq3mytIXUwVain4+xO
         BeKg==
X-Gm-Message-State: APjAAAVGuAw9VwGzI0KZoLOMnAdjkIPZDju0/iMBasGaaM5W/mgrZ8Bo
        D0en4l8G17dnL+aYQvRpGowyb5G5bhzMlFR+bLNe1Q==
X-Google-Smtp-Source: APXvYqyenEg9Pfzh3zpwTofjurhA7va+LpWlyWEPnFdoW0Il6G3CG7/AYO024Q8vaAbUCIS2R/WvYzsNaNiGnTW8cf8=
X-Received: by 2002:a05:6e02:4d2:: with SMTP id f18mr23274670ils.54.1577090040687;
 Mon, 23 Dec 2019 00:34:00 -0800 (PST)
MIME-Version: 1.0
References: <20191220155109.8959-1-jinpuwang@gmail.com> <20191220155109.8959-23-jinpuwang@gmail.com>
 <20191223081412.GM13335@unreal>
In-Reply-To: <20191223081412.GM13335@unreal>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 23 Dec 2019 09:33:49 +0100
Message-ID: <CAMGffEnnS_HZVo_5D9O-v=6QYJXoaJ63u39cwFu+aiaNTNXTyA@mail.gmail.com>
Subject: Re: [PATCH v5 22/25] rnbd: server: sysfs interface functions
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>, rpenyaev@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 23, 2019 at 9:14 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Fri, Dec 20, 2019 at 04:51:06PM +0100, Jack Wang wrote:
> > From: Jack Wang <jinpu.wang@cloud.ionos.com>
> >
> > This is the sysfs interface to rnbd mapped devices on server side:
> >
> >   /sys/devices/virtual/rnbd-server/ctl/devices/<device_name>/
> >     |- block_dev
> >     |  *** link pointing to the corresponding block device sysfs entry
> >     |
> >     |- sessions/<session-name>/
> >     |  *** sessions directory
> >        |
> >        |- read_only
> >        |  *** is devices mapped as read only
> >        |
> >        |- mapping_path
> >           *** relative device path provided by the client during mapping
> >
> > Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >  drivers/block/rnbd/rnbd-srv-sysfs.c | 234 ++++++++++++++++++++++++++++
> >  1 file changed, 234 insertions(+)
> >  create mode 100644 drivers/block/rnbd/rnbd-srv-sysfs.c
> >
> > diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
> > new file mode 100644
> > index 000000000000..17258156cdf2
> > --- /dev/null
> > +++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
> > @@ -0,0 +1,234 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * InfiniBand Network Block Driver
> > + *
> > + * Copyright (c) 2014 - 2017 ProfitBricks GmbH. All rights reserved.
> > + * Authors: Fabian Holler <mail@fholler.de>
> > + *          Jack Wang <jinpu.wang@profitbricks.com>
> > + *          Kleber Souza <kleber.souza@profitbricks.com>
> > + *          Danil Kipnis <danil.kipnis@profitbricks.com>
> > + *          Roman Penyaev <roman.penyaev@profitbricks.com>
> > + *          Milind Dumbare <Milind.dumbare@gmail.com>
> > + *
> > + * Copyright (c) 2017 - 2018 ProfitBricks GmbH. All rights reserved.
> > + * Authors: Danil Kipnis <danil.kipnis@profitbricks.com>
> > + *          Roman Penyaev <roman.penyaev@profitbricks.com>
> > + *
> > + * Copyright (c) 2018 - 2019 1&1 IONOS Cloud GmbH. All rights reserved.
> > + * Authors: Roman Penyaev <roman.penyaev@profitbricks.com>
> > + *          Jack Wang <jinpu.wang@cloud.ionos.com>
> > + *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > + */
> > +
> > +/* Copyright (c) 2019 1&1 IONOS SE. All rights reserved.
> > + * Authors: Jack Wang <jinpu.wang@cloud.ionos.com>
> > + *          Danil Kipnis <danil.kipnis@cloud.ionos.com>
> > + *          Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
> > + *          Lutz Pogrell <lutz.pogrell@cloud.ionos.com>
> > + */
> > +#undef pr_fmt
> > +#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
> > +
> > +#include <uapi/linux/limits.h>
> > +#include <linux/kobject.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/stat.h>
> > +#include <linux/genhd.h>
> > +#include <linux/list.h>
> > +#include <linux/moduleparam.h>
> > +#include <linux/device.h>
> > +
> > +#include "rnbd-srv.h"
> > +
> > +static struct device *rnbd_dev;
> > +static struct class *rnbd_dev_class;
> > +static struct kobject *rnbd_devs_kobj;
> > +
> > +static struct kobj_type ktype = {
> > +     .sysfs_ops      = &kobj_sysfs_ops,
> > +};
> > +
> > +int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
> > +                            struct block_device *bdev,
> > +                            const char *dir_name)
> > +{
> > +     struct kobject *bdev_kobj;
> > +     int ret;
> > +
> > +     ret = kobject_init_and_add(&dev->dev_kobj, &ktype,
> > +                                rnbd_devs_kobj, dir_name);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = kobject_init_and_add(&dev->dev_sessions_kobj,
> > +                                &ktype,
> > +                                &dev->dev_kobj, "sessions");
> > +     if (ret)
> > +             goto err;
> > +
> > +     bdev_kobj = &disk_to_dev(bdev->bd_disk)->kobj;
> > +     ret = sysfs_create_link(&dev->dev_kobj, bdev_kobj, "block_dev");
> > +     if (ret)
> > +             goto err2;
> > +
> > +     return 0;
> > +
> > +err2:
> > +     kobject_del(&dev->dev_sessions_kobj);
> > +     kobject_put(&dev->dev_sessions_kobj);
> > +err:
> > +     kobject_del(&dev->dev_kobj);
> > +     kobject_put(&dev->dev_kobj);
>
> You are using this _del/_put pattern a lot, from what I see
> kobject_put() is the only is needed.
>
> Thanks
Yes, you're right, for these 2 cases, kobject_put is enough, although
kobject_del is harmless here, which will unregister the kobject from
sysfs, and makes the                        kobject "invisible" to
user.

Will remove them next round.
Thanks
