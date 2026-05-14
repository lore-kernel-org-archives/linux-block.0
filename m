Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994B53CF960
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795529; cv=none; b=sPnfrIf3xu8dx3zugln/tl2Bqb+doQbfc8l/XlUrWNUnFvZJpomtgg/sw0pvAkCA4Tx2BPSYzS7U4f4IaL9+2bBtwN4WAW3VtL7IEPm5pZEWnFZ84GNWNFyiKIRqZ+xbpU8LZcnBaC9eU7vwp19wMsTe6EKFmyfD6BZTsJZPtiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795529; c=relaxed/simple;
	bh=4kYnZvc+owx18DdRK+b0WjIntKdQQVbjejy+2ia87ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jee7UkjakOGspfDuVkZSStw4bAsILViWwUgq9ucPjp1qiwJu7fz3wmRg+ZM+NvTW8nzC2uUgyF12dtVvBTv76KmYQXXj4KQnWLkUcU1w6U2qHJ2er7ly5jR3BSKidcb5uOy5Ya4LVu9gKmQiM0bUQyrll7+BvwAbSTv+JX1ISmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=eZyHj6/o; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="eZyHj6/o"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ELjLna341036
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 17:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=3Hr8
	xytd8pzj0HErDwC1OWfZgJX2Msw8AYmLwQIxWTo=; b=eZyHj6/o229FuGb6obFP
	y01//iQN2R10GEr4qVdWRAcKfbBn39iOW7pDeiamYsItYvBz9nE/Pon62/FrHbRT
	ca25JObOyp6I0YgF1LVja0LAoUrXTH8PN4c9FaJLVX4cocBvkgvr8P1/bXRUtYEU
	ezdeGP/xD8FpSO71pFPt2m+7sM8WNaM3qd7Ykfu81marJvVKRJ43F9LEndWsCW/H
	RNqSJjAMDbssaOoJUGGgGwOzvmON7E+wXPvY9wvASbmqJ2uqaCGwOtc7KTVgCX9l
	VxxXI7XPNFK0AnLfKFz1TVkvCMAgh/s6LpNCtKUT3llAjiwNjZdOQCTCQf/Jzy6W
	FA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4e5m22sd1t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 17:51:54 -0400 (EDT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-90fc0ca47f4so35723285a.3
        for <linux-block@vger.kernel.org>; Thu, 14 May 2026 14:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795513; x=1779400313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Hr8xytd8pzj0HErDwC1OWfZgJX2Msw8AYmLwQIxWTo=;
        b=RMNA3mPKFEgPhbmIpcXpm0mlixWD+mdXEy2oQIuW88zpixUGaaGX9fRkClqw4dsfkE
         jaKFs3I2Tj8BnzyKq3in/ZpDNng6Uh1/PjYdUuvS6ENTN+KHfATbt08rB6sq9zigHCU/
         wzSps26WMQYg9wtR84p7NlnKlmLerKqZBSyVARCHXgzzEyFEBbLh+qjf7pE3bGcvavKM
         rQCoMG5VwBakE9BppB2eGs34yXxONUGQes09Dm/osEPjYJzcMVtn39yqsdJfV+tRRN6A
         MH+AgfqGf8BtJ/20S4QKGBWMn1vSwlLx5TnlKFkKvbhV7x7d2HvCAqAJEWvfaArw8OQw
         B0Gg==
X-Forwarded-Encrypted: i=1; AFNElJ/5MQlPBWN6IRqAmgiFY6pNlsstHaqO78ZLrWL/JW1bhNG9JedXJjw1jC4gYuCG1C6CT3dUUWMZNoq2cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLalIxqAoI2XnMdFOWILcA2xbvRMGdF6EnFFa8SiFNizY8Ctpp
	3jQC6PyMEIOrmLIxnGFBKQiyt1b/j6RXVH4BI6iqgkWHsqMTzv6pPpLMI4pRWDXU6UhrBAnmzyo
	KrKAkcbly+Nij/EPS5QT2CtpDqjoTXHUSTl4/LIACgXMfCFvQ54OD7+mqICiH
X-Gm-Gg: Acq92OFjCsfZfXgKuqQj4f/WXRtFIDfB7T6BfwCyY7zcCGhwTpPVqnIqOFTbnonXdDn
	/yqTNbhf+e9RnE/yqsztN4o8VH1/KVVK5xUvWm+vpwxV7iN8JLwh17kxdcBJc0Y5ah3+i5lB8x7
	zQqSgFLbjO9hpL7qIbzV5dA4yNrgq7NBsQ5gFG95QRY8ZAZ1rmYQMKu5DK6iMP7cBcNdCbi/NNX
	/fneix5wHE+jPSgb60GfJvg6uM94AiBLBigZFOqLyhgoikJ+Gn+3NiM7aa1KVsGfcLUoqrrPv/f
	ycXpgbLrscVgF7GxbiZ+wcuCN3CYrz0PmYlJHxY9uIUE2RtLiwRtFOY7EjUxHOg67gQ6NmZLSj8
	FUnNdMC0+o6aBGuennbmHF2JEYoSwP6S/
X-Received: by 2002:a05:620a:2987:b0:8eb:605f:6cd6 with SMTP id af79cd13be357-911d0c5d023mr239924185a.60.1778795513396;
        Thu, 14 May 2026 14:51:53 -0700 (PDT)
X-Received: by 2002:a05:620a:2987:b0:8eb:605f:6cd6 with SMTP id af79cd13be357-911d0c5d023mr239919185a.60.1778795512909;
        Thu, 14 May 2026 14:51:52 -0700 (PDT)
Received: from [127.0.1.1] ([129.236.229.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba18132fsm354966085a.6.2026.05.14.14.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 14:51:52 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 14 May 2026 17:51:17 -0400
Subject: [PATCH v6 4/4] block: enable RWF_DONTCACHE for block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-blk-dontcache-v6-4-782e2fa7477b@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778795507; l=1606;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=4kYnZvc+owx18DdRK+b0WjIntKdQQVbjejy+2ia87ck=;
 b=h/wC1HCfLFItwTEGisusw9jduZm6p1jTrRpV6ed4zqtg5o3ocYnG/8kC6WqedCRsxxH5uzIMI
 xkDRAyq8KAYA0Vpg3tuCs1ya2+fmJNNoRSOmfuMYQk5UpCQHPwkaVV6
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIxNiBTYWx0ZWRfX/SJrokBRNdTg
 SyZ8vEmi6m4MtDPDJ90kO4KubBsQizIlEtUikra9VzkMuuL7x81deGzz0u6S6LEkDYkf9sZcQ30
 BKc9mSnenWzImC/C4bXUNxSENaPR6qg6SwCJecD5cV678/lsxN4N4QT5SKW1ANXUMkAa9IqTA1O
 0jQabrE5zIcbLtooSH4pa3YqrND7iyiFqYH2W4pTuo10HY5jFMOL67gPoAT1gj0f4zdv4g8fq5o
 9o6Te4oYkxu7mvgDCKIHiUm3YoKkq3FVQpZeEgeIducHcWCagRdg3wcfhfB3AeBb51IPg+3GHth
 efS61yuuCljH5EGvA+wKhZRqdR8dZYNx0JWyQYV3hz9pbFoO8+wkFKiWtZ1j+RtSs8gX6l7pGyX
 Zezw+UOUXavPuFiOKmwMMovgTazJlVkQRd68mLDYtnGgYkwY8nELXj5bpHie+ZE0gNBkwVwMoPC
 b36/3Zp5qSz4V9oQkvQ==
X-Authority-Analysis: v=2.4 cv=Je6Ma0KV c=1 sm=1 tr=0 ts=6a0643fa cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nkegbr1AwBRna+m8FBH0UQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=hW3giJO2Q2g30DqAd_4A:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 8Z4TXnvReIh3yTdT9SqhvuxahNdiKjBQ
X-Proofpoint-ORIG-GUID: 8Z4TXnvReIh3yTdT9SqhvuxahNdiKjBQ
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11786
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=10 lowpriorityscore=10 bulkscore=10
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605140216

Block device buffered reads and writes already pass through
filemap_read() and iomap_file_buffered_write() respectively, both of
which handle IOCB_DONTCACHE. Enable RWF_DONTCACHE for block device files
by setting FOP_DONTCACHE in def_blk_fops.

For CONFIG_BUFFER_HEAD=y paths, use block_write_begin_iocb() in
blkdev_write_begin() to thread the kiocb through so that buffer_head
writeback gets dropbehind support.

CONFIG_BUFFER_HEAD=n paths are handled by the previously added iomap
BIO_COMPLETE_IN_TASK support.

This support is useful for databases that operate on raw block devices,
among other userspace applications.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index bb6642b45937..31b073181d87 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -504,7 +504,8 @@ static int blkdev_write_begin(const struct kiocb *iocb,
 			      unsigned len, struct folio **foliop,
 			      void **fsdata)
 {
-	return block_write_begin(mapping, pos, len, foliop, blkdev_get_block);
+	return block_write_begin_iocb(iocb, mapping, pos, len, foliop,
+				     blkdev_get_block);
 }
 
 static int blkdev_write_end(const struct kiocb *iocb,
@@ -966,7 +967,7 @@ const struct file_operations def_blk_fops = {
 	.splice_write	= iter_file_splice_write,
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
-	.fop_flags	= FOP_BUFFER_RASYNC,
+	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
 };
 
 static __init int blkdev_init(void)

-- 
2.39.5

