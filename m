Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2438246D2DE
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564634; cv=none; b=i5/SPSX1lYOjSW6f9jYN66SuLgo/xE78Q61wmJZQHjoG4OlMHvY4omEqK6+8QAkHyHxN0bHm9pBgcBDeYL+4Be5PK7J/e2Ic+VFxBqJfkNOThyDozxm68mESuxMrxtmr/5ayswNKY1jxy9gYdn3GflE1ep5AdAjs8XkbLH4BLZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564634; c=relaxed/simple;
	bh=TjEmrIwoDfGD/tJl+VVnQl6XHOIQk68grd/DlzMzZsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F/SB2ft5d4bhzoZsLEEqwY3LLb7N4A7TKOjxf3KeYo7p4hT5m6gZYUtWEyUWwFBiZniqJq48hOvGKy4pps8K6sJLByraH/Il67tCP/9awqX2KyKGCWiGjCNzBd1IsIX6GRJJRVfhL/JebwDprw7AbEVK0r81t25aD9QgQAVn3Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=KjFOJMlh; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=CGM4Tlkx; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="KjFOJMlh";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="CGM4Tlkx"
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GYGkH683645
	for <linux-block@vger.kernel.org>; Fri, 9 Oct 2026 12:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=YGcz
	I1vSHasliXD66Zjo2T9yKyc6ElYvYCgnRIuVKQY=; b=KjFOJMlhN1+3lGbf0LpR
	No0/4aMtdq6WbA9PKdTRS6CMrn4lWqPrvC1gWTjcPwgDef0/tKi+mSIaD2u6FKBk
	T77LqQcgz4L4VAoTaN+/A5QzTj9LiSAhoPFNAqfc20Rl17rRJKt/UzSkJOkpCBCx
	EMza0toduGjnEt+5u2FLIf8zuRmUgBaziKPWyIKnb9uuFmV0UavqGGtwnnqJyrOm
	DVyAzCGblDPduVqjQNzmnyhIIo+t/F33HJtPdv9ifFMzW+tLcEiJJQvMUsK4XQXw
	vIRGcd9Ka/4v+2JBYuc7nEOS68OxSRaQ/B3XzVOE0Vfo82ov9jp7HmcNOYpnDXoF
	4w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4h6wpyusqv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 12:50:30 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5338c59f90dso44084791cf.1
        for <linux-block@vger.kernel.org>; Fri, 09 Oct 2026 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1791564630; x=1792169430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YGczI1vSHasliXD66Zjo2T9yKyc6ElYvYCgnRIuVKQY=;
        b=CGM4Tlkx2j9os9joEuyGTQXgvVrYq+mU6PiOkIAOWt/YTk4w9amjaoUHmFj6TC2zlP
         ohYem+p7w1Ju3WJoAUPjZAcijzgRAQiLez0//kOwBFKd8gISJAfons9PWlt8o+qPYFYa
         Fi+5UyW30YQZi0qMEEaQeoaMyG/eZ+pBAT6JZL1LP646c7rmNSAu+VOOZ4/8TbUvX9VL
         l4ByKCTO5JFbwglm0eqgsXfpa3FWYhMPdQE3AgnHyIp7A0/tt5n+Qt475Es9MLgUfTHD
         F/tHpIIWotmK+/UteUhL8qw9UmPfkNt9CiXye0+kjaZt06zYmLVHlQDs9yNni0ghjK2g
         m4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564630; x=1792169430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YGczI1vSHasliXD66Zjo2T9yKyc6ElYvYCgnRIuVKQY=;
        b=QgZ7mmAYMhEjS2rBjva/Z1fce0mPPSnPzsKgaE/O1i+j1e4C6cDrOEQ+aDH02hEI65
         8GaP5d69zjtri4atKBzu/L5VJ0uhGyIPoQEJ+NnFLz1+qSvTJRgRLflSRLZybRJkaPV+
         VVm+BiLrejvhQiqE9ImVB4O0A4PGA1wmoYogzUwhyTLHsTY1ONA9NuHavXT4slkbqi7b
         cuigOpn1kCdNwS/u9htq7U2fiGFamXYiyAHzM1rUeRKTK+Y7HZPIFs/SbosIx+mmFzMm
         1ldibnyyAYc/fYyorC0p06L1683UcGO/6nj4y6AItAu+uuO4Rh4515aqiGeViK39/Nmt
         dHiw==
X-Forwarded-Encrypted: i=1; AKwUvBwRPxtm1Z+2pT0dxTznILjK0+RVht6v/LJ2GK3UIMOxFHdKBCfLlD4eJmUEq9j+7FsyDlvLqO83Sb2AwQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k1M9zQn/b7Y1I3g0NYYZOOWBIRYdhSiCHxgRhcEK0IDlEDSK9m
	/Pg5RPKZmKGFLD9F0YA6ISg3FCey95CK6UTl6dz5zvhpdt2q1Z08y88WrmEc//zytf+fOylXubo
	DlRu0TM+/xjWZuCXUtaV15k5NjAyWW/aGmh5LsjhZVPEvzaQn1WBTX6XpNhpf
X-Gm-Gg: AYBFou2p7WJ7Q3EptcKsPNKPjbmVU9qgF0BG5JtPRu2nzPgbWVILp01jilusT3kFuL5
	owsB4iWs9I5MLCvuAQ0Sp2FioqAA2lEpn+AynEuOmIgymXnKg0D1kDKPyO8EAdFbqJKvXzy50uN
	eiRowhnnpoc3HXNYYMZZvGPZPypLF0eYHhr9VSqZSE830WBEIc6++gJCa25jRvSYSCgRQQCPaA1
	KSu9Thp1P7RJUfFZJqxIbOT2j0TTU21yjl+K7DwwvdPwzlnZtrM/9lCjI7HEkgiqkqCkvxknH21
	2yMcJIMQfojtHstTOKtC9UDUEf3ll3RZKdyeWumvlI9Srw6HGAn3V0bsLiTuQysYJGcRQgBsQCJ
	MplpMOAo/4uHW3+3z8UVJGInjL2EDe/1cldEblKB7ryktHEs=
X-Received: by 2002:a05:622a:1b03:b0:533:3274:60c with SMTP id d75a77b69052e-5359dd26620mr40806071cf.29.1791564630464;
        Fri, 09 Oct 2026 09:50:30 -0700 (PDT)
X-Received: by 2002:a05:622a:1b03:b0:533:3274:60c with SMTP id d75a77b69052e-5359dd26620mr40805501cf.29.1791564629868;
        Fri, 09 Oct 2026 09:50:29 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-178-194.net.columbia.edu. [128.59.178.194])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b77d0eesm22234701cf.19.2026.10.09.09.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:50:29 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 09 Oct 2026 12:50:17 -0400
Subject: [PATCH v6 9/9] block: remove dead metadata handling from the async
 direct I/O path
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-blkdev-fixes-v6-9-307939c387df@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791564615; l=1396;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=TjEmrIwoDfGD/tJl+VVnQl6XHOIQk68grd/DlzMzZsM=;
 b=kyR/6+0uUpySOm5+kLC7PnMLFfMvdbxJB3gn4ywQjE3A653IQAONvgDLa5uwCFOb8cb81Gxki
 mgjkL5Zh7XwBFha5mPhJAYuM10mgmerANhTN+Si/GE2JLVdD1jnvnyH
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX7WzI42Ru03xM
 QRpOFA8ygbdewSfOPy9qnV/ZpRaPwN6vWSu/rYniuAVqCbtpxIcBEhuokCkEPVFDSnX0OvljGuq
 v6oP1El4HKjQP6dcgUDhtQZsVS4O8/9CeNui+YtuCzJbAiDNhIbd
X-Authority-Analysis: v=2.4 cv=a42lZkSF c=1 sm=1 tr=0 ts=6ac91b57 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=u0MKzLA9JmpizDwXU9Rxjg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=VwQbUJbxAAAA:8 a=-GSYpVTsbc7fiOcD5ogA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: VhgEWQsPMocd7Nds7SyGe5wmbwIIxJi-
X-Proofpoint-GUID: VhgEWQsPMocd7Nds7SyGe5wmbwIIxJi-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NyBTYWx0ZWRfX66tlgrsmyqRY
 MtAgku/LwCWsySHGoZ1OyiRhmzYmqdqod5EmtKWBUyVy/0V6t4ZayMx6K7IMmk2Fm2uvs7F7LCo
 ZDYPzl8waGqp19iNT51j1F6abjzqi5NrAtXXQHM/NakAPsBwGga4sqGoW65ayNOFeIJitjhjRXT
 xxxHzsTNisw5cnwMW30DtUtLx3qfgkPxS/8IFrz3iiIh6/5wV8MUMQpjdNp4v/u79LFiK4X6u+T
 4Bn41r9Ru0BilnM6INtp4NINcqGXrPfLPIZ9H+cqixW0WlPGxeBfq4OcWvyFlsQ/0HFI9SnWOyR
 Y0vCKk9ywMmFMM1H9kGEj5a4uie3WGdLxTnVqzRCBLmlnYijRbVsVc3f9cNBC+uvDimAfrKc4UD
 T9i5D/0EScneCUK2aOxA1t0PtMHKtlaUmxV9lnmp8DPLdOud9Bsfpbs5rKA+HrGACnQSVSXPfH6
 WhPQAabIJRWpAoIXEOg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11930
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=10 impostorscore=10 suspectscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090067

Since commit 2729a60bbfb9 ("block: don't silently ignore metadata for
sync read/write"), blkdev_direct_IO() sends every IOCB_HAS_METADATA
request to __blkdev_direct_IO(). Remove the now unreachable metadata
mapping in __blkdev_direct_IO_async() and the unmap in its completion
handler.

No functional change.

Assisted-by: Claude:claude-fable-5
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 41fa0c663f77..f3ff4e62413b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -321,9 +321,6 @@ static void blkdev_bio_end_io_async(struct bio *bio)
 		ret = blk_status_to_errno(bio->bi_status);
 	}
 
-	if (bio_integrity(bio))
-		bio_integrity_unmap_user(bio);
-
 	iocb->ki_complete(iocb, ret);
 
 	if (dio->flags & DIO_SHOULD_DIRTY) {
@@ -385,13 +382,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
-	if (iocb->ki_flags & IOCB_HAS_METADATA) {
-		ret = bio_integrity_map_iter(bio, iocb->private);
-		WRITE_ONCE(iocb->private, NULL);
-		if (unlikely(ret))
-			goto out_bio_put;
-	}
-
 	if (iocb->ki_flags & IOCB_HIPRI) {
 		bio->bi_opf |= REQ_POLLED;
 		submit_bio(bio);

-- 
2.39.5

