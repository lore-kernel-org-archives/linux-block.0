Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125A221554;
	Sun, 28 Sep 2025 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759040937; cv=none; b=uX4XX8DsbeI3rM/A4gk+wES1U7jHGBCLh4w94eqjoTeobxnPC8+SXVh1zzLgEb34y7sojG/230zXsDxGTmjadDHJ5SDV4eg05/fY3VN1mhr25+kTMF/cGd8vG+DH6HtK5hU09UGCATqAFkz08wccWCAIWW8sb95FMDvNweINJ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759040937; c=relaxed/simple;
	bh=z+YHa/cOdoibGw2jRY2xxhhsZJRT/H6INHbF8sLonRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zd6r+WLJ7sEo0NJO0641TKmAxzEVULH/knMQLryPr+WI4zX+8Uze5lLUS2teuDltsLmkKf2Z4lMG5gpjB8x+J+YCiS3qiSf9thvy+3b2JSbfThItgB5Ws07zfY+U1hohJPqpR1IN8QHSOFMOUWfqrPKLQ1IErBYFXAp1GetqNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 61d23e349c3411f08b9f7d2eb6caa7cf-20250928
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:d98a05f5-1ae2-456b-b5a6-54465287ac08,IP:15,
	URL:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:d98a05f5-1ae2-456b-b5a6-54465287ac08,IP:15,UR
	L:0,TC:0,Content:-5,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:999dcae1378ea676a66d6000eed1a84b,BulkI
	D:250928142846D3N2MTPY,BulkQuantity:0,Recheck:0,SF:17|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 61d23e349c3411f08b9f7d2eb6caa7cf-20250928
X-User: cuitao@kylinos.cn
Received: from ctao-ubuntu.. [(39.156.73.13)] by mailgw.kylinos.cn
	(envelope-from <cuitao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 607324908; Sun, 28 Sep 2025 14:28:44 +0800
From: cuitao <cuitao@kylinos.cn>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	cuitao <cuitao@kylinos.cn>
Subject: [PATCH] block: Kconfig: Fix indentation.
Date: Sun, 28 Sep 2025 14:28:32 +0800
Message-ID: <20250928062832.3465356-1-cuitao@kylinos.cn>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: cuitao <cuitao@kylinos.cn>
---
 block/Kconfig | 116 +++++++++++++++++++++++++-------------------------
 1 file changed, 58 insertions(+), 58 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 15027963472d..ce19774969f4 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -65,82 +65,82 @@ config BLK_DEV_INTEGRITY
 	select CRC_T10DIF
 	select CRC64
 	help
-	Some storage devices allow extra information to be
-	stored/retrieved to help protect the data.  The block layer
-	data integrity option provides hooks which can be used by
-	filesystems to ensure better data integrity.
+	  Some storage devices allow extra information to be
+	  stored/retrieved to help protect the data.  The block layer
+	  data integrity option provides hooks which can be used by
+	  filesystems to ensure better data integrity.
 
-	Say yes here if you have a storage device that provides the
-	T10/SCSI Data Integrity Field or the T13/ATA External Path
-	Protection.  If in doubt, say N.
+	  Say yes here if you have a storage device that provides the
+	  T10/SCSI Data Integrity Field or the T13/ATA External Path
+	  Protection.  If in doubt, say N.
 
 config BLK_DEV_WRITE_MOUNTED
 	bool "Allow writing to mounted block devices"
 	default y
 	help
-	When a block device is mounted, writing to its buffer cache is very
-	likely going to cause filesystem corruption. It is also rather easy to
-	crash the kernel in this way since the filesystem has no practical way
-	of detecting these writes to buffer cache and verifying its metadata
-	integrity. However there are some setups that need this capability
-	like running fsck on read-only mounted root device, modifying some
-	features on mounted ext4 filesystem, and similar. If you say N, the
-	kernel will prevent processes from writing to block devices that are
-	mounted by filesystems which provides some more protection from runaway
-	privileged processes and generally makes it much harder to crash
-	filesystem drivers. Note however that this does not prevent
-	underlying device(s) from being modified by other means, e.g. by
-	directly submitting SCSI commands or through access to lower layers of
-	storage stack. If in doubt, say Y. The configuration can be overridden
-	with the bdev_allow_write_mounted boot option.
+	  When a block device is mounted, writing to its buffer cache is very
+	  likely going to cause filesystem corruption. It is also rather easy to
+	  crash the kernel in this way since the filesystem has no practical way
+	  of detecting these writes to buffer cache and verifying its metadata
+	  integrity. However there are some setups that need this capability
+	  like running fsck on read-only mounted root device, modifying some
+	  features on mounted ext4 filesystem, and similar. If you say N, the
+	  kernel will prevent processes from writing to block devices that are
+	  mounted by filesystems which provides some more protection from runaway
+	  privileged processes and generally makes it much harder to crash
+	  filesystem drivers. Note however that this does not prevent
+	  underlying device(s) from being modified by other means, e.g. by
+	  directly submitting SCSI commands or through access to lower layers of
+	  storage stack. If in doubt, say Y. The configuration can be overridden
+	  with the bdev_allow_write_mounted boot option.
 
 config BLK_DEV_ZONED
 	bool "Zoned block device support"
 	help
-	Block layer zoned block device support. This option enables
-	support for ZAC/ZBC/ZNS host-managed and host-aware zoned block
-	devices.
+	  Block layer zoned block device support. This option enables
+	  support for ZAC/ZBC/ZNS host-managed and host-aware zoned block
+	  devices.
 
-	Say yes here if you have a ZAC, ZBC, or ZNS storage device.
+	  Say yes here if you have a ZAC, ZBC, or ZNS storage device.
 
 config BLK_DEV_THROTTLING
 	bool "Block layer bio throttling support"
 	depends on BLK_CGROUP
 	select BLK_CGROUP_RWSTAT
 	help
-	Block layer bio throttling support. It can be used to limit
-	the IO rate to a device. IO rate policies are per cgroup and
-	one needs to mount and use blkio cgroup controller for creating
-	cgroups and specifying per device IO rate policies.
+	  Block layer bio throttling support. It can be used to limit
+	  the IO rate to a device. IO rate policies are per cgroup and
+	  one needs to mount and use blkio cgroup controller for creating
+	  cgroups and specifying per device IO rate policies.
 
-	See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more information.
+	  See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more information.
 
 config BLK_WBT
 	bool "Enable support for block device writeback throttling"
 	help
-	Enabling this option enables the block layer to throttle buffered
-	background writeback from the VM, making it more smooth and having
-	less impact on foreground operations. The throttling is done
-	dynamically on an algorithm loosely based on CoDel, factoring in
-	the realtime performance of the disk.
+	  Enabling this option enables the block layer to throttle buffered
+	  background writeback from the VM, making it more smooth and having
+	  less impact on foreground operations. The throttling is done
+	  dynamically on an algorithm loosely based on CoDel, factoring in
+	  the realtime performance of the disk.
 
 config BLK_WBT_MQ
 	bool "Enable writeback throttling by default"
 	default y
 	depends on BLK_WBT
 	help
-	Enable writeback throttling by default for request-based block devices.
+	  Enable writeback throttling by default for request-based block devices.
 
 config BLK_CGROUP_IOLATENCY
 	bool "Enable support for latency based cgroup IO protection"
 	depends on BLK_CGROUP
 	help
-	Enabling this option enables the .latency interface for IO throttling.
-	The IO controller will attempt to maintain average IO latencies below
-	the configured latency target, throttling anybody with a higher latency
-	target than the victimized group.
+	  Enabling this option enables the .latency interface for IO throttling.
+	  The IO controller will attempt to maintain average IO latencies below
+	  the configured latency target, throttling anybody with a higher latency
+	  target than the victimized group.
 
-	Note, this is an experimental interface and could be changed someday.
+	  Note, this is an experimental interface and could be changed someday.
 
 config BLK_CGROUP_FC_APPID
 	bool "Enable support to track FC I/O Traffic across cgroup applications"
@@ -156,31 +156,31 @@ config BLK_CGROUP_IOCOST
 	depends on BLK_CGROUP
 	select BLK_RQ_ALLOC_TIME
 	help
-	Enabling this option enables the .weight interface for cost
-	model based proportional IO control.  The IO controller
-	distributes IO capacity between different groups based on
-	their share of the overall weight distribution.
+	  Enabling this option enables the .weight interface for cost
+	  model based proportional IO control.  The IO controller
+	  distributes IO capacity between different groups based on
+	  their share of the overall weight distribution.
 
 config BLK_CGROUP_IOPRIO
 	bool "Cgroup I/O controller for assigning an I/O priority class"
 	depends on BLK_CGROUP
 	help
-	Enable the .prio interface for assigning an I/O priority class to
-	requests. The I/O priority class affects the order in which an I/O
-	scheduler and block devices process requests. Only some I/O schedulers
-	and some block devices support I/O priorities.
+	  Enable the .prio interface for assigning an I/O priority class to
+	  requests. The I/O priority class affects the order in which an I/O
+	  scheduler and block devices process requests. Only some I/O schedulers
+	  and some block devices support I/O priorities.
 
 config BLK_DEBUG_FS
 	bool "Block layer debugging information in debugfs"
 	default y
 	depends on DEBUG_FS
 	help
-	Include block layer debugging information in debugfs. This information
-	is mostly useful for kernel developers, but it doesn't incur any cost
-	at runtime.
+	  Include block layer debugging information in debugfs. This information
+	  is mostly useful for kernel developers, but it doesn't incur any cost
+	  at runtime.
 
-	Unless you are building a kernel for a tiny system, you should
-	say Y here.
+	  Unless you are building a kernel for a tiny system, you should
+	  say Y here.
 
 config BLK_SED_OPAL
 	bool "Logic for interfacing with Opal enabled SEDs"
@@ -188,9 +188,9 @@ config BLK_SED_OPAL
 	select PSERIES_PLPKS if PPC_PSERIES
 	select PSERIES_PLPKS_SED if PPC_PSERIES
 	help
-	Builds Logic for interfacing with Opal enabled controllers.
-	Enabling this option enables users to setup/unlock/lock
-	Locking ranges for SED devices using the Opal protocol.
+	  Builds Logic for interfacing with Opal enabled controllers.
+	  Enabling this option enables users to setup/unlock/lock
+	  Locking ranges for SED devices using the Opal protocol.
 
 config BLK_INLINE_ENCRYPTION
 	bool "Enable inline encryption support in block layer"
-- 
2.48.1

