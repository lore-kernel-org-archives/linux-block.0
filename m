Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2A440A26
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 23:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207829; cv=none; b=halRAdFp5emyMulnG1V+yQepMF6YmXDiYNBdzRqz0K6ZfSwjXFaZnLcXX5i8aQbGoO7QhQ/mUGClK3qFj+XwVf5/Xl61Fz7ZhaAdEZmvi1QNipuy1PluLoaWGGAFK1SpetRguLsPwUJhkLEvjKoGtL2yWOuN8Wzc2kaBO4fG06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207829; c=relaxed/simple;
	bh=Nu/5r3TfT/Q/vsXNVUhqfpuzZC3aCtD8nZTl9rIbR08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jiiwh967ti7j/9gYIN/f8bGJMT1W2lOxxUtX+7Qn5oHpY5nWZfxL4RmtANxYf20vYoE4Du0smxTFmwOL85zaPUL3vfvNYteTAf24AEeBEBVG3uAm0iDNe0xWaiAKNoGoWj64TceVeKATdjoudQUVBXhJLbFBuuLsdNCMmrP8aMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=dHyNcdDs; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=w1o9YZEL; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="dHyNcdDs";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="w1o9YZEL"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NNCYr02931484
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=3uhH
	QLJjfq0DoIJAX+Cur8K6P4W0lN4dox1XMY9jjcM=; b=dHyNcdDsw0mxu8q5hicJ
	NzTaUcTdarP0BPx5WFUkDegaaMOdP2Lrlxo2YIk6UNJxt/WxrunFt7PjJ+oMIig4
	aadw98a5ApMep0vwsAVQiJ/AUKeDSyGM2AzvJr9cUcmlz7G9yTZV0USzmgGov58L
	szLTEaCF+vFwp0O1uOu1h5+H9lX196sfxF+JPC6VSpEPM0365yzguTeOQ2vtBxbl
	oMW4mZkFLrF7gswHnUMGsS2i59EXswlwGE5/LQ1sBYgNx3GJ1eMZjW1ft/e1GEce
	zSWFaC/AydDGVKcYovjjI2p9hB/N/CJZl8xmW8a/VgFTgBFYhvayQFukawkxLAWT
	cQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gvh6a4h59-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:57:04 -0400 (EDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-398d0010cfaso1356867a91.3
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 16:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790207824; x=1790812624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3uhHQLJjfq0DoIJAX+Cur8K6P4W0lN4dox1XMY9jjcM=;
        b=w1o9YZELBtHSwbFNi4z8wFyQ77ZO2wf6B465myG5lFffQmLjmuk2I2LJs8WqOWQca9
         Y92RC8mjTEATcv9Dhzr87WTFB/acjwyqSZ77MTKRA8Ah0bPvYBsee3OBrNvYB8x1zKIY
         RLSGbKkXK2Th2vETILm2prN3J7Hb/Yqq7ZlToGHzYsoLR3PC3I7SpzpWKCsulSNIK1M+
         P/U6qJas10oF8hNIPqBh4Xcj15m4f1Pj3WLa5mDinDiWVbBugj9XrzbbZlWxk904UII5
         H+gwaqSoeH6A7VUC4REVpHaShmr/ZxNc4u4zob5/P5pODbKQDq4/tjviKzYbM4QCDGit
         ny6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790207824; x=1790812624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3uhHQLJjfq0DoIJAX+Cur8K6P4W0lN4dox1XMY9jjcM=;
        b=irU3gE6fjcwqnBMUg95zKjgfXLpGVML7CiXQgjngX7kNLXredCpc42n7Gy/rocCEfk
         ehb1SVeIiqBJcPhpHSg5SS6I+xZ7fvO1DqnWLVJGmTl3xzmUj1cDkGlLstvjYIXTNbGY
         LIBJZ1mskVYpFPFLqbifk+kvKg/eLDhwIqC+7oGSa4LIdfrWOC3jsgccZ5n+C+/TT74X
         CYGVOxKeTZNA8QDtzVygejAGxBTAbS9p9mBq/6qlHWysC9D0eX5JNCzpNIRXce1K0Ziy
         Y53qD9iAspwbd2eG54sEG5PWV74JIewIKbcrQGHmzbqvmeruMlKDi7JH+Bb5WGAB1wIB
         O2uA==
X-Forwarded-Encrypted: i=1; AKwUvBxLtlL3h9Y4Gli/hWKKTbFYJAQJaiqTNpu8sRFk1Sb0sE3seZ7Ut4yrtTurmKjLGt6RUgOVD05uYBxtpg==@vger.kernel.org
X-Gm-Message-State: AFuF++nnT9gPFLpKy2z938ji7sqGNMFZT7KQrK/EL3ZVz1L0LWIi6hVp
	A7tISMMTgSVKEeYgBk88QSHZmyVqpE9ujXNRpe/lf4V5oOKO4FkYUXUrAQMSElr+4Ye5hZf8GIE
	VNldPieHuv90Y08Z7t1Rgij0iHJtLPG+mlYHTay+tC7QthmV6tGYd6tFVd1HI
X-Gm-Gg: AYBFou3PjNe+BZiYvCErVt0OBAIn/+niF5hvrCAyiUv33JCgi9KHSREBGNqUqk0Dlh4
	Io4JeuoykM8QfvfqPgz/469K+ONeMtfl2VNo9mUBNUTJq+Do2aNb6O4jHS3f1XYPQdiJ9dJjLU4
	QR9l07cjXoJy5axoZI+3PtP5EIpmXvWmIaiWMzmOJzaz5PlcRSICN8/dIAae7RKfBEvyVowO1UP
	UNVgS9rkYXkR18Edh9bHuJSxxfUFsAg3WUt6MjxF46XOxTpkocEP7DwqrNkKd1LsIk7tUyf//Lx
	1tdjgGQlnmgTqaix7du2N0YxIstKdul9DVJMMdhSyt6P/rkjvVg81zUs0i05aGzQlmdJCopbF7i
	srSiGZJT5FWbbL+bEUneH7do3u6ltodsi2PXba+2RGpfd/w==
X-Received: by 2002:a17:90b:52d0:b0:3a0:903b:f254 with SMTP id 98e67ed59e1d1-3a0985e68a2mr574531a91.15.1790207824153;
        Wed, 23 Sep 2026 16:57:04 -0700 (PDT)
X-Received: by 2002:a17:90b:52d0:b0:3a0:903b:f254 with SMTP id 98e67ed59e1d1-3a0985e68a2mr574518a91.15.1790207823749;
        Wed, 23 Sep 2026 16:57:03 -0700 (PDT)
Received: from [127.0.1.1] (RED-LION-HO.car2.Seattle1.Level3.net. [4.53.155.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm1331613a91.14.2026.09.23.16.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:57:02 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 23 Sep 2026 19:56:39 -0400
Subject: [PATCH v5 6/9] block: don't fall back to buffered I/O for atomic
 writes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-blkdev-fixes-v5-6-89e60d66eb38@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790207813; l=1775;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Nu/5r3TfT/Q/vsXNVUhqfpuzZC3aCtD8nZTl9rIbR08=;
 b=DXmB7fQK9D2lfhFBOvF3+NbMxz6a5uoj8VE/L3TXgOqQFNw4KwOJzMuRHd3rufj/AV8xliIC+
 84FjyOzp3XiAKHWIVKzOaQ7t/WKZ4kqDrpqIzo7WfN8pRUhL1j5MjIW
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX/f2TeYtvNy7U
 QPprQf3MbL1539OdjYicq/ddIY3kPXKo7FsTRrJKzmFnDUj4Bar/lRic8dwMT5QXAthwbzf543z
 d4e79G4G5UHjaP9AkhuAb8gm7Y0q+DwyxGw3rcw2pw4AB/vtN4Ae
X-Proofpoint-ORIG-GUID: T4ZSzeEWN_FRpgAkYsw-vQDdqHXvlB3t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX/5/2WfweAEMk
 fohewp5PtipBKUn2NYMVbReBxVr/MoPezcnbUTqm5DBiFiL5nUePkSm9qx0G31gvs8k0i9pJ4jX
 zERLUiFQj87qJMswF6QaJeiFMCWtZFUCiD1D1s3YTmVmXdJCSXbG9z2OMW4ZY2fkXUaLnFELoez
 LQ3BP+DknQg70in5rZkrbqVUS5gmgVwKmnqSgmLj3Z+xzhhTPCO7eoOp16tXJnGqwuXH9vSxvl/
 wEh0LDZz8DzKvNzn9nVKHn6N9IE9dGaaE47VGAsprFdWfgU7MgJZuakJgx3ilxdM3qhWXbVKnuz
 Y2Ar3MiPxnL6jgIm7khPjA1+uG4o7UKb7SQsS6SshneKQFDBTrbBv9DInm0aCSrsS1JVhP6Rj53
 9PMeSEiEh5vEJlNt7wuAOg7wGvUbCxzXmDiDb+v2u7Zp0lgDZfIkx46YdI4m3AmaEDjFBxqToKb
 I45m8ME3EqY2gxujlrw==
X-Authority-Analysis: v=2.4 cv=D6nSufRj c=1 sm=1 tr=0 ts=6ab46750 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6aZ3Ysb2zzbY2sELL/OBJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=s8mzj7eOnaliLhoSWqYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: T4ZSzeEWN_FRpgAkYsw-vQDdqHXvlB3t
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=10 clxscore=1015 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=10 suspectscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230100

blkdev_direct_write() turns an -EBUSY from page cache invalidation into
a 0 return, so an IOCB_ATOMIC write is retried in full through
blkdev_buffered_write(), with no atomicity guarantee.

Skip the buffered fallback in blkdev_write_iter() for IOCB_ATOMIC, as
it already does for IOCB_NOWAIT, so the -EBUSY case returns -EAGAIN and
the caller retries, matching __iomap_dio_rw().

ext4 has the same fallback and only warns in it. For block devices the
fallback can be skipped before any I/O is submitted, so fail early
instead.

Fixes: caf336f81b3a ("block: Add fops atomic write support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260802-blkdev-fixes-v1-0-a82fc549fd74%40columbia.edu?part=2
Assisted-by: Claude:claude-fable-5
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: John Garry <john.garry@linux.dev>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index d143a664c770..59af4e808204 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -771,10 +771,11 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
 		if (ret >= 0 && iov_iter_count(from)) {
-			if (iocb->ki_flags & IOCB_NOWAIT) {
+			if (iocb->ki_flags & (IOCB_NOWAIT | IOCB_ATOMIC)) {
 				/*
 				 * The buffered fallback blocks on i_rwsem and
-				 * on writeback of the data it copied: return
+				 * on writeback of the data it copied, and
+				 * can't provide torn-write protection: return
 				 * the short direct write instead and let the
 				 * caller retry.
 				 */

-- 
2.39.5

