Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3704585931
	for <linux-block@vger.kernel.org>; Fri, 19 Jul 2024 11:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388609; cv=fail; b=PKw2ekTR0hWyk/Oq6RPX8SQLn8eV2rTWK2eMpEp73gd12Wq8/aTPIzsPgjK/msE1V+WTuz16/EJXcZBul15d1LJSXNVY0uoINziKExd9dflV3zcI94C8He403Gl8qvKGU/5NT6gNCPKsfNssJGabOttfDeEkZ7xHSw9Ojdu0p9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388609; c=relaxed/simple;
	bh=dxLj6xbFfIPMuv787U+48GlMhoG8Gd9LMp8smC35mAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i+iZ+xBmLGF+7OuOn3UgTe6tWFOJ/r91dv45wf9s4xlHF8R0voi3i22iQ+qyc2tTImiciyrwozmJMil4F60veR335K3EIUatdaHLJYFwQqJ3S+YFYkq/9cPLCA4lY6GvOIw70vzdxcpXAtUhrn5c+XD9/TjeMZR6lf9xEzI/ZLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NZylmhgr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DBsOUv5S; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NZylmhgr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DBsOUv5S"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46JBCIoR007772;
	Fri, 19 Jul 2024 11:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=lUwRWyOOeew8bw5GshXhSjH+KmjZF6vin+uSEpzyBMI=; b=
	NZylmhgrqfqmQmeqN1nOdF7Rhs8fd3RpWcFhyarEeesaAaP3opuMohMBb98vqklB
	CXTpqavFZYS7j7GWMdzIxPYU0GgQn0X3F6WoviNJzXrPwhtCOI9hv32nQsaDCcMq
	Po0nD4Vol2dztEUAjWy/5M2aR6rbyHDYDDPO2FN2aoHTJwAkfhIE7Qebteba0kdj
	GMTY2ySsTUIcO+/iYPMRPX3a7eqLiPNvjfM6aFboGhluXW6vp8IBjHYaxMTVi4Vu
	R4NprW+qRdOikOiFZjga9K9FuQqxHnnJU3mmy9QSa0UPBC0s7ob3WNogrt2f/fuI
	dpybz7XI5lZwLZ2SFjBPFg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40fq2h00un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:29:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46JBAtcm003757;
	Fri, 19 Jul 2024 11:29:47 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40dwf1mjte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jul 2024 11:29:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBVhKBnIiOHjrNhAa+m8A5/q8ugwiBhqkgJvaMtV0DQQcqhEwzcj2mbfz5iv/fcwnQqqBCukppm/8aAJKt8LHPhMETn8colH2Sq02Us8sdAq6ZIZsfG33Wa+L5y3o8kd2NUqprMe7XbCBhUEFtaTq15cHA1h+Wr8S5To1T0HIRyZpvY91sC1yG3PscScRA9FCArJXT96lR5aA+cW5ycOzuEWfTmj5SWn85hRfaE9G0/ApMitRkb5mC/onPPbedTl68VQM6XtL/GfFymSyQtehUXu1Nx82Skqx6S5IYI5BRgJ1segABgitr0A0r5Oz08XkkmB+envK9uyTJ4srubeZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUwRWyOOeew8bw5GshXhSjH+KmjZF6vin+uSEpzyBMI=;
 b=hkhSwtfesbnQfo7ImVXIPiPTo6FXSOgWUI/yYrO1eEx4E4ojJQYGtuxeIiFdlk95tTf98ZqU1au1Hbnc5kNgYhDjAHy1NjDSKhWwp+g7Z0FOqqE5oa1/d2o+qcj8oswpupWTA0udymg2cagcwdBvw5I76qdIzLeV+BB9aVhng9u9/PVj1TBoqnASssg9QKXTg8BRTAd/S58AkM9Jo9fIwGjtfYkn/UyprTiU0bFgwFUN55XIfuKzY9LNJbLUnRVi2Vi2Voi4bAiNUxQlOSQe8FuTYru712R33tfy64xg17hbbUI5MworEvI4u2Jp8bI37YscUDaVdtGQoCdmB2tGrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUwRWyOOeew8bw5GshXhSjH+KmjZF6vin+uSEpzyBMI=;
 b=DBsOUv5ShwbT00vO++9OFF/gKp02f/jfGl11TLqFYZJ7makvPIWW/u92EkCIctOo78hH84+swNK4X4RSYBBxfrgMF/NiHp2IEUEYw3OxzAvVHxbON4bMUfYzxACJh4msEVdDHbsMWKc/DD8bllVFpcyYog+NUz0nAZkodIY+iN0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6537.namprd10.prod.outlook.com (2603:10b6:930:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.30; Fri, 19 Jul
 2024 11:29:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Fri, 19 Jul 2024
 11:29:45 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, bvanassche@acm.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 04/15] block: remove QUEUE_FLAG_STOPPED
Date: Fri, 19 Jul 2024 11:29:01 +0000
Message-Id: <20240719112912.3830443-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240719112912.3830443-1-john.g.garry@oracle.com>
References: <20240719112912.3830443-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: def9c614-3c0c-47c2-c2ee-08dca7e61711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mxAa9WpQsLI9qBg1H4484FUrKiVUsHV758Hc2i5TPVfuYqHd5AVKFYm2OadE?=
 =?us-ascii?Q?TMAYgwnZTD7X/oFBpsee2/UafZtYB+msuY8WyVQHdBl+fJSV3u/aPTMadeHK?=
 =?us-ascii?Q?9g9+lUy1Dl0DZuDTZ8sWDbKXHsiXJ6Mmm1Fjevs6c8YeUwpEL5eRSlgIC5wU?=
 =?us-ascii?Q?3jlmWC+i35ODuR4CBrm65bH4U0uFx5BM8dG+LW9vyKOp4s/6RNyj9eyhHsjs?=
 =?us-ascii?Q?gsmfBDe51+AMGfHlVoc2ALGXHp8Qg/9DXwEDc5iijo7PyGfu7hGrI6ZtAoR8?=
 =?us-ascii?Q?610y6lSUfqs1Bvw5yyPXrZmEhhifDlvscCzmcr34SPisWWX2qBnJRzGIbdm5?=
 =?us-ascii?Q?PGNX+OL/FEgmCOwSwgUSHfwgDBl+ueAmXVCk6XN5PZP6zJtYQV9cWRSzk08+?=
 =?us-ascii?Q?cwPRPCkJSYRn+VLjvoJHdbA2wLKjLg4IPKoWcUj4kQXsw2o0f8MmhPMuHg3P?=
 =?us-ascii?Q?tVeokqxogAd0iU71dqjvDv9Fa2lrLlphJWzSPLvk1k4Trturv7bazqhDNvfp?=
 =?us-ascii?Q?dTNM8pyYpy77h1VMfHlGe9DW5V6RmiOXea/n1bi92okBE2i5d65CmlbYT/Ne?=
 =?us-ascii?Q?W7oGdaIniNZmZ8kAEsqcjEjuf9oFUOs4si35IiRlG+99i/KTqa9nogT7u97b?=
 =?us-ascii?Q?zhN6eKSU/IJn5WtFkME2WnxYHzuOY+V4xVRgquXx1byL6dz/9ioWagmQyb7F?=
 =?us-ascii?Q?8dAYeo1bQyBXM6UCVGnpT4JgbKxsFq7g3UWU0ePe93KAxyR4WzxkwZYowCyh?=
 =?us-ascii?Q?jgTmD/rECb6zM8r2AjHCuFuNv4Bl9mG+hKzaBx8pXjvsxRwmVn10MTGqSDQ6?=
 =?us-ascii?Q?4+vyGowS3dTXgtjxSRWXAbZ0XYtZnTPuU6tKhoPnPraDmUAJG2R4qPzQfw4L?=
 =?us-ascii?Q?l2zkcBfI9EdOmynjr0ZsSGi6PtZRw2k839GVowfqzqvjiq2eOqai9kxmg4O+?=
 =?us-ascii?Q?P5eXL6AWTQsfQ56hdKmgEoGsV8acDYhBWyzIrh5fLts5SkypcmYc5qdZ0ZSy?=
 =?us-ascii?Q?9iAxHpV8M3/wxD+VziXmayaEt2eNvzGPmsQHoTaHaNyJOkLxaQd4AcC1clud?=
 =?us-ascii?Q?eKDaNA9FEn1Xaw8XWDgWWHllS/Ouj+l4R2nVjmA9duvT4GDV02UJROrCh6KV?=
 =?us-ascii?Q?4ZO69UwTgK1bS69I9h0ovRsnfjDgj2iOeaOx+++Rcc3MFh13+7Tr4Onp1xHF?=
 =?us-ascii?Q?Y5tHDm7puAFetJjxbdH1o0eJDmN6s6mcF2KtHo5gVNhGRuPNh26Wy9ryPwyo?=
 =?us-ascii?Q?kFF8od2a4l4cq0u/tx2Ux+bLTDEtb0h89uctO4/2r/KitgEguW/BmAMY4Oze?=
 =?us-ascii?Q?GTjnrCiB4N/7pGWIFtgzexHCEWXvaLiJ2Ph8qpsGGV4sbw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?g3Y9hDflsqNCTzvk3t8VqvikMEH8zNDhw2DxLD04BSgIpIj5rNs7B6FS2XMU?=
 =?us-ascii?Q?1PIIyAH1nWAfrbbWG+B1N7vPEahe8+t8Es0udomLhXJffwPgKBZESFmAVJty?=
 =?us-ascii?Q?FsiA/cfNyoiE0/2Cr3AfTk/dPoATU+j/gEe+wP7OMKs3bTWhTkScMGiBZetl?=
 =?us-ascii?Q?nGPHFAhd0nTL+vjlf6v7SQE7vcGcmjjNk9udrvAQYG2hPHxXliz+YtNU7kzj?=
 =?us-ascii?Q?CR5eYcglzRkFNw5RHrSxu0G2yNNXJ+aNtfav3Svf9o340PCN4ApszAmUaPS5?=
 =?us-ascii?Q?qc5a7vpk8i2hmYlfZawBtQ++Erzk9IhZmwYyf5na2q6Vlw7bt7g5q0LKR1ZJ?=
 =?us-ascii?Q?a5HYg9g9ymV9rHKzQMv6JM+8fRpSU4nNh3qyzT0PMdYSpZMll+H5yspCz6Jm?=
 =?us-ascii?Q?8/NKvWO+B4Y26QNBMvJQXXqabjiFDtJpCKFv7t/jXRhgc9Vtt8Nu1zJm13Me?=
 =?us-ascii?Q?cJdvZShbl1YMbR/NJ+DnOdlc0ggUF9GIdaA8ZqQK//TN0M1qGkdH2hJa+uah?=
 =?us-ascii?Q?EhSJ6tL/cGaYOiGLkMu/4MKz/iC/Y1IV9McEE3cEcoI46L8R6+g0e2nF4KcR?=
 =?us-ascii?Q?JEDKbFZcmiN4hneY7aTBOQOTxkkbW8Ef6Z1EdDA+NF306/anvLJwjTL+vV/F?=
 =?us-ascii?Q?DI1WZ9aN8pCTcLuTcbyTqgM6dTozkqhPweYTuAy1B0jUrAzrAdQyfhfAqvSS?=
 =?us-ascii?Q?ADy2PyBZJmHT9qtfQn8qBle1mt0eh0uCAwvwG0V6FAsrGt2JoDNypa1QDvGO?=
 =?us-ascii?Q?+OE12fu/ZpS3eSlBbO2gaCcbInVXD/ks3KYZ02R6lS1rb2ODvau9IZXI+Vnt?=
 =?us-ascii?Q?ZvDkLRoa3bb94+aF1oTNwSrNeGzSkf8R70EOO+XNqJnY2trBajWrheA7f9YX?=
 =?us-ascii?Q?y1xgmHL/UtflUuy0iWXbCBuUStOlx7X9GRvPHMBZPkh3Qju7dk8sBxrftj05?=
 =?us-ascii?Q?kzZS/7Qr3F0DR+TcHwMPGiEWK211+qKedkp787fqhiOgmmNLtW4lax9nLtPt?=
 =?us-ascii?Q?17g8wPj5nEjzOGAkWSvJlLn6sVfD7snheIOuZw+7L3jRM+LQS7vto2ti2zyj?=
 =?us-ascii?Q?3iT5DBMENYckHDLH/KIkC2ZOj2KcXVIFKAVY4J2BlLnckG6vypUzBTLNuDYW?=
 =?us-ascii?Q?ZXGqIJ8xl76SQMBg5Ju6oDGHUWuakZXYMh6R1L4CPmXzkyRA2sS+xuaGVTlH?=
 =?us-ascii?Q?JA80LzB7qfsorMybw36QyBaFmg09zoGnNxcf0sBJqldfsG94nnsRvHM7QYAe?=
 =?us-ascii?Q?UGwvBDQEEgoary4D2XrltqlJKy2Bcyeeb/R6rfET6QLFYoF3/Hjs17dFnHbx?=
 =?us-ascii?Q?aExDk9XvLvoAhROWksT9dnt3lGebfiDy7/lG/3nxtdKHu++IOmdrNdTrnIF9?=
 =?us-ascii?Q?QzTyspH2c1PDkJ8evjXwUfMxlQb4YAvJs5mHy1P8hnCdxjTig7mIlpCOluOI?=
 =?us-ascii?Q?VLZlnWlNvioXBce2MnSN53/BwXZtF1d9dkIQL/nmOQJuyjuVsVUjIaVhkwSV?=
 =?us-ascii?Q?/fL/n1H9qpRN4baS7Y8FUuE7t27FrAs7t2z8WkkPPoh1HIGrmU537J0wIJlC?=
 =?us-ascii?Q?utY1RgxjEEFFqkYFZpslxqywChFsZov6N9GnaIkSJzuOiPuIVYpnBLKd8WYv?=
 =?us-ascii?Q?gQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dfmJDSXVgXg/6xTNIon2yBZx4FvLzhVDBgFjuVlM2imIu89gmzcdi86YPTWE1cFU9UxeZBTYJyDjh3HdhXpQ42l7Sq5Vtt5/+JM/2cFebIaJqP1JMv7d50pSstdQWRTwT2wkjde4UbDRF48AN1PETxzgswVSi79QpZDw1vn74p2Ul73wN1EdCsa24houQs3sa1r1Hr+OTLHY6kM/CW7y0Ksh7bFVpe7v7uT8brg/Meab7Z/QFwuPL1gEadsbY3pyxATAIfM+OhYYcoC+REfmDsvissz6HnBBA1newk4g/ipQGhJk1OLVfwTMobUgSmz9r9PX/rGwaGgERsRsnfo1hYnXa55MedDPOhjfSMIFnB/Cc/I+ecEaVx+JwUFRDq+v+Ww8h4DuCsJlqhe8s3yv8nJoAvdV4BAQH+fgBuhg0Nfyj3Qts/Q9BD1cIstoV/q0jrUbN/nVMUMEZR4eaZsZhQ3U3lWiMRIjDi4+8Jloh0/5iHtYqSaKpbtv5L3BefNOTczeF+JyDapUGZBOOfw11xbSzKP9j/DlfLcswCVrTFuLhtk75+lyi6plC6zjP4B0mhb41kpXCsBs0H6NhajX7RiYOikZZ0XZyliduvBLPWI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: def9c614-3c0c-47c2-c2ee-08dca7e61711
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 11:29:45.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iEvnouZM/cYYhTTXbH5H9CCWdxEvY4A+ntM0CUR2mnGPkP7UsqCE0nrJqNMTv9KFV6XaP4T4l+nvkEs04EGFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6537
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-19_06,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407190088
X-Proofpoint-GUID: 8ZLa8Hq61BPjffqM9U_Aq3WlnA389Ftf
X-Proofpoint-ORIG-GUID: 8ZLa8Hq61BPjffqM9U_Aq3WlnA389Ftf

From: Christoph Hellwig <hch@lst.de>

QUEUE_FLAG_STOPPED is entirely unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 1 -
 include/linux/blkdev.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 5f53796bd6e2..866e8c6bebd0 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -79,7 +79,6 @@ static int queue_pm_only_show(void *data, struct seq_file *m)
 
 #define QUEUE_FLAG_NAME(name) [QUEUE_FLAG_##name] = #name
 static const char *const blk_queue_flag_name[] = {
-	QUEUE_FLAG_NAME(STOPPED),
 	QUEUE_FLAG_NAME(DYING),
 	QUEUE_FLAG_NAME(NOMERGES),
 	QUEUE_FLAG_NAME(SAME_COMP),
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index dce4a6bf7307..942ad4e0f231 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -588,7 +588,6 @@ struct request_queue {
 };
 
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
-#define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
 #define QUEUE_FLAG_DYING	1	/* queue being torn down */
 #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
 #define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
@@ -608,7 +607,6 @@ struct request_queue {
 void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
 void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 
-#define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
 #define blk_queue_init_done(q)	test_bit(QUEUE_FLAG_INIT_DONE, &(q)->queue_flags)
 #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)
-- 
2.31.1

