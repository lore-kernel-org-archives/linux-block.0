Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F5257844
	for <linux-block@vger.kernel.org>; Wed, 24 Jun 2026 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782285525; cv=none; b=TZ4iS5eTR3BHeG0/wCZZNsheW5QFPLNYjBtoOQnnTLswJMWlgH4VBljjYi7oEa4xZPXulwI8Y9jm+qU0Gday9cvfDaXO+Ws10wWlUDEf45IPttcV+iJ5GxDEleotAFHZ7xFM1KVngGvDcUyi18IaGKZroEjzEM/ldi4g1QYWh+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782285525; c=relaxed/simple;
	bh=nrYKMufaXtqNYB+P9v4MXfAaqsWI0fYVNrFA8gXNLKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pl6k4Y1Qceh4nUYixvzE6ieQxYXvxWq9WLYJtHhEop7+oWxvu071dFk8MUMVzWG5QUG41nDVPkqfgPWK8zmtM5GEvvuhCeXG02R7ctX++FnUFIgc2HxEzi+d4jnGvap6pmTdAyFATU8a6DvOzBjJzUXV4/2Jyf1+R+9WZcksEz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lJfFWSiO; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lJfFWSiO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782285523; x=1813821523;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nrYKMufaXtqNYB+P9v4MXfAaqsWI0fYVNrFA8gXNLKg=;
  b=lJfFWSiOr6ZCpjr4q4RA1IryOMeESRNbhi06IdGRsH2el1k3drzKuZln
   SqB/+ZvuW6S4AFJ6HccAEV8wWh/q3KPkL5XjzKrXgkmMxMnzm7STye3jy
   WQGcqDuT/w7ZX5Vm9biJ7vn9qvrzb8N4QBYfdThCj31S1d8D2jpTV331U
   wSOViUthtx22i/Pr8eoZLEDfWxAAVx3Ruw+LNdzZG6+d4rXWluzD8kNOz
   mjtazg+8mlog2LZPteu4HdJ4QQzsgiWGuQ8aUx46aT0hYHQwfumZOrza0
   pmvWEOUxH86CZ9K23TJT9z6mW/ekMdJWkKJhouRnuaQYe+imJ/SYNmfIp
   A==;
X-CSE-ConnectionGUID: jYDnFWwtQCqv7mfgj19R3A==
X-CSE-MsgGUID: 2DehUcNAR4+Kt2OPfTVDfw==
X-IronPort-AV: E=Sophos;i="6.24,222,1774281600"; 
   d="scan'208";a="150621005"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2026 15:18:37 +0800
X-CSE-ConnectionGUID: 9ea8US44SGWFO5CT+mp0/g==
X-CSE-MsgGUID: znK0HbuCS5qT5KhBZ03s2w==
IronPort-SDR: 6a3b84b9_xhsaWskF9FT2eymQY6z+D6PAXPQTIDEZprE5ZY6bMpWEfZf
 i1zBV6cu90aZ3eRKjcUKwoA5dahvc2XNYdLvIBw==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Jun 2026 00:18:17 -0700
X-CSE-ConnectionGUID: i5rSIFdzQYeYSMoFqEr5Lg==
X-CSE-MsgGUID: XI0XIkZbSH2sNKjp8Xzzow==
WDCIronportException: Internal
Received: from wdap-pknkuu9kan.ad.shared (HELO shinmob.wdc.com) ([10.224.105.128])
  by uls-op-esai2-o.wdc.com with ESMTP; 24 Jun 2026 00:18:16 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Omar Sandoval <osandov@osandov.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Jeff Moyer <jmoyer@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] README.md, check: require getconf
Date: Wed, 24 Jun 2026 16:18:15 +0900
Message-ID: <20260624071815.54600-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some test cases use the getconf command to query the page size that the
kernel supports (e.g. scsi/011, throtl/{002,003,007}, zbd/{010,014}).
Add getconf to the list of required commands so its absence is reported
clearly, and document it as a dependency in README.md.

Link: https://lore.kernel.org/linux-block/ajm1x0koQ4BftBOc@shinmob/
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 README.md | 1 +
 check     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/README.md b/README.md
index b137a43..b62540a 100644
--- a/README.md
+++ b/README.md
@@ -19,6 +19,7 @@ The dependencies are minimal, but make sure you have them installed:
 - fio
 - gcc
 - make
+- getconf
 - systemd-udev (udevadm)
 
 Some tests require the following:
diff --git a/check b/check
index a68049b..bc2dde9 100755
--- a/check
+++ b/check
@@ -1118,6 +1118,7 @@ _check_dependencies() {
 	required_commands_and_packages[blockdev]="util-linux"
 	required_commands_and_packages[fio]="fio"
 	required_commands_and_packages[udevadm]="systemd-udev"
+	required_commands_and_packages[getconf]="glibc-common or libc-bin"
 
 	for cmd in "${!required_commands_and_packages[@]}"; do
 		command -v "$cmd" &> /dev/null && continue
-- 
2.54.0

