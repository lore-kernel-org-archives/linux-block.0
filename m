Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7C8C433F5
	for <linux-block@archiver.kernel.org>; Mon, 30 May 2022 13:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbiE3NIk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 May 2022 09:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbiE3NIi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 May 2022 09:08:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C49E819A9
        for <linux-block@vger.kernel.org>; Mon, 30 May 2022 06:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rVtv4hqHRIiBfzH3a3TRr9+YdmhHgE1PAv/ncRPpl0c=; b=vgYdLq5ebdLT8QuOVdfk/w6P7H
        7F0UH+QioeAmdGSQd+s4KmwM7JqPpckR7eG7PYuI0xf8g99kjVJyps9QkIgPCB24M4p+wCAbKA5lc
        FZnfBwk94/hlQJfFUirmllyN/eiDPwG69LCCr1La6P2+eWr+CR29ZYIxw3BkMxBi7FzbOOck49NBb
        5e2xsq2Fy1HvkYV1yvYMWGLeGutQulhexcei/T3KSrS9IAjBphOBYJy6sS5TPuF+DXLJ0hw2+hPAL
        OOeH3M8XpFb1D+lX+6MQ7skon3sIvnnBKSAoxpt0e8IL2pUklUDJP/NYjJzdTgoFYEq8G7F28OpbB
        /61fygnA==;
Received: from [2001:4bb8:185:a81e:fda9:da32:3b0c:8358] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nvf8O-006bs9-FD; Mon, 30 May 2022 13:08:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 8/9] nvme: don't require the nvme drivers to be built in
Date:   Mon, 30 May 2022 15:08:10 +0200
Message-Id: <20220530130811.3006554-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220530130811.3006554-1-hch@lst.de>
References: <20220530130811.3006554-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use _have_driver instead of _have_modules to check for the availability
of the nvme drivers, and don't bother checking at all for drivers that
are pulled in as dependencies.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/nvme/rc | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index ccdccf9..998b181 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -16,21 +16,23 @@ _nvme_requires() {
 	_have_program nvme
 	case ${nvme_trtype} in
 	loop)
-		_have_modules nvmet nvme-core nvme-loop
+		_have_driver nvme-loop
 		_have_configfs
 		;;
 	pci)
-		_have_modules nvme nvme-core
+		_have_driver nvme
 		;;
 	tcp)
-		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
+		_have_driver nvme-tcp
+		_have_driver nvmet-tcp
 		_have_configfs
 		;;
 	rdma)
-		_have_modules nvmet nvme-core nvme-rdma nvmet-rdma
+		_have_driver nvme-rdma
+		_have_driver nvmet-rdma
 		_have_configfs
 		_have_program rdma
-		_have_modules rdma_rxe || _have_modules siw
+		_have_driver rdma_rxe || _have_driver siw
 		;;
 	*)
 		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
@@ -125,11 +127,11 @@ _cleanup_nvmet() {
 	shopt -u nullglob
 	trap SIGINT
 
-	modprobe -r nvme-"${nvme_trtype}" 2>/dev/null
+	modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
 	if [[ "${nvme_trtype}" != "loop" ]]; then
-		modprobe -r nvmet-"${nvme_trtype}" 2>/dev/null
+		modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
 	fi
-	modprobe -r nvmet 2>/dev/null
+	modprobe -rq nvmet 2>/dev/null
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
 		stop_soft_rdma
 	fi
@@ -137,11 +139,11 @@ _cleanup_nvmet() {
 
 _setup_nvmet() {
 	_register_test_cleanup _cleanup_nvmet
-	modprobe nvmet
+	modprobe -q nvmet
 	if [[ "${nvme_trtype}" != "loop" ]]; then
-		modprobe nvmet-"${nvme_trtype}"
+		modprobe -q nvmet-"${nvme_trtype}"
 	fi
-	modprobe nvme-"${nvme_trtype}"
+	modprobe -q nvme-"${nvme_trtype}"
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
 		start_soft_rdma
 		for i in $(rdma_network_interfaces)
-- 
2.30.2

