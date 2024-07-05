Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E528514A09A
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185973; cv=fail; b=pNYA1x4XK8yErOsHow2obJTBCHn5/1Aa1eS4XZQCPXCB/RAS2VkBREO+ARpz5mW0dy2A+jDV+JWKYEnId2OklY4yxUzR3EdKz2ZUNDTPkuII7NNTnvmXcuXh5n7s4buMJxkuZv4x8gTETlk5bNymkooSD73/3XIFT3FNhE6TY0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185973; c=relaxed/simple;
	bh=Fp0KkQ585oZURn8SxUTANmxrFdSK8nLc056k1l01v8M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aMdIAVAIhdjmMcSeBGJemAF511sSiPGU4dSq5F51YrCLq/WVGe0dVJDBbOny82KebBaAFTF8r680pbpiuw6+UbfP2bibpD6xzmJtw/JSomP/SdQKanHIVRRmT15lxDyzfDglF6AJlP8qCa7N44lWzKPxue/ZQUSG4Gv5XVDlqH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gwiv5zjT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sIRsJuyl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gwiv5zjT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sIRsJuyl"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465CtTKT022830;
	Fri, 5 Jul 2024 13:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=CZ/ZknOPiOODQXFrrsvcmEC54VRzxa0UBjCpA0o0oPw=; b=
	Gwiv5zjTrOFE1lIlDr0PiQeY9iPeGctk7yqz/gE4xAXazlXTEGIAAq81F3+3iBje
	6lQaBRIQJp6MiaRL9L3PHE6UOctW5tRLupCyKeKJ0+DONCWO9ia01KPW7N4ERai3
	FU56R3L5uXnZ42Ikp3JSFfxDLRO5It4foDSSgYd7j0zpAsn1tXQfdCrj8owI5O8r
	3N6zzyDxjRfz2857u4B7mYKYrfJhMmgvtrbEPU52D+Fkpv1dkGp12aarV8Qndy1w
	/RM4ZmGgmPKzsQJBGZMvUDzRLCrrCzUgRqWQRvKvuyby0EsR8gngHiQdTmXHJH4d
	B92plBSj5PqJ2dzbFF4i2g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vsut2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 13:26:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465BgauX023596;
	Fri, 5 Jul 2024 13:26:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n12bmke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 13:26:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXlGmZnylIWWcnBUkOmmZ7vD9igQWF6WdGC6DFfgBi7mYS3Ewd5fKIPYn+5xtHO0sNMLlEghHQeCqkBsoHgxPiLRvHnrlGxuHkDB0n080GefFXBCSlXie34V9j0v9K1zV/bH4ILDl1/3k0jVDdBD+JzxSNZ2kElV4FmhG3j0w7N04ibqbObzhxgIVDs+dbLAMU0YL3v9qbquc8LfdRxQCDZVYXk+AGVf2D2STyUgDEeg6Tzc3H+ydC1SBia5ijsBYq7nH0DUJARQoWym6GC9U6RCopc/5e4XkmqgdoeMfiW+5wfWB+SzNqC2eItmur0JbefTN781vZaUoqx5y8eU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CZ/ZknOPiOODQXFrrsvcmEC54VRzxa0UBjCpA0o0oPw=;
 b=nWFXaIeJlp9xOJvxL8+SA/NRZgYHYU6n+prhlvHfBctQSSMSj9KGabknXfWcV43sGeSxhPpU6bBu7aZ7tBf0vyZr4ldSxX1TWJcKFb9WuizU2ZAC1FzUn9xP9NayJw4CwwqK8XsrMUUIEqxXajnAAHaHDmKNXejELDMvFnNtcEvKzQn+55+TsZoyQchUBYG9KSOv9jaxZVZtbGSYoB5z7Hoil+uTvxyhfo25DzKnbtdpeQuNSv+8DT/C2YQMhP07Ek/l9qzuV9EAeQEslrTVo445v54F1InxFgE1unpKDebxyuBaKbZeFa4K0JXnVASh7AmIB86xBtkWAfNBNSJYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZ/ZknOPiOODQXFrrsvcmEC54VRzxa0UBjCpA0o0oPw=;
 b=sIRsJuyldTmziHxPaa451R4EIkgGXEEd/Lrzs5SC2eOsjZ5qX3Cg8pz9qcgIkyLBPvd3nkCgo8zphWMyBhux5xKbZyWOyO72W4ASfRgRPLKzQnetO/tl4jgMwLTjYYx8pYNgAJ2m6tKlmtXtU5vi/+j5g5F6mHz5OhcaxrrQWpo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB7488.namprd10.prod.outlook.com (2603:10b6:208:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Fri, 5 Jul
 2024 13:26:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 13:26:02 +0000
Message-ID: <85d7971d-f682-4b9e-8c0a-0366075471de@oracle.com>
Date: Fri, 5 Jul 2024 14:25:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: also check bio alignment for bio based drivers
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20240705125700.2174367-1-hch@lst.de>
 <20240705125700.2174367-2-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240705125700.2174367-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0429.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b10561-c6a5-4f54-6663-08dc9cf60449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YUtuWmtFd1piaVBTdlovUFRlM0JyMGNndm5mZGRzeGQxOWs2dCtvaW5pdGxt?=
 =?utf-8?B?ekVrR0F0R0xzcWI4Z2FVNzllWFUweEJlazJ0U1NlbmFyV2U1NjhTUTJFUEI5?=
 =?utf-8?B?ZE1mVFFoWmViRnhLdjhMakRycUFqa1BFK3NYTVhBM0xDeXE0aURWcEpBc1F4?=
 =?utf-8?B?aWxyZS9Yb0F6ZHdnZVZvMGU3SGw4Q3NCZTZrcU9xUXgzc2R6N0VoWld6Vmw0?=
 =?utf-8?B?VjZJd1dZREJLQllDL2xyWGVrNXpwMGFiWnVJbjhvNC8rZzVycENwMUtNZVpu?=
 =?utf-8?B?eDAzMFp6SldkM3RIdkdrSHJldU9tVitNRi9Fa0JOV2lYUFRhcjBGOXZCQy95?=
 =?utf-8?B?RHEwYm5xVm1taUtsTVlKcExzbXR2cDhDMEd6dVUyb3ExTVplQnV5d1lnQS9E?=
 =?utf-8?B?L0hpYnAzVVpVdk12Uzc2YkxOQVpyeWhORytZd3h4QzFDK3JjbkpuUi8xcTZF?=
 =?utf-8?B?VDVRRVVpMG5NVktIZTdZSGxudGJ1Y1ovRDZITGxEdzYwR2IvYmlpNTRnQW9s?=
 =?utf-8?B?RDltRXJDYWphWFhCTjUxbThIZlNzcjZzZGllV1RHZlJCVGJ0L0RnZDZMTk5G?=
 =?utf-8?B?aXFyR0cvTWlBY3l4UlA1ejZiQUhzWHpISDh3L2w1aHo1Z3Urei9sZFVBMHJF?=
 =?utf-8?B?M2VHRFFkOWRGSjlCN04xNDFlOTBPZDRUejRRRUgvb1Y0V1ZNSUpDQnJJUkpP?=
 =?utf-8?B?clJ0Rzd4NEZzb2pCNkFjdGFFM0dBaVRyVk9YZFBpSUpjOE1IOU9rMzVmUXBC?=
 =?utf-8?B?TjllaGpYWk53Skt1WEdjRWc1MEhpeVVrRWR2Qi83UlgzQkdqUkxNaWNMTEph?=
 =?utf-8?B?dmhvQXV3VU1rdlYzTTI2MlhUUW1GRHp5TVRDMWdGNHNBR0hzdzVjYnVPbmZY?=
 =?utf-8?B?NG5QZS9ITmtBZGRiZFRJYmxJRTdvcWRGdzhrVHVxS3grWkhXOTBmOUp3T0FU?=
 =?utf-8?B?aWgrNXlyWTRBQlRyZjZNVVpGZ2xyaDNvVFJKOVpvQkhtV2xyMHVtS0x1aFlX?=
 =?utf-8?B?M2Y3eUZ1eEV1b0FwcEU4Sy9qZzZCcndCNmZnbDFpQ1FlVTBQTDJZRXZqWEFq?=
 =?utf-8?B?eVZIc3ZsOUZKTG0zSzMrQnBlbExHYU16U1F3UEtIQkN6MmhOS1h1L0orb0ZF?=
 =?utf-8?B?NUJZZEZMb0N1TGUzZy9JMHN0cjZHOVl0dG5JZHVPTjVnZ1d1ekY1ZDBRYjh0?=
 =?utf-8?B?cHo5U2hzT25ZWldFckhEYzYvbitFank0bWxiNnU3YmJBb3BwUjlmTDZqclpQ?=
 =?utf-8?B?UmRTSjNRVE5QOHZwRisybEFkRERLSk1TaEhpMjNkVW1vTU82aHJmcTVuQ0Vs?=
 =?utf-8?B?Nk1KOThNWUxmQTVuWWsxRE9aU1o5WnR5NUQ5NEpxUVVOd01IRDhrdklHUFp3?=
 =?utf-8?B?aDZBRjVGUXhhdXNsTDJwdHZueDVGbjJ3cHp3UmtzSndhV2lLVG1xYktKMGk4?=
 =?utf-8?B?Y1NYNUZ2RHp1QmFwNzdUWUJ5cFhMWmErQW12RVFYSG1MWWVWZWNLUXJ5SjhH?=
 =?utf-8?B?eHdiWDhLTmpZbnRPR0FKV0MydW91a2hzcFZpOU5EQ0gyU2pxbyt2L2NUaDN6?=
 =?utf-8?B?TXQ5blZid29RR3pCc3V0Ris0Wm00aTJ5WmpPRDhITFk2aHBOb0tMeXIvK3pk?=
 =?utf-8?B?aDFwRDk4MHUxMVNHSWlIcXlVdGZwSmFiODMxdFc0cEQzZk5Oa2hYRGQyTk1Q?=
 =?utf-8?B?RGY3UEdwTEVJbW40bm1RT2ZzMFhZQXZLM040RHlZdUVCd2x6YmVEa01DMWg2?=
 =?utf-8?B?TTN6QTNWU3M4dGlkYk1GK0todURRb3Q4MmZaUG1YVG1IRlEvNmxIQUpNcFlI?=
 =?utf-8?B?UkhYcXlkTTUzTzNOQVF2QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cUtsbGQ2a1d6aEZoSWhTbG1tY2pSZzBYSTdTSmxwT2gyUUdDdXc0WS9za1Yr?=
 =?utf-8?B?R2o3blQ1YmV6NVpmanIvaHdldS9IeDhPNjJLTWlid0hBZ3pBV3lUeUc5RHZH?=
 =?utf-8?B?MVI3ZEJ0QlFoR0NNZ0NtN24yem5nbzJJT0JTUW1BU2ZjNlZReHc5OE1YdlM1?=
 =?utf-8?B?MEFBUnJxVmxVN0tjOXNCdXVmQUVNeFZ4UFUrS0RaNS90cVRYVXBCT0VLZjQ5?=
 =?utf-8?B?NmFraVhVM3lvZjNVd1czMTBDSFgwT3pUSmowZ1FGa3BCYzhabU9iYWhGTTB6?=
 =?utf-8?B?eTBkV3BVUzRDMEFNelRUT0tWUDhiMS9xMnRxekpKK2JNWDBYdDJkVm91Tkp0?=
 =?utf-8?B?bnRORDdycWlTOTRKRm4rWVJSVFJiRWU0c0Vzb1ZLQjBnQUc1U0hVK3lYYkhZ?=
 =?utf-8?B?NGRSZ2N3V2VZdHBQLzVaTm9ZK29hbVpiMXNzcHNZVlpFTzJsNUhEMDdlVXI0?=
 =?utf-8?B?NDBLaUFBTWFYVjkyekFKTmtFMlpyRzJ0UlBnRS93MFdaeWZXZVJSTnE4U1NU?=
 =?utf-8?B?cUV6elJmd0NxalMrUGFxdHFDWlVLTWtFc0V0QlF2SkxhSitUaFFOckxsUkww?=
 =?utf-8?B?emZoNzlKOUxKYmJZNHhMQ0tMLzk5VWVUakhTM1RpZUI2Q1NJRFliV09CS081?=
 =?utf-8?B?NEhIamxLOEptL3h5R0RmaG9vS2xudFIvR2M2L2xVWTFyaWgzQTMvWmpYUzdS?=
 =?utf-8?B?L0lKK3gzWHE0M2JwdWZBT0lWUW81UHVYeWk0cTcxWVRrbVJOL28rbHhscndw?=
 =?utf-8?B?WGZValNOSmZtTlM4eU9hc2pVcjY0ejRUeU13K0I3RFk0Q0hZbGtQOWRlVXVq?=
 =?utf-8?B?aDUrTDJONXgrRUprcFNDSlNtc2szU2t6dVZkdkNWaWUwaC9xUjAyeEpDNk5C?=
 =?utf-8?B?ZEk4b3pYZVc4Wi9xbWpCazFzWGZ6aHNtdjZPVXIyV2dhbTRabXNlRmpzc2pa?=
 =?utf-8?B?cDZPbktNcmZQMHJLNmFPMHdIWmJwWXVoTVI4YkVMMWNQZ1ZRZGRadHlLd05E?=
 =?utf-8?B?b3RQSGpCT29Cd0s3N2ViOUhHOGh3VkhUNzdWTHhvUDdBVWNRQ0hFcWd0cWMz?=
 =?utf-8?B?dFYyaUF4M0RmQkdmS0ZGNEJpd0w0REFiY0V5RWQ4b2NBdU9oODdSOWpNWnkw?=
 =?utf-8?B?UHlZQXpBV2lCdzRlYnFBb1h5NlpHaU1oNXFjZEUxQlJIcUFrSHF1ZmNhTGJs?=
 =?utf-8?B?ZVN6ckhMRS9NdHBJZVNZbnhnWGozMGZFZGIxMGtVMTZzRHMvekFydVVyN25k?=
 =?utf-8?B?alJGQnNXalRpSnVZNktLRGVTbWVEOXFJZ1ZEYlRiemNkcmhLU0lQVW5lNTRh?=
 =?utf-8?B?MHAyL2pJMThoYXdaVXdZb3ltL09BMEJ4MGMxZ1oyTUlja09JeFRFYlhVRENS?=
 =?utf-8?B?YjRjamttWDNmOTB6alovY3h3dlZqSCtSeUxnOWZhdVozbmRUdVAyZUdubFpq?=
 =?utf-8?B?SE5DT00zR0g1Z1VoV2pDRUZRVWFkSld5SmVZL0Jva1ZsRmdtZ29EMXluajhw?=
 =?utf-8?B?OGpHMjFOaWdaeGUxVkF2bWI0QUFndWdVREkxNWFOV0tMOFZ4bW5DMzYxZnI5?=
 =?utf-8?B?SldaS0I5dFdBZXF4bXUxdnBFc2hsSlRkcENxTFF2WEh5T3pkOUtIRktUbHYy?=
 =?utf-8?B?cjhPUldWTFU4Y1RMR3ZEYUVsVWZwNVcrMEwxZmhyQkx1amxlTWhVenJPZ1p4?=
 =?utf-8?B?Ri9YSzVvTGU3L0RRTmJBVFgrcExNSHYzcFFSUjRqNllnMS94QkJvd0NsL0NF?=
 =?utf-8?B?WU5mWFdNQ1F2Q0pPWktaQXBod0J3cjlJNTMzUVJnUUJ3Zm12R2h2a0Q5cml3?=
 =?utf-8?B?Rk1QditiZ2E5YWQ5NlpXM2xCa09HTGMwUWdGQkpYT3QxYXlEWG9CSEhOSW1a?=
 =?utf-8?B?L2hSUHJFaGtlbUlNT1dEWk13SWJBUVRHcXh6dWN6bVRnN2FYejZ4OHNmVldX?=
 =?utf-8?B?bXc0bHpySVVNN2VJeWYyRXYxTUIxSWkxSHVjeHNqYU9aV1U2RXBkK0g5TjBl?=
 =?utf-8?B?bzB6Um5nZTVsbERXbzVaeUwrTlNVbVNwVzdMU2VkaVlFejE2NjlQNXlyck9n?=
 =?utf-8?B?YVNzSXRhTUV5ZjhZUkVpSVRJckxnUkxkZGhvcUtNeUFiek93ME54Uld5ek1K?=
 =?utf-8?B?RGs0R0N6MElNMWVBK3dXOXJjNm1IK0Q1U1hZRnVVQjQ2eDFlK0ZCblJkWWtn?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QCo0NdXG/1chpWCidX//4lqU3vrXOeSVfI0SSfdsun+RK9fVOjzsJz007QyuDtO5Ape+KJSLrLEBAr33sj/2F4j0OyXJq9bgBVBKQco5ccLDjPP3qxcX8ZIpAvNif8/zoncsv8nbTgwakiewGfTWTJX7zhu7FiVuWtUXG5Alq2KGoo2Yg1jkDDkccLInGiKP8w+O8kBLBOQOAMirxCEIgO0iLpkTscAhF8kR4t9qyrOx2y9dSl3PFxXLGUeqV13oNNuWIVBdzTPM5o2DphZGKK09Aiksihu/XcWW5wt7ZJXVcysRP1HX28xPEPND6PwxZyT29R4Xwb91seZ/k+MjIzdVcBj7CfR5Ah/3AwTgfbs0IuroVXyJgqYC01IvVTgPc2DVjAyXJnlrrZ5CB//dMsReLDVECS/Qd3Rn6cd2SuIdi/qU4c7+hFO+B8ySYdSN9o1boh2h0KMaGaw2Vf1zH2XXqJGnq1Hfs4LqOeYQtdOXcQoEG88sQHIbkFAfbhsb3dUxDjwKaaCsQeNIl+qQr3gIQbWRFmFGyMDQ0+p1CxBE+yBaMzMDpZb6yR6P8qqHuU8uyPg7GJQYS+Ty0hXUHFRQb1t2qYTyRQpU1UyeXTo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b10561-c6a5-4f54-6663-08dc9cf60449
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 13:26:02.9319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbZp8CCTrg4NYDaWrsBWu7I+3CKzvz0pz6yRf8XG1QTrGtqRSTLgFLrFX8WEDBmdmMg36m0Ad0zLeBAgZc2r7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7488
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050096
X-Proofpoint-GUID: 4gcH_5xHSr7Au9tZ6DphAzRKbMiyL-Ii
X-Proofpoint-ORIG-GUID: 4gcH_5xHSr7Au9tZ6DphAzRKbMiyL-Ii

On 05/07/2024 13:56, Christoph Hellwig wrote:
> Extend the checks added in 0676c434a99b ("block: check bio alignment
> in blk_mq_submit_bio") for blk-mq drivers to bio based drivers as
> all the same reasons apply for them as well.

So do we now still need blkdev_dio_invalid() -> 
bdev_logical_block_size() pos checks for simple and async paths in fops?

They are not doing harm and messy to remove, I suppose (if strictly not 
required).

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c |  7 +++++--
>   block/blk-mq.c   | 11 -----------
>   block/blk.h      | 11 +++++++++++
>   3 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 71b7622c523a30..ffb55d8843a121 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -615,8 +615,11 @@ static void __submit_bio(struct bio *bio)
>   		blk_mq_submit_bio(bio);
>   	} else if (likely(bio_queue_enter(bio) == 0)) {
>   		struct gendisk *disk = bio->bi_bdev->bd_disk;
> -
> -		disk->fops->submit_bio(bio);
> +	
> +		if (unlikely(bio_unaligned(bio, disk->queue)))
> +			bio_io_error(bio);
> +		else
> +			disk->fops->submit_bio(bio);
>   		blk_queue_exit(disk->queue);
>   	}
>   
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e3c3c0c21b5536..94a102abb88055 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2909,17 +2909,6 @@ static void blk_mq_use_cached_rq(struct request *rq, struct blk_plug *plug,
>   	INIT_LIST_HEAD(&rq->queuelist);
>   }
>   
> -static bool bio_unaligned(const struct bio *bio, struct request_queue *q)
> -{
> -	unsigned int bs_mask = queue_logical_block_size(q) - 1;
> -
> -	/* .bi_sector of any zero sized bio need to be initialized */
> -	if ((bio->bi_iter.bi_size & bs_mask) ||
> -	    ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & bs_mask))
> -		return true;
> -	return false;
> -}
> -
>   /**
>    * blk_mq_submit_bio - Create and send a request to block device.
>    * @bio: Bio pointer.
> diff --git a/block/blk.h b/block/blk.h
> index 8e8936e97307c6..d099ef1df5f64a 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -40,6 +40,17 @@ int __bio_queue_enter(struct request_queue *q, struct bio *bio);
>   void submit_bio_noacct_nocheck(struct bio *bio);
>   void bio_await_chain(struct bio *bio);
>   
> +static inline bool bio_unaligned(const struct bio *bio, struct request_queue *q)
> +{
> +	unsigned int bs_mask = queue_logical_block_size(q) - 1;
> +
> +	/* .bi_sector of any zero sized bio need to be initialized */
> +	if ((bio->bi_iter.bi_size & bs_mask) ||
> +	    ((bio->bi_iter.bi_sector << SECTOR_SHIFT) & bs_mask))
> +		return true; > +	return false;
> +}
> +
>   static inline bool blk_try_enter_queue(struct request_queue *q, bool pm)
>   {
>   	rcu_read_lock();

