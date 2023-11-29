Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Do3FuNMk"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5934B5
	for <linux-block@vger.kernel.org>; Wed, 29 Nov 2023 03:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701257777; x=1732793777;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YN4Z/bGjY0kaPL9PTU6XxB6l4IGlqdpWZPKerV1xchA=;
  b=Do3FuNMkH1r40Wk+npEAGEI89zqYgM02fsVZ5qoSG6ng7pfn6LZOzazs
   ySVqi+huVkKpZUMA/j9k+K5s1HV3Et4HQdGnBjUJ1WzzOxYkOKzqvZN3P
   +2qDfMreYedG25wF4DHmF5d6fyliwNejel8ynmuXr0NIzwKWIf1mjEH9k
   iF5U6yUGXi9j2J6bmmAZ/xzHDCMctRTgkxSe0vbExGQqWEkbgbneXJFjp
   snOTTL2DDJrr83Z7MDenhDXDoWA+ITHjP2N743Fo7do+40WhLYS1/1P9a
   s1ujRPpSXiJrkgasde9oyFnFlFXerMdFAw6zkIBrxzKBFugF7PZ+jcVQX
   A==;
X-CSE-ConnectionGUID: 2uD6KaFoSUCtIfUS5ESGFA==
X-CSE-MsgGUID: Z45NdgGjTbSZ7EtGbYp0GQ==
X-IronPort-AV: E=Sophos;i="6.04,235,1695657600"; 
   d="scan'208";a="3755240"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2023 19:36:17 +0800
IronPort-SDR: B018wNdRS86kvBw9Y8ooA35urjjUFUrlLqOUr1tit3vBNZIoyPHzbwFbjTq4djAZ0isgwnLyEx
 tLOJfI0gbRWw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2023 02:47:26 -0800
IronPort-SDR: FsNKRWRjzE3GHdZiMVpZGRv/6bz+1WGsgDO43e10gKddHdQNV7o740EuZgf8OkEj0vkK1dgY8F
 Sxo7X+2krGBw==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2023 03:36:16 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Alyssa Ross <hi@alyssa.is>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] loop/009: require --option of udevadm control command
Date: Wed, 29 Nov 2023 20:36:15 +0900
Message-ID: <20231129113616.663934-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case loop/009 calls udevadm control command with --ping option.
When systemd version is prior to 241, udevadm control command does not
support the option, and the test case fails. Check availability of the
option to avoid the failure.

Link: https://github.com/osandov/blktests/issues/129
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/loop/009 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/loop/009 b/tests/loop/009
index 2b7a042..5c14758 100755
--- a/tests/loop/009
+++ b/tests/loop/009
@@ -10,6 +10,12 @@ DESCRIPTION="check that LOOP_CONFIGURE sends uevents for partitions"
 
 QUICK=1
 
+requires() {
+	if ! udevadm control --ping > /dev/null 2>&1; then
+		SKIP_REASONS+=("udevadm control does not support --ping option")
+	fi
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
-- 
2.43.0

