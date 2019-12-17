Return-Path: <SRS0=G4H8=2H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A1BC43603
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40F024679
	for <linux-block@archiver.kernel.org>; Tue, 17 Dec 2019 16:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfLQQNs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Dec 2019 11:13:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:48522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbfLQQNr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Dec 2019 11:13:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5DB33AB7F;
        Tue, 17 Dec 2019 16:13:45 +0000 (UTC)
Subject: Re: [PATCH v11 2/6] xenbus/backend: Protect xenbus callback with lock
To:     SeongJae Park <sjpark@amazon.com>, axboe@kernel.dk,
        konrad.wilk@oracle.com, roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sj38.park@gmail.com, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191217160748.693-1-sjpark@amazon.com>
 <20191217160748.693-3-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <44327bf3-45ed-3e5a-3984-36ea40f53fc5@suse.com>
Date:   Tue, 17 Dec 2019 17:13:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191217160748.693-3-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17.12.19 17:07, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> 'reclaim_memory' callback can race with a driver code as this callback
> will be called from any memory pressure detected context.  To deal with
> the case, this commit adds a spinlock in the 'xenbus_device'.  Whenever
> 'reclaim_memory' callback is called, the lock of the device which passed
> to the callback as its argument is locked.  Thus, drivers registering
> their 'reclaim_memory' callback should protect the data that might race
> with the callback with the lock by themselves.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>   drivers/xen/xenbus/xenbus_probe.c         |  1 +
>   drivers/xen/xenbus/xenbus_probe_backend.c | 10 ++++++++--
>   include/xen/xenbus.h                      |  2 ++
>   3 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_probe.c b/drivers/xen/xenbus/xenbus_probe.c
> index 5b471889d723..b86393f172e6 100644
> --- a/drivers/xen/xenbus/xenbus_probe.c
> +++ b/drivers/xen/xenbus/xenbus_probe.c
> @@ -472,6 +472,7 @@ int xenbus_probe_node(struct xen_bus_type *bus,
>   		goto fail;
>   
>   	dev_set_name(&xendev->dev, "%s", devname);
> +	spin_lock_init(&xendev->reclaim_lock);
>   
>   	/* Register with generic device framework. */
>   	err = device_register(&xendev->dev);
> diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
> index 7e78ebef7c54..516aa64b9967 100644
> --- a/drivers/xen/xenbus/xenbus_probe_backend.c
> +++ b/drivers/xen/xenbus/xenbus_probe_backend.c
> @@ -251,12 +251,18 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
>   static int backend_reclaim_memory(struct device *dev, void *data)
>   {
>   	const struct xenbus_driver *drv;
> +	struct xenbus_device *xdev;
> +	unsigned long flags;
>   
>   	if (!dev->driver)
>   		return 0;
>   	drv = to_xenbus_driver(dev->driver);
> -	if (drv && drv->reclaim_memory)
> -		drv->reclaim_memory(to_xenbus_device(dev));
> +	if (drv && drv->reclaim_memory) {
> +		xdev = to_xenbus_device(dev);
> +		spin_trylock_irqsave(&xdev->reclaim_lock, flags);

You need spin_lock_irqsave() here. Or maybe spin_lock() would be fine,
too? I can't see a reason why you'd want to disable irqs here.

> +		drv->reclaim_memory(xdev);
> +		spin_unlock_irqrestore(&xdev->reclaim_lock, flags);
> +	}
>   	return 0;
>   }
>   
> diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> index c861cfb6f720..d9468313061d 100644
> --- a/include/xen/xenbus.h
> +++ b/include/xen/xenbus.h
> @@ -76,6 +76,8 @@ struct xenbus_device {
>   	enum xenbus_state state;
>   	struct completion down;
>   	struct work_struct work;
> +	/* 'reclaim_memory' callback is called while this lock is acquired */
> +	spinlock_t reclaim_lock;
>   };
>   
>   static inline struct xenbus_device *to_xenbus_device(struct device *dev)
> 


Juergen
