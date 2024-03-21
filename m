Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB415472A
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014459; cv=none; b=HZuMDq1b6af3DWaA+Kd0YlOp9s6CxTwFiURlSIbfruT2WPFbAbVBisoQCwa/9dK5/MAia1DtX4/P8PKZaF+WA0sQNQcV8GPq3iM9MvJNmI3JL2oy72W4kEtMLxu6uk21G9M3WEGWaMSMOgKpYqlQqhqEUC5/HT4M33M1lyqi11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014459; c=relaxed/simple;
	bh=xBpx4xdyttuWG/yFdfgtDWAnt308WnXkCP1HE8JyQSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hc5l1RlZ/YPFMmzWso1wdzF5GF7Gp9UkMG5azKCtBTpK6j0po4oxTU/4Af6Hj9tV0Y/y9dldXU4WBcMRb2uPlv1C9MKIW07o5Sdi3T7FaeAX2xqihxwHEs7QFtBKgJJWhvo8DkDMb4bsTY57cgnsWZpKCsf0pSFZN4qoNWFWCcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lG7cD2PK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QZ/zVNYi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lG7cD2PK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QZ/zVNYi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lG7cD2PK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QZ/zVNYi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lG7cD2PK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QZ/zVNYi"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 87DA65CBC6;
	Thu, 21 Mar 2024 09:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B70yQI77lSD6R+II1ZF++3m28FGPD0kcKsOZKvVNRI0=;
	b=lG7cD2PKfLoJk7gu7r+HDx/itkFEcsWAwcez8jbz3eC/VUtRFbCy/FGjRG0ekfUs+H7tfj
	FmuiyxwUJ5G8QAqQ4b6DSfZPHZqHQX17rUcmGuQmsyQRmcZ0wfb2kpNsYHz9n38oGVBdWB
	Pa7MNVOxVYp8ed/WlsuXLl7AWrCU2Eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B70yQI77lSD6R+II1ZF++3m28FGPD0kcKsOZKvVNRI0=;
	b=QZ/zVNYi4jlfYxbxWiaKp2RBStX+ZDVoxosa8btQQUhIwMzMGpbJNZenIT90WhkeSNMVMl
	LDZnx/NboLx0OBBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014456; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B70yQI77lSD6R+II1ZF++3m28FGPD0kcKsOZKvVNRI0=;
	b=lG7cD2PKfLoJk7gu7r+HDx/itkFEcsWAwcez8jbz3eC/VUtRFbCy/FGjRG0ekfUs+H7tfj
	FmuiyxwUJ5G8QAqQ4b6DSfZPHZqHQX17rUcmGuQmsyQRmcZ0wfb2kpNsYHz9n38oGVBdWB
	Pa7MNVOxVYp8ed/WlsuXLl7AWrCU2Eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014456;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B70yQI77lSD6R+II1ZF++3m28FGPD0kcKsOZKvVNRI0=;
	b=QZ/zVNYi4jlfYxbxWiaKp2RBStX+ZDVoxosa8btQQUhIwMzMGpbJNZenIT90WhkeSNMVMl
	LDZnx/NboLx0OBBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BA1213976;
	Thu, 21 Mar 2024 09:47:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EtnBGDgC/GXZDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:36 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 10/18] nvme/rc: remove unused connect options
Date: Thu, 21 Mar 2024 10:47:19 +0100
Message-ID: <20240321094727.6503-11-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321094727.6503-1-dwagner@suse.de>
References: <20240321094727.6503-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.72
X-Spamd-Result: default: False [3.72 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-0.98)[-0.977];
	 R_RATELIMIT(0.00)[to_ip_from(RLm9s6cmri9k4spo5w97m8fq33)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

These options are not used, thus remove them.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index bcc936549689..ba83f32febb8 100644
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

