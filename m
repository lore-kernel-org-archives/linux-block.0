Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4887C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 12:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F316214D8
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 12:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRVnrjYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfLKMUa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:20:30 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45940 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfLKMUa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 07:20:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so10299089pgk.12;
        Wed, 11 Dec 2019 04:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=2Gmp6YOucsMACQ792uGEILrIHWMUBHy7q5oV2O7SluA=;
        b=JRVnrjYwlGgiNuY9z9sJPe5x3p7yIqHAAaxAHgZaKPbn6qAKUunT/+/UW43RuECKc4
         Fz7/1CyWe9Nnr0bufgys/lYP7FNEusO6pGxKENaIBEv3JxfJf9QGVjJxMa8GPzhKJYqe
         TTw7JG70ixN3LTZZcFwGCKaI3ls/RjpBaaKVBGwMxS4DpsJytgO8TloZ7wKrXYzxYh0I
         4nfK3IQRAwVvBWD4ovfnnJF0mT6q3y210aZR55HmMyomS93fmwLwmFejWptLEv92NmZL
         ilMHFogMmh+/Yd7zxmWlExDA96Mqnjg+pNQnO2k57eAtw9w/9lx47W757FE6Jv1kFmTp
         MOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=2Gmp6YOucsMACQ792uGEILrIHWMUBHy7q5oV2O7SluA=;
        b=je1Us8qxBhMqxkE7vqRPMwaBmcDhwLQYvAMZBt6sgDGgxwhk8PyZE3tHj5shsQIUXc
         iiHScEyZm7uUzyNDIH4hXSy117Escxn05Y0UZ4+dGxrxo3bEpKIAXyIynNJKDLPAgTND
         Wzqu1fzxQMbY2qCSsC1thlezxc2ZdAPh5LyIVkI97rVGw6DoKmr0ld5TxOiPFiMCpGAT
         CN0cJQfqwv+qYmWMH6hApYa9JnJWKPJo3/lS1BLWupWH2xFjszUWqS4BSNTK9AJDtSqc
         lX/wTuhWeN95ycj3it6snj6XfRXULGwFBFyuYUXYI8sOomTttFsEHf7xjmen4AGzWmAp
         BmxA==
X-Gm-Message-State: APjAAAVAn4ejryfqlaCTCvOHqwnMT0FiCm4ZqYFd8BspNJv7lktjBWJ/
        iyIib+31cpWd7MwUjayS7eg=
X-Google-Smtp-Source: APXvYqzAqmTEma+xlFtP5yw9S0mHaSrSRi2QfNYSRFP3vN+eRcvJJchAFpIQQ6RRZqkQyrRDh8Z+Dg==
X-Received: by 2002:a62:ac03:: with SMTP id v3mr3371967pfe.17.1576066829511;
        Wed, 11 Dec 2019 04:20:29 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id e20sm2848907pff.96.2019.12.11.04.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Dec 2019 04:20:28 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     jgross@suse.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        "SeongJae Park" <sjpark@amazon.de>, pdurrant@amazon.com,
        sjpark@amazon.com, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v6 1/3] xenbus/backend: Add memory pressure handler callback
Date:   Wed, 11 Dec 2019 13:20:11 +0100
Message-Id: <20191211122011.16231-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
In-Reply-To: <20191211114651.GN980@Air-de-Roger> (raw)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 11 Dec 2019 12:46:51 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:

> > Granting pages consumes backend system memory.  In systems configured
> > with insufficient spare memory for those pages, it can cause a memory
> > pressure situation.  However, finding the optimal amount of the spare
>                                                               ^ s/the//
> > memory is challenging for large systems having dynamic resource
> > utilization patterns.  Also, such a static configuration might lack
> > flexibility.
> > 
> > To mitigate such problems, this commit adds a memory reclaim callback to
> > 'xenbus_driver'.  If a memory pressure is detected, 'xenbus' requests
>                        ^ s/a//
> > every backend driver to volunarily release its memory.
> > 
> > Note that it would be able to improve the callback facility for more
>                         ^ possible
> > sophisticated handlings of general pressures.  For example, it would be
>                 ^ handling of resource starvation.
> > possible to monitor the memory consumption of each device and issue the
> > release requests to only devices which causing the pressure.  Also, the
> > callback could be extended to handle not only memory, but general
> > resources.  Nevertheless, this version of the implementation defers such
> > sophisticated goals as a future work.
> > 
> > Reviewed-by: Juergen Gross <jgross@suse.com>
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  drivers/xen/xenbus/xenbus_probe_backend.c | 32 +++++++++++++++++++++++
> >  include/xen/xenbus.h                      |  1 +
> >  2 files changed, 33 insertions(+)
> > 
> > diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
> > index b0bed4faf44c..aedbe2198de5 100644
> > --- a/drivers/xen/xenbus/xenbus_probe_backend.c
> > +++ b/drivers/xen/xenbus/xenbus_probe_backend.c
> > @@ -248,6 +248,35 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
> >  	return NOTIFY_DONE;
> >  }
> >  
> > +static int xenbus_backend_reclaim(struct device *dev, void *data)
> 
> No need for the xenbus_ prefix since it's a static function, ie:
> backend_reclaim_memory should be fine IMO.

Agreed, will change the name in the next version.

> 
> > +{
> > +	struct xenbus_driver *drv;
> 
> I've asked for this variable to be constified in v5, is it not
> possible to make it const?

Sorry, my mistake...  I was difinitely too hurry.

> 
> > +
> > +	if (!dev->driver)
> > +		return 0;
> > +	drv = to_xenbus_driver(dev->driver);
> > +	if (drv && drv->reclaim)
> > +		drv->reclaim(to_xenbus_device(dev));
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
> 
> I would drop the xenbus prefix, and I think it's not possible to
> constify this due to register_shrinker expecting a non-const
> parameter?

Yes, constifying it results in another compile warning.  Will drop the prefix.

> 
> > +	.count_objects = xenbus_backend_shrink_count,
> > +	.seeks = DEFAULT_SEEKS,
> > +};
> > +
> >  static int __init xenbus_probe_backend_init(void)
> >  {
> >  	static struct notifier_block xenstore_notifier = {
> > @@ -264,6 +293,9 @@ static int __init xenbus_probe_backend_init(void)
> >  
> >  	register_xenstore_notifier(&xenstore_notifier);
> >  
> > +	if (register_shrinker(&xenbus_backend_shrinker))
> > +		pr_warn("shrinker registration failed\n");
> 
> Can you add a xenbus prefix to the error message? Or else it's hard to
> know which subsystem is complaining when you see such message on the
> log. ie: "xenbus: shrinker ..."

Because we have #define `pr_fmt(fmt) KBUILD_MODNAME ": " fmt` in the beginning
of the file, the message will have a proper prefix.

> 
> > +
> >  	return 0;
> >  }
> >  subsys_initcall(xenbus_probe_backend_init);
> > diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> > index 869c816d5f8c..196260017666 100644
> > --- a/include/xen/xenbus.h
> > +++ b/include/xen/xenbus.h
> > @@ -104,6 +104,7 @@ struct xenbus_driver {
> >  	struct device_driver driver;
> >  	int (*read_otherend_details)(struct xenbus_device *dev);
> >  	int (*is_ready)(struct xenbus_device *dev);
> > +	void (*reclaim)(struct xenbus_device *dev);
> 
> reclaim_memory (if Juergen agrees).

Okay.


Thanks,
SeongJae Park

> 
> Thanks, Roger.
> 
