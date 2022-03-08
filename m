Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C71AC433F5
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 07:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbiCHHda (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 02:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240635AbiCHHda (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 02:33:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EE546588
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 23:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646724753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mxVYmrh8lybxZ8WqRcxCenerqjKg/5oTqjtDpXmxK6g=;
        b=gXS9bnZD/0gvTR8OmhxGU2R8pV10YoMLfqnP4ZLXMTurZjk3Yd1fvncx8hFKm8+JQpnbUp
        tgKEqtxyhz13bi/Q16Em1CzCh2eCYKp2Qf1iHrY6jxurZZN1cRiSEcr60HdUbcUagfC3IT
        sj3VLpcKDGUVJohtdz6XFHg4lLLZnaE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447--6uh0KBoOq62u2cC9jCxBg-1; Tue, 08 Mar 2022 02:32:29 -0500
X-MC-Unique: -6uh0KBoOq62u2cC9jCxBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 249E11006AA6;
        Tue,  8 Mar 2022 07:32:28 +0000 (UTC)
Received: from localhost (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2396A72427;
        Tue,  8 Mar 2022 07:32:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 0/6] blk-mq: update_nr_hw_queues related improvement & bugfix
Date:   Tue,  8 Mar 2022 15:32:13 +0800
Message-Id: <20220308073219.91173-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch figures out correct numa node for each kind of hw queue.

The 2nd patch simplifies reallocation of q->queue_hw_ctx a bit.

The 3rd patch re-configures poll capability after queue map is changed.

The 4th patch changes mtip32xx to avoid to refer to q->queue_hw_ctx
directly.

The 5th & 6th patches fix use-after-free on q->queue_hw_ctx.

V4:
	- add reviewed-by tag
	- convert one plain loop into xa_for_each_start(), as suggested by
	Christoph

V3:
	- fix smatch warnings reported by kernel test robot (5/6)

V2:
	- use xa_for_each() to implement queue_for_each_hw_ctx(5/6 6/6)
	- patch style change(1/6)
	- rename as suggested by Christoph(3/6)


Ming Lei (6):
  blk-mq: figure out correct numa node for hw queue
  blk-mq: simplify reallocation of hw ctxs a bit
  blk-mq: reconfigure poll after queue map is changed
  block: mtip32xx: don't touch q->queue_hw_ctx
  blk-mq: prepare for implementing hctx table via xarray
  blk-mq: manage hctx map via xarray

 block/blk-mq-debugfs.c            |   6 +-
 block/blk-mq-sched.c              |   9 +-
 block/blk-mq-sysfs.c              |  16 +--
 block/blk-mq-tag.c                |   4 +-
 block/blk-mq.c                    | 165 ++++++++++++++++--------------
 block/blk-mq.h                    |   2 +-
 drivers/block/mtip32xx/mtip32xx.c |   4 +-
 drivers/block/rnbd/rnbd-clt.c     |   2 +-
 include/linux/blk-mq.h            |   3 +-
 include/linux/blkdev.h            |   2 +-
 10 files changed, 116 insertions(+), 97 deletions(-)

-- 
2.31.1

