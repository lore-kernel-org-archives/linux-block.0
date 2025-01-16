Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7422BAD8
	for <linux-block@vger.kernel.org>; Thu, 16 Jan 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737043162; cv=none; b=suJq5lzygO3MTGaFJII9GXrIYdlsFNu1TzQAYZ0dZubOcz4CBTnGAVIa5RtHQmKPc2w4n5Xhj3M4/dlY58FgJFi4ThoSCM2rT9oHfQUHLlyxTqu1hq4ZVxLHrLmsfJu7tVabipykqgwgZwRD8c2REdLhW7ShUtnevUo9FfCm+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737043162; c=relaxed/simple;
	bh=vuB1aXeKOHAi9KtWTYvSWRzWkPViT2/wb1W+YOtimAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Srj0mtS6bFM+z4P83jI6rF64qlYN1tTd51q2Lhn5Gw9k+UesyLQqm5XLvulh7RkYsIulevU3xbYnQWbrLuK/lQISN+mGDf9BoZukaHsbF9rFIpwsfn5k7zvib/Ohz8Hdp9TkBTl2zB9UOEVSSwJ3771eDV+zanOT5oFWUpv7pkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I58d2NDE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I58d2NDE"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GBcSTZ032049;
	Thu, 16 Jan 2025 15:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	perEZ1wv5g1PuIjlzk/UD4sF/spmVcBLSEsl4GGxLUY=; b=I58d2NDE6xn8YmNb
	H9PJwO4AmCiyvJlEWH4u63a3ZZaWgl+/7UUN20jy6vi79GJCIhUK83ku8FTY7/AV
	2QNJeVZpJkyJkxIrCOdPN7RsPKU9lXdsgVm800SMmsjZg61qNWEE8NAU1xsnjSPQ
	dtmZUeAmN31nrq63koqrlXvB1g/bsjx0sf/d9j7JvJli5iXQlo1KonwLcv7t1OQJ
	75Ghv03LXOFGlZ+U6XwqsC4ZOmQtQOfPvLCaZgclV2Q9kT97gZo/pB6uF7KVpWwc
	m5CHw2MlF54F8d8vNWe/KG4eQLhQ+s03KHqGUHYXugWwUIDmAXgnhzbyPtYGTEHC
	5qsXKw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4471de8mat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 15:58:41 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50GFwfs7014178
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 15:58:41 GMT
Received: from [192.168.143.77] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 16 Jan
 2025 07:58:40 -0800
Message-ID: <a0923b0c-ba96-e025-e063-59ba9f97678d@quicinc.com>
Date: Thu, 16 Jan 2025 07:58:39 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v17 14/14] scsi: ufs: Inform the block layer about write
 ordering
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Damien Le
 Moal" <dlemoal@kernel.org>,
        Can Guo <quic_cang@quicinc.com>,
        "Martin K.
 Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>
References: <20250115224649.3973718-1-bvanassche@acm.org>
 <20250115224649.3973718-15-bvanassche@acm.org>
From: "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
In-Reply-To: <20250115224649.3973718-15-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ng0-gbCmP2jUabBVwbyz1g_CviQxwboo
X-Proofpoint-ORIG-GUID: Ng0-gbCmP2jUabBVwbyz1g_CviQxwboo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=667 bulkscore=0 spamscore=0 clxscore=1011 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501160120

On 1/15/2025 2:46 PM, Bart Van Assche wrote:
> This patch improves performance as follows on a test setup with UFSHCI
> 3.0 controller:
> - With the mq-deadline scheduler: 2.5x more IOPS for small writes.
> - When not using an I/O scheduler compared to using mq-deadline with
>    zone locking: 4x more IOPS for small writes.
Hi Bart,
Wondering if the change has been tried on 4.x hosts and using different 
IO schedulers? Any performance improvements?

Thanks, Bao
