Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AA0C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 16:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FB92080F
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 16:52:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FB92080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeLLQwx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:52:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:33850 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbeLLQwx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 11:52:53 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2018 08:52:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,345,1539673200"; 
   d="scan'208";a="303267016"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 12 Dec 2018 08:52:45 -0800
Date:   Wed, 12 Dec 2018 09:50:17 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme: provide fallback for discard alloc failure
Message-ID: <20181212165017.GB10895@localhost.localdomain>
References: <87d6d992-6d9f-c863-c14c-e4f3555cb3d6@kernel.dk>
 <20181212162855.GA10895@localhost.localdomain>
 <f53d0bc1-6fe0-12e5-c210-e583d71bc739@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53d0bc1-6fe0-12e5-c210-e583d71bc739@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 12, 2018 at 09:36:36AM -0700, Jens Axboe wrote:
> On 12/12/18 9:28 AM, Keith Busch wrote:
> > On Wed, Dec 12, 2018 at 09:18:11AM -0700, Jens Axboe wrote:
> >> When boxes are run near (or to) OOM, we have a problem with the discard
> >> page allocation in nvme. If we fail allocating the special page, we
> >> return busy, and it'll get retried. But since ordering is honored for
> >> dispatch requests, we can keep retrying this same IO and failing. Behind
> >> that IO could be requests that want to free memory, but they never get
> >> the chance.
> >>
> >> Allocate a fixed discard page per controller for a safe fallback, and use
> >> that if the initial allocation fails.
> > 
> > Do we need to allocate this per controller? One page for the whole driver
> > may be sufficient to make forward progress, right?
> 
> It should be, but that might create a shit storm if we're OOM and have
> tons of drives. I think one per controller is saner, and it's dwarfed
> by memory we consume anyway in static allocations.

Okay fair enough.

Reviewed-by: Keith Busch <keith.busch@intel.com>
