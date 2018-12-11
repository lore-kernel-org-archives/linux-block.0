Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F70C07E85
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 06:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15472082F
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 06:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u55Is/qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15472082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeLKGRK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 01:17:10 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46884 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbeLKGRJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 01:17:09 -0500
Received: by mail-pl1-f194.google.com with SMTP id t13so6423609ply.13;
        Mon, 10 Dec 2018 22:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TlYVShGWQfqCikX7zIfo6dSj8lcXrBBDWQwIm/PzWAQ=;
        b=u55Is/qA0pSseLvGvzYgxvg44ykhaYLA1P4+SfTntUm/1jRq5p7qJiQ82p0EdWsWni
         cdvBxrnGCavkp5pqneI/M2ZusPoIRlDM5rLfqYNyRTCAXLOadKxh/huIBzcXV+RJRkqu
         WaRrwWxdL53tDisAlhgvyZC3eJvj4tR1M0xxQaJAlJ8N0mxjKisR6jiVAkywiRAAAXyh
         x63D8vDM1Ydvsgb86/tzzVtyLBnFYitf18eB7h2HHynwSTbA/65xpbvo0IyF1fQ63nv8
         dpMDV3QxZTn0idAZcy07VA0/DG2cTvC3ZrQpNIGSavewgqms8TirjIKom8g+K/0xwIZs
         p/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TlYVShGWQfqCikX7zIfo6dSj8lcXrBBDWQwIm/PzWAQ=;
        b=m/f2KiVNnDXd3jv0IZRlpdIuWYqChCpuImIXmRHyqmt3+yru9W4IJOzncGVFTlTYI8
         xC9hi5x5R6T4eNSlJyCF9Wh9TQ48Fi3J1VS7MfnpQEU586kicsPjFFcwbdqF8RA4W9Q1
         os6cJtcoPWX4MNVOPPcXBkn2XfmFBklBmkN55s7NOSGel8IjzDvBoROxuJHX4JPnHERt
         GW4v0JnMC6i9dYxtMvLUX3uqDFgfp+LLDezjXuNYE4IDoxtX6iOhKBSiBVWMnxI+yY3L
         8yDlVLi6pCHw1XFs2Vxvq/5Oe3tywst+0bKoVCmob/yHKwz89xTh+W6g0UFqAkq+rtbZ
         xtwQ==
X-Gm-Message-State: AA+aEWYLuLVIzzBwKxQ9UsZJxKMmlA3heL0bq5nnU6XcpShk11zChhEm
        ZCdjZxp2V2DkjvkDxdiTfMI=
X-Google-Smtp-Source: AFSGD/WtGwEGzXbzvfgEkVr2zxQ5RWgAx4+tVSYC1KALczRjt5jgzWAy5EcN525T7eCRDfgAiwvC+w==
X-Received: by 2002:a17:902:722:: with SMTP id 31mr14992831pli.271.1544509029167;
        Mon, 10 Dec 2018 22:17:09 -0800 (PST)
Received: from localhost.localdomain (27-52-137-213.adsl.fetnet.net. [27.52.137.213])
        by smtp.gmail.com with ESMTPSA id e16sm16246045pfn.46.2018.12.10.22.17.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 22:17:08 -0800 (PST)
From:   medadyoung@gmail.com
To:     jbacik@fb.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Medad <medadyoung@gmail.com>
Subject: [PATCH] nbd:clear NBD_BOUND flag when NBD connection is closed
Date:   Tue, 11 Dec 2018 14:17:03 +0800
Message-Id: <1544509023-18923-1-git-send-email-medadyoung@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Medad <medadyoung@gmail.com>

    If we do NOT clear NBD_BOUND flag when NBD connection is closed,
    then the original NBD device could not be used again.

Signed-off-by: Medad <medadyoung@gmail.com>
---
 drivers/block/nbd.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 64278f4..5c88490 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -277,10 +277,14 @@ static void sock_shutdown(struct nbd_device *nbd)
 	struct nbd_config *config = nbd->config;
 	int i;
 
-	if (config->num_connections == 0)
+	if (config->num_connections == 0) {
+		clear_bit(NBD_BOUND, &config->runtime_flags);
 		return;
-	if (test_and_set_bit(NBD_DISCONNECTED, &config->runtime_flags))
+	}
+	if (test_and_set_bit(NBD_DISCONNECTED, &config->runtime_flags)) {
+		clear_bit(NBD_BOUND, &config->runtime_flags);
 		return;
+	}
 
 	for (i = 0; i < config->num_connections; i++) {
 		struct nbd_sock *nsock = config->socks[i];
@@ -944,7 +948,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 		sockfd_put(old);
 
 		clear_bit(NBD_DISCONNECTED, &config->runtime_flags);
-
+		clear_bit(NBD_BOUND, &config->runtime_flags);
 		/* We take the tx_mutex in an error path in the recv_work, so we
 		 * need to queue_work outside of the tx_mutex.
 		 */
@@ -1020,6 +1024,7 @@ static int nbd_disconnect(struct nbd_device *nbd)
 	dev_info(disk_to_dev(nbd->disk), "NBD_DISCONNECT\n");
 	set_bit(NBD_DISCONNECT_REQUESTED, &config->runtime_flags);
 	send_disconnects(nbd);
+	clear_bit(NBD_BOUND, &config->runtime_flags);
 	return 0;
 }
 
-- 
2.7.4

