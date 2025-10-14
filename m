Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172BB24A046
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 21:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760476717; cv=fail; b=Ilb+3crROdzLyY9DZFxlhHsxh6f0jEQ/ztrAc38A7tEKBu9aZejZzF/P9wDTCqZhE7xzWf2dJPfRAItdZXBLUey6GvOWJ07vvlFpU7P0TXwEqbhRIuxDT1j4UyHFj/WOKIPNrv3foSgmp35B7el0IFGb21Xn6m90b1a4vhJHop4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760476717; c=relaxed/simple;
	bh=RnRsq7s5Fy16NSaPIy1fINTzl/sTLkZuCc8/mTTmyz8=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=Nm16xT5Ar9DNIf+wuCJS00wk/LCM0q3JZ+j6NNAa+f4oQxbs4ZQlcmMMdABWoacYEOL6e1S2UN2VQqi/Wd4EPLYp5y9OCuwMKfKh14TwKP9S+DPYKT9W6hRaYfMpvnguy2xrYMj5Srq9cIz+GYd850LwxgwcTGRfWwWT0XdHiss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d+EW0F/7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hJ9rX/EM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d+EW0F/7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hJ9rX/EM"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EEf6J5005812;
	Tue, 14 Oct 2025 21:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=yfkXv8qO1xI3cRXn7E
	wDcTZByOdfogkMKSAtzHQouWM=; b=d+EW0F/7IaMUWH/b6w/9L6gZ4bvOuExzK/
	HaCA+9RpItexJjHW0IC5TSlbpg+597v3r/Arp3bWXHKFA05wz+cLKX8bnOM3IfAC
	PcVW61MAakRQHEiE9mWXrAQugSMCkshzTV5iJIDEnv0RU1ewaYr3H4uT8+mfrpq9
	EBXs/INPFJnOPtBSNTxxoZrelPm6JdMwai4MINkcIgc5E5Ck/2RcGTgaPasM40Rz
	ANeO3GwSJDJ7qIjuUF8NJsNL64jqDz4qSsayzAp+UzywIUztNZmUvcUl636Ox8nr
	NeNp2unopdMtv0w+umPYxhSR9DEcMhano+LUPExIPSXJn7897I5Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qeuswa9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 21:18:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59EKBQPD009930;
	Tue, 14 Oct 2025 21:18:21 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpfge1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 21:18:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQECH92tbKpJOu0KtKSbIY/XzzQbY9A3Q9f1a4t+iQFftJ0hfOBS6pFPR3ar0hqVaVleOfqUmxg1HHnnCm63Yg7u3NRkrR5fhOXug39FCYwcjgZQmb8gr8UshcpRmmiyNuQiq2fGuJPzB6WfERo8yz1cpMOxrIo9Lk5/P9MwA5hiuDz55qEtK4RFWUpJ5jYL3vsT0iCCnwl5rUwzedHewrThY7ar+pt5SADTbEoWoveM/Q01XEDhY85a/ubvyl/lCr3g3PFtezIRFlnYay8m/vrF6MUS6yHvbcbTy2gCmjUPtpvq7mXIwE+Z/V4UD8GygzlOcg1oOR1zY486N+91Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfkXv8qO1xI3cRXn7EwDcTZByOdfogkMKSAtzHQouWM=;
 b=D9MwS4LXWP68CFtNZDstyoPUGszEz4PxZqcl1r9zw26S7Kx/iALAcdA3f1WMp1qjczmh/KigK8upHYfjNyS1teYyh/hFd43d8q/n59OLKM8IYq3PEXr+9YBahEO8/nOL0QfbT6O9YSF+xRKsVvOvUfdHsNDY+/XUFqTzmUaV1n0YxUsOpwgBiOrez2Spv4Hv7UnggEFifTZ0aCL5w5pk0JJA0uEl0tw54umuPkeLN0XxR3RGeuAhokbiuQdjNY2BEXIz/kZ87yWXOx31Jxi2iI5F2KKpEDQYouCDlEXgSG35wmgm/Q0KwRqfznGubiGMzFu9Etc2V6m09/ZPza9bSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfkXv8qO1xI3cRXn7EwDcTZByOdfogkMKSAtzHQouWM=;
 b=hJ9rX/EMuehkMsIVTtiUMTEJoI9nMb0CyZsyjHkbe9XtrLKboeypwW2B9SSXibsM3uhtD+tgP1wmW6OjHCyDRySeMbby8rUW7186yJsYnPaPZLq2RpHwCARxSZtrJa3cfow75LCwEt/zlFcMMZKPkUxKKJ748GKLMR7xfeStNHg=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CY8PR10MB7316.namprd10.prod.outlook.com (2603:10b6:930:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 21:18:17 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 21:18:17 +0000
To: Keith Busch <kbusch@meta.com>
Cc: <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251014150456.2219261-2-kbusch@meta.com> (Keith Busch's message
	of "Tue, 14 Oct 2025 08:04:55 -0700")
Organization: Oracle Corporation
Message-ID: <yq18qhdchdv.fsf@ca-mkp.ca.oracle.com>
References: <20251014150456.2219261-1-kbusch@meta.com>
	<20251014150456.2219261-2-kbusch@meta.com>
Date: Tue, 14 Oct 2025 17:18:15 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0102.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::38) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CY8PR10MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: da0c0b5f-73a5-49b6-df65-08de0b6731b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xdS1Ov5+Gix+z9av2aN1c4GKkJCt5LXJxMXcZnZHGEYjgNfgztHqyx1RXOcV?=
 =?us-ascii?Q?DBJTNoLJ7eyCqIhogRf6zS4VnYI50ic09IV2yW5yVxo/Ak+AmLpgYTSwlRDC?=
 =?us-ascii?Q?TeFGfGCM/HcmsS0vkwZyJjyfWLNux5I17xHdMbnlzFmnxwtfn8yRYynDbM09?=
 =?us-ascii?Q?t15guE01I72fSJl6I08LUZQYq7RusJPJvUxa4RG1AkU15CNewPaxJnlerHA1?=
 =?us-ascii?Q?mkfYcZthS0s141lL1NI1ybja30Ju9TuNWtP0rQRBvtDdcloEyraoGMYkjtqy?=
 =?us-ascii?Q?DWfODXnMoWdZ7mt9Y6bSWkLu3WxNO0z+iTYyg6ymu0ZJUhlw55iLUHVLxJdX?=
 =?us-ascii?Q?Oe3QoA6hhBQ+lmWY/MDGBXY/z9d9EHGY990zXwx++jFGWERgrkBtc8spPaI1?=
 =?us-ascii?Q?MmSR17r4j5cREK+ybpbUY4D/gGQHOtz+SGkrE23A0Lb2sgRDrHUQSAAsCriR?=
 =?us-ascii?Q?r7W49vQYPGFGQtOmkA2DiHZYN8Mo7ZoCAO5rDYn4RCNy/yWqwqigHc/BjjHe?=
 =?us-ascii?Q?QdLHiVdknUIKlyx8p150Aak4J1rnyOHUsh0/M/bzb3ewjhalGowENr4IV7HG?=
 =?us-ascii?Q?aMyNBiQOcglhHojifwyoJEWJ7FFFUhr9j0AmPDojhGe4CkywSZnj62fwfzz3?=
 =?us-ascii?Q?EjAZmEphDqYgNgDviweOl8W0vzcf0V5Z1jGufXfiVdvuRxgnzEU1w9cd2wR3?=
 =?us-ascii?Q?AZEW7R2eGYKuLakevO8M68s7w86muyxLVCFVcDFPolz7e+5QR+Boqq9nVCrM?=
 =?us-ascii?Q?A/JmWeMR5baNHjzK/ieo4gFv9pkGExquc0D0Xuhv2Z1p6VgmazeOnrnkRuWM?=
 =?us-ascii?Q?1wnM34y9AFbDhjie37bXo3HqHuOwD1NHHqwBW7hjmlr6+tBbF4osXvr5A4R/?=
 =?us-ascii?Q?1eA5K55c5MwRWxh34IooWvRDTQM6AvIz/0Di9QMgWsnL/EnJqlWIJrWgBRK/?=
 =?us-ascii?Q?G1doKEtihrpofB/TWAlQ1suou7WS3NH+nZrlIFquKhxLbvvhAioV7sio2AHU?=
 =?us-ascii?Q?ONjHnsY9mXBq59OLbAlaFOffLSmylpB8SLfUIAmDzbEayvUapbVnmMyuGZhV?=
 =?us-ascii?Q?uaJ2yBvVpxuf3N2WPxkOeaBOiR9bolgZNyJXesVvQP3HP8WXuUoj+VlDn+eH?=
 =?us-ascii?Q?u5OTYYCNCGWbAZDDZwAx7ljxNpTgYl8iTPLOdmffMky6iMbPC0rs+VLNS/gr?=
 =?us-ascii?Q?w3h+npKySC4vO0wkGkwmGwstQuHJN8KQhczUUfczly5QBoMavDLzVpTCU7DT?=
 =?us-ascii?Q?G3wY1lIuCz9gTQrkuojfz3D+8bPqX3PN3Vljb4SDfXOj57+gEuxZXGszbmmZ?=
 =?us-ascii?Q?zx2FUtoXYLGIsgBmdIzmSx3TI4ccsKUYWjW9n6k6LWXDKLdU6YVOjyhrLrDg?=
 =?us-ascii?Q?bEMrMbIczfpetkNEp7y0KTcrkOdrQybxIpbM4QwSF/HJA1rIm1P71Ljtv4QB?=
 =?us-ascii?Q?3lm/ec5GP9A9F4wHHyM8toVq/ns6XwDV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k0JYBFKCbsBNMYSYDh9tgxZd8YqHZM3dM0X2gN3+HJU8bNuWCKYsEjD1tK+0?=
 =?us-ascii?Q?5zMRscCwIed2069y/Mmkt8j0ZCR0jd4bDvfWidAETw/nNX22j2ELAI8rsqIe?=
 =?us-ascii?Q?6UwJj0Purp3+U+ufutd1WeS46+XTc4KbDJA2jnueAPQyBhng1LTwleJo/UuA?=
 =?us-ascii?Q?tmQe4q6ohefEcaGDQ30ODqSd4cSzoy+sjoxZx/ZE+/+xVj2KTevH/QS7ErNN?=
 =?us-ascii?Q?e6su6H5YNtbJ9bcfEja//qEpxhUjGfWkm+v+r7rtjUNYLF66D5pB74XPv1ga?=
 =?us-ascii?Q?26UwukiBsGq1lJ0UdXzXaF4JX4WJIWTd4w7bkdQqeV2me021z9Q6/tmpuq6t?=
 =?us-ascii?Q?SITVxoah1T+51ODB07OVXgPGf/cXbqSl8CO4mmmP59bp0CoyFgT1e+So9/3f?=
 =?us-ascii?Q?fKTMsCbAMjfjygBmCJwGrDZvHglfoR2cRo8KVCuJ6tnZjuzr8iQuSjHZKtBC?=
 =?us-ascii?Q?z2ELyzIwx1wPzJRrBnnfGpQczI4+gYcgEho6qdwJcJnkElNooo/Pm0+VCUmf?=
 =?us-ascii?Q?+ldTboL9T2sXWxVUz/fAxKOiKEoreI59pbvss84cvXOCQOV0rrJaXs/z8CSy?=
 =?us-ascii?Q?5H5ijVWEn9xJu4Ydmes7wvFm6TrZFr/nT19d2/NWg9C8Q3pXvBFwQKqWT6mJ?=
 =?us-ascii?Q?qtm4qn1zN4urQSTsWp6M/zs6Ce/mqMWKJNzkDQEbWsatZXYhDRAyDMc3CJ0L?=
 =?us-ascii?Q?v/PfZG+eCYUe8U8uVWJwjR+2clZSQMSKPY9jP5X8oq2hokNu7NaOo8wZUin1?=
 =?us-ascii?Q?UFEG/+Gd8uKH4SEHZspNnZiD07d9k3cDj9mst0m8yoUcXKankfpFqhVO13mX?=
 =?us-ascii?Q?HNNQ9JlcJwv4xner0ktCDwc8p1eYK/9FbQAdhkN0F6ajT5rseiHSfnNyR6KW?=
 =?us-ascii?Q?ewzpr9BSYEsZ/E8pfD+3C/epGD+RoeQYQMiQFlBCN456qSEFOZrl44xETTka?=
 =?us-ascii?Q?9TMVoDDgF037eQft2rGbms5zKx7e6LtZG30LIjgujnSgMqPE4fhtZBaZpv1z?=
 =?us-ascii?Q?BrtAJIXwNW0x5NyrjYVtXG+ZBj0ftOQf54Q+/NTo6K9V0EtfKFqg5Lzu8h0o?=
 =?us-ascii?Q?j100UtYJlyxD1GtX/jl2E17y6RUom6z7hF1mwnCbBnjIGx0atJd+H8Ozju76?=
 =?us-ascii?Q?zHyZfhQItpKs0wFA0rfcc7uWP2ui83cOb5qiolssfZLEmdC6GBW5znug9PsA?=
 =?us-ascii?Q?uop4k1fOcvGQchDTZ9fp6PnRFFe5rieC+mLbYo9lDd7TVBgKFGgQqdQ2VtEE?=
 =?us-ascii?Q?9Fg9DexsLUEHHxWue06ALpZuGD5Y589AOAF3+tX8qvlDBe/VEdvuQY3R+FXt?=
 =?us-ascii?Q?K5KVivUZA2up1ViTiBnjHcRWsJKXEP4+uZeLLxPFU+mHBneunKAOz4mTNCwu?=
 =?us-ascii?Q?prXrdLaySYq1BW6UxMIDU7vzFTg5Qf2pSryRw3GAxtmt74RTY2fVUCTS6U01?=
 =?us-ascii?Q?EevNlJBJAvjpXbgEMLvoLgoZh3JKm2T2ISW5+BZNi4V/3XOi3xOmvoKdwsgv?=
 =?us-ascii?Q?BpZbbE6fiopF+vw6c9raYvMsVV6iyTrf2OAxvB+YfpnPmiwNIMlNtPVQ8Nz8?=
 =?us-ascii?Q?uPf1DnrQ94UhhHnY2XnVsBvWcy5aqJD4JJuZ0WNh04+ri8jcYK2whUCs/mYk?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uGqY5bWbZDf6EDc8Od7lA9XWfqCy65xTyfvSk9e+zK+pgGsnank2n6LJt3lNAiG3+EsE1xxKFRtPkEJL25wS7cSSsD3jJkoTmO8dtrTL1hli0nFR9de/s3+jNnBMYiuRNYkeYioN66hqUA0+sEn+mZwy4HDZQw/0CSBN8MWI2/gbF6mN4YBvATa7NvWhgpgj6Xle6OvPVS0wQ4iG0/z737X/XFv0+yEuNH/KDUSMYe6M4evraHGfpBn7LmOzhFXahtuHoTuryGAUvhxh8OXTaNmpy+stQ3UeeTgPc+sh9CVOKcMl8p6TV9ikFZ0J01KMmVWbgt+cVSgFOEqHkFLhfBq51TsiO/hHRuQlzS9e8W1crIZmlDz94ZPK4BN8M/CWeRHUO5FHP7eJnv8JsYulLCnatH1OY8LxzLda6U8LXZ6k0s1uoesY/CGzQnWP8G7uZx2euSLshhubfHR+zgdZJdgziwDbRxxUh/wEnQkEpNWitefHZbtZmk6tAMRNM6nXck+EomfDP9FnF8n8sCGdLlhkintdPi+xhldUNLZjC3bwPfT99vMib1jM5ziQ629Sa6X88yrcR+kPK+6/J80zEE4/nXqT4A24vQjOE4I3CEI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0c0b5f-73a5-49b6-df65-08de0b6731b4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 21:18:17.8705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+KM8ckBjrP1604RWHynL6I9H6NLxNX7hp8AZP9++Hj/a34BqApXmFbgu4MGN+c/cmvHtXOACuY9lcu8tcTQU4OJlKBakaOQeZyMZZZHew4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510140145
X-Proofpoint-ORIG-GUID: e0VAxB8IT7bMzdYD0-N_PMzA58beZyCE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX3/gbB/vshLV9
 gV5E4tS521snzyrphGDk9BMV3me0o7vZ0klcWxUr+dOz/CFDAHtgJMD6TOFLcBKHCvf5y4pZzDY
 ispnce8/2upLBvsFTwoGSTH9fSh8lBw+aCFv3wiGmRhByNlHfgALvS9n6APLAp+DON9dNm6jQ70
 yTlD9orCSj0kiFL6zx9YxfUe+R1u+7/k4RmylQZFiureH/Vavy5DBayp20qB5VoYM5baL6m0bmc
 MvuA260ZuOZgSvcH6uqHO0Yc24sijlL85kebJJEOZUUyQ2f8k1dFyILGmGrT1k9LJYOzmxlcqbG
 0Sfk4/POq7OQbK7hU4DQvGWA0dJceb0xhALVs3AdQTbcjy7jJla2dxBiDUe9DDnR30gezSFe3sW
 Ec+aFeSVR2tQ0hiDzmJPe6fHnKOFYIPpwT2YMuiFd3KHrRY6xjo=
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=68eebe1e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=fadctHfkj4wiuBWLsVoA:9 a=zgiPjhLxNE0A:10 cc=ntf awl=host:12092
X-Proofpoint-GUID: e0VAxB8IT7bMzdYD0-N_PMzA58beZyCE


Keith,

> The blk-mq dma iterator has an optimization for requests that align to
> the device's iommu merge boundary. This boundary may be larger than
> the device's virtual boundary, but the code had been depending on that
> queue limit to know ahead of time if the request is guaranteed to
> align to that optimization.
>
> Rather than rely on that queue limit, which many devices may not
> report, save the lowest set bit of any boundary gap between each
> segment in the bio while checking the segments. The request stores the
> value for merging and quickly checking per io if the request can use
> iova optimizations.

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
