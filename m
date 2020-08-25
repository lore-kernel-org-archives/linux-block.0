Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F25C433DF
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 12:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A4D2074A
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 12:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbgHYMGF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:06:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:42062 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbgHYMGE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 08:06:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C28D8AC4C;
        Tue, 25 Aug 2020 12:06:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 163BA1E1316; Tue, 25 Aug 2020 14:05:59 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     yebin <yebin10@huawei.com>, Christoph Hellwig <hch@infradead.org>,
        <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH RFC 0/2] Block and buffer invalidation under a filesystem
Date:   Tue, 25 Aug 2020 14:05:52 +0200
Message-Id: <20200825120554.13070-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Recently Ye Bin has reported an ext4 crash which he tracked tracked down to a
problem that several places (block_write_full_page(), fallocate(2) on blkdev,
etc.) can invalidate buffers under a live filesystem - block_invalidatepage()
will clear (among other) BH_Mapped flag and following lookup of the buffer_head
will reinitialize it (init_page_buffers()) which among other things clears
bh->b_private fields which then makes jbd2 crash.

I was thinking how to best fix this. block_write_full_page() is easy to deal
with as the invalidation there is just a relict from the past and we don't need
to invalidate pages there at all (patch 1/2). Other cases are more
questionable. In patch 2/2, I have made fallocate(2) on the block device and
discard ioctls bail with EBUSY if there's filesystem mounted because it seems
very weird and problematic to mess with a block device like that under a
filesystem. What do people think? Is anyone aware of a user that would be
broken by this?

There are also other possibilities of fixing this like making
block_invalidatepage() (or rather new ->invalidatepage callback for the
block device) less aggressive so that it does not discard that much state from
buffer_heads. But details of that are not yet clear to me.

Or other possibilities people see to fix this?

								Honza
