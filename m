Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB482C2D0E2
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 07:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 377862396D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 07:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="fR6q+2xF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgIVHjS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 03:39:18 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:21341 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729762AbgIVHjS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 03:39:18 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 03:39:17 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1600760357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=imblkrn9ceDLM/emiZtlefFra0U8yImhIQZNSNE+Xbs=;
  b=fR6q+2xF+OVU+queIemzHH5qmkjbFs+DEdXSYe6v8cq/90cyWhTec6GT
   AIiQGANw4xhszQJaxE4mxNHsvskk4MnuaehtLqhOnEfUxayeC3Whzsgtd
   GXkPyYL0yUMHqWeThU7uk4nKXgvVI4BEtV6LE0F1IcZuJ+E5V87A6Fpcb
   c=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: pN38FHBviY2A2B5jjvRXaMfl4t3R5hwYAYISS+7aBNZxvxjJUKclvXnCiss46rNidW/rkcA1W1
 a3xRTTF8/B5YKfC42ryKQrWH5V9IWyZP2ZGc6JFgHQdMir8tMOZUWfkcBXN1oi7Whoq+6yp0Ru
 eE8HH6DJ5ajGNeX4wo8cPJ+bgLvbT85NXNTPvq9RsJot7hqGBPTvBCW2Sjv2RhsM6uYl1ELlYR
 hbujwj3cq0kDHCBTMJNlmAwucLHQQCWAiwM0SInhQPQawg0A4KwCBsNu7hlgdeqywp2Q0DUWFV
 xF4=
X-SBRS: 2.7
X-MesageID: 27333621
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,289,1596513600"; 
   d="scan'208";a="27333621"
Date:   Tue, 22 Sep 2020 09:32:02 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     SeongJae Park <sjpark@amazon.com>
CC:     <konrad.wilk@oracle.com>, SeongJae Park <sjpark@amazon.de>,
        <axboe@kernel.dk>, <aliguori@amazon.com>, <amit@kernel.org>,
        <mheyne@amazon.de>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen-blkback: add a parameter for disabling of persistent
 grants
Message-ID: <20200922073202.GH19254@Air-de-Roger>
References: <20200922070125.27251-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200922070125.27251-1-sjpark@amazon.com>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 FTLPEX02CL06.citrite.net (10.13.108.179)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 22, 2020 at 09:01:25AM +0200, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Persistent grants feature provides high scalability.  On some small
> systems, however, it could incur data copy overhead[1] and thus it is
> required to be disabled.  But, there is no option to disable it.  For
> the reason, this commit adds a module parameter for disabling of the
> feature.

Have you considered adding a similar option for blkfront?

> 
> [1] https://wiki.xen.org/wiki/Xen_4.3_Block_Protocol_Scalability
> 
> Signed-off-by: Anthony Liguori <aliguori@amazon.com>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  .../ABI/testing/sysfs-driver-xen-blkback        |  8 ++++++++
>  drivers/block/xen-blkback/xenbus.c              | 17 ++++++++++++++---
>  2 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> index ecb7942ff146..0c42285c75ee 100644
> --- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
> +++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> @@ -35,3 +35,11 @@ Description:
>                  controls the duration in milliseconds that blkback will not
>                  cache any page not backed by a grant mapping.
>                  The default is 10ms.
> +
> +What:           /sys/module/xen_blkback/parameters/feature_persistent
> +Date:           September 2020
> +KernelVersion:  5.10
> +Contact:        SeongJae Park <sjpark@amazon.de>
> +Description:
> +                Whether to enable the persistent grants feature or not.
> +                The default is 1 (enable).

I would add that this option only takes effect on newly created
backends, existing backends when the option is set will continue to
use persistent grants.

For already running backends you could drain the buffer of persistent
grants and flip the option, but that's more complex and not required.

> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index b9aa5d1ac10b..9c03d70469f4 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -879,6 +879,12 @@ static void reclaim_memory(struct xenbus_device *dev)
>  
>  /* ** Connection ** */
>  
> +/* Enable the persistent grants feature. */
> +static unsigned int feature_persistent = 1;
> +module_param_named(feature_persistent, feature_persistent, int, 0644);
> +MODULE_PARM_DESC(feature_persistent,
> +		"Enables the persistent grants feature");
> +
>  /*
>   * Write the physical details regarding the block device to the store, and
>   * switch to Connected state.
> @@ -906,7 +912,8 @@ static void connect(struct backend_info *be)
>  
>  	xen_blkbk_barrier(xbt, be, be->blkif->vbd.flush_support);
>  
> -	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u", 1);
> +	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u",
> +			feature_persistent ? 1 : 0);

You can avoid writing the feature altogether if it's not enabled,
there's no need to set feature-persistent = 0.

Thanks, Roger.
