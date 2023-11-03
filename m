Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D00C4332F
	for <linux-block@archiver.kernel.org>; Fri,  3 Nov 2023 08:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbjKCINC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Nov 2023 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbjKCINB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Nov 2023 04:13:01 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02087D5C;
        Fri,  3 Nov 2023 01:12:55 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A6DFB67373; Fri,  3 Nov 2023 09:12:51 +0100 (CET)
Date:   Fri, 3 Nov 2023 09:12:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Li Lingfeng <lilingfeng@huaweicloud.com>
Cc:     josef@toxicpanda.com, linux-kernel@vger.kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, nbd@other.debian.org, axboe@kernel.dk,
        chaitanya.kulkarni@wdc.com, yukuai1@huaweicloud.com,
        houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        lilingfeng3@huawei.com
Subject: Re: [PATCH] nbd: fix uaf in nbd_open
Message-ID: <20231103081251.GB16854@lst.de>
References: <20231103101334.1750094-1-lilingfeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103101334.1750094-1-lilingfeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 03, 2023 at 06:13:34PM +0800, Li Lingfeng wrote:
> From: Li Lingfeng <lilingfeng3@huawei.com>
> 
> Commit 4af5f2e03013 ("nbd: use blk_mq_alloc_disk and
> blk_cleanup_disk") cleans up disk by blk_cleanup_disk() and it won't set
> disk->private_data as NULL as before. UAF may be triggered in nbd_open()
> if someone tries to open nbd device right after nbd_put() since refcount
> of nbd device is zero and private_data is not NULL.

I don't think this is the right fix.  nbd needs to move to ->free_disk
to free it's private data.
