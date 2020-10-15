Return-Path: <SRS0=w0su=DW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CED1C433DF
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 14:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1369C2076B
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 14:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="M3sHzG3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgJOOoK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Oct 2020 10:44:10 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:5754 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgJOOoK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Oct 2020 10:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1602773049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=o1CQ3R7emkmHv4RUcLBMXcqMzNDO5c9/K98ceiO5WPY=;
  b=M3sHzG3kqgEF1LE3o3AwomXT4Jo+9URFcmvncEvF8V+4v7+VOVYaFGfN
   ER4QLM7CHYk8sw7e2yoxnJ4U5gJ2Rn9OrK3JXRD67rDtAWPjbWeO7Enq6
   6s5AGGEaHFYkwl2PUQisHimex+63TFallUDB1CL8CGsLrTDcc+1+Dh2Id
   4=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: Z4s7vITO+mHQS9oB+C4ouNemkOqjjehCAngW0yVOcOZq04ygvwCVcGgbPLD8RBhDSvA3F+eemm
 c/h6pxL2oC7X+MHZyYFuZpuaDaZNdFcnSrsAGb3po6+35gDs+IxmknEX0cldpOTM4OC8S2TOQm
 lGxsYqm4bpWcqDHsefCWV8DhMsH1IMssrsxK4sbm2H59uFD8UW5X+pY2kK1bstzhLb8rwllnr9
 ZU7ZHIfpgy0GhZXZOhMeXzdYi482XfAPpmiIJspXPtZhF5JviJRGkhXux9S5+oAjnkiIYS0RrX
 7BA=
X-SBRS: 2.5
X-MesageID: 30128371
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.77,379,1596513600"; 
   d="scan'208";a="30128371"
Date:   Thu, 15 Oct 2020 16:44:01 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
CC:     <linux-kernel@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        SeongJae Park <sjpark@amazon.de>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        "J . Roeleveld" <joost@antarean.org>
Subject: Re: [PATCH 2/2] xen/blkback: turn the cache purge percent into a
 parameter
Message-ID: <20201015144401.GD68032@Air-de-Roger>
References: <20201015142416.70294-1-roger.pau@citrix.com>
 <20201015142416.70294-3-roger.pau@citrix.com>
 <0b7da9e1-6c59-5b8d-52aa-6293568613d1@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b7da9e1-6c59-5b8d-52aa-6293568613d1@suse.com>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 FTLPEX02CL06.citrite.net (10.13.108.179)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 15, 2020 at 04:37:52PM +0200, Jürgen Groß wrote:
> On 15.10.20 16:24, Roger Pau Monne wrote:
> > Assume that reads and writes to the variable will be atomic. The worse
> > that could happen is that one of the purges removes a partially
> > written percentage of grants, but the cache itself will recover.
> > 
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > ---
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Cc: Jens Axboe <axboe@kernel.dk>
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: SeongJae Park <sjpark@amazon.de>
> > Cc: xen-devel@lists.xenproject.org
> > Cc: linux-block@vger.kernel.org
> > Cc: J. Roeleveld <joost@antarean.org>
> > Cc: Jürgen Groß <jgross@suse.com>
> > ---
> >   Documentation/ABI/testing/sysfs-driver-xen-blkback | 9 +++++++++
> >   drivers/block/xen-blkback/blkback.c                | 7 +++++--
> >   2 files changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> > index 776f25d335ca..7de791ad61f9 100644
> > --- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
> > +++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
> > @@ -45,3 +45,12 @@ Description:
> >                   to be executed periodically. This parameter controls the time
> >                   interval between consecutive executions of the purge mechanism
> >                   is set in ms.
> > +
> > +What:           /sys/module/xen_blkback/parameters/lru_percent_clean
> > +Date:           October 2020
> > +KernelVersion:  5.10
> > +Contact:        Roger Pau Monné <roger.pau@citrix.com>
> > +Description:
> > +                When the persistent grants list is full we will remove unused
> > +                grants from the list. The percent number of grants to be
> > +                removed at each LRU execution.
> > diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> > index 6ad9b76fdb2b..772852d45a5a 100644
> > --- a/drivers/block/xen-blkback/blkback.c
> > +++ b/drivers/block/xen-blkback/blkback.c
> > @@ -127,7 +127,10 @@ MODULE_PARM_DESC(lru_internval,
> >    * from the list. The percent number of grants to be removed at each LRU
> >    * execution.
> >    */
> > -#define LRU_PERCENT_CLEAN 5
> > +static unsigned int lru_percent_clean = 5;
> > +module_param_named(lru_percent_clean, lru_percent_clean, uint, 0644);
> > +MODULE_PARM_DESC(lru_percent_clean,
> > +		 "Percentage of persistent grants to remove from the cache when full");
> >   /* Run-time switchable: /sys/module/blkback/parameters/ */
> >   static unsigned int log_stats;
> > @@ -404,7 +407,7 @@ static void purge_persistent_gnt(struct xen_blkif_ring *ring)
> >   	    !ring->blkif->vbd.overflow_max_grants)) {
> >   		num_clean = 0;
> >   	} else {
> > -		num_clean = (max_pgrants / 100) * LRU_PERCENT_CLEAN;
> > +		num_clean = (max_pgrants / 100) * lru_percent_clean;
> 
> Hmm, wouldn't it be better to use (max_grants * lru_percent_clean) / 100
> here in order to support max_grants values less than 100?

Yes, we should have done that when moving max_pgrants to a parameter,
it used to be fixed first.

Will do in next version since I'm already changing the line.

Thanks, Roger.
