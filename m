Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D9928A3FA
	for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671098; cv=fail; b=oKoDDdnBlPYLWEDjiEt8MESVwEBZp0TmAMvRsIRhEPpuNFPrnaWtdTU8MZj8DuN+Pwmmm1PfyXQE9GuRtypjFpkxDL3gu1dKADY50V2NcKimrG0OeiLpgCj/erEtdRr35aGlPIQPjmK5MLWHOdAxRYVbULVi264rN+K+IiJNQHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671098; c=relaxed/simple;
	bh=/a4csTg/1FMtGpOQPevbJadM2snkW8gBLHpxYgj2zVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MiXlaMkHJDMJ8GClDIAiJPWDH5To2w6muk7KRojUUJtNWbEvwhshM8wAIKYjH7GZRX8BKvCG+9ewHnatOdBrfc8MpOBdYDBNBwbtipOOtg8nSZd6wDb4KOEMuLZbaT5WoaDAmAd+Nl3S9Q1zpaKnn4we+YaMT7DLKUCxwTn3Gqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WQ/Nd8vy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q/yJ6+x2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WQ/Nd8vy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q/yJ6+x2"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1tn5S021080;
	Fri, 12 Sep 2025 09:58:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=COdncVTyz4icPbr5IzDOyPG2WUOsC1PdA1gHrbI5jsA=; b=
	WQ/Nd8vyuxE15cnONk5ZP6dWTHiEwi/zbks39uZo3OTJBikR3mqQe5ywNCfmUtwZ
	0rRVcKiZXdt6fzh9j2WTPxQwewVjV5sv0lxImG5i/CRBcmS+MdqK2e0SRFXRHJKC
	ppZYgHBdtsfihfkh5gQYaovYu7w7GzRVefxSBeCvmToCay8i9k2EEzvvONCzkt6D
	Y1FJCOcOO/JVhYdQaffoweg9aB6TuEL7dfzYGtengYH3uL5SsK2mVF9az0NAYKyD
	KzWVB61WzOArcm4YUqiu7R+/NwW5abUgHvI24AnvSE5xFKbFqLE23zmpQQXKEynI
	gIVeaOEP5TqeA/edSt6xIQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jgyyfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:58:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9uwj1002944;
	Fri, 12 Sep 2025 09:58:12 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdm6hm5-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:58:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhMyBvUnv5PPpZ/h/EsLTbg5yl+UaZQeebvG8mOt/RJzOS1qusN+yRnKm6jwrZmDXtHMElmcXBqvF3deYq0m3LM84erB+WdMfRH+OIgBMuedO2Z0ar7/7i3wmrFb39AYo1ofkEffBnJd3VAymz/FWAeqUrQ4gMeiTbsGOFuWQnXc+QSxk82/RFESwKqt78C6oePH6LlJmSEBJgS+g7X5TXHvUw7Eo36hQaGXkRbwY5l0D+HTmE8hmM5XbEBZJXhw7xL0ectwVM1LqRYTcnI1H6Zr0pKn6mfK1MB7FJHCKMUyc85VLuTHJr3Sdc0R0L7LXVyGS67AI+O8PrxTTcz1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=COdncVTyz4icPbr5IzDOyPG2WUOsC1PdA1gHrbI5jsA=;
 b=IaickCDgh/oxaPTLoal1berlSPraufjwm7Sm+v/K7A8/95GNeINQp/T/8d+qgnibY9x72AoDkHY4TnfSSppb+boqyzNRVTwsn+yHwhDHqzIBf8htiZJF5WVrXU27jKWYJZfjn0JR76exBQvx8rurjpyL6S8N51WLddxH3StS/RXUP/Y76VGnJ7sTy/RvVPKv+z6gKNFRcg+VSk3C850bGV31j69oYrkOkI/R+AGxMLhgMGd8FjsFKq9NnxzE+Y076hyF7dIEugzG1mJGIpgSWzAYAA/YWiGK7RC1185sm/haX64sYTKmfzgbm/UE7YEGRDJ1n5yz0L9K6+wU6CgvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=COdncVTyz4icPbr5IzDOyPG2WUOsC1PdA1gHrbI5jsA=;
 b=Q/yJ6+x2j4Rq/6IShG9m0qenKlpKymIfN6PvSIYRkkAFSIRQtE9iCmSFkMrVDfD3M/MedtBxCFdgzA6Nw533jNsM3EvGb9VSVjTMyDPDpqp2b21ruwsJmQDqbfsK8AELsABN/PV5YLKc6LhNi2V1Conya+HgVmn4uK9NtBjAsq8=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by MN0PR10MB5909.namprd10.prod.outlook.com (2603:10b6:208:3cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:57:56 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:57:56 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests 7/7] md/rc: test atomic writes for dm-mirror
Date: Fri, 12 Sep 2025 09:57:29 +0000
Message-ID: <20250912095729.2281934-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250912095729.2281934-1-john.g.garry@oracle.com>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0168.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:33b::19) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|MN0PR10MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: c9e97f06-5c51-45bf-1bad-08ddf1e2d8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aPrysDqtv0s6cn+nhBHlK6vRK4vv63TL4QzK/1ifC0SWJJ9zHe2qgWlz4SzJ?=
 =?us-ascii?Q?S+WukZ0+IJmVCv1XSXbh4IhP7KhjQ1UzBQnpoC40HrlyCX3TzrXGXhwMSAej?=
 =?us-ascii?Q?nb6Z1i9tDQTUfEUa4IqvW/hUEIZEFkJ/pOO/A/SwljcBdWrmjZXPaVCSseIJ?=
 =?us-ascii?Q?DEF/W0QLlZkGGboH9xtFpqAU1kKjGs/36C2wuqKHC/L1+0lxom+GanxxOAgt?=
 =?us-ascii?Q?8jW8ltroEtqaJobUZtUFnBZproGFxVC8ayr9TbBCvgTW0xeGBGNUCbMvTVfj?=
 =?us-ascii?Q?ciqUiHsEtCQTq1kErMam36VNt+Nu+q2iZdqWbdDLfjcN/wH1gqJUCbDP+qNd?=
 =?us-ascii?Q?ldUi2nCor9OBApoduroZ1Pkk8hdna0r2iMY+aYcbDQ5w0jBejat7uUMSR1wW?=
 =?us-ascii?Q?qRbz86Ex6/u82GlfoU6mDVV8SdjU25nIjSAE7GjhmuHdgpqpffNoA2Ki6ihq?=
 =?us-ascii?Q?J/PsRFDG/Z0oiCvmVH1uBI6rYYnVQhzu5x3oGdU3xnvLF9j/OaaMcJBs2Z1l?=
 =?us-ascii?Q?R1ya9qb6yr14JUfnOIlmBn6GbACQarvVZ7423OP+C+t8nGBEY0He+Se9NaYs?=
 =?us-ascii?Q?yXYhLKWeJLSbQz4j8BXKtx/hNyK0YkMPLx9driUyJ0olrz8gyXxY3/c5i7Ti?=
 =?us-ascii?Q?wWy7gxnXyTo3lOfK//oRfbgPGlsfqP2IR5gQl6QKZrAUm7ph1Ki1Ze1rtBXV?=
 =?us-ascii?Q?SaKtM6uVBhJcSrSGB5R9MKAeF9rxpe5co4V/s9wrYn60tEXJfSn20yD8KLQ5?=
 =?us-ascii?Q?s3F0digAgDMyx55vioMRM82Y2POepyvMNNewhbGNvvoDi6ADodNQH0MPLgRK?=
 =?us-ascii?Q?uPWL6owUhMPIvmKliV9hKfbW2N3Z5qr1g9HhS2B41O2cfzyk+j2aQTBh6yAh?=
 =?us-ascii?Q?mGWQ5xD6ZSkAOJeQpQy3iFgwEhxR06REx+rM19VPYDX30qQT1dV3oc/eOm36?=
 =?us-ascii?Q?ybhawQWUEFq9kXIJLdLU34rOULkOg/bdzj9TInLtlxYnz1G14HkvSk4CDkCO?=
 =?us-ascii?Q?zyiz27vgntqkao4T0rZiAZ3FHkKLJKJ+Mcc+wWqRZVtZPa4Eau5FqN6jxOs4?=
 =?us-ascii?Q?42gLrV4wsWM4WW1GAE6BDYGxHQbAXAgLWmkiZLFIt19y6nszRzY7iRa0mSuC?=
 =?us-ascii?Q?ZVvnO7sSYGye2+Y0M6FeOz30NaNLwQTmSTSkrwSW+1Lpr+MLcf3UxXrcWBjQ?=
 =?us-ascii?Q?0yTv/hWtQSmxMsuGT3Sv7WIRnKMFBf1glWyMfkAD9xLjGmq2PeBvmRmjNrJB?=
 =?us-ascii?Q?xWC0ZrIvmEaJ7LIEfLKiWEXKYgW41U9VsRZfhN2rTzumzl13ZUkGArs0D5Rg?=
 =?us-ascii?Q?m+UsBqDee0V3tuBptS58vUyLuIwyxTcw9L0g5oe/WyasFrdHfp8ifUnQbLRV?=
 =?us-ascii?Q?TnuO2EW/T+01cDwQMM2k9VQ/rC4HD8sFhFIaQIV5jqRtD0vDT3lXNoNyf97A?=
 =?us-ascii?Q?YZkIFS6dfBI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IbUBoUAm+aZxQVtBJnGTnoKXNMJ7ICw3zVvievV5w6y3klqrd2VyTfpoH9n8?=
 =?us-ascii?Q?/qy5WgJiwCIRofMTk0twhX/D1Ed5f8DMEKoziIRO8Mg6QfQ4PYk/dk5G6+fQ?=
 =?us-ascii?Q?6Bmq0wX+HROwIYJkVLteR96TpzcWm5wKUQGgcainy2uD1ibMt4b5jqlSxRxI?=
 =?us-ascii?Q?0/FljofCKHLaEBL5BS09MRhbg4dNqbzRk31FsMuT43hPPbTL3WxMGBikm21s?=
 =?us-ascii?Q?5O2iov4qiz5Peg4iYTXwMMQEv7rj4U49pBBGbI+F1u4tYX/ncKXAATsrJU+4?=
 =?us-ascii?Q?dtje1TNGYBtGmj58TCGn4+pdoSkg8iULkDnLwKuNlBRk/Ig4+JgWZ/BFE/LX?=
 =?us-ascii?Q?ICtxibtFte+xEDYfzKPXFq1LcDKGJIXF5rJTM/vbMeenr61BPcINjsvo7qb/?=
 =?us-ascii?Q?J3PAidNMkNkwy8bFcvEHKKUIb+itkln6WuoEyGUiLd+93wheL9/m1X2FYwh5?=
 =?us-ascii?Q?0aUtJmirWGu8koImQ99zGkaDhPvyo8DnOWKbJkR1eUdFF62kzTs3M0Ry/o4s?=
 =?us-ascii?Q?A8q8RUhlAihnEIfpQFEWM5Bvhpmfp458Q8F39JYhLU2P7Ol5q7/b2Sb02lEl?=
 =?us-ascii?Q?jelGMQhxqeAklPPCf+iUM1yiueHQMCtnQRFvFhS3T0ndCYMlF/4ThwnogRrO?=
 =?us-ascii?Q?cv2obWBL/GVnhaB5lcuZlFzzFkC1fG0FarL6KYmQpSdYBfMTn9yw2KfS0y5i?=
 =?us-ascii?Q?V/mg9S/+JFPAtUTKoE26wZsyoA5m5TL3oD1SOa1XtW8cDaYwO++CJHrIjxPa?=
 =?us-ascii?Q?G8aaY3okJ0/xqv2Me49PgNVvpR7JXWvP6iQC4qyrNJ2zY5LezLORBgCfyTqq?=
 =?us-ascii?Q?17HtTmcaBa86lHqz0MfcMiC49Pb/o89ALmj6Ni6oA4YcXLZTTaaL73AS7Wsg?=
 =?us-ascii?Q?60LYOjRLYqr1Z3tevz+RSYn+cF2EUiYAl6WbUSwE8fELoDtTvOAUaTZ0EEiw?=
 =?us-ascii?Q?a78GMq7qvsYuA2OT1IWANrRZlFY8neuifpi1bK7ucw0oDXI/8U/s3pzlUpiV?=
 =?us-ascii?Q?hb29K/P0/tdfApOua2eaSm71cQvpgyBjNCpnEhRbi7or+vhhQsz/QfARjkz8?=
 =?us-ascii?Q?+CWHyKLtE1vtquQ0Q3Tcs1bahBJ31Z3JI1rlVirY0acE0V/Anmb8j2AMTiRo?=
 =?us-ascii?Q?9zsXvgl8ORexsz8s/BJY6o0CN/Jx9gLLWQajJbuABW/xf0Yz/qBC+9i/n90Y?=
 =?us-ascii?Q?QNbAqoNhogay4HEkD+qfXG6e4GGUJZrAGefDApYIka2De1l7Vt5rtQRypos9?=
 =?us-ascii?Q?B2XuAGzWY5Cgf/u9YPdLlpp2rmb7j5LXwraWKLErLNDBKhgOmcBN1ihpEQRG?=
 =?us-ascii?Q?v0OS+ixJh8SQldAedWvm67kDcE3BoFi7bMoMKdYlzGHKIl+A7dk6hYTZoEDt?=
 =?us-ascii?Q?9jVUFXUIt9RxONbK6fMHsARTNfb1/mzCxctMMRicBGcqnjpWqDMsNFqjPOJs?=
 =?us-ascii?Q?yA5mrAf0bQLoxX6+RZx0L2nR8/JRx9YN/q62vv5TnWYyu1d4w3/Ai6PQvP+C?=
 =?us-ascii?Q?+R92dTTC/GS776B7vBhhQojITkvYZTUt7AipHbZn4U5zqfx2tuZQC1fd5LTM?=
 =?us-ascii?Q?Av2XB8MzH1eBjicmntSYJdb24eZD9PkBFe3SN7KTjQYlDWvrcy8N2yD4ZaDM?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pQzXbY1DZYctfpeI4/RhOhvbTQhOZLMzZh4pVujBLdCrJx0pEi+Iwjq+8GlpNQ43ag4yLXEhK75XtNQXtOe172fRHRR4riQfdV1iJl9CgefI+xAskwn6wyfvHijx0iU5HbxwQCVUGQxWwbWBfLoD/6D7hbuMDVK9ELfPNyPQhuhaeuH6c2j/tx8ZOt8LLPqmmQWiEko1h1GimC4wDlgSl2VUMBiuw/n9BQ9uPmsL1Fi7WEQmwSutStE4ltRgikbxP6rfr+QWu4Rx9NQyyTL5sXXneDdwAvXdAp6giXiQaPCJgwdeFMxlIafe29Bkg3upioLWKvxnmkPTHnMAiFMR8cmzsoOg/AdLJzLQV9Epdp2zmmCut8o8QBm2JQsP+wrfnFygi7B8AeqGJPYGL1d8iDZfKVjVzhq2WuY/zbTPx5Nj2AWaaW6JUd1xR4Si3EljOCfTwpDaRo6w50a2yOk/6BFQsfngeWZx5SKv8W3W0Axh9aSQzqUjWp0JO8jGDNSApdE3d9YdD5wyH35YFpNfqh2ZW+O6qLaOmGjXSsh/Uc7RzqtonwTdjCI+o9yWfKPlg0mbs6s8jywofHeQs9bQyjjIbTlV8MEFF/uyMveEpYE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e97f06-5c51-45bf-1bad-08ddf1e2d8fc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 09:57:56.3622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYvE/F6gjv0FVJ+a/3Zb+3FEK2+Ru5fnjoqpusZUSzdzquGKKIV/yguWRc7v4Z6TfszLUdITbtM+ZWx9BOPcjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120094
X-Proofpoint-ORIG-GUID: ias3vqr2DkpfkTXHjW8-EPMjC9Ddctqk
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c3eeb5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=UBAxYB4vsja0X90EuDgA:9 cc=ntf
 awl=host:12084
X-Proofpoint-GUID: ias3vqr2DkpfkTXHjW8-EPMjC9Ddctqk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX1CNVHGtHEOJY
 SIVpp/sKl9o2TRZOMFB9h+ZLRlHB8TRQQZ4OIuC2+IKoP/pOryFesQr6pdKJ4UqQACNRBkJdWr4
 CMwej9cmpg+VK9FdXvncsV0fclFZEU61W27nlNZzp+ghiZtmavlkPj0YtZD4V3JTZR/rvlK0CIy
 mFZ9tfx1z3HaftEDIjWe97qsQIaX13BuXqGre3H4WEyq+37JwcudJi8YtqaboN20pQmpdecd9Xg
 vHwietZlTO8AeA/Foqu/YSAGNiY8GSaIiJrbV9wNp5pzPdtpeYiCkCZEpChJXTY2XFk80l2r5d/
 mXf6NubKYxFfrF0b1BTpTmz82EACkfud4Wfskc51FSkwS9migbbKFG2DtQCHhVflfhTADQMPH00
 EIkeosjclWFpxgQkHzdGfuWzKt+tfg==

Raise the required device size to 16MB, which would be enough to create a
2M mirror array.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tests/md/002     |  2 +-
 tests/md/002.out | 13 +++++++++++++
 tests/md/003     |  2 +-
 tests/md/rc      | 15 ++++++++++++---
 4 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/tests/md/002 b/tests/md/002
index 0470a1b..de3d908 100755
--- a/tests/md/002
+++ b/tests/md/002
@@ -22,7 +22,7 @@ test() {
 		num_tgts=1
 		add_host=4
 		per_host_store=true
-		dev_size_mb=5
+		dev_size_mb=16
 	)
 
 	echo "Running md_atomics_test"
diff --git a/tests/md/002.out b/tests/md/002.out
index cce1b1c..c6628bf 100644
--- a/tests/md/002.out
+++ b/tests/md/002.out
@@ -181,4 +181,17 @@ TEST 9 dm-stripe step 4 - perform a pwritev2 with size of sysfs_atomic_unit_max_
 TEST 10 dm-stripe step 4 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
 pwrite: Invalid argument
 TEST 11 dm-stripe step 4 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 dm-mirror step 1 - Verify md sysfs atomic attributes matches - pass
+TEST 2 dm-mirror step 1 - Verify sysfs atomic attributes - pass
+TEST 3 dm-mirror step 1 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 dm-mirror step 1 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 dm-mirror step 1 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 dm-mirror step 1 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 dm-mirror step 1 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 dm-mirror step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 dm-mirror step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 dm-mirror step 1 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 dm-mirror step 1 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
 Test complete
diff --git a/tests/md/003 b/tests/md/003
index 3e97657..453669c 100755
--- a/tests/md/003
+++ b/tests/md/003
@@ -37,7 +37,7 @@ test() {
 		TEST_DEV_SYSFS="${NVME_TEST_DEVS_SYSFS[$i]}"
 		TEST_DEV="${NVME_TEST_DEVS[$i]}"
 		_require_device_support_atomic_writes
-		_require_test_dev_size 5m
+		_require_test_dev_size 16m
 	done
 
 	if [[ $testdev_count -lt 4 ]]; then
diff --git a/tests/md/rc b/tests/md/rc
index da04b4a..677efbf 100644
--- a/tests/md/rc
+++ b/tests/md/rc
@@ -152,7 +152,7 @@ _md_atomics_test() {
 		let raw_atomic_write_boundary=0;
 	fi
 
-	for personality in raid0 raid1 raid10 dm-linear dm-stripe; do
+	for personality in raid0 raid1 raid10 dm-linear dm-stripe dm-mirror; do
 		if [ "$personality" = raid0 ] || [ "$personality" = raid10 ] || \
 		    [ "$personality" = dm-stripe ]
 		then
@@ -218,7 +218,8 @@ _md_atomics_test() {
 				md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
 			fi
 
-			if [ "$personality" = dm-linear ] || [ "$personality" = dm-stripe ]
+			if [ "$personality" = dm-linear ] || [ "$personality" = dm-stripe ] || \
+				[ "$personality" = dm-mirror ]
 			then
 				pvremove --force /dev/"${dev0}" 2> /dev/null 1>&2
 				pvremove --force /dev/"${dev1}" 2> /dev/null 1>&2
@@ -260,6 +261,13 @@ _md_atomics_test() {
 				md_dev=$(readlink /dev/mapper/blktests_vg00-blktests_lv | sed 's|\.\./||')
 			fi
 
+			if [ "$personality" = dm-mirror ]
+			then
+				echo y | lvm lvcreate --type mirror -m3  -L 2M -n blktests_lv blktests_vg00 2> /dev/null 1>&2
+
+				md_dev=$(readlink /dev/mapper/blktests_vg00-blktests_lv | sed 's|\.\./||')
+			fi
+
 			md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
 
 			sysfs_logical_block_size=$(< "${md_dev_sysfs}"/queue/logical_block_size)
@@ -431,7 +439,8 @@ _md_atomics_test() {
 				mdadm --zero-superblock /dev/"${dev3}" 2> /dev/null 1>&2
 			fi
 
-			if [ "$personality" = dm-linear ] || [ "$personality" = dm-stripe ]
+			if [ "$personality" = dm-linear ] || [ "$personality" = dm-stripe ] || \
+				[ "$personality" = dm-mirror ]
 			then
 				lvremove --force  /dev/mapper/blktests_vg00-blktests_lv  2> /dev/null 1>&2
 				vgremove --force blktests_vg00 2> /dev/null 1>&2
-- 
2.43.5

