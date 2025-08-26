Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B7F2777E5;
	Tue, 26 Aug 2025 02:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756177145; cv=none; b=CLamcd2bvKElqXpVfLlD7i8aYLIjNzVhUr2NdUN2AIH8Dle9Gs2/lRC1wQQhdBMsPMsLkIYZnfz7/r3fvzGEclUh/la447qFjNaumxtOJRs3hAW+raCa6Ix19zPW0ituk8vFxNgJ+cNzrI6hFxqr8WdA5FYRleQ0EMh6ClHE0io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756177145; c=relaxed/simple;
	bh=q9o3QoT8lr/AGU0AQv1oBtYFnfwN7uErKAg4OVa4Vbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nwuYbbaZ9IRG8EwGBNVwG2O6xaGogxcWfHone2LZ0kAN1QYQOBavU3Hi2DtXt+F03uyY9nPECJFMl/2t6DaYwBX69npHllpCHL0y5JC4X+QdNuEO3vsUutqlgmyEyCA2ryQnpwprO3Am2/9ZREACKmUgPf+dOWwaI9GV0zh6wv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=IsW+t1QE; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="IsW+t1QE"
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57Q22HGZ014836;
	Tue, 26 Aug 2025 02:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps0720; bh=/l
	FErksqAO2mqrtk6vYOINrt6RJ5khwuke1lCAx9oRQ=; b=IsW+t1QEHRTHZ7anl9
	BlpLmsxXdLxUxj0JMJDzCIPOPigvSYgIjtO3cb++dzsEGG+59GTpS8LEw+tFfWAP
	qV028UNPfuepO/0JQC6BtOoXeEsLN4qo1GieDWlA2QVtKjHsNTxzL4F+BL8Oh78E
	eSVzbiIdyB/fV69RZwOdfDLVJGdtOpUkrAbRmlUsLYGUZIqu1+GUXXgQieWStRgg
	PEMs3G6L7UP1y2JgulFZ9G6h4x9T6ipydrTV3lrbUZ45qfl6Bw6OEGS61gLgHG0w
	2V5FMIIXczRdrYZL4A2yTgxXQCM80Lgs8kUZMwYYU7mhr3AOnSQy1TmKRsHSMtrG
	lZew==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 48s2djrydj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 02:58:32 +0000 (GMT)
Received: from mlperfr9.3-rocky.novalocal (unknown [192.58.206.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id DC47B8003B5;
	Tue, 26 Aug 2025 02:58:31 +0000 (UTC)
Received: from mlperfr9.3-rocky.novalocal (localhost [127.0.0.1])
	by mlperfr9.3-rocky.novalocal (Postfix) with ESMTPS id 79C61A0A40A4;
	Tue, 26 Aug 2025 02:58:17 +0000 (UTC)
Received: (from rocky@localhost)
	by mlperfr9.3-rocky.novalocal (8.16.1/8.16.1/Submit) id 57Q2wFAS3715170;
	Tue, 26 Aug 2025 02:58:15 GMT
From: Cloud User <rajeevm@hpe.com>
To: Cloud User <rajeevm@hpe.com>, Yu Kuai <yukuai1@huaweicloud.com>,
        ming.lei@redhat.com, hch@infradead.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com,
        yukuai <yukuai3@huawei.com>
Subject: Re: [PATCH v5] fixed the blok file statx issue
Date: Tue, 26 Aug 2025 02:58:13 +0000
Message-ID: <20250826025815.3715160-1-rajeevm@hpe.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <a118e156-36a2-6612-517a-ba22c11fbd1d@huaweicloud.com>
References: <a118e156-36a2-6612-517a-ba22c11fbd1d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WMJ/XmsR c=1 sm=1 tr=0 ts=68ad22d8 cx=c_pps
 a=A+SOMQ4XYIH4HgQ50p3F5Q==:117 a=A+SOMQ4XYIH4HgQ50p3F5Q==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=P6ybfcUMI3NkiizEEVYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cxvBjHSDvEE1W4TQ6LRpkkJ7fcklRZfu
X-Proofpoint-ORIG-GUID: cxvBjHSDvEE1W4TQ6LRpkkJ7fcklRZfu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDAyNCBTYWx0ZWRfXxBmhcQxF2uqP
 c+vwg3x9X+GTi7Ad8xgqxlG09b2Rg5PhQHz2ulnVj43PCJqiJRssaFfHru7/8KYCXO+zHBNsHiT
 FZwS5jtKYnQCavaQ5q0Rb663s5MV/RsEf+b/BK7U9a4t44KhEStFqM4pWDAp3mh1F66o4VeLGek
 pTt9J6a92CdnmrSO2mZPXojm4XgFm8rnxpXmjeOvNfPpxfiEB0yS4fW7n3SPJfKtQTaiYX7YJmz
 6SST7gZYWAuLNuypig1uxqNREkp0r45yoKOUYbdxCMpW2RjlAfYqqbhM3FESULnlIE7W7mWTv6H
 fHV9tbUxum9oBgabvEKBev1JzlUg9Jge+dQEQIUhn/i3bT8XW28bDjsJ9atCq4FK6TjGlSMJLPw
 0sbh4C3R2VspU0twYvaaJWyDbyRt79O4zptQstctjZvec6O4MFWCbMLUVl6/OaeNSZ9bDPMd
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 adultscore=0 clxscore=1015
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508260024

Hi,

在 2025/08/26 6:17, Cloud User 写道:
> This fixes the statx issue which caused multiple test issue
>
> Rajeev Mishra (2):
>    loop: Rename and merge get_size/get_loop_size to lo_calculate_size
>    loop: use vfs_getattr_nosec for accurate file size
>
>   drivers/block/loop.c | 43 +++++++++++++++++++++++++------------------
>   1 file changed, 25 insertions(+), 18 deletions(-)
>

There is no need, to late for this now. :(
>>> Thanks Kuai for your continued support. I just want to make sure the original 
>>>> fix which calls   vfs_getattr_nosec in lo_calculate_size is not getting
>>> discarded. Again thanks for your quick response

Thanks,
Kuai
