Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE74148844;
	Fri, 14 Jun 2024 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355850; cv=fail; b=PbKhTJSoX0mn7ZtdGDaPftOc+7yhbzK5td1egxHL28SwU/0oebnUfWEWkudBYCWoKrxWbY3hH2AB/4hXB/w13auEj32jAq1Uo1FPiRTBlY7+s0mv3d462K9+pBnGwZGpY4k1UxaZ4WK4Ug0Prak/bRgOHV4EtJ4DWftGuNMHUB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355850; c=relaxed/simple;
	bh=0+1Gu2D5OXFevAJ6EUWSB2dYQwQh5sQJnO+3mqxvERg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DvlgAjZQ5hs1dagPzIWHB7iqfrmxU4FIX81QazJC3A0ClSwaL25zStJqSqMK4AVv3YrkbBAKpoNr1N78ir3nK0TJfZ3YD3zVFZkFW/cWtFFvysioHS/AaWgDSBoTTS8kL0SJl7o1wQh20XLsknejd1o5Y2hYp6Zcg36rr/ZHkoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZD+XsORh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F1hHnR0e; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZD+XsORh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F1hHnR0e"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E1fRXc009888;
	Fri, 14 Jun 2024 09:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=jQBTUO51UtFlLvWVGMfTS8jAwrXdNqSw2EEqKgrhvBs=; b=
	ZD+XsORhjzHFyXpWI6wQ8y0Nnm1b2EhYGYE0K0p3+nRqOtVb4oFR9dp2NMnINMRf
	5Iccvp20ShgZ6pPsHfPDL2GnbfALtJZvUYS7PP5uJGEmG3yZdNaOHLY+lAtLPKBs
	53yMibtEda1PyW7AYspHNgkurOgEtj3ptK8sTAiJLYCW/kj8kJxCLlRLoE4nMZHW
	EUhvtBeB4qmv2gA+6gAJuZL39O7HvRXU/5wAyAZuBVDyIrpTiJ0HE2petttDRNwm
	ZFvbJ7eXQk7kAITTDrn/iU2w4YTTTRR9HxTKbMQQBwuJPk7GYF/77vuQyviSRqNc
	+6LOsUW6jU9XM+/e39XGMA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh19b874-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 09:03:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45E7GMpK021164;
	Fri, 14 Jun 2024 09:03:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncayp8d0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 09:03:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGqa3xrha4ikFHnKdoIr2B79tFjJHHhkz7/0vFERrLtM0bgCtxzOw4VWXHywFkyaD8zu8BF4hkgCAxUAFRWs3VhuS5huIJcS/JuC5bo3Kgjp56aLxdUkFFqDrTc0+mwpAm06sIHGEq1r7f1PiLrQnJZjubnLqOi//a1wYU+wXGxyebDhfvc2a4sxIrpsC1Rde3zddlyptOVTDB7FcD0O/PTWII22+uWieEI9Sdum8t+d+CVOV4MJHoSwV+DpMHcYGoJNO/i+/urW28wu96u6JADsBwLDQmG95HVdJ077TPGp+fgZN8f8L4UPLw3GccjYssPINM6xBJTlmPazKH7E2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQBTUO51UtFlLvWVGMfTS8jAwrXdNqSw2EEqKgrhvBs=;
 b=EbWHc8CVJ4tBq66vcyZbxzN01eZNtGHJQUuwnqKmZCupCxZs2HntMoIGrnbuWml68fyEO2xEOpmr/uENqnXauPMZZkg+CqkanFTUVus5YO6FFS07grnMkALj5NTKoWBk6XsAplhJ4C7UHx82blSqXtm/0yBlcoYo+7EAKI5aU9RMseQ64y6KkCTHVGCjsr3HmL58m0FmPFMW3wltMiYB6Wcz8ykxGKLPpIomp5uavZZj7yORlJk3Iigbx7V9byFQLB2gI9ILQLzL6MYXlIABJbk4hdN3Bm4ntzopiBcSwf9A2HmJ94sFRGQ9u8VpXoTtm+qEijZ6/nIzIVsix7YZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQBTUO51UtFlLvWVGMfTS8jAwrXdNqSw2EEqKgrhvBs=;
 b=F1hHnR0e118QGSLZaxMFwDDxetfynC4lEm4h0JILuOT3PuSrkrhj7Wcmgfsh/BD1FKlR3vDZkDx46I5+xDm/3oW1yn65VYGLZT4VoryZGLw4MNUMbIvntwTQxhwtuv73md95XVMI3ovTsU1GuyldJ5R/xF3Be3o9LJcSHSpcmrg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB8105.namprd10.prod.outlook.com (2603:10b6:408:28d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Fri, 14 Jun
 2024 09:03:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 09:03:57 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, paolo.valente@unimore.it
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiapeng.chong@linux.alibaba.com, hch@lst.de,
        Abaci Robot <abaci@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/3] bdev: make blockdev_mnt static
Date: Fri, 14 Jun 2024 09:03:43 +0000
Message-Id: <20240614090345.655716-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240614090345.655716-1-john.g.garry@oracle.com>
References: <20240614090345.655716-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:a03:100::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: ac11d8a9-eb20-4508-8383-08dc8c50ec66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?AeJ2twTx5+ETQefu1+6LXZ61YMNtuem8FJSciV6tofkwyAYi0GY4Ga/E1ikP?=
 =?us-ascii?Q?xk/70ojEVrFxYnA+ZkTWPutYs0EtO9zZNG5WNnRR/Zmm/iuSqWPb2BxMxFBM?=
 =?us-ascii?Q?tw1Fa/Q+ZO4VQG6NET3hvwQg7lZPySbGZ1dU8bTMn0fjdg+v7/6CWZyL7WsE?=
 =?us-ascii?Q?MDWVfCPAzMpU5lp4SM3xn5i6xOWvHnV2mE521y6vZ0Zw3IlwognTDdjyVLFO?=
 =?us-ascii?Q?1RJutZbbJOBG7otv+2ahIjVl1dJCaMWvP1mmcF0je5fA+l1XvCvz1nBzyeW8?=
 =?us-ascii?Q?KBZ37ATpxVznDFUYvSLwXsyNR4K6zA+8N/d3WuOEzRORECH2i1WqPCOyw+I3?=
 =?us-ascii?Q?wL62pJPQ2L4rEt9KM55SH+2XqDdu/o9w1FPwUu8JKJudPSsFEjhFe/NItowz?=
 =?us-ascii?Q?F3ZpKP8mzehPMFL/P87NBLjqcXhbpTAVdgNRVNPvN14mfSH94ZqXtrhCzxfc?=
 =?us-ascii?Q?+bMEJYowFaEzbWc5kB1S5LPU1jdktCdDvqdx/adSMbUChSIGd8deKXkXEbPJ?=
 =?us-ascii?Q?bdJ2zIBLW579hvsND6UU3zZURBivv8cNay9YjLl7MYZRiH4i485fRDUVOiAl?=
 =?us-ascii?Q?XEvsiIbu2nyhJxwAW9qxUhB25uGJPFgYN5M8AOcoi4Sz2mchF/GnvklIqnLZ?=
 =?us-ascii?Q?KhlW5aGX4s2HYXxCxihrCr/XNomZv/2HZwG7nlje9N6eJpomRw6CLEhmiksb?=
 =?us-ascii?Q?73fg1JRiNQw/j6cYsgCoKGjKawDRvLOVFgFADo9ppTUwAyJfrklZEgNQ0XzO?=
 =?us-ascii?Q?aTUuiDY2r3MJXRIoxXGEyUDqO17L/xy+Q931ARk9caVRzBA4+i2mCPWIz6ge?=
 =?us-ascii?Q?WeMXPaIeT52V/KaJwUcOH4X1mJMs7ncKXrF3+r/ED6LUuuxt2PQhqLz1y+X2?=
 =?us-ascii?Q?i+6c4SkxuLUjVxQ/plePPC/8Jn/zc6D10wGXZeeogjWjRAZks82P+OIhTGaJ?=
 =?us-ascii?Q?ZCzEPNzNvBoo79V0PmXk+l/Hh2Uk3RXBfCavhcgD9bI4aEOegvBMXpyfY7jr?=
 =?us-ascii?Q?FKxmdKAe+T8XwM4xcm+1/dk/Jx87cRy0ad5zM6DtFb1L0W771zV2Jjsu90f9?=
 =?us-ascii?Q?JFizhcv9fsi6YAwmTWsmOJFr9oVfmCzhDyJ35wvEsw307YyBQgQWWcEgy2O4?=
 =?us-ascii?Q?BAjvLGTxA9+qxEnziVfKGAaYGLddMcY3wZWabvjvYFIWcInyahMeutIOhapD?=
 =?us-ascii?Q?Kn263hJ3ZRN2GHiyXJ+oo1jGJdMg48sJ3yknw13MXvCAW0SjwmEuxWoJVgHN?=
 =?us-ascii?Q?kAfYZ7lc5Jv4PB2jK+TfEdJBYF3Jt++RMuf5DC7Wd91YhQcMQwS5zKPw3BjC?=
 =?us-ascii?Q?pLwuzaKLm7RSGQwqi2ZNolvM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DSB+wdhmPh4/4SViPtVUsFsg+pElzxpKyANxfpKYjDlq5CQLCe9PEuQo5hUe?=
 =?us-ascii?Q?JzjLwZFNoWYYfqET7ADI+JzZxrJRbvrsOWeftv4Ss46ot2WQYL1KUPK6/PaA?=
 =?us-ascii?Q?Uy5yiE1SsNFv6i7IZiLDmvqql9XbRpU6MKmjTeyItJBH1DMbc0C4m2fQlpjm?=
 =?us-ascii?Q?liGP932LFH2LNA+htiFQR8yuTcZjlFFBUnzbV2XvGJ9Vjd1cpaSPhtk1OzB/?=
 =?us-ascii?Q?qtPRovlmFEcCJ3GO8Jx6AKro3TphplsrNc2HW+echU5l6qC8S3yPGzl0jgF8?=
 =?us-ascii?Q?S77Daaako0B11PMWTGYm66bGpk1weUjZoVUusjDlQrwPi/4m/FokyqaUm+5c?=
 =?us-ascii?Q?bHfHW47RVXnyL5eLvCHpmV/AWDJnay2HpKbunauZBWEBwR6Wyd7b0b/W3yI2?=
 =?us-ascii?Q?k/XuIEJ/rBO9AbcYcRJ1I//lMhiWBmH2PN6DxjgVnG9jY7c7lYVahU/QUJzB?=
 =?us-ascii?Q?xQ71pUnjA4wte/CG32g/r6dWoSF6Nv9AINcgTAzRnjORiO9QEr10S8Uyhplq?=
 =?us-ascii?Q?TnwfZ18O+Y0hlnqCEhQZBBV5Wb+MXA9/9wnz+tgKvR672cElqtln726XPSa9?=
 =?us-ascii?Q?CPlrJ9aYXTItyNy/c/ddV1W1olGKyON1pMfDcNJk79dBjGJM+hi+eMbyqk+/?=
 =?us-ascii?Q?L/oG1+YWycr9TOW50hUGI2XS6a88/hhvr8RPLMr5FoKzbPTj9SozOi0mFeTg?=
 =?us-ascii?Q?Nae28MxqXvRn+ZnGoQm0lUS7D1UXbd6tBWHcdbGP32bdmJzdvXlwForQr/Yb?=
 =?us-ascii?Q?xwSIlyoD8mHlGt5Qa5CAmBLnu0edmY1gmP5N0QR3MqolJIw5dzI59Kx7HW6Q?=
 =?us-ascii?Q?i0LhcMrZGXsGgZPzZTq8OwTbEmQdI0eFlZ6gE8RV/vDta5JUa+V4aJZzv6lF?=
 =?us-ascii?Q?ZHJD5yVNrn2DP3c8kHjO24UIu2SWlIFPwm4e3ziPRlpDo/DYyp+BakFnkpLs?=
 =?us-ascii?Q?S/g232oAa3a7ZgYvyKyL8aMvAoWI0c2mkutoNrS8v/80XHaR6hmH9Y7Z8p03?=
 =?us-ascii?Q?ez4QJnFAyFdGV4hk8dlaAqKqfd4XWriGfCVwEpvPGE4Dl28UJh4+1zevMl53?=
 =?us-ascii?Q?x2tRU6Y6YUmP/h7y96+jMAvDa+AwJtT1jhNiG+r9RbCb9u6dPqdfnEf8090Z?=
 =?us-ascii?Q?kDHtkqwQS9nC+4o3CwsgMU+Dvh5UfxgCu7d3/Y4naCKnFkcnUjF0tOG2HLrH?=
 =?us-ascii?Q?oF/f+WDfz+phRHNoqzj2Udcc7FB22ak8P9ozW7aYTt1e5jSGdIgCvpLQUSlA?=
 =?us-ascii?Q?w/TuIiLgqTt7uAIrq6ndIOIIwWD8QKCJrrsgvBgPFCwI+hQ5jqFmz9qVEbaj?=
 =?us-ascii?Q?QjNC6CgU+raehaSre1qLO5u4tzZwhwtIOD+gZC+rVIY1i3zANZxbN6qIaULE?=
 =?us-ascii?Q?pqDUExFdKgMqx1u2yHBUU3DsiFLayPv1kGGAfUJ9PJkJeeSMV5RmUKbwQV3X?=
 =?us-ascii?Q?twnuyP2U6qXDJA7U1uMlSENQOySmt8hdKcLwdAzgyp/GhmUbgIghL0Nd16NY?=
 =?us-ascii?Q?eSwoQak8c5cCC0YBt22RZjfzWRGld/gEv27x4yyT5XUK1as1i0AeFhsCbuIy?=
 =?us-ascii?Q?b0xNU2c2zybiZUvBGPahDC0ssdRI4V0rA4ejVDPMvgzyNOw0YKIcGlBp2lPM?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lKbSo/UEZUJHFXTZHZeFrhYEyC+sifrDlxOJDAboAdc97a82CTxbvLc7LAbloz4A4QF695qu7Ypw8TXbUAjiojIDf5a1m5V+c5YjtNDtexPNg1GSxXXVBGlxrCICkHKUEs+ZlC26/mX/Mai5/vBmIskjctbShacDr9TyM08ChOO6DZ8VSEi00i51horlBw97PryI34B8SemfwwIqbxdOm6IRGqYCo+u1dJ0HTezcQp4pqREwMqvZOEThQtKYDf6rHFpyCyAuUxpFqXTJJUZ29Zt/vLYXar+oV7Jt2FRLEQLyYjefuYOq5ctqZrwDn5X188p7zyPlPcdEU11GuNYAAHEJFGW2hSKl8+NkZ9vcNeh5MHQufdFEV1xsvM7+OY+mn1X0+9B9MksT0SNBnBDR6bf3JMtfwc3BQGYDa/8FtQnwJSekNOOsw+gaSJzOPozPyFVNFbt90K9PrsHMdd6E3OW6ZR8aMIxkJ8pLByN0vraGWRSzoKWzxli63gt/hNlsdcHUiztvoGMazeF+UmCl/wCjgWUKlaZPqTmLRa8clrFxlWXPP29w+KBszUvuv/kSTvfGLqZ3VI8a4fj7kuW+LuIwFyVPMMRYIWjg4ArlqME=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac11d8a9-eb20-4508-8383-08dc8c50ec66
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 09:03:57.2155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZY8vMVQmlCnTQWNUwVApoSyElywMeHcwz8lYqenO3y1fPlJ0exMIz10Q4LxAe042pjBrl//3/9yPpZfWg7Xq7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406140061
X-Proofpoint-GUID: pZfBEdmsKE6qkVpZAslx_tJcYyw1_FjX
X-Proofpoint-ORIG-GUID: pZfBEdmsKE6qkVpZAslx_tJcYyw1_FjX

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

The blockdev_mnt are not used outside the file bdev.c, so the modification
is defined as static.

block/bdev.c:377:17: warning: symbol 'blockdev_mnt' was not declared. Should it be static?

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
jpg: Remove closes bugzilla link
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 353677ac49b3..ced4ac990ec8 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -385,7 +385,7 @@ static struct file_system_type bd_type = {
 };
 
 struct super_block *blockdev_superblock __ro_after_init;
-struct vfsmount *blockdev_mnt __ro_after_init;
+static struct vfsmount *blockdev_mnt __ro_after_init;
 EXPORT_SYMBOL_GPL(blockdev_superblock);
 
 void __init bdev_cache_init(void)
-- 
2.31.1

