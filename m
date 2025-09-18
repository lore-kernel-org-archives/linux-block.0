Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703E22E8DF3
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180819; cv=fail; b=VojVKGrZo8Fi82PkKO9EHl+WjZ9ExdHi50jCHGdvMuBjIhYMn5ZwZamh/pndljzgaUKUK/uH9R96XMw6uI481zjWSZ3rxy7YMa0esnjaXT0YPOrAQJgShP1436GP4NmA4QSTq5vL8qwyuAaURf+VQoqYvyn+8yOwpWGd1VYtU6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180819; c=relaxed/simple;
	bh=YFF1DGuTDOG+p/A5PqIBDac7Zp7V+oE1/PnNFhq+4+M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HJWAut3OlDkrPfjFNmg0gMddMov5O7QWGUSMZJj0zSSKuUOET/FVwO2BWAGPa2iPbTdndWIGkM/957ImnA5Hr9n3cQZwrLUZLkM4Bp8A4oPV9MF2VrvJ4iOwhj1Nfs9FAaup5JH8o6iFt+ZqGiPrOJ4CUm2vVwRdSmDrn3IZ8yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kn+X2Jzi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NhmmJlPl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kn+X2Jzi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NhmmJlPl"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HMmYG1001802;
	Thu, 18 Sep 2025 07:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4BfwHSqtz1/wTlpyQzzvKYoYnswp6F+lrQP7mM58mCQ=; b=
	kn+X2JziqE8hncpmRKVAEhQYuiUrn+RM9A/I8XfG7EaXlqaJVEGU4sdZ4MZLRhW9
	vWXTuIQ3Zm0W//skKlsN6y28G2mUL+DlNjYR+l2BExsG9CnN1GKcUBWQz6xRuoBy
	OqdHwvVjBL39KxiDwbj12Q4lb1yRZJecsvT5gTlDueJhfrdNE6oDnWDaVg083CFn
	UUaffxJ5/G3TwvS0HwciO0BcD3MvgLuzGJIN2ve7AYG5pN9Ne5lM3z2ITFSUfh0K
	DD7BWIFctZ/CuHBkGUwnaAkmsGDq38Zds+FnICgiBtvPaSX1UNrqwIiE+eYAIq/H
	3pyBfUtUox8YZBlcCAY+lg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd2ug9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 07:33:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58I5x1hc036754;
	Thu, 18 Sep 2025 07:33:35 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011032.outbound.protection.outlook.com [52.101.57.32])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2estb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 07:33:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3d5BryOn7h/k2peiniBRbyPFc3LmlMtDhwnu0778E7SEeMgSDxMHMgjsbGB9joEl56TElATicZHe+qTK0/2JRNv64gC1750yxLNnjA9Tcblzw2Xim2OnN56s3AkcSBUIqx5WcY09BMHz26N/yDBcpRl0OwJrdKvpKt8/j0QFtkY/LCiTyUJBlgLLnLx4FDuqoCCYL9FaHjVHvuINtdKveDVlDm6KxGp2yJ6L251AR6lnB4VNS437s/RWYcJVwQ4lXEohkakCd8OSzPsV3DzDN18sRILiP1DP3vD4gyS2pG8BYLAmOfhw1GeL7oVbxDAXkO708izNDOirU8C88UMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BfwHSqtz1/wTlpyQzzvKYoYnswp6F+lrQP7mM58mCQ=;
 b=MEijCAC9xLcYaCxSnHXIhzPTEU9dTATARFuKC19hbxQ/q5VD4GPoEQ6E5GpktzWbJJaB5kride733Hcr8NTS1kKH0jRYR85PZurSrd0Ra4gRkkAqnWkgNNSGuS1RK0edJCEYg9CBbKDEuG71eRtY48P8B02u3MtKsr2qnq9othNI4Db9tKnRn5Ixf0U39g5Zm4OxwOSGUgVUqt0TrucXIhckrnYIJX0xxEWZPH+O3HuJBvnyyDVG7pN4H8xq8M1tseFhw0jX+djlM+MihPTlesnRg5aVOQAWwn8Tc8uABztawkY88I+RrzZp1aicGD5bYx+9T5rBvkObIXQxOJynEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BfwHSqtz1/wTlpyQzzvKYoYnswp6F+lrQP7mM58mCQ=;
 b=NhmmJlPlPqUo1VyrS2Rskx8dvKfLHG3rFX8wfaJ4QnBxkFMuqHYuIZEWuZCVytwYajDfPiCt6p4r5wbXDxzFj9BdVvTa2InZN+gYrXj1QvNPjQTnLb4r14BiMgC65FekFVZehs/aHhjxxP1Plgm+CBBL2Si5bfTDapFgqqfyFNA=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by PH7PR10MB7720.namprd10.prod.outlook.com (2603:10b6:510:2fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 07:33:33 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 07:33:33 +0000
Message-ID: <2b4522f2-03e4-44a5-aaa6-2814fd0f99f3@oracle.com>
Date: Thu, 18 Sep 2025 08:33:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 1/7] common/rc: add _min()
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
 <20250912095729.2281934-2-john.g.garry@oracle.com>
 <3vajuldrx4svsmh2nabii56psc6kepncrino44gvycj3ekkufn@e2blebamxl5l>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <3vajuldrx4svsmh2nabii56psc6kepncrino44gvycj3ekkufn@e2blebamxl5l>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0148.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::12) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|PH7PR10MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 235cfb4b-ea6a-46de-d671-08ddf685ab75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzNoTmhlZmkxRjIyZ2tXNHd5QXkzU2hQKy8rRFcvY01Fb0VEQkpKYTlxS2xE?=
 =?utf-8?B?QjUrUkQzS1ZMOEZXMVhERFlZcGIvSk80bkNXOGdXaWF3L28zVDVtRkRNUnBV?=
 =?utf-8?B?U0w5Qk85bk1VRmFIUjZUdjJNS0Q2TTNhZjYzRXdoRU1ZWm9mQXUyeDJIM21h?=
 =?utf-8?B?NUVLMERzd2tyNDJ4OGJrOVBHNlNqcVNibDJqSUt5Q0JReVNSKzBEMmtvdTdZ?=
 =?utf-8?B?R1ZZclBBSDlVSWlHMjF0eS9UK0tTRThqNWxNRElJZVR0SEU4d3BTN0M4UDJG?=
 =?utf-8?B?RVI5a2F5YzhVRURpdWNnQ250dVB5ZnRpR2VvcnIveEU2aXY3MTNLZ2ZYTjVp?=
 =?utf-8?B?NEgxeldBM1Z0d3IzVWFpNWtUVmlDbVBTOGR0Rk1xZE5nWEhvbnNzS2R3VFVm?=
 =?utf-8?B?TzRiRGZQY2RPa3NsS2NSTHpMVXpId0IyNDNCRUZmcmNRU2NRdWdMeVlxM3F2?=
 =?utf-8?B?UG95S2pkNWt2VUV1WnlTeUFROElXK1RhUDRkSU5qblhhNEdSTy9SSmh5dkhL?=
 =?utf-8?B?YXQ5NVFWdU41YkhneVRxM05GRzI5MnNrdk90clllU2F0dURMOGYydjJZaHc5?=
 =?utf-8?B?YlJ6VXpzUC9wVzJhUHJwOUdNd0MwUm5CUUFtVmpkeGdNMThVQTdvR1JBVk9C?=
 =?utf-8?B?OXF3ZURadXZnaTJnM1Zwd2JwZ2dTcSszb0Q3WDVXM0FBVUhoRjFDUG52Yml3?=
 =?utf-8?B?UGlQVFhHVWcxc09HVGVaSFJ1eWc4QXVnSk55d2JTcnhGMTJRSnFqS1c2dndI?=
 =?utf-8?B?TXVyTGNTMExoZEVvdHovcFp6ajhKVzV2bGt2WjhWVnFvZjF3V005dTRnVDhH?=
 =?utf-8?B?ZnFXL1JpeFlnNTI0a2FsK1FGR1dEcFZxNWNVTnN6WTBXV1l3ZE8rM2k5SEVW?=
 =?utf-8?B?M0xvN3VBSnpvZHJ1OVBBaXljZ0JzRlNZTGNadnd5VTVaRnAvM1JhUkF0TEhS?=
 =?utf-8?B?aHpyTFdqZ0xLREVoM1F4V3FjcmFpVlVjUkgwRE9qaW50bGMvWURRT0tEbWIr?=
 =?utf-8?B?VkZUVjQ5WVB3SkRhRk5CUUFXdkdPVGFiaE50WmRoUDY1U3FHRVNwWXVkOFla?=
 =?utf-8?B?eEdsandnTzM1S210SWxvZmpYeTdpNVc4N2ZGR1ZaSDZpQ3cxTkJTeU85Ui9p?=
 =?utf-8?B?RUNVQUI0NTJTR1pYSk1HMjFPaHh0QnJySDFvc1JsOHNjZk5aUnFGbkpRQXRG?=
 =?utf-8?B?SzNUVEtyYzBDYXNhTTZPYTc0a0Irek9XeldnZG5LY0hTajAvMVMybXBXdGsy?=
 =?utf-8?B?L1JVaEkyNEtKbXBCTmY3RmxsQjM4WUFEU2lqMEI0T2xLV0tPWUtvN1QrcEw1?=
 =?utf-8?B?TXpJSDRCTi9NRlV6c0dxcHB5RWFrYXdXdGJYQnYwT3NxWFRTalIrclBDTVVG?=
 =?utf-8?B?eXl1ZHc3cWQwem1QbEtOdU1wYmNqUDhiL0JDajF4dmt2L2VCcEdyUVZtYnY3?=
 =?utf-8?B?ZDNWWFRzZ1JRRXpBUEdQdEVndVdnb2FjbXlRTFM3U2lxby9GSE1UZ0xRQkRI?=
 =?utf-8?B?RzIvbVN3QlVIQUU1Ym9uMmxhRkJRZXA2NEtGNXBqZUgzQXpGTHdCRW1sSnpH?=
 =?utf-8?B?UFpJZGNwR3dxajlIRUJ3S25nR2IyZFRrL3lmUlNVZjVHZG8vTVNYK1hYYUFI?=
 =?utf-8?B?VmxuSmJLNWZtK3JyT29FYmdYbFVyV2JQL2hDUnExeWZRdzFPVzNFQkJMSEJv?=
 =?utf-8?B?OFF1MDBMTzJJazJTMDBZZzh1aWNIY2hDUjB2b1hyRWJqenI1cDdTM0hkZTV2?=
 =?utf-8?B?VU1wWVRjVTdVTko3L0pUSkhWRGtmc3JTUUg5RE5VTlN6T2FBOXN0WHFmOW9T?=
 =?utf-8?Q?nJxNrZK+h+3EdthNHP1wkVz3UWHFifGGKEK5U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVVCc1JJYTJIODdud21teHUxb3l1SFpJMFZNSmtYQjRxKzdGMEV3MGJUY1JH?=
 =?utf-8?B?MzU5UHlpSndmQmlod25jRGwvc3FscFJUd3Qwc2xwQmtXWEpybUJiUnBNSG5M?=
 =?utf-8?B?Q21IYldqNEowaFFoQVF1WjhFYStRNEhENkRadjk3Rnk2UjlTQVErc0FsYjlE?=
 =?utf-8?B?cTUydUNhNlFFeUVwSXVidkxBVEluSnQzdjU0c2d3WXMxOUc1TlE3akcyN1J3?=
 =?utf-8?B?dW0reEN6Y3FzNXdWR0FHVERKUytYaU9xUVhINDVFSHZNZzh4MlZZYzJSVkVo?=
 =?utf-8?B?ZnBudWpLZWRnVDNrV2RZQVVXV0M1bmtjUy9BeitUNTNaN0VFbEJJWnFoYnVW?=
 =?utf-8?B?VjlncDlvUDNka21rbERxaHEvWlZHQWJQc3FZZGRpelZxNHZRa28rd0Nqd0xx?=
 =?utf-8?B?aUM2d0lWYXFzUHJpM1hTQ2lNdjRpaWZ2YmdHVlRXTCt3cWk1cWxNQWtqUk5x?=
 =?utf-8?B?Zy85czNGaTJHMTRHVU9GeUxlOXFKZmZ1M0RGd0t0QnpZeDZFZElBM3lSaEIr?=
 =?utf-8?B?ZUNidEpsTmVyUGpjTFJXSExtaTJrNXZLRnpJZ0pEUy8zQTVoUVZ1Rkw0NktD?=
 =?utf-8?B?d24wRE5FaGd3eis4Q3FRSEY5d2tWNDdobnByaWgyNzAvTXI2Q2paUTBnVXF5?=
 =?utf-8?B?Um9RbGRsN2hCb0hLUmo0QTBCNldPaEdkbm9PYjhTd0lZUEphWFp6WExmd0Uv?=
 =?utf-8?B?cWRZKzdqdUljK0FOWkdxTHRSYjNUcitaRVlHY2IySncwTW9FTTNhbDlRWXV4?=
 =?utf-8?B?U3hYMmh3eHd0UHdpZ3JFcE4ydXJ5TkdXNFk1YmUvRUJOSE9OdVpOQlJlanFN?=
 =?utf-8?B?V2UrUFpEeVBjTTBPR1Nsbmt3cUZpc0laSHpaNlltSSs2WTFaWmZSMTFRUkVi?=
 =?utf-8?B?Y240eUxzVWJnVnJzTlhHTkpzSlFjRjMrTlhCcWZDbWVPN01KU2pGMFFQOXQ0?=
 =?utf-8?B?K1BUMC9uQUprQys4MEU4cUk5Y0w0M3IvZU9vZ2FpNU5UYlNPTlJnV053YjlJ?=
 =?utf-8?B?RVZwWjExLzRPRS9rTkJFNXBrQlcycHIyMWxLSHh5eXE0eDhxbDBlWGZPMEdu?=
 =?utf-8?B?ZDFQSEt4b3VLYndWWVU5TlJSY2tiYVJmdHJNMXJoTnVvNlk4Zmg3cDBwMmln?=
 =?utf-8?B?VHlidjRDNDBQeE96bkwxUC9UTDBESXJWNTIva29ITHp1cmxWS21tcEdUeVZu?=
 =?utf-8?B?dHJpbWN0SE9rSjN2SHFCZU9Oc3hKUkJ4a0xUL3VsaDJtVWlWQ1FYMmhnenlx?=
 =?utf-8?B?MTBOTSsyeUFVQ3VEZEhyVHlSMHVlbGR4Q2l1Vkt1SUh4UzU1OGQ2dGNhRm54?=
 =?utf-8?B?ellESy83NXU2ZEozWGxnUDB4Tk15by9lL1dIVitZdkYraXFqWDQ1Mmtad0pJ?=
 =?utf-8?B?d3dOZ1J3UkZMZjM4b1l4MDVaMHhNY3NnVE9jNlZaMzl3VUR2ejFCZU43TEZz?=
 =?utf-8?B?WnZYMDNicGRjNzhPbWtGNTZ6SXc2Z2cybWlJVFRrcS9nUW1vRmJXQVB0Z096?=
 =?utf-8?B?YnNqdUllNmtkT2k2WmJ4SEJhN3BSR09zS0M0WkxXTURBeUx0Ry84ZWtTSjRa?=
 =?utf-8?B?KzBPRXZWc2F2MzVkL3Z3YUJqQnRhNmRBZlUwMVpjVW5IdmQ1U0gzdTd0bER3?=
 =?utf-8?B?TmhOYjBsTEpUQTJwb1doUDl0MGRSaTVsQk1hY1R0bzNZRG4rSkpacHVsdEdo?=
 =?utf-8?B?ME1vSmFTL2ZOdWFKeWRVTXNKTGs4dm83Rm9DeUlLQnV0REl6dnZUdXJBNzFE?=
 =?utf-8?B?d3kzUnh5OEhlMkhnV0ZUMW9QTndWNElWQjc0aHVJdzFXamJvaldCeDFDMlBO?=
 =?utf-8?B?ZVRIRExvMXMxbGlpNWg0M0xZc2lCNWhBcVlJd0pMb1VsWjlUOXZxeFJzNFRv?=
 =?utf-8?B?cXppQWF1UVdqMlZ5dlk0eEhjTWZiTnJjK3RuV01ab1JYaDRGOG5FUzBFZXZT?=
 =?utf-8?B?OCs5NHlTdDZKbG1md3JKclNTU2xCTWZOeENYbk4xaWVWRnkvRXFyUXFqYXJK?=
 =?utf-8?B?MTBQcHl6eUlsa1J3cGQwRzltRks2RDhScUlKNmxLa21sZVpkeXQxWm1nMUNm?=
 =?utf-8?B?djNrVlZ2NmhONXdpMnVNTXZCbjRST09UTHhPSnFEd0libHlxMkI0ZFJjYnFJ?=
 =?utf-8?Q?1ENVs9VMYZ5t+iYVOTLQCVckN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d5vGuyLf0QiLTAYh+tHF75jOUKfct+EZx0DtCEi93mKHO4bvrah4KvfEVDnRXtYfQuKriM133wKKrT8nXXI75nlm/3zBVEi+3Y2wwSczPAP5jfVgc8T2KOjiXss88Lalcw7tc8Ay9x+Ro9k+9WK0mWM/iwmlG5L8XozSdqUfRFWbrSQ5RyizOdORpf657GD3EFyHaRU+6fTH5U/bKCoiqtJ+Uh9Zo9eJfEsg5lwucks9Xf09G5fZOAKA1b+GDBdV4Ncci9gSd0JSifW5Qn5+5pyM/UtkR7XlvkLdXczsfaQ4v8svws5URWTndneGHIbDx0G923mpo4SbtV8hOx+y//AgO6yqHXV5Mq8ukGxj8D3gNshFdH9mDHIOoanDIiXLMtvAxhGqpuleVUdPMNdcgAZAbXbMemSyReO4iOcj7meet3qDFhCSLwgVmwSo8qh6sp74pNH6Ja1MeK69SNjGYhW3DNB6fcjbdmM/6k4aaIiiw00kfj1vB3Ve3gScSkfceSfMf547hj//RAdmCJhCj5tXGb8RQfvJaIh4QzEpacKQhWf8ZACTbQ8QdCZ0QY5SfOxqObrFadofELhHzCjKUHeAT+4PL4rAGJfsesOjJOQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 235cfb4b-ea6a-46de-d671-08ddf685ab75
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:33:33.1034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yAvmaTISqCV2sxsuKGescBUS/MTaU09ZNX4qZw7RpwMGY9WJo5g6loIJFzNTFpriCqopa45Gn19/AcIhCRb3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7720
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180068
X-Proofpoint-GUID: zkFHIR4ZKZRqRGw48MyaSQi8NHgwHzjQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXy0PdNMr5d+8S
 1vDkVmFWxcumvJjIs0kT8m87hjt56KYqUPxrJ2LyP9KRHR+TPDXocQyBrTb6L1K+mNahvV8QOB4
 Hncd/xsoRgjAxoHXggkOZOk3jGubC2/baXpgHo/VirjH9kkq6m+/gdnNOkr89lkRjmMalIpu5r0
 n/uzZkyJKREyTVN07hgyajw72sQB3QWfhzDmv37/7LdRFE/RFi2rmAJ0I85na6Kw9NnGuu63uPw
 RCqbVeWNpff0iOHrIIsLJMmuaT2kwlkV8N/ccRO5BvvjRsYnmg4wpllg4VjG9/UnkyMAD8gb4I1
 e4VUb2lz86RF8dW5ONaVbXJXFqcD4V0QQzNm5sfyAGRSez0r3IbHj5kIJ+8owdCHnsM23YEkAVv
 3MJBFDFyyO4HMFG94vOdgFUMDTXAoA==
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cbb5cf b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=yPCof4ZbAAAA:8 a=--L3KNeqR9zZcoQM2k4A:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12084
X-Proofpoint-ORIG-GUID: zkFHIR4ZKZRqRGw48MyaSQi8NHgwHzjQ

On 18/09/2025 05:08, Shinichiro Kawasaki wrote:
> On Sep 12, 2025 / 09:57, John Garry wrote:
>> Add a helper to find the minimum of two numbers.
>>
>> A similar helper is being added in xfstests:
>> https://lore.kernel.org/linux-xfs/cover.1755849134.git.ojaswin@linux.ibm.com/T/#m962683d8115979e57342d2644660230ee978c803
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   common/rc | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 946dee1..77a0f45 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -700,3 +700,14 @@ _real_dev()
>>   	fi
>>   	echo "$dev"
>>   }
>> +
>> +_min() {
>> +	local ret
>> +
>> +	for arg in "$@"; do
>> +		if [ -z "$ret" ] || (( $arg < $ret )); then
> 
> The line above and,
> 
>> +			ret="$arg"
>> +		fi
>> +	done
>> +	echo $ret
> 
> this line above caused shellcheck warnings below.
> 
> $ make check
> shellcheck -x -e SC2119 -f gcc check common/* \
>          tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
> common/rc:708:26: note: $/${} is unnecessary on arithmetic variables. [SC2004]
> common/rc:708:33: note: $/${} is unnecessary on arithmetic variables. [SC2004]
> common/rc:712:7: note: Double quote to prevent globbing and word splitting. [SC2086]
> tests/md/rc:28:12: note: $/${} is unnecessary on arithmetic variables. [SC2004]
> tests/md/rc:28:21: note: $/${} is unnecessary on arithmetic variables. [SC2004]
> ...
> 
> Other patches caused other shellcheck warnings. Could you run "make check" and
> address them?

sure, will fix

thanks

