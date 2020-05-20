Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068FEC433DF
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 11:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0195207C4
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 11:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyKpwVDx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgETL5N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 07:57:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25749 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726443AbgETL5N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 07:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589975831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JWKpeI2C0LFWENZuWWHrgdjnNtpXaqQRftbElmCVxzo=;
        b=FyKpwVDx8Q6JJXZLQ1nhRrZhBmROY9S3RX2i5W0odQFJo/0YO/QF/Dan4F0Ktk7XheSBsk
        nw2vE4yFsq3xpjbdb6WzYMmPNTpGqhCmyB6ep93HKoslahozVj2A4nyH9RQcWeqpe4kr1p
        7unNdMAvwWd/UncYHvlB92zzfz0exRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-Zzur8L-IMkCPg4VnBMCFmA-1; Wed, 20 May 2020 07:57:07 -0400
X-MC-Unique: Zzur8L-IMkCPg4VnBMCFmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76BB5107ACCD;
        Wed, 20 May 2020 11:57:06 +0000 (UTC)
Received: from localhost (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8583819C4F;
        Wed, 20 May 2020 11:57:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Alan Adamson <alan.adamson@oracle.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] blk-mq/nvme: improve nvme-pci reset handler
Date:   Wed, 20 May 2020 19:56:52 +0800
Message-Id: <20200520115655.729705-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

For nvme-pci, after controller is recovered, in-flight IOs are waited
before updating nr hw queues. If new controller error happens during
this period, nvme-pci driver deletes the controller and fails in-flight
IO. This way is too violent, and not friendly from user viewpoint.

Add APIs for checking if queue is frozen, and replace nvme_wait_freeze
in nvme-pci reset handler with checking if all ns queues are frozen &
controller disabled. Then a fresh new reset can be scheduled for
handling new controller error during waiting for in-flight IO completion.

So deleting controller & failing IOs can be avoided in this situation.

Without this patches, when fail io timeout injection is run, the
controller can be removed very quickly. With this patch, no controller
removing can be observed, and controller can recover to normal state
after stopping to inject io timeout failure.

Ming Lei (3):
  blk-mq: add API of blk_mq_queue_frozen
  nvme: add nvme_frozen
  nvme-pci: make nvme reset more reliable

 block/blk-mq.c           |  6 ++++++
 drivers/nvme/host/core.c | 14 ++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 37 ++++++++++++++++++++++++++++++-------
 include/linux/blk-mq.h   |  1 +
 5 files changed, 52 insertions(+), 7 deletions(-)

-- 
2.25.2

