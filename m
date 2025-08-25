Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C401D5CC9;
	Mon, 25 Aug 2025 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756160308; cv=none; b=adCoSC9q+M78kqkCVZqBiWq9ViI1yd9nLKhpXDx9+hKAhY35rM9uin53aqVdoQ89QMu1osN0mkahsCsalzL/q4kyynU3J/CvwF1p+9Ekz4xSVteXCt6Rudesu8RISmTjvZh6wYPIbIE2KxS6vg6CEiI3vrz0DvL+TLIz8s2AWVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756160308; c=relaxed/simple;
	bh=tO0H6Iz98Y1SUxiSrCY+w9nj1rzfnCv5B9Lx1sY30k0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZYQguVg1JsKDEgSKsOwSomEmto4fhCjzU22XHXL89mC7ZlqBQse26Rosh7lcTpiLZ4i4CQUIfS70VeSzUzOv4GwI5awhvlSns2y56OOtPE5gCrsSRIn8Sl2ezT0XXU+WxKl4cz7IgtGwirJQX1Q4750CecNf83vA39Dt1vYP0NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=LTgeubUw; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="LTgeubUw"
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PELWDX011035;
	Mon, 25 Aug 2025 22:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pps0720; bh=2PcIqWTnEzCDWMnKtwvFR/xzxeYOR7U/BFfWd
	JUVS30=; b=LTgeubUwd9BkjxDQ7kJN4M/cnjme/CHuXRiyk0KjeYsz3yKEiO2NH
	VcN0ahwElBiyPVy5L6H6WQ+E6JAIRb+7kYuzE98B/ZhaYbLTmihofZWR9lJBRoiM
	RgQliZrQxviWZOKGZ+uY3E3skRjVam1qk5fB2Cgt8gJSD5Pnwr9waD3ZyHLMRxND
	Dsmx0LWszyESZSEgYA7enDg0m3gkn/5lfFcivLAtZztRosozL+2Pife2ysokwC0T
	8fYiimgrpL3fhCW+CwbZUKFcCP9twRPeyDHlQY12dqJ4XbcvAOtgq9PehUsnn1vM
	hZFbyIozJo7R7ePLnSdRNiU4fOUmnycBg==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48q6afh9gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 22:17:51 +0000 (GMT)
Received: from mlperfr9.3-rocky.novalocal (unknown [192.58.206.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 3668D800358;
	Mon, 25 Aug 2025 22:17:50 +0000 (UTC)
Received: from mlperfr9.3-rocky.novalocal (localhost [127.0.0.1])
	by mlperfr9.3-rocky.novalocal (Postfix) with ESMTPS id DEB38A0A40A3;
	Mon, 25 Aug 2025 22:17:45 +0000 (UTC)
Received: (from rocky@localhost)
	by mlperfr9.3-rocky.novalocal (8.16.1/8.16.1/Submit) id 57PMHh6u3714502;
	Mon, 25 Aug 2025 22:17:43 GMT
From: Cloud User <rajeevm@hpe.com>
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, hch@infradead.org,
        yukuai3@huawei.com, rajeevm@hpe.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
Subject: [PATCH v5] fixed the blok file statx issue 
Date: Mon, 25 Aug 2025 22:17:39 +0000
Message-ID: <20250825221741.3714488-1-rajeevm@hpe.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Z3kX_059UzbGYcMkCnlXNVtC2vsAzLVp
X-Proofpoint-ORIG-GUID: Z3kX_059UzbGYcMkCnlXNVtC2vsAzLVp
X-Authority-Analysis: v=2.4 cv=S8vZwJsP c=1 sm=1 tr=0 ts=68ace10f cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=2OwXVqhp2XgA:10 a=3CjU-aPNe0WqvE6INSUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI1MDIwMCBTYWx0ZWRfX0aIhHe4y/jif
 Qx9Rg+Wj2i+60ra7OWMQqUX2X11H+HuSB3QDjGtyTZzDxVuwf1mufZoFDv+1MnADnSMVKZ9mV7J
 fkMw22tzWvAEXDTDNceRRTjkAxcxbTQGrLE4rUwTWP1nSw+020DvbqHhtLkFWYnQ51N2hSB4uX7
 9FP2KCIOW8RleUsrE9Hg8ASADUlzGTaIGffKt4Jh1leECNymSD0EL/xW5lBQjovOtanY8CzlfaU
 rsfP6HnJKFEeaaPQXtiVtkQxdHRocc43poXlfrg1am4iGUDqBm20sCOQgyoSruqSF71CaEKLNuU
 WF36CzjdnKPknhG93Xyeet6zZz8R7VKGLg5AOiXLdEgxv/jFZ+vCmR3bfAAXeEdNyfzSOtH/gzC
 eJWmjeOX1md2gTkoUrNHO847OrzaD65rZ996LUmYk+tYYCUafQTLFVNlT2lUYnqfnCaadsKJ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_10,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 bulkscore=0 mlxlogscore=906 lowpriorityscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508250200

This fixes the statx issue which caused multiple test issue

Rajeev Mishra (2):
  loop: Rename and merge get_size/get_loop_size to lo_calculate_size
  loop: use vfs_getattr_nosec for accurate file size

 drivers/block/loop.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

-- 
2.47.3

