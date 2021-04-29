Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B13C433ED
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 07:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CABB6143E
	for <linux-block@archiver.kernel.org>; Thu, 29 Apr 2021 07:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhD2Hc5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Apr 2021 03:32:57 -0400
Received: from verein.lst.de ([213.95.11.211]:52107 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhD2Hcy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Apr 2021 03:32:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4823967373; Thu, 29 Apr 2021 09:32:06 +0200 (CEST)
Date:   Thu, 29 Apr 2021 09:32:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Subject: Can we make the io_poll queue attibute read-only
Message-ID: <20210429073206.GA3925@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

while looking at the polling code I wonder if we have to keep supporting
the change of the io_poll attribute and thus the poll flag on a live
queue.  The support to change this goes back to before supporting the
explicit poll queues, and was used as the prime interface to enable
polling.  Now that we use explicit poll queues the driver specific
paramters to set them up work as the prime interface to enable polling.
They can still be changed at runtime, although much more invasively
(i.e. controller reset in nvme).  The upside is that we don't need
to bother with draining the bios and two queue flags, and don't have
a confusing duplicated user interface.
