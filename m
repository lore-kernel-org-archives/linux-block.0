Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C256A8C7
	for <linux-block@vger.kernel.org>; Fri,  1 Mar 2024 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709286514; cv=none; b=o11vZcGNHHGQbgXCGTPY9mKt70OqX+Q7OrD1w8BUW5jaVQ4waU4ovaT5dLOFKZ65MllJ+rs1daJo7lT2pSxxKrcLeRCY05odcPuqwQ+VdKk78dee/pGNcGhaqWvGU5oXKpLR01mx08CCPooYdO0K1tLqjEaZSrgX2+l+glxVktk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709286514; c=relaxed/simple;
	bh=4gOR+avT8IC3KIzJKpuKvHYktIMxWKGHMJF6MyBUai8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WwMOp2g0NrD51XdCqsiR3k1kn3t8bZeBD9qa37YNyv0c/rRpvdM8BuWZW9hiOG+bDvLNoiV6qP3DNml4gFma2ZClbORYVpcZ6kmfv15b4T9RXeT0c9lkwXI6k/YlMNtXs3jssU8cUo3Upjlol2+pgkXcV354YJvF2ATJzbRyuJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DUi/Rqvl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=26DJCdQl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DUi/Rqvl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=26DJCdQl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DUi/Rqvl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="26DJCdQl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DUi/Rqvl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="26DJCdQl"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7DA4A20088;
	Fri,  1 Mar 2024 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709286504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XcFMZ+BWgHEUVydJExrm0h0WA34AeksN3ptVPV0nieQ=;
	b=DUi/RqvlY429nH937HuLA4M2yjb72vaey6B4gJ2y4UH4+Nd6NRcUAjj61mb1qwV1OTN3bn
	JGrLm8gks9wWxbRrdvVNCrdnV4W7t2IlhbxLw3NNPr3Zz2mDylevAP0C7ck3k34YUuciAq
	4l7nwVsbvFt0wTvWZmlGHDvoapknAU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709286504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XcFMZ+BWgHEUVydJExrm0h0WA34AeksN3ptVPV0nieQ=;
	b=26DJCdQl8zLe5iZp6yvlppnRtpERerTsMSH71nqUwh39Vemi1XT66Rj5v4Zh3l/Y8QnrRI
	1PXkFjKNnGD1GbDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709286504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XcFMZ+BWgHEUVydJExrm0h0WA34AeksN3ptVPV0nieQ=;
	b=DUi/RqvlY429nH937HuLA4M2yjb72vaey6B4gJ2y4UH4+Nd6NRcUAjj61mb1qwV1OTN3bn
	JGrLm8gks9wWxbRrdvVNCrdnV4W7t2IlhbxLw3NNPr3Zz2mDylevAP0C7ck3k34YUuciAq
	4l7nwVsbvFt0wTvWZmlGHDvoapknAU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709286504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=XcFMZ+BWgHEUVydJExrm0h0WA34AeksN3ptVPV0nieQ=;
	b=26DJCdQl8zLe5iZp6yvlppnRtpERerTsMSH71nqUwh39Vemi1XT66Rj5v4Zh3l/Y8QnrRI
	1PXkFjKNnGD1GbDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B93513581;
	Fri,  1 Mar 2024 09:48:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kJDPGGik4WXlGQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 01 Mar 2024 09:48:24 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests 0/2] make nvme/048 checks more robust
Date: Fri,  1 Mar 2024 10:48:15 +0100
Message-ID: <20240301094817.29491-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="DUi/Rqvl";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=26DJCdQl
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.88 / 50.00];
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
	 RCPT_COUNT_FIVE(0.00)[6];
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
	 NEURAL_HAM_SHORT(-0.20)[-0.990];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.61)[92.51%]
X-Spam-Score: 1.88
X-Rspamd-Queue-Id: 7DA4A20088
X-Spam-Flag: NO

The nvme/048 tests fails with the fc transport because the check logic is racing
with the reset code in the target. By making the checks a bit more robust in
blktests, this test passes for all transports.

Daniel Wagner (2):
  nvme/048: remove unused argument for set_qid_max
  nvme/048: make queue count check retry-able

 tests/nvme/048 | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

-- 
2.43.2

