Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7268CEB64D7
	for <linux-block@archiver.kernel.org>; Mon, 26 Jun 2023 20:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjFZU01 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jun 2023 16:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjFZU00 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2023 16:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1417E98
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2023 13:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687811141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=3GTZUTR7TSN2Pv2rP/zl0U3Y8nn62m39alERRhanbpM=;
        b=gllMhVmaWtgz4+OqbJNO3j9uUMKJl/zShACVh8l/tg0LW65VZAjddRSYiRVxFijMbqz/it
        3U99XEt5QL7NTZEDqdKp8KADjxNuuUf1V037oJSCX+/sNpM8mcnyP2W5424o7heJMXu2A6
        9ZIjxDlLXBaCDL7D9xeN6jjojNIdnWQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-537-byjuLztxMMKAGNaaDCxVnA-1; Mon, 26 Jun 2023 16:25:37 -0400
X-MC-Unique: byjuLztxMMKAGNaaDCxVnA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EA838C8101;
        Mon, 26 Jun 2023 20:25:28 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 835D215230A0;
        Mon, 26 Jun 2023 20:25:28 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 6EF2030C045B; Mon, 26 Jun 2023 20:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 66F8A3FB76;
        Mon, 26 Jun 2023 22:25:28 +0200 (CEST)
Date:   Mon, 26 Jun 2023 22:25:28 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Marc Smith <msmith626@gmail.com>
Subject: [PATCH] block: flush the disk cache on BLKFLSBUF
Message-ID: <1a33ace-57f9-9ef9-b967-d6617ca33089@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The BLKFLSBUF ioctl doesn't send the flush bio to the block device, thus
flushed data may be lurking in the disk cache and they may not be really
flushed to the stable storage.

This patch adds the call to blkdev_issue_flush to blkdev_flushbuf.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 block/ioctl.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/block/ioctl.c
===================================================================
--- linux-2.6.orig/block/ioctl.c
+++ linux-2.6/block/ioctl.c
@@ -351,6 +351,7 @@ static int blkdev_flushbuf(struct block_
 		return -EACCES;
 	fsync_bdev(bdev);
 	invalidate_bdev(bdev);
+	blkdev_issue_flush(bdev);
 	return 0;
 }
 

