Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0402C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 04:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71EFC64E6F
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 04:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhBXEAS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 23:00:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229999AbhBXEAQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 23:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614139130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DSml4ZDvXo8RN3I4XE8bl8UTrUdFIfkGqMaNCq86Rms=;
        b=ULV4otz8SG2uz1diAdCC8LdgrKdw0PLofEG5LL1xHP0y1ydGPBjDf3bXMB/O0tSljvcBh8
        PU/y2NSHutVcD5+e8+Y76dDNtouLQYU9R35rrvSYfmHaX/yOtp5+aJP1hiFI+quw6LBNQN
        R8j1hYkm7G5XRd5ki84NHe/T5OudFAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-FoRpbip5Pq-AAlKASE6KMg-1; Tue, 23 Feb 2021 22:58:48 -0500
X-MC-Unique: FoRpbip5Pq-AAlKASE6KMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E76F51009617;
        Wed, 24 Feb 2021 03:58:46 +0000 (UTC)
Received: from localhost (ovpn-13-84.pek2.redhat.com [10.72.13.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4245F709AF;
        Wed, 24 Feb 2021 03:58:42 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Ewan Milne <emilne@redhat.com>
Subject: [PATCH V2 1/4] block: define parsed_partitions.flags as 'unsigned char'
Date:   Wed, 24 Feb 2021 11:58:27 +0800
Message-Id: <20210224035830.990123-2-ming.lei@redhat.com>
In-Reply-To: <20210224035830.990123-1-ming.lei@redhat.com>
References: <20210224035830.990123-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So far, only 3 partition flags are used, it is enough to hold it in
'unsigned char'.

Cc: Ewan Milne <emilne@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/partitions/check.h | 2 +-
 block/partitions/core.c  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/partitions/check.h b/block/partitions/check.h
index c577e9ee67f0..8f0ceed06c7b 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -14,7 +14,7 @@ struct parsed_partitions {
 	struct {
 		sector_t from;
 		sector_t size;
-		int flags;
+		unsigned char flags;
 		bool has_info;
 		struct partition_meta_info info;
 	} *parts;
diff --git a/block/partitions/core.c b/block/partitions/core.c
index f3d9ff2cafb6..430ff7863556 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -314,7 +314,8 @@ static DEVICE_ATTR(whole_disk, 0444, whole_disk_show, NULL);
  * after all disk users are gone.
  */
 static struct block_device *add_partition(struct gendisk *disk, int partno,
-				sector_t start, sector_t len, int flags,
+				sector_t start, sector_t len,
+				unsigned char flags,
 				struct partition_meta_info *info)
 {
 	dev_t devt = MKDEV(0, 0);
-- 
2.29.2

