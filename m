Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F923F9CC
	for <linux-block@vger.kernel.org>; Mon,  4 Mar 2024 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560111; cv=none; b=uytTeqKhp9YWVrnApADgARuWR3RuRhvLwtitZmT3x02pPA3i8knuu0UbaMk0APtHLoW3u4yrwvtkKO6HzJ2brodR2JJSkBaCYyoqQEr+pzADeEeW73knoxXPa7xf/qXhMSLC75vEsTAQZm++UkOLJ7VAS32lzVWmDhbZ/5Xbrv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560111; c=relaxed/simple;
	bh=JVl4hlskTzjxwSQ23uTctRyJYZXNeZJVBWsk+eri2QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=al0AQbxd40GuW8aHDQs/YGl3x9cC1gMnOu+HV8T41KE1EwRrYCuGlFyJi1wUc8znjAmb0uBRchJ9FUOsXoERfbvXDQXRjCbGCMSZVeYK3beG/24Ghnw1hpde/hhIN3O0MBJ3FZtaTaHIZvAAs1kTfYzAcm5MHYAgIAEA7BW4ex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YLFi/baN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yd/mcWgL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YLFi/baN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yd/mcWgL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YLFi/baN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yd/mcWgL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YLFi/baN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yd/mcWgL"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BF40A4E7D6;
	Mon,  4 Mar 2024 13:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709560107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YOb9NOunQoYd1XGViW40ozdbjE2xreUtD/GXyT2nWwA=;
	b=YLFi/baNf9LEXNCxXn77sKPwrvkno7gibNX7zuaUtCVwLkHkvO45o2wsp82TXtnY2loFse
	SKubONFdZ21gStbn/UkwZiAJWsmiWj3sURqtEwaiEDl81Mfwh6cQfwJEwmtpEjzYtZdmq8
	m8jLtfiWNRwmB97xgugv3Zj33Mt1rn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709560107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YOb9NOunQoYd1XGViW40ozdbjE2xreUtD/GXyT2nWwA=;
	b=yd/mcWgLigW5T3wNzRXYOFLbPyDQfbfnbugOgiLpwTTPdU/oTc4FssNspBTH1sQ45458q0
	4KNR3sVbyZ7T7SBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709560107; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YOb9NOunQoYd1XGViW40ozdbjE2xreUtD/GXyT2nWwA=;
	b=YLFi/baNf9LEXNCxXn77sKPwrvkno7gibNX7zuaUtCVwLkHkvO45o2wsp82TXtnY2loFse
	SKubONFdZ21gStbn/UkwZiAJWsmiWj3sURqtEwaiEDl81Mfwh6cQfwJEwmtpEjzYtZdmq8
	m8jLtfiWNRwmB97xgugv3Zj33Mt1rn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709560107;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=YOb9NOunQoYd1XGViW40ozdbjE2xreUtD/GXyT2nWwA=;
	b=yd/mcWgLigW5T3wNzRXYOFLbPyDQfbfnbugOgiLpwTTPdU/oTc4FssNspBTH1sQ45458q0
	4KNR3sVbyZ7T7SBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AB39F139C6;
	Mon,  4 Mar 2024 13:48:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 5FhWKCvR5WUfUwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 04 Mar 2024 13:48:27 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 0/2] make nvme/048 checks more robust
Date: Mon,  4 Mar 2024 14:48:24 +0100
Message-ID: <20240304134826.31965-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.03 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.87)[85.71%]
X-Spam-Level: ****
X-Spam-Score: 4.03
X-Spam-Flag: NO

The nvme/048 tests fails with the fc transport because the check logic is racing
with the reset code in the target. By making the checks a bit more robust in
blktests, this test passes for all transports.

changes
v2:
  - added RB tags
  - refactored exit path as suggested by Shinichiro
v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20240301094817.29491-1-dwagner@suse.de/

*** BLURB HERE ***

Daniel Wagner (2):
  nvme/048: remove unused argument for set_qid_max
  nvme/048: make queue count check retry-able

 tests/nvme/048 | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

-- 
2.44.0

