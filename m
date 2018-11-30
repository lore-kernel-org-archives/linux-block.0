Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FA6C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 14:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DCB20863
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 14:43:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DCB20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbeLABwq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:52:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:11407 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbeLABwq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 20:52:46 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 06:43:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,298,1539673200"; 
   d="scan'208";a="108580214"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Nov 2018 06:43:14 -0800
Date:   Fri, 30 Nov 2018 07:40:20 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 01/13] block: move queues types to the block layer
Message-ID: <20181130144020.GH9377@localhost.localdomain>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-2-hch@lst.de>
 <20181129201914.GB9377@localhost.localdomain>
 <20181130080013.GB18936@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130080013.GB18936@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 12:00:13AM -0800, Christoph Hellwig wrote:
> On Thu, Nov 29, 2018 at 01:19:14PM -0700, Keith Busch wrote:
> > On Thu, Nov 29, 2018 at 08:12:58PM +0100, Christoph Hellwig wrote:
> > > +enum hctx_type {
> > > +	HCTX_TYPE_DEFAULT,	/* all I/O not otherwise accounted for */
> > > +	HCTX_TYPE_READ,		/* just for READ I/O */
> > > +	HCTX_TYPE_POLL,		/* polled I/O of any kind */
> > > +
> > > +	HCTX_MAX_TYPES,
> > >  };
> > 
> > Well, there goes my plan to use this with Weighted-Round-Robin NVMe IO
> > queues!
> 
> Wo between what do you even want to round robin?  If it is between
> reads and writes that's easy.  If we want priority reads or writes
> (separate from polling) that's also still fairly easily.

I was considering the IOPRIO_PRIO_CLASS. There are four of them, which
may roughly correspond to the four NVMe IO queues weights. Maybe even
through HIPRI flagged IOs with the RT class.

 
> Btw, one thing I wanted to try once I get hold of the right hardware
> is to mark the poll queues as priority queues and see if that makes
> any differents in poll IOPS/latency.

I doubt it will make much difference in IOPS, but should improve latency
on hipri IOs at the expense of normal IO since hipri will be fetched
ahead during command arbitrarion.
