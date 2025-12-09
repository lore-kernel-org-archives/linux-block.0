Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417FD24BBE4
	for <linux-block@vger.kernel.org>; Tue,  9 Dec 2025 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765268792; cv=fail; b=QY3kQIRrcADihB7V7t/121xOEbhmejWXNsguQQn9aanQPikOw60v1PNgHZJVAGe8lRCZuUBMYJYR/Tt8o0wKZP59wN0eT1aocUPlCcKBO3RFmRejkadQylP7TEZ57tTCgxyavJEuMBAA7Tw2IttkJiHzJTNJb7H/hLLk8tonrTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765268792; c=relaxed/simple;
	bh=vKHLoLuHBB0hFX7MQoNYQ6EK6yl4CKVVGagt8OgRxf0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k5mD+QN5WHpc0zOaBJNiFX6URo4AU7gUPGKmKH8ISG/8+/pDn+bTBrlsjhidQt929Hcp193I+eZLIYhKSTiiGfSqKhfwd6vepbP66H8sCm1X4cOvd6qjuF9X4DxUgMWEQmijLdKTL1QRobtC0KZxjozkiDegNrRo2e7VfEfgpLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IawcLA6o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V6h7Un1A; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IawcLA6o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V6h7Un1A"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B97g1bc245705;
	Tue, 9 Dec 2025 08:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=K9ffPdUQyRyWar3yGAbxY2ZCUv08J1ICbfgJ6TAfYo8=; b=
	IawcLA6oEmovg9URMvNySIdneAFVxAxwfzHEl2UuW5Htb/XGNM2SEV1UumenCH5q
	uQEZSy+mLtMU9L4GmBjXLOiI3z4+a7gkyqj7+wYwkM4sKajWxN6oJMtgIQfqe6AH
	PyyQjkiQwqvaiX0rTm8rwCv4D4Fko2PFv3Sut0AL1NZ911ZUQ1x8agRSnwwqGf3v
	e6vyFuHx0hFDViKvmEMGnrkJYfTWX8iA/gmE273ePlWSja+Gkyt/MGQRa7+r5Ade
	/HVN+HYr283DFOZETxLxGs1CwjOQP0Kmhrw6jlv1mx37XcsuIPR21YSC4l4hVTkz
	uOzWJYR8Yb6pITQKJeOrbQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4axf9hr2bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Dec 2025 08:26:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B98IYpL040225;
	Tue, 9 Dec 2025 08:26:05 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4avaxjj8ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Dec 2025 08:26:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2sBOL0mwDZrxiwGlR+w7g8AkU2qKQ3YC8lj6LyZ6VIuuADAj6Ws3EBfv2CaPitXAeKqP3McKKDQah/2s0jVhEchMeZ8osmNGLpvLDQOeeHdK8UtRliO8d3MxoL1PtNqdThyb5cwXq59IEEbocxazQwxMsyXyRg5x9+5jZR49VoJq4H+KPRIv/D5LFw8eeJHAS0F9UoOz3+O6QBgFORiChbG1qp1dENZNcGB3bzgQwTi8On7LuetPvKsJkvO8kYQKhy0f+fVPnLXk57EWC8+iNxVKFxfGTceVqjICZd2H+RSTTX/7+JxSkE+JcoHWJOQNBYmpwOXLBznyzyvB+3w1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9ffPdUQyRyWar3yGAbxY2ZCUv08J1ICbfgJ6TAfYo8=;
 b=YkHlzhxutcukHOQ9ZTtcCNUz25g1Me8q1ppOkbB4MDkoKOFAH+2bNeMvEEmLQqfxrI9/BpXNCfOxKPhTV6VZRkpigoNhUYEU+cVMwONSRlFyfwfVzF3JBUb/wDNQg+UiQ3xyyQHSBVGA/yvFRSLgHBWVaegd0yELZ+N+jj6MbgZKpyMhfURXMK3qQlr+4wORXBmkYubduIzNATEKsxT/CCXZ4ex6lf2jJ8TYM6qFxAa6lBkxBjGmnHXRKM8geRjovCd0tUZvOVoepHvlo8qpWYoAyJGGKumdmlpoFHDYU7H8uWbgNKqRgGYzIhoqdXXR3l9TB8vc4O22ScR+Gy7/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9ffPdUQyRyWar3yGAbxY2ZCUv08J1ICbfgJ6TAfYo8=;
 b=V6h7Un1AZI7cRzdjI4tWy8PhagDTfufJzL2IAjWG1z5dWLFgVf8e82iwsI4i7/0A5GL0m9R8uQkZfKJswyD6BCtxpS2RV72PJJ7lJezwgKMQN4z+cCpXlozeqYPrBbBfFKR55uWrMUJPvUBUGU7YV5fdPd2l5WUMe5ukgyUnJ/U=
Received: from IA4PR10MB8729.namprd10.prod.outlook.com (2603:10b6:208:56b::14)
 by DS0PR10MB8102.namprd10.prod.outlook.com (2603:10b6:8:202::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 08:26:03 +0000
Received: from IA4PR10MB8729.namprd10.prod.outlook.com
 ([fe80::1779:493f:b5d:395a]) by IA4PR10MB8729.namprd10.prod.outlook.com
 ([fe80::1779:493f:b5d:395a%3]) with mapi id 15.20.9366.012; Tue, 9 Dec 2025
 08:26:03 +0000
Message-ID: <d2ce6a5d-f6e4-441c-957c-fefc33f3758d@oracle.com>
Date: Tue, 9 Dec 2025 08:26:01 +0000
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
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <4023a0ad-ef60-4307-aca6-514ee790d6c6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0461.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::16) To IA4PR10MB8729.namprd10.prod.outlook.com
 (2603:10b6:208:56b::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA4PR10MB8729:EE_|DS0PR10MB8102:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d06715a-b35d-49b0-df72-08de36fc9745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0pJM3ZVT3VwY3M4cXBaTHc5UGlJRXV6NzZPS1MvTC9IYWRWVGsvMFhGSUZV?=
 =?utf-8?B?blE5MEFsMkMyTDNnb0UzLzNONlhhVDZjdS9IWVg2djNrQjZqYkhqNGl0REpx?=
 =?utf-8?B?c1Z5R2tvR3d0SllrT25kNFNDc241YjZqNkQ0ZnAyY05yUmRYQXFFczBEaGlV?=
 =?utf-8?B?ckhweDh5empXaGJXV0QrNkhCYzhqRGtBMTJaV2pnZUtpUkVMMzNtU1QwditX?=
 =?utf-8?B?ajRDZisyeWtSaUlscmRmb0srOFQyUDhkWHhaT2lrMGNRWTVuR3piUkI0NFd2?=
 =?utf-8?B?TzVCK1RFRzZzeHJaTU5lTGpTUmY5T1J0STYwcUkxdlBzSzMwQ0ZRKy9Xb3VI?=
 =?utf-8?B?eUU1dTZ5dUtaQ1ZsaS8zbW55R1Z3UmhEL1gyVXRvaExkZlM1THJudnYwOWp1?=
 =?utf-8?B?ajRwTWN5ZWlVRjNFTE9YMTA5dFcvME82UEMvU0hNWTJoUlJ3SkZ2bzNGRnZ4?=
 =?utf-8?B?WU1kMlBLY1dlTGxXQktQWU5kVC9VTldlN25acHlDay80NGMxNjFaTENCNkll?=
 =?utf-8?B?L1BUeEJpWXRyZzl6b1RiZXBHR3pKU0NnUWY0cWNxOVk0dTFIU0JxV2RlSzUx?=
 =?utf-8?B?SFVYK3I5dzBpRU45NjJjQ251ZUMyaTBpNWZwc05BeUNvOTZoNWhNK2Q3RDUr?=
 =?utf-8?B?Z3pYUzNkaTV4clEzdWduSGFWUWg2RENZenJUbG01SktYYWo0NmtvN2Fqcklr?=
 =?utf-8?B?WllnaEtyeHVVTEhiTTEzR2lBS3lhVy9FSmtTQXJWRCs5cDNocDRrd2dMenl1?=
 =?utf-8?B?ZDRxRE45VVk0RGJVRDJSR0xUenJyY3d2ckRKSlE4RHZDbkpld2VCNzVOanZt?=
 =?utf-8?B?dVVBVUY2VTE4bDUxbkFmZjZMUFlmSk40cktTaSszempkajFYRGQ3THhxL29k?=
 =?utf-8?B?c2owS1JSZWVZamtjam04VEVrb2dHc1Jkcy9yU3haOTVtVWVJcFpsM1ltaHZY?=
 =?utf-8?B?QmV5N0ZJTWl6VTRQMytUbC9FOE5TYXJXamZXSXlNNXZVZGVFTmphRnNTZWFQ?=
 =?utf-8?B?ZHI2NlpGRnQydkUvV3lzK0hzSlFrV0lZQXZOaDY5UHpQeEI5eFRGL0VNdUJv?=
 =?utf-8?B?WnZ6MUFhTXNrcGlHR1JlTVNUUUNyc3pNQktVazRQWG1RbXVmWlgxbEpCdVp6?=
 =?utf-8?B?aGtFYkxQYnE3M1NZaVhLc1M3eXAvb2J0c1NzTnVOR2IrajI0UEpNLzJaOGxy?=
 =?utf-8?B?QW5pTTJPYmV2M2l1Nk54STBCMVB2WXF4aTl0RDFXZ2lmcHRUMFE0MzZib0FE?=
 =?utf-8?B?d3drTG10UWNHNGF4amtRNFE2Q0R4OThtaS9GQWx4SjdDRXZ1UFkwbkdhVHp6?=
 =?utf-8?B?MDBBRDZTQ0ZxNENxU3dtb1ZLWHdzS2tBdWo0NW4yZ29PeVJub0c4MmNsa1V1?=
 =?utf-8?B?bDhFTFVLU1EvbXllZFduUlpkR2RqNk9IMnZMdklFK0EyZTZkWjFYL1hUQmRZ?=
 =?utf-8?B?Uk9qbFE0d2E2ekV5SzVRMVdGMnRlSTNYY1UzM240bldPNEQrTUJ3K0kwMnpq?=
 =?utf-8?B?RkxTRWh1eGRyQlRlbG0vS20wRE5raEp6eUJCRjNJNDFVMjQzWEFvUlQ4eEhm?=
 =?utf-8?B?ektyODNmK1Z6WW9kMjE5c1J3TlNRSFdHeDF3NDV3OEtGcndsZWVOQzc5Ri9F?=
 =?utf-8?B?SEw1Um1ZVHJHU2YybXFvUUp4K1V3akFmMExjQ0J4Z1hEY0YwTFhQZHR5NHd2?=
 =?utf-8?B?c25LSVdKY2ZGRG9XZklxbDZzWllEMXFCY2hyY2RsNVRScE9Zb0RlL2IrQUtS?=
 =?utf-8?B?YWNsaU9Ga2R6cWhLT3JQV0NuakR1ajU0LzQ2dzRBN1ZKOHcrTmcxUktzd1VD?=
 =?utf-8?B?MUNpMFVaUkV6WjJHeDdnSHBtRHpmY29CR3NLdUQ2ZnIwcHlPd0U4MDdpcDVE?=
 =?utf-8?B?NklPSGFGTlkwckJDNVkzWUhLampMZVVaUFcyS1YwUHZtT0ltdm5UK3NNR0lx?=
 =?utf-8?Q?Yx4P4xHpbm5iYT+wHkL+AAR5evd3YX+s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA4PR10MB8729.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWRWNnBsNWlpdjcreU9FeGMvOHJlOFFpUjZhcU1vdEVWUWVGc1ZNS0JkVGlo?=
 =?utf-8?B?NmRlQTBLUXROV2c5ZU1FckovbVZNZk9Cb2NNdE1URGpkTnVPMTdtOUs0ZlNn?=
 =?utf-8?B?WlJFb2hLVEQ3QUVzbzdBN3YvYTRocngzT3VHWTBYWnVZQXEyc2QxSnNObTYx?=
 =?utf-8?B?UGhTREhHQlhlYVU1RldYaWpNZVUrTUVTdk9yWlBmM2pIQmFlYnNTZTB1c1RF?=
 =?utf-8?B?TzYwYnFOa1kyaGFiZDQ0VlhCR0p4U1FzbzA3RnZzRlVWeWllWEVJaXlFeUI2?=
 =?utf-8?B?K0QvVDc5RU9Tc2ZhSFZoN3JpWTVQaE5iUlZDdHlBdEVZTzJ2NS80d0JrM2dl?=
 =?utf-8?B?dXF0U1d6Si9ya0I3aVVReUJZbithTjRxR21Kck5HLzlJYno1Q1VDMEp6RWNH?=
 =?utf-8?B?LzB3dXlUZkhHS3BOT3N1QUdvSURxdGo0QVFDWjJvN0hic3hqRWhJb1dWWk1E?=
 =?utf-8?B?N0FPenJIajJ1MGtNNkRNQnBOZkZSLzdnRHpaK25uWVdVSU9WT1NyNGxFZVgz?=
 =?utf-8?B?VFIvR05vMDUybnJJanUybWJPYmlKNFB5clRwa2JrUVJMcnhFTERXbzlDdWFV?=
 =?utf-8?B?ODl4UTNkL0RmSDhBNzhBU1Z6ai81aVRNbGdRU05wNk9oemdwUTVxUHFFRmh3?=
 =?utf-8?B?TG1XcnlZcVIyVWUrUlg3NWRqRUZ2L3ZjK3ZoZWZsSWJUMFpJU2hqYS9DU0Zr?=
 =?utf-8?B?YkhlZXpVWCtwSld6VTd4OVhiRWxjRkRhZGNsZkFNRDRxZE9TeGhhLzBVMUty?=
 =?utf-8?B?MElaVExiUWRmV2diZVdaRm9SdEk3Yll4enlKdm9sVXpQQ3hoNHhTUXo0V3Y1?=
 =?utf-8?B?VmlaUENWVGR6eVBkTjczOWh2aVFTUC9wSWpMUXdhOVB2RWRaeEZOVHhTTWxY?=
 =?utf-8?B?bHRGeE5sZ1RmbmlJaklXNWhXc2tLbUJ3aE15ektFNk5xbnplcmxrOHU5NDNp?=
 =?utf-8?B?WUJ2RjVXazJYS1c3Z1AwckhKMzc5SDBkVk9LbFRJL1dCcnRWZkFsRUQ3Yit1?=
 =?utf-8?B?eC9pZGZtSWoxYlpYZDl2MU9uZUx3WW45aDZoK3drU2Z0OWZaNVU2KzYxVWgz?=
 =?utf-8?B?TGVFUmx5dFhMQjhlZ1A4VzJWNUg3QmhEOCtibnZxWDNhOW9VOFFVeFJaOVdI?=
 =?utf-8?B?d3FWMElUSFpsZGxVcUcxNENrZ2wySEtOQmNWUk5DTHhJcjFPTHUrY1JtTTVs?=
 =?utf-8?B?MWtSaFdlSkJsNHo1MkU2cWxueWw1ZTcrMWE2RHFOTittWG02ZzFJbm1WdlBL?=
 =?utf-8?B?cXMzMGE0ZHloMXhPMi9Bd1BBVFkzUmhSNERjOUEwZEJGd2VOeEV1ODB4VHdU?=
 =?utf-8?B?YVhrYW9yTXZrM2VaazJHSzdWUmQrTmQ4dEdJczZ1dDBGU0lpNjkxN3dGeFd2?=
 =?utf-8?B?Z2NwL1dBa3U3UDZrcTdsMFJuUklvdUdZajRSbHRUaVJYTDJ5c201VU81R3Q3?=
 =?utf-8?B?RVJVc0MrbHFzQjUzT28xTG9ROVRoYWhRY1dONnlCem5MZFdMQjZMOVhFeXk0?=
 =?utf-8?B?UER2aTd1bGFwVll5dTdocFEvQWY3VkU3V25DN2trNTRpUzZQeTFFMUY0RDdK?=
 =?utf-8?B?OUZQZjUyZ0pLVXR2YVpiZXpHQlBZU1lTR3lsdWNkTGpKamJpNTR2eVF5L0p5?=
 =?utf-8?B?U0hzbmNpeUdBdG5lWElRY0RiTFhSSlZQblBsUWhNbjMvSVI0OWdmbDRGa3Z1?=
 =?utf-8?B?Yzh0RmwwK2YyVDYyZjhKZjMrNHNWWHlTU0NRdWNqQ2N2NVYzZTVRTy9Fcms5?=
 =?utf-8?B?ZzdkM1lHQ2RWeDZVKzFtNlV4NU5nWHJsaHFBQkZ5OGh4NGM0WEJoUUlSUmU5?=
 =?utf-8?B?Nmo2NjNlbGFGQ3ZZbDgwd25Cd3BmOUVPbkFBS2NwVFZxR2hjbG9tSGxjYzRN?=
 =?utf-8?B?M095ek5Mc0tkTlhNUmhCdHB4K1hhcWZwOURySXNRQ0hSZmtoYnRPUFpocnJK?=
 =?utf-8?B?NnNDU2tNMUF5bmIxTVNMcS9oUWZpRWVNU05QcXpHdWJMMEFacFZiSU5ZSysr?=
 =?utf-8?B?N2cwdFp2NHNrYW1LaWRUTm05M2xtUDZFbE5YMVJDU3NZZjhYOEx1emhnK1Y1?=
 =?utf-8?B?Z3JPY2VmbUVtQ3R4em53RnRUL2ZwT0t5LytnTkRtSWJjZEZhNE12K2ZrL0Fw?=
 =?utf-8?Q?4Y2UlqHmrIEZkYWMF8OjsGg1l?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eFrZmbS/uT5JpciNwk5ghKiBQyrs+93HFJ35LVH2CgSRM++5IGp4YwjDRhcitmd91Pl2FRj+iJkrh+fc4cVAqNHfZ12fERPPhturfa5yqLfYtgfOwR0e5s+sNlkhOcU1ADqarARgr633r5v9fIdjs9fZ0Z+ibrpvlceKD9G2fHQwLRkNDmFnr59fp+Eip2ARsUTsHCGMUS+sZ3wWba0lguP+1g21487gYD/MOTksFJ9C/yULlXBGa/EHQhxstojQk1UR6OghErxHYduLshOPZcjreij753EOqNeSJOIu17HTwUeUGWYXbGm7dkDW9C7SOJLQttFLS0VoiBsffKMtgesupcn87/jKGwgcPtfZcbtLjblHhuXJztdJpHHuPrew/nB7dIB0ULvzw0HugSRDNuTAbl9tI1HWEyEdVL4pMgvhRnrEyCETrqypEZI2Rx5VPLfa+42J9VRVMpSV1TE+w+31vusTY6bdN8zLHlvPpLrs01GrVbmjRc6D6SDVLcf8MMxQYwNjrPbakBh09hNU6GfcgiBt65sc6WnLKQeeh64TAaBQpe6qhNHoK3Vz0mYYkVMqxBkIlyM7TlwEHGBDekh+9lMvbQ4cmwKUNdQzvGM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d06715a-b35d-49b0-df72-08de36fc9745
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8729.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 08:26:03.3301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONUvdS2nyjgipSYiiwT2VmVwxyHpFyTLLJ8Bl0DznEFK32r3UBVqpSX2P83Mhu/zJbHULYsUtRcrvSWuvrnWrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8102
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_01,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512090060
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDA2MCBTYWx0ZWRfX1yGMCgq2Kdft
 ggafqNytzNMw43mSD6gS1+l+QX6ZrYM+65BNkxEHtGBRrS0uUBI6FQ+t+PCl7QNf1I7fs5RAvn/
 l58zwWiGgXmZB3V9m1uL+pIaCUu2QsxwOToyCmvalcQhrwgZw7EZJ3j3v16T8CwyKyVSuafpssS
 YV94wkABxaBuaty/p/Nq0jmP+xiSEf+1I01rxmkCGOLCM8eZIF4c9Mct7CBVymWqmuMfxA46yWD
 rl8YY8b08gnotbiiogN02vB2m1CQn9bwmOsJv3aukD71ExuQRxfUVICQxwsZGM8KO1JDikfVnw6
 YRrdQLnLiFFVzX9M6k0+cOqXEc3ZMzGuJmC3u6HnyUB6M2R1ktKkbMJ2KYI2Kzsaclvx9nc3EO5
 HXNAiF3y0XEtP3oRcF5Nn5nuA/qyKTdqAC3migN6kXlh5wyRKiQ=
X-Authority-Analysis: v=2.4 cv=GMkF0+NK c=1 sm=1 tr=0 ts=6937dd1e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=I5r0CxplrSDLCy34:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RDetRKujpk2TfiE0F94A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: 8a3kfAp99P2T_nCdieVBnFOaImRtJBXS
X-Proofpoint-GUID: 8a3kfAp99P2T_nCdieVBnFOaImRtJBXS

On 08/12/2025 12:11, Nilay Shroff wrote:
>>> Do you think that you could check with the OEM for updated firmware (that reports NAWUPF)?
>> Yes, certainly — we can check with the disk vendor for updated firmware that correctly reports
>> NAWUPF. I’ve already discussed this with my manager, and he’ll arrange a call with the vendor
>> so that I can directly explain the issue and what we want from the kernel perspective.
>> I’ll follow up with you once I’ve spoken to the vendor.
>>
> Just an update...
> 
> We met with the vendor team and explained the current situation regarding atomic
> writes and the NVMe Linux kernel driver. I’m happy to report that they acknowledged
> the issue and agreed to provide updated firmware that advertises atomic write support
> using NAWUPF instead of AWUPF.
> 
> We shall first receive a test firmware build with this change. Once our test team
> verifies that it behaves as expected, the vendor will proceed with a formal firmware
> release. I’ll keep you posted once we receive the updated firmware.

Thanks for the update. It's good to know that this vendor will provide 
the required FW update.

Cheers
