Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44FE1B86E2;
	Tue,  9 Jul 2024 20:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720555302; cv=none; b=MrWEtC/fvUn4Rc4GpCvOB3rBLQD6DQlurdqLqs8jdl1mkYTR81RtC/N8P33piC8v4hBg+SK1DhnkeCEQG9yBa/zd621pWzSniQx8mQktfB4y4nTE6suet3jQJbBLh3nqiX6xfcyAnmVhqm8bLL26PJBI3OyIbmVE1K2RCy3qvcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720555302; c=relaxed/simple;
	bh=AZo9xaN9BpD5r2Jr0EvGfjckxDw+bEvswfeb3wZ3AZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JXcJkuLlam3yH+QajZEVUZOdy4JShnAt84+tuLDoRR7Ug2J1BQnX6rjBZWY9kvT+dtL2r6vXz3oa/2JmBGLLiSHug+XvYxtOlfG3xcDDSF7iTr0BY/gst6tr2X5O/ksgMiUEXckknHkEtEX9ZK9IYHyRZTKMo3gGm2Dx30nga0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=peqAZqEs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="peqAZqEs"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469HIKnV025500;
	Tue, 9 Jul 2024 20:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GcIxVMV/I96Q8u9kb1BertF27XdbTkbl/r6HZpwgBjk=; b=peqAZqEswwHg1OkP
	ajznx7SRbJTRxC0AH7n+tyIHyJDW8oPAafJ/A9zQK7O2ezPh7RAKlSmK0ieGwtR7
	Ml5+34Qeso4SVdplxo2IW1Z7BYy9ajeGuh5P+2gFgyZX60zgbqLOXROvSeu5xQuX
	zAM+TTMLkUIjfkFTWMrLyNRcssEDDHFRJssoyY9pOPR0BvBIidWxRrHKLSce+yY4
	xxwK9AdzmZN8PWcUHWySU00o5X3HStQ3yubfxJCnbqwQg+2n1iGMgSvO/qaHm+hN
	raKrtccHVpTVhzt9C977xl5uHO9rl+882Oikvzhz0IEQZYhiTMsRpWWSxQsqD36E
	ipOdJA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4091jdhrug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 20:01:15 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469K1CP5027914
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 20:01:12 GMT
Received: from [10.48.245.228] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 13:01:12 -0700
Message-ID: <42b70860-e06f-40b7-9bda-6a512ed1dd9d@quicinc.com>
Date: Tue, 9 Jul 2024 13:01:12 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xen/blkback: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe
	<axboe@kernel.dk>
CC: <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240602-md-block-xen-blkback-v1-1-6ff5b58bdee1@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240602-md-block-xen-blkback-v1-1-6ff5b58bdee1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6Gy7EWo_B31q2FiCLW-SkcytPttdadMb
X-Proofpoint-ORIG-GUID: 6Gy7EWo_B31q2FiCLW-SkcytPttdadMb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_08,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1011 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090135

On 6/2/2024 5:37 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/xen-blkback/xen-blkback.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/block/xen-blkback/blkback.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/xen-blkback/blkback.c b/drivers/block/xen-blkback/blkback.c
> index 944576d582fb..838064593f62 100644
> --- a/drivers/block/xen-blkback/blkback.c
> +++ b/drivers/block/xen-blkback/blkback.c
> @@ -1563,5 +1563,6 @@ static void __exit xen_blkif_fini(void)
>  
>  module_exit(xen_blkif_fini);
>  
> +MODULE_DESCRIPTION("Virtual block device back-end driver");
>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_ALIAS("xen-backend:vbd");
> 
> ---
> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
> change-id: 20240602-md-block-xen-blkback-0db494d277af

I don't see this in linux-next yet so following up to see if anything else is
needed to get this merged.

