Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA611C1F2C
	for <linux-block@vger.kernel.org>; Fri, 20 Dec 2024 10:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734689194; cv=fail; b=VpvvdK+gfSKM/62TvOOHJIE+H0OIpuGjOGluatQPStetrs5Of9ghtHOQYLCfhEd03VcYdBUAw+y5qeBedxjQnzsfyGN8MaKqDeno4epnsl7XjlB52EOTohTxny0dNvXLeWwXnvwKXnoQuWM8fh2YSgvGs/lvHJvATIj7USXGZhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734689194; c=relaxed/simple;
	bh=2y2GeBHBlhdzPSZOnppVFzrbqJxA/XFFE+6DYYpCo0Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VfBpweML1M2pnU07527i5bGVYm59WqWoLLip3RtLjofT8hnGdvK1ER7awhJZWY6YYKfOo+MwVxkT5iAvGE0dz1mvCOD+DorbIlpMFaQpxKOJgjJlJ2bYXG4jUrQq9932Xens/AFlSkm6yVc2uKKubxXtWCBO1ghQ9Orm7GOcM70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Lvea+qZe; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mDlXXUy1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Lvea+qZe";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mDlXXUy1"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK3u3xY013851;
	Fri, 20 Dec 2024 10:06:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=voEDRCBx5ztkijQ15pKC6PrXUcoJOckJg5LRoMvu8tM=; b=
	Lvea+qZeW9dhasS8gY2FO9qv2040NFWucFjyg4JJ4t2DoDtLO5asPM/WRRGUGzO8
	hBGTi+CDQABP4rjO3CvvVKEUGrz3mdWQ+HSkq7TPmEQGVuZUAHAty3QlfB/QRjKv
	Vg5iB2cRgEjBTk+h8ibDqRm2D4/GAGAlWbnjd7yjkcoJSk+rJs0UQl2OJKs8P8yB
	MwOLoBVRHAJXoh3iRUOdQ3w/uxU8vy7N5/oCHAKWSlXdllq5rHhO2nNFHYHl/B8h
	gBuhFGquMganblpy+jUaFcMFQWjKMTWH9jZRqo7UKlnD+6wgRFUtTHfQLxSCN3+J
	IT7wdQLyprvD+2QPTz3cTg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43jaj5jm9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 10:06:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK9Wwda000596;
	Fri, 20 Dec 2024 10:06:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43h0fcdjf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Dec 2024 10:06:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qApEI8/hpKGOEVMMF7IO1KL9I9FxX9hLrj7Pxbj5roOv7FhKJhzbcjEg6gAT4yVd90isMePnrzkBu96iI4nprAjnDD90BjLw5ncF1EmZz1A7GPPz9goy5Z0wNaMKkZGvBGezEw/+vlLNGJ2wPzBYAcSpRTSLQP7Occ5Gu95lCg5Ventz3elsLgjvujYdH76yUcNvgnjcN4FT3ZVvOKqazjoer9145WinwAghbJdEUsulFfUOoCH5wb8Amsi3aF+kys9aZ8ISTLBw40FI0rthUK81VCnL0Jdrn9XCE2VFLI0XPZz7vbxinU1qve9l2GrQmxyyMHBzTBuhgnZ1wZT1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=voEDRCBx5ztkijQ15pKC6PrXUcoJOckJg5LRoMvu8tM=;
 b=TNbEKM/ffz4xOAIrDjZ4kSrBmYaxKthmtgkRuG5OcVeZ2NcHK0i4ysiBPhKRrH4K4RxVwAZbkNsVEkINGr0kcsFjU5JNP0ZKtUjsMCzoB8k+lEhh/UhM0lht0Q45W0N35H9iUDqtGBGId1Y6bkCdwOXziXmnKROPLY1YsfnIgYqkDOMctO6UxgJTowNfAZjUh+vJNhqAyPebJA/ztKpkXr0Uv50BTYsu+27XdMTpnkEmr9fjYNhqgI1wR0dqSQWmYsG8PQCj4PI4Eqqq6+9Ay2u+diI/2O6wJD+cSyThJ+9aiVCHq9jBDtGT0zKk7ZPm2z5bupYVx2iVlaygks5nbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=voEDRCBx5ztkijQ15pKC6PrXUcoJOckJg5LRoMvu8tM=;
 b=mDlXXUy1xH/P9mKL9PKp76M0L4rBLJHgyqExrJqQjtQp7N0dsvo6PFd5j/XfCtLjwcUZ6wn+XDVJ6AZUbRhxueR95BPyiS2Ed0ecrt9SYVfk2QWohvC9TtwDdSsoktRd0HKHeHaP90p716BX1Kq3Pueou6TF8s0CnXR2MawJ6lY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB5940.namprd10.prod.outlook.com (2603:10b6:930:2b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 10:06:25 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 10:06:24 +0000
Message-ID: <6880f851-bb7c-40a7-b405-ee9134b8bb1c@oracle.com>
Date: Fri, 20 Dec 2024 10:06:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove BLK_MQ_F_SHOULD_MERGE
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org
References: <20241219060214.1928848-1-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241219060214.1928848-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: b33d4b89-f4ee-4a9a-7337-08dd20ddf630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkU5QXZubHNRQXo1WDNNWFM4K3VEay9wYXBUOGh1OVpGOGFXejcrOTdwWUhM?=
 =?utf-8?B?d0R0Wm0yaHJ4ZU5JaEVibHhlSDc3WTcvMm0xT1lvbUh2MWE5cGwvejJ1RFdX?=
 =?utf-8?B?UFlGL055ampOL3NDaWFjVXllYWlNaVdDVUt6QXFwN1ViUklLVFNKRnptZlhp?=
 =?utf-8?B?V0NIY3pXZVhxMUdBY05JSVJkdUsrbzR1UmlIanNUV0hTakN1aGIxaUFTRldS?=
 =?utf-8?B?dnF3UkFwV3JqdkRQVFdXZHVmcTRreGVLRUlXcVlpMzMzL0R4Y0N2UEtlemVC?=
 =?utf-8?B?bThDTHV1UVNKMURMU1FOeUdvSnJLYTFuODZMM2t2TVNDUnBzR1lCejZOdzh5?=
 =?utf-8?B?QnFCSTkyaFRrK0dXT2wrQnF3Vm56N0Yxbjh5MjJ6MkxxVlZObWlESFI3dVh1?=
 =?utf-8?B?TGRWZEdRNEk1ZWE4aFRWRngrR0RmUVlrQUkzaW9xTWZrbmFJQ25IblVtV1dF?=
 =?utf-8?B?Ukxxc3ZobjlOdUhJVVhDZnhUaVRXb24zQVp0RHFXZEtjSStBT25aUEdLK1hY?=
 =?utf-8?B?OHR1Q01nci94dEk1OURPbHh2NGxjTmFxNENMVmVEOEQwNTFmQ3pySmdReVZ4?=
 =?utf-8?B?OXVYaE9HMVZNKzZ5dG9LQldzOFhhN2JMZHBoRWFHWmhsbitoMnhRM0VuSzZv?=
 =?utf-8?B?cW9iUWtvd2tMWis1eFVLY3pBRFMvbDNQRVVxME4wTTIrY0JyMURCcE5oYklt?=
 =?utf-8?B?NVE3alNYSnBEWFNld0txRXNzNTFlc0c0QXFhS1lZUXdMbm0wMm1xQXdsRkp1?=
 =?utf-8?B?WmV4MW1Qc0poN2cveU5vQkJYRGVlNjg3ak8yd3pBR0RWZ2xLUUxmNWlRQUc0?=
 =?utf-8?B?UEJOVnIzYnhSQzMxeVcwZnUxTFg0N1dPYkJISmZtRmpEQWExVTk0WFc1c1J3?=
 =?utf-8?B?Q3o4Szd5T0tsUDJGa2lrQ3B4N1JKYmhXNHExeER1RHVwTzJHbVlac2xxaXU5?=
 =?utf-8?B?b1M3Nzh5NldGUmUwUXYrQlRqNUdoSnAzYlFTZDhPSE5iMTRNMGsxUExiOG8v?=
 =?utf-8?B?UHMyaWpDV3hla1kxa1BrQWZaWXQ1V25BUEt6UWE5QWFNMGx1Vjk1dG9CWCtW?=
 =?utf-8?B?djdBdmYvZS9KcWNYQmZXSXA5U1lDN1RQL0FFdzVwREVoNXlnSjhDYm5BM29G?=
 =?utf-8?B?cmxpNGgzVXZrWWR1aXo4eXUrT1M2TDh1UWRPNlIvbXVrUzZPYXo3RzJOZEJP?=
 =?utf-8?B?cHh3RTYwWWxqU05WS0xSMFN4bFBHTXRXSkIrcmtiWkxGSWo2a2hCR1hnOHBL?=
 =?utf-8?B?N1RGcmNhNGd6MytUanJmUVRyWWV5N1ZLVTFPeU1hb05ZRG95WXJIRUc1VENT?=
 =?utf-8?B?MzNUWkd6dkdsS3JjU1hiMklxYlpYTk5kb2R3S3R0cjhCNGZNd2NqTVVFSThy?=
 =?utf-8?B?ZXNmWGV3MU5CQ0VVZHFUcnAraWJNSlpyRkdDSHpTUW5xSVVBTXJQZXNBaWNM?=
 =?utf-8?B?Q0kvL2Q1VVdTbGFLejFBRW5zd3JZOUFYZUtUVVhCaThBWnVBQjBDdkhWcXpq?=
 =?utf-8?B?VGpWTTgwRFl2VHB6YUh6QXU2cTdZUnpMaTJpODA4cC9IRjNwYXA1MVhCWGRj?=
 =?utf-8?B?aVF5Nm9CZjJDWTBoY3RPSVNaYUU3VHRpWGVLOVJqeVA5d0Yzb3hZNm5aT05t?=
 =?utf-8?B?RlFLSEFuS3VRcSszU2prZEhyWit4ZGlRMHVPR3lEU3kxUFJ6U3BxZTlRQ053?=
 =?utf-8?B?NFNDbzQ5Yy9QQkdtNjR5QnFHS2EvRUtSRzJMeHBkaUI2dlZsdy9oVkZTU2xs?=
 =?utf-8?B?WWdnRnlFRnV6UkpQTW12OHNHcXpwQmtXTlYyTU5JZjc1cEwveklnaGZHSkQ4?=
 =?utf-8?B?RUlneXRkeCtFOWU1MjVJbDBzSzg0bTZ3Mzh3SDFhR0FZcFBOMmRNL1lsOXlH?=
 =?utf-8?Q?Nof7cYodXy7uL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3g0YzhzOVZQN3JwYWN1WWNXMUt6Q2I3WFhOODVuMHVIbVpQNlNPcFB2WGI1?=
 =?utf-8?B?VlErTkxGNzAvU3A2bmhiYkdZN3hIN29DUHhxY1lHRHYrczMwam9la1FwcWl6?=
 =?utf-8?B?U0ZwSVEwVis0a3NnZmN3RWR3Unc2eUJLTHZzOHBSdW1nWTc4aFRJYTV5dXZE?=
 =?utf-8?B?OVJnNG9TSk85UUtRdk5ObUJwSVRiYitvNXQ1cG5NM1duRDhXTm84L29JY0NS?=
 =?utf-8?B?eFdXdEJCSFA1MkJaTy9DRVlmMXYwaTczRTBBVTE2dW9JZzJ6N0tsdkFHV2lk?=
 =?utf-8?B?NVNIU3lDOFdoVUdCUEsvOVFtN0p2NXp2U0NWckZMUUFmRmIrS3RlVERPYjUx?=
 =?utf-8?B?L05MYTJzbElseGJsWFpWRWZjcGVyck9rUS9ELzlXeUhTVTBLUUlYYU5PdWZo?=
 =?utf-8?B?c0NvVVRPN2FkcG9iZXYzTTNoTE1IZk5YeVp6MEJnUU5VMjBsaGUrRVJwUC9L?=
 =?utf-8?B?QmJ1SXFLUVZDZG1HZ01UaUZWWHRiSjMxdjUzVGtTRGZTZmtHUlYydis3YUpT?=
 =?utf-8?B?U0h4aXY2ajgvMTZ6aDBRdHk1TmZIU1h6YTNzME9zaVJmOFc1RndPRVU2a0Iy?=
 =?utf-8?B?dEY5RE0zWEk0dnlhZ0dPY1VaSk93WEV5eWhaNkF2RkpUeTlMNTl0QkdxWWJG?=
 =?utf-8?B?UFNJYmlNVFl5bnBQVmJYOE50QTBQTHE0bk5yRFRrWW9FK2YvV2g2RWdXRC9U?=
 =?utf-8?B?UW5wOWdROVY1ZWhOSy9henZiNGdqejg2ZWRrNmRqTStZQ2plcVU1K01FQm5x?=
 =?utf-8?B?NFhXS2JtalNDSlRCbis3WGRQcU1YL25PdGgwTTlNZ01pZkQwMmduVThkL0Ra?=
 =?utf-8?B?eFNURUg4Vm9NRmtyMEdST2FCNmNEUW44cjlGNFdhQUlpaVZxRFcxSlpqMUJ1?=
 =?utf-8?B?RWVJWWxtbWVwMlBwVXVtS0xjbjNGZHlRaEFuTHUvZW1UM2NMVUY0QTloZXNR?=
 =?utf-8?B?WkU4aXkxeGNKSnMycnlqdVIxV2d3aHdncXJVczB3Z1A3OEdDNHBiT0kyZVhH?=
 =?utf-8?B?R2pZWk1MMUNicFRyeDlFd0c3SHJCeVhEU05xMDFFU1pMV3Z1R0Rzd1RLRkcx?=
 =?utf-8?B?Y3Z5NnJyOUp4ZDdaYmhhSjBIZ0w1ZXVzd2hIUnVqN0FIZmNRNFBYVVNtTGxo?=
 =?utf-8?B?VE5keTBqR0U5S2V3b3hGRld6ME12emVsaitjU3NBVnJTc3FTY2RIUW1razNC?=
 =?utf-8?B?TVNFM0dvNElBb2tkS01uTTJyMTcwUkF1V2xqQnk2ZElLZ1dYeWFFbyt1ekZ3?=
 =?utf-8?B?RVJnNmtkSW00bkFCdWN1YnNwYVdhYTZ4bVloaG1FUTJVUU1oL25JcUFlWTFi?=
 =?utf-8?B?YUhZakpoQ0lib2djdkpaaTNYSGdoVHdTT1ZoSkk1WlZUbVVRdG4rcHRSQ09Q?=
 =?utf-8?B?ViszZC9Gdjh0Uy91aEVDcktmbDNEd3l1R2xhYkFCbVhYY2VwVzFqYm1nK0lG?=
 =?utf-8?B?cDMycmc2eU5za3VnOGx3WjVndGhzN0VoWk5Kbng5Qmc1ZERoM2pzM2pHNDZE?=
 =?utf-8?B?MEIrS3NKd0h2WkxDTGNLZ2FrQktPcE5zRU80M2ZYODVXeDFXMTVwOWRYUFQy?=
 =?utf-8?B?ZWloVWhtaXhGRWx0Tk5iOWhiMmJnZUxnaTBiK09qM29EN0FHUFZRVE8rbDNH?=
 =?utf-8?B?eUFwNE40Tko4OUVPUmVqRVVxdUtGODlKNTVRWVk5R2FPV25OcDcxeStNdzRu?=
 =?utf-8?B?WDlpR3F4NEluSkRCMytPNktvRGRtWVc3Q3BpVVZ3RUt5elJJT2twbWw2dUtp?=
 =?utf-8?B?aFBDVjV1Q295eFRHK2lzdGN4UmRQZlk3Q3JnUzNkTjJyejJCRzlRaHlGVW84?=
 =?utf-8?B?QUorbFRsVDVDMTJGSVZBRE56RkxDY21LVEd2NGVLeEZrSWlJS0xXSXJYdWF5?=
 =?utf-8?B?WFZOcGZtZTdnWHJYTC9BaThOWUoxNDdnREhpKzVHR2gwbmVlL3BucmFqeXBj?=
 =?utf-8?B?bGM5YUhpdC9tVzBINHhJQ1lvN2grSGNnU1lpK2c3emIrSmJmQ083ZUdZYjBK?=
 =?utf-8?B?NlRTRkhQOGdVcDhUbVpxOEgyWCtGYzVrMWxTQVF6T3dkR1Y4clBvM1VweUN3?=
 =?utf-8?B?MVdYT1pjdGl2VU9iUnZDbElvL0JORU1IM0NkQ1k3a3FUMmJ4UXV5TnEyTFZS?=
 =?utf-8?B?MkJvS2hSZUg3a0JDTy8ySFozK2JGWHRMTzZ1U0ZhNUpnQ2pjQkZ1V0lwSFVy?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RoQIx+tv2DtFbK6zeOpto5DK4WIjGaK7AzQ5NC+wPgpGwYTXULiBZhc61FPI0XkcwCJQ9/w3CvXSc8XSAcvrK1RftAH1GCRj7DrI4kRTrnbQKFzFhPJhxVtiG/O323MDKrLwpUfRxqeekUCt17MjMP4IjckTMcsZA21iEVYlBRlHsgBwIYr47cyTNMEvXPubwvFipxJNSn8fHuyRJrxq7weAu2FPSTCdzVWaOoRP2DMfA6F1EXPi0jWuROKtnN9OykOkplhKLI5TzZBYbP0x9vCSLgrlLrkb2YsGvZFF4k1JFZEgB1N2KaUw5JGZtZKZlaAHdafYAOEXrwKS13rCMQocMRJk8SamGTjc2CyuCH80wKybt3bfDsYVgYxlSq+iq4g1wJSoPYNyr2kNPsRXI0Aq3Edx1uJJBf7XQBAuJNcgMarPpZllAmAbAeal6E0YO+G9CSqWkDIWO7WQ1y3S/DAz43//UkMSfoc1VRK4h3y6I3m8kW7m/8uYXu6SJWInZxBUSoXBkdW3beLZLom/PBhM1ojOMoPDbF7XOwNV6DgEyvIyQmgB3xfxwL+9a5LdkXfmsrDJWgjIlXM2q6p7ILInwcnEaX6gXd9CK4j2/DQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33d4b89-f4ee-4a9a-7337-08dd20ddf630
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 10:06:24.9480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cq7E7v1vgLg68LmtxsoF6A+y1crtOWaZMhVP9cM+6KwudruYC9S0ihRKSnapbNpEDuRC4FfpETFramwQ8ktpgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5940
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-20_03,2024-12-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412200083
X-Proofpoint-GUID: v88sRWMKCOYBUIeXploanI5t6DGHOFE6
X-Proofpoint-ORIG-GUID: v88sRWMKCOYBUIeXploanI5t6DGHOFE6

On 19/12/2024 06:01, Christoph Hellwig wrote:
>   	if (shost->queuecommand_may_block)
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index c596e0e4cb75..4096d4456582 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -668,7 +668,6 @@ struct blk_mq_ops {
>   
>   /* Keep hctx_flag_name[] in sync with the definitions below */
>   enum {
> -	BLK_MQ_F_SHOULD_MERGE	= 1 << 0,
>   	BLK_MQ_F_TAG_QUEUE_SHARED = 1 << 1,

Should these be renumbered? I suppose that we can introduce an enum like 
req_flag_bits (with separate #define for the bitmasks, like 
REQ_FAILFAST_DEV) to avoid the need to renumber manually.

>   	/*
>   	 * Set when this device requires underlying blk-mq device for

