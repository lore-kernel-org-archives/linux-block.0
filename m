Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A85C3A5A1
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E28523401
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Wji5OPkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfHWAPc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 20:15:32 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30876 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbfHWAPc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 20:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566519332; x=1598055332;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=AZXywgRcoKRoM0uXmO6JmAnLjhTdPgMFw+Criebpuyo=;
  b=Wji5OPkbSO0AzlUODh9jChPiVTwvxv+KtMKJNc8jnUpmn6yhSHgYofFD
   nFTTXqZDgJ41d8CWokmuEYFsrT/RNlnIoc4Z+2KQdOo6SCKqv8HInSsZv
   FWow3p9kLs23HptjSCJzPgjiH/TJUs3N/tX/1NcNNFeDFTVmtGZmyHvbo
   va8zKWNUvdBz44VbKqCocmB+sWwkiy6Glkb0ijzy8Nnr5tIDyEsK4N2mz
   S8safjnLltPypBMRdPPkXn0HVLLsyFz/xD3HaLMiCoHeZ1UpWnZDcs/2M
   HvHodYMZjB2j/sS+jBGtm4u8k1iPFqXxPX53GP/FcDVt4VhTb0/ybV/ub
   A==;
IronPort-SDR: ARk1dZoAbUhTQWtzoUfd24XIo8b5GknecReNJKGxVP1o3x1rpzpVFEYm+F94tkxpz6upo8kbHG
 VADnh8xQ7aeMuHXC3G1n0BrCb441w7EcFlcqxJFEan42+nSzCu3Jm9I2aAgsvlFH75pT8gXaex
 7d3yMNZy547fSiOFBMmig3b0Goi4GTDP8FgwM2aOwDTlSThcjPnwOx2E8ukjku8ZHlB6G1qj+Q
 SxEZIp7ZEC3Kn9DgaMw4cn90m2e90Z/9NHBMGGlcRIyHWY6kaMJc+9dsUbwvDq0eqsLbf2Eyjq
 luw=
X-IronPort-AV: E=Sophos;i="5.64,419,1559491200"; 
   d="scan'208";a="121063667"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 08:15:32 +0800
IronPort-SDR: BQYBqIIl0BiPFq4ABMJnmuD7jbPOpoRwN4c8DyiHbLMuTxine+Ef5e9khX9Qm8j0Ia57IvBVHB
 ath8YgaJS0r+IA0LIwlAw1mVFH3nM5zD5tAJg1P/UUSSVb2K7Sj2E+iHfDHfQCED8IKCjFKmsN
 +G4mjsiVed048qDnqgzAgW5iOwvZRWFbIB8tCx9be6lOH+JnGx1UjCmAvpFCnP8JDA4S4vn4b/
 dtXfP+kdtl3uq+rK0D8Z5lz/W0zpJxMnyslzXY2UdNUt8UexH1a9uqExncxdggIvaVMx4PtZ0D
 6ie4w1IEJRrHWqYUoRiRhQxh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 17:12:51 -0700
IronPort-SDR: MobddehZuMTCSEmguSJzwirGd8SFwojqpS/Uyh8Dkn6Nz5yXIq9zoU4HZtkUJvc01331QITFGl
 Z76OcrVLj0cYPMr+VF3uUv3Q7g1ER3yAXvA1IdDFLMF8/tr63LtrRlreystqFE3sKBMGf+qCTg
 VvO0u+WvRcVVFsvlG5jm1VlFiebCAe5NX7jkaR6TcWgQcMGA+r73O/QOmiBPPVpnVEqxFet+JP
 xw1p/ya5F6rOMNwPhNWK6tHUT9b08nFhO/zMgTYu1e9wytPfd5PUIaW2GZSmcl5coh7C6T4jLi
 VVA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Aug 2019 17:15:31 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/7] block: Remove sysfs lock from elevator_init_rq()
Date:   Fri, 23 Aug 2019 09:15:24 +0900
Message-Id: <20190823001528.5673-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823001528.5673-1-damien.lemoal@wdc.com>
References: <20190823001528.5673-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since elevator_init_rq() is called before the device queue is registered
in sysfs, there is no possible conflict with elevator_switch(). Remove
the unnecessary locking of q->sysfs_lock mutex.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/elevator.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 7fff06751633..6208ddc334ef 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -617,17 +617,12 @@ void elevator_init_mq(struct request_queue *q)
 	if (q->nr_hw_queues != 1)
 		return;
 
-	/*
-	 * q->sysfs_lock must be held to provide mutual exclusion between
-	 * elevator_switch() and here.
-	 */
-	mutex_lock(&q->sysfs_lock);
 	if (unlikely(q->elevator))
-		goto out_unlock;
+		return;
 
 	e = elevator_get(q, "mq-deadline", false);
 	if (!e)
-		goto out_unlock;
+		return;
 
 	err = blk_mq_init_sched(q, e);
 	if (err) {
@@ -635,9 +630,6 @@ void elevator_init_mq(struct request_queue *q)
 			"falling back to \"none\"\n", e->elevator_name);
 		elevator_put(e);
 	}
-
-out_unlock:
-	mutex_unlock(&q->sysfs_lock);
 }
 
 
-- 
2.21.0

