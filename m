Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FA2C64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 14:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D9920868
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 14:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D9920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeLAB5e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 20:57:34 -0500
Received: from mga12.intel.com ([192.55.52.136]:16353 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbeLAB5d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 20:57:33 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Nov 2018 06:48:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,298,1539673200"; 
   d="scan'208";a="96316903"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 30 Nov 2018 06:47:59 -0800
Date:   Fri, 30 Nov 2018 07:45:06 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 07/13] nvme-pci: don't poll from irq context when
 deleting queues
Message-ID: <20181130144506.GI9377@localhost.localdomain>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-8-hch@lst.de>
 <20181129203632.GE9377@localhost.localdomain>
 <20181130080809.GC18936@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130080809.GC18936@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 12:08:09AM -0800, Christoph Hellwig wrote:
> On Thu, Nov 29, 2018 at 01:36:32PM -0700, Keith Busch wrote:
> > On Thu, Nov 29, 2018 at 08:13:04PM +0100, Christoph Hellwig wrote:
> > > +
> > > +		/* handle any remaining CQEs */
> > > +		if (opcode == nvme_admin_delete_cq &&
> > > +		    !test_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags))
> > > +			nvme_poll_irqdisable(nvmeq, -1);
> > 
> > We're dispatchig lots of queue deletions in parallel, and they may
> > complete in any order. I don't see how you can guarantee that the
> > wait_for_completion() will return for the nvmeq that you're polling.
> 
> True.  I thought about moving the completion to the queue so that
> we have one completion per queue, and I should have done that after
> all.  Note sure how I got the idea that not doing it is fine.

You may also move the completion polling in its own loop outside the
deletion loop.
