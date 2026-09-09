Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8615632BE;
	Wed,  9 Sep 2026 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960411; cv=none; b=gV6rlJDMW4JIjF/x23FXFz5UjbAwdCfN3935DDnEDCi8CYQ++QLvMBbnQnF3AwmSPn0QyDhANtSo3Eh6mP61nWgAlPNNkM9nFlb2NWzOnueyOKWhsuCwybsTfzeiYzvsFbX8EpEDUAUYnQNpFyIE7viZdn1nq1/xYgevKP2qO88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960411; c=relaxed/simple;
	bh=m9d7ujv378uw+j2ZjyLPhKB21Fd8zoqENiKhmu/5oqg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XhFm4Y3UXjlZjmiBvkDGQaK2sl6PA/NdSn2TuEVFZjuy59J2KKWX8cG2wPr0AOA2Gu/GoPLs1VQWSRW7djNbPYffoeM7oOVoEFPfPEAH/0ejTkdXeqjPWquS0k/nYz1D3uM0pNm6LR7WFcHG6wxe7MltMStShYEfQzCOM8P56vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=IADbfR6V; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="IADbfR6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1788960409; x=1820496409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=stTt3pcn/55ggI22k7c3KD4aU4G5gE3hgIvnTyPwIrs=;
  b=IADbfR6VUP/0XeI3sbHdYanC4dODAowD7WV9UjWeVgyteB8bADUEv8Hi
   W8+TSgjnfnc2fBS41c3++HkQeEQl+pCjjFD1j3KWHm/ZzYFUaWLuIC330
   HuN9KzCg2sq/hzya27hbHzNkmPJbwm6JcH9glaX1nbR068heBDe8ZzDEt
   vetA3bZxv5cfdNgRHXpUYfz6dYuUnotguVkre1usz4pYdNM9j6wbP2jId
   g/arLF0iaaSVnMMqu1rVzcUZnS958degofIWiYIZt8DlkYaqpNqT+SNFo
   IdNUhouQ8dg9nBi1n/ePa63kjFRIPBk5FsaJyvE8dcasLMmuxJOId338L
   w==;
X-CSE-ConnectionGUID: XFeq43UxR+edIZcqz43naA==
X-CSE-MsgGUID: d9xPtqCDSL2K4hIpBkglyA==
X-IronPort-AV: E=Sophos;i="6.25,270,1779148800"; 
   d="scan'208";a="28092934"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 13:26:43 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:26264]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.27:2525] with esmtp (Farcaster)
 id 2b3fafe0-6241-42f4-94b6-181936edf88d; Wed, 9 Sep 2026 13:26:43 +0000 (UTC)
X-Farcaster-Flow-ID: 2b3fafe0-6241-42f4-94b6-181936edf88d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Wed, 9 Sep 2026 13:26:43 +0000
Received: from dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com
 (10.253.107.175) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46; Wed, 9 Sep 2026
 13:26:41 +0000
From: Mahmoud Nagy Adam <mngyadam@amazon.de>
To: <linux-kselftest@vger.kernel.org>
CC: Ming Lei <tom.leiming@gmail.com>, Shuah Khan <shuah@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] selftests: ublk: install test_common.sh and trace/ scripts
Date: Wed, 9 Sep 2026 15:26:03 +0200
Message-ID: <20260909132602.68852-2-mngyadam@amazon.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Every ublk test script sources test_common.sh from its own directory:

    . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh

and test_generic_02/12 additionally run bpftrace against the scripts in
trace/. Neither test_common.sh nor trace/ is listed in TEST_FILES, so
"make install" does not copy them into the install directory and every
ublk test fails when run from there:

  ./test_generic_02.sh: line 4: .../kselftest_install/ublk/test_common.sh: No such file or directory
  ./test_generic_02.sh: line 8: _have_program: command not found

The bpftrace tests are affected even when bpftrace is installed: the
missing trace/*.bt makes bpftrace exit immediately, and the tests then
report a skip rather than a failure, which hides the problem.

Add both to TEST_FILES, matching how other selftests ship their sourced
helpers (see kexec/kexec_common_lib.sh and zram/zram_lib.sh).

Fixes: 6aecda00b7d1e1 ("selftests: ublk: add kernel selftests for ublk")
Fixes: 723977cab4c0fd ("selftests: ublk: add generic_01 for verifying sequential IO order")
Cc: stable@vger.kernel.org # v6.15+
Assisted-by: Kiro:claude-opus-5
Signed-off-by: Mahmoud Nagy Adam <mngyadam@amazon.de>
---
 tools/testing/selftests/ublk/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 5daf36c6c36c4c..37883e9d50ec3e 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -73,6 +73,8 @@ TEST_PROGS += test_stress_08.sh
 TEST_PROGS += test_stress_09.sh
 
 TEST_FILES := settings
+TEST_FILES += test_common.sh
+TEST_FILES += trace
 
 TEST_GEN_PROGS_EXTENDED = kublk metadata_size
 STANDALONE_UTILS := metadata_size.c
-- 
2.47.3

