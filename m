Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0F2439F9B
	for <linux-block@vger.kernel.org>; Mon, 17 Aug 2026 16:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786984414; cv=fail; b=EbkwN50dP+8kXTsX7b+oIsh/U5cyCxd3eD6gq2zqJn1THMXJk5HfusbN4xRLqNFsZhnHvx5G7nw4Nsfz/JDStlBABgH/UnQgOxYxx6Lnutg5+NPPPuWsLnJe+5/wWdDjoY5fQSDjfe3OpLt4MufAbqIWYHaEYqn2euQ2ZmhiXBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786984414; c=relaxed/simple;
	bh=8fQNjVw+ib7QoPEDoZR8nGcZE5RilLKiuEMvuHrfHLE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XhVjzDGUc1YqsKWjkCbF+pLZoA3UGUack4NvEpL9f5ov4LvYcNOSSLrYMG4tpYFyqXS2W5NA3e/ssUuOalDprzuyik9w2HPi/ZBEd5ZMAgpbyIYrV7JDdWcrwMTjfoqSeFv5wey+KrOiaG+j6YK0x9itur56EfploaBKxo6GlfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CjeNiEKo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YGqq2j1Q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CjeNiEKo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YGqq2j1Q"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFj451814781;
	Mon, 17 Aug 2026 16:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WyrAr3UxxpBcrFmWUwy+cQ+VFKL+iC58BWrtAjAAzRM=; b=
	CjeNiEKoN06OASOFi+nGlciaLBZpuPmn8vT2M7Dolf9sCOzeGo4JN2RPbn3MR7p+
	AvhlwKUt+cjo5Z0PONRjKYMtWP78KOqcNnM1UYMVOxkNZcnis/VJq6xsCZkXsHxi
	lsD0kdqsa209gZTk9KfMqzlHL0A2JEcC9Dhw1BRo3NcyFl3mDJI3VeB5/b/YIwsv
	sNrtwWNY/68fScRSd6DEqbfFr4i+mVc3wyO1EEDV23gHDMO7oa2vr3aeWpJxgZO+
	69Xaemf/QaORJdIWfjkFZP6yQx4cYMnXxjBdsfXZ/Ri5xnEUup1QP7DvCnrZfMG0
	1zJ9RZoxRtUWY1y4UTZUDA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4g2epy2uyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 16:32:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67HGFHiT000727;
	Mon, 17 Aug 2026 16:32:57 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010013.outbound.protection.outlook.com [52.101.46.13])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4g2ejbv040-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Aug 2026 16:32:57 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3aldlPA4R1CiHywk+nug5Jdynlu1tkClXXfkcfXQ16Bxzl5Y5B+qIZPNGd5L+meqUkxJ7GRhfqqt42SfLq+KA/6Rdnd6EPqS0zGtbDUsrQMovFQrK1oMxTTy4LuX3mAfcPDPCSlnB6SBDLzQ3f7WO6te8J+fsAAizASfhgDAOXYnCaZ4foa4VDrvJRK45BzxxSmzUgv/ACbb0nKzKic8TnyyL99FBTLCfZINR2+g0i8JhgICpP2DVZtA0jy2YhbxKnf8ynxJKXSl7TUxt18jz4XEGzCJgC++WNQsxerLzPLPWAOPTErMkfE1E4GKLE+iYXrhwHouB1zHxlHt6CaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyrAr3UxxpBcrFmWUwy+cQ+VFKL+iC58BWrtAjAAzRM=;
 b=iZTxdK6LAafwEDRj9pMImccOsSEads1w9ekJA3N4xWTPtHHNndb446qcQ0WfrePG8HfwA2xdOTVnpZ1efeTVEqVGzqT0aUOkvkQHmlYCF3+zBOYulvH01635eFMlYOf23pR3derZJXKyPoFJhNfNDKgUahdvGQcDWhv4rLtnqDLe2hS/wMhw24G5hylfGEo92cqSFXWKv6zk2U/2OS6Hd9Q0pYEcv9zfwI6uTBtf33DksH4r0mS+ijMmiiLHbAk7+crMNY7Iu5AEAttmMFFh3nOxFzeLshkIZ++p5N5A+BSfVQtGZFF3WZWyFdkLdHm0+qxw52P6haHJnD25+nxhfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyrAr3UxxpBcrFmWUwy+cQ+VFKL+iC58BWrtAjAAzRM=;
 b=YGqq2j1QuyAzpfB4wBq8jANFIhQYKy1ailGKzT+0gRFNrIH6cxdXHjspJXXeJsbF4Dyp99lmVD8Iz18iPOe8PPxAcfKlxZpkkWpT/X2ASctM9iBqKLpwpeTqnu9v4Zm/SAp81uDHGv8hgeMcvnd2uBFwMIMqfNZeJqja02NvVH8=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 SJ5PPF2740EE012.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::795) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 16:32:53 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 16:32:53 +0000
Message-ID: <6d737efc-e7dc-401a-a265-5cbc4beaa8fa@oracle.com>
Date: Mon, 17 Aug 2026 17:32:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] nvme: factor namespace-head queue-limit update
To: Yao Sang <sangyao@kylinos.cn>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20260806024658.4193386-1-sangyao@kylinos.cn>
 <20260806024658.4193386-2-sangyao@kylinos.cn>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260806024658.4193386-2-sangyao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::10) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|SJ5PPF2740EE012:EE_
X-MS-Office365-Filtering-Correlation-Id: 83749c00-8e9f-4dab-929b-08defc7d2f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|4143699003|6133799003|10067099003|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	o5shVtw+3/hSeRzzFUQiQjWxrdUlNwzIa4ezql/6UdqdtUvImsoOVY0uGeLdQQ4oDUCicewICtarMeeoUHOoQ0uACXiLll7vZ4k+A+LMnl/L9KX9QosMoVIN3nT7yBZEpPJkAMQKOFU7nr0MYFhMRg3azAJ8PgO6CT97Eur31/6sHHXhN1C4TaW1x3TDkt7dyPc5oLs0B/o1w+BMMQVRNzV6ArCsVqN0IK5DHM3mah1dzyhY4nSsWssFq5+5S+dXdpg9zSJgjhQ/j8+Q8Ark9XRykotnMG1Aeimxqj3uNL+OgeyvwXB//E+FObQ/bbCeUzoeDMpHKvQt+FGA0Vi+IS/gkGW/ZZJzVCpzferOPZ24rODOWNLUM5/5QjdjgNrj+dgFyT5BGe20AfpXRsyvIWXWwUCJXT6bf2a8GEwKQDgUGRUB47qfOnzzAKNvTse33lEISi//5xU8gSsYWFZCJFOx8ULpnhch4Z4Nu8bPwcoG77Sr7tX7VW7OyilIYzx5fgiF4OPFUg4i6qQ2kE0xQJaLVE4mfTYUXu9CeJHew5vU5jy1dWaP383VkKHy3LPgYPmiTP3xPObfuzEE5fHyytg3Os77xP7OucYVLLGKLjqtTXo954KrQlZOhWhFdmYorPwx9a0Xpac9IFMtYQfiPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(6133799003)(10067099003)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHdRemVIVTh2M2hMUXZhOExIS0xEeHZqdFA4bENqN1RYOHRWNVg1c0FiU1Jx?=
 =?utf-8?B?TWY0UkcwTGo4dmtlM3ZiUjNXdUlkMUxQU2srUFVRYlRDK2t3SWU1WFhsWVFx?=
 =?utf-8?B?S2dCQllybVpMWWVyRFZ1WXlKTnhuaEFQMS9oR0pTMjZiVytCRmpCSCtMMFFi?=
 =?utf-8?B?Yzl2aTZLa1JWbmFtUkkwMHZVcUd0Q0JKLzBZWlBNOE8wSVEwVFp2cUVqMVl0?=
 =?utf-8?B?VTN5T0xzcnFLdWR2Y1U0NkpmSlUvWHpudEk1THFFSE1hVHRKMGpJeDdkQmpi?=
 =?utf-8?B?K3JaQUx0eVh5MTg2NGNtenNuWTluWTBCS3poSnFjMHhBZ3VYdlBBMC9WTThp?=
 =?utf-8?B?WkV3SzAwN0VHdHp1ZXAybXJGM1V0dkluQnB4enBFUTdacVB1K1ZsajZpbXBC?=
 =?utf-8?B?OWJHMjgyZExuQ2J1REtSbXdZZDZyTHYzZ0hpeGVNWEtpS1A2Ky9manZLK3FR?=
 =?utf-8?B?T2d6NkQxQnBoZS9hK2tuakUvQklwVk9hZTgwVDY1bERwWGRzbGEzOThGOHM3?=
 =?utf-8?B?dEltVUg3U3BzMzc1OFVTa0tBTXBJaysyNThyU0ZTcC9EaFQvaWEyZkpyOUll?=
 =?utf-8?B?RDI1OFkzSDFKcDFzWW94NlAvYTQrMStVTWNwQjc3K1hYMVpHM0xFMUdOeUJF?=
 =?utf-8?B?a0lRbE1JUzk1ZTdKWjd4OStHcGlqSXFTR2dYTnV4Uy9jeHl0QUVIMXBIM09x?=
 =?utf-8?B?OTlZeEl3dVdmYlpuWUtYeWFoSHFTWkNoYkNTcWE3YU93ZWxWMEpYTCtvWVJU?=
 =?utf-8?B?Q0hlalg4ZEFqTE9aL2ZrTWs1TUV1UnNqV25lcEduRjZoWG5Od2RvQXoyR2Rq?=
 =?utf-8?B?dS9kN1BEK2ZDdHlkRmxRb2tHMmNHZWJ3OFYwaWFyS2FvM0pmSnlqL1I4SWNS?=
 =?utf-8?B?MzVaVzJ5MlNYMUFBazhxd3QyUWUrMzNyV0xObUJUK1hFOTJEbWxJSmplYXVr?=
 =?utf-8?B?eHpBaS9ITHBlUUhZK3M2eFNuOWd6QnFPTGIzc0VJUTBwTGRKM3RGSjZjdFA1?=
 =?utf-8?B?KzRDRG9GbFdKa3VXYXpkTUF5TEp0THNGSEJhQ2h0QTBUR0w1R1RGdlE5N1JQ?=
 =?utf-8?B?dmFVUW55NXNNRnFzVmtOR0V5L3F1Y1oyNHUzd2ZFd2RzV1dJME5FU3IweVBk?=
 =?utf-8?B?dkkrN2tBK0dOelBNcG1jeWtTUllNbUhFcGFJdlZ0eTJiR0FmeE9DaVRUbXA3?=
 =?utf-8?B?eTFVSHFGTVIrQU8xL2t6dW5GdjRlRWhZdzJxd1pybElWRElvSTVCaXhSR3hn?=
 =?utf-8?B?NzlJZmtMbWVocnpURDhVb3UwemZiUUE0c0o0M255U2JjcHB5S0ZlNkMySXRu?=
 =?utf-8?B?NUtKQnoybzhJdHFpeG4zRlErUDc0ZG9vUGZubEFhamVyaXl2QXVJOU5IQ2tq?=
 =?utf-8?B?VUF1YnFKUjdMcXk4RWpKdVFndm5yeWVtZkxYV3Q2V2F0VmlxSHRGWkVaK1dT?=
 =?utf-8?B?ZnpYN3VRajdOMnBjK1owUFFaWTBoRE1CSTVxMm1Cc3V5QmwyKzZ3QSthRFJW?=
 =?utf-8?B?SXk4SElFeW9CWmFjRTFVUk9nSFo1Z2h1OXFrdTBlZ3pNYk4wdmZQbDN3SDU4?=
 =?utf-8?B?cjVlbExENkFML1RYb09wMUpTa0h2REhlYklMR2ozSjBuQ0hpVTR6aWNyOTUx?=
 =?utf-8?B?TjNLTk1xTklqUVMzQmc1d1J2RjFrLzI5MCtuUXBQVEEzSDdSczZPUlRyTkdv?=
 =?utf-8?B?dld0dFBTeXpMU3hmNjNlWnF4aE5BdXI5WE9qME1LTEQrOFRFNHY1RzdWeTFa?=
 =?utf-8?B?Nlp5eThGMFNnUDdmcC9ObEY1R25iNVphSGw1Wk1BTDc2eis4MTlIS05JWmow?=
 =?utf-8?B?aSt4ZnFVSU10MWtzTGlrbGNaWVRFMFhIZmtuellFTlJyMkZyVjU5dmJDZVhi?=
 =?utf-8?B?akFXc28vTzJ4NzhSaXlTSGtIVGNrdDNsaGUrTTdRVFgzYW1QaHI0TCtjRkNK?=
 =?utf-8?B?ZE5GOG5zbVdWcjN3aGpwRS96UmIvVW5HaTcrcUlaSGtLczF0cnNnV0ROb3l6?=
 =?utf-8?B?c01oc2NUYmV3RUR2eHhiT1huNmk5a3R1SFNGdTgvMHhRMWE4d0V6eVlOeXd3?=
 =?utf-8?B?SmVhTURGdVlsY3Y5THM4dnNYQTB3cXRVcGJEcFR5NFhZcGFBdFR2V2tsaFFi?=
 =?utf-8?B?cUh6WFdrMGhGUzFlc1h1bDZoL05udlF4Unl3TDdGSUFDNHh1Q0VZQ3RBTVh1?=
 =?utf-8?B?RUpOL1crTG1RQXdIVVVqcjlQNnpJaUdrSnR3WWptMC8rTlRZeFdRb3VORkVO?=
 =?utf-8?B?K2lXZG5kK0NCcnJ2N3htU2FOcjBTajFTeTBmY2hEL24rS21BVFNoQytqQ0lw?=
 =?utf-8?B?WW1RdG1xUjkzZDJGTlhxUWNnRThObWhROENrYXQ5UE9RZDZuSDVlUT09?=
X-Exchange-RoutingPolicyChecked:
	V5vnAy0mozUWzROppbyc/hMS0bmssyQK48GMBYFtI/ZcvtkK+HCjeJoSz0F/GdK5P3/48ZyFeZy5S1rlUoAV23N2EHTTT0hZQnZWhVxtxQBXTROTKoKOg/Ad8hoHzi8ixoseFYftTzm++bErxBxcLwd0g1zTs4tZmifE9dIaeEA69ROKK9y8BRFciFjfqO2Pw61TCx21V5QDHYrWKtJ7pkYbv9g9rA7Kc3hZMJqQwcvWlufV3x0T0vlt/XL2UFB2sYorAVw/HQzkyToxOw/+Af2sGQ/zguCr7zzgNx9ZnXDpcrBajmR/n9rsvT38qN3CguPyio2Xe250pD+LrzQMpg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+Vvnpp/yiCbsuvcuNd60C/sYzsIjGwq0PeIqz13EREXm9GNRY0Jpnwn/E35VfHQDSPIvUd9Dzu7dxL+ufek3QWMDzNQjXicaagQLRf7Ar/xzJ75MyveawDQXcoW+z0F8WMIjpZHBi+XqjDrnptVG6RHnYdDinZHtR1l6SEy6Jf8ei7Jv7qU2ja+muNGNCaPWvYdqs3qd0psmYWZprdYO0RHrhcnjbYVS07D2v2cll7D+YCnel7ds4WPxs2UxhuOlwIiEBlLziOwQ9v2oafyDGnCK9HNH65FjW1pCmFVPo2E5idkuWZdt/pL9vCM4Up0+v69Af2ulN08YGFj6K5BbS+Ib9o8DY7lvqDyu3sNawv9iyn6P0ZHTVnYP4ZYT8zvnRvdmoVqGCfA6cbBf8qunHoqSq+IgqGNXR/HoOVGeRyQ8C9WFJ3maMoMVIFXildjF9rZpbdSMmUicw3VE+fM2Hc56mGGFHkX2VG1RDnwgAHvTn+Sbd24PvEgojL0j6WFrI/fV4q1W6SLEPmvyprQePDZqqo4heMV9o9KMV1nxaatXh3lWkNnqxf/j3Hs6eKgiUMeEyVUIIqsT8VyGJtUjCie1LZr4e5hjugQBoPizH5g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83749c00-8e9f-4dab-929b-08defc7d2f82
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 16:32:53.3646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/ES/UJAdjAh966kC8Skl0wnUBzpmi72V/2gymz6Yv/rtaIwrx8gMrJAqaWB8Tc6GUoub0L9L77Sz4yIKnSHjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2740EE012
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608170125
X-Proofpoint-GUID: c8OpQEBtnTP4rmVNnNOlIOSQwn6Wc-bi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEyNyBTYWx0ZWRfX5GFTqkUPyJoI
 UR77FN9cCWW+DyeKci9ioCDDQQwZ71tk6fTQc9FY51zbUMMmLxAfcIt352UE2HVDG+i7YUM18UU
 rhnKsuZWJfUG1wqDOOe6ypFj+DyyTf7joJd2zCRX4UyExx8RSSwB9pyTC8+I+KuE7+tAbcv7Oq7
 bQR49BOPtdwdvT9UoORwX/0ZS7fzB5j7/QuM38bdF5JdWL6PHSLqLVkslgGFwYdaONEtNcWnXcv
 yfqXVJLO1NaFsuDZyV+Rvad8bGhIVtyDoMae6nzueeMSuddK5SWkkytKYJ5wBAlsIHgq0AUXNcL
 pLCojxkRsRIQNzttNvMlZoXUtSAIhu8snXXCi4B2VLEqZioOSI9uUI5wJh7sj2BXcxu7B8luFXm
 X8gdU7nnPrKXC7hSPpfDjJ7UC+5GUE09j/Mpx3JAx8P/zua+Nc61buX2SVWGzv6ABDGMG2Tw3j2
 0O8RH8xapAtR7Ji/WCg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEyNyBTYWx0ZWRfX/qBt7BGUBQ2I
 zaPLKsVdjqKFJPOFWrQiX1IwGML86m6IKtStUlCBnuFmx4ZDZ8rhpIWZ+bOxtpV58/f/nk7qPkS
 lnmMDCjdFnrNSHG8NV795oU4UdX3d92PF5hmOOQdf2w3zhjcoiGS
X-Proofpoint-ORIG-GUID: c8OpQEBtnTP4rmVNnNOlIOSQwn6Wc-bi
X-Authority-Analysis: v=2.4 cv=EP02FVZC c=1 sm=1 tr=0 ts=6a8337b9 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=RePjbS6cKJl2W0Z570kA:9
 a=QEXdDO2ut3YA:10

On 06/08/2026 03:46, Yao Sang wrote:
> Move the namespace head queue-limit update out of nvme_update_ns_info().
> The new helper keeps the current queue_limits_stack_bdev() based behavior
> intact, including zoned resource handling, write-stream assignment,
> integrity setup, capacity and readonly updates, path revalidation, and
> namespace-head zone revalidation.
> 
> Keep queue-limit commit failures on the existing short-circuit path so
> capacity and namespace-head state are only updated after a successful
> limits update.
> 
> The helper gives namespace-head queue-limit updates a single NVMe-local
> entry point while keeping the namespace information refresh sequencing
> unchanged.

Like the cover letter, this message is too verbose. So much so that I 
lose track of what is important to note - that being the motivation for 
the change.

The motivation seems to be to just factor out the NS head update into a 
separate function as it deserves its own function and the code will be 
neater, but not because it will in future have multiple callsites.

> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yao Sang <sangyao@kylinos.cn>
> ---
>   drivers/nvme/host/core.c | 104 +++++++++++++++++++++------------------
>   1 file changed, 56 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index cb93ada4376a..e3d27c0440db 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2528,6 +2528,60 @@ static void nvme_stack_zone_resources(struct queue_limits *t,
>   		min_not_zero(t->max_active_zones, b->max_active_zones);
>   }
>   
> +static int nvme_update_ns_head_limits(struct nvme_ns *ns,
> +		struct nvme_ns_info *info, bool unsupported)
> +{
> +	struct queue_limits *ns_lim = &ns->disk->queue->limits;
> +	struct request_queue *head_q = ns->head->disk->queue;
> +	struct queue_limits lim;
> +	unsigned int memflags;
> +	int ret;
> +
> +	lim = queue_limits_start_update(head_q);
> +	memflags = blk_mq_freeze_queue(head_q);
> +	/*
> +	 * queue_limits mixes values that are the hardware limitations
> +	 * for bio splitting with what is the device configuration.
> +	 *
> +	 * For NVMe the device configuration can change after e.g. a
> +	 * Format command, and we really want to pick up the new format
> +	 * value here. But we must still stack the queue limits to the
> +	 * least common denominator for multipathing to split the bios
> +	 * properly.
> +	 *
> +	 * To work around this, we explicitly set the device
> +	 * configuration to those that we just queried, but only stack
> +	 * the splitting limits in to make sure we still obey possibly
> +	 * lower limitations of other controllers.
> +	 */
> +	lim.logical_block_size = ns_lim->logical_block_size;
> +	lim.physical_block_size = ns_lim->physical_block_size;
> +	lim.io_min = ns_lim->io_min;
> +	lim.io_opt = ns_lim->io_opt;
> +	queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
> +				ns->head->disk->disk_name);
> +	if (lim.features & BLK_FEAT_ZONED)
> +		nvme_stack_zone_resources(&lim, ns_lim);
> +	if (unsupported)
> +		ns->head->disk->flags |= GENHD_FL_HIDDEN;
> +	else
> +		nvme_init_integrity(ns->head, &lim, info);
> +	lim.max_write_streams = ns_lim->max_write_streams;
> +	lim.write_stream_granularity = ns_lim->write_stream_granularity;
> +	ret = queue_limits_commit_update(head_q, &lim);
> +	if (ret)
> +		goto unfreeze_head_queue;
> +
> +	set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
> +	set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
> +	nvme_mpath_revalidate_paths(ns->head);
> +	ret = nvme_mpath_revalidate_zones(ns->head);
> +
> +unfreeze_head_queue:
> +	blk_mq_unfreeze_queue(head_q, memflags);
> +	return ret;
> +}
> +
>   static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>   {
>   	bool unsupported = false;
> @@ -2566,54 +2620,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>   		ret = 0;
>   	}
>   
> -	if (!ret && nvme_ns_head_multipath(ns->head)) {
> -		struct queue_limits *ns_lim = &ns->disk->queue->limits;
> -		struct queue_limits lim;
> -		unsigned int memflags;
> -
> -		lim = queue_limits_start_update(ns->head->disk->queue);
> -		memflags = blk_mq_freeze_queue(ns->head->disk->queue);
> -		/*
> -		 * queue_limits mixes values that are the hardware limitations
> -		 * for bio splitting with what is the device configuration.
> -		 *
> -		 * For NVMe the device configuration can change after e.g. a
> -		 * Format command, and we really want to pick up the new format
> -		 * value here.  But we must still stack the queue limits to the
> -		 * least common denominator for multipathing to split the bios
> -		 * properly.
> -		 *
> -		 * To work around this, we explicitly set the device
> -		 * configuration to those that we just queried, but only stack
> -		 * the splitting limits in to make sure we still obey possibly
> -		 * lower limitations of other controllers.
> -		 */
> -		lim.logical_block_size = ns_lim->logical_block_size;
> -		lim.physical_block_size = ns_lim->physical_block_size;
> -		lim.io_min = ns_lim->io_min;
> -		lim.io_opt = ns_lim->io_opt;
> -		queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
> -					ns->head->disk->disk_name);
> -		if (lim.features & BLK_FEAT_ZONED)
> -			nvme_stack_zone_resources(&lim, ns_lim);
> -		if (unsupported)
> -			ns->head->disk->flags |= GENHD_FL_HIDDEN;
> -		else
> -			nvme_init_integrity(ns->head, &lim, info);
> -		lim.max_write_streams = ns_lim->max_write_streams;
> -		lim.write_stream_granularity = ns_lim->write_stream_granularity;
> -		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
> -		if (ret)
> -			goto unfreeze_head_queue;
> -
> -		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
> -		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
> -		nvme_mpath_revalidate_paths(ns->head);
> -		ret = nvme_mpath_revalidate_zones(ns->head);
> -
> -unfreeze_head_queue:
> -		blk_mq_unfreeze_queue(ns->head->disk->queue, memflags);
> -	}
> +	if (!ret && nvme_ns_head_multipath(ns->head))
> +		ret = nvme_update_ns_head_limits(ns, info, unsupported);
>   
>   	return ret;
>   }

