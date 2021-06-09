Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DB6C4743D
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 00:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D50613C0
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 00:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhFIAsG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 20:48:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234193AbhFIAsF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jun 2021 20:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623199571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aCZtxBzxP5Q5oeWpoY5L15gMpYNfroOL+o4JJ3VnJnE=;
        b=LyTV1XgF94qaH1wwL+BuTEGUOf9XMrB6xVBzkXIQaMgOhRYuLmxEU0J9Yw3Rk2PzIeaq/x
        6lJuk7U9qy4F/x+K2SVeewn82xFp8IIi13k/LrPnjRe7D/i+TZkFY5RQmFomUoqpq4OV7r
        0rKmLaO/w64A6zvvpoKbYj48P/mLKl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-nrdJlZ0SPb-AvMROcO44fA-1; Tue, 08 Jun 2021 20:46:10 -0400
X-MC-Unique: nrdJlZ0SPb-AvMROcO44fA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E41A98049CD;
        Wed,  9 Jun 2021 00:46:08 +0000 (UTC)
Received: from localhost (ovpn-12-143.pek2.redhat.com [10.72.12.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 347E919C45;
        Wed,  9 Jun 2021 00:46:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Wang Shanker <shankerwangmiao@gmail.com>
Subject: [PATCH 0/2] block: discard merge fix & improvement
Date:   Wed,  9 Jun 2021 08:45:54 +0800
Message-Id: <20210609004556.46928-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Guys,

The 1st patch fixes request merge for single-range discard request.

The 2nd one improves request merge for multi-range discard request,
so that any continuous bios can be merged to one range.


Ming Lei (2):
  block: fix discard request merge
  block: support bio merge for multi-range discard

 block/blk-merge.c          | 20 +++++++++------
 drivers/block/virtio_blk.c |  9 ++++---
 drivers/nvme/host/core.c   |  8 +++---
 include/linux/blkdev.h     | 51 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 16 deletions(-)

Cc: Wang Shanker <shankerwangmiao@gmail.com>
-- 
2.31.1

