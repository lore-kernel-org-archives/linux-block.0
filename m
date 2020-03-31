Return-Path: <SRS0=+91Y=5Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9B5C2D0EE
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA262072E
	for <linux-block@archiver.kernel.org>; Tue, 31 Mar 2020 09:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="L4AdER7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgCaJ35 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:29:57 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39223 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbgCaJ35 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 05:29:57 -0400
Received: by mail-io1-f65.google.com with SMTP id c16so6552500iod.6
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2020 02:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e9TC9Dvq+NxHGmVjcxml98fEBNVdqGYWIzldJgXCRdc=;
        b=L4AdER7p0yZLutfy4JSvfuKwUGwUmZY2JV3er/hjSVcru+yO8m3Egcr096hguEw12Q
         kG15HJ6d7JqhzwOT0tw9DIIxCvpEixVwn39C6k1HAEHhp8mFv7YN4eFVcemYszFPOUpU
         0rWazWw5V3HmcarKda3nQN6I4XsioPeTiqg57pMMIAcFwnWSfcOHOBqy3ZytnVWE678H
         nFeH2A0KlPu7tzGNqIkVftUouawcRYHYxkWsBXOWXqU97hqUZ+hjlT5IZhxvEqlNIKZ7
         b6jCOfNNnknKTfNXNUAlTT7a5oH9CMUi9pem8iaFF2MLcog5D5nVH68T2Jz7sTNqfM5G
         djfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e9TC9Dvq+NxHGmVjcxml98fEBNVdqGYWIzldJgXCRdc=;
        b=Tq7CbfnDLfQrXrL8VnD7GtXEiYR8ynOzH4N4Q7GBzNbPNUBnrXt6MRrCDineTsnAMI
         4vZVzlL6D6F3Xfx7JfXsIVC3S6c5zX89i/WwA/66K+BJ9P3sdFXsmdKRWW2U0Tka/chH
         8ELXLZH1qKuMbj+vGKSdR0GphPtwYsXbdFFJZE2792fWvl1Nhbym6JboeD8e3vPM67WY
         jZ9QPSunFQS+BoGc95I+dn2qf3aQFiQd8gVJ4WNm6P2A4iWB4HfrYO9DR/ZJri+QJ+fe
         4xVEGfqc5WAdqW0UlLxkoddh50B31jmnicSHkFIa5abLujQ8dlgIjp4RiXLpAFGfJ0T6
         VYyQ==
X-Gm-Message-State: ANhLgQ3RyEukIMa/VEncjMR3rJ9oOvJqdUzT7sOjSdPCAHG1NFdCZPES
        BJmLo2xIdL0ER9QPiuEyfaMtsUMhwyCElnOvjPnjlA==
X-Google-Smtp-Source: ADFU+vtWWlZdtpSbBkN5OF1s68dy0E68ycIqrABToueXo4BBTpuuADtHMSmrlQ5bG4CgB6gHmAHmcls73EBg9Oeub2A=
X-Received: by 2002:a6b:b24d:: with SMTP id b74mr14544159iof.49.1585646996530;
 Tue, 31 Mar 2020 02:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-22-jinpu.wang@cloud.ionos.com> <ba7c258f-a169-f2d5-3d62-62a7d09908a4@acm.org>
In-Reply-To: <ba7c258f-a169-f2d5-3d62-62a7d09908a4@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 31 Mar 2020 11:29:45 +0200
Message-ID: <CAMGffE=4LNom-aWJhogqjgD+mHPp1_B9g=rEzHzdr=x9Zy6vAw@mail.gmail.com>
Subject: Re: [PATCH v11 21/26] block/rnbd: server: main functionality
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Roman Penyaev <rpenyaev@suse.de>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 28, 2020 at 6:41 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > +static int __read_mostly port_nr = RTRS_PORT;
>
> Would uint16_t be sufficient for this kernel module parameter?
yes, u16 is enough.
>
> Is this kernel module parameter used anywhere in the hot path? If not,
> should __read_mostly perhaps be left out?
not in hot path, __read_mostly can be removed.
>
> > +module_param_named(port_nr, port_nr, int, 0444);
> > +MODULE_PARM_DESC(port_nr,
> > +              "The port number server is listening on (default: "
>                                 ^^^
>                                 the?
right!
> > +              __stringify(RTRS_PORT)")");
> > +
> > +#define DEFAULT_DEV_SEARCH_PATH "/"
>
> > +static void destroy_device(struct rnbd_srv_dev *dev)
> > +{
> > +     WARN(!list_empty(&dev->sess_dev_list),
> > +          "Device %s is being destroyed but still in use!\n",
> > +          dev->id);
>
> Has it been considered to change WARN() into WARN_ONCE()?
ok.
>
> > +static int rnbd_srv_rdma_ev(struct rtrs_srv *rtrs, void *priv,
> > +                          struct rtrs_srv_op *id, int dir,
> > +                          void *data, size_t datalen, const void *usr,
> > +                          size_t usrlen)
> > +{
> > +     struct rnbd_srv_session *srv_sess = priv;
> > +     const struct rnbd_msg_hdr *hdr = usr;
> > +     int ret = 0;
> > +     u16 type;
> > +
> > +     if (WARN_ON(!srv_sess))
> > +             return -ENODEV;
>
> Same question here: how about using WARN_ON_ONCE() instead of WARN_ON()?
ok.
>
> > +static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
> > +                                  const char *dev_name)
> > +{
> > +     char *full_path;
> > +     char *a, *b;
> > +
> > +     full_path = kmalloc(PATH_MAX, GFP_KERNEL);
> > +     if (!full_path)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     /*
> > +      * Replace %SESSNAME% with a real session name in order to
> > +      * create device namespace.
> > +      */
> > +     a = strnstr(dev_search_path, "%SESSNAME%", sizeof(dev_search_path));
> > +     if (a) {
> > +             int len = a - dev_search_path;
> > +
> > +             len = snprintf(full_path, PATH_MAX, "%.*s/%s/%s", len,
> > +                            dev_search_path, srv_sess->sessname, dev_name);
> > +             if (len >= PATH_MAX) {
> > +                     pr_err("Tooooo looong path: %s, %s, %s\n",
> > +                            dev_search_path, srv_sess->sessname, dev_name);
> > +                     kfree(full_path);
> > +                     return ERR_PTR(-EINVAL);
> > +             }
> > +     } else {
> > +             snprintf(full_path, PATH_MAX, "%s/%s",
> > +                      dev_search_path, dev_name);
> > +     }
>
> Has it been considered to use kasprintf() instead of kmalloc() + snprintf()?
will convert to kasprintf.
>
> Otherwise this patch looks fine to me.
>
> Thanks,
>
> Bart.
Thanks Bart!
