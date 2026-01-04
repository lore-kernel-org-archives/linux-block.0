Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE7E12FF69
	for <linux-block@vger.kernel.org>; Sun,  4 Jan 2026 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767544676; cv=none; b=LiSIqzrols2TbjqQLKDnwClqdvbY9MYcpkV4tVn/dKDBAEwpW1Cgb5RkQdRcdzwVwd4LSxbn8GGLgDqEyB1PdNwhBuIaEPakQCbk15GaLdGviNmokm2ppuy5MfqGs2pFIYVfu4UlKXS/6+vbbAEg9N2/L/Al1MN6Ous15zXAw8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767544676; c=relaxed/simple;
	bh=+CIijP9s/RyS2Y7kVO132CPkEHEHKngRfDGRSEo5/lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J1OeAP96qX1fQimhp8YDgwyO5te27EMPZbKvWaEBIGql6/+eRJ7H3g9q7Tfc9Hmth07hHWA7b8PAR8Mx0QNSuhZj9iYo5aSlOVhQ8/Lyrny+lVAlEGGiE9uwEtRBe2hazVAeCbbcGYbtPN6j+f0OcxiaJ+Qqf+Dx93W7qA+elY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q4ycPxJH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q4ycPxJH"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604FF6dB012747;
	Sun, 4 Jan 2026 16:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JYGEi7
	JW4Q3CbYM/XUMcPpcobUAGukbrRAnKMlB2+2s=; b=Q4ycPxJHhD1X2e8236VP33
	GSJ4kFReMEvb3KkbwJB0bzSImvBaXJAJelTHLoU+tT7NmtRFR17/xnTsluyEBxFa
	g0Cm5dw5xGyMiBB/x0Q7CcE6wZ3xEI9VuG7C0Yr4P4YNBwCgrAUFC17+78d5q8bR
	0nGy9YQci07VsbwJd0AGwtkEwAr/bxZpByP3EHgItHqM2Zin0exVrY9MGoQKkMRx
	Ii2enz8pcXPy4LEByhZyKl2Fh2cFprLbKWVR1r+PhAkrC6MGXal9z2TdoF32sZ7v
	e3Qz8BBT2VbEM2khqYaSJ/lcdA7hHSesKEFCF7bC8Dx+5H745LtrNwcQOpn2gKkA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betu5v3w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:37:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 604EKRBk014503;
	Sun, 4 Jan 2026 16:37:32 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bfeemj2kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 16:37:32 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604GbVZu31457996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 16:37:31 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A41658059;
	Sun,  4 Jan 2026 16:37:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E638758043;
	Sun,  4 Jan 2026 16:37:28 +0000 (GMT)
Received: from [9.87.141.48] (unknown [9.87.141.48])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 16:37:28 +0000 (GMT)
Message-ID: <587322fb-ebb5-4362-8578-430851aa1afb@linux.ibm.com>
Date: Sun, 4 Jan 2026 22:07:26 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/16] blk-mq-debugfs: remove
 blk_mq_debugfs_unregister_rqos()
To: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, linux-block@vger.kernel.org,
        tj@kernel.org, ming.lei@redhat.com
References: <20251231085126.205310-1-yukuai@fnnas.com>
 <20251231085126.205310-7-yukuai@fnnas.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251231085126.205310-7-yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QbNrf8bv c=1 sm=1 tr=0 ts=695a974d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tJLSzyRPAAAA:8 a=VnNF1IyMAAAA:8 a=zfs1Wf4-2qmbgOLhyD4A:9 a=QEXdDO2ut3YA:10
 a=A3mqa8q7df4A:10 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-ORIG-GUID: JBSMIVOA1821gtqaOKVOqID_8Q8j0f8E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDE1MSBTYWx0ZWRfX/4cwDFLRoOU4
 SlxnPl3YAqzqwsgfNhpaUW6HCcM/54SxX3rarrJ7t7p0BLDykOt4gVPHLBDiscNJIP3/40JhHav
 64NIjvUF7tAmHKjNaWmtrqal93O3UI4mg/jFzQBNqryXO3I8UHB7hjRuQbhZF/5nUaOOcn0YbYg
 8ocUxNZ7zkReWW8AwlywUKwc8r7zXkDOkAXBRGqPd3NBglBi1TR+/LCCrKMcc2qgTJfKOFGDiLG
 qRK8d2Yc0nVOwfthKaVKG0GHJpGPVYXhLlpoAuH1BIPtDaTpz3j61/c1XQ9ee98/ryBJ5Rub9nb
 ya/Mje/ITPTkQb8kTsnTH6a/PmEF5PuLFA14GNurE3pc6pC0SLOnKYnzqjvPZkVs+4h6FVW2Run
 6AGA2GYwDbvm4AL0o1HUSkGW7Gt32ggBxpX1whH9YqF2pDIh6AESkkTR8pm+dcpeDNKlp4EwiJX
 O1rtFKDmxQaO5d/kjjg==
X-Proofpoint-GUID: JBSMIVOA1821gtqaOKVOqID_8Q8j0f8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_05,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601040151



On 12/31/25 2:21 PM, Yu Kuai wrote:
> Because this helper is only used by iocost and iolatency, while they
> don't have debugfs entries.
> 
> Signed-off-by: Yu Kuai <yukuai@fnnas.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
