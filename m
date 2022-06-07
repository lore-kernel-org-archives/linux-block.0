Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEAAC433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Jun 2022 12:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244199AbiFGMsY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jun 2022 08:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244197AbiFGMsT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jun 2022 08:48:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29338BD0D
        for <linux-block@vger.kernel.org>; Tue,  7 Jun 2022 05:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=dSY9q8SiyA9w6r6j8Ui3CeYMf/mJmCFyCSTGI67/BE0=; b=Y/gLPNOT+jJx+7aMO7p4ydhSkl
        pzQ34Q0hIIrsMc3HouNiUp65EoP3D0DaKzkgx6l3hwr7zCEF6DV5D+vtbrlni/zvZPvOlQCIyxrdt
        xhLH0j1YomkGcCI+niFOte0COejebHNNVJ6OBDarI5Qco0Ir36qjr4LQARHj8GkLwtlWS9TlTgnDy
        FOyIwgF0xdIGMqZN80op8D57JfgHgirQ3cgI1TOr4HcDjruHTXhSKF6PcbSqIwDD4UJNo75tpzdF0
        sHt8EsxHgjFgMmUn0XdKK0z1ZY/QoF9egxRUeoHAFpNWZy1jXWo43MdzoRc/pY1iiiHyac6zz+S+T
        guXw2Q9g==;
Received: from [2001:4bb8:190:726c:b34a:228:52ee:6d34] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nyYd0-007Sj7-Eu; Tue, 07 Jun 2022 12:48:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 10/13] block/021: convert to use _configure_null_blk
Date:   Tue,  7 Jun 2022 14:47:36 +0200
Message-Id: <20220607124739.1259977-11-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607124739.1259977-1-hch@lst.de>
References: <20220607124739.1259977-1-hch@lst.de>
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

