Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6001E2C1B6
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754748; cv=none; b=MqYXHdHFHRUIaN00aXZ/ZVewiihziCr5bt4vDi1f6I+iaWhWI672m8RfEWx35m0CwokqFmiguQYgxJvL2QA/YPs8HAWvi8H2qsPmeVOO26rOgpBo8tCjXC1awcF3xubi7HrH7eJV5OzLejcvNQLOcts+pJ6WTJv4um46+1ZmSuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754748; c=relaxed/simple;
	bh=IMn6efD3rHdfHVxXztU+oxf/9Izh+7UABCTIhY13dI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFCyZOLqxbtQwLxasxUeSqwDWNI+FNmBUXktlE9l7MCFCRqfCqt94pjZArjHdnNQgom0oDjW4fbFFSFR04YzVw5lJEUO3e6EsdtdQsnBuZi3hhWoWyhp8pOJSodlhYcF7F63wbB5b4bJKLkwSeNBYDqpAjDCyewIqUsKg3zwgMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UmUVZYdV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nv6Nkm3E; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UmUVZYdV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Nv6Nkm3E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UmUVZYdV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nv6Nkm3E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UmUVZYdV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Nv6Nkm3E"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93A8B5C339;
	Mon, 18 Mar 2024 09:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEnyo+AcYrJKCl2seZqGvjTKSN/N0LR3yJr6caLuKVY=;
	b=UmUVZYdVjkX1ZVWthvtPIDQov4iAiwZ9ykfv5AYl6PKkGAn+BTXOeQv8uUOeDypPLYoZYF
	RzF5vbG4DvHGU8z7RjshCSHX7YDlCv+lyQ/Zy3SSzxq6wjcBKbYww4leV6JGezp6iVWkTA
	SbGp12Da/xxaCU20FSsR2MglFQQFU6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEnyo+AcYrJKCl2seZqGvjTKSN/N0LR3yJr6caLuKVY=;
	b=Nv6Nkm3E7yyC//gBzLZsaXUPUH61U9dyrDAnlmJ8xim5abR6P0KEm5RrHMuPpqrRFaRTav
	bBtD0NuVqDVeW8BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEnyo+AcYrJKCl2seZqGvjTKSN/N0LR3yJr6caLuKVY=;
	b=UmUVZYdVjkX1ZVWthvtPIDQov4iAiwZ9ykfv5AYl6PKkGAn+BTXOeQv8uUOeDypPLYoZYF
	RzF5vbG4DvHGU8z7RjshCSHX7YDlCv+lyQ/Zy3SSzxq6wjcBKbYww4leV6JGezp6iVWkTA
	SbGp12Da/xxaCU20FSsR2MglFQQFU6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEnyo+AcYrJKCl2seZqGvjTKSN/N0LR3yJr6caLuKVY=;
	b=Nv6Nkm3E7yyC//gBzLZsaXUPUH61U9dyrDAnlmJ8xim5abR6P0KEm5RrHMuPpqrRFaRTav
	bBtD0NuVqDVeW8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 815CC1349D;
	Mon, 18 Mar 2024 09:39:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bBMiHrkL+GWoUAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 18 Mar 2024 09:39:05 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v1 02/10] nvme/{012,013,035}: check return value of _xfs_run_fio_verify_io
Date: Mon, 18 Mar 2024 10:38:47 +0100
Message-ID: <20240318093856.22307-3-dwagner@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
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
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.980];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

When _xfs_run_fio_verify_io fails we should log the error. Currently, no
failure is detected when this function fails.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/012 | 4 +++-
 tests/nvme/013 | 4 +++-
 tests/nvme/035 | 4 +++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tests/nvme/012 b/tests/nvme/012
index c5e0eb9c5e23..f0914ce3206b 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -33,7 +33,9 @@ test() {
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
 
-	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
+	if ! _xfs_run_fio_verify_io "/dev/${nvmedev}n1"; then
+		echo "FAIL: fio verify failed"
+	fi
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 3ec280ff24cf..3cef009cb9f4 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -32,7 +32,9 @@ test() {
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 	_check_uuid "${nvmedev}"
 
-	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
+	if ! _xfs_run_fio_verify_io "/dev/${nvmedev}n1"; then
+		echo "FAIL: fio verify failed"
+	fi
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
diff --git a/tests/nvme/035 b/tests/nvme/035
index 712fe1dbcfb8..01aa09077d6a 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -31,7 +31,9 @@ test_device() {
 	_nvmet_passthru_target_setup "${def_subsysnqn}"
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${def_subsysnqn}")
 
-	_xfs_run_fio_verify_io "${nsdev}" "${nvme_img_size}"
+	if ! _xfs_run_fio_verify_io "${nsdev}" "${nvme_img_size}"; then
+		echo "FAIL: fio verify failed"
+	fi
 
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 	_nvmet_passthru_target_cleanup "${def_subsysnqn}"
-- 
2.44.0

