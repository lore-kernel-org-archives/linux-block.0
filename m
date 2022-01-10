Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CB1C433EF
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 07:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241778AbiAJHyZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 02:54:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243179AbiAJHw2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 02:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641801145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=I2cRPMJbr/pSdoEnNVQKuE/evurCyOss9pSsaSb7Tno=;
        b=QV5EGhh1FDeVqgtlEGywsasmSP8svtJYNDjoD0MEWa4D3vZRQD0ShOcZjHbLt4q2g1sGi3
        2R9XfUov2LAvLcm4p8Iq9MTwXFldLnwmrbONxei7NCStr5K/Mdzo7yf9TlS/R4k13Aczjv
        2SoaU5TWpEm1i3yI7pG+VzUA3k0uOHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-8-eFlEofPZisYnisifqOIA-1; Mon, 10 Jan 2022 02:52:24 -0500
X-MC-Unique: 8-eFlEofPZisYnisifqOIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 684F83E743;
        Mon, 10 Jan 2022 07:52:22 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51C3B7B9D7;
        Mon, 10 Jan 2022 07:51:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>, lining <lining2020x@163.com>,
        Tejun Heo <tj@kernel.org>, Chunguang Xu <brookxu@tencent.com>
Subject: [PATCH 0/2] block/dm: add resubmit_bio_noacct for fixing iops throttling
Date:   Mon, 10 Jan 2022 15:51:39 +0800
Message-Id: <20220110075141.389532-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Guys,

Commit 4f1e9630afe6 ("blk-throtl: optimize IOPS throttle for large IO scenarios")
only fixes iops throttle for blk-mq drivers. This patchset adds API of resubmit_bio_noacct
so that we can use it for fixing the same issue on bio based drivers.

Meantime fix the issue on device mapper via the added API, and the issue
is reported by lining.

Ming Lei (2):
  block: add resubmit_bio_noacct()
  dm: use resubmit_bio_noacct to submit split bio

 block/blk-core.c       | 12 ++++++++++++
 block/blk-merge.c      |  4 +---
 drivers/md/dm.c        |  2 +-
 include/linux/blkdev.h |  1 +
 4 files changed, 15 insertions(+), 4 deletions(-)

Cc: lining <lining2020x@163.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Chunguang Xu <brookxu@tencent.com>
-- 
2.31.1

