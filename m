Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7F4597E
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014456; cv=none; b=Da+6MLumT4wex8jkUsHuZZQ5rTFa7vXDQvsfbAxXhRK0Q37zDMfMYp7p2syzgGe+hmsiub090aIdKoS1iTzocFMyCsKuKWeRV1LDw6/KS+kQlwl0ROVLmP8oY+Xx6q93enO9vXBe35Rzb69kCww7YPfsk0FYQNHnkyHd7KzARCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014456; c=relaxed/simple;
	bh=YCIGqzbnuxgRiH5eRqLpdZkhi+BH1RJ1HrRmb/vej8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kymJPwEocfvkzxl4bZaPiejwaP0r14gmT20NAb1JYdFZx5FnXgACCdBupXolygHHSaY09A9q8lOVNC12GYd46aB4SnVCViW5XFrjUAf6HCXZgsnj7rZzy3piLS8+w9oaF0KZw2gZyCrbN0G8JsQpejccG9qyqJpnuCLEWQdFo2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zImkQgyX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+rKSb46n; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zImkQgyX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+rKSb46n; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zImkQgyX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+rKSb46n";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zImkQgyX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+rKSb46n"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C886D5CBC2;
	Thu, 21 Mar 2024 09:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YI2CBx8BIa8CSsKBnOyhZ/dTKMZfvGnVLkV71KB7Krk=;
	b=zImkQgyXuNgEIsK4dEuJYU9OWaxKLPpUt59G4H/1J2Dvh6fRKo2lR2E5NUxePRzY/dLNrH
	RRINRHWOdWwPeBjh3ujpHxRoAG6KYk13NTkYbycZZb5Wjpnu6nvqQaBacZ7xmm6qc9nzh/
	//SgOB1UXo0sWcazyIvIBZwSk5c4Eo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YI2CBx8BIa8CSsKBnOyhZ/dTKMZfvGnVLkV71KB7Krk=;
	b=+rKSb46n2bTU1hma/zw5eVhHXeVTAN4EztnhPtFoyLxBE24zJ8HT3YyyKDH9bm5nIvZt8U
	jxXOt4YdTACz7/Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YI2CBx8BIa8CSsKBnOyhZ/dTKMZfvGnVLkV71KB7Krk=;
	b=zImkQgyXuNgEIsK4dEuJYU9OWaxKLPpUt59G4H/1J2Dvh6fRKo2lR2E5NUxePRzY/dLNrH
	RRINRHWOdWwPeBjh3ujpHxRoAG6KYk13NTkYbycZZb5Wjpnu6nvqQaBacZ7xmm6qc9nzh/
	//SgOB1UXo0sWcazyIvIBZwSk5c4Eo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YI2CBx8BIa8CSsKBnOyhZ/dTKMZfvGnVLkV71KB7Krk=;
	b=+rKSb46n2bTU1hma/zw5eVhHXeVTAN4EztnhPtFoyLxBE24zJ8HT3YyyKDH9bm5nIvZt8U
	jxXOt4YdTACz7/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6B7B13976;
	Thu, 21 Mar 2024 09:47:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7KgyKzQC/GW/DwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:32 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 04/18] common/xfs: propagate errors from _xfs_run_fio_verify_io
Date: Thu, 21 Mar 2024 10:47:13 +0100
Message-ID: <20240321094727.6503-5-dwagner@suse.de>
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
X-Spam-Score: 2.43
X-Spam-Flag: NO
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zImkQgyX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+rKSb46n
X-Spamd-Result: default: False [2.43 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.06)[87.80%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: **
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C886D5CBC2

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

