Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1917565
	for <linux-block@vger.kernel.org>; Fri, 31 May 2024 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146649; cv=none; b=ekGufcBlGpLiRL7VIXkL7iIG0uqvfZClbfL6gOon9ulkDHE34gUFcheCE7/A8/X4HoWEX4HpgsNtOhFR9/oPXgoYrjgvVVsRQ2fb8jQfuMGWoB/yzKxTIo0jFRXM7A1qSNwNF4MrAsk7DI5Bso6KQwIwgNG/R3q92FlHw9fSUpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146649; c=relaxed/simple;
	bh=8k4FpKQXsM42cdPZUF+s9v5Mg/QNDBjS55kjfvqjdRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=NnaRw47a/6CPhSPBAvyu3QNaar9oSxpH9hSgKfwbqPN+rgxIesv8O26ySwvCPvLPzM38gFrC5EwwsvKSBQRH4gdBuhMLBfGEoxye7II9e4l4qu3+2iQyv1qOecTBKHXupw0PgrNjHGZhIM8Evl6NJ8h8+r6KsmsJ/BjIY27bLOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uM1Wcmpc; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uM1Wcmpc"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240531091042epoutp0332cfbcf2a429a03376839e192852ec86~Uh8YXOoOR2766727667epoutp03g
	for <linux-block@vger.kernel.org>; Fri, 31 May 2024 09:10:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240531091042epoutp0332cfbcf2a429a03376839e192852ec86~Uh8YXOoOR2766727667epoutp03g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717146642;
	bh=DT5kVb5GgEEKGoo1ZoN8PwlN8iNvooLbd2zvQBMGthY=;
	h=From:To:Cc:Subject:Date:References:From;
	b=uM1WcmpcIWdeoerK8Hd+OetLjrBldJJsWsxYV+SV7mz7phLHJB/sDJASeNczoUCcH
	 P/47KT2v2IP8IQh82vqG5YilbYBNu+VlIvlZHkzEnBUyDlyqoaPvwAqjOTRah8EO2V
	 eLDRuZ7oLma7ThFzjYVYW6rsdA/MVv5Y2bhjYXW4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240531091042epcas5p3d1ba5dcb04dc1049d8b56812ed2afc76~Uh8YE537D1063210632epcas5p30;
	Fri, 31 May 2024 09:10:42 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VrHQl3yM9z4x9Pt; Fri, 31 May
	2024 09:10:39 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	10.FD.19174.F0499566; Fri, 31 May 2024 18:10:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240531091021epcas5p48fdbd6302bec7a91ff66272c600b0dab~Uh8ELyE0W1099010990epcas5p4Q;
	Fri, 31 May 2024 09:10:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240531091021epsmtrp2c323fb7a21eb06df67d6796a51a83ba7~Uh8ELFANl0785607856epsmtrp2y;
	Fri, 31 May 2024 09:10:21 +0000 (GMT)
X-AuditID: b6c32a50-87fff70000004ae6-45-6659940ff427
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5A.2A.08336.DF399566; Fri, 31 May 2024 18:10:21 +0900 (KST)
Received: from testpc11818.samsungds.net (unknown [109.105.118.18]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240531091020epsmtip2cf9a4abb2229fdcd69b2ef2551973b03~Uh8DRiGP00314203142epsmtip2S;
	Fri, 31 May 2024 09:10:20 +0000 (GMT)
From: hexue <xue01.he@samsung.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hexue
	<xue01.he@samsung.com>
Subject: [PATCH] block: Avoid polling configuration errors
Date: Fri, 31 May 2024 17:10:15 +0800
Message-Id: <20240531091015.2636025-1-xue01.he@samsung.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEKsWRmVeSWpSXmKPExsWy7bCmui7/lMg0g2nr5CxW3+1ns/jVfZfR
	Yu8tbYvLu+awWZyd8IHVouvCKTYHNo/LZ0s9+rasYvT4vEkugDkq2yYjNTEltUghNS85PyUz
	L91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKuSQlliTilQKCCxuFhJ386mKL+0
	JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj29+3bAXNHBU3bq1ga2A8
	ztbFyMkhIWAicWrpUyCbi0NIYA+jxMsrLYwgCSGBT4wSnxosIRLfGCXW7F7DAtPR0LqPGSKx
	l1Fiz6Lv7BDOD0aJrv2dYO1sAkoS+7d8ALNFBIQl9ne0gnUzC8RKHF32ACjOwSEsYCVxdTYT
	SJhFQFXi1qZXYDavgLVEz4//rBDL5CVudu1nhogLSpyc+QRqjLxE89bZYEdICGxil9iwcj3U
	dS4SV3euYYSwhSVeHd/CDmFLSXx+txfq53yJyd/XQ9XUSKzb/A6q11ri35U9LCC3MQtoSqzf
	pQ8RlpWYemodE8RePone30+YIOK8EjvmwdhKEkuOrIAaKSHxe8IiqPs9JC5/WcEGCdFYiVMb
	lrNNYJSfheSdWUjemYWweQEj8ypGqdSC4tz01GTTAkPdvNRyeMQm5+duYgQnPq2AHYyrN/zV
	O8TIxMF4iFGCg1lJhPdXekSaEG9KYmVValF+fFFpTmrxIUZTYCBPZJYSTc4Hpt68knhDE0sD
	EzMzMxNLYzNDJXHe161zU4QE0hNLUrNTUwtSi2D6mDg4pRqYlunEtLekxP8/0cF1afauZ9OZ
	VHYd7nF6ff5Cx49/Bbe0j15IYF8fqj2d9d/blf1BC5dn8YaVq8QUvLKc+ujv5ze7fv7nOp//
	6sKitYaeTtNF/m2K2RW1qy/K0vdfyeWqkhuxzt/bnaMLxBovJGxaK7/D8faUhlvfYraWZUUl
	pTr8vyCycvH2VaLXk63WspuVdf084t9Q69j9p+rNj9OPv16cH2wivsdfQZ3R8YbUL8sPz3m+
	HpjV2Nd88v7Ug3P8lk3TEr6U5ZE62+j/c6aq1uu9UUXrL3JMPHRzktV0yQoB6R0/DU1Kwip9
	W2eZBiXLPlLiVhYQD/B/tzLhtEeA91fDtrc/ZuUIP2+UTbJMU2Ipzkg01GIuKk4EAGjKgD8F
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLMWRmVeSWpSXmKPExsWy7bCSvO7fyZFpBl1drBar7/azWfzqvsto
	sfeWtsXlXXPYLM5O+MBq0XXhFJsDm8fls6UefVtWMXp83iQXwBzFZZOSmpNZllqkb5fAlbHt
	71u2gmaOihu3VrA1MB5n62Lk5JAQMJFoaN3H3MXIxSEksJtR4uG0m+wQCQmJHY/+sELYwhIr
	/z1nhyj6xigx58QMZpAEm4CSxP4tHxhBbBGgov0drSwgNrNAvMSlqeeBajg4hAWsJK7OZgIJ
	swioStza9ArM5hWwluj58R9qvrzEza79zBBxQYmTM59AjZGXaN46m3kCI98sJKlZSFILGJlW
	MUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEh6CW5g7G7as+6B1iZOJgPMQowcGsJML7
	Kz0iTYg3JbGyKrUoP76oNCe1+BCjNAeLkjiv+IveFCGB9MSS1OzU1ILUIpgsEwenVAPTnPMe
	C+/sVmtR9Sq3i3hbx+gVnbJwItflCrdfgW8+BzXPYOesPsWuaPjr2cGXXz+2HP1y/MLDqZP/
	9GllB67UafMyzYxW9GRwWV2g2rptVpL2+rYjV+NjFu8ovCG2KS3SsM1qxkQhmSvrtXKMNLrW
	rr7KXMzRtkTz5LQu5yC/o/XBqotn7tl2ev+5plJ/6V5JxSXBYuuePpT9UfWVuXuOWJDVnnnZ
	HCsYaw8yuaZeY2vVLrSYeKCjJZmheq1My9rNSWUfGiaFx3n9s6+8zLtr53/T9588Ui0uCbjc
	+uXkfmdf36dphdITp/S/3btv97WzUU0LPyo7pPhO9qj6cUVsgowL8/2DbKphF48Y+xxWYinO
	SDTUYi4qTgQAnQ4zc7ACAAA=
X-CMS-MailID: 20240531091021epcas5p48fdbd6302bec7a91ff66272c600b0dab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531091021epcas5p48fdbd6302bec7a91ff66272c600b0dab
References: <CGME20240531091021epcas5p48fdbd6302bec7a91ff66272c600b0dab@epcas5p4.samsung.com>

Here's a misconfigured if application is doing polled IO
for devices that don't have a poll queue, the process will
continue to do syscall between user space and kernel space,
as in normal poll IO, CPU utilization will be 100%. IO actually
arrives through interruption.

This patch returns a signal that does not support the operation
when the underlying device does not have a poll queue, avoiding
performance and CPU simultaneous loss.

Signed-off-by: hexue <xue01.he@samsung.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 01186333c88e..0afcd74ae939 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -913,7 +913,7 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 	q = bdev_get_queue(bdev);
 	if (cookie == BLK_QC_T_NONE ||
 	    !test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
-		return 0;
+		return -EOPNOTSUPP;
 
 	blk_flush_plug(current->plug, false);
 
-- 
2.40.1

