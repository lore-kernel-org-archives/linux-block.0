Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504B13D34B3
	for <linux-block@vger.kernel.org>; Sat, 16 May 2026 12:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778933332; cv=none; b=IbcvqsHVB1BXKDnJbIi+JLSFA0Zk8/1OSoSFxSls+BL/zXN0tDCrCjiJwfAAnDLvuI3an6DmE4O1+/f+tufZ2l7+NITeQfzCrIPyr8LrwrbY+i00t25T5LrANUCanou8XI6Anx2ETRBr8UtnIe+bPELrZJTJzHBPMbax9E0gVLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778933332; c=relaxed/simple;
	bh=d8ZmZCUtgG8S1jn2BteKfTqejPFTbrN/Jq2VnwWlxdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PRGY2AEqrgHRfarWFacbYg3urKjqSJKrn3N7Ft17TZVQlDhwWJrH8Jmk4sBZRpvaIe79UKk8yCZwH7yVGpBBmiLwXqmughAMgFWEG5ULPVsjglsqkdWhoDGUH3G/ueZahEeD2xJPt0YHlluYeIF8nsWedkUxFzZqmBhGcLgj9gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=S2NwVnhJ; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S2NwVnhJ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778933331; x=1810469331;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d8ZmZCUtgG8S1jn2BteKfTqejPFTbrN/Jq2VnwWlxdM=;
  b=S2NwVnhJ2XB0ITNyZG7+A5ORRG2IF4sPo+vs3y0g4yE5RNqjRB9sg8wX
   4GDMRj6TxEI7sVlil3NXpCQMA88pwrs/ZPRDjskPOLEq9a67TYz+cDnRc
   GI5PoKhMj0zd0cLsOib6ovZWsTLJKknrRUbxH6JBZmpus6XI7nJBtE4R8
   uKQeyLTL7LUSB0+xYyBhQLLuCBP6qXG/yNXapHS8KTAk5FKof5rK93Y0J
   r9HQy9wmH3mmy1vCCSPJDICaLhKJAHGyLmoLyc7o5lNFMYAFAMPRGIa5h
   VCo9LISDkuOn0EaaHqtAsu3LJOQ56AM/b9iP4YjcSxyGlmUeCQkmlW/1V
   g==;
X-CSE-ConnectionGUID: 4Y7eMI/pQOG1H9ZIZDtJNA==
X-CSE-MsgGUID: TMtu3nkRRZS40yRHsguYzw==
X-IronPort-AV: E=Sophos;i="6.23,238,1770566400"; 
   d="scan'208";a="145562575"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2026 20:07:43 +0800
X-CSE-ConnectionGUID: 0oSj+Bw5R+2vpE29ad4Zkw==
X-CSE-MsgGUID: E/kLxGA+RkemZHXs3+riXQ==
IronPort-SDR: 6a085e03_1xUhnrT5/VHV6JXF6/OPc20IcPg5KLx/tm9IqjGe/Telpc6
 tl9CZT6/oak8SzgJGKcJmwOGw0jB/BrOLlTf/mg==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2026 05:07:30 -0700
X-CSE-ConnectionGUID: zxbnTqi9TIOU5xiEl4vi2g==
X-CSE-MsgGUID: 7QiO8PAQRwC07IeNeL5dJw==
WDCIronportException: Internal
Received: from wdap-zejtyqwo0v.ad.shared (HELO shinmob.wdc.com) ([10.224.105.206])
  by uls-op-esai2-o.wdc.com with ESMTP; 16 May 2026 05:07:30 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 0/3] introduce command trace feature
Date: Sat, 16 May 2026 21:07:26 +0900
Message-ID: <20260516120729.113659-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some blktests test cases have deep nesting, making their behavior
difficult to understand. For example, the nvme test group has many
helper functions that set sysfs attribute values and call nvme-cli
commands. Understanding these behaviors is essential for debugging test
case failures.

This series adds a new 'command trace' feature to blktests. The first
patch introduces a new --cmd-trace (or -t) option to record commands
executed during test runs. The second and third patches add a new helper
function _set_attr(), which traces both the value and file name of sysfs
attribute writes.

With this series, blktests users can use the option to generate a
.cmdtrace file that records all commands executed during a test case
run. By grepping the .cmdtrace file, users can check writes to sysfs
attributes and nvme-cli command invocations. The example below shows how
nvme targets are set up for the nvme/008 test case with rdma transport.

# NVMET_TRTYPES=rdma NVMET_BLKDEV_TYPES=device ./check --cmd-trace nvme/008
nvme/008 (tr=rdma bd=device) (create an NVMeOF host)         [passed]
    runtime  1.903s  ...  1.890s
# grep -e _set_attr -e "nvme " results/nodev_tr_rdma_bd_device/nvme/008.cmdtrace
+ _set_attr 0 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/attr_allow_any_host
+ _set_attr /dev/loop0 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/namespaces/1/device_path
+ _set_attr 91fdba0d-f87b-4c25-b80f-db7be1418b9e /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/namespaces/1/device_uuid
+ _set_attr 1 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/namespaces/1/enable
++ _set_attr rdma /sys/kernel/config/nvmet/ports/0/addr_trtype
++ _set_attr 10.0.2.15 /sys/kernel/config/nvmet/ports/0/addr_traddr
++ _set_attr ipv4 /sys/kernel/config/nvmet/ports/0/addr_adrfam
++ _set_attr 4420 /sys/kernel/config/nvmet/ports/0/addr_trsvcid
++ nvme connect --traddr 10.0.2.15 --transport rdma --trsvcid 4420 --nqn blktests-subsystem-1 --hostnqn=nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 --hostid=0f01fb42-9f7f-4856-b0b3-51e60b8de349 --output-format=json
+ nvme disconnect --nqn blktests-subsystem-1
+ _set_attr 0 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/namespaces/1/enable


Changes from v1:
- 2nd patch: added -n option to the echo command
- 2nd and 3rd patches: renamed _echo() to _set_attr()
- Link to v1: https://lore.kernel.org/linux-block/20260513112326.584256-1-shinichiro.kawasaki@wdc.com/

Shin'ichiro Kawasaki (3):
  check: add --cmd-trace option
  common/rc: add _set_attr() function to trace attribute writes
  common/nvme, nvme/rc: use _set_attr() to trace attribute writes

 check         | 17 ++++++++++++++-
 common/nvme   | 34 ++++++++++++++---------------
 common/rc     |  7 ++++++
 tests/nvme/rc | 60 +++++++++++++++++++++++++--------------------------
 4 files changed, 69 insertions(+), 49 deletions(-)

-- 
2.54.0

