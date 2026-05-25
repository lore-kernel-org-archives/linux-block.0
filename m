Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CFF188CC9
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 18:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779733587; cv=none; b=RWr5O7vwfHlrXVQKvD3BGeEq+Qx6LLrb2D6lMHUVlfhqJ0aszJHqSffxgVf6v/lkAviovD2gw+XS7VweTmsyr1W0Te6RWH8QDtPCHI7RwDtc/awGeHZo1PqBQIu/iZiYfv32Nr5J+jrDopN7U2mR4GtYQSOYvf1qSgi6WtnK8+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779733587; c=relaxed/simple;
	bh=YtvXsYoRDOxv5QVUHgUA7AG5V4yQxClrjbB9/DdVMv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g5oR5hbNzSIkeh9w/YTlekINvDbXWoE7taqmpTgRpOJ8nZDACxRoXJbh/gpLhZdBNFm8yZr61OcXYkFQ/xNvYxWf1fyrpBUFYkiP7SCfB6aW3PzJvwxmfuLP0ce6EtLSxyQncp7i1rFG151lS0kvoYBSjRCy8Idma37aWruWxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Pt5kihg2; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Pt5kihg2"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PHQqOI3944751
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 14:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=7C6HfuZmXSjeoBm5rn0zZzKAlC
	x0pKJm+zmGOCOo9U8=; b=Pt5kihg25R92LZXoRVg9yt2HJQEwQCVmM4QbsJrqgX
	/s9/zMaJ+TtLTMVFql0ROLoBGHLE3V08V5j4/KOjpEUj+HK+C8xzfkDt8RpiS7gW
	0Hg7oWlbdaJR3CXNwXJi+hWNnEJ3WXqHSr6avSIwvoJ286yj+34Wt0WnrqB2GeVd
	rV0XSjZoJ/N5Qisi8aw9ALx3aDga+8Z2ji5s9rdnMJyYt20dfXXDjU4n+to6NSjw
	iTI1SpRCwltIjPt8/NiII+QbUAW02gfVrpTjH6LCEBTDyqp63Zhe6Iuwnld6LiRU
	W1dM8kkCpMbUHMxO5GEBadocgkYNku8t9koAq2Dfvzqw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4ec406pqn6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 25 May 2026 14:26:19 -0400 (EDT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8acb26fbbb2so89654186d6.2
        for <linux-block@vger.kernel.org>; Mon, 25 May 2026 11:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779733578; x=1780338378;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7C6HfuZmXSjeoBm5rn0zZzKAlCx0pKJm+zmGOCOo9U8=;
        b=ky1N3mYJWGaflayyddcJWc08fxln2rGO1TJnAe02SQtx+lLjkfdE7ECKWxwExjjqf9
         c8yQm2+QUAAXaT8IMY3nfvDLtHY0DpohqsGkob86/hLjyeIqe/vf/LgnfBj/9HXX9rPd
         xP6DlQ912OAH9tSyAMW8ux4L1QVrLCw2ZQVQsW67oYHDPDDu70qW0mpJQiGPfHsFPK+S
         8I7ksRiT7SumQk7LpqFh2oFikyq6DACtnk0gkyzTcVJkzKMHgWEMIBZn+AY2BNHolEit
         TyQAFFriLjEfzAECHkRKF3dvpVHl5XWFDmQ8RZu8/jtU6YYg/1wShAwCkQ6SyY68B3a5
         pgKg==
X-Gm-Message-State: AOJu0YwLzg/3miUrAwhkVf+ih80Z03PeZvRk2ARX+SEhc77eUDQplfuj
	p4Y5ywAzw2fssivnwczIaQqGQa3HcVCpcK0MQQeXV28mvD9MxJj3IzUq1qqbAVEpJtehR1IiUmB
	jnzgmNwKWczNJMrngt14hBv2RqrHc36YyLVNLJdVQM2+ndFwikOOqIlrWJXZ+i+MQZuDT
X-Gm-Gg: Acq92OHK5goohVgGkwV2nJqgtn7d4ZmtBNox/igZAr8dfRMX2yJnKCjUsVj8vfnEIeU
	Cu30DVAS5zi5NEowszxUhA3kDYDnVcCB018rRva3z3naytC5KUC1trk8GUJLIzxC8SEujoCLs3w
	pYFcAoojUun9T5ucevacRBoQAPwPAWeg+gt7Fq2TCEUgxI7XLiQgiA4wR2UlHeteottIDADUqLu
	XNS8hhENKtQW9aXxTOx7v9ikgv1xiTEm00otic8VqLKcPgsRjhI5uPKPYNWmOylPzaW0KPve1xN
	X8uDFeA8G9Nu11Nn2CAxVvhuspUWaqI/OrLIhby+PRtkWI81LXRFsvx26kgaE+FYMDJTdnmmIQ4
	sxGqU7/Q1uyLJcKm47IKxphmSdy6iVujdXO2PqHlczLzkzvXiji/xyliUAX9R+jlGgfo=
X-Received: by 2002:a05:6214:1d06:b0:8cb:e63e:2a45 with SMTP id 6a1803df08f44-8cc7b552029mr261898126d6.18.1779733578464;
        Mon, 25 May 2026 11:26:18 -0700 (PDT)
X-Received: by 2002:a05:6214:1d06:b0:8cb:e63e:2a45 with SMTP id 6a1803df08f44-8cc7b552029mr261897736d6.18.1779733577943;
        Mon, 25 May 2026 11:26:17 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e2018sm116790646d6.28.2026.05.25.11.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 11:26:16 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 25 May 2026 14:25:55 -0400
Subject: [PATCH] block: remove blkdev_write_begin() and blkdev_write_end()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-blk-write-cleanup-v1-1-391c073e3831@columbia.edu>
X-B4-Tracking: v=1; b=H4sIADKUFGoC/x3MSQqAMAxA0atI1gZqsSJeRVx0iBosVVonEO9uc
 fkW/z+QKDIl6IoHIp2ceA0ZVVmAnXWYCNllgxSyEUoqNH7BK/JOaD3pcGyoR3JGuUqbtobcbZF
 Gvv9nP7zvBw3pHKdjAAAA
X-Change-ID: 20260525-blk-write-cleanup-afedb5d1ab84
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779733576; l=1925;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=YtvXsYoRDOxv5QVUHgUA7AG5V4yQxClrjbB9/DdVMv8=;
 b=fKI503mymezaQ1bOj/gh7v8flGRod/Duvwa0KuFjAz5NnvQ3JoF3MBqpgTbW79CV77cSPhhba
 rMjKwqc6mkyB5z3t2qv7tplj9Q9Ge2CrDfISNb3S1SmTBbNYMHGHTwf
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: COmlsACvwchTmHS_iG5ql2IFebyzTdPh
X-Proofpoint-ORIG-GUID: COmlsACvwchTmHS_iG5ql2IFebyzTdPh
X-Authority-Analysis: v=2.4 cv=XOoAjwhE c=1 sm=1 tr=0 ts=6a14944b cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=WHal4xhvaHetekjCY9QA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDE4NCBTYWx0ZWRfXwu/0xP98ERBr
 DN8M+BlT6t3r0F0RN+XAhevFHuvuObvGPkIDXSz5fxJOzUDtMismJWEM/Ly5Mq56fZ5sd4dW7b1
 pvLRXvevGgDhY1wJ1zenMK8osD0j2iThBnEWGYL66Wp21nnyOKWsnWDgkmWjwV+uAGpFoPl14IB
 ZPiTfrznh1z/uQWBXYlO63VpDnsxFzZ6gRh9xlbO3UOM7kXDcXQKjXfM3Ssyuy0Zy4aN2i8U1zL
 XvIsFu1S5E4Ou+/gVOZnkgQ+oT3jOD96pwpqz0muavOdkWmVbXBECDSnAn3eThpw918NXFjsE5t
 80PBAusCnQuV1hiD03Mwb5zx8hluVq2uJjCEK1PwiPL9RNbxwQL68e0PUvjRpwTjnRZhc7R7fmo
 eQ797WZbp+Ou0h+7QQgl58KqbiphPd2P89loCKaQTMGTzEOUOZgj/YmBy8CQBdWVuz+mCfNpwaU
 qOeI6EKFG0M5C9qXh9Q==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11797
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=10 adultscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=10 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250184

Remove blkdev_write_begin(), blkdev_write_end(), and their entries in
def_blk_aops. These have been unreachable since commit 487c607df790
("block: use iomap for writes to block devices") switched block device
buffered writes from generic_perform_write() to
iomap_file_buffered_write(), which bypasses aops->write_begin/end.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index bb6642b45937..ffe7b2042f4e 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -499,36 +499,12 @@ static void blkdev_readahead(struct readahead_control *rac)
 	mpage_readahead(rac, blkdev_get_block);
 }
 
-static int blkdev_write_begin(const struct kiocb *iocb,
-			      struct address_space *mapping, loff_t pos,
-			      unsigned len, struct folio **foliop,
-			      void **fsdata)
-{
-	return block_write_begin(mapping, pos, len, foliop, blkdev_get_block);
-}
-
-static int blkdev_write_end(const struct kiocb *iocb,
-			    struct address_space *mapping,
-			    loff_t pos, unsigned len, unsigned copied,
-			    struct folio *folio, void *fsdata)
-{
-	int ret;
-	ret = block_write_end(pos, len, copied, folio);
-
-	folio_unlock(folio);
-	folio_put(folio);
-
-	return ret;
-}
-
 const struct address_space_operations def_blk_aops = {
 	.dirty_folio	= block_dirty_folio,
 	.invalidate_folio = block_invalidate_folio,
 	.read_folio	= blkdev_read_folio,
 	.readahead	= blkdev_readahead,
 	.writepages	= blkdev_writepages,
-	.write_begin	= blkdev_write_begin,
-	.write_end	= blkdev_write_end,
 	.migrate_folio	= buffer_migrate_folio_norefs,
 	.is_dirty_writeback = buffer_check_dirty_writeback,
 };

---
base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
change-id: 20260525-blk-write-cleanup-afedb5d1ab84

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

