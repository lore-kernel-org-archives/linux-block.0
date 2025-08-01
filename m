Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3501FA15E
	for <linux-block@vger.kernel.org>; Fri,  1 Aug 2025 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754035459; cv=none; b=CkPrGtl02scWyS+ApvVXZk3C9xh4U+TMrpRMWubmtJX7L0EGvEY29SqpzN6CiexShfwB79HnD3m8Su7p7RtBSjebAs+/qpb4QTR6sk6zAOciYkf2vka6gkp0vZaBOgQLqi6/oarTC152HMv2W4kHE+5S8+nMOqNDp45GPkSNlis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754035459; c=relaxed/simple;
	bh=nnPCEfYl7P0n5cYp6ZV/HA5gOBYtTEE/RdugXDbE7l4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ul5DGZfwXrKTnPsLEojzcrBbWz1XQ7dSi4danT1QmMKJZ6YtSIJDTXwcnkKi8MW3U+N9YXf5mCy63QbS1j9Yg8xCLb13iu1bE1d7xhx9X0i96ASq5zVWkVtX8KvnW33fBnhxDI5r4Fh16f38cmrqGskSBk5i8fPnhmI9KBiPADQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BOTaKfpJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BOTaKfpJ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5710smwm021698
	for <linux-block@vger.kernel.org>; Fri, 1 Aug 2025 08:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hkiPQOuq40Ps/bo+JMPRlBp1hyPYRZQxi7RXk1U3VoQ=; b=BOTaKfpJmYOnbUQk
	uFzj0TPh++pjY/1FfMbW4voVJicNPRRFTDhAxi05EgxlTfLVe6D/wP4kFgFElnWe
	warK4+7jO7r9eHC9hh/OYMAQoC4tqOwRUQS95i2lLn56ZMlzZe8Dd44bjs9izYKy
	1peD/xEU8szpcg6aruESTF8YSlpzIfqYAF55ZQ2Ox4uW4AjdgdLi34g9bdBdOMXC
	8BTLn+zNrButUUBk5d0LPjoI5EPINlT1tVnX50hcwcP9iA+SoQIwDk+Sr8qQ4Bl+
	/ipAusevWDGB68R0HWVOMVWC0VIbF17aCYw20lQomsC4trZzEo2O5PurLhBQbgqU
	KnJ1QA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcrk5v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 01 Aug 2025 08:04:16 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b4226c60a38so894863a12.1
        for <linux-block@vger.kernel.org>; Fri, 01 Aug 2025 01:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754035454; x=1754640254;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkiPQOuq40Ps/bo+JMPRlBp1hyPYRZQxi7RXk1U3VoQ=;
        b=i37f7JSs2r0d5evUt5n/pFDWXJwHAhvht+8s0XGKCeWOkPuV0jlomtWQgmSmTFODRH
         hUKpQlq4iarOeCwF8o4NB+SjCBP59lf47t+eaWKxBMb0rTvqsrhLIEQulNtD1r+Zmg3o
         l9hteOVO4apjECmb4eLoc3QlaSXlJ+bEM9GpSnnN224zhB0QtLqDCoStM7+898ZKDyHD
         4Iyy6ii5Hjl0zmebesKHNWWchWzVzyZh9kSzbMZWJib/ixtyFX9IDE72Sa1EgHELJMKy
         ZNPvXyO19nnr1l6iciLPUkhhZH515hdV90WOGRoxj2CpcXvD4lnWz0t571PLovmb4cOv
         ytRA==
X-Gm-Message-State: AOJu0YxHQbsaaxNnHr+rPIcjmkvFs9uzZSRKRxv4UarCmgIlnCE+HzpK
	zG/mfFMccP1rvnz1HgNURNpQM2/Tiq7OP4HUnDOK0s6DNiI5heFy0l2zU38VzWTuTsfcR7wGSnH
	0UYL9kOl20mb3sWO57fmdrUEZi2pSLk/S/TJ2sBHH6FoAWVnXcMqAAifLLpjnK8r2rg==
X-Gm-Gg: ASbGnctlBFA1ajvhtLQGE6MWKTrjCDtv02o/GvDR18WxqPmajZwcgrzgdgwVeDO6DWF
	FJOO1fUKS66el4RvZP75sBGYSzAYT0550ejuRMsjI06uGUUAQgbv8E/EK2t/imi27NpM+4Cr/ZT
	wfCVKfp6Lyool1js+HdB3dAp4S2Z7yvAPtbsqIqLEQnEJGS1AnYNFOB4WE+uomb5BHCwCBx8V6J
	QNMxQCrZx+kecSYsnxqWaO2L//2Tx/MDAhuI4QQ7EaZyMXHkz0LbUm0+0Nhs6xcUtTIvsz8RTRw
	BL7K0b0KZ+fU+S3qZMv/ZkggVhscj34uTTb5+TrxWWJweXT2KZZID8LQuqm9ZUh8R8m0LycgOZT
	ikr2JCpxhWfGpsPInZ4op8e5q
X-Received: by 2002:a17:902:f2c6:b0:23f:fdeb:416f with SMTP id d9443c01a7336-24096b680afmr123067345ad.35.1754035454627;
        Fri, 01 Aug 2025 01:04:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeBFR6JRo/H9wRlRFcU/kwFK6wWe7Gqnlyfk0vlX/82+g+ocbEP3XFMzwGRpeP6fp8RZwjHw==
X-Received: by 2002:a17:902:f2c6:b0:23f:fdeb:416f with SMTP id d9443c01a7336-24096b680afmr123067115ad.35.1754035454279;
        Fri, 01 Aug 2025 01:04:14 -0700 (PDT)
Received: from [10.133.33.163] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaadadsm36703015ad.156.2025.08.01.01.04.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 01:04:14 -0700 (PDT)
Message-ID: <923e52fb-fe4a-4c3d-9526-fc8536a28f28@oss.qualcomm.com>
Date: Fri, 1 Aug 2025 16:04:10 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 14/14] ufs: core: Inform the block layer about write
 ordering
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        "Bao D. Nguyen"
 <quic_nguyenb@quicinc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20250724215703.2910510-1-bvanassche@acm.org>
 <20250724215703.2910510-15-bvanassche@acm.org>
Content-Language: en-US
From: Can Guo <can.guo@oss.qualcomm.com>
In-Reply-To: <20250724215703.2910510-15-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDA1NyBTYWx0ZWRfXy2XF4dkX5cNz
 lftdD66OwgNrUqeIffEfyFlUJTfVyR+plaRM0+guUCYKhAdVtM0a+ywp40AzPJ8TXJEtWFo6ygn
 udRNtZ1k5kj1maDp+jOKaw2wGm63G9burLCSTcbCfoGRYf4m8O+w6PoTldC9IIcqXOoRSe67B90
 +v6i7zgproTfV+Vz6sve2h4De5XZqbl9vwUKaYyO630qH7hiQsbX8hEWOzi51/Z1+sJkYVQJGnK
 YpRkbyxy++k/4VonzVbn3eUNRe5K9yEu0MiLDGGVsuIuw4ptPCyrjGLK58SMIOha9lHyXkLmeap
 zI9q0BlL5Kh5z8fVDisDb+U008jxRVYHnBB/AKxBLcJ7D54Z2/mm8nZhKRG6OjIZ0zbCKm2bF8C
 R2z4yiz38vuRl09g6tAUCZlaF9jUOMBtI/dO/cMVbW61Lb7jnsPls8ytgG9WkhuAiEDmZ4Eu
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=688c7500 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=JF9118EUAAAA:8 a=COk6AnOGAAAA:8
 a=yPCof4ZbAAAA:8 a=N54-gffFAAAA:8 a=EUspDBNiAAAA:8 a=vGqm9230wn-5tKDOnP8A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=xVlTc564ipvMDusKsbsT:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 8hnF7TGWd7csbIPed_ftz4UBdpmN3C2L
X-Proofpoint-ORIG-GUID: 8hnF7TGWd7csbIPed_ftz4UBdpmN3C2L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_02,2025-07-31_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1011
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508010057



On 7/25/2025 5:57 AM, Bart Van Assche wrote:
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
> In other words, in MCQ mode, UFS controllers are required to forward
> commands to the UFS device in the order these commands have been
> received from the host.
>
> This patch improves performance as follows on a test setup with UFSHCI
> 4.0 controller:
> - When not using an I/O scheduler: 2.3x more IOPS for small writes.
> - With the mq-deadline scheduler: 2.0x more IOPS for small writes.
>
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> Cc: Bao D. Nguyen <quic_nguyenb@quicinc.com>
> Cc: Can Guo <quic_cang@quicinc.com>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/ufs/core/ufshcd.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 50adfb8b335b..6ff097e2c919 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -5281,6 +5281,13 @@ static int ufshcd_sdev_configure(struct scsi_device *sdev,
>   	struct ufs_hba *hba = shost_priv(sdev->host);
>   	struct request_queue *q = sdev->request_queue;
>   
> +	/*
> +	 * The write order is preserved per MCQ. Without MCQ, auto-hibernation
> +	 * may cause write reordering that results in unaligned write errors.
> +	 */
> +	if (hba->mcq_enabled)
> +		lim->features |= BLK_FEAT_ORDERED_HWQ;
> +
>   	lim->dma_pad_mask = PRDT_DATA_BYTE_COUNT_PAD - 1;
>   
>   	/*
Reviewed-by: Can Guo <can.guo@oss.qualcomm.com>
