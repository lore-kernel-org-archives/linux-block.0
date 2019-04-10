Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292A2C10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 15:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1092082E
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554910109;
	bh=FB7/h1IAEQc3iO7rtQhF1LlN40BNju0vP/ioMqhebpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E0Jo/tVV8qMy4PTwph9955HuSt/J0kkKl50MGMw5GXU+xN6QI1g7VgKaNbTc8d0Cz
	 xoNGM1gRxZk6WnDwEeaoZ3U2JjUUZkormR8NtmiZcmqZ5vsj/Vajt+mVvYK9dnj6zA
	 CeyPAR86WjD9l/c+qMjhAB+ZlF4OYFWEE4PdX1lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfDJP22 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:28:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:31251 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfDJP22 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 11:28:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 08:28:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="141657049"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga007.fm.intel.com with ESMTP; 10 Apr 2019 08:28:25 -0700
Date:   Wed, 10 Apr 2019 09:30:06 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        James Smart <james.smart@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V4 0/2] blk-mq/nvme: cancel request synchronously
Message-ID: <20190410153004.GB3714@localhost.localdomain>
References: <20190408223122.29844-1-ming.lei@redhat.com>
 <20190410150436.GA23621@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410150436.GA23621@ming.t460p>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 10, 2019 at 11:04:38PM +0800, Ming Lei wrote:
> On Tue, Apr 09, 2019 at 06:31:20AM +0800, Ming Lei wrote:
> > Hi,
> > 
> > This patchset introduces blk_mq_complete_request_sync() for canceling
> > request synchronously in error handler context, then one race between
> > completing request remotely and destroying contoller/queues can be fixed.
> > 
> > 
> > V4:
> > 	- drop return value
> > 	- don't handle fake timeout
> > 
> > V3:
> > 	- avoid extra cost to blk_mq_complete_request
> > 
> > V2:
> > 	- export via EXPORT_SYMBOL_GPL
> > 	- minor commit log change
> > 
> > Ming Lei (2):
> >   blk-mq: introduce blk_mq_complete_request_sync()
> >   nvme: cancel request synchronously
> > 
> >  block/blk-mq.c           | 7 +++++++
> >  drivers/nvme/host/core.c | 2 +-
> >  include/linux/blk-mq.h   | 1 +
> >  3 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > Cc: Keith Busch <kbusch@kernel.org>
> > Cc: Sagi Grimberg <sagi@grimberg.me>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: James Smart <james.smart@broadcom.com>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: linux-nvme@lists.infradead.org
> > 
> 
> Hi Jens,
> 
> These two patches have been posted for a while, any chance to make them
> in v5.1?

FWIW, series looks good to me too.

Reviewed-by: Keith Busch <keith.busch@intel.com>
