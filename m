Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB23B154451
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 23:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471761; cv=none; b=VV3954KK5U5gkdoI3dTMYykaUzAz1vUEBHcKlM1TdVKbx38jkuG+NeAEaldu8dyBYZNBpOr8OZYtdY4aGowtDpbsFbCS/SwH5eSQTixRPYwuvPbvz8UdVuvu4Bh/IfBrpipqlIhYiQJaS8zsdmiun/mD6JKVXkTtR4+Jhx0z834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471761; c=relaxed/simple;
	bh=XjDnNvLFnTr8MBnSjeTz86l8/+tXMc65nUaY6XjwILI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U0HAUR/yv88AZyQx/xZnpBTNYfOOOkJK937abt019oAQB1JtLi+x4pH2aX036FOUZ1UbcLvrKyiey4ybtmJFkggap8LHriNTm4khkupv6xaQC2b6sbQHeCLk6SAIvo7aM9WNBk8KjFd1HrzyLk4htZYl7EVGSaNP3cL4KStfNjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=chdKGdin; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="chdKGdin"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41KKXcGL004113;
	Tue, 20 Feb 2024 23:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=bqGCULEBWiOTsXd46lhnk+JCijZWOS5tGdu1mCkkVVM=;
 b=chdKGdinGEbGPd8U2R/wizhhGu5B0kkT7of5YhPF5dcdGKQo1zAvvj0zgULaaCyxS7bB
 rycVL8yUqHVoUBpXz3By3MVlNvdn6WVW1D6hR/7XxLi/nxT9CoKGoenqVgAirMu3Ats2
 JTen7oBTcIFrhf6SL6pczeMIPpRFp8iBGxC75RkO+/DqxUiG+OdERvX5khk5wf+aAZ/B
 xlX05BJ9BMqu+ZxIFbj7uMebEbyuzQawRQW5JXs2UdcEHTl3KePf+Z+I38Nci//VsYsA
 i55JT/C8nKkocHHP4Diqw3bX3LGlyu1i0hPuYCUjG7V23EmMTEdkDLm7IYY3BGobdPak bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakqc8bfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 23:29:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41KN3woj006646;
	Tue, 20 Feb 2024 23:29:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak88b8cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 23:29:15 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41KNTFFN021792;
	Tue, 20 Feb 2024 23:29:15 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wak88b8c5-1;
	Tue, 20 Feb 2024 23:29:15 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com, chaitanyak@nvidia.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests V2 0/1] nvme: Add passthru error logging tests to nvme/039
Date: Tue, 20 Feb 2024 15:30:41 -0800
Message-Id: <20240220233042.2895330-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200168
X-Proofpoint-GUID: RR6VnzOfvjebOi04zV0ojA82cVV4mBhI
X-Proofpoint-ORIG-GUID: RR6VnzOfvjebOi04zV0ojA82cVV4mBhI

v2: - Pass namespace (/dev/nvme0n1) to nvme io-passthru rather than controller (/dev/nvme0).
      This resolves a issue when testing with multi-namespace devices.
    - Only run the passthru tests on kernels 6.8.0 and greater.

Alan Adamson (1):
  nvme: Add passthru error logging tests to nvme/039

 tests/nvme/039     | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |  2 ++
 tests/nvme/rc      | 37 +++++++++++++++++++++++++++
 3 files changed, 102 insertions(+)

-- 
2.39.3

