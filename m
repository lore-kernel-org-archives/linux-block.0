Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CF0C4363D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 07:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD8721548
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 07:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XGm6a7cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbgIVHZE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 03:25:04 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:25617 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbgIVHZE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 03:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600759503; x=1632295503;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=0+bAyvjF/IRHs0wEyMipvSEvEkOVBr0aJg9baDfrY4k=;
  b=XGm6a7cvA9g0jdo8UcG0YLC6gpcCaVZViT4eJ5TBqV/G4d/WeZPOl2op
   kftm/DSC91QomrA8PGE1sF9HPmF1CJIkmiE12F8cvDMovyw+Jx7/c3ckq
   LhNgkmW30NFOgzWt3bZaiqaCOy92DGdvVc29TpyD0YxxJw5GM166Kfz31
   w=;
X-IronPort-AV: E=Sophos;i="5.77,289,1596499200"; 
   d="scan'208";a="70012700"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 22 Sep 2020 07:25:02 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2c-1968f9fa.us-west-2.amazon.com (Postfix) with ESMTPS id 1D0C8A0829;
        Tue, 22 Sep 2020 07:25:01 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.185) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 22 Sep 2020 07:24:54 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>
CC:     SeongJae Park <sjpark@amazon.com>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>, SeongJae Park <sjpark@amazon.de>,
        <axboe@kernel.dk>, <aliguori@amazon.com>, <amit@kernel.org>,
        <mheyne@amazon.de>, <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen-blkback: add a parameter for disabling of persistent grants
Date:   Tue, 22 Sep 2020 09:24:37 +0200
Message-ID: <20200922072437.2495-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <5fd34475-c296-c4f3-2bac-180c166449fe@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.185]
X-ClientProxiedBy: EX13D39UWA004.ant.amazon.com (10.43.160.73) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 22 Sep 2020 09:18:05 +0200 "Jürgen Groß" <jgross@suse.com> wrote:

> On 22.09.20 09:01, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Persistent grants feature provides high scalability.  On some small
> > systems, however, it could incur data copy overhead[1] and thus it is
> > required to be disabled.  But, there is no option to disable it.  For
> > the reason, this commit adds a module parameter for disabling of the
> > feature.
> > 
> > [1] https://wiki.xen.org/wiki/Xen_4.3_Block_Protocol_Scalability
> > 
> > Signed-off-by: Anthony Liguori <aliguori@amazon.com>
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >   .../ABI/testing/sysfs-driver-xen-blkback        |  8 ++++++++
> >   drivers/block/xen-blkback/xenbus.c              | 17 ++++++++++++++---
> >   2 files changed, 22 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> > index ecb7942ff146..0c42285c75ee 100644
> > --- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
> > +++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> > @@ -35,3 +35,11 @@ Description:
> >                   controls the duration in milliseconds that blkback will not
> >                   cache any page not backed by a grant mapping.
> >                   The default is 10ms.
> > +
> > +What:           /sys/module/xen_blkback/parameters/feature_persistent
> > +Date:           September 2020
> > +KernelVersion:  5.10
> > +Contact:        SeongJae Park <sjpark@amazon.de>
> > +Description:
> > +                Whether to enable the persistent grants feature or not.
> > +                The default is 1 (enable).
> > diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> > index b9aa5d1ac10b..9c03d70469f4 100644
> > --- a/drivers/block/xen-blkback/xenbus.c
> > +++ b/drivers/block/xen-blkback/xenbus.c
> > @@ -879,6 +879,12 @@ static void reclaim_memory(struct xenbus_device *dev)
> >   
> >   /* ** Connection ** */
> >   
> > +/* Enable the persistent grants feature. */
> > +static unsigned int feature_persistent = 1;
> 
> Use bool, please.

Oops, I will.

> 
> > +module_param_named(feature_persistent, feature_persistent, int, 0644);
> 
> module_param()
> 
> > +MODULE_PARM_DESC(feature_persistent,
> > +		"Enables the persistent grants feature");
> > +
> >   /*
> >    * Write the physical details regarding the block device to the store, and
> >    * switch to Connected state.
> > @@ -906,7 +912,8 @@ static void connect(struct backend_info *be)
> >   
> >   	xen_blkbk_barrier(xbt, be, be->blkif->vbd.flush_support);
> >   
> > -	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u", 1);
> > +	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u",
> > +			feature_persistent ? 1 : 0);
> 
> Using bool above should allow to just use the value of
> feature_persistent here.

Indeed.  I will fix these as you recommended in the next spin.


Thanks,
SeongJae Park
