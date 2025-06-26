Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9AC2C1587;
	Thu, 26 Jun 2025 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750930502; cv=fail; b=jiRYga1Xx3dr9OQXr4CfJ5EP1gJAxVCxaKGNQEf/d2a2FEaSus0sDwGaJwL0ofWWBHBHalIPwGsGGrR7mmsmWNg8KP55Q9l11eNBFwY1lWHR9rDZDatHRvI1Dr0FjcYl8GuVtz3zkvX5OzSde1Zunryo14RjPWrz09HROl5i7AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750930502; c=relaxed/simple;
	bh=qU8UeHX97pjrjEOxw1wVUmuD31/cX0HajzrHzygKRUU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qNW+wvkrx0p19h0JQ51hHPqvdNdI6nlltIBoNVlchXwQ8gXWLqUcjtVgd21MwpBYLjSWhOome8uQwqMLLW463S5JJX430dAUInLN+gazWypHLbJ/il+Yz3L2x9/FyshK7FQVEwq7GxvSzjw/8+sVxnHSJN1QwQvhIkv1IbRSr/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dcxl9sux; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xrfuFAk6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dcxl9sux";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xrfuFAk6"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q9CBqg011639;
	Thu, 26 Jun 2025 09:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=InM0YOG9+viqnBTvEQO+gFCBrbL5xdO5KVhB4mInvzQ=; b=
	dcxl9suxHJNWfc6BOWCnp7Ed7mUEbYkfDPm/8BnQ0vMR5jO5h309xQRfTeQj7/RE
	Zrz67bbsj+MYXVs4SWThYMGQ6OnUAPZ7/Q0Imz983gQat8TsB1hoWwgnXSDfktS8
	0ibuZL1KrM+BUv4b8PQ5DMw0mj8bvyFsubtIVG4eY5cT7Fa9arS3CdqXar6VgCCm
	KYjlyenVNO5vmVJcihMfsk6/GTBQ7h+8MQGMQGzQTZxtH3szxxh/TqRRm+KGfbIB
	uZ+G5QplBKzndDN5Wt5urEph1xgfyVV+orGU3HgHiRX9GlX9nCWXNGNE7aii+Rue
	BZpvjwBd0N7kbihpNsGLBw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5rbe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 09:34:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q7WvEv001975;
	Thu, 26 Jun 2025 09:34:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehr78abu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 09:34:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8xPeUJ6BjDQux3QIxF8+21F5foTRZb4rG4zWC5o00E/aenYt94BNuIn069b9UNmN28pNHR21FjoPfi0f6xMAT97N44ITsesmkLFwOxnhxUk1VZPZglKGnGM7X7a5xhARUcZ4/ir6YC4u2C5ELOUeRovmt61OLmxa1BkU/HmlHh3wicLSuIArAQ2M/RqKR22dqTSxTWW36rn97kNUGBzQiggGq10tLm0/g9HHR1YZVR37hpP8MTMKSGfMrWdWPk6eZVQBI6l7Orj4F7UP2EoipD29kewgEVjNUxn0w0Q7uLnpPF0caCmDhW2oFxXtptzfvPfF0AGcl7qDDfQoAZmIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InM0YOG9+viqnBTvEQO+gFCBrbL5xdO5KVhB4mInvzQ=;
 b=DvpkMVleh/5MRyJdh5Q+YVm4FFo7bgo+qwl1Y6ShOlCmO1xlEnvn6W38urUHea6Q7nbgGVwb+la3Q7azGYMID0ISRxRVAcTT6B2kr5Cj47r+bvgprg+szYHoH2lIZrZIP793Mqj1WzzaRStuVsiClWqlZcXQUarJw1AQayPyHo0A58xqskK+6j5dsKceapxnCTFaYQko6nSPM48DL85kw2Vg/Ri4L+3v63XKzcrfoeZ1Y+6FpSDJkXpkncTVUvpGyQR+OTFET0oQNmYivoQe+8yOhS40yXjxT83bQwuItrrpe4otsw5CdFX3DM8/PFoikXEIiSgwbPMPnuFbHun7qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InM0YOG9+viqnBTvEQO+gFCBrbL5xdO5KVhB4mInvzQ=;
 b=xrfuFAk6bCQuLBrqNVhz8mth+OaAzW6/9uR2SRavof9C9KSSYHv/1wj6cXhHXSqh2Q9743dVaaN/qPtdTEo+m1U2ME4EU3Xfom/+ZA45oVPd3cKM5QKxXcbXzSjJitT/NkLdv1AoqjgdMOgsFdRSpMvzE3K4B0qanXZIMFh+v94=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6342.namprd10.prod.outlook.com (2603:10b6:806:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 26 Jun
 2025 09:34:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 09:34:32 +0000
Message-ID: <27e4f72f-3b6e-4dc8-a722-0ace9aa8c066@oracle.com>
Date: Thu, 26 Jun 2025 10:34:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix false warning in bdev_count_inflight_rw()
To: Yu Kuai <yukuai1@huaweicloud.com>, axboe@kernel.dk, hare@suse.de,
        hch@infradead.org, yukuai3@huawei.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@redhat.com, calvin@wbinvd.org, david@fromorbit.com,
        yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250626083927.576207-1-yukuai1@huaweicloud.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250626083927.576207-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0001.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: d5ebd686-4572-4d21-c2f7-08ddb494a7fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjBPNENHNi9uaXFVd1FKUi9UZE1TNmtKMmU2NFcvdkpwU0NKb3d4QmRTaWVw?=
 =?utf-8?B?anNXWGZTZEVaSE9CV1NpZFA1UFo3Umc1YkxSamkzT2J6TTcrZDhZSDNheXdj?=
 =?utf-8?B?Uk5TYnk4NExaUm5rcVl6M2RvbFNWak9qY280VVZoZmZtVnRxMURvMTlkbkoy?=
 =?utf-8?B?U2phcmZ2ZUdFa3FsRks5MUhabE1uWlpDZVBEbEJQQ3AzejN2eW5JWG9nN1ZF?=
 =?utf-8?B?ZEtSTXFSR0VGbUh0LzJMOC9ZZ2k4MldLT0xuRUlPa09aYStmU09FSkh0YVd4?=
 =?utf-8?B?T1VNczNnKzBPTHg3RzFqNHc3czFTdDdCZVArUGZKQiszUU8xWDBwN0JpbTYy?=
 =?utf-8?B?dmlVaGNrMThwTjhwTVJoVFUySm5CRVg5bkdhOG45SWF3L2F3YW5xY2VWaDZa?=
 =?utf-8?B?SVhCend6MXg4NzRQZWRFSS83UHlMUzhsWEVUZ0JVWXRGa1dsbS9xd3N6Q2JP?=
 =?utf-8?B?NlVOQXkrZ3dnU3RGV3ltMkF0TTYrMHNHYnZaNVN3d1VNdHNSWitoRmgyUzBJ?=
 =?utf-8?B?V2EyQjVuTFRBN2VHUFJpb2VLMEtTWWFNOXo3eXZhWElnSkVkMHJsU1lNMStx?=
 =?utf-8?B?YkM5MTdSZVhmYThHbm1sN1pIYy9iN2M0YTgxK1RnUTRaKzNQQnNvVURPRTJh?=
 =?utf-8?B?cjhTeE0wYzRHSDVObjIxTEUwZy9KbVVqS0Y0ZHEvSWFYUkxQOTdyTktVYUdp?=
 =?utf-8?B?bGFUdXF5a2FLczdCeXYrbXFtL1pPYmNlT2tPdzRTM3VaVTEycHkycEdaYUxS?=
 =?utf-8?B?WXhCMFBCT2c0VFdYQ1R0QXErK3lHREE4Y0ZZTmNQTGMyblZjQXpyT0M1SWpp?=
 =?utf-8?B?V2NQbDFIWTVQWUdrTngzSXVyOS9uSjBNeGsvc0ZyQTBTN0ZHcGdxMk5Zcnp4?=
 =?utf-8?B?TlJraVlvZ3FHdURsd1hxN0FVYXhwLzFaWmJQVHFRY21Oc0xjVVJrU1Q2VU1h?=
 =?utf-8?B?SVVuSkZyQmlGZDBrUUE0R2lJVGc4UE9KVWtFbVU0WmtTeE9lbUtEZXFNYmNZ?=
 =?utf-8?B?ZHNpb2hSS0ZGY1JiUHBrSG5VQWpZZy9OSUR6ekxzOW1kSmsyTVQrMWp6WlRq?=
 =?utf-8?B?S1Q2MmFmSkY1QWM2UGVhcFU0M2YrWitwaGZQYS9LbmpiNmdLK2dKcjFPaUlH?=
 =?utf-8?B?L251KzZhT1VrTDZZeERRb2l6b29CMStxTUo1NEdNZERJSG9ZbVpsc0ZZU0Zi?=
 =?utf-8?B?bTVyN1hXS3p1dmNNdGxzUkFSZjJNc1NBdXZjaGMxb3FQaWwzTUVjMUxrZEg3?=
 =?utf-8?B?UkcyY3VQWEY5RXdEZUFTdlZDbCt2LzBBZnhsZXgzWndpN2pXWUtqWWR3ZDRq?=
 =?utf-8?B?bHlZckRGWmVWTFI0S0lSTGoxSlBzb2ptQWtGaEhVTml3Ni90UUx3dkNFVnpX?=
 =?utf-8?B?dEQyMHYvM3I5VWgxd3lGc0JCK2V1WVpEbndMZmJFYnNlaGVwSThqandORk9K?=
 =?utf-8?B?TW03VUJiNnE2SDZ2VURUT09sT1dqZmtTZllNKzBjdGZvOGpBb3BVUW9LNnhK?=
 =?utf-8?B?Um9STWZxQzNzUTZ3UFlneU5BZ3B1dVAzN2dGNFpueTVvUEF4ZzVQYmRVRGVp?=
 =?utf-8?B?MnpZMEtKRW1lRCtObUVGV1MwNUF2cXRNNUNUdnNMNHU1Sms2NUlrVGhxb0Iw?=
 =?utf-8?B?ZEJzUGIxdDNZM211cVJHWUJ0U0RBZVBaQWl4Uk4zN0NYOXpvcXlCdW9lR1Jw?=
 =?utf-8?B?TWxLM2J3SUhsMmlFWGh5QUg1WW50ck14RllUeG56Q2M1b09OUHFxSk4vMTFz?=
 =?utf-8?B?Q2pqUzZvbG84YkNmZ3h2T0RWVTNDNUQ4UnhaVkFtdjNXeDdZZU1ua09Cd3Br?=
 =?utf-8?B?U2tyVkdhQkEvN0cxZ3AxNXlQZHhZY1ZSU29sSFVzeGRVRXpQNXA5ZDhQOXN3?=
 =?utf-8?Q?0z6roNKBoJqaj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2VGY1d3NEM3NkRRUGhCODltc1QzYzZ1a1RGcUYra1U0aHRDWlhmS3Brc1p2?=
 =?utf-8?B?UEgxRFJTSktrNk91Yjl3Ymk3YStKY2NTNU9HSFhad1h5YTN0THR2SStFWUdj?=
 =?utf-8?B?dktYTUtCRGQyN1BqK0xqWmt6WFdlMFVITG4wcDl0alZiMzArWFozQmJSNTc2?=
 =?utf-8?B?UmQ4c0NzZE8vWlhWSXY2NkRkVUY1VFREd1lJdDNPaTdTWG9zY1p2dnEvMW9T?=
 =?utf-8?B?V2xwTVBOSVJ0Y3NXaWlKT2xUa1d5Tk0vZFdmYWRkTVlUL3QrQ1g1VjVjVVZu?=
 =?utf-8?B?TGF3MWkvNHRIUGJvWUVSY2ZLbmp1aGVJd0F1MGI5Umc3UkYyRkR1bDl5OTAr?=
 =?utf-8?B?WkxrSlE2c3AwQnlzb2dvcU9BSzRaOC9RVFJJMVcvYVNLakNYcUdXQkZOUHlG?=
 =?utf-8?B?c2trcC8rU2x4bmxVTVpkaVFjVXFadUU0TVZGWlpDVkVwSlVvYmd1RFlTakJx?=
 =?utf-8?B?SG5kekhnT1JjOXNIbGRpMmZObnc2dVB4NFQ0M243T0Nyem9pTnNDUmtJbGJH?=
 =?utf-8?B?UGJkQ0dqeUpyS096M1d2UTJvRzJIMEJ0d3FxSEpNZFJaZVEwRmlRS0pBUHZp?=
 =?utf-8?B?bzh3ZDlrOHhOV25zY2JHbDBqZ3hHcEdPMHVYaWp6bVl3M0Q0WEJQc3JzVVJw?=
 =?utf-8?B?cysvWE5ZRzJDODdsTjNpajI5S1VWZ2xTUXRjQVorSXA2VGNmWEU1TGUvYStk?=
 =?utf-8?B?YkpUWUNLL2xtRm4vRUxkNjdJR05idHh0NkVXUHFMRWRyQVNraUkvUVRDR2sy?=
 =?utf-8?B?WDZsdzAyc1RmRVJSMTE0U2ttVjh1dFVyQmVuRTRiOFV3Qm5uRXlEakNpa3Fq?=
 =?utf-8?B?WVdKMTdRb1Bjdk5sVWxWSWh6M1o4VDBNUDQzazg3Mjk4aWNreElEMU1uOWVq?=
 =?utf-8?B?SmREcTZkTVNrSTVhT3FKOS9HZTcvcHBYVXFFd2tQRlRZbDM4UWlrbE53aGY3?=
 =?utf-8?B?Ui8xYzJCaTZEOEFaWDdRMEJUL0ROVTN4UjlJV2U2Q1dLVXFDdHBxZ09ZSjY4?=
 =?utf-8?B?WWhvNE00UTVoZDhML1FzN1Erc1FGeFQ2SU54OS81Q1lXSnJQUkxLb0xCVVFB?=
 =?utf-8?B?QzZnbEtaVEM1Q1BMdlpydzJtM25YOG5iN1JQb1dhazJsdkRJQ1M3WjhkV3A5?=
 =?utf-8?B?UXk0UVA4cUFEallWeUloeUg0UzI5cVBkbmVmOW5YSXEzTGZKMHd0dGJYL3FM?=
 =?utf-8?B?a0JZMmhZSHhFQlk4RTljTkFXdkUvaGtPTUtVUFVTSXRxOHlDbEw3Yk1zSW1a?=
 =?utf-8?B?VTkxcUEwSHJYaWsvWXlSTmFXOFpOb1hidHdhTWM3c3FJRGprb1dLWk0zMnVG?=
 =?utf-8?B?SGZCMGt2WHVnOFhiTFVlL2pFbmNGL2phNzFEMldPZWxTZTZPSXZsRmFUQjdp?=
 =?utf-8?B?cHVvK0Fmd3Q5YW9BZ0g0YXA5NE1xTlhIS0pnVnZQaXVwTG1WRkZuYmZValRy?=
 =?utf-8?B?VW5JekJBK2RYRDU5WHRLYWhScUREUlJNdUJOUjcxQmJvSG9nSVBNWktYUHhO?=
 =?utf-8?B?eDVmYmJNVFQ2T0NlemVjOHRkQnBKMGh1UktkQTFGcVpTVmFxOWlxaGI5Sysw?=
 =?utf-8?B?QjZ4b0V5Qk5hQlBQbEhMaDl5clg4amNoaEZWcG1CS3p5M3RHWEo0Si9aMm5s?=
 =?utf-8?B?NW9PQi8ydjJtMitPcVl2aURvbW5kLzdqVEUyMjZRYk9GVmVNNDg3bUd6WnVH?=
 =?utf-8?B?ZXlMY1MzYVI3ZUZ5SjlaQXFZbDNXZmF4ZUZ6azU1bW04VDNjYThhelJ2NUVj?=
 =?utf-8?B?QkpDWTJMeVJGS3NzQ2syK0F6d2JMV0Q2Y2lMamUyYzdNaVFCOXZrWWF0T3Zx?=
 =?utf-8?B?em4zMTJuSlo5MGNsdWVmRDBQRzR6TkJtOXZVVUJxNk55NTU5T2wrdS9KdVBG?=
 =?utf-8?B?NVdaK0xqVmFQclR6WGdNL1N1a0c0R1ZoSzY2SGpMZVd0di96K0d2RDFJby9K?=
 =?utf-8?B?RTdheUUrM1JZeG9JTlhCdG9ZSDFmNTFvb3RSWFNaZjNCSE9pTUoxbkYwcHJP?=
 =?utf-8?B?N2pPUXhNM3gwMlI0MWVqOTRDVjUwR1Y2MlB0UHdQM3JYNWlHbG94cGtpOHN3?=
 =?utf-8?B?bHMzTnlYL0xJbjV1VFZ3K1BPZHI2enBzdlVCMzlxL1hLVitUbzdGS2JDVGo2?=
 =?utf-8?Q?HCGOxtF0/TFfstENlEDXv4TYM?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OnMCUHYbgg2CvO3GZlp1gK46vA8yuoEuVWbDJOCXUaxu1RPZzJ+h4A5TVZbDeSAsx5J1CQe4Nk1hK2JxXYTy15ivPtx4QgzQh9tlUFJqdYKBH907PRgMMZx4gtdmKdNCken8P3pYu15AuewiQBKdTMiZ/mfmHDXQScMilda2UlcUXx58rsST7/TPWL9TRAEqUd3vi31G4TJkSw+TGkz+nSOdbvUNjT76ohLEZjHVsfypFTu74m0Dil95NX3zoFKtcd5zhnlkYj8AtSpvEbjUM+lBcX8iA+Z0JDtigWOd96gSgWAyhyQiJxWbLoV+q2BZltQn6CBrnSG3ZAf5ZXpq2smOaJItTwgcnESvkyRnhDUkD21hv1wCdmaZx3W2oa5vtyP1vBMuX/FFT1tdDwd88veR0Br3vEZOL76FwYqfwDQCc2Ee+r/2NJIPXUwD6q9mpmbZYlZIoeblAjCNyPgmxQsIKbuFC3S1OHbbG+aMBG193fE1Z42c37bczVUAvrvns4SQWEjRmDyUIQM3A9jEwB8YS9ZEQZ96MtYXneaKEUxKwRt4+2pYcrDpsH5QEwZaKNTJsaLNVQshFeIrlDBJiH/UJsTsF0L5ZDanz8dm55Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5ebd686-4572-4d21-c2f7-08ddb494a7fb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 09:34:32.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x59S1HJVV0ANIEF3DmpULGwNnoCV4Kul4QbkQhQzzYdAFgnF1WJqxhCVCSd6gxsZrRp2U1l7RRuV608k2LE3GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6342
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_04,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506260079
X-Proofpoint-GUID: Hrw6up_4jP3wC8I3XqImkDfeFzzFkt1t
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=685d142b b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=i0EeH86SAAAA:8 a=20KFwNOVAAAA:8 a=ksaEnqtyAAAA:8 a=7-415B0cAAAA:8 a=ygCaLBscuBxKH5AfQnsA:9 a=QEXdDO2ut3YA:10
 a=HZj4eoehtxM6a3hhqZpi:22 a=biEYGPWJfzWAr4FL6Ov7:22 cc=ntf awl=host:13215
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA3OSBTYWx0ZWRfX4VM2YUdWFkJm gr3f7yglvly8QDWhLdnF6SaijbGyb1YOw8w79elYUrFO0uf5pVmYuQEk3WshQx01HChvZoIu86z knu7i2y30rBcEapLS38YWehWWcmZRs4k47zm+H4PLL0550i6a2aUY9tc1Mha3QhOI0GozDRxFlu
 s1Pu5KtNGpnAnBiEroQZXZ64ymjcsVqAclP5WOEvqZBFJEatSkUEHXPRVwsJRqd2up4c63BfUiF +mWpcd4eEsW45oSPzG/sqBbMtwkarYffEW+weRjCFJRz3abpQdFcWJe8CZbJ4pDI4Lx1iBIweto DnbsiBqgjP94RKMmyfWFlVlUTMKMVG/VC2TSaGNS9HHUb/dciZQMZqVbe2LTn4W+gIEbBjg0Ob8
 w51J+XHM0yQOcToQ7HixIbU9xTKpaU/8KPF6q3CTtJaPrdWDuTqXtBen2txhZdZPjNNpsorT
X-Proofpoint-ORIG-GUID: Hrw6up_4jP3wC8I3XqImkDfeFzzFkt1t

On 26/06/2025 09:39, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> While bdev_count_inflight is interating all cpus, if some IOs are issued
> from traversed cpu and then completed from the cpu that is not traversed
> yet:
> 
> cpu0
> 		cpu1
> 		bdev_count_inflight
> 		 //for_each_possible_cpu
> 		 // cpu0 is 0
> 		 infliht += 0
> // issue a io
> blk_account_io_start
> // cpu0 inflight ++
> 
> 				cpu2
> 				// the io is done
> 				blk_account_io_done
> 				// cpu2 inflight --
> 		 // cpu 1 is 0
> 		 inflight += 0
> 		 // cpu2 is -1
> 		 inflight += -1
> 		 ...
> 
> In this case, the total inflight will be -1, causing lots of false
> warning. Fix the problem by removing the warning.

Is it even safe to even use this function when not used for just 
informative purposes? I mean, for example, it is used by md code to 
check for idle state - could that check return an invalid result (and 
cause harm)?

> 
> Noted there is still a valid warning for nvme-mpath(From Yi) that is not
> fixed yet.
> 
> Fixes: f5482ee5edb9 ("block: WARN if bdev inflight counter is negative")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Closes: https://urldefense.com/v3/__https://lore.kernel.org/linux-block/aFtUXy-lct0WxY2w@mozart.vkv.me/T/*mae89155a5006463d0a21a4a2c35ae0034b26a339__;Iw!!ACWV5N9M2RV99hQ!LLzonI0PgLV8uruViz5LkA_QGoFQSsfBMNDhb45qsRoJqxuTMcO_2BxJXhMOADfnwncgrR3o99lVDCnq75I7_UI$
> Reported-and-tested-by: Calvin Owens <calvin@wbinvd.org>
> Closes: https://urldefense.com/v3/__https://lore.kernel.org/linux-block/aFtUXy-lct0WxY2w@mozart.vkv.me/T/*m1d935a00070bf95055d0ac84e6075158b08acaef__;Iw!!ACWV5N9M2RV99hQ!LLzonI0PgLV8uruViz5LkA_QGoFQSsfBMNDhb45qsRoJqxuTMcO_2BxJXhMOADfnwncgrR3o99lVDCnqYruhFG0$
> Reported-by: Dave Chinner <david@fromorbit.com>
> Closes: https://urldefense.com/v3/__https://lore.kernel.org/linux-block/aFuypjqCXo9-5_En@dread.disaster.area/__;!!ACWV5N9M2RV99hQ!LLzonI0PgLV8uruViz5LkA_QGoFQSsfBMNDhb45qsRoJqxuTMcO_2BxJXhMOADfnwncgrR3o99lVDCnqj32KGls$
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/genhd.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 8171a6bc3210..680fa717082f 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -141,9 +141,14 @@ static void bdev_count_inflight_rw(struct block_device *part,
>   		}
>   	}
>   
> -	if (WARN_ON_ONCE((int)inflight[READ] < 0))
> +	/*
> +	 * While iterating all cpus, some IOs might issued from traversed cpu
> +	 * and then completed from the cpu that is not traversed yet, causing
> +	 * the inflight number to be negative.
> +	 */
> +	if ((int)inflight[READ] < 0)
>   		inflight[READ] = 0;
> -	if (WARN_ON_ONCE((int)inflight[WRITE] < 0))
> +	if ((int)inflight[WRITE] < 0)
>   		inflight[WRITE] = 0;
>   }
>   

