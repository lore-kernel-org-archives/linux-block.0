Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12BE4399ED
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987394; cv=none; b=OVKNTdrI7nwMedfee7Zmh5Kl/zRSnEsx+5UPuP+A961NrUmQPfORYvz1wJQMocXiBl4Q6ooZXZo5xX4AjBV5AnCt45ej8MiGdNrMpxh1vAtEKkpgy23b6BdDabb5OTYJO6hrObIZCoGNtg+pXjDXLAsgUPphjYUl/NU+qR65CZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987394; c=relaxed/simple;
	bh=Eu+0Om4nXxfhek9V2AOG88l8xsxFV6d4kLyWXbtDvRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CTQQ/GpAnP4QLUV5B/fq0MMKI8BWvhea3+P7hOW8bXAm1bDZ2rlZA532GtfFxyVvY3kwIKhYvpzrSWlU21O2CvqYndNVKJPEmtkJM50bKsJEGrFsp0X8r+qqVWr+2EEyqvAu+/RqngnDfhb2Fl+jw7rizrhdRxOmlTiBMz16aus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Pfwu2z97; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=cn7pOP8n; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Pfwu2z97";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="cn7pOP8n"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689KYZko1214575
	for <linux-block@vger.kernel.org>; Wed, 9 Sep 2026 16:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=wAZfefiEaDRvanKkEQj6zpo9v6
	6Gi+kDLh61ika2uy4=; b=Pfwu2z978uNChRb5pJYyTCzabmBFMKDDJ+onuIG2tU
	DrLEYqmJIggO75sD0sJRGLrMe+Z+tJTd2vGS3P21WSAX5l3GZHDz2Y5tt9j16HQY
	F2Lm+jNOaN6ZOyUqEWVIbt2R1HBoedjVZCjM5Yg4aUrEfu+B56TTsujcHaYeWCiU
	MJudNCyeA8hCjp6PiTTPO/2VbS/95jyvLSBTG2G5SORfVCVUlpa68/Aw6aMROjgV
	uopwRSlGdG+AkXpJvE7H8RChdbcigwffrkBrL0VYKIVZWBL102ZF81JQcnDyumrv
	kUT/gn3jiuEbQBAsh5jXD008jAwjIbchi4zodoFwRquQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gkcxyh6ph-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 16:56:26 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93903982af1so1292275585a.3
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 13:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788987386; x=1789592186; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wAZfefiEaDRvanKkEQj6zpo9v66Gi+kDLh61ika2uy4=;
        b=cn7pOP8nV4qe3FQgsLXRjNX8yNCPxwaS/f6AvV1B1bj/KILRoiAuyH0sSXrge9KaUl
         +LropMeraAYXxvRewPcNybtuSVGQ1EWysfzC+hy6aJfUef1TN1z9HALaN6AOr4MQP1/9
         mnZgf6W8oedDlM9vsVaQMHQhpdtNfZgcXOxMkE9PgPEcwcB5CcIAtK8lg6+xg9Ax1cm8
         NEc7N4MofP1mRVe2bnfybZRFjQfZYnzot5LZmc0KjVRpa3Yh2n2nr0vjmdbvO78wf1sa
         UpJOl1P06SoDX5yGeFxGSmL6AjaY1PddGXOS3nONtb+V0LX8GoWyCwG3AFhP+5VZk+ap
         Pdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788987386; x=1789592186;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wAZfefiEaDRvanKkEQj6zpo9v66Gi+kDLh61ika2uy4=;
        b=knqwqupOmrUVQUufa0e2JRmHithc5NyMGj/B/J++HmVcM/Cs/gb9Tzks4xqEGO1fi4
         3/jew8pezydrlr25dLZalSybGvIKWiVQ0gpWeAIhFt8lbni6L9e7S6sN0vwIA6W0X0n5
         0P7Ek+/0+IFfwjyAmWznbLqaGJ5aZBUm2YpLukG4mnKgO8+8K8k/lSkzQjU8wlE8aYHs
         UOSUnR459BDvEE0dwQdHzdujanxkW0JKJWbZ20z7B7/D67y9+Wteb24XnAEls6KR2NGY
         tdy/qaNm4ZkLE8ckyY22166m8jSpriQa2f9nA0V6bKm6ic9v4uGpiABxcDUOEWwu9HL6
         Vjog==
X-Gm-Message-State: AFuF++nS+LxwnGUPfLWUOP5OqLuZeZur3AT9+0ip2jwVsvzKaaAfA+UL
	YfY08nekwqvWoXEaDpqqsN6oaqX48/JmeL5cQpiOOAdijYS72MuSaSyf2p+GwunQHToDIFpXllk
	gk6VO4jAMoBGg1Or1FicyUuJfG3h6eRWgivVb8aEnYhRpp5BC5q3zENvm1SO981cMuklTIao=
X-Gm-Gg: AYBFou1YD/TbpWNcjZSDAoBkDSIrWVKLFRvHKqu8GTsct8Up3MisJhARH3hRH67WIQW
	ro2b/lbqXSbehfJRq64Eaw68GNDnX98VkiMn2mdQiGQCN5IqOthztG789taXdX94+YkqscxlNIN
	/2eAga+nrOKVb4qLD8p1tsQeOSPZW7AhCqdPrnKX4metDPKgbrc4+13KOzE0ZPn/Ep9837pz2cy
	mLXiVoRKksNKCFqiYSauinwG498qEywLS4NPB1HOdO8/dCcCDE4+mtOWRJ26j6/CO6ls4cNL1Xt
	OjKt5DisKhGy4cIwDbpL7bkocB+g5HbTScNIjksJn1fX5BWqL5pkSHzq4btKfeiEmwl17uK4VaF
	4O9Q+cZith1SFPgnTg1VrMv5RYHVSDLxDSb4EYTgp0XpluZxH
X-Received: by 2002:a05:620a:400f:b0:939:7e48:f937 with SMTP id af79cd13be357-939806da346mr3905964685a.34.1788987386143;
        Wed, 09 Sep 2026 13:56:26 -0700 (PDT)
X-Received: by 2002:a05:620a:400f:b0:939:7e48:f937 with SMTP id af79cd13be357-939806da346mr3905960785a.34.1788987385680;
        Wed, 09 Sep 2026 13:56:25 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-193.net.columbia.edu. [128.59.176.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fba2c3esm1504798685a.36.2026.09.09.13.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:56:25 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Wed, 09 Sep 2026 16:56:17 -0400
Subject: [PATCH RFC] ext4: never fall back to buffered I/O for atomic
 direct writes
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-ext4-atomic-no-fallback-v1-1-5a6b9539c002@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAPDHoWoC/yWMQQrCMBAAv1L27ELaWqVeBR/gtXjYrBtdrYkkU
 QqlfzfqcQZmZkgSVRLsqhmivDVp8AXqVQV8JX8R1HNhaEyzMb3pUaa8RsrhoYw+oKNxtMR3tHX
 XGdpS69hBqZ9RnE6/8wDHwx5Of5le9iacv09Ylg8o+r4egAAAAA==
X-Change-ID: 20260909-ext4-atomic-no-fallback-b1550a7a3fcf
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Baokun Li <libaokun@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Zhang Yi <yi.zhang@huawei.com>, Christoph Hellwig <hch@lst.de>,
        John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788987384; l=2513;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Eu+0Om4nXxfhek9V2AOG88l8xsxFV6d4kLyWXbtDvRU=;
 b=hP4uTw3T93DqPxhf6WfvMmeepkGXSHcHNK0KjYju1xI/5qcBbLiisM5f2b99lfMB4oqigXcKr
 HiFHq/XknnbCc7mLX9Dl1pQGFYFWp/WTU+kgC/z3CMkQkfA6ZfOxIa/
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: 8CJKIZKlUancNjkQ_pESdc1_aJwtvQnU
X-Authority-Analysis: v=2.4 cv=Gr7XaU1C c=1 sm=1 tr=0 ts=6aa1c7fa cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=fJxgZNdXt3opHMdyAp+FXA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ExgVtMUaGOEd3M8Mp4cA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIzNSBTYWx0ZWRfX3h8cSSVZGDGO
 OcP6Nw5Oav/eBDo8fXJJdd2nkm0anzJrUMNawEPC+RGo7dg26qO+Hsm1q78JU2A4MEwtJZETJVH
 l5nEwWR9209lK1mVX1EE2MmheyqvUFiUlHq3wFLBvqpIvl2WBcdlqQt0lHPVbNoPZ+821AuUJGG
 Tzwi1iaxyBTUq/sGpRotLpiOMw67VzV7dJlnn5mZ50W5Pl9WO6ioBVkUZIu3CIJa2hvwA6ruY01
 DiT02cjk7F0ldjJfns3leL7jWj6DtEI9TbGvNDkd2i0/mfsDdeYifiD+usLUR50sL9TYf0uMule
 54Hl3/183V2tXnTnQqD/RMeN5rUBRc8DFI5g/P6quOCW3vNCE6UMi/T1+NJKb8E/rA7jF6zUKE8
 w0e24q36z81Dy7F1pGp48B6P6rctBadEFJ++WsllhRZSgLiIU7AMfcE449gSYRQGosIKcSPuPYa
 vfngPS+I6GtgRHIhFbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIzNSBTYWx0ZWRfX6EggbMOw+Y+N
 Rk9lCzEx71arCaldxhPx1JTrQPAaYoRsOMxHudxYgqdmb3qja70cGEiViu2Y3W67rcdn4i2ejaL
 79APVoOs220b4pb8wZFW/HHSMkh1kOEpRxce+sCimvFSPROonllF
X-Proofpoint-ORIG-GUID: 8CJKIZKlUancNjkQ_pESdc1_aJwtvQnU
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11900
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=10 priorityscore=1501 clxscore=1015
 adultscore=0 malwarescore=0 suspectscore=0 bulkscore=10 impostorscore=10
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090235

ext4_dio_write_iter() finishes a short direct write through the page
cache. For an atomic write that path only warns and then continues,
which would tear the write.

This came out of a block device fix [1], where an IOCB_ATOMIC direct
write could complete short when only part of the buffer could be
pinned, with the rest going through the buffered fallback. Christoph
Hellwig noted that ext4 has the same fallback and only warns in it [2],
and John Garry agreed it should reject the write instead [3].

In contrast to the block device, nothing reaches the branch on ext4
today: iomap requires the mapping to cover the whole atomic write, a
buffer that can't be pinned in full fails in iomap before the bio is
submitted, and a failed page cache invalidation returns -EAGAIN rather
than reaching the buffered fallback. Exclude atomic writes from the
fallback outright instead of WARN()-ing inside it, so any future bug
yields an error rather than a torn write with a WARN().

Link: https://lore.kernel.org/linux-block/20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu/ [1]
Link: https://lore.kernel.org/linux-block/20260907071217.GD934@lst.de/ [2]
Link: https://lore.kernel.org/linux-block/a7752d1e-8ec1-44d1-a266-c287c315e8ab@oracle.com/ [3]
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/ext4/file.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 374b4bc25bd5..fb561c701d29 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -666,17 +666,16 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	else
 		inode_unlock(inode);
 
-	if (ret >= 0 && iov_iter_count(from)) {
+	/*
+	 * Buffered I/O provides no torn-write protection, so never finish an
+	 * atomic write through the page cache. iomap should not return a short
+	 * atomic write anyway.
+	 */
+	if (ret >= 0 && iov_iter_count(from) &&
+	    !(iocb->ki_flags & IOCB_ATOMIC)) {
 		ssize_t err;
 		loff_t endbyte;
 
-		/*
-		 * There is no support for atomic writes on buffered-io yet,
-		 * we should never fallback to buffered-io for DIO atomic
-		 * writes.
-		 */
-		WARN_ON_ONCE(iocb->ki_flags & IOCB_ATOMIC);
-
 		offset = iocb->ki_pos;
 		err = ext4_buffered_write_iter(iocb, from);
 		if (err < 0)

---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260909-ext4-atomic-no-fallback-b1550a7a3fcf

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

