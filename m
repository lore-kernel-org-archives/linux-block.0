Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387D46EC79
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 13:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925042; cv=none; b=ohJZsFe+DoS0/AtCf6sSf81rBuBewP93spRPrTO32VbGfMA0Pbqm+EAfH3jSI5xndxQAvk2TyfzBcdPqgWDV6v33KDszX2cowulonJGr2bnn4CB5tCzCO6gHRYW6QIiEiw03skKrDqxb7UA9/j1Cg+Ha3Xei/47huyhcOaH4Tzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925042; c=relaxed/simple;
	bh=CLBEYcKpWyuhrcgiMUWFD60aO3Fph2vHxszmT1moq34=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sEN2u31wP71RLlvKsuKd/vRTjz/Yu1tURKRyQCgx02OCxUCGkIhiWeJUXd4oSZyQwUNYE0c0cO7/0sdM4ZIME1cBQN0XZKHuFS9FP2xrx23iuEfau0XDr7T8Bzgpdd9DkDAbbFDxZUxWsxs7ibIp++BGzgY6QD7hzjMKLjHYywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=lXpIiGs1; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=2ZJ6UdCc; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="lXpIiGs1";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="2ZJ6UdCc"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SCY8BL1743154
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 09:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Bgm9
	Lli18Fm8IY/j8xR8FpbXhUGGdPwb42mwnsGVJrE=; b=lXpIiGs1yvcVkoXZ+BRp
	aah3VZmrUyPV6mFS+VhqketrNQ2RqfVXqEBYRnBkUUe0o1wV1AYa0MGOKHwFgFWr
	vyu9F5LMzBI43aWEGi9OqL6qIbtzM1HYbbMBdh5tceTRAk5+1jvHcNYqnGUFA23b
	jSGjI+NBOaTwoTlsW16joScTiICVC0oDIRd9BpfITfAPkKVItUWKreTrVu/0ra7D
	I6ywj55ZQa8Fy8Pd9cpSS5TmaFHUBJH2kt3Nhys/EKQERzQjFv7sXmNJUUhXAcnl
	ymXEWf6xv76Ppn8D1ed/iS5bUJwevRDN9KYSm53uiU78uxa3QNNkj1SZfj9Atb4w
	vg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gaufacg2s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 09:50:40 -0400 (EDT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90c8da50f4fso9721176d6.0
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 06:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787925039; x=1788529839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bgm9Lli18Fm8IY/j8xR8FpbXhUGGdPwb42mwnsGVJrE=;
        b=2ZJ6UdCcyrJinjZQ/lBFbR+QmLb48TYCes6ouy9jqUHD6V5wnZ5XI7QluGc5R/6/Jx
         udiJp8rnvMJjANjcFUeG05V95CKvxeONXBCb99+gIwIHKQyE1+QkVpZD7O5WdVfBcq5G
         Z3NxsqMoFmUypGX/aLAZy9kBSX3NsW61kPQbCZU4N3wt3Nl1K3hcBl8tjVAaBWnNZKCk
         RLPwsYxbqocI4TZVCF2SXvB8tNoJJGnkripSQu5bpHmniaI87jxNvmlI1w/HGfQ9BwLj
         RCi1sCBrCNDxYJ6kMgaAPlAT1K1CDLW4d3SxHtEzMim829c+2ds1i4zGGLPfRK3YUML5
         mb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787925039; x=1788529839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bgm9Lli18Fm8IY/j8xR8FpbXhUGGdPwb42mwnsGVJrE=;
        b=RcxawgWC8zG6NpR1Iz/5UqPEB7SbiTkYVmjdQczAFqH5nWBUUkrpA+PecN2sMuZcRN
         Gv+wbBB/uk9rTvozJJ7zYVDaU1bTA8GU+p24rMVpHGkn8zdIfDpY2kENGXkdz0AWNW17
         Xz1TbMqe9UnnVMwxhCHuD2S7EJZtS7CvyNEkShW3yZPdV+TIHkA/nlFNgDY4zpw89mm4
         aonEOsmUaA7hnuXi6N1+CTgOOzU+jp74bVK56+sobItAYbBpFF49ge1DFwBnARB7Cr2P
         zZrgYgCtFakglUfc1UIkeEwqkbKnHSbP82uvlyAi7LYk6SSEHOs3EFOXcLGa0QeA9ttv
         jMYA==
X-Gm-Message-State: AFuF++niy+qjy5N8+qhkIqbJCgjx4T1/XvGF6K3peeCDkNgImjt29xP6
	Pia7FbY4/2IkQE1ZZkMnoZREdvXnzS7G9y93bC/faxqCsWP0r0lKc8i4eYbi3vfEj8dKcvW6ZD5
	v8NyD9NhLzjBYm1PwE1dFC4nkGiBEAcLkhaDhFTbOiG/btiik+6oEL4uV2fV9
X-Gm-Gg: AR+sD13P2iLayrPG1hjj6FbUElCiXgEXLaz7WQ2xS2mmfbSAUhLY+wYVjq66306RC0y
	yZRvEyBaHfb067FAYsEP7U/kqrE8aNVGvbjKpNFNX35nyBxRNn9KRzSoaCAwzVDXso0YJNola5y
	dQE52ZILPQStRgksQ+mYEWbDQc2m7UtFUeMp/XKAlU/ptpBz5q7jaTVGBlAvh01AUKqpgxSD8uC
	JdB9dk+zcjpP4mKyQntLwaRLVk+IunO4LSSH6NXlLfhibp4j1RRYcKlxUgPY9NGOHRZGNzjNTnE
	37vLdiYINqrkfishNu7xBWNxAlsRckOUY/y2AWSpwT9oc1Q95ObOOT43JL8UfTVll/DEaF7uSxV
	WdLq5K7ga
X-Received: by 2002:a05:6214:234e:b0:8cc:ea2c:f2b3 with SMTP id 6a1803df08f44-90ce0f0a733mr76345886d6.21.1787925038956;
        Fri, 28 Aug 2026 06:50:38 -0700 (PDT)
X-Received: by 2002:a05:6214:234e:b0:8cc:ea2c:f2b3 with SMTP id 6a1803df08f44-90ce0f0a733mr76345216d6.21.1787925038479;
        Fri, 28 Aug 2026 06:50:38 -0700 (PDT)
Received: from [127.0.1.1] ([45.130.83.151])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce4534ebesm15645116d6.48.2026.08.28.06.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 06:50:37 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 28 Aug 2026 09:49:56 -0400
Subject: [PATCH v2 7/7] block: remove dead metadata handling from the async
 direct I/O path
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-blkdev-fixes-v2-7-32f3f40cebed@columbia.edu>
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
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787925005; l=1284;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=CLBEYcKpWyuhrcgiMUWFD60aO3Fph2vHxszmT1moq34=;
 b=5WvKxt3K2LYokFDzH4WeJTFTA7gEIVIWCTmbVlba+tySOCaeA5kMtbAcp9DpKL341If1ztIEY
 xh3MbLbTCOAAGoQ8NrQGpjPrFv+GQRpn8+uJLIHNzo8rEQPhfBCqT+R
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDExOSBTYWx0ZWRfX6dzIDrHiZvvW
 9x+24bXQBmnrjYiQmt29pcHkmPIiNoqws50Ea1Phb6GVon78FTf6dHF+NUOE472yDdErqYpduAm
 9HqW+19hUuY+K7IGJoO+NK4wKQqIuNAmZJhLofEIlxjOM5N2IaRNKMmzz8WqiXWmQAkdCLM1fJ0
 nQxUwCY8uhlBOUJxpKVcVcX5GKQg3dsKgBZrzFTPXm0V1fuoz35QqIQLIOOJbMlJIukA8kpxvCD
 YS/f90NYkeB/BD9LgPl8ox4oYA1ixWLHgTUmxX901OtC5xTBqt6yq/mrhNUyAYmkQ6uNe06wPOH
 lqiSoEsAZYpZ8jnhaKMPz+CJ8BSdaolV1gx5EueWgv2Uon4H+d9p2naXvvqWv5coiMqSi/yE84Q
 KU/WIopSL7zYj43G1rsuccqFTlZwr2+QjJP+6EA9i30DUL9ANdDYc+XTFwVDdt6KAo3sFWNQFvt
 EZx5RyOfiMYCNMxvMWQ==
X-Authority-Analysis: v=2.4 cv=PIc/P/qC c=1 sm=1 tr=0 ts=6a919230 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xDWFIMX55ayQNp92vt0S/Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=YZNyPf5b8iN1AD22L6QA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: yADhLvt68QMmaVoRxAdd6_1SA2Qe6_W_
X-Proofpoint-ORIG-GUID: yADhLvt68QMmaVoRxAdd6_1SA2Qe6_W_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDExOSBTYWx0ZWRfX4s0T0dW8q6j0
 xZ8csAm7WsB+Ws+BUHipAvnEnutuNlHm2Q5B3atJnKLofGPszqZd8c60zy016AizkTC6ysJ6hnS
 acyxAXqt6/GMQD4HIXPOaKocRAaPKzInLxBD2i6pLI1yIanDhs3n
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11888
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 impostorscore=10 malwarescore=0 spamscore=0 bulkscore=10
 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280119

Since commit 2729a60bbfb9 ("block: don't silently ignore metadata for
sync read/write"), blkdev_direct_IO() sends every IOCB_HAS_METADATA
request to __blkdev_direct_IO(). Remove the now unreachable metadata
mapping in __blkdev_direct_IO_async() and the unmap in its completion
handler.

No functional change.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 8769bb13df1c..1964cb113842 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -312,9 +312,6 @@ static void blkdev_bio_end_io_async(struct bio *bio)
 		ret = blk_status_to_errno(bio->bi_status);
 	}
 
-	if (bio_integrity(bio))
-		bio_integrity_unmap_user(bio);
-
 	iocb->ki_complete(iocb, ret);
 
 	if (dio->flags & DIO_SHOULD_DIRTY) {
@@ -376,13 +373,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
-	if (iocb->ki_flags & IOCB_HAS_METADATA) {
-		ret = bio_integrity_map_iter(bio, iocb->private);
-		WRITE_ONCE(iocb->private, NULL);
-		if (unlikely(ret))
-			goto out_bio_put;
-	}
-
 	if (iocb->ki_flags & IOCB_ATOMIC)
 		bio->bi_opf |= REQ_ATOMIC;
 

-- 
2.39.5

