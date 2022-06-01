Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670A0C433F5
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 06:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245519AbiFAGtA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbiFAGs7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 02:48:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F37954A4
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 23:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rVtv4hqHRIiBfzH3a3TRr9+YdmhHgE1PAv/ncRPpl0c=; b=ys4ARIJTVPyEBap1jOVb4wZhPX
        aAOp2drORDU5Qj8Sg5SrUAOe7vo9UCwjB9ZXZUuoH2pVMASoGsx9F1K7c8uqWZKWcfJ2IAkDfROCz
        1E4XxIPrb6n0ZmOFceZy7JRWL0CV6l2knpWWqbuWi7PNgTgZKRgUSQ0jHGic69pi0l8aAeV16t81D
        FGPTjok0cnR8L95wBS9IDvzftTbOCYQn943obIAB0lb0Lc2PtaLUWH1VtaLkfD7p3V4/A0DeSmUyL
        AosNJryIZchp4nkC/OL3TfX7VBAl7VMLdN1RchZVQvRM4mcK+1dEKHc53ucVYPWLvPluSPpcOIMwz
        areYcjww==;
Received: from [2001:4bb8:185:a81e:471a:4927:bd2e:6050] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwIA6-00EEZX-Aj; Wed, 01 Jun 2022 06:48:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests 7/7] nvme: don't require the nvme drivers to be built in
Date:   Wed,  1 Jun 2022 08:48:37 +0200
Message-Id: <20220601064837.3473709-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220601064837.3473709-1-hch@lst.de>
References: <20220601064837.3473709-1-hch@lst.de>
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

