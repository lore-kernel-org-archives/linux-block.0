Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A0A3451A6
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 22:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991286; cv=none; b=SF/MnqNHFGzKZqXfCeo5UGPEq6d7QJYdYvxXUoibD791FIqx0/WHkyC5ATcFvYf2MzfGV5zK45TnGxBTYmsAnkfscmdPC2JYSk+YYvCIRs+Wpub4JL6ZjFc2IeH7qUhxfPeiFZCxV6JbO4/OXS2D8Gf2sPaGGt+vvn7X85BlK3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991286; c=relaxed/simple;
	bh=omRobIYeubqYt1ShRwO+xJfwqyahvimqDH0UuCrRjvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TmWprlL0FEtKy2vA+dxlD4DRFNUyTkQaYsxrIQiksrkYzfKRjZXto19wAp43RwMbFUP7Pr8vh+oR6Jlo9zovjPt0E3DaY+gEhHcNIyjk7D4frbIcc9f1D9IfFhRgTZ1atRWA55ndFgkSPhCuLeNNDhGBgiXKcMiZUWtCzlBUZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=JNZo3tnu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=DyJZhpej; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="JNZo3tnu";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="DyJZhpej"
Received: from pps.filterd (m0499199.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689KYbHl872828
	for <linux-block@vger.kernel.org>; Wed, 9 Sep 2026 18:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=6i89
	u0mptbr+Jh3PRt95XNfEgizrGGtLlz3J/in9MkY=; b=JNZo3tnuLOTjfuuFK6SN
	R9s3lhOUMKEA3JQ6yxj4QLoqkBPKNdx3+WhZgQMRAyWpFYePUVpg86cOMRBBLcJX
	kW4YnPUzaTHGiPzS3X3YwvXA4oFBVxBCPmLWwyNM1rnpDx2wGva4AQWesPWhyV3z
	R7O1nRkXXV5SyNZuxU9Q7Vhq8/QoxQ313bwzrA+RUn8pzt/qaxqDFOzu2F7yl/Wz
	VqxiWUPmJ/wJjz5xgx/BM3x24pt6TeZ6WVKSsUSN7w3LpoXuD4eNectHz0V5mGZN
	3m9MAdRjQTMObbuFiQBXgwRksjXQhwZH1M/jAiMvWgeMbYNlr0VX6p/IbnLCMJfv
	Xw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gkcyb1v1f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 18:01:15 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9396e0515dcso369465685a.1
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788991275; x=1789596075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6i89u0mptbr+Jh3PRt95XNfEgizrGGtLlz3J/in9MkY=;
        b=DyJZhpej5JOKUeLGpaDPJ9uLDj1I/zH56pK0+cZA2CvhhRilaJPbr4Qn/xFj3ilBAu
         E0Pikb7YPcEFgKD+LGz9yjsx4Q1dKJOZKxlvKBLFrgEQo4ZBAJmi63SmxOiv31I9eWG0
         G4NEECEzS2u3H1e0zK6mUOC5AKa7FlWH6u2bY5KiUHx+BOnMv4LIc3Y7qdhG97Bsd2MF
         Qdp4sa3NSkImsUK198SDlOUBixKUBKor2q22yFqY5W12Q1e5izuvk8e4V8V4Kok6qDJh
         u5XncjcPwlrcobZVQckQ28nQXldvYmm2HVOlF2GnZcjlkvF3pm8Roq4nhAu+Uezov75Z
         RQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788991275; x=1789596075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6i89u0mptbr+Jh3PRt95XNfEgizrGGtLlz3J/in9MkY=;
        b=j39PQyhqe4DjzFjHOreNvLxQYqN6DCr/Th4nYDX30unFY5CFGP2IiUNEePCroGrSmE
         VCL5SL+uqeb+9veyRq6fHc/y9jJgb1r1vFbdtnO8z/bY3+M9UM85+J4VcPAJnY/e88VP
         GwQTdE3WZABc4h0MXnSpzefuabtD9e1eVWlqzPNk/XS2Kj8sxnYIA4Ov5MA1PGl4Jix4
         vmUoFhkkzdV1SlpzZ1rcjsq1nKDrCy+otwL3Ac37s5xQHWcqdL/czYLBQDBmfOyrJ/9W
         m2SQ/G68hcwSv3WvIvXkqafhawcySY4teIue+8oS36ZEqB4no2YIag5SvbWG1fj3Uwqg
         0f+w==
X-Gm-Message-State: AFuF++mBlKjP6XSVUxeWuwD6sqNqTpn8YpQZzf0W52Tyl+cRzCLt39ZI
	/Ldme8XUQsTSigEmKbkc5cZnskIHUSJKXGT9L4g1g78JihXlfgpmj/0DM3nj8rl3IlL2egGARzd
	vCj30bYjrf6GO1r725tJl0/f8Zhj3Z97JogsRA43s1n9y5EzSxEmrPZgBtm3g
X-Gm-Gg: AYBFou3VtIHpG+WzzD4/vvWRnuZxIZLLehKvUNC6odjg1CTJ3mN2Xq4u+ppw60ZKpBv
	viWsu1TDpFWN4qRpIiS/EL8eQgacZAX/WgbCavl5J9DS9ywll5beuCgBk1av7wMXhoq9yVUpSXl
	XNIE123SatH8UJyt8j5+pLLV6bxAPP1xOJLYrHkaoNc7VHSMKOkT2HQuurynhT+IxOvJVU3/fPA
	25Z01n1FENmGo9VXxmwEWqMqlFW3GTj9bwdEKeYkELaLrRPhdgBYcZffafbFOwLmPN1cqB/JgNm
	RA8uDlrHL2Sx3mL419mZgjDRD4IVK1X+bO/qnNzkbBHR1Y1yHejhmASJo6NO4TTDM8rDGLf4q9V
	ebsXY4oU2Ex5JyccB0LKs0ISFdhBWvwZO4QXcqyLOCNj/KDRS
X-Received: by 2002:a05:620a:4551:b0:939:6de9:208b with SMTP id af79cd13be357-9398058371fmr4235671485a.48.1788991264819;
        Wed, 09 Sep 2026 15:01:04 -0700 (PDT)
X-Received: by 2002:a05:620a:4551:b0:939:6de9:208b with SMTP id af79cd13be357-9398058371fmr4235341485a.48.1788991249064;
        Wed, 09 Sep 2026 15:00:49 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-193.net.columbia.edu. [128.59.176.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fbe31c6sm1535326985a.46.2026.09.09.15.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:00:27 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 09 Sep 2026 17:59:42 -0400
Subject: [PATCH v3 4/7] block: honor IOCB_NOWAIT in the block device
 buffered read path
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-blkdev-fixes-v3-4-1a5222c6e8ad@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788991197; l=1869;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=omRobIYeubqYt1ShRwO+xJfwqyahvimqDH0UuCrRjvM=;
 b=9Nl/nBXz4hvk3iMfr00Au+HApKUeQvDeZ6iBBKqO9QJ17SeC8ILbrAXylK0i39U56AAhdqk1p
 C3uCDh4Mov0C6ijIxOEQBV2lv/lFui4DUz9SbYFWmHNXQ1PAMkEJOfC
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDI0NyBTYWx0ZWRfX0m52IJRgMQRp
 pHTU+PHN4+ldwHWIZCOiyjJkSruAZyDqU0gWCZ4jFM/zKVyQi+XZ5LOMpGi3+ilgDV+MuYWy/lW
 TCNOZ33hmrAoEpC5LNan/alKIdyxgVG79O6Axd0fL2dk+svg4BK/
X-Proofpoint-ORIG-GUID: rsRaX8_dnqsZJ0ZqCz3mJKbdzwWWPc1T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDI0NyBTYWx0ZWRfXyEJ4sWhTRio4
 5BsZeTeKZzZKwoQNMvAfpW7jkTsIzHJf61RZUTuta3qTggNAIDHpO9oU8XhRhac2AgBOu10Z8M4
 PaBq+EyZGx+PUqTo2SAMHrnaDBQTumHwkJNGJ7t3/ZHUKbeKtl8+bHARfYjatsONNfjRz+FEpFH
 8CP20HjAJxFDEUeVjHej9swkIjLUWGVG3TtDafaRPRDIWgmtdrdjsxZfTKeMaPXB+nQ0BKPyHUa
 qJgNxMnNUJdw6tVUvCyFX7l7WoBaWQFgwVGJtlnVnmZJTPeKPa6el4QqfNb6FN++yI1Nk14sNFH
 /CeAvlzgMoQ8Gb4VyDHVzdV7AGfBQ8xuGIimtz8Ik28c+bj3g72oDaCGZ2N2rSfc/87GFjwpbzA
 1hDWiBnMnTziZqfBaHa6qY07lxLHzAEXAQAt1CdB3D62Q2dIkycRHmwVBcGAX/T3uNeExXPz8MC
 u8Ia1PUg+hKnfZBQXZg==
X-Proofpoint-GUID: rsRaX8_dnqsZJ0ZqCz3mJKbdzwWWPc1T
X-Authority-Analysis: v=2.4 cv=Nq1E4MdJ c=1 sm=1 tr=0 ts=6aa1d72c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=fJxgZNdXt3opHMdyAp+FXA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=G--0XuH5328wxK7v7Suf:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=s8mzj7eOnaliLhoSWqYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11900
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=10 impostorscore=10 spamscore=0
 phishscore=0 bulkscore=10 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090247

blkdev_read_iter() takes inode_lock_shared() unconditionally around
filemap_read(). Unlike blkdev_write_iter(), it does not reject
IOCB_NOWAIT for buffered I/O, so a non-blocking read, or the buffered
tail of a short IOCB_NOWAIT direct read, blocks behind set_blocksize()
holding i_rwsem across sync_blockdev().

A preadv2(RWF_NOWAIT) issued while another thread changes the block
size with a dirty page cache blocks for as long as sync_blockdev()
takes, 4 to 6 seconds on a scsi_debug device with delay=5.

Use inode_trylock_shared() for IOCB_NOWAIT and return the bytes the
direct path already read, or -EAGAIN if none, when the lock is
contended, preserving NOWAIT semantics.

Fixes: c0e473a0d226 ("block: fix race between set_blocksize and read paths")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260802-blkdev-fixes-v1-0-a82fc549fd74%40columbia.edu?part=2
Assisted-by: Claude:claude-fable-5
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index a51814821100..a3a709697b40 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -845,7 +845,15 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
 	 * changing i_blkbits/folio order and punching out the pagecache.
 	 */
-	inode_lock_shared(bd_inode);
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(bd_inode)) {
+			if (!ret)
+				ret = -EAGAIN;
+			goto reexpand;
+		}
+	} else {
+		inode_lock_shared(bd_inode);
+	}
 	ret = filemap_read(iocb, to, ret);
 	inode_unlock_shared(bd_inode);
 

-- 
2.39.5

