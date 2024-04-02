Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829559162
	for <linux-block@vger.kernel.org>; Tue,  2 Apr 2024 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052210; cv=none; b=r9CIay04JBBjafcYs4wcAwjj8H2Mm8rFUgDkVGM+iFIue5EnZ/EUc7U5jCvnVoAiMzoL1M3iX0SKBjbOAVcCWEvYGePzSKFwXWw7cWite0VjUHCJoobUwMay+ShZYBMV7/ThWTgLDlJlfTih6IMCMLmof1l1V8ZZTUHy+ZjcQ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052210; c=relaxed/simple;
	bh=gUN8Kn9VAJV4tgZRpH3mIEyo87ak8PtFj4iAiqRh8ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ijogo+9f7Q+4qqatSg3OvP7IqyVh3qjn35trUo44UYYTRVw1zOaWzORJCUO1WHPQsuzPoZeYkzeROHA/aIfe4zSC6ko35C+/Q01cB4DKx7HEJYlL/4C7/FaBsrz7J1bpeoDqn/2xDq/TLNky9KkygB4j97zq+aUZEjYPV845dhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S2YZKXD+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YtEhXuyf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S2YZKXD+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YtEhXuyf"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 18ECF3452D;
	Tue,  2 Apr 2024 10:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712052205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Mj2NWuR7dc4q1preQthCCIAcIisu/i5K+dIUxhLJoY=;
	b=S2YZKXD+Cnvwxyt3yDtQO6XVtAKhNLOc8yl1WZ95Csh0gqPglf/SjMryrxPutmYq5c1J6G
	77UegE5Z0J0A4E2LBN8MNMUxO+lk33AY7sSifxgC9baBEICS6EwNpgQTCqHn1RfT2FWM1B
	PTTWlTqJl1lnp7djxFT15Yx47ix0jCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712052205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Mj2NWuR7dc4q1preQthCCIAcIisu/i5K+dIUxhLJoY=;
	b=YtEhXuyfqxT0sCaF7oM4ckNTzLT8fWDmwWEecyWYEPMso5iQN1emkFm3igU+6Mf9PqSHt/
	GwzCSG7BCSQ29IDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 04D7F13A90;
	Tue,  2 Apr 2024 10:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id TltTO+zXC2b0CQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 02 Apr 2024 10:03:24 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 1/3] nvme/rc: add blkdev type environment variable
Date: Tue,  2 Apr 2024 12:03:20 +0200
Message-ID: <20240402100322.17673-2-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402100322.17673-1-dwagner@suse.de>
References: <20240402100322.17673-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 5.90
X-Spam-Flag: NO
X-Spamd-Bar: +++++
X-Spamd-Result: default: False [5.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-0.98)[-0.985];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[37.34%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: *****
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 18ECF3452D

Introduce nvmet_blkdev_type environment variable which allows to control
the target setup. This allows us to drop duplicate tests which just
differ how the target is setup.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md | 2 ++
 tests/nvme/rc                  | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index ae80860c917a..9cc53cb8d147 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -109,6 +109,8 @@ The NVMe tests can be additionally parameterized via environment variables.
 	and 'G' postfix are supported.
 - nvme_num_iter: 1000 (default)
   The number of iterations a test should do.
+- nvmet_blkdev_type: 'device' (default), 'file'
+  Select different target block device type backends.
 
 ### Running nvme-rdma and SRP tests
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 203cf0c7903b..5fa1871f7fd8 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,7 @@ export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 nvme_trtype=${nvme_trtype:-"loop"}
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
+nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 
 # TMPDIR can not be referred out of test() or test_device() context. Instead of
 # global variable def_flie_path, use this getter function.
@@ -826,7 +827,7 @@ _find_nvme_passthru_loop_dev() {
 }
 
 _nvmet_target_setup() {
-	local blkdev_type="device"
+	local blkdev_type="${nvmet_blkdev_type}"
 	local blkdev
 	local ctrlkey=""
 	local hostkey=""
-- 
2.44.0

