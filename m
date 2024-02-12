Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F52BAE7
	for <linux-block@vger.kernel.org>; Mon, 12 Feb 2024 10:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734453; cv=none; b=EwqW+r0f0L7RQ+bKPW2MkvlznwW3/jiIJtKD6nKMAKfm07upAH3Hoj2vtMouumYONXpiMCbS/cCGudi07EEyDzS5jg6kKkRRRJs64JQH+LLl2XHUGl+twbZA+n8VtgsO9DU9+aMxJJbs0RwgWiTGCtZoSvRc8rEN4ideoxblzuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734453; c=relaxed/simple;
	bh=dgKa9VDQvHYsZfOETtM98F0usTw6EuwcSDbuNfLp/vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gDbNvgecUccQp/LfppLyhD5/945ZMjm4OwFe8lPM+XpDhTGzlsYhNVlips0bn1JvAxyw/WPhrr3K01j69AoJIXiSbs6DhssR7bDrurGpwCRmAbGG2wyAvus+Nr/HM9nYYr9SgUilR3AxU+hdtBOgbapLIlqNwURimnTR/zYPEZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ufejVy7Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BCacqDln; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ufejVy7Z; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BCacqDln; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ufejVy7Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BCacqDln";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ufejVy7Z";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BCacqDln"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 85C311F460;
	Mon, 12 Feb 2024 10:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bfIsHwXpWLEWMKfGhN2ivFAAbKUNepkGa9IJPENRoo0=;
	b=ufejVy7ZIvTZaDzyuEX6PxUwFi2xLrfLRTTePAWqABKsRUCnPF05vZ5V1ZGDkYyxqKs/YQ
	x0KniUUABVBjXM7Wgl9lEBwCC04egVzXUzF6OUhqmoPjDTviSK1k05j2ET9qBnDb9mEuI4
	NAkutl8aQXMVrzTMDFBzNHOVEbhFzKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bfIsHwXpWLEWMKfGhN2ivFAAbKUNepkGa9IJPENRoo0=;
	b=BCacqDln6eNA6ZYEkFoUhxX5QXaIQgVJOhq7qvQDpKB21XOIqVVaWZEGA+bnVREaI3+gjD
	iLbXbYC+V1UgezCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bfIsHwXpWLEWMKfGhN2ivFAAbKUNepkGa9IJPENRoo0=;
	b=ufejVy7ZIvTZaDzyuEX6PxUwFi2xLrfLRTTePAWqABKsRUCnPF05vZ5V1ZGDkYyxqKs/YQ
	x0KniUUABVBjXM7Wgl9lEBwCC04egVzXUzF6OUhqmoPjDTviSK1k05j2ET9qBnDb9mEuI4
	NAkutl8aQXMVrzTMDFBzNHOVEbhFzKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=bfIsHwXpWLEWMKfGhN2ivFAAbKUNepkGa9IJPENRoo0=;
	b=BCacqDln6eNA6ZYEkFoUhxX5QXaIQgVJOhq7qvQDpKB21XOIqVVaWZEGA+bnVREaI3+gjD
	iLbXbYC+V1UgezCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 730E513A0E;
	Mon, 12 Feb 2024 10:40:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id T9mfGrL1yWXoCwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 12 Feb 2024 10:40:50 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 0/5] fc transport cleanups
Date: Mon, 12 Feb 2024 11:40:41 +0100
Message-ID: <20240212104046.13127-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ufejVy7Z;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BCacqDln
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.50)[79.97%]
X-Spam-Score: 0.99
X-Rspamd-Queue-Id: 85C311F460
X-Spam-Flag: NO

Fixed the typos and collected the RB tags. 

changes:
v2:
  - typo fixes
  - collected RB tags
  
v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20240206131655.32050-1-dwagner@suse.de/

Daniel Wagner (5):
  nvme/029: fix local variable declarations
  nvme/rc: filter out errors from cat when reading files
  nvme/rc: do not issue warnings on cleanup when using fc transport
  nvme/rc: do not issue errors when disconnecting when using fc
    transport
  nvme/rc: revert nvme-cli context tracking

 tests/nvme/029 |  2 +-
 tests/nvme/rc  | 73 +++++---------------------------------------------
 2 files changed, 8 insertions(+), 67 deletions(-)

-- 
2.43.0

