Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816EBC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 06:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461E82087F
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 06:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aJUm8D0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461E82087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeLMGiX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:38:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35064 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbeLMGiX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 01:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+dF7d4lFmK4aEgkQcqtZa7QfZBaKysEeaOd5SLzf1CY=; b=aJUm8D0beZHAdwNj0cECaGAHu
        UMtL5cWkBxlvL31zzgsvlPP7+GDAjvjNCjsDpVDaQjWTiX7+Yxl6fhseZYkV8eBiqpX4NaLn8JaDe
        Jb1r6KaRCRsbGNiZrPE8cadBShEBZuqu7P9MeYay0D/iDL++Qaro5HOsXrbXcpeW3dnntKp+8gC5r
        tX0OQdNkE8YPnNkYXrtRnf68Pu5hdC1qcX4PIFKP/jmfwnwP/JAxRgaR9xBGxt8DPAYgOPdbw3tDh
        9lL1P5y1wa5FICLhEfIHrd9S8hhzIMUkJW1/nK5y8nB4QOktEzSa9xX169ifijaQb2BP924TbIdQU
        o6jp3JSgQ==;
Received: from [2601:647:4800:973f:7888:b13c:bff:87b0] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXKda-0006LR-2j; Thu, 13 Dec 2018 06:38:22 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 nvme-cli 7/6] fabrics: pass in number of polling queues
Date:   Wed, 12 Dec 2018 22:38:19 -0800
Message-Id: <20181213063819.13614-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213063819.13614-1-sagi@grimberg.me>
References: <20181213063819.13614-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nr_poll_queues specifies the number of additional queues that will
be connected for hosting polling latency critical I/O.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 Documentation/nvme-connect.txt |  5 +++++
 fabrics.c                      | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/nvme-connect.txt b/Documentation/nvme-connect.txt
index d4a0e6678475..5412472dbd35 100644
--- a/Documentation/nvme-connect.txt
+++ b/Documentation/nvme-connect.txt
@@ -17,6 +17,7 @@ SYNOPSIS
 		[--hostnqn=<hostnqn>      | -q <hostnqn>]
 		[--nr-io-queues=<#>       | -i <#>]
 		[--nr-write-queues=<#>    | -W <#>]
+		[--nr-poll-queues=<#>     | -P <#>]
 		[--queue-size=<#>         | -Q <#>]
 		[--keep-alive-tmo=<#>     | -k <#>]
 		[--reconnect-delay=<#>    | -c <#>]
@@ -80,6 +81,10 @@ OPTIONS
 --nr-write-queues=<#>::
 	Adds additional queues that will be used for write I/O.
 
+-P <#>::
+--nr-poll-queues=<#>::
+	Adds additional queues that will be used for polling latency sensitive I/O.
+
 -Q <#>::
 --queue-size=<#>::
 	Overrides the default number of elements in the I/O queues created
diff --git a/fabrics.c b/fabrics.c
index 5cc1a795345a..efe2ce89cdca 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -54,6 +54,7 @@ static struct config {
 	char *hostid;
 	int  nr_io_queues;
 	int  nr_write_queues;
+	int  nr_poll_queues;
 	int  queue_size;
 	int  keep_alive_tmo;
 	int  reconnect_delay;
@@ -624,6 +625,8 @@ static int build_options(char *argstr, int max_len)
 				cfg.nr_io_queues) ||
 	    add_int_argument(&argstr, &max_len, "nr_write_queues",
 				cfg.nr_write_queues) ||
+	    add_int_argument(&argstr, &max_len, "nr_poll_queues",
+				cfg.nr_poll_queues) ||
 	    add_int_argument(&argstr, &max_len, "queue_size", cfg.queue_size) ||
 	    add_int_argument(&argstr, &max_len, "keep_alive_tmo",
 				cfg.keep_alive_tmo) ||
@@ -704,6 +707,13 @@ retry:
 		p += len;
 	}
 
+	if (cfg.nr_poll_queues) {
+		len = sprintf(p, ",nr_poll_queues=%d", cfg.nr_poll_queues);
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
 	if (cfg.host_traddr) {
 		len = sprintf(p, ",host_traddr=%s", cfg.host_traddr);
 		if (len < 0)
-- 
2.17.1

