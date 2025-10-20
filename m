Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2E432AAD6
	for <linux-block@vger.kernel.org>; Mon, 20 Oct 2025 13:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967767; cv=fail; b=J5japHidOrOqJEOYBUxX/jxvgGCxZSaVaU1jo8toIjNZaC7cHuIdZhhVN2kTkM84xOQP34HwPcmMu2jhk30JFWsgcQUIxxm53Lj/vslUgNQ4xhaAKdOUaS/pdLMvZlttpwY5epyDy8IUJOcrd4BtRlwU7q0TP3ohqzuHpFAfeEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967767; c=relaxed/simple;
	bh=2ooKHk+3vej+qwduP1D2hceotgNaEDcStqrhef7ivRU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iKKcGXq60JNuJZuxe91Ur4TTaK19JWXwtvZcnOV928TvN+QY+md29KcJupqDxMitRDVh+uT6hGTo7PbAbYnsH51GJ5qvaB4yhMvLPl+p4yd6Do6uIgEHi0lA0i5ddbbBN3/9P2c6fF6Xs6jb5kr/Ac4rNXgImtrIhw2UwoOqPI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ida3P1EF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YMcdcrkI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ida3P1EF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YMcdcrkI"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8SJpM025814;
	Mon, 20 Oct 2025 13:42:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QqkC/fvk/g8p+G6bBVzG5JScILZRA5frT+PrmyrxWJE=; b=
	ida3P1EF1YCNXYPGBue0XiKXPgw8LmPsz265eUj+5pwaX9fY7CICG8z/yzionM4O
	1vK8vWPur2403+QU3pbarbdKruc8jqfR+7/uCLFzeqMGbKnJ/mVEd9psk7rz+10f
	ZLcIAHixaQR/NgPNuiZowKJ9Yd9451tacZix3+Onf/1m/S3kq/ZounItMwefADZh
	45175//xNZtaJTZ/6K5uryG4O+bvOSHQzgO9731VWZC91/e+S8lbsMgn70vVWZyK
	GZRTouyzHD6UqxXH3G5wcTyuaEzUxPOz+HBv5jWIPlve7CvDkNeqnkjYvDMcqinF
	LX+Q7DRtiQJf71aDe0Koow==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v3esj99m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 13:42:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KDUCkH032302;
	Mon, 20 Oct 2025 13:42:29 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011062.outbound.protection.outlook.com [52.101.62.62])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbpypc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 13:42:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCRuThuo0/zVTikBR55vDyuJG/o3+64aLUxLYgBeLED8Nr2xrPisNdigCSluUXgeyQyDE9JJ1igQqCDj7H0g8gz19PFGZ2dEV3hILc8KTrFpq27132CX0qJP7cs5UrDj4FIcAjhghL7yEC2wQpcgnIhq3AAiMYbEUv7p0dBgzKZmYbXYmBW3X/AuHUzC/kGCjPCZNT10XnuDcThmFQxAW3KPlHOH5CEbXj6P3JT97SfEnKUJ+E5HWRzHgtLvPd0EoPHtdAN/CSjlrWvqpfwIqQFJ1TUMPOdT2LK7acYtFuW5JRqtMrdTHj4Lef8sNpbrS4/XLbenE3cjBcjM1Xig+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqkC/fvk/g8p+G6bBVzG5JScILZRA5frT+PrmyrxWJE=;
 b=jK14PfgA4FhSXxRqxXTSNk4zCif8BT3+O8HGJFu+oX2i+yWbT0mx4lGbjSm9udtpsBjC91+zb0BfvEUY0mK6dJfa5mLq0y+rcXghmt2qKGIcWaNeZscP2f3r5rxvBG/gUaR3UCn3PAB5kFJbp7dTg77TX6jLngr1gUdFShUYQHanSLhXU/JCAUiAV0iCgtUPBPltvnSMsT9p1SovowJ8w+gG9690r3MQDLy8UMD2wfbYF9uBtdq9w+2fgi1TPaBEaOYVgkSMm86O6NVi6Zuz1BaISq5/PCv1NUkDcdw2+lKVzhsRDTsHh+gCDb8veXWeELNLhY4xQYuaQD9i8Elpiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqkC/fvk/g8p+G6bBVzG5JScILZRA5frT+PrmyrxWJE=;
 b=YMcdcrkInVkbE+wu5FSTMD30MglT8aEKEqLMQVvaaEL8E2n2xSKIuVpouJ2/MepLuQ1UesJL5bwcVVWETpb4+auETfGjCdh/1Zdq8dmkZ3ZE3P4zf8o9mTs/3XoESXwYAl6ZHIVXJDuz6/KeuaFyzmQC2eCdYSrZ88OArPlPfbU=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by BL3PR10MB6162.namprd10.prod.outlook.com (2603:10b6:208:3bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 13:42:26 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 13:42:26 +0000
Message-ID: <a454f040-327c-46d1-8d0a-7745eb8a7aaf@oracle.com>
Date: Mon, 20 Oct 2025 14:42:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: What should we do about the nvme atomics mess?
To: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20250707141834.GA30198@lst.de>
 <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com>
 <aG7fArgdSWIjXcp9@kbusch-mbp>
 <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::13) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|BL3PR10MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ce7d7d-190f-41a0-3a12-08de0fde8152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjFjZmNFcVhJdzZCVzdxTHExR2FjeFpNUG9ZU1pQOWZMeXY2a04raVFhTm9Q?=
 =?utf-8?B?VmdRcWxJV0cvZ1VFTXZ6VzdORytpN1NMNXFTUXFXVzl3eGpCaE1QNXRoRm1Y?=
 =?utf-8?B?di8rMHZyTkxabHV0ak53Nm1QM28weWgrSWhwSDJsMDZ3WElPSGJFM3VBaU9I?=
 =?utf-8?B?d2NzK1g2NEF5WHVyd20veTRLbWhLUmVlZTFFMHMrc2x4cnNQM0lMcmVMZG9D?=
 =?utf-8?B?clNuVW55YnE1Q2JJRWNPckZ2YnRFU3U0ZjRFWGk0bnRZWlZ2WExOOHhGYXhu?=
 =?utf-8?B?WFhoTjVJYXgvaUpTYzhoWEZkWklYdFR3QTVoMm5lNVpDNTJ4QWVjTEhGOEN6?=
 =?utf-8?B?NzhBZEZwcXFEa0RrOExUQi9lY1hzYzloU0g2dEZmZ2JzYW03Q3JUYnVpYmEz?=
 =?utf-8?B?QitHZ0M4OU9oSDVQYnBEZm5vOWZMbCtsQTJsdmxVRXpCY1JxK0ltS2Z0bTVw?=
 =?utf-8?B?N2JLTVdyelZtK0hXUWhTc29DS01DaE9iejNodVJoVmhIZ3IyTlNodHVBbFli?=
 =?utf-8?B?WDAyblQyN3B1cDFlYmthT01KS21LVkNIL0ZDc3NlOHVIdzlpZ1kxTkdENmFi?=
 =?utf-8?B?ZS9rVHpYQmJwZTRNdE9HVEt6Tkg4NWpmWS9KRFFsNmNENG9DNkQ0TGdrdE4z?=
 =?utf-8?B?OW1YU29JVmZMZS9lN0h5M2JLSzBZSk1BNFFLMFl0SWY3b2xJZjFhVkJNWlgy?=
 =?utf-8?B?NFFFL3N0eGVFWVFhb0JwSGltWTZSTkUvTUhoWTVoRW1JTXhHTHA2c01wVjc5?=
 =?utf-8?B?VCtOQ1dTWVRDS3VrVUsvZnpJSEhIZml3eS9rQW9PcTdxMUliVEkvMUkySVM4?=
 =?utf-8?B?ZFVIL2ltdTV5SXRLM2dsVlJ3UHBLa1BVMDh4c2FoektGMFJQWW9JUUVIL2NT?=
 =?utf-8?B?YVZRUC9qZHh1ak5xcVkwZnJtb3VsS25WYVJKekgrMENUODl3OGNVRDBZM3JD?=
 =?utf-8?B?bnFrVlRHYklVWjhQMUlpZ0FRaFdDQW9FdVB1NFFINVRjYTRyQlVPK00wRTdW?=
 =?utf-8?B?Vy9KOGh4dHhCUG1Ba3JWSHVHblhLeFNkeXJXdVZ4Tjk5WjNENnE3QXVOTnFK?=
 =?utf-8?B?emRNUXc3cmsyS05sWlA1b2xWSEVwdTV4UEd5eFFvdXhkT3pYZGNMSy9EK2Qz?=
 =?utf-8?B?aDF4SnpRZnhyOXNkT2hwSitUQ0F0a2liZTNyb0lJeGFlb2VKQWlzWkExU2xm?=
 =?utf-8?B?WHc0cTRLazZzd3FqUzZYc3pwZ3pHeVB1cjJPWmFodnVkeFNHQ3lKRkpzTkNm?=
 =?utf-8?B?NzRGbEEzQlNyTEd4YXd2NHVuRDZjNmdvRjdDR1RZNE80T0RuOXlEdldTTjY2?=
 =?utf-8?B?MWd0dGF2ZUUzdUlubEMxSnk5S2JBZ2ZaQ3JobitWd2ZvZGxWZlNSWXhrMzAy?=
 =?utf-8?B?eG5Jb0ZCWW55ZU9YaXRnTmRDVWlpZG8wYVBMVkhJQzJEZVZUNmp6Qld0bXpt?=
 =?utf-8?B?WTZsOUtGK2lTNXhLZjlVdHZVVW12Rm1WTlpESDIrY1J5VWg4WFQyME9aYkkv?=
 =?utf-8?B?THJiRlVwT3JCQXpqTVA0OGszcmFEZmtvRk1wV21NMDlyOCtrUVZXR1RYUUdO?=
 =?utf-8?B?dGZ2M3ZUN3hWdVFZQ1ZzeVFyb0QrbmFZNzF1L2VPWmNBeklIekVVYWtuQzZ4?=
 =?utf-8?B?UDlvNlpTTjR2UWg5cDNNT2tsaFc1ODhWdER6WU1xMXV6T25QSlJ4dlZnVjFj?=
 =?utf-8?B?VERTMU5pOWsydHBYT3doSDdkeHF2M2ZqdGx0UStwUWtjL05iZjhwS2lzMnZ4?=
 =?utf-8?B?NW81Z1ZMK0VSZTgrc2JHNDhLM3JLek1YbEhYOVRIdHdUR3FHclB3cWJyTEcw?=
 =?utf-8?B?Z2FSOUgzUVozRWREKzJPc2VQVU9iTDhlcGpWUm03dXM0emorcFRQdWVwMExW?=
 =?utf-8?B?cW9RK1JMWElLajR1VEhhMi9lV1NzUTM2d2Y0bTU4eHAyTHo2ZkgxSEZ0QXht?=
 =?utf-8?Q?adysDsIS/FfwvVrE5uP4wNbt2fwr6mRa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVhRZjVNYjQyaWUvV0E4MGhTdkMrVWp3MEdCdVltZTBNbFVuc0dPbFp0VEhT?=
 =?utf-8?B?ejladERSVU96eU5jcHdKV052TVNmU2JOVjdWZnRWeXErU00vS1Z4U0IyZWha?=
 =?utf-8?B?eGpGVXA0bG03RmtKVjJWdGx4UlJYMGw0MzMyL3dUNzN4SDNFR0Y1UkRZRERn?=
 =?utf-8?B?VjZoN3BzSWtZNTFDSGNJV0hJTTUzQUdra1liMXpVTGg2dG5FcVY0Z3k4ZkZG?=
 =?utf-8?B?V05od1lLSWRxV013YlRkYWlxdWZnbmhxbXRJZ3FrTDJvMXNJd1VMRlcrUmVa?=
 =?utf-8?B?MWZoU0JoNnhzMG9VWFhxVHhqN2lpaXpiMzJvcUJGem1YMlFTa215TGhrUlpm?=
 =?utf-8?B?QlhXVTZxMk9YS2UzbVlhUlVJbG8wdkhObXA3ck9paXVhcEJRbHN3Z0p4VWVF?=
 =?utf-8?B?ZWQwWWVBUDZQdyt5R3FmTDQ1aFNCSzhYSTBYakEwNWhtZEV5TW5KN0cxUEZC?=
 =?utf-8?B?RXdIZXRCNElZb2svV3I0aTNjUHNaMmI3M3JUdGdxcEFKVU45VHp1dVA5VXF0?=
 =?utf-8?B?d1ZZR0Z1R3BWUzFGaHR2MzVlelVrd25lVjlKOWpBTVJocFRuYUJOQjRCTlZs?=
 =?utf-8?B?NlJYQlFpMDNhQkVLYzg2cHBONkZub3dnckp0alBpYW1XWmFHZzZrOVBJdnRz?=
 =?utf-8?B?Zmh1aGoySEswY3RXZTh6NnRKWWRLTnpvdFhQbXBjazNJS2c5S1pxUHNoYzVy?=
 =?utf-8?B?UXZYTklJdU04eTh3WE50NmlVbVcza2JnelNHbC9rQ2YxcWpWdUF3ZktHbUpy?=
 =?utf-8?B?LzYxQUhvZHlzN3NCa3NDb2tseGw5a1hvcGY1Z2VTWUdkVkdZY0V1akpzdnFv?=
 =?utf-8?B?d1pKR0U3Q2lwK0dSZ1IxRmFBeFFSRTV0YzNET1BtOG1jOXNnOGtpVTc1T0tL?=
 =?utf-8?B?SWJFS21OV1BlWEQzWWV4QnpxaDFtaWpRNlRaeDF1UktsNEt3UkVvV2FLMG1E?=
 =?utf-8?B?ckZVcUxDTXRjaTVzejVPbzhuU0V6bkJXQytiUllrR2h4Vm5MVnEyMWw2Tzgy?=
 =?utf-8?B?TGVoa1ZEQVFZdThiWGFISFhRLzNaV1lvV1hBMU9mY0dhTE1FZGlmZHM4eXpI?=
 =?utf-8?B?MmtiMWV5QWdFY0VpdXlINnR0aDNIQXBaOTdkZHV3MjN1aHh1ZjUxT3dJcEdP?=
 =?utf-8?B?eU9Wd3JhZEw2cmhqclFINHlBY0RJWVdEMHRSM2VjM2hkNnlROXViaUZZRUNa?=
 =?utf-8?B?TDVoM0lKVlRpMDNJYmFXbjVCRUlaTFkxaVd2NVRBNEZvcGhlaW1ralp1TEFJ?=
 =?utf-8?B?YkN0SjJjQzVwKzQwNHFJZDY0Y1haekU4d1JKUlVFTHFMdUdkTEc2eGRrRjJo?=
 =?utf-8?B?YnZxUWhPVy9RR3FKVTM0RjNyV0V6d1Z6NXpOU2VyMU54dEk4TWVWMUM3UmV4?=
 =?utf-8?B?V1pWVEVkSUo5c1dOWU9RNUt4dUJaWkVMSzVMOU9rTklqb3VGa0kyWDIwdXRk?=
 =?utf-8?B?MmhIRUoxWUh1cmdZczJnK1V2TmtUb1JqZWNLVWc2L1FkWnV0TWJwSzMzTXBW?=
 =?utf-8?B?b1J1Y1dTLzJtUUhNMktEWkFEWmlNb1hpUVQ0MkFSUTVyZkhJTkhEL1cwbkdS?=
 =?utf-8?B?MW0yNWo3cW96OEhZNEEzR2ljZXJjSUt0eHhmcW96a2xHTmtyd29pWEJ1U3BO?=
 =?utf-8?B?cmtPNXpLTnZhaVRackVZQXpvYXBmRExlVVRFdjFIK2trODhLYlFwSDFkTTVp?=
 =?utf-8?B?elk2YnBKVFREdlJyUWNpTW4yaTdON3hxSDJyZGp2bVMxUnVQMUZKV2o0dWRh?=
 =?utf-8?B?TWliUlVNTDhad2JQZkp0YkhFUDMvR2Ixa0dtQTVZWmNlU2o1anlDZHFLc0dH?=
 =?utf-8?B?cG93K3B5ME0xaFc4YzdZK1E2b1ppUEF4MzA5WXJTZUFKR3ZXVEJaMzFnQnNC?=
 =?utf-8?B?ZER2TEdIUmp3aXJKVXEvdXcvbGljYVRKSG9hMDdYUXFDaFhvYXNIRDhzL3BH?=
 =?utf-8?B?c3h0d1pzQXhnTkZOMFJ1NStwSUl6QXc2U1R3MlNSVkZOb05DNENzK2NhQ3E5?=
 =?utf-8?B?ZERMdDVrVWVzMDM5T0N3d3FCalVjbDhQZks3T1V4REVVeS9JSFdxaVhwUWIz?=
 =?utf-8?B?VEtidnFGVk9uLzZRZjJFSG9lQTQzOFNsQU94eTB1THFTWWFqUlpoQnUyUlo0?=
 =?utf-8?B?SHhhZ1BObEJtRENINTBUaGJxczRWNW1uaTJxWW1wOWVqd1dKQm9uNnZDdlUv?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3zyfiMcJ/lTQjb4vH054dcKP4nQk26N4PbbvPvx+8ZJih4Ly0yjr+6wVO2aJdccjw62zRPe97nWaz8JdjoZ0Zjh/5KdXLlQ/zLveDn1W5jiU8kboUdA69VIC/IMTww5WAi+FrTuT2MAHMFbe9K+MLSA+bNxGYrqOUBO2d175MSzZNpSLu/oncwUCGpJWWKlCbg+FQjtJbtZYXK5YLM4HpQw22+OjFjDvnWQZhC/FFFSgXS+pNdMBUntBtSPylknQP6EK4XJeap3+FqTSbfvpEZqFtRVpjLmWcDDDGiLq7N5AwUGll1K/W1HUsIB0Oj6/YG/Kr2sO8sVm0HXdcGDHgGgibO0NCXs1l65jIgvBXRtzqwlpYPjlLD/BLJxPYwsrREqhAi12JfyuS+jszOVrn1aGQ2NX3i3tz4Cmx8MO6Xa8tjxn4h2R+puJy3jkhNVk3rvzfI6zeCAxUvYFzz8uYHwMYn/UrXWbr2EwcXjJ3AzfnyKZWJFFbgDj4d3xWLJQwWzDoW2mOgn5MxIHZ2sjFxJuAOsWq1HeqQpnG1VczNJVuensAmaWRnjDzcBq3xh8+k5BFiAdcsAsBux9GpztENQanX76P9zYRgQ7chtyG8M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ce7d7d-190f-41a0-3a12-08de0fde8152
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:42:26.3040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+EyOG2t8cX2z1wMV8iOfZG/vzYTsgpakay8M1C2nwiBglqxhYEZJrLG7wxC8ZJkxyar0rR1XcgFwYKEsA8gDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200113
X-Authority-Analysis: v=2.4 cv=N8Mk1m9B c=1 sm=1 tr=0 ts=68f63c46 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=I5r0CxplrSDLCy34:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=C9a5e595NJuNeuqIxPwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13624
X-Proofpoint-ORIG-GUID: SdfCvI3MrYCd8Z0S-Gks2GdLtnRrQLIG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyNSBTYWx0ZWRfX8n90hw3IoC2n
 fXTbHkB4nvxx36OAxr8lR0t5V88X00OvW9B7kSn/IOTP0ZzLIzPmNU4i3irjywX17gh0rFJoxUB
 4pcnBBjX2VxfnJmTPygM+FV9i0nApqHI3VPidJZKsVgEDaWBHk5yMXmJhCaJGtKw/pn68utx4Sq
 e8H56PZaBj29vGCCVyHFF8/0Doj0jtWTWmL7g3nCWaIWxkumfr6ixc14gtA0X0ybPQ8xLep7JwV
 xNtN4Z0g8+RfWcbA+WAQ+mGzsp/d3HsUxnJAtG1AjLyo7z/Cxc1KeDqrT3L212NOztXd5eTZCEd
 IZlfFuqPrg7DYOuAk1hIFgqfn6Sulhs7MHQORUwShimlFBt4RfBrchILzDp/C24UbfrFtQ7/F49
 5ig8rrcbl37U0hw0GdN4ydB/eKVhtOw9GJ64f+pSS/49H2YcPiw=
X-Proofpoint-GUID: SdfCvI3MrYCd8Z0S-Gks2GdLtnRrQLIG

On 10/07/2025 06:07, Nilay Shroff wrote:
>> Considering multi-controller subsystems, some controllers might have
>> namespaces with only 512b formats attached, and other controllers might
>> have some 4k mixed in, so then they can't all consistently report the
>> desired AWUPF value. They'd have to just scale AWUPF based on the
>> largest sector size supported. Which I guess is what the current wording
>> is guiding toward, but that just suggests host drivers disregard the
>> value and use NAWUPF instead. So still option III.
> Yes, I agree — option III seems to be the best possible way forward.
> However, does this mean we would disregard atomic write support for any
> multi-controller NVMe vendor that consistently reports a valid AWUPF value
> across all controllers and namespace formats, but sets NAWUPF to zero?

Hi Nilay,

Does the drive which you are using report NAWUPF as zero (as hinted)?

If so, have you tried the following 
https://lore.kernel.org/linux-nvme/20250820150220.1923826-1-john.g.garry@oracle.com/

We were considering changing the NVMe driver to not use AWUPF at all...

Thanks,
John
