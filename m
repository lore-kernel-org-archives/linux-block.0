Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB0DC6FD1F
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 10:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjCVKQ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 06:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjCVKQz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 06:16:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43DF5B437
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 03:16:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 94BC8339B3;
        Wed, 22 Mar 2023 10:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1679480213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VUkysKhNingyeMfZ0KjMwZybzXM1TI6WNetcJwrtqg4=;
        b=fBJPRHBolQ8VfgVkmsUWiKZeIRPUAq83u8n0964lD9ldMxe62SX7h6mAurmamoGtWwmPA4
        ido+ykiGwxrmdn9ukwUdO21dmdW25cdQDqE+oNdDyC7UHfx+KV1JR3aDHbmIrx7II78WrZ
        yydvPD3nw5jQB+xHIv75P/a9HtTzw7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1679480213;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VUkysKhNingyeMfZ0KjMwZybzXM1TI6WNetcJwrtqg4=;
        b=tQFMT4gD/EKigeXRrckkubzJDTx0T93HWSyNgG/LoYgpfeOtDaIfWoD4xNMwiR1T7nTVHQ
        QXu7p7uNQYzj+nCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 883E9138E9;
        Wed, 22 Mar 2023 10:16:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id COLjIJXVGmSCDAAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 22 Mar 2023 10:16:53 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 2/3] nvme/rc: Add nr queue parser arguments
Date:   Wed, 22 Mar 2023 11:16:47 +0100
Message-Id: <20230322101648.31514-3-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230322101648.31514-1-dwagner@suse.de>
References: <20230322101648.31514-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1145fed2d14c..ca3d995f7b0b 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -326,6 +326,9 @@ _nvme_connect_subsys() {
 	local hostid="$def_hostid"
 	local hostkey=""
 	local ctrlkey=""
+	local nr_io_queues=""
+	local nr_write_queues=""
+	local nr_poll_queues=""
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -364,6 +367,21 @@ _nvme_connect_subsys() {
 				shift
 				shift
 				;;
+			-i|--nr-io-queues)
+				nr_io_queues="$2"
+				shift
+				shift
+				;;
+			-W|--nr-write-queues)
+				nr_write_queues="$2"
+				shift
+				shift
+				;;
+			-P|--nr-poll-queues)
+				nr_poll_queues="$2"
+				shift
+				shift
+				;;
 			*)
 				positional_args+=("$1")
 				shift
@@ -394,6 +412,16 @@ _nvme_connect_subsys() {
 	if [[ -n "${ctrlkey}" ]]; then
 		ARGS+=(--dhchap-ctrl-secret="${ctrlkey}")
 	fi
+	if [[ -n "${nr_io_queues}" ]]; then
+		ARGS+=(--nr-io-queues="${nr_io_queues}")
+	fi
+	if [[ -n "${nr_write_queues}" ]]; then
+		ARGS+=(--nr-write-queues="${nr_write_queues}")
+	fi
+	if [[ -n "${nr_poll_queues}" ]]; then
+		ARGS+=(--nr-poll-queues="${nr_poll_queues}")
+	fi
+
 	nvme connect "${ARGS[@]}" 2> /dev/null
 }
 
-- 
2.40.0

