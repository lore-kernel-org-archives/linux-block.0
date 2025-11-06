Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE812144CF
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 01:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394123; cv=none; b=EcZ0VY0NEhcpo9Jukqd/CgH+zDVDCPtX0ymHpAgEEe3vArBEAr1iYVZ1emc3IYCDGJM/C735/3xxuJMY6LHRyrmFjDP/IUiuSF1MWfqvLzzZJxIin6mESQ1FZR4320Kxr+KJe0tXNXDKxcCcDy3BTAzx6+anMpxXGohg6XLPpLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394123; c=relaxed/simple;
	bh=bzTDQQeEDwGfIH2TlpQgnmMSatjAKVe2zaCoefl3bg0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a11amN7TPHl6snFBOdhTriVRNQliVQ8DMMOgUev8WpWpQ/XqRzsCVydQEdMTKQm3LuRKf/m6Vj8fi8ILGuPcLVUIyzHurVmYxJtR1ka3oizLsMX1VHTq4D2uSZ9vLZI5ddjG0DxHQeSAvceGxkWIRKgsiADO1PRO1Ue7aXVNlXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Yv9Qp1Oi; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Yv9Qp1Oi"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5MuCZT1771731
	for <linux-block@vger.kernel.org>; Wed, 5 Nov 2025 17:55:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=17NDB7W+4dqBTZiYQF
	jAm67W1EfHBKIGhr+Vz+VRY/s=; b=Yv9Qp1OiUmAYHEt/Cq1Plbr1ZMJnv216q2
	8JJlm4YFxSQ+YwSGU6dVBfvK3wgoZ+bcf6esarkfV1XMnVxrfjr8HgHGS4OK5oKP
	JRTw58u5vAu52O1BaD1EIRKUr6FBBEVp/VffaFI0VVfYKgcRMjPDkDscxGABR581
	2lFR+MvYRvSCzmBsHpacxgzeBnuDTvMHkjdTFnIsbXDUnebOc0yS5j23fobgVcNX
	cwOJbRZ1AvxA3yCJxnrWwZ8bWeMK7tIwA26XnmXpgq2qlnmd1q75hi66ABZq/m3c
	X2SaVjZL4lymeSlhfCzUV5uzZvRJ6WCNDY1vxpImpA+ieRtJIRdQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4a8ftj13bh-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 17:55:21 -0800 (PST)
Received: from twshared125961.16.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 6 Nov 2025 01:55:05 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9CB403789B1C; Wed,  5 Nov 2025 17:54:55 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <hch@lst.de>, <axboe@kernel.dk>,
        <dlemoal@kernel.org>, <hans.holmberg@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/4] null_blk: relaxed memory alignments
Date: Wed, 5 Nov 2025 17:54:43 -0800
Message-ID: <20251106015447.1372926-1-kbusch@meta.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAxNCBTYWx0ZWRfX1SUydhtD1zmp
 R9aGMGAwVtsuP9jt1AVRrxvZg/7pQO1ie4YH/OvawXt8d6J6/mKve3RqHCge9VLcjX3zlBg1fDm
 JzG7lzO3Ka5CVzFii7JXmgBj910Dyn6wftWRI8HKfh8DdJdcsi5Y87VJyXiSAlEFTFaDV8ZxKny
 K9Hmq3yiKTqOiJhyAx8Lamhqz94ipSATfJ0Wq08u3bBJXLaZRBqnP6lRrnxJOCNBSw6amDBAzbq
 OfjvM3PIfxL/T9jFexAdEu1/cXNkw23tmWRBMTQC8xA0rTgZoRlGmsi8lyvsEp1DulU04pVbt1K
 ZtEHzpKu0bdCltsn30UePyEKV0IoUswlZrbOai7q2aDimwQ5YAH5JjKQYqBrTSqfSZZrZ4o/Ubb
 B+isAWme0XdtiwDOL5uT5inaC2HgfQ==
X-Proofpoint-GUID: qshBnF4g7uOmm6V9SwTNKzDML6cWFwvo
X-Proofpoint-ORIG-GUID: qshBnF4g7uOmm6V9SwTNKzDML6cWFwvo
X-Authority-Analysis: v=2.4 cv=HIHO14tv c=1 sm=1 tr=0 ts=690c0009 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=tGGrF7m7fe9u9NsC7MAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

The direct-io can work with arbitrary memory alignemnts, based on what
the block device's queue limits report. This series enhances the
null_blk driver by removing the software limitations that required
block size memory and length alignment.

Note, funny thing I noticed: this patch could allow null_blk to use
byte aligned memory, but the queue limits doesn't have a way to express
that. The smallest we can set the mask is 1, meaning 2-byte alignment,
because setting the mask to 0 is overridden by the default 511 mask. I'm
pretty sure at least some drivers are depending on the default, so can't
really change that.


Changes from v1:

 - A couple cosmetic patches to clean up some of the error handling, as
   noted by Damien.

 - Fixed up the buffer overruns that Hans reported.

 - Moved the kmap'ing to a layer lower in the call stack as suggested by
   Christoph, which also made it easier to fixup relying on
   virt_to_page. This part of the patch is split out into a prep patch
   this time.

Keith Busch (4):
  null_blk: simplify copy_from_nullb
  null_blk: consistently use blk_status_t
  null_blk: single kmap per bio segment
  null_blk: allow byte aligned memory offsets

 drivers/block/null_blk/main.c  | 77 ++++++++++++++++------------------
 drivers/block/null_blk/zoned.c |  2 +-
 2 files changed, 38 insertions(+), 41 deletions(-)

--=20
2.47.3

