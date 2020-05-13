Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3645CA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 10:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADCDC20675
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 10:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q/hzZurT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbgEMKtn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 06:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732683AbgEMKtm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 06:49:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC654C061A0C
        for <linux-block@vger.kernel.org>; Wed, 13 May 2020 03:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GMaCynBRlOHCgqnU9YRIKSqeuwPHeIiXFAnd3YV89Gw=; b=q/hzZurTwNvkuJZhBhul1fJ6sQ
        GK3TFAhWPhJumHCaOng02b6cHWSXdnHZSkUdInRrwuDhs9ImL8KFziTdPZ9/ZfJpWF4bLMa+PKpzH
        AwYKXWnwA2DUGJ5ovOFk8kxfEL0A8beAb1dffj41gILr55aETFLfoUsHY6wSdpZgL46jsTWOpGroZ
        nxv++fB2cJZJSDL8u97bare9ryVA1Eqwfilfi6/JPR+V0iRDn9JgKac9b+GgDqT51xYGvcOz+dy5y
        3r6rgkvWcAMd/SOtvsoXvYAXUfJ0H5QKDU1CDRJV4owNMg26vdB/zd5wp5jdyQWA3ReGFHFelyt2K
        7IuzfNgQ==;
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYoxK-0005bj-C7; Wed, 13 May 2020 10:49:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/4] block: move the blk-mq calls out of part_in_flight{,_rw}
Date:   Wed, 13 May 2020 12:49:33 +0200
Message-Id: <20200513104935.2338779-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513104935.2338779-1-hch@lst.de>
References: <20200513104935.2338779-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't bother to call part_in_flight / part_in_flight_rw on blk-mq
devices, just call the blk-mq versions directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index afdb2c3e5b22a..56e0560738c49 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -142,14 +142,9 @@ void part_dec_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 static unsigned int part_in_flight(struct request_queue *q,
 		struct hd_struct *part)
 {
+	unsigned int inflight = 0;
 	int cpu;
-	unsigned int inflight;
-
-	if (queue_is_mq(q)) {
-		return blk_mq_in_flight(q, part);
-	}
 
-	inflight = 0;
 	for_each_possible_cpu(cpu) {
 		inflight += part_stat_local_read_cpu(part, in_flight[0], cpu) +
 			    part_stat_local_read_cpu(part, in_flight[1], cpu);
@@ -165,11 +160,6 @@ static void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
 {
 	int cpu;
 
-	if (queue_is_mq(q)) {
-		blk_mq_in_flight_rw(q, part, inflight);
-		return;
-	}
-
 	inflight[0] = 0;
 	inflight[1] = 0;
 	for_each_possible_cpu(cpu) {
@@ -1307,7 +1297,10 @@ ssize_t part_stat_show(struct device *dev,
 	unsigned int inflight;
 
 	part_stat_read_all(p, &stat);
-	inflight = part_in_flight(q, p);
+	if (queue_is_mq(q))
+		inflight = blk_mq_in_flight(q, p);
+	else
+		inflight = part_in_flight(q, p);
 
 	return sprintf(buf,
 		"%8lu %8lu %8llu %8u "
@@ -1346,7 +1339,11 @@ ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
 	struct request_queue *q = part_to_disk(p)->queue;
 	unsigned int inflight[2];
 
-	part_in_flight_rw(q, p, inflight);
+	if (queue_is_mq(q))
+		blk_mq_in_flight_rw(q, p, inflight);
+	else
+		part_in_flight_rw(q, p, inflight);
+
 	return sprintf(buf, "%8u %8u\n", inflight[0], inflight[1]);
 }
 
@@ -1601,7 +1598,10 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 	disk_part_iter_init(&piter, gp, DISK_PITER_INCL_EMPTY_PART0);
 	while ((hd = disk_part_iter_next(&piter))) {
 		part_stat_read_all(hd, &stat);
-		inflight = part_in_flight(gp->queue, hd);
+		if (queue_is_mq(gp->queue))
+			inflight = blk_mq_in_flight(gp->queue, hd);
+		else
+			inflight = part_in_flight(gp->queue, hd);
 
 		seq_printf(seqf, "%4d %7d %s "
 			   "%lu %lu %lu %u "
-- 
2.26.2

