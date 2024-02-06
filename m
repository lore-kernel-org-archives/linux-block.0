Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A053130E30
	for <linux-block@vger.kernel.org>; Tue,  6 Feb 2024 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225427; cv=none; b=LtMkqpWFx30lzLYbPyCNbkYg3dUQRuvqJ4VS2tiG2gx4FJifjatEh1DistdP4RPKcd3eHJzJ/Q0UEjd5T3ywtT2oW5c2c4jW4A6yJQYZvao7ngrw7dKPf49na0cO0yWxntoFoRw1/nRVAnilparM1APxKUHOubL/GtXoGfq1gHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225427; c=relaxed/simple;
	bh=xeIZrBZZXmhPowN41D+IKb26Bjf60vxRKxJJNJU/O2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sb7lcle3ppvP2NTftrU5NTnZLs0IbhTOvZm2CLDfYQjYLakGseHsbKuWBc0hgojUn4nliM4eSZfAD8lI1tSZsxc1sckyahg6b4HMvE5kFXG7fFGREEV1xiY2ACLCEkFPyJ22/zzMo1KcDCpkbMLr8qGN1nf7yBcTqUvb84wHSQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e1zkHGmI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u/ELiJIQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e1zkHGmI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u/ELiJIQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e1zkHGmI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u/ELiJIQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="e1zkHGmI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u/ELiJIQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D5E36221B1;
	Tue,  6 Feb 2024 13:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707225423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=g0JLgoeNJjfNLrB2IA8XUaFiQ9Bu5iSYR7limojHX6I=;
	b=e1zkHGmImopbYElYjhKIpTstSpZQWMNXFP6VrcnxqWDBcMvoT0oj+Pxvoc3Xcq+qVr7aoA
	t0kqlISYajBgH44+n2cWfmbPpRsVxoWJ4KEdFKlpNgoJQkOMWflO6gmqENP60Ejk5KTXdN
	m1ov2yADfsclOFJFnW21wy9+cG3IxXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707225423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=g0JLgoeNJjfNLrB2IA8XUaFiQ9Bu5iSYR7limojHX6I=;
	b=u/ELiJIQBOaZJ+77TgTJPy4bySep/O2zJXbAG96q/42YnBeMVuu2KfdFsaIJhPUIvoUpkD
	xa4CxT16XN/X4SAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707225423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=g0JLgoeNJjfNLrB2IA8XUaFiQ9Bu5iSYR7limojHX6I=;
	b=e1zkHGmImopbYElYjhKIpTstSpZQWMNXFP6VrcnxqWDBcMvoT0oj+Pxvoc3Xcq+qVr7aoA
	t0kqlISYajBgH44+n2cWfmbPpRsVxoWJ4KEdFKlpNgoJQkOMWflO6gmqENP60Ejk5KTXdN
	m1ov2yADfsclOFJFnW21wy9+cG3IxXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707225423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=g0JLgoeNJjfNLrB2IA8XUaFiQ9Bu5iSYR7limojHX6I=;
	b=u/ELiJIQBOaZJ+77TgTJPy4bySep/O2zJXbAG96q/42YnBeMVuu2KfdFsaIJhPUIvoUpkD
	xa4CxT16XN/X4SAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCCEA132DD;
	Tue,  6 Feb 2024 13:17:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iU3OLU8xwmVpOgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 06 Feb 2024 13:17:03 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 0/5] fc transport cleanups
Date: Tue,  6 Feb 2024 14:16:50 +0100
Message-ID: <20240206131655.32050-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: *
X-Spam-Score: 1.90
X-Spam-Flag: NO

After the nvmet-fc fixes have been merged into kernel, it's time to get the
tests work smoothly with the fc transport. These fixes here are not necessary IF
the auto connect udev rule is disabled.

If the auto connect is enabled, discovery controllers are created and destroyed
which are not under control of blktests. This only a problem when we iterate
over the sysfs resources to find the device. As these operations are not atomic,
we have to make the lookups a bit less noisy.

Also the cleanup path needs the same treatment. With a small fix for libnvme
which turns an error message into a debug message[1][2], we get (Linux v6.8-rc3)


  nvme/002 (create many subsystems and test discovery)         [not run]
      nvme_trtype=fc is not supported in this test
  nvme/003 (test if we're sending keep-alives to a discovery controller)
      runtime  11.460s  ...
  nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
      runtime  11.460s  ...  11.439s
  nvme/004 (test nvme and nvmet UUID NS descriptors)          
      runtime  0.580s  ...
  nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
      runtime  0.580s  ...  0.577s
  nvme/005 (reset local loopback target)                       [passed]
      runtime  0.691s  ...  0.663s
  nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
      runtime    ...  0.177s
  nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
      runtime  0.161s  ...  0.133s
  nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
      runtime  0.590s  ...  0.547s
  nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
      runtime  0.516s  ...  0.515s
  nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
      runtime  9.348s  ...  8.376s
  nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
      runtime  26.887s  ...  25.305s
  nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
      runtime  16.937s  ...  15.540s
  nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
      runtime  28.198s  ...  26.436s
  nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
      runtime  3.013s  ...  3.036s
  nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
      runtime  2.855s  ...  2.721s
  nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
      nvme_trtype=fc is not supported in this test
  nvme/017 (create/delete many file-ns and test discovery)     [not run]
      nvme_trtype=fc is not supported in this test
  nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
      runtime  0.535s  ...  0.556s
  nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
      runtime  0.540s  ...  0.584s
  nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
      runtime  0.619s  ...  0.557s
  nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
      runtime  0.543s  ...  0.576s
  nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
      runtime  0.639s  ...  0.699s
  nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
      runtime  0.638s  ...  0.511s
  nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
      runtime  0.539s  ...  0.602s
  nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
      runtime  0.527s  ...  0.521s
  nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
      runtime  0.566s  ...  0.569s
  nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
      runtime  0.580s  ...  0.607s
  nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
      runtime  0.541s  ...  0.521s
  nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
      runtime  0.809s  ...  0.768s
  nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
      runtime  0.514s  ...  0.521s
  nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
      runtime  3.434s  ...  3.318s
  nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
      runtime  0.047s  ...  0.048s
  nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
      runtime  6.698s  ...  6.639s
  nvme/041 (Create authenticated connections)                  [failed]
      runtime  2.553s  ...  2.543s
      --- tests/nvme/041.out      2023-11-28 12:59:52.708172235 +0100
      +++ /home/wagi/work/blktests/results/nodev/nvme/041.out.bad 2024-02-06 13:40:30.159988590 +0100
      @@ -2,5 +2,5 @@
       Test unauthenticated connection (should fail)
       disconnected 0 controller(s)
       Test authenticated connection
      -disconnected 1 controller(s)
      +disconnected 0 controller(s)
       Test complete
  nvme/042 (Test dhchap key types for authenticated connections) [passed]
      runtime  2.629s  ...  2.710s
  nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
      runtime  4.014s  ...  3.912s
  nvme/044 (Test bi-directional authentication)                [failed]
      runtime  4.019s  ...  4.029s
      --- tests/nvme/044.out      2023-11-28 12:59:52.711505550 +0100
      +++ /home/wagi/work/blktests/results/nodev/nvme/044.out.bad 2024-02-06 13:40:43.653233959 +0100
      @@ -4,7 +4,7 @@
       Test invalid ctrl authentication (should fail)
       disconnected 0 controller(s)
       Test valid ctrl authentication
      -disconnected 1 controller(s)
      +disconnected 0 controller(s)
       Test invalid ctrl key (should fail)
       disconnected 0 controller(s)
      ...
      (Run 'diff -u tests/nvme/044.out /home/wagi/work/blktests/results/nodev/nvme/044.out.bad' to see the entire diff)
  nvme/045 (Test re-authentication)                            [passed]
      runtime  1.534s  ...  1.531s
  nvme/047 (test different queue types for fabric transports)  [not run]
      nvme_trtype=fc is not supported in this test
  nvme/048 (Test queue count changes on reconnect)             [failed]
      runtime  0.484s  ...  0.506s
      --- tests/nvme/048.out      2023-11-28 12:59:52.711505550 +0100
      +++ /home/wagi/work/blktests/results/nodev/nvme/048.out.bad 2024-02-06 13:40:48.339870090 +0100
      @@ -1,3 +1,7 @@
       Running nvme/048
      +expected queue count 2 not set
      +FAIL
      +expected queue count 3 not set
      +FAIL
       disconnected 1 controller(s)
       Test complete

The auth tests and queue count tests fail and I think from a quick look these
failures are real. I did run these tests in a loop and didn't see any sporadic
failures anymore. So I am confident that we finally have some progress in this
area.

[1] https://lore.kernel.org/linux-nvme/i4bmvgd3u7shgizqgtdtssdz5v3wc76l6bcce6fcbvoft32gzk@rztzeut4azvj/
[2] https://github.com/linux-nvme/libnvme/pull/778

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

