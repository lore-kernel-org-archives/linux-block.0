Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C95C6783C
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC3120870
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E8ydGBoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBC3120870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeLKXfa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:35:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbeLKXf3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:35:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LL1dS1qTTUl9WO8m3Sk44J2lSK4k++Yl0Zt60QAejPo=; b=E8ydGBoSEDwJxWVlia7sjD9ev
        wkV5nAiA0obW7imtoo4WAG0JhQqxDzzCQ8j6WTsAnKhsCZ5uE6rxqx/nuR98DVUsrNkh1tm5S9paM
        KfC0hnG23HEqqV+La3QSCos2UGcJ0Fc2YZRVwVMUYIaf4INbHUBpUqGDPcUP0mFi0CyofpXfj8IWN
        jr72zBQKOqmEt45xYbdL33CGgvCV2ei+tWHU1nw1VHDlDzxPGeTEt/H+nBUoAy1Zsx4DkEeVppmGp
        yTCDc9/DCgPQg4fSD8t/zoOjPLwSlxeP7t18sALaNPCVcdrEdEPm6NMvj0XrnJdzE2JwwCOrZRMix
        dlLVeobIw==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWrYi-0002L4-5G; Tue, 11 Dec 2018 23:35:24 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH v2 nvme-cli 6/5] fabrics: pass in number of write queues
Date:   Tue, 11 Dec 2018 15:35:19 -0800
Message-Id: <20181211233519.9350-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211233519.9350-1-sagi@grimberg.me>
References: <20181211233519.9350-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nr_write_queues specifies the number of additional queues that
will be connected. These queues will host write I/O (host to target
payload) while nr_io_queues will host read I/O (target to host payload).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 Documentation/nvme-connect.txt |  5 +++++
 fabrics.c                      | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/nvme-connect.txt b/Documentation/nvme-connect.txt
index af78b2a8238f..d4a0e6678475 100644
--- a/Documentation/nvme-connect.txt
+++ b/Documentation/nvme-connect.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 		[--host-traddr=<traddr>   | -w <traddr>]
 		[--hostnqn=<hostnqn>      | -q <hostnqn>]
 		[--nr-io-queues=<#>       | -i <#>]
+		[--nr-write-queues=<#>    | -W <#>]
 		[--queue-size=<#>         | -Q <#>]
 		[--keep-alive-tmo=<#>     | -k <#>]
 		[--reconnect-delay=<#>    | -c <#>]
@@ -75,6 +76,10 @@ OPTIONS
 --nr-io-queues=<#>::
 	Overrides the default number of I/O queues create by the driver.
 
+-W <#>::
+--nr-write-queues=<#>::
+	Adds additional queues that will be used for write I/O.
+
 -Q <#>::
 --queue-size=<#>::
 	Overrides the default number of elements in the I/O queues created
diff --git a/fabrics.c b/fabrics.c
index 93f3410a1c72..bc6a0b7e4e21 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -53,6 +53,7 @@ static struct config {
 	char *hostnqn;
 	char *hostid;
 	int  nr_io_queues;
+	int  nr_write_queues;
 	int  queue_size;
 	int  keep_alive_tmo;
 	int  reconnect_delay;
@@ -621,6 +622,8 @@ static int build_options(char *argstr, int max_len)
 		    add_argument(&argstr, &max_len, "hostid", cfg.hostid)) ||
 	    add_int_argument(&argstr, &max_len, "nr_io_queues",
 				cfg.nr_io_queues) ||
+	    add_int_argument(&argstr, &max_len, "nr_write_queues",
+				cfg.nr_write_queues) ||
 	    add_int_argument(&argstr, &max_len, "queue_size", cfg.queue_size) ||
 	    add_int_argument(&argstr, &max_len, "keep_alive_tmo",
 				cfg.keep_alive_tmo) ||
@@ -694,6 +697,13 @@ retry:
 		p += len;
 	}
 
+	if (cfg.nr_write_queues) {
+		len = sprintf(p, ",nr_write_queues=%d", cfg.nr_write_queues);
+		if (len < 0)
+			return -EINVAL;
+		p += len;
+	}
+
 	if (cfg.host_traddr) {
 		len = sprintf(p, ",host_traddr=%s", cfg.host_traddr);
 		if (len < 0)
@@ -1009,6 +1019,7 @@ int connect(const char *desc, int argc, char **argv)
 		{"hostnqn",         'q', "LIST", CFG_STRING, &cfg.hostnqn,         required_argument, "user-defined hostnqn" },
 		{"hostid",          'I', "LIST", CFG_STRING, &cfg.hostid,      required_argument, "user-defined hostid (if default not used)"},
 		{"nr-io-queues",    'i', "LIST", CFG_INT, &cfg.nr_io_queues,    required_argument, "number of io queues to use (default is core count)" },
+		{"nr-write-queues",  'W', "LIST", CFG_INT, &cfg.nr_write_queues,    required_argument, "number of write queues to use (default 0)" },
 		{"queue-size",      'Q', "LIST", CFG_INT, &cfg.queue_size,      required_argument, "number of io queue elements to use (default 128)" },
 		{"keep-alive-tmo",  'k', "LIST", CFG_INT, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
 		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
-- 
2.17.1

