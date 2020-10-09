Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1ABC433DF
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 04:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5624A2224A
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 04:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuVY/TMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgJIEER (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Oct 2020 00:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57883 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726011AbgJIEER (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Oct 2020 00:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602216256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9BaeyfU4DjtiItfsi85/rgmsC2vzaMr0oa/BiI3+daU=;
        b=AuVY/TMrMxm3gbEPEKZkYmKBPj0C3lhiBQA8e54piuoMaIfHCwFBnmfJ1yHoAiFOLaLcug
        Gk/nY/XeKk7igzLTMv0NXPSqsaUbWqxaXbDm6Y+eG1s8imGRQGlFbu0S6uevdlSpzhPVge
        bKSuXwymYWxaiMISjlk1JtM0Z1vGtz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-CyZnxB2NP4mw9XJq8NOXDw-1; Fri, 09 Oct 2020 00:04:14 -0400
X-MC-Unique: CyZnxB2NP4mw9XJq8NOXDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60C151018F9F;
        Fri,  9 Oct 2020 04:04:13 +0000 (UTC)
Received: from localhost (ovpn-13-88.pek2.redhat.com [10.72.13.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6FCA55780;
        Fri,  9 Oct 2020 04:04:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] percpu_ref: don't refer to ref->data if it isn't allocated
Date:   Fri,  9 Oct 2020 12:03:56 +0800
Message-Id: <20201009040356.43802-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can't check ref->data->confirm_switch directly in __percpu_ref_exit(), since
ref->data may not be allocated in one not-initialized refcount.

Fixes: 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of percpu_ref in fast path")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 lib/percpu-refcount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index b6350d13538a..e59eda07305e 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -109,7 +109,7 @@ static void __percpu_ref_exit(struct percpu_ref *ref)
 
 	if (percpu_count) {
 		/* non-NULL confirm_switch indicates switching in progress */
-		WARN_ON_ONCE(ref->data->confirm_switch);
+		WARN_ON_ONCE(ref->data && ref->data->confirm_switch);
 		free_percpu(percpu_count);
 		ref->percpu_count_ptr = __PERCPU_REF_ATOMIC_DEAD;
 	}
-- 
2.25.2

