Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D17C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 08:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbjDFIa7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjDFIa6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 04:30:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00B17281
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 01:30:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4A28D1FF2A;
        Thu,  6 Apr 2023 08:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680769855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8Ct3r+MAAuYTQfED7hD0ME3xkyBJsbN9HYSC4zhmVM=;
        b=Uom9IRVRB3Sk0OSXDjODRQYVa5fLaLXTQKqTp6xiJTca3IePEAvfCt5vpKo6bcraqW74Vu
        EIyjT725+2GB+JS+pb3/udTXrcC9OYFS/39izTcOJok+CfjAMokbIq0gAq5RWeXPaq6cMo
        WN5w9+5Pfx5x9YIn1VJchZjcDw6Rfxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680769855;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8Ct3r+MAAuYTQfED7hD0ME3xkyBJsbN9HYSC4zhmVM=;
        b=Gr8Z+uw/SyxioFXFUWxB1XuImbuIKJUWd5SKlTn/X+BLWgpqYGWMAtc4LGG+08467RbrJZ
        Ezsc0W+ThUlxSLAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39C2D133E5;
        Thu,  6 Apr 2023 08:30:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7r79DT+DLmTRZAAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 06 Apr 2023 08:30:55 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v6 1/2] nvme/rc: Add timeout argument parsing to _nvme_connect_subsys()
Date:   Thu,  6 Apr 2023 10:30:49 +0200
Message-Id: <20230406083050.19246-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406083050.19246-1-dwagner@suse.de>
References: <20230406083050.19246-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add the possiblity for tests to specify the timeout values. This makes
it possible to reduce the test runtime.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index a3c9b42d91e6..b44239446dcf 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -338,6 +338,9 @@ _nvme_connect_subsys() {
 	local nr_io_queues=""
 	local nr_write_queues=""
 	local nr_poll_queues=""
+	local keep_alive_tmo=""
+	local reconnect_delay=""
+	local ctrl_loss_tmo=""
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -381,6 +384,18 @@ _nvme_connect_subsys() {
 				nr_poll_queues="$2"
 				shift 2
 				;;
+			-k|--keep-alive-tmo)
+				keep_alive_tmo="$2"
+				shift 2
+				;;
+			-c|--reconnect-delay)
+				reconnect_delay="$2"
+				shift 2
+				;;
+			-l|--ctrl-loss-tmo)
+				ctrl_loss_tmo="$2"
+				shift 2
+				;;
 			*)
 				positional_args+=("$1")
 				shift
@@ -420,6 +435,15 @@ _nvme_connect_subsys() {
 	if [[ -n "${nr_poll_queues}" ]]; then
 		ARGS+=(--nr-poll-queues="${nr_poll_queues}")
 	fi
+	if [[ -n "${keep_alive_tmo}" ]]; then
+		ARGS+=(--keep-alive-tmo="${keep_alive_tmo}")
+	fi
+	if [[ -n "${reconnect_delay}" ]]; then
+		ARGS+=(--reconnect-delay="${reconnect_delay}")
+	fi
+	if [[ -n "${ctrl_loss_tmo}" ]]; then
+		ARGS+=(--ctrl-loss-tmo="${ctrl_loss_tmo}")
+	fi
 
 	nvme connect "${ARGS[@]}" 2> /dev/null
 }
-- 
2.40.0

