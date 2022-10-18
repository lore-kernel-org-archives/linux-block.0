Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FADC4332F
	for <linux-block@archiver.kernel.org>; Tue, 18 Oct 2022 13:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiJRNSs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Oct 2022 09:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiJRNSr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2022 09:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98F5C8941
        for <linux-block@vger.kernel.org>; Tue, 18 Oct 2022 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666099111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OHBkuTSUngShbJj713zOySelAXFW6/K6OGq2+nTXW5A=;
        b=gyaF/82Czss9cB4u74MZcHRzQrefPaXr2FBw6zxHf3DoJpbhx0jpilhRcvcViqi2gROCT+
        AYJLAstzqjiJ1BPzy0J4pevffJSTsu3SAcow9yAq2PVLtlmcOz325+KuZSoqepAN7VV9TS
        Ap+mIcftQVV/uTwLBQIw69Eyxy32Xw4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-320-MgC455w7MSSzwCPjCNoPzQ-1; Tue, 18 Oct 2022 09:18:30 -0400
X-MC-Unique: MgC455w7MSSzwCPjCNoPzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26232803D49;
        Tue, 18 Oct 2022 13:18:30 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25A191401C23;
        Tue, 18 Oct 2022 13:18:27 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     shinichiro.kawasaki@wdc.com
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V2 blktests] tests/nvme: set hostnqn after hostid uuidgen
Date:   Tue, 18 Oct 2022 21:17:58 +0800
Message-Id: <20221018131758.763311-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

hostid will not be appended to hostnqn as it was generated after set
hostnqn, so let's set hostnqn after hostid generated.

Reviewed-by: Hannes Reinecke <hare@suse.de>
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

