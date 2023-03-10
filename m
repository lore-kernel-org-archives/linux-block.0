Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63323C6FD19
	for <linux-block@archiver.kernel.org>; Fri, 10 Mar 2023 20:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjCJUQ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Mar 2023 15:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjCJUQ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Mar 2023 15:16:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E88F12DC15
        for <linux-block@vger.kernel.org>; Fri, 10 Mar 2023 12:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678479334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qbf3haIGUbZxNkBMJMJQ815E2aix9OEBTv2ECdqvLKY=;
        b=UakdK3j46vQYUxaOn68+jp1GDhbxtxJocIGLBDfBm+oNbkqcHpLwwVCIc2/z40QkxeyDeq
        7irVciqkT5w2Ckmh147JZDC7Yk5TC2qZnHg8wtt5wu7O+MrLF94DvyXffP+CzWF6wu/hHV
        WT0jdnvvJZnGrhCL2xOegorCjKPhmbc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-xlH238XMOMmsWX3UtP1IVg-1; Fri, 10 Mar 2023 15:15:30 -0500
X-MC-Unique: xlH238XMOMmsWX3UtP1IVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DD093C025D2;
        Fri, 10 Mar 2023 20:15:29 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF0B64014CF3;
        Fri, 10 Mar 2023 20:15:28 +0000 (UTC)
From:   Eric Blake <eblake@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] block nbd: use req.cookie instead of req.handle
Date:   Fri, 10 Mar 2023 14:15:25 -0600
Message-Id: <20230310201525.2615385-4-eblake@redhat.com>
In-Reply-To: <20230310201525.2615385-1-eblake@redhat.com>
References: <20230310201525.2615385-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A good compiler should not compile this any differently, but it seems
nicer to avoid memcpy() when integer assignment will work.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 drivers/block/nbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 592cfa8b765a..672fb8d1ce67 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -606,7 +606,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		request.len = htonl(size);
 	}
 	handle = nbd_cmd_handle(cmd);
-	memcpy(request.handle, &handle, sizeof(handle));
+	request.cookie = handle;

 	trace_nbd_send_request(&request, nbd->index, blk_mq_rq_from_pdu(cmd));

@@ -732,7 +732,7 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
 	u32 tag;
 	int ret = 0;

-	memcpy(&handle, reply->handle, sizeof(handle));
+	handle = reply->cookie;
 	tag = nbd_handle_to_tag(handle);
 	hwq = blk_mq_unique_tag_to_hwq(tag);
 	if (hwq < nbd->tag_set.nr_hw_queues)
-- 
2.39.2

