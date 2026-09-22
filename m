Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EAF3BED5F
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790045673; cv=none; b=mcbFpVF1Zi6sIiObF4JYY+/ghyl/QTicqO4EQnHs5HYkdsCpgE7YkmbomUvTEgI9XjW7Wz8pxUJ38g46ayNq6kGc0mZ0VAqVl1Tw9nD4nW2xt0Gif3Ku3aKRF4bJtGn7UHNSST3HDjwxp8vS0lV8iGRetp/U9DN9n7t3n+lMU9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790045673; c=relaxed/simple;
	bh=Rd/lOuuBE1fe+JFuRG2/9O0X8Yb9sAGg8AsM4evfW18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FoFQ15ZkoHdvgk9XMM7PXUQc8fUgq0FYaCc79BTQhrnIx5W1tC5x2BbSspGotaNosP3NqYwD5kVGf4IgArqsqsuPljJ4PxGjPOC5D8jNWoq3Sy3fhBz+SzeWLP3j9xlEUtE6bLqMGTEmPnYCMnARL1lQp2KNtgprAXsmnX7W1dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=rlReKUca; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=beJrSqq3; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="rlReKUca";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="beJrSqq3"
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M2X9RI852788
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 22:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=o6sz
	vYxzTXRH/nN6ZyC8xHzMIfsKFkaFTiMpK6Zrzos=; b=rlReKUcaU6aGKSA/655I
	zk0AODFqSgU14BhrtVvlJJwRFerd0a1kuvy6ACpotM1KvCo8woFOl2wA7U98Mjp+
	iahxTociNoNlhpYzgs6Gcn4AQZhz9ByXjqHh/cJDIroc3GvBA4faXiR2JPRdq5X+
	d5z4k8aYhqxgHS5ZrAsUobKTLv/5ImSn+ReSajzrj1NRLeleTPHBh4sd1hDqjd0J
	OlmAFT8WL2C1Q0M5bU6LE4J1IzMvpCjbtgP7RnY1CyNctM5MunMoR9R0y37i0DK9
	VQTHhxn2WLpp4xUcpEtr88JATLGjZsvnysQgwi7qoNvZCvfd/zPLc9uTB8BIWvBV
	PQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4guf3vrkja-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 22:54:18 -0400 (EDT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-530f9b8cd29so71635911cf.3
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 19:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790045658; x=1790650458; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o6szvYxzTXRH/nN6ZyC8xHzMIfsKFkaFTiMpK6Zrzos=;
        b=beJrSqq3XWnhhrDGtNvwSw4sWsBsjgeDHTJv3G8fqOsiIlJaqU0kNyOV9BO89N3JYS
         r9zg9XqBIWHDZu/rf0mGvD1K1Hcd68DEDUiIQsvYs3l8WTMqfzGaFgybIT3ckHVxEsnl
         KioI5C2OMi2XOdGV40wMrVMqA/2QPbGTWYGfQn9zD29b0phgKUCVTvdirpfsk427UlwP
         RRzXfHLbKxG5Liqj0m2vd0RPNAapIFNtTe03grU0mJUOBQG1i7HPn4A56zrlMJnN8hre
         U5N+2VsnyTJ6Y7Z/X5wRwPOvrtnm4McK4Hyh4nMpHBompWTq1PWjvFjyunUvjg6MpF6+
         1FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790045658; x=1790650458;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o6szvYxzTXRH/nN6ZyC8xHzMIfsKFkaFTiMpK6Zrzos=;
        b=mE4i71vKp7E/jLrxw4ccnCimrNmYdKCq0z7lGOro3vwmswHtkh3lBt/xgryWJJ2tkb
         lYpH8sq3W9CD+7PkH7d2oYziMm498OntyEOMywFLyl01KCmPujtDxqlmnVdNRN6915VH
         ACIU4Gn/TeTC0KJWmPJ95xJf3tKUwLr0Ym+XXVN7E5vhTWmvGxWEl5pcUbe1BQ1Fe9Zk
         ke9nbyA4mdiQKZBRWiD80H6wSbTolTDJj8djia4lx/00Brv0Vr8YwqDBgsr2U7PwKFe8
         yTiV0p8LIbrmeXRUUXJLu4ATg1+FEjq+Zx6A5Iy2b9ns4HFX8SvdyG8GQzU450mTCSie
         8Ngw==
X-Forwarded-Encrypted: i=1; AKwUvBx8BdnNr3MVtroBs78N+eeKFbIlDTVPvO73XTk98AqzXaGGpwd7gQIzYnAehOPzvFFSxgc1ZfVN6hf3Lw==@vger.kernel.org
X-Gm-Message-State: AFuF++lwWxgGMUHYiRKc0ZFDwlIAX2hw+D4ujt+yiEBCcZUtKyr71Utx
	UgYqOYKBbczsL8D/I41SgA/MjhZBZI7yJEglqwHrShjK2cARbr8KYj29eUYh4MY3by0xcLrop/u
	YIk/jOOseVG4FCky4eE4jE/xgYS0l77OEP3f/5NxMyk8TdZTD6CP3QRMF2q/e
X-Gm-Gg: AYBFou31Ywv8Yg/OpvmfeJDaqVheI0E5Fj4lkde0+jsqJ9FaQDWst0Y2f6z1bom0OU4
	923aomYduHn0e0TMQxhORWdHXRaFCqLEXmumT1s6SsiptPB0ewCHBbieXmPk5TIpdeqLVDt+nfz
	B02EfGjfedM+4hFDfrBbxiFCTUWKkCStmeKADniqyTuC1htLb1aiHfjPROlvmFdmFlZdV6NmY+d
	JnSwXeRriesxbmjkNxZGCa3DXNnNp0DtDBalg1DGy82dROO+iqek+qp2QPTTqjjEQNOCZTPVcxG
	hY2NgLpfp8VpHXxgjCSAZfSVqyVrJLqoDpZfRmdsxLWaXcPjGzlDDALBx6nXU31xq9v8ZMtswlc
	TMFhUHWtgt9TKs1ihVAQVWh5Ex2mUsZvr4LEFXuMdrxZT
X-Received: by 2002:a05:622a:4105:b0:532:18a0:492c with SMTP id d75a77b69052e-532d8cf03c1mr39374041cf.14.1790045657755;
        Mon, 21 Sep 2026 19:54:17 -0700 (PDT)
X-Received: by 2002:a05:622a:4105:b0:532:18a0:492c with SMTP id d75a77b69052e-532d8cf03c1mr39373721cf.14.1790045657344;
        Mon, 21 Sep 2026 19:54:17 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e18fce9fsm2048421cf.15.2026.09.21.19.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:54:16 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Mon, 21 Sep 2026 22:54:03 -0400
Subject: [PATCH v4 6/8] block: don't fall back to buffered I/O for atomic
 writes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-blkdev-fixes-v4-6-e2801f71ede9@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790045650; l=1679;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Rd/lOuuBE1fe+JFuRG2/9O0X8Yb9sAGg8AsM4evfW18=;
 b=1dWllPo3jLt9esInUtwSLHG5wFx+G8i6GuB4B2qyjpBYRHbZBBbovT0TkA3lP8HjZrFVFvAAJ
 cr2W9fFn1YJCFRQN9D+wC6CR7b/KghRoSP0xBcaShXpXvMHlBfrOXQs
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: QLYYXzCXBA5rP5DImDyFrQWtDC1ZzdPo
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDAzNyBTYWx0ZWRfXzCppD0Mac1e5
 B4EcFv7pSRH243h0wZKgY8EENe8QAvg5W/LR68cPe7uafzyc7enl5/2Amua4BanMDCUr94Td+JS
 8a5l0M8qBLDPkblWtEJ/NrJMnkUpABBIr1HcKSyOIIbmhyZDGJBs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDAzNyBTYWx0ZWRfX2RJcV4GyiHcr
 9qPt9i1Fz5A//5WP37bzKzrBZEcKZ0N+7dqMQ1L3OrpRsm1+BappCL4He0iRnmfqoi6BMSd723Z
 qb4qJMMuxDjmNX4xV0SkNh8lnp4YgSE/l8KtjH5XwuH6AtDQd+CCIygiw9dYYciOMQ8wpM/FtQv
 iNrJHGuO2r6C4B81BIp+qM5JbofG8at3OEZCkrSDDCrJQN3xS7to3xJJy8V99byK3TzC8vF6/6R
 acMHQey9Y/KCqB5ApxREWOR/LcJKej55IYepgjVCb6fPiJ6d9TGW2Kc3oMhIPLu2ZVQ5VK+g6oQ
 6M1DUpUZsWDSiebByWD2G1vC0QUW0HyJgS1DyFyXmrVpIcPMo7LjGFehPfnFERxBoYOiTUQxhmz
 /mFalNHD5cHfEIErmptc9/tvXU6/vyBzWbdwrS2/TpmzJBFksgywY7n1v+GDZYo5HPziQSuR0El
 svNThzHbb2BN1YBuMwQ==
X-Authority-Analysis: v=2.4 cv=U/UHnuru c=1 sm=1 tr=0 ts=6ab1edda cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=QOCMdifcju39GKoXhKua:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=s8mzj7eOnaliLhoSWqYA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: QLYYXzCXBA5rP5DImDyFrQWtDC1ZzdPo
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11912
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 lowpriorityscore=10
 impostorscore=10 bulkscore=10 adultscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220037

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
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 90777e8a9a6c..7f23778f6b81 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -766,10 +766,11 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
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

