Return-Path: <SRS0=alrN=OK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5E2C04EB9
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 16:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA39020834
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 16:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA39020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbeLBEBB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 23:01:01 -0500
Received: from verein.lst.de ([213.95.11.211]:56715 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbeLBEBB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Dec 2018 23:01:01 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 904466732A; Sat,  1 Dec 2018 17:48:04 +0100 (CET)
Date:   Sat, 1 Dec 2018 17:48:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
Message-ID: <20181201164804.GB19557@lst.de>
References: <20181130202635.11145-1-keith.busch@intel.com> <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 01:36:09PM -0700, Jens Axboe wrote:
> On 11/30/18 1:26 PM, Keith Busch wrote:
> > A driver may wish to iterate every tagged request, not just ones that
> > satisfy blk_mq_request_started(). The intended use is so a driver may
> > terminate entered requests on quiesced queues.
> 
> How about we just move the started check into the handler passed in for
> those that care about it? Much saner to make the interface iterate
> everything, and leave whatever state check to the callback.

So we used to do that, and I changed it back in May to test for
MQ_RQ_IN_FLIGHT, and then Ming changed it to check
blk_mq_request_started.  So this is clearly a minefield of sorts..

Note that at least mtip32xx, nbd, skd and the various nvme transports
want to use the function to terminate all requests in the error
path, and it would be great to have one single understood, documented
and debugged helper for that in the core, so this is a vote for moving
more of the logic in your second helper into the core code.  skd
will need actually use ->complete to release resources for that, though
and mtip plays some odd abort bits.  If it weren't for the interesting
abort behavior in nvme-fc that means we could even unexport the
low-level interface.
