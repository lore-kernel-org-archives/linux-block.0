Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AB27442B
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458852; cv=none; b=YaGyuUzzeXmte6HAP8AO0PkbN7dd3ToG77g8SmX8hP/qowvwJ0uGpvyqqRXd0mf7EpvFrjcknPHwz1YF0k3JQ9k56v439YLqVFYaCvhSIdWXJRfMdXO1sAedb/wOFX8fANM9RmiStcP+jzcT1KQoZdgRAECj+4GcWPaP0fkAJeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458852; c=relaxed/simple;
	bh=IMn6efD3rHdfHVxXztU+oxf/9Izh+7UABCTIhY13dI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6crQzvUHwD+eQlNA09W8tRJYRBBo7j+hn4OoY5Dt7dqlnpElkuQZV95TrID8oOCA07RfEpp/rV3e7Zh4MlirKsYtJOc99nCQkq/9D3w9hunkJb2SOce+1SDJvDzheU67ioUUp1qqz8DCoMW4V2qwZhNBr7cv7wFtKaapGnfThc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1nJvlAWe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mVW+nw0O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1nJvlAWe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mVW+nw0O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1nJvlAWe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mVW+nw0O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1nJvlAWe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mVW+nw0O"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 997AF5D657;
	Tue, 26 Mar 2024 13:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEnyo+AcYrJKCl2seZqGvjTKSN/N0LR3yJr6caLuKVY=;
	b=1nJvlAWeMGo1KEqXzyH9FfU9tdfzhmSyTh+T7JF8PwbsYulVFcc/1WSl3kzbGaJ93lRuvh
	obQM5oReYcdneZLm24+R0wAPBYrmoVB1KF7tPrNLf/vHKJrm6GUBd1rscW4iIYzd9FBxD4
	8HfZFYQRdwX1Jf1SwRyM0JLPxLdcTtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEnyo+AcYrJKCl2seZqGvjTKSN/N0LR3yJr6caLuKVY=;
	b=mVW+nw0OhF+r298XaVT1fUiL1Dow837fx0yVDfn7uOzWIqXwD/9cQFNyZ+ORW0oT42z5CY
	1VBDY6JjKI32hHDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEnyo+AcYrJKCl2seZqGvjTKSN/N0LR3yJr6caLuKVY=;
	b=1nJvlAWeMGo1KEqXzyH9FfU9tdfzhmSyTh+T7JF8PwbsYulVFcc/1WSl3kzbGaJ93lRuvh
	obQM5oReYcdneZLm24+R0wAPBYrmoVB1KF7tPrNLf/vHKJrm6GUBd1rscW4iIYzd9FBxD4
	8HfZFYQRdwX1Jf1SwRyM0JLPxLdcTtk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458848;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yEnyo+AcYrJKCl2seZqGvjTKSN/N0LR3yJr6caLuKVY=;
	b=mVW+nw0OhF+r298XaVT1fUiL1Dow837fx0yVDfn7uOzWIqXwD/9cQFNyZ+ORW0oT42z5CY
	1VBDY6JjKI32hHDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 87B3513587;
	Tue, 26 Mar 2024 13:14:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id fXatHyDKAmYENwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:08 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 05/20] nvme/{012,013,035}: check return value of _xfs_run_fio_verify_io
Date: Tue, 26 Mar 2024 14:13:47 +0100
Message-ID: <20240326131402.5092-6-dwagner@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
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
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
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

