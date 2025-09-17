Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B201B30C34D
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758109764; cv=none; b=Q4MIDr1iyYvK9m3PR6gSEBeprlZwXjVBRwncSlO+v7NClKJpJSlf+j2P1Kn7ux55rVcP2H3RW8LlnQZcJctk0S4Sg1EkOs3WUda372NIFOFBZE5SiRWZDHjNTPMyDOgvhON/gNZrPak42Ox8Stz0MyeGqy24MJvPv2A4vrIMVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758109764; c=relaxed/simple;
	bh=4tHBvm8dB986I12RvGRb6C8MH9oHXeq5VOgaS0PRRTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=msbIJzsjyoa5qQMgQ40ybMQ061QVNrZf0cveGb77DILetKWsq1L7JL/Iz3P9tiAXbXHBiySneq2in/1BSo3Wah123m9veye2OBrNR6J+YKF55Junh4UsgN/4Caq4v1CnYj4t0TME4JzaQCiimXM2iN5tpbDz3icvZSvs0f2kKtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EONDICgX; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EONDICgX"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758109762; x=1789645762;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4tHBvm8dB986I12RvGRb6C8MH9oHXeq5VOgaS0PRRTo=;
  b=EONDICgXepG1rQza+DQLw/qULdirGmSwdl2fkGp/AByX88o+3Acry7iu
   x3wl/p2+Y4QkR3WlD/ZaoM6K08dPscJHdr/TvHG/c/kFFTOXqKZbxZkE8
   3e/oai+xOj+CKysmn99/K89oBnqNh/WNG+r1hFPrxXoKtaajTG+eqP6/a
   YAlEdLWTMDL8NO0UzvkZCQdknKbiPx1e2xQYnz0cWMXg4Oa+GCyx8HW81
   k5F9wIv+mOfXddEAGkYp9aorAleLs8qAT0JBaZKiAc3TYhjHPxjukeQ8H
   RuAeFKU75dhsqiYEnZl/M7EuZRrwc1FOsCmFyJ7/9oDqC92k6eloKB+1J
   g==;
X-CSE-ConnectionGUID: 1fjvMpimQeS/bGThfF6e9A==
X-CSE-MsgGUID: P8aJteAPStaU9U23mH5Myg==
X-IronPort-AV: E=Sophos;i="6.18,271,1751212800"; 
   d="scan'208";a="122448497"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2025 19:49:21 +0800
IronPort-SDR: 68caa041_BOfoVgJnuZXBtFOXwur+H+oEvMlVv3D85U7Q5w0TbRXBmkI
 G+NHOhM/hSOWWok7xVzxE2M6iD+6f6uoI6C9PuQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 04:49:22 -0700
WDCIronportException: Internal
Received: from dr34yd3.ad.shared (HELO shinmob.wdc.com) ([10.224.163.71])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Sep 2025 04:49:21 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>,
	John Garry <john.g.garry@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/5] support testing with multiple devices
Date: Wed, 17 Sep 2025 20:49:12 +0900
Message-ID: <20250917114920.142996-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of today, each of blktests test cases implement test() or
test_device(). When test() is implemented, the test case prepares test
target device by itself. When test_device() is implemented, the test
case is run for one of the device in TEST_DEVS that users prepare and
define in the config file. In other words, blktests test cases can be
run for single test device prepare by users.

However, it is being requested to support testing with multiple devices
prepared by users [1]. This request was made for atomic write tests for
md raid with four nvme devices. To run the test, users need to prepare
four suitable nvme devices and specify them in the blktests config file.
But blktests does not support such test with multiple devices.

[1] https://lore.kernel.org/linux-block/39c9f89a-6e6f-422f-88a2-3b2730b659a3@oracle.com/

To support testing with multiple devices, I propose to extend blktests
framework. Currently, each test case is expected to implement test()
if the test case prepares devices, or test_device() to run the test for
the given single device. This series introduces another function
test_device_array(). It also introduces an associative array
TEST_CASE_DEV_ARRAY that users define in the config file. With this
,users can specify the multiple block devices that the test case with
test_device_array() uses.

The first patch is a preparation patch. The second patch introduces the
test_device_array() and the TEST_CASE_DEV_ARRAY. The third and the
fourth patches update the documents accordingly. The fifth patch adds
meta tests to confirm the functionality of the new feature.

As always, review comments will be appreciated. Thanks in advance.

Shin'ichiro Kawasaki (5):
  check: factor out _check_exclusive_functions()
  check, new: introduce test_device_array()
  new, Documentation: describe test_device_array()
  new, Documentation: improve descriptions about TEST_DEVS
  meta/02[0-4]: add test cases to check test_device_array()

 Documentation/running-tests.md |  27 ++++-
 check                          | 173 ++++++++++++++++++++++++++++++---
 new                            |  12 ++-
 tests/meta/020                 |  14 +++
 tests/meta/020.out             |   2 +
 tests/meta/021                 |  15 +++
 tests/meta/021.out             |   2 +
 tests/meta/022                 |  17 ++++
 tests/meta/022.out             |   2 +
 tests/meta/023                 |  17 ++++
 tests/meta/023.out             |   2 +
 tests/meta/024                 |  13 +++
 tests/meta/024.out             |   2 +
 13 files changed, 276 insertions(+), 22 deletions(-)
 create mode 100755 tests/meta/020
 create mode 100644 tests/meta/020.out
 create mode 100755 tests/meta/021
 create mode 100644 tests/meta/021.out
 create mode 100755 tests/meta/022
 create mode 100644 tests/meta/022.out
 create mode 100755 tests/meta/023
 create mode 100644 tests/meta/023.out
 create mode 100755 tests/meta/024
 create mode 100644 tests/meta/024.out

-- 
2.51.0

