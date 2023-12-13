Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nbnitXv0"
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06866EA
	for <linux-block@vger.kernel.org>; Wed, 13 Dec 2023 00:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702457180; x=1733993180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JO8kBDtkW9hko8Ffk7iz3YqmDFm+X3ENShtPbikeaUs=;
  b=nbnitXv0g3uPFU1TKpjqdwuI5iLPbAxcv5j0UE/sjHILoLSpC36K8FQN
   3n+A/5D9ZlGMnXHWIqX7gyYB4a0zK6L5W1/GPSiKKsuwqz1eOe3wAoWRW
   QjIFICzWl0AMijgkbCI/b7Qclbql069OPjjNxVqFWdE3B6TVYHquW1WwN
   gzXQr3m9HXfIWbZwZlC93b+oL9cSQutthmFBECrJ3NJZTQJXj35EsC+sI
   XfUfL0fSZ2LQ26lltdaPp+lFja3cPeaIWW3pmmtf5yTowSwfgcFaQetqA
   mlNS9zFfTw5CYUs91DS376GUsjKoxbPeeZ/7Rg7rRGpKiq4GuOJkn/yJe
   A==;
X-CSE-ConnectionGUID: KJWPhKsTTMi7pnNrWtoWUQ==
X-CSE-MsgGUID: 69kXfmRAQSSQ6Yo6fHJXpA==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4711861"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 16:46:20 +0800
IronPort-SDR: OS7216qcCDSUOikpHdpTvyYNk6W1vDGHrT3S9Nh+bynw9TVj9193PQydzLQBDncXkNpq+1lKdy
 R2YJY/8peMIQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2023 23:51:32 -0800
IronPort-SDR: F465IMBijf6Uu6V7xZC2nB7qiCFWC2vkkL0oRC4jobyYTk5kkQldS/qY1Cs3M99lAPNgWe6UK2
 RgfGcK50Ihhg==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Dec 2023 00:46:20 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] block/007: skip hybrid polling tests when kernel does not support it
Date: Wed, 13 Dec 2023 17:46:19 +0900
Message-ID: <20231213084619.811599-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the kernel commit 54bdd67d0f88 ("blk-mq: remove hybrid polling"),
kernel does not support hybrid polling. The test case block/007
specifies auto-hybrid and fixed-hybrid polling for testing. But it is
confusing and meaningless when kernel does not support it. Check if
kernel supports hybrid polling. If not, skip the hybrid polling tests.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/block/007 | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/block/007 b/tests/block/007
index faa3780..3b68d0d 100755
--- a/tests/block/007
+++ b/tests/block/007
@@ -58,14 +58,18 @@ test_device() {
 	run_fio_job 1
 
 	# switch to auto-hybrid polling, run job
-	FIO_PERF_PREFIX="auto hybrid poll "
 	_test_dev_queue_set io_poll_delay 0
-	run_fio_job 1
+	if [[ $(_test_dev_queue_get io_poll_delay) == '0' ]]; then
+		FIO_PERF_PREFIX="auto hybrid poll "
+		run_fio_job 1
+	fi
 
 	# switch to explicit delay polling, run job
-	FIO_PERF_PREFIX="fixed hybrid poll "
 	_test_dev_queue_set io_poll_delay 4
-	run_fio_job 1
+	if [[ $(_test_dev_queue_get io_poll_delay) == '4' ]]; then
+		FIO_PERF_PREFIX="fixed hybrid poll "
+		run_fio_job 1
+	fi
 
 	echo "Test complete"
 }
-- 
2.43.0

