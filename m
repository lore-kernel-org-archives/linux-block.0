Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8557836C5BC
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762878438; cv=none; b=Gc4Nym0yM6EZcTPqFswtdZiyrdTy/mtBeXK1tqHoMF5AkBr0oMQSWb09R5BBkMJgypYmlwsbRQiEVY/XcPTvdsStgNxi35u0C581diz/3I1RW+eBxbCLHG9L6CFdjg2zk6rmNUU9Cgl/fzHTyFaj8jkb9j/c8khOWL0yPsq+Dwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762878438; c=relaxed/simple;
	bh=r1m1OkE2x4DxS30GpswrTV+0Whr4TGhBK3SbuDY7jX8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dlZr1KkRvDOBEBLaCd1ciMQ39FmsMk+C7lEKpQkTQ9059imyTMTOKyE/YUqFVXsK4WWjd39En7B+w48aPnFJcZdyeW6WlbSwMVuh6e/DH90sdFocevdwBoG/g7QSMERHw517vUBYsSkmJQvFyvpui0b9/t4u0ObFaaKbf3DOZ1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QKZAtHdi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QKZAtHdi"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABGA5B3029112;
	Tue, 11 Nov 2025 16:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r1m1Ok
	E2x4DxS30GpswrTV+0Whr4TGhBK3SbuDY7jX8=; b=QKZAtHdifR1t0GZfEqW/Tt
	jD6us6SzMdzRsn1Ry6Z3iSro6XvvHWwKPtDpOA6fUos4bG76NsHGN4GBaNwnHs+m
	wz/kg2r2ercvC0ARa/YZ0oDLkeWSGnzTiTb3LU9NeY/REVv8trfU15Aqrr1AyOvj
	P8zFJoVZsWvOUXTmM3P8JNALr4wA529mRzzs6qswvIARPWAvWpi5GM0CD1kE3QoX
	EaUjWLRaOVKgmIhLYWm1WU6z34M+Bvrm/RpWHsdk7Vbn6UVvCX3ISjkHHTewIPlO
	zhaJJnwq3ALTfkviu7pDjVTpVK1hw5d0pkaQneULW0L1LEjzug4v5MgkxbByqlqg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5cj4xd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 16:26:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABE0fW9011562;
	Tue, 11 Nov 2025 16:26:56 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1bch4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 16:26:56 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ABGQtIO25690802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 16:26:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC5E658057;
	Tue, 11 Nov 2025 16:26:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E21358059;
	Tue, 11 Nov 2025 16:26:53 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.250.35])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 11 Nov 2025 16:26:53 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH] block: fix merging data-less bios
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20251111140620.2606536-1-kbusch@meta.com>
Date: Tue, 11 Nov 2025 21:56:40 +0530
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de, yukuai@fnnas.com,
        Keith Busch <kbusch@kernel.org>, Matthew Wilcox <willy@infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1158667D-9944-4F55-8EAC-76CE8E04BC98@linux.ibm.com>
References: <20251111140620.2606536-1-kbusch@meta.com>
To: Keith Busch <kbusch@meta.com>
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Ss+dKfO0 c=1 sm=1 tr=0 ts=691363d1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VabnemYjAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=VnNF1IyMAAAA:8
 a=Hoco3CVtmKLWRN3_MvsA:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5NSBTYWx0ZWRfXzfAvb/Ehusfq
 g9lQK9SlUkCEA8FiUa7Ik71BorzyOIIVWH+lBK8RzJZqV0qN263WHrH7luZ4y2JRxvwPjnYbGVU
 rJ52/m9QQxTjEy52Up+/+bgNXiMUd5uA1994FbOm8UcdQ+0oIi/CrKS1lq9XX1ce5N4xNf3ucyR
 0vi/kUXSH0l1FbkqKElWV9RK6Td7WZldW9sBKtWGbU9uCrAigWzt7fjqwOUV1KMi+Udg4/jC9qh
 qCdufBRqKRpFKS/ZfXB0TskT19L+2eyulugRc5b6srLvWJPp0MsBFVzagMDiKbsR660oZx7bWJv
 DQqdB9lJgRtdbMwbvJrji1YYIHWctSrAwqeooi9w3GNR/QPRzyPfqsF/smCVuRhN/DOOjbJbaNb
 kgKio51Fs0lss792VXzlHq4kI9oZAg==
X-Proofpoint-GUID: dZsOyKSqN08RFUd9dyt1FdY8GId2q92P
X-Proofpoint-ORIG-GUID: dZsOyKSqN08RFUd9dyt1FdY8GId2q92P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_03,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080095



> On 11 Nov 2025, at 7:36=E2=80=AFPM, Keith Busch <kbusch@meta.com> =
wrote:
>=20
> From: Keith Busch <kbusch@kernel.org>
>=20
> The data segment gaps the block layer tracks doesn't apply to bio's =
that
> don't have data. Skip calculating this to fix a NULL pointer access.
>=20
> Fixes: 2f6b2565d43cdb5 ("block: accumulate memory segment gaps per =
bio")
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---

Thanks for pointing to this fix. Tested this on IBM Power9 server and it =
fixes reported issue.

Please add below tag.

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.
> block/blk-merge.c | 3 +++
> 1 file changed, 3 insertions(+)
>=20
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 3ca6fbf8b7870..d3115d7469df0 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -737,6 +737,9 @@ u8 bio_seg_gap(struct request_queue *q, struct bio =
*prev, struct bio *next,
> {
> struct bio_vec pb, nb;
>=20
> + if (!bio_has_data(prev))
> + return 0;
> +
> gaps_bit =3D min_not_zero(gaps_bit, prev->bi_bvec_gap_bit);
> gaps_bit =3D min_not_zero(gaps_bit, next->bi_bvec_gap_bit);
>=20
> --=20
> 2.47.3
>=20

