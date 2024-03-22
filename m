Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B943747A53
	for <linux-block@vger.kernel.org>; Fri, 22 Mar 2024 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115426; cv=none; b=BcIrne3l7Sgz8cHD8kMlbId5rEc1/zdxFvLowvFBGmlxKgryW8awybFXPHGeX3rinNj2/RM7k7uGXpymW5Clxn1J9Gcbcsx3E1jHKXrhskK9TxAYG1Z82KnHN9eqodUdfWdL67KORHtCje28FTcI64i3S7OrKcPiT6AzKMM8Ah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115426; c=relaxed/simple;
	bh=YCIGqzbnuxgRiH5eRqLpdZkhi+BH1RJ1HrRmb/vej8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fkEYcvT2Ni3xriPg9qN4A/v1cXw7MwMV2MBJP2LS6Ys6pbv/Sso5UJHxoG/C2oyf5eu+c4c41so2CGPCUrhaNg5A1Og0Ll5q6KRY2xj1exNW5QHcbNhYNzMrVO6Mwoxzma5QXhdG6oHw2nhYTGw/1I4IG6oeb8VHz+r3Xl+2qb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DPz+J9vQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NDUZYCjo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DPz+J9vQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NDUZYCjo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DPz+J9vQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NDUZYCjo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DPz+J9vQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NDUZYCjo"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 86C2720C1C;
	Fri, 22 Mar 2024 13:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YI2CBx8BIa8CSsKBnOyhZ/dTKMZfvGnVLkV71KB7Krk=;
	b=DPz+J9vQ2SIFz13KNQjbb4eFlI2PYgS1vg4T5f6V83g7KS0x59fqzfKgcVv56JCwZpus2T
	Cb/del0YL6wgT6LR6J3JAtJlTO2sQnBXmaCx/4Pmtu55fhwpvJWTeBbgXnWQosJS+MBdZ9
	xXtR8hmXkPoLgS7ViO0hDi5mdLGajlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YI2CBx8BIa8CSsKBnOyhZ/dTKMZfvGnVLkV71KB7Krk=;
	b=NDUZYCjodylMnD6VNRK/1R414nnkqaJHoJjBf5a/3U9pGU8mYmU2wHnXIkvrvkxLnTnd0F
	iJMjPahAj6dz38Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YI2CBx8BIa8CSsKBnOyhZ/dTKMZfvGnVLkV71KB7Krk=;
	b=DPz+J9vQ2SIFz13KNQjbb4eFlI2PYgS1vg4T5f6V83g7KS0x59fqzfKgcVv56JCwZpus2T
	Cb/del0YL6wgT6LR6J3JAtJlTO2sQnBXmaCx/4Pmtu55fhwpvJWTeBbgXnWQosJS+MBdZ9
	xXtR8hmXkPoLgS7ViO0hDi5mdLGajlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115421;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YI2CBx8BIa8CSsKBnOyhZ/dTKMZfvGnVLkV71KB7Krk=;
	b=NDUZYCjodylMnD6VNRK/1R414nnkqaJHoJjBf5a/3U9pGU8mYmU2wHnXIkvrvkxLnTnd0F
	iJMjPahAj6dz38Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7504B136AD;
	Fri, 22 Mar 2024 13:50:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WjEfG52M/WWCJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:21 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 04/18] common/xfs: propagate errors from _xfs_run_fio_verify_io
Date: Fri, 22 Mar 2024 14:50:01 +0100
Message-ID: <20240322135015.14712-5-dwagner@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.21
X-Spamd-Result: default: False [-1.21 / 50.00];
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
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.91)[86.20%]
X-Spam-Flag: NO

If _xfs_mkfs_and_mount fails _xfs_run_fio_verify_io will continue to
execute and fio will run against the local file system instead against
the block device.

Propagate all errors back to the caller.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/xfs | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/common/xfs b/common/xfs
index 37ce85878df2..569770fecd53 100644
--- a/common/xfs
+++ b/common/xfs
@@ -16,7 +16,7 @@ _xfs_mkfs_and_mount() {
 
 	mkdir -p "${mount_dir}"
 	umount "${mount_dir}"
-	mkfs.xfs -l size=64m -f "${bdev}"
+	mkfs.xfs -l size=64m -f "${bdev}" || return $?
 	mount "${bdev}" "${mount_dir}"
 }
 
@@ -27,8 +27,10 @@ _xfs_run_fio_verify_io() {
 	local sz_mb
 	local avail
 	local avail_mb
+	local rc
 
-	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
+	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" \
+		>>"${FULL}" 2>&1 || return $?
 
 	avail="$(df --output=avail "${mount_dir}" | tail -1)"
 	avail_mb="$((avail / 1024))"
@@ -43,7 +45,10 @@ _xfs_run_fio_verify_io() {
 	fi
 
 	_run_fio_verify_io --size="${sz_mb}m" --directory="${mount_dir}/"
+	rc=$?
 
 	umount "${mount_dir}" >> "${FULL}" 2>&1
 	rm -fr "${mount_dir}"
+
+	return "${rc}"
 }
-- 
2.44.0

