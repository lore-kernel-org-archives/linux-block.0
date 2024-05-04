Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2177B11C83
	for <linux-block@vger.kernel.org>; Sat,  4 May 2024 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714810505; cv=none; b=QZMINVxFRaQZPlZM8AQLOkD8qpJ6cOIF1Der5hOKt08PPrk2aQOrmkeI/UT5ccdcL7FZ58s3MZWjYFUAKlIa7J08SjzolJy7yPFgNdI6Q2q7yRmMUJtoztX96ryzF8Cz+6NTxqweAQU8VjdtuxOYXhQGfnl6AHHpYL2yQlTlIdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714810505; c=relaxed/simple;
	bh=MPBXHvjYsktcEJAin3E7drsL+wdn5WXd98VqCO/B/8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMidawMhW+tyaheIZ0B20/3jLSVgNZ8stvTzepJRRuykpwgwjzbddJFNN/ZjVDx66Scrpl4duE2znk9W7QH5TXylj3rZsTqdwOUU3Q4Azl1ley6wo+9DL0Lz/Bu2OTNxDsD64rz0+0rhLtNrT9/rIb2RG+CCvnIE98TIjedeaow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MqqiIFq0; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MqqiIFq0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1714810503; x=1746346503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MPBXHvjYsktcEJAin3E7drsL+wdn5WXd98VqCO/B/8Y=;
  b=MqqiIFq0m9sAD+wMNhAuU7cj3eh6NARZvM0FL9uAaOZhH5NnSZz0mReK
   u9ivnQwqCsgyJvaHYUORPv8aydwD5F5IUkroYwws5yzAZ9FCsVfQ/JqxG
   rKq2ULTg3CcwKaj1JE4KbYPzggByJ8NjTGxOsO2x/+chgOlA80eFGHL1k
   apL6tnHlrDxGc2M9cVtY9AX6+Z0gGUZaB9nFCj+JqN/lTBFFGSDJLsa/H
   sX4dER0nIEPbEh7Xhd0jfWgvHV4dWexHi9rtYXtUscLdC8hOvBhMH5jd0
   XbqHVHCYWe3REAYOl1LJwpuxvd6FITH3hPX/0xUY1U0bYwi4PcPf6VH+9
   A==;
X-CSE-ConnectionGUID: v4lZ7NwxSdWehKTXjXy97w==
X-CSE-MsgGUID: fGPJ6SqmQlm+K/uoRiGXrA==
X-IronPort-AV: E=Sophos;i="6.07,253,1708358400"; 
   d="scan'208";a="15540322"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2024 16:15:02 +0800
IronPort-SDR: TuAOsabyeKnXp2zRIMSaOyOU55lFTVxFcCpZ89LbJHe6RKJYIlcJzR7oNmpV2248pB6BPYxOQf
 kaDZBbk9jNGN6eo8TLv5GiEz7RvhJGNguCLt0fF1ovncgzz8tTI8EkiwqqtT27yxJsi1rrT1K/
 SqXvsMwnKkkUB6SINLPHELf8j3AaFBjThNqsC5kHyvLbLc9Ge+H/3sQfcczWQbVrqstHmldEy7
 NXB5DqzyqJSlJ+ihtcqd23lDoHmJu3GUggrpTdGet03jhqTuyNPskWrHAUgFy0b6llULUZEfeO
 8Nk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2024 00:23:00 -0700
IronPort-SDR: Lt8Abm8RaM8kghAclX4IO3o1TbXo/mNXltdINu6ndonA/DnTn2eIzAfTsU5tZ5GYX+HDYqtkBQ
 n+SxtizaBtl0PoY/t/MjT0WsVigpxVr4IfJDxeaCqnPZRXsSIpNxB1SpWAe+1dEFjMIAhmZi+M
 UdkAhpy4QkC6pv4inC1/0u6znLqKvbw5U6Dfy4ApRlp3ufLphU+QvjwHEEAroXBjxqemsAY4JL
 SYWWq6uKA87BNQCXL8Jbn7KVUxmOD1V8CkfcWdF61BFbbZLUTRc9Nox2Nn5iv6dYdRWJDHaZ2D
 GGg=
WDCIronportException: Internal
Received: from unknown (HELO shinhome.flets-east.jp) ([10.225.163.38])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 May 2024 01:15:01 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 10/17] nvme/rc: introduce NVMET_BLKDEV_TYPES
Date: Sat,  4 May 2024 17:14:41 +0900
Message-ID: <20240504081448.1107562-11-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
References: <20240504081448.1107562-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Some of the test cases in nvme test group do the exact same test for two
blkdev types: device type and file type. Except for this difference, the
test cases are pure duplication. It is desired to avoid the duplication.
When the duplication is avoided, it is required to control which
condition to run the test.
    
To avoid the duplication and also to allow the blkdev type control,
introduce a new configuration parameter NVMET_BLKDEV_TYPES. This
parameter specifies which blkdev type to setup for the tests. It can
take one of the blkdev types. Or it can take both types, which is the
default. When both types are specified, the test cases are repeated
twice to cover the types.
    
Also add the helper function _set_nvmet_blkdev_type(). It sets up
nvmet_blkdev_type variable for each test case run from
NVMET_BLKDEV_TYPES.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md |  5 +++++
 tests/nvme/rc                  | 18 +++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 571ee04..64aff7c 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -108,6 +108,11 @@ The NVMe tests can be additionally parameterized via environment variables.
   tests are repeated to cover all of the transports specified.
   This parameter had an old name 'nvme_trtype'. The old name is still usable,
   but not recommended.
+- NVMET_BLKDEV_TYPES: 'device', 'file'
+  Set up NVME target backends with the specified block device type. Multiple
+  block device types can be listed with separating spaces. In this case, the
+  tests are repeated to cover all of the block device types specified. Default
+  value is "device file".
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm', 'M', 'g'
 	and 'G' postfix are supported.
diff --git a/tests/nvme/rc b/tests/nvme/rc
index ec54609..27d35e9 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -22,6 +22,7 @@ _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
+NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
 
 _NVMET_TRTYPES_is_valid() {
 	local type
@@ -51,7 +52,22 @@ _set_nvme_trtype() {
 	fi
 
 	nvme_trtype=${types[index]}
-	COND_DESC="nvmet tr=${nvme_trtype}"
+	COND_DESC="tr=${nvme_trtype}"
+}
+
+_set_nvmet_blkdev_type() {
+	local index=$1
+	local -a types
+
+	read -r -a types <<< "$NVMET_BLKDEV_TYPES"
+
+	if [[ -z $index ]]; then
+		echo ${#types[@]}
+		return
+	fi
+
+	nvmet_blkdev_type=${types[index]}
+	COND_DESC="bd=${nvmet_blkdev_type}"
 }
 
 # TMPDIR can not be referred out of test() or test_device() context. Instead of
-- 
2.44.0

