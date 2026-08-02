Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D2039CD0B
	for <linux-block@vger.kernel.org>; Sun,  2 Aug 2026 11:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785669305; cv=none; b=S5JoRcIuv+ZzD1mSn6aB57q6+5RyBR313Cd/JRx5fZQsRR8v+zOIOpBnzTEqTqvROWfo7AE3hEugsO/NZKVXPHjt3WA+qnhvqCw7OUOqtRX/y5nYJ/BKozE8Ye2FYMPpj4FGT/jw94Y2c2qVAUA0Vi6GO2ZotZ+jqcXpbW7jcLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785669305; c=relaxed/simple;
	bh=RUAIuCrptX65LAFCifV760DLKbgJfxffGLRjeoThBXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G5Zhnv92VZcuEcaVzRFGK124YZ6FLXVIt04DwBuwiMwivdJN33sC0F1Unkdr4ebRfQcgQYQpfwKEnOkMQn56Zuin/D9azIXdHLiKVkoTrpKfVEFcJqVUbWIgYbelVqktQ+h0qbez++Y/khMy03UVa0RlvS/vrsGRjnMVaFq1I/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=WHCq94G0; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="WHCq94G0"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672AkZ6Y3174616
	for <linux-block@vger.kernel.org>; Sun, 2 Aug 2026 07:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=mUZ2
	YgI/8k7aFpEXSk7k5v2fRQDJ9Y/P+nVYYaC22TE=; b=WHCq94G0qJP9U89bPHjU
	trQgnhjG+tsRMYzF44LEhQzKUrDu4VtD0bvaDUkTq+r+5NDxsnesEuRd7DS2VxWS
	SC94IN94uVZRE1bT5k35iPjdwfc5Rt9vrk/9Ngde7JjhUZRMiA+UQTRblAAwFIng
	HtDVZ3o4et8NC+98dQ193PgL3gre1eVC47sNt0ioNjfqDnNSsK57JKCQPvJ5pfKL
	cBpxtWuBUKGPNoGluR2v3z/qe9KgKKWCFbPZ7mEZ1gYaHDsC8fx+9P+9FvYQ5UmD
	86IF2ZvV4TDfcSz+KPkILMTZkaba7fNHJMs1S15ZehcFGeVeULMlHncxzGtAfDcO
	TA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fscuwvjsu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sun, 02 Aug 2026 07:14:56 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-526da7e3c9dso21211991cf.1
        for <linux-block@vger.kernel.org>; Sun, 02 Aug 2026 04:14:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785669296; x=1786274096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mUZ2YgI/8k7aFpEXSk7k5v2fRQDJ9Y/P+nVYYaC22TE=;
        b=UyZo8coQ24EmXD8YQMZRAB7Qj7ODJL0ip4O+4qdZduIXw0bBtYb/JZ1Cu/D6eZWn5s
         xxOGucOlGEbf1MXE+NwHCdbGN5DXNp/wCxep8jKPQ7hzZQGqQUsKRJqvkP+jjCRUWlPf
         +JRMNFmQRXMJKlkCWchbZq8Rw4lhvpSFERpsIZiqfqe5eF0XtM6OD7h/PBFLO2Ktbxug
         umjTvGhR9gfw/JtiAC08V/o8hqvPYIyuyBv1hEG1Lxakfc2cMq+9TM9IxqP5AP2EqfEW
         N29jsbpUfKwZcMG68UVuU3jzOwkKxSOe+FDzgEjZEnK1Yd3xSK8VmRXwi+Y8gyhyR938
         /FCw==
X-Gm-Message-State: AOJu0Yx73a/hRpTtubxf9jv70KNB9gN9LI+mcIVvLBLhJ7tR1OevwqU1
	QkLBQxmsOWA5s1j03kOqBSllC+ILyjG07hPns/HyJpMykpMngWdK7B3xiWtTpQNHjv8X77TgsQn
	sxJF7Kux3e6GEhQBI0c2OjzARwl7XPACcK6XREeg4xcOs3Fim9A0DKDMwlG3PLohH5/qN
X-Gm-Gg: AR+sD10G/2a4VkPmCEX0K70ZfjbwCqHEavIAcNGdr4qhBVz58dbfSO40CdVpTxwmlHW
	PbEZdFUb44aHG+Zm6V83Jnm/lXrpAMvHrfNIsEmwnKGcqKP1W6yNorUZCnVjcmmez0PFja4x9x/
	wBojy/dBRpr4LwjdZJhAykhPAXFPDK/mL5H8Ov6g9B2RnYvdjaWkrPfT/fOYyN+U3tp0LoK0GlM
	4fJq6e9scQF7i/NRhEmRAe7S4N3WO4uT6KpJffZQ9nimzIMhooJNoxnMc4WeOAzGwtXGthOP2YB
	FN3TyKK50tN7y76IvUBeiSn+KdWKmlOIDK1B0k1TbStPKTcnhh3Lb4k1c4nT8YkRfgyjGJv9HEY
	S4DzwoQInLWZCY0axPWwnAMthwDrRLS8WJeOuPUq5k9GqARRhWLM=
X-Received: by 2002:a05:622a:2612:b0:517:642c:8196 with SMTP id d75a77b69052e-52b566db0admr135726021cf.12.1785669295632;
        Sun, 02 Aug 2026 04:14:55 -0700 (PDT)
X-Received: by 2002:a05:622a:2612:b0:517:642c:8196 with SMTP id d75a77b69052e-52b566db0admr135725601cf.12.1785669295187;
        Sun, 02 Aug 2026 04:14:55 -0700 (PDT)
Received: from [127.0.1.1] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b917efsm208062155e9.11.2026.08.02.04.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 04:14:54 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sun, 02 Aug 2026 07:14:26 -0400
Subject: [PATCH 1/2] block: use iomap_dirty_folio for block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-blkdev-fixes-v1-1-a82fc549fd74@columbia.edu>
References: <20260802-blkdev-fixes-v1-0-a82fc549fd74@columbia.edu>
In-Reply-To: <20260802-blkdev-fixes-v1-0-a82fc549fd74@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785669291; l=2035;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=RUAIuCrptX65LAFCifV760DLKbgJfxffGLRjeoThBXA=;
 b=qSMB1xarEAqvwZMzjxQ+siCbuBZakxZ9sTK1x690CWKxR+GfjJMuowX/fEvp3h5h5ke7Z7BqQ
 s9BZUV8ZpGXAVR3YpjAl0Q8uM90NVAPtPuwyVUQslBEmNpaLmD5oC4Y
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: 160YT6rB8X7azsjISUIaC6wZh3roouZR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDA5NSBTYWx0ZWRfX6kpH2orbk9Kh
 oGan3gobO7MpSKweQzZuS49YIAjLVzAcZBjM+QCrvfr9qW1mYtLxw00fTi0owKGn56166K5h0WV
 GQ05c7g6/kQh/9lgbVm4+oykiVZVhHStiWL/GFBJCmuH1mSI0Rdx
X-Authority-Analysis: v=2.4 cv=OZmoyBTY c=1 sm=1 tr=0 ts=6a6f26b0 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=NEAV23lmAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=k5QuxOG1Ln5ovoWlWFUA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDA5NSBTYWx0ZWRfX+8vpiuels7PG
 DrJcJnAfdbwvlQJwceUzqS1RmNnR5ZMeRTMXkhzSs5Si3GXhCVd/nXCO+0wTeCKo4ryzUFDTCRf
 6UUBQB0h+RSbuPFhagclfbZIy62RiwVO5zRXlTYsjqk35/rJzWaRZpSZU9YsURY/1e16mIeiKR9
 oUZyxLQW+rY5LrCQaVVCul7vL3Bv1xvtBdWNDMqtqx5oNFg88kkXnwscXCzIZMlXV0+c4wlfWlq
 fv56GYkD/spHIVZzNUGQZkEI87wVJncNC1S0Pq1YEKxl/Hy97gN5hsBtbxy4rRZpy3cNYw0+L1y
 uJHJlyLrBiY9zin+rkbkvWj806LJPRwMqOOmC6tLeRd4nacPimX0pCZtZopJBJGyOVv6V1Xlv0L
 JaCG6mU21e/qsZpF2jTIZ3r8wugU4ybpD44P+n6ND4EpUFnytSjks2q5aLDaKh4JMLjxAEJwicT
 0ZVaAlpZVU2PlnkZOOw==
X-Proofpoint-ORIG-GUID: 160YT6rB8X7azsjISUIaC6wZh3roouZR
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11862
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=10 lowpriorityscore=10 bulkscore=10
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020095

With CONFIG_BUFFER_HEAD=n, block devices are written back through iomap,
but def_blk_aops uses filemap_dirty_folio, which only sets PG_dirty. It
does not set the per-block dirty bits in the folio's iomap_folio_state,
so iomap_writeback_folio() finds no dirty range, submits no I/O and
clears PG_dirty, resulting in data loss.

Other iomap users set .dirty_folio to iomap_dirty_folio, which marks the
folio's blocks dirty before calling filemap_dirty_folio().

This is only observable with block size < folio size. With a single
block there is no iomap_folio_state to get out of sync and
iomap_writeback_folio() marks the whole folio dirty itself. For a
page-aligned device, this may require using the BLKBSZSET ioctl to set
the block size, which requires CAP_SYS_ADMIN. A device whose size is not
page aligned already gets a sub-page block size from
set_init_blocksize(), so no ioctl and no privilege is needed.

To reproduce, on a device with a sub-page block size, write a known
pattern with O_DIRECT, mmap the same range, store to it, msync() and
fsync(), then read it back with O_DIRECT. A reproducer is available at
[1].

[1] https://gist.github.com/tzussman/18ab05cba4b3fdc79cce0a69d1fd05b4

Fixes: 925c86a19bac ("fs: add CONFIG_BUFFER_HEAD")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260730-blk-dontcache-v7-0-3e8e6850068d%40columbia.edu?part=5
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 15783a6180de..5b938f673d4f 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -558,7 +558,7 @@ static int blkdev_writepages(struct address_space *mapping,
 }
 
 const struct address_space_operations def_blk_aops = {
-	.dirty_folio	= filemap_dirty_folio,
+	.dirty_folio		= iomap_dirty_folio,
 	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.read_folio		= blkdev_read_folio,

-- 
2.39.5

