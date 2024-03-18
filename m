Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D522D022
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754753; cv=none; b=bNPvZAYe2PE5AyGHiBY2jNXbqFt3YHRRrAxAhjYeOwsbRMcXn8hz4bzxcEuX7AkR1wt7n7x1mPeVghgl1rovywVejdCcCiPZILJhbtVGzuSTEAPWstYciwUyZFI5lTAAx5F3AldBFtOBrZrxs194GmzWb/5RLOf6VYwHej2o0gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754753; c=relaxed/simple;
	bh=iGvq6ePUEwqPZ//tjHLfEsgTV1a0793RRAPwiIaaUQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ql8LkqGMYS4hdqi6AUC+1blH1DNk85Bsbz5zqYv8GpUoEapfQwrLRsBh8kPAhPOKmvnk+wY80i65+G1YxfQD05VdpOWLWymFd3FOtugKaOfoJf0/bj9oysEKxFLvpZpsugwSh4bDRNWIZUABxj/HKnV8pfi+E0rsARclN7jStj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JmG6qZR0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L58CayZC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JmG6qZR0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L58CayZC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JmG6qZR0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L58CayZC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JmG6qZR0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L58CayZC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 95A2534881;
	Mon, 18 Mar 2024 09:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkjVtUMWwJ1rBkwMVdD32WaQ4UJ0NgnLZeel8d3RvV4=;
	b=JmG6qZR0l+sGNd8cbAPLHM3vf8BSQUfutnC2VvzBkXON2AlEthTWfNYkcZvFldkbapXI+A
	JHyTkFiS+PbbQzDC44MD+Krcn4OUrwOPfDW7j4eha0sXcozWHSroA2YsVG8DhiDg3rfDrz
	gQyL0MF/2HPq7bR9AZSIeJCQSIrJE7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkjVtUMWwJ1rBkwMVdD32WaQ4UJ0NgnLZeel8d3RvV4=;
	b=L58CayZCFX2tjXA1ujFOHvJl5eYYaLCCo09pH+xh081ojyhoQQKEBBWXP9kc377eYU46Z3
	xecBJBCk7LvaYRAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkjVtUMWwJ1rBkwMVdD32WaQ4UJ0NgnLZeel8d3RvV4=;
	b=JmG6qZR0l+sGNd8cbAPLHM3vf8BSQUfutnC2VvzBkXON2AlEthTWfNYkcZvFldkbapXI+A
	JHyTkFiS+PbbQzDC44MD+Krcn4OUrwOPfDW7j4eha0sXcozWHSroA2YsVG8DhiDg3rfDrz
	gQyL0MF/2HPq7bR9AZSIeJCQSIrJE7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkjVtUMWwJ1rBkwMVdD32WaQ4UJ0NgnLZeel8d3RvV4=;
	b=L58CayZCFX2tjXA1ujFOHvJl5eYYaLCCo09pH+xh081ojyhoQQKEBBWXP9kc377eYU46Z3
	xecBJBCk7LvaYRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 835DF1349D;
	Mon, 18 Mar 2024 09:39:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BFigHr4L+GXHUAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 18 Mar 2024 09:39:10 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v1 09/10] nvme/rc: introduce remote target support
Date: Mon, 18 Mar 2024 10:38:55 +0100
Message-ID: <20240318093856.22307-11-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318093856.22307-1-dwagner@suse.de>
References: <20240318093856.22307-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.29
X-Spamd-Result: default: False [-3.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 R_RATELIMIT(0.00)[to_ip_from(RLm9s6cmri9k4spo5w97m8fq33)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.979];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Most of the NVMEeoF tests are exercising the host code of the nvme
subsystem. There is no real reason not to run these against a real
target. We just have to skip the soft target setup and make it possible
to setup a remote target.

Because all tests use now the common setup/cleanup helpers we just need
to intercept this call and forward it to an external component.

As we already have various nvme variables to setup the target, extend
this part with 'nvme_target_control' which is expected to be script
which setups the remote target accordingly.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 49 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 5 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 2e9a0860c0e7..35eb4cc5e954 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -7,9 +7,10 @@
 . common/rc
 . common/multipath-over-rdma
 
-def_traddr="127.0.0.1"
+def_traddr="${nvme_traddr:-127.0.0.1}"
+def_host_traddr="${nvme_host_traddr:-}"
 def_adrfam="ipv4"
-def_trsvcid="4420"
+def_trsvcid="${nvme_trsvcid:-4420}"
 def_remote_wwnn="0x10001100aa000001"
 def_remote_wwpn="0x20001100aa000001"
 def_local_wwnn="0x10001100aa000002"
@@ -19,6 +20,7 @@ def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
 export def_subsysnqn="blktests-subsystem-1"
 export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 nvme_trtype=${nvme_trtype:-"loop"}
+nvme_target_control="${nvme_target_control:-}"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 
@@ -325,6 +327,10 @@ _cleanup_nvmet() {
 		fi
 	done
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		return
+	fi
+
 	for port in "${NVMET_CFS}"/ports/*; do
 		name=$(basename "${port}")
 		echo "WARNING: Test did not clean up port: ${name}"
@@ -369,11 +375,19 @@ _cleanup_nvmet() {
 
 _setup_nvmet() {
 	_register_test_cleanup _cleanup_nvmet
+
+	if [[ -n "${nvme_target_control}" ]]; then
+		return
+	fi
+
 	modprobe -q nvmet
+
 	if [[ "${nvme_trtype}" != "loop" ]]; then
 		modprobe -q nvmet-"${nvme_trtype}"
 	fi
+
 	modprobe -q nvme-"${nvme_trtype}"
+
 	if [[ "${nvme_trtype}" == "rdma" ]]; then
 		start_soft_rdma
 		for i in $(rdma_network_interfaces)
@@ -391,6 +405,7 @@ _setup_nvmet() {
 			fi
 		done
 	fi
+
 	if [[ "${nvme_trtype}" = "fc" ]]; then
 		modprobe -q nvme-fcloop
 		_setup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
@@ -819,12 +834,13 @@ _find_nvme_passthru_loop_dev() {
 }
 
 _nvmet_target_setup() {
+	local subsys_uuid="${def_subsys_uuid}"
+	local subsysnqn="${def_subsysnqn}"
 	local blkdev_type="device"
-	local blkdev
+	local ARGS=()
 	local ctrlkey=""
 	local hostkey=""
-	local subsysnqn="${def_subsysnqn}"
-	local subsys_uuid="${def_subsys_uuid}"
+	local blkdev
 	local port
 
 	while [[ $# -gt 0 ]]; do
@@ -856,6 +872,22 @@ _nvmet_target_setup() {
 		esac
 	done
 
+	if [[ -n "${hostkey}" ]]; then
+		ARGS+=(--hostkey "${hostkey}")
+	fi
+	if [[ -n "${ctrlkey}" ]]; then
+		ARGS+=(--ctrkey "${ctrlkey}")
+	fi
+
+	if [[ -n "${nvme_target_control}" ]]; then
+		eval "${nvme_target_control}" setup \
+			--subsysnqn "${subsysnqn}" \
+			--subsys-uuid "${subsys_uuid}" \
+			--hostnqn "${def_hostnqn}" \
+			"${ARGS[@]}" > /dev/null 2>&1
+		return
+	fi
+
 	truncate -s "${nvme_img_size}" "$(_nvme_def_file_path)"
 	if [[ "${blkdev_type}" == "device" ]]; then
 		blkdev="$(losetup -f --show "$(_nvme_def_file_path)")"
@@ -890,6 +922,13 @@ _nvmet_target_cleanup() {
 		esac
 	done
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		eval "${nvme_target_control}" cleanup \
+			--subsysnqn "${subsysnqn}" \
+			> /dev/null
+		return
+	fi
+
 	_get_nvmet_ports "${def_subsysnqn}" ports
 
 	for port in "${ports[@]}"; do
-- 
2.44.0

