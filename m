Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C237F2F4A;
	Sun, 23 Jun 2024 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163967; cv=none; b=JC+7Us1W8hax/9C6SFKz1BQg2AyW6E09S9by67pxyIuKcT2MzrtBuWLI4q6Dk+P16cHVm7A2jSzhJRkxKQ+8oe/BvkFKJxwF/EjchEPkP6hWngWazxNjH7B2vxiR3Z6sCKYJ3K16tJgYfGkQ4029FafvSFiwCtZNjAbEd8+szUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163967; c=relaxed/simple;
	bh=5XVddq2aJJiXJGtLhX9aSQO2lYLjdc6piTSx/L7U/MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gkhbTnHcEhNxT6QHdN4P2QFc/mN/d0tLYjacEOQ1QOFGMBOw4nUTarGy7/MhLtPMvesCM84J4tl7e1FRVu3r7kRMuLvVAEOrVsOO3ZC+mj46IQyjLVboWTKyXhLiU0Y71BVLyppN7H5szeN4f9BUxGmIEa0FWGVPoTdJVwVwdHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jZ1KHajD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jZ1KHajD"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45NGnN5K014416;
	Sun, 23 Jun 2024 17:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZZYZdRFm0729J0taMyV1DnvDam2mSjZExv48LlyTr3g=; b=jZ1KHajDCnkIhXuw
	OJ4JFedaEgmRsHn5vfdMVLw9+JcqzJvKDh/iGGJ6yGM7/vSkoQWKLoHbC+FQw8UO
	gn7vQ7MZ2Y6ipy/OakEhcSIGgdFzrch6lJNJFZKSPqQ7ITY4jkSKuQKr3e7vGb5a
	xoXAxtNsJ2l4AuWu8DMOkogaqc4qHzp0Xu6p/09RSDWoHCxR4Ge+nC5jA3YEWNz1
	dfbqVD+s/RHeBJFyQg8JZXvnbgqpMO1EZvOZnHUX/U1meiZtKPt47Dib7sAYD9v4
	HLHAO0c5YpVwk5e7vmTuQraxJYfwxkKO4nuv+ewNOKChmZD60OakW8MWFlr900+s
	PLzgUg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqw99vj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 17:32:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45NHWbce021347
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Jun 2024 17:32:37 GMT
Received: from [10.48.244.142] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 23 Jun
 2024 10:32:36 -0700
Message-ID: <6349112e-3df3-43d9-a541-24e1ca04be14@quicinc.com>
Date: Sun, 23 Jun 2024 10:32:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] brd: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20240602-md-block-brd-v1-1-e71338e131b6@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240602-md-block-brd-v1-1-e71338e131b6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: p21mQ60-NTR39kRB3yx-2t4DCHcelkAx
X-Proofpoint-GUID: p21mQ60-NTR39kRB3yx-2t4DCHcelkAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-23_09,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406230141

On 6/2/2024 4:46 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> modpost: missing MODULE_DESCRIPTION() in drivers/block/brd.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/block/brd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 558d8e670566..3fb2f37ab893 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -296,6 +296,7 @@ static int max_part = 1;
>  module_param(max_part, int, 0444);
>  MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
>  
> +MODULE_DESCRIPTION("Ram backed block device driver");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
>  MODULE_ALIAS("rd");
> 
> ---
> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
> change-id: 20240602-md-block-brd-e4ac89657a2a
> 

Following up to see if anything else is needed to get this and the other
drivers/block MODULE_DESCRIPTION() additions merged:
https://lore.kernel.org/all/20240602-md-block-brd-v1-1-e71338e131b6@quicinc.com/
https://lore.kernel.org/all/20240602-md-block-floppy-v1-1-bc628ea5eb84@quicinc.com/
https://lore.kernel.org/all/20240602-md-block-loop-v1-1-b9b7e2603e72@quicinc.com/
https://lore.kernel.org/all/20240602-md-block-ublk_drv-v1-1-995474cafff0@quicinc.com/
https://lore.kernel.org/all/20240602-md-block-xen-blkback-v1-1-6ff5b58bdee1@quicinc.com/

