Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13F14374F
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 14:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486234; cv=fail; b=SvKeVLuXLxTD4eQWAaKm26KuZ7tSt9OKqinBjy5HqZpWrQBuNCtl4syufxT8gP7iJoe1jDk4wyh43lwZijCuG49kD3s06XQcOItXA62Hv19U91qiJyLtWtfyWlHWh4b+ftCtchX/JQa6G4GTFtxDzRKZhOcXEC/usrEZRj/K7Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486234; c=relaxed/simple;
	bh=LZgRqIVaxZnDbY58Q9CIrTIsp1vRuWRqpM1VQWRIt8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TnOS04DZnMAkr/KdO64dw9oTiCic/vYjct51e/uHB5MAW9+/rET+geQrAX7gbD1ZEDV188nmHrLSMmqyE32mk1mTSZKjQ34bhH8xxbirbb+3OpsCwVbekSvbjN4Gz9N4CIBsLlbXh+GdL1gIVzLrU3R5x9/y6lc2HrU9MSOyIv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NXdG2OjA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HwErp3XJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NXdG2OjA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HwErp3XJ"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43UCcIXm018674;
	Tue, 30 Apr 2024 14:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=NQYd9fsBKqDl9dYu8mvQrqJM4+TY7TXQzAxx3P3+zg4=;
 b=NXdG2OjAr+ASVB/LN9SM3Ot8Baix32FobJEzvOq16y1MKYT2b5xwmLpDmDHNcvpKuSCo
 RaXAk2AJqFUa9NZfHr6Xigf6XMPKXOG4aBxaTJeKg+9eiTIMxS6jfWBaW/nW9VcZvlB6
 A+rAwJuR/JLweCJTbvZDYMLq2dnJsBpovgSp8TCEkAi0U/c7hDlOnQltWbUsiBoopb11
 zP0RafcCWdLMeUD6a2ERJHaLnR/eAnHolIR2ICOLk71nyi/pLLID51pKmEDBYJ8qwtus
 0DAGcW5iNCvdek5sKMWVGlfxiRSlyU0OlnIu7p+00hPUaVBVVDD0RxhERl9xhyuZBDrt lg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr9cn84d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 14:10:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43UD0IIn005193;
	Tue, 30 Apr 2024 14:10:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt7fpq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 14:10:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtNyS+TOaHuABkjcKZ8zAtiuYgKYjRtaw5rKzMhnISkGDFh1hFk0aTGXVm3fa/6EIthEkhnKViAMrE4ue5DD0ZB7TIXxceNdtKE23m+LsUaCNYV/tWj7k8xit09ZbtQWvZz/rx3M0+WImdCLzGujYiwRp2ujvw2GMpFPBFfWl0IkIL5qemIkFORAupNsPiWhm8LM5i1uDUKz77XYwKQ9IGCbVRPaH1OSQX+ZrjyegvIOEHfdNa+rSkEfyMzxbPJix9Q6cGj6rsNGDQc3yZNxzElocDKIj2ZkKXE9f1vHbV0yXfvjegYrJtQFz8Fqter8CF3ijzpDwDHvUfgonmg/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NQYd9fsBKqDl9dYu8mvQrqJM4+TY7TXQzAxx3P3+zg4=;
 b=knBatmN0U80WJrnl8wwKRJF2lioXYQ+j6KNxzCHTvuxoPHbY27da/3+2his21qCg1Apk4XOXR6FR9YEV9z2zpskcABLYmNZrYN9yWl7zFvd/nLNX3GHMJWNQMsso9I7ffjKcnHA3aUj+ZfsQI6m7Qxmq48YgIPtSNkevGgT1Qe3dj3Hxh6cTBmEs15GZSkBLl1PAmjnLI172yX8S8sI3ArU9WiueISZLBZvs4UqwEnHg2k5PzLVJ+8HamDtfhwyzRgJ9d9LUMe5sHmnmuoFYUI1oLXyu0gGsXx9RIabW9oaGH73x0HWOQKNAktCL+6Kr5gClxC+XTVf00wJc3ddN/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NQYd9fsBKqDl9dYu8mvQrqJM4+TY7TXQzAxx3P3+zg4=;
 b=HwErp3XJ4dFBrkB9ifDDmF1CnBJJvGhLZmUVCXkUgpBY+/oGV8nOabJqYj6QptJ6RNwgqUWfHK0BpWq7J/0n7zg7YWN8o6OLdSZMfHvgDKKlJJI3zVAi/v4u8+ClP1shTb7blLKbFWcPh9Cd32NSHcbSmggPdhBAx1N9d5KpZ3I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ2PR10MB7785.namprd10.prod.outlook.com (2603:10b6:a03:56b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 14:10:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 14:10:16 +0000
Message-ID: <ca4b3634-e6f7-407e-9cb5-c49f59772966@oracle.com>
Date: Tue, 30 Apr 2024 15:10:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: add a partscan sysfs attribute for disks
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Lennart Poettering <mzxreary@0pointer.de>, linux-block@vger.kernel.org
References: <20240429174901.1643909-1-hch@lst.de>
 <20240429174901.1643909-3-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240429174901.1643909-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0241.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ2PR10MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: f97edc29-b47e-4b8f-8adf-08dc691f4274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c2dWckhqYjFwZEdVNVdoN3RpNDB1S1o1TlVMSkw5RUx4cWV4MWorUUJ4b3Nk?=
 =?utf-8?B?cFIyUGI0MEhKNVhYTGVEdVZQaHdwSzBZRlR4Ui9FSjVEUWtxTEdoNHN0d0hD?=
 =?utf-8?B?aVlOOU9Gdnh4R2xVc0RyY01VV1dCK09KVzh4aDF4T3FrNHNVTC9GREZIK1Rh?=
 =?utf-8?B?UkVjdHRiRE0rRStTR1NJQ2VhZFZsRXd5dzcyL3NaT0F1YmV0YmJxdGtUR3A0?=
 =?utf-8?B?cjN3MTJuV3R6RUhwZk00TW9NcDJSMnhIdFQrUk4yaXdrUFhqUDcxRjdkeEtS?=
 =?utf-8?B?K3ZBQm9BZ1B6bGpxbWE2Rmtrb2Q4MWx5UStWRUNGbzZWWG0yczdLMThPbUt5?=
 =?utf-8?B?VHRDeE8wMFRhS05iM0RxcFVNd00rVHgzZVcvWFR6eDBIVE9wc0lGWW9tc3ZF?=
 =?utf-8?B?M3JZVWRSQng1bThFYVNBQXp5c1dnSStlYzh4SWlOd09oemg4R3hKenowVERs?=
 =?utf-8?B?WFpoNEpBT0NZVG1kTERBNkFEemZkb2RlYzlQZS9SZ0ZDcnJuZmxRV3FJa1Mz?=
 =?utf-8?B?NTVMazJycHB3UDY2WXVvdWZESzFhb0UzNWJXZFlzYVhSalNMVVRKcjJBWDlF?=
 =?utf-8?B?TmtlYk9aazdzU0hFQjdTOW5ORnpZN1JrTHlZK2h6QzQvck5FcWdlQlZlZkpD?=
 =?utf-8?B?SmFacUxvOVRKdEZtUUhvamExeTFZU1N6a3VENWlpUDFKSURnbTNSZ2ZLQ28v?=
 =?utf-8?B?eEYrQUNuQWEzaEtvbThCQ3p4ck05cmthQWVENFMzQjJldUo2NUVEbU9DUys0?=
 =?utf-8?B?SndQczlwRTlsRVEyU2pvMzNWdzExd1N1dVRITGJzeUNtZFY1eHl2YkVUS3VK?=
 =?utf-8?B?TldZMFdNUHFwYmFucnJhaHJoWGlZQWJNYmM5Q1FTREZYcis3UTI0SGpTUXR0?=
 =?utf-8?B?YVI2MnBBRmhsYm8xZHRHRzU5dGsxakhkc3ZzTU1lRC84Y2orc0JhdERHZkdF?=
 =?utf-8?B?c3BFeVF3bmpZQlQvS0JuNnF1TkRzM3BrSkptSG9NeHhLM1haUE1jejljQSs1?=
 =?utf-8?B?TjN3dXBXVWQyb0xlNlpZWEh1NnY4TnBXV29UTlppaFJGYmNYTVdUc1F1Q3Jp?=
 =?utf-8?B?NjV3cUJ5Y0h4SU9RTFVXNlF6Z0gxcDQwc09kc1UzbkJUdkZwL3UzSTJPS0Nk?=
 =?utf-8?B?bEFZbGpicjU0d3BkT09iRE1OeGMwVjJ6eThIam1kTmFPMFc2VHN0bnF2V0NG?=
 =?utf-8?B?UE4xWFRua3FMZ0thZGJOZjZ5aEQ5TE5zeWEyaXd3OUs2SkNCZnVESzZGQ3p2?=
 =?utf-8?B?bkgwSmpVZDF3Uis2dlZ4a2dtMHdqREMxS0t3ek1DN2ROOVVHNHJmamh2N3pl?=
 =?utf-8?B?Wi9nY3oraWxmZEhUbWZVVGN3Q3Y2K2FyKzkzRHhhbFlRdGlLZ0U3TW1jMVJi?=
 =?utf-8?B?NysxWGhPU3QvR0ZVM2VmOERRQ1MrN2k0ek8yRTVqS25tbjJnejBRWVNPNEpk?=
 =?utf-8?B?aEtIeXlUN2ZDbENpMUdxTzB4MEpPRWZHSzV2YWM0Z05MS2VFOHFWMVJyUUh4?=
 =?utf-8?B?VUdqYVNEdUMwRVkrcUJrTUpyQktjcTNPdlpGQmRJQ1AyaVFrWVZpVGtzRG9K?=
 =?utf-8?B?eHpRbHZTR1JiTm9hZUNEWEZ2SnRERHQ3LzJHeHZnbWRkUC9ZUDNaaUo1Z3hJ?=
 =?utf-8?B?dGxHbFpzeHh1N0JJYmZ6c2c1and6cTBpVFhCNTdJRnBzUlU5MGRsRU5aU0lr?=
 =?utf-8?B?Vjl3b2JhMUV3Yy95aStJR2d1bCtUQ3ZmdU1hNFdwNUxIK2NDcmt6NC9nPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M1I0eTd2OTd2UnlIek5waWZtbmFUS05KRkdzREdGZnI5Rnpqb09mNFFRRkQ4?=
 =?utf-8?B?NmZTR1RhV2tHd0QzYVJQTkpvRVIrSnkxekJ6c1BnNWc5bmtHTzF4RUhLMy9h?=
 =?utf-8?B?MDNWWkx4c3JSS1VGYU1LZTh1RllXb3A3czlzZ1dTVGFpZjJEa0lpUVNWOU9U?=
 =?utf-8?B?U2hFZThYS2dnaGx1aXVlUVBqWHRxalVJSjAwbGxIVUwwNnJYMWxoamhQNDgy?=
 =?utf-8?B?WVc4cGFVeHRTVW5pNkk5Sk1BQjRUdm9pV2VsWGk1dnQzWEsvWk1ZeHV3aXIr?=
 =?utf-8?B?WUxpRHF4a3l0OGM1Zkp4UmtYbTJXRW8wYXZOWGZrVEo2eDJwcFdnTVppY2NK?=
 =?utf-8?B?ZTJpSitVSytBMnAzMGpUbWs5T3dnZ0FwU2JuL04wYXlJN2c3SHVWbExCaFd2?=
 =?utf-8?B?TTNPL1JRNmwxZ2pQck5nMnJTMzZXVFpYQ3lCZW14TlhITlljdGppQi9TeE5E?=
 =?utf-8?B?eGhEeE54eHgwOFo4eGFETVVodnhONWZMWW9ZOXc3c3JDVjhwRnk2Q1JubE1k?=
 =?utf-8?B?eENmSEZTMVpWbWs1UEMyemVDeHBtc0tQUVBDSC80OGpPc1AyOVoxVUNjY25E?=
 =?utf-8?B?WGxOT09Yajk4eXVBRTFUSjVLYlB6b1N3b2xjNFZYbmRYQTJJQVcwS3YyN2hz?=
 =?utf-8?B?Yk9hU1BlWTE1SkVyY3FhdUViWklUenQxdzFid3dMVUdDdUd6R3VTUGp4a09t?=
 =?utf-8?B?eGU2bzBsSVB5TTZuOURySkVnSWFXZHl6Qk16bXJIZnZ3eDR5cUltQ0ZldEtO?=
 =?utf-8?B?WTNJL3Z5RThDZmFtc0xGR3krVUlwZHNSMnFnSG84bEFtblkyak5GTkkzOFZS?=
 =?utf-8?B?dlMvSlFPenNXU1o3ZEZJUmg3eVRlUklHUHoreDcvNEhnK2tycHFFUlF3NWJK?=
 =?utf-8?B?S0MzWmRzNEU3U3dUMHpYeUk3elpYakx6cEtOaXQ5d05YK3o0QnU0V2RuZlpT?=
 =?utf-8?B?cUhkVnhUUnlkTERXRFlYM2FTVEFKMW1WMzdPbXRUTisrWkFnWGE1ek1LVXB0?=
 =?utf-8?B?bTNOWGpHZHFaMjNuVExqanhIR3NMamxLMENZcDdjYlB2Z2RCbldXRnBoSGlv?=
 =?utf-8?B?OC9BWGczTnhjNlRxTjVzYWFRb0Jjd2xEckkvTjM3eURaN3Z4aWZqRUtLd05r?=
 =?utf-8?B?T05rNmM4VG9YZS9YaXRkTkR3cWJjNytiMjdJdmV4TkdJNlNkN2FySkFCaWdX?=
 =?utf-8?B?RXJ3RkNVQ2J1UzM0bVRVcENMamtENXkxQkNHd2I0M0NBMmp0UVhFUGpyb0d6?=
 =?utf-8?B?QzY1ckNseis3N1g4bmlSa0g5bkkybHQ4Q1g3U1dpU3VDby9QVkhVbEZFMkJr?=
 =?utf-8?B?bHJTNzFZSklManVyRTFRaUNKU0N4WkYyMzBSc0ZROXFBQmxnWlV1RUk3Q0xQ?=
 =?utf-8?B?bkp1a1RydjhyNi8wN01yaHVSWWc1MDdXcm5vU3BXakxCb0FneGVoYjJRUFZo?=
 =?utf-8?B?OGxxU3Zqb0tQUVQveVB3amp4bmdHcm80MUE3a05qT0I0SEdFVHZodEp2bGU4?=
 =?utf-8?B?R1djSGh6M3JVWVE3WkdJV3NteGUwZ0pnNm9TVlhzMGp6cEdDb3l4WElzMUFF?=
 =?utf-8?B?YTlLN0w5OGN4WTBjUWd0NzlEUTNCU3NjMDM0ck11WXl1VGdGeVNTZnp3c2lI?=
 =?utf-8?B?Unl1UkFuK2tRSkpZdGt3YzhwS1ZQRmxWMWVJeWtvRE1xM2drYU12RGxnTHBV?=
 =?utf-8?B?NWFseXRFZWpnQVl5Z28wUkJsZ0d4ZkFYSmxCSys5SWlYbkplb0tDRzN1Y05E?=
 =?utf-8?B?ZGdiR1RVNVo1UzdtcElpWTFNT2ZsbVBEL3k3R2FKM2F6dFZocHJHTWUrbUx0?=
 =?utf-8?B?WVZ3YTVRYmRjZ1A2cGswdElLMnRXbG5sakZsb3R4dHh2UXZiTE94ZE1WWno0?=
 =?utf-8?B?NzJGaXNOWnhSWG5SRVV5QjlBT25vbXBFWDNpblM0L3piQnhBV1h3TUhxUU9L?=
 =?utf-8?B?RzZIMnFoZFpmWHhINEJ1VHdGWUpUUGlYVWsraVRldVJXT2lDTVBwMDZUQkdr?=
 =?utf-8?B?LzF6NmduNDFVNzR2NjF2MENOWXRzTTlXelMyS3VoaEdLNzh1cDh5NWR6WTJI?=
 =?utf-8?B?L1dSMTdMMHVqK0ZDVGtpdklZNmZPU0NkWEFZV2h3RjRqdXhURkVjWHNXdGFD?=
 =?utf-8?B?OUlQWjhUL3dRT3hLakFRck1yeUlXT1JZUjFqNTlRdWovNTZOY21pMWFjT0V6?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5yy51kS2qd0CraJFWjKVY+XVgUqSjA8CkkGlKtNjucVPxVjhvRS211vCqDGhDFQ8VFLiDZp/R3YZmL1MPLLCrBru1UZJhlByuWvmz7WzjN1nlTDUoURiriC/9DcAbaHDIQ+uMHCoWrrchmxfr0z3Oil5npMH1Sjo/E5sm1mxYnaK3O2FrASRFIttH8WibjQCNPqu4z03kZiAl9l6g3gDdkz14D0I5Kg3+HGBeqKzc2GGji8FT+GIDk7UpGAiafl2lAiPMUFekG4OReoRpzdjx/pPuM82ebIXDnTlLbt30famXsQawz1PwyTXhjb6pmBJ92ARHI/T1UbIPHa+F0Ogj1JiS9OkPAeBftQe6QbCU8EU7fiKxWuOPRZ+NQ3A2xQVyjL1GFnpmEFcbkUVAi+wlYoipYI6ivSsf/sWkDKdOu4EGn/GuEErccnCXMUDiksg4UJqFtuVS9FRUd5/pkdJ9+tvgKOG0lgZ+gr3KwbDT8f9I6BP2A5o4xMmvK/Lr6Unryo5prZq+xs8RoWvZX1CkHg/6sHbLCkRPlKRUUii/CuQq3HcJCoLyXZnkIzHI5xT70hdBFKGb1TBXddNr0CC2wQNh5r4yxDBgAS+yvjyV8M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97edc29-b47e-4b8f-8adf-08dc691f4274
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 14:10:16.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWo877DCpv95OdAEnmzVLBRu1OmbzGHv7YkcwxCZ7i21g4NhIEbTYJFHXd6eiJx/WiAQ25PqbWGwAiampvUFtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=930 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404300100
X-Proofpoint-GUID: fCCU4sMvE6RgXC7FYJssq795xctGeGVr
X-Proofpoint-ORIG-GUID: fCCU4sMvE6RgXC7FYJssq795xctGeGVr

On 29/04/2024 18:49, Christoph Hellwig wrote:
> +Date:		Atorl 2024

I suppose that this needs to be fixed.. or become May.
