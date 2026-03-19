Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25962E7164
	for <linux-block@vger.kernel.org>; Thu, 19 Mar 2026 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773929127; cv=fail; b=Xb2JNaqi+ThMU4MrNTsS5dxWinAaeblvWgBfYXSbP+6aDePIy/2EdHG/ZBZNntBmzdtDtacjVNfR2OQOIzJzWzCiB50RV7A+LZmwaVBie5jGfMhcl2ZtFZHK7yyFmDutnjTq0dn38cyub4jDaWWPbD1dKdwSNC6lgEvXC14my9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773929127; c=relaxed/simple;
	bh=IDxMTmyFp5JAvGqsXBTQaMzuJh9LKoTdzZ3HCrN+bkU=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=EMrD3Ga+48Sg7so/eLBZhZrsvKDtm9HNJO1Ib4HuVdgtOjzTj6rIAtXD4iBiTCvx4mTD09Z3popK/+xovKCV1vyY+PosNP2ChZBcQPQOX6+u3O2zwF+MMm8zrPfGdJ5bIn0MiP34yesNNllIPfyTQ00ATDi5bBfuMIHLLGkctPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VxZTtrHB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xqEiEOTA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VxZTtrHB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xqEiEOTA"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J31Q0e975851;
	Thu, 19 Mar 2026 14:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=sfpsETJQwOsFJq7p8j
	1GYXGHVbWWw0nF6/RCxWUmnik=; b=VxZTtrHBPKXNTzb7051JSnzRfQq8vV/oaS
	kHp5SkgRHByo0iny7PUNdACkFE5HWFeWSjOgqyKErEO5MhtRoKbx1k327eLDW6xJ
	/6XZAnJcqXKEOBMU7SfRwt4DtdntRK3pBQy4Y/wIAfW4/SZwm4Z0ZGCbqMhfHDYn
	JWHH/I5yZotPCUKazJza4RVnu3++4gO+9IMZZ/F9QsH7vk6TmuRDt8glfbgMIdH+
	EEh7w1MTocS+VHGBNU6CBvDZ2S5m98IL/7zW7K6dWgTpHSO47EZsjQE5YxvznBaT
	tCAdFaXrVsjIucQl9I3zXxAXKMF610Pnnao2yBEg+auuJ56Su0+A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cw07rg09m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 14:05:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62JDi45x017938;
	Thu, 19 Mar 2026 14:05:04 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010029.outbound.protection.outlook.com [52.101.201.29])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4qj4sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 14:05:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkKvMhxSMhEhYKojjhhT3iYFEfUxXgZcCIWcOwKWZ5tywG+uGI00TNv/Qs75+590cb3uBZHC6X2J2d4ZmUcCMa38CWYI60lZ4k+yL7fGDhXLzsq5jp13szmhZvg/ba4eaMKJN8+/fHNo+JZZ3MHnsFPzlSKGcnMctmVw+s+VlXmScobC9C9kq6nh0j7c0CUpdFBBhufNxXqbTm/X0blLu6Ff79lB0+dPr4eT0KyMJsUv4g89SoUj06CZfNFCLs9yeBqZvPZKG+VV4fzi42kSDmRxWRtCaeWXdyf6/i8KP7/yRwg7EbEPEYprU8AVZfa7lvjG+U2kxW8Yia7zjtICdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfpsETJQwOsFJq7p8j1GYXGHVbWWw0nF6/RCxWUmnik=;
 b=hW2LfJniesXHW5kP+lzYaXDyVoqXCKHmitJV0nYHgxprBLKE37ysN1Vfpu/RkaKhLHn0Pqhytiq8HaXGiBM58jUEujSCcWuLXz3nh8QMjUahHDSm2jlCjUVE/Ndmsh0Y4d0QHBPgtqnC9XPF/LlNC1GLhBSCEOpqYQuW2Dufe1G+A/jDK/8rlcx90LsrxHpjSm/a4sgULiObdcpOuIublMN0dk1HiXb/qcNE2nsMR3pYmiv3W2BkDUGRQzrraUDxpL0GDo0/a+H3ojNjpa/twQJmi3I/m+rUltwD/LYMY26hITMi4MeneimfUjx2+1rZRpgj9eR4hQbvoTSaZR6gYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfpsETJQwOsFJq7p8j1GYXGHVbWWw0nF6/RCxWUmnik=;
 b=xqEiEOTAQ9bI1oZXhI5hVZCK6PwtrTQzSoySLmGs3RePRshJYijERZcvwbXB/cDQoIv5q5rgvAX+MRrxc7IJTs6C3+A4yNao4/3xvis5C5UJiLy628jMF8jFfIibXytSd0/ZWmisdWiu72+BNc8PPMvpvq2TEDKilu7REriuu4k=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by LV0PR10MB997684.namprd10.prod.outlook.com (2603:10b6:408:33f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.19; Thu, 19 Mar
 2026 14:05:01 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9723.018; Thu, 19 Mar 2026
 14:05:01 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] zloop: forget write cache on force removal
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260319060246.2084931-3-hch@lst.de> (Christoph Hellwig's
	message of "Thu, 19 Mar 2026 07:02:37 +0100")
Organization: Oracle Corporation
Message-ID: <yq18qbnnch1.fsf@ca-mkp.ca.oracle.com>
References: <20260319060246.2084931-1-hch@lst.de>
	<20260319060246.2084931-3-hch@lst.de>
Date: Thu, 19 Mar 2026 10:04:59 -0400
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::12) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|LV0PR10MB997684:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fa5280-c7e4-49cb-7fcf-08de85c08319
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dlCGTqSsOxqAQfiKMtvHMHXJCZQx8ajzAfgMs6o0AytzbBLYGTokR3jrx1ShNgFGjK2upReg6yBC4Zk7C2fNEg66TKNyMtl9N85FZOhud/M0gCWdUp4Cmj8udtEtbLTyO5FaRUCGFSVQ9KoBmAW170RQVUcLhE23TuLVACdbwY2oxcv3iOgm/zdYuoueHNonTd6aEp6oRTgOY5/k17q9kdk+dDN021w5j2VtPwTtl4HBFT7U5LZHaUCkhaIsmoCCabQNaWn5reyiibZ8BwAOIP20Cl7V3qeeRqMNoSy5LDMN4PQv4qVhiNNdFNJ5ik2bu5g5jvov4s/WquYog4XpoWaUgog4Fvxf814ktXasDJBWtbcp8v8ROxeKSaj0KYr6dIwHN0EbaJi0Vvx9dIj5E6gdbBC3VdfGiXb817RC0Qox9xrw9NnHDDWApLHOJ5gWaEA2fa4nXsCFZsPHAHyiihxEfWNTMLYgZm3p+rr3e6cSawLeEjpYHq67wCyrQMGXpIoVgh6n08uc7CRUSmzIHjQY6loky8XrODgkmgjraKY8uvrbtEa8bA7BqbUs1Z1Nb6xIN3aFbMnu1at1iqEAIDryfH01qcn9cUl4pnjhq0kOYAyBVJO3y3tHHGBY019uIfosm76gmH1DpDlIOYUCgxPt2pErva7/lx3NMyHYtRekZNR+dEnN9yGkSktBCrEOSfraBtd/6yYrcsjaNvjjItJBa9TB+IN1C0plym7/4eA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U8a4R9+/yYMGC/5VnbadEFrxZkh2oPo0Fb+dROUPu9qWnWcRsq+m7DKhYmfi?=
 =?us-ascii?Q?LggsboWJGhARWgwUlERgpptrMNKBSLIi4GmghwibbvoE85BbPHt/gfhcFVQR?=
 =?us-ascii?Q?v/gu8HzCTvVn/rWU/ePX2gbu/3azP1HxA1ChKkQXHVwBSKi4PGbJpdcWnMkw?=
 =?us-ascii?Q?xcbTwhTymwm5PzthDYvpUNnVE3UCqq6HM+ioI1uOuugWOn/zdZvs6yukzQWe?=
 =?us-ascii?Q?9G7rfKPbNXOe8R7QRrkXBJbrAErPP/d4RAJwVnTam4AylZvfg3qzTw9M24xt?=
 =?us-ascii?Q?PVVUWnwlayqcQ7ORCYG8NeRVvweJcYUpKWbsJ7h1KWqHGfBRRHZPNY1EIDOu?=
 =?us-ascii?Q?0ncqykzmVb9MOV9y0RmSKBKSIjXm6jyU1opm44PBxuD6dP+ZKHBbv/jEr0Ye?=
 =?us-ascii?Q?ZT5HeGBVB9klx+Uh9Qtm4WJMO4Mlb+kcUkvPVTTOhM2bMVdV6tmOqewgvUK4?=
 =?us-ascii?Q?q5bv3/n7iUrUz77NTwMcczKGtqaqIcCak9BCEKVtIYSptEp6h/Hz2gDVMzpl?=
 =?us-ascii?Q?CG6NweEhqgNkpm1N+0WcC2v5XIBiT1m/USloOZskIz2JVb7VsQE+/XOiPqVD?=
 =?us-ascii?Q?Qny805mUUkyz0xb/E4RqJazxTWXNXjhq0FaZp5oCN4gqn9Px1s34a+B9/wWI?=
 =?us-ascii?Q?r+h/oNAK5hh5d8zXFguJPHvVIBRRY4yOlUCE+7F1rj3Y6vsJJ9t7DmHDhpRP?=
 =?us-ascii?Q?ehc8ToP8uWaOuIzUX34u/iPCMKW4i/crqKXEiwi69997C+dm8MMN7MDEoZ1Q?=
 =?us-ascii?Q?D3/wMg4sd+AoWgbg4+N/KAUKjx4LDLPU2/SGqkhd+6oGThOERjUNO9tbYAma?=
 =?us-ascii?Q?g160t+UUyvYKlwTNCLktc7+vJkX3UH81kF6kvj57kZ0ByZ/QPnEAiab9hAIp?=
 =?us-ascii?Q?uUnt1iH2cN73z9zHfs/VMIklU8LhLLLKO5GxRVjVEsameGy00hGhZ+9bnxNy?=
 =?us-ascii?Q?4aSBes9dRvbuYywnnQGTDAP3pI3RbrbIivpt+VCXf0ShY1+4SKn+rs3L9CMg?=
 =?us-ascii?Q?gzSOpbrb13CL3HmkRfdCdKjr0hzj2aS/vwqgS94MQKJqfFjpuvVjz2Qy8mhC?=
 =?us-ascii?Q?mzwYC5C9CV5knGvdwIL16h0wJSg6yPeE9j9pYWNEBif0nkOb2dM3oDmBOu0j?=
 =?us-ascii?Q?ZZ+KgRJYx8UWqScD3jGKHzjogvCD0ps1jGQZndkOAQA0e89EYojlaE8WaNaP?=
 =?us-ascii?Q?eLpGUliRcS7+7nQAl4YMZ2HnrdujwfMnsOP0XEFq2jSxUGPA8UEsb54N2P3O?=
 =?us-ascii?Q?lx9vlyQJbEpnjRbr9VX3nzaxuz7z04tUvJdR6/NYuAlsxGxlDz5suRd0Wb1l?=
 =?us-ascii?Q?LvwymnzYjRUub6mhJoptLmpW0aoPZuVN4iOOPD64INvMP7Wjv8aKPuJEJMel?=
 =?us-ascii?Q?gBJC2y2HiBiAROTaNNwBe3VPAuEGnzIyBzUl0r+46rIt2HMLBSaOeMvvABLL?=
 =?us-ascii?Q?xvIFMMidZxr1xj8pRykVjIPwRub9Reou5GGGFv8BF9yIWsCRSFmm55WE6qfb?=
 =?us-ascii?Q?pua4bWRvI5pBzdEOKbr531KQUXVas7g2wTXy/wm0aKsYVO3lr2x0Xp1ushvt?=
 =?us-ascii?Q?LhXjfBolG8+O7LhBJS0r+5CyhATr1h0rTYBynn2siOhBifmBApIU/pwmgGrj?=
 =?us-ascii?Q?M7adSRORWL+jPa6wX+Z466DvnJ7DHChKyByt1R7P1GWmUPZwo1Cnpw33wf6u?=
 =?us-ascii?Q?uMZWssm/jXkLzbaw4biDDVLflbocFCOxGyyPjn82b93OZ++53yaUFioCfzBS?=
 =?us-ascii?Q?OagTchl2HSgwn4P23etoXEJNK20Z0xM=3D?=
X-Exchange-RoutingPolicyChecked:
	MRKmuFdzptKAlUla36Mf1bz7jBOkUisQpB83aZ0o19e6Tn7npUlswIKnZSoEAI4/VI1iKUz5ElhObltElBlPbpPEbGNGvRV72kkrlvTlBVWjK94LjpBh4T4p9txTNXcs7Buqyn/mm0p/pZHuyJ+IAkn0IWcSI6A5GZAwIqDuFo3gcMa4ibFuBKMqUMl6XSRmos8Ry1mY0G/rWG2rYFV7uQOs5Kt2d+gooFkF3Vw5zxWVfn0xhgCXh9hDAiLcvpVxaOIWA1M03+AwL03HdDz3oyIEdHW/jYMRuaReAvUOwpZUktPrq6YPOjcagH8dGCNsQ7qAYu+KM07sjbbxcyJj9w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zbcwAXFs0voL0Oc5Z61cYTRYLV+7WIC8HoQPgGbe0euhrnvJbms9wGtSBmLUDNkKMQEqelFMfhMTDWxoBl3Y6bSmkJ24w9Yd2NCVFfDCo9wxk0WHOaXB+qgsQdMtvIxm0fT8rknNu5XQEK5HG4tmlkgk1YBtpADrtfanbzfs3M8QJzpEFfy+kLnPWrqy69XIYwqZc/XtusX2OZq+M+D4otzEaPlheGSHlW8yeHaclhrMUFnKndH0Zm9+e71W0mNnKaigiIUII3HoNML/cYdgpAnYbhYLXtUFoKor4E1OVotKM39b3C6ap9s2+3UXQbq/qNFYvCOWasTAwYWQ2fVpd3+LXdTv0YGMxcYp3nWMRRUqU1UZzBIElq4n0tuDk5a/iMVaVEcLk29APyxKXV6zch502XxEzX5OVAOH8tizaoXrZ4aJqsY103liDueIdOhY+TODiM65rQyT1RsGC4ALPtxf73uRXINryLxyZMz0lFTiVTTiRzMO0bwZwT6civLapI5EnFihwfXa2oHYEgkaSJ61PzRatUcHrsUHoRYuDtx8Bd/Njxe3KbcNksY1D00TPztsCAnndb1hueDk8jt/J/FsAiJyqAwE1oP/O/jlj8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fa5280-c7e4-49cb-7fcf-08de85c08319
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 14:05:01.5991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mts/L5ceDI9rgm0jlFi/b0Pw/XNFGoKFvukQiTSJPAirpHaUKyT/aT2DZMexKVQdP9Mv9J7TFo52SgqPFeGl+6SUAzRBGJe/+MbUWtNGWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=904
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603190111
X-Authority-Analysis: v=2.4 cv=HcsZjyE8 c=1 sm=1 tr=0 ts=69bc0291 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=TcBs-eTr17GuGakdYwcA:9 cc=ntf
 awl=host:12273
X-Proofpoint-ORIG-GUID: In7XRSdGS_OgsWMpvjcEIVnJnY230KVN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDExMSBTYWx0ZWRfX7KW/8k0uJZ92
 H/7iyOiRFfeHY9RziJnS/S5J48VOhASd/ow+ipwl1v10GDD3ZRBZYLeCj/AeKJ7g9JulS7KA7RN
 B16/F46hktRJFwaXW6AJMqXaafTLBNe3K0fwfpvsYS4B1MRYVIX2F3hZHGOpUb9ykXYawnNDuLe
 QtmQ/UUdcMppjaqJGTkJONk5IPHx78NJXBX5x20AKGVDLi90WYrQ+KsBmhEgmoaMhnluviiAiYp
 cTNy6OAV00E2lnRRwCcFJMK1l9naoyZO95sspEmHCHCpMrzwhG2Iv19vjMmnemSWIEqjSkY3m2y
 9a6ek5ewnytZku6sMyrY65sSfOu/2OxCbXp89Pl8qRGUerk45Mxv4cy67VrsB0TDze0JuhZXrRp
 1FmOEPcgIKLjAMQibpBSIjcnIktV/8o9mrdtwBeuJOJFY0H4psXdqgOyTHPSqYoFD0IwZc7SYfS
 V/JkanL2nW5enXnDUM+l/nXyEwOlmH4T3LLcENzc=
X-Proofpoint-GUID: In7XRSdGS_OgsWMpvjcEIVnJnY230KVN


Christoph,

> +discard_write_cache   Discard all data that was not explicitly persisted using a
> +                      flush operation when the devie is removed by truncating
                                                  ^^^^^
                                                  device

Otherwise OK.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
