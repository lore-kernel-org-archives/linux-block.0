Return-Path: <SRS0=cFNo=DP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4B0C04EBE
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 16:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A143A221F1
	for <linux-block@archiver.kernel.org>; Thu,  8 Oct 2020 16:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Ze5do6sF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731022AbgJHQkg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Oct 2020 12:40:36 -0400
Received: from ale.deltatee.com ([204.191.154.188]:48802 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbgJHQke (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Oct 2020 12:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2H5pnlIGgr783fyjVRGozSxgfc3nLB2Pz4M+rb66lZs=; b=Ze5do6sFDceTWtvDx/DuUBt5jk
        G6sA3x3TTHcDoRa23y6jQLXrXNED8xI7PRPmdEDgBby9BR1fvuClc0lzGomppOuIu+IpL/UnUyuZi
        xk4IkyjDgjs3qg/UVlTYWfu5gahrlnaGRbR+qXYFQ0qfTklIHIp6YcDyZ4f4rOaMX1uUZVru5WxGr
        Y7ezuJRXkK4jLGd3DNbTSg9u4IqS0vgFK/fSUC/W5IxQbqMf7UyLtmcE6CblKoNba842K6fvRgqhf
        d38AudcEA6FEls2iMgCRliTIyT2ZyZMac0wndsfRrY/oxsT/Kh2guyfrYdJ0Vs5Lb9ZnKF5iw93Nq
        U6aR0AeQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kQYxz-0000il-Po; Thu, 08 Oct 2020 10:40:33 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1kQYxz-0003HR-6i; Thu, 08 Oct 2020 10:40:31 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  8 Oct 2020 10:40:17 -0600
Message-Id: <20201008164024.12546-5-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008164024.12546-1-logang@deltatee.com>
References: <20201008164024.12546-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests v3 04/11] nvme: Search for specific subsysnqn in _find_nvme_loop_dev
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This ensures we find the correct nvme loop device if others exist on a
given system (which is generally not expected on test systems).

Additionally, this will be required in the upcomming test nvme/037 which
will have controllers racing with ones being destroyed.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/004 | 2 +-
 tests/nvme/005 | 2 +-
 tests/nvme/008 | 2 +-
 tests/nvme/009 | 2 +-
 tests/nvme/010 | 2 +-
 tests/nvme/011 | 2 +-
 tests/nvme/012 | 2 +-
 tests/nvme/013 | 2 +-
 tests/nvme/014 | 2 +-
 tests/nvme/015 | 2 +-
 tests/nvme/018 | 2 +-
 tests/nvme/019 | 2 +-
 tests/nvme/020 | 2 +-
 tests/nvme/021 | 2 +-
 tests/nvme/022 | 2 +-
 tests/nvme/023 | 2 +-
 tests/nvme/024 | 2 +-
 tests/nvme/025 | 2 +-
 tests/nvme/026 | 2 +-
 tests/nvme/027 | 2 +-
 tests/nvme/028 | 2 +-
 tests/nvme/029 | 2 +-
 tests/nvme/rc  | 7 ++++---
 23 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/tests/nvme/004 b/tests/nvme/004
index dfca79aab20c..4b0b7ae50a5e 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -37,7 +37,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" blktests-subsystem-1
 
 	local nvmedev
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "blktests-subsystem-1")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/005 b/tests/nvme/005
index 0d5801868bc0..9f3e388dc695 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -37,7 +37,7 @@ test() {
 	_nvme_connect_subsys "${nvme_trtype}" blktests-subsystem-1
 
 	local nvmedev
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "blktests-subsystem-1")
 
 	udevadm settle
 
diff --git a/tests/nvme/008 b/tests/nvme/008
index 8616617ad398..219fe9b0ca6a 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -37,7 +37,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/009 b/tests/nvme/009
index e91d79065cb1..2814c79164ee 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -33,7 +33,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/010 b/tests/nvme/010
index 0188e842213e..150a4e540f3e 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -37,7 +37,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/011 b/tests/nvme/011
index 543dbe840874..4bfe9af084e4 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -35,7 +35,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/012 b/tests/nvme/012
index a13cd08ce6bf..c4e75b09796a 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -40,7 +40,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 1ac725ea83f2..265b6968fd34 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -37,7 +37,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/014 b/tests/nvme/014
index e3c70364e332..48f8caaec0b3 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -37,7 +37,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index 46fa4f605749..e33cfde5d72e 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -34,7 +34,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/018 b/tests/nvme/018
index 6d7934d09d99..7f407da2ce19 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -35,7 +35,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/019 b/tests/nvme/019
index 486b5acff713..8259e2e0c157 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -39,7 +39,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/020 b/tests/nvme/020
index c8053f440e2e..16fdfcc94918 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -35,7 +35,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/021 b/tests/nvme/021
index f543a1d8fd92..fb77f9cbd99f 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -34,7 +34,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/022 b/tests/nvme/022
index e824ed31f6f0..62c4690e35fe 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -34,7 +34,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/023 b/tests/nvme/023
index bdef3dc8abca..bce21b56c9f1 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -37,7 +37,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/024 b/tests/nvme/024
index 78f779e8a08a..ffec36cf3333 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -34,7 +34,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/025 b/tests/nvme/025
index 223430965d7e..3d3f01bc45fd 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -34,7 +34,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index 7f82284d9c57..2f5607793cd3 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -34,7 +34,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/027 b/tests/nvme/027
index da96e6c5008d..53f06646a3d0 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -34,7 +34,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/028 b/tests/nvme/028
index f826b67623f1..3d9084f18636 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -34,7 +34,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/029 b/tests/nvme/029
index 5bed9b8e70ae..960e5f5a63bf 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -70,7 +70,7 @@ test() {
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}"
 
-	nvmedev="$(_find_nvme_dev)"
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4c5b2e8edf0d..dfa57a299625 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -273,12 +273,13 @@ _remove_nvmet_subsystem_from_port() {
 }
 
 _find_nvme_dev() {
+	local subsys=$1
+	local subsysnqn
 	local dev
-	local transport
 	for dev in /sys/class/nvme/nvme*; do
 		dev="$(basename "$dev")"
-		transport="$(cat "/sys/class/nvme/${dev}/transport")"
-		if [[ "$transport" == "${nvme_trtype}" ]]; then
+		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn")"
+		if [[ "$subsysnqn" == "$subsys" ]]; then
 			echo "$dev"
 			for ((i = 0; i < 10; i++)); do
 				if [[ -e /sys/block/$dev/uuid &&
-- 
2.20.1

