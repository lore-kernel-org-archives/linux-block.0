Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B02139CEF
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350536; cv=none; b=OWLGtSsK07Ol2Vb3zuR7yz257gnfCRBtwjBwqNvlR9S3R2g2nCBRRBE0moWaYnicecS9Ez54xuWLimIwtBYrKzczqj48POVfhMxi/4jdMpEIT4oYx8/2Eqy27gHNOqmsUiUjX9WV7tcfnCcVxlYO5YxeXiKJtPeqEj/u4jmZXwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350536; c=relaxed/simple;
	bh=3roGAFq0akpy3yja+jCNy+bt+me5vr5KFtx4OdO58SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROacMOjzSpVMIiOT7isEp/T6QCo68yG5+fS18Iq4crAcIlsxYqa7iqOUKnuk6StMtXLogfWr2jmjDiMNf+caTKvnxTDl7xzrhqDxro2fFTDM2CErx+pOYwka8pG+2OWRgRSC6SmTwflm1zDDeyHDgzWiSiRwc64hywrlnpTi9bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rrvwvvPt; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rrvwvvPt"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713350534; x=1744886534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3roGAFq0akpy3yja+jCNy+bt+me5vr5KFtx4OdO58SQ=;
  b=rrvwvvPtvGiv3BWGODM06LST5I7rPD7s3uNsKsIrFGwvBvz5/pYvIw4L
   jisLdKy7lRLMF8MoITfri+jhn9hOwI0V3XQrvc7Jgwsmzg7gfmKZcMKrp
   /G8kdy3ku1uiGTWV/Z31rHr2swmGDaohvXZaBAUI4VP3VTjOhxdInpOhH
   Uzb2UrOTjGqQSfiXWb5MKULInWAfW1qcWHTxBi+EtCZ0YFysTqT7IzW3k
   YQr+0LvShzYH0QF+M23F3QyYT8pyL8Yul6tVi4lXXdU3waiz3NyRlzYC0
   QPZaciLv65VMf2QZV4bgjeqhX4of5bemVYQifNpCQhbCQ7DFaINk+MdwO
   w==;
X-CSE-ConnectionGUID: PhKVrGAxQQOMEXm1aseN8g==
X-CSE-MsgGUID: 8p4C7daaSj6T/MEcINRK7A==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14913464"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 18:42:13 +0800
IronPort-SDR: F2s4IIMSa+sa6VdhnyrPOZ4plzkW1qO+UjWRWZeZXfmspyWRXluFy9aX9dWuOL2Tzh0zkfHLOQ
 8bqJg7yy0YnNNHLzbfdueBObuNZ91fLu/m5S+SA33s3dWmjUIqspee7PqHEMNbVbUdusL1Os3Q
 OHbFk3eMnSmAChPW6eZ6Zg0vmmhL0SVuOSV25xnYtlGi2gRBox9E0GjL4mPYPJFWmskkDTPb94
 R9wjomGGXU0tY7pSH+3AUWHz7k2O/JtxMqiZutEvMhsyKxlkKP3VVwnfymU49gLfbzy39ESy6I
 0rc=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2024 02:44:51 -0700
IronPort-SDR: 2lueZgCJKeUgOK1iCvOdv3rtDN0qEyJDam5qcH2IIBDzHsgoBZvkQdoKLeENNXMTgu+l+hfPLD
 90eiTc2LV5LRzQ+tHnPEQUYCPVxSYD8Ue/3W7bP4oikLs9RdY9DQWxuALWGqecIcCUB3EdlG4/
 l3CSbHV2XVYDC23NGZFeWUZECv4OUGXN5mDRKg0lYF2LQt+6ReOaqaoGsJLFTbmAvaGtyh/G63
 7HrNJV4VSZgWDYhYZKQYGGtsqa60AggHRIGo0SI38EmC/Ex55xTpHJSMkJW9ZJnARtx5LG+iyo
 owA=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Apr 2024 03:42:13 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: nbd@other.debian.org,
	Josef Bacik <josef@toxicpanda.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 2/2] nbd/002: repeat partition existence check for ioctl interface
Date: Wed, 17 Apr 2024 19:42:09 +0900
Message-ID: <20240417104209.2898526-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417104209.2898526-1-shinichiro.kawasaki@wdc.com>
References: <20240417104209.2898526-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When nbd-client is set up with the ioctl interface, it takes some time
for the nbd driver and the block layer to complete the partition read.
The test script calls stat command for the /dev/nbd0p1 device to check
the partition exists as expected. However, this stat command is often
called before the partition read completion, then causes the test case
failure.

To avoid the test case failure, repeat the partition check a few times
with one second wait.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nbd/002 | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tests/nbd/002 b/tests/nbd/002
index 968c9fa..8e4e062 100755
--- a/tests/nbd/002
+++ b/tests/nbd/002
@@ -21,6 +21,8 @@ requires() {
 }
 
 test() {
+	local pass i
+
 	echo "Running ${TEST_NAME}"
 	_start_nbd_server
 	{
@@ -64,7 +66,15 @@ test() {
 
 	udevadm settle
 
-	if ! stat /dev/nbd0p1 >> "$FULL" 2>&1; then
+	pass=false
+	for ((i = 0; i < 3; i++)); do
+		if stat /dev/nbd0p1 >> "$FULL" 2>&1; then
+			pass=true
+			break
+		fi
+		sleep 1
+	done
+	if [[ $pass != true ]]; then
 		echo "Didn't have partition on ioctl path"
 		nbd-client -nonetlink -d /dev/nbd0 >> "$FULL" 2>&1
 		_stop_nbd_server
-- 
2.44.0

