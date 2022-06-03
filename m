Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38174C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 04:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbiFCE41 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 00:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiFCE41 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 00:56:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2944136E10
        for <linux-block@vger.kernel.org>; Thu,  2 Jun 2022 21:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dSY9q8SiyA9w6r6j8Ui3CeYMf/mJmCFyCSTGI67/BE0=; b=1QAVg16R+zhuapmh9DI8tHh0HI
        xSygLP/ZdDZbkRMztLJh1NEFO0PVJu5AUwCElsnQzC8i9e+hFyRO8pTIUyWOdPXcRDIonokXVGX33
        u9evE++E9ziDrKdq4ZBL7M1H1h9G1k22LEzXNLIkS+2i2lwfBz/sVaDjBOUUY97odI+/qCEtUCPu6
        QCcdQbAreywlY0TGue74k7emqk8hqgJN2iXzoonXfLM5kg17ROSnrJypI2bTt8Y7zPAiZ/jXuQmTV
        2iSnVPLcvR1VrXOFWKR297XYyiDD+s2DTKrWu3WFi103Cz1iD4im/vK4XndZah8AG9uQvPGkenZnb
        j0wH4TpA==;
Received: from [2001:4bb8:185:a81e:9865:e17e:4c0c:3e17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwzMH-005qRh-EB; Fri, 03 Jun 2022 04:56:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 10/13] block/021: convert to use _configure_null_blk
Date:   Fri,  3 Jun 2022 06:55:55 +0200
Message-Id: <20220603045558.466760-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220603045558.466760-1-hch@lst.de>
References: <20220603045558.466760-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Switch to use _configure_null_blk so that built-in null_blk can be
supported, which implies not using the default nullb0 device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/block/021 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/block/021 b/tests/block/021
index a1bbf45..89ebcd0 100755
--- a/tests/block/021
+++ b/tests/block/021
@@ -20,7 +20,7 @@ requires() {
 test() {
 	echo "Running ${TEST_NAME}"
 
-	if ! _init_null_blk; then
+	if ! _configure_null_blk nullb1 power=1; then
 		return 1
 	fi
 
@@ -28,14 +28,14 @@ test() {
 	local nr
 	local scheds
 	# shellcheck disable=SC2207
-	scheds=($(sed 's/[][]//g' /sys/block/nullb0/queue/scheduler))
+	scheds=($(sed 's/[][]//g' /sys/block/nullb1/queue/scheduler))
 
 	for sched in "${scheds[@]}"; do
 		echo "Testing $sched" >> "$FULL"
-		echo "$sched" > /sys/block/nullb0/queue/scheduler
-		max_nr="$(cat /sys/block/nullb0/queue/nr_requests)"
+		echo "$sched" > /sys/block/nullb1/queue/scheduler
+		max_nr="$(cat /sys/block/nullb1/queue/nr_requests)"
 		for ((nr = 4; nr <= max_nr; nr++)); do
-			echo "$nr" > /sys/block/nullb0/queue/nr_requests
+			echo "$nr" > /sys/block/nullb1/queue/nr_requests
 		done
 	done
 
-- 
2.30.2

