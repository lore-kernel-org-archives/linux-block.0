Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E399C38A24
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 08:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86E92073A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 08:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pfof1cUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbgEGIxM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 04:53:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27480 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725802AbgEGIxM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 04:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588841591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03xX1/0D2r8z9mADqwXn00/3fORYAzSaiim9JEwxIFs=;
        b=Pfof1cUr3bU0Zfj3b0pGX+wic35dUFW635wxnyimBM/krihSScFqh72wdqirv5gdKbF3iF
        9TluuNF8QgHxskIfF+ic7XzQ5iz6zjl/7BcvxZswJMDLf8bJixj992qW4PQZ1TFrxrV+OR
        21UMDuTEDm2y8J0ndX0KvxpGqb9quDg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-5pANkWR8P8CGpF5rNKIhmA-1; Thu, 07 May 2020 04:53:06 -0400
X-MC-Unique: 5pANkWR8P8CGpF5rNKIhmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD08B64AD2;
        Thu,  7 May 2020 08:53:05 +0000 (UTC)
Received: from localhost (ovpn-8-38.pek2.redhat.com [10.72.8.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC31E1FBCD;
        Thu,  7 May 2020 08:53:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH 3/4] block: re-organize fields of 'struct hd_part'
Date:   Thu,  7 May 2020 16:52:38 +0800
Message-Id: <20200507085239.1354854-4-ming.lei@redhat.com>
In-Reply-To: <20200507085239.1354854-1-ming.lei@redhat.com>
References: <20200507085239.1354854-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
index 2732120751e8..e0fab519ce37 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -71,6 +71,14 @@ struct hd_struct {
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
 	struct gendisk *disk;
 	struct rcu_work rcu_work;
 };
--=20
2.25.2

