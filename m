Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B700126AE4
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723739576; cv=fail; b=XXNHYU+7FJo6eIMQ62QLLcSHir4DclN/fgO4OhiRInZvrFe5wPmOCsjJ/Bxh4GISDOKjVZXRmefxEUbosD1FJF/1DjwMeZDoUj73WD00Fh7boj6QPXGvGxvQLPSwpZD6N5a9OUL08vGp4trCy1NBXRioohheU2KxLEOtiWRUG78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723739576; c=relaxed/simple;
	bh=vZsKXUImDUmSjjxiIVKfnZq5E/xmBWOd1u5z5x7oAP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a9MNzQZQr6FGviifdbyRjCBUcR0tZHhH0q2hWneSt1UGIYdycG/I7/QDP66ATEzxad7AHG6R84VBChSTABBsu0RTVPTG2L5Sve+66z+bPHjPvrDUfanqFHb40BZ3YpbDQw6evNWoyzw4ffyJgBc2u/ngGFLseSmsZsKU18MfRBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HzGnAThq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jmTot62X; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HzGnAThq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jmTot62X"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FEtVkV017293;
	Thu, 15 Aug 2024 16:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=zvgvuquGlqEuHavG0Un4GC6OkcKEmznPohqoWVTUl3k=; b=
	HzGnAThqc3sXd8qxr6WzUj9/Ni90YJCB3ar9ens3bVdAwa1C8SKadke2VktiHGWC
	w21BsEDGvFNRoMzGpebu+t30eOJXAJJ8+s4bn82a0l+MK0iLwFGkN2suo/yeaktd
	2+nkJNFt79uhNh/vFggGZ3qw0bO+XNTYZvOmnN4123FLmeESWYJR9OwgeHd0W2/P
	5NXGyDON1dodMo7GWvICDixEiE5kHyTbKlcpcuy7IGWqq5Y/+2YeMS5GzsdeD588
	ntVb1GCw/zj1WIAqM8SPlF4p1PZJSPlS3HlG9cMgNdK351bznxJpUhLya45cnDjg
	6FX0styYClLXXquGMG94Hg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wyttjx9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 16:32:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47FGUCI2000747;
	Thu, 15 Aug 2024 16:32:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnb8m02-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 16:32:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abQF/fQgxLHRZfRwK3yA58jN2SoscvOgJbLQBD0q2Scb9n0t0j4uxFE62rybB4X6w0t3jx9A4dA55gxxQfnRSvTnbtThnn/ensMnGZa+8R3DimoGkWtRX1d4xukTUv0+O6WTuK28reK9I8HSCWdER598mhx1FKXNhZdBVn2d1AiIgQK2X6USOfh7Qy9OTixHKFy6WIxO3xoGuO4eGlou2HQQpPX44qsumjrd0fhFord1aUZhElokxBv0PdzliLazr2nc4ukH7+6OM1yJU1AU4RXXEF0OeuTDnbbh1/kUbgt9pudp/b8pE4eXym7Czv80W/J/P9sP1ssSwdxHfCmpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvgvuquGlqEuHavG0Un4GC6OkcKEmznPohqoWVTUl3k=;
 b=TCB+FZOlwA2nYfMuLbbfDZ6diEaMvDK6XJDhxFgF+a/hvy3d4zYfXNAAyHQ+4eAXLHIUTT3koTncpVBTIn/2NEGdKZh1WhJYRyWfYsHsS65tV7TreFV+sgTRkXLrYKbf875F7JJnvSoCOFJ+p5BdGcTA/VMfgGv7pnv00Y7fWPBQqXS60O3H9dSwOUoOsK+wjua+wOx7S+3mKLK7piCrPLl7yAtxENM4UGFDow5cLE17XHysVX6xvx5hvMFuun5GeTFk7eYwQQEiGJg5XsHeoHxicR+uU8fBvQhetdvFTrsBKh9xiJQnIKOUVBaPxcLf4mvmkErl6zLPviJHwV3JUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvgvuquGlqEuHavG0Un4GC6OkcKEmznPohqoWVTUl3k=;
 b=jmTot62XEoM6Xk8yyE7CBbwEy8HjqjIlEIJYs2mCZWBS/AOyaFF+deBDf6XjiYXP9Q5aMHzBQfAsNUDyz/VKh7bEnBS499Tn2G08/VO/4Nrs7L9xQdzGz16wS64SEH5kLUDJkik2Un7Mmw1wu8xcGFv307+GHAXEmz1743nXeQQ=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by DS0PR10MB7247.namprd10.prod.outlook.com (2603:10b6:8:fb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.15; Thu, 15 Aug
 2024 16:32:44 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.7897.009; Thu, 15 Aug 2024
 16:32:44 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: martin.petersen@oracle.com, linux-block@vger.kernel.org, kbusch@kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 2/2] block: Drop NULL check in bdev_write_zeroes_sectors()
Date: Thu, 15 Aug 2024 16:32:28 +0000
Message-Id: <20240815163228.216051-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240815163228.216051-1-john.g.garry@oracle.com>
References: <20240815163228.216051-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:254::24) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|DS0PR10MB7247:EE_
X-MS-Office365-Filtering-Correlation-Id: 52506431-a954-43d3-6924-08dcbd47e41b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5dBkjI7ptr2mzv0kTaXy1XrvDkE+FWThoxmSpRGmXHvHgLkvVgOjgWVPhYq4?=
 =?us-ascii?Q?BH0vIQ8JKO9h599wB8aXUCqN8ZjRP4oh8dX4oPBbDoA0HWAV4hQaMHcHUup6?=
 =?us-ascii?Q?xiLQXf5vJwLjOKvXsTIwmT4mUD1iKLGpgcRdqOwtpbjnPKXO1NB6nXjGI27y?=
 =?us-ascii?Q?V57nlU8gb4oKGKvGVDjVlJz0Lad6/T1TlKmzQe2sf/moloVN8EIQGzI+tlj9?=
 =?us-ascii?Q?tQHl6LLeAFO4kZVFZdAWR1ItDklsvGzWgyUxfhXTerVpVCLkmAZpmXkbeMWG?=
 =?us-ascii?Q?ik1WyV6N2x51AibimV3F04Q6GTsHFk4ZMLbTc2IbfFsM6w0orxF7LOjZ3Frk?=
 =?us-ascii?Q?USdhRu6gsSyoi8wb+vI7olNlEPgJoG3MTcFY9iXbflKXwnZBMJwBs30ZDW8f?=
 =?us-ascii?Q?umm+VG0ggIx+jXjcP1HzEv0F7uXQeEEHjSqOW62FaSeArJ/4B6XkgtVxoele?=
 =?us-ascii?Q?F397NhjvHYNYDMBSGwgwB6FYq7vu5utkBgl3DbvZBmZs2a6nXTcnoL3LvJRT?=
 =?us-ascii?Q?xZvDG8K2CatLqBnvFr+oOxgkKAUdRVwKsMdasH0AHUGs2+N3D68iypHYx/Ar?=
 =?us-ascii?Q?tLrk1dy5Sy0GJ0Sk40+pmiF7ZtEFDSZJUoJetWJSTIevJbQFRkP4eS0Lh6gd?=
 =?us-ascii?Q?fTeUHBpOOxcSlyfnR/RR4WsR3s+8RIllhSgtqoG8TpNqJvawDSZppgQglfPa?=
 =?us-ascii?Q?nMsXCIkNCqJEh9c/amgdisnt5JhnH9c3IQ0FcQnfBMj20flARldMV8pKf6rZ?=
 =?us-ascii?Q?TKskv7TVzOntR9wdYNX8v5Jdwr++MtVyeWelGtQuC32qQP2ZqkfoBrR+BcXZ?=
 =?us-ascii?Q?nPgccuxmim+EJDjn7X8u4ylVdCCTEiLJlWB8v3ZMk2oEuOYGlj4/4CMViybU?=
 =?us-ascii?Q?+V01XbF9rd0UvCUJ/o0cSJHchIGZrnrm8j7ZHx2PTl/aY92Tc1fMcUDCZ+w/?=
 =?us-ascii?Q?s6yu8nGeyWqJQx4lfHCLPhjGX1Xy8qs8yLIchJFoIz6bWTmgnQ/lng17woSu?=
 =?us-ascii?Q?JZHVrE4LdB4Ew5F9Q4j4Aw8BIr4b2JfqCnNKAWWCn0RhyqynchsjqLfWlW/U?=
 =?us-ascii?Q?e0yqTqUCSoM2iyTFwUHhpppXl8HEdsmBJap2pjmxxDIK5FOUI/KIVVY4AmlF?=
 =?us-ascii?Q?i41vhZWA0oiNuIguqQGq2sVbIDDafR8fvmbxJz2xzNxHfqx8M4NLKRysgwhZ?=
 =?us-ascii?Q?08N+FKLu3HznbhzPJxcZ508np0y8J5Odu4Vl86lH/R0TNdgWxjT/GI+YaCTL?=
 =?us-ascii?Q?JczsgY17rJGMG3ixWx4sxEJhGu9CP+4YpWDh9HOWh36F+X7fxAMyEOo6fjdF?=
 =?us-ascii?Q?DDfU5XOCqNflSkp5zOvpKoABp+mX8grvalE3t86usL0fSg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/E/IUDENkUtlAN7Qy3XcCQp2Z0lriAV5QugWhNEMIRAAhN+X9f3pjv+s38Bh?=
 =?us-ascii?Q?IxixO6N49/hnqyEjruzZhi2jioFOJTuWbn6bI0xQVjtms4v1cph+3Y9vJS7z?=
 =?us-ascii?Q?zED+hv7GeFhaonjNdU9P15/LP9hgfjBWOJpbOi1lAMgMMc/+iWl14ktSlmr/?=
 =?us-ascii?Q?2YV5K4o1V7eHhrxG0INnk25V2snD7Elqpgr8QC0PAFEPqq+EO420sLGjnRNB?=
 =?us-ascii?Q?jd6f7oFX6q72YRJPuqx2ORoYR9OIWS86HpVS79J+Rr/S8Ftp2TR1o3q2KJ+X?=
 =?us-ascii?Q?b0/Jn5FyEmmVsGuysezQi47RBzpXU0TEft3Mm+YQ4AMQIfQXtqGZcoBbkgx7?=
 =?us-ascii?Q?6AC95XIrfBxLkSSiA8EQCN/k5kwyQSfZK08L4yYvapAZPCApiZKpgLE1ZGah?=
 =?us-ascii?Q?ihpJYd7MUYsDXko5uCw5JqxybEUck5MwkawHB6fteVT7mqnEQcj75dY4thWX?=
 =?us-ascii?Q?wYWFEwB2tt5U1gXZF10VFMjevOYbNbETvWsCwgn0RDCXrMnXCPCyzssx7qKo?=
 =?us-ascii?Q?PruIO9J/06BZrr8gkxTagabjKiNqYvGJIpFW9hnBaQgb8lyL5ay4adv3nEzc?=
 =?us-ascii?Q?6/ig/6D9rL7NubOBP617Lz/CJrpTBa2tiR5WmbXgMbXgF9UU9twgrXYmUcIR?=
 =?us-ascii?Q?a/PWjDDXpujAbFAWsnkwEqu4vJB4o4+Czjn81VBXHVeNfPsz5X9P36dJo7Eh?=
 =?us-ascii?Q?DxoTk71png+6BMd1kIqECPaQ7DcH7766yyyoojg2angJhx4ZD/zRIjCAeWeH?=
 =?us-ascii?Q?hkyS03x4nTuXahxjBkut9xHk9WQ8gLVfjckTzF2qx6wiC2G6KNjzUy22sHtx?=
 =?us-ascii?Q?zj9GL1HJRJvZyv8xI4pK4j1plzejiEjEC+9NF5Vi92z19GjaYtksSxR6IIgq?=
 =?us-ascii?Q?QaAkoxkMzD0L/QUIPpRIHjxhdA3fg3o9TUK8pfw4saZQmIeWXWBSo3jhd0ts?=
 =?us-ascii?Q?4QQlJnAm/MH/yQC0hdaORDHMqaQrhK11GympLrrpAHRIe5lswOrexp4NEHIz?=
 =?us-ascii?Q?o7augPcggPVLE8GWdhBb88xduORLTqGbQlBEIVATpMbdSn4yPkmVKDGL//B4?=
 =?us-ascii?Q?ZQLzyslt9rCoMwKy2iWtcgjCm3zNYPs/FW/WzyjUO3m63mkGqU9XjR+snwHy?=
 =?us-ascii?Q?eC9WRqVhgRxJxVtgppkSfACeU9U8Fbn55cYfk6Dvun/dA+WwLe55/PBKBbqL?=
 =?us-ascii?Q?Ww6A4+f3DxPYJ7mWnTDfMOARrGd8bf5w6qF97cdz/Q5DxWcVcLePWtunpDns?=
 =?us-ascii?Q?W714pEeAh2ZFmTeYNFold90Mzh+Z0xzVeVP2UL/5HGq/qFS0CdpZjbtM5Pse?=
 =?us-ascii?Q?xTzke3UZ7XYp2k/AXdInEyh1+y0aa/SpMKr22TQ4iAYYJTYTqe7R0LMzYp3M?=
 =?us-ascii?Q?ROgDsfH5UpSz0/uwP+yC2kZJMIC2e3wMWqJV5h5yHULJfaJnwEovHmCsU6zY?=
 =?us-ascii?Q?kLtHQ2Tccy4XxdvLn2IltdPEoR2hAB6uhMfOALH/UReOr+mR6QqXh2RfiziM?=
 =?us-ascii?Q?Dw19aUlw42VDM623MC6nlncNsxltuGqt4Q+rkQtCmnFwu4ge7lyBzMoySMKK?=
 =?us-ascii?Q?z8MONcwHRUtx44Ks6xkwbDAPe56Nmqu3+T2clqtWUuUusUgDCXSmYSPwuoqg?=
 =?us-ascii?Q?9Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p4VgLM11UKhXsX4XVcDajrZyh4gNj2Llo1aNWX2dVxQGUrRdsCqF8uHGZ5uXKLV0eSQ+nc3cZd3kdOthzyO/K8WrMXTo43QdgSOv5mboUcupdrk8pe8PV1UJj/h/yxHmdsBpbM1uH77q/JYheT0+uQj4AxYADfySDD6w/ipd8e++zMelhCCRaeGBzw7xkK/mKOxjt0IRb2Lxa6lUokqoyBjNEIK2LL8Mxre8+lI+lS3faZN2GyWjr4C3R4S+s5LPcQs8hTsOtoPJaV2qIqcibRuy6wbIRm35TXTQIGxxQyDEVWMpAkSuveBEs1RBT8tr+Gfn+3zBYzt3rQwV0ErVyVgWi2zVGWrMM7i5uTeMQmU1oJxBNDIe6qu8swZa9WAbC5vpKw5B6VPPDo+kMO45WmfXc7pTtkSvDGVPAbsVqJ88H6UygpwPvbtK9yHiS57oclIpwalf8vlP2lkFr6nl3Abm2bxRpVoNhpsMHXDsK0xivmNsegNdEiZRBW4F5/TyUtoYJKphL6cPLVYI77CW1T2MB2uhnnlRaRjMItv77fmgrPp4AzWramJ275EFBmw4f+bhGm7GMHIsch0K4pt5zdSRgLqlDGWhh5Lo5aFk3ow=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52506431-a954-43d3-6924-08dcbd47e41b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 16:32:44.8289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCM2fKE3GAwtePvrW7uYtAResrSFjXohqDlecao+MLQfKjXkIuXeavB8UYrYUJ3ZiUa9rrSSJWxoD42wjTtI7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7247
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_09,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408150120
X-Proofpoint-ORIG-GUID: boLTiuo4iLxsIFkzk6D27mA3FMa12TuZ
X-Proofpoint-GUID: boLTiuo4iLxsIFkzk6D27mA3FMa12TuZ

Function bdev_get_queue() must not return NULL, so drop the check in
bdev_write_zeroes_sectors().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/blkdev.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e85ec73a07d5..b7664d593486 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1296,12 +1296,7 @@ bdev_max_secure_erase_sectors(struct block_device *bdev)
 
 static inline unsigned int bdev_write_zeroes_sectors(struct block_device *bdev)
 {
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (q)
-		return q->limits.max_write_zeroes_sectors;
-
-	return 0;
+	return bdev_get_queue(bdev)->limits.max_write_zeroes_sectors;
 }
 
 static inline bool bdev_nonrot(struct block_device *bdev)
-- 
2.31.1

