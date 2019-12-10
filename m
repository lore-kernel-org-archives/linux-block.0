Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42368C2D0C6
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 10:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7AE207FF
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 10:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="FefSaWy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbfLJKQn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 05:16:43 -0500
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:46030 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfLJKQn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 05:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1575973002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lvaoe6PF5ne+O8eFrYv6xylYoM5pzWb0Os8/rpg2yvA=;
  b=FefSaWy9S43QW/Q6YVFj1CY2n8WuAXrT7SwkCGhBFeId/di900fuyeHt
   zK7QYAcyWFNNN8YswhSOx3SToS9YOnLXODM7PZTWeEoBwZSTgDGR47kpc
   lQbtdh7mBPuZfZmysczA2aONY1Bhs89BWomvkXE40nE+dJj5TWWlDQoph
   Y=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: 9IDqAWxfl6GB4MpZN7qCOk4M8hOVCyJJZkZFstv0Y6xsVz0PCZ38GaHuQOX5FR85MixU1ffCGh
 /5SCEXREeeZ1a+dcW9UMQlQ2yA9Xzlpn9OCktFGlHD8z3RhdrKQDW+92zEybK098kEsSgz6pjx
 qxHnI3A2O+cQ80dmJO9zL2Vu5ILc06RzKVhahdm0WUSb4OFAL0l+AN97cR9atUpsQNWwF2+N7p
 fSbSkb8noLO9/CSxP0FQYUtd54zwI+cuWxdgrbok8S3tAe5Wf/EsGhYevCIugfnc13VhL3sY1N
 feM=
X-SBRS: 2.7
X-MesageID: 9802387
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,299,1571716800"; 
   d="scan'208";a="9802387"
Date:   Tue, 10 Dec 2019 11:16:35 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     <sjpark@amazon.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pdurrant@amazon.com>, <xen-devel@lists.xenproject.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH v5 1/2] xenbus/backend: Add memory pressure handler
 callback
Message-ID: <20191210101635.GD980@Air-de-Roger>
References: <20191210080628.5264-1-sjpark@amazon.de>
 <20191210080628.5264-2-sjpark@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191210080628.5264-2-sjpark@amazon.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 10, 2019 at 08:06:27AM +0000, SeongJae Park wrote:
> Granting pages consumes backend system memory.  In systems configured
> with insufficient spare memory for those pages, it can cause a memory
> pressure situation.  However, finding the optimal amount of the spare
> memory is challenging for large systems having dynamic resource
> utilization patterns.  Also, such a static configuration might lack a

s/lack a/lack/

> flexibility.
> 
> To mitigate such problems, this commit adds a memory reclaim callback to
> 'xenbus_driver'.  Using this facility, 'xenbus' would be able to monitor
> a memory pressure and request specific devices of specific backend

s/monitor a/monitor/

> drivers which causing the given pressure to voluntarily release its

...which are causing...

> memory.
> 
> That said, this commit simply requests every callback registered driver
> to release its memory for every domain, rather than issueing the

s/issueing/issuing/

> requests to the drivers and the domain in charge.  Such things will be

I'm afraid I don't understand the "domain in charge" part of this
sentence.

> done in a futur.  Also, this commit focuses on memory only.  However, it

... done in a future change. Also I think the period after only should
be removed in order to tie both sentences together.

> would be ablt to be extended for general resources.

s/ablt/able/

> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  drivers/xen/xenbus/xenbus_probe_backend.c | 31 +++++++++++++++++++++++
>  include/xen/xenbus.h                      |  1 +
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
> index b0bed4faf44c..5a5ba29e39df 100644
> --- a/drivers/xen/xenbus/xenbus_probe_backend.c
> +++ b/drivers/xen/xenbus/xenbus_probe_backend.c
> @@ -248,6 +248,34 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
>  	return NOTIFY_DONE;
>  }
>  
> +static int xenbus_backend_reclaim(struct device *dev, void *data)
> +{
> +	struct xenbus_driver *drv;

Newline and const.

> +	if (!dev->driver)
> +		return -ENOENT;
> +	drv = to_xenbus_driver(dev->driver);
> +	if (drv && drv->reclaim)
> +		drv->reclaim(to_xenbus_device(dev));

You seem to completely ignore the return of the reclaim hook...

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
>  static int __init xenbus_probe_backend_init(void)
>  {
>  	static struct notifier_block xenstore_notifier = {
> @@ -264,6 +292,9 @@ static int __init xenbus_probe_backend_init(void)
>  
>  	register_xenstore_notifier(&xenstore_notifier);
>  
> +	if (register_shrinker(&xenbus_backend_shrinker))
> +		pr_warn("shrinker registration failed\n");
> +
>  	return 0;
>  }
>  subsys_initcall(xenbus_probe_backend_init);
> diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> index 869c816d5f8c..cdb075e4182f 100644
> --- a/include/xen/xenbus.h
> +++ b/include/xen/xenbus.h
> @@ -104,6 +104,7 @@ struct xenbus_driver {
>  	struct device_driver driver;
>  	int (*read_otherend_details)(struct xenbus_device *dev);
>  	int (*is_ready)(struct xenbus_device *dev);
> +	unsigned (*reclaim)(struct xenbus_device *dev);

... hence I wonder why it's returning an unsigned when it's just
ignored.

IMO it should return an int to signal errors, and the return should be
ignored.

Also, I think it would preferable for this function to take an extra
parameter to describe the resource the driver should attempt to free
(ie: memory or interrupts for example). I'm however not able to find
any existing Linux type to describe such resources.

Thanks, Roger.
