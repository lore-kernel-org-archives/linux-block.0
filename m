Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="e78lj2Ad"
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC41A1BF
	for <linux-block@vger.kernel.org>; Tue, 28 Nov 2023 14:28:07 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3ASMGMfl014696
	for <linux-block@vger.kernel.org>; Tue, 28 Nov 2023 14:28:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=gz46DOJDVW8DfYBnHMREJeF0H1ddTB4qso7LZwreJ6o=;
 b=e78lj2AdR8+aKuGsH8bAe1QDYY7SRTJXK+h4dI89Y7FFvhMmWB2sT7O2It7xNVNTqbac
 uD0APeHUs/irvjVRBEMwSsTl01RNJM/AA4kJCce/M1OKAV+wuA1IH4weeQIqOUObED5j
 ujxB6RHOV5Jv4b+gkb97B+9q6Czv4t3UVNXQJEnHRUANa9XOVmMnxEFcL7j3ImAXMD2s
 E8iQOYp7ol1CeBdrn7EkZVOYknDf8K77WNfLiU2D5neyDE3gIoq29kaC1TXZriQib2gG
 uBvHP8Z4VX3k8B4SpoEJP1BeVWRx97arZtdc0km5VvF/7CFvmFJNtKCdNzRvc9Mf0LW5 wg== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3unf81cty6-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 28 Nov 2023 14:28:06 -0800
Received: from twshared4634.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 14:28:04 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 62B152252F0CA; Tue, 28 Nov 2023 14:27:54 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, <ming.lei@redhat.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv4 3/4] iouring: remove IORING_URING_CMD_POLLED
Date: Tue, 28 Nov 2023 14:27:51 -0800
Message-ID: <20231128222752.1767344-4-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231128222752.1767344-1-kbusch@meta.com>
References: <20231128222752.1767344-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: DXjeafOrUbioUMpVU_JTB8dM3lkz-eCl
X-Proofpoint-ORIG-GUID: DXjeafOrUbioUMpVU_JTB8dM3lkz-eCl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_24,2023-11-27_01,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

No more users of this flag.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/io_uring.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/io_uring.h b/include/linux/io_uring.h
index aefb73eeeebff..fe23bf88f86fa 100644
--- a/include/linux/io_uring.h
+++ b/include/linux/io_uring.h
@@ -28,7 +28,6 @@ enum io_uring_cmd_flags {
=20
 /* only top 8 bits of sqe->uring_cmd_flags for kernel internal use */
 #define IORING_URING_CMD_CANCELABLE	(1U << 30)
-#define IORING_URING_CMD_POLLED		(1U << 31)
=20
 struct io_uring_cmd {
 	struct file	*file;
--=20
2.34.1

