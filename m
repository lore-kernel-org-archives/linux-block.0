Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF7BC43334
	for <linux-block@archiver.kernel.org>; Wed, 20 Jul 2022 06:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbiGTGHK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jul 2022 02:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237966AbiGTGHJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jul 2022 02:07:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231EA68735
        for <linux-block@vger.kernel.org>; Tue, 19 Jul 2022 23:07:09 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9DCB068BEB; Wed, 20 Jul 2022 08:07:05 +0200 (CEST)
Date:   Wed, 20 Jul 2022 08:07:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] Revert "ublk_drv: fix request queue leak"
Message-ID: <20220720060705.GB6734@lst.de>
References: <20220718062928.335399-1-hch@lst.de> <20220718062928.335399-2-hch@lst.de> <YtalgzqC/q3JpYCR@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtalgzqC/q3JpYCR@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 19, 2022 at 08:37:23PM +0800, Ming Lei wrote:
> This change will break START_DEV/STOP_DEV, which is supposed to run
> multiple cycles after the device is added, especially this way can
> help to implement error recovery from userside, such as one ubq_daemon
> is crashed/hang, the device can be recovered by sending STOP_DEV/START_DEV
> commands again after new ubq_daemon is setup.

What is broken in START_DEV/STOP_DEV?  Please explain the semantics you
want and what doesn't work.  FYI, there is nothing in the test suite the
complains.  And besides the obvious block layer bug that Jens found you
seemed to be perfectly happy with the semantics.

> So here we do need separated request_queue/disk, and the model is
> similar with scsi's, in which disk rebind needs to be supported
> and GD_OWNS_QUEUE can't be set.

SCSI needs it because it needs the request_queue to probe for what ULP
to bind to, and it allows to unbind the ULP.  None of that is the case
here.  And managing the lifetimes separately is a complete mess, so
don't do it.  Especially not in a virtual driver where you don't have
to cater to a long set protocol like SCSI.

> 
> Thanks,
> Ming
---end quoted text---
