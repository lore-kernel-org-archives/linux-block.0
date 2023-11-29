Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CCoj+IMc"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532721AE
	for <linux-block@vger.kernel.org>; Wed, 29 Nov 2023 02:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701253908; x=1732789908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KnviQ2ymAzfNc4y3yC6typtzhWKDAm9b+z3JTEDzMuc=;
  b=CCoj+IMcw2PnWXU24bPECuFTuu4dLjnkd+qd78Y74bEmWMHqk3u3qb+i
   Ke05tp3XLd2t+0c6dDGDwqX95JOop5t0SNfuGuoGg4dAsTRAOQqFMUp1G
   YveGm/2b0YCsw59ifVN9cIBpRyrFiEFPdam26a6OpTgkrYR2d4fz/4qL3
   m2MS+TJiIp5xHki6E+pxIc9223fPuHOL4XOBhCYbpoLsmcuLcicpUd+do
   jc3V32J0aTQqMwTk7fCuH8X8B6efhEgxjyhjxBLyxTZ41MaiUTrngXlrF
   QDrX7ZjYpfmTxqRe3kWHrIs/olNB8XvXdYdAbk3IVH6RuhRVowuCum+L0
   w==;
X-CSE-ConnectionGUID: hDlwciWMTx2xs09l20OCHg==
X-CSE-MsgGUID: 5iZkzzkoTLiTgvTgrUATig==
X-IronPort-AV: E=Sophos;i="6.04,235,1695657600"; 
   d="scan'208";a="3614312"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2023 18:31:47 +0800
IronPort-SDR: 3XQE4eOa3c0lIlZVyDkAw984Tj0pBtBiRIymwTzsB9M3zhOmZQDEKtNMJWVUDA9OkWxNc1OLNj
 ccF2tWmqayGg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2023 01:37:16 -0800
IronPort-SDR: RDGle/Qs6CbYgeJPiWpE8p39qd7pZJGQaGSghSxYTPkBlDvRC5a8/bMwvOmmRHHvZ3F3uBUEiW
 pEHin2Td3tHQ==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Nov 2023 02:31:47 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/2] block/011: set default timeout to 20 minutes
Date: Wed, 29 Nov 2023 19:31:45 +0900
Message-ID: <20231129103145.655612-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129103145.655612-1-shinichiro.kawasaki@wdc.com>
References: <20231129103145.655612-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case runs fio while disabling and enabling PCI device of the
test target block device. Depending on the device type, it takes very
long time to re-enable the device. At worst case, it takes 4 hours to
complete the test case.

To avoid the meaningless long test runtime, set default timeout limit. I
ran the test case on various devices: real NVME SSD, QEMU NVME
emulation, HDDs with AHCI, HDDs with SAS-HBA. Many of them takes less
than 20 minutes to complete and pass the test case. Hence, choose 20
minutes as the timeout duration.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/011 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/block/011 b/tests/block/011
index 2a967d1..78d8d3d 100755
--- a/tests/block/011
+++ b/tests/block/011
@@ -49,6 +49,7 @@ test_device() {
 	fi
 
 	# start fio job
+	: "${TIMEOUT:=1200}"
 	_run_fio_rand_io --filename="$TEST_DEV" --size="$size" \
 			--ignore_error=EIO,ENXIO,ENODEV &
 
-- 
2.43.0

