Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F7847A66
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115428; cv=none; b=MeT4NKHZUuVd69FRzzQZH3YLX/HSOF/6SqZHr3rvNiwyruGKSrXuG4uP6pDbQhcOvRexx6fPSbQBjwXCCz0GRsg/t3+VcOXlsCb6GMJHdMuSnzzR7Svwx7pXwPCZR09bzysBL/E7P5DTKpXtOLfPVINH8C/4SPKgOsy1r8e00rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115428; c=relaxed/simple;
	bh=LfoyrayKYoLkggjYpp5l1i4X8Pq3zks8nbttMhfpi3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpFEcWKmMH21fVpSRNnGODlgR7btgBZy/A2pjy+lOmHuGFSEeaRR98/Bl9bLSrpeBPB7VWB8xDvZxXUMynvlC9Clxmcld8jXd4VqfHHxhfwlnfC0zO1Yjc5IYPHfg7j0UWik/oYxU5OsIQu4bJqv85g9FzLO1IX1PTcbJxmgDQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 53E2C5FE26;
	Fri, 22 Mar 2024 13:50:25 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4294C136AD;
	Fri, 22 Mar 2024 13:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aGPoDqGM/WWSJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:25 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 10/18] nvme/rc: remove unused connect options
Date: Fri, 22 Mar 2024 14:50:07 +0100
Message-ID: <20240322135015.14712-11-dwagner@suse.de>
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
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 53E2C5FE26
X-Spam-Flag: NO

These options are not used, thus remove them.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 7f436037eb94..4ad6cb640627 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -410,9 +410,6 @@ _nvme_connect_subsys() {
 	local positional_args=()
 	local trtype=""
 	local subsysnqn=""
-	local traddr="$def_traddr"
-	local host_traddr="$def_host_traddr"
-	local trsvcid="$def_trsvcid"
 	local hostnqn="$def_hostnqn"
 	local hostid="$def_hostid"
 	local hostkey=""
@@ -428,18 +425,6 @@ _nvme_connect_subsys() {
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
-			--traddr)
-				traddr="$2"
-				shift 2
-				;;
-			--host-traddr)
-				host_traddr="$2"
-				shift 2
-				;;
-			--trsvcid)
-				trsvcid="$2"
-				shift 2
-				;;
 			--hostnqn)
 				hostnqn="$2"
 				shift 2
@@ -498,9 +483,9 @@ _nvme_connect_subsys() {
 
 	ARGS=(--transport "${trtype}" --nqn "${subsysnqn}")
 	if [[ "${trtype}" == "fc" ]] ; then
-		ARGS+=(--traddr "${traddr}" --host-traddr "${host_traddr}")
+		ARGS+=(--traddr "${def_traddr}" --host-traddr "${def_host_traddr}")
 	elif [[ "${trtype}" != "loop" ]]; then
-		ARGS+=(--traddr "${traddr}" --trsvcid "${trsvcid}")
+		ARGS+=(--traddr "${def_traddr}" --trsvcid "${def_trsvcid}")
 	fi
 	ARGS+=(--hostnqn="${hostnqn}")
 	ARGS+=(--hostid="${hostid}")
-- 
2.44.0

