Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475955C305
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091278; cv=none; b=kHrtAvNWUBbpU6n7THvfwkkwaQaZ5hLsuNmorUrEZQkscBUgYiSm0SHkAolFg32T4Hx66lm82/rxwtU6I67826gS99Z2lIQbcHNDJRB6FovoelK6j+y55hvE7l4+4QkpH8fVJYW+rIHTZ88t/bJ04edH12xqHAnvws4W/CgmcZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091278; c=relaxed/simple;
	bh=LuiaBeSD0IBnKnMQwy2MeH+wYKQ4HMIUxgxd4XXEt50=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l76kWYh+ThcmUxiEDDI4lgoKPY0/OnOpGPxsMe0hfsLv+cBVJpdc9DriaPSCM9Yf/r8hUL2U/8sMUue8Eie1uLhXkV9pqRQo5PzGaC68Id112/1lsTIowkMQ+bFevbNKdezhvm9hp3Hnd10KItcxEbhgAx8tentYmUmM4CO6nVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Gc13Dmh3; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Gc13Dmh3"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68MF2Np72373682
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 08:34:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=l2zHm5Xj3
	0UEAOy9nk3DRA+Kvmm8ZO804nBKRhqtn60=; b=Gc13Dmh3rdvnXajo5nIwwIXz8
	9FnjRmsuVSRd0KGYUGyoZ7rCnbIbUdLcLOVvH4LL6bElYcfmhY2TFzYwewGwDA++
	NEtFrP8ltQNvufJ6007FO0mrH+1YG3NXp8dMX30qr5DmmyzkBG+JS88CqIodv95c
	6//rXrJIW4S7Zn8OnUUOjH79jn2XyXf+GW9LfX628SGeLJCqAf7aKT/ZSwUT3fGu
	7sM4CPSSLVFq4K8WCjZCESbdNCoEguwI3lyD4XtiTt9PTVFYJAV0kMWKXVzQ/n5+
	UdhYfICtqNDLXdDulmhjY7F8d8nECYizpJNVVkMPPoO/ff6EXRAmh3QXCwMfw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4gsp29eryq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 08:34:35 -0700 (PDT)
Received: from twshared123204.16.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.49; Tue, 22 Sep 2026 15:34:33 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 07E412C3C65D8; Tue, 22 Sep 2026 08:34:17 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <dinguyen@kernel.org>, <schuster.simon@siemens-energy.com>
CC: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <lftan@altera.com>, Keith Busch <kbusch@kernel.org>,
        kernel test robot
	<lkp@intel.com>
Subject: [PATCH] nios2: fix __wsum type degradation in csum_fold()
Date: Tue, 22 Sep 2026 08:34:16 -0700
Message-ID: <20260922153416.730513-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDIyNyBTYWx0ZWRfX4L7I8cxA2OMq
 2wDgEwu4Hu6bJmNmqd0OtheJPPrsQow/S1nfTMILao2GODGrLMLs6X9Ft1jZF5sHm/T7sfHUfw3
 BfxTDQqO0vbobyfPlGKZeJ8Xu6k5Sgc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDIyNyBTYWx0ZWRfX6IGDOUFVIwsk
 4/bpKhBAZGaK9cEhzcqqnzEEpe1FjPokYK/RfnidBM0YyFpBDyQlZ7rAstWveMn0flT8pOATQkE
 xdT/JEiu4AMSTY20ZbjZ8TTSJCJTBhrb6H0LQHDP38G95eBM9v8yYzd45u/uhbcMHmQhFCwdmMG
 xk/X9LS/oYu5O2sTCe2bGT6zp2aFY1iYb4Uzn8rsYs7pnZB7V98AHsxniLnFlrrxgW7l7/t2/9i
 3Q3dzn/EKjfj3VNdZUqjHYvpoFJTgjkYVnHNa9GWs1Q19JXlYLOfjeOYRCU9r2HqrNh7UQMULSq
 mlu6gcMD0HvLbXVVJUfsJl09/f4JvyQ3lBXn8uo52ChXGHes+T33JHiYQWL+gDT3KCJx1zNmmDG
 iYGEiHkTlvPrWVuiEy0ya9vke4Yd8zV9OEKYzk/JJlcPfR/XwoDlyDbtes2io4UIMg8jxDTN9r2
 v1qI7v/sajue+J1+Rcw==
X-Proofpoint-GUID: _kMzZ11oZlqJkA2yi-GXmAFRdQSNXetX
X-Proofpoint-ORIG-GUID: _kMzZ11oZlqJkA2yi-GXmAFRdQSNXetX
X-Authority-Analysis: v=2.4 cv=abX0Dhot c=1 sm=1 tr=0 ts=6ab2a00b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=QfzvH6fXpEJYp8rZMLYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_02,2026-09-21_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

csum_fold() shifts a bitwise __wsum type, which sparse reports as
"restricted __wsum degrades to integer". Sparse only checks the body of
a static inline once something instantiates it, so this went unnoticed
until a recent block layer change added the first csum_fold() caller to
a file built on this architecture.

Force cast to a __u32 for the shift, as the other architectures do.

Fixes: eea9507a69d6 ("nios2: Library functions")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202609222053.5gjiJjtb-lkp@i=
ntel.com/
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 arch/nios2/include/asm/checksum.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/nios2/include/asm/checksum.h b/arch/nios2/include/asm/c=
hecksum.h
index 69004e07a1ba3..b6b415ae17a08 100644
--- a/arch/nios2/include/asm/checksum.h
+++ b/arch/nios2/include/asm/checksum.h
@@ -27,7 +27,7 @@ static inline __sum16 csum_fold(__wsum sum)
 		"add	%0, %0, r8\n"
 		"nor	%0, %0, %0\n"
 		: "=3Dr" (sum)
-		: "r" (sum << 16), "0" (sum)
+		: "r" ((__force u32)sum << 16), "0" (sum)
 		: "r8");
 	return (__force __sum16) sum;
 }
--=20
2.52.0

