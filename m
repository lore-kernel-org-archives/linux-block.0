Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF651C6FD18
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 09:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjC2JCt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 05:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjC2JCj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 05:02:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AA84688
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 02:02:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B0DF5219E8;
        Wed, 29 Mar 2023 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680080525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AHWeEdeCHqqBY/im3wOsoSiaR35kDE0egEtQWNVv+UU=;
        b=MvboyGO1sjp5ugq7nwvlVnGSATJdntH5Q88kFfCRexau2+W+mPLk4QvsbhFz+FOeFvaPIg
        4t8iRnkJHwVzzQKvsIAHJGcRxnAaQZHLmwIFi13KT1I2iJatr4y3pxls3km44O6pFaUin6
        LibQr0DY4rdHLbh3AqH6CMQI7Jo7Evc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680080525;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AHWeEdeCHqqBY/im3wOsoSiaR35kDE0egEtQWNVv+UU=;
        b=/r8Rvlop8Vi5Xgjf1Iip7RPw/CU2MotfIXO5LC1UjKnodXdzY0GHr38UXDyp56UIHAZE2k
        7GPSIICktVoXFEBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A326B138FF;
        Wed, 29 Mar 2023 09:02:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8m+qJ43+I2RadgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 29 Mar 2023 09:02:05 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 2/4] nvme/rc: Add nr queue parser arguments to _nvme_connect_subsys()
Date:   Wed, 29 Mar 2023 11:02:00 +0200
Message-Id: <20230329090202.8351-3-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230329090202.8351-1-dwagner@suse.de>
References: <20230329090202.8351-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 20c5e2fa32cb..c1bb08be511a 100644
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
@@ -357,6 +360,18 @@ _nvme_connect_subsys() {
 				ctrlkey="$2"
 				shift 2
 				;;
+			-i|--nr-io-queues)
+				nr_io_queues="$2"
+				shift 2
+				;;
+			-W|--nr-write-queues)
+				nr_write_queues="$2"
+				shift 2
+				;;
+			-P|--nr-poll-queues)
+				nr_poll_queues="$2"
+				shift 2
+				;;
 			*)
 				positional_args+=("$1")
 				shift
@@ -387,6 +402,16 @@ _nvme_connect_subsys() {
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

