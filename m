Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B1558AAF
	for <linux-block@vger.kernel.org>; Tue,  2 Apr 2024 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052209; cv=none; b=UGsEtOKQmLs8IKvkJMacXWv4rYVXrmdTTIFRQ+kZNDVVhcT8Z8c4OWfr0+YjlFuZgopAAGSiIYY2mPXT4BQqkso5bm+yCx/zuwu69cff2LLai873GzQ2Q8nqNKFDmzwFUBTNOLl+mm9r9pkyaxj8LkOmvTwzDFYUPYujwKHb0Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052209; c=relaxed/simple;
	bh=W8EMzt/O2eaAwpCquPGi+SUm2Mo8/N3plw63XqazPLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fmT+KUmEYJAlSbovjNNkTwaI9Ca+FFcQCDBwXM9cQrxeUOl9iBjOqT2dugiK7KXl05kXIRXOpxnWgTi/7FhG0Tpp+DUfMxxles1KvRty403xDQt6Kf9ja2NPgDkQ2lgfmPHoFNGpBem2f1JjVFlJ2LTTJk8loF2zPi/peGWvY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Yzqcq4l8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/NHW3jlW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Yzqcq4l8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/NHW3jlW"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CFFE20F22;
	Tue,  2 Apr 2024 10:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712052204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BtH0JQusNt/m2acAX0Gmxhgcf2jNVxYa++5QTX/0eY0=;
	b=Yzqcq4l8FeaP1xYTTN7LN7cOm0GMP9WoewrI3fuBvpTA+1vE8Vg2pA149fDxwDgXvNeWoY
	erdXzXbskOM+woJanEM2rlkWToJI2djT07NzMUOdpLl3/KnzgAS0NJbPME0jzjVe2VqQ/J
	SLQc2l1HKXlGRULUCc52zSobPqjX0tY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712052204;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BtH0JQusNt/m2acAX0Gmxhgcf2jNVxYa++5QTX/0eY0=;
	b=/NHW3jlWEQmvr2zmdJAg4F68KciB6ozBaL3xqK5UVFV6XWoBmqCR0O3UNjaOZ1oGIVXhWk
	N5yRKxhbOVrJslDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AB5413A90;
	Tue,  2 Apr 2024 10:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gT2zFOzXC2bxCQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 02 Apr 2024 10:03:24 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 0/3] add blkdev type environment variable
Date: Tue,  2 Apr 2024 12:03:19 +0200
Message-ID: <20240402100322.17673-1-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6CFFE20F22
X-Spamd-Result: default: False [-1.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -1.81
X-Spam-Level: 
X-Spam-Flag: NO

During the last batch of refactoring I noticed that we could reduce the number
of tests a bit. There are tests which are almost identically except how the
target is configured, file vs block device backend.

By introducing a configure knob, we can drop the duplicates and even make some
of the tests a bit more versatile. Not all tests exists in file and block device
backend version. Thus we increase the test coverage with this series. And not
really surprising, there is a fallout. The nvme/028 test with file backend is
failing in my setup but I was not able to figure out where things go wrong yet.
I'll provide some logs later.

Daniel Wagner (3):
  nvme/rc: add blkdev type environment variable
  nvme/{007,009,011,013,015,020,024}: drop duplicate nvmet blkdev type
    tests
  nvme/{021,022,025,026,027,028}: do not hard code target blkdev type

 Documentation/running-tests.md |  2 ++
 tests/nvme/006                 |  5 ++--
 tests/nvme/007                 | 28 --------------------
 tests/nvme/007.out             |  2 --
 tests/nvme/008                 |  4 +--
 tests/nvme/009                 | 36 -------------------------
 tests/nvme/009.out             |  3 ---
 tests/nvme/010                 |  4 +--
 tests/nvme/011                 | 39 ---------------------------
 tests/nvme/011.out             |  3 ---
 tests/nvme/012                 |  4 +--
 tests/nvme/013                 | 43 ------------------------------
 tests/nvme/013.out             |  3 ---
 tests/nvme/014                 |  4 +--
 tests/nvme/015                 | 48 ----------------------------------
 tests/nvme/015.out             |  4 ---
 tests/nvme/019                 |  4 +--
 tests/nvme/020                 | 40 ----------------------------
 tests/nvme/020.out             |  4 ---
 tests/nvme/021                 |  6 ++---
 tests/nvme/022                 |  6 ++---
 tests/nvme/023                 |  4 +--
 tests/nvme/024                 | 40 ----------------------------
 tests/nvme/024.out             |  2 --
 tests/nvme/025                 |  6 ++---
 tests/nvme/026                 |  6 ++---
 tests/nvme/027                 |  6 ++---
 tests/nvme/028                 |  6 ++---
 tests/nvme/rc                  |  3 ++-
 29 files changed, 36 insertions(+), 329 deletions(-)
 delete mode 100755 tests/nvme/007
 delete mode 100644 tests/nvme/007.out
 delete mode 100755 tests/nvme/009
 delete mode 100644 tests/nvme/009.out
 delete mode 100755 tests/nvme/011
 delete mode 100644 tests/nvme/011.out
 delete mode 100755 tests/nvme/013
 delete mode 100644 tests/nvme/013.out
 delete mode 100755 tests/nvme/015
 delete mode 100644 tests/nvme/015.out
 delete mode 100755 tests/nvme/020
 delete mode 100644 tests/nvme/020.out
 delete mode 100755 tests/nvme/024
 delete mode 100644 tests/nvme/024.out

-- 
2.44.0

