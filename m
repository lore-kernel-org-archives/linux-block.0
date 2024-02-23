Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9A182D81
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703968; cv=none; b=jXqzAmi/m5Xp682HTxmv+OqaW3WsZqU/+3uRuRuae02ymuHbrUg9W7qmQrAb/PzE1kCCXQGcC963UgGZZpbzkyU3on+xkuVWGwpQn5UpUcFpSCXylphRb0ItvzCU/5dbzMB0rVkjwRrY4ZZxIRsL60FTm+EPO/gYIVq2mh2Wics=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703968; c=relaxed/simple;
	bh=Y4Qv0Ryn8M940ad2Ttnt2ZEB8nPtjitKR0zZjXkfdjA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YucnST6UyUSia0TfXXklFeCNITbLdGlKyEbNNmJfl+sGsY5cHRa1uCd57Rubbg+abmMN0vjyg2Ypl/iHepXk6o1Dp7tHu07wm4uZFGNDs1sPj2uDOOxq8w8oVLYm6Y4z4UXp3rcDaHCG9TAOOBaILWhgdXpw9KGKsFpZ9CTRyBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FJbqOkVY; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FJbqOkVY"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NF5P3s021692
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 07:59:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=EJn8gal7/WlJIZYk7CPkBp0tSDR5oN4QowIZWHzXe1o=;
 b=FJbqOkVY6av+1ETEoX4TaGt83xohq02V2zJSV150wSh0yDvOnY8CU6rzRoPuvsY8ozY8
 NcntQ/kKBG9w5bJp89eEhqClYp5mocd/TuG4g9sS38bU1N7g3UYhCZh+9k7iCKN8ttjU
 EIOeII1eZc57NYV1j3TYoI8HF7WWzWtc6smn6W/dYxeEKeL1tfD5LZb589+vIjTYO4EK
 jpuE4K2OpSvkzt8xRM+SnYVj2tkAtt1qmILwfpm16KsBpsgGdphCr0on6vnHRxev1P/P
 D/s8Tbvq6FPKTBSR00dhSa3gVfy9CKVrtEC9w4OYTA851wV8f+AV+aCHEl+wz611895h Hw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3webyke4e6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 07:59:25 -0800
Received: from twshared9513.02.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 07:59:23 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 998932574FA3F; Fri, 23 Feb 2024 07:59:12 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>
CC: <axboe@kernel.org>, <ming.lei@redhat.com>, <nilay@linux.ibm.com>,
        <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 0/4] block: make long running operations killable
Date: Fri, 23 Feb 2024 07:59:06 -0800
Message-ID: <20240223155910.3622666-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: OPd4pStd-vN3DOZelXzmViaHaPqrgvGr
X-Proofpoint-GUID: OPd4pStd-vN3DOZelXzmViaHaPqrgvGr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_02,2024-02-23_01,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

Changes from v3:

 Added reviewed and tested by tags

 More formatting cleanups in patch 2 (Christoph)

 A more descriptive name for the bio chain wait helper (Christoph)

 Don't fallback to the zero page on fatal signal error (Nilay)

Keith Busch (4):
  block: blkdev_issue_secure_erase loop style
  block: cleanup __blkdev_issue_write_zeroes
  block: io wait hang check helper
  blk-lib: check for kill signal

 block/bio.c     | 12 +--------
 block/blk-lib.c | 70 ++++++++++++++++++++++++++++++++++++-------------
 block/blk-mq.c  | 19 +++-----------
 block/blk.h     | 13 +++++++++
 4 files changed, 69 insertions(+), 45 deletions(-)

--=20
2.34.1

