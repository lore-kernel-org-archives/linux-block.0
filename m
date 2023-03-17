Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EC4C7618B
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 20:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbjCQU3K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 16:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjCQU25 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 16:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4023AF291
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679084881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LMNmNTOdx390ioTe9XNiCAi1NYjBrn3x8X89rBxIitg=;
        b=fKaktX6BEYi2d1WqbMA4G+oCwmqlZsoZg/ugQvXUUye0APtXpbd4JSchdngYpQDLZU2ibp
        li+xPjA0J7OVht3ZK4tXv2Kl8jUxZc+HGy/ByiuR3ROglpDquksi+WOm/T6ei2e4dj3T/7
        nqMqQB3osV3rXBni+1HUTnS5XL+GA8g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-Mxwocp_hMcOEN5qt7QZfpw-1; Fri, 17 Mar 2023 16:27:58 -0400
X-MC-Unique: Mxwocp_hMcOEN5qt7QZfpw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D7602999B21;
        Fri, 17 Mar 2023 20:27:57 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E243B492B00;
        Fri, 17 Mar 2023 20:27:56 +0000 (UTC)
From:   Eric Blake <eblake@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] block nbd: use req.cookie instead of req.handle
Date:   Fri, 17 Mar 2023 15:27:48 -0500
Message-Id: <20230317202749.419094-5-eblake@redhat.com>
In-Reply-To: <20230317202749.419094-1-eblake@redhat.com>
References: <20230317202749.419094-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A good optimizing compiler should not compile this any differently,
but it is nicer to work directly with integers instead of memcpy().

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: Fix kernel test robot complaint about wrong endianness on loongarch:
https://lore.kernel.org/oe-kbuild-all/202303121323.Jd35Q1Au-lkp@intel.com/
---
 drivers/block/nbd.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8a9487e79f1c..94ae85400b46 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -560,7 +560,6 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 	unsigned long size = blk_rq_bytes(req);
 	struct bio *bio;
 	u64 handle;
-	__be64 tmp;
 	u32 type;
 	u32 nbd_cmd_flags = 0;
 	int sent = nsock->sent, skip = 0;
@@ -607,8 +606,7 @@ static int nbd_send_cmd(struct nbd_device *nbd, struct nbd_cmd *cmd, int index)
 		request.len = htonl(size);
 	}
 	handle = nbd_cmd_handle(cmd);
-	tmp = cpu_to_be64(handle);
-	memcpy(request.handle, &tmp, sizeof(tmp));
+	request.cookie = cpu_to_be64(handle);

 	trace_nbd_send_request(&request, nbd->index, blk_mq_rq_from_pdu(cmd));

@@ -729,14 +727,12 @@ static struct nbd_cmd *nbd_handle_reply(struct nbd_device *nbd, int index,
 	int result;
 	struct nbd_cmd *cmd;
 	struct request *req = NULL;
-	__be64 tmp;
 	u64 handle;
 	u16 hwq;
 	u32 tag;
 	int ret = 0;

-	memcpy(&tmp, reply->handle, sizeof(tmp));
-	handle = be64_to_cpu(tmp);
+	handle = be64_to_cpu(reply->cookie);
 	tag = nbd_handle_to_tag(handle);
 	hwq = blk_mq_unique_tag_to_hwq(tag);
 	if (hwq < nbd->tag_set.nr_hw_queues)
-- 
2.39.2

