Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ACF2C1AF
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754748; cv=none; b=GXN1B9KjD9ZeFwcAZ0Ko4n5M0KzAc2vuJNj/1elCzOoVBuzOtguYPXUC0ZI0SpRwvvHncIdEQK0tdzLVd8KLkJIs16gcWIxec3/jKxRKBJ4M6m/fEAt122OTI6YgLMMtZA5gHQIgt/agyYH0GuTG030RP5NIolmw69hqBBm9cQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754748; c=relaxed/simple;
	bh=YCIGqzbnuxgRiH5eRqLpdZkhi+BH1RJ1HrRmb/vej8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DB7I3/t9FZmrw6ruws+C8drc5eU+2OrIgiQk6wq0P4vQjrR6OKOv7OrQTNa2AcB0nkysz107JhdkEOO5rTGSG7uH1cn2KhRcTfIAXIki6cRLjnM5WmqIoHor7mtEi8/g6585isHd9a6Ep03jI1NJd3jm1r9J8U0djeI1rZMoScw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED0C25C336;
	Mon, 18 Mar 2024 09:39:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB2431349D;
	Mon, 18 Mar 2024 09:39:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oOoPNLgL+GWlUAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 18 Mar 2024 09:39:04 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v1 01/10] common/xfs: propagate errors from _xfs_run_fio_verify_io
Date: Mon, 18 Mar 2024 10:38:46 +0100
Message-ID: <20240318093856.22307-2-dwagner@suse.de>
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
X-Spam-Score: -4.00
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Queue-Id: ED0C25C336

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

