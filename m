Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB506C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 03:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE0320838
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 03:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cb2c4Qu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfLKDvO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 22:51:14 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36336 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfLKDvN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 22:51:13 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so8366654pjc.3;
        Tue, 10 Dec 2019 19:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=w9o4gMDR79zJbq+/ILGvB1xN+aaga7BtIGFfI8prB5M=;
        b=cb2c4Qu1c1VKdo14t+tdEIreffodBdWgrfZOnau+8AaTsPYBHxEDq2ozEzFFz/pEXz
         1Pz5xgaVxS7aheHrbjvMvC0DfUNyVafnjbnzBHpv7NUksimAVRA4gVCZVj8Ydn64MoVb
         CSt+5FDPXEO6+HIN1gVgL2lUTUC0OSJJD+IC0nahZy4jbR2rtY9d53t++mdn3OYc1Jj9
         PAQUqBaUzQA1lWISbOFvz5im/enk1rQV5SA86x8ZF0GMnO3BK7HOp+osbtQhfGOBFXHm
         gKXy/czYdBvRWV7jv/jpcYv/8/AfbBfxTfHGyhIYxJrKgDDf18qfGpkIS34S2xVClL79
         X7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=w9o4gMDR79zJbq+/ILGvB1xN+aaga7BtIGFfI8prB5M=;
        b=Fa9/NQ616nFX+TBgw/Sf8v1bTWPQ4DWe/H4DVPrnlCWW7n7gCOTvsdCv6U/5ChU3/W
         nAQl3KE/faPj9UP92wstvUdsxheKDQqsbs2BmlTBNoqrrmk4JOu8hFnX2iILWrrgbdXq
         K0wBT+e5NuV8N+fDf1k+1glmKKWZeN6wYXo5mtLfkObHHmrxd6mj3lYWwnbuPWUu1B0u
         8zlUlqc/DA/8lWgFt3GDdqmcqXLHGhn0Tj59NkXhpxijBIKI4xtl5G4jvwQH/zQ6uk4l
         Ga9QOz0jegBt9DQMVuhrI83L97cPiQUL0ID4emRTCoANrKW7NmzNPLkTE5DWoRJS0cJf
         KvKw==
X-Gm-Message-State: APjAAAWawWc4hUaUwA/nhTy27IfGx05Go60ACqxK+oj9AktRTFydz83m
        opy+Ddga/zYJ53//3NPVABI=
X-Google-Smtp-Source: APXvYqwV5LToqYXF+yA4cMixtRX1yiBntc+ibWAwq4CQnG/WEECa7yTzQkoSqPhBeU9QcWl0npySrg==
X-Received: by 2002:a17:902:6909:: with SMTP id j9mr1012338plk.136.1576036272826;
        Tue, 10 Dec 2019 19:51:12 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id u3sm501061pga.72.2019.12.10.19.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 19:51:11 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     roger.pau@citrix.com
Cc:     sjpark@amazon.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pdurrant@amazon.com, xen-devel@lists.xenproject.org,
        SeongJae Park <sjpark@amazon.de>, sj38.park@gmail.com
Subject: Re: Re: [PATCH v5 1/2] xenbus/backend: Add memory pressure handler callback
Date:   Wed, 11 Dec 2019 04:50:58 +0100
Message-Id: <20191211035058.11479-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
In-Reply-To: <20191210101635.GD980@Air-de-Roger>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 10 Dec 2019 11:16:35 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:

> > Granting pages consumes backend system memory.  In systems configured
> > with insufficient spare memory for those pages, it can cause a memory
> > pressure situation.  However, finding the optimal amount of the spare
> > memory is challenging for large systems having dynamic resource
> > utilization patterns.  Also, such a static configuration might lack a
> 
> s/lack a/lack/
> 
> > flexibility.
> > 
> > To mitigate such problems, this commit adds a memory reclaim callback to
> > 'xenbus_driver'.  Using this facility, 'xenbus' would be able to monitor
> > a memory pressure and request specific devices of specific backend
> 
> s/monitor a/monitor/
> 
> > drivers which causing the given pressure to voluntarily release its
> 
> ...which are causing...
> 
> > memory.
> > 
> > That said, this commit simply requests every callback registered driver
> > to release its memory for every domain, rather than issueing the
> 
> s/issueing/issuing/
> 
> > requests to the drivers and the domain in charge.  Such things will be
> 
> I'm afraid I don't understand the "domain in charge" part of this
> sentence.
> 
> > done in a futur.  Also, this commit focuses on memory only.  However, it
> 
> ... done in a future change. Also I think the period after only should
> be removed in order to tie both sentences together.
> 
> > would be ablt to be extended for general resources.
> 
> s/ablt/able/
> 
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  drivers/xen/xenbus/xenbus_probe_backend.c | 31 +++++++++++++++++++++++
> >  include/xen/xenbus.h                      |  1 +
> >  2 files changed, 32 insertions(+)
> > 
> > diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
> > index b0bed4faf44c..5a5ba29e39df 100644
> > --- a/drivers/xen/xenbus/xenbus_probe_backend.c
> > +++ b/drivers/xen/xenbus/xenbus_probe_backend.c
> > @@ -248,6 +248,34 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
> >  	return NOTIFY_DONE;
> >  }
> >  
> > +static int xenbus_backend_reclaim(struct device *dev, void *data)
> > +{
> > +	struct xenbus_driver *drv;
> 
> Newline and const.
> 
> > +	if (!dev->driver)
> > +		return -ENOENT;
> > +	drv = to_xenbus_driver(dev->driver);
> > +	if (drv && drv->reclaim)
> > +		drv->reclaim(to_xenbus_device(dev));
> 
> You seem to completely ignore the return of the reclaim hook...
> 
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Returns 0 always because we are using shrinker to only detect memory
> > + * pressure.
> > + */
> > +static unsigned long xenbus_backend_shrink_count(struct shrinker *shrinker,
> > +				struct shrink_control *sc)
> > +{
> > +	bus_for_each_dev(&xenbus_backend.bus, NULL, NULL,
> > +			xenbus_backend_reclaim);
> > +	return 0;
> > +}
> > +
> > +static struct shrinker xenbus_backend_shrinker = {
> > +	.count_objects = xenbus_backend_shrink_count,
> > +	.seeks = DEFAULT_SEEKS,
> > +};
> > +
> >  static int __init xenbus_probe_backend_init(void)
> >  {
> >  	static struct notifier_block xenstore_notifier = {
> > @@ -264,6 +292,9 @@ static int __init xenbus_probe_backend_init(void)
> >  
> >  	register_xenstore_notifier(&xenstore_notifier);
> >  
> > +	if (register_shrinker(&xenbus_backend_shrinker))
> > +		pr_warn("shrinker registration failed\n");
> > +
> >  	return 0;
> >  }
> >  subsys_initcall(xenbus_probe_backend_init);
> > diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> > index 869c816d5f8c..cdb075e4182f 100644
> > --- a/include/xen/xenbus.h
> > +++ b/include/xen/xenbus.h
> > @@ -104,6 +104,7 @@ struct xenbus_driver {
> >  	struct device_driver driver;
> >  	int (*read_otherend_details)(struct xenbus_device *dev);
> >  	int (*is_ready)(struct xenbus_device *dev);
> > +	unsigned (*reclaim)(struct xenbus_device *dev);
> 
> ... hence I wonder why it's returning an unsigned when it's just
> ignored.
> 
> IMO it should return an int to signal errors, and the return should be
> ignored.

I first thought similarly and set the callback to return something.  However,
as this callback is called to simply notify the memory pressure and ask the
driver to free its memory as many as possible, I couldn't easily imagine what
kind of errors that need to be handled by its caller can occur in the callback,
especially because current blkback's callback implementation has no such error.
So, if you and others agree, I would like to simply set the return type to
'void' for now and defer the error handling to a future change.

> 
> Also, I think it would preferable for this function to take an extra
> parameter to describe the resource the driver should attempt to free
> (ie: memory or interrupts for example). I'm however not able to find
> any existing Linux type to describe such resources.

Yes, such extention would be the right direction.  However, because there is no
existing Linux type to describe the type of resources to reclaim as you also
mentioned, there could be many different opinions about its implementation
detail.  In my opinion, it could be also possible to simply add another
callback for another resource type.  That said, because currently we have an
use case and an implementation for the memory pressure only, I would like to
let it as is for now and defer the extension as a future work, if you and
others have no objection.


Thanks,
SeongJae Park

> 
> Thanks, Roger.
> 
> 
