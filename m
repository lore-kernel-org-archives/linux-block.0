Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1321C4727C
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 14:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F7A2399A
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 14:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XlK9+DhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIVOcA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 10:32:00 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:15511 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgIVOcA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 10:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600785120; x=1632321120;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=noIQ/EB2UQYZv4x5hTS9cjTceBsCt2CTaoR0u2DKqiY=;
  b=XlK9+DhYwJElGQ2wkhwkzrxnKFsv/eqAfV8ni7+voKBMEO9ibTGRm/bL
   FeykGi8g/9Fuf6s3+mWKkMfwn8QRBmlPCeyPWTcHpat/eV7O+W5ltqINf
   5au1rJe9g1nfl43gBLmQThHUGvN4sAmuPNH9GgJP+R2Suw0cX25DhNdIw
   g=;
X-IronPort-AV: E=Sophos;i="5.77,291,1596499200"; 
   d="scan'208";a="77050146"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 22 Sep 2020 14:31:45 +0000
Received: from EX13D31EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 8E204A4527;
        Tue, 22 Sep 2020 14:31:40 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.85) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 22 Sep 2020 14:31:34 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>
CC:     SeongJae Park <sjpark@amazon.com>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>, SeongJae Park <sjpark@amazon.de>,
        <axboe@kernel.dk>, <aliguori@amazon.com>, <amit@kernel.org>,
        <mheyne@amazon.de>, <pdurrant@amazon.co.uk>,
        <linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] xen-blkfront: add a parameter for disabling of persistent grants
Date:   Tue, 22 Sep 2020 16:31:17 +0200
Message-ID: <20200922143117.30167-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <28773bff-7664-99fa-a542-b87e907bf705@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.162.85]
X-ClientProxiedBy: EX13D01UWA001.ant.amazon.com (10.43.160.60) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 22 Sep 2020 16:27:03 +0200 "Jürgen Groß" <jgross@suse.com> wrote:

> On 22.09.20 16:15, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Persistent grants feature provides high scalability.  On some small
> > systems, however, it could incur data copy overheads[1] and thus it is
> > required to be disabled.  It can be disabled from blkback side using a
> > module parameter, 'feature_persistent'.  But, it is impossible from
> > blkfront side.  For the reason, this commit adds a blkfront module
> > parameter for disabling of the feature.
> > 
> > [1] https://wiki.xen.org/wiki/Xen_4.3_Block_Protocol_Scalability
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >   .../ABI/testing/sysfs-driver-xen-blkfront     |  9 +++++++++
> >   drivers/block/xen-blkfront.c                  | 20 ++++++++++++++-----
> >   2 files changed, 24 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkfront b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
> > index c0a6cb7eb314..9c31334cb2e6 100644
> > --- a/Documentation/ABI/testing/sysfs-driver-xen-blkfront
> > +++ b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
> > @@ -8,3 +8,12 @@ Description:
> >                   is 32 - higher value means more potential throughput but more
> >                   memory usage. The backend picks the minimum of the frontend
> >                   and its default backend value.
> > +
> > +What:           /sys/module/xen_blkfront/parameters/feature_persistent
> > +Date:           September 2020
> > +KernelVersion:  5.10
> > +Contact:        SeongJae Park <sjpark@amazon.de>
> > +Description:
> > +                Whether to enable the persistent grants feature or not.  Note
> > +                that this option only takes effect on newly created frontends.
> > +                The default is Y (enable).
> > diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> > index 91de2e0755ae..b2d3b1262404 100644
> > --- a/drivers/block/xen-blkfront.c
> > +++ b/drivers/block/xen-blkfront.c
> > @@ -1866,8 +1866,8 @@ static int talk_to_blkback(struct xenbus_device *dev,
> >   		message = "writing protocol";
> >   		goto abort_transaction;
> >   	}
> > -	err = xenbus_printf(xbt, dev->nodename,
> > -			    "feature-persistent", "%u", 1);
> > +	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u",
> > +			info->feature_persistent);
> >   	if (err)
> >   		dev_warn(&dev->dev,
> >   			 "writing persistent grants feature to xenbus");
> > @@ -1941,6 +1941,13 @@ static int negotiate_mq(struct blkfront_info *info)
> >   	}
> >   	return 0;
> >   }
> > +
> > +/* Enable the persistent grants feature. */
> > +static bool feature_persistent = true;
> > +module_param(feature_persistent, bool, 0644);
> > +MODULE_PARM_DESC(feature_persistent,
> > +		"Enables the persistent grants feature");
> > +
> >   /**
> >    * Entry point to this code when a new device is created.  Allocate the basic
> >    * structures and the ring buffer for communication with the backend, and
> > @@ -2007,6 +2014,8 @@ static int blkfront_probe(struct xenbus_device *dev,
> >   	info->vdevice = vdevice;
> >   	info->connected = BLKIF_STATE_DISCONNECTED;
> >   
> > +	info->feature_persistent = feature_persistent ? 1 : 0;
> 
> Just use the value.

Yes, I will.

> 
> With that changed:
> 
> Reviewed-by: Juergen Gross <jgross@suse.com>

Appreciate :)


Thanks,
SeongJae Park
