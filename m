Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B99D193074
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215199; cv=none; b=K+udSpxHwHkrTuXbzCj4OB7OcJR+NomoxELjByF3XheeCeuYdGYSrsEIKXi3seXyRlnyfohLZLl3n+No/u7qYx5r0h64CYQRsnEpz3wL4cZnDV2DqRr7rY9okVbXtSKTasxTfnG0cJ5kc/ZK5yRTUn7Cz+Mq9leRDILL4ZhNF5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215199; c=relaxed/simple;
	bh=RTkTfNmlAK9/4u2bWiR0BiAR3mMG6QfKEBlAYe5AaEU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdVxMzuDH8Z6ny02mgJOKf9Os9fiRefhw8N+eDHB7aX5IoZ1A9vrtTtPzu6kpKp1Sp+7Z0FgToSVmKe78kL53A9VVYuKme6DHQ5VKdZJtMAwG/BryW4fpIyKnO2q+wmQ5HLwvd2dp/yIkNHvI5XIXxP9TcGMRK6niggom1qIoMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GiVZVm5W; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GiVZVm5W"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49TD7Fwh021662
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 08:19:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=KkMsdiy6+G613EM2iVNE1sWpzDf7A70uir1Q/qyFKn0=; b=GiVZVm5W+RXT
	zyP06X7gCJqRTFYdNORXxwmh6xw7VUUpi0VQfY3gwYgE/BB4Vzw5jFbrIiirlIAr
	+4VC7U26lB3w9WiUzypItJv0eIIUdYrwEhObziPttAgbNRDgVFXqR3xnWpNt4KZL
	Xq1U3pXWtcvZJX9ekGOEFXC+0w3Vz5cY2j7Y0I7eNk7gMXcci8Z6guhm9L1S+dUE
	Z8KwcmGKbQ6lIvKhEbc2IDrIgeCpY1PZTwIHNuqZNz6W2M+J+CDzvHG5U9vKsk01
	edMipsrm4IT1qZzh56uphZTAEqfmTqaLLFvus43Czjkt/AzdjokeAby1x5BnGFNk
	XSrm5Dan/A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 42k0af13y2-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 29 Oct 2024 08:19:55 -0700 (PDT)
Received: from twshared23455.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 29 Oct 2024 15:19:52 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id DFE2C14920E9C; Tue, 29 Oct 2024 08:19:43 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv10 1/9] block: use generic u16 for write hints
Date: Tue, 29 Oct 2024 08:19:14 -0700
Message-ID: <20241029151922.459139-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029151922.459139-1-kbusch@meta.com>
References: <20241029151922.459139-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 5XcreGYEf9aRa4HTy0_CKGw8FIdpf3qH
X-Proofpoint-ORIG-GUID: 5XcreGYEf9aRa4HTy0_CKGw8FIdpf3qH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

This is still backwards compatible with lifetime hints. It just doesn't
constrain the hints to that definition. Using this type doesn't change
the size of either bio or request.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blk-mq.h    | 3 +--
 include/linux/blk_types.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2035fad3131fb..08ed7b5c4dbbf 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -8,7 +8,6 @@
 #include <linux/scatterlist.h>
 #include <linux/prefetch.h>
 #include <linux/srcu.h>
-#include <linux/rw_hint.h>
=20
 struct blk_mq_tags;
 struct blk_flush_queue;
@@ -156,7 +155,7 @@ struct request {
 	struct blk_crypto_keyslot *crypt_keyslot;
 #endif
=20
-	enum rw_hint write_hint;
+	unsigned short write_hint;
 	unsigned short ioprio;
=20
 	enum mq_rq_state state;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dce7615c35e7e..6737795220e18 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -10,7 +10,6 @@
 #include <linux/bvec.h>
 #include <linux/device.h>
 #include <linux/ktime.h>
-#include <linux/rw_hint.h>
=20
 struct bio_set;
 struct bio;
@@ -219,7 +218,7 @@ struct bio {
 						 */
 	unsigned short		bi_flags;	/* BIO_* below */
 	unsigned short		bi_ioprio;
-	enum rw_hint		bi_write_hint;
+	unsigned short		bi_write_hint;
 	blk_status_t		bi_status;
 	atomic_t		__bi_remaining;
=20
--=20
2.43.5

