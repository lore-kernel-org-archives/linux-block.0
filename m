Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CF0C433EF
	for <linux-block@archiver.kernel.org>; Mon, 13 Jun 2022 18:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244943AbiFMSop (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245622AbiFMSoU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Jun 2022 14:44:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DA0DB364
        for <linux-block@vger.kernel.org>; Mon, 13 Jun 2022 08:17:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A89B621B94;
        Mon, 13 Jun 2022 15:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655133446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5XGvE6a11G1pe4IdfgztNVcwtiKfHEawmpfq5SOcOIA=;
        b=zhSdd/PmcBa0m067W7OaScvcCrkPAN0eRQYGUdSE8Rt4TiZjtwuIcw9vpSSlhUVNCN1873
        /TY5O5ZemAQBgel0n51kK5t+kbd/Xxs2353pennJ5US5X7hD+bnLlsgJNa1S04E1YW/HyU
        8HgrpfjZmPBV74cWTs+8g+0MZHiYeWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655133446;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5XGvE6a11G1pe4IdfgztNVcwtiKfHEawmpfq5SOcOIA=;
        b=T2roQafyYk0zUuKfxmnI4QJnz66pMhyVUm2jXuAEhZSFQMVPgORuh7UgvYs7gB+dIkQZXA
        pYoeoiKIEQH/B8CQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9A99A2C141;
        Mon, 13 Jun 2022 15:17:26 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 348CFA0634; Mon, 13 Jun 2022 17:17:26 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     osandov@fb.com
Cc:     <linux-block@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] blktests: Ignore errors from wait(1)
Date:   Mon, 13 Jun 2022 17:17:21 +0200
Message-Id: <20220613151721.18664-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Multiple blktests use wait(1) to wait for background tasks. However in
some cases tasks can exit before wait(1) is called and in that case
wait(1) complains which breaks expected output. Make sure we ignore
output from wait(1) to avoid this breakage.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/block/016 | 2 +-
 tests/block/017 | 2 +-
 tests/block/018 | 2 +-
 tests/block/024 | 2 +-
 tests/block/029 | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/block/016 b/tests/block/016
index 775069c..d399ec6 100755
--- a/tests/block/016
+++ b/tests/block/016
@@ -41,7 +41,7 @@ test() {
 	# While dd is blocked, send a signal which we know dd has a handler
 	# for.
 	kill -USR1 $!
-	wait
+	wait &>/dev/null
 
 	_exit_null_blk
 
diff --git a/tests/block/017 b/tests/block/017
index 8596888..ff68e24 100755
--- a/tests/block/017
+++ b/tests/block/017
@@ -40,7 +40,7 @@ test() {
 	sleep 0.1
 	show_inflight
 
-	wait
+	wait &>/dev/null
 	show_inflight
 
 	_exit_null_blk
diff --git a/tests/block/018 b/tests/block/018
index e7ac445..d2c97ea 100755
--- a/tests/block/018
+++ b/tests/block/018
@@ -50,7 +50,7 @@ test() {
 	dd if=/dev/nullb1 of=/dev/null bs=4096 iflag=direct count=1 status=none &
 	dd if=/dev/zero of=/dev/nullb1 bs=4096 oflag=direct count=1 status=none &
 	dd if=/dev/zero of=/dev/nullb1 bs=4096 oflag=direct count=1 status=none &
-	wait
+	wait &>/dev/null
 	show_times
 
 	_exit_null_blk
diff --git a/tests/block/024 b/tests/block/024
index 2a7c934..dd99f0c 100755
--- a/tests/block/024
+++ b/tests/block/024
@@ -57,7 +57,7 @@ test() {
 	dd if=/dev/nullb1 of=/dev/null bs=4096 iflag=direct count=1500 status=none &
 	dd if=/dev/zero of=/dev/nullb1 bs=4096 oflag=direct count=1800 status=none &
 	dd if=/dev/zero of=/dev/nullb1 bs=4096 oflag=direct count=1800 status=none &
-	wait
+	wait &>/dev/null
 	show_times
 
 	_exit_null_blk
diff --git a/tests/block/029 b/tests/block/029
index b9a897d..cb8fd03 100755
--- a/tests/block/029
+++ b/tests/block/029
@@ -41,7 +41,7 @@ test() {
 		    --runtime="${TIMEOUT}" --name=nullb1 \
 		    --output="${RESULTS_DIR}/block/fio-output-029.txt" \
 		    >>"$FULL"
-		wait
+		wait &>/dev/null
 	else
 		echo "Skipping test because $sq cannot be modified" >>"$FULL"
 	fi
-- 
2.26.2

