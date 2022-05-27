Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73BFC433FE
	for <linux-block@archiver.kernel.org>; Fri, 27 May 2022 07:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiE0HPu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 May 2022 03:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346335AbiE0HPJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 May 2022 03:15:09 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBFB419B7
        for <linux-block@vger.kernel.org>; Fri, 27 May 2022 00:15:08 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E62B468AFE; Fri, 27 May 2022 09:15:03 +0200 (CEST)
Date:   Fri, 27 May 2022 09:15:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: remove per-disk debugfs files in
 blk_unregister_queue
Message-ID: <20220527071503.GA16342@lst.de>
References: <20220524083325.833981-1-hch@lst.de> <YozvXP9/hVhTQt+D@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YozvXP9/hVhTQt+D@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 24, 2022 at 10:44:44PM +0800, Ming Lei wrote:
> The above line code may cause kernel panic in the following code paths:
> 
> 1) blk_mq_debugfs_unregister_hctxs() called from __blk_mq_update_nr_hw_queues()
> 
> 2) blk_mq_debugfs_unregister_sched_hctx() called from blk_mq_exit_sched()

Yes.  Then again we already have the same sort of race window in reverse
at startup time, where nothing synchronizes between 
blk_mq_debugfs_register_hctxs from __blk_mq_update_nr_hw_queues and
add_disk adding debugfs files.

All this probably needs serializing using debugfs_mutex and a check of
QUEUE_FLAG_REGISTERED.
