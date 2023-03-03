Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDCCC61DA4
	for <linux-block@archiver.kernel.org>; Fri,  3 Mar 2023 23:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjCCXOw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Mar 2023 18:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjCCXOp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Mar 2023 18:14:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77D84B801
        for <linux-block@vger.kernel.org>; Fri,  3 Mar 2023 15:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677885236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z5vCHFhYPeAkT+c1PkPwMKEFL4FjgQ8idohZ/LdWkTU=;
        b=BwTJ7Nh737Vr9IPMDNa9NRq+umpijPoQXN+f3jHAF+qCMChIuVYYGrkAQQnGAqfjfxbNqv
        QHrgMsbRGFdLeyi2ZG4m1ucT79WNuy24DWA4+EYbiq44OPocHC29TB6OgFIJihv36TNpQY
        Txx0ovdvxZtg7Q3ivZ3oZURDZ8dW7E4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-Y2rkx_arNcaQBf8pxk-ikw-1; Fri, 03 Mar 2023 18:13:54 -0500
X-MC-Unique: Y2rkx_arNcaQBf8pxk-ikw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E3CE80D0F0;
        Fri,  3 Mar 2023 23:13:54 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 602C32166B26;
        Fri,  3 Mar 2023 23:13:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] nvme: fix handling single range discard request
Date:   Sat,  4 Mar 2023 07:13:45 +0800
Message-Id: <20230303231345.119652-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When investigating one customer report on warning in nvme_setup_discard,
we observed the controller(nvme/tcp) actually exposes
queue_max_discard_segments(req->q) == 1.

Obviously the current code can't handle this situation, since contiguity
merge like normal RW request is taken.

Fix the issue by building range from request sector/nr_sectors directly.

Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2730b116dc6..d4be525f8100 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -781,16 +781,26 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		range = page_address(ns->ctrl->discard_page);
 	}
 
-	__rq_for_each_bio(bio, req) {
-		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
-		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
-
-		if (n < segments) {
-			range[n].cattr = cpu_to_le32(0);
-			range[n].nlb = cpu_to_le32(nlb);
-			range[n].slba = cpu_to_le64(slba);
+	if (queue_max_discard_segments(req->q) == 1) {
+		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
+		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
+
+		range[0].cattr = cpu_to_le32(0);
+		range[0].nlb = cpu_to_le32(nlb);
+		range[0].slba = cpu_to_le64(slba);
+		n = 1;
+	} else {
+		__rq_for_each_bio(bio, req) {
+			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
+			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
+
+			if (n < segments) {
+				range[n].cattr = cpu_to_le32(0);
+				range[n].nlb = cpu_to_le32(nlb);
+				range[n].slba = cpu_to_le64(slba);
+			}
+			n++;
 		}
-		n++;
 	}
 
 	if (WARN_ON_ONCE(n != segments)) {
-- 
2.39.2

