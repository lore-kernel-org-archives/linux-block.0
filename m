Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97980C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7AF2082F
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b6Iu3sQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C7AF2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbeK3CxD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:53:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbeK3CxD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 21:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zgjExX5/1RM4Ye3X3U+aV2gVVIw/T/MJ2C8WhedDUbs=; b=b6Iu3sQdc+FnYcRZXy1PEybKn
        Bs4eORFTg9E4IeKtdhVC8Fbbd0unPFio1u+MlrVHPKQOn2t4KaX6xXajSTOwk1DnbAnF77KmFxstk
        G7WXQ5PuRjLS2SmIzQ+Zh0rvsnIMbHfG5iOECWr5KV7lq8M2MMQ2u85CXGmqKZ3Xt43wrFymwsC9t
        eEIqjFZgTCT+OFeg5uLDBmT04XmlMcMQ03R8DYg+F+iIWe0KSmBhzYQ4FKOwdp7JgAskquIlgakCI
        kevEp0CByKnsGgDsliTK9edOM/n9pVvo2pmaurmYcu/cEAwMrVkYWW2V+2tr2zveGzfyirYnJ7E3J
        6qv+FDW+A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSOX4-0004Jg-1Y; Thu, 29 Nov 2018 15:47:14 +0000
Date:   Thu, 29 Nov 2018 07:47:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/7] nvme: implement mq_ops->commit_rqs() hook
Message-ID: <20181129154713.GC7234@infradead.org>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128133538.20329-4-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static inline int nvme_next_ring_index(struct nvme_queue *nvmeq, u16 index)
> +{
> +	if (++index == nvmeq->q_depth)
> +		return 0;
> +
> +	return index;
> +}

This is unused now.

Also what about this little cleanup on top?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 42472bd0cfed..527907aa6903 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -523,22 +523,26 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 	return 0;
 }
 
-static inline void nvme_write_sq_db(struct nvme_queue *nvmeq)
+/*
+ * Write sq tail if we are asked to, or if the next command would wrap.
+ */
+static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 {
+	if (!write_sq) {
+		u16 next_tail = nvmeq->sq_tail + 1;
+
+		if (next_tail == nvmeq->q_depth)
+			next_tail = 0;
+		if (next_tail != nvmeq->last_sq_tail)
+			return;
+	}
+
 	if (nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
 			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
 		writel(nvmeq->sq_tail, nvmeq->q_db);
 	nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
 
-static inline int nvme_next_ring_index(struct nvme_queue *nvmeq, u16 index)
-{
-	if (++index == nvmeq->q_depth)
-		return 0;
-
-	return index;
-}
-
 /**
  * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -548,24 +552,11 @@ static inline int nvme_next_ring_index(struct nvme_queue *nvmeq, u16 index)
 static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 			    bool write_sq)
 {
-	u16 next_tail;
-
 	spin_lock(&nvmeq->sq_lock);
-
 	memcpy(&nvmeq->sq_cmds[nvmeq->sq_tail], cmd, sizeof(*cmd));
-
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-
-	next_tail = nvmeq->sq_tail + 1;
-	if (next_tail == nvmeq->q_depth)
-		next_tail = 0;
-
-	/*
-	 * Write sq tail if we have to, OR if the next command would wrap
-	 */
-	if (write_sq || next_tail == nvmeq->last_sq_tail)
-		nvme_write_sq_db(nvmeq);
+	nvme_write_sq_db(nvmeq, write_sq);
 	spin_unlock(&nvmeq->sq_lock);
 }
 
@@ -575,7 +566,7 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 
 	spin_lock(&nvmeq->sq_lock);
 	if (nvmeq->sq_tail != nvmeq->last_sq_tail)
-		nvme_write_sq_db(nvmeq);
+		nvme_write_sq_db(nvmeq, true);
 	spin_unlock(&nvmeq->sq_lock);
 }
 
