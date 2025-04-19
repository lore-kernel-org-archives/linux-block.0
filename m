Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E91F26AF3
	for <linux-block@vger.kernel.org>; Sat, 19 Apr 2025 11:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745061964; cv=none; b=kPUVfuxU1Bm48GJe4opN5+ByKd4d0Dj+O43lqTOviE13SGgOqRV9u3huJmdpSjEnFd3JaorKI99XP8pSO7LUoUATDc6tzMp/G5428acbBTOea1ErALMgCe+Qa7lA+tefA+1hBTIbdzTAopqKfipIwpDQrE6TVGKwTXHyeeLNAcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745061964; c=relaxed/simple;
	bh=CDm0nXcMLy951d9GPRM8YP7IV3EYEifvKAvPsqCls0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LU4F2F5hxkAZDPRJy2S8PgCNm4NC80fqVA4qFCAW3fWnT3n8ytlPZ/Sqtusxxk6Tb47vxDHpgxAWefhL8OaqOajLqrQz/PbTqPHcMvDTSXd0haaoPhc54QIeP5oq1SyS3429nJXlxNf769TRjz5dTRsQ/gHGtOeKlO+Ef9dqnuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RZun2zN5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RZun2zN5"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53J417AT032490;
	Sat, 19 Apr 2025 11:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Jnt7S6
	49tx0KmIoOV0xQIec8Npfbb3TCi32ZDaJXwCI=; b=RZun2zN5fPhK+N2nS0AESQ
	7jQnTwVK1+F7IIvrK60An9qgPCNryBC0pySNYY6oYyuHzYgiZJQHggXuvXTKfF2Q
	4JeK3H39HboB05M8Fy1Co7hvEwVzomALQt6JWPUWN3tNsciNQoqzaJC5PcrOXHV1
	J0iM6eUEjP25fSpMoyeI17SjcXjShfzKDJjGTiG+dUdRgJL43xTs5kx9z92xFED6
	swc11DmVcE9z0ASrzVdKn9U34OQm8pJofIQ3W5kkt6kSgGesYTu0LcVbr2Wng7b0
	VIK8z80M8Klzu6rFTiZpTvbyk5iGEPlbN+w9yqLnzpPBIo9iEuNLz8dryCYoa1Dg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4643g094c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 11:25:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53J7LO76024914;
	Sat, 19 Apr 2025 11:25:53 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gtyhjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 19 Apr 2025 11:25:53 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53JBPrP332506408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 19 Apr 2025 11:25:53 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3034D58059;
	Sat, 19 Apr 2025 11:25:53 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5130958058;
	Sat, 19 Apr 2025 11:25:51 +0000 (GMT)
Received: from [9.111.34.38] (unknown [9.111.34.38])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 19 Apr 2025 11:25:50 +0000 (GMT)
Message-ID: <7df341bb-8437-4451-a373-43d2a404b890@linux.ibm.com>
Date: Sat, 19 Apr 2025 16:55:49 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 09/20] block: simplify elevator rebuild for updating
 nr_hw_queues
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250418163708.442085-1-ming.lei@redhat.com>
 <20250418163708.442085-10-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250418163708.442085-10-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7mY2BIousqmsbB_Q-EAP6vCy3qgKyCQ3
X-Proofpoint-GUID: 7mY2BIousqmsbB_Q-EAP6vCy3qgKyCQ3
X-Authority-Analysis: v=2.4 cv=cPHgskeN c=1 sm=1 tr=0 ts=68038842 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=L6bXmuYMFcewxp2zkcQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-19_04,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1015
 mlxlogscore=877 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504190090



On 4/18/25 10:06 PM, Ming Lei wrote:
> In blk_mq_update_nr_hw_queues(), nr_hw_queues changes and elevator data
> depends on it, so elevator has to be rebuilt.
> 
> Now elevator switch isn't allowed during blk_mq_update_nr_hw_queues(), so
> we can simply call elevator_change() to rebuild elevator sched tags after
> nr_hw_queues is updated.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
