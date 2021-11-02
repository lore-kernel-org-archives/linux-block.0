Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB48C433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 13:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13655610E5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 13:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhKBNiT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 09:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhKBNiT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Nov 2021 09:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635860144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=61NPga9WQaO7ZK1XRVgXs/L0uOvZh+/W60+MLWMzlWA=;
        b=eUISHlv9NxZ1mRCMwWRcZOWwqYQyD0g3SpblIB1hBXgtY56uD0hgaZkBJQHMgc4PpVXcuI
        KxJoN1RArZB8SVdVfh6DU3BpOs2DxJtnCWzg99ANkAOgOm+pju/d+nuaRUpIMMvGCyiWgC
        uqQ6s4sHrqjPvcKqA/dVjZvhd6290A8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-S1lzHxztPAmv6slAuUVdiw-1; Tue, 02 Nov 2021 09:35:40 -0400
X-MC-Unique: S1lzHxztPAmv6slAuUVdiw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB30F1B2C981;
        Tue,  2 Nov 2021 13:35:39 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D28A860D30;
        Tue,  2 Nov 2021 13:35:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] blk-mq: misc fixes
Date:   Tue,  2 Nov 2021 21:34:59 +0800
Message-Id: <20211102133502.3619184-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Here are 3 small fixes against latest linus tree.


Ming Lei (3):
  blk-mq: only try to run plug merge if request has same queue with
    incoming bio
  blk-mq: add RQF_ELV debug entry
  blk-mq: update hctx->nr_active in blk_mq_end_request_batch()

 block/blk-merge.c      |  6 ++++--
 block/blk-mq-debugfs.c |  1 +
 block/blk-mq.c         | 15 +++++++++++++--
 block/blk-mq.h         | 12 +++++++++---
 4 files changed, 27 insertions(+), 7 deletions(-)

-- 
2.31.1

