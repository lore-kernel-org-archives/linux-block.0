Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20150C433F5
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 12:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18BD60FE3
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 12:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238709AbhJOMTh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Oct 2021 08:19:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42693 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238683AbhJOMTg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Oct 2021 08:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634300250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ONXj7wWtsSoFMMlHkzQ53wDVJMEEb2b2b9Mo1qZtjr0=;
        b=bUBF/ittcGPg5imLqYS2p44hPFCQZvcerLJ5e7X1GXs3mMP5cxuoXeevNgQYzT78Tf8kPW
        9ushxBy29ruQ9aNWMjogbeJiy6iDEHuYl2F7vuPIhtHElTywHJeqoBwEdJbPg39St4Cj4R
        OWgyiCmxfr+Ed/0Hd33Ra53Ah//cS3Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-IXxNsi2yOVaZauwPshqJcA-1; Fri, 15 Oct 2021 08:17:27 -0400
X-MC-Unique: IXxNsi2yOVaZauwPshqJcA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C14911808302;
        Fri, 15 Oct 2021 12:17:25 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D23060583;
        Fri, 15 Oct 2021 12:17:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] zram: fix two races
Date:   Fri, 15 Oct 2021 20:16:49 +0800
Message-Id: <20211015121652.2024287-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Fixes the following two issues reported by Luis Chamberlain by simpler
approach, meantime it is sort of simplification of handling resetting/removing
device vs. open().

- zram leak during unloading module, which is one race between resetting
and removing device

- zram resource leak in case that disksize_store is done after resetting
and before deleting gendisk in zram_remove()


Ming Lei (3):
  zram: replace fsync_bdev with sync_blockdev
  zram: simplify handling reset_store/remove vs. open
  zram: avoid race between zram_remove and disksize_store

 drivers/block/zram/zram_drv.c | 62 ++++++++++++++++-------------------
 drivers/block/zram/zram_drv.h |  4 ---
 2 files changed, 28 insertions(+), 38 deletions(-)

-- 
2.31.1

