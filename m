Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37171F9C1;
	Tue,  9 Sep 2025 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417691; cv=none; b=pBTCD3uJH5RZkYxkyY/71vxZsc2J9wgHsGOIS6FTRNV1xZzvf31EfPRThrQFPbTL+meM9eQpsmf71xw4V/F1XxG0udrt9/Zm9ysA+YtQDm8kNDSHYos3VzkkoPIHfS/81f17gFc0/p0MVLuerzMykyh4vnaemAAi2lg8Rl3I3Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417691; c=relaxed/simple;
	bh=COiuzhUz9C+1v40K+e1P+jmG7cd0wWL3Hc0ys7WeluU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpPMDWLJs1gKZZ8PlUextN5UGlQY1Q075sYHfhgKnMbTS5utrjt/M9gM6r+Cauc32Z/TkNLxyDaXlW4VgVtEjewSsS+wWKASw2jfU/fbHZjtKUl4NeYG5MbIyfmAZcv62COcCj3O3ulHo0nD6IkK66LInTgaK1xYJI3/fuGcCgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WHP+EWEZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WHP+EWEZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897LI92003430;
	Tue, 9 Sep 2025 11:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GtUqbN
	gpfJqwH/w5ngtzqGW3RAaL7d0ikuwPgHDKTAA=; b=WHP+EWEZMB3mFNzXpVQjnL
	lo4yxF5C2BjT34h4JBUnD8+wIlk/g72fa8x6qwcDuXV/h8CKAXTjkgdXU9yI+MlP
	qsKOtsOxoVPtv2BDmjrWCK8HxIaskF/wKeGhPtVBFywOSfPPnEbxI0F8PxoY+UtQ
	frPykvIYr04fEdEIu6rCZAOYxFCplxBGofRuVIuqJdavF3uIeX+NaQADUWsOcFhV
	Z7xBScVXfhNZOWk/O9WuvvZSrh274zhNt/tc/82p916yDl72AJjp4qK5AEGVetc2
	86hdpo6sej4zzmWzuKRbRmues91/9tzpUDSu1/ZEz2ykAR6opKCa6V0aDHDVj+XQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff7f6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:34:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 589AuJPR017227;
	Tue, 9 Sep 2025 11:34:37 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4911gmap58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:34:37 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589BYa2a34800094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 11:34:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AEC658062;
	Tue,  9 Sep 2025 11:34:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9407458061;
	Tue,  9 Sep 2025 11:34:32 +0000 (GMT)
Received: from [9.43.86.190] (unknown [9.43.86.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 11:34:32 +0000 (GMT)
Message-ID: <f4aef359-750a-4c0f-b071-b7173afdfbef@linux.ibm.com>
Date: Tue, 9 Sep 2025 17:04:30 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 01/10] blk-mq: remove useless checking in
 queue_requests_store()
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-2-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250908061533.3062917-2-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kPFUVm87DUcn4P1K_a7mVcGQhGIlmGYa
X-Proofpoint-GUID: kPFUVm87DUcn4P1K_a7mVcGQhGIlmGYa
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c010ce cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=j4c9uMVVAOzEm7xRwl0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX/B5vVQNqJrb7
 IpseFyJ7RIWxDZeikHsjF/+dkMt46fjIleL3Fz6QjBEIfiaFBF8eRvKDCCoL6/9Ik9uiAi3wkHD
 RG2L72Qzm7/M2jAwZZubo2Dgj7AE++kVijyQhHCzd8DIkcQC0R5PWj3F/PNFJHdn+pSMxFOGr1e
 ssdlFIqC8sUoetzKXPZVtv39vOmEIn2+bMXzeeePmBLOS/wtmk5tn8VdOZrcyRnCUs/dXVpU+PN
 zSmLsNhF5yEt/weF2FEVF1G9sxZ5GYt9oWXx5Ep7ubNn5rnJzBdGfiDpYYOk9CUNXFkSBPwWiLn
 hMKqVacIsyu7h8fai5Q3owo7ihOkGGHpKFQ0gDN0xBcuMIEGgeUuAG4sUWcJ7ufLFr6xmdb4W23
 uDUITG1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_01,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020



On 9/8/25 11:45 AM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> blk_mq_queue_attr_visible() already checked queue_is_mq(), no need to
> check this again in queue_requests_store().
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
