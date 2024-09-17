Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0379474
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726549364; cv=none; b=Q5j8nuUjX5CL1SZaEbxnUo2KsLdK4kb/xXg/fVddzOE7PR6elZv+T50O/m+mEBAd9MoSnb3O5LeU2/VM6k9U7H/gbK+maiGBndfw5FVRNuB/z14Eyc8By76Y91Yh4k80f456+KUZFO3wVnVSAlHOaztgSrJeFeNzJ4sm0MdV6x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726549364; c=relaxed/simple;
	bh=Msi7Ner7crIq3QhA1BupXqtw4DWXj3xdz11MA6VILk4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=EXi8RezZQyhpDyrx1OpbYKwP+2B9tvqdK/TYFUBjTguFjQf09C7CiHlAqPKi8CnDsUJkDmdavuRFB+09Y7Ye7AYvFbsNkZeJSmH6EByktxGMkUglRoFd9VWGcXGzRp4PCFLglDAVlr+KqiaD7D5qsDCEgcIDP9pWF+USo883t4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ViAy9Srb; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ViAy9Srb"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240917050239epoutp01c4dde2b61f0a588744ac5703648afb04~1736t3YTX1382813828epoutp01y
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 05:02:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240917050239epoutp01c4dde2b61f0a588744ac5703648afb04~1736t3YTX1382813828epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726549359;
	bh=252Cv4ekYy1STWc8+OAT60RMqfIJmmf+13KTZeu7ht0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=ViAy9SrboBf0zNkunusjSvGcjGxdRHu2wfkR4GuhieEsbuGmUsK4pw1LaWT0e95De
	 zJ6nz/9zIEHSWiEdAi3TWnAVkouVN9DdRwzYRvE9nWgsbZk/Zf6Pb0tPw/t8moXYtS
	 ADAPUwKCqQIem3PY+4VqVHkT/Y/F0xTIZjFMzSJ8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240917050239epcas5p18c7f2ef05bbd156c46f6bcc5fe1e51ea~1736bCr5g2061620616epcas5p1s;
	Tue, 17 Sep 2024 05:02:39 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4X78mD5Vlqz4x9Pq; Tue, 17 Sep
	2024 05:02:36 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5B.E9.09640.C6D09E66; Tue, 17 Sep 2024 14:02:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240917050236epcas5p3b032bf733800ef5b2b9d1ebe9ce92838~1733cz_-f2558825588epcas5p3W;
	Tue, 17 Sep 2024 05:02:36 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240917050236epsmtrp2bd20fc5567f9cb4851ab937156a5a8c2~1733cONOh2591825918epsmtrp2O;
	Tue, 17 Sep 2024 05:02:36 +0000 (GMT)
X-AuditID: b6c32a49-aabb8700000025a8-87-66e90d6c457c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	06.0F.07567.B6D09E66; Tue, 17 Sep 2024 14:02:35 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240917050235epsmtip25c67a46b83e973f396e9e66f62b157b8~1732opMK12340623406epsmtip2a;
	Tue, 17 Sep 2024 05:02:35 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, martin.petersen@oracle.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH] block: remove bogus union
Date: Tue, 17 Sep 2024 10:24:57 +0530
Message-Id: <20240917045457.429698-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7bCmhm4O78s0gx3LNC1W3+1nszj6/y2b
	xd5b2hbLj/9jcmDxuHy21OPj01ssHn1bVjF6fN4kF8ASlW2TkZqYklqkkJqXnJ+SmZduq+Qd
	HO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7RQSaEsMacUKBSQWFyspG9nU5RfWpKqkJFf
	XGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdMePZZtaCD6wVn09+ZmlgfMfSxcjJ
	ISFgIrHu6CKmLkYuDiGB3YwSa4/sYIVwPjFK3HhzCirzjVFi/5k9cC3fLvcyQiT2Mkq8//wK
	yvnMKPG9+RZQCwcHm4CmxIXJpSANIgLCEvs7WsGamQWSJKafXMYKYgsLaEksnXCbGaScRUBV
	Yk4XD4jJK2ApsX1HNsQqeYmZl76zg9i8AoISJ2c+gZoiL9G8dTYzyFYJgVXsEgvuPWSFaHCR
	OLK6jRnCFpZ4dXwLO4QtJfH53V42CDtb4sGjB1C/1Ejs2NwH1Wsv0fDnBivIDcxA16/fpQ+x
	i0+i9/cTsKckBHglOtqEIKoVJe5NegrVKS7xcMYSKNtDYv2sHrALhARiJZpa3jBNYJSbheSD
	WUg+mIWwbAEj8ypGydSC4tz01GLTAsO81HJ4TCbn525iBCc0Lc8djHcffNA7xMjEwXiIUYKD
	WUmE1/b30zQh3pTEyqrUovz4otKc1OJDjKbAQJ3ILCWanA9MqXkl8YYmlgYmZmZmJpbGZoZK
	4ryvW+emCAmkJ5akZqemFqQWwfQxcXBKNTBtyFDp2V1/m/VRjmzH49uqBe3e011C7MTml1gf
	uXXWpOCE//YijfInc3v171i/NF1UPXeZ6ofFV0QXH3y/j7/Z8p/tzymTHk8uYX4asnidhOas
	8sJ7QanyB/bO3vO6OWCPUGBA9reGW1++vzWd6NXsknmM4ZDPkyWutR5MHo1RxSG7ogz1vcS3
	70phFHhh6xCgsKZgUoLjYeHNnubzJ7Tu1n8UHC/CwHhDsf9r4cviS1WmUzQSgtVOWaUs9rZ/
	tmZH/xOu2iWrj5mdexZ4Y9Y+B3ndnSEer21Mjl33NmT5YPT8oJlkUgDzn+KkZdFvc+Km+ASt
	n7Np+8YLDo7Sy09Vq0xXuxoUmPzNxnbOS0YlluKMREMt5qLiRAA3pLYZ8QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKLMWRmVeSWpSXmKPExsWy7bCSvG4278s0g13NZhar7/azWRz9/5bN
	Yu8tbYvlx/8xObB4XD5b6vHx6S0Wj74tqxg9Pm+SC2CJ4rJJSc3JLEst0rdL4MqY8Wwza8EH
	1orPJz+zNDC+Y+li5OSQEDCR+Ha5lxHEFhLYzSixq0kaIi4u0XztBzuELSyx8t9zIJsLqOYj
	o8Tcx1OAmjk42AQ0JS5MLgWpEQGq2d/RCjaTWSBF4tzPZawgtrCAlsTSCbeZQcpZBFQl5nTx
	gJi8ApYS23dkQ0yXl5h56TvYJl4BQYmTM59ATZGXaN46m3kCI98sJKlZSFILGJlWMUqmFhTn
	pucmGxYY5qWW6xUn5haX5qXrJefnbmIEh5yWxg7Ge/P/6R1iZOJgPMQowcGsJMJr+/tpmhBv
	SmJlVWpRfnxRaU5q8SFGaQ4WJXFewxmzU4QE0hNLUrNTUwtSi2CyTBycUg1MbYULGJXbfOco
	LJmyVE/pVbBFeKvV/s1ro7a6/GJJms37yi1I7a/OgWOv/jkraXFMjnudfSXrfsEvha2bzpz/
	GbCOW76F846bXlDKrX3rLktsfnZsB+sF6UD/XXM9LxzjzDk4993/Xs8U35vu+Wa36njeHbCs
	CObVZ73wSsZR6xbP7SnWu485ty1fzyB9w8hLZp2f9ekb8fv0vu7a57uU51nLXh27mMrYHW8T
	Hu69YFFjV5TwmWFDcBqnW9sxC8fS1g/3nourl9xUbS95tkvm0dm1ZnkXEj5826e2yqztOvOR
	81O4hTaz6fnNqbuy9LDZt9cy6a8fVzr96Dm4/kf6/vUhAsz+Ey8WBifPylmZqMRSnJFoqMVc
	VJwIAJ0ZfDyoAgAA
X-CMS-MailID: 20240917050236epcas5p3b032bf733800ef5b2b9d1ebe9ce92838
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240917050236epcas5p3b032bf733800ef5b2b9d1ebe9ce92838
References: <CGME20240917050236epcas5p3b032bf733800ef5b2b9d1ebe9ce92838@epcas5p3.samsung.com>

The union around bi_integrity field is pointless.
Remove it.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 include/linux/blk_types.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 36ed96133217..6d3a0fff2a1d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -248,11 +248,9 @@ struct bio {
 	struct bio_crypt_ctx	*bi_crypt_context;
 #endif
 
-	union {
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
-		struct bio_integrity_payload *bi_integrity; /* data integrity */
+	struct bio_integrity_payload *bi_integrity; /* data integrity */
 #endif
-	};
 
 	unsigned short		bi_vcnt;	/* how many bio_vec's */
 
-- 
2.25.1

