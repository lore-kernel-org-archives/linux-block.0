Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197A44A3E0
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 23:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790207835; cv=none; b=PGvmxutcn5ldriM2VYZ634sn5ZeX6dtCGPbijbblRGP9uWiOZnV75Ydj2nrLZ37kQT3Wo1BzA9uIzo25dypOpMhviPbYUp+FcUqNyN8wRABJ/xKt+hXEzbAyPSSMcDVkznbKpVyQWpS1u/PKGB1kSdLGbeDbR2PoWeXydHeSCu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790207835; c=relaxed/simple;
	bh=eekIRUkO6xctJzh0LDxpTW7f45r0xCkvZKYTjeZsvDw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JI+NjxtyXSDZjiuV47pZ2lpQa3G2m5/YfPPIbsCkB9fsJzNMmodinHw8lpa7RA2pF97XTwJItA5CDccBnTwzulXKXb/GIAJ0ybnXSV0LfAjnWgShM8ZliEpp7qGKMmUHKavlkLOUUfk54Ein3L7gSua/TVGgve/com2hK6KTqqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=ZqFevxwT; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=QJnoUHlP; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="ZqFevxwT";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="QJnoUHlP"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NNCw0e1940864
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=0qoQ
	93CRiLkSb7/te8GPJ2ac6VSP9fU3H03z6ipMMtI=; b=ZqFevxwTcBbyDpOcLaW4
	mO9UrX57vPQn2xrd0XPJ9Z/fmWZjTyXImQ4f0RMylBH3owoB63T3ReRghrAXhmvK
	pAJY+eZBp8Rh+Kf/7wzUt9i/X66+G+8FlSwTlXdV0uPNGgzqQ6bpRkqskKxvvLHg
	heXoLcS7GBtoeGRJkCLUjYhnFscr5J1x830G6jjBOhPWGeQ0oZux1U5m7CSmLce5
	hnKa61pnOiJNKXrbWkDcqVl6ujHfk9URZOe2bPrl/8epw/fLUmbgNULiLIJ7KjdP
	Gpe+rzcR5FYW+2i8fTaU4WiLldSMiLNo6wVrF+hFoSd37ZNgMaAX5wIoR5fukObL
	sQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gvqtcrbrf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:57:06 -0400 (EDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39b6416441eso2226618a91.1
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 16:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790207825; x=1790812625; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0qoQ93CRiLkSb7/te8GPJ2ac6VSP9fU3H03z6ipMMtI=;
        b=QJnoUHlP3TDF2W2zU5aXMQeCuMkehazdb5/IokCeRuo2OqBI5zfiJMgKhqYAa6C/Sp
         AXtHb7H5GB7ezxievtf6RCxtSWX4WGp/pu83eHGneAKwtUGKBp0xC0o/6UX/9MGwoahN
         PtkWgXQgZ7mg8rnAfYK3drFjqHAVybN1flltryut4EXxMBhEE4CkS2lIbtXXuqg4omG/
         GqE7qAYDls97oWrc2MvtiCCYndEbod5q+bBbjQwzOaUW42bqNzgGD61mCh3vI5M836jG
         k0KCLlYecT3siGA8du9AuXfowtmZhgY6TNfi13KxT28PSTTFLITjHPjyUzWk9WGlHSli
         +Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790207825; x=1790812625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0qoQ93CRiLkSb7/te8GPJ2ac6VSP9fU3H03z6ipMMtI=;
        b=f1REofqlIIg6PpytTAZClUlR08FX+3NC5fneWN+o4rSaWWK1zB4dYUBBbJvILeMkii
         CuU4MrTP3GqplmClGugMbg9S00TQWHNz8sNbLV3xEXD7WyebVWCklThiTASDxD4ZMjAk
         TUPslyHAf+ZcHKnz3E8jqM5hIl/C3xEd6TTSlAdPvcocHZw7HvR9XvT9M2yaf2wxiaLS
         jbshORVqPzROOcbxEoDcipGrxDepPJ4RkmviflltoIu6X/Csg3S2rY24xVuL0bB/gJUE
         E+K31KNkXLXblEHcdU6+itkJUgmdpK+xnn5GJEQvAr/2+QO+8h+okD693lvaROx7U6pA
         7fMA==
X-Forwarded-Encrypted: i=1; AKwUvBwUSQcyFyzhV7kbOLSQoAkvHPd6oRSqJ7LWalQh3JhiJymPJRV7ptSOw3+viBWk+yaaEBMqgEhZM7r1iw==@vger.kernel.org
X-Gm-Message-State: AFuF++nix6h5wuz8J3dy126leOcl0gftM3F377dmksZE5/8NkUL2c0sK
	4na0TJ/mLAtzk7I5uCePttsT3+oHj6nB2ej6MwSIFyaz+YmHZKdx17fdlUmT7tN7Wq+bYUlN8fd
	njmfqNVooysCNMjN6UAAsp22cQXbXMDMlectyg7w37r07hGTt4F2v0sAV6ubP
X-Gm-Gg: AYBFou3Kq2USucIgz2XcTHmSFbfMtZOT/r4S1UYvQyjN3bPfeEgxdBgdVpIlXnYb2df
	V7G8gODTzQcHt6pRJsmlJ6ttMsW/AfO7Y48SbUxPU03TYe+pbEsq8xlfKqt3xZw/rADUi6YftUZ
	dHpY6aeIrG2fv2ZTpn03oMM2/TWp+RuW4dM0ZRuYsuWCK9nQ6WWCXFKO/6RosTaWJmOjdA95gME
	4/N47Jp7YtkzZpNqc6UZj+udkB3qT8+GaRmCffbIF+wR21HLk8soFU6RSzFtFvsfnsgxV0U1yan
	zyy8BU7U1xwO8gvLgW7EyIGjg4GZy5YfjMZE869duqxz/ZrUng7VmDRRegRNPujqhvoaGDJlbX7
	Yka9qPxhi4qzyOMEyoTeQCqSMS2eB2SmXNPoS44u4aPwYsg==
X-Received: by 2002:a17:90b:1c92:b0:39e:6c68:c77d with SMTP id 98e67ed59e1d1-3a098e0515cmr614675a91.51.1790207825689;
        Wed, 23 Sep 2026 16:57:05 -0700 (PDT)
X-Received: by 2002:a17:90b:1c92:b0:39e:6c68:c77d with SMTP id 98e67ed59e1d1-3a098e0515cmr614654a91.51.1790207825215;
        Wed, 23 Sep 2026 16:57:05 -0700 (PDT)
Received: from [127.0.1.1] (RED-LION-HO.car2.Seattle1.Level3.net. [4.53.155.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm1331613a91.14.2026.09.23.16.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 16:57:04 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 23 Sep 2026 19:56:40 -0400
Subject: [PATCH v5 7/9] iomap: reject atomic writes in
 iomap_file_buffered_write()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-blkdev-fixes-v5-7-89e60d66eb38@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790207813; l=1162;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=eekIRUkO6xctJzh0LDxpTW7f45r0xCkvZKYTjeZsvDw=;
 b=2YSDeglgyk07rr4XCceLzHJrMpahC9wn5HyPBCzFyGWpB4A7Jm0LwTpK53X+wg/uOg2P5jPVn
 EO951ZjrUh1C4yifGSMaj539bji3K60vVy92ozbmJFDFa2hZoDofx44
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX34IyYmp7kWV7
 gR0UBoNwBiFdciRI7eSyMapvyRri9KP2g+jx4vFaCBD7JhaL9iQ+TECgN8E68tYkS9OJ4/NAT1U
 igPCxYhDjNFa0i9vuwl4nYplTyZYW9+bdI3IcyuIgnraH8np9bsCKDOehHoN+4QSprfCLZFITb8
 MADWdDh/xvrQimN0A6NIlQsXPfHxVlvxZ1roElthw1dFgd2uK763/3LDExjLkHa0avz/r1fYNGH
 laNrCRBiuLtNC8JaovhSS9RPqWa29pK8Fn8ju4+KO+BeXoSSyxOeCzQqGgIY4X3EHVCpHkz6viW
 ncqMzsASQMgh98BYe/CONIsF0jzNm073BluYh8Ci/eP9Ceg9ziAelWOcNchUC2uMQCU2yg9DNZb
 YQE8r5oettSHs+RTpF44ViTJ26/bpc5PFlfq85hU33alMf17mBprjM9vQoCp3lk+zglr8qP0TOF
 TV0oNVJjJpCVrhK6pqw==
X-Proofpoint-GUID: eWVdv1MGYzaTHvprttgWkYNXex-lzPov
X-Proofpoint-ORIG-GUID: eWVdv1MGYzaTHvprttgWkYNXex-lzPov
X-Authority-Analysis: v=2.4 cv=LtYHWXdc c=1 sm=1 tr=0 ts=6ab46752 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6aZ3Ysb2zzbY2sELL/OBJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=ASVHLkjgWNnnwhGXR8EA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDEwMCBTYWx0ZWRfX5Ma1tQ31J0RH
 CL2KmtqRl8ZJBL2vyiYR4lSGDuWMSpbdOa4sBFCLD2j1wV44xexuPuwtN91gcBMQx548WnvDPdj
 bC+HycpG2B+Qtle1UaolVSAEQ/jhVmjJIANdem3jU5+GOzUwdpeB
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=10 clxscore=1015 malwarescore=0 bulkscore=10 adultscore=0
 impostorscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230100

Buffered atomic writes are not currently supported. The page cache
writes folios back independently, so it cannot guarantee that a range is
written atomically. iomap_file_buffered_write() does not check for
IOCB_ATOMIC, so a direct write that falls back to it would complete an
atomic write without atomicity. While no such case currently exists,
fail IOCB_ATOMIC writes with -EOPNOTSUPP, so that a future fallback
cannot complete an atomic write non-atomically.

Suggested-by: John Garry <john.garry@linux.dev>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/iomap/buffered-io.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0a5ebfda90f1..e6654cfe1cbf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1304,6 +1304,10 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
 	};
 	ssize_t ret;
 
+	/* Buffered atomic writes are not supported */
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return -EOPNOTSUPP;
+
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		iter.flags |= IOMAP_NOWAIT;
 	if (iocb->ki_flags & IOCB_DONTCACHE)

-- 
2.39.5

