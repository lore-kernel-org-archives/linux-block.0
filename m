Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA6155303
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523170; cv=fail; b=LhBNklCEyrTHXFzLHEPxmUSwZXHizz0rp38CkCMNUNpUEPk18xS0jOS5PaGkdPwfipRMSEtJ9tyQsZumscGAod0TCnrsfAWqbRYZKJjLaf3HrjkhuS7IRU7lK4zXi3kkosOdggiA/vGhaLH6k42bwHqHH25wOR5nupgMUVbaAQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523170; c=relaxed/simple;
	bh=YSAfWmQxthv7CZxE1FZasBdf/exc/YRRb63pU50IPq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hL48ykUJqP+A1osUvptO1XYBnnxP3YUW6/GoetBQPp4fj1zr1LJSL8k2CyeOV8HR0HQSIk+bFUltcVb5GdTLg/BYXMM91Rgn4SFTqFx1inbcJ2CbgfmdWCJ0nRPZqapZccfyGnbwcdX3zPe49PpLJhfgER+zZwvEdIgYtQVHhrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FxCkOjt2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mY7pW1qU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FxCkOjt2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mY7pW1qU"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tVlO029509;
	Tue, 9 Jul 2024 11:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=uEUDrmPZ0x2Q3si2eXb6PNFZDMXy5CV5jGtngHpiKE8=; b=
	FxCkOjt24lrlzgjN6cRVfu7oiGPvXR4ippWXkFHj9SY5Z4hJv4oAvWcJyfQpFMPk
	MXvl9VvclPqZXMGzepKFIdpOgZoonCuwgSFhJfdOeDFDa61Z+luJ9WoXq8EDYT8B
	u4NAVQTX1J8SkZanAVwFQZy8QSG6J4LGZvNDQKE2MgLKbA1gKcOABwVnxHWnAgob
	ZkYhVQUHIoEZ9K94RT0uaa5l5pJ12IpxHjWFL5mCZxF9whDTfU/DcdDsBh+au5kz
	F1zoGyGA/pRS3fmw7AKpHi0rjOdzcZroe4xsw/cp0Zs3hFeaUzCj2+Z8fq3cjaHO
	F2jraZeosWxkcDxLlcd3ow==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfsmnr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:06:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4699RE3I005701;
	Tue, 9 Jul 2024 11:06:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tx2hh8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:06:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAqjsm3b6JXCR0QUzsH5SuRwL9EpG4sEcKiayVzEzi0hS2PY1D4bXtWwwzwR0oN3+vvkQ8afHTz7UkBPOqawYJBCK284SjTthkcr9l+WhV55wouuej6WGv833BvBpUKKGnKiKERWwQHRjd9qHE6P0FG/Opis41MLRcF17sOjkhfK8EB1ArCOo8z18qe8lCqrL9uJMAkL1f4VVmoATWhJ8AHye6cMLFY7/H4P0Et6GsKKmEwW/Z8h4j/zUXJgU/ZEPsF7XERZLos6jFY38LL6AIt44iokx1/muRbsEJpvpxxqRYdfU4TFi6E5z2UpP6Tn9PYoTmf70MwpiFPiesHyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEUDrmPZ0x2Q3si2eXb6PNFZDMXy5CV5jGtngHpiKE8=;
 b=DGivQ4sdvg0Xl3J5VakijxDFfI/7HxY/tI4NsRlvB/Ic5RT/FOWkdh/uwuu5yJEbfKWldDle3yuT06+pCTKNPJWF3fXQDNAO4Qh+NQ2BHSunTcCr4sn92U6khrqN4HlrzLdtii8MjCCB5nn1rvmjGEGgbaUpQEvMPxWJ8vEqJjgSp3HHkqX8XJfHkfBJf6a5ebFvE8zZrGcNwOY5bES2QWCh1oyudBzECptrYQtdd35c4ua0SiSiGd99y0Bq+nCQkXZJPrztIKZU7T+o2oUlZ0jYmY/z6x9CVDVngrQlGkY9D1ENPOyfRRr7qXHc6wTEy4ZUvke5Wfg/rtHfqBd4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEUDrmPZ0x2Q3si2eXb6PNFZDMXy5CV5jGtngHpiKE8=;
 b=mY7pW1qUgWbwVGsHz3qqSHEW6PVtO7ZLK6AWpq6fG4qsiY+dxjtAq+5X8Zu17SEEXQSyRrlbdaMa/pFDDZM0cIerzRRIlelOzxBe/YiGOqSRdcVED3GLaMJN7ox77vryqy30u10pZU8LWb5v1d7mS84gWHKfAas62F0Qt6ZXSX8=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA3PR10MB8068.namprd10.prod.outlook.com (2603:10b6:208:505::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 11:06:01 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 11:06:01 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 08/11] block: Catch possible entries missing from cmd_flag_name[]
Date: Tue,  9 Jul 2024 11:05:35 +0000
Message-Id: <20240709110538.532896-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240709110538.532896-1-john.g.garry@oracle.com>
References: <20240709110538.532896-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:23a::19) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA3PR10MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: d2860471-b5ce-48c1-71dd-08dca0071e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?v+dS2r6ZnOPXKkuj3416b/oWJOHwhJqMiLNnxPzgx3Fqfm+pLjlj5gwu9u6p?=
 =?us-ascii?Q?MLSYQ8FzJFeewWA13Pz29LaeVt0MCiQ2iucyk2fsjXPz6iB48VidhWGIZptf?=
 =?us-ascii?Q?eljYqYS7OGT1hP2CApyC0u6mnE2Y3TerUVGiOyCaBEJj6BwtJ6EHoIRkPZfE?=
 =?us-ascii?Q?MLjFhVgOETc4t63ijU9bgoBs/mBhYy12r/GpRnUXLgz5YvJacDRsBTYXeCAO?=
 =?us-ascii?Q?LpHodkstq/TBsWM9AnRoP+mqQ2Z+IJLGDz+657F231ZWgilr5kT2ndYNer8J?=
 =?us-ascii?Q?AHLngUTnc/bgsrjn8h9pt8lusBKRWC6Qds+5X6tJOGsuPdN2a2ieJPpwadoj?=
 =?us-ascii?Q?CoEyKLywMdnGIlCB6ItkajF4X/g597j+e3ajFCXIHonK3FxHazzp7Y61wOoL?=
 =?us-ascii?Q?UuWwQovO2wgCT10Za3o1M4pXJNmqKJsfCwNrIK973seTwC7Nsh5cvzuvrE3u?=
 =?us-ascii?Q?hviIFbUES9zf/Fulye124Fb86Pr0+cAqdoReU60Sre5KQkw/hQn4Z0Tuac9K?=
 =?us-ascii?Q?cq11lK8MD34b81r7ucAApZ1c6NclhiXChsA2dn6ss35nHXUXVbAO0dyNKGxM?=
 =?us-ascii?Q?Je8GNcZO8KmrnZcLrRuz/D0RE9CkATb19zrVXgU/Chl4UbZCy3hPSkSq47Ad?=
 =?us-ascii?Q?zInCOCBaH6NJTIeW41K78dExwc+qV+9oeDEhOrVdGDfVrGxkG1uiZWo88Z3H?=
 =?us-ascii?Q?TS8H6mROmW2ywdyO6pU0c5icD5l6ajJejL/qkyRAB0g7fv32mN93rGfjwVnp?=
 =?us-ascii?Q?H5OrGkBhqusF2aa4ECpCwVnmNuL25ZZXDus/fzt9eEwuHg9Q/yo9kaOcbQW+?=
 =?us-ascii?Q?xfG7Ya7x9NQeVu5a2zp2AnnVfbm8WLq0+OKuXVcm7CtTeHn/HqXe0L8w9Ibj?=
 =?us-ascii?Q?visIbXht443bMDzFFQActMeHky9m9aNLz4zi3SFhNcWyZKKlgarakmxsBFJz?=
 =?us-ascii?Q?PalLLTBVanYYydiScs0KAIly85pgiBft3dSzTt/0reXo7dSVEE9hVJJZYxlI?=
 =?us-ascii?Q?YIwvAFIOjIgIWzxWhXcnNebUnot6FyvgkDUlR10fHd/K1ewKLduk+f36ppr5?=
 =?us-ascii?Q?NokKEZ9Mps23Iz6sbbpDbLLxWbbclu1yttXqudpYnmmBSr7o6ZV5zj/+HXRl?=
 =?us-ascii?Q?exICD4E2aol/+2EpeShKdaDlmbzXmtOms9aiMfWiysR2SB5k/W1uxHhBBOqV?=
 =?us-ascii?Q?qy+jCDFcLAPEUBG3hFGvZRufRmVU64JKViGtsMkot/VDGtnBwKQteayK6rEX?=
 =?us-ascii?Q?rZJ1YqUsl1EwTVOQocZGbRDwzvb/pRDvBwjOHUM4iZOgztxIFI3w77waVQ/5?=
 =?us-ascii?Q?GCmn252rGZozZ9rd/6vZ7Q+OP7V8pANE0vOWXyvnnEzKRA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TsSFhLs6APM7VmEKIwtTSguLg8I1vRx11fwen4qckBmw5ZRVAh4IqDIZoEdC?=
 =?us-ascii?Q?CZ/A2q23snkmP8ONvsgGGC8EPOSVRVRIdoGpSrPuB+sJ3Jbl0nyGlqh5nBpg?=
 =?us-ascii?Q?7S2ObXP3Lv1q1JHCbLOFA1leJRqJAIRhjrsNHFPvLJ1zuuOCmxoAQ8CaqKnw?=
 =?us-ascii?Q?7PvRWGuPx7aYV5YCae4BaSz4KlIxyIvRv4HhNSUDDS2riCiff3ubv4nj9VBm?=
 =?us-ascii?Q?sn8F9kF6b4zDnU0ZWZtZovOMdXTWjsm8kC7Ju8jr+4QWCZQL2CZnJiPTlTOZ?=
 =?us-ascii?Q?/ChBc7z7w5rP6VZApX+wI4pzkja5RFidDvVry4UTVuqvEzrUXBca5d/hfInV?=
 =?us-ascii?Q?dH26nqNbLmOCPe+WNuCsXnW8f3UGbBYns8pgdgx+jnvOeulBWfqaEYomRnWE?=
 =?us-ascii?Q?+LkFXSWrVoqlB4mBeJDzo2GPCLwEvLOA2msLxhPjfHNk5GO0UsCNLAx8PbeA?=
 =?us-ascii?Q?q5P67Xq9PG1cLHdcx6MmC1gHqiM0rz6NUEDS6gtqv5WiOm5ko/3q4DbkRm/l?=
 =?us-ascii?Q?FLTLXEWgoyjsl/wnqWhtDlnkW5zzrg2H9vWQf4xPPm/Iad0jASEXRxk9exoW?=
 =?us-ascii?Q?F0GePtSIn5yp9Uoivh/s+m1E+Cn5R6VlQPmC47468d8aB0/I995mJCvLdWhV?=
 =?us-ascii?Q?GitU4p6lqum8Moi+2zudnbEzAIb65NWr+8z+tfefC29df7As7xtdq+Cofc/4?=
 =?us-ascii?Q?2Ppp6HXHbCwqonwc+Jh9qPIns6qgWErxgFPBDkT4POpIj4TGjwEPyOKzSX5I?=
 =?us-ascii?Q?RQHrwa2NY+nwH3ZajKyADwn+AWlEu7ajJJOnW0k2UNylTEWVI8jGers0yZxZ?=
 =?us-ascii?Q?9pEhDUYQAI6uk7EIoHSw0luY5LW+wvw3otD5eKecqmxHIXdsm5MlMd9U0HUP?=
 =?us-ascii?Q?IZR58Z0pJvvMvexSQEmV2XZwKii25ctqaF7H/NwTfIR1lDKsyc2ipuQcaV7o?=
 =?us-ascii?Q?6R699I1lUOqKNpZkrVNJK9KdYqNg1Ve8NDybFxtoEKbcXMn5kloDJFHX1kCw?=
 =?us-ascii?Q?zkN9k3ZOp0D9YOlN4e04Nmmh9kC+XGtsYDEeUTlkfnRqO+jrLN08vb4y1Hgx?=
 =?us-ascii?Q?AQV1/xD44ljgsBxEs3BYpJDLtugisJFu6koF/sl2qrwqEZlWzYUmFV6INOe3?=
 =?us-ascii?Q?6BRsti3HioZ7hhwQc6vn45W+SUpiSr0+vG8GErwe11bOiDlrFSsvfMVdXtf5?=
 =?us-ascii?Q?ko9xRDIQjEfbAiHgP0VTSjiQsGh53IQ2YJw7jccsw68YHd4JPz5Oym1IdCuN?=
 =?us-ascii?Q?JKCVJwGaQTiXQU356JQ0P723/9lhDqj3KIipPxbZUYZJq2a4UnCqepSgYz+2?=
 =?us-ascii?Q?N/pAt0NPrfCQAhnPMkDkpW/ym3AzSjxslEsNwA9JPATHNagRzb8QRHiqsDKP?=
 =?us-ascii?Q?MSfbwC/O1AOX7Mdy5esbUjjCW/wwZ/898aw5+aMpWKVBeJcOed9DD7NOqUsI?=
 =?us-ascii?Q?K3jsEH3cQeNZ8nk5IdMWovm77OUQImkhinjjTBwnbDGOtSre9rfKv9PaFRHP?=
 =?us-ascii?Q?VGLbvRv7qhKrWb+NRRYWGkwvQCocw/9/L5oTLhy0WnGaBMckbs1tQM4rALu2?=
 =?us-ascii?Q?KuwDCB8naKE2ia8Y+ViyAOxltUxg3P8j8cW+THr9AQZh5p9zzJk1QeOFnC9A?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VSmJWilCj745S19EjUtAtfri4pckBbLlug9DH4pHMcLolKnS4mftilNwrDJjhLW/F+6HuF6eHzJlZWsT5nPRKvJcLTZld+HsUoan2YplliRIS0HtuYuWZPonT7Xi5yO+pohyPEF3Hk36VXGUt6aYa4PXG4ASV9a/UVWojN6phUaizoMhDJq/ZO4b6DYseMXqqIK6sX2GEckRiBuvPNbSqHC6ilVm0uXrIbfq5GBgjtv2ljfI6P5l6Mu802O0cik+C4acMTYYoAq78siC8Xz0p4RRzsALMLTwDvyqfFphC1Bt2mPcSXuCLY+85YsYLXF2QZSRR62zUnFy+dP42bzwbv9p8qjfEHWqSuP4bMp2OwHo2u0ON6f0vOvViDZlHp+RSOptTGgZiWzQ4jsCkbnq+rW0F7Vh9BfhBidXlCdf2won+SqTWMwT4dKfmixU0Jk+fhvVerlhyXfwZ/VeaNWy7ZANiiseGLm5md0wVB59yllLnejKQv8PNRoLWPviLKSXZAd1OMvtatFlMs+j59Dv/BQkddeiHf0GCe+uy/D2cD2lIu0XFvY3BImOrUAOx+a06yGPin0uobIzw/Y6XBD936Hq+SdR2K2wM96pQQr3lRc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2860471-b5ce-48c1-71dd-08dca0071e5a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 11:06:01.6448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9u32w/Bha2UZMYs8J0dC83pOVHnTRSR68aL6SmpFHHBlEbdIfTxTqxjP0iFkyytMNpYs8VwaU2owxTRJWkDxZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090076
X-Proofpoint-ORIG-GUID: LX_Ojt-aT2WA-E4kxg_hS-nL47lksFH5
X-Proofpoint-GUID: LX_Ojt-aT2WA-E4kxg_hS-nL47lksFH5

Also add a BUILD_BUG_ON() call to ensure that we are not missing entries
in cmd_flag_name[].

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c    | 2 ++
 include/linux/blk_types.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 62ad3ddf0175..f764b86941c3 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -278,6 +278,8 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 	const enum req_op op = req_op(rq);
 	const char *op_str = blk_op_str(op);
 
+	BUILD_BUG_ON(ARRAY_SIZE(cmd_flag_name) != __REQ_NR_BITS);
+
 	seq_printf(m, "%p {.op=", rq);
 	if (strcmp(op_str, "UNKNOWN") == 0)
 		seq_printf(m, "%u", op);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 632edd71f8c6..36ed96133217 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -354,6 +354,7 @@ enum req_op {
 	REQ_OP_LAST		= (__force blk_opf_t)36,
 };
 
+/* Keep cmd_flag_name[] in sync with the definitions below */
 enum req_flag_bits {
 	__REQ_FAILFAST_DEV =	/* no driver retries of device errors */
 		REQ_OP_BITS,
-- 
2.31.1

