Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3132F157E88
	for <linux-block@vger.kernel.org>; Thu, 16 Jan 2025 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737013490; cv=none; b=k7i3yZro+4XCBZewlugGGGn2TLWl4HNmyRwIzLtuhvnYxn22dme6VMtMqS7iM5z2KkPfVN80TwQX83azGhCyj+TKUtlugf721yuHgYbeDy9XPvxmQu+GtvwPyED8hO7BL9bphxv9yfUSUyaJGVgeXBaAibUJG73Pf+5lZ8/wxsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737013490; c=relaxed/simple;
	bh=vCUL355PUmxQkHoUZjQusX+HzCE2DufxqUmBkiy4UWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qfZnMY76jfSJawrQCWMCWJh7O0cSUAzQ+mKq7UT7Lx6Ma/CvzHjxmh3kXHLo9/EipAnSwtGpZpWG/zQFZgB1Su8XhmPbKMl/GUSedTutYUxZzvrjYwCCE5oEumDfXnM6P2jp8Hn16qIQB0yFH/gjvXRGxfFmyxMcDtp5Ip4YGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WKxARc0F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WKxARc0F"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50G3Hxu9025801;
	Thu, 16 Jan 2025 07:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EQoTO7/2AaY5MfsO2OXUF4bpfLihZ/AjYN/01loV764=; b=WKxARc0FgWHhHSYG
	oR6UR5Sw7rW47fHNVRhAszvkZRe885W2PEbWeu47IZv5I0f3m4hRKVurd2SR5dw2
	21uWZfv24dQjeXn9+Hvlq6AIflpIQTJoB6Hm7QVd9svchTdGLeE7Fmq7jq7OpVb0
	qPnf6eiN9uobhQJC4zXTl8F2PHL7HZMQo6JXcLxxTNiDIm+v4gwP1H7VmqTyQczD
	5TXhjfa8IOJwbclOkvdDKKdMSQD5e/dIIiPpOEb7xlr2TqyCYHSValu7/33Jlsoa
	QYtyydbXonxSQRD+r+wnyIEsn2Anfe0VGk1DiJDgizQrCaFpbRafm7gFPKCC+nF2
	L3j8FA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 446t348hpe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 07:44:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50G7iOcP004164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 07:44:24 GMT
Received: from [10.253.34.248] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 15 Jan
 2025 23:44:22 -0800
Message-ID: <48378035-f0f2-714d-6172-bbaac285e3d8@quicinc.com>
Date: Thu, 16 Jan 2025 15:43:57 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v17 14/14] scsi: ufs: Inform the block layer about write
 ordering
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Damien Le
 Moal" <dlemoal@kernel.org>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Avri Altman
	<avri.altman@wdc.com>
References: <20250115224649.3973718-1-bvanassche@acm.org>
 <20250115224649.3973718-15-bvanassche@acm.org>
Content-Language: en-US
From: Can Guo <quic_cang@quicinc.com>
In-Reply-To: <20250115224649.3973718-15-bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z1pPeEXZ6151UoVqCel07qXCyumNIA4w
X-Proofpoint-GUID: z1pPeEXZ6151UoVqCel07qXCyumNIA4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_03,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160054



On 1/16/2025 6:46 AM, Bart Van Assche wrote:
>  From the UFSHCI 4.0 specification, about the legacy (single queue) mode:
> "The host controller always process transfer requests in-order according
> to the order submitted to the list. In case of multiple commands with
> single doorbell register ringing (batch mode), The dispatch order for
> these transfer requests by host controller will base on their index in
> the List. A transfer request with lower index value will be executed
> before a transfer request with higher index value."
>
>  From the UFSHCI 4.0 specification, about the MCQ mode:
> "Command Submission
> 1. Host SW writes an Entry to SQ
> 2. Host SW updates SQ doorbell tail pointer
>
> Command Processing
> 3. After fetching the Entry, Host Controller updates SQ doorbell head
>     pointer
> 4. Host controller sends COMMAND UPIU to UFS device"
>
> In other words, for both legacy and MCQ mode, UFS controllers are
> required to forward commands to the UFS device in the order these
> commands have been received from the host.
>
> Notes:
> - For legacy mode this is only correct if the host submits one
>    command at a time. The UFS driver does this.
> - Also in legacy mode, the command order is not preserved if
>    auto-hibernation is enabled in the UFS controller.
>
> This patch improves performance as follows on a test setup with UFSHCI
> 3.0 controller:
> - With the mq-deadline scheduler: 2.5x more IOPS for small writes.
> - When not using an I/O scheduler compared to using mq-deadline with
>    zone locking: 4x more IOPS for small writes.
>
> Cc: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Cc: Can Guo <quic_cang@quicinc.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Cc: Avri Altman <avri.altman@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/ufs/core/ufshcd.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 3094f3c89e82..08803ba21668 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -5255,6 +5255,13 @@ static int ufshcd_device_configure(struct scsi_device *sdev,
>   	struct ufs_hba *hba = shost_priv(sdev->host);
>   	struct request_queue *q = sdev->request_queue;
>   
> +	/*
> +	 * With auto-hibernation disabled, the write order is preserved per
> +	 * MCQ. Auto-hibernation may cause write reordering that results in
> +	 * unaligned write errors. The SCSI core will retry the failed writes.
> +	 */
> +	lim->driver_preserves_write_order = true;
> +
>   	lim->dma_pad_mask = PRDT_DATA_BYTE_COUNT_PAD - 1;
>   
>   	/*
Review-by: Can Guo <quic_cang@quicinc.com>

