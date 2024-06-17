Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B0256A
	for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 04:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718600224; cv=none; b=QjbUy0zHYOR/KQgxorXl94Js00BAhXaxkqpHlaq22dvZQQ54MR+yPpgZ1/XuquNDHsPWG+S91vNk5NhEiRp/2xvBRJ9F4ipucYr6Tijt49y1fFxehfWuHQpTPSX+hn8bLsefPeSegSwDd7PB9byRVuc5+jYESXNazuNnLBA2Mcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718600224; c=relaxed/simple;
	bh=cPMHUDXHEad5+LaD4ieA+6YgHcmdRCDNNvjTzdM0RZs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=JO7OGsfIS9YRLygGjEhbxH9N4DEZ2/h7YCtnFcxgarGXuJpKRaycNiSLEZ52FAjXvyVQkHmlY3CRsGYFcjj1TjpxqfGEnTY4csSjA13DY9f6a9/F7DbsWS9q4r1CFjNFlFU/1lSHZeNe1wnFwAjWnOKkZ+bxep1eatPPrTfFGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=E/sm5Tc8; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E/sm5Tc8"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240617045700epoutp03c2083d2cc4a410f885758ce122c72985~ZsctxSbW22327423274epoutp03l
	for <linux-block@vger.kernel.org>; Mon, 17 Jun 2024 04:57:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240617045700epoutp03c2083d2cc4a410f885758ce122c72985~ZsctxSbW22327423274epoutp03l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718600220;
	bh=+LJtr1XCVtQyV7zoHn54pbxvaLacbIDdt2QQjM6M/C4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=E/sm5Tc8cZ5/WS3FWH/VqKWY9FvyvA+Kr5h+roKELrg/c7C6ATFrq5VOOXKZxOa+v
	 9HlEQaNzshJ0TKSeZYi7vuphrQzLK3EsXwLiNbdCqdxSKTCT3ujcJx6VsewRAaUXQc
	 Sn6PYEa1DyqMvrgHVGq6vwzMk5tpU344lztyzO8A=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240617045659epcas5p4ea124dfab839177c8245d0bc5183518e~ZsctiC5WV2873528735epcas5p4Z;
	Mon, 17 Jun 2024 04:56:59 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4W2d0936Zmz4x9Q1; Mon, 17 Jun
	2024 04:56:57 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	48.73.06857.212CF666; Mon, 17 Jun 2024 13:56:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240617045649epcas5p1763924a49c5182f30a9ae3ea013390ae~ZsckQC7w00314103141epcas5p1T;
	Mon, 17 Jun 2024 04:56:49 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240617045649epsmtrp244cced941844fb2e94d149aa30fd3439~ZsckPaUKS3033230332epsmtrp2i;
	Mon, 17 Jun 2024 04:56:49 +0000 (GMT)
X-AuditID: b6c32a4b-ae9fa70000021ac9-56-666fc212eb98
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	86.42.19057.112CF666; Mon, 17 Jun 2024 13:56:49 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240617045649epsmtip1f465930a8f865e299e2de6321e48d4c6~ZscjesEOL2180621806epsmtip1r;
	Mon, 17 Jun 2024 04:56:48 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH] block: cleanup flag_{show,store}
Date: Mon, 17 Jun 2024 10:19:18 +0530
Message-Id: <20240617044918.374608-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7bCmuq7Qofw0g6MbeC1W3+1ns1i5+iiT
	xdH/b9ks9t7SdmDxuHy21GP3zQY2j74tqxg9Pm+SC2CJyrbJSE1MSS1SSM1Lzk/JzEu3VfIO
	jneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAVqopFCWmFMKFApILC5W0rezKcovLUlVyMgv
	LrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUqTMjOONPewFxwXKhiaXNOA+Nm/i5GTg4J
	AROJM53zGbsYuTiEBHYzSuw4txbK+cQoce/LF1YI5xujxNrfR9lgWs4+3sAEkdjLKDH3xlGo
	qs+MEo8f9rB0MXJwsAloSlyYXArSICIgL/Hl9loWEJtZwEXiYeMDdhBbWMBQYs66X6wgNouA
	qsT+lY+YQWxeAUuJ7l2HWSCWyUvMvPSdHSIuKHFy5hOoOfISzVtnM4PslRBYxy5x99IERogG
	F4k3Wx+wQtjCEq+Ob2GHsKUkPr/bC/VBssSlmeeYIOwSicd7DkLZ9hKtp/qZQe5nBrp//S59
	iF18Er2/nzCBhCUEeCU62oQgqhUl7k16CrVJXOLhjCVQtofEp3+rwa4REoiV6N+9g30Co9ws
	JB/MQvLBLIRlCxiZVzFKphYU56anFpsWGOellsOjMjk/dxMjOKVpee9gfPTgg94hRiYOxkOM
	EhzMSiK8TtPy0oR4UxIrq1KL8uOLSnNSiw8xmgKDdSKzlGhyPjCp5pXEG5pYGpiYmZmZWBqb
	GSqJ875unZsiJJCeWJKanZpakFoE08fEwSnVwJSlKVuse7gpeX/0jZzLEi3cq6qOSdgsML/l
	tmB30NprM77MZ+9wr5icYjTnoKKGQsPp+ooH4XeeLrGz+qeXaH9T6beEiC7jJZvt5QEiEx3E
	Cw8n/QuT0mV6sab3/ev3DxY//Nv4bW21TVhSyb+5D4Jvvl4yY571KjH5pQFv33Is+p500TKJ
	9dlWB4dzrRynNtg61K94uv3OYke78B9N7Asf8Kef65Ct6FZ+1z+9hJF7xkbDmvesCjzFsQt2
	aS3a2vRcPqhDXsns7J03V3W838vbPWoXSVoSqCZ7U2hSfJep6AmpUt4rjGdOCr1aHVeZuN3u
	d69Q78WE3VPnpH18MI372ccvjS/kKx/vXhCkdkqJpTgj0VCLuag4EQCHc+WA8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsWy7bCSnK7gofw0gyW3jSxW3+1ns1i5+iiT
	xdH/b9ks9t7SdmDxuHy21GP3zQY2j74tqxg9Pm+SC2CJ4rJJSc3JLEst0rdL4Mo4097AXHBc
	qGJpc04D42b+LkZODgkBE4mzjzcwdTFycQgJ7GaUOH37EBNEQlyi+doPdghbWGLlv+fsEEUf
	GSWmP98E5HBwsAloSlyYXApSIyKgKLHxYxMjiM0s4CbR3/UPrFdYwFBizrpfrCA2i4CqxP6V
	j5hBbF4BS4nuXYdZIObLS8y89J0dIi4ocXLmExaIOfISzVtnM09g5JuFJDULSWoBI9MqRsnU
	guLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzgsNPS2sG4Z9UHvUOMTByMhxglOJiVRHidpuWl
	CfGmJFZWpRblxxeV5qQWH2KU5mBREuf99ro3RUggPbEkNTs1tSC1CCbLxMEp1cAUcdxHTfTK
	s8ZoFteL2oKCK3qixPbkWWfmvToeGl4fPT1O8e23liOfjBZc6OFZL1wT4BVZHGHPMElqy/sP
	fy3jlldlF6Q4GC9fse7I3/U1B7zbm7eXJ1cZG96V/rfcf873jJUR2fPm72hwMlqYeEdCUN0j
	j5XvrZynEeNVqe/b099cWyzzxOmQRQzb37nXc+7su7Lx2CsWk5K5YlMvJW9yOMtxuP31+6O3
	+boe5r93epW8yUS67qJZi77EhbeLHbZKXPKIOdVqdybRbtLEXUZi9nNXPfjZePy5wbE59gaf
	gkTU1t9XWih0/MIayatrzl3KuMUgWdCnEN+b7LPwk37dpG+a/9ZltXeHHTJttF6vxFKckWio
	xVxUnAgAAJWjBaoCAAA=
X-CMS-MailID: 20240617045649epcas5p1763924a49c5182f30a9ae3ea013390ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240617045649epcas5p1763924a49c5182f30a9ae3ea013390ae
References: <CGME20240617045649epcas5p1763924a49c5182f30a9ae3ea013390ae@epcas5p1.samsung.com>

Remove a superfluous argument that flag_show and flag_store currently
take.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 block/blk-integrity.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 05a48689a424..010decc892ea 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -186,8 +186,8 @@ const char *blk_integrity_profile_name(struct blk_integrity *bi)
 }
 EXPORT_SYMBOL_GPL(blk_integrity_profile_name);
 
-static ssize_t flag_store(struct device *dev, struct device_attribute *attr,
-		const char *page, size_t count, unsigned char flag)
+static ssize_t flag_store(struct device *dev, const char *page, size_t count,
+		unsigned char flag)
 {
 	struct request_queue *q = dev_to_disk(dev)->queue;
 	struct queue_limits lim;
@@ -213,8 +213,7 @@ static ssize_t flag_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static ssize_t flag_show(struct device *dev, struct device_attribute *attr,
-		char *page, unsigned char flag)
+static ssize_t flag_show(struct device *dev, char *page, unsigned char flag)
 {
 	struct blk_integrity *bi = dev_to_bi(dev);
 
@@ -253,26 +252,26 @@ static ssize_t read_verify_store(struct device *dev,
 				 struct device_attribute *attr,
 				 const char *page, size_t count)
 {
-	return flag_store(dev, attr, page, count, BLK_INTEGRITY_NOVERIFY);
+	return flag_store(dev, page, count, BLK_INTEGRITY_NOVERIFY);
 }
 
 static ssize_t read_verify_show(struct device *dev,
 				struct device_attribute *attr, char *page)
 {
-	return flag_show(dev, attr, page, BLK_INTEGRITY_NOVERIFY);
+	return flag_show(dev, page, BLK_INTEGRITY_NOVERIFY);
 }
 
 static ssize_t write_generate_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *page, size_t count)
 {
-	return flag_store(dev, attr, page, count, BLK_INTEGRITY_NOGENERATE);
+	return flag_store(dev, page, count, BLK_INTEGRITY_NOGENERATE);
 }
 
 static ssize_t write_generate_show(struct device *dev,
 				   struct device_attribute *attr, char *page)
 {
-	return flag_show(dev, attr, page, BLK_INTEGRITY_NOGENERATE);
+	return flag_show(dev, page, BLK_INTEGRITY_NOGENERATE);
 }
 
 static ssize_t device_is_integrity_capable_show(struct device *dev,
-- 
2.25.1

