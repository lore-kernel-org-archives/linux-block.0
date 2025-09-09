Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6973258EEB;
	Tue,  9 Sep 2025 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417749; cv=none; b=cLDBtdso+GBykVaB6+OB0Yb4u64PivcZyO0mWIjZLv1hcf+DcS8xUCw4+ScchYBTudwtrFh5DJxPUmVkBrW2V2eZd7k7Fx+8J50dLwnJWtLd1wTfQtWW9NSaw3JHR+7GZGdip57GsrIpBfHe59GD1OsgXCB9OHhC6ImEhASScwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417749; c=relaxed/simple;
	bh=PWWNF1TvMJ22gLazPLVkMf8vqBGGyEGkt/Z9C0y6MPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ChvRRsEYqJbsJ+ESVz/q4S99ZD6ynV6JMFsijeLVDrnDLMjZFHDnQMANMtN1pu7NPCKwUEafnOQi29kNFOBRXPUBk9TywD4aHSverd63OEfHmQaYbMODilf9FfH9U79MbULT4VE3zVGnPMcds/An3DbW+beK8hPH1LZ5mShMQy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oqt2t7oH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oqt2t7oH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5899fOVR015917;
	Tue, 9 Sep 2025 11:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Hdj9cV
	t7NQFUbC+qru0UrsWcvAxff/Y4qbj+3O4HLQ0=; b=oqt2t7oHFSesmBNHUY2y0f
	5gMeW0iHew5RfqUoJJNuFrO0Ok038AgDlrNRuLaneeULKsi6e+4Ap6/lutWq5GuZ
	3kyiOcbMOO0olA9ybXwuadbH46azu3mLxtAF90kM40+9lDDzK1Qy7Je/gD3Jj7kH
	EmMrTOWAk1mVJfKjtZNN2rQaJe7MugUjlSTDZhevK4UROfhPcbTbVQhr1OqR7ERh
	9x3JNs+DWVoxmsUc5Daci/3kW8txzk+rqTJXrSdEiThjvQJb+7QiAxH5cBk0qxRJ
	36uCR4JUZbXAQMJQEypGfFlhu4ZeUt9EEuC1b+QS1tWv0CSfGPJxpmw4xYzPbKkA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff7feg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:35:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5899P39H011435;
	Tue, 9 Sep 2025 11:35:32 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9ub394-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 11:35:32 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589BZVEG29426352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 11:35:31 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FF2658057;
	Tue,  9 Sep 2025 11:35:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C339558058;
	Tue,  9 Sep 2025 11:35:27 +0000 (GMT)
Received: from [9.43.86.190] (unknown [9.43.86.190])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 11:35:27 +0000 (GMT)
Message-ID: <189e51d1-474b-4608-a4bf-a7b4a0e4f951@linux.ibm.com>
Date: Tue, 9 Sep 2025 17:05:26 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 02/10] blk-mq: remove useless checkings in
 blk_mq_update_nr_requests()
To: Yu Kuai <yukuai1@huaweicloud.com>, ming.lei@redhat.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com,
        johnny.chenyi@huawei.com
References: <20250908061533.3062917-1-yukuai1@huaweicloud.com>
 <20250908061533.3062917-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250908061533.3062917-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uEhZtJ2vSAa60MjX4tG8am9damik8SUy
X-Proofpoint-GUID: uEhZtJ2vSAa60MjX4tG8am9damik8SUy
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c01105 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=bTXSNJD4q4jJJGutWJoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX08uDEeJtaPCU
 3GbAJKsktCQZhJLJpbvJfpcZw5UnaEIPeTHdCn49apLRnInJx/GAmaWZWdpaCyXP/UiqCgzaOZ+
 4HeEhdaTx1sZ4aynsbK32+qo5yuzXezxlRXqlq/ujv37d/aTSiCygjbxG4jNum2tLgYOMOSMl3Q
 WmbEH2tTfCjNRWSK5Yhw0Wj4NfTyST6hVPN/Atp7rXqaupcJIyAT7ra9AgeBjfrPbSZehKnEE0z
 skrvhXaLUEvIjoNlTHhP6VVf7MMKPvGYKZIo5qFKS3WLSgaJpipN9db8XbxC6+2zgmj/i1FIq91
 99QN+YehJMkpWG7ZXyad9Cg+3ir0meFiOrR8aqG67K+lLXHuFANDCm0Mwi9crLCQghy4uqqGCmm
 0xr8y81h
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
> 1) queue_requests_store() is the only caller of
> blk_mq_update_nr_requests(), where queue is already freezed, no need to
> check mq_freeze_depth;
> 2) q->tag_set must be set for request based device, and queue_is_mq() is
> already checked in blk_mq_queue_attr_visible(), no need to check
> q->tag_set.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
