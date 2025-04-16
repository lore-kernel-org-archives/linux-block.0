Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC46C226183
	for <linux-block@vger.kernel.org>; Wed, 16 Apr 2025 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744833883; cv=fail; b=uiNg3R8SHnS6p0DP/arpb4YflGSmybQZdv8Bv9D5rGpRYbGcmUvm0bhbyzuIn1Q9ckrXnoORt8DDL6Cjo0cLkwjUJfq+aeXBfMV6p1HUEDTE+hc6z8bYwY9vI8BW/pqjeA49xieS9Fsy5mN1yY+gjo+0POc4w000FYLqUSkTguI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744833883; c=relaxed/simple;
	bh=zqL9SV0bnBlp/QvnlfDJLMQG2A4JDWWbFxY3BzQYq2E=;
	h=To:Cc:Subject:From:Message-ID:Date:Content-Type:MIME-Version; b=p9ADAkgin00P+BFUBxjO9dJh2I/PVCSdaL3HZFfwfIsDnaljxLsN/bpv+LTl+pk81AF28DCK7SuQ0m3ZYh8Eo3rSGTpaQmbjN+e6VYxx6s4KxADxayrPqKPL//j4A74A5bct67qmhsPWBImt8dQJ/hv9y4q9wTxLHOY9uXTHVDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AAowPR7D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G4C/7C+G; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AAowPR7D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G4C/7C+G"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GIufWg024615;
	Wed, 16 Apr 2025 20:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	corp-2023-11-20; bh=1dds2FyTADl02opfg70kWKB7kGLJjPZJoSzLFbPEPsg=; b=
	AAowPR7Dk4J6i6dXrShNORGPxtcaP93hE6OBivfSbG1tLTBLDhUvSRFny9KWYjCL
	+iOUdmA8zzA0wfxRJW1vbSfKMfUPT4FhGBGGZZVTgVRoOFI++PTZLH70qdYHWs+l
	P08Lsaty4TS71G8Na0fSUFUPSv0sdpI1c+J8VI+LaCuiHHtNg59L4csXFd6R8zsP
	LIqUV0D1s/Aq4lNGhk6vouvl/LsH4seyuIABeBGurAGderPRfC9tQpz9c/e0NoYV
	iC5Q30gXoywHqB/c04GUkNqt+hIfz5a+8NkFUmBHFecgyTxtlv6zwpsYDW19d20y
	ffXOWwbvXBZ3/Br9UikcEw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46185mvuwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 20:04:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53GIZIdd031047;
	Wed, 16 Apr 2025 20:04:27 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011025.outbound.protection.outlook.com [40.93.12.25])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 460dbcqjyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 20:04:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g22Tzdq0fotggXrTGiSgHa35UrkqINAvhFcNiK+7fXIHUZLfD3rPsSEepJ2zKshZYjg1fla1aNu0CEm0ndFPPgAS9rtvK0eUlcoDy90uGDD4gYm6QYhsdR1pIdBjwAOHz49Ep3I7sCe7OtcHePIvsZx9cxK9LbOE8Q1Zzgx+/inJlAYvDROn1TZeeWqonoM2hc5+WyhRdZ8P9B1mlZ4nAk12koYgXVsB8Fl/o1A0lbUeZ2K9iF7ta/1vqKA2zZFWHmZ+yF1QOdXzN7NpdH46Kq9dRWrff1dNFW9Uc5T/AUQPz8FolXkUXRWmdvj3XXkbbO5htVZm93fRDXqzDeUuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dds2FyTADl02opfg70kWKB7kGLJjPZJoSzLFbPEPsg=;
 b=sspiISaAh/kZWhXr+wJRrvIu4z2LktciSZT0hy0WTKPTfibUkdQaDJg1x/3NEPj/3LsrHXT/TY5D9fJkYCzGU1nrqnRC9N5s4uWj67TchlzBgn3ao/je94AEjB4z8FptkHjbKCuPrmgMPEUju0EFTBTknz6efU1+cqILR0twkUk443TmfeTlE245/aiN50ivm+3Hg/K17Xx8QmrwE1xLkKhhx47QD75MrYqz8uQYfEwKdFeOGR8hMxTdbT7ZJOoUimu4acUjZu1NMNy0ofWqtDT9azVLl47RXbS6CodV9+XbJI8MDX0cSFU1W5JyErXe0KdsUiBzuPZrfGOPTOc5eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dds2FyTADl02opfg70kWKB7kGLJjPZJoSzLFbPEPsg=;
 b=G4C/7C+GqXd0y7SHsgeloxCVyh1swxrts68uPr+T9EbpArTfBU8q+AhxezlTsTYlaOJy/+srgVlHzwya+FICdofTwPS46a+4p2UGyOkFXOUC41ax9swh7Xs1x0h1rZqWOroSRidhcWC5JvpBbKznnibG33HGWl/ukSOVNq7sm5c=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MN2PR10MB4125.namprd10.prod.outlook.com (2603:10b6:208:1df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 20:04:12 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%3]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 20:04:12 +0000
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk,
        Matthew Wilcox
 <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Anuj
 Gupta <anuj20.g@samsung.com>
Subject: [PATCH] block: integrity: Do not call set_page_dirty_lock()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
Message-ID: <yq1v7r3ev9g.fsf@ca-mkp.ca.oracle.com>
Date: Wed, 16 Apr 2025 16:04:10 -0400
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:408:fb::23) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MN2PR10MB4125:EE_
X-MS-Office365-Filtering-Correlation-Id: 6490de61-0b4e-4452-046b-08dd7d21db67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UHCclS1tspt5r8CkcfPVGzbzy3vSRepuFxWusAmgiMLf3+0nHecBNEVOX6A1?=
 =?us-ascii?Q?DJeHzzodd02SIFrW8BIN2a7b0v6ZBXurdvd2vih+njTEb4YrRMYlLJubdTmr?=
 =?us-ascii?Q?MDhOIwx+Xlv6abi32D+ocxMAAkMG8rfSjhcgS7hdmjGJAnF7z9SgDrIpZULD?=
 =?us-ascii?Q?UmRL9ZVjQo2Nh4AbCEmuOfxGaBXAvfFG4GjUnhRAvP0yjga/NQS6GZx7KJSt?=
 =?us-ascii?Q?QiDvrjxR43GaCGWqCRKUkLBjD83zI7OBmWlHlRBA6CFl+REkJvh07fZyYqCm?=
 =?us-ascii?Q?w1I2TQeb8o8TnxZyiBgvAgsl7EP27JrdVRE8ue0f77KDX9Ka0OC30iTDAucN?=
 =?us-ascii?Q?9deVAXOuxs6SumiRL7r9iE6/J3QMYC0iMD3Pud8LHXRbYJ++Zghvubdx4emV?=
 =?us-ascii?Q?kxkwB5qBpDzvxWjDfbErwwPe9ouXHa6dC42ureyviLvkTKc5cGwQSPl70pdJ?=
 =?us-ascii?Q?o44j1aZLUTOChlzOkONm4ywFdHNDYv2fXOra/VKYpIODMqt4/lk9sJ89Cuek?=
 =?us-ascii?Q?LpvmE98a2fw1UTrCUa9sLhLDQa7ebjUMWmhVbQHHCfYwKBYSyHkfx5vLyliu?=
 =?us-ascii?Q?fUnA53HwBI7DyucgUA023qJTiIXqgnie+BC3swp5NLsZmggGJvw7vVmVNN2w?=
 =?us-ascii?Q?WZijnDKb1a0jy1IT2g1m88U+6YOYl6xI22mKPkQtjWa4t/ZEOAzQRCbtlQC4?=
 =?us-ascii?Q?AlREF4tetwLzia89qUi5OCGiUEemxKzo+XA9nv4iN7lDh9wcsAsZSOXDmfrD?=
 =?us-ascii?Q?aInPBZCRmsm/m3Ssizp8iho8DiD5LCywQ3Oa3t7ZFx+5v6z/ojOu4clnWAz1?=
 =?us-ascii?Q?Iof34rlGpxJBnjTtoU6GR6wlg82VbA9njpBeDGjzeN8GgWkgEaChKpmKwte2?=
 =?us-ascii?Q?Q2PSVAILjDY/LtilIWbfheNcGtoF0yXTcn796YtYdaQTVAFaBgJnfRcoUqC5?=
 =?us-ascii?Q?hhwwZndVWKBmxPZLypcyFXclc0YrauDNdcBJ+KFbriJcujjBjsFQi1clo/x8?=
 =?us-ascii?Q?GU3vMxqJWlhNu6hzK07Hi25ZXUWp9lIgR6buXd+VDeXodfJp/6l5um3vlsa6?=
 =?us-ascii?Q?AdtN1PEj2zd2L1mFdXkSZvLtq2Tl4ubv2iSd0AXquyLKg9nZLTWtivGC+JRZ?=
 =?us-ascii?Q?rzQT0qNGgBi69UCsKolnagx5gpIOwls3/HNpo9K46J5gfHBOKoz+z9aJiXoy?=
 =?us-ascii?Q?ZYBdZ582+GFvWZRBuFTJk1kcGqyPKpIOS9I3ysBk4YT5JTloQg0oribRyH7O?=
 =?us-ascii?Q?PzgESmq/5iSqPmZj07zKd+z4rdXUOThrisDkWWl2DvJZcc8yRjjZQ7AT3+06?=
 =?us-ascii?Q?gelqZx6WyZjjLblt0WnjjiqEHEl1EpEwcXa30GEmoy97R3t1NvVDqujkSrA6?=
 =?us-ascii?Q?J3fC/I9q2xxhTuKTCNNEYJOE41z6bw+l4qcgqspGGgPVe9bG5/BT3cxQdl1/?=
 =?us-ascii?Q?8Ebocikd34o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oYWifqvBBRolXSIFbKs8tygxM9MBTX6pvmeVBP/Y3V1LqvrbMBGkPMpVMb+M?=
 =?us-ascii?Q?q9dgbiyinpjki7KgPBaEGwHtv4ufZEVlCEoxxlW0dDa2uxoyuywE+6jzeWYk?=
 =?us-ascii?Q?N2cfvnm/LTV0D62Av3FK4NyMTAliwhmDbzfXP4uh7Y0lnnlopkP3zzeU6p8K?=
 =?us-ascii?Q?hVSu/BYVmqeD3c02AdeTWoaYyCAdgm2EIrdMUvkZGrdwM8SJQT7SXMQ5H9eC?=
 =?us-ascii?Q?ppeYzGcC+zBKylyoHsIqq1uBNGpCkLAOltv3n18ubC6WYjHguUC62DzsDObs?=
 =?us-ascii?Q?xTMlz4z7VYMr3bWYZFYP8//pU5kzQDdsGQHjKBEb6GvasBAkZzEUI10UUtBJ?=
 =?us-ascii?Q?dzHXOq9hJuTNDYZRKqxHu/RrzGnWkLhqf1liXeKewkeiP8/UCZVUZjHLo4UX?=
 =?us-ascii?Q?NL4UN078h2LZia10WMKIfGRphCAeV6eCi9/4MIeZ58b1rMgiAUAqI+CA7lM5?=
 =?us-ascii?Q?MSf9Nn1DLHv/jO6HrLlUSlTuhhJrubV90c293h3sbnKDEj8uv8Rz+HV1haHA?=
 =?us-ascii?Q?P3MyBkgOuk8DL3t/TnVqjY6mF8npc1qTbYrWzze+qpPgv7d7AzVzkJG7+O30?=
 =?us-ascii?Q?1vaE9wlGrp91pleXRjypSeXRL5eBHlDsMsQVZRUMpUeEMfr9NQSjSB41Wka7?=
 =?us-ascii?Q?NMDVcE+CryeKMMJd41orYWUu95vaGpejYarmvI8S3Cui3kZmbrIm0obOPCCN?=
 =?us-ascii?Q?CCvhK+MRmhLSR0ot8mCzzM8bET9V0Np83E/1af8umJRfqGuWQnrMcmKp1Wz5?=
 =?us-ascii?Q?faNccDqrHBSkoJNLrCaNO4iDAzdUzOWHu6Bg4QDPffMrwB7kr8srhy0BE0HI?=
 =?us-ascii?Q?9QmwaG4WHNIer62WA6ZNtC418poWonWLCxrraEGO4bkvY6xs0ARFmMIn5d4p?=
 =?us-ascii?Q?jvcW81GH/0XQZfLU6L5DSARyCkmdVfczqUvEdoUzUvzROMeGuTeoHKLVBL2T?=
 =?us-ascii?Q?zbdhgU79iBgfMNitE0632q6TYrOMtLY7D/53G9iSQkcuRaNDaXn3ORqlm6LC?=
 =?us-ascii?Q?MfRZHmpgDALhW6I5Af5+Qn2+wO7KRMmLNlLQyhpRAdzoc2hk0axhT3atIyAz?=
 =?us-ascii?Q?SzjIBuzXDPD9Pv7gvbKjzWcCGajnxYcNWHUtmVgBplKR419iGH5jrV0RhRRk?=
 =?us-ascii?Q?hsnmu62tY7/qvG6OKJTyJS/fWQQl+1eLhPkyjd3+sMGap0NodgGzJtb7oo4P?=
 =?us-ascii?Q?tsotpXGldpoCc1zZnkmBdiJomtAtITfwe2tjUvhFPizSXbU782Vo/2azc3ud?=
 =?us-ascii?Q?cQvFx1o9Y4sGO/1E9hnotHyp/P6g4BylztXhqXqsZaeIfcCLtWtUXmPQb0PV?=
 =?us-ascii?Q?qBbihJDkSzngxvzOobMFwz4wUAP0EmH89Q0huaunRdblyxGFrpc6Kkm4J3qq?=
 =?us-ascii?Q?36su2BpwVa8edPSkiZJk8fgyNDlqEKEI0DyYyDdrIb3gAnA/EsZWUrZIPmqs?=
 =?us-ascii?Q?EXI3TQFcoj+nqXN8zWLs8eYrCMLTf0OCNu3NspbbauwLH8AWITMAZ0i43prx?=
 =?us-ascii?Q?btXAw+7Yb159YB9tb29OG4/pVmAK1+WPgbPZQymSFBcUw2P0vEqmRY0VYnzt?=
 =?us-ascii?Q?JDnqktNsgWOjVP/1UCvdT1dI8gE5ThrpwG7UPlfW9kuhx1ZNWc4utXUw+ck0?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7ZgwuoojF9pSF1Ve29Bslf4gpyM0Sq3tU7n1iUS3qHAPehii7MfKFgivL/Tz7EtZuXdX9gTFUq5uOIVrSooL2HX5yke1FafTw2cGGBKT4gpp84vtnxViwS1dd+daWyqGv5DYyP1L8L1cI/H0tdJ0GzpVC/b1kJ08z197vtcxhajMjLH/2svpwbRCJdbIOg8B2Pa/1ECOJiERtjhvtnIbudctyg7zuTFnn7TUnyiElChvz2Ef6gnG/kJmllVM5d8AN6UCDS6OwY7agRiEE8ysms2DyBdDzSGfq0Hx6Pr/uA/VJI9dLy8y5UqUVIRvbWVRLWaJfxcRo8YFpJfJPB8tKUCd9BVipTlniK/AwIWdxahQ7vWhPK7/luHPjeGCP3CkiFIRxnxK1X2V6kWL9lyYNt+PMu26Vp3A2QN7aeMFkINB5NEr05YlXV/UekftMb+tE1wiX9O5T5/sytHF4T/v81zNlkuGPDqq8r0slXokVXbzGzNX0pa90rsIPn5rgLBVoamPWc66u0eqpQIO46V5xN3CP5y2Bi8UNauDbcrC+QP/uB2jRDSIeZVUwjWr3zKBVTu5KIW1UbmAbzrMqR+UegXcw70F1gsHUET2yWk7Vko=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6490de61-0b4e-4452-046b-08dd7d21db67
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 20:04:12.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ysx9uIFj+nR/s/nB1Vm4F5qKSJOqZ1ABCOdXeKXV3xlynHiBpW4JNB3iuoCw8OFEchJh8gUFE0IHS+eCXLM/5rsEPJGoeOGFgUQwcc9aGOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_07,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504160164
X-Proofpoint-ORIG-GUID: gnSanT6bMj90F9kyGhM4vv2edGoWUgPO
X-Proofpoint-GUID: gnSanT6bMj90F9kyGhM4vv2edGoWUgPO


Placing multiple protection information buffers inside the same page
can lead to oopses because set_page_dirty_lock() can't be called from
interrupt context.

Since a protection information buffer is not backed by a file there is
no point in setting its page dirty, there is nothing to synchronize.
Drop the call to set_page_dirty_lock() and remove the last argument to
bio_integrity_unpin_bvec().

Cc: stable@vger.kernel.org
Fixes: 492c5d455969 ("block: bio-integrity: directly map user buffers")
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 608594a154a5..43ef6bd06c85 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -66,16 +66,12 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 }
 EXPORT_SYMBOL(bio_integrity_alloc);
 
-static void bio_integrity_unpin_bvec(struct bio_vec *bv, int nr_vecs,
-				     bool dirty)
+static void bio_integrity_unpin_bvec(struct bio_vec *bv, int nr_vecs)
 {
 	int i;
 
-	for (i = 0; i < nr_vecs; i++) {
-		if (dirty && !PageCompound(bv[i].bv_page))
-			set_page_dirty_lock(bv[i].bv_page);
+	for (i = 0; i < nr_vecs; i++)
 		unpin_user_page(bv[i].bv_page);
-	}
 }
 
 static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
@@ -91,7 +87,7 @@ static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
 	ret = copy_to_iter(bvec_virt(bounce_bvec), bytes, &orig_iter);
 	WARN_ON_ONCE(ret != bytes);
 
-	bio_integrity_unpin_bvec(orig_bvecs, orig_nr_vecs, true);
+	bio_integrity_unpin_bvec(orig_bvecs, orig_nr_vecs);
 }
 
 /**
@@ -111,8 +107,7 @@ void bio_integrity_unmap_user(struct bio *bio)
 		return;
 	}
 
-	bio_integrity_unpin_bvec(bip->bip_vec, bip->bip_max_vcnt,
-			bio_data_dir(bio) == READ);
+	bio_integrity_unpin_bvec(bip->bip_vec, bip->bip_max_vcnt);
 }
 
 /**
@@ -198,7 +193,7 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 	}
 
 	if (write)
-		bio_integrity_unpin_bvec(bvec, nr_vecs, false);
+		bio_integrity_unpin_bvec(bvec, nr_vecs);
 	else
 		memcpy(&bip->bip_vec[1], bvec, nr_vecs * sizeof(*bvec));
 
@@ -319,7 +314,7 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 	return 0;
 
 release_pages:
-	bio_integrity_unpin_bvec(bvec, nr_bvecs, false);
+	bio_integrity_unpin_bvec(bvec, nr_bvecs);
 free_bvec:
 	if (bvec != stack_vec)
 		kfree(bvec);
