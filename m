Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05582C48BE5
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 07:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60B26128A
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 07:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFWHn7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 03:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230001AbhFWHn6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 03:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624434101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yYDv1ve1pPCO/wVpdHIv+/+bdGzxC/0la2+de0MywqU=;
        b=Plxu563rZOrSaBbGlX1wJe/aPl6AB9I8LEluPsQCC5egHTCa3yOBAPyqruWyXlc78OZ0Yw
        znzDXtdX/2q1fotQQ3IiZCzgXN12isGjgphsitjpnrMQhFLN3x/VXMgDTOcU9Bc5t8fDzT
        ptM/FRMBHjTsQXhvT1azU9BvrU+aYyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-OJGCqLoKO3-AR_jo8QcZyg-1; Wed, 23 Jun 2021 03:40:59 -0400
X-MC-Unique: OJGCqLoKO3-AR_jo8QcZyg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A52F100CF71;
        Wed, 23 Jun 2021 07:40:58 +0000 (UTC)
Received: from localhost (ovpn-12-52.pek2.redhat.com [10.72.12.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C58375D6D1;
        Wed, 23 Jun 2021 07:40:46 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/3] block/dm: support bio polling
Date:   Wed, 23 Jun 2021 15:40:29 +0800
Message-Id: <20210623074032.1484665-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Guys,

Based on Christoph's bio based polling model[1], implement DM bio polling
with one very simple approach.

Patch 1 adds helper of blk_queue_poll().

Patch 2 adds .bio_poll() callback to block_device_operations, so bio
driver can implement its own logic for io polling.

Patch 3 implements bio polling for device mapper.


V3:
	- patch style change as suggested by Christoph(2/3)
	- fix kernel panic issue caused by nested dm polling, which is found
	  & figured out by Jeffle Xu (3/3)
	- re-organize setup polling code (3/3)
	- remove RFC

V2:
	- drop patch to add new fields into bio
	- support io polling for dm native bio splitting
	- add comment

Ming Lei (3):
  block: add helper of blk_queue_poll
  block: add ->poll_bio to block_device_operations
  dm: support bio polling

 block/blk-core.c         |  18 +++---
 block/blk-sysfs.c        |   4 +-
 block/genhd.c            |   2 +
 drivers/md/dm-table.c    |  24 +++++++
 drivers/md/dm.c          | 131 ++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/core.c |   2 +-
 include/linux/blkdev.h   |   2 +
 7 files changed, 170 insertions(+), 13 deletions(-)

-- 
2.31.1

