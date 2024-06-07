Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D088433B6
	for <linux-block@vger.kernel.org>; Fri,  7 Jun 2024 04:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717735971; cv=none; b=OP+1NcAEnY8qoaDt7MNGCmx2wEebaFwegNTbYuizTb7gdZasfeef+xsGAGII1Iz+CTh+PNF6ngNgyIjEnf3xNS9B5Zkn8m15mTrCPFMn6benxuLUE2KeqZHdeqDC4ClmgauditJ6W5iybEiM1o0Ux13yKceE7pv3qnYK8Iu77eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717735971; c=relaxed/simple;
	bh=TtKH/nRpLLSQBv6ga6OR/mLkhPqERzHax4+J4S3D3rY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eu3aTJu59kDWTCJMAltKgkll5w/wXCyBRlvXIfWyRcfETE2tpW6AvS4OoX2aIxMpIs7RdyXULyi1W7jUCcNph3a1nNnlujUL0uonrRxa8PA8GBEDPpE/m+ROVsbdpcUP1ePC4QnbXdT3Hdb3PUIpTdMtmP78EZ8JtL/HcAKXbbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KkfGSvYu; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KkfGSvYu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717735969; x=1749271969;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TtKH/nRpLLSQBv6ga6OR/mLkhPqERzHax4+J4S3D3rY=;
  b=KkfGSvYuSEKVFvk+qPpp620ljzt4P20uxc9D7CQ2WmK7DrXakAs3cBn6
   h1OcwpNlCdSH1DVomZCjAzFoG5hGKO2fIMumiE0mr1r8o0gKgCB4/zIhA
   3ouejcpKC81cS/lDDnMZw/RrJDipaNAdDcSpOlsoxJf+z008nbkQzJgOK
   VI8uSfSiFg5txAwy1/8jMu6Lm/7ieukQ+0BIIn+s4sex+rQgw5+2lKAcl
   qQaQsk5JArYUNPwl+YlWNZ5XGsi10xBSlNRR33V2Ms5durZ59BSQ5JTOk
   MGgYgUeGKcKb9EXHUQ/Y0Mq6TB/zi2ViTZWqcunBkKXiE2eqY4YLtcEm3
   A==;
X-CSE-ConnectionGUID: QoRo8hy9Q0a5srjv2XGfkQ==
X-CSE-MsgGUID: 7DL2ZKUqSuyRMH2nRIpXoA==
X-IronPort-AV: E=Sophos;i="6.08,220,1712592000"; 
   d="scan'208";a="18511884"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2024 12:52:48 +0800
IronPort-SDR: 66628471_E511/p08AAd+FLJ0LzFZ0NK7ZDwFpBrdQPG1SMuy4qjtTpy
 Cq/nwychPN8O5dtDeJYwpXj6Zqv9vJQggM8w2uw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jun 2024 20:54:25 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jun 2024 21:52:47 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] check: confirm dependent commands
Date: Fri,  7 Jun 2024 13:52:46 +0900
Message-ID: <20240607045246.248590-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in README, blktests requires some commands to run tests.
Check them and warn if they are not available. Also confirm that the
bash version is 4.2 or larger.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/check b/check
index 3ed4510..7f43a31 100755
--- a/check
+++ b/check
@@ -709,6 +709,32 @@ _check() {
 	return $ret
 }
 
+_check_dependencies() {
+	local v1 v2 v3
+	local -A required_commands_and_packages
+	local cmd
+
+	# Require bash version 4.2
+	IFS='.' read -r v1 v2 v3 < <(bash --version | grep version | head -1 | \
+					   sed 's/.*version \([0-9.]\+\).*/\1/')
+	if ((v1 * 65536 + v2 * 256 + v3 < 4 * 65536 + 2 * 256)); then
+		_warning "bash version is older than 4.2"
+	fi
+
+	# Check dependent commands to run blktests
+	required_commands_and_packages[dd]="GNU coreutils"
+	required_commands_and_packages[gawk]="GNU awk"
+	required_commands_and_packages[blockdev]="util-linux"
+	required_commands_and_packages[fio]="fio"
+	required_commands_and_packages[udevadm]="systemd-udev"
+
+	for cmd in "${!required_commands_and_packages[@]}"; do
+		command -v "$cmd" &> /dev/null && continue
+		_warning "$cmd is not available." \
+			 "Install ${required_commands_and_packages[$cmd]}."
+	done
+}
+
 usage () {
 	USAGE_STRING="\
 usage: $0 [options] [group-or-test...]
@@ -748,6 +774,8 @@ Miscellaneous:
 	esac
 }
 
+_check_dependencies
+
 if ! TEMP=$(getopt -o 'do:q::x:c:h' --long 'device-only,quick::,exclude:,output:,config:,help' -n "$0" -- "$@"); then
 	exit 1
 fi
-- 
2.45.0

