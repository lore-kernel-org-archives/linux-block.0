Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919AD3CF663
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 21:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795530; cv=none; b=J+ilPVeqqkVitOxvF/g6fg5ZpJWQZ6HGBj4UP0dMxg8qlrGS3Iz2zxpLs4up6CJpzGQlUtZRNiuUsjUSvDBwHWzCIJdA6jdfDflmnl37Bs4NGNtxOWNRHlWN2InFcIv3O3uFmtR9EME5bu1qn2gsJIL09Dtx3R6n9pnKlgF1esY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795530; c=relaxed/simple;
	bh=cKMEY2qMe+ThIRuTqPtJK/4lqWcAKsfKxgMzaSM3Nxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lt8PbYkEetIVHnxuTV1OOI3ZatDxx29KUka7C7ndn9xkwSwkb1zwZlQ0nSmG1ye/qwV6wtIVVgeO+K4Y8fLUe0uld4qQzt3fGSkC+xBYhCVKAEaPu0BJZNMBh9TqS1gNXzu4vSeWdtxQ7T9+UqecDQPpV+7YES66PNCfyQnQuiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=lVizpkSM; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="lVizpkSM"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ELgpgw610219
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 17:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=KiFB
	1XYNEx2p4p1r40wGMJ8MJmpntx+6yGMPM/Sx6+E=; b=lVizpkSMqP3/FNMIKfpJ
	2hYHvrsvlJYHnoo3y0s5a04k3jgVNQAeOD6ig9ZVde/pTJtE5K5rxyPO4de+aDsX
	qH34Q+J7K0T3JD5Mx1wAx0Bz1gRqXXDQtW04vtheDJmQIP/aaCX7y0Jj7pFZylPO
	VV5rlxyWSwj/hMDAXgjPY7e+bDDxuKwJK2VaJsxOfL4PHNQf+4Z7MxCEj2VRgohx
	x4La/cHrHDCpNTUc7iLKyDPFgO+0LerhtZA2C6OymuwDDAG2I7U6yoSzRHVYhKzp
	MEqCS0cxojwtxF5sSKiCMmL5UMtOVIQeReQH7pNSDVe25Xcc6171h3BdIBw5LE5g
	jQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4e5m219m34-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 17:51:51 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9114ffb5d86so112258585a.1
        for <linux-block@vger.kernel.org>; Thu, 14 May 2026 14:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795511; x=1779400311;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KiFB1XYNEx2p4p1r40wGMJ8MJmpntx+6yGMPM/Sx6+E=;
        b=M3d/RX/lLraLaMSCB6g4zjtvCR6W9hkxQYuYj4GaGUHWpyDyz29JfyBJ+rjU3CkNfs
         u/wan/Yh2vqY+pUoAbG8o02Q2+7fwIXkd4epzPwEu30ifbYj5DLiHQNlRhvdgTw4Qn1S
         CM2McSuEmdnS9SZn55FVMYM0GK6WVebBkV8kzrEaiWac+IfqlhzbNR2l14+HXivL2LK2
         2GTjEx6qV5afPjEUe3txEIq/u+4r/8Ajx+i8asW5ZHep3LJR+658eNBuYjagh6SzTM3g
         XRdkD+B47Bg7g7HJL+t6YHsmVfiG1+Wc/JzcGBjFUi20bqcM2QltzjT3bxdG3FAMW23T
         Vg7g==
X-Forwarded-Encrypted: i=1; AFNElJ/SbPfrytXAkBvGt94+kx8ulITMqmec4kKX5C6Mg4qoa72eD2ZIWb7+y0l4kogAy/8M1cW7/JtbleXK2w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7oxOmNK452awlghUBLL2+6EJBAnRVosulZjMDY4nzrpAedhgE
	U6nErldQbT+roZNLbIRSyW+K9oAc3eCr8T/W/N0BFPH4vOgwxs6ij8vI+seYkhaxWvIM6w4KlPz
	teNkVcs7lcoa+y9fGc9/AX32xoQux/0/zrTyMvXKNCmz0sjeHp8EvT0sv6T+i
X-Gm-Gg: Acq92OFSp1cTwXMTFI8JvYCkfwFmwrnBt9M06tQkD6A3v3aj7QWcFfCUtPNAm+C0G/X
	J0rfSnZXPpvSjdprvEOzSphENZe1/nFeYZZ6ju1GO2a/zTTWvO30Rvj1WS+YwzqmPYQeGVAkLpg
	YYIkTG5UtX17qxsH9i1e17II0JvA5cZaV3dQURJJkTCFS0RkAnWdORyaktfGMEQtP5wxE3BskDJ
	ijXul/Kc6OSjekWIp7OWco2YQyC9qH4mk5sxa4yHeQ1uXW/aPZ7Dh9Fk2I+MF37KIvgJKUtumEK
	pOGXo060CUOI8AJsmVX+JHdtroEW0ixsfKxCsF9JFVP0NgZw98VNzG98cwURMnOSinujaVFfraU
	6NjWwb5zdueTKYZfSYGKL9dXm9zAtqeRZ1HDXrMZ8kOc=
X-Received: by 2002:a05:620a:31a4:b0:904:f4a5:ab76 with SMTP id af79cd13be357-911cd8572famr230868685a.3.1778795511103;
        Thu, 14 May 2026 14:51:51 -0700 (PDT)
X-Received: by 2002:a05:620a:31a4:b0:904:f4a5:ab76 with SMTP id af79cd13be357-911cd8572famr230865885a.3.1778795510670;
        Thu, 14 May 2026 14:51:50 -0700 (PDT)
Received: from [127.0.1.1] ([129.236.229.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba18132fsm354966085a.6.2026.05.14.14.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 14:51:50 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 14 May 2026 17:51:15 -0400
Subject: [PATCH v6 2/4] iomap: use BIO_COMPLETE_IN_TASK for dropbehind
 writeback
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-blk-dontcache-v6-2-782e2fa7477b@columbia.edu>
References: <20260514-blk-dontcache-v6-0-782e2fa7477b@columbia.edu>
In-Reply-To: <20260514-blk-dontcache-v6-0-782e2fa7477b@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Gao Xiang <xiang@kernel.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778795507; l=3015;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=cKMEY2qMe+ThIRuTqPtJK/4lqWcAKsfKxgMzaSM3Nxs=;
 b=EUSRdVenMg2q2kdAIUHNovBRSRrki7XEbmF5ULdT5lQWRq5+xfggvWhH1KNRKBXyJKgw/JuBx
 lcJ9tESwNybAtxuwQcAtvSMvqi8D3Ob2J54zMF5tDxhJkwMV4Tpj6IN
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: eIa6O_czr4UkG7E2HIiTScCi3auO26tO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIxNiBTYWx0ZWRfX8oOc458jD8GB
 IF4XdS3oGRqj/bwnTO4qrTT0B/YhtS8C1vAwgPUvS5JwnRrin+F98ccotUBnhQnd4GYUl2kAGwZ
 jwKNvxW/0vttu7qpHeDLThZvDKQY3WuU2a7ieSDIjI83V0G8by62XtNTlyTVCOT82o2mBfQ4EoQ
 1khQLWonq5q4m33hMvszQb+qw5+vjbG1jUEAt65TZmtIZZJx63uy/tQlSMPINWkNUzfcs5mwspA
 XkgdXNoMpkTaOa6Mgl17vHI5CHge7s9flTOG6gi8syYyZcX/TA1Gp3bsK4xwr8UMHhwjE1F7S9X
 hzBwuvdEwytvELNEcp3eE/OGKxJj1PSY46f1YII2zfwMEbePo2ENCIWNiCBhiPVt6OOJb8keoWV
 w3VKKwiFF5pmEenFjZQ4UZJ4PGduOR5S2uyGSSW/Pw7hGXr8wy8TUTD1Fmv0RzRYftTZI6s/UOE
 d4XFilSneJb3QR4kV5g==
X-Authority-Analysis: v=2.4 cv=VLjtWdPX c=1 sm=1 tr=0 ts=6a0643f7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nkegbr1AwBRna+m8FBH0UQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=CxwgBoAeUDVvfQxjk70A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: eIa6O_czr4UkG7E2HIiTScCi3auO26tO
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11786
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=10 lowpriorityscore=10 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 bulkscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605140216

Set BIO_COMPLETE_IN_TASK on iomap writeback bios when a dropbehind folio
is added. This ensures that bi_end_io runs in task context, where
folio_end_dropbehind() can safely invalidate folios.

With the bio layer now handling task-context deferral generically,
IOMAP_IOEND_DONTCACHE is no longer needed, as XFS no longer needs to
route DONTCACHE ioends through its completion workqueue. Remove the flag
and its NOMERGE entry.

Without the NOMERGE, regular I/Os that get merged with a dropbehind
folio will also have their completion deferred to task context.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/iomap/ioend.c      | 5 +++--
 fs/xfs/xfs_aops.c     | 4 ----
 include/linux/iomap.h | 5 +----
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index acf3cf98b23a..892dbfc77ae9 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -237,8 +237,6 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 
 	if (wpc->iomap.flags & IOMAP_F_SHARED)
 		ioend_flags |= IOMAP_IOEND_SHARED;
-	if (folio_test_dropbehind(folio))
-		ioend_flags |= IOMAP_IOEND_DONTCACHE;
 	if (pos == wpc->iomap.offset && (wpc->iomap.flags & IOMAP_F_BOUNDARY))
 		ioend_flags |= IOMAP_IOEND_BOUNDARY;
 
@@ -255,6 +253,9 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 	if (!bio_add_folio(&ioend->io_bio, folio, map_len, poff))
 		goto new_ioend;
 
+	if (folio_test_dropbehind(folio))
+		bio_set_flag(&ioend->io_bio, BIO_COMPLETE_IN_TASK);
+
 	/*
 	 * Clamp io_offset and io_size to the incore EOF so that ondisk
 	 * file size updates in the ioend completion are byte-accurate.
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index f279055fcea0..0dcf78beae8a 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -511,10 +511,6 @@ xfs_ioend_needs_wq_completion(
 	if (ioend->io_flags & (IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED))
 		return true;
 
-	/* Page cache invalidation cannot be done in irq context. */
-	if (ioend->io_flags & IOMAP_IOEND_DONTCACHE)
-		return true;
-
 	return false;
 }
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 2c5685adf3a9..fef04e01116f 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -399,16 +399,13 @@ sector_t iomap_bmap(struct address_space *mapping, sector_t bno,
 #define IOMAP_IOEND_BOUNDARY		(1U << 2)
 /* is direct I/O */
 #define IOMAP_IOEND_DIRECT		(1U << 3)
-/* is DONTCACHE I/O */
-#define IOMAP_IOEND_DONTCACHE		(1U << 4)
 
 /*
  * Flags that if set on either ioend prevent the merge of two ioends.
  * (IOMAP_IOEND_BOUNDARY also prevents merges, but only one-way)
  */
 #define IOMAP_IOEND_NOMERGE_FLAGS \
-	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_DIRECT | \
-	 IOMAP_IOEND_DONTCACHE)
+	(IOMAP_IOEND_SHARED | IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_DIRECT)
 
 /*
  * Structure for writeback I/O completions.

-- 
2.39.5

