Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A27C433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 00:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbiCBAfa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiCBAf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 19:35:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 91AC113F9B
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 16:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646181286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lvapV5GLXY4wmW/hUeBI4Jp/rDSjzPCuOEaq2iWsCBU=;
        b=Me5UGWr2DLSLJJdtkGUN0VW6jZhdPtYqyoSF/47eVBcfY783iwqDQr/dn1DLWX2xop26AF
        JY479RQvygfjS4ZXBTc+jByGu6k4Tr554WAZQ/pggtwr4AQacn+cF8oJf15m94X9X7rDZO
        +IvvDk9WNKiVcOu5gL6uyck/09ANju8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-VdMAsmyxPk-H6IlM-Jwugg-1; Tue, 01 Mar 2022 19:34:43 -0500
X-MC-Unique: VdMAsmyxPk-H6IlM-Jwugg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A7561091DA0;
        Wed,  2 Mar 2022 00:34:42 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD2DC1037F30;
        Wed,  2 Mar 2022 00:34:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH V2] blk-mq: kill warning when building block/blk-mq-debugfs-zoned.c
Date:   Wed,  2 Mar 2022 08:34:31 +0800
Message-Id: <20220302003431.1253287-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the following warning when building block/blk-mq-debugfs-zoned.c:

In file included from block/blk-mq-debugfs-zoned.c:7:
block/blk-mq-debugfs.h:24:14: warning: ‘struct blk_mq_hw_ctx’ declared inside parameter list will not be visible outside of this definition or declaration
   24 |       struct blk_mq_hw_ctx *hctx);
      |              ^~~~~~~~~~~~~

Cc: Christoph Hellwig <hch@lst.de>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- forward declaration of struct blk_mq_hw_ctx instead of including
	  header, as suggested by Christoph

 block/blk-mq-debugfs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index a68aa6041a10..361d759c6fad 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -2,6 +2,8 @@
 #ifndef INT_BLK_MQ_DEBUGFS_H
 #define INT_BLK_MQ_DEBUGFS_H
 
+struct blk_mq_hw_ctx;
+
 #ifdef CONFIG_BLK_DEBUG_FS
 
 #include <linux/seq_file.h>
-- 
2.31.1

