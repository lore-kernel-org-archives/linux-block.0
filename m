Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B3DC48BE5
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 13:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6993561356
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 13:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhFPNIU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 09:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232389AbhFPNIU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 09:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623848773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=b4vcydcnli/8OHwgEzilNoIijtvBdKQo9NYziSQJjW8=;
        b=QEow1AqG0zC7k4p/izWb1agfBSHmnYARoK1P2BS7TDhMWqcTDNuwjXUAKmyFgZNbBcJGdJ
        4t/lTVNGmhy4efRqZI4w6uTZULQarZuTqViDBgMe9aRMLbHnA9iG2V1nNbnWET0KJgsidV
        3jmdO74M3+LDi99/weFrJD2/9BBYHMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-gD1ekMtHON6rZHmOnUA_GQ-1; Wed, 16 Jun 2021 09:06:09 -0400
X-MC-Unique: gD1ekMtHON6rZHmOnUA_GQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AA48100C663;
        Wed, 16 Jun 2021 13:06:08 +0000 (UTC)
Received: from localhost (ovpn-12-48.pek2.redhat.com [10.72.12.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 806846060F;
        Wed, 16 Jun 2021 13:05:49 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 0/4] block/dm: support bio polling
Date:   Wed, 16 Jun 2021 21:05:29 +0800
Message-Id: <20210616130533.754248-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Guys,

Based on Christoph's bio based polling model[1], implement DM bio polling
with one very simple approach.

Patch 1 adds helper of blk_queue_poll().

Patch 2 reuses .bi_next to bio driver for storing driver data.

Patch 3 adds .bio_poll() callback to block_device_operations, so bio
driver can implement its own logic for io polling.

Patch 4 implements bio polling for device mapper.

Any comments are welcome.

[1] switch block layer polling to a bio based model v4
https://lore.kernel.org/linux-block/20210615160619.GA32435@lst.de/T/#t


Ming Lei (4):
  block: add helper of blk_queue_poll
  block: add field of .bi_bio_drv_data to bio
  block: add ->poll_bio to block_device_operations
  dm: support bio polling

 block/blk-core.c          | 21 +++++++++-----
 block/blk-sysfs.c         |  4 +--
 block/genhd.c             |  3 ++
 drivers/md/dm-table.c     | 24 ++++++++++++++++
 drivers/md/dm.c           | 59 ++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/core.c  |  2 +-
 include/linux/blk_types.h | 11 +++++++-
 include/linux/blkdev.h    |  3 ++
 8 files changed, 112 insertions(+), 15 deletions(-)

-- 
2.31.1

