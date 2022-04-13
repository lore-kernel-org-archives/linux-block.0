Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808F7C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 05:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbiDMFY2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 01:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiDMFY1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 01:24:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB664F9D2
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 22:22:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id s18so1720412ejr.0
        for <linux-block@vger.kernel.org>; Tue, 12 Apr 2022 22:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cdeKgFpJvLEHvH552w4sygZi2El7+LZAqARF9ocqxh0=;
        b=fzSQIPniJYDY30ggsApkSEApxWiKMzzhpvMzBJS8rVogyZ8l60Y3vB8cBRQNiedonu
         +Wacz2pWLsJ5+U6hyR6/tWngywcmoyvySanIDj1DsHAAwiWJKGP/M4q8HAVJ1gmL6Rj1
         VWiAAKJfB4I/tJEB3nmvF7/GWitViZh+XBv2mPHVVcGe0E2f+gmkH0WNR0Y1VTYv+IDJ
         i3RIGrkWN4lWO8NZ4rLnk9pdXS67dRI5bEWxnj1aqvrnhaQpe1Ieh5RdtMK9xGFI+mwe
         ng/YyaEBL2/o1XadAYEeZMqgHWBb9DJxtQgbnrxjq1KgxpNbMDpMFQqes7MvHZKalF56
         VsIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cdeKgFpJvLEHvH552w4sygZi2El7+LZAqARF9ocqxh0=;
        b=JZg9/C3lN2WeSs/BtK/MtVvCQAv06apI/lxc4LuKXDy4zHMWHBbGjBRsRguGXZXU3+
         JwwwzuBRxR9NFT3si26tZ/StjY65jwjVvZTC9XfZyXHyhqwm4oyAqtI6tr+m6th+oyBL
         kjiZ1hDNpuU530akCWzZ7WDU/N6GmvXrAYF1nqVRy6nsFshE0a0LrtBs6lOvdAyNKUFH
         lRhkL3KAoxIjKopNVNTjKv/EPAY8ps+UANt+38qdftQloHrlKBRnbrj+Pw7iz6FAws3J
         Jl/y411jGYzlUewdgykXJ8JbWMWLnn4B0pNDcodi/hOVRysckohsz1H7/NTzssa0KG/H
         lWHg==
X-Gm-Message-State: AOAM531v95ovFCjbBU8sl2qcWX5RNXzzpI/GcoecW58pJGJCaNlha+SB
        kOAGhhgicrIlWg28/hEfc3upNZRkKpGpAkd3Myspsg==
X-Google-Smtp-Source: ABdhPJyND6FFswxqjiYBspCBqGztxwB0CpNUo2ZkpeAMIz1dajivfwDzobMyhVC8cy3Rv+CQe34QgULBKeOvwZts0EA=
X-Received: by 2002:a17:906:d552:b0:6e8:4ee4:748 with SMTP id
 cr18-20020a170906d55200b006e84ee40748mr22356949ejc.58.1649827323519; Tue, 12
 Apr 2022 22:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <becb2389-e249-0aa2-7701-2c02155aedf2@I-love.SAKURA.ne.jp> <55006f3b-9571-9167-eaf0-6a2caec747ad@I-love.SAKURA.ne.jp>
In-Reply-To: <55006f3b-9571-9167-eaf0-6a2caec747ad@I-love.SAKURA.ne.jp>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Wed, 13 Apr 2022 07:21:52 +0200
Message-ID: <CAMGffEnXi8AiC2rqZaHER1rrcsCPR0UNocKyxr9H6hXRwjj4MQ@mail.gmail.com>
Subject: Re: [PATCH] block/rnbd: client: avoid flush_workqueue(system_long_wq) usage
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tetsuo,

On Wed, Apr 13, 2022 at 12:18 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2022/04/12 22:46, Tetsuo Handa wrote:
> > Flushing system-wide workqueues is dangerous and will be forbidden.
> >
> > Since system_long_wq is used only inside rnbd_destroy_sessions(),
> > let's use list_head than creating a local workqueue for tracking
> > work_struct to flush.
> >
> > Link: https://lkml.kernel.org/r/49925af7-78a8-a3dd-bce6-cfc02e1a9236@I-love.SAKURA.ne.jp
> >
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > ---
> > Notice: This patch is only compile tested. Please test before applying.
> >
> >  drivers/block/rnbd/rnbd-clt.c | 5 ++++-
> >  drivers/block/rnbd/rnbd-clt.h | 1 +
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> > index b66e8840b94b..b14e7c15133e 100644
> > --- a/drivers/block/rnbd/rnbd-clt.c
> > +++ b/drivers/block/rnbd/rnbd-clt.c
> > @@ -1730,6 +1730,7 @@ static void rnbd_destroy_sessions(void)
> >  {
> >       struct rnbd_clt_session *sess, *sn;
> >       struct rnbd_clt_dev *dev, *tn;
> > +     LIST_HEAD(list);
> >
> >       /* Firstly forbid access through sysfs interface */
> >       rnbd_clt_destroy_sysfs_files();
> > @@ -1762,11 +1763,13 @@ static void rnbd_destroy_sessions(void)
> >                        */
> >                       INIT_WORK(&dev->unmap_on_rmmod_work, unmap_device_work);
> >                       queue_work(system_long_wq, &dev->unmap_on_rmmod_work);
> > +                     list_add_tail(&dev->unmap_on_rmmod_list, &list);
> >               }
> >               rnbd_clt_put_sess(sess);
> >       }
> >       /* Wait for all scheduled unmap works */
> > -     flush_workqueue(system_long_wq);
> > +     list_for_each_entry(dev, &list, unmap_on_rmmod_list)
> > +             flush_work(&dev->unmap_on_rmmod_work);
>
> Since kfree(dev) might be called from unmap_device_work(), this seems unsafe.
> We need rnbd_clt_get_dev() before queue_work() and rnbd_clt_put_dev() after flush_work()
> in order to make dev->unmap_on_rmmod_list traversal safe...
you are right, unmap_device_work could free the dev structure, lead to UAF.
simply add rnbd_clt_get_dev and put_dev will lead to following WARN_ON
to be triggered.
>
> >       WARN_ON(!list_empty(&sess_list));
> >  }
I feel the simple approach is to replace the gloable system_long_wq
with a local workqueue for rnbd_client.

Thanks!
> >
> > diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
> > index 2e2e8c4a85c1..a6d704abda61 100644
> > --- a/drivers/block/rnbd/rnbd-clt.h
> > +++ b/drivers/block/rnbd/rnbd-clt.h
> > @@ -136,6 +136,7 @@ struct rnbd_clt_dev {
> >       char                    *blk_symlink_name;
> >       refcount_t              refcount;
> >       struct work_struct      unmap_on_rmmod_work;
> > +     struct list_head        unmap_on_rmmod_list;
> >  };
> >
> >  /* rnbd-clt.c */
>
