Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664795579A
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014460; cv=none; b=MkHsJiOKHDTbHKOOyZNzHgvFFkeqpSe7sdx0xkPOFWgyMzDorI7I5DwLUC+RqkxPzfCPzOaTDvb3GJQP8u+MPNF9E/JV+6YQPIpzXvwnIxAgT0VJUzt5adHx+pdqAvVT1UBUjXcMIqG25Y3pJpptada9cS/gqeMnd/CjYQIIIf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014460; c=relaxed/simple;
	bh=iEvPo6jfPmBdh3e21x8lsDgH+8zgmWIXpaI7vUWRaPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e0HSL5z13D53BZhLVjWSDCtsxX5skX2MvwszjyC1nO8ZIckq1NK989I76cWzmOgeMeLjNosKThlO64okMThnf0fW/vd/A3oD1H8EkjY98SOOptrx2fQYKJAC2kxPa4cMAQFxWlHrwzchgG83uUmGsRUvmNeaCwBi61uWisKZ+ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=twooA3Zk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fUOErFJM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=twooA3Zk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fUOErFJM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="twooA3Zk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fUOErFJM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="twooA3Zk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fUOErFJM"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5856137158;
	Thu, 21 Mar 2024 09:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kKA51qgyv6QF5Yf1pHjBEQQT4fuXgc6nnR2Y7Rj9gkA=;
	b=twooA3ZkEhYqCmM0Ne86LpY0FrPjMoVH2Jz7D5Te4uWbhe06BzM1grtlhtT+ZifRDbx5z7
	HMr9ZLya2mA06w0wLP7rdib1KhdKNpo3lzlG9W0JqeNcWVFcf16wcH7ivHK7PLLVLYq28y
	dquRQT2Q3JfVZdsmE6AZqruURDaqzRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kKA51qgyv6QF5Yf1pHjBEQQT4fuXgc6nnR2Y7Rj9gkA=;
	b=fUOErFJMXOqKUfS2RX+kysNvH68cY1ECZp3hVOZDa99tupLMgKBOocahNajqeANVYvux0O
	Nu70vJm5yGuFjbAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kKA51qgyv6QF5Yf1pHjBEQQT4fuXgc6nnR2Y7Rj9gkA=;
	b=twooA3ZkEhYqCmM0Ne86LpY0FrPjMoVH2Jz7D5Te4uWbhe06BzM1grtlhtT+ZifRDbx5z7
	HMr9ZLya2mA06w0wLP7rdib1KhdKNpo3lzlG9W0JqeNcWVFcf16wcH7ivHK7PLLVLYq28y
	dquRQT2Q3JfVZdsmE6AZqruURDaqzRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kKA51qgyv6QF5Yf1pHjBEQQT4fuXgc6nnR2Y7Rj9gkA=;
	b=fUOErFJMXOqKUfS2RX+kysNvH68cY1ECZp3hVOZDa99tupLMgKBOocahNajqeANVYvux0O
	Nu70vJm5yGuFjbAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4656113976;
	Thu, 21 Mar 2024 09:47:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ijDSDzIC/GWyDwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:30 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 00/18] refactoring and various cleanups/fixes
Date: Thu, 21 Mar 2024 10:47:09 +0100
Message-ID: <20240321094727.6503-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.49
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=twooA3Zk;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fUOErFJM
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.49 / 50.00];
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
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5856137158

While working on two new features I collected a bunch of patches which I think
make sense to review and merge them indepenedly. And I got a few more ideas for
refactoring and cleanups. But one step after the other.

Daniel Wagner (18):
  nvme/rc: silence error on module unload for fc
  nvme/rc: silence fcloop cleanup failures
  nvme/rc: log error if stale configuration is found
  common/xfs: propagate errors from _xfs_run_fio_verify_io
  nvme/{012,013,035}: check return value of _xfs_run_fio_verify_io
  nvme/rc: use long command line option for nvme
  nvme/{014,015,018,019,020,023,024,026,045,046}: use long command line
    option for nvme
  nvme/rc: connect subsys only support long options
  nvme/rc: add nqn/uuid args to target setup/cleanup helper
  nvme/rc: remove unused connect options
  nvme/rc: remove correct port from target
  nvme/031: do not open code target setup/cleanup
  nvme/{rc,031}: do not cleanup external managed loop device
  nvme: drop default trtype argument for _nvmet_connect_subsys
  nvme: drop default subsysnqn argument from
    _nvme_{connect|disconnect}_subsys
  nvme/{041,042,043,044,045,048}: do not pass default host{nqn|id} to
    _nvme_connect_subsys
  nvme: don't assume namespace id
  nvme/028: drop unused nvmedev

 common/xfs     |   9 ++-
 tests/nvme/003 |   4 +-
 tests/nvme/004 |   5 +-
 tests/nvme/005 |   2 +-
 tests/nvme/008 |   4 +-
 tests/nvme/009 |   4 +-
 tests/nvme/010 |  11 ++--
 tests/nvme/011 |  11 ++--
 tests/nvme/012 |  13 ++--
 tests/nvme/013 |  13 ++--
 tests/nvme/014 |  17 +++--
 tests/nvme/015 |  17 +++--
 tests/nvme/018 |  20 +++---
 tests/nvme/019 |  13 ++--
 tests/nvme/020 |  12 ++--
 tests/nvme/021 |  11 ++--
 tests/nvme/022 |   4 +-
 tests/nvme/023 |  11 ++--
 tests/nvme/024 |  12 ++--
 tests/nvme/025 |  11 ++--
 tests/nvme/026 |  11 ++--
 tests/nvme/027 |   4 +-
 tests/nvme/028 |   9 +--
 tests/nvme/029 |  10 +--
 tests/nvme/031 |  14 ++--
 tests/nvme/035 |   4 +-
 tests/nvme/040 |   6 +-
 tests/nvme/041 |  13 ++--
 tests/nvme/042 |  14 ++--
 tests/nvme/043 |  14 ++--
 tests/nvme/044 |  28 +++-----
 tests/nvme/045 |  17 ++---
 tests/nvme/046 |   7 +-
 tests/nvme/047 |  16 ++---
 tests/nvme/048 |   9 +--
 tests/nvme/rc  | 170 +++++++++++++++++++++++++++++++++----------------
 36 files changed, 282 insertions(+), 268 deletions(-)

-- 
2.44.0

