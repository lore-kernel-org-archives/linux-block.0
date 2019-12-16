Return-Path: <SRS0=l7do=2G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF06C43603
	for <linux-block@archiver.kernel.org>; Mon, 16 Dec 2019 16:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 619E82067C
	for <linux-block@archiver.kernel.org>; Mon, 16 Dec 2019 16:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="q3BOpMZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfLPQQV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:16:21 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:54371 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfLPQQV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Dec 2019 11:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1576512980; x=1608048980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=9z8t8XnsAnAXAf2gaDgzxItc1c1wK1sA8xuncflNNTQ=;
  b=q3BOpMZy94YncFZJenGg/yyH1K/6XfsWfcLcRMKmSwmC91Vx9Xrdb7Ie
   Jeqgpwx4e9iX0RIy+3V0H3PukN5gqDPWDnLgt8H3hMzjcHb2l/wxw7S0r
   V9ab/DjRMA+bNmPdeo+O7W6HExFqKZOw1EpO0Nngyd4evxJEh6FCVeLNT
   I=;
IronPort-SDR: E3egi9ueoOF6CWKE2d6HH3+whzv1+J303Ok2CC8E09WqnGH2siSeJ6rUbyhRFFZ0+JupCCbi4z
 FBQHv6I/V1FA==
X-IronPort-AV: E=Sophos;i="5.69,322,1571702400"; 
   d="scan'208";a="7840830"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 16 Dec 2019 16:16:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id 78C7DA252F;
        Mon, 16 Dec 2019 16:16:17 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Dec 2019 16:16:16 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.161.74) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 16 Dec 2019 16:16:08 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <jgross@suse.com>, <axboe@kernel.dk>, <konrad.wilk@oracle.com>,
        <roger.pau@citrix.com>
CC:     <pdurrant@amazon.com>, <linux-kernel@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <xen-devel@lists.xenproject.org>,
        <sj38.park@gmail.com>, <sjpark@amazon.com>
Subject: Re: Re: [Xen-devel] [PATCH v10 2/4] xen/blkback: Squeeze page pools if a memory pressure is detected
Date:   Mon, 16 Dec 2019 17:15:49 +0100
Message-ID: <20191216161549.26976-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191216143720.23268-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.74]
X-ClientProxiedBy: EX13D15UWA004.ant.amazon.com (10.43.160.219) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 16 Dec 2019 15:37:20 +0100 SeongJae Park <sjpark@amazon.com> wrote:

> On Mon, 16 Dec 2019 13:45:25 +0100 SeongJae Park <sjpark@amazon.com> wrote:
> 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
[...]
> > --- a/drivers/block/xen-blkback/xenbus.c
> > +++ b/drivers/block/xen-blkback/xenbus.c
> > @@ -824,6 +824,24 @@ static void frontend_changed(struct xenbus_device *dev,
> >  }
> >  
> >  
> > +/* Once a memory pressure is detected, squeeze free page pools for a while. */
> > +static unsigned int buffer_squeeze_duration_ms = 10;
> > +module_param_named(buffer_squeeze_duration_ms,
> > +		buffer_squeeze_duration_ms, int, 0644);
> > +MODULE_PARM_DESC(buffer_squeeze_duration_ms,
> > +"Duration in ms to squeeze pages buffer when a memory pressure is detected");
> > +
> > +/*
> > + * Callback received when the memory pressure is detected.
> > + */
> > +static void reclaim_memory(struct xenbus_device *dev)
> > +{
> > +	struct backend_info *be = dev_get_drvdata(&dev->dev);
> > +
> > +	be->blkif->buffer_squeeze_end = jiffies +
> > +		msecs_to_jiffies(buffer_squeeze_duration_ms);
> 
> This callback might race with 'xen_blkbk_probe()'.  The race could result in
> __NULL dereferencing__, as 'xen_blkbk_probe()' sets '->blkif' after it links
> 'be' to the 'dev'.  Please _don't merge_ this patch now!
> 
> I will do more test and share results.  Meanwhile, if you have any opinion,
> please let me know.

Not only '->blkif', but 'be' itself also coule be a NULL.  As similar
concurrency issues could be in other drivers in their way, I suggest to change
the reclaim callback ('->reclaim_memory') to be called for each driver instead
of each device.  Then, each driver could be able to deal with its concurrency
issues by itself.

For blkback, we could reuse the global variable based approach, as similar to
the v7[1] of this patchset.  As the callback is called for each driver instead
of each device now, the duplicated set of the timeout will not happen.


Thanks,
SeongJae Park

[1] https://lore.kernel.org/xen-devel/20191211181016.14366-1-sjpark@amazon.de/

> 
> 
> Thanks,
> SeongJae Park
> 
> > +}
> > +
> >  /* ** Connection ** */
> >  
> >  
> > @@ -1115,7 +1133,8 @@ static struct xenbus_driver xen_blkbk_driver = {
> >  	.ids  = xen_blkbk_ids,
> >  	.probe = xen_blkbk_probe,
> >  	.remove = xen_blkbk_remove,
> > -	.otherend_changed = frontend_changed
> > +	.otherend_changed = frontend_changed,
> > +	.reclaim_memory = reclaim_memory,
> >  };
> >  
> >  int xen_blkif_xenbus_init(void)
> > -- 
> > 2.17.1
> > 
> 
