Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E016C433EF
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 01:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD326112D
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 01:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbhJTB6X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 21:58:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53803 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229728AbhJTB6W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 21:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634694968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Pu3sG/FV/XHFlGlb+MD+S4jwVz+kZ2wYlCEsgwkjXbQ=;
        b=Z9DqXRtuxD5x/iSsPnG1H8+IeG24pSbW8B8bZS6zi/2iXrnquvHGAX4+XkcxgPrVOzT35v
        mnbnk4p1aDLPFBV+fRMFbwvFahDHeGZHMWHsPt4Z7WMSEK2c5533q8Ryx2mKE9eFw7XXOe
        nhSXZ53iu2gB0RfnTHxkfIz+MV9Z02s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-WqG2NJePMpKM_zr1m551xw-1; Tue, 19 Oct 2021 21:56:03 -0400
X-MC-Unique: WqG2NJePMpKM_zr1m551xw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C4C2800685;
        Wed, 20 Oct 2021 01:56:02 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8E3D5C3E0;
        Wed, 20 Oct 2021 01:55:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/4] zram: fix two races and one zram leak
Date:   Wed, 20 Oct 2021 09:55:44 +0800
Message-Id: <20211020015548.2374568-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

Fixes three issues reported by Luis Chamberlain with one simpler approach:

- race between between zram_reset_device() and disksize_store() (1/4)

- zram leak during unloading module, which is one race between resetting
and removing device (2/4)

- race between zram_remove and disksize_store (3/4)

Also replace replace fsync_bdev with sync_blockdev since no one opens
it.(4/4)

V2:
	- take another approach to avoid failing of zram_remove()
	- add patch to address race between zram_reset_device() and
	  disksize_store()


Ming Lei (4):
  zram: fix race between zram_reset_device() and disksize_store()
  zram: don't fail to remove zram during unloading module
  zram: avoid race between zram_remove and disksize_store
  zram: replace fsync_bdev with sync_blockdev

 drivers/block/zram/zram_drv.c | 39 ++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 8 deletions(-)

-- 
2.31.1

