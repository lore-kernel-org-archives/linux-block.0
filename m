Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0608FC433DB
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 15:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09672220B
	for <linux-block@archiver.kernel.org>; Wed, 23 Dec 2020 15:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgLWPts (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Dec 2020 10:49:48 -0500
Received: from verein.lst.de ([213.95.11.211]:34843 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbgLWPtr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Dec 2020 10:49:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0B65E67373; Wed, 23 Dec 2020 16:49:05 +0100 (CET)
Date:   Wed, 23 Dec 2020 16:49:04 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [RFC] nvme: set block size during namespace validation
Message-ID: <20201223154904.GA5967@lst.de>
References: <20201223150136.4221-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223150136.4221-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

set_blocksize just sets the block sise used for buffer heads and should
not be called by the driver.  blkdev_get updates the block size, so
you must already have the fd re-reading the partition table open?
I'm not entirely sure how we can work around this except by avoiding
buffer head I/O in the partition reread code.  Note that this affects
all block drivers where the block size could change at runtime.
