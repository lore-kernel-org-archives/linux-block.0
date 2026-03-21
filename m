Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4070D26B0A9;
	Sat, 21 Mar 2026 22:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774133579; cv=none; b=PyU4ZKZBWlzY6GLOJ2L471F8YUlRf38Go9KJMYbfeTwX3iJEBOj4/IVnBU9YNGDydHaS0eljDlYfxADEJaCf0F7osNdjY2L38n2Vz/o0S6BxVbMArDs6qojZSFFXIQYZ0SH5CNQ/U1hy1gkx0d6css/QBbTqSrPRm99hBiD3trU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774133579; c=relaxed/simple;
	bh=bZo0j1dxJfo5v0/M22pDd0+k38/1/qcUprAwjPDGMZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Br8BJKMGOgUY+hVqHmhsIhCIgsFmj5waQFs4Ard2wwDnzHnAGZ1+zRQ8CtROv4/sAaw/9mvTrpZ0W/YXuT/F1rSVwMLHiA9o1QF7aUfVG1YCUIP5WJpRtL+NIYRiEY8xM61XDAxVfov/syo2EPJGFwb/MtGFmjoP6B5iIZQMff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ivYC53U6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ivYC53U6"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LANri8647112;
	Sat, 21 Mar 2026 22:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=piy/xWYQVEac4EJPudzJdNZEal1zAd
	Z+uQsMlryohLg=; b=ivYC53U6AIEIZVL0C1wqeYc8KEUKzLmPKMSdDME+XoBKoY
	T4pVIE45Ertb7Zbbh9kQP7WmxcVbIVuXA20w5MYKRKEOhXCQ/vTI5E9/kj0J3/lB
	7OU/b+XzsCGMcJBZKTq5aEhZgELxIUT8X7GUpGqtlil7y5ZZ5RCFd7rt1TkvWhlM
	eUubBzrN88aV5X0pmeln5G9LzFPCnQQGwrdy+fDL6xp06Uv+z5OsfSiCpqZCAVVt
	hbP/ep/sWKS+GRcLCPolLspC9VQI8LHuWtkxNh69C0ukIn8TDBAWkjVp2G5eD4+p
	I6rCJ/3GJilRCDl5ync6Ub6iNYsUhsNdDYrE3p+Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9j4rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 22:52:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62LMC4sN016244;
	Sat, 21 Mar 2026 22:52:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7kcvts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 22:52:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62LMqiEj56295840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Mar 2026 22:52:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03F962004B;
	Sat, 21 Mar 2026 22:52:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A925820049;
	Sat, 21 Mar 2026 22:52:43 +0000 (GMT)
Received: from localhost (unknown [9.111.74.1])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat, 21 Mar 2026 22:52:43 +0000 (GMT)
Date: Sat, 21 Mar 2026 23:52:42 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: syzbot <syzbot+09ddb593eea76a158f42@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] general protection fault in bio_alloc_bioset
Message-ID: <ttc9u7u@ub.hpns>
References: <69bdcdcd.050a0220.3bf4de.002f.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69bdcdcd.050a0220.3bf4de.002f.GAE@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ps0fHuJhwDrYYKfnPCDHKsKL6H2JFUjy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDE5NyBTYWx0ZWRfX2TE2lx9lgvn9
 i1YYjpYDN/v1duYm4lqWJJvwvLKnOfWGmp1K2CrEYuk4Jddzlzi/JcAIX5wWteRX1hhg7PfRBYQ
 sPrOvkvusj21xGPKiSUbmYTppGSfexWdQ3G+KPDjATSStO4CbAt/3e53eTg00ZlXMd+lpvEXst5
 RJYYAMw6LVMCVZZ8hafGz5yNZV28vUMEUy7xWHYXDtSrm+AmOCfLkOpTdM+/NCN8UVCnFQDrjef
 rbUkeDmsSmRqGng3mIPjcmiY3soInaaV/mrDzo38WW/2PVIUogOaC0hKslHJeEPM+ZgAWIPx0gB
 ZBGb+kCCsbr0dWZKo7uvMGp4+ZEY5sRYZ09vXSNNcWzIEr8DoDv2uBfM0OBwWtV72dFmoT5oMIj
 GVn3cDJotUcatH+hsR81NYyXpeqKYKtOvrrDguPJjawP71MrXuyKhQFhAK7l6GzMTKBvOI0NXOt
 cbLBQonhWuqG9t26UQw==
X-Proofpoint-GUID: Ps0fHuJhwDrYYKfnPCDHKsKL6H2JFUjy
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69bf213e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=BhzMjQlMk7PoH4ACK3AA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_07,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1011 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210197

#syz test

diff --git a/block/bio.c b/block/bio.c
index 5057047194c4..77067fa346d3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -581,11 +581,11 @@ struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr_vecs,
 		 */
 		opf &= ~REQ_ALLOC_CACHE;
 
-		p = mempool_alloc(&bs->bio_pool, gfp);
+		p = mempool_alloc(&bs->bio_pool, saved_gfp);
 		bio = p + bs->front_pad;
 		if (nr_vecs > BIO_INLINE_VECS) {
 			nr_vecs = BIO_MAX_VECS;
-			bvecs = mempool_alloc(&bs->bvec_pool, gfp);
+			bvecs = mempool_alloc(&bs->bvec_pool, saved_gfp);
 		}
 	}
 
-- 
2.53.0

