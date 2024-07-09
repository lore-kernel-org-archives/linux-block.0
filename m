Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4C71B86E2;
	Tue,  9 Jul 2024 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720555219; cv=none; b=HQt7hRoNtRuhG70VPt4TDTOzNXIBjmQTXRcsliOiedarfnnK0wXqAj3urKwqVvqjByXqjvKDobCxcum0FGRGr3cvVQvVTclqThYi3XYnOOWPu9rWtGJ3AD1fnPdmJGv8FA3TdAt1Swt3zQgI3dC4KjQt2eZTjDus7iOAWzEEM0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720555219; c=relaxed/simple;
	bh=1lzGyTZlIEIPFdxijJ8NYJ+TnGmqvFx2qdm4im5AiEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YaKK5gZJcOzJx/5MMQ2CpfZ9hTx8uALq+fvdisRdK1kqZrJ9Ry6XEjnZ9FDVAVkpDFJatihZMyJ9Ez4w4XYDXRdqBcDKf3rAZ9GnXSVTzm6AgSudk41fxBCInmtjlXDfdFFcZ2snx1vyVbwePGFG8aSNGU0e0cVqG2GBLZPWLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lf6b7NQ0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lf6b7NQ0"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469AcgQq013950;
	Tue, 9 Jul 2024 20:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ruvPn1wCN9xP8BOsoAGRFa53JmzZJ7XW5TyuzwEe6EE=; b=lf6b7NQ0dC5jYwCP
	Qe9+greDhhwBXkXBbQ3Vg8Muua21fe5WeFbQFVNqFLUjmg02BPXB2smKMOHS88Zw
	DLITUjilZKaIHVj2EzvodJGTr+Jd1ck/1HJri8+GfI3gEUal79syhJbRy8eddfsY
	NgYfx1z8K3z4Gner1gFuiYUSj6vMo3/68FAb4j87hGHnZduRxEQd7TGTlE0q7lKE
	y1Xm4WcKNJmxaLIcDh1P/LN7P9yMGfTnW4C9dL9l20Mb2kJPO3tMqHUJldhknjVX
	PBevbIk+t/DxBibJWeBi/Q9LSY2C0QhGJ0gspllVVNLAfc2lThKaeZaw0CKV8giu
	3hj53w==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406xa67cc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 20:00:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469K0Dwa026891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 20:00:13 GMT
Received: from [10.48.245.228] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 13:00:13 -0700
Message-ID: <5a080f52-5486-4bb4-ab52-59cc0ab2589e@quicinc.com>
Date: Tue, 9 Jul 2024 13:00:13 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk_drv: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240602-md-block-ublk_drv-v1-1-995474cafff0@quicinc.com>
 <Zl0UJZWx9fyZLzrm@fedora>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <Zl0UJZWx9fyZLzrm@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QzEHlHgrs6KejurBJzd-0XcD7gAH19Pr
X-Proofpoint-ORIG-GUID: QzEHlHgrs6KejurBJzd-0XcD7gAH19Pr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_08,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1011 adultscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090134

On 6/2/2024 5:53 PM, Ming Lei wrote:
> On Sun, Jun 02, 2024 at 05:23:26PM -0700, Jeff Johnson wrote:
>> make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/ublk_drv.o
>>
>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>>  drivers/block/ublk_drv.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>> index 4e159948c912..59916895ee2e 100644
>> --- a/drivers/block/ublk_drv.c
>> +++ b/drivers/block/ublk_drv.c
>> @@ -3017,4 +3017,5 @@ module_param_cb(ublks_max, &ublk_max_ublks_ops, &ublks_max, 0644);
>>  MODULE_PARM_DESC(ublks_max, "max number of ublk devices allowed to add(default: 64)");
>>  
>>  MODULE_AUTHOR("Ming Lei <ming.lei@redhat.com>");
>> +MODULE_DESCRIPTION("Userspace block device");
>>  MODULE_LICENSE("GPL");
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

I don't see this in linux-next yet so following up to see if anything else is
needed to get this merged.


