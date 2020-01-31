Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AD6C33CB7
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 10:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8915B20CC7
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 10:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgAaKiG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:38:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:55862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbgAaKiF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 05:38:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EE52AB01E;
        Fri, 31 Jan 2020 10:38:01 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Sage Weil <sage@redhat.com>, Daniel Disseldorp <ddiss@suse.com>,
        Jens Axboe <axboe@kernel.dk>, ceph-devel@vger.kernel.org,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/15] rbd: kill 'work_result'
Date:   Fri, 31 Jan 2020 11:37:34 +0100
Message-Id: <20200131103739.136098-11-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200131103739.136098-1-hare@suse.de>
References: <20200131103739.136098-1-hare@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use 'pending_result' instead of 'work_result' and kill the latter.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/rbd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index a6c95b6e9c0c..671e941d6edf 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -352,7 +352,6 @@ struct rbd_img_request {
 	struct mutex		state_mutex;
 	int			pending_result;
 	struct work_struct	work;
-	int			work_result;
 	struct kref		kref;
 };
 
@@ -2834,13 +2833,13 @@ static void rbd_img_handle_request_work(struct work_struct *work)
 	struct rbd_img_request *img_req =
 	    container_of(work, struct rbd_img_request, work);
 
-	rbd_img_handle_request(img_req, img_req->work_result);
+	rbd_img_handle_request(img_req, img_req->pending_result);
 }
 
 static void rbd_img_schedule(struct rbd_img_request *img_req, int result)
 {
 	INIT_WORK(&img_req->work, rbd_img_handle_request_work);
-	img_req->work_result = result;
+	img_req->pending_result = result;
 	queue_work(rbd_wq, &img_req->work);
 }
 
-- 
2.16.4

