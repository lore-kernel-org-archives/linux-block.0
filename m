Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB7AC7619A
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 15:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbjDEPrq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbjDEPrp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 11:47:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D11C6E95
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 08:47:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F3B9C228A5;
        Wed,  5 Apr 2023 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680709597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KriKWBgyaGStn0k/pyyPULz1XbvMdnHcfTtuEj30UFk=;
        b=hXI7/+RAmDrKYDmb/PL0Vk+RHGyndaRKR/Wy2HdNHbFej/Dd0Pwe/mX2lt6ARQNSRkg0E1
        J5virmxIoe+5CwxT0MoTJolq/LsE1hXNF6dMMACEUrUTQh0ReRrXyqKkEiqu8lhU3vjNrH
        xGGOZ+QDQ5hy/zhXbqYN3d6g2m/hMc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680709597;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KriKWBgyaGStn0k/pyyPULz1XbvMdnHcfTtuEj30UFk=;
        b=7S+5P+EQs7nrqjsSfLuXUYSr7Yx3q7awzcMlT3F/Gc7RZMutAcNS9ZvTIbi8AWuv7jwEXc
        1RuoBt4JuaWN1HAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5D0213A10;
        Wed,  5 Apr 2023 15:46:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qaUvONyXLWTeNgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 05 Apr 2023 15:46:36 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v5 3/4] nvme/rc: Add helper to wait for nvme ctrl state
Date:   Wed,  5 Apr 2023 17:46:29 +0200
Message-Id: <20230405154630.16298-4-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405154630.16298-1-dwagner@suse.de>
References: <20230405154630.16298-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function waits until it sees a given state (or timeouts).
Unfortunately, we can't use /sys/class/nvme/nvme%d because this symlink
will be removed if the controller is going through resetting state. Thus
use the real nvme%d directly.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index e720a35113aa..ae4a69fe8438 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -16,6 +16,7 @@ def_local_wwnn="0x10001100aa000002"
 def_local_wwpn="0x20001100aa000002"
 def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
 def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
+def_state_timeout=20
 nvme_trtype=${nvme_trtype:-"loop"}
 
 _nvme_requires() {
@@ -198,6 +199,28 @@ _nvme_fcloop_del_tport() {
 	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/del_target_port 2> /dev/null
 }
 
+_nvmf_wait_for_state() {
+	local subsys_name="$1"
+	local state="$2"
+	local timeout="${3:-$def_state_timeout}"
+
+	local nvmedev=$(_find_nvme_dev "${subsys_name}")
+	local state_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/state"
+
+	local start_time=$(date +%s)
+	local end_time
+
+	while ! grep -q "${state}" "${state_file}"; do
+		sleep 1
+		end_time=$(date +%s)
+                if (( end_time - start_time > timeout )); then
+                        echo "expected state \"${state}\" not " \
+			     "reached within ${timeout} seconds"
+                        break
+                fi
+	done
+}
+
 _cleanup_fcloop() {
 	local local_wwnn="${1:-$def_local_wwnn}"
 	local local_wwpn="${2:-$def_local_wwpn}"
-- 
2.40.0

