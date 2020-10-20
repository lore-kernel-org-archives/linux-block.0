Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A56EC433DF
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18AB5222C8
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkLwBFxE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389661AbgJTIxW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 04:53:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46203 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389645AbgJTIxW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 04:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603184001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JtagE/ajhgoE7H7x1jlumd9vteeleoMmxBS5P2L1fQ4=;
        b=WkLwBFxEI2uyKR9hrQ9hcgvFYKwOKn7wAt9DjudzBlPeADj6QUM9+KQMA+0g1CLhXpR7aq
        xuXNMCRDll25xzA6TVd0gEp8zTJym6y8A4zrKica4XFPJJdTjQDc8FYWwb3UkijbJAdKF6
        VtGaaITfKtPaeS1aWroUnbt2HuXHDJM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-NoLH95oiMdugDmvEo9pvgQ-1; Tue, 20 Oct 2020 04:53:17 -0400
X-MC-Unique: NoLH95oiMdugDmvEo9pvgQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4FB887507B;
        Tue, 20 Oct 2020 08:53:15 +0000 (UTC)
Received: from localhost (ovpn-12-164.pek2.redhat.com [10.72.12.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2AD1D10016DA;
        Tue, 20 Oct 2020 08:53:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Chao Leng <lengchao@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH V2 0/4] blk-mq/nvme-tcp: fix timed out related races 
Date:   Tue, 20 Oct 2020 16:52:57 +0800
Message-Id: <20201020085301.1553959-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st 2 patches fixes request completion related races.

The 2nd 3 patches fixes/improves nvme-tcp error recovery.

With the 4 patches, nvme/012 can pass on nvme-tcp in Zhang Yi's test
machine.

V2:
	- re-order patch3 and patch4
	- fix comment
	- improve patch "nvme: tcp: fix race between timeout and normal completion"


Ming Lei (4):
  blk-mq: check rq->state explicitly in
    blk_mq_tagset_count_completed_rqs
  blk-mq: fix blk_mq_request_completed
  nvme: tcp: complete non-IO requests atomically
  nvme: tcp: fix race between timeout and normal completion

 block/blk-flush.c       |  2 +
 block/blk-mq-tag.c      |  2 +-
 drivers/nvme/host/tcp.c | 98 ++++++++++++++++++++++++++++++++---------
 include/linux/blk-mq.h  |  8 +++-
 4 files changed, 86 insertions(+), 24 deletions(-)

CC: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Yi Zhang <yi.zhang@redhat.com>
-- 
2.25.2

