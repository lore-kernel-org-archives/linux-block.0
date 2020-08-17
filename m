Return-Path: <SRS0=fuqo=B3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22445C433E1
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 09:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA3B20738
	for <linux-block@archiver.kernel.org>; Mon, 17 Aug 2020 09:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVdykIly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgHQJxG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:53:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43770 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726575AbgHQJxF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 05:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597657984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oh43CEo0ofGGR7FxCKF9mVraJ2WCgZRDWSz4ITdiYj4=;
        b=TVdykIlyP9ZpS3/irGDJmEz/p9jghRifLQj7SbLeGunIA5yvrOkOy0F3zHbuuJC54Lvzt5
        T+FNbR6kLwPfUW/8Bt0FAen5Ps9bu+/lXOXZPWBpb2YuYpPZKerXg0sC9/qqU5A4Gqe/Uf
        U+pu16Jn4IvQ2VX12txHuq+zIMutS6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-dWmsT77cPrmSTxAZKvEKLA-1; Mon, 17 Aug 2020 05:53:00 -0400
X-MC-Unique: dWmsT77cPrmSTxAZKvEKLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8702D81F00F;
        Mon, 17 Aug 2020 09:52:59 +0000 (UTC)
Received: from localhost (ovpn-13-146.pek2.redhat.com [10.72.13.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D92E7A21D;
        Mon, 17 Aug 2020 09:52:49 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Changpeng Liu <changpeng.liu@intel.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH V3 0/3] block: fix discard merge for single max discard segment
Date:   Mon, 17 Aug 2020 17:52:38 +0800
Message-Id: <20200817095241.2494763-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

The 1st patch checks max discard segment limit in request merge code,
and one discard request failure is fixed for virtio_blk.

The 2nd patch fixes handling of single max discard segment for virtio_blk,
and potential memory corruption is fixed.

The 3rd patch renames the confusing blk_discard_mergable().

The biggest problem is that virtio_blk handles discard request in
multi-range style, however it(at least qemu) may claim that multi range
discard isn't supported by returning 1 for max discard segment.

V3:
	- one patch style change in patch 1, as suggested by Christoph
	- add reviewed-by tag

V2:
	- add comment
	- warn on mismatched bios and discard segment number
	- rename blk_discard_mergable


Ming Lei (3):
  block: respect queue limit of max discard segment
  block: virtio_blk: fix handling single range discard request
  block: rename blk_discard_mergable as blk_discard_support_multi_range

 block/blk-merge.c          | 22 ++++++++++++++++------
 drivers/block/virtio_blk.c | 31 +++++++++++++++++++++++--------
 2 files changed, 39 insertions(+), 14 deletions(-)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Changpeng Liu <changpeng.liu@intel.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
-- 
2.25.2

