Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0E6757E4
	for <linux-block@vger.kernel.org>; Tue, 26 Mar 2024 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458861; cv=none; b=V8H6rOrNXZ05qjqj0bBh7AdlYfbMypU7xGDVvnJ+6ER8BvXOkje6KPOyJnRodUOYJ/D9wKSlyRTwHl3DGUEoEI2LSaqt0+W7ZKzYbt/umNVvh5zNHzRHbpE27Ls7ilLWFE1cNKH21ZFoWQ74qIwksxmMsyV9LQwOeRIxz9N0QAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458861; c=relaxed/simple;
	bh=JqKE2N8SMV1Emk1mDNVMBkXmRjUMBJQkCJuJmbGqV9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJN4H8hp7829RBr0+6Nhq8vMd3LBmCTmf0VVb8gd8iUaDKXvq6pjtYduanLbo4002ivJ+1QYFAwQgr/kfowb9MDESwR91+e4gkBdRi0qe1iVWKCUZNBJE5fD7F9S8bKmruKbdVF37O1CfjkGnj7LVoAK9Vo4GpYL9S+SrIvz5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=urmC2Y46; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NLWZuotC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=urmC2Y46; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NLWZuotC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="urmC2Y46";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NLWZuotC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="urmC2Y46";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NLWZuotC"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 22FDF373CA;
	Tue, 26 Mar 2024 13:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=;
	b=urmC2Y463zI4LAuuayeqgr5nV3fFVV57tlaJDGEgthI5OIpFhnnk4phfamlpTgSA1HW1v+
	wFTpsgYzvuyosxZ+ZtuLsmC5rugHFgQeGnmhdRmIbwtIsycQnO7FaLhTfhvIRRaFyYVNJC
	ZhJh3fp+h3fX7cWjKf92Cv9fMBDhwWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=;
	b=NLWZuotC8NqNpY45q7SuIC/94cdKyyRHdCVyR/95128+QqX+UWSw97GWDliTHVwyiV2/1v
	ZZSNkgYeU/vjZMCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=;
	b=urmC2Y463zI4LAuuayeqgr5nV3fFVV57tlaJDGEgthI5OIpFhnnk4phfamlpTgSA1HW1v+
	wFTpsgYzvuyosxZ+ZtuLsmC5rugHFgQeGnmhdRmIbwtIsycQnO7FaLhTfhvIRRaFyYVNJC
	ZhJh3fp+h3fX7cWjKf92Cv9fMBDhwWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a63muCPZYWeAQkA9FtpSeKqkvj6LphOGjlZs+vXd+mQ=;
	b=NLWZuotC8NqNpY45q7SuIC/94cdKyyRHdCVyR/95128+QqX+UWSw97GWDliTHVwyiV2/1v
	ZZSNkgYeU/vjZMCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FDAD13587;
	Tue, 26 Mar 2024 13:14:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id znFeAirKAmYqNwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:18 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 20/20] nvme/028: drop unused nvmedev
Date: Tue, 26 Mar 2024 14:14:02 +0100
Message-ID: <20240326131402.5092-21-dwagner@suse.de>
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
X-Spam-Score: 0.74
X-Spamd-Result: default: False [0.74 / 50.00];
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
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.97)[99.85%]
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Flag: NO

Nothing uses nvmedev, so just remove it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/028 | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/nvme/028 b/tests/nvme/028
index 4710bba1f416..9f4a90581984 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -20,15 +20,10 @@ test() {
 
 	_setup_nvmet
 
-	local nvmedev
-
 	_nvmet_target_setup --blkdev file
 
 	_nvme_connect_subsys
 
-	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
-	_check_uuid "${nvmedev}"
-
 	if ! nvme list-subsys 2>> "$FULL" | grep -q "${nvme_trtype}"; then
 		echo "ERROR: list-subsys"
 	fi
-- 
2.44.0

