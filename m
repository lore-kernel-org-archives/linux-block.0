Return-Path: <SRS0=/PDd=CJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A182C433E7
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B002071B
	for <linux-block@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gWHfM64w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgHaSR7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgHaSR7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 14:17:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32E9C061573
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 11:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Q3fAY6+YGidtxRBrrZsqjprNhmHfs9Hw56KK0thIerI=; b=gWHfM64wVy/CGjQA9+pKcKrbjE
        W1VH+Z4uk5Paorv8lRE5LA+FZT93ayO2k7nGFZWcnVRzJh2VDo88JuZa9d0qAdUyoNDtkmeGadaiC
        KR0ZfE9LsjiwVU3IjpRfQBe7uWeA+HLphDPItv1FjnFHRNELrq3Ykp6flu+qxd2ZnCrSh8/RIg9L9
        VLymyTvb7SHwl8YkLOp41U5zi/RuILdqXNqUzI+5sRzcsPAvCL7v85j9J6443ugjdsMg/pYVCTNSf
        1C1hx8L3Pku0+zlwAftpwhsqlneBwUtoLUDG3ZSxs3rQ3cHo9YU06qHeou5mDridyOyC6HLf5R8wi
        yBGueCRw==;
Received: from [2001:4bb8:18c:45ba:9892:9e86:5202:32f0] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCoNR-0002i5-FN; Mon, 31 Aug 2020 18:17:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 7/7] block: remove the unused q argument to part_in_flight and part_in_flight_rw
Date:   Mon, 31 Aug 2020 20:02:39 +0200
Message-Id: <20200831180239.2372776-8-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831180239.2372776-1-hch@lst.de>
References: <20200831180239.2372776-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 2055b5bf637a80..5fc6d82e6c68c4 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -110,8 +110,7 @@ static void part_stat_read_all(struct hd_struct *part, struct disk_stats *stat)
 	}
 }
 
-static unsigned int part_in_flight(struct request_queue *q,
-		struct hd_struct *part)
+static unsigned int part_in_flight(struct hd_struct *part)
 {
 	unsigned int inflight = 0;
 	int cpu;
@@ -126,8 +125,7 @@ static unsigned int part_in_flight(struct request_queue *q,
 	return inflight;
 }
 
-static void part_in_flight_rw(struct request_queue *q, struct hd_struct *part,
-		unsigned int inflight[2])
+static void part_in_flight_rw(struct hd_struct *part, unsigned int inflight[2])
 {
 	int cpu;
 
@@ -1301,7 +1299,7 @@ ssize_t part_stat_show(struct device *dev,
 	if (queue_is_mq(q))
 		inflight = blk_mq_in_flight(q, p);
 	else
-		inflight = part_in_flight(q, p);
+		inflight = part_in_flight(p);
 
 	return sprintf(buf,
 		"%8lu %8lu %8llu %8u "
@@ -1343,7 +1341,7 @@ ssize_t part_inflight_show(struct device *dev, struct device_attribute *attr,
 	if (queue_is_mq(q))
 		blk_mq_in_flight_rw(q, p, inflight);
 	else
-		part_in_flight_rw(q, p, inflight);
+		part_in_flight_rw(p, inflight);
 
 	return sprintf(buf, "%8u %8u\n", inflight[0], inflight[1]);
 }
@@ -1623,7 +1621,7 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 		if (queue_is_mq(gp->queue))
 			inflight = blk_mq_in_flight(gp->queue, hd);
 		else
-			inflight = part_in_flight(gp->queue, hd);
+			inflight = part_in_flight(hd);
 
 		seq_printf(seqf, "%4d %7d %s "
 			   "%lu %lu %lu %u "
-- 
2.28.0

