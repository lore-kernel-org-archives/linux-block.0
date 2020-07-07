Return-Path: <SRS0=CAbX=AS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322D9C433E0
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 17:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFA1206E2
	for <linux-block@archiver.kernel.org>; Tue,  7 Jul 2020 17:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgGGRxS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:53:18 -0400
Received: from verein.lst.de ([213.95.11.211]:60122 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728265AbgGGRxS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 7 Jul 2020 13:53:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 14EE668C7B; Tue,  7 Jul 2020 19:53:14 +0200 (CEST)
Date:   Tue, 7 Jul 2020 19:53:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: loop: delete partitions after clearing &
 changing fd
Message-ID: <20200707175312.GB3730@lst.de>
References: <20200707084552.3294693-1-ming.lei@redhat.com> <20200707084552.3294693-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707084552.3294693-3-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 07, 2020 at 04:45:52PM +0800, Ming Lei wrote:
> After clearing fd or changing fd, we have to delete old partitions,
> otherwise they may become ghost partitions.
> 
> Fix this issue by clearing GENHD_FL_NO_PART_SCAN during calling
> bdev_disk_changed() which won't drop old partitions if GENHD_FL_NO_PART_SCAN
> isn't set.

I don't think messing with GENHD_FL_NO_PART_SCAN is a good idea, as
that will also cause an actual partition scan.  But except for historic
reasons I can't think of a good idea to even check for
GENHD_FL_NO_PART_SCAN in blk_drop_partitions.
