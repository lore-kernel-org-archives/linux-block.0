Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9EFC43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F0920716
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DF1XF4tp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfLQQYo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:24:44 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:52712 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbfLQQYo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 11:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576599884; x=1608135884;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=6CjLT/jXM24rz/CtEsr3sfgvACZw7Z+OWO4pwc33DNA=;
  b=DF1XF4tpPFRfpi5PB+Nzc6esRN/lmuTrT630ln4dVUqiPWUNCGp020kL
   kq2DgD5HEM/4+VvPsCP2Hwki23CPZ+9V77gpzRgqqpNuB9FbAT8jih/d8
   9eflJ5kLxTPYHawNDofoH/SL8GBtyNjUSx1ZScF2wqnyBgjXxV4iTcmsa
   s=;
IronPort-SDR: l/5bBVqxQm+PGBhtTf/q0S//8Ztt3FG2SPwySz7BkUjYe4bKLQS0PyvVYKwTQiZO1BdfSZNFme
 t5zCG84erTug==
X-IronPort-AV: E=Sophos;i="5.69,326,1571702400"; 
   d="scan'208";a="9474974"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 17 Dec 2019 16:24:43 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS id 3F287A221F;
        Tue, 17 Dec 2019 16:24:40 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 17 Dec 2019 16:24:39 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.205) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 17 Dec 2019 16:24:34 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>
CC:     SeongJae Park <sjpark@amazon.com>, <axboe@kernel.dk>,
        <konrad.wilk@oracle.com>, <roger.pau@citrix.com>,
        <linux-block@vger.kernel.org>, <pdurrant@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        <linux-kernel@vger.kernel.org>, <sj38.park@gmail.com>,
        <xen-devel@lists.xenproject.org>
Subject: Re: Re: [Xen-devel] [PATCH v11 2/6] xenbus/backend: Protect xenbus callback with lock
Date:   Tue, 17 Dec 2019 17:24:06 +0100
Message-ID: <20191217162406.4711-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <44327bf3-45ed-3e5a-3984-36ea40f53fc5@suse.com> (raw)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.161.205]
X-ClientProxiedBy: EX13D02UWB004.ant.amazon.com (10.43.161.11) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 17 Dec 2019 17:13:42 +0100 "Jürgen Groß" <jgross@suse.com> wrote:

> On 17.12.19 17:07, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > 'reclaim_memory' callback can race with a driver code as this callback
> > will be called from any memory pressure detected context.  To deal with
> > the case, this commit adds a spinlock in the 'xenbus_device'.  Whenever
> > 'reclaim_memory' callback is called, the lock of the device which passed
> > to the callback as its argument is locked.  Thus, drivers registering
> > their 'reclaim_memory' callback should protect the data that might race
> > with the callback with the lock by themselves.
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >   drivers/xen/xenbus/xenbus_probe.c         |  1 +
> >   drivers/xen/xenbus/xenbus_probe_backend.c | 10 ++++++++--
> >   include/xen/xenbus.h                      |  2 ++
> >   3 files changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
> > index 5b471889d723..b86393f172e6 100644
> > --- a/drivers/xen/xenbus/xenbus_probe.c
> > +++ b/drivers/xen/xenbus/xenbus_probe.c
> > @@ -472,6 +472,7 @@ int xenbus_probe_node(struct xen_bus_type *bus,
> >   		goto fail;
> >   
> >   	dev_set_name(&xendev->dev, "%s", devname);
> > +	spin_lock_init(&xendev->reclaim_lock);
> >   
> >   	/* Register with generic device framework. */
> >   	err = device_register(&xendev->dev);
> > diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
> > index 7e78ebef7c54..516aa64b9967 100644
> > --- a/drivers/xen/xenbus/xenbus_probe_backend.c
> > +++ b/drivers/xen/xenbus/xenbus_probe_backend.c
> > @@ -251,12 +251,18 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
> >   static int backend_reclaim_memory(struct device *dev, void *data)
> >   {
> >   	const struct xenbus_driver *drv;
> > +	struct xenbus_device *xdev;
> > +	unsigned long flags;
> >   
> >   	if (!dev->driver)
> >   		return 0;
> >   	drv = to_xenbus_driver(dev->driver);
> > -	if (drv && drv->reclaim_memory)
> > -		drv->reclaim_memory(to_xenbus_device(dev));
> > +	if (drv && drv->reclaim_memory) {
> > +		xdev = to_xenbus_device(dev);
> > +		spin_trylock_irqsave(&xdev->reclaim_lock, flags);
> 
> You need spin_lock_irqsave() here. Or maybe spin_lock() would be fine,
> too? I can't see a reason why you'd want to disable irqs here.

I needed to diable irq here as this is called from the memory shrinker context.

Also, used 'trylock' because the 'probe()' and 'remove()' code of the driver
might include memory allocation.  And the xen-blkback actually does.  If the
allocation shows a memory pressure during the allocation, it will trigger this
shrinker callback again and then deadlock.


Thanks,
SeongJae Park

> 
> > +		drv->reclaim_memory(xdev);
> > +		spin_unlock_irqrestore(&xdev->reclaim_lock, flags);
> > +	}
> >   	return 0;
> >   }
> >   
> > diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> > index c861cfb6f720..d9468313061d 100644
> > --- a/include/xen/xenbus.h
> > +++ b/include/xen/xenbus.h
> > @@ -76,6 +76,8 @@ struct xenbus_device {
> >   	enum xenbus_state state;
> >   	struct completion down;
> >   	struct work_struct work;
> > +	/* 'reclaim_memory' callback is called while this lock is acquired */
> > +	spinlock_t reclaim_lock;
> >   };
> >   
> >   static inline struct xenbus_device *to_xenbus_device(struct device *dev)
> > 
> 
> 
> Juergen
> 
