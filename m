Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E83286D69
	for <linux-block@vger.kernel.org>; Wed, 13 Aug 2025 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755104254; cv=fail; b=IY8Cku8rfCtE6zmuStwo5kO04M/YwX7vpyZClghA+1TNAJaEsWNJyB5Q/MqhMwdCjoqWSAgosHXsKFrtFZ/bewO2L3t3J1mG8nNe9rwCxz0KMnHdk/1+iBhYtHN9CTkcjwVlJ8zPqBnglNxvsMZ4qkuxBkSkCh9nw1M436VfqwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755104254; c=relaxed/simple;
	bh=tgNCCpLTXIUcA/CyvH5RI40x8zxQabwukqsirMKBDss=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=ZXs6R9HMIY8CNNBT3qUh0ENLT/d/taXtg8BnvsE+Xu8Z3uN3P9bKSAIsfKpG5LuFNO/Dg0Z1Cwv3lv1oPdCvURBQs99nypvVfXbcvLCElUAAzSiuD9QhoFj1NUewLnRvmtgvE86lY8LNf9UPZ0AcpYO4ObtRHbDPB+Eo8N/xTCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UqzHIahk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rNndz4PC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UqzHIahk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rNndz4PC"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DGCDFp006632;
	Wed, 13 Aug 2025 16:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=yB2LyI+53yM3IEgawe
	YdV4QEWz0zaaOXe8AvWQ7lHlg=; b=UqzHIahkQsE2dNMr8UvAO6dAZXlZrSjzok
	E3zO0QseO83caZAwVF35dTLLCObMLZtkFZZqzc/G5QVeBO7A2AY9PNjbP3suwmZT
	PRmFhrIzbXFmy9WOEvtq+/SKkuL7YIYXVU+r1FwPurrSZZAfw8iRwOnLqWk3gMgP
	QBFVs0kUEFGs52PBx5/WBdbI07joDoDudZacgJcDXMmTqJXPgSRf9eaAtwfadfIK
	PlqmUvyVWNFk23RfvWkP7K/auyqpF2hdy2Ve70GwAY18A6Pcps4M/QipxSJaiFzX
	VBzBMv8fCPbJ1ZVQMb9tFIpXn248MDCm7bInAfEJLcWYTTVL2iQg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf849p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 16:57:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DGojBT030187;
	Wed, 13 Aug 2025 16:57:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsbncxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 16:57:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doByh+RGbCrCd9FfFaYD7tiL+YViwykRiWN29EqSyarh4OIlLbE4B1ohqtKec8rO7KNkwTEqB8XvEixN50ByvaN8Roe58HUYfRuAcu8DLEJ7oxnXSAYDecDrVvQNbBKU7Z++AJghn40RCCEzeoW+Du9q1kB0ytF3D8xZUO8s+YtLT8o91+5D44L9+RyNUIi5IRyj4Uo753QaMh83uS6n31AGso35zt/lDtDr7xYPGRbXEXAW75MdTWYZc7PrZIWCgbP/iVIP9f54iCIS9qZ8HsoCaKx80FV/U90ENwcklMS87utOZMQcoFg6KDAVzovCL6fVT/SZJ1BjOVOPg0bWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yB2LyI+53yM3IEgaweYdV4QEWz0zaaOXe8AvWQ7lHlg=;
 b=gCHO2lJRqh0FBIy1aHsbUh/axA46bSuWVDF6fKSwWm2g2RzQTi2c2F2eG3X+2IOouSGWwS30TuBdQ2rBj7vMw3bq/yWBu4ovHWkV7uPy8b5ZPqG3/Xx6DlzI5CZ42f1sYtyYVmPXs6pDBeMRi8U2qZJr1A8t46CnEyhMwbWNzLdi30Kn3Hg/Qc4CZzC1b5XdOKUBaD4QLZUDUietxsfKB1ix1QOmJgvXffktIZZMQPn9/Ua8XHsOt9Wir0YEFRnIR0X0DWHct7AqZOHj6uDa0riV+B5myBzKvh+eGrzveIlEO6vuFYtHCPRS6zsxVTjf7hlFnuJWbnu9hcez9q9Zjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yB2LyI+53yM3IEgaweYdV4QEWz0zaaOXe8AvWQ7lHlg=;
 b=rNndz4PC0oTIgQHA+HNXjY6cO3q36rnUGH/aljR1Gde76c6dtWQMJsSW3c1oxFdVpOUCGTHDdFJAjbb2ERZ//i3If6MJXeH7mZvG3FXgWcsF10hFoMY3zuZI6Vx3jRjqxivXXkE5CDt2HsSe37imxI8JLkg71Hg8AMTDI+a3D+A=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS4PPF5E3A27BDE.namprd10.prod.outlook.com (2603:10b6:f:fc00::d20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 16:57:07 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 16:57:07 +0000
To: Keith Busch <kbusch@meta.com>
Cc: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <hch@lst.de>, <axboe@kernel.dk>, <joshi.k@samsung.com>,
        Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCHv7 0/9] blk dma iter for integrity metadata
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250813153153.3260897-1-kbusch@meta.com> (Keith Busch's message
	of "Wed, 13 Aug 2025 08:31:44 -0700")
Organization: Oracle Corporation
Message-ID: <yq1cy8z2mdm.fsf@ca-mkp.ca.oracle.com>
References: <20250813153153.3260897-1-kbusch@meta.com>
Date: Wed, 13 Aug 2025 12:57:04 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH8PR15CA0001.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::13) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS4PPF5E3A27BDE:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4221a3-9522-481b-a711-08ddda8a6fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rztEmuEdexgPbJVHjOE6kQCMxld5Iz1T8R2wrmaIAty42pHm8TUd1TFiOmss?=
 =?us-ascii?Q?0WQRmYkAiHItzECHvXcPRebY/gg4Y9uXE3ShbW66Zncq9yRSKSrTYFKN9L9+?=
 =?us-ascii?Q?0Qm6zGh2Omu4roUB7snqz6SYhdOdhPzTJTMwvS5rBsiSXXvC81aKgTOxf+Fu?=
 =?us-ascii?Q?vXrdICzhTNNSEeLH4LvWUFsenl/Qk6RXLansjQ+zkzIeqJ+nondqepSKtxjc?=
 =?us-ascii?Q?h7v7AxDuDX37i27pi9LWbCjEjS9nGFGQbJwapND8bFTpEBLnnT2+CIBPEOg6?=
 =?us-ascii?Q?xne4ag30zSWVR+sPqsmU8RmtIzyRkq99eiprBTpWd8rQT/TNF3tAUyxhlg5R?=
 =?us-ascii?Q?eyT48JqHhaaZrFtpo6S/alZwK3zPdCjwPYxX3jkcFOxTIkZ6HzCK9LUREQi6?=
 =?us-ascii?Q?GEFDkO9OYaP1K8hQSAGSt+5ABjg6xtQ6Trx7z5526bj/fILfQUYvX/aCdZvn?=
 =?us-ascii?Q?IQK1WbGJdRkq8fvg1nBfz19c5WF/cn/l5t8AoipilZI9g0g+wAJD3TRbTJnn?=
 =?us-ascii?Q?sWOQg5lCOv5d998HQUvpKrrDungjlJoY8KjFzRZuGzm6PK/EUS/nZXxl/GrF?=
 =?us-ascii?Q?vFTuV8LuHpPgrab9Fr6ANr9gRTs1MoF6jmQYwkvuNIwTKEfDteXOb+VoG2TW?=
 =?us-ascii?Q?bCnW0yuV75WGK0C546Sj/eQWgNRSxCE029nQougcQFltIyf/rwuCZ8UsuYlx?=
 =?us-ascii?Q?baj3BghdZ05IxIEeuVovB2Emw6kqP6OalhSUNbgzRg+luJLB07Lb0wChclSJ?=
 =?us-ascii?Q?EA26H3WRNYxvnC+5UBX6MXl2irASuzn5cDHP464xAMwPm/LaaeWVgKYushD4?=
 =?us-ascii?Q?SIhlyxn+amJV8IbA9ZR1cPZ9iE38lSc/Ay3iPE4ZW1uErGCqNbOIPOmUW+Zt?=
 =?us-ascii?Q?EeO+tnWY+YBqqC+ZrD32Qtmwd9lsWPI2oJ9hzt3zddLHied8v631V4sFm6gD?=
 =?us-ascii?Q?GT054Ssr6fW8D7MsiCCwW/CUAj9vkbnrPKxL0tTmKf0/CRgQrBT9VDceV+W8?=
 =?us-ascii?Q?SFlpE8OW2ImhgxNxGGy5p6CT5LzW7DjdBb3Oofyx8RqJRWmIZGbZCFha4g5D?=
 =?us-ascii?Q?K971WjSPGhOTsJhqH5boLZe74C/15zFbajl7/C0Cya9/no0FOAlN36bQpDEu?=
 =?us-ascii?Q?cSi9y0MO6a9buv6GdBVa+faf37cLe1DIB6q3PiAPebVprHXDYtK1vzuhLVDG?=
 =?us-ascii?Q?wTqWtTyL0bVRyeu1CRoHUUdhuZvyLiJWX60ddxKvhUygHVjrduV9SN3lkY0a?=
 =?us-ascii?Q?kjJXJNHiWdloPPTNqZL0iG9JflHlz3My6MV4fo5N0DwH+MnLx3uVdWm57uEi?=
 =?us-ascii?Q?Jasa4JFLWNOVrum0ZVjj/WTVU0AGw982UEjmlzbaVzwu1NZp0p8WtToploTD?=
 =?us-ascii?Q?Q9aAB04JUXgBg4d+2p6UiGDdfLdRbA/VNV72vQowX7ukbSKj+Lzg+d8gGHLj?=
 =?us-ascii?Q?UfHzWM4bmX0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j79fmvdfVFvdsxN9ObE/gQwnZMgpRlq6moqjbbIS2N6eD4rLQYlTlzoELsKC?=
 =?us-ascii?Q?AvWBfdwzTiF7IH9p8xSuHrC8sGTMvF8WtCEbo0DXQo7V1SIsPtdxZuyYFBBp?=
 =?us-ascii?Q?waoqrUKvoqo2LeSOk5PbaqRNQ5fTLrJ1RltzufysdMyrL6WKomjQFPi8PCuD?=
 =?us-ascii?Q?aOIy1byBC9CREZkoGUPwUf9i3bfDZ1TCD5GGZLt4NsvkbIimcNmpplxkMj1j?=
 =?us-ascii?Q?wh0/DdG9vG/s6TtlaYkatZR9ZPUCzPSArUpIDvTHXqVnjQjrAjpz+QzVh3X5?=
 =?us-ascii?Q?WxoijT2TUQ73l/oe2M0VGvX/deexYZsMW6JHUawpcASYHy9ERBiKsEYVKjBT?=
 =?us-ascii?Q?cR0c/EAa3Y6UbMX7iVeUCc6FfzrZByFlJUZTV+ab4DfxbUfJUTYUMt1yaje/?=
 =?us-ascii?Q?bRzCDt+ATLSDTTy7EHq1KUjFeOT3b10oUNZWu1M25EUU8Bb7OIfQ+fAdvhw6?=
 =?us-ascii?Q?zgDhQy/f61vprCcqept2GlGOYfK+vXZxxQFwu0ZAsB6Ry0GFkI719vIF+NGi?=
 =?us-ascii?Q?XGDtsu+E0MtGeK1BaX8uL0w38sJwxQstv3FfFxAM39xm1pr/GNIUG4D16N2+?=
 =?us-ascii?Q?FMjBaM8kGaVQLGgPteHWMY2v1bG1YMtKJEy4QRNYo+jX60yL9/xP9rGB2peq?=
 =?us-ascii?Q?NHKWktDsohSP3iU9IsHQOs3J0k7NjGxdvnjCc3YcujonxI0PpUPl133ZfGm2?=
 =?us-ascii?Q?A1qJek/WOnR+QMojghu2wB7ohrkZaDB8K3OU6m1Ni+EbEDp7Nc0dfQPm5j0d?=
 =?us-ascii?Q?cbQCt/jPT2f823QsdWAU/GNjFOtPtqEUZn6hzh8vx3czRiaFbo9hsItoiWgZ?=
 =?us-ascii?Q?NxTml44jNyzzOltWHN8MbHw8bQvroERjp3G+tIUIR9NwpTLEXgSR3fAtZuRP?=
 =?us-ascii?Q?+GhqznLxcb7lSiImdXuneKYSUjuDJX7NuXWkNSacn8ncUWck1pf3uRp0RTis?=
 =?us-ascii?Q?qtyUiKSCDHCX3ESXks36Ooqlu7Xby6cqFNEB0vsxvIf84sBRi114G63qYCDV?=
 =?us-ascii?Q?8gSDQcTuxm2RLzMWZ1Vk+vr0762ebZYQRNE6bWq+vcCPLSk91yB/wkaD2Tg3?=
 =?us-ascii?Q?OcfjTql/l3xc1nguLGpEgoU7PYPVHYJ+al1WUJXHaPVKS20Cz80e1ebr4Un7?=
 =?us-ascii?Q?Orfwvo8DVhPVCyk5ARDEbxm92rCqX9Gvs0wD1moEaZZ18j/nQnzROvAZ7KYl?=
 =?us-ascii?Q?SA8Xt8wiG5ZTjVsxRdim3bB9E3QLfZ3VceR7hjcqSgASAJU/DPuBbyqaiImF?=
 =?us-ascii?Q?MgJxgswJTl2vST8laPfihKHPUBxaGBl5DBfvsDucLKlO9UevIgJg6LMIAIJx?=
 =?us-ascii?Q?LJGRGEdjVJ8BvtNEAax2OLGgqo86zTSj+5Pl6VM4Gublbo6kDICWvt8aFyZ+?=
 =?us-ascii?Q?IYXhoLUmmKS48u5bndgFaKkErCJ1al4tJv8+zvh0vBDomq6mzD+4Wh2auIaL?=
 =?us-ascii?Q?TJREtcvNk/brNpJfpmc8MuQCdLj/ve1VjWFN4qwBZP1Q/fQJaVOigX4MiZpw?=
 =?us-ascii?Q?so9B+DPdReFodNbnkrDcmuVrgC1Z00QpWkObNu2+C8Hmtx5hXt3JFNOpYpVT?=
 =?us-ascii?Q?A1vHjSfPue82JbeAmwkNP4Gfe+63f19ZzC7sGGOHLLi6gB4UcNK1PryKPNO4?=
 =?us-ascii?Q?2g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JQfER6HjNHUsXJTFXoCkXzHznvBGuPiYfeVle8CxZFMOJtFtWTmYQqSj0nVXaD/gt1e4gvmJ0Cr7equmyUWxE+cHJLpqeOmm+47bgZvAA0FvJn6NImeoepvyt7GlW92eShCtuLijbt4Deh+xEj6WlbCw4r1ERYJprD10wM5AUnqm5q9Tzy7Zi19DF+TOF5KRtk/l09ogJakC8Abn32RRRcanWku4o81tcf803Ugl7YmmGpv9lGrPbPNmFF2nH2CA/UmKR90jUs8jDe5wb/VosqCOVNvOUzNiPt+H/sz80u07e6YTcwMFEE2WUbcjSY/MY+nyNwfzWKf2ziHT3Sfn0VOV6plDWazltqKSBQd3/4IiMDEGQHoPTM2ByDgP8NQsIbUoTiVNLe5j5zV6Wewp2t6hyE40uJXm207g6VBgpye2e9apv3cTXnpuwZZVUX4vxyvaT/0vuJV1jj8qyFLLzB55IZb48PWAXt5Tdj0/HRaczXN03h9au1J3DHa7d5jaWZpb4pL6DZCR4oFtdkKEIhux+zCVI4JvowfFl6BZYrbSDCjDGxMhM1QmHp7Y5uyAeikFixB9haKgdCGjXuTbPdeJ3byIT2i3rbmk1/LtCjo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4221a3-9522-481b-a711-08ddda8a6fc3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 16:57:07.3556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Jyr8GsdRYaDwoP1Yitoaw4r3oSILLoLagX5EEoftu4Rf53lxrGsSLFo3ipHtTrHJm7heWjHeoGwoNzr2n3fd52mK3Fh2Tt7xH5CsslQ02M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF5E3A27BDE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=814
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130158
X-Proofpoint-GUID: Wj1BS0VaG-a7aBDkre1K3kF_OER-egCM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE1OSBTYWx0ZWRfX+cWDBDttabdh
 ZGz6QXufTGlRgy4onTQ0r3mmTsZWjXE6U39USBvkQxCoiXe0UZRpi9rFAPdBpbxKQjQtMc8Hsu0
 AYz9ONGJs78FKSz506ztkbC9JOVzER/Jci3ZuuewyO/Uwlf/Zgwocwl1n/p7NCKCsmZ6DA2CVPJ
 o07NCtv2AA/kIzhdld6Ygi6XoFRxU7rHswzwm8E/coQTC4CyhqQEgjepN4pvanzfAtghqDwxIvu
 IsCWTgxqtWHw75crjPMVnKbfLyKcRJ9FVMlC7yiG+Ql/Wi0wU6CYtzsm7rvOli7GbRsWK1McOqx
 enNLs/ShxVhm38ITEjCEtxPyvYLVGk+KpJSBokdtJtr7JpeGnwFzsDsNyMLEdjwsWwwfDqm6SV9
 iueAPc3J2hKyplWK1BI8ybvM1fMSxVBCgQwJjbkKDrBN/LW69q2r4pOeRe3TBkIL7hKrjjuv
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689cc3e9 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Lle9XbHFX8SJNqZQgocA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: Wj1BS0VaG-a7aBDkre1K3kF_OER-egCM


Keith,

>   - implemented it in blk-mq-dma.c instead of blk-integrity.c to avoid
>     having to shuffling functions and common types around

Very much in favor of aligning the data and integrity mapping paths.
The whole series looks good to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
