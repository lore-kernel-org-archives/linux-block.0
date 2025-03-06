Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2F82907
	for <linux-block@vger.kernel.org>; Thu,  6 Mar 2025 02:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228171; cv=fail; b=NT7ADcoqw+IRN26GWG0nkXRJNZuf5GbeWYnbt8j/oYRu4CLmdMU+0bfQgSsRkKzk4kDDL+EEZYEblM2gXgY1yFj7/PLCca22mWSK70tA20JJAzr4NF13nxnDZmDT+AjPWKSOMKSGEKqwocgVhFvQlsDUM5bjiaV+IwsL02OCIhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228171; c=relaxed/simple;
	bh=wRsStKTNZkAlB9PgXmvkLKWQIiTjBpORyVsfxfBUnCk=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=sYLFNhIsoiCW1zI6vHhp3Bv1hWj9IGL5ur2RJ2yBbcu6TvkVZwL3fTcUbMNyZq9mmTe9zr7dd0Un559w5Pj4Ecb2VFx8QAfZ7hv3dLagfUc11+5DTKGwrsN8t/knUiqAQ3i4GOM/etCQblESnoPiOBqgmm5E47Y/E1F93NN3jIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RtrlKbmN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Gm1O/5yF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RtrlKbmN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Gm1O/5yF"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5261tlm9007486;
	Thu, 6 Mar 2025 02:28:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=x6aHvpPqrmRV9foLut
	AaIwI079nwMpOnJ1R6vvkmCtY=; b=RtrlKbmNA8+4GyvEBU3zA5FzaTZi97mV+X
	sKtgyoR1ZcO71iKspPOwPxCeqe6qN7R2yduytMHylBzmYyVHPZbtBp867fNoFWsR
	vNdY21bPdrxHHG/oGMXQYUGMthEu58TUhZ6tt7E1ychVgKNdfEucc3WqcdkiXZWL
	WLvkxs4/lyIf6WRZ875p8v8QVi+MnujDAl7zCgHLCd7cuM8cAuRFzApnY0plFyas
	VlL/ua8wKGqu0+x6QvAXqPUBxFXqzjdTHXYKZd78RBr8zsc5cFMNrpZxi7g87EfD
	GBR87QFa5MbTb4JB8aoFOX0vrI2ejzzdb5aEP31OH7v7afFaZ/mg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u9qh919-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 02:28:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5260ZfuU011064;
	Thu, 6 Mar 2025 02:28:48 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpcxfd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 02:28:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUgXuQzpPLm7z5LPWz/STTsG6gEPJkm9PZrPTJSbToPQ3105Igc2TH8KKDmk9m2I2BhTXkpPOIX2rCYy+q8wyiQ6iLW79uOKV59d9SNDoNrT9tvA4XMt08e1aSRae69H/++3pE1nRpUfOTJGcHDA7MscCD/KFzu2wwdI7zHU9Os03jsKJcELH1hSk02FlDOh3kdAmCjJY2rtq2+ebvOt34O/gjn2z79xn9YbIRpUeeHXig8qpnS5GaqVy1U8u2KiawpqDSVt+eJLGyumPnRWtCJFusLzh9coejIDZzyHd4j9WAyVqzpgpn+g4r+ypgrgksAkyHM6GzZt9UJLbr+Mrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6aHvpPqrmRV9foLutAaIwI079nwMpOnJ1R6vvkmCtY=;
 b=GXAP0lPkOgAytugqLpeDQfRa5/BVntQoBMuTfgwD9o7ErFG3IAboKbasoDaDOG1RJoDiQ4VznT+FxqCDluwpOIrBGY8j8g5uGVRqUplb1xvSH9r2E+MsTxMVNJMpYk4jKvzOl1017xXLv6N73UALLAVVWBnYNFe8QhkEX52eZIOVqzn+Ay5cZkuI5eXrgvj6CAXfZFpCYniR3mVYS64xbpkOhqIzcsjT0u8eyMQ6I6XDcMZxTtTxp0AH9Euq5Vrw9jDuBEs4E5sxkR2amT9K5WonINEgjypRV3UfZ4wQ/FDcXPFPisVkmoRcNSg120gN2lOsqrF6Vv4kAIP+CkXdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6aHvpPqrmRV9foLutAaIwI079nwMpOnJ1R6vvkmCtY=;
 b=Gm1O/5yF7a4dYclvo4Hqf8HCq7s2MgK5BrmS4L33JfGGjFpBI0hAb5ck9K2ouA3971q+ZpOz2ljeUTR0Gi2oQcbHs/QfnYfOHLDPPaNnIeFP6c/tT7POkllWFv44W4NGtNMyFrKqyangijHafeJzM113vyGxVB5MPu6InspYzkU=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by BY5PR10MB4386.namprd10.prod.outlook.com (2603:10b6:a03:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Thu, 6 Mar
 2025 02:28:46 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 02:28:46 +0000
To: Milan Broz <gmazyland@gmail.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@infradead.org
Subject: Re: [PATCH] docs: sysfs-block: Clarify integrity sysfs attributes
 for non-PI metadata
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <8aaa0b97-ef9a-4bd8-8f8f-7c6869ff4c26@gmail.com> (Milan Broz's
	message of "Mon, 3 Mar 2025 19:52:48 +0100")
Organization: Oracle Corporation
Message-ID: <yq1pliuoqek.fsf@ca-mkp.ca.oracle.com>
References: <Z73kDfIkgu4v-c9W@infradead.org>
	<20250227144609.35568-1-gmazyland@gmail.com>
	<yq1mse2xdlk.fsf@ca-mkp.ca.oracle.com>
	<8aaa0b97-ef9a-4bd8-8f8f-7c6869ff4c26@gmail.com>
Date: Wed, 05 Mar 2025 21:28:44 -0500
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:408:e6::14) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|BY5PR10MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c849f8d-aa17-4e0d-9c32-08dd5c569edc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zD1PcpSPA2YA5oP0fhum6+wPyvZD0tcYyCuFVb9Ly8m/XAic+86f6QSNYkDi?=
 =?us-ascii?Q?qECePuisWgGglV68UpwXnuf0Quhinn7seik1z43tZPKxxZAPSHrsuuknAOLy?=
 =?us-ascii?Q?Z+xX3yxxBXtDeZ7Or1UZj2HkFHPxPikxbuGpvS4HDvLmwg84QZlb0BFIEd0c?=
 =?us-ascii?Q?33y/LDFhHjNbdBFKwD/sIQVb4aWf/Dhd9YR8PLmy2NxDba6d5wKfZCbmfqf1?=
 =?us-ascii?Q?bB076M2B4roduGBq/L8er7XRLjuFjgZX/OL4023wcIewBK6/NiQGn6vuo3rE?=
 =?us-ascii?Q?eqDcgoG+ufVv4qYx/aNuOsu2/2d6DMXvPVV761gIasWEMAGyBr0BHB8aM9mo?=
 =?us-ascii?Q?dvR7vL8+H4sSfsAdjr2lzPjsypZeV0S//9xf/UM3Nn34lcfebyDVfq0RSO+9?=
 =?us-ascii?Q?HCdgyq6kTTEZgJZkUsdkA7V7iARZol+THPyFAEZ6ych8fAJOhKA30FD4DY1x?=
 =?us-ascii?Q?XegZ7GanSUSfecFfOwq/seKKcjw446pNCSb7ydyKd8v8+1N2K7U5uscsMTTL?=
 =?us-ascii?Q?YujDI47cVH+spBy6KeZm38mKETL0fxpsr+C0dfrFT26Zxm9u3XQdBcv7I4Cr?=
 =?us-ascii?Q?5OvdgoxuHGYKIUwyPklJ74G4YzGzvDncfP8bQc/5D2h6bec1rzeWtm3O55h4?=
 =?us-ascii?Q?/qSSRCpJn5Ymb3wyevqam5ti9JsQSXDpWOy4vzeoZg78/jN7DKvxLAW/hOOQ?=
 =?us-ascii?Q?kFCpfzpWKGOw6logW69RlJ5wzV4bygam83S8VSnusprXWDtIcoWXEizOCCT+?=
 =?us-ascii?Q?xM2oZrKt64HpUhfxK8aOFDaIFKZdF30p81i77LH4j0dxfjW0TGv4IC35/R/V?=
 =?us-ascii?Q?j5dp0fnOdcZafX+974zDQpgDK3tehXSfVVlteh6SdxZN+cGOBP7lknlnZSYB?=
 =?us-ascii?Q?o/jNSPLOn3Stu3uxfIGjUaat3sEr4cFNQXX3UxxnX+Pai4YQ0YU9Q+gR5lp9?=
 =?us-ascii?Q?aEByl+ViiUZosOHSPToobMoQHBw8sEGo0iRC2QkqaSsMrtvPGngkVr/sPQUj?=
 =?us-ascii?Q?ZlMIORdrq1azeRgdxfHIJ896NTPTjdydKUewJn+U+6Lbtm2NxGn78hR6hXwp?=
 =?us-ascii?Q?hAVrJaoC4YLWhBYlrQ7g4p1zHGcVMuQ5hWwRwxnie9Mu71HroY6QoeV0FoBz?=
 =?us-ascii?Q?Sduqalwi4zc5VcyDSjYcWhLWweYwyokSbYspxCUz4aHu29cicpHae9YY2+TW?=
 =?us-ascii?Q?QLm5TOOi0CPc67MzCIFZyRAKXl+pPMso+h4rqH+p8QC2QrXCPHRf12MMnlmo?=
 =?us-ascii?Q?4ekCbV8dnkWkw9Yxkd0u6BomrvW+ihfu7d/CiWSUtYSEt9Z2bgXZChiipk2A?=
 =?us-ascii?Q?LGNSpK1Zzrn7MofFjet/nfEHCTJwf9sFAODXPxvYoZWpiK4cyzgCWAFKphGQ?=
 =?us-ascii?Q?ITABm/wMAOr3/sCRRHNFmq9vkzlh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?InAnxRHsxdvjFwbJunn3IskPYVP8h8IjaUGlvBzVRJCH0aS1fFbhl/2fQYu2?=
 =?us-ascii?Q?nfkJ4cH2mivY+kMlxDcaPtBGRwsicCVeyEN5TORuyxG2ZkXiJwxOLK7xog1Z?=
 =?us-ascii?Q?Z2TDw//kjiasD7CsetEAyXjJ6+QAkOO6jewQkGjU/0Ivp/me+WCcruC2EBDG?=
 =?us-ascii?Q?+EWpTb6QTblnZBPhvTcIjUH03DBEyUSho0FEmMKq8Qlk59BMwwLnRWIE6bUQ?=
 =?us-ascii?Q?F4mlrbNusU49awouuiMEnyCHsTx9ISImYZzeUojTrIvKFzea/GY/1hbDtPRd?=
 =?us-ascii?Q?Z/xLq7k9SmlfCmPfLOY6BQVbw6EkRLM2fAXFv4AegelJg2Qa+vlvSw9aT33+?=
 =?us-ascii?Q?4JzlOUrGNNPth70K5rQLMru5wF4qzWDTOPWZbu7TIluVOgwGt1pg3Oj+lBgM?=
 =?us-ascii?Q?9ARRbaq3QOgtiob9vbBGCm18OGiyJLwVVymrKbLhX+GXjDPEqy+ljEUNdQYp?=
 =?us-ascii?Q?wLeYrt/+xNfPi/HsKWpqNZdvYrrqPX45oIs0EvoUv4dKUL7YjQyxNWYs+BbC?=
 =?us-ascii?Q?SPRVGNRyDwx2zn7jukWERwQzWjOprLAO0jnuyX4W5iGnEx1ZWT5JaRYevXeK?=
 =?us-ascii?Q?L7eHc4UmIUIyILiF8mc65QsSvcwY/hUKbZPHY5cxOdPbljURyILmfCO81m6T?=
 =?us-ascii?Q?iCTo3cOzNywqPHPMAFD4AzQJKmQ8FwlteIcsdxXCxlP+lAyT+J+xj961v1X4?=
 =?us-ascii?Q?vVFcV2u4TkZBIx4BLklozt8AkZiuVJglg4rq9zp+gWEVUkKAOK11lcCZ2iIX?=
 =?us-ascii?Q?uwB8Ihy4qGzwf/qnS5ZdyLQGptm0I/8L/n2hvxevWHSyXznPdADODmM9C8ez?=
 =?us-ascii?Q?DIavXMh6ts1v/8pggDa4XUFObLGoArpcOPH3VYNCvty8igBD4EL3AIJVM85A?=
 =?us-ascii?Q?Cg+/A9qAoV6uYOTqsm8Ylx/ZvHz0wahOTGrYaVumz3zMgyv8PSOMt2HL7uBT?=
 =?us-ascii?Q?S/zzXzAv8pKK6SyRJ21b+1XTE9wIfNDoLAnmZ62FslON0QtgHZ/6+sywXifc?=
 =?us-ascii?Q?75ZgwWGVGNBRNoFA/QSuqjvOLbw/G2BoYxs4afbSfOGTuNBdTv6iQUxRLTvd?=
 =?us-ascii?Q?l3hdHlH8E4/N+6q0hHAJ0E4diSn+avTxcQ9oFea2ChCy5Nb32hNJ1D3K9ps3?=
 =?us-ascii?Q?Rtvmcq9F1GVCuswGyBlO4Hs2TT9eZ5+XrwyBBf9TCOvPSnX2sQ0WzFj9ElIw?=
 =?us-ascii?Q?NoYXbL79lwLJZObIz47k3IzRUTFMNQh8vy4ZgTuiM8nIIvfiNKi+nTUn+Aa1?=
 =?us-ascii?Q?IwlgAiEGqbx8hcW63mu2b0uJGT19vuKDbx7pGeuFZOV0cymjLWMVQGjkDRMw?=
 =?us-ascii?Q?1G+kKYH9daKXv9bEJG8F68UZaLQGdq0+Q96AEPF57mW5rWoxdTgB3jMlJGV6?=
 =?us-ascii?Q?bpcX/9vPVAEJy9+To6wAwFx1j0zhd1yc8DLlbeItzueoKc1oqsfpkHMuBgLX?=
 =?us-ascii?Q?5uQBVf+bIwKgHudOIz2f+XcDhUXNdYjMUZZ5VuN5q6cAzTr3FpyEfVWQGLYO?=
 =?us-ascii?Q?ifz6WLHp0azkDqaPoRYSalkhUyLkOYCGd6jM9OCRyHdBeJnruU//jHu37dLe?=
 =?us-ascii?Q?u4/FEAE9OZfpoHu9M6GHJrQ+XEQmu7n7twkhtA85CRfulGdbeC3rEIe9a0fY?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ti80EqAiP5QNYDxestpDTAXFyxAcWyMOyiLaItTI5W7DbRj3mxGkgfNoCMFfi+RsKTsukin1j2V7lZLSInRAGqTQ37TErVioNZwV2KB9xembLrf1vjNmX1mYJDRigLwwj//v8Bo4In5CSpi879gO+anV0xqR7dWMeH5XpRTNjcImcXdEaw4mTRYpUK/M+INhqhzHOTmxkDh1X96fjSWQJakb3LeaMw/M1CUghulpMAL2UdMEvd9rYaepLjsoLG1Ih7/PKgQKLpwS47XXI+VJK6uJvUVHBWsHHtBpYFNoPy0LOe5otCkYRWsBSlMpzRN4uEsYqq5xmcPcNvK+rEwYrTMExrnb51ogHHRXWCt3zYiibMOQLBcWU6UhBl9Gfuzm9SwZJEpi3Pvyv0mA9nh5Thfdh9DQ50e8xG3WAkK4CDfSOeo9bT08GTB814uYjogLRt4dKgrzoMq3ejLoMgpryiqPR+PB0Oms/WPWrjoQZ8Dq7nnSOqNTlmGEEH9FlYqrTXfTNEAeCbUlw1OOBAz9hkZXw+JPQKt6QvkFj3hSYp18lT7tLThgGwOXTK6CHO3qPjTiJWNe/DA6xwitOtbYYutUx3t7VhxpQiNJikeP6eo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c849f8d-aa17-4e0d-9c32-08dd5c569edc
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 02:28:46.0062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M3db7xyy8KhrXE4D/r/tcvnw8+PVh24i4oDYZp8nKi1aBolBrEf2XxfFcp4CI4OQgxNIdY6//09ZA6qpJAldf9nwvteUYYey6XPB8B69VgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4386
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_01,2025-03-05_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=687 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060016
X-Proofpoint-ORIG-GUID: _OZPrUZ_HQ9Sz_wVrSjtOS23RdaEN-QS
X-Proofpoint-GUID: _OZPrUZ_HQ9Sz_wVrSjtOS23RdaEN-QS


Milan,

> thanks for the clarification, should I just update the
> patch and add your signed-off line?

Feel free to tweak and submit. You can add a Co-developed-by tag, if you
wish.

> There can be "none" and "nop" here. My understanding was that "none"
> means the device does not support any metadata space (no T10 profile
> possible) while "nop" is that there is a metadata space but it is not
> used by any known T10 profile. Is it correct?

Looks like it, yes. We didn't originally register a profile unless the
device was capable. So the "nop" vs. "none" distinction is a recent
addition.

>  - a flag that device supports non-PI metadata (is it that "nop"
>  above?) If not, then there is no way to check for non-PI metadata for
>  non-NVMe devices (as metadata_bytes is present on NVMe only)

Currently, yes.

>  -  maximal size of usable metadata (currently NVMe metadata_bytes
>  field).

Aside from PI, SCSI doesn't support separate metadata. It does, however,
support larger logical block sizes. So 520, 524, 528, etc. And those
block sizes may be accompanied by 8 bytes of PI. But the non-PI metadata
is considered part of the logical block data and not a separate entity
like in NVMe.

So until NVMe happened, we didn't have a situation where we could
actually have non-PI metadata in a buffer separate from the data. And
the block integrity interface still reflects that.

> I think that metadata_bytes would be enough, if supported for all
> block devices (note we emulate metadata in dm-integrity, so it should
> be set there too).

That's fine with me. I do prefer to distinguish between PI and non-PI
metadata. Even though they may be sharing a buffer in the NVMe case.

-- 
Martin K. Petersen	Oracle Linux Engineering
