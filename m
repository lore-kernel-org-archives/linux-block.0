Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6BD3CFF51
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564630; cv=none; b=r7fMENpRhi4nAGwZEADdERfmgBYQuVOiEw7JWnKyHmr7Huf0QsJFlMuVnG22In6hd9e3apB7AyYrQfB2H6GEngpDJ8p8xBsAM3PDG3fuh1x7G8VTksYGOkrkRBafsdFnS6nbtdBV9S0LSs1wG2YdJzFZqVkWS5hoBYvokfdFgnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564630; c=relaxed/simple;
	bh=nOUyLn4mikuuV5NB3Wyl5aQas2LTcg2ovZW2RzEQLhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ItSVwaCybx+aj3nzavdIFQzcoTs2LpeFc0vCGcg5SQ76rb/8srYD4dGL9t8gihprkY6Gm768PKzQMf6zT6Axtn4S/dUtXb1tCwRlCjxmnj86lktrqYDZiPJ6Pph9HpcaI6w1CbKRIChTO34Dlav1ULbGuWVXIWh6zyyZ/Q3xXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=idFMBDye; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Hk+YuNV9; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="idFMBDye";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Hk+YuNV9"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GYKr6984523
	for <linux-block@vger.kernel.org>; Fri, 9 Oct 2026 12:50:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=KmSd
	hCQKvTCx7iCBBSxeBtwdW5W857zsoal7R697w6Q=; b=idFMBDye5fdULfNdY3rm
	IrgA8nByqJoUBBKItUZcbn5sAojpR05gche47oZ8PSgi7T73xwmKmpKagS7/qrxM
	iF4T+yCUpo5wEKCsnVOKzrv6Pg939zc22V7TcT3JrfMjRfMbtawdeEjA9sYjZfyZ
	JEF25fbJvRbUK4xsLKOzHmV28aWohYef9E+v38Zfs+/PUu8VPe3jqFDCA9k3+2PH
	k6PrQah/6U1YT0UNWFGl8oj+IonyjxrtEU0T55dxCvfEulp85tlsCuTfOrdsBjiy
	B8CJrAPWFMvAY7b8NLw7OzmA9zZnAl/gs2QZx1vUyrfUP9iFyRPi4XwWwVEpLp8v
	1w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4h6p2nn4a1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 12:50:26 -0400 (EDT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-53397338004so181787891cf.2
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 09:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791564626; x=1792169426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KmSdhCQKvTCx7iCBBSxeBtwdW5W857zsoal7R697w6Q=;
        b=Hk+YuNV9SPZMyNDsaWnndFUjeUhI0aAXJGSr+SWFPc3DWfjb2WnDB9ZZzigoCN4w/f
         ZYN1FUbMuRAQ9Nq9GPtJWh10KDCcHELRkU2h9lUP/89F7d3vVy8uBE9HAy+Y7aeQqonL
         dYciTBzcksgnjQRx6kxxPaFc81L6k9vuWgF554qgpiCxvR7wvF99KAnhXmRgv1VdNpKA
         p337OyhSa8idViVWF82yMA45PiP3gxmdOEXYslDkHCMsnJ1FXT7Fh9MUzevpIe8zo/ZK
         gWHShhbapMPxvar12bTuTUCWhrg4Qa9za+X/DNQHpk5Fr7J9JMIpB3Y5WzBYkwRYLsoa
         I4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564626; x=1792169426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KmSdhCQKvTCx7iCBBSxeBtwdW5W857zsoal7R697w6Q=;
        b=eW1r04lAQ+vFf48P7XNvIdOF2BAxQ0hSp9nlV1lbh9Zoy7P/5IS82aKqq4b9m/AEmM
         4kDM7GEW8irN0ATdOlzstN3ds3jx8vBiM+nK8Kgpx6YAJip1IYfPYpD14PxHtnKnkbCe
         y4FATU2W0LmED9PnK5stEhS1T/HhS/lsCZt/v1Ph30qxpY7GXnto4E1bl0ruc6SQ/+PU
         HeqtucvHhEEqUASlsP4KIFPLHZdxMP5yvin0o0GqEhUxLLC3VsHNptBb52YxWs6HVYAb
         M+XPZ2Tx3K4Vy9Ayo0ed+EJNifaijYwz2UbfDl8bLUu3Lul0rFZjWoIYjQVnWPttsXSx
         V7rA==
X-Forwarded-Encrypted: i=1; AKwUvBxfSoh314dXkdtxN9JLuSi//LjGEo0qFOeuBqCAeuqoALUsOQ0g3DergWK0UW7RVP6SYiVJlpxwpHYhtQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lwUSeVmDTFbXsF+g8hNVGHbRaEtPiVj7mgFjuQDsZoX3lbqZwU
	yXm8I1csGn26/arfG1GPYpLwQ9HNTgG+6sErs8zy8upUdsp+RKrenCs7XwyfgqAjGIfOMZbpXrJ
	/rbNBc6Qav0es4Rc2ZkTgDWZm1TJEgqgpVOyMbqXAkx/pLBZGr/e+gHY9exEW
X-Gm-Gg: AYBFou2qiVfGKw5cTBFAjeuSpjSy85sauqAGpG4A+/FarczWc2N57GBG+ZpblI/TTxf
	rt9J8rrF+jESUo421c8fw+pA7OE8+LDvPR5xDrw7bGAFJRa17fsEtQ5wtU0m3imyZpvB4boQ/8P
	kS2/y2FkQPFATETo0mTq4RIhno77utje7TUVkZEAcC+2FFxnQnFMuXjfPVI992DgdtGq/4vYEG9
	652SBoX9sQYVsiyzbADnkj6/z+f3EFYAWuUcR42z+MymnuDkVotHfLqwr9E59hc1K5itZ8kMkzN
	vq2pImtF1IrfSdGJNCLhYFyslGr49rm5h+m0FOEHD8KEDEhi24mCu2iKsb4uraY2L7SN+jDE2Fw
	b4MmdLDx8xBcmiZb6h+vreDygSU4uOvnQJnWxKQaD341ztwo=
X-Received: by 2002:a05:622a:4c89:b0:535:1a4b:a65c with SMTP id d75a77b69052e-5359fb432b3mr36916101cf.34.1791564626101;
        Fri, 09 Oct 2026 09:50:26 -0700 (PDT)
X-Received: by 2002:a05:622a:4c89:b0:535:1a4b:a65c with SMTP id d75a77b69052e-5359fb432b3mr36915461cf.34.1791564625428;
        Fri, 09 Oct 2026 09:50:25 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b77d0eesm22234701cf.19.2026.10.09.09.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:50:24 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 09 Oct 2026 12:50:14 -0400
Subject: [PATCH v6 6/9] block: don't fall back to buffered I/O for atomic
 writes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-blkdev-fixes-v6-6-307939c387df@columbia.edu>
References: <20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu>
In-Reply-To: <20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu>
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
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791564615; l=1843;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=nOUyLn4mikuuV5NB3Wyl5aQas2LTcg2ovZW2RzEQLhk=;
 b=GRY+dI66HvbGZcsKUzr9httFuonZ1PqySnkNxCOVUeKS4B187FSIqqmyLZ3rTzggMPfXvLQow
 oeJGvyx0EngAAc/r7e00x+XXW3hCpKoDE9sj/87HM8fak2oyTeYI42H
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Authority-Analysis: v=2.4 cv=eaGo7LEH c=1 sm=1 tr=0 ts=6ac91b52 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=s8mzj7eOnaliLhoSWqYA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: Tz494UiGTRISCTKxKmuGEymj7YI9C8o8
X-Proofpoint-GUID: Tz494UiGTRISCTKxKmuGEymj7YI9C8o8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX3nS6KbV50dDE
 sJQKZiw2o6P1UKI6d6Bxr1UU1N+kcTdtna1o2axdtIANNMcMVQlL1ywu7AYfTXmMi6sYr3oJjxX
 S4eUk+FriLFxs0hOaSr/tOsWoxGPdrkuGmwf8lfbNknuicb0qtO6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX62ifsyNjvxXg
 8Sg/o77penmQLVVvJgBf8UI16/Hk4lqlynVKF2H6SGyQVTozz4Up05WC3xVRzOxIUTitmm0IVct
 PRaNhKraYjXBttuAByTZrgagAFLo5Ota6nEpnH3u1ilVw8iIKWPycE+pXgoy8ECFFdTt/o/JU/p
 YuGrsuXAK/lzUdft0SyPWOD+QgPUTgLNstIDOJmys2OZR7P0phY+JFSGL216os+w5e3l8XLWxOA
 i6BTXRiory/6Jt39UM9x3I0YvyKdkz2uzEANmrXdjQVXg/9yVLr8ll9PQUXwNvjsE/t7jzK+Vk3
 cPewtFR8AQ2jeh5CEkV5gjVqZ1iOh+035KL/V9YAPWsVeeg2jKd9ptR0CXINcDqbHQhwgHFD1Hg
 5+8K33gdw1rFzPvZunGOGCT9/GGw7KE60ufkzvupQDPjJiySIkGZ6KDvnsQa8mlZBvRfJ5nv7kU
 sebbdbX60vbnp7+z5rw==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=10
 lowpriorityscore=10 malwarescore=0 phishscore=0 bulkscore=10 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090067

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
index 1ac3fa285090..41fa0c663f77 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -782,10 +782,11 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
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
 				 * caller retry. The bytes already written
 				 * still need a flush if REQ_FUA was not set.

-- 
2.39.5

