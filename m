Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BA1C2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 16:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7991D611CE
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 16:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFVQed (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:34:33 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:40451 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhFVQea (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 12:34:30 -0400
Received: by mail-pj1-f50.google.com with SMTP id bb10-20020a17090b008ab029016eef083425so2038267pjb.5;
        Tue, 22 Jun 2021 09:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uTpQ8hRPDjCfcXc4SgrFqnYObrqEsoH4Mk3pn1K1zf4=;
        b=GCad/n8EG4vTPgHB9hCDQiPeYM0hXRT9ufDdq2vmgVpyTOBIldjkwHsfxw2qOegTv5
         /rAUDSO963JX80eTbYFOze3W33nCLxknXTR64M01b+fI1hbIdwFmUPInJGu/iwCNMNW1
         6cnikG/3KgQaS/0N7g8jPNhuIOEGS5kzWbEfz2aXKMgj6dp35SnJZwHUwV3I7zWfOf41
         1ZHvuMDYxNMk/Vi+fcKUQjhqXktwQkR3CugffH0LaXU4AF7AdILssaK5j+L5N8nc+QtN
         PlVyxOmd10PJk9YfIh14uaTzdbTBMTe2w6R7y+D2Ve3A/aYyr2PborVdtQQEpeaU4ldo
         u/Cw==
X-Gm-Message-State: AOAM532zUsU2pOwwmr7UTIERDvyrh+XBhNjEqlMYfp/6t9ApLI7M+X79
        rzs0AFEi2C8y+JnHRrFCGbw=
X-Google-Smtp-Source: ABdhPJzdSiE1Yq7VSQLR8CBcP+ckFw7gC04FzOretVA6hOh1DndWqexkxOd0Vs9B5Ij6+/D8wNLKeg==
X-Received: by 2002:a17:902:8504:b029:11c:c69c:b3d5 with SMTP id bj4-20020a1709028504b029011cc69cb3d5mr23403705plb.25.1624379532097;
        Tue, 22 Jun 2021 09:32:12 -0700 (PDT)
Received: from garbanzo ([173.239.198.97])
        by smtp.gmail.com with ESMTPSA id k5sm623467pjm.44.2021.06.22.09.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 09:32:11 -0700 (PDT)
Date:   Tue, 22 Jun 2021 09:32:08 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     minchan@kernel.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] zram: fix deadlock with sysfs attribute usage and
 driver removal
Message-ID: <20210622163208.epx4lf3pv2x2d5b4@garbanzo>
References: <20210621233013.562641-1-mcgrof@kernel.org>
 <20210621233634.595649-1-mcgrof@kernel.org>
 <YNGVI/vKSBAM8dlh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNGVI/vKSBAM8dlh@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 22, 2021 at 09:45:39AM +0200, Greg KH wrote:
> On Mon, Jun 21, 2021 at 04:36:34PM -0700, Luis Chamberlain wrote:
> > When sysfs attributes use a lock also used on driver removal we can
> > potentially deadlock. This happens when for instance a sysfs file on
> > a driver is used, then at the same time we have driver removal trigger.
> > The driver removal code holds a lock, and then the sysfs file entry waits
> > for the same lock. While holding the lock the driver removal tries to
> > remove the sysfs entries, but these cannot be removed yet as one is
> > waiting for a lock. This won't complete as the lock is already held.
> > Likewise module removal cannot complete, and so we deadlock.
> 
> This is all about removing modules, not about "driver removal" from a
> device.  Please make the subject line here more explicit.

Sure.

> > To fix this we just *try* to get a refcount to the module when a shared
> > lock is used, prior to mucking with a sysfs attribute. If this fails we
> > just give up right away.
> > 
> > We use a try method as a full lock means we'd then make our sysfs attributes
> > busy us out from possible module removal, and so userspace could force denying
> > module removal, a silly form of "DOS" against module removal. A try lock on
> > the module removal ensures we give priority to module removal and interacting
> > with sysfs attributes only comes second. Using a full lock could mean for
> > instance that if you don't stop poking at sysfs files you cannot remove a
> > module.
> > 
> > This deadlock was first reported with the zram driver, a sketch of how
> > this can happen follows:
> > 
> > CPU A                              CPU B
> >                                    whatever_store()
> > module_unload
> >   mutex_lock(foo)
> >                                    mutex_lock(foo)
> >    del_gendisk(zram->disk);
> >      device_del()
> >        device_remove_groups()
> 
> Can you duplicate this in a real-world situation?
> 
> What tools remove the zram module from the system on the fly?

A customer did run into it through a series of automated tests. I was
able to finally reproduce with the instructions given below. I
simplified it given that the series of test the customer was running
was much more complex.

> > In this situation whatever_store() is waiting for the mutex foo to
> > become unlocked, but that won't happen until module removal is complete.
> > But module removal won't complete until the syfs file being poked completes
> > which is waiting for a lock already held.
> > 
> > This is a generic kernel issue with sysfs files which use any lock also
> > used on module removal. Different generic solutions have been proposed.
> > One approach proposed is by directly by augmenting attributes with module
> > information [0]. This patch implements a solution by adding macros with
> > the prefix MODULE_DEVICE_ATTR_*() which accomplish the same. Until we
> > don't have a generic agreed upon solution for this shared between drivers,
> > we must implement a fix for this on each driver.
> > 
> > We make zram use the new MODULE_DEVICE_ATTR_*() helpers, and completely
> > open code the solution for class attributes as there are only a few of
> > those.
> > 
> > This issue can be reproduced easily on the zram driver as follows:
> > 
> > Loop 1 on one terminal:
> > 
> > while true;
> > 	do modprobe zram;
> > 	modprobe -r zram;
> > done
> > 
> > Loop 2 on a second terminal:
> > while true; do
> > 	echo 1024 >  /sys/block/zram0/disksize;
> > 	echo 1 > /sys/block/zram0/reset;
> > done
> 
> As fun as this is, it's not a real workload, please do not pretend that
> it is.

Whoever said that it was? This is just a way to reproduce an issue which
was reported.

> And your code is still racy, see below.  You just made the window even
> smaller, which you still should be objecting to as you somehow feel this
> is a valid usecase :)
> 
> > @@ -2048,13 +2048,19 @@ static ssize_t hot_add_show(struct class *class,
> >  {
> >  	int ret;
> >  
> > +	if (!try_module_get(THIS_MODULE))
> > +		return -ENODEV;
> > +
> 
> You can not increment/decrement your own module's reference count and
> expect it to work properly, as it is still a race.

The goal here is to prevent an rmmod call if this succeeds. If it
succeeds then any subsequent rmmod will fail. Can you explain how
this is still racy?

  Luis
