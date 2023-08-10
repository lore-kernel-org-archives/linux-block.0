Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A54C001DE
	for <linux-block@archiver.kernel.org>; Thu, 10 Aug 2023 10:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjHJKKC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 06:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjHJKKB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 06:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CF3E0
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 03:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691662155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zmj5nzJTSHzE8zf1I1zUcK3keiQbhtTkmdKSaDQ9f0U=;
        b=U01m/qope0QhaAepEpfyMRMm+1FJOhs9hYMbTqDO48W7AMHz3gMRXrhX8UeTmb4kMeD/9g
        bM52r1KZVKN6o+hdoxoY+yeaLaS/fDpz0o2CgbqKtGf5r76UEVlUMJDHXZggbXYrYinvzd
        XprJ0f0hbefxc/A3ezxSqaCr06AxwcM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-btY38AADN2yPlZumBh7MJw-1; Thu, 10 Aug 2023 06:09:12 -0400
X-MC-Unique: btY38AADN2yPlZumBh7MJw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3469A8DC661;
        Thu, 10 Aug 2023 10:09:12 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2488DC15BAE;
        Thu, 10 Aug 2023 10:09:12 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
        id 17FD730B9C07; Thu, 10 Aug 2023 10:09:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 14B933F7CF;
        Thu, 10 Aug 2023 12:09:12 +0200 (CEST)
Date:   Thu, 10 Aug 2023 12:09:11 +0200 (CEST)
From:   Mikulas Patocka <mpatocka@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
cc:     Li Nan <linan666@huaweicloud.com>,
        Zdenek Kabelac <zkabelac@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH v3 2/4] brd: extend the rcu regions to cover read and write
In-Reply-To: <2dacc73-854-e71c-1746-99b017401c9a@redhat.com>
Message-ID: <2ae7f7aa-add7-a7f5-e73e-443fc97a0d9@redhat.com>
References: <2dacc73-854-e71c-1746-99b017401c9a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch extends the rcu regions, so that lookup followed by a read or
write of a page is done inside rcu read lock. This is needed for the
following patch that enables discard.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/block/brd.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-2.6/drivers/block/brd.c
===================================================================
--- linux-2.6.orig/drivers/block/brd.c
+++ linux-2.6/drivers/block/brd.c
@@ -150,23 +150,27 @@ static void copy_to_brd(struct brd_devic
 	size_t copy;
 
 	copy = min_t(size_t, n, PAGE_SIZE - offset);
+	rcu_read_lock();
 	page = brd_lookup_page(brd, sector);
 	BUG_ON(!page);
 
 	dst = kmap_atomic(page);
 	memcpy(dst + offset, src, copy);
 	kunmap_atomic(dst);
+	rcu_read_unlock();
 
 	if (copy < n) {
 		src += copy;
 		sector += copy >> SECTOR_SHIFT;
 		copy = n - copy;
+		rcu_read_lock();
 		page = brd_lookup_page(brd, sector);
 		BUG_ON(!page);
 
 		dst = kmap_atomic(page);
 		memcpy(dst, src, copy);
 		kunmap_atomic(dst);
+		rcu_read_unlock();
 	}
 }
 
@@ -182,6 +186,7 @@ static void copy_from_brd(void *dst, str
 	size_t copy;
 
 	copy = min_t(size_t, n, PAGE_SIZE - offset);
+	rcu_read_lock();
 	page = brd_lookup_page(brd, sector);
 	if (page) {
 		src = kmap_atomic(page);
@@ -189,11 +194,13 @@ static void copy_from_brd(void *dst, str
 		kunmap_atomic(src);
 	} else
 		memset(dst, 0, copy);
+	rcu_read_unlock();
 
 	if (copy < n) {
 		dst += copy;
 		sector += copy >> SECTOR_SHIFT;
 		copy = n - copy;
+		rcu_read_lock();
 		page = brd_lookup_page(brd, sector);
 		if (page) {
 			src = kmap_atomic(page);
@@ -201,6 +208,7 @@ static void copy_from_brd(void *dst, str
 			kunmap_atomic(src);
 		} else
 			memset(dst, 0, copy);
+		rcu_read_unlock();
 	}
 }
 

