Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E156C5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 10:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6362081B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 10:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AOYPNv6/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB6362081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbeLKKuE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:50:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:58322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLKKuE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 05:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E7bYPCWGrph1P1/NkRkn2dznOK+J7KtiEK/gajlmlas=; b=AOYPNv6/A7uS6ho1QrsSE3hGr
        4OjJsWqkFrho6y675DyilyN+nfc6t5EpEIbdudSdanu5wMofLXPvpRLqfZuvTqFnn67TMeY6qIBtd
        YXEe3JQLxqUYecIbzw32ecktAI1fbGD0PBsH1im6ftPaIMcO4HH+vTTzt9FIPSgfwdhn9G8QhqROi
        bxUxZMzbmM7RZ1CCPfmLhbboWegxGSELZPZOSaUfGsde8FqPj0eyJKhntPLt0YdonyfoyedjBz/dw
        aawI0QHCCI2z6iu8cgLkrh4YjfwIS20A8Fg4cpC4VU07ctrPwSwpiQMJHqJOeOw1hb4VZKxx329D+
        UURT0fprQ==;
Received: from [2601:647:4800:973f:7888:b13c:bff:87b0] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWfbe-0004p6-Fi; Tue, 11 Dec 2018 10:49:38 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH nvme-cli 6/5] fabrics: pass in nr_write_queues
Date:   Tue, 11 Dec 2018 02:49:36 -0800
Message-Id: <20181211104936.25333-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211104936.25333-1-sagi@grimberg.me>
References: <20181211104936.25333-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

nr_write_queues specifies the number of queues additional to nr_io_queues
will be connected. These queues will host write I/O (host to target
payload) while nr_io_queues will host read I/O (target to host payload).

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 fabrics.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 93f3410a1c72..55ce2ba79c4f 100644
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
+		{"nr_write_queues",  'W', "LIST", CFG_INT, &cfg.nr_write_queues,    required_argument, "number of write queues to use (default 0)" },
 		{"queue-size",      'Q', "LIST", CFG_INT, &cfg.queue_size,      required_argument, "number of io queue elements to use (default 128)" },
 		{"keep-alive-tmo",  'k', "LIST", CFG_INT, &cfg.keep_alive_tmo,  required_argument, "keep alive timeout period in seconds" },
 		{"reconnect-delay", 'c', "LIST", CFG_INT, &cfg.reconnect_delay, required_argument, "reconnect timeout period in seconds" },
-- 
2.17.1

