Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9FD1EA7D6;
	Wed, 19 Feb 2025 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739974776; cv=fail; b=POtRUTTemn/+Vlzv8wU4Sc/BofDlgqz3mc0HhJJSL2/UmFfBagpdRcvkWgRzIPJK2o57o4XjMJcSlitWq+3EafuUvhteHozyKTMfQLEKO1BGqVKXsHiquc9xWltHjOdDGYUyeQmYbN+Xls324jtmGKoceovywxB/3O5mUTp+zhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739974776; c=relaxed/simple;
	bh=iO+rcJo6aONBKbm1ZThzfojJkHU/o3Gxt9WwpsUaB0g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dZbvYIpzepwQaaYNuxPqJ6aADsThe9VuK9ee04dr17+K3IpxvoW/DeZTdP06VuiC4/CrmhvFwE4p/m3V+tqN5P9qTeNB4jCpgywAGWoqGTrsDKKR6Fj+sNTKVfkx9cYlDxzsFVSzEIYxFtnU1ttnukQ8YBM8BSYq/ErgUcfkO1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mbEZP5jp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EA9OiCeC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mbEZP5jp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EA9OiCeC"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JEBXcu028660;
	Wed, 19 Feb 2025 14:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FgmlnkjWwP9KFTvOz29/8KQGumIgVla5WAGHze88UVU=; b=
	mbEZP5jp8M09HMGKCk45g2PBFzV6E+cH0+pqG4uoDeiXufX7gUMGI/9Pxp2MY4CJ
	J1gOxb6EC2w65qCULuF/Bh0BwdR5UuMVsGwA1ft7nefzF3l0LmFvoi3q6c2DtYJE
	UmBkhgW3CueloL8lJT2Ramsnx6BcJBVeL58RmbcWTECW0Dam8gicC6+N+BXsMsu6
	ptIEZVghC12X4ipFD3km5LFkKtJdXx2C+kA/G0IFB2BngtHOucCcNGHhpCZla6os
	baGt94snf8CdTToVUBXSZgk1QVsCsvmk87tbs3RdH6/UfeYt885swKpDbuuPDQXW
	IvZvOOKu4koeyszsRnWy1w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00m1s5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 14:19:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JCoA1M009776;
	Wed, 19 Feb 2025 14:19:07 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w09chn05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 14:19:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRMFQqDVTnOLZmGlwBBLj4FnGLEQ1fdX4kZj7q+1kDAkguWRmrk9mODOtUd8b8TvX5FjWWzBD/E3KiTqhS0k4vyYPUhoRlTwWFF4m96fZvvYqGgAdMhh8TdM86bUnZAcOkgfxC2HV7OhwkD/YoMtDsRxUO8IZF2Vm11mw3P8ujlm2DyGNEV0/k/GOGdoieYtS9n8EsuKK8WgqOqOs8sxueNtyJnysu61Boxl4qCE25g4+iEaagNoNMTaN24wNdDEGM0wyqFGeb7fAXuJ8t/2dTBleYzrBN91mIdAK57LXCp7jb2IqmTcmc63cGGkSr3xgZK2gGwzl3Y75cyTzl8n2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgmlnkjWwP9KFTvOz29/8KQGumIgVla5WAGHze88UVU=;
 b=RQEjn2yN7RkCilouFxqIZe1lRXDm+60yMcfwCkA+xEYMhOeSlnG1WIOOhHqmyI3Oli9aqqUAE1vS9bsbfBn6yY3btiQKB4WmfygAnkSgr4N+Yo4ucmsfu8NQ33K23dymZdnGUL14Kj6NQc0jMKuroiGTJpC1Wt4cx9AXtnKjm9Rb0Yb/6BTEIiLun6H+kY9LLx7F6/doxPsUfo9oE1k85qHUv8xoAsExMM2x1lwA+YHv/hPxRdurAlckeIfYN5z2BO9zLmxQFOAN67+Mxrh3wAu5FEFdmP9jYdZJkGTlC1lvoWK/fdobwclVCIYfOno9+uFgstqaXwGrgqcLJFgpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgmlnkjWwP9KFTvOz29/8KQGumIgVla5WAGHze88UVU=;
 b=EA9OiCeCVfmdHYFM/V1K54dCagSLvb6AA+8/2xhjiPk6GGXzP4CvqGkVfZ1d1DksGrpAuvlwVditzC6gpzzEDZnw37Q0qSnwQrDVj4m0x7YhtkVYXdxsI41q4rtTgxzel2ikgmyKWl2GxyPscyUCzFUOlZ8utZREK+RMl+3X3NE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4655.namprd10.prod.outlook.com (2603:10b6:a03:2df::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:19:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 14:19:04 +0000
Message-ID: <2c23b85e-4ec7-4554-bac8-a76e3b75d776@oracle.com>
Date: Wed, 19 Feb 2025 14:19:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: set bi_vcnt when cloning bio
To: Bart Van Assche <bvanassche@acm.org>,
        Andreas Hindborg <a.hindborg@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Oliver Mangold <oliver.mangold@pm.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250215-clone-bi_vcnt-v1-1-5d00c95fd53a@kernel.org>
 <KP4HxjAbrINQTT05XxqLFD7bPj5ONsT3hTQJYUyXtoHBYc7-xFNDZUN3R8pWT-Cd1Q5fguKy97Oy8UJv5Nj1Cw==@protonmail.internalid>
 <f4f4fff4-5055-47f7-9f24-6b1780920f4d@oracle.com> <87r03vfpkm.fsf@kernel.org>
 <464bc3f5-aef2-4e6b-b7cb-035077d1e3f4@oracle.com>
 <6c3d81f0-aee5-4619-82c4-3ce72bdce317@acm.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <6c3d81f0-aee5-4619-82c4-3ce72bdce317@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0041.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4655:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa25a46-af85-444c-56c5-08dd50f05d09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHpQK2NNRXpYZS9EM3RKaFlVMk1WYkg4cEl6M25KcVZtRHVLRU04aldMMGRv?=
 =?utf-8?B?RGN0N2c5cVRsTXM1T1dkMVdWUG9qMVhWQVFRaTk4KzNRQTRKaDBzMm04NHU4?=
 =?utf-8?B?Y2NqMFRGUktJdXFvMWsrRDlocWF5aXlWeXBCWUs5aDRieXlZcTMxN1kySWRs?=
 =?utf-8?B?UFJWQm1oOWNOUldmZ2dYOTRRSTB6L0tGaDdsOGxZcTVWNWxVWjNPWmhOYUUw?=
 =?utf-8?B?enJqOU1GS3dFbXJSWlRibTdKd2hyZWErZUVWcjcydC9TelBiYXVKSnFVaitI?=
 =?utf-8?B?SVlEYmdscTYydEYyUnFFSEoyaEJDT0MrVzZ2SVhvSnJUemtPVi90N2d0UnUy?=
 =?utf-8?B?a1Mrc0VuMGpZbTBQbExzakR0cW9FUVUyVmlRQmROZ2ZPcG1iZTgxMkV4a3lv?=
 =?utf-8?B?VVUwdW1zdWNiL0NvMW80cmZIcDdwZ0dwMElUWUZBTUppcW9lMWp1OTRpeEE1?=
 =?utf-8?B?dW90UEwrUFd4VnJrdFh0SW1EY1B6ckFtQXI3MzNvUFdGZmE1Vno3Tm5NT25W?=
 =?utf-8?B?UTcxeW9ZRU45RXh2ZlN1UGhORVRuU0RJUUJEa05JR0grZG9lN05HK2E2Um54?=
 =?utf-8?B?QktPd0VzSmZxWTgzZTZZN0RvWjRhZDNBZzJxR2MzTm5BaTJqV042c0VwUWtj?=
 =?utf-8?B?OHdLbFRqZEJsY0FyazZLWisrZEVyaVc1YWVzWGVKT0xSM0gxMXhlYjhRSnNm?=
 =?utf-8?B?a2NKNUpXeCt1RExCZ1FqTzQvV2Y4SG5UTFA1Qi9tZmdXSEZpSFQ4Wk5iZ3BD?=
 =?utf-8?B?K3laRHpQSk9OZjdsQzdvVWxNdTBBSGNBaWNZdDVBSFpPZnNaWHRsMktpeE9W?=
 =?utf-8?B?VGxpSjl5YmZMcXNGZEJocXJWS2dwMklRaG9sajdTcmFNZWRWbkg5L1hISXMx?=
 =?utf-8?B?VHIybEh4V0xKSWVRWEhPcjhZTkg1cndRV3BSNjJVMXBiR0xob0NDa2RPdXIv?=
 =?utf-8?B?VEpkWk4rZTNmelZzSzBvSmNpaDFDRktyalJ4UUpVcVRSVGttMlAvWHhabGxG?=
 =?utf-8?B?Nkt1NFg5QkdWazQ3Vk5sRHd1Tkg2VzA0b0tTTTBBdlZ4eW4rcHpxV0JRbmZx?=
 =?utf-8?B?bFVmeXNWUkdrcnY1MTQvc1gybHMyblNUYnRTZk1NOUROb1V6V1JpbjcxakNR?=
 =?utf-8?B?UFVWUTk5c1V2OTY0ZWZVUTN3V0Nwb0d5RFdWK3RUVktJd1QxUm1SL09HQ3FF?=
 =?utf-8?B?ZStuYVFRM1hJUTlncVRhQUdTSllLT3RNS2d1VlZUeFY3TG5ZM0R6MzY1bFJH?=
 =?utf-8?B?dWs4Q1l0ZkZhYTlXTlNwVElVeFI4STM2NENyVERCSlhtVHpjWlhyTEtqRkc2?=
 =?utf-8?B?TnBsQ3VQT2FubHV1M3JnamlHV3A5QlpiaDBpbHA3TmRTaUpIY3RNMUU4SHlF?=
 =?utf-8?B?MzdLU1E2NlBVZkVyZHo3ckY3Z3RxanMxWTVhZlNueDljdldqTVVPRnYvQzhs?=
 =?utf-8?B?VlpxVnp4S2dvT3dpWmRobVdPK2FNU1FTMTd2djk3d1V3WU5WeFhUbkFuaXBR?=
 =?utf-8?B?V3ZWdDN0K2ZUaEg5cnllZkwxTXMyTjBFMXo0WE9EWC9UeEpnTlJyN0N0UU5G?=
 =?utf-8?B?a0tuUFozcDNxVjNSanZHWG5EdGJwOTJHNW5DekliUDJjbm13MnJNUTdhSGVk?=
 =?utf-8?B?WFRDajVMbEZzenZyZ0hBc3JuRmlBVEhUSjVwVkFZZkdKbkVjb3plenlKZnI0?=
 =?utf-8?B?S05hckREbEhuU2tpUG9WTEpOL2hkS3VjYWtQKzhMTzM3SDFhTkZLRHp6U3ZV?=
 =?utf-8?B?QldqVDhCWDlEMHhRVU1EVHJQY1ZGOE12YlpxcDZmT1hnSVJCY01iMTFqeXFT?=
 =?utf-8?B?SFhVVFRjb2g3UnNYVFVJQzk1RTVNK1Jnc0U0U1ZYSlZSTXhxSU9HOGxLSGJJ?=
 =?utf-8?Q?N0z35tARrK/GA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDY4RmtlanlQRTE2TjJPdWRva0FmdzlmNjQxZVVwK21tTmdCNjRwYTF0Q0Fy?=
 =?utf-8?B?cTlxWVdvT042VE9teGRsK0N6NUxSdkQ0Nm5iSmtQYnllZFVhL3VZS0JwYkx0?=
 =?utf-8?B?MzU3Ui83ZklwYmxYbW5SNEJPcDdPTFBDamNDdGUxVGgwS2lobm1kLzFleXA5?=
 =?utf-8?B?cnZiRkNGM3RNWThoRFY5ZytBUWxlV0dvQkdnUWJyZEVsY3N2M0FiTmFoVk9s?=
 =?utf-8?B?NkhRWk9CcW5SOHJZU1c2dzUvYURyMzRqZVc5UjFSWDVhU0FjYkVlbUlPMG9R?=
 =?utf-8?B?RVYvMkhNaUZwajJnL0pmSVozcExLdmZESEhTV29WaWlwZElob3NUQnRHV3pQ?=
 =?utf-8?B?ZnZLQ01KR2VLejFhNm1FY1lHK3ZDRUNhcFlYYzlpUEpZalJLWXlWOVZrOHU5?=
 =?utf-8?B?cXZYRjYraVdsY3h2TmI5aDFYMmgzazNXZjkzSUplNllNNjNjaWtJbmt2SUxI?=
 =?utf-8?B?aEJ5YkpNcnFkUWRWVEZjRDZ3REJ2UFRXalRFZE14SEg1U0NNQnVHUlRWNi9o?=
 =?utf-8?B?S2MxMGNwc3VrelAyMHBQNmJjeXdMT29nT1pPcjBSTUVQeXpaZk9aeFpwd2F1?=
 =?utf-8?B?QkhzSlNRK01rWEhQbmk1T25RVVRmNE93VkRqc256T3JCVWYzZEd1dEh5Mzd0?=
 =?utf-8?B?MTdIZVBQWTVtbFB2dk1MOVZETHppbUZkalUra0RScmlZTFdXQUNtS2tnVHh0?=
 =?utf-8?B?dFNNQld4ZUdZOWRlMjkyeXQvL3IrNkV2c3djb2lrbHQ4TjRGWThUUEpuWlg3?=
 =?utf-8?B?SWdtWUpIRTdYbjlLdUM0dFFGSTJQd3QvRFI2K3FCUDdzYVVaUEduMVI5cDYz?=
 =?utf-8?B?OEtxbXlKb0tXcGM5SC9CWVFla2dSZld4MXBnNE9NNE1OMnVIbEk2VkVXZFNG?=
 =?utf-8?B?OVMxUnVwa2h3emRPd0pSeE5iWXdjN1RoK3dsWXBWRjF4RzgvYzBjOXQ3S0RT?=
 =?utf-8?B?K1M4aTZSMk0rSmF3Sjh0MGUvODlWUC91U29yaC93cDVMMmZ4QjFTenRzbDlX?=
 =?utf-8?B?MnVKcHRSMHdhUjREWU9ldXdxNUlIRERTOHNiUUNWTjNQeW4vSHNJSkRTVkNH?=
 =?utf-8?B?bHlFWlVaN0Q5QzQxU2ZRMmdQOUV3QzllSUl5c0hPUDU4TmdZeXNqQUg1RXNL?=
 =?utf-8?B?MzJaMkpsUXBIZG4ra1dmR2srSGVBL3NyYUxtRUtzSkgrK3c3Sm1SeFZlVFJ2?=
 =?utf-8?B?ZW9vVGFLMHZjQ0dkb2xvQzNiOVhxUlJUVTdaTWZLVU9lcTA2WlpiTDNybXpm?=
 =?utf-8?B?cTZCczB3OG5aVnhnZTIyNUQ2V1hwblZrUmRwcTM3MjNNa0dPQVJZSng5eFd1?=
 =?utf-8?B?dXhJQk1EK3NyT3pFbHJ0WmFlNG1qVjVjSkppY2NjQ1JnQ0djRFVsOHlEOFkx?=
 =?utf-8?B?V24xVnJHV1FMekMxNFkweDVnK3U0N3dqWk8wWit0M3VidFo3K2ZyQ0dpRjRD?=
 =?utf-8?B?dVN4dVNrcVF6akJLbTNRNnlCNkdJZTBXVkhuNlRLVEhtY2I2Mi80NWR0SlpW?=
 =?utf-8?B?bjdMN0pGV1VYMjUzVFJiOHQxOWpuVzd6anovMTFCRFBmT1pCVkgvUUY3aHd0?=
 =?utf-8?B?dStweDF4d0YxTk9vem5NL2RuYlhGZzZTbFlsc0FSb0svREVibXhIcHNoc0Yz?=
 =?utf-8?B?c0kyRm9MQUZxdU9URktmQkhqakhyYnBKRndzUFUxUFdvalo5SllXMDJlR3V6?=
 =?utf-8?B?MTlPNVpxS1h2Tlh0b24vNHNoK0JEaTlSL2NHZ0htQWlCL2tLUW5taGo3MTRn?=
 =?utf-8?B?emZpY2srMHQ2Rjhjd2luNUFZL3V4ZEcrbkFnR1hieGRJYUhWMGtZSFhiUWRT?=
 =?utf-8?B?aEZYbmxmb3hPaFBjbFEybkFaV3UrTVMyRjhTdFNDUXdzYU5ON2Rib0lwdUxl?=
 =?utf-8?B?dk9oSWRQa1N2YllFTnFjcU9kK2ZFTHRCeVlRamVOeWcvVGlodWJEQ25tNDhj?=
 =?utf-8?B?ODhuR0JJRUh1Vjl4YzFSWVlkQW9SWDhIRTkyYjI1SXlYVmRNQk9YbGF4eklY?=
 =?utf-8?B?MHZEQzFaU1dRa0pFb3YwcFhOSGxBZzAyV1U2SEZQS0RwdTl4cGl4NUdUZ0VJ?=
 =?utf-8?B?Unh4V3JFbGZIWkdRYWVwMm52TTE3NFNHWG8wYlUyRk9KUjRvWi9OdTZoZS9X?=
 =?utf-8?B?RUppQjB2WjJBSWtGSkN3UWRPdTBBMFFGWGxwdVpUdFVHMVZLcGIvNGViNkQ0?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NUiaA2Q2Ce94ois1ZdIopaYHqRYDtZzGFQal5j0fpSWliMCVm8yOZaDS807abDAMsbSw45F/HP9l7phgZfZrkSpr7KX+pghHtkdkze9rDgGdzlnHOi/UKb7in61W/GwFt4iRhTLGqKYXwXALkx9JaU1QGLIZABSXX+2xtT2hx7JFxdpz0D/aUcObylUx3e0MSJXgTCeIYVnfHjAC8iwCwYQS0HsWkZQg1EQA95sjX1JV8r2Iu/LSMsEOGCcsobH2p1047UUKAeRA5Nl/tb9ujm5BBoe0Wpu5SHdtzBNfNlDQimlw9N+kN1BX9f6UdT4xUyRKdIV6uffkTBzSo/hRXSOyfFuHyE1006dO9EyTRj4+MFWNNYH2o9f+5GCD/ND28J5L7xADMPftK/ikJOi3FsK6pt6UhlTR+yUjncq++pNMPnRwTQPNferz8kApb3rDl1SDk6wFycsaKXHENAGMsz2fSW19R3MHFhnSi8WQ4c2qR6DCF3zUhAZcd5mAyIkkrsPA53O2K5RbnwvfWGZHkiFIfudF9VVke5Nf10svFlsqFpIiid+JVAssHbLOe9xTvfVOLg1nmZAHxZuZvssVLcP+oqkeDuzb0JWaU9PM2KE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa25a46-af85-444c-56c5-08dd50f05d09
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:19:04.7581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xveCnR2S1huGrHmPQp7JELsSnSan3vwfF+vEAMCmKaGOJMK3PGU0LNLymgv6xad+I86nQmx8Tl9aejniZZsybA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502190114
X-Proofpoint-ORIG-GUID: zsbunSbQ66U2TSMSgl8-vNq8sKiUacIy
X-Proofpoint-GUID: zsbunSbQ66U2TSMSgl8-vNq8sKiUacIy

On 18/02/2025 22:21, Bart Van Assche wrote:
> On 2/18/25 9:12 AM, John Garry wrote:
>> On 18/02/2025 11:40, Andreas Hindborg wrote:
>>> But I am genuinely curious if there is a reason for not setting
>>> `bi_vcnt` during a clone.
>>
>> I think that it came from commit 59d276fe0 (with the addition of 
>> bio_clone_fast()), where we assume that the cloned bio is not having 
>> the bio_vec touched and so does not need to know bi_vcnt (or 
>> bi_max_vecs). And it is inefficient to needlessly set bi_vcnt then.
> 
> Hmm ... I prefer paying the very small performance hit caused by copying
> bi_vcnt rather than having to deal with the inconsistency caused by not
> copying that data structure member.

 From my experience, setting anything which is not strictly necessary in 
the fastpath code is generally not wanted.

Thanks,
John


