Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4418DC433C1
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 07:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09ED461879
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 07:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCVHS2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Mar 2021 03:18:28 -0400
Received: from verein.lst.de ([213.95.11.211]:53831 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhCVHSE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Mar 2021 03:18:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0C2A368BEB; Mon, 22 Mar 2021 08:18:02 +0100 (CET)
Date:   Mon, 22 Mar 2021 08:18:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     syzbot <syzbot+8fede7e30c7cee0de139@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, hch@lst.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
Subject: Re: [syzbot] KASAN: use-after-free Read in disk_part_iter_next (2)
Message-ID: <20210322071801.GE3440@lst.de>
References: <00000000000053da9405bd7d2644@google.com> <000000000000a17fb305be0b3f38@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000a17fb305be0b3f38@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I've been running the reproducer on a KASAN enable VM for about
15 minutes now, but haven't been able to reproduce it.

Is there a way to inject this proposed fix into the syzbot queue?

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 1a7558917c47d6..f5d5872b89d57e 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -288,15 +288,12 @@ struct device_type part_type = {
 void delete_partition(struct block_device *part)
 {
 	xa_erase(&part->bd_disk->part_tbl, part->bd_partno);
-	kobject_put(part->bd_holder_dir);
-	device_del(&part->bd_device);
-
-	/*
-	 * Remove the block device from the inode hash, so that it cannot be
-	 * looked up any more even when openers still hold references.
-	 */
 	remove_inode_hash(part->bd_inode);
 
+	synchronize_rcu();
+
+	kobject_put(part->bd_holder_dir);
+	device_del(&part->bd_device);
 	put_device(&part->bd_device);
 }
 
