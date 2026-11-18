Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794991351;
	b=TI5KYa+VzTiQ6M21W2ooGRpmOQvDsVWY9qWe73n7QtYrEaRk6Nh/olyBVGM5+Y7QxAfy
	 x765vUhM1j/wFLfEoAGG00Qrplk4Hlj/MNXmz2OpScMm1wRtn51UhpSXWdD0O1TQtrHEd
	 +/xvYMvOi3ZBGAngIHb4r0xjgiu4Is56VhRrNdLp8dvwMJyDIcV+kRD8SWWEj+d7Rr6y5
	 76xzzsZMLRbovy5xEBDQLCzwPIbQkowSUsnVvNfLkQN5I3S8RPjzpmaRPVPUTvML7+Nao
	 OvXqzsEy0wa5h9mvUpoQbQqaBkUWZqwNPa2+v3WQ7fO2wOOjMtiTMMGB6UqKgIFgY3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794991351;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Spamd-Result:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Rspamd-Queue-Id;
	bh=EZrD0NQn3VHaZmRgI8GJFbLALpowkgsD2yWgtgW382o=;
	b=HCxySg2MlPQjEr6OfpYQiPZ6C3Sopy9feytepP1yxyjohqY7o/hRogbqUKCfXkcPiBsV
	 5KqBsU82+R2QOI2iBU097bwIAk+9FWp8gv9K6BXyFigT5afjDBlB/mjEKheAr6aPu+89r
	 C00ao8Wb1uaVN/QvktKD0f2tJeDOFfqFdVeew6zuV8P+qMlXxCOteIZ7mSGUFVTXq+ZUR
	 PIe0f7P5zbsspgq2n37XQIz3iuKdLpXbuKNSny2TC0ZK3RVlgNK4sldHwrKJmPpLWpNUl
	 78AkaisVAXXSh3qzK43QyT5FXyda26EpdTIjTnJboxXTOFfHnNFSC0LYrD20JULQjHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kbiAPLFt;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HNBI6fLz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kbiAPLFt;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HNBI6fLz;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0221606A893
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 08:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0221606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kbiAPLFt;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HNBI6fLz;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=kbiAPLFt;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HNBI6fLz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 26D521FB72;
	Wed, 18 Nov 2026 08:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EZrD0NQn3VHaZmRgI8GJFbLALpowkgsD2yWgtgW382o=;
	b=kbiAPLFtbCVZc6GweRSnb2h2k03iQBuHAY4oYowYbTfCT7I/D7Aj1e4Q3FAMjEL5STMdtd
	3jkBZSj8wvUahF6h2Gp995fTj9qpiuvbXdwmw8dkMfMxXiF5MWGZJNVFAe+QzAkMtutVFr
	VTYp3s489/kAtzs+so/S4VOthfShC54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EZrD0NQn3VHaZmRgI8GJFbLALpowkgsD2yWgtgW382o=;
	b=HNBI6fLzZoCXXuoMAnKwzL4zLJjoOty7tZhJgVHxH0/CnXW3VuTKj38GId5toZeV8UphRp
	ywBEIPgtFAgycrBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kbiAPLFt;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HNBI6fLz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794991343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EZrD0NQn3VHaZmRgI8GJFbLALpowkgsD2yWgtgW382o=;
	b=kbiAPLFtbCVZc6GweRSnb2h2k03iQBuHAY4oYowYbTfCT7I/D7Aj1e4Q3FAMjEL5STMdtd
	3jkBZSj8wvUahF6h2Gp995fTj9qpiuvbXdwmw8dkMfMxXiF5MWGZJNVFAe+QzAkMtutVFr
	VTYp3s489/kAtzs+so/S4VOthfShC54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794991343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EZrD0NQn3VHaZmRgI8GJFbLALpowkgsD2yWgtgW382o=;
	b=HNBI6fLzZoCXXuoMAnKwzL4zLJjoOty7tZhJgVHxH0/CnXW3VuTKj38GId5toZeV8UphRp
	ywBEIPgtFAgycrBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0E34134E9;
	Wed, 18 Nov 2026 08:42:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZQ0BKu5k/WrCTgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 08:42:22 +0000
From: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 0/5] skip tests when a program they need is missing
Date: Wed, 18 Nov 2026 09:42:20 +0100
Message-Id: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTtJi02pXsW4gDKU0VibjhgT0
 rtbYPkW/68glJkErs0Kmb4s/I4V+tSAn/sYCHmshla1VmvdoTw54YtFOAYcKQme1WCUM/bivIH
 apUwT//bn7X5YluFB/rONoJQ/BXhCw3UAAAA=
X-Change-ID: 20261117-skip-missing-deps-30b4084698c4
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 26D521FB72

Hi all,

a few tests run programs they don't check for, so they fail instead of
being skipped on a host without them. Worse, check leaves the modules
loaded when a test with a fallback device is skipped, which makes the
following tests skip too: a missing xfs_io for scsi/009 took out six
scsi and zbd tests.

The first patch fixes check, the others add the missing requirements.

On a Debian 13 VM with a 7.3 kernel and without these tools, all tests
that fail are kernel bugs except nvme/068. With the tools installed, a
run of all groups but meta goes from 81 to 120 passing tests. The
remaining failures are block/052, block/053, nvme/073, nvme/074,
nvme/076 and zbd/009, which hits a btrfs warning in
btrfs_schedule_zone_finish_bg().

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Daniel Wagner (5):
      check: unload modules when a test with a fallback device is skipped
      nvme/053, nvme/068: skip if fio or xfs_io is missing
      nbd/003: skip if mkfs.ext4 is missing
      block/009, block/012: skip if hexdump is missing
      zbd/008: skip if fio or hexdump is missing

 check           | 3 +++
 tests/block/009 | 1 +
 tests/block/012 | 1 +
 tests/nbd/003   | 1 +
 tests/nvme/053  | 4 ++++
 tests/nvme/068  | 1 +
 tests/zbd/008   | 2 ++
 7 files changed, 13 insertions(+)
---
base-commit: 79c32fb31b7bca6a4383b749030128683cf6b6b4
change-id: 20261117-skip-missing-deps-30b4084698c4

Best regards,
--  
Daniel Wagner <dwagner@suse.de>

