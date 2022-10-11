Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E127C433FE
	for <linux-block@archiver.kernel.org>; Tue, 11 Oct 2022 17:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiJKRnp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Oct 2022 13:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJKRnp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Oct 2022 13:43:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC2226108
        for <linux-block@vger.kernel.org>; Tue, 11 Oct 2022 10:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665510223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=50WiZs7UViSj5w2cOYj6iUBWIJIgEQpETSwSo79m1LU=;
        b=RBQQb1yMMTksAaZ8Ij9C84rh9yrwZet0UGJ02nSdLtR0ma5uE/2sJQvOEzA2sH1aLwaR0J
        UUE6Z9HGNs4pwW3Qh/MrJ7qCrKAeVuFFm89S6qWIG7SmLakBHbOhlxwWaRX3KWrxoo8nTr
        behnlFPkG247ZvXC1dysSK1Nhzt2gMc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-461-JoZ7qEh2Mq2Qz02Jn-V8cw-1; Tue, 11 Oct 2022 13:43:41 -0400
X-MC-Unique: JoZ7qEh2Mq2Qz02Jn-V8cw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 412C12A59548;
        Tue, 11 Oct 2022 17:43:41 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93532207B36F;
        Tue, 11 Oct 2022 17:43:39 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     hare@suse.de, shinichiro.kawasaki@wdc.com
Cc:     linux-block@vger.kernel.org
Subject: [PATCH blktests] tests/nvme: set hostnqn after hostid uuidgen
Date:   Wed, 12 Oct 2022 01:43:25 +0800
Message-Id: <20221011174325.311286-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvme/041 | 3 ++-
 tests/nvme/042 | 3 ++-
 tests/nvme/043 | 3 ++-
 tests/nvme/044 | 3 ++-
 tests/nvme/045 | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/nvme/041 b/tests/nvme/041
index 98c443e..b311229 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -23,7 +23,7 @@ test() {
 	local port
 	local subsys_name="blktests-subsystem-1"
 	local hostid
-	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local hostnqn
 	local file_path="${TMPDIR}/img"
 	local hostkey
 	local ctrldev
@@ -35,6 +35,7 @@ test() {
 		echo "uuidgen failed"
 		return 1
 	fi
+	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
 	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
 		echo "nvme gen-dhchap-key failed"
diff --git a/tests/nvme/042 b/tests/nvme/042
index 06e5d3d..30a638d 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -23,7 +23,7 @@ test() {
 	local port
 	local subsys_name="blktests-subsystem-1"
 	local hostid
-	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local hostnqn
 	local file_path="${TMPDIR}/img"
 	local hmac
 	local key_len
@@ -37,6 +37,7 @@ test() {
 		echo "uuidgen failed"
 		return 1
 	fi
+	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
 
 	_setup_nvmet
 
diff --git a/tests/nvme/043 b/tests/nvme/043
index 87273e5..84e1666 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -24,7 +24,7 @@ test() {
 	local port
 	local subsys_name="blktests-subsystem-1"
 	local hostid
-	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local hostnqn
 	local file_path="${TMPDIR}/img"
 	local hash
 	local dhgroup
@@ -38,6 +38,7 @@ test() {
 		echo "uuidgen failed"
 		return 1
 	fi
+	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
 
 	_setup_nvmet
 
diff --git a/tests/nvme/044 b/tests/nvme/044
index 1301965..0eb36cc 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -24,7 +24,7 @@ test() {
 	local port
 	local subsys_name="blktests-subsystem-1"
 	local hostid
-	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local hostnqn
 	local file_path="${TMPDIR}/img"
 	local hostkey
 	local ctrlkey
@@ -37,6 +37,7 @@ test() {
 		echo "uuidgen failed"
 		return 1
 	fi
+	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
 
 	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
diff --git a/tests/nvme/045 b/tests/nvme/045
index 264f210..389e434 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -24,7 +24,7 @@ test() {
 	local port
 	local subsys_name="blktests-subsystem-1"
 	local hostid
-	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local hostnqn
 	local file_path="${TMPDIR}/img"
 	local hostkey
 	local new_hostkey
@@ -39,6 +39,7 @@ test() {
 		echo "uuidgen failed"
 		return 1
 	fi
+	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
 
 	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
 	if [ -z "$hostkey" ] ; then
-- 
2.34.1

