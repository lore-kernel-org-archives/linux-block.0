Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B5E1B86ED;
	Tue,  9 Jul 2024 19:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720555007; cv=none; b=mU7oiGGUcrbpD/FynuPwE1VqLfgsy/UxdiSGzbiHAOCFYcPdDw0/O5/rKZze8wSGx0ImAiczi8XAdu9hiohgdl0WrwNkUMqloHUQvcrAI/75d4drFCSqFnw7cys7dCsmZHD9/SoxiNcwU4yH59aHJxFDGrqkta2OBI6sbi0lplI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720555007; c=relaxed/simple;
	bh=iGrkgNHDwjaspnRj+A9ep2nKHiE8m1A0f/54O8jUHa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kh5nHgyWnwXsHVClMcp3WD/6Dcl8+E9OP3rvZxdaibjmmAuLnVcF/CvgfGQRIx6lrBEKGDBSt+udfLzFLdbgPG+okWnaDpaxU9cVEutHXm3TDOYMhtJuDfsm0nY981zVEui/XvhcUEV3+LYMsgQaAbYsUAO+rGnSHiyev9WQHno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a3Mk7TWS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a3Mk7TWS"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469ArSYH016564;
	Tue, 9 Jul 2024 19:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BZq8fvJRscNfyyoib00+DW3enVqCLU4u9OjMtygYT40=; b=a3Mk7TWSB4cYL8VZ
	MEPQl7oRFORtOIvTz7nzd2fkG37dV9n7HVtscY5TjueeuMmpGfiysMKGG6T8IFWQ
	6vZbuZY9WH/vJK/YFikC2vVtiUVnliTeJ8VZKUujCx8SCYDdmJErfPd+4C6YZtvG
	me5A/AREbRXEaE9/tjwL/sE2wASm9/JWNJvHR3PuJKWXk9Xi9JB+36kUPMyb4wx0
	gqmGeXz5xfjSwZWoUV3i5pF4920hwfcapCFMcSC0yhOOmHBI4qBIWRSBZm+zlx0L
	0Z0POX3q4g8T6r9w68oo64kuN5IbWVeL3zRimhFahoMYVXF51+KdQOqdHEEv6gKI
	yHCGsQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406x517np7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 19:56:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469JuQR0017047
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 19:56:26 GMT
Received: from [10.48.245.228] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 12:56:25 -0700
Message-ID: <389aa594-5c58-4740-8079-3c2c88754be7@quicinc.com>
Date: Tue, 9 Jul 2024 12:56:24 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] floppy: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: <efremov@linux.com>, Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240602-md-block-floppy-v1-1-bc628ea5eb84@quicinc.com>
 <f3a27dbe-091a-43d0-aac8-eebb4e2833d4@linux.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <f3a27dbe-091a-43d0-aac8-eebb4e2833d4@linux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gBbqRD3DyAFeLuX82x96Ph0fxQBOMX6M
X-Proofpoint-ORIG-GUID: gBbqRD3DyAFeLuX82x96Ph0fxQBOMX6M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_08,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090134

On 6/3/2024 3:35 AM, Denis Efremov (Oracle) wrote:
> On 6/3/24 04:05, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/floppy.o
>>
>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>>  drivers/block/floppy.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
>> index 25c9d85667f1..854a88cf56bd 100644
>> --- a/drivers/block/floppy.c
>> +++ b/drivers/block/floppy.c
>> @@ -5016,6 +5016,7 @@ module_param(floppy, charp, 0);
>>  module_param(FLOPPY_IRQ, int, 0);
>>  module_param(FLOPPY_DMA, int, 0);
>>  MODULE_AUTHOR("Alain L. Knaff");
>> +MODULE_DESCRIPTION("Normal floppy disk support");
>>  MODULE_LICENSE("GPL");
>>  
>>  /* This doesn't actually get used other than for module information */
>>
>> ---
>> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
>> change-id: 20240602-md-block-floppy-1984117350ec
>>
> 
> Reviewed-by: Denis Efremov <efremov@linux.com>

I don't see this in linux-next yet so following up to see if anything else is
needed to get this merged.


