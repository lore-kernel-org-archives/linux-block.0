Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C81C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 11:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE3F2073D
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 11:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Gj91FSbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfLKLq7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:46:59 -0500
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:53448 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfLKLq6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 06:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1576064819;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P2MU3njNrfLJrdt+eLEGCcK2Oa2o5yX8/PbMswCYaNY=;
  b=Gj91FSbu2p3T7aec5OjUxskshJUpOD44qW5++mOO4/aCuQo4yvK0LVWi
   RNTAv2X+KvSJgOXKtO/njmW3eZlxjT0xQs1nXCfaryp4u4p48NfeOHQ0B
   AmRVa13lmu4uJhtB8yYdMH6Ym3U8iSyHvkyZ7iI88qXQtZEMFpKNnz4+u
   k=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: +HzPxT1PiH2ZjG1A/5a+YfO0CQqZIrbFt+4gfS5zEDuQYbwMbYZYsNOOKCizsr554KZiOjCygs
 lC2iM+TIgx2nXizoG7CSDvtJnMffNrKLFkPiCOxaZV7OnKRWcZraFooL9oay3qh/l9F12vzA22
 GlaJKSzUlO7b0z0fwM1eZc6/6QrTXWc+AsVZnSJvm3l741QORu7LTBzAyuGFDVuzkUPKRb+l50
 OxylbBCvU/JBgcN5Pu/VNJuqpoyKvQ0mgmGJVaIwgzQyYjS7NnTS1r3DryE40Ex1bVlu8ASGoG
 +eA=
X-SBRS: 2.7
X-MesageID: 9513342
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.69,301,1571716800"; 
   d="scan'208";a="9513342"
Date:   Wed, 11 Dec 2019 12:46:51 +0100
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     SeongJae Park <sj38.park@gmail.com>
CC:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        "SeongJae Park" <sjpark@amazon.de>, <pdurrant@amazon.com>,
        <sjpark@amazon.com>, <xen-devel@lists.xenproject.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] xenbus/backend: Add memory pressure handler
 callback
Message-ID: <20191211114651.GN980@Air-de-Roger>
References: <20191211042428.5961-1-sjpark@amazon.de>
 <20191211042657.6037-1-sjpark@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191211042657.6037-1-sjpark@amazon.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL03.citrite.net (10.69.22.127)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 11, 2019 at 04:26:57AM +0000, SeongJae Park wrote:
> Granting pages consumes backend system memory.  In systems configured
> with insufficient spare memory for those pages, it can cause a memory
> pressure situation.  However, finding the optimal amount of the spare
                                                              ^ s/the//
> memory is challenging for large systems having dynamic resource
> utilization patterns.  Also, such a static configuration might lack
> flexibility.
> 
> To mitigate such problems, this commit adds a memory reclaim callback to
> 'xenbus_driver'.  If a memory pressure is detected, 'xenbus' requests
                       ^ s/a//
> every backend driver to volunarily release its memory.
> 
> Note that it would be able to improve the callback facility for more
                        ^ possible
> sophisticated handlings of general pressures.  For example, it would be
                ^ handling of resource starvation.
> possible to monitor the memory consumption of each device and issue the
> release requests to only devices which causing the pressure.  Also, the
> callback could be extended to handle not only memory, but general
> resources.  Nevertheless, this version of the implementation defers such
> sophisticated goals as a future work.
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  drivers/xen/xenbus/xenbus_probe_backend.c | 32 +++++++++++++++++++++++
>  include/xen/xenbus.h                      |  1 +
>  2 files changed, 33 insertions(+)
> 
> diff --git a/drivers/xen/xenbus/xenbus_probe_backend.c b/drivers/xen/xenbus/xenbus_probe_backend.c
> index b0bed4faf44c..aedbe2198de5 100644
> --- a/drivers/xen/xenbus/xenbus_probe_backend.c
> +++ b/drivers/xen/xenbus/xenbus_probe_backend.c
> @@ -248,6 +248,35 @@ static int backend_probe_and_watch(struct notifier_block *notifier,
>  	return NOTIFY_DONE;
>  }
>  
> +static int xenbus_backend_reclaim(struct device *dev, void *data)

No need for the xenbus_ prefix since it's a static function, ie:
backend_reclaim_memory should be fine IMO.

> +{
> +	struct xenbus_driver *drv;

I've asked for this variable to be constified in v5, is it not
possible to make it const?

> +
> +	if (!dev->driver)
> +		return 0;
> +	drv = to_xenbus_driver(dev->driver);
> +	if (drv && drv->reclaim)
> +		drv->reclaim(to_xenbus_device(dev));
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

I would drop the xenbus prefix, and I think it's not possible to
constify this due to register_shrinker expecting a non-const
parameter?

> +	.count_objects = xenbus_backend_shrink_count,
> +	.seeks = DEFAULT_SEEKS,
> +};
> +
>  static int __init xenbus_probe_backend_init(void)
>  {
>  	static struct notifier_block xenstore_notifier = {
> @@ -264,6 +293,9 @@ static int __init xenbus_probe_backend_init(void)
>  
>  	register_xenstore_notifier(&xenstore_notifier);
>  
> +	if (register_shrinker(&xenbus_backend_shrinker))
> +		pr_warn("shrinker registration failed\n");

Can you add a xenbus prefix to the error message? Or else it's hard to
know which subsystem is complaining when you see such message on the
log. ie: "xenbus: shrinker ..."

> +
>  	return 0;
>  }
>  subsys_initcall(xenbus_probe_backend_init);
> diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> index 869c816d5f8c..196260017666 100644
> --- a/include/xen/xenbus.h
> +++ b/include/xen/xenbus.h
> @@ -104,6 +104,7 @@ struct xenbus_driver {
>  	struct device_driver driver;
>  	int (*read_otherend_details)(struct xenbus_device *dev);
>  	int (*is_ready)(struct xenbus_device *dev);
> +	void (*reclaim)(struct xenbus_device *dev);

reclaim_memory (if Juergen agrees).

Thanks, Roger.
