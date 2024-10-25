Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69EC217F5F
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729892589; cv=none; b=q0uzNNEIEsAsE6L0pRAoksOTnQhovi3Ck34/AxHdVeiw5aZ/yWZhcDHq2VBD0NPxd1YltXJM2Cbd8l/hEmLpH/jTw3v2Om9dktHv1Xmzu9SX/uT9RPb5tmP6ATmc4xlz8r1JDVtvAjySckxXsVzRA2yBkNSo1KGj2hlPcLp7Kic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729892589; c=relaxed/simple;
	bh=9K35hkLTRC/BkJ+8V1VdlasgPnySGLTUr6wJTC9WLGs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WWHNXsAPZjlFDS60KKnoB/MekvKECe7dkGBLAB/DrS2ywhia7/nuam+F0/Bv6bzFcsU5XQDb4HnPDblYZYffoL77XOZJIe804aBOymCRg1A3e2cj2mpt6LaLtigTrTqL7pgoQIuAUimqMKWVQKCafTh2zrwpxva08SaLplbxs6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=XRNAmIJO; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="XRNAmIJO"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PKcsEu024226
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 14:43:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=hV75pvgBqnAl8CFhITowhUqqskleOfnv2dfeICUvPJs=; b=XRNAmIJOOe71
	LGMNbhslgHq0Fyh2EVQ5kle6FaW40Hb94mHqkhoJgDP9/XF6yx8g+vxv7Li57ziQ
	WMH0tKAFgbqAx50Eadj5Cv+MP3WqDiJ1vzXmYezhLmaYlDlBrb7jzMbp6jJEWU3X
	o5MjrvRFzwaFV/zXsER2Lb0bT5fXxpXMyisXzEuBLWiC87ZFqL49ywhBQ8iFpVFb
	vB1tVBMp/rgJIWbO8pvFwzgeyfziRMWimdqQ5N9UMewRlCs7KY2JA4n22VcD7xBA
	vgCWXiANGoOQ3LY4tp52C8q5mav16cDUDQWFRb8TU15cyHzd1ilaIzKW3TbmsRdQ
	ksMHS9p7lw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42gjhxrcwv-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 14:43:07 -0700 (PDT)
Received: from twshared12347.06.ash8.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 25 Oct 2024 21:42:38 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 936951476D73F; Fri, 25 Oct 2024 14:37:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Hannes Reinecke
	<hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv9 5/7] io_uring: enable per-io hinting capability
Date: Fri, 25 Oct 2024 14:36:43 -0700
Message-ID: <20241025213645.3464331-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241025213645.3464331-1-kbusch@meta.com>
References: <20241025213645.3464331-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: bG2lMRMZlcJfTs2S8WghMupIVuErTCfi
X-Proofpoint-ORIG-GUID: bG2lMRMZlcJfTs2S8WghMupIVuErTCfi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Kanchan Joshi <joshi.k@samsung.com>

With F_SET_RW_HINT fcntl, user can set a hint on the file inode, and
all the subsequent writes on the file pass that hint value down. This
can be limiting for block device as all the writes will be tagged with
only one lifetime hint value. Concurrent writes (with different hint
values) are hard to manage. Per-IO hinting solves that problem.

Allow userspace to pass additional metadata in the SQE.

	__u16 write_hint;

If the hint is provided, filesystems may optionally use it. A filesytem
may ignore this field if it does not support per-io hints, or if the
value is invalid for its backing storage. Just like the inode hints,
requesting values that are not supported by the hardware are not an
error.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/uapi/linux/io_uring.h | 4 ++++
 io_uring/rw.c                 | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.=
h
index 60b9c98595faf..8cdcc461d464c 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -92,6 +92,10 @@ struct io_uring_sqe {
 			__u16	addr_len;
 			__u16	__pad3[1];
 		};
+		struct {
+			__u16	write_hint;
+			__u16	__pad4[1];
+		};
 	};
 	union {
 		struct {
diff --git a/io_uring/rw.c b/io_uring/rw.c
index 8080ffd6d5712..5a1231bfecc3a 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -279,7 +279,8 @@ static int io_prep_rw(struct io_kiocb *req, const str=
uct io_uring_sqe *sqe,
 		rw->kiocb.ki_ioprio =3D get_current_ioprio();
 	}
 	rw->kiocb.dio_complete =3D NULL;
-
+	if (ddir =3D=3D ITER_SOURCE)
+		rw->kiocb.ki_write_hint =3D READ_ONCE(sqe->write_hint);
 	rw->addr =3D READ_ONCE(sqe->addr);
 	rw->len =3D READ_ONCE(sqe->len);
 	rw->flags =3D READ_ONCE(sqe->rw_flags);
--=20
2.43.5

