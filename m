Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A6423CE
	for <linux-block@vger.kernel.org>; Wed,  6 Aug 2025 02:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754448723; cv=fail; b=ZBWVwH9ClZ1+KqN/0za0ttZjNAEaf6WQ9fhJqOJyNhNzuB9Gq7gj917wm6HDAPurzf4ZvMRUYYojMUfg3X+TNaLOgmkBwfrZHfKUWL4Qv70OfHTnmkDcYi0LyGIxsjrCxqzn14MAh4LEzjse6KG+of9aFYmgQvdJE/48tUkfSzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754448723; c=relaxed/simple;
	bh=VSLsKyaWFkV3GPDy9N/6i+L+17AbGhj0cnudAJhdsso=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=UW4SXUp45LHbpXVKon9RZyW6D2nMeKk2zGJezDdgvKvd2uC0+Mrh8bDd4/OOnNEtSGxx1ovXdB4XjrMW2rurax7c1oSOXBRwja8EcELiLPvVHsTnJLsc5gok5PebLMJpwKv+G33/eshSSkJXNZ7EkXE+hfzuwq11nOdjixNyqjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=efgZgRpK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PFmwyGF4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="efgZgRpK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PFmwyGF4"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5761uKfo031943;
	Wed, 6 Aug 2025 02:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=tMrNTRJZuDNSmmcd4b
	3//B0DbqlLt8ATdA09juHgmjY=; b=efgZgRpK+tjjuWY3fIqkyqfLK3gGH2OVEl
	+ATt/LpU0izjefwwG/Ydb9ylQs9kGz8kY1FXO330CCp9rHt3wgM8KcHMOrOPyNZN
	UOlsyXemaRfOCegB9bWWS14fED+IVKaa6c/cgezmcoXMXZr4RNUFdUvHU3um99tT
	t0Q7GXdx/QvCd+3mwOUF2egP5mOwxWs0ZEYOhBh5vRDEIc6D7um0eOd37A8e7cf0
	TlaRkVOptJaFiDcrWCGbRimnYmOL9asRoIXR7fohgv2zQz0f1TQKtvEz2AkhVUbT
	N+F4TcYGossXNIKj8UaqFr2MqlO+wC64HYWVmFsCbjp8qXdIfTNQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvgrmxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 02:51:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 575NRUEB018341;
	Wed, 6 Aug 2025 02:51:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwqefmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 02:51:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+IgvoEnes3hzQKEkEYvFODJDhbnIqReSVJF2jegDIyRB70FaBiyva7uU8sAwpFhOsFIIOjoA4fX4mmJHRgRryOdwYigWBCBLuDlhGcWj59gP/xzvmddAAZ6vvaAwwHgBhUx43VytteuJZieslrFcEQk0qshFEN6gbA/N0DfmuU1hYFL7biNEsDyulSME1LCN2VipeG2n3yhk8lJRpdHKDrYk/pWHMeU1efZH+wofXhHDAUUPQM9VWcS+PIiUYik+QK+nlBjG+soWMPNTZ/9JCstXwhnw4CV/ulGfmUuzukybrKPScctocJcsWMA+yLuJe1j6IHx13lW2YAoLxIziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMrNTRJZuDNSmmcd4b3//B0DbqlLt8ATdA09juHgmjY=;
 b=hoKfuPrH3nPlJL5ld6D+REcxcNurSznryRtg5e81cVEzoEv3zqsSSEVrIP2UVTHnXB3AoGwAuRnWobAWXR6nzM+91CA4D7CW/87KsyVNLUuGKhmfN9/246gmV2cqfHVbpJpkiRHod8wrR8xSGRG/BQOvMzlLNgW2T1ujUJfgDP+r7CDu5SmqbXSFT6/TCgZZRB9hkyeYPrmZ6rWfZRjK9NCYxG9s5q/JYP4ebjgr+iSauDxXaYl020KgQ00AdHSA4A2yr49Bkpc4xTyq+DxUpBG+v3hXndCW/saea3nt7xWx6c8mR4ClLOeVasATJIJSQD60Td4D9+TZ9Ma0tEzrBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMrNTRJZuDNSmmcd4b3//B0DbqlLt8ATdA09juHgmjY=;
 b=PFmwyGF4AUjsq7iLGUpR3n3Qfm9sAl5BGdv9QA730KLl5Gl2EoLd/HT+zvxHmrYdQA+TTPIPig0v7aJap3Bxl6UjPsaWXhBWBvkK8zo2lIBFDVXkL5l+5Lz37LfBijswpqO94pcab3W6X4Clmr+Emk+6D7givgxwPJWyxwjC12Y=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH0PR10MB7077.namprd10.prod.outlook.com (2603:10b6:510:286::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 02:51:49 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8989.018; Wed, 6 Aug 2025
 02:51:49 +0000
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, anuj1072538@gmail.com, axboe@kernel.dk,
        hch@infradead.org, martin.petersen@oracle.com,
        shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
        joshi.k@samsung.com, gost.dev@samsung.com
Subject: Re: [blktests v1] block: add test for io_uring Protection
 Information (PI) interface using FS_IOC_GETLBMD_CAP
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250805061655.65690-1-anuj20.g@samsung.com> (Anuj Gupta's
	message of "Tue, 5 Aug 2025 11:46:55 +0530")
Organization: Oracle Corporation
Message-ID: <yq17bzh9n8i.fsf@ca-mkp.ca.oracle.com>
References: <CGME20250805061730epcas5p4ae7a8eda6d1d11cc90317a80738eb2ea@epcas5p4.samsung.com>
	<20250805061655.65690-1-anuj20.g@samsung.com>
Date: Tue, 05 Aug 2025 22:51:47 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:510:23d::8) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH0PR10MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3b6f27-d7fd-476c-a9d2-08ddd49430c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CJURyudmaw20wTUI5xsBl1DN9X4bzZZbZzvjBpSMi+iIM/Q4kMM6PkC3gkwu?=
 =?us-ascii?Q?pn8PGxtmuQriDQyMx8eabgSJf7OUn/Ga0YMFjqB4jF91dZbWL7ZGbZnbmsjP?=
 =?us-ascii?Q?fW0niIDfkssAq2laWzyU5OFssvVfxZuc3dC5ctelXREMcxYsPxKD7R8HU1ex?=
 =?us-ascii?Q?KS4XQq3PMA0gTaBN8v6jbQwyVMAyXtlkCU37B1BbVdfIgeyxCdF2F8ciRyKs?=
 =?us-ascii?Q?rSoDWgJF54ae7Ebg+d3NFffuoRUaocc/ELssfb+j6GYFsncvQ00Z9N9e8o2L?=
 =?us-ascii?Q?K+xikNoytThE1RygCHRD5jr9xTzqhUGxp01NH7fWpLTvYME5wgXPEqYXkH/i?=
 =?us-ascii?Q?gUlmFo4YDMq+cgyj2bYeWhriGiiUw8uXADxKuUxEdysZroLhkxXfpACdgVHO?=
 =?us-ascii?Q?XS5j2OT3QTQ+OMvuvBE/ZZdss2Zp5AQcCnlafIx07C9kqdtPnHd+A6k2mjUt?=
 =?us-ascii?Q?6hkS4Z1Q8R/SdPPmK59t4bl7/92B0fk9cpdW14XeCe9aBakPkbnspLCmFeZl?=
 =?us-ascii?Q?1PF5034F6dtMF0S9ZnwNCVawRJTmXcyjeBL83wggxjjw8ospGPW/5YriY2hz?=
 =?us-ascii?Q?jK+FOAoeQFANfLekMNymGrjDRDEyiWKasHDktyXfVcahv2V0r/PYnumtGJ5+?=
 =?us-ascii?Q?yzHs+HUw8tpbHsWGDnjZZlEQ690bnb4DZ/0VK5/U7DZ0pAKCwHeT7td9vGmP?=
 =?us-ascii?Q?sHxV+jqE76Bo0e6jIIE2ZOcgMKGJYDJPqVG3VNmcGsTIlrvRg/6dwGj1ZD7z?=
 =?us-ascii?Q?58BPHTZ2ifui8uaJgt1M5j/5Gk6aRN/9LopWe3504fWHguawN/nopWsn4J5T?=
 =?us-ascii?Q?bIZ31/uPAQKt3cuQu7Kwt7EA+06Ilwoee03lyHWM62fAVkWyGu4cdfdZ4KoQ?=
 =?us-ascii?Q?gPoRbkrds7kdru9SOtIz/ppI69UnyuwWizqp/mLx63tpaDZGbKUzWeGLKV6K?=
 =?us-ascii?Q?4FKG9h4AMRyy7pohYKnII+7ep+4b6qsW0G1KW3tDeyzPWxs/njpvSU0A4fhz?=
 =?us-ascii?Q?N+mHNDrWk2joKAD16t4t2k9g69DmZvwrqc9J+oTm9ilE4OyrXmIUDNIRhdTe?=
 =?us-ascii?Q?e6zySLOyyrAqSDQAqLlWBRJxp6TzwPPKRNql0Ub7vrkX4G6xWsHUTuBFl0ho?=
 =?us-ascii?Q?y3Ue0zzmwJ6B7Xh5o5s6b2s7pxCTVjzotfXtRSc71J0inRqM2lNVzHLvexaK?=
 =?us-ascii?Q?ow+LujDBzbox6Asi5/doJPiST0mCaGPa3jgp84EwyTALzvbBu8OjwXVEjfxp?=
 =?us-ascii?Q?OzL0nQuylCsv8RA0XVNh6U8sWvNC8l+H+6cQKTv+TxMDbfbLyl28hjJ86pN9?=
 =?us-ascii?Q?BnN8Mb0sdJRmT78+PfBHP95QYLkaRbAMHTVulKZmb0xpHtzS1WTNLO0MsQyz?=
 =?us-ascii?Q?ZOGWBtnTX9A+1185kH5lBGvwuFwS0aGrykdyzSx9gpoXjRIssEa2SOBnBDky?=
 =?us-ascii?Q?vM8cfCafYko=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HCT4S0lt7jbfwTtzeM6gnGHj5DMFheT8924nvzu2GRXsy3VZIMPMvL4lpyPK?=
 =?us-ascii?Q?JSQ7qsgtq5vJNfKInEepOSaqJVX/Wv0+mkbjEYA8aifSTSKJLv6luihfyDAl?=
 =?us-ascii?Q?/0T53hdwu9dlJu0XQnqfq0JwuQQzkso5RzQjDPWrNLbWebl7cOtVu0n4Qm16?=
 =?us-ascii?Q?9YRcmQU7l3pNHKLA++SazWl4bBVJwBT/5bGlWrn3hRJ5mIIGcBNpXdY+65zh?=
 =?us-ascii?Q?V7sooHQG3PNcwwzkkEaY9ZgyYLM9SWNgosA4qBBtI13kGembw+XJRBtTHQQu?=
 =?us-ascii?Q?X1lr73F01Iwtgt8s0e0pPIzBVGs8pyAhF+iYFyQbIcjVjWW+dZZKJnmn8Mv5?=
 =?us-ascii?Q?gB6PdUL/mfqKLCGhJfqdlEfeAmal/UrA1xNBkKebZ2ZgtqltE/0/nxy093N+?=
 =?us-ascii?Q?kgwm3RiurmEhUeAWDDQD1jxKkI4KY3Y+cf5SabeBhAyocFIHsgZ0Bp4E+OOr?=
 =?us-ascii?Q?Yyhz8Kjt9dqaDNFFuuFjsed3YGlAW8/9jV+fQYOn/GCI38f4kn8zo28f/34Z?=
 =?us-ascii?Q?yNttsUbC5eY2x42yOETK0F73pSaJ7iV39aeZpbHhLwPa3ndU4TKsT6GiFJ2Q?=
 =?us-ascii?Q?oXuyMaFFB5Bcq/BnWXNCVtjUcyEMb9pxyBU3Dpy+u4F6K5l0KgBrbfl7+0zz?=
 =?us-ascii?Q?Kq55SX3NfRMIFD9gYViFxawL3C20eF+N6YbbfylocLBVicaJOOS4cuu1XsVI?=
 =?us-ascii?Q?btlb/8yKXjkr8P80x6jHmooexpKFuNQIFqRKdlM7v+NyGeRNq3LAynqOycE9?=
 =?us-ascii?Q?9xDwsIyN93eeKtUiFI1//KnhDBDxW9CGBHYZOYUjnxnO+xeoCLee7b/RAksx?=
 =?us-ascii?Q?XPTsLVU6nv7sjZUpM70se+vTDrIGrZfsSfhTFNezN7AEMNynl6iBwiRzMwns?=
 =?us-ascii?Q?+A84G9lE/dtq39IuIYlrSVrMz3AsJ/AA638/w0Y5xj9AI4hWbfNT2jBxB78F?=
 =?us-ascii?Q?XvQN7FzmsoIJ5xGAnxC7ByWScEDf3E2s3A1w1oucLlrniT+V8NESBNw7wSlu?=
 =?us-ascii?Q?K7orN0IdLRtT2q4U9r6s7bg/ZItVBt1CHDkJ2OjWGxEElrB8+FnkUADqiucF?=
 =?us-ascii?Q?wJVTzrwmve8RUYEUGjekQ2/G+pAEGCfqkL1qDDO4RMw0ep52JWL+xM4jlsBE?=
 =?us-ascii?Q?XOTFHYUGqlICYs1PT24+VO9G6COzDJNXtXfgwH/x+TttUQlQo+kqineAtkEC?=
 =?us-ascii?Q?XEUo2PODnU9Rl8KAhhvg3oBOokhwzCO1fcqZVxZJB+3O4naumG4YScyIt/VT?=
 =?us-ascii?Q?9KFgFBlHX9vUTMGpYROPOEOXzNIjRQ/wZPnvCGOCnvzlGWN9iXF6EEGKhxjG?=
 =?us-ascii?Q?YrZI+HOlFTGdNFC9tYGTdXd0YIsrNrr9IbXXW0vUUN5gfCr6SQNBxQwDfhhV?=
 =?us-ascii?Q?5IrSqwEt0G5+vscxKCHNrQ8wlYiW0aZfvQ1Zv0qmO5ap2Ba4++h40/Hv2weD?=
 =?us-ascii?Q?Ech6NnG6NVorHDuMFckLnI2geNjO9sCeygwvwuLCBNIP5hlUmwbsn0xJ6Id3?=
 =?us-ascii?Q?+XigoZ5k+/vpJqa0oiXDnWPhvjzaU06EF7ZHlSuZw5/n0Y91PmW91CJlwv9Z?=
 =?us-ascii?Q?FUdDxmkeZs2HpbSazdqEE2b8zJJrxAW5MrgP1yscltxEH/O6x1LRrjdeWiTk?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oNHnsmPMvQ2ec8DIMnnGW/ydHZWjuEaRqKxYVQOjSrXw6/suqhHkYF+VsJ0CAVLwAAecuS8H/beD8ACZJNgxqh/4/0Zc27o+dhF+M6VXl2b5TStDeKOptf6kIkl0jhhwW6+Nt9HCIm8EqQgpSYJx9cjBDyi5ZKNtRaTD+986aXRTjm17uicA0RznOOwgGgrhRb8RY0YAOM+InvUUCrkcd5bqUC29DvG/tqc/A4T+97lOpdPJWsS32pl0QHtovShS3ZeVr1wn1UF3WjmC45a/24/zqcqKw17ygWYf82IupdUwlkhD0mMCY8DSpQwBpw9AUKx7POsIdVQYTCFsCwP0a90OF2/+547stk2SkPr+Das8U+jcsUnGomGisy+Gi24gkwzoqxkYFzdLEdrUkQ/0k0aGp4dLhsFGtz2zVUIyx/V6hOeJQb2iEX8Y19Aq7JTtm6DJrKkJa+P7x4Q7rdWBoxZFBpntTZcZrP1ZDwDyDm77mtj24j0JM55zqVJZ2+C1cysIlosa2/BfQHJPZ1hqL6+BaQfTla6T0NZaKg5oCZJqCEGKRE8SvAqFk6uIj5AXFios5WKcUNef56iDZ9tGgBauts9ieSqHNXEhdZR7GVg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3b6f27-d7fd-476c-a9d2-08ddd49430c6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 02:51:49.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjSOal0tWb177Fz7n3ODCHXXb90331ECrLtjLhjnTEEJ7uSDXY2UNkJYDxtCXzheFWV/O/AFgDm+vV3G4pukuAER8Bcx3Q1TTC4jYayu1xQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7077
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_05,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508060018
X-Authority-Analysis: v=2.4 cv=WMp/XmsR c=1 sm=1 tr=0 ts=6892c34b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=2-k84BmsKjWdcM_wPxIA:9 cc=ntf
 awl=host:12066
X-Proofpoint-GUID: bIBsihVTGv6QBZMYRl7fO3sYyXIcUfuu
X-Proofpoint-ORIG-GUID: bIBsihVTGv6QBZMYRl7fO3sYyXIcUfuu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAxOSBTYWx0ZWRfXzrAo4sQwFxh2
 m8HA3+Rthfqk9UNpNC8+7Sh+DaH/THMhcqBEmUTXRX2zSdIrK6HHe++Ww8ZZIPtO5i9Vj9mX3hn
 gRlbLL1DVTwPmA/QYWipW4IiPOV/wB2HkL4ZUj8TeTpVYZx4jqBe74/xn6tHkbaVVG9lA++OLgS
 S8ZD7PlsgB60WthhxpFkMOYbrESt3Ru+JsGdOyTpg9r2Ge0x5wDRtE++v8nabuTPOr9hqTAIuLb
 Pq08VahycvuyJytunfOY5KpPKaSm36enytG6RDaKAzs+u1F4BGRy4M++RgnxBA5duWX0sq5KY0V
 Ff0PdoTiUJ/0D4/GoRF65ssELP1w2c9Snq2LqvKGL3mWUBLgSpDW58ENp3GoZdPlNheO2k7Otv+
 8r7DNaFv9zemw8pRZEs2WFg6KwP3JyZJELL5RReWMdlfCmJw5/LlF3s1vOA5JQtCGvFrtkGj


Anuj,

> This test verifies end-to-end support for integrity metadata via the
> io-uring interface. It uses the FS_IOC_GETLBMD_CAP ioctl to query the
> logical block metadata capabilities of the device. These values are
> then passed to fio using the md_per_io_size option.

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
