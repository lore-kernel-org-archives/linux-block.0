Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E20586621
	for <linux-block@vger.kernel.org>; Thu,  1 Feb 2024 13:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706792938; cv=none; b=rj9NBuCPYBeEleogq0Xtq2g9Iv37gqFHnazsqsOZbzc5h2nNcs7sImAC5sEWu6CUo90XbQThPYy8SV+8oLdNUtVQNdm1FVz0MbOiGZ8clqp1MUv5ZM4LvjS/LEzkj9Q5xQ2znBpmXiCihZ3VcarWl+ZYjoq3vKNCZt8IDtyPgHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706792938; c=relaxed/simple;
	bh=CRkHxd+r6CjzQ8ldDZDrF6LE/fLNwTfzIJUvyZQGWAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=dawXpDlRLJ5Z7BSUNyn14yqhKkbF0p4PFUZ5/vJMkt0ezr3xhDaI+Fdy1TI5oJGYDcQ6vuvafKsCVEoULfBbMrIi+f2qexo8NNpOyf8aYP4Y51bXeaEfDC7kU/Dbp2IwNzSCIb/pLDd8/TtnxtMUbMeKCfl85yH7vJazPku0hjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eo4AGG1c; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eo4AGG1c"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240201130853epoutp037ad31a9d7ddf7fb4da53e9d6f44208a7~vvyFjxKSs3226732267epoutp03L
	for <linux-block@vger.kernel.org>; Thu,  1 Feb 2024 13:08:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240201130853epoutp037ad31a9d7ddf7fb4da53e9d6f44208a7~vvyFjxKSs3226732267epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706792933;
	bh=xE87XiyEjpN27Y86mxPEvfdrpWQvIouz/q38Jljw4ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eo4AGG1cBGI9RD642Ox6Exm6cnAYfFVLfNtTD9/Tg9YUcsOd+X2ksWZZUf8JNQRis
	 6re10mAnHVkhY3iiCNRWeg0Hw07qutuT8AmIU/SkM3Oaciw2gmq4vbbwmppCm65TxS
	 MlTdoaMiQCrIkPrG9gAJrCv8h2OvWqTCHz59AV/s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240201130853epcas5p24c9b8187102ec3665160c1a8481d253c~vvyFAxDLi2489924899epcas5p2p;
	Thu,  1 Feb 2024 13:08:53 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TQfNz3Fn0z4x9Pt; Thu,  1 Feb
	2024 13:08:51 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	11.D7.19369.0E79BB56; Thu,  1 Feb 2024 22:08:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240201130848epcas5p3e1ac78cdf99d3fdd1db1cf76f7e1c6df~vvyASIP-D0679006790epcas5p3Z;
	Thu,  1 Feb 2024 13:08:48 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240201130848epsmtrp2d9eb15333c8082974d9183d49dcee623~vvyAQ79Xe2690026900epsmtrp2P;
	Thu,  1 Feb 2024 13:08:48 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-85-65bb97e0c7f4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A7.DF.08817.0E79BB56; Thu,  1 Feb 2024 22:08:48 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240201130845epsmtip1eec821d1997ad66d56f5cc28baa183a3~vvx96b6Js2596825968epsmtip1M;
	Thu,  1 Feb 2024 13:08:45 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH v2 3/3] nvme: allow integrity when PI is not in first bytes
Date: Thu,  1 Feb 2024 18:31:26 +0530
Message-Id: <20240201130126.211402-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240201130126.211402-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmpu6D6btTDX6fULRYfbefzeLmgZ1M
	FitXH2WyOPr/LZvFpEPXGC323tK2mL/sKbvF8uP/mCzWvX7P4sDpcf7eRhaPy2dLPTat6mTz
	2Lyk3mP3zQY2j49Pb7F49G1ZxejxeZNcAEdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmB
	oa6hpYW5kkJeYm6qrZKLT4CuW2YO0HFKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKU
	nAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMja+fsRVc5KtY9nQzcwNjK08XIyeHhICJxJNf
	D5m6GLk4hAT2MEpMOX8YyvnEKPHz90s2COcbo0R7531WmJZDXxayQCT2Mkpce/sRquozo8Ty
	rjdADgcHm4CmxIXJpSANIgJJEh/7zjOC2MwCNRKX755mArGFBbwlvmz/zwZiswioShy70MMI
	0sorYCkxf1cgxC55iZmXvrOD2JwCVhL9U9rBynkFBCVOznzCAjFSXqJ562xmkBMkBHo5JFZe
	38wM0ewi0XRkHZQtLPHq+BZ2CFtK4vO7vWwQdrLEpZnnmCDsEonHew5C2fYSraf6mUHuYQZ6
	Zf0ufYhdfBK9v58wgYQlBHglOtqEIKoVJe5NegoNHnGJhzOWQNkeEk2fzjBDQqeXUWLt4lnM
	ExjlZyF5YRaSF2YhbFvAyLyKUSq1oDg3PTXZtMBQNy+1HB6xyfm5mxjBaVQrYAfj6g1/9Q4x
	MnEwHmKU4GBWEuFdKbczVYg3JbGyKrUoP76oNCe1+BCjKTCMJzJLiSbnAxN5Xkm8oYmlgYmZ
	mZmJpbGZoZI47+vWuSlCAumJJanZqakFqUUwfUwcnFINTMIeS1RFvuoeKvMVNHu1nf3kh0W+
	vz7kJX1qm6t5cLH1lWNaNorcuzbfeV0S4PNzoerNv18tPlfZfdyjqc9Ru6j5+CKjzgdSiSfq
	HoisFn6/+3W94OHbS8/+9OQPKQ5NePL3XHSBqo3WlTM7vc4cjUt/8OP47hAHa73mRuFZnZEt
	qxUehX1XYJAMfLV5rsoj1fq73G9fzmdtnLdp0ecjX7xvaZyUzd14cuL6A/+0K3KeMxhWKM0P
	SZVwz1w0TTn7xor9pZddvrH+uq185PL5Jcofvh7ZcvnZLOdNBTsPPT2rr/iRQfhHx+QOxzWP
	bs76vOL//HPFOy7rzn9bcXjFepddITwL94jGW2noyO9JkhfOVGIpzkg01GIuKk4EABYTO/Is
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsWy7bCSnO6D6btTDf6vZLVYfbefzeLmgZ1M
	FitXH2WyOPr/LZvFpEPXGC323tK2mL/sKbvF8uP/mCzWvX7P4sDpcf7eRhaPy2dLPTat6mTz
	2Lyk3mP3zQY2j49Pb7F49G1ZxejxeZNcAEcUl01Kak5mWWqRvl0CV8bG18/YCi7yVSx7upm5
	gbGVp4uRk0NCwETi0JeFLF2MXBxCArsZJQ7+W8oGkRCXaL72gx3CFpZY+e85O0TRR0aJLd2N
	TF2MHBxsApoSFyaXgtSICGRIdPyewQxSwyzQwCix7vUuJpCEsIC3xJft/8GGsgioShy70MMI
	0ssrYCkxf1cgxHx5iZmXvoPt4hSwkuif0g5WLgRUMm32FLA4r4CgxMmZT1hAbGag+uats5kn
	MArMQpKahSS1gJFpFaNkakFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcARoae1g3LPqg94h
	RiYOxkOMEhzMSiK8K+V2pgrxpiRWVqUW5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7NbUg
	tQgmy8TBKdXANGHJjtDabQfeic/21myWuqjtefRRppvN5luno70sznrd5vnD0aVWesTO6Fjp
	Aoauxda1KT+k1jA/vvo51enExR8s13eL6T8LE5ZbYZ88Q43zzqp5Kx0L3vyayJis9N8jbVPX
	yb/ftj79ZNW1tXv2/XPGaUGfeHnlLKTdI+3bP6inSZy0XCe2Zqm9QSJjaE9zhJ2wv2TLkhzW
	yf9uWPS7/p3WnGDecom9+EzPkqT6D4uK3lfubfRrCAgUW9ah2chdFJTnVP6id9kaDy4h73Xi
	uwT2yBzkv5sXVWWx70aTHMsOkb2rf7+y2FT+bM/Tz02Je+dm9ngvtTs7nfnjVtfUa7p7X09f
	VC16SihmPYetEktxRqKhFnNRcSIAqmoAi+8CAAA=
X-CMS-MailID: 20240201130848epcas5p3e1ac78cdf99d3fdd1db1cf76f7e1c6df
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240201130848epcas5p3e1ac78cdf99d3fdd1db1cf76f7e1c6df
References: <20240201130126.211402-1-joshi.k@samsung.com>
	<CGME20240201130848epcas5p3e1ac78cdf99d3fdd1db1cf76f7e1c6df@epcas5p3.samsung.com>

NVM command set 1.0 (or later) mandates PI to be in the last bytes of
metadata. But this was not supported in the block-layer, and driver
registered a nop profile.

Since block-integrity can now handle flexible PI offset, change the
driver to support this configuration.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/nvme/host/core.c | 8 +++++++-
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85ab0fcf9e88..4945d6259a13 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1726,6 +1726,7 @@ static void nvme_init_integrity(struct gendisk *disk,
 	}
 
 	integrity.tuple_size = head->ms;
+	integrity.pi_offset = head->pi_offset;
 	blk_integrity_register(disk, &integrity);
 	blk_queue_max_integrity_segments(disk->queue, max_integrity_segments);
 }
@@ -1835,11 +1836,16 @@ static int nvme_init_ms(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
 free_data:
 	kfree(nvm);
 set_pi:
-	if (head->pi_size && (first || head->ms == head->pi_size))
+	if (head->pi_size && head->ms >= head->pi_size)
 		head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
 	else
 		head->pi_type = 0;
 
+	if (first)
+		head->pi_offset = 0;
+	else
+		head->pi_offset = head->ms - head->pi_size;
+
 	return ret;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 030c80818240..281657320c3a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -462,6 +462,7 @@ struct nvme_ns_head {
 	u16			ms;
 	u16			pi_size;
 	u8			pi_type;
+	u8			pi_offset;
 	u8			guard_type;
 	u16			sgs;
 	u32			sws;
-- 
2.25.1

