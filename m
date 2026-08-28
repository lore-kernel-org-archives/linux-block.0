Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C0246C4BF
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925022; cv=none; b=InMqyK7H52u37V5A3z0ClNDh4ng0oTKtd9qnPVl9Rt5g1oRGNIcNeJ7j8B2cSCyQCfEY0r7mLnLK8/3vpNsH7GGvAab16upU5s4OlZGJGVKn194A3MPB92++04FrSgbrvW2yQ3w3L2xquzhHZbfT3iAz+MmAmhQy8lwrZaHuDOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925022; c=relaxed/simple;
	bh=cvjM2bWwCeJz7HnW+o4BiE6Cy5HEK+ZgZMvk4q0+/sI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aqXYp/JG8kuQWQd8CtsG10/1qtUzohm2v3LyW0gYYFx8Z+HSzUOTL0/TOZtlgc185Q0YCWQpTrR0OGaDOhPHaRgbnV8+B3p6pJrkoQId9wUlM+Z/PcpxG2+pqLWpQQ3BszpJ/kNbg+xY2AlW2AFpKcLTxxb42z5Yk+FLWQrmc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=M3kgtPwo; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=XbrYFfJ7; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="M3kgtPwo";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="XbrYFfJ7"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SCY7gN1703502
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 09:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=3vNQ
	+LNoQmUCg3VgcL1mBrxpYQC65W9r0CI37CzqFVA=; b=M3kgtPwoQ93zAYhvaleR
	kUktSiCzGBXI7k2zR3+L5GiCRipIlReUOtTWyTC63BK8gtPbmAQvgW2Zps0ogDiO
	Mmd5rKNSgXGbRotTd8+cgVc81s2NvM2UPBthobsO9+TSlRGh87qIbRACzxA0oTjo
	kpFWGzjH9DXjdsfQBDBNfxoJlKk5fwfUBz8tsMOaC1IDBTfZawsZ5c0Uw5k4U6cL
	+LGnVK1fHarbLAvAxY/uQaWZMgLJ+Wocw4dN1COAE/W/gokSTozRsIFq+YcFeVC7
	SIEueuBe5FmtyslfRSDMCji7vjpkqYgKTwMKfoJQrSLBCyeoqWVV6Zxdfp6pI/ty
	oA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gatc1d4jy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 09:50:14 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-90ccb6102baso14295986d6.1
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787925013; x=1788529813; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3vNQ+LNoQmUCg3VgcL1mBrxpYQC65W9r0CI37CzqFVA=;
        b=XbrYFfJ7oDb9gs0GD6o6W/gWBPcaFc4cqKEOCMe2YoVXsPTi6BvgeuxftuQgn2ATkb
         UhnM87Cbq8dge68ifCzboV2D26od8+wvgYEPpgg+fAa1CT+MSNCvXF7aCjUUByWJrGSG
         AON22gcTrYJUq7lU9/Gf6xDXUCm9XhuE/bATBnNY/W18ESMCBfu47OUvcWDcZO/OJICs
         uXnMQHQs4HRBkF0QpoUgtAf4tKFvBMSmUTU8AZ1vWeBdLTGCibSBztnP3fyxeJUrFtHR
         KnIzvfUxoB8UL9VyQPAab5yIx2Laz0jmwwCoJi/w9q/aI+IkzBPPUcE316LGl33SUNT1
         pPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787925013; x=1788529813;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3vNQ+LNoQmUCg3VgcL1mBrxpYQC65W9r0CI37CzqFVA=;
        b=X7Mdq9WUxZYQfP/AEroeRneV4OrZRZtH5m8htOQfY54yDVaA1AgDFRGXNReRESW8eC
         4le6ITXL+aKeoA8myC62w1muwNAYdqV4zEPIQsjeEnnIffZGbXuRoXFt2HOuDdW7gY/B
         ShCfUzac1p3b9GO9sHGg/mI78HhbWiA4LjVhqPSCmp7ricRIj/6Xzl0QCrWPAQYbCBO3
         3kKEUv5HT9u8+X66pdvM6QYrHKciLVma9YnILN/ulgNwMKY1BLryeehsxvJh9q+GRbHY
         SDiu8FDtst5CKC+fKYjtbiAigXgSc1PQIyzPKQi+Zl1tfL5UaTZsooO9+cZWYzlvvPcO
         xpKA==
X-Gm-Message-State: AFuF++md4z/qZzA3/a4WROlpHJlvTTCqM3oqu6Z0iIN992gCnu5xvfl0
	yCGJ66yg5YDf0RkcJ6DIo6D7YFatELXCx7a71Q1orn+f3R6Eay2niJVw+LY5s8M4PIeEe4sjF9M
	Piv+fO3LHtecrA0PYapCBeivWCQS10lPvjyfXQi+oN0WRbgetj7MCs5OMG4BQ
X-Gm-Gg: AR+sD11Uw+VBIjWfcpiNY0NO/BhL8fEM7mpuii9+7HCOK6wxGwCWJGfAkNM9CYWESPe
	i/mB8HgRZqUX5tjYY+ks/ic1PL2OBLt8reHSmeNH6g6Yz5LnuLOzAFZKLP+mhoZK0rhkMdHjioW
	5poquJxI5SJR3L+oRYM937MwiPpiUiJQZ6iHaHltzBEBJFFd2zSEYd66/DAHB92yohOsZ8b7tWG
	k81SzCYFsZmcM0AtwwhT36nlVuyWtaqUAZxJVhf8tlKALN81UbCjAAmX4m+2m5BfIF1r52qQqcD
	uk2eG3j6e+sFjZLGvtIyfR06rbVLOFxswGWThFYJbZG2/han2rRHGXu4QLAXJhHEZiJ0X0Ncg6o
	PYnBC5jO8
X-Received: by 2002:a05:6214:2aa8:b0:90c:de81:6e76 with SMTP id 6a1803df08f44-90ce0bdea13mr82677296d6.6.1787925013375;
        Fri, 28 Aug 2026 06:50:13 -0700 (PDT)
X-Received: by 2002:a05:6214:2aa8:b0:90c:de81:6e76 with SMTP id 6a1803df08f44-90ce0bdea13mr82676576d6.6.1787925012771;
        Fri, 28 Aug 2026 06:50:12 -0700 (PDT)
Received: from [127.0.1.1] ([45.130.83.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce4534ebesm15645116d6.48.2026.08.28.06.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 06:50:12 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 28 Aug 2026 09:49:50 -0400
Subject: [PATCH v2 1/7] block: use iomap_dirty_folio for block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-blkdev-fixes-v2-1-32f3f40cebed@columbia.edu>
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
In-Reply-To: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787925005; l=2080;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=cvjM2bWwCeJz7HnW+o4BiE6Cy5HEK+ZgZMvk4q0+/sI=;
 b=i8zsqlqEzBYmHrJwB1M3D8XEh+23kDrso9VTCckZEfshQvH5f8/F9Pzew2miCa10YzGSqCg9j
 uvM9QwyZrWOD0K8kb2ZlIvPguvMz82e7tPysKEcIuBpfgJvx5VF2Z/e
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=JKYLdcKb c=1 sm=1 tr=0 ts=6a919216 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xDWFIMX55ayQNp92vt0S/Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=NEAV23lmAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=lHyHCDWJ2e6pF_oXpYUA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: 4qY8vtEXwfeE0DO40CJXQc5MLISm8Q93
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExOSBTYWx0ZWRfX9CBYVdG3ar76
 I+nKzznvQuu3ZJxImDAjN2bCmaQ4JgKoqp4kVsI4O3E/mN5MaNNpcR6fGYNhv1f1VcvL4snG35e
 QWn8MuprXy3lwaERBS/d4C+ryD867qnLhtMVXrd7quu3YTOI3q62
X-Proofpoint-GUID: 4qY8vtEXwfeE0DO40CJXQc5MLISm8Q93
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExOSBTYWx0ZWRfX+wbE5BprG9Eo
 P/RIGc4YOhHoQG1Ku0Ka/yZx1AcKEaV4PXVDzo+VIbCHMQcJ9ohlox2a72HU+inDdtfDMqiY8oV
 2280pueO6zOZn9bE7Yzqo3YnAYH1XJsuSQQYa9HAFkPX1yFCbHCcEqsiKNObmzQF8BwP0xuexAZ
 BYHqVmrV+1/vBbB4UnJvXh+kC/EMJjLPfWztRHdBPa64G8OF0qyrJ5Fi57IeJjY1EntMVMVVpOO
 sBYpALssNkU4RWGZBRv3sbjsGDHoYoZHoLRgVgVi7KuFalQ1ez8U3+WWdolBTMS2+i8FKvA9Ucu
 JLluaGzwHbciUXHhTKZRz79gXTdyFHJKq/2qQk7PpNY2eVmyi2/HSqCmgOGGgCs+iNZjzKeRVoC
 Vk4/AbJbE7LGKAF1o2HIAXT3E2OlJqRkdGlqlLro5QIoRHNC2+9tUTDLaZMku+dXpT5u4ADs4BZ
 K03pX6EXGCzCwFcDYrQ==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11888
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 bulkscore=10 adultscore=0
 impostorscore=10 lowpriorityscore=10 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280119

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

