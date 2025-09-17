Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3760A1E1C1A
	for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 00:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758069937; cv=fail; b=QZEazIo0y03xmqo3OIAeOYULp6z7k8rwJOQ1FnbN4JPuzOM2uCHBBWfLkmSm3bM1fEOQTPBpajzcc2mrrfFwy/8hjtGJ0/rbqIHXSb37KDMLAOz3EY/89yIizfjbHOFCJiXK35QmpyHkgmnhYk33aSIlxmH9Wo9N0zFIudWpl4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758069937; c=relaxed/simple;
	bh=5xtL9fsTHLwZY1DKLhbzOdlXTvm6eu6DG+hn3jM5wz4=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=OPdXHhEMHc1lgfDx3m7L/FdvnuXBHyEn3GyKlqsO6I7YRYoliQRXct/cdVEuXJVXkKtPsasMAPu/X9YghlOQ0youLDAZ03h+vqYtOihfc1p3ZnS81cwAkgNp3bVPNYqZoWp6CEjps61AU6ObJTfBKjR8lMvgBoWpqHm7Avrumjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AQqqxE7b; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WMySnqsC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AQqqxE7b";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WMySnqsC"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLZMkm022652;
	Wed, 17 Sep 2025 00:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BVb3KtvdVpznXgRg6H
	79WyusFuxe4afsKZY2qY0MRTA=; b=AQqqxE7bpLI1hSIxHMJQt4FtEfjNnr7+K3
	26TuZZKbbBXfKkZ+1CXTsdLbeNmUChJhqFQRQi/kc8F04xth6nyBwZ2O8gz55jF4
	BOdreG2BUsLjEn34vWd2oUn+fA6DZgwu2hl19ALCS1nLc9o6XIZGE+eUmr90yNld
	egfJWFiy4TR/8Pe3yxtlg2AV28rqOHXcSobUGW2+hpjMUty60A846aClnWxCRQ6n
	smsZyED7YqEOouBDAMcacWqQOlEUL6oNRjORbS8NF1S0LEoAiO6fHEVGddiS++a6
	EpdhAJ07JJTRLKWitmuU6SaRJhoGCCGJe0VQd8KUE8rnMRcmF6zw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx9063q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 00:45:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLcs1O028970;
	Wed, 17 Sep 2025 00:45:21 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2d33c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 00:45:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sD7XwOhy2J5bDadFktHlaHYPpaSPSDmxED6OlApLyTv5l2f1hMRUy8uTQ0XNd2wa75J4WQ6qr/Kzu441ABR74eJ9hyQkJ39tHL8jeP0SM+ZVKravkR1NT/dSWme7MXML3a77ABF2dbhCqjTChCzqZVAZ9e8wBg7vEdO6ZiYXNbi9gdryosaFuUsDVHj4wOjVxgBK1//5fAp49SQuCMLkLmJEBW8PwEqCbKd0sxSILAfEzZ3dRWkNRFCBccdFgjPxnql6O93TQcAVeZpDqqSB7m2ITkpvk4tNFepJwQLu5K/uTSYQbXgPnJHXOaErAJpSEE7x450Kz8wx+8OnYjQSrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVb3KtvdVpznXgRg6H79WyusFuxe4afsKZY2qY0MRTA=;
 b=LgcFjn1iBg+goNO5tbz6NkR8+ID5tPTvt+NWBER9Lltue4WFJK4kjwyzsjVBnqRJfAna/NPUfirK86XMrcHAdwFvYD+bW/xKF/S89J3hHU831jCIJdcoHt9wKHK/WiDJ+n+aboMwdf1Sg+6FNJw0FRxg84U5lz78kaDpKnhBjy8s+mmF9yjsUfUbTgB4XgQAQQDgm6fpC1Uvqj4qU50KW8TgS8JtSKs5SL578HZukUdwkkb3CXfMsVEzE3aLwi4h6Tj2QY+H87wfj0p8UxXI9VY662h1d8Z+4iLs9FI7n82Wt9tx9+miw5Swves2Ud/xBYBiuiT7RxL/nKDn2G9vDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVb3KtvdVpznXgRg6H79WyusFuxe4afsKZY2qY0MRTA=;
 b=WMySnqsCToxM42DTyMQJkntlNVJBbwbPflbA8qId26gqt0hEL1T8/FHIASxxnk8jWLsWPYVvfiOKmoMAAnrUquGFOU9JD5Qb2Q864GaJS8hexcx1vonJbynG7ubPQ+tZOr28ge9TxtPcq5i5myr7ZT6O7JoL51ZXQ8rNuYHsnn8=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA4PR10MB8686.namprd10.prod.outlook.com (2603:10b6:208:56f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 00:45:18 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 00:45:18 +0000
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph
 Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
        Ming Lei
 <ming.lei@redhat.com>, John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH] blk-mq: Fix the blk_mq_tagset_busy_iter() documentation
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250916204044.4095532-1-bvanassche@acm.org> (Bart Van Assche's
	message of "Tue, 16 Sep 2025 13:40:43 -0700")
Organization: Oracle Corporation
Message-ID: <yq1ecs5zz44.fsf@ca-mkp.ca.oracle.com>
References: <20250916204044.4095532-1-bvanassche@acm.org>
Date: Tue, 16 Sep 2025 20:45:15 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::26) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA4PR10MB8686:EE_
X-MS-Office365-Filtering-Correlation-Id: a538dc61-ebd2-4418-3032-08ddf58378c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l/wC8tzXv9JgYXAe8a1wpDrHwPsYnNtlnt8ZSyBmcsSYB9FxB2K4MrunAot+?=
 =?us-ascii?Q?eP4AfnpuCmZLyHSP/SYb2EeThEO8ecfZ6BKVY4YnNfX37a6iqnqtS5jhHi6D?=
 =?us-ascii?Q?YQkxepcAHF1tKegeQUHC5/qbk6wJexz5XfVex4GQwt343pvB45mq9goTtc3N?=
 =?us-ascii?Q?SkPfx16rcLhzqXineb2dLCICGb20IkXt3duaQNCbCAsAU0uECTuNnUEFa1Ry?=
 =?us-ascii?Q?zJcZ4XGElIlFFAEgckKIuadMrQzKrdaXUgrPcoaemwC1Ff8AtitJrpASv7tk?=
 =?us-ascii?Q?/B/g3uWrQVsQxHgVgNp5ru2hWxh0TPeEx4WurSG54W2cXuKYiMN9oNEQ2iC5?=
 =?us-ascii?Q?IK9rJIMFgovolGuor/pWdldMRRip+ppYZK8uCo2uxFDP1NVgNmHKShBXgLVv?=
 =?us-ascii?Q?JkqIPPq2WWAEt5lUZHRECuRg0BvMJJBfvR2EHMx3A/qWIP0Qra02beHzziNt?=
 =?us-ascii?Q?d6QRfvHX6oeUbnmJdvwy3tvy+aSFtcy0I7osvE5lzAPRBdsX3gN7MyeuULaT?=
 =?us-ascii?Q?n19tAOL0KzkoqEh6XM0GPFrPTvOepOWNHybLyFpKHM9a8j1YZ26qAHwZuyPy?=
 =?us-ascii?Q?IY+WhcvBYoCumxvaLP13S3KqW/svOapzoAimlC2m1QFa7h6LlLL1uot1mGM7?=
 =?us-ascii?Q?dBCGD9uxEoFrcts5y1DY9OVgTDGnVQnMMGrtXgbw66BSvsOxK58HzEUMM20G?=
 =?us-ascii?Q?pk3B2u13a14VIlumkL3ol3DbFQp+D58iEqFDeUHiDvksHg+Y/1x+DEl3HO7+?=
 =?us-ascii?Q?s8VZCHEDAbh4Age3KNxRkCLPGHmlu/GeR3JV7rd/j8uAymN57UbL0Q5k1IEu?=
 =?us-ascii?Q?biqYss91dbqWZTgkIrDf73ITrSb3WLhc7HTYiFFfVG8VSNOTUfjM9SOwGCgA?=
 =?us-ascii?Q?9dzp2wg1eg4z1jL3YMrPUYmSqaGX6gbliNrzl4kY2shSdzdJjTLJbTTYZDkX?=
 =?us-ascii?Q?jGAytt9HjCSFgwWrEsyAgG8z4wbGYIs3JSrckm78ErsGmRtCCXQbHe9D8iFV?=
 =?us-ascii?Q?VYP7o8PeBot8OHnsGACLkreXG5iONCsKs9jGQo8vcKQeGRUP0jZqB8HODIlc?=
 =?us-ascii?Q?4fbTsA/tSWe+FsSBHptj8BzW+Dt16BQwvk1L458KFm4vlJIB/d3n3XgG7F2U?=
 =?us-ascii?Q?6oNqSRDts7DFnvRRarB0Awu2lG7DtO58fO/cvVkwnsVqWMwVn5CC8g9qnUeR?=
 =?us-ascii?Q?sJNsGWFw2SLltJ9LS1dOmojpziEUnA9+gBv91CcCXKtKvHPVP/1PDI2CQzv/?=
 =?us-ascii?Q?IuDww3pusKg4H3zMWwzjyWeyc0WQGGdBAJjg/pioNo1PCfGbmRCCHnsjAaJX?=
 =?us-ascii?Q?pa+EpUlnqjCAWJJ4B0UzET0T8BBpjpqFUc++gvlCkGasXD/U+3dKQAf483MD?=
 =?us-ascii?Q?Xn0DRvXJuCALj+vpxCwidP4k4wWc6GuPSzpjQpxsuCWPTzKRfh1ED5bzG3B9?=
 =?us-ascii?Q?jRowBo0FLdM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NOBuO8CQCgaTfL3r3EHXolrpqnOQY2CD1hJzHYbDbqDZyUg2iWmpH3f3a/7l?=
 =?us-ascii?Q?h5cf3P87kpfkPbo96cI1O3b3N3spPMwvtYYQr25HVeXVDY5EiR/jT+Bq+rLo?=
 =?us-ascii?Q?Qi07qxmM4bf/qYeMSRQffQSga6mWRiix6E8q8DJb+5R8u9ZleplKfyORaHg7?=
 =?us-ascii?Q?TsJgc8ja47w8aaVnT1gI1l1Q9nZ8nOYDBgsvJUo46J2xqocv9MLXxuAmun+V?=
 =?us-ascii?Q?kpMuYCVoPxN4ZVU8JghH+2bUvsBLUqfg6b+k9Et1xdGu3ndBvHgJnBevnCeZ?=
 =?us-ascii?Q?BVXlfUb3iawsIC+jBz8ZuDFZLKlRAUaXcPi6uOzlvRpXX/0nLoPfGdzcqt2Q?=
 =?us-ascii?Q?Wqpc8ZWWZg4uMsgcNjZ7FYPVTzOcOZOWXfqSXf5t+FW7GSzTt8Mh3VEvifNj?=
 =?us-ascii?Q?c4Tg8fjp2PlAksiPpUg2fLak3W24TqRX44rT7bohI9gFa7NXbAEdUMdNd1GP?=
 =?us-ascii?Q?zxh9HU4pwKXA9CH7rdxWnbXPTAeZ+fwBzhFmfEk9l8JbPob9EZGQCTas8hFv?=
 =?us-ascii?Q?0gaI1uW4UGGAR1/zU/LeYZL3a7YogiKEjAhVTjWLvWlpKEyZp3wDNzRrG+7g?=
 =?us-ascii?Q?yKU69+5LbfqeBqULluO4lzhL5r5nyC7QpALfC+0N3Qp9QFll4JzJjFCtpCk3?=
 =?us-ascii?Q?fbE0nJ1JJkM+o4hBZJOKJWqSMGTyxyc6alZpTXezT+38XpXXjJml4ANh2aae?=
 =?us-ascii?Q?pJe+bBv10Q2dOE6YmG0DIrZ12inRrV930xlScVo9TjsHn/bHJzYQzaQWSfF3?=
 =?us-ascii?Q?ywbyON8MMEVk7TdoZG8a5MEKJIVpWNGIaZ78L4KcTqAiXkPRTZAVza3mwbsO?=
 =?us-ascii?Q?EypiKLS60gvd8/vaJ3Df9J3PLaKj7M7J/ypreAd4sCCMbJq6RDoMGP5POKOQ?=
 =?us-ascii?Q?HuKgYlfrHptBCnO0ABmILFLyYR0+/BLykn2GF1KEO4xi7Gnz6PRTyzH38yUd?=
 =?us-ascii?Q?ziDFVBfCTtEOJBf1mRvY/gzblwc6h9+/ToX0XrfvWFTGvnWUU0KNZ65Ajqik?=
 =?us-ascii?Q?4rjUn3H5+qkbnhy5B6lEL6gBomZ+MEIQOOCegkNdCPedIoyycpfYMv6aJjRf?=
 =?us-ascii?Q?cx3Im0l5CesDdzinsGSNa9DhBS+Ga47Wy23pXfpEMopvoeco8r46TfzkHQFj?=
 =?us-ascii?Q?+gGTGiQrPbNQn/JsVWxcFiyCYSX7Ci6AELKSRdVAhCvqeg1Gwt+OUHGtpqbJ?=
 =?us-ascii?Q?7hK+vVBfM05aiA1gcoj/WrjvVuAPx47ArN7Oymyn9afcES7qnZPJT3B8JUNs?=
 =?us-ascii?Q?GZDp5Lq1HxCHMcUlOnLN108abVuLdRLF/4HKNQMi0xcrKqNM59Tbe0AmtngO?=
 =?us-ascii?Q?kJMUXgDfIUnam8VqIzCd3glwEJsec9B+TshyuSu7T5exqzPDCoI9kmLEMma8?=
 =?us-ascii?Q?3ezPgUwt5hePjk5V7vQ/RTC9UHON3fA7b1vcMX1VhNMwVXYsJb/DqfGEuTgE?=
 =?us-ascii?Q?eOn8ZM0MMRFNJRuKs1hXbasGLuyOAFRH8RalGeGOsEvT+TjSSj7uHEfm0rtF?=
 =?us-ascii?Q?7ah66xfwk+CNRP1xWunaH4iAjwSo+Ie2yXmUYKxTmNNhop3xSQ93ynyzdIwq?=
 =?us-ascii?Q?6A+nfXC79VnhL5TjNzOfBbW7lDHgy3egGlbK1fM3f9DjD1TFJsphPgg0tSQy?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zfn9SOcsptwP13Vj4IkXS5pt55Qrd06ACDf8GftTuUCA5zg4K+A+9DaBPM6JY2wizqNCorwYIo9Ernp7qn1X/bgL1hsKlswMDxwgsHg0V3Nde6Tcl905jVKyMlgjocRV7hVo00a/WmJ/eZt8pMnQA2tEQXq0UaCnwBtNEAc3lJ0xiVzCyyrN5X+Sb02Tj9/mhKfu8FPoSGG4irQZ/sy+Wpi+HVyQrVao/bYydjeL4m64vHRAneHvibRtzmdAeOdolB1L470tKFdqw7lRSBRodQ79QJgJYww1CykGoRzs9+vkeO3SxvNtj6PJukyyiJ/8aA0gaelkUbeYSiTMzk/Bv1Y9w9DZmcFn69G+M3q+IECK1DUJcwfO9wvNMYs3OGt1Rbi09iV68K32wRUCYu47SePp+claRa0iYFtzmSPhlty/rmSha7a1HnAvWnh/owwvNefwTynBt3vHrn8hJYowdash7CmL9ZkArU2dociT+W0qlrkqCalyOg0j49/Vt1SjgsosVcBEyzw48cN/4HWxxgzqKpxBYh7DoZxQ1iqTe1kUUJXXwG1RCCW8QG3d/ISrgIXItTQWPhW19MsIbHIj+ri6bqtTqqeI17Lx4fB6T5A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a538dc61-ebd2-4418-3032-08ddf58378c5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 00:45:17.8666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7zBdSPfJihB8UnxsbHZaLAwDDxGn9mwcUOhmBccIPH327fjG/XEeHHa/VjvI5fUzuVl7FT9uUqMob7oIoCRucCkwX4jL+dq65VmlRj3Cvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8686
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170005
X-Proofpoint-ORIG-GUID: P2NnvUHdJCOK4VKaeyOt5R2HjbzJmHCa
X-Proofpoint-GUID: P2NnvUHdJCOK4VKaeyOt5R2HjbzJmHCa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX1hTwB+koecyY
 1Mb7i9QgTW6UDRsIrNq84rv/3Lx6iF/JMphuidRGkZxLvUKlJazxo+tbKsCCUX6FMJQsMDsqvt3
 rQTTaWtRtfquxgIeQDB/9OIjiogOBTw8pyZcL3wpjH1NE9pokqE9uFsc/BrbA2Edlk1CieqMPaj
 OfK4Twoippr5aIV/uPaZ8KoR7VraeDAQBH5vnAJ9hmlstNlgrXFe7edBLQ2Zfh96djHEu4t/EMR
 dye+66BziPhLq9aZUvb55L4cJd6zMWUhYATRm2LWl85//HU6IPd3jmnSr5UCuuEMq4bPh2xmOtq
 T9EhXyxC65Z4aCPUMJz/40UHTQ9feO1I6vijHtfV+oJGzRl+kxgwRSkCmkW/atE2hd4fhDtJ3vN
 9zzxsD7H
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68ca04a2 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=6QoIp_ukNQ5DW1UNWsAA:9


Bart,

> Commit 2dd6532e9591 ("blk-mq: Drop 'reserved' arg of busy_tag_iter_fn")
> removed the 'reserved' argument from tag iteration callback functions.
> Bring the blk_mq_tagset_busy_iter() documentation in sync with that
> change.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
