Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CBDC433F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 16:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 606B961039
	for <linux-block@archiver.kernel.org>; Mon,  6 Sep 2021 16:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244161AbhIFQjq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Sep 2021 12:39:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54763 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234378AbhIFQjp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 6 Sep 2021 12:39:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630946320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XDRSVVNXv21/f4fvDTpcmbi/5m6iR2hENhLOMYkY3JU=;
        b=cA0/JHqEqlKxA+P//baCSzxMyRjrT42tW+vxup5SJ0qM9tdxd/+RxLE+YO2Q5qTAhemfnJ
        UM8JoLiyrdgsmc6jmWmVVuC0HLZjdMr+Uwly3qPXWxgy3R31IWpJ6tb5dwJMrrugxoq15i
        08wQWxyDUjSpQ3ihHMKFZUEoWBB23wk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-mo6H-W57MNadHDUpDJhaaQ-1; Mon, 06 Sep 2021 12:38:39 -0400
X-MC-Unique: mo6H-W57MNadHDUpDJhaaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5061B1020C4E;
        Mon,  6 Sep 2021 16:38:38 +0000 (UTC)
Received: from fedora.redhat.com (ovpn-116-52.gru2.redhat.com [10.97.116.52])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0F1B5C22B;
        Mon,  6 Sep 2021 16:38:35 +0000 (UTC)
From:   Julio Faracco <jfaracco@redhat.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: include dd_queued{,_show} into proper BLK_DEBUG_FS guard
Date:   Mon,  6 Sep 2021 13:38:31 -0300
Message-Id: <20210906163831.263809-1-jfaracco@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This commit fixes a compilation issue to an unused function if
BLK_DEBUG_FS setting is not enabled. This usually happens in tiny
kernels with several debug options disabled. For further details,
see the message below:

../block/mq-deadline.c:274:12: error: ‘dd_queued’ defined but not used [-Werror=unused-function]
  274 | static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
      |            ^~~~~~~~~
cc1: all warnings being treated as errors

Signed-off-by: Julio Faracco <jfaracco@redhat.com>
---
 block/mq-deadline.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 3c3693c34f06..07319ac49a1b 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -270,12 +270,6 @@ deadline_move_request(struct deadline_data *dd, struct dd_per_prio *per_prio,
 	deadline_remove_request(rq->q, per_prio, rq);
 }
 
-/* Number of requests queued for a given priority level. */
-static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
-{
-	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
-}
-
 /*
  * deadline_check_fifo returns 0 if there are no expired requests on the fifo,
  * 1 otherwise. Requires !list_empty(&dd->fifo_list[data_dir])
@@ -953,6 +947,13 @@ static int dd_async_depth_show(void *data, struct seq_file *m)
 	return 0;
 }
 
+#ifdef CONFIG_BLK_DEBUG_FS
+/* Number of requests queued for a given priority level. */
+static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
+{
+	return dd_sum(dd, inserted, prio) - dd_sum(dd, completed, prio);
+}
+
 static int dd_queued_show(void *data, struct seq_file *m)
 {
 	struct request_queue *q = data;
@@ -963,6 +964,7 @@ static int dd_queued_show(void *data, struct seq_file *m)
 		   dd_queued(dd, DD_IDLE_PRIO));
 	return 0;
 }
+#endif
 
 /* Number of requests owned by the block driver for a given priority. */
 static u32 dd_owned_by_driver(struct deadline_data *dd, enum dd_prio prio)
-- 
2.31.1

