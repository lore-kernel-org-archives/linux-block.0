Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C7585C44
	for <linux-block@vger.kernel.org>; Wed, 21 Feb 2024 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540529; cv=none; b=ZLkQTJpNb4LKgAWS3u1qhf0kQg6CoWD/QaQDf2ikSV8hVKGTWodJnD2bCKT/aNFXWch9hcBqqCyYzrGkjXdvrP11VrqwjtAGVeYfXO1UMEk8amOuv/x/EpoQOmrC/8AbrqDz56toK/GyjNhe4AFvl5KO3ZGX9B5qk6itbY5j7gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540529; c=relaxed/simple;
	bh=OX5GAn3nmmhaaz6jSSFLTjsiA8qpOHo9QFOCb5g/6EY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y5bYl9C3NMaSXg9q4W8toWmEbnSd/FKiX7Rc8hKY3P7KYwrqrj2OoxrxKadJXaBT5/seBpfUnB9WovLSZUjA1O5GvbieDASa9lF2vRrA7QEBg9K7Q+XQRWWf12mPOAiYFuHe65amyTEtYecw9ya3otRTjCGcXsdXn/f0gXxCPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ib5SF+CB; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ib5SF+CB"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41LDis74028029;
	Wed, 21 Feb 2024 18:35:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=UUhBWSekF8OvZS2OoisYMBdZeWjZOlz86uYctiuXbh0=;
 b=ib5SF+CBWbHoyVbyXexrU6qvP8bLDxnaqfrnff4a0qFefevw3fK/qCjPsdFPzhoUQQkr
 IZ00q8KAJ0kGZ7aphEEtsIUcc+/jWVusVnzJ2jsnhXiAD1vXz3+78NB6tZy9L0a/i4jJ
 U9TqNu/keaihNo1qETaS62lNMXo4r+qcbG0OiCiDvemKhbn13qn0wB15I7IeUjH9fFEz
 HnrEjhC1p/dflbhVo5yUwmkeLkbPiD5Ln80evg1UzytSaQAg+fjcyQFDPGmLR1oi2imu
 Ay0Ixc2OG2TN5hD0SGSWoINHDb1Q0zSWLMu7lU9ZhF0NRGzn5KVr0+CQmJkxsHVhunhV Rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk42ngs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 18:35:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41LIUEZM039655;
	Wed, 21 Feb 2024 18:35:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak89evgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 18:35:13 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41LIVkxd039971;
	Wed, 21 Feb 2024 18:35:13 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wak89evfs-1;
	Wed, 21 Feb 2024 18:35:13 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-block@vger.kernel.org
Cc: alan.adamson@oracle.com, chaitanyak@nvidia.com,
        linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com
Subject: [PATCH blktests V3 0/1] nvme: Add passthru error logging tests to nvme/039 
Date: Wed, 21 Feb 2024 10:36:39 -0800
Message-Id: <20240221183640.3432605-1-alan.adamson@oracle.com>
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
 definitions=2024-02-21_06,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402210145
X-Proofpoint-ORIG-GUID: 04_YxgoWM9t6p1JN5T1QGq9Tr3Xtr2NC
X-Proofpoint-GUID: 04_YxgoWM9t6p1JN5T1QGq9Tr3Xtr2NC

v3: - Use the availability of the passthru_err_log_enabled attribute rather than the
      kernel version to determine if the passthru tests should be run.

v2: - Pass namespace (/dev/nvme0n1) to nvme io-passthru rather than controller (/dev/nvme0).
      This resolves a issue when testing with multi-namespace devices.
    - Only run the passthru tests on kernels 6.8.0 and greater.

Alan Adamson (1):
  nvme: Add passthru error logging tests to nvme/039

 tests/nvme/039     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |  2 ++
 tests/nvme/rc      | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+)

-- 
2.39.3

