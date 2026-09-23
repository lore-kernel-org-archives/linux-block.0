Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5203F4101
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207819; cv=none; b=lHl+lwnON8rSSxX4hsgQfgVbYh9RI+JEMpH5m+W4oLVIhzEtD/02KlTQCTtd/huiTsId8MmHWtsKqAflYAhgV7hRshFX0BH4s7/97xPPbB+wIqhl7vkMnVKyfF4VZKzZIV+gpS25rj1KKzH5YTomtiyreSu16Cw0S30G2KlbYf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207819; c=relaxed/simple;
	bh=i12hnJ0eqOMt0VRMSQ5nUYBLPvQvZ5w4YLNVMjTdOTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SEviwErsmftvcyy/cfAvoOy+n/0RpaAHkvvVKWyGJVIT/38J94hsmqlkg6vP2mEs8KHD7cVGpr7rvWci+4wL3pDfVnpJMpFp+drogc7alQs20EYCREwXNSlXgFchNvUAi2TRC3qt8oI4daNMsLm9p56DwBjmvtW4nGtbG0vKZAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=U5B9wdvA; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=wsfOhptW; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="U5B9wdvA";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="wsfOhptW"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NND5Q81941933
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=ax67
	jZ+b44nKltzMuzfiZafq22t+/L44VnfnOiPTRO4=; b=U5B9wdvAwn8EGEb50qKv
	mU3/ILHiIcbU2jjEyu6isl0KtpIiPDbLdk0j1k0jXSxgoms/BHcJu1ivdEokEG9G
	Uhhu1+zOHlFXFhF8ZvX4aEmDQVrVHCrxvNyVmeXTzoh2ca/y3raPqV4WAlZG2bKi
	11VW1fvFAUTEpOqj/dkRvF5PguLbPgdILN0E9ZSSsQ2VkWOUAbtOCUrKIeeU9GZT
	q/RBVbL2PvfztET+BLI3RoXd4rjoCaEa8KlomXJ5UWmS1aGOIjCZBPXJBrvhjXDx
	/mIKIHAV8R/+3GQ6Hi4ysT7ekk0SQapeycLTGiUCCKf34N70zZnq61WliYJStxoz
	zw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gvqtcrbq3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:56:57 -0400 (EDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-395543dc382so1498686a91.0
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 16:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790207817; x=1790812617; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ax67jZ+b44nKltzMuzfiZafq22t+/L44VnfnOiPTRO4=;
        b=wsfOhptWLUzmCDnAvFWqmVX/Au1tdOzvT2i+jYLQvOZ4phHE5jCPeOdC0QbYw5rOee
         rZzVdmJMM/QjjoWBogpDRuAGgdjz9+D57td8klMZhivYx61q/ONK/H3IS/84/9KdYph5
         +McLw7arZa6Cp9wiJZIRiPxeFhzKttmGLlzcES3nkT76vze+6pUGbJDnoZo/RBN0ExE7
         cwNzVNwoL15gBTzvR84Xu7KgHJV3+oM3p04B4B63SpGRGO/XvoBvy/psWiruOyWkClaK
         k7Tw8CKllMjP1dCKovbyLAMKlZVaVzILvVbyFbdBtSD1ZF68YddYVXyOmIzdQuqFzUg7
         QN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790207817; x=1790812617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ax67jZ+b44nKltzMuzfiZafq22t+/L44VnfnOiPTRO4=;
        b=NnrmFml9sZGJXfyd060U9vF+s6tLkOb8yBI+TUSKMGXxHGp7WOeFN43ySmD0xbE8nG
         8Dgo98kai5Omrzf4NGEF+P35r7Ka/2rYAsjCKYLr1gBtZFCw+OQkaaE/5oFwQUMMGvEW
         02Pui4rN+1ubN1TQFX3jLTmWgR82thL4w88E5aATVXxtwWtB81qnDHFhWGypAx9v4Iqf
         iWi+IDJcOlXw2DW4x5J7Qxzc1hRH9jATBbvXV1AVSRNiX01ul714gyganz7RJeRWd/mf
         Al2Y3MvRhwXlJuO01X1nKJXh5cg+uf9O06jSR8B7CMOpAUbwN3GwPraTtAkZ9EFv1Zxw
         3qTg==
X-Forwarded-Encrypted: i=1; AKwUvBylXjsEUfv9HsVMr24QKk+0kLaQnWytKMp8Zp/VzhcWijpeTCSj6rZTghWnfLxN6dBG0/lA0hvjhmp4Xg==@vger.kernel.org
X-Gm-Message-State: AFuF++krD/tW500ftrdQBlNxhvHNGuinXfVg1jD7LrlV6464UWOmEokm
	wCEKkK4KIxf0d+0aZ+Lzq0EGegbdfsojpFajaAfyg+5CE3fVzNODTY2NFw62mCpMWzYFNCnDDiI
	VgTDphBnOm1e7XEABXaXq8ndr4MWWeo0AQsrtx76D77EDWUCWu3sVYiKDCa3S
X-Gm-Gg: AYBFou17G51rdM/9G24HyM5hXFr6gCpKQCyVYl50eF89jC1kc1QoKgQ4sjipBGSr7zW
	zZZABuQ9As+skZuylPsd1BRJ3E05LIsqXwG0n/0cSZgfQLZX3SelJY4t5apsrptsnobMGfilH0z
	MNcv9JrqulzcbqQ9dbPEKmMSZWyBv3Kt5ugGZvFaiH4UG40rFxhepdZjmryWGasVT8egv5ESgcC
	b2PFT1uShoyCTiAT6DJ326vJpBGbLm1ukl8e4QAxXDGBYpRRo9JuVzDULJWEKjVX+e8bTuaoAMd
	4UUyZkduIuLBiUrUP0wiiSrj9It6cF9WyIo1Wzc88nRL32gpD4zoz/hCA0E47t3M9xHfgXch5ar
	CvwqGy+Dzs62rW7MfnDmF1WWK425m7HxmTA+ZCmm1RzBA5Q==
X-Received: by 2002:a17:90b:5807:b0:3a0:8050:2ec5 with SMTP id 98e67ed59e1d1-3a0985be2fcmr563444a91.12.1790207816856;
        Wed, 23 Sep 2026 16:56:56 -0700 (PDT)
X-Received: by 2002:a17:90b:5807:b0:3a0:8050:2ec5 with SMTP id 98e67ed59e1d1-3a0985be2fcmr563425a91.12.1790207816377;
        Wed, 23 Sep 2026 16:56:56 -0700 (PDT)
Received: from [127.0.1.1] (RED-LION-HO.car2.Seattle1.Level3.net. [4.53.155.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm1331613a91.14.2026.09.23.16.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:56:55 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 23 Sep 2026 19:56:34 -0400
Subject: [PATCH v5 1/9] block: use iomap_dirty_folio for block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-blkdev-fixes-v5-1-89e60d66eb38@columbia.edu>
References: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
In-Reply-To: <20260923-blkdev-fixes-v5-0-89e60d66eb38@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.garry@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790207813; l=2128;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=i12hnJ0eqOMt0VRMSQ5nUYBLPvQvZ5w4YLNVMjTdOTI=;
 b=R1EL1ScX2aVYbpHYS0yrNGfXhtAVJe9OIq3govPDMYOK98H2vXi5VkQ/PuISAl9x0AynVtyKf
 yFgkE1ENpDOAsxbyiP9gCJJi+T6K0FFxraeu19m6jAssaHCY+Vpo7jV
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfXx3OtWtkhMqBj
 Cr3YjyGiP6FSBVYnV4bUOU80D2uXcGbkjMxOznCoiaqN+c+v6Szsk53+YszQZxHXl+bh/6bpQsn
 M78hOSZKr3RGObPMjiCqdsLrtI9TOhFTZRqtDFKaFHnFGrrL/jEJpF54ujRaMYkg8ToceROY4yq
 WcPgUnWtNHkU5iqTiBLj4SF4QvfKImGX3lmzuxDJDb3L0r54lple3njeNwdnAtyzszCscCLAKe4
 gi558cRif4Y/7P27z0crXUJIIFTRfbgfonOWExZTFzdkIy7h8gFnCLOjzY+HgF0QLmO0XBFXYd/
 LmG7MavQfTVF8g3wnnhSNcWmyIxruY+VXuZHT/9xI82eDsuP1EoEND6tXfKIA8oLLJNZRb3XmPN
 PldDjS4JBpaXYEhy3/xuLHBJvYE/ZE45X409MGyTppqWKL3VIu2rNsi4Fw8+KH0wywUs4R1MJ9u
 8RiQR/kgnuBpR37de3w==
X-Proofpoint-GUID: rMRt9_V2pdY4KYOVv4_9IaC3DZKabTKw
X-Proofpoint-ORIG-GUID: rMRt9_V2pdY4KYOVv4_9IaC3DZKabTKw
X-Authority-Analysis: v=2.4 cv=LtYHWXdc c=1 sm=1 tr=0 ts=6ab46749 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6aZ3Ysb2zzbY2sELL/OBJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=NEAV23lmAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=lHyHCDWJ2e6pF_oXpYUA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX4EYhxeV65Ygo
 /0k+7CLkIuPug/k+AYg+IzgJ4KZLF32MpOlUKJ1mTZmajPOtUiPjRYWCacd+loqJPaq2DLag6hx
 7RSzgh4LgvmRG1gJaptxoJOnV/njfcOQ/UV3h9n76rdEmkAmhxmx
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=10 clxscore=1015 malwarescore=0 bulkscore=10 adultscore=0
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230100

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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index c915ec0126d7..8d74d0e57f43 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -565,7 +565,7 @@ static int blkdev_writepages(struct address_space *mapping,
 }
 
 const struct address_space_operations def_blk_aops = {
-	.dirty_folio	= filemap_dirty_folio,
+	.dirty_folio		= iomap_dirty_folio,
 	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.read_folio		= blkdev_read_folio,

-- 
2.39.5

