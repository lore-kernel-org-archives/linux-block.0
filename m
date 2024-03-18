Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C882C684
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754750; cv=none; b=PGKtSsI+hYGiuup24WRVZK+so340qYOb/oXFPpmiTPL1T8cKH5XPLN0Pckd2RBX8lY13R61s5No4GcA1eXiHXlm6evCbGct+OK/NTkurm6qI7QKbhLlGrlDQOoBftGpv58EfARKsXop9Vah9kZH/FEPLeTvWo6rMVjEkf4AaEHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754750; c=relaxed/simple;
	bh=0WJj92dWElygukRuAVB++4bNianv0nGmH9won2KtyX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qg4iVymonIcF4fvSrk73dj8j6AWF0X/E87+qvdBZVEJdx74DjOH6fJ0ayjU91TQJVLwfvEnA1UiZni2bwAKJHi2BrEpjnPAMxNzfCEayf4GXGxmwHhzvZXEmQyippTEeGkky9p8JVB7v089GAa24BHA5r370okQa52rMAaJKYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GgrcPP5r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H71aLf99; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GgrcPP5r; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H71aLf99; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GgrcPP5r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H71aLf99";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GgrcPP5r";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H71aLf99"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 551213487B;
	Mon, 18 Mar 2024 09:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KVrZpy0RdPySj2UWsz+rM5mkyWuU4qpCsSQWAOcV+VY=;
	b=GgrcPP5rLPv2ZncXo87JpVWBFz7GgFMwAbBUmozYIsDbzTp/pAE9PgY9zu5+s5IeZRQ8h8
	QKX3QDsjza0J11WqkLqeTZ/dtm8gDNCsuKNl/tHvNc4o6ea1y+x6CAMdWMw3dX0QrXtxOv
	BLKWO//9qwC6neNmdsQe3fAOwzZXYS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KVrZpy0RdPySj2UWsz+rM5mkyWuU4qpCsSQWAOcV+VY=;
	b=H71aLf99mx3pjWZB0F6R/GogGn4JS0zNpGimNKCIvCMDR2sBKE+FP1kmZXMHyziTZGBdGg
	Bpl/q+TJ7z3rjqCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710754744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KVrZpy0RdPySj2UWsz+rM5mkyWuU4qpCsSQWAOcV+VY=;
	b=GgrcPP5rLPv2ZncXo87JpVWBFz7GgFMwAbBUmozYIsDbzTp/pAE9PgY9zu5+s5IeZRQ8h8
	QKX3QDsjza0J11WqkLqeTZ/dtm8gDNCsuKNl/tHvNc4o6ea1y+x6CAMdWMw3dX0QrXtxOv
	BLKWO//9qwC6neNmdsQe3fAOwzZXYS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710754744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KVrZpy0RdPySj2UWsz+rM5mkyWuU4qpCsSQWAOcV+VY=;
	b=H71aLf99mx3pjWZB0F6R/GogGn4JS0zNpGimNKCIvCMDR2sBKE+FP1kmZXMHyziTZGBdGg
	Bpl/q+TJ7z3rjqCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 421271349D;
	Mon, 18 Mar 2024 09:39:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id F7WsDrgL+GWhUAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 18 Mar 2024 09:39:04 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v1 00/10] Add support to run against real target
Date: Mon, 18 Mar 2024 10:38:45 +0100
Message-ID: <20240318093856.22307-1-dwagner@suse.de>
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
X-Spam-Level: 
X-Spam-Score: 0.71
X-Spamd-Result: default: False [0.71 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-0.997];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.984];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

As preperation for the planed discussion during LSFMM on

 - running blktest against real hardare/target[1]

I've played a bit around with this idea. It was fairly simple to get it going,
because all the NVMEeoF tests use the common setup/cleanup helpers and allow an
external script to run instead. I've wrote a simple Python script, which then
forwards the setup/cleanup requests to nvmetcli with Hannes' rpc changes [2].

Thus, I still run blktests against a Linux soft target over TCP. This already
uncovered an issue with xfs formatted disk. The test passes if the disk
formatted with btrfs. It seems worthwhile to extend these tests, as it is able
detect new problems:

  Running nvme/012
  umount: /mnt/blktests: not mounted.
  meta-data=/dev/nvme0n1           isize=512    agcount=4, agsize=327680 blks
           =                       sectsz=512   attr=2, projid32bit=1
           =                       crc=1        finobt=1, sparse=1, rmapbt=1
           =                       reflink=1    bigtime=1 inobtcount=1 nrext64=1
  data     =                       bsize=4096   blocks=1310720, imaxpct=25
           =                       sunit=0      swidth=0 blks
  naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
  log      =internal log           bsize=4096   blocks=16384, version=2
           =                       sectsz=512   sunit=0 blks, lazy-count=1
  realtime =none                   extsz=4096   blocks=0, rtextents=0
  Discarding blocks...Done.
  mount: /mnt/blktests: mount(2) system call failed: Structure needs cleaning.
         dmesg(1) may have more information after failed mount system call.
  
With btrfs:

  Running nvme/012
  umount: /mnt/blktests: not mounted.
  btrfs-progs v6.7
  See https://btrfs.readthedocs.io for more information.
  
  Performing full device TRIM /dev/nvme0n1 (5.00GiB) ...
  NOTE: several default settings have changed in version 5.15, please make sure
        this does not affect your deployments:
        - DUP for metadata (-m dup)
        - enabled no-holes (-O no-holes)
        - enabled free-space-tree (-R free-space-tree)
  
  Label:              (null)
  UUID:               7f0e210f-907b-4b87-9a98-fab0d9d60c56
  Node size:          16384
  Sector size:        4096
  Filesystem size:    5.00GiB
  Block group profiles:
    Data:             single            8.00MiB
    Metadata:         DUP             256.00MiB
    System:           DUP               8.00MiB
  SSD detected:       yes
  Zoned device:       no
  Incompat features:  extref, skinny-metadata, no-holes, free-space-tree
  Runtime features:   free-space-tree
  Checksum:           crc32c
  Number of devices:  1
  Devices:
     ID        SIZE  PATH
      1     5.00GiB  /dev/nvme0n1
  

I am still running a bit older verion of the kernel (v6.8-rc3); this might
be fixed already.


  nvme/002 (create many subsystems and test discovery)         [not run]
      nvme_trtype=tcp is not supported in this test
  nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
      runtime  12.696s  ...  12.943s
  nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
      runtime  2.895s  ...  2.765s
  nvme/005 (reset local loopback target)                       [passed]
      runtime  2.961s  ...  2.929s
  nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
      runtime  1.389s  ...  1.324s
  nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
      runtime  1.338s  ...  1.337s
  nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
      runtime  2.797s  ...  2.764s
  nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
      runtime  2.804s  ...  2.775s
  nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
      runtime  21.120s  ...  40.042s
  nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
      runtime  39.702s  ...  40.838s
  nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [failed]
      runtime  157.538s  ...  3.170s
      --- tests/nvme/012.out      2023-11-28 12:59:52.704838920 +0100
      +++ /home/wagi/work/blktests/results/nodev/nvme/012.out.bad 2024-03-18 10:04:38.572222634 +0100
      @@ -1,3 +1,4 @@
       Running nvme/012
      +FAIL: fio verify failed
       disconnected 1 controller(s)
       Test complete
  [...]
  
  
[1] https://lore.kernel.org/linux-nvme/23fhu43orn5yyi6jytsyez3f3d7liocp4cat5gfswtan33m3au@iyxhcwee6wvk/
[2] https://github.com/hreinecke/nvmetcli/tree/rpc

Daniel Wagner (10):
  common/xfs: propagate errors from _xfs_run_fio_verify_io
  nvme/{012,013,035}: check return value of _xfs_run_fio_verify_io
  nvme/rc: use long command line option for nvme
  nvme/{014,015,018,019,020,023,024,026,045,046}: use long command line
    option for nvme
  nvme/rc: connect subsys only support long options
  nvme/rc: remove unused connect options
  nvme/rc: add nqn/uuid args to target setup/cleanup helper
  nvme/031: do not open code target setup/cleanup
  nvme/rc: introduce remote target support
  nvme/030: only run against kernel soft target

 common/xfs     |   9 +++-
 tests/nvme/012 |   4 +-
 tests/nvme/013 |   4 +-
 tests/nvme/014 |   2 +-
 tests/nvme/015 |   2 +-
 tests/nvme/018 |   3 +-
 tests/nvme/019 |   3 +-
 tests/nvme/020 |   3 +-
 tests/nvme/023 |   3 +-
 tests/nvme/024 |   3 +-
 tests/nvme/026 |   3 +-
 tests/nvme/030 |   1 +
 tests/nvme/031 |  10 ++--
 tests/nvme/035 |   4 +-
 tests/nvme/045 |   6 +--
 tests/nvme/046 |   7 +--
 tests/nvme/rc  | 142 ++++++++++++++++++++++++++++++++++---------------
 17 files changed, 141 insertions(+), 68 deletions(-)

-- 
2.44.0

