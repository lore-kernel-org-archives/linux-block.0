Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bqLjqQdM"
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C70C8
	for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 14:41:18 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3AKMSZNK013393
	for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 14:41:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=jAGKyWeA8QTcQMk/vfy8VOIt2qAQYrVxiznwPWy89lU=;
 b=bqLjqQdMna77OQGoh74v+kipvppsSBqh35fz4GwW9q3Vf8Ub2mEy/qqSq5cMRVmGP39Y
 Ir7wMjSkuULc4BNoHlenQnXVaW3wz1MZGhMXlPPZeHS7F813JUC4Wg/gYpteZxcbI7Oo
 mY622oAwU6TeyK7sSR+OHmoKOhO/u7Z5Li3pcG6RdM+u+oA0YxfsU0sHKWlBIR5mc8d5
 ge2Kf06rPi+3wr9lMKzu/AfqKmCa39b1liibrwfXcnlDmGxEoXnbd37U49Lq7slYbDH9
 4GoaEg+Qy6dZ1ogTYhJeB3zvF87r8/9kMcEYDR68P0la53VM/kAUH0RuOQEfZLi7nUqR Ew== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3ugbt1abug-16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 14:41:17 -0800
Received: from twshared13322.02.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:41:02 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id E21F821F1B1B1; Mon, 20 Nov 2023 14:40:59 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 4/5] iouring: remove IORING_URING_CMD_POLLED
Date: Mon, 20 Nov 2023 14:40:57 -0800
Message-ID: <20231120224058.2750705-5-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120224058.2750705-1-kbusch@meta.com>
References: <20231120224058.2750705-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: gSeA5-nOu432aFAU-xfJ7TyCPPi-wR_b
X-Proofpoint-ORIG-GUID: gSeA5-nOu432aFAU-xfJ7TyCPPi-wR_b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02

From: Keith Busch <kbusch@kernel.org>

No more users of this flag.

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

