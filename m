Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FF4C48BDF
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783CB6128E
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhFVQqX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:46:23 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:35765 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhFVQqW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 12:46:22 -0400
Received: by mail-pf1-f176.google.com with SMTP id t32so35601pfg.2;
        Tue, 22 Jun 2021 09:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x799InAcoDjDt4DQpoZBoNM42r4xX5n0kOF7AEe4YKo=;
        b=t5vcqXMs6Fj8CClxbgQVcBIMI7OC3nl+e31v6VC/yE0Jq9PNLYuFkopRMKyCbOAJk5
         9Pyj+fqYcxqfbZtMicNecxQgYr0C5n3QjKKntzLPPgm4Ov4MamO57K3HGCmVH4WClpV7
         lD88vnzmJ+QjVtPUrUX4O4uZIAd5GIbgKQrQY7cwN2FK1uF1U8EAjcLAmbfjydoRbi/t
         PqnrmcxvSCTqTzQmS/RuLJJWZv/fO+MIezs3A2fYkzjma7HGCrb5qba2XEnj0JN6L26z
         vCTe1lWlz+Mibg1uUYBe0SXowSsv2krcBabfRYodV+2Mgykd0cTjX9o4zDtLxxUETmgw
         EL8A==
X-Gm-Message-State: AOAM5319jhP52QDGhYtYGEkG0klyeSmL1nVTCoBw/8d1v676ohdconO+
        htPCMH+fV7UJ2byoONG+Stk=
X-Google-Smtp-Source: ABdhPJx9G3hGxhRz77cNIDM5qxm3q3evv6WM4wgToHfnSXhofD0b6jAgePysM/sIh8RPdFGtSfDqEw==
X-Received: by 2002:a62:820a:0:b029:2fd:5aa9:549b with SMTP id w10-20020a62820a0000b02902fd5aa9549bmr4463646pfd.77.1624380245551;
        Tue, 22 Jun 2021 09:44:05 -0700 (PDT)
Received: from garbanzo ([173.239.198.97])
        by smtp.gmail.com with ESMTPSA id o9sm2778772pjp.19.2021.06.22.09.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 09:44:04 -0700 (PDT)
Date:   Tue, 22 Jun 2021 09:44:02 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     minchan@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] drivers/base/core: refcount kobject and bus on
 device attribute read / store
Message-ID: <20210622164402.d62je6pajcplkfuy@garbanzo>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233651.597220-1-mcgrof@kernel.org>
 <YNGVUk18pmTFZqAB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNGVUk18pmTFZqAB@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 09:46:26AM +0200, Greg KH wrote:
> On Mon, Jun 21, 2021 at 04:36:51PM -0700, Luis Chamberlain wrote:
> > It's possible today to have a device attribute read or store
> > race against device removal. When this happens there is a small
> > chance that the derefence for the private data area of the driver
> > is NULL.
> > 
> > Let's consider the zram driver as an example. Its possible to run into
> > a race where a sysfs knob is being used, we get preempted, and a zram
> > device is removed before we complete use of the sysfs knob. This can happen
> > for instance on block devices, where for instance the zram block devices
> > just part of the private data of the block device.
> > 
> > For instance this can happen in the following two situations
> > as examples to illustrate this better:
> > 
> >         CPU 1                            CPU 2
> > destroy_devices
> > ...
> >                                  compact_store()
> >                                  zram = dev_to_zram(dev);
> > idr_for_each(zram_remove_cb
> >   zram_remove
> >   ...
> >   kfree(zram)
> >                                  down_read(&zram->init_lock);
> > 
> >         CPU 1                            CPU 2
> > hot_remove_store
> >                                  compact_store()
> >                                  zram = dev_to_zram(dev);
> >   zram_remove
> >     kfree(zram)
> >                                  down_read(&zram->init_lock);
> > 
> > To ensure the private data pointer is valid we could use bdget() / bdput()
> > in between access, however that would mean doing that in all sysfs
> > reads/stores on the driver. Instead a generic solution for all drivers
> > is to ensure the device kobject is still valid and also the bus, if
> > a bus is present.
> > 
> > This issue does not fix a known crash, however this race was
> > spotted by Minchan Kim through code inspection upon code review
> > of another zram patch.
> > 
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  drivers/base/base.h |  2 ++
> >  drivers/base/bus.c  |  4 ++--
> >  drivers/base/core.c | 42 ++++++++++++++++++++++++++++++++++++++----
> >  3 files changed, 42 insertions(+), 6 deletions(-)
> 
> Please make this an independent patch of the zram mess  and I will be
> glad to consider it for the driver core tree then.

What do you mean by making it independent?

The patch does not depend on the zram changes, and so, this can
be merged separately as-is.

If you mean that I should not mention zram on the commit log, please
let me know. I however think a concrete example is useful.

Or do you just mean that I should resend this out as a new patch
without it being attached to the zram thread?

 Luis
