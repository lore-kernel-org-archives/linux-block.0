Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1EB2DF707
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467315; cv=none; b=ZKSQ81H+FyF1AaqgQKoOKB+9jvtXg02w2Nxn8XQhzYkcK+yo7+idj3U1m2mzuPz7sz9GLWQSu0ThQZ7P7X4gu7v4FGeQSxjbTUwHQCO8Jvg0AVu2vsjvPLeQ7CXErnlFhJqmsyS/3ZUIgy+YLPluT/2BZd/QoPkrvUJjSGUKDs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467315; c=relaxed/simple;
	bh=7zwsmyUip3CAkS6JVcgPiuvcXkqOuFIklXcl4CKLS7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BV0jTwJVzGjTJ26aus9yIL05gHUbiR/uEim+OelhlsJ8wfsiIqnZ1koydXq+k3B0Mw2kSGumM0q9mZZ2OzQa7VO0xtEyKS8eksUeQ4o1Y2P7Uj6oZIfpUK0pXPVN2HYmy16qYT8d5ii+2lPAaxoKMJcABfNfT9fxYxSm0PqrWss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Au7sydVY; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Au7sydVY"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PJSiAJ477742
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 15:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=7qfY
	4Yey2B/8xRD7jk2HVXbmFsGdrb8gwFavo/knRp8=; b=Au7sydVYHJxfvhcGusjW
	FEbpn9GGkRrzgLrTHhOCMbptHSX/ALA6C88pzf3RJSXe3GRiSgydzJVOXWnM9VaY
	BNdVPii2y6i0oYq7y+9TO5mMxTct2pKIusyD79XPROlhYQeMKRNs87jKHrvyI0uw
	Wn8noKHIq4KB814b8F0P5FciGNk7ALGmCIX5JsU1y5+3ZOptL+6ahq1z3ywm2k1x
	MeMBSMQF62gu6jXDiXJrd/WT/tL/m6ciFKIBfAIwvo+/WigpyDrml510h3ho9m//
	h3PTLxppFUGY/IZ/ripHeVxqmM3JNsTeqGDbAUh4GSukZ/h2dod+qzk1+uc+2Tnd
	Ag==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4d42nnq9sm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 15:30:42 -0400 (EDT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5093a985e21so13620691cf.3
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 12:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774467042; x=1775071842;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7qfY4Yey2B/8xRD7jk2HVXbmFsGdrb8gwFavo/knRp8=;
        b=AFgOFgzGlbUNdOJz4JVJoBeKr75hLsVTmuzsx6x2C6vTbqP9mxxgk02dQSbMyillXm
         RX3Bk/7zgFFX/3PLNjk5zSHbEYDCI2fvWeAn0UvwPDzeSuCgR7nKCgAyAWVfzIpii8vy
         rvvCyx5tMd9feKoJYSlnrAn4cv3hG5CdpnzC5oQNF4yHgqSXiPkFgtH9KwDzBwYHfnXM
         VO2K5uM6Tsq083U50Kw0ldh1nkdI5jEhZQOt1oYnqLgnMuoIzxqeSgt8AZtmYqFHgjn6
         av8FrL6vCP+pLCEqkMPZX3ltJqZxHvfYbHHfLYBA1E7toLeeC6vJhVxgcdog4Xjtj7FV
         5D8A==
X-Forwarded-Encrypted: i=1; AJvYcCVuVXwz8nE4PCbvdHm79MKCci+ULYHXX0vLIWk3sPlQIGOuquPMPgUuRlgt6sGROcSemWfNLZ+9B0T/bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgF0VRK96OTfjtuqExIuoVZu+W9KlwyHqdPDXFlS6haVyxs9WW
	F47K7Pl2K9F7yQumgZwMCcUsLdZkbe8VFsBayH+vnDbIaIt8j9Ra12ixE5kHfmKYfyzeBJCTVc9
	Dq13gfRh2JkLbyDmRMnrUD8ArM/5xtIJsOG4F3GC3vsQnlWotnqrpl85FCiclSs/eoQMt
X-Gm-Gg: ATEYQzxv3houw5ycNqTX6AVhBJEKCztHx11JIqJ1oZIytKi98DuX1MnLYa+Nq7VaC+t
	KJ8mESqgy8CgQtTTrnzp+IknWZ2OYrTfixPlZ1fu/47yytVzNj7J+4vvB8ZiwNWCWzNOMItIMim
	AxnjXA9VkdDvuxhaws4afJZppHgaJGZP6lo6hVtUJqgAoedkfy+J49nB1Z1qzw1R3zOe6nQVew5
	KrKLqPR9JChrB1zxTOPJbTiDbMmuSfmbwGlQ/p/tSo9g1TCkWrik5EWEIQxMgxi/3MjUXxp+9SL
	vNkKsDpUKK/4thTmTuNgH0TZVrYyappgIM73KMyXO2ynzWA92TW+zXiHJPE+TUKl+xp66k6XHuc
	ypkcs7e54pxmoxsDupjww1xmXhCSxbuBZAOtaLg==
X-Received: by 2002:a05:622a:9d7:10b0:4ff:c08a:52c4 with SMTP id d75a77b69052e-50b80ce31d4mr55571831cf.18.1774467041717;
        Wed, 25 Mar 2026 12:30:41 -0700 (PDT)
X-Received: by 2002:a05:622a:9d7:10b0:4ff:c08a:52c4 with SMTP id d75a77b69052e-50b80ce31d4mr55571251cf.18.1774467041146;
        Wed, 25 Mar 2026 12:30:41 -0700 (PDT)
Received: from [127.0.1.1] ([129.236.226.199])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b9234e3a3sm5534221cf.19.2026.03.25.12.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:30:40 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 25 Mar 2026 14:43:01 -0400
Subject: [PATCH RFC v4 2/3] iomap: use BIO_COMPLETE_IN_TASK for dropbehind
 writeback
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-blk-dontcache-v4-2-c4b56db43f64@columbia.edu>
References: <20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu>
In-Reply-To: <20260325-blk-dontcache-v4-0-c4b56db43f64@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774464193; l=1665;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=7zwsmyUip3CAkS6JVcgPiuvcXkqOuFIklXcl4CKLS7s=;
 b=L4CWzIK6kHXuFczj/fPjz2aWyUnS1OpJUL3M+esbeR43gMhMyjhAVsUMhpLPiY2zQSiPsjHza
 J5C73e08cUYBjjsRFhFa/ta9SjUn5dInI/J4XLjlsu/GNzv1JM0+xWE
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: VkBodQp3a3mhR0TuIVa4azdqfeG02CeV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0MiBTYWx0ZWRfX9ZzSL+weEbYJ
 d9TLB/ejfxelYzpSq/S47AZmOuu4z7q6rVJPXJ2bUqt/osUNFry0FzJghkLEQ5GKv8P6OjrnS1a
 H6E90s2SqwUhiWGuz75KfSB7Wc1n6l4Gxi5N5BW+TMV+y8NytbQpKzr2BLXMcPkYDs3hzrLK63a
 2Ci1XgDLLrp0dVMUKBZnZEWW3/Xq7MUH/y2RW0QAhYpZMJ5QgNopM1bfszRM/S6gwOeKDoyTOy+
 cUleBUu5ajzs7Gi/44Ca/4MNBghy85+6KpSk7kgpLI55qkrCHISNV1xYJsTCVfrdYSR7Bo4dQCL
 Fog3Dok1BHYqnv761HdQg5YgksLdWloP4cn7BDvtIvGa39HSiDkhzFIDs0CU7aiNxgH7bUZPHe0
 AiV2TaKwRu56RZzBoLRGS8bHD576zB39LolwNstdxNOxZwYDkfEi+jd+5Ig6bqcLfvNVjTWxnGy
 T6yYWugzd7ExCzTvVJw==
X-Authority-Analysis: v=2.4 cv=A/th/qWG c=1 sm=1 tr=0 ts=69c437e2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=QOUmeeuX5y9IvSxXHa6D2A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=wJ0dTj9p17mGQU10CegA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: VkBodQp3a3mhR0TuIVa4azdqfeG02CeV
X-Proofpoint-Virus-Version: vendor=nai engine=6800 definitions=11740
 signatures=596818
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=10 bulkscore=10 adultscore=0 phishscore=0 lowpriorityscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250142

Set BIO_COMPLETE_IN_TASK on iomap writeback bios when
IOMAP_IOEND_DONTCACHE is set. This ensures that bi_end_io runs in task
context, where folio_end_dropbehind() can safely invalidate folios.

With the bio layer now handling task-context deferral generically, XFS
no longer needs to route DONTCACHE ioends through its completion
workqueue for page cache invalidation. Remove the DONTCACHE check from
xfs_ioend_needs_wq_completion().

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/iomap/ioend.c  | 2 ++
 fs/xfs/xfs_aops.c | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index e4d57cb969f1..6b8375d11cc0 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -113,6 +113,8 @@ static struct iomap_ioend *iomap_alloc_ioend(struct iomap_writepage_ctx *wpc,
 			       GFP_NOFS, &iomap_ioend_bioset);
 	bio->bi_iter.bi_sector = iomap_sector(&wpc->iomap, pos);
 	bio->bi_write_hint = wpc->inode->i_write_hint;
+	if (ioend_flags & IOMAP_IOEND_DONTCACHE)
+		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
 	wbc_init_bio(wpc->wbc, bio);
 	wpc->nr_folios = 0;
 	return iomap_init_ioend(wpc->inode, bio, pos, ioend_flags);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 76678814f46f..0d469b91377d 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -510,10 +510,6 @@ xfs_ioend_needs_wq_completion(
 	if (ioend->io_flags & (IOMAP_IOEND_UNWRITTEN | IOMAP_IOEND_SHARED))
 		return true;
 
-	/* Page cache invalidation cannot be done in irq context. */
-	if (ioend->io_flags & IOMAP_IOEND_DONTCACHE)
-		return true;
-
 	return false;
 }
 

-- 
2.39.5

