Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0BB1D799D
	for <linux-block@vger.kernel.org>; Sun, 28 Sep 2025 08:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759047347; cv=none; b=i/m9Tm7n/A2wYiWDHBUisP2NfmkCHJ0PVC0qAXw06dRSSIEiDFBLkkrMRnLhdFPN+fLKrvghPND+jz+z0XSISOPRiIOvG8ZpaLsvaX1mNpaXm6zxGhzWdDNWBqteDq0z20vZePkie9Jp+3TJCw7MRIf76vEXAIGK2e70HDJw2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759047347; c=relaxed/simple;
	bh=U9N9Uk2GkPvfryNBwhgvXIJ2QlSSYqApjRs2m5DSZPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R/9Ws3HmehpQU36aKndE3NABg20PmF1bUUMpHorbgIqlXCs0EnSDNMenuQYaGGiRJ6ZkfdReL/jyRRC3xdr8WR7sfUdhVMKWlEn+y/n5mqZ2F0cFVPhfu6i94pV/XKW8OCkUOw++paYd03kSi37h252IsihfB1/jRReuFbBUMn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lW0PlNp2; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lW0PlNp2"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759047345; x=1790583345;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U9N9Uk2GkPvfryNBwhgvXIJ2QlSSYqApjRs2m5DSZPo=;
  b=lW0PlNp24t2hZFPjBKD+mupJb2Bj7qMZfdMe/eHy8ZzD20HGHWjAlA8/
   6q17P46r3S4istZWWj3ZIwVBBYhQrl46P1QLkRgvGRDP8NF1itcPZQmJX
   c6a4843VFyX1Z57zbA3DtR/AIX2aVNiEO2zO4N/nNPZebs50NjjQ+gaXr
   bE9yrYc57dKXOJZ2EHh8uW/CEf5rn1kYlI7Naw32zLahGYzT6NdPYjKJY
   KoqrrW07kwg2ic4shBVMLfFV4Tfizenbmoym+YsosyHtgOBQktO3O2L93
   HY8E4nHErpqZ0DIWrWhfPLo9zl8fCsVK/u1+qKpgKdYW6XlxuATaNlKMY
   w==;
X-CSE-ConnectionGUID: IeDHFRmORRSX278VHqo5bQ==
X-CSE-MsgGUID: hsxXibVSR1CKQbZEj7+mJg==
X-IronPort-AV: E=Sophos;i="6.18,299,1751212800"; 
   d="scan'208";a="132307090"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2025 16:15:39 +0800
IronPort-SDR: 68d8eeab_QFBTkR/ibNTA1vdB6XLJeb4iNffa8PUZkWJBwiq8xDnbrRi
 8bUWBPxPPc1ayWHl+NCeKrM4sgqiQbIQYN7bG2Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2025 01:15:40 -0700
WDCIronportException: Internal
Received: from wdap-iwbc3fucvd.ad.shared (HELO shinmob.wdc.com) ([10.224.173.105])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Sep 2025 01:15:38 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: John Garry <john.g.garry@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] check: print device names provided to test_device_array()
Date: Sun, 28 Sep 2025 17:15:37 +0900
Message-ID: <20250928081537.337008-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a test case has test_device(), blktests prints the name of the test
target device provided to test_device(). The commit 653ace845911
("check, new: introduce test_device_array()") introduced the support for
test_device_array() which runs the test for multiple devices. However,
when the test case has test_device_array(), blktests does not print the
names of the test target devices.

Modify the check script to print the test target device names. For that
purpose, factor out two _output_status() calls into a new helper
function _output_test_name(). In that function, print TEST_DEV_ARRAY
elements which are provided to test_dev_array() as the test target.

After this commit, md/003 run will look like as follows:

 md/003 => nvme1n1 nvme2n1 nvme3n1 nvme4n1 (test md atomic writes for NVMe drives) [passed]
   runtime  18.678s  ...  18.446s

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 check | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/check b/check
index ca0faca..6d77d8e 100755
--- a/check
+++ b/check
@@ -252,12 +252,25 @@ _output_notrun() {
 	_output_skip_reasons
 }
 
-_output_last_test_run() {
+_output_test_name() {
+	local dev
+	local -a devs
+	local status="$1"
+
 	if [[ "${TEST_DEV:-}" ]]; then
-		_output_status "$TEST_NAME => $(basename "$TEST_DEV")" ""
+		_output_status "$TEST_NAME => $(basename "$TEST_DEV")" "$status"
+	elif [[ "${TEST_DEV_ARRAY:-}" ]]; then
+		for dev in "${TEST_DEV_ARRAY[@]}"; do
+			devs+=("${dev##*/}")
+		done
+		_output_status "$TEST_NAME => ${devs[*]}" "$status"
 	else
-		_output_status "$TEST_NAME" ""
+		_output_status "$TEST_NAME" "$status"
 	fi
+}
+
+_output_last_test_run() {
+	_output_test_name ""
 
 	{
 	local key
@@ -277,11 +290,7 @@ _output_test_run() {
 	if [[ $status = pass || $status = fail ]]; then
 		status+="ed"
 	fi
-	if [[ "${TEST_DEV:-}" ]]; then
-		_output_status "$TEST_NAME => $(basename "$TEST_DEV")" "$status"
-	else
-		_output_status "$TEST_NAME" "$status"
-	fi
+	_output_test_name "$status"
 
 	{
 	local key last_value value
-- 
2.51.0

