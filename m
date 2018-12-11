Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A4FC6783B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767DA20851
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rgjFxYra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767DA20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbeLKXhA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:37:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLKXhA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tmCUpodaC14HxdBvhUMvpC4Z0CrR1akJvM7Cmg0Tlls=; b=rgjFxYra0uaonpX4Sxq6fv9AG
        2zk83m4OFwdBCLNa2+QB9RS891ufTmRQgdE3YGacgmgk6TfeWnfJsKte/JlKLZoJsnuDF2LKMsi5g
        Smgf50ccRgfisKNJDEY+KyZAAQdFrp6P14i88jBk7hiPrcJ7rbAS5cUoMJQUvC8+KK0P0SqvYpVvS
        0bpzweECc5esYc92OGd2ZbNH2xAwhEUaHH3rWPsB8wDoLq8+1zWLV/Qlaf7noPpAxNMgBeO1ow0nQ
        ott0jrNgdzXyOb+2qLg3V2+9RIcrv3z0g/6zu/EsImDVMv3z4RJ226m8oWwrZQGiZu+ZIe21KiS6x
        GJQI/FKmA==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWraE-0003uQ-ET; Tue, 11 Dec 2018 23:36:58 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH RFC nvme-cli 5/4] fabrics: pass in number of polling queues
Date:   Tue, 11 Dec 2018 15:36:52 -0800
Message-Id: <20181211233652.9705-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211233652.9705-1-sagi@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nr_poll_queues specifies the number of additional queues that will
be connected for hosting polling latency critical I/O.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 Documentation/nvme-connect.txt |  5 +++++
 fabrics.c                      | 11 +++++++++++
 2 files changed, 16 insertions(+)

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
index bc6a0b7e4e21..214fce4c1b51 100644
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
@@ -1020,6 +1030,7 @@ int connect(const char *desc, int argc, char **argv)
 		{"hostid",          'I', "LIST", CFG_STRING, &cfg.hostid,      required_argument, "user-defined hostid (if default not used)"},
 		{"nr-io-queues",    'i', "LIST", CFG_INT, &cfg.nr_io_queues,    required_argument, "number of io queues to use (default is core count)" },
 		{"nr-write-queues",  'W', "LIST", CFG_INT, &cfg.nr_write_queues,    required_argument, "number of write queues to use (default 0)" },
+		{"nr-poll-queues",  'W', "LIST", CFG_INT, &cfg.nr_poll_queues,    required_argument, "number of poll queues to use (default 0)" },
 		{"queue-size",      'Q', "LIST", CFG_INT, &cfg.queue_size,      required_argument, "number of io queue elements to use (default 128)" },
 		{"keep-alive-tmo",  'k', "LIST", CFG_INT, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
 		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
-- 
2.17.1

