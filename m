Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731CBC433FE
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 07:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiJJHln (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 03:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiJJHkf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 03:40:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A09517A97
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 00:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/tmNS9s+uMFFjxjxTXeXkzuIbAHu+8UfxrIUsUqzd/o=; b=BNH4++6mvzCFCSvJbtsaEP66Vj
        wYlKpHXROqhMp+e3+LKfcqOPpRPHvznaAt4Q8WKGEFF5iKdvsWKu3fXyQIo4zuWiA3cnsFTCzqUWg
        DQKKA+ULBv/87fgoixJkGAam4G4fFpsBo1QujrEOPz2Nl8sB+SNenoCTWFDd3EYFAPGFyh+cgPQIU
        9W0Yp2wTJTElYDSsPL9P2e6VKjC4B9GbubBBfaeMJnjYQuUnPbUGiKC4xFuvHkH008B0XsLOGv423
        b4HAQY7wqi/t3iyO9q5kk84UQwxOGYxEHECG8DGVHM3ZYGo3JzgVP2QmGVxkc6iocfj37P9aV4qFn
        5lFJJoDQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohnKs-00HOeN-Hc; Mon, 10 Oct 2022 07:36:26 +0000
Date:   Mon, 10 Oct 2022 00:36:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCHv2] block: fix leaking minors of hidden disks
Message-ID: <Y0PLerK6pBp9UC2G@infradead.org>
References: <20221007193825.4058951-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007193825.4058951-1-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 07, 2022 at 12:38:25PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The major/minor of a hidden gendisk is not propagated to the block
> device. This is required to suppress it from being visible. For these
> disks, we need to handle freeing the dynamic minor directly when it's
> released since bdev_free_inode() won't be able to.

This now leads to a different lifetime.  I think the proper fix is
the one below (untested):

diff --git a/block/genhd.c b/block/genhd.c
index d36fabf0abc1f..1752ce356484e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -507,6 +507,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 		 */
 		dev_set_uevent_suppress(ddev, 0);
 		disk_uevent(disk, KOBJ_ADD);
+	} else {
+		disk->part0->bd_dev = ddev->devt;
 	}
 
 	disk_update_readahead(disk);
