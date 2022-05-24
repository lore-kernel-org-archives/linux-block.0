Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA20C433F5
	for <linux-block@archiver.kernel.org>; Tue, 24 May 2022 12:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbiEXMBj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 May 2022 08:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiEXMBi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 May 2022 08:01:38 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4593E289B4
        for <linux-block@vger.kernel.org>; Tue, 24 May 2022 05:01:37 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A4E8068AFE; Tue, 24 May 2022 14:01:34 +0200 (CEST)
Date:   Tue, 24 May 2022 14:01:34 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, dan.j.williams@intel.com,
        yukuai3@huawei.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: remove per-disk debugfs files in
 blk_unregister_queue
Message-ID: <20220524120134.GB17563@lst.de>
References: <20220524083325.833981-1-hch@lst.de> <YozFt0qFCvZVt67m@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YozFt0qFCvZVt67m@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 24, 2022 at 07:47:03PM +0800, Ming Lei wrote:
> Not look into details yet, but as one blk-mq debugfs user, I don't like
> the idea, since I often see io hang issue when calling
> blk_mq_freeze_queue_wait(), and blk-mq debugfs is very helpful for
> investigating this kind of issue.
> 
> But now blk-mq debugfs is gone with this patch __before__ draining IO in
> del_gendisk, and it becomes not useful as before.

This is the way hot it is set up, so in doubt I want it to be torn down
synchronously.  There might be a way to move the teardown later, but
that will require a very careful audit.
