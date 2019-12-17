Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE11BC43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 17:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30902465E
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 17:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXjCCWzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfLQR2J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:28:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33811 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfLQR2J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 12:28:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so12240286wrr.1;
        Tue, 17 Dec 2019 09:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=vXn2Yu4RkHlP1Gh90RCX44u/DnD2AY3PkGZLCTXZShY=;
        b=cXjCCWzNHoaJgyu5OIAhA2JSISeRLzdsicjh5w4b9kGXxlnUazSpdYDlnZrlOSqKE4
         Ku04u/hnECWcv8Y62FEoFKtozKEyoaUrlIob2NUiMoaDQuy+mQYBNbbQLLaGBX/6O9KM
         pbFLYKyC38pfyCzXVwRPSwRsGTpVPoGxUJhbKQTbFnZMurl84obSvskY5a47FNc769Ap
         uz2SdvgyiFK88ICAM8PCOcgHRVOBNvnyiRZuqtfMJcjCgOEv/69SRvYPtLPsZwWZ4J0v
         BoWDMp/T+459syiNlholtJWR/jErBI1rTo4wYsVMRwAdYWCKbuYQ9xIyZnw46lSWOI3I
         jNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=vXn2Yu4RkHlP1Gh90RCX44u/DnD2AY3PkGZLCTXZShY=;
        b=LnxMsWBjXWTktTX7EzIQTDAmdvQICUwIzId+ewKOswhWq5lsHZWDrvaagCtMBNd0Wq
         etDxrJQFCQPzMgvWyw3WJI6BsyBX0HGZNaGzCbdb6wdYGzbXb4I0Xq6p6gSynRjFWBsD
         wGbKkrfqalORVPg1SzFS7TP3uVDh5N90dj4H74dPohQe65c27JVjeqXzQaaOHc53suwv
         8VCbFdjbmHIiEpgKogJyGsn9bwuG4NthEsd8YkTiezNkDE5w7xousqnSzwKxXlNemsph
         cJfuuIkJ2+hJq9GuTQOE7XT2av+DiDT/gnrSB9DPDUJxFBg4V5Z33l2rkaQVD34P35wk
         qcQg==
X-Gm-Message-State: APjAAAUnVjaqS8zkopL3GgMxX85Ar5la1h0tfIbV65oGLtWyfyY/w1Lp
        Udcb5/HkUVVGzglu0lSHSGw=
X-Google-Smtp-Source: APXvYqxWnHbAUaxerL55jC58SIZbNR5PNO5hY231h8MMtPhz29c3VbD89coH273KvyzCzv+FPtZxKQ==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr38050795wrq.176.1576603685895;
        Tue, 17 Dec 2019 09:28:05 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:5015:4c4c:42e9:e517])
        by smtp.gmail.com with ESMTPSA id 188sm3875074wmd.1.2019.12.17.09.28.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Dec 2019 09:28:05 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>
Cc:     SeongJae Park <sjpark@amazon.com>, axboe@kernel.dk,
        sj38.park@gmail.com, konrad.wilk@oracle.com, pdurrant@amazon.com,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        roger.pau@citrix.com
Subject: Re: Re: [Xen-devel] [PATCH v11 2/6] xenbus/backend: Protect xenbus callback with lock
Date:   Tue, 17 Dec 2019 18:27:38 +0100
Message-Id: <20191217172738.20787-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
In-Reply-To: <f9a601af-4413-ed1d-f7f4-89343118a2f1@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 17 Dec 2019 18:10:19 +0100 "Jürgen Groß" <jgross@suse.com> wrote:

> On 17.12.19 17:24, SeongJae Park wrote:
> > On Tue, 17 Dec 2019 17:13:42 +0100 "Jürgen Groß" <jgross@suse.com> wrote:
> > 
> >> On 17.12.19 17:07, SeongJae Park wrote:
> >>> From: SeongJae Park <sjpark@amazon.de>
> >>>
> >>> 'reclaim_memory' callback can race with a driver code as this callback
> >>> will be called from any memory pressure detected context.  To deal with
> >>> the case, this commit adds a spinlock in the 'xenbus_device'.  Whenever
> >>> 'reclaim_memory' callback is called, the lock of the device which passed
> >>> to the callback as its argument is locked.  Thus, drivers registering
> >>> their 'reclaim_memory' callback should protect the data that might race
> >>> with the callback with the lock by themselves.
> >>>
> >>> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> >>> ---
> >>>    drivers/xen/xenbus/xenbus_probe.c         |  1 +
> >>>    drivers/xen/xenbus/xenbus_probe_backend.c | 10 ++++++++--
> >>>    include/xen/xenbus.h                      |  2 ++
> >>>    3 files changed, 11 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
> >>> index 5b471889d723..b86393f172e6 100644
> >>> --- a/drivers/xen/xenbus/xenbus_probe.c
> >>> +++ b/drivers/xen/xenbus/xenbus_probe.c
> >>> @@ -472,6 +472,7 @@ int xenbus_probe_node(struct xen_bus_type *bus,
> >>>    		goto fail;
> >>>    
> >>>    	dev_set_name(&xendev->dev, "%s", devname);
> >>> +	spin_lock_init(&xendev->reclaim_lock);
> >>>    
> >>>    	/* Register with generic device framework. */
> >>>    	err = device_register(&xendev->dev);
> >>> diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
> >>> index 7e78ebef7c54..516aa64b9967 100644
> >>> --- a/drivers/xen/xenbus/xenbus_probe_backend.c
> >>> +++ b/drivers/xen/xenbus/xenbus_probe_backend.c
> >>> @@ -251,12 +251,18 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
> >>>    static int backend_reclaim_memory(struct device *dev, void *data)
> >>>    {
> >>>    	const struct xenbus_driver *drv;
> >>> +	struct xenbus_device *xdev;
> >>> +	unsigned long flags;
> >>>    
> >>>    	if (!dev->driver)
> >>>    		return 0;
> >>>    	drv = to_xenbus_driver(dev->driver);
> >>> -	if (drv && drv->reclaim_memory)
> >>> -		drv->reclaim_memory(to_xenbus_device(dev));
> >>> +	if (drv && drv->reclaim_memory) {
> >>> +		xdev = to_xenbus_device(dev);
> >>> +		spin_trylock_irqsave(&xdev->reclaim_lock, flags);
> >>
> >> You need spin_lock_irqsave() here. Or maybe spin_lock() would be fine,
> >> too? I can't see a reason why you'd want to disable irqs here.
> > 
> > I needed to diable irq here as this is called from the memory shrinker context.
> 
> Okay.
> 
> > 
> > Also, used 'trylock' because the 'probe()' and 'remove()' code of the driver
> > might include memory allocation.  And the xen-blkback actually does.  If the
> > allocation shows a memory pressure during the allocation, it will trigger this
> > shrinker callback again and then deadlock.
> 
> In that case you need to either return when you didn't get the lock or

Yes, it should.  Cannot believe how I posted this code.  Seems I made some
terrible mistake while formatting patches.  Anyway, will return if fail to
acquire the lock, in the next version.


Thanks,
SeongJae Park

> 
> - when obtaining the lock during probe() and remove() set a variable
>    containing the current cpu number
> - and reset that to e.g NR_CPUS before releasing the lock again
> - in the shrinker callback do trylock, and if you didn't get the lock
>    test whether the cpu-variable above is set to your current cpu and
>    continue only if yes; if not, redo the the trylock
> 
> 
> Juergen
