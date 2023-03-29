Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA8AC74A5B
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 09:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjC2JCu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 05:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjC2JCk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 05:02:40 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0582F423E
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 02:02:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 18E001FDEE;
        Wed, 29 Mar 2023 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680080525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3DgnundXw3/fWoRWwwxsBqOoYOOJIiKIHvv0PtfL9Cg=;
        b=agi/1BkpWD2l1Qyo1c2qv3YaQts4+RLvve+8UPQ8bhiKa9Of0fLDzivj5lU1kuc3PnWs+W
        NoC0xNzkpBj6YyZjFEaxhZ8+vFgDwB/MumYkRF0pzE/TfUzbuNCSYXdWhXS7kzEGp506gy
        uJB2hoyQCkYRfmZQpmewBrGjPgO5Rrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680080525;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3DgnundXw3/fWoRWwwxsBqOoYOOJIiKIHvv0PtfL9Cg=;
        b=5ColjjWeDLLqbxU6XSf6fRh/362uPmUe3bknNlRlEs9n2SV20dlGtuo1l13BaX8QvmitcB
        5LRomWgFqqomUnDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09FF3138FF;
        Wed, 29 Mar 2023 09:02:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4rtdAo3+I2RUdgAAMHmgww
        (envelope-from <dwagner@suse.de>); Wed, 29 Mar 2023 09:02:05 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Keith Busch <kbusch@kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 1/4] nvme/rc: Parse optional arguments in _nvme_connect_subsys()
Date:   Wed, 29 Mar 2023 11:01:59 +0200
Message-Id: <20230329090202.8351-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230329090202.8351-1-dwagner@suse.de>
References: <20230329090202.8351-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Extend the nvme_connect_subsys() function to parse optional arguments.
This avoids that all test have to pass in always all arguments.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/041 |  7 ++++--
 tests/nvme/042 | 10 +++++----
 tests/nvme/043 | 10 +++++----
 tests/nvme/044 | 23 ++++++++++++-------
 tests/nvme/045 |  6 +++--
 tests/nvme/rc  | 61 ++++++++++++++++++++++++++++++++++++++++++--------
 6 files changed, 88 insertions(+), 29 deletions(-)

diff --git a/tests/nvme/041 b/tests/nvme/041
index 8ffcf13a500a..03e2dab25918 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -55,14 +55,17 @@ test() {
 	# Test unauthenticated connection (should fail)
 	echo "Test unauthenticated connection (should fail)"
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-			     "" "" "${hostnqn}" "${hostid}"
+			     --hostnqn "${hostnqn}" \
+			     --hostid "${hostid}"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
 	# Test authenticated connection
 	echo "Test authenticated connection"
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-			     "" "" "${hostnqn}" "${hostid}" "${hostkey}"
+			     --hostnqn "${hostnqn}" \
+			     --hostid "${hostid}" \
+			     --dhchap-secret "${hostkey}"
 
 	udevadm settle
 
diff --git a/tests/nvme/042 b/tests/nvme/042
index d581bce4a9ee..4ad726f72f5a 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -58,8 +58,9 @@ test() {
 		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
 
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-				     "" "" "${hostnqn}" "${hostid}" \
-				     "${hostkey}"
+				     --hostnqn "${hostnqn}" \
+				     --hostid "${hostid}" \
+				     --dhchap-secret "${hostkey}"
 		udevadm settle
 
 		_nvme_disconnect_subsys "${subsys_name}"
@@ -75,8 +76,9 @@ test() {
 		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
 
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-				     "" "" "${hostnqn}" "${hostid}" \
-				     "${hostkey}"
+				     --hostnqn "${hostnqn}" \
+				     --hostid "${hostid}" \
+				     --dhchap-secret "${hostkey}"
 
 		udevadm settle
 
diff --git a/tests/nvme/043 b/tests/nvme/043
index c8ce292ba2e7..c031cecf34a5 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -56,8 +56,9 @@ test() {
 		_set_nvmet_hash "${hostnqn}" "${hash}"
 
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-				     "" "" "${hostnqn}" "${hostid}" \
-				     "${hostkey}"
+				     --hostnqn "${hostnqn}" \
+				     --hostid "${hostid}" \
+				     --dhchap-secret "${hostkey}"
 
 		udevadm settle
 
@@ -71,8 +72,9 @@ test() {
 		_set_nvmet_dhgroup "${hostnqn}" "${dhgroup}"
 
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-				     "" "" "${hostnqn}" "${hostid}" \
-				     "${hostkey}"
+				      --hostnqn "${hostnqn}" \
+				      --hostid "${hostid}" \
+				      --dhchap-secret "${hostkey}"
 
 		udevadm settle
 
diff --git a/tests/nvme/044 b/tests/nvme/044
index c19a9c026711..f2406ecadf7d 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -66,8 +66,9 @@ test() {
 	# Step 1: Connect with host authentication only
 	echo "Test host authentication"
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-			     "" "" "${hostnqn}" "${hostid}" \
-			     "${hostkey}"
+			     --hostnqn "${hostnqn}" \
+			     --hostid "${hostid}" \
+			     --dhchap-secret "${hostkey}"
 
 	udevadm settle
 
@@ -77,8 +78,10 @@ test() {
 	# and invalid ctrl authentication
 	echo "Test invalid ctrl authentication (should fail)"
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-			     "" "" "${hostnqn}" "${hostid}" \
-			     "${hostkey}" "${hostkey}"
+			     --hostnqn "${hostnqn}" \
+			     --hostid "${hostid}" \
+			     --dhchap-secret "${hostkey}" \
+			     --dhchap-ctrl-secret "${hostkey}"
 
 	udevadm settle
 
@@ -88,8 +91,10 @@ test() {
 	# and valid ctrl authentication
 	echo "Test valid ctrl authentication"
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-			     "" "" "${hostnqn}" "${hostid}" \
-			     "${hostkey}" "${ctrlkey}"
+			     --hostnqn "${hostnqn}" \
+			     --hostid "${hostid}" \
+			     --dhchap-secret "${hostkey}" \
+			     --dhchap-ctrl-secret "${ctrlkey}"
 
 	udevadm settle
 
@@ -100,8 +105,10 @@ test() {
 	echo "Test invalid ctrl key (should fail)"
 	invkey="DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-			     "" "" "${hostnqn}" "${hostid}" \
-			     "${hostkey}" "${invkey}"
+			     --hostnqn "${hostnqn}" \
+			     --hostid "${hostid}" \
+			     --dhchap-secret "${hostkey}" \
+			     --dhchap-ctrl-secret "${invkey}"
 
 	udevadm settle
 
diff --git a/tests/nvme/045 b/tests/nvme/045
index a0e6e93ed3c7..612e5f168e3c 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -65,8 +65,10 @@ test() {
 	_set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
-			     "" "" "${hostnqn}" "${hostid}" \
-			     "${hostkey}" "${ctrlkey}"
+			     --hostnqn "${hostnqn}" \
+			     --hostid "${hostid}" \
+			     --dhchap-secret "${hostkey}" \
+			     --dhchap-ctrl-secret "${ctrlkey}"
 
 	udevadm settle
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 210a82aea384..20c5e2fa32cb 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -316,15 +316,58 @@ _nvme_disconnect_subsys() {
 }
 
 _nvme_connect_subsys() {
-	local trtype="$1"
-	local subsysnqn="$2"
-	local traddr="${3:-$def_traddr}"
-	local host_traddr="${4:-$def_host_traddr}"
-	local trsvcid="${4:-$def_trsvcid}"
-	local hostnqn="${5:-$def_hostnqn}"
-	local hostid="${6:-$def_hostid}"
-	local hostkey="${7}"
-	local ctrlkey="${8}"
+	local positional_args=()
+	local trtype=""
+	local subsysnqn=""
+	local traddr="$def_traddr"
+	local host_traddr="$def_host_traddr"
+	local trsvcid="$def_trsvcid"
+	local hostnqn="$def_hostnqn"
+	local hostid="$def_hostid"
+	local hostkey=""
+	local ctrlkey=""
+
+	while [[ $# -gt 0 ]]; do
+		case $1 in
+			-a|--traddr)
+				traddr="$2"
+				shift 2
+				;;
+			-w|--host-traddr)
+				host_traddr="$2"
+				shift 2
+				;;
+			-s|--trsvcid)
+				trsvcid="$2"
+				shift 2
+				;;
+			-n|--hostnqn)
+				hostnqn="$2"
+				shift 2
+				;;
+			-I|--hostid)
+				hostid="$2"
+				shift 2
+				;;
+			-S|--dhchap-secret)
+				hostkey="$2"
+				shift 2
+				;;
+			-C|--dhchap-ctrl-secret)
+				ctrlkey="$2"
+				shift 2
+				;;
+			*)
+				positional_args+=("$1")
+				shift
+				;;
+		esac
+	done
+
+	set -- "${positional_args[@]}"
+
+	trtype="$1"
+	subsysnqn="$2"
 
 	ARGS=(-t "${trtype}" -n "${subsysnqn}")
 	if [[ "${trtype}" == "fc" ]] ; then
-- 
2.40.0

