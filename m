Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB943AB47A
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 02:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045661; cv=none; b=f+ZB+hIrYMdt5KleSQYbEJs0P1khzmkHbmKfvg1q4VvfCaa+l1Mt/HFpAH3teo3iZi+gfO9a5z8R4BsbyDlgf37jRpJBV6Y6A3grMZwb376qzTBzA3W0blfXU6uFTfu7LmXmXnIsGGn5SzCRubifxY1waQr7tk/d4uyG8h07SlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045661; c=relaxed/simple;
	bh=c22FXI/yBAiFiP+IXJLY78+gOs/orKSY6ViRpYhhCRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O1roGRdclocKfqiucxS5Yb7xK6SxlV5JnggJzrP+R4St16U4vLKvj6VmUV8+5PuKwbinN2qbyMOEZC2V71b7agNbE3qCJDTSisclGu5Ik3w1U+VtZkDcdZKtz+hVcnwxoFayUF6WeNjSmFDwQSZR0Dtebx03MJl1XjJrKhnA4OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ALm5Erja; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=1uPSm7St; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ALm5Erja";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="1uPSm7St"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M2X4qS1444324
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 22:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=GFCH
	X+CoYPEwVk2r0S6WYakXL0Z4yMswhTz3nIDnaZw=; b=ALm5ErjaR7B0g25ne9Cd
	TJH4de4s9Mpn6ImW+vl4AkjIz6Ij2PecbQqdNQP/+h+PwYQrSzyuxqhdruV6zKWv
	1IK1gqeh8MGor6+ldLOx9p3TzJxgS1cGAH8Qc0XXpaj7VsIocfCY6WT1iscKjAYO
	tkzYcEMfsyrMa08YDTH3OfqyC1nioks6atP9SrVwF8yf7z54MJC92AjeVYvUdfXt
	Wy5SzdYf3DJLCEsafhJRKdhcVdiFmn/TuFDTv/MbmgQg58yCcEFNl/6VQKqishKN
	awQKlFijrsjSVH3/DKOacNRfDARmFPlfv+Zw8/vpakfq8+O0eF7OCnEmO6B5ChTv
	6A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gudres2sy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 22:54:13 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-530f9b8cd29so71635061cf.3
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 19:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790045653; x=1790650453; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GFCHX+CoYPEwVk2r0S6WYakXL0Z4yMswhTz3nIDnaZw=;
        b=1uPSm7StHJeXbA4Zl4+3+b/+vKFMBsYisFhQ4EUjuThyugQsHnCRSNCxsBpvzccldr
         8S2Si3prGFsS7907oLOII9oDP7LMqDBlAeiMdQkxKMbxPZl3dCwNUGw2YsMNaOTUkWpr
         tipJDtvCDntBv5MBxlmIQlIfWsBGzgbX5lbfDhEOkpOMGscVdlSCk2mRpXNY1LaAiQf4
         Jhzi0mjeZ0f8C7t3svaLj3TsyCwqZd3a9SWL1n36Cm/B/Uz+ACjgv/p+7dY9WSx4G9Hk
         v0gzDZE8Sik5dHrBqOO+msO9r7YBTIqVHeZ4Dk54NyKJnXVFiaKbL8CQ2VKWNqd6asQf
         YsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045653; x=1790650453;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GFCHX+CoYPEwVk2r0S6WYakXL0Z4yMswhTz3nIDnaZw=;
        b=R4zsLaEy5kun8iaLP5+7KmmawkKFLc3ArpPfDrAsMjUaajKc1+1WxyxlxZSQ+ozc6P
         K9/6dHzyLO7ks0WMHUCXg0AIZELx/gOJKBkjuK5joxETW/caomild2w3QfDdEa3evCVf
         k0OJfO9O9whPxMugtLqbXOvoxMXoSl7j3s9r16kTeQtVq0VgG4SwPCwZ2RSWoJ6gKU6W
         OUjw3uSn8YQPcAsvm8zvNv1rKtuv2zjBgnSOU4EH1wP4ZjPHh6rAnKspFvYbeBkl+Iwt
         WMq6rnhh6KAue/ZYvRfhJt5glUptsmlb9al0G3U55Gv6pNN3HqOm8vUDhMX1hTBDbna4
         NUPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlx+pNwzC52DrYkCNDy/tVlhPB9oG+BOgip1nSyJRVgYjkEJ4rsRNQt5NZ8sAgxG51MBca1zeTSgimjA==@vger.kernel.org
X-Gm-Message-State: AFuF++n2bZHHmwxDAMldGe1txZodojbFQ1imcfuQstnUuZfkgRpvDJc8
	0JhHUR6SqQZomV8TkVO+qKpB7hBtW/0vom9HFOo6Z2nHWJd34tg5NLIBgGUIFTdjMBeNmjnOA7+
	iyXdCFOffHbs3mFHCAlDPpWvo8efwOoK5hTnLCSvGVN6Y12yroeclYszbwtcC
X-Gm-Gg: AYBFou2Udrs65qKlLWZumamPu31b1oH/aFh8wv8G1O1RPX+2wJgpEQrm2ILOWj2nqGg
	jsPkssRm7FLFRd2EnqhCp80IyKNJoSGUY/Nx3Mg3L/Mx3B6ARCobFzSzrX2CGvLMyyAVoTRGrRr
	A5XFwQDDtsLobdOezgBpGvbKj+XqIcdsNLUh75ng/e47Shl54VtmZZ65S9A/p+RpdT0nRGen8cs
	aEUuM/EZA9yPtN79FW1IGSzT0P94LJeykcHh5RoLnUiNKZ2hxyqGHqMgSHzZ+beV8O6xf1FULzD
	fCvUSfThYfJzniwJ7OFjxRbizk5CCiigsQPSHifUcfE/0jOm34uJfbRrO9nM5KNWBzVmkj+OmZM
	XR3f6KpRIIpW+F+Xnv9pt1E2cd+6AeTNjhJAiwCWmJxn9
X-Received: by 2002:a05:622a:4a8b:b0:532:9adc:63a0 with SMTP id d75a77b69052e-532d8e70eb5mr36236741cf.68.1790045652949;
        Mon, 21 Sep 2026 19:54:12 -0700 (PDT)
X-Received: by 2002:a05:622a:4a8b:b0:532:9adc:63a0 with SMTP id d75a77b69052e-532d8e70eb5mr36236551cf.68.1790045652486;
        Mon, 21 Sep 2026 19:54:12 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e18fce9fsm2048421cf.15.2026.09.21.19.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:54:12 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 21 Sep 2026 22:53:58 -0400
Subject: [PATCH v4 1/8] block: use iomap_dirty_folio for block devices
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-blkdev-fixes-v4-1-e2801f71ede9@columbia.edu>
References: <20260921-blkdev-fixes-v4-0-e2801f71ede9@columbia.edu>
In-Reply-To: <20260921-blkdev-fixes-v4-0-e2801f71ede9@columbia.edu>
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
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790045650; l=2128;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=c22FXI/yBAiFiP+IXJLY78+gOs/orKSY6ViRpYhhCRU=;
 b=E0jg/mA+TgCvunpLEHsylFuItt8N7gX1yjeXv6y5xZN0zRIn5xZkffjGjTyRGZjerXFz8MxAI
 f9bAwEccsSeDa6qVnE040yvX+TE7xOTXD62PK5IbDIhlmaGwDs6u4kw
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDAzNyBTYWx0ZWRfX1tLdXubk9J3Y
 zoowqtwu4FwXU+pi83q0oFWQKZHCTE6kc+EcTY8Yzfrh1dX3qAzv0cT4aEVxf6NJ2aIsc1xJTcZ
 AlvhSlNJy53lkf1f4nsWCyCFYX1kVXffqZ8P1AfQKOlWm/JAyoCikwekYxlIski5B8D+UVsi8n6
 gblsU2IydzSSTpUb4ps+2oxdq2yUshgZQpDyXLITb0t4H8HxwdFPtuo0EZoNW0z5nS+zEeyKyNQ
 TQIo512846k3Scy22OXArPWxNFxgzxQ24GEQXF/mgD3eyTkx6iv2+Dbn+tHcLRVa0mdH08qQ3GT
 JqsiCMMSLecnAU2OYe/6Wyca6JKwm5mmafRAz3JtQa/3QPrAgqg2PLsQaXyQPmG73RJ8AQuIrO6
 T3fsNxqW3X9O+fVH+40ve4XlcdCme9RagtV3NclkPW4iKNz1uQzlM+6Yng7dg6e0BkGdzxHw/R9
 dYZyW8tcgzAaBQM8QvQ==
X-Authority-Analysis: v=2.4 cv=be3+w+PB c=1 sm=1 tr=0 ts=6ab1edd5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=NEAV23lmAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=lHyHCDWJ2e6pF_oXpYUA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDAzNyBTYWx0ZWRfXzex0qbL7EERw
 bqcVHyzRqb0g1p6BkHMtrLoBPFDxzpy5PQ7xPgevfca4Oc3PWkYq3fVRigteBNheAwMcZh0n5ZH
 HVhE7LZt4LpZtgHA5uJkxLsIrgTrcLCjDsukbThKAN1K05fy8+Ih
X-Proofpoint-ORIG-GUID: wpH_moqIqGEKin4VN2EmcA2xXYbqRpIf
X-Proofpoint-GUID: wpH_moqIqGEKin4VN2EmcA2xXYbqRpIf
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11912
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=10 adultscore=0
 phishscore=0 lowpriorityscore=10 malwarescore=0 clxscore=1015 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220037

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

