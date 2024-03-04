Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F1C482FF
	for <linux-block@vger.kernel.org>; Mon,  4 Mar 2024 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568791; cv=none; b=sT4bIYVsSAeZPK4yR6B6aecr2hA2Ru2NarNqGmaUsWQINBBUyDuHzLUltE9muw5R/8LYAvstAj2gZP3Wk8ILhtUG0rC+++YMTb4ZLkMtb5qh5C4p2YsGIfPtNWUdP7Kgn922fLopvvYcR8NzkRfG50N6SBojgcNdYHdTtQTVdj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568791; c=relaxed/simple;
	bh=JVU0VkAZhWbz4GAPZ2BBpGvYuhzsk1vFRSQ4wqSwA7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4Ym7ScCHXbzlksytNW0BB0rXmGaDIWYW353fvUQjeVVC9Ra/MVQ3JKBQ4mJfH/j/TSBgIY59VJamyatXXBB8sy6PBQ6kwhE2HFeJHr3Ju5bQ69Ia5OwGH4U3pz6Mx47Xe2wDRE017neWAbl0Fm9kKv2EN4MK6sUBZ+y1Moub3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K6x5303Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eeFc3Uv6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K6x5303Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eeFc3Uv6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K6x5303Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eeFc3Uv6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K6x5303Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eeFc3Uv6"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28C51220E1;
	Mon,  4 Mar 2024 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709568788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=60oY7wct07es8wGHSZmkx8IhjdrICnYow5D3CUvPbN4=;
	b=K6x5303QyomchmrMlz0IO3/wFjkYork8wQ3TbMf5n7OmD2bp9slrmAkr36Cmev0M+dBXrb
	oowD1Kyaa0QhNKKLg6nZaRfag8qyVaeGWw2FgSPn9RjHiuvEQWz9xUBDSwyBuvY6JrGu8D
	iCy+mhdbhDGlXWlkwz0yg7vN5fRlfGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709568788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=60oY7wct07es8wGHSZmkx8IhjdrICnYow5D3CUvPbN4=;
	b=eeFc3Uv6ItbEz6nE+O8cBv8bTQ+ReHWztPn6DUzT2+NABSg0IjtGaJV5SgPgZZTHc04axc
	/JVe2TtQbHRPfqAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709568788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=60oY7wct07es8wGHSZmkx8IhjdrICnYow5D3CUvPbN4=;
	b=K6x5303QyomchmrMlz0IO3/wFjkYork8wQ3TbMf5n7OmD2bp9slrmAkr36Cmev0M+dBXrb
	oowD1Kyaa0QhNKKLg6nZaRfag8qyVaeGWw2FgSPn9RjHiuvEQWz9xUBDSwyBuvY6JrGu8D
	iCy+mhdbhDGlXWlkwz0yg7vN5fRlfGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709568788;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=60oY7wct07es8wGHSZmkx8IhjdrICnYow5D3CUvPbN4=;
	b=eeFc3Uv6ItbEz6nE+O8cBv8bTQ+ReHWztPn6DUzT2+NABSg0IjtGaJV5SgPgZZTHc04axc
	/JVe2TtQbHRPfqAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 14AC7139C6;
	Mon,  4 Mar 2024 16:13:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 9daIAxTz5WUXewAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 04 Mar 2024 16:13:08 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 0/2] extend nvme/045 to reconnect with invalid key
Date: Mon,  4 Mar 2024 17:13:01 +0100
Message-ID: <20240304161303.19681-1-dwagner@suse.de>
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
X-Spamd-Result: default: False [4.01 / 50.00];
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
	 BAYES_HAM(-0.89)[85.88%]
X-Spam-Level: ****
X-Spam-Score: 4.01
X-Spam-Flag: NO

The is the test case for

https://lore.kernel.org/linux-nvme/20240304161006.19328-1-dwagner@suse.de/


Daniel Wagner (2):
  nvme/rc: add reconnect-delay argument only for fabrics transports
  nvme/048: add reconnect after ctrl key change

 tests/nvme/045     | 72 +++++++++++++++++++++++++++++++++++++++++++++-
 tests/nvme/045.out |  3 +-
 tests/nvme/rc      | 17 +++++++++--
 3 files changed, 88 insertions(+), 4 deletions(-)

-- 
2.44.0

