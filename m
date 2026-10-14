Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B658D47F775
	for <linux-block@vger.kernel.org>; Wed, 14 Oct 2026 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964319; cv=none; b=snNNtzvxlxO5ZLz8Z2luf21V08A8nGnDt01RrOKa86cWeXnGUH2Gog5p0JqKAKZnizix0184MXroXAyJsj0kCz0DX4f0yKCX8UDW8yH4oIHxZ5pceuTTKnW/m3jUySYPDYefuv+pVfvxIKSbsr4yknZ6AnJ4T9F8zZXD5wMw8jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964319; c=relaxed/simple;
	bh=/jIAw+yh+RCdIwON/KMt7cVbNi1WZZ6bQGIWKq+RrIs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pfREANnjGa0uq7RN6Om3llLeLfjrigln5FryGz9NnsyY5yJT5SygeI1hnPXwHur+Mc7v7e5BePtKiZZ8xVpf3gODFP6STvR4vM7UAyUWeS7wKRsFKD6CM8vJLb5zJd+CukR10Jjjcp4a6x5WaYkfuytinmPcPnyVCFnm4nF7Oo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=prntN53P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zEw8vjc9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=prntN53P; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zEw8vjc9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="prntN53P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zEw8vjc9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="prntN53P";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zEw8vjc9"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 67A7E21E5D;
	Wed, 14 Oct 2026 07:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HRTqqsF0Bv3kLAm3cpGKpYcVToU8tQ3kC08BJrZRjDI=;
	b=prntN53PYwgbkDXydcGykg8IXmkQT2UPysjVEiuHSvh4l49vU349wZEqok/Ei15pGbSyNW
	MG/psii915c4HfzHaitqeqCQsRraV2VeZTr5PDc9jRND2GmkfGdiKf3iEZAg6ORFo9XhSE
	IzEF9zfrZHiL+dkiZwGXdifWghIyyd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HRTqqsF0Bv3kLAm3cpGKpYcVToU8tQ3kC08BJrZRjDI=;
	b=zEw8vjc94gOzi+I/b6C67ykmGY1upqyhKfHc2wPcqd/ILJGC28SnpI9RY4MYw4KyWDG1/D
	t0mlkqDoYz2huYAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=prntN53P;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zEw8vjc9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791964314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HRTqqsF0Bv3kLAm3cpGKpYcVToU8tQ3kC08BJrZRjDI=;
	b=prntN53PYwgbkDXydcGykg8IXmkQT2UPysjVEiuHSvh4l49vU349wZEqok/Ei15pGbSyNW
	MG/psii915c4HfzHaitqeqCQsRraV2VeZTr5PDc9jRND2GmkfGdiKf3iEZAg6ORFo9XhSE
	IzEF9zfrZHiL+dkiZwGXdifWghIyyd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791964314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HRTqqsF0Bv3kLAm3cpGKpYcVToU8tQ3kC08BJrZRjDI=;
	b=zEw8vjc94gOzi+I/b6C67ykmGY1upqyhKfHc2wPcqd/ILJGC28SnpI9RY4MYw4KyWDG1/D
	t0mlkqDoYz2huYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3771A1368E;
	Wed, 14 Oct 2026 07:51:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XUYZBZo0z2rEPwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 07:51:54 +0000
From: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests 0/5] nvme: tests for isolated CPUs and fabrics
 queue mapping
Date: Wed, 14 Oct 2026 09:51:46 +0200
Message-Id: <20261014-nvme-isolcpu-v1-0-2fd175a8ef00@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBREryKzbiCREtCrSBcaf+pXGyU/iiDev
 bFdvhneOyEUmQR1cSLSzsJLyGAeBdzQhjcp7jOj1KU12jxV2D95k2V266Yqr60h21bWe2RljeT
 5+OUadPOUSJLg9X9k60Zy6a7hur74i8aYegAAAA==
X-Change-ID: 20261014-nvme-isolcpu-9f061e6a96ff
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.16.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 67A7E21E5D
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51

New tests for the bugs fixed by the kernel series "nvme-fabrics: fix
connects with isolated CPUs and queue mapping bugs":

https://lore.kernel.org/linux-nvme/20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org/

  nvme/070  connect with an isolated CPU (cpuset partition), verified
            I/O from a housekeeping and from the isolated CPU, traced on
            the queue of the isolated CPU
  nvme/071  more write and poll queues than online CPUs
  nvme/072  no queues left for polling
  nvme/073  reconnect with fewer I/O queues

nvme/071-073 need write and poll queues and only run for tcp and rdma.
Without the kernel series all four fail and nvme/073 crashes the kernel,
with the series they pass. Tested with loop and tcp.

Patch 1 stops _nvme_disconnect_ctrl() and _nvme_disconnect_subsys() from
truncating $FULL, which dropped everything logged before the disconnect,
e.g. the fio command lines.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
Daniel Wagner (5):
      common/nvme: don't truncate the full log when disconnecting
      nvme/070: test connect with an isolated CPU
      nvme/071: test I/O queue limits per queue type
      nvme/072: test poll support without poll queues
      nvme/073: test reconnect with fewer I/O queues

 common/nvme        |   4 +-
 tests/nvme/070     | 196 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/070.out |   2 +
 tests/nvme/071     | 104 ++++++++++++++++++++++++++++
 tests/nvme/071.out |   2 +
 tests/nvme/072     |  85 +++++++++++++++++++++++
 tests/nvme/072.out |   2 +
 tests/nvme/073     | 117 ++++++++++++++++++++++++++++++++
 tests/nvme/073.out |   2 +
 9 files changed, 512 insertions(+), 2 deletions(-)
---
base-commit: 6f5a1dcb4551fe45c35e1fb1cdfa8343909f834a
change-id: 20261014-nvme-isolcpu-9f061e6a96ff

Best regards,
--  
Daniel Wagner <wagi@kernel.org>

