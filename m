Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6991447A5C
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115426; cv=none; b=Zb0s4tT/vwya4icVMB0E4kEZCJ6ooxzkmi3kFiirc3bYgOM8cDbYA//vpHvfzSJSOk8xrnMRAVtnd7NzsrQGxdObkrqfzbST1kjG4UGPklUwLgqzD3R1yUE6a4azW+yRKxDZ8iHKUehcDEH2PmmSm+umiCcH0IStTfEpq0jDouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115426; c=relaxed/simple;
	bh=aRAzDTd6GCU3/nhsdEv7HiRGUV5nf9n66G14txiEZCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkMiV6S4x8ue7V6hNPE1RTzkOSTTpkUhy6P9X7RMeX+NtGkOAPSBl03ZTD01D+K/noBV/aeacLf0999qO7/2hyWBHO7iMw2cVWkLFZQ78pD/e1ceqiz9d3iX6wJVRDC5pD0HXFFDVRpJeS+C/hS2dJzk47wW3l1pOUXAWHCrP80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C22C65FE21;
	Fri, 22 Mar 2024 13:50:22 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0EBA136AD;
	Fri, 22 Mar 2024 13:50:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +BG9KZ6M/WWHJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:22 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 06/18] nvme/rc: use long command line option for nvme
Date: Fri, 22 Mar 2024 14:50:03 +0100
Message-ID: <20240322135015.14712-7-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322135015.14712-1-dwagner@suse.de>
References: <20240322135015.14712-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.00
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Queue-Id: C22C65FE21

The long format of the command line option are more descriptive and more
likely to stay stable.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index e67bb846ab77..6bf2e3ae37c5 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -148,7 +148,7 @@ _require_nvme_trtype_is_fabrics() {
 }
 
 _require_nvme_cli_auth() {
-	if ! nvme gen-dhchap-key -n nvmf-test-subsys > /dev/null 2>&1 ; then
+	if ! nvme gen-dhchap-key --nqn nvmf-test-subsys > /dev/null 2>&1 ; then
 		SKIP_REASONS+=("nvme gen-dhchap-key command missing")
 		return 1
 	fi
@@ -396,13 +396,13 @@ _setup_nvmet() {
 _nvme_disconnect_ctrl() {
 	local ctrl="$1"
 
-	nvme disconnect -d "${ctrl}"
+	nvme disconnect --device "${ctrl}"
 }
 
 _nvme_disconnect_subsys() {
 	local subsysnqn="$1"
 
-	nvme disconnect -n "${subsysnqn}" |& tee -a "$FULL" |
+	nvme disconnect --nqn "${subsysnqn}" |& tee -a "$FULL" |
 		grep -o "disconnected.*"
 }
 
@@ -496,11 +496,11 @@ _nvme_connect_subsys() {
 	trtype="$1"
 	subsysnqn="$2"
 
-	ARGS=(-t "${trtype}" -n "${subsysnqn}")
+	ARGS=(--transport "${trtype}" --nqn "${subsysnqn}")
 	if [[ "${trtype}" == "fc" ]] ; then
-		ARGS+=(-a "${traddr}" -w "${host_traddr}")
+		ARGS+=(--traddr "${traddr}" --host-traddr "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-		ARGS+=(-a "${traddr}" -s "${trsvcid}")
+		ARGS+=(--traddr "${traddr}" --trsvcid "${trsvcid}")
 	fi
 	ARGS+=(--hostnqn="${hostnqn}")
 	ARGS+=(--hostid="${hostid}")
@@ -565,13 +565,13 @@ _nvme_discover() {
 	local host_traddr="${3:-$def_host_traddr}"
 	local trsvcid="${3:-$def_trsvcid}"
 
-	ARGS=(-t "${trtype}")
+	ARGS=(--transport "${trtype}")
 	ARGS+=(--hostnqn="${def_hostnqn}")
 	ARGS+=(--hostid="${def_hostid}")
 	if [[ "${trtype}" = "fc" ]]; then
-		ARGS+=(-a "${traddr}" -w "${host_traddr}")
+		ARGS+=(--traddr "${traddr}" --host-traddr "${host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-		ARGS+=(-a "${traddr}" -s "${trsvcid}")
+		ARGS+=(--traddr "${traddr}" --trsvcid "${trsvcid}")
 	fi
 	nvme discover "${ARGS[@]}"
 }
-- 
2.44.0

