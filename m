Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659353A5E64
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671436; cv=none; b=H9paD/gSL3KHAwPxcAfHIujtqNDL/TJ1bCzs59HayGHAitT2aS5yLFBnajQLLBv2iZXshQU6uhLtWnToxtXvgCBA4AotJ+RSYyNqnuQl5a7jqmnSdl4zgu3hBXeY2m6ssDT3hpJLoh+K8m6sxt5X9SWwNbd6Oa8mUCuO0YzxPI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671436; c=relaxed/simple;
	bh=BMyXUYr9p4bbaocxpUXEFqMo7V5USwGhdWrrSlGK0Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1nqee2yPeJTKqGksrj6W/CP4QT3sJlkKH7baLIlpOwOFbzfN1xwh4Go5HCn411v3HZNy1OyAz6D7JToIvrEXzn3E0bP9WLIRzW/oe/zS4us791KU33ugk9Prgb3l7j6DZlGd7Zrb+zUmD6tkpqXp8I8eqexTelwxDl5SGUJ0nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=L5ZUXjcZ; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L5ZUXjcZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1778671435; x=1810207435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BMyXUYr9p4bbaocxpUXEFqMo7V5USwGhdWrrSlGK0Xw=;
  b=L5ZUXjcZr9C6o7LfuWmpbY64arLW7L9j8ezjkr/QByEiAOUt7GyZiIJU
   +A4LXaM4+sGfUJ6CZnKHeJusIHNcLvQ/nWDvGgUYsGbWLf8YbSEcfAXjr
   lkjpm73sqB4hkhVz7vxrStmsI0c05H7SzM4qkJAb3ZmqYB5bs5AQs/YO5
   iyAEOBAmty4nRwbVGirdN3hOY7G1apRapvYd+P5Gocs9slJbek2ypXmQT
   Z9oA/QPlPbvyQkGzWzSs/GJv5WsMBLgwfq2HSinJJ7glkVrWxxoc7JV5A
   UeKiIOhbSrHTPf+eMzzjEM9wLhhghuOttR6rfdeuBo/yK0IWGhBU3zaLf
   Q==;
X-CSE-ConnectionGUID: KiHjNpNGTUWsl6cshEuMzQ==
X-CSE-MsgGUID: mPb3o80HSlym0+A6hZzSQA==
X-IronPort-AV: E=Sophos;i="6.23,232,1770566400"; 
   d="scan'208";a="145918709"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2026 19:23:54 +0800
X-CSE-ConnectionGUID: gQv8YpgXRgyhTYWe8lViEQ==
X-CSE-MsgGUID: txno4i2iStKRt62NDbUkFw==
IronPort-SDR: 6a045f30_QgvQ1COyQrOyMZ7l9GitHwIaL7PDC0Z9rdil8fofxHtuF68
 +5/C1ityEVJvg73Dof6RRAVLOspRyPG3TrbZxKA==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 May 2026 04:23:27 -0700
X-CSE-ConnectionGUID: AhGEb6AYSxOmGrxndLRSaQ==
X-CSE-MsgGUID: InnKxI2zTfiLOV/npgh1sQ==
WDCIronportException: Internal
Received: from wdap-o209afpuln.ad.shared (HELO shinmob.iptvf.jp) ([10.224.105.138])
  by uls-op-esai2-o.wdc.com with ESMTP; 13 May 2026 04:23:27 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/3] introduce command trace feature
Date: Wed, 13 May 2026 20:23:23 +0900
Message-ID: <20260513112326.584256-1-shinichiro.kawasaki@wdc.com>
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
function _echo(), which traces both the value and file name of sysfs
attribute writes.

With this series, blktests users can use the option to generate a
.cmdtrace file that records all commands executed during a test case
run. By grepping the .cmdtrace file, users can check writes to sysfs
attributes and nvme-cli command invocations. The example below shows how
nvme targets are set up for the nvme/008 test case with rdma transport.

# NVMET_TRTYPES=rdma NVMET_BLKDEV_TYPES=device ./check --cmd-trace nvme/008
nvme/008 (tr=rdma bd=device) (create an NVMeOF host)         [passed]
    runtime  1.903s  ...  1.890s
# grep -e _echo -e "nvme " results/nodev_tr_rdma_bd_device/nvme/008.cmdtrace
+ _echo 0 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/attr_allow_any_host
+ _echo /dev/loop0 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/namespaces/1/device_path
+ _echo 91fdba0d-f87b-4c25-b80f-db7be1418b9e /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/namespaces/1/device_uuid
+ _echo 1 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/namespaces/1/enable
++ _echo rdma /sys/kernel/config/nvmet/ports/0/addr_trtype
++ _echo 10.0.2.15 /sys/kernel/config/nvmet/ports/0/addr_traddr
++ _echo ipv4 /sys/kernel/config/nvmet/ports/0/addr_adrfam
++ _echo 4420 /sys/kernel/config/nvmet/ports/0/addr_trsvcid
++ nvme connect --traddr 10.0.2.15 --transport rdma --trsvcid 4420 --nqn blktests-subsystem-1 --hostnqn=nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 --hostid=0f01fb42-9f7f-4856-b0b3-51e60b8de349 --output-format=json
+ nvme disconnect --nqn blktests-subsystem-1
+ _echo 0 /sys/kernel/config/nvmet/subsystems/blktests-subsystem-1/namespaces/1/enable


P.S. The idea of command trace came from the hallway discussion at LSFMMBPF
     2026 with John Meneghini and Daniel Wagner. Thanks!

Shin'ichiro Kawasaki (3):
  check: add --cmd-trace option
  common/rc: add _echo() function to trace sysfs attribute writes
  common/nvme, nvme/rc: use _echo() to trace sysfs attribute writes

 check         | 17 ++++++++++++++-
 common/nvme   | 34 ++++++++++++++---------------
 common/rc     |  6 ++++++
 tests/nvme/rc | 60 +++++++++++++++++++++++++--------------------------
 4 files changed, 68 insertions(+), 49 deletions(-)

-- 
2.54.0

