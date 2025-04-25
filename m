Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756FC24293C
	for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 10:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745578433; cv=none; b=AtoBeyOdTPBsdDJZAz61EavxVKldXctgSpG5qi4bKjdYkuxBeb0AAb/il2WyE1NuczFEyxpVforcgXPi2pZqK/wMwi1aXv6OlZY9Sb1cPXOLWM1bFzkhcIDdWM5pW6U+lfXQX2O8m+6RTiiB/ugp+NAeUnRbOfwIBHJ9UhJHjqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745578433; c=relaxed/simple;
	bh=bfY/G8cz0m6xbI51ZchEChByMnMLV9/CRev4yD5zYLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtNTduLwBjOYQKvMtTZSRdkE6eOg4DGl/zsGIUdv1Wqx+7CAhPPAxlfePMu3bi96O27IVTZYfqwrzgoFHaie6Mb537aMXjeJFoLDwk5yQB5MuOAfI/mrgzRqL4FNtCgRDyPgQ91zw6I4ob5rUojNx8jXDf5rtyeiH8dB9PTIPvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TrchWnF4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TrchWnF4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAeqoO023193;
	Fri, 25 Apr 2025 10:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Rrd/kI
	rV+mWl1ht12ShWQjlmHYAZ5jpNBjMAzfoWKEU=; b=TrchWnF4O+5wi7j7ocYIQD
	GDwFVEw3zTGLY0mvEZGiYdcM6eMdmFAtCWO8o6Y2yUXfysS8mBXy0DGgMI9+VGs3
	/15ztyZfIReNkY1EF6YIOj1Z96fdrCzMSWuBO2lwGrTmS2GF+fdyJ+3kkm73124I
	iHHYyXqPkCQxi6qt5IftUDee8eW04D8xNZ4OGWj4tSuBuYBRb0qNy6INYXardVlw
	w3zvaq4vYDtjDTIll7ON86RH7mrLs7I6CD03D82yVOUSdnaWxJKZiso5wrh2pT5N
	3wKEy6gDBSgtcDFf8BtOO6cxsLJmaXNd7tN+nnpGL7yvnkn19yHjTAT3g4u3qV4w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4688usg18g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 10:53:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8bflV028434;
	Fri, 25 Apr 2025 10:53:44 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 466jfvvtak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 10:53:44 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53PArhpT25952964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:53:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A38F158055;
	Fri, 25 Apr 2025 10:53:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19F3C5804B;
	Fri, 25 Apr 2025 10:53:41 +0000 (GMT)
Received: from [9.43.102.9] (unknown [9.43.102.9])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Apr 2025 10:53:40 +0000 (GMT)
Message-ID: <ead21df3-cb46-4c28-bdc9-c63c271f8e26@linux.ibm.com>
Date: Fri, 25 Apr 2025 16:23:39 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 04/20] block: use q->elevator with ->elevator_lock held
 in elv_iosched_show()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-5-ming.lei@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250424152148.1066220-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dbeA3WXe c=1 sm=1 tr=0 ts=680b69b8 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=xS5cVjNvW9UVLEE6uu4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3NyBTYWx0ZWRfXwaZ1STG2rHVz pqtFFM5C6ZzWSBeFVTmmGXz0YIXeOVnn/Ay88FWvY1GYH7ow05pa+qzkJsILXQpxF2IFY/hi3vC UphKd+S+AnJWZsuLj3sBwLjeGBlEyhFRyxZQCMK3qIsLig/ace0qGGjxPeIxqqsQmU5Wfbf2t86
 Uv3dYHTLv9DE6udFMN2z8OKoMHWEItkTW7Q1UQuDWmYEOSYC3Ik/9jjRzQCmhvBhLsPdtoKaBb4 F8EHeam3fgdtVMlnA+Z3OqIya23equdJ/BcZixUM8IUO0uMr97hb22TetwA3GXSFnkyH3TMuG8f CHeaiXTQpjFTjIKL5xbG7EXJU2QpLuAoK4WCIsZxfoVDZ7iiXGgD/T7vnzOhYCt+FrotCcJuGAG
 5Mf5DmB1LIjD6N9GYCk4i4cyQgNbVIfbg7PN0YkQI2DAQ9tCYFtpD5xZMogxaT6qC/7pNhFY
X-Proofpoint-ORIG-GUID: n63qlBjYptwWfUsnviE8JqA2SD2by_3k
X-Proofpoint-GUID: n63qlBjYptwWfUsnviE8JqA2SD2by_3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=537 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250077



On 4/24/25 8:51 PM, Ming Lei wrote:
> Use q->elevator with ->elevator_lock held in elv_iosched_show(), since
> the local cached elevator reference may become stale after getting
> ->elevator_lock.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good to me:
Reviewed-by : Nilay Shroff <nilay@linux.ibm.com>
