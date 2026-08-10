Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E468B426D37
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786379986; cv=none; b=IMHwgPrccutUN7z2xkHp73jq2kQExY/NYzebIp65CfdIXXPB11huQNWUdeTKFdzWozRWdMnh4zW/J1DtE53aU1Ium0fi/e6unL+kSgMY4Vysa05cCLBqTWm2v8dlse1dcXaXNhC90naTAuAaBPKo9B9d0EQuZU56hAyf461SIOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786379986; c=relaxed/simple;
	bh=1dVw8nrbAkxuia8Ac49iB4K1gs7YkCKauVwA5PiTKg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D+VrkhEXpDQgGO7vbqDvARAvNFcqHpDvjUYT7N2nP4FCjOBqcWW6WMVMHoNAIF90pS3TLzY7MfVvxu+tT5aKkMxHoTo7wM+DZdDPFBX65E6cZXIcLThmjUMHIdCR7iy5jVyc01kmJnme5FYMEhSVonGMrWVWze8wtdXa0K/IhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=gK4/09uf; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="gK4/09uf"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AGZKP53614967
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 12:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=e+BPPtqOvSp2f4p9hlj0HukM/4
	EvcLMV9fvq8zY/jWg=; b=gK4/09ufjiH+PjNIxNIToysgyH3VTFluCwCJrtSPf2
	n/H+xqxPD5N/2VMqd0mP0lXQyBpXqEta74UfG66EGNHpcdqvIkh4CkLWq0ibG4U/
	cANtQQUjRnrslosC+Mji6YUWBYpAeQ+HiDh4Gd9f83UkkNKdb96mTFxcWdp/RZNm
	PJHi4uXsj3VGAkFwBgh4AxP/GreuFB62DuGuISvncmMUpSe2+PgJjxi6ZlYDCxgQ
	EF61hn2BNm5ZCKMKG6yMOZRWbmAqDKPLFd5UHusjl4MpFm3gE5Al3B0C4MGsDgaG
	tPHHPF0+oSXfhIzvAHMMNbHjwRkbcjQiYGQifU+l9Ftg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4fyj6h02qh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 12:39:42 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52827090cc5so1193341cf.0
        for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 09:39:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786379982; x=1786984782;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e+BPPtqOvSp2f4p9hlj0HukM/4EvcLMV9fvq8zY/jWg=;
        b=by6Mx2vYhszMO/VnO9uJOvQEhGsTQhB6sYusi/mVNnP+3MpWBBJ+xNO9tj6d4Qp5N5
         WLXD7BHUtwRRxnfNBN4kmO5wKm1Gh+AUd+Qdf61HcjQK2fR5anXbcq3HcE4Ns/cpCxnO
         AbYZ1LM8jn91K6tGsZBi4Hdz5GzF+ylINueZRFqFfO64Xo+Dk3Qj9xjXNwiLvf/jfYXi
         BevTCuOVv3slJXMwgqkXLAqwdZMqQI6yD90e8rqrIGx6EP3XHH2SYiymNdNAXAlAMP9W
         A8IzF78Iytey5H83CWHKzplsBKRDQjMQS4iush7uZV98UpMrZF1klf1ShVCATkG3yIIr
         TC+w==
X-Gm-Message-State: AOJu0YySaVUgbP5McbZNZhazVCD/kFciPB0dkj406/ChFd4ifRpWRWaC
	OmQKknKrH7JkP8M/3QDA/jAjWDuuNl8XrYeMpwsr0I8txRpnTSiQkHipQ4waczhs1zBaGKqNp3+
	WbLotGAHaOD8m512qL/jcsCiQiHjkKKCEp0DgFbyTCUSWI+IKZbdjFmFSdPZ0
X-Gm-Gg: AR+sD13AtKcP4VzoTRg5NZJ7JKH4mo1lZdw7tjajibMCzZM13QGe6bR2IWSspwx2Dij
	QMykay4uy4/EwWiKuEK4XDWQu9oYKSXppkAt4NIaiB6O1hK0obQEUSuqeR1hNjl+dyeoDj6AtO1
	g2dJxz++S7J6LE+6Gx/6geMNuTZyz/8JpU/HMHi9A1WSRElZiQvEqbLWAe86095bIAfvagWMHh8
	v9AUw0bj6Air83TpSYf9HO1uAgDSxZ0Tfh9Jq+LMTkftgNj04srPWer4I+tGfovamPmvjmXVEZD
	tGZHvsDNt2C9dnU+Pi5RxLjk+6HnJ3MoXEhyIbcqVgaC7jpf4kYm1O+1uvmETALM2MH0lYpNMtp
	M2sAoKif1hy0/YIINWoGwj4OiJd2NCVpEVLJVnIqn1UA=
X-Received: by 2002:a05:622a:2cc:b0:517:146d:2cb5 with SMTP id d75a77b69052e-52d23825fffmr193169661cf.20.1786379981912;
        Mon, 10 Aug 2026 09:39:41 -0700 (PDT)
X-Received: by 2002:a05:622a:2cc:b0:517:146d:2cb5 with SMTP id d75a77b69052e-52d23825fffmr193169081cf.20.1786379981496;
        Mon, 10 Aug 2026 09:39:41 -0700 (PDT)
Received: from [127.0.1.1] (bzq-79-179-7-133.red.bezeqint.net. [79.179.7.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021506c0sm33475204f8f.11.2026.08.10.09.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:39:40 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 10 Aug 2026 12:39:19 -0400
Subject: [PATCH] xfs: avoid double deferrals for RWF_DONTCACHE writes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-xfs-dontcache-double-defer-v1-1-aea7484b3e49@columbia.edu>
X-B4-Tracking: v=1; b=H4sIALb+eWoC/yXMQQrCQAyF4auUrB1IRxTxKuIik2baiExl0pZC6
 d2NdvXev/k2MKkqBvdmgyqLmo7Foz01wAOVXoJ23hAxXvHWYlizhW4sExMP4m9Obx/JUgPJOdM
 FE2FkcOBTJev6xx/Po21OL+HpJ8K+fwEx2RpgfgAAAA==
X-Change-ID: 20260810-xfs-dontcache-double-defer-ae3fa50ba02c
To: Carlos Maiolino <cem@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786379979; l=2117;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=1dVw8nrbAkxuia8Ac49iB4K1gs7YkCKauVwA5PiTKg4=;
 b=J2RtFKGjmGGQZlE9chrI+urEUn9ROGe+QzTLmqzAsEYbReC3BuS6IvwP3bkhsK+eJgE4g9vHG
 sxrYq9ROhdjAiJ3p/0Lved0ky9kPpSwjM9eNM4uvkOYziZVUIFUUiuT
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE0MiBTYWx0ZWRfX4t0Zy70T7wiu
 5DvQmDx2xjmKCPOoOwYrUcjh8jvag4v/f+E2t1NHI2f5At7OecAjqawLm5qKf3b4nIeG9S4ZYVt
 0zm03dNgKQ17ViQuB5prDFvbWw2QRbwmHNGG8fT5N2UX5/LDpicDL6JACIpexmmthUAmxnGziRv
 7BHCw9PgEra0w/P/yvGy6gMv6oBk2R1HpkGtsAduTI/Ouq14NpfXNzM67xunwuYsEJW54v/Be1l
 NtK2plOCVLsWI/sEomuBoYYMoGzEWUIH3GUlwbHizl8hLnjYB0pZ02/OAgkncHDwacGfZ+ZKQAP
 SI9eoSof/tdRwiTI8HHkF89W9GC8beNX8UgGGPPnQ8EaxDrBoUjFW/FxORwkmXtsJX6U++GpInx
 8QfmYuIksDxj9PRBYtbMh7wNc1+QpLDx63/+OQcTZuB7IJzMCXa7Jmi0GFmrsjW+natA3dzO0pU
 Fe8Mve5H8SydfsuHXRQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE0MiBTYWx0ZWRfX3gPbWvzC043/
 8dWLfdtbKdzTgrtZlfpNU9wZvY4Zz5cd7GCuVtnZWvP5EV7GO+sU+nbVtYBwWsmn1jw4vpq+Qbu
 InpJzIpiOIYim1K66/XiSm3GLK1j6LOAOZ8t+bdPOsxornJA15fN
X-Proofpoint-ORIG-GUID: 6lwOq_h3r2ReEtvCcYHdJNf-1ZmbD2iM
X-Authority-Analysis: v=2.4 cv=QY9WeMbv c=1 sm=1 tr=0 ts=6a79fece cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=LRATYcvZeiQrLRB5MfbBvg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=YmEKMl2L6wtdMVtX8_UA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: 6lwOq_h3r2ReEtvCcYHdJNf-1ZmbD2iM
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11871
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=10 priorityscore=1501 phishscore=0
 impostorscore=10 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100142

XFS already defers some writes to a workqueue when transactions are
needed to process the I/O completion. Disable the block layer bio task
completion in this case to avoid a major performance drop.

Fixes: efbde6f9f449 ("iomap: use BIO_COMPLETE_IN_TASK for dropbehind writeback")
Link: https://lore.kernel.org/all/8124341f-3af2-4a16-897d-38db5ab5a9d4@columbia.edu/
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
Follow-up fix for the RWF_DONTCACHE task-completion series. This is
targeting the block tree. [1]

[1]: https://lore.kernel.org/linux-block/annkDbhXBEeMoNVT@infradead.org/
---
 fs/xfs/xfs_aops.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index cd8de8c82d78..74a6089abadf 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -549,10 +549,14 @@ xfs_writeback_submit(
 	}
 
 	/*
-	 * Send ioends that might require a transaction to the completion wq.
+	 * Send ioends that might require a transaction to the completion wq,
+	 * and disable the block layer task completion for them as there is no
+	 * need to defer twice.
 	 */
-	if (xfs_ioend_needs_wq_completion(ioend))
+	if (xfs_ioend_needs_wq_completion(ioend)) {
 		ioend->io_bio.bi_end_io = xfs_end_bio;
+		bio_clear_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
+	}
 
 	return iomap_ioend_writeback_submit(wpc, error);
 }
@@ -663,7 +667,14 @@ xfs_zoned_writeback_submit(
 {
 	struct iomap_ioend		*ioend = wpc->wb_ctx;
 
+	/*
+	 * Defer all completions to our workqueue as all zoned writes require a
+	 * transaction to be persisted. This also means we never need the block
+	 * layer in-task completion for a task context.
+	 */
 	ioend->io_bio.bi_end_io = xfs_end_bio;
+	bio_clear_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
+
 	if (error) {
 		ioend->io_bio.bi_status = errno_to_blk_status(error);
 		bio_endio(&ioend->io_bio);

---
base-commit: 30df3ab3c92d0e7854c54df6ae66f4aa6eb5b3d2
change-id: 20260810-xfs-dontcache-double-defer-ae3fa50ba02c

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

