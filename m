Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8007CC43603
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 06:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D2B2077B
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 06:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfLJGL4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:11:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:58028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfLJGL4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 01:11:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56FF1B311;
        Tue, 10 Dec 2019 06:11:53 +0000 (UTC)
Subject: Re: [PATCH v4 1/2] xenbus/backend: Add memory pressure handler
 callback
To:     SeongJae Park <sjpark@amazon.com>
Cc:     axboe@kernel.dk, konrad.wilk@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pdurrant@amazon.com, roger.pau@citrix.com, sj38.park@gmail.com,
        xen-devel@lists.xenproject.org, SeongJae Park <sjpark@amazon.de>
References: <20191209194305.20828-1-sjpark@amazon.com>
 <20191209194305.20828-2-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <2aca11d5-38ba-e924-c38e-e48c52c915c6@suse.com>
Date:   Tue, 10 Dec 2019 07:11:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209194305.20828-2-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09.12.19 20:43, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Granting pages consumes backend system memory.  In systems configured
> with insufficient spare memory for those pages, it can cause a memory
> pressure situation.  However, finding the optimal amount of the spare
> memory is challenging for large systems having dynamic resource
> utilization patterns.  Also, such a static configuration might lacks a
> flexibility.
> 
> To mitigate such problems, this commit adds a memory reclaim callback to
> 'xenbus_driver'.  Using this facility, 'xenbus' would be able to monitor
> a memory pressure and request specific domains of specific backend
> drivers which causing the given pressure to voluntarily release its
> memory.
> 
> That said, this commit simply requests every callback registered driver
> to release its memory for every domain, rather than issueing the
> requests to the drivers and domain in charge.  Such things would be a
> future work.  Also, this commit focuses on memory only.  However, it
> would be ablt to be extended for general resources.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>   drivers/xen/xenbus/xenbus_probe_backend.c | 31 +++++++++++++++++++++++
>   include/xen/xenbus.h                      |  1 +
>   2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
> index b0bed4faf44c..cd5fd1cd8de3 100644
> --- a/drivers/xen/xenbus/xenbus_probe_backend.c
> +++ b/drivers/xen/xenbus/xenbus_probe_backend.c
> @@ -248,6 +248,34 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
>   	return NOTIFY_DONE;
>   }
>   
> +static int xenbus_backend_reclaim(struct device *dev, void *data)
> +{
> +	struct xenbus_driver *drv;
> +	if (!dev->driver)
> +		return -ENOENT;
> +	drv = to_xenbus_driver(dev->driver);
> +	if (drv && drv->reclaim)
> +		drv->reclaim(to_xenbus_device(dev), DOMID_INVALID);
> +	return 0;
> +}
> +
> +/*
> + * Returns 0 always because we are using shrinker to only detect memory
> + * pressure.
> + */
> +static unsigned long xenbus_backend_shrink_count(struct shrinker *shrinker,
> +				struct shrink_control *sc)
> +{
> +	bus_for_each_dev(&xenbus_backend.bus, NULL, NULL,
> +			xenbus_backend_reclaim);
> +	return 0;
> +}
> +
> +static struct shrinker xenbus_backend_shrinker = {
> +	.count_objects = xenbus_backend_shrink_count,
> +	.seeks = DEFAULT_SEEKS,
> +};
> +
>   static int __init xenbus_probe_backend_init(void)
>   {
>   	static struct notifier_block xenstore_notifier = {
> @@ -264,6 +292,9 @@ static int __init xenbus_probe_backend_init(void)
>   
>   	register_xenstore_notifier(&xenstore_notifier);
>   
> +	if (register_shrinker(&xenbus_backend_shrinker))
> +		pr_warn("shrinker registration failed\n");
> +
>   	return 0;
>   }
>   subsys_initcall(xenbus_probe_backend_init);
> diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> index 869c816d5f8c..52aaf4f78400 100644
> --- a/include/xen/xenbus.h
> +++ b/include/xen/xenbus.h
> @@ -104,6 +104,7 @@ struct xenbus_driver {
>   	struct device_driver driver;
>   	int (*read_otherend_details)(struct xenbus_device *dev);
>   	int (*is_ready)(struct xenbus_device *dev);
> +	unsigned (*reclaim)(struct xenbus_device *dev, domid_t domid);

Can you please add a comment here regarding semantics of specifying
DOMID_INVALID as domid?

Block maintainers, would you be fine with me carrying this series
through the Xen tree?


Juergen
