Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4216390228;
	Sun, 19 Jul 2026 12:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784464096; cv=fail; b=Sb+mMhM/RJjSxZ2T1nNrwY/tZ4w2yakjaV18j8/TXlOtAW0eSYd0grcRJIR2fghUVNAE98dgvXkSK4fKbo97jLDqbbemYGUT8/dFSAGr009+/8Ff1nyK+IsjAGOLEieEsdcb/GLwK8N8ijKQbdPmVCyD70QKStRzldqTYeZoJLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784464096; c=relaxed/simple;
	bh=c6XyGax5aAq/bnd9BGN3zX5YA9qqk/Vl/1GDpLbqp6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nSPMtEpM91g+8+lMt+DkEr1JpVZBnSBxWhY+nFPQF+SvfxuIXuYX+ul+UWIys5QItfr7KPoghQar9D0rfD0HP1ySxbTlc+w8QWxa57sSfIg6JrHBag5ijj91XMdwyMwsOmlinVLREnVF88ztfuY6aIlWmgICssAzNGOoa+GBduA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=fmprM4+q; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="fmprM4+q"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66JBoWZ41665381;
	Sun, 19 Jul 2026 05:28:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=GFsgLbf++uT/dSRJfs5wpb6jAH/uFWHIc6PV21/gJWc=; b=
	fmprM4+qbW/iGgATKEWzJVFKnuoyOat1SglH81XiKz9qKkuMYwjQ+GUki8MHbjU+
	vdQd6vrqrapMRk0wGhHqV2/QeyJINpyt+9ojzIz9aEwY6+LR8gokfYDu6tR8jh2S
	a/Uz8SPJgxMOHIOYJOwUPlK6RwN/YLIg+bDhLBVSWDDA9aVrYrq0X+mGYSqh55LC
	PkUDMqg9L7UBuVqHWxG2D5UvAsS4Y18ZEq1beISVYis8R6Uj2GOo2iuyb+qBSA8f
	OlzrR1y3ip6t0sokic4JqSy6DUFidzMTgJp81sWa3DIhKo5pwMSJOrc8CcnWPWZ6
	xDVn3g8sInbunIep0+pV4g==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013043.outbound.protection.outlook.com [40.93.201.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fg90crskh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 19 Jul 2026 05:28:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m5xm8IThsd51jEi5kZ07Ghywud3x4eRuXwAE9f2QUsqaHMpxHvNLpeXVj/libhxIMsfnl6yauqYX1aZx1x/Ib1mTy+GyZgtjXUTfJpZGpRuGGDG/Ee/7A05wBR/LYD0xCSGVXm5gfd8Alm2/gLxERCjbKkfT9FM+9bVhOl97MXRzP/aR94gobudgZhZPFKequI3Uck5rDd/1fy6FSbFFnUwE0Wv2mCVwomjjmVrA241Tt8Dg2db4BOIu9LS0AaHZ6Mr3s/+/nTjKRZpcJZ5IBgbhUqFxS4u3GJgJjSSz03kIl+qpWW//Mcy3IKGy9RazImLLeNTfWK6EMMCWG7+mTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFsgLbf++uT/dSRJfs5wpb6jAH/uFWHIc6PV21/gJWc=;
 b=bOmZogN3CGHa9lfKdHngvDyg0w7GDi4Cf26vkXgE9xt+lsrSYgkGmV9cC6EDokCFSAiOu10cYHJOP1+jSYrksF5AbQIKMyGrOye+SFsQik65mDHA/vD2Per50k2tTldo6XBX+T1VSmkn85kSNUWTmQNmcNuudOG4bJfREBGx2sNOBxThC86LUpdrJ3Jk2QmjpvMKSEM4leDpUfwNYvQAiYblR9wRH29pdfBrQScwiCgFObRlhYIM/JRZnjpNl8P/GpBWXsXzKV2P4XhauHPHPHJ7urmKqmMzmLFSGzL7877O552DBa9cIFlBi+LnuEbq7TNzN/tf0E1/4X0wSzzyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by DS0PR11MB8688.namprd11.prod.outlook.com (2603:10b6:8:1a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sun, 19 Jul
 2026 12:28:06 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0223.015; Sun, 19 Jul 2026
 12:28:06 +0000
Message-ID: <1c5803c1-4554-4500-abe0-e0c6b63b70fd@windriver.com>
Date: Sun, 19 Jul 2026 20:27:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: reclassify socket lock in nbd_reconnect_socket
To: josef@toxicpanda.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
References: <20260706155744.1399153-1-yun.zhou@windriver.com>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <20260706155744.1399153-1-yun.zhou@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0091.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2bf::19) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|DS0PR11MB8688:EE_
X-MS-Office365-Filtering-Correlation-Id: 04300ec8-54ac-4b95-e9a7-08dee5912f70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MOPwTCq+aTIZjrmQzZzD0FrDiYIptP2xPsFyv61gQ2WOazIQM6CmN/RLCT1/3jt/9fEE6qj7wxS9OcLmbDyEJIcRKaj2k8lo5jdH6QJ2wjZdauAZEu2L8XbkTmURFMPzpom2IfXT3kWHuKyDG9m+IGRkM3Xqt/o75Liq56QQkTxwzVbj5JcaEiGFR0DT459WmT3UgHA/IJYT1J5W5F4lMNb6tx4RZVhUUPyAT/Kyf6Gf4Sb0AhqgbC39TBA96RJcofdSLafP/o2q6FC+KvngMVkASBj9o9Dfx3ZRuXRzMO2rT+F6+nmsRK9gDiMbLUuJJ8vVWmIwOCJRBemyj/O/swR2CucmmlGWEYfLCPos0VS22NunaaPIE63+MAPtj1AAHbW91UAzNPp4hQbfm2amJfzR5hrnAAwhFXU6ej8Qc9DorcarHV8WEGYMUXb7xnoblNzVORWnf5TSt2gP0d/SKBBRhsCHkAeWss+S52o0hYy4rM1FH75dGz1RhjLt2/fEB3go2xCSTek17OmfGDpcTRDOBKl1K+WdSGj6YhMxP9bb7Aj7O16T5NbQ0pvK8WyTWj8h+OGApQY+PIqPUdpj7t3rEQ3qf874wnDhiujjKdicUmnqfhDbq3rtdHxDHxql
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHQ2blhNVmpjSjB6dHlTSXVIM05YbWw1K3p6VU5wSUVnT1pmaTlWLzBnR2V6?=
 =?utf-8?B?cHRwTDRjOWQyU1RiMXRaU1hEMG02RzZ3T01OTzFTZmI3RUhuVGZEN1lQczln?=
 =?utf-8?B?YkdOaHpnZWQySEtmV2Jib0h1cTdEM0VWK2F6eDVFWi9RSHc1SnFxZmZJSFlo?=
 =?utf-8?B?ck42T0QrRzRzTlRsVXhzY1p6SDB6VFNHdjRHTXZOYUdZYXozL3I3LzkrM05F?=
 =?utf-8?B?R0xKTDhDUWIyMm54eWpVYTZJamc5MVpLcVFEZGUrQ3RETU5iMFpQRjZEVUhU?=
 =?utf-8?B?dzg2Q3RteEg2dHQ4SU90VnZzZVRVREJjR2crRkhWdEl3aUFGM1JDbFdRbVBz?=
 =?utf-8?B?QkllUTBIMFV4ZGd6cDNjY24xUVJ3VzRGQ0tpRUhFMVdJWm43eGg1Q0hzVGdw?=
 =?utf-8?B?SGZXUXR4VEFzWERSU0xSdWQ0eHFMay9iVmR5dEhtb2JrMWhBMWhEZmZnZkNo?=
 =?utf-8?B?MklXQmxqMWJHczVwUmxLMUh4d1hUNXp4ZGRkM0g1NlRKMVlCTW5hV2Nac0c3?=
 =?utf-8?B?NlpBTUR0c1BRSjFZVWF4bjV6N3U0K0tWbTlxZGw0c3BqWnVna3JCU3ZXRVpG?=
 =?utf-8?B?WlFGMjFxKzdEb3REMXlJcmVqTFJreEkwZlJlM3lNWG1pUFlYZ2RnekxIRmND?=
 =?utf-8?B?alZSWVVxaVc3L3l3OFVFdVZGckV6cEprRmlDZXNxYXp5Q3g0c2M1WGduQ1Ji?=
 =?utf-8?B?WFRrMHgzakwzenc1dGZ1aFEyWEV6dFVkYnVBZEhkdUQ2S3Z4WXpsOXpheE53?=
 =?utf-8?B?aElUSTBNUmlhajFaYm9ocS91b2YvZmsrMGZOTkRhejVoVVU5TVN4KzRIVzRM?=
 =?utf-8?B?aEJqN214aitOVldScWdpaE9SZ3NvL3lGNGdtalVoalY3Y01YQkxHNnZjSFdE?=
 =?utf-8?B?RFNucjFiWVZ1YXBXS3lZSWpxcllQSVlTSFJLajNSTXVUd2kxaktCRU55QjNh?=
 =?utf-8?B?aGRkdkhqY3F4c3VpajlLYlBjRW9QOEtvT1lGSElYcHQyTW1kR2cxbmQ5MHBa?=
 =?utf-8?B?Z0I0WUJ3MTgxWndaeElZVU5LYkRaK1orSEJLUSsvSUYwWmN3b3VoYzRiK2xs?=
 =?utf-8?B?bk40a2VRTnFSc0NMTUQ4RnoxSDRORHdNcGI0UW00cHl3cDZhQVlrN0dneUdt?=
 =?utf-8?B?RUpLV2VuMGpLS3M4T1pnVVEvTlN6NWhVOFJYSUFmZUlKOVVKZU1UUXVOL2VC?=
 =?utf-8?B?MUxtUW56b0kyeHRTOXdDUmxoalRPWVBnVUdHNWplNUhyc21RNmc3aHJjYm81?=
 =?utf-8?B?RDV6eFpBYkE1cXZ5OURzWFRVSFR3bktYMm40TVBRcTA5bGtOQWdibmdkTE5B?=
 =?utf-8?B?aWRQclBJYlNsTkhuTXpxeEdNeGZqUUk1RFNGaXdmMDYvODlDd01ONTFvVzNP?=
 =?utf-8?B?REZNWmFCWFlWdXRzSzhHQWRheU92YlNycUhUMzhZaHdLT2ZQa1RVOVg2ME84?=
 =?utf-8?B?S3J0K3NQSThUcEQ0RjBFdzdJVUxhMEd1TDRXSWljQk5ua0NCcEU0NDJzWVpZ?=
 =?utf-8?B?NGd3N3FJQkkzVjVvdnl0eWwrYmwyT2dXNkxrY1FnZ2tFeUJVbkR0U2pzWHlj?=
 =?utf-8?B?QlV1U1hSbktyeCtxL2Z3WnBaTkNOU0FwZWJrZVJOLzhKR2NDYUpVbWRTTGpl?=
 =?utf-8?B?YzREc084ZStNMTFXM1BORzNyeHkydzZySGs0OTd1T25CeGRHaEtzdWpCVFdZ?=
 =?utf-8?B?SGwvMEhJMTYrOUtUTzcwd3NvcUxnYlhvT201bTB1MU9lOFhZajI2MWpqc2ly?=
 =?utf-8?B?Z1pCTXQxWVc2UXpBRGhrbG5uN0RwQjl1b0JWY05YalNMOGNtZFdhbS9ldFNO?=
 =?utf-8?B?SG54U0ZoSmQ0a2wxcVh4WTBOVnNudjNWRit3ajZzcXdnSHVKYzhtaEdvbDR4?=
 =?utf-8?B?b0VpbDZ3SlYzQ0xLaloycGRTQ0VkOEl1SkI4TVZ1SWJ3SXN0VHRlcGtTMjJ2?=
 =?utf-8?B?dVZCcTVCWUg2YnpQazZ1TEZaS3BPODRPQkRDVlV2T3VsWmRjVUlGRndWc3oz?=
 =?utf-8?B?WkNaSlVpUGJEWlByY1ZXbDVJWFBDc2JkcElJbTdCQmJoOEhHRHJqak5BanRM?=
 =?utf-8?B?a0tnV01YU0hUU1FoOUlwUUZiR2NPbEVNNHdod1RjcTQwcWFLR1RSM0x0QWp3?=
 =?utf-8?B?bTI5SUZoSmQ0djZpTFByN3RUT2Y4dXBVTmc5RElqZFJQbDA2OTRBQndJcjZF?=
 =?utf-8?B?T1FDVEpMTURDM0gycWtZWWNzUzlJM1hma2JYNGk0RnZZaWozZmJ6dms5SGNW?=
 =?utf-8?B?QTIxRjRPbmtuQ2lUQnZwRi9oOEd0aU5XUHhKNjZkT3RubWk1aUtDRlVPWlZy?=
 =?utf-8?B?MHhGRkg2RmVEeEpUMm1IRVQzREZvSktWTEF3aUlPcHFBdVlzU1dQdz09?=
X-Exchange-RoutingPolicyChecked:
	A6D8Kii5EHTFcI3kE8CqOdNktDfq35zPCueSy2f6kUTs9nXUHVPbPZMtpV0OBeEiUZuR/r/3k56iWCX4qYE1DlmV733AYYLw2EKaCSPvAezwQEtahEtpju2e/21CGXUR/Uw1bo01GLQHEvXgBDeNLeX9JYeTr0h0IHVozfb468F6l9JbtPKrBJOtASwjNUQqBpxLwhedfw6HUwxpURNlfB4VBgfznWTYUrihN4V7qZpWpZK0xsNfB4djf4+8mtDGo831/wzOaKyCXkLRtzRphRBfrdzkCMbci5zfvWC+Eaea/QzwKhTyuaR63z/Kqds9O4vuJPMUVtVXplJwttR0Fw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04300ec8-54ac-4b95-e9a7-08dee5912f70
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2026 12:28:06.6078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CS6a0QOeTvJPjpGGbAkP6fmGaXuydE2vWwc63nhTR08ArqN8tBOdCXmQiCGwAbt+y/aVe3RFQAAnHhNiuRRkAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8688
X-Proofpoint-ORIG-GUID: vQAq0SAEEcdEPenR9grTByA_lGx4Ubzp
X-Proofpoint-GUID: vQAq0SAEEcdEPenR9grTByA_lGx4Ubzp
X-Authority-Analysis: v=2.4 cv=AOkSgtoa c=1 sm=1 tr=0 ts=6a5cc2d8 cx=c_pps
 a=XNh4DmHdy4Cg7KTw7bneTw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=mA0Hb_X04fgIqIpTn48A:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDEzNiBTYWx0ZWRfX97C7opkfNlqE
 eTEek9kalcudB15QZFGZnXGwgyBgF+nKkedJUKhrcw8qSqhR9tm2u/A0i+kIWk5QKb3GSPvCmiF
 yNefuigdvYr4MUH6gaMB98+EJ46wpZoGGOh0LEPZI3ZbTU9ojkUZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDEzNiBTYWx0ZWRfX1p0A2FGscr0O
 TbJ4y35f3w68jC6FtEYZXk/FdxAcXk3jHi0MPOkHIM1h0CtvByRBNM2iRw7UUVVMFNCPAcCfwOp
 4HkJYVnOz373RSX08LFW1SwyOniXbXR2mqxOvi2fwjYa6aP/C8O6vHcGSp+z3zi0Y6XO+Ql85vv
 vb1Q1jWVuF3/KvbNigsk3+oaKqXsDjH8+7SgZ9qXFOFOet0OzMcFZ47DJEyQSY8Ot8TIMrMctkO
 pIh7V4ch8T+S9FTgpZNrD4VU7/PX0+H57ItQjrWpY7nyChTgHI2kx2q6reXmrbcKU6NeexZtRDa
 iR5FfBu385QYs/3D87P8P6bwa1FwprAWBiUvsgtvmj5JpnNOrBRidlxNWbWlJHpwgVHvU9yDCri
 EidFq9dhOWSbxDTPgTb9Ufub144Aj6U/MwEY0z4zuK5GnngMDl5q1QLT+YenDsTp0hQZbc6Nk0D
 F9ituozp14cCp8gR79A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190136

Friendly ping.

On 7/6/2026 11:57 PM, Yun Zhou wrote:
> nbd_reconnect_socket() obtains a new socket via nbd_get_socket() but
> does not call nbd_reclassify_socket(), leaving the socket's sk_lock in
> the default AF_INET6 lockdep class.  This causes false circular lock
> dependency warnings because lockdep merges the NBD socket's sk_lock
> with unrelated sockets (e.g., rawv6_sendmsg) that establish a
> sk_lock -> fs_reclaim dependency in normal operation.
> 
> nbd_add_socket() already reclassifies correctly on the initial connect
> path, but the reconnect path was missed.
> 
> Add the missing nbd_reclassify_socket() call after nbd_get_socket() in
> nbd_reconnect_socket().
> 
> Reported-by: syzbot+576095eed5658cbd9b63@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=576095eed5658cbd9b63
> Fixes: d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular dependency")
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
> ---
>   drivers/block/nbd.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 8c6028e71e83..70a04d541ea4 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -1386,6 +1386,8 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
>   	if (!sock)
>   		return err;
>   
> +	nbd_reclassify_socket(sock);
> +
>   	args = kzalloc_obj(*args);
>   	if (!args) {
>   		sockfd_put(sock);

