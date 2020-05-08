Return-Path: <SRS0=OuBg=6W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA084C38A2A
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 08:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C1D2206D5
	for <linux-block@archiver.kernel.org>; Fri,  8 May 2020 08:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CR2y3wAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEHISf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 May 2020 04:18:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38006 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726797AbgEHISf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 May 2020 04:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588925914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eqE+VZT6iP5BBQICf6hdfbtPcveHLASDX8yMLp9dHYE=;
        b=CR2y3wAN2uCvZM08z+VQRpQfGrM/PyTmWjhOtEul2lOEckTbGTvdc6lrQZ0oTGQawaVN/8
        PI25NBVsYhqJjsESCL1xo6APY0QMwWuWgd/3PCxVy5Xu7jLHlGh9ecJewyeKTwB7PGzL0X
        HCEnUuDhVkgOPnCVfDFEV7+ynVHNt4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-qS71B8ypM3K4WnJfbWZgdg-1; Fri, 08 May 2020 04:18:32 -0400
X-MC-Unique: qS71B8ypM3K4WnJfbWZgdg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68E921895A2A;
        Fri,  8 May 2020 08:18:31 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFF6E5D9CA;
        Fri,  8 May 2020 08:18:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH V3 3/4] block: re-organize fields of 'struct hd_part'
Date:   Fri,  8 May 2020 16:17:57 +0800
Message-Id: <20200508081758.1380673-4-ming.lei@redhat.com>
In-Reply-To: <20200508081758.1380673-1-ming.lei@redhat.com>
References: <20200508081758.1380673-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Put all fields accessed in IO path together at the beginning
of the struct, so that all can be fetched in single cacheline.

Cc: Yufen Yu <yuyufen@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hou Tao <houtao1@huawei.com>
Reviewed-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/genhd.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index b4744035ae58..a9384449465a 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -71,6 +71,14 @@ struct hd_struct {
 #if BITS_PER_LONG==32 && defined(CONFIG_SMP)
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
@@ -80,13 +88,6 @@ struct hd_struct {
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
 	struct rcu_work rcu_work;
 };
 
-- 
2.25.2

