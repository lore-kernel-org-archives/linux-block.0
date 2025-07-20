Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5C8182B4
	for <linux-block@vger.kernel.org>; Sun, 20 Jul 2025 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753011380; cv=none; b=D+KHsCLnh1ktlMBIDJ0tdjv7ISz23sEhxl/fa/OyAKz99jAsyQ5GWDs+dLvc9J7gWkIjZ/oXbXfO7olh/0yFPqAW2JjctoqjIMgp95xYaTW/h3R8unjdAG32Navd/uVxD1TdOUys6l8sAQhxEyBRzb04+fm7C4lYXtrf9XKQfKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753011380; c=relaxed/simple;
	bh=JUgX7RvsyZlpv3Mpk4rVbk9Tsujqby1e47HFjtPJwn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JV0r3wgqLfCDBrGvGCXcOHv+aUT32dpw5FHFBkiD0YokPQbU6f5pS9YroPwCdqivAsLhD15GyESLizlodHsQjIqIX/I8jUwgr45hg+CmsadT8El49FfE1Nincz+i0ZLyW4ec2YbOatEI4WZwDlmEvcaGgeVl/oXJVvaq/yagU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M0Zu0vbz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M0Zu0vbz"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56K9OeHT021848;
	Sun, 20 Jul 2025 11:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=LzpMp/rT9OrUs346xpPmfL/J1tef
	KBrxXujpCxa+Onk=; b=M0Zu0vbzYljFSLspEPWin0mIHN5PRVy9g/q56UPp/TN1
	P7xGtGirolkhlbzkK9Q7Jg2+O+OnAUCdrKmUXJGZmW1XftvcDaE30lauzWdspD85
	eVi1bcJ6GJAC9BbfEx+FYxs/5S+SID4fcbSUFdNpzT1lEdrpT16cLALM6kFRHrt4
	0iAHAq7k1xLtFeUOyIzWhHCaceqIAYvSKlwqlR8ETqplb2nWt76C3N5VadPyMA9L
	jYIJuqzgqY7ToOI+v4Cl0jUoEKA3FkDh+iRLo7GljVuh5C7ZXQJj3r1UZNU1ZvUu
	H2H14lhynaLQ6sC8Cwr1hJi52U2zSbEccscdETIYsw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48069v483v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 11:36:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56KB0A3O025138;
	Sun, 20 Jul 2025 11:35:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480npt9uas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 20 Jul 2025 11:35:59 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56KBZw6T48562588
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 11:35:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 382D32004B;
	Sun, 20 Jul 2025 11:35:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A00120040;
	Sun, 20 Jul 2025 11:35:55 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.22.10])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 20 Jul 2025 11:35:54 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-block@vger.kernel.org
Cc: hch@lst.de, ming.lei@redhat.com, hare@suse.de, axboe@kernel.dk,
        dlemoal@kernel.org, johannes.thumshirn@wdc.com, gjoyce@ibm.com
Subject: [PATCH 0/2] fix sbitmap initialization and null_blk tagset setup
Date: Sun, 20 Jul 2025 17:05:40 +0530
Message-ID: <20250720113553.913034-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QLdoRhLL c=1 sm=1 tr=0 ts=687cd4a0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=vN614xK3YunQ6eAN7V4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDEwNyBTYWx0ZWRfX0S8v5yeR11Pr
 S9Z97f/oou4352YXPBkpDhMBXjjn6eHFJtJxFf/CqTqlZ6DCd9grsLw3VKKNiZOWfJEtWlKsfa4
 raTOapo32jfkmoJnqYvtf7XBIDHA3eNSGJ3+i9lV/AhT8ziINjY/P6SJ1qWO1slGs0kpaF/SSdA
 a0T3IkYtkcWwha3OP7bTPuWw7PG+MGuWhukRJtbgWT9t6foE32LpxKxaxHWgfVfXHOO436whn6E
 B9sgNpzg46/jNj0JSrDTjbp4ZHDCf5v3Xr9z2QxqFAemUw5OrSlEWGTRyfFRF3wjcq2dzcfbT4r
 Pskn2Z2qqFdCr8ufk4Li3IzypVwEHU6iFphaHJxvD5p7goGl0oiDF5S5NiRea7XFJomaf9piTNb
 6ZKvT/CoxjqEDWpBeEshDJPQSDRdqKLyyJfwl/pYWLLamBaTSdNJUKFDxz3xPGXPU/uj39qf
X-Proofpoint-ORIG-GUID: dRCgJequXh-urryklxoi5bZp9qVqh63m
X-Proofpoint-GUID: dRCgJequXh-urryklxoi5bZp9qVqh63m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=95 malwarescore=0 spamscore=0
 suspectscore=0 lowpriorityscore=95 mlxscore=0 mlxlogscore=475 clxscore=1015
 adultscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507200107

Hi,

This patchset fixes two subtle issues discovered while unit testing 
nr_hw_queue update code using null_blk driver. 

The first patch in the series, fixes an issue in the sbitmap initialization
code, where sb->alloc_hint is not explicitly set to NULL when the sbitmap
depth is zero. This can lead to a kernel crash in sbitmap_free(), which
unconditionally calls free_percpu() on sb->alloc_hint — even if it was 
never allocated. The crash is caused by dereferencing an invalid pointer
or stale garbage value. 

The second patch in the series fixes a bug in the null_blk driver where
the driver_data field of the tagset is not properly initialized when 
setting up shared tagsets. This omission causes null_map_queues() to fail
during nr_hw_queues update, leading to no software queues (ctx) being 
mapped to new hardware queues (hctx). As a result, the affected hctx 
remains unused for any IO. Interestingly, this bug exposed the first 
issue with sbitmap freeing.

As usual, review and feedback are most welcome!

Nilay Shroff (2):
  lib/sbitmap: fix kernel crash observed when sbitmap depth is zero
  null_blk: fix set->driver_data while setting up tagset

 drivers/block/null_blk/main.c | 3 ++-
 lib/sbitmap.c                 | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
2.50.1

