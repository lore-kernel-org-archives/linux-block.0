Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3F4C433E9
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 16:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B98B64F11
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 16:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhCRQuD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 12:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232255AbhCRQts (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 12:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616086187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pPmdiGFpIEVHHdkjC5nrbTsamI2Cw8osFs9EsU37nO0=;
        b=CYJKcOmb32PRoeC1AyOoAOOC2tYKhrIpOdC3YinRQGap990stWqryf8kJwRWMsUiUC1i38
        ztKFECX750WioAoq0mOAwf6Mg6TFQZS1sCyOM7BZDJj32cdSyyGNRmFGYzYdno/bcUgykP
        oXp3TBVFYRlQdiP+gjSGMHhHpp7hgsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-Uvsna_TyP4i-6-UkduWWfA-1; Thu, 18 Mar 2021 12:49:45 -0400
X-MC-Unique: Uvsna_TyP4i-6-UkduWWfA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FFDC1B2C9A7;
        Thu, 18 Mar 2021 16:49:31 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 754FC5D9C6;
        Thu, 18 Mar 2021 16:49:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH V2 06/13] block: add new field into 'struct bvec_iter'
Date:   Fri, 19 Mar 2021 00:48:20 +0800
Message-Id: <20210318164827.1481133-7-ming.lei@redhat.com>
In-Reply-To: <20210318164827.1481133-1-ming.lei@redhat.com>
References: <20210318164827.1481133-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a hole at the end of 'struct bvec_iter', so put a new field
here and we can save cookie returned from submit_bio() here for
supporting bio based polling.

This way can avoid to extend bio unnecessarily.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bvec.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index ff832e698efb..61c0f55f7165 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -43,6 +43,15 @@ struct bvec_iter {
 
 	unsigned int            bi_bvec_done;	/* number of bytes completed in
 						   current bvec */
+
+	/*
+	 * There is a hole at the end of bvec_iter, define one filed to
+	 * hold something which isn't relate with 'bvec_iter', so that we can
+	 * avoid to extend bio. So far this new field is used for bio based
+	 * pooling, we will store returning value of underlying queue's
+	 * submit_bio() here.
+	 */
+	unsigned int		bi_private_data;
 };
 
 struct bvec_iter_all {
-- 
2.29.2

