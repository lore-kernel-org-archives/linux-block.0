Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B0185607;
	Tue,  9 Jul 2024 19:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720555130; cv=none; b=BP7Dg/UKrDVz5wZD+d8b6I7Uw6VciGfBc7wuKiEhIfTxcb9+n5WEFyZO9chS0lJcJEs7uD/J4wlThdzoe0BldM9j8KnrnInUkSS4KJdrt8Ftw+dYXLCAe90cqjhyikI2dnlnf07V/J510bMcDnU1ZGB7rUAAfRdfK7P2aa7E2lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720555130; c=relaxed/simple;
	bh=Rvlo3aS2QiBWc1I0xHE7+GAHax3YRlgY/uQSsLbxeUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=O/LVODliXXtGbNsBRpZ+3NEJ/E4HZyPRHB68Jm/w3R6lokgs/mCmn3ySxMQ0Sjarxt2NnOnhatIu/Xt0sWHlQKc8MGCLBIszyQLRRtd1xttLdBNRzv1PyoQk9pbPjEAtX5dt9UMWuKk7W2JGK+DVdhaSezZ9rIltpBldn5f8sXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hLC54aVa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hLC54aVa"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469Crv3H019517;
	Tue, 9 Jul 2024 19:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GRkQX0d772lMiO+BzCwxVeVSpy06O9LgQ64lCdx+Ar0=; b=hLC54aVaRjU7r6A4
	RGL2fhiyQ6kXcwyzAAwHZfiVbj/s1WLuH235HkyT9kSyB/TBnOnKqQVN6yytf2XZ
	exrew11j/OF102z5I81x4KF+HdZrkfx8ar73iHbIllVw5BwtOT+2Aff943fxBUaM
	mujA1k/AQomPcFfn7TpBSYgWdLSk3P336B6KScCTVPer3KW/8FSHQu4Fz2t0cwyn
	FoQ0gBG4x23NnnhCPKYV4co5ZcMhZsoF9ycswNZ7X0/AsH5eBo7XJlOuXma2rTu1
	zY3HMhrTAf3AtvjJk3We+QqjWirqGf/1K6Xqm4v3j/Tm8F2tT/y14Um093VwiwSR
	79Nm1g==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wgwqf24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 19:58:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469Jwj3e024988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 19:58:45 GMT
Received: from [10.48.245.228] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 12:58:45 -0700
Message-ID: <ef5e039a-4279-4c03-9d98-a31ba88cd26f@quicinc.com>
Date: Tue, 9 Jul 2024 12:58:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240602-md-block-loop-v1-1-b9b7e2603e72@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240602-md-block-loop-v1-1-b9b7e2603e72@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7dd1E6VD0RU6ZwdV15zEoCxGQmXR62w-
X-Proofpoint-ORIG-GUID: 7dd1E6VD0RU6ZwdV15zEoCxGQmXR62w-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_08,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090134

On 6/2/2024 5:15 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/loop.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/block/loop.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 93780f41646b..9455c82451aa 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1830,6 +1830,7 @@ static const struct kernel_param_ops loop_hw_qdepth_param_ops = {
>  device_param_cb(hw_queue_depth, &loop_hw_qdepth_param_ops, &hw_queue_depth, 0444);
>  MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: " __stringify(LOOP_DEFAULT_HW_Q_DEPTH));
>  
> +MODULE_DESCRIPTION("Loopback device support");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
>  
> 
> ---
> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
> change-id: 20240602-md-block-loop-756a95ba7841

I don't see this in linux-next yet so following up to see if anything else is
needed to get this merged.

