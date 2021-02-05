Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6812BC433DB
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 02:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EAB464F3D
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 02:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhBECSv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 21:18:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37338 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229508AbhBECSt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Feb 2021 21:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612491443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yViiFj5/UvknIHJmYdZC5PhHVIA9CzYdE/iPEoPmYT8=;
        b=VydWRsDoNbaS9UaBqjHIvkohG4qYws9p1v67yObKpKlFN5b862YmYfU+jf6eLTdPu1RYH2
        Um+UM8xCZ+B7Vwta7SAX/5+673bnejoG120YQLuXzzw9REzRYBa3iN6aEBkWnmYVtlHzEv
        ji4Nzo1hZjWU6DRvYx3tLaNr3UvOBTg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-WFpP9iRCNVqjMO78oLbFrQ-1; Thu, 04 Feb 2021 21:17:21 -0500
X-MC-Unique: WFpP9iRCNVqjMO78oLbFrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A68B19126D;
        Fri,  5 Feb 2021 02:17:20 +0000 (UTC)
Received: from localhost (ovpn-13-14.pek2.redhat.com [10.72.13.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9FC45D762;
        Fri,  5 Feb 2021 02:17:16 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH 0/2] block: avoid to drop & re-add partitions if partitions aren't changed
Date:   Fri,  5 Feb 2021 10:17:06 +0800
Message-Id: <20210205021708.1498711-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Guys,

The two patches changes block ioctl(BLKRRPART) for avoiding drop &
re-add partitions if partitions state isn't changed. The current
behavior confuses userspace because partitions can disappear anytime
when ioctl(BLKRRPART).

Ming Lei (2):
  block: move partitions check code into single helper
  block: avoid to drop & re-add partitions if partitions aren't changed

 block/genhd.c            |   2 +
 block/partitions/check.h |   2 +
 block/partitions/core.c  | 101 ++++++++++++++++++++++++++++++++-------
 fs/block_dev.c           |  28 +++++++++--
 include/linux/genhd.h    |   4 ++
 5 files changed, 118 insertions(+), 19 deletions(-)

Cc: Ewan D. Milne <emilne@redhat.com>
-- 
2.29.2

