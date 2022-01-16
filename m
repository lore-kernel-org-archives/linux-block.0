Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30983C433EF
	for <linux-block@archiver.kernel.org>; Sun, 16 Jan 2022 04:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234255AbiAPETb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Jan 2022 23:19:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230092AbiAPETa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Jan 2022 23:19:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642306770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aSR7wZ8vFX/nqH53z/KBo89GGQX1uIomEuSwa16CxuE=;
        b=PL/W5yxt7lNNuG6oBdmdjzuhwdez+rKiVWv/d0tt9cTRFTeCjNWxWyJWmfFKAJZAcfcAec
        ZfU+Nada9Q0p5vFyNdoO6tfyeVYlWWSamF4kDvX5zsB28uqEjxk+SHWGplaZU19717hAqQ
        MBuYrKJz671SsZZKYREMDoS9urFt8nU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-468-syI9dbXyNDqCLS0OJD9YeQ-1; Sat, 15 Jan 2022 23:18:59 -0500
X-MC-Unique: syI9dbXyNDqCLS0OJD9YeQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A48682F26;
        Sun, 16 Jan 2022 04:18:57 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0C0A5ED44;
        Sun, 16 Jan 2022 04:18:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] block: don't drain file system I/O on del_gendisk
Date:   Sun, 16 Jan 2022 12:18:12 +0800
Message-Id: <20220116041815.1218170-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Draining FS I/O on del_gendisk() is added for just avoiding to refer to
recently added q->disk in IO path, and it isn't actually needed.

Now we can move killing disk into queue's release handler, see patch 1,
so no need to drain FS I/O on del_gendisk().

Draining FS I/O on del_gendisk() isn't reliable, see the following
cases, so revert this behavior.

1) queue freezing can't drain FS I/O for bio based driver

2) it isn't easy to move elevator/cgroup/throttle shutdown during
del_gendisk, and q->disk can still be referred in these code paths

3) the added flag of GD_DEAD may not be observed reliably in
__bio_queue_enter() because queue freezing might not imply rcu grace
period.


Ming Lei (3):
  block: move freeing disk into queue's release handler
  block: revert aec89dc5d421 block: keep q_usage_counter in atomic mode
    after del_gendisk
  block: revert 8e141f9eb803 block: drain file system I/O on del_gendisk

 block/blk-core.c      | 24 ++++++++++++------------
 block/blk-mq.c        |  9 +--------
 block/blk-sysfs.c     | 13 +++++++++++++
 block/blk.h           |  2 --
 block/genhd.c         | 31 +++++--------------------------
 include/linux/genhd.h |  1 -
 6 files changed, 31 insertions(+), 49 deletions(-)

-- 
2.31.1

