Return-Path: <SRS0=+EVs=26=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77983C32771
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 06:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431E5206ED
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 06:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNtV79Gi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgAIGVl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:21:41 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54256 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbgAIGVl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Jan 2020 01:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578550900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RdOup2ZdUA6kr1X5B9TVP+fnISExoxWGQURfZsDFWLs=;
        b=cNtV79Gi+o/I5HeRjXxQqWa+gMRDfS79HktqePpy3CFKf7mB6M3fZWHcHP6zJ2UZOFjES7
        cNB/FYd0LKcF6W/KcG1pqKq3mm45XJDweK6GssvcjWujqN5JU7MzB4sN8a/VfvB7NouewF
        PlLgIltyyCgY62b5ebxI5Nh6PYBhfxo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-Y2Sv-VUgOAujQXOEz6LUJA-1; Thu, 09 Jan 2020 01:21:39 -0500
X-MC-Unique: Y2Sv-VUgOAujQXOEz6LUJA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C3F31801E72;
        Thu,  9 Jan 2020 06:21:37 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B32FE7FB7C;
        Thu,  9 Jan 2020 06:21:34 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH 3/4] block: re-organize fields of 'struct hd_part'
Date:   Thu,  9 Jan 2020 14:21:08 +0800
Message-Id: <20200109062109.2313-4-ming.lei@redhat.com>
In-Reply-To: <20200109062109.2313-1-ming.lei@redhat.com>
References: <20200109062109.2313-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Put all fields accessed in IO path together at the beginning
of the struct, so that all can be fetched in single cacheline.

Cc: Yufen Yu <yuyufen@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hou Tao <houtao1@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/genhd.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 5f5718ce5e86..4c6a998a0c56 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -116,6 +116,14 @@ struct hd_struct {
 #if BITS_PER_LONG=3D=3D32 && defined(CONFIG_SMP)
 	seqcount_t nr_sects_seq;
 #endif
+	unsigned long stamp;
+#ifdef	CONFIG_SMP
+	struct disk_stats __percpu *dkstats;
+#else
+	struct disk_stats dkstats;
+#endif
+	struct percpu_ref ref;
+
 	sector_t alignment_offset;
 	unsigned int discard_alignment;
 	struct device __dev;
@@ -125,13 +133,6 @@ struct hd_struct {
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	int make_it_fail;
 #endif
-	unsigned long stamp;
-#ifdef	CONFIG_SMP
-	struct disk_stats __percpu *dkstats;
-#else
-	struct disk_stats dkstats;
-#endif
-	struct percpu_ref ref;
 	struct gendisk *disk;
 	struct rcu_work rcu_work;
 };
--=20
2.20.1

