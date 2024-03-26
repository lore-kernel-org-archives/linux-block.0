Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951974C0C
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458855; cv=none; b=oBaG1kVVHIkww3Fa7kdB3HtlPXzPcQp7FR7wETS9dDtr3RBU1sVqchFmHVH5ENy+09O93Jrye5OONyNnMJgsRSsSmK515Yeyyvti0I5HUPDU46dTBiYlrrNjqKWl3fb0Sy6hFTpiihmhU9ktRyfeA5eWtEneWEmg8AlNHqjUtE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458855; c=relaxed/simple;
	bh=LfoyrayKYoLkggjYpp5l1i4X8Pq3zks8nbttMhfpi3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V09XZaXaqZFMmWOMxWdpmkOGe4Y5FEUXL4TWEqfXZ/Uar9hHqyS1C3HkPiLXMYZXXU+e9I156ybuWN74mNb71sA8yO4PJcREwqOhIfdpyeiW0a3/4YzZdCwRTa25zrRmboGGXOozqszjJRvvamXRKH40vkSFAUyi6sRGS90TgBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dbJm4A0K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HxyzxpU+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dbJm4A0K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HxyzxpU+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dbJm4A0K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HxyzxpU+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dbJm4A0K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HxyzxpU+"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D73665D65C;
	Tue, 26 Mar 2024 13:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPXiBI8rMoQrJ9iRb9rD9NF39La2pyPU2rJ4anwyLkU=;
	b=dbJm4A0K2xISlf07iLGAqwbxTL+qRcwAS6W70aS7E1ayRzFtqQ+wqKKiZkTTmMNp7+a34J
	P49edl/o39o8xKZmvUZ+6Phv6/PZXzJtLyxqeOkorbNdqNG8gcNIj3oZzjdDQV8bEFlwWL
	nXzytDPsMjznBsxO7XEJBtIJAEmMzME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPXiBI8rMoQrJ9iRb9rD9NF39La2pyPU2rJ4anwyLkU=;
	b=HxyzxpU+G9bU3BQwfazTsWefwMWq3MWPUMs96RjRIOeBvgMB/NJsQmXGJrWSQ2zsVyRzbW
	mowCbCVgkO4gopDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPXiBI8rMoQrJ9iRb9rD9NF39La2pyPU2rJ4anwyLkU=;
	b=dbJm4A0K2xISlf07iLGAqwbxTL+qRcwAS6W70aS7E1ayRzFtqQ+wqKKiZkTTmMNp7+a34J
	P49edl/o39o8xKZmvUZ+6Phv6/PZXzJtLyxqeOkorbNdqNG8gcNIj3oZzjdDQV8bEFlwWL
	nXzytDPsMjznBsxO7XEJBtIJAEmMzME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPXiBI8rMoQrJ9iRb9rD9NF39La2pyPU2rJ4anwyLkU=;
	b=HxyzxpU+G9bU3BQwfazTsWefwMWq3MWPUMs96RjRIOeBvgMB/NJsQmXGJrWSQ2zsVyRzbW
	mowCbCVgkO4gopDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C60FA13587;
	Tue, 26 Mar 2024 13:14:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1s7rLiPKAmYSNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:11 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 10/20] nvme/rc: remove unused connect options
Date: Tue, 26 Mar 2024 14:13:52 +0100
Message-ID: <20240326131402.5092-11-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326131402.5092-1-dwagner@suse.de>
References: <20240326131402.5092-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=dbJm4A0K;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HxyzxpU+
X-Rspamd-Queue-Id: D73665D65C

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

