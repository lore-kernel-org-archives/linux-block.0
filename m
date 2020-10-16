Return-Path: <SRS0=I4RS=DX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA1DC433E7
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 14:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24AC020874
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 14:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T52IIiM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408815AbgJPO2f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Oct 2020 10:28:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22644 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408814AbgJPO2f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Oct 2020 10:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602858514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3TIf5iCrDa1crF7arOWYxShLok0bW/SJkG7vvFcFY0k=;
        b=T52IIiM+W7MvRLDitGEb/n6xIaI57mEv6eVE2GhISJDxsdXpr9/WgtNc08+SVGUSPV7FoD
        D4pqGzcz6Mc2qFF2jwZF+2T2elSM5561yxQ6FHh+rKfYeamttFjq2ccSnTDnaUiE9XhAQd
        M8m+nO8JD/Fj5kCGMjlo2zLqQt8qk5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-GqhWd3abMpCw8nx2SKehaA-1; Fri, 16 Oct 2020 10:28:30 -0400
X-MC-Unique: GqhWd3abMpCw8nx2SKehaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C98E57083;
        Fri, 16 Oct 2020 14:28:28 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97C481974D;
        Fri, 16 Oct 2020 14:28:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Chao Leng <lengchao@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH 0/4] blk-mq/nvme-tcp: fix timed out related races 
Date:   Fri, 16 Oct 2020 22:28:07 +0800
Message-Id: <20201016142811.1262214-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st 2 patches fixes request completion related races.

The 2nd 3 patches fixes/improves nvme-tcp error recovery.

With the 4 patches, nvme/012 can pass on nvme-tcp in Zhang Yi's test
machine.


Ming Lei (4):
  blk-mq: check rq->state explicitly in
    blk_mq_tagset_count_completed_rqs
  blk-mq: think request as completed if it isn't IN_FLIGHT.
  nvme: tcp: fix race between timeout and normal completion
  nvme: tcp: complete non-IO requests atomically

 block/blk-flush.c       |  2 ++
 block/blk-mq-tag.c      |  2 +-
 drivers/nvme/host/tcp.c | 76 +++++++++++++++++++++++++++++------------
 include/linux/blk-mq.h  |  8 ++++-
 4 files changed, 65 insertions(+), 23 deletions(-)

CC: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Yi Zhang <yi.zhang@redhat.com>


-- 
2.25.2

