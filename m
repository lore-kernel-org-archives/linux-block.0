Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A59EC25B07
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 16:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235582AbiG0QYm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 12:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbiG0QX6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 12:23:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B67F4C62A
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 09:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=04ZILN2NAv+ObiHia7yIz5XMlF76VXCvJOIw1l7pPFo=; b=3D4AN8y/W37AX8H7oypYbUMqvn
        sJQXw26TG8Q4hDJ7FAyotEWYusUCLknH/wiImY9LweLRabWaEpdFAO9wKdNDuefDo2xHC+85nKDKH
        K880QmL55vEGN6URrC1GRh8vrj+06t8HZDh+LMTACKyIIKUk68hKWBDogd/FZupCUvjfVoHz3kInz
        w4JlYgNuwhN0RUmhU4p6J1YnDR+psqcOtV53vFRa3/X6ZR/rvLnKkysVIqyZ0ukL0DaLRUUNqnqvU
        MaL86Yx5RsBkjOTs/6URn0LXibfHjpROUwf2Iw/bFvJUSD5+SECMF6rbY9UCHN78/vutCDuQPYY+W
        boQr58aQ==;
Received: from [2607:fb90:18d2:b6be:6d6f:ba8a:ca81:9775] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oGjoN-00FUaO-BO; Wed, 27 Jul 2022 16:23:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: bio splitting cleanups v4
Date:   Wed, 27 Jul 2022 12:22:54 -0400
Message-Id: <20220727162300.3089193-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series has two parts:  the first part moves the ->bio_split
bio_set to the gendisk as it only is used for file system style I/O.

The other patches reshuffle the bio splitting code so that in the future
blk_bio_segment_split can be used to split REQ_OP_ZONE_APPEND bios
under file system / remapping driver control.  I plan to use that in
btrfs in the next merge window.

Changes since v3:
 - fix a merge error and rebase to the for-5.20/drivers-post branch

Changes since v2:
 - trivial rebase to the for-next tree

Changes since v1:
 - drop a bogus patch
 - fix a comment typo
 - fix a commit log typo
 - clean up the blk_queue_split calling convention and name

