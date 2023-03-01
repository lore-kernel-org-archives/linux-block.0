Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B7CC7EE2F
	for <linux-block@archiver.kernel.org>; Wed,  1 Mar 2023 14:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCAOIn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Mar 2023 09:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCAOIe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Mar 2023 09:08:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E073432F
        for <linux-block@vger.kernel.org>; Wed,  1 Mar 2023 06:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677679667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fGzcLuKh8pFFEv9i8gGA6ApGflYmy8iq+CgmaP8wY3k=;
        b=gg39lkRNwgH9fxSY/onqMXBHBWkEVELjmKNGodJbpFllgmPwVIIXuihv839vB7WH78rZMF
        VG1eOw0E5KvV3J2cxBacvs9DYum1rA8tBLYh3M8WEAGdwFuYZ1PNwYTujKif5o/p9GrK22
        zxgU8Ap7RuWgMMynnd9/xP34Fusi740=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-_G84y0-tPl-mfNrQoYpvFw-1; Wed, 01 Mar 2023 09:07:36 -0500
X-MC-Unique: _G84y0-tPl-mfNrQoYpvFw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71F0F38123DA;
        Wed,  1 Mar 2023 14:06:31 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A936EC15BAD;
        Wed,  1 Mar 2023 14:06:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 02/12] io_uring: define io_mapped_ubuf->acct_pages as unsigned integer
Date:   Wed,  1 Mar 2023 22:06:01 +0800
Message-Id: <20230301140611.163055-3-ming.lei@redhat.com>
In-Reply-To: <20230301140611.163055-1-ming.lei@redhat.com>
References: <20230301140611.163055-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Unsigned integer is enough(4G * 4k = 16TB) to hold nr_pages in one
io_mapped_ubuf.

This way will save one word for io_mapped_ubuf.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 io_uring/rsrc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 2b8743645efc..774aca20326c 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -49,7 +49,7 @@ struct io_mapped_ubuf {
 	u64		ubuf;
 	u64		ubuf_end;
 	unsigned int	nr_bvecs;
-	unsigned long	acct_pages;
+	unsigned int	acct_pages;
 	struct bio_vec	bvec[];
 };
 
-- 
2.31.1

