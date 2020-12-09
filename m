Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A96C4361B
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 16:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120A823BE3
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 16:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgLIQO6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 11:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgLIQO6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 11:14:58 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC6CC0613CF
        for <linux-block@vger.kernel.org>; Wed,  9 Dec 2020 08:14:17 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id f11so3027117ljm.8
        for <linux-block@vger.kernel.org>; Wed, 09 Dec 2020 08:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZAg+cDUtB7m1aEcjEYgg+0yDU3LaVgWbWORq8MBJjvw=;
        b=gk4+POP2vmzeezWL3zTTSECKdVZ1I7QTqj8Gul0V1gsTaqpw7Vz+R8yzX68edG87Yv
         aPc+KFAse3ln/vjs8agAB83vpPf8CHEwjhk/TrLlO9/Mr90LDfwA62F5zjO0g/sQz++G
         j9NsBjKuC3msGg/XUNXzdZuvXAJ7bB4nj87j0MwBUAUxdOpPlNFuoI1wuORWN3Si5JPc
         V3dbE59zQF4/n5WuLLgfxJxx351/HWvf14A8CbGIWdR6cJ1rh9gHNtNA3sDX0NpDfhW5
         XzuERla2qIFbnUboLpAu6kWiU3U8AwThzggdSA9ipPSNvWjahz8Py2RjcQoj9NSwZ54b
         9Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZAg+cDUtB7m1aEcjEYgg+0yDU3LaVgWbWORq8MBJjvw=;
        b=mSLL3b9oDqihZH3w20AsdKj252ucemWfaqt9tq32IBLEECs5g+CNdY+yHiHxdzR98K
         1qnDUQ0OshOCkKAk7ctpgGHoBlDZap+4Bh/PEeL0jN64FCT7udRBr/+yKkRtSPW6uwkZ
         1CjXZ/CblsTPISHT9LWBq73rFxxuXP1H4QzcuS8F75eW11QmDCvG/vz7ckniqC6zZWsU
         Fx2+Q3+ftHdhtXgwjXPC1bePuAKJAgYnMjZbfpsH7OhQdnA2J7a2uO1XhV/YW5xBaMTh
         lTF3fCGEK6aq2RRxURFr22odVzP7ugPYEKpFW+YAxi4SzDwMxVx/nrukjbwwThwbb1H0
         l91Q==
X-Gm-Message-State: AOAM533At+rg1qjfEQpiGPIWSS6exsmx+Q7kU1BzOjj+5Uv6+nIfnGgC
        BuOxjjR5yIlNdrb9+E7RPUstxcsOHHfot94/P/CVhg==
X-Google-Smtp-Source: ABdhPJxGzwQTFrvBJpK1OG1cKANgdkxMW+Qy09Ymspx2iC0sSNuWkdHyUjZeezVg7lRNPVNjzL+ZvUDma5fQw9E23Gc=
X-Received: by 2002:a2e:9756:: with SMTP id f22mr1392963ljj.65.1607530456369;
 Wed, 09 Dec 2020 08:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20201209082051.12306-1-jinpu.wang@cloud.ionos.com>
 <20201209082051.12306-2-jinpu.wang@cloud.ionos.com> <0452fc87-3205-c3ad-9957-84e5e7adf32b@acm.org>
In-Reply-To: <0452fc87-3205-c3ad-9957-84e5e7adf32b@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 9 Dec 2020 17:14:05 +0100
Message-ID: <CAMGffEkqqz84p=3zeQb1FnVHDZBkXDBfrXSCnJV9p8_cXLQC9Q@mail.gmail.com>
Subject: Re: [PATCH for-next 1/7] block/rnbd-clt: Get rid of warning regarding
 size argument in strlcpy
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 9, 2020 at 5:08 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/9/20 12:20 AM, Jack Wang wrote:
> > From: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> >
> > The kernel test robot triggerred the following warning,
> >
> >>> drivers/block/rnbd/rnbd-clt.c:1397:42: warning: size argument in
> > 'strlcpy' call appears to be size of the source; expected the size of the
> > destination [-Wstrlcpy-strlcat-size]
> >       strlcpy(dev->pathname, pathname, strlen(pathname) + 1);
> >                                             ~~~~~~~^~~~~~~~~~~~~
> >
> > To get rid of the above warning, use a len variable for doing kzalloc and
> > then strlcpy.
> >
> > Fixes: 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > ---
> >   drivers/block/rnbd/rnbd-clt.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> > index a199b190c73d..62b77b5dc061 100644
> > --- a/drivers/block/rnbd/rnbd-clt.c
> > +++ b/drivers/block/rnbd/rnbd-clt.c
> > @@ -1365,7 +1365,7 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
> >                                     const char *pathname)
> >   {
> >       struct rnbd_clt_dev *dev;
> > -     int ret;
> > +     int len, ret;
> >
> >       dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, NUMA_NO_NODE);
> >       if (!dev)
> > @@ -1388,12 +1388,13 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
> >               goto out_queues;
> >       }
> >
> > -     dev->pathname = kzalloc(strlen(pathname) + 1, GFP_KERNEL);
> > +     len = strlen(pathname) + 1;
> > +     dev->pathname = kzalloc(len, GFP_KERNEL);
> >       if (!dev->pathname) {
> >               ret = -ENOMEM;
> >               goto out_queues;
> >       }
> > -     strlcpy(dev->pathname, pathname, strlen(pathname) + 1);
> > +     strlcpy(dev->pathname, pathname, len);
> >
> >       dev->clt_device_id      = ret;
> >       dev->sess               = sess;
>
> Please use kstrdup() instead of open-coding it.
Ok, will do it, thanks for the suggestion Bart!
>
> Thanks,
>
> Bart.
>
>
Jack
