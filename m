Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A108C5517A
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 07:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C8421D40
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 07:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8kPM04f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgKLHzq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 02:55:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725884AbgKLHzq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 02:55:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605167745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6bz/KsOzR5wf+7A3G0krlSSNDvuKL7/IXddr5pTa7h0=;
        b=c8kPM04ff2yRpTcJp2A31F6rbGe5o42zwNq/tCVMypnBamq8puMrfTDXPR9Vkx204H5G1V
        n8Yl6wkQ0fYVsyUL9zSwoyhi1ilzKPB8vaY9hq9SQ52ZMsKGASlDOElogV7kK9dPnaFxmg
        +E6nzkulsq16HRBTJRSuyVnq7S3vTDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-jjHKepSSNHeZXwrszJvw7A-1; Thu, 12 Nov 2020 02:55:41 -0500
X-MC-Unique: jjHKepSSNHeZXwrszJvw7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9E168018AB;
        Thu, 12 Nov 2020 07:55:38 +0000 (UTC)
Received: from localhost (ovpn-12-132.pek2.redhat.com [10.72.12.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BEDA2CFBB;
        Thu, 12 Nov 2020 07:55:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Qian Cai <cai@redhat.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/3] blk-mq/nvme-loop: use nvme-loop's lock class for addressing lockdep false positive warning
Date:   Thu, 12 Nov 2020 15:55:23 +0800
Message-Id: <20201112075526.947079-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Qian reported there is hang during booting when shared host tagset is
introduced on megaraid sas. Sumit reported the whole SCSI probe takes
about ~45min in his test.

Turns out it is caused by nr_hw_queues increased, especially commit
b3c6a5997541("block: Fix a lockdep complaint triggered by request queue flushing")
adds synchronize_rcu() for each hctx's release handler.

Address the original lockdep false positive warning by simpler way, then
long scsi probe can be avoided with lockdep enabled.

Ming Lei (3):
  blk-mq: add new API of blk_mq_hctx_set_fq_lock_class
  nvme-loop: use blk_mq_hctx_set_fq_lock_class to set loop's lock class
  Revert "block: Fix a lockdep complaint triggered by request queue
    flushing"

 block/blk-flush.c          | 30 +++++++++++++++++++++++++-----
 block/blk.h                |  1 -
 drivers/nvme/target/loop.c | 10 ++++++++++
 include/linux/blk-mq.h     |  3 +++
 4 files changed, 38 insertions(+), 6 deletions(-)

Cc: Qian Cai <cai@redhat.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>
-- 
2.25.4

