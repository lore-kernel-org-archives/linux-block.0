Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E462C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0360121104
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hfQE1ESM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0360121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeK3GUA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:20:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54766 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbeK3GT6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 01:19:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2UoY7IFuPzVNO+JYZCGkiEciJN/QA2DkCGR2/Znm2g8=; b=hfQE1ESMdogtH1qk17ubQlBVK
        ycGyCTQZwUqGeVQhb4vl9pfUZn+g+mPoAp6s9vt4+/6oEXbkTfllk9toNIkKE94XVhqrknLbjR2Go
        Oqc8IVDSLrDOjjY+7e9/lgfr24+woFUmu3agWgJHqjby747B61a6ZNxxpXi3uuPfLuoAzgnLPD70i
        BMPnT1pUxaCqP61oHsqT/naW4FSh1FBEeKI2yq7E0Smj5fspqO9+wljw9BOFjZpKkuQDEmyX85h0p
        8jLwls8wM7IPMwyHSpSrFBRg2NLTijOsn5AyG6o/6mTuru+F3MM/NvXM+JEBqf73sx/BQibBi7+FD
        3JTQnpKWw==;
Received: from 213-225-33-236.nat.highway.a1.net ([213.225.33.236] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSRkV-0003eG-96; Thu, 29 Nov 2018 19:13:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: block and nvme polling improvements V2
Date:   Thu, 29 Nov 2018 20:12:57 +0100
Message-Id: <20181129191310.9795-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series optimizes a few bits in the block layer and nvme code
related to polling.

It starts by moving the queue types recently introduce entirely into
the block layer instead of requiring an indirect call for them.

It then switches nvme and the block layer to only allow polling
with separate poll queues, which allows us to realize the following
benefits:

 - poll queues can safely avoid disabling irqs on any locks
   (we already do that in NVMe, but it isn't 100% kosher as-is)
 - regular interrupt driven queues can drop the CQ lock entirely,
   as we won't race for completing CQs

Then we drop the NVMe RDMA code, as it doesn't follow the new mode,
and remove the nvme multipath polling code including the block hooks
for it, which didn't make much sense to start with given that we
started bypassing the multipath code for single controller subsystems
early on.  Last but not least we enable polling in the block layer
by default if the underlying driver has poll queues, as that already
requires explicit user action.

Note that it would be really nice to have polling back for RDMA with
dedicated poll queues, but that might take a while.  Also based on
Jens' polling aio patches we could now implement a model in nvmet
where we have a thread polling both the backend nvme device and
the RDMA CQs, which might give us some pretty nice performace
(I know Sagi looked into something similar a while ago).

A git tree is also available at:

    git://git.infradead.org/users/hch/block.git nvme-polling

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-polling

Changes since v2:
 - rebased to the latest block for-4.21 tree
