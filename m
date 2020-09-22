Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91CEC2D0E2
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 12:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5178520936
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 12:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CxHmzwgb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgIVMHi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 08:07:38 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:64402 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgIVMHi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 08:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600776457; x=1632312457;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=EbMxVxxFklRKS3zGijxq8O1nhhE8A4FeT/IHUzpIBpg=;
  b=CxHmzwgbsYbcuRpq5gRr0I/ee9JDRtaJVuGTgq/tAO7/0jE+LTKRQe9S
   em81zz7F/7DkGCpYPJZKmh1bodtdzQYAN5SdoEm6dfqS6wxrgDpR1bv9o
   ReUP/4iQ9HCJhoRWfkNTktocXWKCkeVYL+0+0kYAZUDDahW7vTxWtYES+
   c=;
X-IronPort-AV: E=Sophos;i="5.77,290,1596499200"; 
   d="scan'208";a="70077024"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 22 Sep 2020 12:07:33 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-90c42d1d.us-west-2.amazon.com (Postfix) with ESMTPS id 790E9A18C9;
        Tue, 22 Sep 2020 12:07:32 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.185) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 22 Sep 2020 12:07:25 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
CC:     SeongJae Park <sjpark@amazon.com>, <konrad.wilk@oracle.com>,
        <jgross@suse.com>, SeongJae Park <sjpark@amazon.de>,
        <axboe@kernel.dk>, <aliguori@amazon.com>, <amit@kernel.org>,
        <mheyne@amazon.de>, <pdurrant@amazon.co.uk>,
        <linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] xen-blkback: add a parameter for disabling of persistent grants
Date:   Tue, 22 Sep 2020 14:07:10 +0200
Message-ID: <20200922120710.24685-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <20200922113511.GK19254@Air-de-Roger>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.185]
X-ClientProxiedBy: EX13D50UWC002.ant.amazon.com (10.43.162.189) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 22 Sep 2020 13:35:11 +0200 "Roger Pau Monné" <roger.pau@citrix.com> wrote:

> On Tue, Sep 22, 2020 at 01:26:38PM +0200, SeongJae Park wrote:
> > On Tue, 22 Sep 2020 13:12:59 +0200 "Roger Pau Monné" <roger.pau@citrix.com> wrote:
> > 
> > > On Tue, Sep 22, 2020 at 12:52:07PM +0200, SeongJae Park wrote:
> > > > From: SeongJae Park <sjpark@amazon.de>
> > > > 
> > > > Persistent grants feature provides high scalability.  On some small
> > > > systems, however, it could incur data copy overheads[1] and thus it is
> > > > required to be disabled.  But, there is no option to disable it.  For
> > > > the reason, this commit adds a module parameter for disabling of the
> > > > feature.
> > > > 
> > > > [1] https://wiki.xen.org/wiki/Xen_4.3_Block_Protocol_Scalability
> > > > 
> > > > Signed-off-by: Anthony Liguori <aliguori@amazon.com>
> > > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > > > ---
> > > >  .../ABI/testing/sysfs-driver-xen-blkback      |  9 ++++++
> > > >  drivers/block/xen-blkback/xenbus.c            | 28 ++++++++++++++-----
> > > >  2 files changed, 30 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> > > > index ecb7942ff146..ac2947b98950 100644
> > > > --- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
> > > > +++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> > > > @@ -35,3 +35,12 @@ Description:
> > > >                  controls the duration in milliseconds that blkback will not
> > > >                  cache any page not backed by a grant mapping.
> > > >                  The default is 10ms.
> > > > +
> > > > +What:           /sys/module/xen_blkback/parameters/feature_persistent
> > > > +Date:           September 2020
> > > > +KernelVersion:  5.10
> > > > +Contact:        SeongJae Park <sjpark@amazon.de>
> > > > +Description:
> > > > +                Whether to enable the persistent grants feature or not.  Note
> > > > +                that this option only takes effect on newly created backends.
> > > > +                The default is Y (enable).
> > > > diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> > > > index b9aa5d1ac10b..8a95ddd08b13 100644
> > > > --- a/drivers/block/xen-blkback/xenbus.c
> > > > +++ b/drivers/block/xen-blkback/xenbus.c
> > > > @@ -879,6 +879,12 @@ static void reclaim_memory(struct xenbus_device *dev)
> > > >  
> > > >  /* ** Connection ** */
> > > >  
> > > > +/* Enable the persistent grants feature. */
> > > > +static bool feature_persistent = true;
> > > > +module_param(feature_persistent, bool, 0644);
> > > > +MODULE_PARM_DESC(feature_persistent,
> > > > +		"Enables the persistent grants feature");
> > > > +
> > > >  /*
> > > >   * Write the physical details regarding the block device to the store, and
> > > >   * switch to Connected state.
> > > > @@ -906,11 +912,15 @@ static void connect(struct backend_info *be)
> > > >  
> > > >  	xen_blkbk_barrier(xbt, be, be->blkif->vbd.flush_support);
> > > >  
> > > > -	err = xenbus_printf(xbt, dev->nodename, "feature-persistent", "%u", 1);
> > > > -	if (err) {
> > > > -		xenbus_dev_fatal(dev, err, "writing %s/feature-persistent",
> > > > -				 dev->nodename);
> > > > -		goto abort;
> > > > +	if (feature_persistent) {
> > > > +		err = xenbus_printf(xbt, dev->nodename, "feature-persistent",
> > > > +				"%u", feature_persistent);
> > > > +		if (err) {
> > > > +			xenbus_dev_fatal(dev, err,
> > > > +					"writing %s/feature-persistent",
> > > > +					dev->nodename);
> > > > +			goto abort;
> > > > +		}
> > > >  	}
> > > >  
> > > >  	err = xenbus_printf(xbt, dev->nodename, "sectors", "%llu",
> > > > @@ -1093,8 +1103,12 @@ static int connect_ring(struct backend_info *be)
> > > >  		xenbus_dev_fatal(dev, err, "unknown fe protocol %s", protocol);
> > > >  		return -ENOSYS;
> > > >  	}
> > > > -	pers_grants = xenbus_read_unsigned(dev->otherend, "feature-persistent",
> > > > -					   0);
> > > > +	if (feature_persistent)
> > > > +		pers_grants = xenbus_read_unsigned(dev->otherend,
> > > > +				"feature-persistent", 0);
> > > > +	else
> > > > +		pers_grants = 0;
> > > > +
> > > 
> > > Sorry for not realizing earlier, but looking at it again I think you
> > > need to cache the value of feature_persistent when it's first used in
> > > the blkback state data, so that it's consistent.
> > > 
> > > What would happen for example with the following flow (assume a
> > > persistent grants enabled frontend):
> > > 
> > > feature_persistent = false
> > > 
> > > connect(...)
> > > feature-persistent is not written to xenstore
> > > 
> > > User changes feature_persistent = true
> > > 
> > > connect_ring(...)
> > > pers_grants = true, because feature-persistent is set unconditionally
> > > by the frontend and feature_persistent variable is now true.
> > > 
> > > Then blkback will try to use persistent grants and the whole
> > > connection will malfunction because the frontend won't.
> > 
> > Ah, you're right.  I should also catch this before but didn't, sorry.
> > 
> > > 
> > > The other option is to prevent changing the variable when there are
> > > blkback instances already running.
> > 
> > I think storing the option value in xenstore would be simpler.  That said, if
> > you prefer this way, please let me know.
> 
> If possible I prefer to avoid reading from xenstore because it's slow,
> very slow compared to storing this somewhere in the blkback
> structure.

Agreed.

> 
> Could you use the feature_gnt_persistent field in xen_vbd maybe as a
> place to cache the value before it's set with the final negotiated
> value between the frontend and the backend?

Ok, I will do so in the next version.


Thanks,
SeongJae Park
