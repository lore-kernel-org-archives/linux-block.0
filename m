Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86A6C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 08:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 962032146D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 08:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962032146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeK3TIl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:08:41 -0500
Received: from verein.lst.de ([213.95.11.211]:48686 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbeK3TIl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 14:08:41 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id CC50C68BDF; Fri, 30 Nov 2018 09:00:13 +0100 (CET)
Date:   Fri, 30 Nov 2018 09:00:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 01/13] block: move queues types to the block layer
Message-ID: <20181130080013.GB18936@lst.de>
References: <20181129191310.9795-1-hch@lst.de> <20181129191310.9795-2-hch@lst.de> <20181129201914.GB9377@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129201914.GB9377@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 29, 2018 at 01:19:14PM -0700, Keith Busch wrote:
> On Thu, Nov 29, 2018 at 08:12:58PM +0100, Christoph Hellwig wrote:
> > +enum hctx_type {
> > +	HCTX_TYPE_DEFAULT,	/* all I/O not otherwise accounted for */
> > +	HCTX_TYPE_READ,		/* just for READ I/O */
> > +	HCTX_TYPE_POLL,		/* polled I/O of any kind */
> > +
> > +	HCTX_MAX_TYPES,
> >  };
> 
> Well, there goes my plan to use this with Weighted-Round-Robin NVMe IO
> queues!

Wo between what do you even want to round robin?  If it is between
reads and writes that's easy.  If we want priority reads or writes
(separate from polling) that's also still fairly easily.

Btw, one thing I wanted to try once I get hold of the right hardware
is to mark the poll queues as priority queues and see if that makes
any differents in poll IOPS/latency.
