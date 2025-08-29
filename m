Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01809320392
	for <linux-block@vger.kernel.org>; Fri, 29 Aug 2025 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477401; cv=none; b=gV0yigtAvYPvoR+5qnrBe+9DFUO5tSKhvlITp3MVuoY8UmC5IQHEGExVi6vi8BweXK05QGYTzZx3Rj+2HlKB4sRUsuAN5B54OfWwoCMQcc0EO+5/V6Oj1c88Cr4uq+JdzV8ZmhJdPIPf/uTruJqaum14VKZ4TdrnzotxA6C1rVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477401; c=relaxed/simple;
	bh=B6d7Ei7k9UBcROB4LTIyzotOLSl3gEhIRX1Ty1BACC4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k9TYqpjWQeKXnjUy7IoyaZLzinlszEFrfcfNU+biNQrtsgaPt8d1rocsNfUbU1dAnlP8E7Q05gEfQB1/FZDI2FD5WpkWpKoxPYRUi0cFuna4tEFg9T2BGGGjTIk3HlvVFuKDh0uhRACMZUJZ8Sq2Xp4ZuV9AoLtxrTY5WBEdZnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SWw0kCzk; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SWw0kCzk"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57T8ipbN3730783
	for <linux-block@vger.kernel.org>; Fri, 29 Aug 2025 07:23:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=PYvMXTL/L8wQ4W0lq8
	RrjJ8AdQQN2IpzN2ellUDipiI=; b=SWw0kCzkbtdFY+9Qliofm3RHRg+Waqm2TB
	Rfd8s9zK9NGrixoYycr0K7SudfK66WhIGHJH6q5T7s/QIHTts2dBEFaPp3XeuV4j
	S2wm9XwONM2IbiA7AvMMVYsGuPmPxeTMuslKcWmkTKYgD2G0WBE8TuNIH7POBq7s
	ZyS3VhNM8EWo0y8miTy0N6u/FPoM+ttQtpzzO52Fl8TmFvU9J8WsknzK6ItEjXhE
	OP8xMMUVGwh+uyQM3K1Zuo8yURgBSP1f/Uz0ioxxjrBdeQ1BPCy6fsYJG3vIFEer
	khr5Icga89xLe5t3Tx7ivDsPKeFWgxEPwadurTLWLxJKRfU+xWsA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48u54easbk-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 29 Aug 2025 07:23:19 -0700 (PDT)
Received: from twshared21625.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 29 Aug 2025 14:23:15 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4D48811FADB5; Fri, 29 Aug 2025 07:23:11 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <axboe@kernel.dk>, <martin.petersen@oracle.com>,
        <jgg@nvidia.com>, <leon@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/2] blk-mq-dma: p2p cleanups and integrity fixup
Date: Fri, 29 Aug 2025 07:23:05 -0700
Message-ID: <20250829142307.3769873-1-kbusch@meta.com>
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
X-Proofpoint-GUID: tqwRAg5y-JrtQMCjyI-3YW5ma5UoIC2x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDEyMSBTYWx0ZWRfX0jv4X4Ofxz+/
 bFj2VLMPTSIW4BtloFUV1ah7IxNTvAPfjZXLtBndkl/EK1A1k08/FISexnNGIJtniN5AjRmuJMR
 T4TOZrYdBpLJ7rlAbYQDlgiXGEsjyhDpnOZlh+CeR8NWITmyxyVMDrVL2q70UGzWrS2C64EE6Ee
 1R/osJT8j3PnBgo4vZWs9wEzoKaGDBqKP9M0+AP1Fcn9Okp7NMOthphZVPxGBPmrqvcWozA0sip
 mkJSKvNHXTblzsmMoRAEkldKpF243LEdOIIu2kineD4hZfdPgGPU6BFSlmnhOq30ABK7cPBVy6o
 x6l73WTVlVVIk1jJMmngXrVx7VKEvKKCRi8cPYfaSIIhnA/ZqIfDNt4cf0HgNg=
X-Proofpoint-ORIG-GUID: tqwRAg5y-JrtQMCjyI-3YW5ma5UoIC2x
X-Authority-Analysis: v=2.4 cv=MeJsu4/f c=1 sm=1 tr=0 ts=68b1b7d7 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=An7AkMqwXWfVQp4ObIYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_05,2025-08-28_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

After reviewing and discussing with Leon and Jason on some of the
proposed updates, it became clean that having the callers track p2p dma
usage doesn't scale, and we have a convenient way to track these things
in the existing structures anyway. So, thank goodness nvme is the only
client of this API at the moment while we work out the kinks.

While looking at it, I also noticed that integrity wouldn't attempt to
use p2p pages, which I think was simply an oversight.

Keith Busch (2):
  blk-integrity: enable p2p source and destination
  blk-mq-dma: bring back p2p request flags

 block/bio-integrity.c         | 21 +++++++++++++++++----
 block/blk-mq-dma.c            |  4 ++++
 drivers/nvme/host/pci.c       | 21 ++++-----------------
 include/linux/bio-integrity.h |  1 +
 include/linux/blk-integrity.h | 14 ++++++++++++++
 include/linux/blk-mq-dma.h    | 11 +++++++++--
 include/linux/blk_types.h     |  2 ++
 7 files changed, 51 insertions(+), 23 deletions(-)

--=20
2.47.3

