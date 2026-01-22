Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10701B81D3
	for <linux-block@vger.kernel.org>; Thu, 22 Jan 2026 10:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077719; cv=fail; b=ILfduu1PbnwH4wpOg8HICVZXTa6fprNxo5i26ospWZTd2vY9+NaGLjg+8oBu94cnB80ci5QtB0CrK4jOxPc1JcyoLJrltsvaLvZpAiUkU+L05Me1Re3JUIHK54WCPGESJCxkL/TWHMTfG7Fz7R7yFTxCDpbfvmOLJ5s4BtsYWkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077719; c=relaxed/simple;
	bh=OzrEDxh5/4pohod2/BwNU8jNvyHF1eD6xiaremoxGEc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VlnRteNEv2w0SQWaT4Ycy5vyLGyGQZP1rkd8plRcXX03gIX2sZF8Rj4SUTL7Z7IZRJyA6kDco1y5PpOYHzKWRi9n9bhqatmpj8uDeX0AvMCfHB2218AP+9WpiWkqyfPkcTA67S2NHa+1JpH0EJ7ch+vqRDkqHooENn9kIv1w+EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N10x44h/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sc2lvE2c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N10x44h/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sc2lvE2c"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M6YRk5720383;
	Thu, 22 Jan 2026 10:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mPGZNlehWXK/E7wMA6VWirsLL8EtD1jRdunMXWeK+co=; b=
	N10x44h/6C9YorWezPCXKj3ytqiMF69j08+Mh9FIsqEJRasK04amTX/No1xN7LPT
	29vCDJBA/ulHrrzmSG5KfrCyNyq3611DAdmRNFJtofeJqlslN5siDf1qI7vkOy1C
	BHtXWRWgOb7ini0XTBYvTKeiY8h+lEs8NqGUs59oBu7ltXOgjH85D470x8Pg4K5e
	kaECPRcuaEhduZlVHmc3WjRyjw1/FTY2/vBHLA8oogZWYZ2yYSZKD6RUfgeLfuW9
	ylwG2Mns60hO79bD/ZS9pca39elhWazi3NPbMtZayBjYAPquI2yOArm3c9JPe9Oc
	42Uav/fTMKL6gE5wTEkJYw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4btagd410s-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 10:28:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60M8FDR6037786;
	Thu, 22 Jan 2026 10:16:59 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vckf2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 10:16:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANI4PD/oeSW2HigDoInPjgqwbEMdny+UGG/A5k5D1+8Zzo1orN9yiKAmJQYXbYv3fTD7uWnHOYcrbGpGCM+n+9vnT2yr1Jw/AZNY3Dn/teSXsuCGYe3PKsArX28N1hU6e+JfX+29WWPbi2M40T8Anc0iebPOqWgHOpo9QXYnnRbq9wUZ7J84PunBDuOdMJGqJ/tCjO1cu7iKJiaLDPtOs3tEsgUdSX0VVRWq6dkK8r071mzu3f3GGFJpEjfE4fYl0hWcQNLg8gCP3innqo+4LUC8tfFv4Mx5DjdMSJnnPoH28NYBGyIoyHeEc4gsBH7jxBIJDHY2qpNmKe0367xP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPGZNlehWXK/E7wMA6VWirsLL8EtD1jRdunMXWeK+co=;
 b=CUcsNtltPoxAE78mUCFZBHv7dJR8zb2mmMweZEyAbNnkgGT6RILmrWEy9YPQgSwb7WYtLKvSrXkeWYYFgDhjKZiVL01HiMMhAHqaYSLL8BMvFbyXXMVQo1Lk4KuZ9YrSjAgqenV/iSNxvOx+WoHr/6LMpz0E7Lv4vpXmvNgPgykT6990YUNiVB1NOuqtHeYW1ngYUDiFBL4m8kIja6XmCadU3KwIDMbRiEB/FuT6UukISjlOsix4AX1y5oUfuDI7wppS8+UMDi6mZV/AArjYb1xku+2sfSseFUuO8T3GSRjvUr26CtmpIQ+x+/TRAUL3OLEuMraKsOpsWoTW3nDbRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPGZNlehWXK/E7wMA6VWirsLL8EtD1jRdunMXWeK+co=;
 b=Sc2lvE2clysBO+Iq98trGY75FyVW38/VQYiuI8pTgX683GodrYMpGZqLs5UfQNDGCBfHacrcSUlMvM3dGFwWaM7qrY4RbNuSGYVyW3qgmBsBRy7nkWtMkp3gb8DgIygRApGE2/VnX9I5Bewx9oaxIElEX5wJG3FHI3lJ0NxtiWU=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CH4PR10MB8227.namprd10.prod.outlook.com
 (2603:10b6:610:1f6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 22 Jan
 2026 10:16:56 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:16:56 +0000
Message-ID: <c5ad03b7-b5e3-41ee-977c-f0ef1002bf1c@oracle.com>
Date: Thu, 22 Jan 2026 10:16:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: What should we do about the nvme atomics mess?
To: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20250707141834.GA30198@lst.de>
 <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com>
 <aG7fArgdSWIjXcp9@kbusch-mbp>
 <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
 <a454f040-327c-46d1-8d0a-7745eb8a7aaf@oracle.com>
 <501169ee-37e9-4b15-89ae-8f2b57da270f@linux.ibm.com>
 <e7873ec2-c447-4eda-9725-80e614c3e210@oracle.com>
 <eaeaaf10-2e60-4ce1-9a84-42aaff1b7fc5@linux.ibm.com>
 <4023a0ad-ef60-4307-aca6-514ee790d6c6@linux.ibm.com>
 <d2ce6a5d-f6e4-441c-957c-fefc33f3758d@oracle.com>
 <fd73dd79-b314-4514-86b7-74f1862aae1c@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <fd73dd79-b314-4514-86b7-74f1862aae1c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::10) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CH4PR10MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: b40c4ab2-ce4e-47a8-f59e-08de599f5ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QitVZkZ1Qkp4RVhERmY1cTc1RXpETnd6Q1lKbWF6RTVxQS96dUg5QjFMb1g2?=
 =?utf-8?B?cWdrRU1PN00zd0VBdzJZRVdOVzRHK0g1VEFzVDVieDFvVi9EUDFsNTFrcFlx?=
 =?utf-8?B?QUttMnhSc3N2dFhTa2dEWVRNVkx1RnRKTDFiWUZJZ0IzSm5vQUZhYzQrMkNH?=
 =?utf-8?B?dU1oVlhiVmN1UDZuWGpaQkhJRVlvd1pQU0I0S0V0bGYzK2kxYVd4NFhXMzFi?=
 =?utf-8?B?aDkveUNmdUwzcy8zVDM4Rm9xTGZyMlF5V2toa0JBekphV3pnRWh4MGZQUmZS?=
 =?utf-8?B?UHJCekdwR0kvYlJnbCszMXQyUjhCRXRpQ25TZ0hZS3JZaS9jeHgybGV6bno2?=
 =?utf-8?B?N042cklVQWQzckJHWkdTRUVCM2ZZSS91anNwUE5FdkVqZEZWVWdRcUtIekJY?=
 =?utf-8?B?QXgzQ2tOS1R0dERQbi9DUm9JeGVSZVdyRmwvdFpLcGw4WEFMMFNKY2pmTkxY?=
 =?utf-8?B?Z3IzRTZUUDZFeDVrVXNLUk5TWmxkUXBvTTEzVXZxMDczYkFCQkxJckVxVnRJ?=
 =?utf-8?B?VUxVc3JtU2dTUThVRUdLUmhGTFRzZk4rejJrOXFDUXFsbVZwbGVPZEVuZjJn?=
 =?utf-8?B?b2o2cjc2SXNlWkRTWC9TdVBZK2lFazlnaXFuTmduVzFSeHVPUk93YkhpNFpZ?=
 =?utf-8?B?QlNEMWthRU1rODltRjJwQ2YwZTJBQ2RwaUhVanI0d2hmcFJIQVBYR0QwV3R4?=
 =?utf-8?B?WXdWOGxZS0s2eS94bnE3MTM4b0dtbW9INHRsdTVUSFBrSDU2ZUF0VCtMRmdy?=
 =?utf-8?B?aElIelFURlFFbWNoMHZJck55cFVENFljakJuQVVFRUI0emYzYWl6Tm1temlx?=
 =?utf-8?B?VXlKQ0kzV0lhMGhJVnFZUjR1ZzNDQVZQQ01tWDJaOUpOR09iUG1SUzc1TURM?=
 =?utf-8?B?c2lRRVVZY3FRL1JFT2l5Zy82eDhoVjE4dnJjYmZXc2FEZ0VxdkZTS0lXblVM?=
 =?utf-8?B?eDJVMnBiSSszUGFoenVGYUtKSXhLV0FPK3BsdFpadWNROTNpNncyY2QzMnF1?=
 =?utf-8?B?L01od2g3SkhKSEVkYm5vdXMzOW5odngvNmx0NTJzUVBWbGU5WW5UVklUVFJm?=
 =?utf-8?B?aGpxSzJWK1JGN2R6eGdjczZ3aC9qZ2RsczRvTWhLbkVseTVjeHU1R0JDM3Qz?=
 =?utf-8?B?SHVXcTFWWUxScW9ncGtRUjdBVjRuVFF6Q3VIYXcvZnphZkFXZmlpbEo5ZWti?=
 =?utf-8?B?dGYvcmdVUHlzQ2NHeDFpdmxlb01pOCtic05jcGdvdi9JSzNGYVg1aWh0VnBz?=
 =?utf-8?B?eEd3blJrMHBLakJlLzBYTXpEbC9wZjJkN0VVNkZUblhKZTFzOGIyUzNtS1p5?=
 =?utf-8?B?SkR3ODBnQXZOYWpieWE1Y0l0d3ZDWGc1c2R4Wm5MR0pjVmxSZG5ROGFuVFdY?=
 =?utf-8?B?QzYwSDF1OFpuSE9lMFdPUFl1ZEN1eVB2WnloWTRmdWJFRVpWMGVxS0tsN2tp?=
 =?utf-8?B?WEtRV3ZwcU9Wamc0WEN5SHpLZWJXMWtLMGNFV0V5L0dXWXhWTUdqS1FYaWx2?=
 =?utf-8?B?MUVKR0pDdFVYQmNwK2UzeW85Vk9hUjMrTWN3eWNYWFFsTVFSOWRPT0pEMkE3?=
 =?utf-8?B?eFJqc0VvN3dlRVRzcEplMFgxckR0bU81S1dEQVg3Qmc2eEgwd1BEUkpScHNr?=
 =?utf-8?B?MlVxQzkzT2lOeUFybEZ6bE9LemozODF5Yk9vMGZmQlhEamN0bTBlajFOU3Fm?=
 =?utf-8?B?bHRhZzJBWWFPU1duYjZKWWl6b2Z2eVRhT0JYaEVtV21DT0s4SlNCRXRtazho?=
 =?utf-8?B?ZXBqbTJIS0tGVjYrNFVhczdqbTg2bmZ5ZUJsMjh2akFPMDRvRm9HVTdJY3oy?=
 =?utf-8?B?UG5MbEs3T0t1TTUrZ2R6MTR4U05jV2xYZ2tZZWJvbGZybTVWbXFoMXNsOVBO?=
 =?utf-8?B?Vmk5c0VCOTlwcE9VQlA2bkZ5Q01wQVl4SWtSTDJrUS9qejRCemZnZkZBSkVE?=
 =?utf-8?B?cHliRnArelNlNkplc0pqS3BqMWV5UUdTbFNWOEl4dG5Ua1h1TmFybXJWTzBM?=
 =?utf-8?B?SW5Rck1jc2craEx0ZWplY3hmUE1SbnFGaVZBcW1VWjVaT05Dc3FOSHp6UUR2?=
 =?utf-8?B?TXpwTWN6YzM5QXEyNjR3Y3U5UGNPRHVMWHdYM3JhUk56Z3UwV01KVkIzUU8x?=
 =?utf-8?Q?7D8+EAF9JLchjMIs0gd8DWpGX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3luRGxRcHNweEN0OE5oVUl3a3dUVm5YVXVSaHF2YUV0NFRzL1NnT09yYlIw?=
 =?utf-8?B?OTQ1NkFVNW9vTEFzT1VxTHRTSFJKNDg4bkdYTXp2UzJGK0Nhc29PM2pyOWcx?=
 =?utf-8?B?ZHlRQ3N0NWpldm9acXhWY0Y2eExvRU1QOU16Rmk2VCtHRXR3cFdhUlVHandy?=
 =?utf-8?B?SFlaaWN3bGJEVXZuRTY4SXRWWkRrMkt5L2tqR0MwS1pMS1lGcHRQREorNHFt?=
 =?utf-8?B?VjZTblF0NjJ0RUJOZ3NMNzdFRmdFVWd5RjJJREJnYkQ0QWlWMmxTc1Fmd1Jl?=
 =?utf-8?B?QkcwVjRuM0h1NEE3amQvcUJoNStUaUFEdVpieVhOaHRhTnlSeEErdHBwMmZw?=
 =?utf-8?B?M1hKc1ZZWlpjNTBWMWxUV2xENFpUaWU0a1RYaC9rWHp4ckJ3MHdXSHFjclFM?=
 =?utf-8?B?bUJJSUdobDFDU1NuZnFwSnFwZmxESWVFQzhJbXhiQW1aYVlJcFFZZC9HS1JJ?=
 =?utf-8?B?SzMzZlpaQTBPZXlHRnFIeTZMTEFHZHQ3VzNBanFHV09NSTNZZnZtNzM0VURW?=
 =?utf-8?B?N1ZJNDNmZmI5TWRMSlAyNXE0Q1p6eVJ2aDg3dGM3Qi93SEZEakl3REp3Vlpv?=
 =?utf-8?B?UXJ3M3ErTy9iVGd4TE5tRzdRVkpJbjNBdzl1RjdkYXg4VGtaenc2YXhlRFk0?=
 =?utf-8?B?MGUxNU1MaDRMVUpoWi93SkdHRnRueElhTENWbmp0UTAwczFXWEpaQS9jVjM5?=
 =?utf-8?B?OEQ4Ukx4Zm5oQ0YrUGJFOUhibU1oZFFrTVA3UjlzbTRFTjBJTkFtMm9RRFd2?=
 =?utf-8?B?UmpCOVIxRVBIVU5mTHhxWkkwYmQ2NmpCWFhTYVc3SHZ2TTNJNFcvVjFKcUI4?=
 =?utf-8?B?UW5lREZJV0NIMHJXR0gvMVhqVTB4UGlNY1c5T2tOV0FoeUZINjZ5ZnZ1Umhr?=
 =?utf-8?B?UTE1ejZmY3ZFUXoyRzJsVEdDMzYwSFBlaFJtaCsvNk51YmtmQXlDVE52TDI2?=
 =?utf-8?B?UDNwQ1F4WEo2NG9waGZTaU5JM2FGR2ZzU2haekNoVWxzRUtYRnJJd2NUSE8z?=
 =?utf-8?B?dTFjU0diSjZRL0g5REs4aVVuczFRNmVTaWhGYWdsOFFpS09lK2F0eWxsb0Vj?=
 =?utf-8?B?M0VyM1NDWW84UmFxQ2plcHZLdStsdGcrM3NQU0tXSHRQcnpVMnpYbmI1RjFG?=
 =?utf-8?B?ZzVlcFZYbm0zY2MzZGNzQ2V5VE5TMGRYR0JkQ3l4VGRVN3NmQzN5YmNkSGp4?=
 =?utf-8?B?dGZOSmxlUXdJOW5Eb0NhY00zbk1Qd3o5bDV6NGVpdCthbWJEYzFxd3N4cER5?=
 =?utf-8?B?RGlMVzMvQnhVd093MVNFdUp0bWxESW5kRGtmcUJ3TEdzUUtkSGF2Q0JLTjlM?=
 =?utf-8?B?NTRydjVuSzhHWExtTmFQNEdzdGcvWjdVbU9KWFFRT3JRaVU5bE5PTkU0VE5B?=
 =?utf-8?B?YlcybTArSmJYeldGY05FOUtVWWRxd0crMU5KYk5uMHNtSWlCUXhXcThEQUs3?=
 =?utf-8?B?TTEwV3g3UmVTOURGOGZVZy9nWGVxOXQ5MTFmOFFSS0VyM0VFQStqMVp2V0o2?=
 =?utf-8?B?M1RNVjEyamtuSUhhbFBORjgvUC93U05MNFFlc0RBaGZnbGRJT3NYOVVtazA4?=
 =?utf-8?B?U2xRNHFWQ3JQbXVvd1IySzFBM1EwMS9KV2xZaFEvRGZ4QjlSUWI4SjNsSDBD?=
 =?utf-8?B?TFo1MHM3akFNUElDeERIWVFxSHhvYkp6VHdtOUxOTmtuNTNHM3hKRGpCeSs2?=
 =?utf-8?B?QnZ0TWtFS1BhSVNtZVpMWDJyTzc5ekd4WWluVGR4dlJZL1BjZ0JkenRVUjdi?=
 =?utf-8?B?bzBIaDhjUFhpK3VML3NrdDhpSE1zdzgwREpvMzV3TDJYVW41S09kcjhMVlBz?=
 =?utf-8?B?VjhnQ0t4VFJOZ2tOaFNSMmtxNENqcGwrT1pKZ0dJcXo4SDVhdUVDRVBSUEQ2?=
 =?utf-8?B?UnNIWWpsTU5VME9RV1lTeGZuRGFLa09WY01HeEhreXdwVVhSSHQxN0RrVVNv?=
 =?utf-8?B?TDdIRXdtUUtVWUdWRnQ4VlpxWEoydUxTN2VBWnQ4VDNNWXhjTDNFZGtENDA0?=
 =?utf-8?B?Z3ZFRTR4YnJ5djBhQ0lvQ2FnUGk2OXFlcW9zL0ptUW1hbUVpT0VmNnJxZEh1?=
 =?utf-8?B?Rk91VEpYN2xJQklCbE5RaFMyUFc1eTVnZDNUZjg0dFpkRzBjZUVVVzNQNTVk?=
 =?utf-8?B?RE1KczlBT3gyWmQwcEUvYytPREkrVFBacGlqMXRLSlJtSlBMWVFiNUppYUt5?=
 =?utf-8?B?a3dleTJxK0dEczZrbzdBMHlUdUFKdW96N283M2VzRlJ0WklvcHhtaVl5V0xh?=
 =?utf-8?B?S2hmcXlWbVJhMk9tY24rWFNHVWFjRDR4OHVrc3ozTEhxVmlPL2ZTYlF3NmM5?=
 =?utf-8?B?cm9Sbi9xVXVVeDNxQkc5VE1scEc2VXBsd0oyWTJXc0VTZlJzUFBtZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c9tS4PZiDk+2OYHuQDw4ix8jLCfi9XfwS38oqIOaAJMKnijjH+rGXn1cEZmZNihpfT6qUlW4+MoudvP9XCk1d/KAysXlOMgz/Cmta2jvp+RiJFAeq1kQcrZbJ2oQMRrsyEkKFt1PkInYcMFpNToIbZrKunDY4zBRh9irtjENbmymAEa/Q9rRjukjpDSXFxpI75UCiaABoSdpt7HQiypNkYpiH1hFKGLcL6tGTnFm5n39/oDxnW0EPXfUz7ckFTQ/GEsEmUF1okF+0S5awrtivGyn1Jd3YipJIlJuRsVxWsxMCyrm9HwvRYhj8M6fw5R9ofVsi6Kkts8/4AqxHor3N0D1MKhS6VzeXmBKf1JuxyaxFuKJEtPfagZToB5zNWtSQJbpBY7oYX6N1qOrH1ppQeZTf9B9lxqU8blqwVP2W8BvihQZ4bf/ft/GY9klZq6k8224aNtIKAVKMbakVS7HkmKxIG52gFmTcEYrSoI/ooLjIowK3WW2Eq1K/2P4Z/8qY63gVTZp0Kwu7hsHsRu8eAFWQbK7pakZEqGCvrbMneYSEOzzOb+arRN1YRMP5SsK66tIPxpdaqIdqx4O8MkRRJAzlrt9BhSFN5MjDrTKw5Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40c4ab2-ce4e-47a8-f59e-08de599f5ec0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:16:56.0157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CM0TbyUB9UnWQz6Ea79dcOZYh6KEpYEWOI9H1zjOdd7a7n/0/msM2025wWsecerxeAVH8XTPIooNrJ8zEIGFLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220072
X-Authority-Analysis: v=2.4 cv=PqqergM3 c=1 sm=1 tr=0 ts=6971fbc9 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=I5r0CxplrSDLCy34:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=nZJYV8BMdu-N2rab7vIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: mTig7x_STe0LY_9vSgH01_BWzE4cFCIX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA3NCBTYWx0ZWRfX/CPcMCLF4wW/
 o6H9iGVpDFePQVikTTrU/mady+0kaaHylASFNP72wpWyqO1YZ/Ec9ujCCXjKN9nk6qX+bt5Bwna
 9eOSiiNV74PaVit/pAfo1YC7iG3Nd3tmcgcPsfx0U4iDUi1ywmRdeN9TqN5YPuAUBWgdKgpob+7
 KIYOVSZ5pk8ElvZvlpJULfUkNzuegK+C2GOVX3b12rY4p/AzDVJ4Qy1H5ssCQgFDp1Wv9eyIVoR
 EoFOXk5u/t7h+VJl09BG18a4+jdPhQiEuPLQn3p7ogq3a66rhXjYJ9EvqTevZD8SnGvO58o/TC2
 Jv0a+BGA40SXWZCr3wpa8RAr/CwOYySc5Y8UQk+4tbAi3g30YX6jAJGa4DZyoMsdGzUE3sJA/hQ
 E3BcNJrzySD38suc0vmXChWhNQWCtDjUTlQgZWrPvSfmdJjZDks0ru6B8vYg5MSb2e4ureySBeA
 N6C7FCnFstPJ8kZDqRA==
X-Proofpoint-GUID: mTig7x_STe0LY_9vSgH01_BWzE4cFCIX

On 22/01/2026 10:06, Nilay Shroff wrote:
>> Thanks for the update. It's good to know that this vendor will provide the required FW update.
>>
> An update...
> 
> IBM has now formally received a firmware update that adheres to the (proposed) Linux
> NVMe driver requirements for atomic write support. With this updated firmware, the
> controller now reports AWUPF = 0 in the Identify Controller data structure. All
> namespace-specific atomic write limits, including NAWUPF, are reported exclusively
> via the Identify Namespace data structure.
> Additionally, the atomic write limits are now correctly scaled based on the LBA format,
> as expected. The results below illustrate this behavior:
> 
> $ nvme list
> Node                  Generic               SN                   Model                                    Namespace  Usage                      Format           FW Rev
> --------------------- --------------------- -------------------- ---------------------------------------- ---------- -------------------------- ---------------- --------
> /dev/nvme5n2          /dev/ng5n2            3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               0x1         12.44  GB / 204.84  GB      4 KiB +  0 B   REV.BAS8
> /dev/nvme5n3          /dev/ng5n3            3D60A04906N1         1.6TB NVMe Gen4 U.2 SSD IV               0x3          0.00   B /  25.61  GB    512   B +  0 B   REV.BAS8
> 
> $ nvme id-ctrl /dev/nvme5 | grep awupf
> awupf     : 0
> 
> $ nvme id-ns /dev/nvme5n2 | grep -A4 nawupf
> nawupf  : 63
> nacwu   : 63
> nabsn   : 0
> nabo    : 0
> nabspf  : 0
> 
> nvme id-ns /dev/nvme5n3 | grep -A4 nawupf
> nawupf  : 511		==>  As expected, the atomic write limit scales naturally for 512B LBA
> nacwu   : 511
> nabsn   : 0
> nabo    : 0
> nabspf  : 0
> 
> With this update, atomic write support is now clearly and unambiguously expressed
> at the namespace level, while the controller-level AWUPF is set to zero, avoiding
> ambiguity and aligning with the Linux NVMe driver expectations. 

Thanks for the info. And it's good to hear about this FW update.

> Based on this
> outcome, we could consider:
> 
> - Recommending other vendors adopt the same reporting model, and
> - As it was already proposed earlier, updating the Linux NVMe kernel driver to disregard
>    atomic write support for devices that report a non-zero AWUPF at the controller level.

Yeah, we can just stop using AWUPF always. Or can further consider my 
proposed change to allow AWUPF to be used based on an opt-in, below.

Keith, Christoph, Any further thoughts on this?

https://lore.kernel.org/linux-nvme/20250820150220.1923826-1-john.g.garry@oracle.com/

Cheers,
John
