Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCC0322A2E
	for <linux-block@vger.kernel.org>; Fri,  2 Oct 2026 03:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790913481; cv=fail; b=Sf/KPu7BnKguCDcMiYRXDktVnih1kHmKYj+kkjy47Ph6If/cGbn27W2HTgPpX+N+Sb50Vnxd8Zo6fD5lTp5S4zlpqnXxiNDLjkQXnMlmhPVxhZ7drDvVB0U7Q1eFv5TWf57zxmPm7JDxErfEDOC+iNILeEe2xxM2hRm+Z/dxZsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790913481; c=relaxed/simple;
	bh=s7BLEXglra4hZal+s8MqV+LFz4T2ct+IVEbD0GatP1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZSqa8gciiuCJrfgyhBzDdUFFzU+Ja3X0WSYt7vx2juAMzKWBbo0QKvhxOt1QWU1sFQGMzHR0mD1VehcqrQot6pvZquAqn9gSyXCEQcXSozDjzERZR1oa5M3zLvRLaPr7IGroOkRixBxujBCUu3lrVdCwxOHHV6Jc4xtkB/EAfBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FzqZSYfp; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=u9EYy79Y; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FzqZSYfp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="u9EYy79Y"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1790913480; x=1822449480;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s7BLEXglra4hZal+s8MqV+LFz4T2ct+IVEbD0GatP1k=;
  b=FzqZSYfp8pR+4b6OIGXjhpRbp7umf87+wWPUpwE2cmGa53yH/GFeacEH
   Nwqq/i0XEit0kXuQDVbN3nlnGQn+kor9mGBoPjhzbIkR6wbAFTpxu840Y
   kFMZjGZZ3R1viYZhdjmXzKlQsZD8Io1jXFay+AGrBQyXtLBrxgNZaeZ29
   kJW63qbaVMV+5KUysdbjSlsUwHC4xOC5O6YwXvmyJSmPCDMZKyTES5wnY
   pcpspS/hInl6w1CYgRbXHHE3Cgg4iWX+I7vqU8v9WJJAdBfvNaTLE1Yz0
   wWekSR78Q3ozv08ccB5x/O+G8l2bIlsBPQWpAgrUhz8yc495hB3UdcnNm
   w==;
X-CSE-ConnectionGUID: YA07PgiBQK2jaWxbxvcF0w==
X-CSE-MsgGUID: Bog6vCE6T1ukVPEJCsJVNQ==
X-IronPort-AV: E=Sophos;i="6.27,135,1786982400"; 
   d="scan'208";a="157101348"
Received: from mail-westus3azon11012028.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.28])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2026 11:57:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azh2trzNlSh2huAHO6dp6wJ1y4So6ZR6gygMBeFpnilZskY6z1IIG8+OzUe0b5eEf+fQnNadH1bgYCo0WY/V2m36WxJgtU3FU6TL89QwkneAu6Y5Enu7LO+kpqQnxeKzddGWKFRNKMRDxmNrSPRTUpr7BV9zSejCzMKpq+uu8htKFf+Wv6H7snuGyj3cHsmrGUvpt3IAFvdS5ILE4KQ775pwgpqJwFielzxyVw1fxxhyA2rzttY//ZYXdD38Ss/2jE7VzV1y1iifDPYy8iCVf4ZLW+eKNkUVCjw6H4XhfUlpD6X43NP/hmTRRsuFAfhjG5IXCq5d6xuTtkCqFCNYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jeHre7c3GY4hg4R2wxm7yUeKCd9SXjXUERIG6eDAng8=;
 b=h7gVGx83UjxItSCrEHcEGdJRCaSFWJBiZv6E2zbMKkUu3RdNpxMA5Ch/hnXxHPy87AWRA+xeyzUeyNBYHQph4kbal8j5uHlWbkEco5U0PEay9gyItzK6jGpNQxyRzffr8lD3ug3/jR5ziLkmaUhXYs8pyyFpkkIzEsY6EL8ZTfAvyy8yZf0XRQR/XWXZ2UmyjZmNtX7GUs/u+/aAmwwGnljMjbRmNTErjm+6AeiIZEPXDo2Wmlhyr9oTLWJuLO4rCxCtzk2z4L6txqKUH4W+ynTs763542pgzFnN98NV6gDKfttyOUzgrtHykB6xNHKAU414Ar0Jv1ax6X+RWYeu/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jeHre7c3GY4hg4R2wxm7yUeKCd9SXjXUERIG6eDAng8=;
 b=u9EYy79YqJHhDaqK04AN90JiMsSJSBFDGAkaD4MIg7QJv6At7qqRU1MIPtaycQaL1l7t0hHaaM7yXq9BLdajOjmdqI//ZW8CoRFaam9E+43NcWT5stnzVWKXtqAhyVFvOZ2y0guW78Xq5DyZPFtF7+Yfvvsrs5QnYRijD05PnHs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BY5PR04MB6533.namprd04.prod.outlook.com
 (2603:10b6:a03:1df::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Fri, 2 Oct
 2026 03:57:50 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 03:57:50 +0000
Date: Fri, 2 Oct 2026 05:57:38 +0200
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 REPOST] zloop: zero out only the unread tail of short
 reads
Message-ID: <ar8qxZlf3h4hKuan@shinmob>
References: <20260916065657.62724-1-shinichiro.kawasaki@opensource.wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916065657.62724-1-shinichiro.kawasaki@opensource.wdc.com>
X-ClientProxiedBy: TYCP286CA0220.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::20) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BY5PR04MB6533:EE_
X-MS-Office365-Filtering-Correlation-Id: f243c2e7-1673-4dc2-4599-08df203953db
X-LD-Processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	5wVXPh3j07i6VozKfA8tnWaIlXCcEYx7DAz0jtRxSo+70Uxu/EW+tBmXFc9lVL0t7+Xp8AI0PbPMeDfhKQExXN17xICQZpwukL71Oh6uQYeXJopLBODbMMWdsxErzhoDklaB9DE2rpPuDyLTYn9mIu1NGZYoXdqqY3eIc6WmIQDBvkI3NU7xk4M58d98VtH9HkBjIehMSrQglasDx/xV0S++8v0XySy13B10bCIBUxtlYlZpxZsodL2KAfJMcXm0ogm1ufwoCOhAI223KP1u5ItylKT/+jIWTmoFaWavWlxokS8tk7fdEq351DKAwdklC4WVGQqVuz/3boQwqNZfqybZ57+Xpeje4UN/PY0hNbB+mBmgDjlfBRBbnUUOyMOcR0RJMv9C+w+7WyoDs10yR+8TC7Uz7WEcr0nDwJ1J8XGO7MH37gkzIndy9c9l+Zyj/yFIEDYLnCLpCzZlSQ0YCK++ZiI1sV1nMApnOHFqfEp0cBKPRUUSITWBYazgQGhMRYMIx9muqanxHPmgtICVYPAjCblFZ81e20K9eCAz2/UKIYUx8rRCz3DNiJkPxwYYTKPlKgTxlZzK6+rMPDum15qK7+8Kse+4+hy5/7EKlLppi6pEe1Xb3BYfqSV1cY9RBTSIYWkPhNPWTlRH0kWu7+2Ir5L92vHp5pMN2GIlHwc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/McrMBgxfVHHauljnUiieDWd7NwZN1AUnKsd0tDdnViY7NCxQF0rsnQr4Bq?=
 =?us-ascii?Q?BjuNNtJ68hC3K4iiUm6Gkn6wjboiWaiyEz1sVSSej31AfUhTBVd+T7uwyNch?=
 =?us-ascii?Q?R42XXYW71RjKZi3CWIsmCaBOdQAFXJHEKHIQruX9cAsttzMOt1lPZp5yDW7v?=
 =?us-ascii?Q?6/tiClrNWfLCL3iPpU2E0w1t0HZ6cQHbJnMCm8eGD38wNQgVMihnCsa6X8Qx?=
 =?us-ascii?Q?s3bRK26LjyRaNlEXV22gZsywRvuV/YFVDEn4dKox/yWncQGmzoAtBcpg6iXf?=
 =?us-ascii?Q?x3DJV0pi5pGcx+vjjA61i1bb0lk4uqdce2ckhUgleDK4MPTR5q4mD2P4VCMh?=
 =?us-ascii?Q?JG1oZdsD7m10iXo/+xf/vnJiDUxmu1NgrJmGa4KL8qRaQKMAExUHqoCdeijw?=
 =?us-ascii?Q?Eq4uvvRRs7gUel5KepGo3DwkCyQWCWrIU3Ob1ajbwQ1HPKtClLGqq6L8FwTo?=
 =?us-ascii?Q?4f1ye0secgER9SLams7Ih6Sv+hHkxb8iq5sbS6QpfO3B7ncuSbyqfEW5gFKp?=
 =?us-ascii?Q?y1ClfvLy0IURqxyk5I4R0cWrqQETfMmKW395gEcPaZEdpUsvuEGu5gJMkj3G?=
 =?us-ascii?Q?TTTZBb8MOybJh/4HT/t98yx68R4HVoNN2Y9Ix8j2wjBytiK+wMixazjuxoXB?=
 =?us-ascii?Q?KDalnlP6bAiHucaNaAN9q73DGJ7jfCapob4wc9bYuJmSpVT3iXuiq0Ilg6t+?=
 =?us-ascii?Q?F+40IzYLY1HTVgarDqWjQOYWD8A/rK3Frw/naim+MBC4m5ds1968mnAD45Hj?=
 =?us-ascii?Q?2gn2co9a0m04HNZDa0D9pM5e4wHojDmD2zwV7KaKcbT1b4TiGZ0uUPXLUIQ+?=
 =?us-ascii?Q?DN94GUtjm/Nzb6/hkRt7aTKXV0PsmU+vbbsYMc3WS6SBJUDWVvymr3bY1KQA?=
 =?us-ascii?Q?HOxVtbv/fJ5aZNPtLYPC+ZtPeb2csIggjX+hj7zKOJRbj4EG0nCL3RKelskL?=
 =?us-ascii?Q?oT7CncNwvT3UbfPTKly1jeo4WJi+/EYJRwMk5e0gkEKVqdv/eiFLJ41CLnjA?=
 =?us-ascii?Q?Hlyxs9OP/uyuFLF4HRhDJo/zVe8sce1LQNuMNhSIcCC5n38XOvgTl1tR4uHu?=
 =?us-ascii?Q?lvJoEyoXQMWlUye1e8XpyEtLtZ6yMTcq/Ke2Ac2UwuJ6vfPPyrPe9sUoN8Z6?=
 =?us-ascii?Q?qI0dx4FbrwOqhiPMndtTLGgV3F9nWt2AhnDsPDf90/Km3kp4Y+6uB83Wzf6I?=
 =?us-ascii?Q?r88XRdMliKxnEVcoG5maO33rzpTMw2UhGvGdEsByA/+MZjv10gTKN0fyrP/U?=
 =?us-ascii?Q?lyOe/3tVtuq6ktQQ4fHmL4pbY4J+syYj55JOZlRO8KFAsEyFfSpmMMWO6EOf?=
 =?us-ascii?Q?xhPY/j+O6LyxHvWalVC+vUcUFqcoz9rhpADq5rffoT/05h8P04wh25dn++F3?=
 =?us-ascii?Q?yvUaZI/TZFOtH8LpAX/CmARPiJUvf9kVwZX3V4ntGgqjAhjhHPsSs/aQCI9k?=
 =?us-ascii?Q?JL5AoWRKqUGLrQNaoraJsLkvrcpW5/+34xVGoQ8Z/eF1GFSSAOYnHIMMrNJb?=
 =?us-ascii?Q?GL9bTSs+FdqpOunIIFsZPNRSXJ84bEgth3S9OhCSwp1yRse5QaOFhdOL+AOy?=
 =?us-ascii?Q?DTxzS4vvZyCnGd1+J1oPCoFKLa8wfUcZj6Et29xD3+crpqKEN2tdHoV06esa?=
 =?us-ascii?Q?o8pU55XRULI7F+tVUHE8HqNOOAWZ+xizl+w44uQ8cGiaDl66a++Y8rmSlxlI?=
 =?us-ascii?Q?y1aWTn2xb4VNem8m46cji1l8oCiSGIE+/X1lZeFJ2KEsaSnE1Dz9/11835D1?=
 =?us-ascii?Q?8ch3aLMFIv7kd9249zKPsYYsalQ1Mvk=3D?=
X-Exchange-RoutingPolicyChecked:
	iJj7rqNRUms273/yhdwjA3pN+RU5Op9ITtONsExSRdJww3VayC8f/TXZQkV3ZRtB840f5rPyWT+k1IcP6nNLFMM2lyhig664yH6EDuieV1OJeFFnVLP0iask8bZ+j+8chE7+Rce2leTwOmnJtEifpNmiKSRijQl/zg8NYWvMAVcuFbocYl5QZy7oEmVbvHgQXiR47OAfCC0OtMBg9RQxmYj+yuiNz1LFSHlOKBKInbyMlxQfQQb733yFAU6A671GMkXhgehU3U/y1kG60p0pmuYQ8lPTEi92rTGE/FD1rDBaw7GF1DLq1B81O9XfngQ7S7vEeAL+EmBALViTSbTerg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vUbhla/uJQcDUlhff23UkstS4E18QQCf8QMqq/Qj+ahZ8reCMP0aant/x2BFZTYWHK7IBkDtrdyst//3ERlhPD0CwAB65pL/H87GhyaGBj+fqiCwv9rrJHLZF6tY6YXZoEdScFRM564FvI6cV0HmQe2gTAI6qPWASRyRFqM0FrUt2R4PI1srER6CtfriqvnDa5QPnAgxuhaUADuP88Ism2zjYeiR8CGw9xMfvqLjPWXGKnh7vyzGopYcNBuAW4rsFBnY2/gSK/rusL07NWsLQ8NrUVmkud/cr86dltj4xFqmXCAMQ354QCVBKOEiwuDHkvMa2adDBcFTldDRqlwRSXfDQGvajHSHfRTrJGLpUdJiEOCokDXtUzn65ISH0Bejvuk021JJHSG3MA0NGTlWudb79eYPv9ecIQkuwhLgLKdsHWhJqQkhKhARE1Ig+pd+Xc1xRnAevupIl55IH+7piwJ57xJrd7ag6iGbS6uzghSBy+jMJRKnJgrB6N3TnIN4oY2MCd8ZY7CqnnbgrkaCEE5S95iSZ2MY9pfB+zhw621dmx1ZhK2bzrOjaGfN/4ZeiDOyy67VdIPJYN0mLSTl8APM3CxfpDnEhyVUd7gEixdHKC1GF+pnrR2YFiNuEss+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f243c2e7-1673-4dc2-4599-08df203953db
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 03:57:50.2956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bW4AzW7Y7hi2nsCiow16EEqwsJZbomilmhs6iBIehE1xisNO54CawSRqr9DjHcENUrrIAJnOYDB6ZDcmxXOF8AJlSvH2Vs9tQHLyIRq/WJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6533

On Sep 16, 2026 / 15:56, Shin'ichiro Kawasaki wrote:
> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
[...]
> Jens, please consider this patch for upstream.
> 
> The fio test case 69 of t/zbd/test-zbd-support started failing since the
> recent kernel commit 9cbbac29d752 ("block: Remove redundant plug in
> __submit_bio()") in v7.2-rc1 tag.

Gentle ping. My test system keeps on reporting the fio test case failure.
Jens, your response to this patch will be appreciated.
