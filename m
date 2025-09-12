Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FFE289378
	for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671075; cv=fail; b=OyXBznxytKz8Q0Abnzh0/bNBIf9/Den5nitTJxMQlvj7vRlyNnIdCTbva66oDskE24S/VZksv199Jx0vRFJB9o3hu4hhnusAX9zhRO+slIH2JMiuiUFfYja0BrlW7CzzzMLRM/fV9dkvMGUfsxfTcRNTSQMNF6sEplhzFwx6kvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671075; c=relaxed/simple;
	bh=a7wzHoqeEZK26kGu/EUGxkhkmWi8GkTblMkXaMLnM7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NZXjZQyI6SS5PHJzan6SLIRp5IhNUHT3507TFWWkuVZ6J/r0cBeDC5YHh1OOyUYmMkVlfa0xm4f2H0uULsnehaGDNE+wbG3sUlPwiB/zUfwTqZX1+jCinIBlPHbjSJzRA4o0k0w48Pie+TrqbQvECydSC0cSKJ1CQakUFBiXwBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j4/VuGFZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E9YkxV+1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j4/VuGFZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E9YkxV+1"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1uEgp022712;
	Fri, 12 Sep 2025 09:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RPQAH/3lSuXAvErmWjBUUB49hYhsjBT6UWEg03BIRcc=; b=
	j4/VuGFZz23yWus9JhEeHHIIr2+BZA+MhbzJ7r6mObKAXc0o29Qn1zElAsukfbH6
	w3uVq3RObi+G1B49aVacprW6DS0erDIqtKXWZDOSMuELr8e0RARabWkrRfbaC19M
	IZto3wynPBSygFmOHOkQK96mUCuW5LxFMtj9QNUKMi8uwvvAQSFOuI8V71fJgk2R
	4N+eG3IgQwSmv3Hyt8rbdvPped8clrpCtpS70LQ5zgwkYw6ApIDRrZEx9FDmrmTZ
	v9VGiMcbm2nDaYgOqMNLFSulsWVM6i7DRWTvTxbWAdHtRK+bKx8cq//s8EKMWnzF
	6i39Zzd5ouX95QkZUv6Rfg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921pefxt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:57:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9Fitl030914;
	Fri, 12 Sep 2025 09:57:46 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bddkunx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:57:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmxvBqnAGaf9z87b4ixm6Ulg8/7FzOuY1raJFaViNI3f3vr8Uk49S4E39zoxpJWSt8NRXI5nrZxoChQGB1CL0K0GKlZu8Sar8/4FogdeqWseiivxFBBkeHOWdiMQ/y5N6Wlpw3fMSV1Mh5Fo5cidEzPbcZjE617gNt4EIpMsAxNkdOFedfKfQCXQrYkgw/S/lrZHUEkwA1oWqrDlYhsLobYJekMF9oTqD21a9gckxnNfL6YDy3O6H3tWpbd7fbBLvWv50GMyQOiQjTAx8uh2df8+L0xX0tzlL/7StpahtFYK8QAgT8UDyhuSGjr4Bu2jpCPcp20S+8+aZJS3F2mQsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPQAH/3lSuXAvErmWjBUUB49hYhsjBT6UWEg03BIRcc=;
 b=JRZk4MeXYLr85DrAtBDwck/jY7Kiwg6EAOwxTCdZ3kPoy0AazfCjvG7WkFK/IqeZN4CKuDSbKAdw/17dlWvw2fqPGvsVytNZXGc+VMnsivmq4Fyrl0f4KXLBpTaRgKUuWQsE8xpa2pyIdz9f5e1horWFjeAgj1sdAHJ5DHBn4YMs+12OOby/qM+pR9pBSNPfvngKW07Z2rLN5eiRZw69QOXSR3PQdeuTbsOS1V/qHwWiR0+fBFYNWSe1SuRQPEgXeEQtuYEUdyIWtLsA6KMNDS9W05mi5nqjDLGAeKOwJBcL587oVcIc5b8qSvlZN0Cui2w+e2Kd9fLD8buOiFvQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPQAH/3lSuXAvErmWjBUUB49hYhsjBT6UWEg03BIRcc=;
 b=E9YkxV+1TUUNxldyyKHCidGLKaJRiNGWRHTQbIDj2zCC6IIqEF3BN9mhajcL1e76cBsVOAQkyVNyTtvKyXbzUVvPgnz5UhFhLmrvbYtvLsq1A1dHxj86OygKqtNGRFoIKSjLgGM0rm7oUdGHgsc7Suu5HJD/ZIQ4GlNvUUTG8Ec=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DS7PR10MB5118.namprd10.prod.outlook.com (2603:10b6:5:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:57:44 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:57:44 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests 2/7] md/rc: add _md_atomics_test
Date: Fri, 12 Sep 2025 09:57:24 +0000
Message-ID: <20250912095729.2281934-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250912095729.2281934-1-john.g.garry@oracle.com>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0076.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::16) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DS7PR10MB5118:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa1e3d9-c79b-4dda-0737-08ddf1e2d197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8UeN8dG/MYrr529eKYA/gXY3WXS22ixLH4yRzS2dL/3rrMAIokBSDC4klMOi?=
 =?us-ascii?Q?zS42v/DfuR4RcHgGffM4XeqX2mqmjAREHScSP0DsB2PWyAI09DBNDqbESHWB?=
 =?us-ascii?Q?4y6ZtKRSV91Ch56q39OgfIBnEFvALmIK1zlk0M4rGzqqQSHqxeEU0yxd86Hf?=
 =?us-ascii?Q?NgpUwwx6sZrzR/j+P3JkC7dNh5AL73BML0Rz0f8iUOGUNgJfn/n/hIcas4rc?=
 =?us-ascii?Q?ibE1+21E8gbzMLTAUvz41ZDL1c3MZaFT9jca50mZZzH9k3Fm6Kf3m1uECfK5?=
 =?us-ascii?Q?yRFen1lgN2SJ0e+GaeonCdVGRpnJG+LN7UvIR8CP+2ynB+zYusr8zqzj7gZF?=
 =?us-ascii?Q?kv8GnYK2hUE/S78VEPd3tfByZ/I0sBAoUggqzQW/gTj8hYl2Tq8enW4qb2wq?=
 =?us-ascii?Q?JqgrCEbGvRE8srvXPSHVnLmenWhqy47/ctMIMEFG8WPhvvzPNOc3i52NfVZg?=
 =?us-ascii?Q?yw0669IqLqTtQA7WOZfirqcOXhJyvBpzV5DB6pH1AtDpZMh4kdXigRu3tEk4?=
 =?us-ascii?Q?rGIvVZYqJ3H2ImOWwraV+vlCno0pxyP+ZfzomrQfYWrpwf/cqx/i3YEpOmod?=
 =?us-ascii?Q?9oDdmBsZkHZf1lixr8/+2Pl+gZyaBEV9KZnh2DBkDzPychOv7bc6cJkhsXLn?=
 =?us-ascii?Q?JoEqvb35TfvfTxv2LHaWOl1TWdeumrwZNmdzoiq6goOaUP9XlwriZIKS6xoB?=
 =?us-ascii?Q?KPBdzhVpcKwH8iWsoizlH+kYni6mVRk5kpHnNyaoKDAo+XtZMiAMhHIzWvi7?=
 =?us-ascii?Q?k7Ba1ZVPr5MIj89AC19qYl1ExJLXtqqZcXbbSv/HKLdQlZTcWQKK/n5mMJRN?=
 =?us-ascii?Q?0c+1b+qhpM0EZOzzR6xB2YSGBydAEdPEZc02HGBTlfCTWv4fRyNWFLpC8UZ2?=
 =?us-ascii?Q?KWNcaqg6u2YjfTZ/cc+6LzxX+LrWXTHGxYJt0QN5OuFVHWUNqW+rfl/nzprn?=
 =?us-ascii?Q?bdo+z7SMDYGYUvg+/PLavnAWr4+ATDTEU5HO79XO65pipGHt5BwilBkMGP17?=
 =?us-ascii?Q?4/nFfoD5kPWZTwnijv/jTdV9CzqYxOY/y8RHL40sXqyY3v+WNoOpLZffpTAX?=
 =?us-ascii?Q?VwUQYvoR/8Ns4Yes3yg/FEV2oTEW8lAwB9qrBvzohK836MCouYCDfZ8+JIth?=
 =?us-ascii?Q?fDsd+eYBSXSBmFPY9wVPPBdcT8jZuzj5nRYdmY+lgd4TinMc6QMXKhYYPMVO?=
 =?us-ascii?Q?IzGQziUheJz8Flej8KmtZRUmsStPQJfOYXKsol+9HTuXE8Nxwmlt+ZvcMrNt?=
 =?us-ascii?Q?N46bMOIkUCg7q9JOfx/XtgTZMWwPE6inmrmdcbq0oT2FQ8CEQrGvWxzfyEaH?=
 =?us-ascii?Q?5EB2oqD5L+mi2sucGFBos2nn+5zlgMvsDYQzupDt1jdpDlmFffV5wZSie/5x?=
 =?us-ascii?Q?IL8ObqKFBw3t0Zf3YkQ0ja29Hd/0WSJRcAiMb5VNhPVzqkO/kEuQ4tNEhYSL?=
 =?us-ascii?Q?4GiGE8GKZMY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tlU1LU/QV2RecTb0dPX7RQWG+5INbDEtIWHA3QH2XgTPde+E6p69huxTfpd9?=
 =?us-ascii?Q?bipH83APmGG7HExpdk0cZ0sPoHT+xBFnfGU6L1ZT+lVUHKFjsvSxNomK3JjG?=
 =?us-ascii?Q?wICfKuN+WuQm0OPRbru5sZjIRyZJD5A5P+PxAleKiUxKG7SDs55smnXnofJ9?=
 =?us-ascii?Q?hZv4xn5PGSvasUJJNvEjEFYOY4dpNxFL2EKxYp21rdRP0+0Unzgfhy6GK0Yv?=
 =?us-ascii?Q?SCSPbp31Csi3MvjGZmkEDYQvysn163/gRzFipmMaBGkDOyNUAabUPPaCvQQZ?=
 =?us-ascii?Q?2m+DBRDPsxinVb4oBW4/Si21EWZWRTLkzeiPz90B+NmUwcHXFYdaeB10GXUS?=
 =?us-ascii?Q?47+C2tLYsIzUS58atS1pxfWfrLC7bmiIVTHV9dUoQp26stE9CdaXKLmvuQqi?=
 =?us-ascii?Q?xb2p40+AyOnxYPHYgqXT8MQkm8vGFNlPYW2h+ToLYfyS7yC8pon8/tnYzfNI?=
 =?us-ascii?Q?gUix1Ic+XhBzEvH9wEVc2ehWVl+2z91v0ore8dmkD32dxEe9Q+xNCTalTJRu?=
 =?us-ascii?Q?E3q8Rt+VKE2HIuC8yCwy+WYZClqGNuAiHGE0/raxRh2YY+swd0TMEh6ZYgpe?=
 =?us-ascii?Q?biuoVPjlm5vBZfDwJRBdgIyh/YNfMQCjMSnf//yHilOewnMUdu0jzxo8XbVD?=
 =?us-ascii?Q?s4Rhfq9gA+Xz+NxIVS17YTjKjBAIvO0YKwo3LGtGlln4GMhG8CKEZ3l0r8f0?=
 =?us-ascii?Q?Z57/X+PSGVTq14AtggmKUKaJAR9uRJn4rag1lCCvy89Hl850hYHa1wgmuZfT?=
 =?us-ascii?Q?aUF4OGkcPExUdE6HABtZezN5czTKMSfSo67t3Zg7QivpD0rwUUMCts9vrnRi?=
 =?us-ascii?Q?OO1dk6xfya9yDKCVKl7dhcFy7dKmY9il0a+I8ItQ5w2BAVfvDmN9k0QWsl5r?=
 =?us-ascii?Q?9pbmhsDIe9CeIpxoOQz6HdhrIVDv3XNKeByfSponaIz5lULWKzwkq8XaycP1?=
 =?us-ascii?Q?Fmb7ondZ8y1wOgsEHucPBKAWedAzSblb+FgmeEETTKQIPvveum8r7C94LGnQ?=
 =?us-ascii?Q?TdObH4abNdGhZEInKorAxUz7cWXjO/q3+RV9FI5NpcswwEUQRWQmU/JNhAEk?=
 =?us-ascii?Q?71JxddOXWD1i+gjJ8jw/agiR5qgEponXLPUuO5l6oVlJi168bIYghpDgCi0z?=
 =?us-ascii?Q?huFB3dS+6dBRWrbYFOYYhg41vneZG9+icRLEA3Ft78xRw+bfuDWHxzBH+Wx2?=
 =?us-ascii?Q?XfjNnlCGzlCNYEu9wA7k83Xkkkj62mjdmm+2H3NdlM7FRL76LVzwEF9CRV9Y?=
 =?us-ascii?Q?9ljPo3ezYvDDc8v0el/MiRfyOwcMbv/KUsRRud773nR5cz/SEWo6ILsuGg1e?=
 =?us-ascii?Q?mpWpUDsw5peeDPIZeBBqYaII6a9y7t9o9WMTvBySVNUEJD/o0iwpZsVu9/wm?=
 =?us-ascii?Q?fgjEhtitrG9g/kz2J7+F3KNsWHx8AH6cXLa35svz/jH3xlxAxH6kIBzOJnEQ?=
 =?us-ascii?Q?aQtOFMzC5fGJcw/GcPPXoGYoxZGiXQkxjus/eaNteP7rWH1jeYNKlPtOC/Y8?=
 =?us-ascii?Q?Bg7yAwE0y8qDcG6atlxnfLFkvauL4XZ9ZW7XjM4/Pw1PM7eFrs+2qW24Sd/c?=
 =?us-ascii?Q?nkLftbEcBOORuQNLmIQXx6yJn37E4sQsnApmVdATAyus6IKpLCb7RZceU8nr?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3Lw5VcDKwPosaW6tVpmh5U8YkQsf0nF2Z4HKtFuk3lkMrXIinY4J5xFoKEs23bkr2QOkaMjjtkE0VVwKUP+B/qHSdDAYX81S63FJHIsz7n6Hi4BTT+omwvlG3+fmJqEgq8kcMAQST6q0M0IaaGHmjYn2bgl80V1c0jbBO6wRubb5en3x9qtEJAul0Wu2x3dy6Vn4O8aU5mNnQPADNmyOOuObhj7yts7J4z960MWoFU+fcVPO154LlVGSeRfjjI0SZrNC3utGEzQrlAbF/eCBtrRTZ7ouqlVMwSsBS7nmxXdPJVKFdUO0FDScD1oqo2SiCq2YSzOofQkm0O2RFQj/v8sjSxfnVMCd5PEVQwhPhEThH/TG6neSZLQzApJ9vO+xHpjr0nj8GbDS1MOn7vV3yRPRc9UBcr86Gwx9m8mNzwf2zJ6/1EahguXZmzoWuj2SGP8+4ZtPfr5q/3kQAqajnRnxRJZiYlfj9fH8r838eG/9wY91EFRuWZlTOQT1aspJ0UmDe75YnOCKtxTiiD/RiOCj865GbKsDvAghpMLhVXiwSSg4CsdMmlPAaaN7WPDdlg7QANM4jSaQdROTPadVuuVoUOlP80BqoGs7ETY808I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa1e3d9-c79b-4dda-0737-08ddf1e2d197
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 09:57:44.1766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5J8801nXn2zvWmq3vF6YCuFcCxWCsoJFgrHHX7hryhf6jXm8CQl8L2ATvBSsnphnneZZwfUkVCiqAfN8ME4WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509120093
X-Proofpoint-GUID: 0Malyw6-Y0UsGueD7t0pH2-2tyGkA9xm
X-Proofpoint-ORIG-GUID: 0Malyw6-Y0UsGueD7t0pH2-2tyGkA9xm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX6afPJY0xFAm3
 oWps1jDIEafGlYb4kGjzxHA+xRoZ45mDgK18JXfsYGBYOdHy3KgUa1E8agvz/kLDTOGQkjCKbBj
 pBUB2mKNcENUReqF4uv32X7U93SmVpMd41DRa+rKwsm0101BbAhj3FbWclGbr11lXZLzRrRe+Mq
 S5SQtn9vbNDIv+lfMatQSuyvh1GYFWQGSTO7m1gjAcPVdhRJO8F0rGmkVKXgIQ3K+co+Cr6+XKW
 y6RD8hLwIWEvojy9NgxjpbTddbBT2KiMrcu/gx6GyHt3JsNNGJ52rTt8KORa0izZMXkSpqNzVgo
 PuJfmD+6M4KqbYbSxt0y8V4zYK6ZYClsfvqqyaCSWuJAtxanClbu6wrZjKwwDm1iuKUxsnkJunr
 6Gpy8kkj
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68c3ee9b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=rxNXlR3Y_y6O8_09eUkA:9

The stacked device atomic writes testing is currently limited.

md/002 currently only tests scsi_debug. SCSI does not support atomic
boundaries, so it would be nice to test NVMe (which does support them).

Furthermore, the testing in md/002 for chunk boundaries is very limited,
in that we test once one boundary value. Indeed, for RAID0 and RAID10, a
boundary should always be set for testing.

Finally, md/002 only tests md RAID0/1/10. In future we will also want to
test the following stacked device personalities which support atomic
writes:
- md-linear (being upstreamed)
- dm-linear
- dm-stripe
- dm-mirror

To solve all those problems, add a generic test handler,
_md_atomics_test(). This can be extended for more extensive testing.

This test handler will accept a group of devices and test as follows:
a. calculate expected atomic write limits based on device limits
b. Take results from a., and refine expected limits based on any chunk
   size
c. loop through creating a stacked device for different chunk size. We loop
   once for any personality which does not have a chunk size, e.g. RAID1
d. test sysfs and statx limits vs what is calculated in a. and b.
e. test RWF_ATOMIC is accepted or rejected as expected

Steps c, d, and e are really same as md/002.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tests/md/rc | 372 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 372 insertions(+)

diff --git a/tests/md/rc b/tests/md/rc
index 96bcd97..105d283 100644
--- a/tests/md/rc
+++ b/tests/md/rc
@@ -5,9 +5,381 @@
 # Tests for md raid
 
 . common/rc
+. common/xfs
 
 group_requires() {
+	_have_kver 6 14 0
 	_have_root
 	_have_program mdadm
+	_have_xfs_io_atomic_write
+	_have_driver raid0
+	_have_driver raid1
+	_have_driver raid10
 	_have_driver md-mod
 }
+
+declare -A MD_DEVICES
+
+_max_pow_of_two_factor() {
+	part1=$1
+	part2=-$1
+	retval=$(($part1 & $part2))
+	echo "$retval"
+}
+
+# Find max atomic size given a boundary and chunk size
+# @unit is set if we want atomic write "unit" size, i.e power-of-2
+# @chunk must be > 0
+_md_atomics_boundaries_max() {
+	boundary=$1
+	chunk=$2
+	unit=$3
+
+	if [ "$boundary" -eq 0 ]
+	then
+		if [ "$unit" -eq 1 ]
+		then
+			retval=$(_max_pow_of_two_factor $chunk)
+			echo "$retval"
+			return 1
+		fi
+
+		echo "$chunk"
+		return 1
+	fi
+
+	# boundary is always a power-of-2
+	if [ "$boundary" -eq "$chunk" ]
+	then
+		echo "$boundary"
+		return 1
+	fi
+
+	if [ "$boundary" -gt "$chunk" ]
+	then
+		if (( $boundary % $chunk == 0))
+		then
+			if [ "$unit" -eq 1 ]
+			then
+				retval=$(_max_pow_of_two_factor $chunk)
+				echo "$retval"
+				return 1
+			fi
+			echo "$chunk"
+			return 1
+		fi
+		echo "0"
+		return 1
+	fi
+
+	if (( $chunk % $boundary == 0))
+	then
+		echo "$boundary"
+		return 1
+	fi
+
+	echo "0"
+}
+
+_md_atomics_test() {
+	local md_atomic_unit_max
+	local md_atomic_unit_min
+	local md_sysfs_max_hw_sectors_kb
+	local md_sysfs_max_hw
+	local md_chunk_size
+	local sysfs_logical_block_size
+	local sysfs_atomic_write_max
+	local sysfs_atomic_write_unit_min
+	local sysfs_atomic_write_unit_max
+	local bytes_to_write
+	local bytes_written
+	local test_desc
+	local md_dev
+	local md_dev_sysfs
+	local raw_atomic_write_unit_min
+	local raw_atomic_write_unit_max
+	local raw_atomic_write_max
+	local raw_atomic_write_boundary
+	local raw_atomic_write_supported=1
+
+	dev0=$1
+	dev1=$2
+	dev2=$3
+	dev3=$4
+	unset MD_DEVICES
+	MD_DEVICES=($dev0 $dev1 $dev2 $dev3);
+
+	# Calculate what we expect the atomic write limits to be
+	# Don't consider any chunk size at this stage
+	# Use the limits from the first device and then loop again to find
+	# lowest common supported
+	raw_atomic_write_unit_min=$(< /sys/block/"$dev0"/queue/atomic_write_unit_min_bytes);
+	raw_atomic_write_unit_max=$(< /sys/block/"$dev0"/queue/atomic_write_unit_max_bytes);
+	raw_atomic_write_max=$(< /sys/block/"$dev0"/queue/atomic_write_max_bytes);
+	raw_atomic_write_boundary=$(< /sys/block/"$dev0"/queue/atomic_write_boundary_bytes);
+
+	for i in "${MD_DEVICES[@]}"; do
+		if [[ $(< /sys/block/"$i"/queue/atomic_write_unit_min_bytes) -gt raw_atomic_write_unit_min ]]; then
+			raw_atomic_write_unit_min=$(< /sys/block/"$i"/queue/atomic_write_unit_min_bytes)
+		fi
+		if [[ $(< /sys/block/"$i"/queue/atomic_write_unit_max_bytes) -lt raw_atomic_write_unit_max ]]; then
+			raw_atomic_write_unit_max=$(< /sys/block/"$i"/queue/atomic_write_unit_max_bytes)
+		fi
+		if [[ $(< /sys/block/"$i"/queue/atomic_write_max_bytes) -lt raw_atomic_write_max ]]; then
+			raw_atomic_write_max=$(< /sys/block/"$i"/queue/atomic_write_max_bytes)
+		fi
+		# The kernel only supports same boundary size for all devices in the array
+		if [[ $(< /sys/block/"$i"/queue/atomic_write_boundary_bytes) -ne raw_atomic_write_boundary ]]; then
+			let raw_atomic_write_supported=0;
+		fi
+	done
+
+	# Check if we can support atomic writes for the array of devices given.
+	# If we cannot, then it is still worth trying to test that atomic
+	# writes don't work (as we would expect).
+
+	if [[ raw_atomic_write_supported -eq 0 ]]; then
+		let raw_atomic_write_unit_min=0;
+		let raw_atomic_write_unit_max=0;
+		let raw_atomic_write_max=0;
+		let raw_atomic_write_boundary=0;
+	fi
+
+	for personality in raid0 raid1 raid10; do
+		if [ "$personality" = raid0 ] || [ "$personality" = raid10 ]
+		then
+			step_limit=4
+		else
+			step_limit=1
+		fi
+		chunk_gran=$(( "$raw_atomic_write_unit_max" / 2))
+		if [ "$chunk_gran" -lt 4096 ]
+		then
+			let chunk_gran=4096
+		fi
+
+		local chunk_multiple=1
+		for step in `seq 1 $step_limit`
+		do
+			local expected_atomic_write_unit_min
+			local expected_atomic_write_unit_max
+			local expected_atomic_write_max
+			local expected_atomic_write_boundary
+
+			# only raid0 does not require a power-of-2 chunk size
+			if [ "$personality" = raid0 ]
+			then
+				chunk_multiple=$step
+			else
+				chunk_multiple=$(( 2 * "$chunk_multiple"))
+			fi
+			md_chunk_size=$(( "$chunk_gran" * "$chunk_multiple"))
+			md_chunk_size_kb=$(( "$md_chunk_size" / 1024))
+
+			# We may reassign these for RAID0/10
+			let expected_atomic_write_unit_min=$raw_atomic_write_unit_min
+			let expected_atomic_write_unit_max=$raw_atomic_write_unit_max
+			let expected_atomic_write_max=$raw_atomic_write_max
+			let expected_atomic_write_boundary=$raw_atomic_write_boundary
+
+			if [ "$personality" = raid0 ] || [ "$personality" = raid10 ]
+			then
+				echo y | mdadm --create /dev/md/blktests_md --level=$personality \
+					 --chunk="${md_chunk_size_kb}"K \
+					--raid-devices=4 --force /dev/"${dev0}" /dev/"${dev1}" \
+					/dev/"${dev2}" /dev/"${dev3}" 2> /dev/null 1>&2
+
+				atomics_boundaries_unit_max=$(_md_atomics_boundaries_max $raw_atomic_write_boundary $md_chunk_size "1")
+				atomics_boundaries_max=$(_md_atomics_boundaries_max $raw_atomic_write_boundary $md_chunk_size "0")
+				expected_atomic_write_unit_min=$(_min $expected_atomic_write_unit_min $atomics_boundaries_unit_max)
+				expected_atomic_write_unit_max=$(_min $expected_atomic_write_unit_max $atomics_boundaries_unit_max)
+				expected_atomic_write_max=$(_min $expected_atomic_write_max $atomics_boundaries_max)
+				if [ "$atomics_boundaries_max" -eq 0 ]
+				then
+					expected_atomic_write_boundary=0
+				fi
+				md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
+			fi
+
+			if [ "$personality" = raid1 ]
+			then
+				echo y | mdadm --create /dev/md/blktests_md --level=$personality \
+					--raid-devices=4 --force /dev/"${dev0}" /dev/"${dev1}" \
+					/dev/"${dev2}" /dev/"${dev3}" 2> /dev/null 1>&2
+
+				md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
+			fi
+
+			md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
+
+			sysfs_logical_block_size=$(< "${md_dev_sysfs}"/queue/logical_block_size)
+			md_sysfs_max_hw_sectors_kb=$(< "${md_dev_sysfs}"/queue/max_hw_sectors_kb)
+			md_sysfs_max_hw=$(( "$md_sysfs_max_hw_sectors_kb" * 1024 ))
+			sysfs_atomic_write_max=$(< "${md_dev_sysfs}"/queue/atomic_write_max_bytes)
+			sysfs_atomic_write_unit_max=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
+			sysfs_atomic_write_unit_min=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_min_bytes)
+			sysfs_atomic_write_boundary=$(< "${md_dev_sysfs}"/queue/atomic_write_boundary_bytes)
+
+			test_desc="TEST 1 $personality step $step - Verify md sysfs atomic attributes matches"
+			if [ "$sysfs_atomic_write_unit_min" = "$expected_atomic_write_unit_min" ] &&
+				[ "$sysfs_atomic_write_unit_max" = "$expected_atomic_write_unit_max" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail sysfs_atomic_write_unit_min="$sysfs_atomic_write_unit_min \
+					"expected_atomic_write_unit_min="$expected_atomic_write_unit_min \
+					"sysfs_atomic_write_unit_max="$sysfs_atomic_write_unit_max \
+					"expected_atomic_write_unit_max="$expected_atomic_write_unit_max \
+					"md_chunk_size="$md_chunk_size
+			fi
+
+			test_desc="TEST 2 $personality step $step - Verify sysfs atomic attributes"
+			if [ "$md_sysfs_max_hw" -ge "$sysfs_atomic_write_max" ] &&
+				[ "$sysfs_atomic_write_unit_max" -ge "$sysfs_atomic_write_unit_min" ] &&
+				[ "$sysfs_atomic_write_max" -ge "$sysfs_atomic_write_unit_max" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail $md_sysfs_max_hw="$md_sysfs_max_hw \
+					"sysfs_atomic_write_max="$sysfs_atomic_write_max \
+					"sysfs_atomic_write_unit_min="$sysfs_atomic_write_unit_min \
+					"sysfs_atomic_write_unit_max="$sysfs_atomic_write_unit_max \
+					"md_chunk_size="$md_chunk_size
+			fi
+
+			test_desc="TEST 3 $personality step $step - Verify md sysfs_atomic_write_max is equal to "
+			test_desc+="expected_atomic_write_max"
+			if [ "$sysfs_atomic_write_max" -eq "$expected_atomic_write_max" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail sysfs_atomic_write_max="$sysfs_atomic_write_max \
+					"expected_atomic_write_max="$expected_atomic_write_max \
+					"md_chunk_size="$md_chunk_size
+			fi
+
+			test_desc="TEST 4 $personality step $step - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max"
+			if [ "$sysfs_atomic_write_unit_max" = "$expected_atomic_write_unit_max" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail sysfs_atomic_write_unit_max="$sysfs_atomic_write_unit_max \
+					"expected_atomic_write_unit_max="$expected_atomic_write_unit_max \
+					"md_chunk_size="$md_chunk_size
+			fi
+
+			test_desc="TEST 5 $personality step $step - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes"
+			if [ "$sysfs_atomic_write_boundary" = "$expected_atomic_write_boundary" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail sysfs_atomic_write_boundary="$sysfs_atomic_write_boundary \
+					"expected_atomic_write_boundary="$expected_atomic_write_boundary
+			fi
+
+			test_desc="TEST 6 $personality step $step - Verify statx stx_atomic_write_unit_min"
+			statx_atomic_write_unit_min=$(run_xfs_io_xstat /dev/"$md_dev" "stat.atomic_write_unit_min")
+			if [ "$statx_atomic_write_unit_min" = "$sysfs_atomic_write_unit_min" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail statx_atomic_write_unit_min="$statx_atomic_write_unit_min \
+					"sysfs_atomic_write_unit_min="$sysfs_atomic_write_unit_min \
+					"md_chunk_size="$md_chunk_size
+			fi
+
+			test_desc="TEST 7 $personality step $step - Verify statx stx_atomic_write_unit_max"
+			statx_atomic_write_unit_max=$(run_xfs_io_xstat /dev/"$md_dev" "stat.atomic_write_unit_max")
+			if [ "$statx_atomic_write_unit_max" = "$sysfs_atomic_write_unit_max" ]
+			then
+				echo "$test_desc - pass"
+			else
+				echo "$test_desc - fail statx_atomic_write_unit_max="$statx_atomic_write_unit_max \
+					"sysfs_atomic_write_unit_max="$sysfs_atomic_write_unit_max \
+					"md_chunk_size="$md_chunk_size
+			fi
+
+			test_desc="TEST 8 $personality step $step - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with "
+			test_desc+="RWF_ATOMIC flag - pwritev2 should fail"
+			if [ "$sysfs_atomic_write_unit_max" = 0 ]
+			then
+				echo "$test_desc - pass"
+			else
+				bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$sysfs_atomic_write_unit_max")
+				if [ "$bytes_written" = "$sysfs_atomic_write_unit_max" ]
+				then
+					echo "$test_desc - pass"
+				else
+					echo "$test_desc - fail bytes_written="$bytes_written \
+						"sysfs_atomic_write_unit_max="$sysfs_atomic_write_unit_max \
+						"md_chunk_size="$md_chunk_size
+				fi
+			fi
+
+			test_desc="TEST 9 $personality step $step - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS "
+			test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should not be succesful"
+			if [ "$sysfs_atomic_write_unit_max" = 0 ]
+			then
+				echo "pwrite: Invalid argument"
+				echo "$test_desc - pass"
+			else
+				bytes_to_write=$(( "${sysfs_atomic_write_unit_max}" + "${sysfs_logical_block_size}" ))
+				bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$bytes_to_write")
+				if [ "$bytes_written" = "" ]
+				then
+					echo "$test_desc - pass"
+				else
+					echo "$test_desc - fail bytes_written="$bytes_written \
+						"bytes_to_write="$bytes_to_write \
+						"sysfs_atomic_write_unit_max="$sysfs_atomic_write_unit_max \
+						"md_chunk_size="$md_chunk_size
+				fi
+			fi
+
+			test_desc="TEST 10 $personality step $step - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes "
+			test_desc+="with RWF_ATOMIC flag - pwritev2 should fail"
+			if [ "$sysfs_atomic_write_unit_min" = 0 ]
+			then
+				echo "$test_desc - pass"
+			else
+				bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$sysfs_atomic_write_unit_min")
+				if [ "$bytes_written" = "$sysfs_atomic_write_unit_min" ]
+				then
+					echo "$test_desc - pass"
+				else
+					echo "$test_desc - fail bytes_written="$bytes_written \
+						"sysfs_atomic_write_unit_min="$sysfs_atomic_write_unit_min \
+						"md_chunk_size="$md_chunk_size
+				fi
+			fi
+
+			test_desc="TEST 11 $personality step $step - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS "
+			test_desc+="bytes with RWF_ATOMIC flag - pwritev2 should fail"
+			if [ "${sysfs_atomic_write_unit_max}" -le "${sysfs_logical_block_size}" ]
+			then
+				echo "pwrite: Invalid argument"
+				echo "$test_desc - pass"
+			else
+				bytes_to_write=$(( "${sysfs_atomic_write_unit_max}" - "${sysfs_logical_block_size}" ))
+				bytes_written=$(run_xfs_io_pwritev2_atomic /dev/"$md_dev" "$bytes_to_write")
+				if [ "$bytes_written" = "" ]
+				then
+					echo "$test_desc - pass"
+				else
+					echo "$test_desc - fail bytes_written="$bytes_written \
+						"bytes_to_write="$bytes_to_write \
+						"md_chunk_size="$md_chunk_size
+				fi
+			fi
+
+			if [ "$personality" = raid0 ] || [ "$personality" = raid1 ] || [ "$personality" = raid10 ]
+			then
+				mdadm --stop /dev/md/blktests_md  2> /dev/null 1>&2
+				mdadm --zero-superblock /dev/"${dev0}" 2> /dev/null 1>&2
+				mdadm --zero-superblock /dev/"${dev1}" 2> /dev/null 1>&2
+				mdadm --zero-superblock /dev/"${dev2}" 2> /dev/null 1>&2
+				mdadm --zero-superblock /dev/"${dev3}" 2> /dev/null 1>&2
+			fi
+		done
+	done
+}
-- 
2.43.5

