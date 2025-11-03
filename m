Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5ED2E8894
	for <linux-block@vger.kernel.org>; Mon,  3 Nov 2025 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762168334; cv=fail; b=D5EWOjvaTXc3kTHY4ZmW1uraCGlpuj/bsiU9kU6mrDY8viI5Q9BLZnBptS/FE8oKxCMYAXvLuOulzPuytDGWBU0VMs6eLLJ6+6MmsVieRY00k2OkDYVi3vqtVBX2a+/mmHKDTaGBbpctqfKMeCHKTtjjQ0Hs+oZkYQVGyLuc+pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762168334; c=relaxed/simple;
	bh=EU23ydVsihGLWUg4vSS7QHe7b3vfaLJlE8aD5txDgFI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h//lU9kFBsCygLd5thNX5TNUBtHDe/kgn2lOkrFFMrKpU+Mxnrppe05bZ8ATxVSwRM3XCB/4P6VKUrkqCgcSex2i0LP2WzFVhJL9iDOJHAh9oK6LBV9OjV0+MXVEkCNy90WD+BsImAHfR+8pW1PXnzEANBGLA7+ljJKzj+rRG60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=itx4f4os; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QhQ05433; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="itx4f4os";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QhQ05433"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3B01PS009926;
	Mon, 3 Nov 2025 11:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=jEmBEDSn3f2BmhfdJxJSjo+Q0tbZbangRpJc9+aS448=; b=
	itx4f4osCEXjULThniLdBlN5Pu4eAwqBvHoYTCsSYoQOVGeH8gHkRV/AyWTh1sKu
	FZNFfuc0WMAjwYlwJTyi6AJL7mqsFacczHftQzVSX2JxwGXJ9am6kSm7EsLcKV+h
	JIOanSJ+6z7a33kmTCnhCeG1ZIjtn1PPp2NTzMxPGSgagxlNMRPv4+3twBV68I0a
	k8J6Ra1HBbjvGN+inDAB6U+JNKTWzKimrKjSnz+93XpkQgX8OltVQ2He6UZqDmS1
	5yJWb5NsWm86BnUsf/y/3e7JrEQraOiOniZ8Vu47FkdEu5MDBkhUwtZqR2YI2Rl6
	r7G1eKuDDmcoSKLR2K3xJQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6u4g80u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 11:12:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A393QfT008009;
	Mon, 3 Nov 2025 11:12:10 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013029.outbound.protection.outlook.com [40.93.196.29])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nbgrrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 11:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/dIBdttf7UKskemWkqnTypQZhMjGQFG5zFbO8BYwtrKKsYpMKJDzjGOFLQkNUJJRvAQRNXuSuM+GeZjUh0Agb039TEdKcjxV3dV9g0QQPNMPBEPBOISmi2b1CeuBwkolI1Bxnji8d/HGZt6XCfFR2MwF3IEzBKc5Yg3d92aVJFvNeOFp227hGKm4tbwzu/f/5XJhXVpPn1lwFi/fYghP/CR5DtnaTNLtWRGp3p57i0d74c2+Zl5E9LYmpoGpAG7Ue/CnVdlRYm2b8Yyp58C59kEOw0XCoSn2IbcZz0uUZu7chPZ4U17hwhWG+NwC7eguwJy6V0ohaXvSWsy83LDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEmBEDSn3f2BmhfdJxJSjo+Q0tbZbangRpJc9+aS448=;
 b=jay8g9kzQiCRHCZS9LBWQEFTz940k8zzc0k41PGJzUzfZFSOjdHHfXMOOQgfy3s0yhHGeWE4Pw0qhMsjimv7p7XjL89B9Je5tVll7qa9B6aDf96A6EAsKaI5XUXalxlFDvfZLsEP5hupohcxhjoZ6qD5uc6TYisfOrKGGE3KKOVQoFnKTCyUDGHflBH4YaEewLbqjZn5a64qINgZMvRJjK2QcuJ/M629wvvRxCmypqYfdR0TyIkAQWTaTHOyofyZJM+tEBsWhE4TC41Ow3nhIOJ1Ur0KJAmXUKBW6BKB2wH+vaSpf1oVfHkgRWWbOkvNsAJI3akRLB24OTeTDZ1B+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEmBEDSn3f2BmhfdJxJSjo+Q0tbZbangRpJc9+aS448=;
 b=QhQ05433srBa/LP+LEv9lTuiMElng5VqildWk0x+6B6uv647Pi0WYhypEXBkN3N1uUyfF66e7DxNiExN5NDBAtQX8SVZ4rqWGlE9BYCy1KOIh1ipX813Jj2h3fwDr73yji1BvS2HSN43ydWv2Of+qG0/ZkA1NNAAoo6lrScPDMc=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CO1PR10MB4626.namprd10.prod.outlook.com (2603:10b6:303:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Mon, 3 Nov
 2025 11:12:07 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 11:12:07 +0000
Message-ID: <ed992ce6-5224-4bf3-8bb3-91fb112c9287@oracle.com>
Date: Mon, 3 Nov 2025 11:12:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: update io_uring and block tree git trees
To: Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <4d23b2b2-c723-461f-94a8-a90c60982bcc@kernel.dk>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <4d23b2b2-c723-461f-94a8-a90c60982bcc@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0035.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::8) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CO1PR10MB4626:EE_
X-MS-Office365-Filtering-Correlation-Id: 54af0126-6042-4b55-a87c-08de1ac9d367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2Z2WmE5cE54anI3TWJ2UG5qaFJGV2MyNEpOTzQwd3VnTHc2YVY1WWc3ZG40?=
 =?utf-8?B?dm1iNVkySmUrU2Vpc2UwQXZmcUtCMFJrNFNobWVsMEQvdHlqNmdpTlV0ekE3?=
 =?utf-8?B?Sy9BZTFsOWFINWFnaHFSM05yZ0g1VmJTUW9pUnlFNjJBVmErQ3o2cTdnRnV5?=
 =?utf-8?B?aXEzQU5IZWkzZE50bklMWlZ4RkF2UVJzenFhV0U5VVJHMUVtSzRia1pFQ1pp?=
 =?utf-8?B?TzhUZXBOa3dyTXd3TVV5Zll0UVZmQ0w5S0s5VDVYem1SVTBOWmRpMkRFd3Bi?=
 =?utf-8?B?dk9XQmdzcFA1ZVRiSDB0RkVYWDZqNGR5Vkw1VU5HT05QQjE1Nk5XLy9tU0Jh?=
 =?utf-8?B?TDFQTTRNZmFqWnJxZy8vVmQvdjJBc1VDQkQybmlyZndiRzZoMTNkY0tKc1k5?=
 =?utf-8?B?YWJZT1Y5U3Q5NlpTQ091TjlXdVM5c24zVWFac2ZPZERVa2JsNml5RUNKYStu?=
 =?utf-8?B?SVJTMG81YWRjL1h4OWk5Nlp6SGtlMlhHb3M2QmRYTERRNHZVK01rbFNybXoy?=
 =?utf-8?B?WStUK01hbVhGWW16QUVCem1OT1JTbjE4UmhHMFpnYnNMZUJWOHVSWU55L2hB?=
 =?utf-8?B?eGZOYWN0cktPdXVZcnVVa0tOMU00UTdrUk1Xazk5dFBURUpsVEYvVlk1QkEy?=
 =?utf-8?B?azVmWG90eXpZWjArRFd1ZXVjeExXa0phUDRBNjRMYWRKVUNBOWM0SXlMN0RR?=
 =?utf-8?B?clV2VGwvRWtmQXJLemtEZlB0ZlZ1MkgxSG4zU0syM2h3RTFveEtRczNJTHJU?=
 =?utf-8?B?U2dGMzliUC9Wbk8wQUxMTnBVb0RaVkpPOSt3MDFnNUdyNmRCNnhtMzNXUFlp?=
 =?utf-8?B?MTdDL2dDNnZxTGRrcjNYU08vTU9yOW1nRUN4aXlOemExL2dnb1dHY1l2TEdI?=
 =?utf-8?B?QUd3ZTBLM1hUUzhFWVI4R0ZiVVNHdFFUVXZLM2NtRncwREFReUwwVm11MGhl?=
 =?utf-8?B?djRVTmlhaXhyQTB6K3pqdnRSRUt0TnU4RGpKMnpkOE9oczI4cjVRN0VaUmFX?=
 =?utf-8?B?QlBWOWNBQm5FeE5kQ2lXMHpnSHpyOTFzNmMweDBiYmZaZWxZbEgwR2lyOVhq?=
 =?utf-8?B?UFI3NnZjZFhtZm9Zb0prM2JNLzBJVm1IcG95SVpvdVB0Z3RubGtBUEE2WUY3?=
 =?utf-8?B?RGgyYnJoMmM1dThiTWR5cWRTZEJXVEl3OTNISHBBalAvR3ZCbERvak9lZWpE?=
 =?utf-8?B?SkRrMFF3anVIY0Q4cFZZY2k5UUFtMDBubTJoaE50d0o5b3VRbWtNRlRoYWVE?=
 =?utf-8?B?SDNSMUFNbXY4bEYwN2w3U3JLMm5lOTJJOXBrdVNDdU5zdVVrYkR3WG5mM2xp?=
 =?utf-8?B?NU5ONGZGdWdTMWNBQzFkdE1UcitycUNwbjE3TldNRWowaHpnU1Y3ZFNpRXZO?=
 =?utf-8?B?VVdUbUZ5SFdzYzhYdklsV2RZSkxlUFRoVzQwdHR5LzYyb0w2dVRkVmI0VjRo?=
 =?utf-8?B?OWt0S29wVU1yVks5WTlRbTdjMWpmS29YRDljUFBGTzdpR1p3clFYQ0FuSXRE?=
 =?utf-8?B?YUdOMC8vN1RFV2FtSDZXcDZGMUlkcDg4S3EvdXRwazhGdXNkbG43ZFRmUTlB?=
 =?utf-8?B?RHFzMGNqMlJreHVaUVVXQ0k0UWQ4TG5zRnQxZDEzTGptbFdvbXJINTI2cEZ4?=
 =?utf-8?B?NGhUSHdTbmJadmNia3BVWUFuaU5peEpQT2VaMlRPSTdFVG5kRHp6S3YxNUZJ?=
 =?utf-8?B?VWQ3Wk4vdmJrZXoySVRTRnlTNlVSWE8rTGNwWWxRR3JqbEJzbnN4QkVWWTFV?=
 =?utf-8?B?Rm9UeTYzQ2ZLWWhrN3NNR0dkZ1o0N2ZLVFgzS2d2YUU3cW80ZHFUQ25uVElW?=
 =?utf-8?B?cHpjdy85aEJ0aFJPWEQ2OFJ2c1dmVldWUEZ2OGljbW01K1RZRk9ld2tlZmkx?=
 =?utf-8?B?OS9lZDFEdXF5clF3SS9sV2c3cWhSdjV6SmVVMlVaU3FCNG1Fd2lQdHdrN0NZ?=
 =?utf-8?Q?jSP6LuOUUf4mICgSHEF7umzcNFhaZVEu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlFXczZKNlY1RHpJNEV5TXUydWVNU0dhSmh0S3N5U3NmK2J4YjBLc3N1bUta?=
 =?utf-8?B?ZVk5YVE0djNPWlh4RHRWNzNHMGNIbDlhUkg3Z2gzR3dyQlU0L1pTV2Y5NWlK?=
 =?utf-8?B?bEJkb3ZpRUFtbS80cWNjMWFJcFNNZmFOdkJGZnpPaVNRTVlUMlRHV0x3WnRs?=
 =?utf-8?B?UHRDZWF2b3hLR3M2MVFWUk4zd09xUDlwTXZlekJlbTBjSjgrRVlicWlKYis0?=
 =?utf-8?B?aWI2anVEVGgzZjVGb3JaSEw1VUEzR2FZclZzZlNzV3d3N3B5dnVoZGVGTkpR?=
 =?utf-8?B?OGExLy9ZQ0IzTGsreEQ5b1JBa1JiSHp4V2J3N1dFTlZlVHBRT2dNMFBqVjdH?=
 =?utf-8?B?SGVkeDh4dm5CbFB5ODhwZjlhNnRTcDRvK0JiZHVsSzFMT1lOKzdtRDdrTHA4?=
 =?utf-8?B?UjFZZXIxOW9NZExYNlN2WXlaa1I0MjdwUEN6dnZIZnlJM0V4QVdlRVZIWDRu?=
 =?utf-8?B?ZGV5anV6V2NjbG9Cd29jWk1PMGJYYXpiTC9FUkFRMVdOUVIraklHYTVhRWow?=
 =?utf-8?B?OFo5dUxRRXRWdkd3MStGOUlJN3JCS1p2Yzc4U01IUFo0Qzk0OGpMNGVDMGpC?=
 =?utf-8?B?eGQ3dFIzTnp3cERiSzdOMWF0eExDUFBaT244MWxlb3NRdWlrcHFqeGpxOFJ0?=
 =?utf-8?B?dHFsdzZ5M3pDOFJLLzRnWDNIVVR1eTRHWXpQd0NWaUFIS3c3S0lmZk5pV3Va?=
 =?utf-8?B?QnpDN0JvdnQxa1IvenlNemVacjJxR1htMlBrMXFUdjFOczJLMXM4L2ZkMVZB?=
 =?utf-8?B?WHZnV1U1RFkrckVId2VLbmpIU2dhZmE1cEsrcEhXVzVrQUtQdjQ0V0ZhaFJl?=
 =?utf-8?B?QTRqNHd5U0pNUkJsVzZiNkxrc1p6UzIzWUozMDRKQ014TG96RlY4MzFLWXU5?=
 =?utf-8?B?dnFPanBwdTdpazY4TXRNRjl4YVFtZmlad0cvZkQyZVNnVFRvTnhpT0FQSmdK?=
 =?utf-8?B?aUNmbGovWWJMMmpYZXFYOURCSy8wSEU1aUZJZGZzTXovUnZHcURiNEl0cnBi?=
 =?utf-8?B?aVpSUy9FbjloTXplVlBDTWluWWl1ZlZEREIwRlVRZTBHZDZyeVIwMmxjZWIx?=
 =?utf-8?B?T1d1SFVDbnhXYjdkMmk1bmN3dllQS3dTWkFSSU9TUmhXQSt0cHF1SHhsaExV?=
 =?utf-8?B?YnRYeGNYZWZlU2JkclF5b2x0eHBtRFc5Um1xckZEWmI4bUkrOXNQZDNUMFBK?=
 =?utf-8?B?RDdqcFJ2cTBnSnlKdXd4UEpkTG8wMXUxQkpUMzBNNGdMN0gxbjhmNzRJenNV?=
 =?utf-8?B?Z3pCTnh3anVjODBIRzNKMjJrVGZzaklvS0wyRWNrRFlHN0k4QnU1M2d3anYz?=
 =?utf-8?B?aGlXN2ZET2lnVEg3dFNEczZrNmZhSFhyLzM4ZE5RcmRNODd0M0J4QTR5Rjg0?=
 =?utf-8?B?TE1RNk1tNEY2TGU4NjdwOUh5WGpsNFdyWUdBLzZzbFlCRFhqT1cvdkxwcW1j?=
 =?utf-8?B?dVpHVjFMeDZiSWliQlgyTGpmeEdIL1Y1UHA3Vm5NbWcvNHdhSTlDL2ZxV2lW?=
 =?utf-8?B?MURraWJKSnZhRXVQcnpCZXZmMTJFSjJnend6WWhNcWowVHRXdHRRK3diZUdG?=
 =?utf-8?B?UEVQZW94QnFNc3RyMGdpUk4zOEVsMFRsamRmK0xLNlhoekJYdXpOVEtOVkNp?=
 =?utf-8?B?dFlOS3Z2ZG1MSnVGdlhrSFVZRzlGQ0xCTWp5SC9lc3B2UU9wdFFiNlhWN1hP?=
 =?utf-8?B?bnVleGg1Y0RFN1dxbEk3R3p0R1ZOaExXUUJwbVo2Y2haOUxyb2FhcC9iMDI0?=
 =?utf-8?B?dnFmSm1xY2M0dlBoSlZBQXhVVVhQK1gyZFJLZFVnNGp0RjFGWlVoeEFJazBG?=
 =?utf-8?B?MFFZZFY0QjF3SjMybk4zNE1JM29Ec1lEK1k2VFZpaHdhaC91dnVsVGMvVTV6?=
 =?utf-8?B?Ny8xWndhT0hETFRld1FzaStJbXBiSDFrY1hUSnhGY1NRZDNEbmp1NjNCYi9r?=
 =?utf-8?B?SklMZ2NOSjQwR1JSTnA4WTNTRysvQ3BxWGQza1UwSW1nRGdWaUxaamZHUGZD?=
 =?utf-8?B?Z0x5QjAzMVFwcVlFZEhOZENxaGlVRVp5dHJGeWdjWmR6WlVKakZjNUhYenRk?=
 =?utf-8?B?blF2a2xaSi9BYXZqV0pyK1VYT1dIdlZkU3RvT2UyaUdodCtYM1QvYWxqL3pO?=
 =?utf-8?B?ZUNmQ1dUbit0b0RPT2xRNFlOUUY4UlB5ak9XTUdqWEtpODE1ZzRZRTVOSUpH?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fAy5NRoRA6rOlANj2yHRkRyA/Jry4ojOH7TE+pu+V+XpOxtVt2cwZdbvbM++PXta0ML9hm/IZHyDlQDPwXyUyxPGeWHC+Yb02zpCu3mLb6wDheZsTxs6W4dJBdvCrGWRn/Z+VHmvc4z0uXeB2RYoEbxGmF3IAtIrhn5gTIag7ISOz9btbhwC7AUXU+UFqha40vZAX/nePplQilpc3fQNumriskWvcmJV/0bq7E3BFXO1G2yl+AXlUvVUVr5lItXprPWgp5HL8y1yMq6AuHDO0UV6FQMtLVX8AfiFcsRG46mvWulNZzvLKwvRFSzJ+I6yYzkAWMSeT0dp37lFl9W3+ilf0bYJbohqRZFppLQDmie5Zxz4g/MOXOUlFO1nxK0TMx8/sC0GewXgr/9DGQyljnlP5zYET+nG0MlaGb+fCIVBe3/WuvejyVRCSeuwC/06JnneAw2Mj3msdheb1IxGJDMoC75C152v2dUwfdBjykkCMtW+CBKBKytY5ZON0XuCGng/LJ2L6c9RSv0Lkb2AbU6NYIdb3njgeK1nl65CehKDuGI7HW9ae3Wf/I76AlYg6ODA8VdIy7PGDDAQ66UJcn6B1MJN44/XQo5QL4ObtzM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54af0126-6042-4b55-a87c-08de1ac9d367
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 11:12:07.3273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3n7vvXzije7xGEXWcDbiVIJ+z0X1fP6Yxw9KP1Pt+vSNhEM3XWnIdH/bnC40UuBDsEC7yb/snyfwdaTdc+Psjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511030101
X-Proofpoint-GUID: KtUaVPIbTqbVQuD_Wq0z8fHbXyG6TE8L
X-Authority-Analysis: v=2.4 cv=ZacQ98VA c=1 sm=1 tr=0 ts=69088e0b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=maIFttP_AAAA:8 a=dt5_ZyVjFhRavsmmCO0A:9 a=QEXdDO2ut3YA:10
 a=qR24C9TJY6iBuJVj_x8Y:22 cc=ntf awl=host:12123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEwMCBTYWx0ZWRfXyO/AZQI6JYP/
 NnLS8X5O6QAN9X/7C9+RdBFTqvyDPffLIpaU9hcITkcKhgu4lBmXs60FBBnG9N69A/vKf8Np6jt
 QjA3CWPXHLD5dQF1iu7g1Ax1rZGgLx7jtWxZBgCMKHG3smOqT9oLsLQ6PDEkszOxdMQcoUmMspm
 Wh72EiGRHyCzFLTb8QB0GPPP7WHlO8r482MIh7xB3b6LYA7Th4GB2NlLIhrNL12VvuOvIlGoX1E
 J7ZqQsCfDYxPkMT0iOdl1qjvXD40zutxQrexdDXRtjKIju+7XKLse/87m25o+C5Hg/AyhaEFeUn
 hcrIX7bMw6eM13u3BQspTNcU//kD4Yt8jndq4V9T//OkcIOeoV29MmUYICaUHw1kNqwy4JHfOyg
 ft7vt0g9F1KNw549u9rOId+T1ULpGH6VZyOGPgzftpx0WXChsEY=
X-Proofpoint-ORIG-GUID: KtUaVPIbTqbVQuD_Wq0z8fHbXyG6TE8L

On 23/09/2025 12:20, Jens Axboe wrote:
> Move to using the git.kernel.org trees as the canonical trees for both
> the block and io_uring tree.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 

Hi Jens,

Were you also supposed to update the tree for "BLOCK LAYER"? I think 
that previously it was 
git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git (as 
that it what my .git/configs entries have), and now it seems to be 
git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git

Thanks,
John

> ---
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b47daf498a97..60d29ff64a55 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6224,7 +6224,7 @@ M:	Josef Bacik <josef@toxicpanda.com>
>   M:	Jens Axboe <axboe@kernel.dk>
>   L:	cgroups@vger.kernel.org
>   L:	linux-block@vger.kernel.org
> -T:	git git://git.kernel.dk/linux-block
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
>   F:	Documentation/admin-guide/cgroup-v1/blkio-controller.rst
>   F:	block/bfq-cgroup.c
>   F:	block/blk-cgroup.c
> @@ -12860,8 +12860,8 @@ IO_URING
>   M:	Jens Axboe <axboe@kernel.dk>
>   L:	io-uring@vger.kernel.org
>   S:	Maintained
> -T:	git git://git.kernel.dk/linux-block
> -T:	git git://git.kernel.dk/liburing
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/liburing.git
>   F:	include/linux/io_uring/
>   F:	include/linux/io_uring.h
>   F:	include/linux/io_uring_types.h
> 

