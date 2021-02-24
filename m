Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6A3C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 04:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432E764E6F
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 04:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhBXEAM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:00:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21816 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229999AbhBXEAJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 23:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614139124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yWByZQB7K7Wiqu8tWWWMAp36KQBNFUgJfqf+tPqQ7As=;
        b=jMABq45c2St3z/DlreDjyMHCPLBzpGTue2JfqTtRkXOD9LwUCFklk48wtTrBmxDTCGVQ/W
        ECrs3LcIiv8nK5w4Q5++8zgCHscPoxOVD5t3xcZ15qlBhigk5wnsq1Li5J6Hg3pPHCy+Gj
        9izjbZhkzV7KvFwc/DcaS5tx8jF089E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-2OV6hZoHMz-nwJQMZhdb2g-1; Tue, 23 Feb 2021 22:58:41 -0500
X-MC-Unique: 2OV6hZoHMz-nwJQMZhdb2g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93F1F8799E0;
        Wed, 24 Feb 2021 03:58:40 +0000 (UTC)
Received: from localhost (ovpn-13-84.pek2.redhat.com [10.72.13.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1683D10021AA;
        Wed, 24 Feb 2021 03:58:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH V2 0/3] block: avoid to drop & re-add partitions if partitions aren't changed
Date:   Wed, 24 Feb 2021 11:58:26 +0800
Message-Id: <20210224035830.990123-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Guys,

The two patches changes block ioctl(BLKRRPART) for avoiding drop &
re-add partitions if partitions state isn't changed. The current
behavior confuses userspace because partitions can disappear anytime
when calling into ioctl(BLKRRPART).

V2:
	- don't save partitions state, and just check if current partition
	state is changed against partition devices	

Ming Lei (4):
  block: define parsed_partitions.flags as 'unsigned char'
  block: store partition flags into block_device
  block: re-organize blk_add_partitions
  block: avoid to drop & re-add partitions if partitions aren't changed

 block/partitions/check.h  |   2 +-
 block/partitions/core.c   | 126 ++++++++++++++++++++++++++++++++++----
 fs/block_dev.c            |  30 ++++-----
 include/linux/blk_types.h |   1 +
 include/linux/genhd.h     |   1 +
 5 files changed, 132 insertions(+), 28 deletions(-)

Cc: Ewan D. Milne <emilne@redhat.com>
-- 
2.29.2

