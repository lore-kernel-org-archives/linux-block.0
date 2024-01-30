Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90EA12BF09
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706635176; cv=none; b=gZu6k2t6a895IAy+GyslVgi/ADQ2pNftE4G9ynWe5WTpTnDRgV1UCMycTHx0j+5OfbowJqyUGgPBZbpOeVDvuCfUg2YVQZoTvTo7Ov2OVOVfrIjh+D8YvxB5F4TQ3mfCh+EJSJa0OvD3dkHQWlNmEVV9ZBtGnNmQ1PXNznjPCHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706635176; c=relaxed/simple;
	bh=FaG92OKvVcuFrGyni+oNU1CWB6DFZBxTn2uqB0pAlYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=tgqr1hC7ylPaMOY8aI1jFwlOouUdHPjuapN0DdFbp+RUalI9jRWgiAUjlH8G1YknKfz05Kq0fI61lgK08E1Fa5ofIq7l4P6upUs9SOgXPQy7njHZPx3gPo5N9xMNtcDhWY+mLhInX5BJWKrNbYhvbsJtBSFgOJ6g8LhS0CYguJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=a9xSckij; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a9xSckij"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240130171932epoutp04049f71af70940ea324f6a117de81e820~vL6XB38G53181931819epoutp04Q
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 17:19:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240130171932epoutp04049f71af70940ea324f6a117de81e820~vL6XB38G53181931819epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706635172;
	bh=O5jRUiGAz+tcp6NhwjqNzP4RxnO5dvmzye0jUTtojvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9xSckijHeS35oDky3U7rRjHpdvtQ9W2RgOc8YX1fElvBq8lwMsimc1pgSZwrf7gC
	 k9aHsOUSD9my/HF1i4bTVa0FcAEM637JVRHXOjt1DzQ8ZD7CHWrXRrVa2XOYCGHH4M
	 4VqcYHFd9lHwHheh9RdSHfQx7PXSb349fcfTchWI=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240130171931epcas5p1224cdc8e535d31fb06a9a29becb5e3bf~vL6WPrc9G0856008560epcas5p1X;
	Tue, 30 Jan 2024 17:19:31 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TPX364rs7z4x9Pq; Tue, 30 Jan
	2024 17:19:30 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C3.58.09672.2AF29B56; Wed, 31 Jan 2024 02:19:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240130171929epcas5p24f6c25d123d3cd6463cbef1aaf795276~vL6Uco8sg1569115691epcas5p2Y;
	Tue, 30 Jan 2024 17:19:29 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240130171929epsmtrp1669927c125c164e66e6f10ca67d07006~vL6UcC0rP2451024510epsmtrp13;
	Tue, 30 Jan 2024 17:19:29 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-b0-65b92fa2902f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	1B.32.18939.1AF29B56; Wed, 31 Jan 2024 02:19:29 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240130171928epsmtip241351b7474fa8bde4e36f47adfcd1b71~vL6TITU8L1888718887epsmtip2E;
	Tue, 30 Jan 2024 17:19:28 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 3/3] nvme: allow integrity when PI is not in first bytes
Date: Tue, 30 Jan 2024 22:42:06 +0530
Message-Id: <20240130171206.4845-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130171206.4845-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJJsWRmVeSWpSXmKPExsWy7bCmuu4i/Z2pBtvmKVusvtvPZnHzwE4m
	i5WrjzJZHP3/ls1i0qFrjBZ7b2lbzF/2lN1i+fF/TBbrXr9nceD0OH9vI4vH5bOlHptWdbJ5
	bF5S77H7ZgObx8ent1g8+rasYvT4vEkugCMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzA
	UNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6DglhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFK
	ToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnbG/MdH2AsW81a0/DnD3sD4gquLkZNDQsBE4svD
	DvYuRi4OIYHdjBLrz35ngnA+MUq8v3meEc5Z9fosM0zL6wmToRI7GSWObloN1f+ZUaLrziWW
	LkYODjYBTYkLk0tBGkQEkiS2vfnMBmIzC9RIXL57mgnEFhbwkHj68AwLiM0ioCpxYvt/dhCb
	V8BcYveGFjaIZfISMy99B4tzClhI9K18zAhRIyhxcuYTFoiZ8hLNW2czg9wgIdDKIdG/aDLU
	pS4Sq5/dZoWwhSVeHd/CDmFLSbzsb4OykyUuzTzHBGGXSDzecxDKtpdoPdXPDPILM9Av63fp
	Q+zik+j9/YQJJCwhwCvR0SYEUa0ocW/SU6hN4hIPZyyBsj0kJje/ZIEETzcwRNdeY5nAKD8L
	yQuzkLwwC2HbAkbmVYySqQXFuempxaYFxnmp5fCITc7P3cQITqNa3jsYHz34oHeIkYmD8RCj
	BAezkgjvSrmdqUK8KYmVValF+fFFpTmpxYcYTYFhPJFZSjQ5H5jI80riDU0sDUzMzMxMLI3N
	DJXEeV+3zk0REkhPLEnNTk0tSC2C6WPi4JRqYKrb8MVEvcfuxcK3y3MfpexofF92LIiBz4f5
	2rrlnvMmyrNn8YQ0Gec9X3AixFY3PsFarTiZa/OGyarn05nyTnH/uz+nfSLzZreLD5x/qWeK
	/BOIfhm9pcTbnfOhX/2XGQuOcPfe+Dp7anD1rR/f0wtnFy6byVoRlrMiz5fPxK9Y+Z39xGma
	jBv1J2/ecebmfYZFl8wMQiO/3GRZKrD06D31cx/fF+5wWxt/jZ2n9+y7Gy9C4zJWZn2pmMHC
	lLx0ot+uHzuib/+MqY1gcF4TPper8duUt+d26n7+mDel3OjH+h2/LdfbmqcsuCccE6ar5crn
	sChox0XDc2xV+WE5B61nCnKvj3t/c/Hiw4LlZ5uUWIozEg21mIuKEwHB8Y6DLAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsWy7bCSvO5C/Z2pBnc/WFisvtvPZnHzwE4m
	i5WrjzJZHP3/ls1i0qFrjBZ7b2lbzF/2lN1i+fF/TBbrXr9nceD0OH9vI4vH5bOlHptWdbJ5
	bF5S77H7ZgObx8ent1g8+rasYvT4vEkugCOKyyYlNSezLLVI3y6BK2P+4yPsBYt5K1r+nGFv
	YHzB1cXIySEhYCLxesJkxi5GLg4hge2MEksn72SGSIhLNF/7wQ5hC0us/PecHaLoI6PEjs13
	WLoYOTjYBDQlLkwuBakREciQmL36G1gNs0ADo8S617uYQBLCAh4STx+eYQGxWQRUJU5s/w82
	lFfAXGL3hhY2iAXyEjMvfQeLcwpYSPStfMwIYgsB1Sz9c5YZol5Q4uTMJ2BzmIHqm7fOZp7A
	KDALSWoWktQCRqZVjKKpBcW56bnJBYZ6xYm5xaV56XrJ+bmbGMGhrxW0g3HZ+r96hxiZOBgP
	MUpwMCuJ8K6U25kqxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc5pzNFSCA9sSQ1OzW1ILUIJsvE
	wSnVwCR+TD7wqpbDPPmDmb3bV9RUxabwbKrwktZP/y63YunpyR7GjP/uhjj9vXfcPPxVZRxn
	dVbpzP7dYubTOJZeT5ba7uNZ/8ll3+ugotc1Mxw6a2UWZd/gE/VLmjTr1krZssqYrvVJBVd+
	NXbvanloKyirMuscQ521ocDftN7Yg7XnFyReeHVkS69zTGNpmI1A8yzdX6qbbt7RexZ+/twD
	2auG7xhusa9qlk82Z+qfuXbtsnunNjb/KBbYavTq0bkydYYHCeeXL+W2anm3JdmS+1pajdKX
	48/bj8f9L0+2vfa80+ZZv+XczX8bpx6eGaTOvuG31yF9qbtWorKyQazfnz6+6xN/jvUYyzZb
	/VOObUosxRmJhlrMRcWJAPUrzOzsAgAA
X-CMS-MailID: 20240130171929epcas5p24f6c25d123d3cd6463cbef1aaf795276
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240130171929epcas5p24f6c25d123d3cd6463cbef1aaf795276
References: <20240130171206.4845-1-joshi.k@samsung.com>
	<CGME20240130171929epcas5p24f6c25d123d3cd6463cbef1aaf795276@epcas5p2.samsung.com>

NVM command set 1.0 (or later) mandate PI to be in last bytes of
metadata. But this was not supported in the block-layer and driver
registered a nop profile.

Remove the restriction as the block integrity subsystem has grown the
ability to support it.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
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

