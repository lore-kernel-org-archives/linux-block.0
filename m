Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75E3C1B0D8
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 16:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C10B23A75
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 16:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbgLHQbx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Dec 2020 11:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbgLHQbw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Dec 2020 11:31:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70E6C061749;
        Tue,  8 Dec 2020 08:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=tk49uTd1GaXg7LbiRUxBP5Y/ceJT7HmrtRb4yzgC7VM=; b=s5apwAVNlLEMa6cM1nAlCU9QOr
        HpaUvcHRCo9Um44Ccv3X2MIbD6cV9z4y+nDP5l9XGJW2iGXdCWFr80CZRUN7cQxBruZ9KW78HG4IB
        fDNl/mNyIUPgKdgbtNV5Y90ECQ/Vf4Z+gW3FWXHyFWDM100/vJ8KXYTwAI6Ex5OrsRrvoTPkAYDrH
        fVKs4QmYZAuU0SIa5R34KSCvbF+PnyxhdqZsDMPW6W9EBJ75Old1waC95Vg+16bY0+volWZvYF/Tv
        /gk2WsDrZHTdiuy+gt5XhhdiebNQMSUgR41FC3yTCRmpNzaS+lo7+EEHXcXGBphBtrrMr8ac9gngO
        FMDshcRQ==;
Received: from 089144200046.atnat0009.highway.a1.net ([89.144.200.46] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmfsw-0000wg-4R; Tue, 08 Dec 2020 16:30:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Oleksii Kurochko <olkuroch@cisco.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Mike Snitzer <snitzer@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: split hard read-only vs read-only policy v3
Date:   Tue,  8 Dec 2020 17:28:23 +0100
Message-Id: <20201208162829.2424563-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series resurrects a patch from Martin to properly split the flag
indicating a disk has been set read-only by the hardware vs the userspace
policy set through the BLKROSET ioctl.

Note that the last patch only applies to for-next and not to
for-5.11/block.  I can hold it back for the first NVMe pull request after
Linus pulled the block tree.

A git tree is available here:

    git://git.infradead.org/users/hch/block.git block-hard-ro

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/block-hard-ro

Changes since v3:
 - rebased to the latest block tree
 - indent commit log lines starting with a "#" to make sure git commit
   doesn't eat them

Changes since v2:
 - fix a few typos
 - add a patch to propagate the read-only status from the whole device to
   partitions
 - add a patch to remove a pointless check from bdev_read_only

Changes since v1:
 - don't propagate the policy flag from the whole disk to partitions
 - rebased on top of the merge block_device and hd_struct series
