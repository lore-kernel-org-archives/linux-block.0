Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606E8C67839
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A22D2084E
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hgZpa6it"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A22D2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeLKXhB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:37:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37324 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeLKXhA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e8XkIZhjpZmySWDuj/AAP4bZaKEJsulR7keB+7yyf4c=; b=hgZpa6itkpemWPmoYJS8DwzWA
        C8SaXlkrf4lemj31DlnUcESmkiP0YMEEeJxCU5T3EpQSBu7nvFh6w6B8HBk34ruQKqgD8x+isKByt
        iWWQ3nCdtgnOrsur+4w8JBa3KkOLdOwNdrNP2grCJch5cYPBH3ddoruhwb56+oHqiQ9Id8fmABLQf
        OzVSaavqhbyJ7rh9h41m+Uky0VPP7NaWvbw/VK3m6oIk4K0Z+Cda/9pE4HlwMsXTXuU3b1y4+bntc
        +n1cJ3JWqR4DQcFywyCPVc5xBW0hQFPM1htCyTCJP1WGb6MVZ5uy12dvO3w1ruCRMyoc4opllBXzC
        SHKgkUXZw==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWraC-0003uQ-Vo; Tue, 11 Dec 2018 23:36:57 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH RFC 0/4] restore polling to nvme-rdma
Date:   Tue, 11 Dec 2018 15:36:47 -0800
Message-Id: <20181211233652.9705-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add an additional queue mapping for polling queues that will
host polling for latency critical I/O.

One caveat is that we don't want these queues to be pure polling
as we don't want to bother with polling for the initial nvmf connect
I/O. Hence, introduce ib_change_cq_ctx that will modify the cq polling
context from SOFTIRQ to DIRECT. Note that this function is not safe
with inflight I/O so the caller must make sure not to call it without
having all I/O quiesced (we also relax the ib_cq_completion_direct warning
as we have a scenario that this can happen).

With that, we simply defer blk_poll callout to ib_process_cq_direct and
we're done. One thing that might worth adding is some kind of ignore
regexp of some sort because we don't want to give up polling because we
consumed memory registration completions. As for now, we might break the
polling early do to that.

Finally, we turn off polling support for nvme-multipath as it won't invoke
polling and our completion queues no longer generates any interrupts for
it. I didn't come up with a good way to get around it so far...

Sagi Grimberg (4):
  nvme-fabrics: allow user to pass in nr_poll_queues
  rdma: introduce ib_change_cq_ctx
  nvme-rdma: implement polling queue map
  nvme-multipath: disable polling for underlying namespace request queue

 drivers/infiniband/core/cq.c | 102 ++++++++++++++++++++++++-----------
 drivers/nvme/host/core.c     |   2 +
 drivers/nvme/host/fabrics.c  |  16 +++++-
 drivers/nvme/host/fabrics.h  |   3 ++
 drivers/nvme/host/rdma.c     |  35 +++++++++++-
 include/rdma/ib_verbs.h      |   1 +
 6 files changed, 124 insertions(+), 35 deletions(-)

-- 
2.17.1

