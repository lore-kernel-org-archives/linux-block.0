Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294F3C2D0B1
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 06:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A01620663
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 06:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbfLJGXV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 01:23:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:60848 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbfLJGXU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 01:23:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CA63AAE3D;
        Tue, 10 Dec 2019 06:23:18 +0000 (UTC)
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
Message-ID: <4be85067-a1cc-224e-6629-06034df2b7e6@suse.com>
Date:   Tue, 10 Dec 2019 07:23:17 +0100
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

Oh, sorry for first requesting you to add the domid as a parameter,
but now I realize this could be handled in the xenbus driver, as
struct xenbus_device already contains the otherend_id.

Would you mind dropping the parameter again, please?


Juergen
