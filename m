Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A780CC43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 16:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6C1214DA
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 16:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aZ8R/9kc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6C1214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbeKVC7D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 21:59:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34366 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730172AbeKVC7C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 21:59:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gHOeHmLnAyC+nec4WqlaaI7BZEmMOnuPalE17SMCv7A=; b=aZ8R/9kcl3rZQwTnrEi2LEsgz
        3lUUkzoRI8F8fr4oDPjwfibITpGvDM3Cg4+xsMqn9o1eJdpznS4jRrycY/YXj5EbMrrXgNutmE1aY
        KIXfalX1FnWADiZP+Kl5571EF/Be7RG0tcd3gqq/2VDJazXoNpVnyfni/hw56tHEMeXQbycCdqzD5
        GCS7vXUKSp29GRqzEvSLXTLcZBPhd5vrWRcup4TECZjEVhetYcsnq4uf6v+0gF7JF8DT6yz5D7G55
        bLzthePh9o5qxeJfCm9BT/7mVjsHzM0TCaqu2WtDtRqBd+BBRpytLt4qMoj81Ps6Imj9B4Sonc5E+
        ZNWve6oeA==;
Received: from 089144201193.atnat0010.highway.a1.net ([89.144.201.193] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPVI5-0002lh-GD; Wed, 21 Nov 2018 16:23:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@fb.com>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: block and nvme polling improvements
Date:   Wed, 21 Nov 2018 17:23:34 +0100
Message-Id: <20181121162347.17430-1-hch@lst.de>
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

    git://git.infradead.org/users/hch/misc.git nvme-polling

Gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-polling
