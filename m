Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08504C4338F
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 14:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB36611C9
	for <linux-block@archiver.kernel.org>; Fri,  6 Aug 2021 14:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239313AbhHFO34 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Aug 2021 10:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57409 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239301AbhHFO34 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Aug 2021 10:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628260180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+yI0uptNoP6G4N0IJZFLL/DMeGNN+zepZ14xcoCNN6E=;
        b=QWwBQPbaerNgQH5EZs9W/mdNQXkcUk4U68/JzchADJ8w9mKtkhxMMFogfBMzYr+dTpzBj+
        7U2GaPRfKKXZynP4z/WQwZhNFfLOL9rLJ7CxHOrYG0SYsoW0mvKqWzFzYtEkpI1VutddLD
        p/jfL6QvatbvWHb8X5cXzrSLHGiaQ+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-xKLAKPfBM76PMbAKYo_Dmg-1; Fri, 06 Aug 2021 10:29:38 -0400
X-MC-Unique: xKLAKPfBM76PMbAKYo_Dmg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 376EA87D541;
        Fri,  6 Aug 2021 14:29:37 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52DD55DA61;
        Fri,  6 Aug 2021 14:29:20 +0000 (UTC)
From:   pkalever@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        josef@toxicpanda.com, axboe@kernel.dk, idryomov@redhat.com,
        xiubli@redhat.com,
        Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Subject: [PATCH v1 0/2] nbd: reset the queue/io_timeout to default on disconnect
Date:   Fri,  6 Aug 2021 19:59:12 +0530
Message-Id: <20210806142914.70556-1-pkalever@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>

Hi,

This series has changes to reset the queue/io_timeout for nbd devices and
a cleanup patch.

Thank you!

Prasanna Kumar Kalever (2):
  block: cleanup: define default command timeout and use it
  nbd: reset the queue/io_timeout to default on disconnect

 block/blk-mq.c         | 2 +-
 drivers/block/nbd.c    | 9 +++++++--
 include/linux/blkdev.h | 2 ++
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.31.1

