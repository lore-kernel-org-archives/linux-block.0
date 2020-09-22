Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961B7C2D0E2
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 12:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7CD2395C
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 12:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JsN94s/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgIVMpZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Sep 2020 08:45:25 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:10402 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgIVMpZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Sep 2020 08:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1600778725; x=1632314725;
  h=from:to:cc:subject:date:message-id:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=4NWeS0xwxjfjyP4fYO5lNehd5ZKrflGYWnJgAJBxqGc=;
  b=JsN94s/f5Er7SUolajdfNmQPufQPXBM3L/6NpLM9ygqipxGQWZJ5EfGM
   9BOsU/aVcnxoWkOresjyxGLKsCO6olF0exMqrn3QELSxW2z8k950lGDeX
   aNKHDgsZe7XaojROqCEzQAauDknp9StOsJESClPZxkZMx0muLLNVqJBLv
   8=;
X-IronPort-AV: E=Sophos;i="5.77,290,1596499200"; 
   d="scan'208";a="70090946"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 22 Sep 2020 12:45:19 +0000
Received: from EX13D31EUA004.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id F00271A04B8;
        Tue, 22 Sep 2020 12:45:17 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.183) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 22 Sep 2020 12:45:11 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     =?UTF-8?q?J=C3=BCrgen=20Gro=C3=9F?= <jgross@suse.com>
CC:     SeongJae Park <sjpark@amazon.com>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>, SeongJae Park <sjpark@amazon.de>,
        <axboe@kernel.dk>, <aliguori@amazon.com>, <amit@kernel.org>,
        <mheyne@amazon.de>, <pdurrant@amazon.co.uk>,
        <linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] xen-blkfront: add a parameter for disabling of persistent grants
Date:   Tue, 22 Sep 2020 14:44:44 +0200
Message-ID: <20200922124444.2231-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <fdbaf955-0b92-d356-2792-21b27ea1087d@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.43.160.183]
X-ClientProxiedBy: EX13D07UWB002.ant.amazon.com (10.43.161.131) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 22 Sep 2020 14:11:32 +0200 "Jürgen Groß" <jgross@suse.com> wrote:

> On 22.09.20 12:52, SeongJae Park wrote:
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
> >   .../ABI/testing/sysfs-driver-xen-blkfront     |  9 ++++++
> >   drivers/block/xen-blkfront.c                  | 28 +++++++++++++------
> >   2 files changed, 29 insertions(+), 8 deletions(-)
> > 
[...]
> > diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> > index 91de2e0755ae..49c324f377de 100644
> > --- a/drivers/block/xen-blkfront.c
> > +++ b/drivers/block/xen-blkfront.c
> > @@ -149,6 +149,13 @@ static unsigned int xen_blkif_max_ring_order;
> >   module_param_named(max_ring_page_order, xen_blkif_max_ring_order, int, 0444);
> >   MODULE_PARM_DESC(max_ring_page_order, "Maximum order of pages to be used for the shared ring");
> >   
> > +/* Enable the persistent grants feature. */
> > +static bool feature_persistent = true;
> > +module_param(feature_persistent, bool, 0644);
> > +MODULE_PARM_DESC(feature_persistent,
> > +		"Enables the persistent grants feature");
> > +
> > +
> >   #define BLK_RING_SIZE(info)	\
> >   	__CONST_RING_SIZE(blkif, XEN_PAGE_SIZE * (info)->nr_ring_pages)
> >   
> > @@ -1866,11 +1873,13 @@ static int talk_to_blkback(struct xenbus_device *dev,
> >   		message = "writing protocol";
> >   		goto abort_transaction;
> >   	}
> > -	err = xenbus_printf(xbt, dev->nodename,
> > -			    "feature-persistent", "%u", 1);
> > -	if (err)
> > -		dev_warn(&dev->dev,
> > -			 "writing persistent grants feature to xenbus");
> > +	if (feature_persistent) {
> > +		err = xenbus_printf(xbt, dev->nodename,
> > +				    "feature-persistent", "%u", 1);
> > +		if (err)
> > +			dev_warn(&dev->dev,
> > +				 "writing persistent grants feature to xenbus");
> > +	}
> >   
> >   	err = xenbus_transaction_end(xbt, 0);
> >   	if (err) {
> > @@ -2316,9 +2325,12 @@ static void blkfront_gather_backend_features(struct blkfront_info *info)
> >   	if (xenbus_read_unsigned(info->xbdev->otherend, "feature-discard", 0))
> >   		blkfront_setup_discard(info);
> >   
> > -	info->feature_persistent =
> > -		!!xenbus_read_unsigned(info->xbdev->otherend,
> > -				       "feature-persistent", 0);
> > +	if (feature_persistent)
> > +		info->feature_persistent =
> > +			!!xenbus_read_unsigned(info->xbdev->otherend,
> > +					       "feature-persistent", 0);
> > +	else
> > +		info->feature_persistent = 0;
> >   
> >   	indirect_segments = xenbus_read_unsigned(info->xbdev->otherend,
> >   					"feature-max-indirect-segments", 0);
> > 
> 
> Here you have the same problem as in blkback: feature_persistent could
> change its value between the two tests.

Yes, indeed.  I will fix this in the next version.


Thanks,
SeongJae Park
