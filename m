Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C83286408
	for <linux-block@vger.kernel.org>; Mon, 16 Jun 2025 17:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750095184; cv=none; b=Pw5+a9ur+PXdtIzV92Js4tXzRdbS51IrYr0fV2V3MyaqDIzecgeWxyw/zwR7o30E8G6XseeF27Hqxl/iAnYvlIqv6USfbfEHmXpwokZRVSoWeLff6Lw4N12PR4wX4SdKNd58Ls9rm3PY7LeU+6EbYgUCCouuEllMA1+rGZCZOPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750095184; c=relaxed/simple;
	bh=/Kwa98k5D1ZXwAY2eGajTQzbyXxwalbrdRsEB4rwhRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTtrl40d7IjVgdhAjSGO/FlxvzeFivkIaHhRuyXgHI976RPFN6slSuHySxTTF72TaCCwU3Nzd/49jnsSWcA721qh7bC+vcANJmgyeY9EIP7aZVdVtSu7AvUHViF3z5MaZYauukVmejnCiGXh2XdfLTy6BogN8EV8iQuIFzRDfUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eR9Wa2zO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eR9Wa2zO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G9XX7F026346;
	Mon, 16 Jun 2025 17:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=PkhURUDV64OFqSxaVYTwW+bH7KJeYE1z5KeUfgdcW
	Kw=; b=eR9Wa2zO1fe0OV2/a/1OdtP6KRGVER8hLw9K2awxLlFtuoqNx8UFrvcvp
	z78ZSg+Bsg8/xmJfSR2gVUtdsygICBAcm6aCm8lXjsiZUxMXaKWUtzfXFBgWahdD
	JyY1mkJyyD6diRsemDkSm709rs5lzcDlh4KODmBuTV1vlaZX9SL+OKv13FglD6F3
	4gVGV2AkaLCF2Op3fwkfSdM2hPGGe4RP2kbw1QY1TV7dLONP5xEn2l/XK0CvYgpd
	zk4ELpZeV4/bcWyk0l/xrQMHgzHn4XZIuTBK5hCBXyfshnkrpZ+yDUkboR9ge2tw
	K0/cz+EOZdHecxdmwjTOQmd9sjYdw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4794qp2aj3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 17:32:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55GDgiq9025751;
	Mon, 16 Jun 2025 17:32:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 479xy5nahb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 17:32:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55GHWsso55247318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 17:32:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DB0B20043;
	Mon, 16 Jun 2025 17:32:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22CAE20040;
	Mon, 16 Jun 2025 17:32:51 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.44.139])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Jun 2025 17:32:50 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com, hch@lst.de, axboe@kernel.dk, sth@linux.ibm.com,
        gjoyce@ibm.com
Subject: [PATCHv3 0/2] block: move sched_tags allocation/de-allocation outside of locking context
Date: Mon, 16 Jun 2025 23:02:24 +0530
Message-ID: <20250616173233.3803824-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FIcbfLNZYv5nWdR6m98HU2xChAw9Ku3m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDExNSBTYWx0ZWRfX6+d/P34e9vrg xXaiZQwfTu+FfYkWMS7HG9qwXk7r8ouLautIw6tETgYU+sM+fpeO5t7vKEoAp8jn1D6M+Eh5uKV +ps5Zj22RhWb09NiSCPb1fsaRyz2G7Rs5LbV0iNabfdHBgHXqZyjzCBmWwE5uS5HyMrY2RR6VOj
 90yjg1idRMpiR3oy54BEdgL+8UCYHJwBKCyb/Nc5NYP5n3/QmZWfjIYf8WUbkqUOAXZoXVIwndx uUflffLcSnwxEF/nw6ZTb4NR71KHtC0NwfnbDBe8CAS5Uray5+ncvex8xuwO/xR46qvAYZ7ia2O VdYBcQ1QINTdkP6LJHtgpx3COUikRW1k0A1Yv8p7NxhV1Q8ZU224trnphvOoxjgZwfc/ITd900X
 ZUklfq2ARN5xsm1ARF8ez3NearR2FJ79T+HNEGpCcAAb76pSlfsvPiLFoCszWlGNnsnagAE/
X-Authority-Analysis: v=2.4 cv=NYfm13D4 c=1 sm=1 tr=0 ts=68505548 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=QhzofUmWjwFfkCKzkbcA:9
X-Proofpoint-ORIG-GUID: FIcbfLNZYv5nWdR6m98HU2xChAw9Ku3m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_08,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 mlxlogscore=844 mlxscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506160115

There have been few reports suggesting potential lockdep caused due to
the percpu lock dependency on elevator lock. This patchset aims to fix
that dependency.

This patchset contains the two patches. The first patch is preparatory
patch and just move elevator queue allocation logic from ->init_sched
into blk_mq_init_sched. The second patch in the series restructure the
sched tags management code so that sched tags allocation and de-allocation
now occurs entirely outside of the ->freeze_lock and ->elevator_lock,
eliminating the percpu lock dependency on elevator lock problem which
could potentially occur during scheduler updates or hardware queue updates.

Change since v2:
    - Split the patch into a two patch series. The first patch updates
      ->init_sched elevator API change and second patch handles the sched
      tags allocation/de-allocation logic (Ming Lei)
    - Address sched tags allocation/deallocation logic while running in the
      context of nr_hw_queue update so that we can handle all posible
      scenarios in a single patchest (Ming Lei)
Link to v2: https://lore.kernel.org/all/20250528123638.1029700-1-nilay@linux.ibm.com/

Changes since v1:
    - As the lifetime of elevator queue and sched tags are same, allocate
      and move sched tags under struct elevator_queue (Ming Lei)
Link to v1: https://lore.kernel.org/all/20250520103425.1259712-1-nilay@linux.ibm.com/

Nilay Shroff (2):
  block: move elevator queue allocation logic into blk_mq_init_sched
  block: fix lock dependency between percpu alloc lock and elevator lock

 block/bfq-iosched.c   |  13 +--
 block/blk-mq-sched.c  | 247 +++++++++++++++++++++++++++++++-----------
 block/blk-mq-sched.h  |  13 ++-
 block/blk-mq.c        |  14 ++-
 block/blk.h           |   4 +-
 block/elevator.c      |  82 ++++++++++----
 block/elevator.h      |  30 ++++-
 block/kyber-iosched.c |  11 +-
 block/mq-deadline.c   |  14 +--
 9 files changed, 308 insertions(+), 120 deletions(-)

-- 
2.49.0

