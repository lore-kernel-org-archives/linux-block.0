Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D7F34DB60
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763582100; cv=none; b=S23xsPCOqS5URNq5N27VL+Gjw63/0UtHoAF5mv/a7IZdMF8xzrc1+BXaSDI66JiP3QrR3ngnztbMm4v4o0t4Tk94k/SRqdB0pl1X0zStm0iSS5LNeEvO+rz/c17bxtIsBIkT5pzlGsVb8EssNgX9eemJ/eBVQJSX4hWS1tbaF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763582100; c=relaxed/simple;
	bh=/Chk2oofry7zWutNDXDMffilc4lYayBndbg9RqwG92g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uGcPRTh/Z3rJWan2h9HE3kf9f88SMTAYaUlS1Zcwy8BRz3VI+QoC2xdemI4Xbrs79Fd8Z8PVVNCe3st9b4xBsBkNCcohDHKfya8UHP+/2EJrCMsspTvVQDAWfQp9Ndmqiue5vnSoMyNgZEO73XduFJgojvgUSqI8i12FyFXBl50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BaTsDIw3; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BaTsDIw3"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AJIj5D31987960
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 11:54:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=hOR8AAz7/98yC5u1n/
	52PFAsKkwZJw9rTiVkW29Otlk=; b=BaTsDIw3INJRmo/mC9nAQuQZGP5DMNMUjK
	8lgFXS18m368SKIHXNrwgWD547HKvnnHysrD5yu7E8Pt6VG73rQsvPKdSSNJNLWG
	4wJJaSg81vLqg97tQy6aW+qesipFcsJjjfBqIgiG7AjcCg4xqjrBGP9y32hV3S56
	73nlPACGGqBcg9tYuw4dHEMVwnS6mlRugsU7n5i4MwJ4dnxsmHF+20i60namgrvJ
	yB+lXp9wOsREuaC9EXEHM+ovUoM2A9qUUmwMSPcDntGXNX5Vjg48DTekGV1HuqQb
	+l2bb2nhUxzDD6rAaBbc0/995BxZb0CTGMTXqcbj+e/p/qZlz6qg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ahdv0buj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 11:54:56 -0800 (PST)
Received: from twshared13623.02.snb2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Wed, 19 Nov 2025 19:54:55 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id BDED53F346F3; Wed, 19 Nov 2025 11:54:50 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <shinichiro.kawasaki@wdc.com>
CC: <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/2] blktests: add tests with offsets
Date: Wed, 19 Nov 2025 11:54:47 -0800
Message-ID: <20251119195449.2922332-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=F4pat6hN c=1 sm=1 tr=0 ts=691e2090 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=u-cNn51Zlx4kbbw4TL4A:9
X-Proofpoint-GUID: SWPl_nWJDszvbzrOwiaAZ31nLSx17SZQ
X-Proofpoint-ORIG-GUID: SWPl_nWJDszvbzrOwiaAZ31nLSx17SZQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDE1NiBTYWx0ZWRfX8nRlMi8CI2WF
 yvHPXWd0L1c9erJ/XJHlI3MPhEnrDiJJuxttw4IJwzRSCKR5q4oFxG2rQ4MRcwozONHZAirS39v
 lU2PosOXJ1moqZvkFp3Zw8OxoaB95Xc6OE/+yEJsSleWI6RimqLMq1Mb+e/d4gOrY9/9LugApyz
 YasAeykvW3fArRMuFuPRmaVWvcdMmio33XnZmmvCWsXm8lGa8eDhPfU34PHtwqW+Z6okRRIPN8Y
 zui0Bkj4a3epuCRSKnqMcl0/TGfTMHRcIChCtTZrpL6uJNecdao+BRjAkBtgjvLKLaI1t4VX6Cx
 hZxvhlbrf6mU85UV2Cdz5AfeOgRAjTuOPZAC0MriDSB8dSq34Q8bEP0dYAJ1x+Gkk7qNeqz6nNs
 Gcv8eExis9t/JRc4A+FtgVhtlVDLPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Here are the tests I've been using to check the kernel's handling for IO
using non-block aligned memory offsets for data and metadata.

Changes for the previous version:

  - Combining the io_uring metadata test in one series

  - Removed all the extra code that tries to discover the queue limits
    from the file path. The test case will simply pass these through
    from sysfs attributes that it knows about.

  - Removed the linux kernel version specific checks to decide if a test
    should pass or fail. We just assume a failure means the kernel
    doesn't support it and carry on.

  - Fixed up the test dependencies for the metadata test, and wording

  - Fixed up requests from previous review comments.

Keith Busch (2):
  blktests: test direct io offsets
  blktests: test io_uring user metadata offsets

 src/.gitignore      |   2 +
 src/Makefile        |  17 +-
 src/dio-offsets.c   | 708 ++++++++++++++++++++++++++++++++++++++++++++
 src/metadata.c      | 488 ++++++++++++++++++++++++++++++
 tests/block/042     |  26 ++
 tests/block/042.out |   2 +
 tests/block/043     |  33 +++
 tests/block/043.out |   2 +
 8 files changed, 1270 insertions(+), 8 deletions(-)
 create mode 100644 src/dio-offsets.c
 create mode 100644 src/metadata.c
 create mode 100644 tests/block/042
 create mode 100644 tests/block/042.out
 create mode 100755 tests/block/043
 create mode 100644 tests/block/043.out

--=20
2.47.3

