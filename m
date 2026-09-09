Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3BB38DC47
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991210; cv=none; b=mYqaBlDT4XyaE6wzwoXGhcNTzaJedyVDCONp/c6jlwDAJKK7Sa0y1YRz36Z+d/VyAjpghT0EM6v6QJm955IYUqo02bZKfOq6bBZmpn3OTq7V8SOKGx6b3Mk9nwhn6RyyS+bB2RnGpQPilXWufxyx9wRAyiTSXemPeu6TPCYhQAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991210; c=relaxed/simple;
	bh=c22FXI/yBAiFiP+IXJLY78+gOs/orKSY6ViRpYhhCRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AeOUyZeWER6GuSBc/4/2FXf/lC8MzZAqT73HpTlkvgc4BPWDcbU0xrXinkNHNy4j9GiSOodUEvdU1oFv92budegZJHzeuF1WsS7yRM2AtMCO+cm2lMM0hWubkkhAOeCvFcLnwXQ0XEaFFmp07LYYTteORFS1LZuUUg2RnCzkmow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=mELivoFW; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=izZ2w6BX; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="mELivoFW";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="izZ2w6BX"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689KYm5V873703
	for <linux-block@vger.kernel.org>; Wed, 9 Sep 2026 18:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=GFCH
	X+CoYPEwVk2r0S6WYakXL0Z4yMswhTz3nIDnaZw=; b=mELivoFWRM3Xk/uoxiVB
	P1UaPobKbdIgy0sRf2QZRfBOzKvek30NrIlJ0MVLYyzklHsnZabk8oRRvrpLcEbn
	QVgRGC+2RrBuztyXakAXFhg0zVmj++YnjAquXh95KBNNB7876vMrRLtGi/bvi41i
	FxlydaFqicU0NtQXPK277m0/nJ9Hue6kcrt4hm9C8IhCCQbRsj1qdL7UkjNPhGXv
	hIGF+Ac+1zEZf0dDJ8afaH3ShAKd01Fz2UMOO3UIQZrDDr6HrcGSvzMKhO1l+QDb
	x0tX1pGqbfkhqzxXfp//NLNUCNqOpAefrApyxk0itzGgiWGsdtMziTN+Jx3wkcJi
	fA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gkcyb1ukx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 18:00:02 -0400 (EDT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9393ac4961fso608663985a.2
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788991201; x=1789596001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GFCHX+CoYPEwVk2r0S6WYakXL0Z4yMswhTz3nIDnaZw=;
        b=izZ2w6BX4os50wrqwOuwvt12j9lOlnVzGijRCsT+Qne4r2uXg9wzYmCBdPmbdnWbES
         p2zUyhjNX7TLiEMzFLRqAMjPhWNkhsfQ7NA1FXhZwxKpMcn0d/0yiE4G3NLCZUGI4MBA
         VG7U4tK3Hrv4LgSyzSFvOfkDSsXLqvFDiQbKAMJD0u7pzSU47TTTZM0Ee6fwtlMd11hO
         ngzUyoTVMKF/ygQOiLomHkts5IdZMPmKvtIryIB6yJhTCuZjDv7v3kPlzgodtiN3UBQm
         6Z8D99tAD8xecyaOT3a1sEG3ZobZEg1Z0ZXPwiBUAPsV1hIhhoGPTp9xxBMISJdC2+60
         /baA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788991201; x=1789596001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GFCHX+CoYPEwVk2r0S6WYakXL0Z4yMswhTz3nIDnaZw=;
        b=fisduxht7bjeiZ1JLS4EaNlUBeotUl/iyHAEVM+wMZbwrzEYGvi5uDZSz3m6azhHL/
         I+Lovq28q7TBbmYlGv6K9H+bfMXAvF/8qZOyXhFiWbQ9c2G+E3j9CA9uBt41RbyHWHqU
         9azkyyR0Xh9C2Xu43K4gpmozNn+9GhNB2v/3dguVG5elcYkF9pGLtIXAVou02XtwPIml
         WlhXsbrSLdyKspwklx4IxuWPIhlxKYH5jrUo8KilwJuLsPuz1QgatRTXIuVHE1fzZbAo
         ARavOyvJb+gL7b6jXu82zEC/eQ8m/J0wqB1ft8Uu8PPbNXdzWz6xW0jltejs9m6aMn5s
         3LuQ==
X-Gm-Message-State: AFuF++keRf5di5R1YbjgdwOXjKqNbRXJPM7MfYUrtB/LX6cljxHYcZgN
	Sp3S9EjgiwFsyubNjaifkjdkD0CL24qAStH6991M4xBtzfnPBDHzKJ5gGjNBdHlWOpMD15iugF6
	Q4EHOB3w7HY/YaSwYm36D06z+h8qp8s3TBRQe2Yxcy1HrKZUdgJAgnG30VR/N
X-Gm-Gg: AYBFou0O2qxe6osyZSKT9dfiXw5VKLqAd6v3Zy8dfIiag3/hvm7cHZLs59DP1CPIYKy
	cVmseIyDIVPx8pR86jHBRcRiw6V6b5GFjObrZXa7nnfRXE2XVfK4psCWOkO9mQ7Fh3ika8AOjxA
	mY+44hqsmjDZaevHIdcKVVwz2dlbK84YW9tqIAWoLPirBqo27qKohdYdL3uHGIHiqXVZgeU8gBv
	0qugwUdh5zZ2kgHUj5u0Rk11FIDe3KM4noxrrJ4XDKklEYo0ghLT54g8pdF+NW3uMeTu81kszj+
	G4wWb6SfCos2xcBYoDHkjx9/q8pdWJTWk0s89JFeJ2lq69mjKbINThOc7MNH9iPAGlGiAqkakpO
	cZKCl12QoLXQA7pOe6NB4L75ZmKBVrN6/bD4nNUnprLbi2MWm
X-Received: by 2002:a05:620a:2854:b0:939:6dff:c0f0 with SMTP id af79cd13be357-939803f60f2mr3819823785a.13.1788991201335;
        Wed, 09 Sep 2026 15:00:01 -0700 (PDT)
X-Received: by 2002:a05:620a:2854:b0:939:6dff:c0f0 with SMTP id af79cd13be357-939803f60f2mr3819820385a.13.1788991200828;
        Wed, 09 Sep 2026 15:00:00 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-193.net.columbia.edu. [128.59.176.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fbe31c6sm1535326985a.46.2026.09.09.14.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 14:59:59 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 09 Sep 2026 17:59:39 -0400
Subject: [PATCH v3 1/7] block: use iomap_dirty_folio for block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-blkdev-fixes-v3-1-1a5222c6e8ad@columbia.edu>
References: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
In-Reply-To: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788991197; l=2128;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=c22FXI/yBAiFiP+IXJLY78+gOs/orKSY6ViRpYhhCRU=;
 b=iHokoII25ADN4u/+WlNa0C8AdoUbSX1R/ZQQttl6llmXcfwkgvYlbWun8mQXNqsc1ZZiUin8X
 Qntxha+O6C3DnCTye+n2buX8TPhr80aw2n4RIz/fHGfh2yR6bvMiu7q
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDI0NyBTYWx0ZWRfX8emMYBkiHDv4
 cd1FWi6RoWgUu6AgaMxQ/Uyy9pUMhAgDQgeKTWyIMGKAHYH+xAlvQ6RHJCYOn21fhFSg+xHf29Z
 z4GmBHj139+1rLnECynmRDtoPzxS+xVxJiZ4+J1zFANDgbJR/ryQ
X-Proofpoint-ORIG-GUID: fepSMVY6KjWN7rIIG071UqpL-q__PQkc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDI0NyBTYWx0ZWRfX52kUYA7NlhKV
 mRdWuwOpSFSm/gGKZRKgOBj7pn73lPtJ7CxR9adjNwgMioA6ryVlwYjnSOMkQ2ljTTgw42VeOdT
 BJgNnLOs3QUR7Mc1wWDlSKOGEcE5Xp/Wh6L9Z5TL2Vd8J/MprKfnVYOFwBTIse+tqN9DyoEioPX
 nKm1y1Oa4PGUmspKuKihpaPFKv+sC1kgjc7eW/PyTIj3M64n7xQdJpL3H0D7Ua8V0HmEvwPSWZI
 g3G4tRrcJhrSK8TFA7LrHZpzvGgTr/v3ZJ15ki8G6ixG6Fdkkhk6p9nZ5jH5fgzhCeptbyBDF16
 X8UvbQ0gBiXKSeQk9sfnoB4n7inujfvohnbmby30BTcufTcBvB4eVXnGYBbrUElRPktOa1SDDRX
 El5W/nYHjgsQZzd8oMPkArh6pX4BqmWd4/EHeJVcya/pl8fBmod8PzObF9a2esqEr7HYXWG2JVg
 LcYlsHNAKq3ms0i1Wdg==
X-Proofpoint-GUID: fepSMVY6KjWN7rIIG071UqpL-q__PQkc
X-Authority-Analysis: v=2.4 cv=Nq1E4MdJ c=1 sm=1 tr=0 ts=6aa1d6e2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=fJxgZNdXt3opHMdyAp+FXA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=NEAV23lmAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=lHyHCDWJ2e6pF_oXpYUA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11900
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=10 impostorscore=10 spamscore=0
 phishscore=0 bulkscore=10 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090247

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
index 2ce7c6c4714e..c57784773fe1 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -560,7 +560,7 @@ static int blkdev_writepages(struct address_space *mapping,
 }
 
 const struct address_space_operations def_blk_aops = {
-	.dirty_folio	= filemap_dirty_folio,
+	.dirty_folio		= iomap_dirty_folio,
 	.release_folio		= iomap_release_folio,
 	.invalidate_folio	= iomap_invalidate_folio,
 	.read_folio		= blkdev_read_folio,

-- 
2.39.5

