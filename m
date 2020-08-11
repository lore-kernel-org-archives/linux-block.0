Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C05C433DF
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 09:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB8D20772
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 09:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYgCWHlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgHKJV4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:21:56 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37222 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728391AbgHKJVz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 05:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597137714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HBXcA2/1WmstpEc0cfyfDp7XFyXTxGIWHnUm87bJiQI=;
        b=JYgCWHlxIHj9w6trv43zV3Ew9CwWOJIhU5rl88J7Cr7sLTy4MoI2YYj614YO0O/vxdy/th
        J27uqy8ZbE5i5FNXUhySiv8I2xB4+HC6kz18MORlQpdGbBNywcJSQz9MkWbZNznV6QoJzD
        Z+WWCvxe6MIM+M0Mgv3KaJYGuokpGMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-mQ7yXy3RNUyemrCLUrgjPQ-1; Tue, 11 Aug 2020 05:21:52 -0400
X-MC-Unique: mQ7yXy3RNUyemrCLUrgjPQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61B19100960F;
        Tue, 11 Aug 2020 09:21:51 +0000 (UTC)
Received: from localhost (ovpn-13-156.pek2.redhat.com [10.72.13.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0A5C5F1EA;
        Tue, 11 Aug 2020 09:21:41 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Changpeng Liu <changpeng.liu@intel.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 0/2] block: fix discard merge for single max discard segment
Date:   Tue, 11 Aug 2020 17:21:32 +0800
Message-Id: <20200811092134.2256095-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st patch checks max discard segment limit in request merge code,
and one discard request failure issue is fixed for virtio_blk.

The 2nd patch fixes handling of single max discard segment for
virtio_blk, and potential memory corruption is fixed.


Ming Lei (2):
  block: respect queue limit of max discard segment
  block: virtio_blk: fix handling single range discard request

 block/blk-merge.c          | 10 ++++++++--
 drivers/block/virtio_blk.c | 23 +++++++++++++++--------
 2 files changed, 23 insertions(+), 10 deletions(-)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Changpeng Liu <changpeng.liu@intel.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>

-- 
2.25.2

