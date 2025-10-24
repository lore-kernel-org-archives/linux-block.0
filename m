Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A8824B28
	for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270499; cv=fail; b=g7/QO/orKNBN+kb4A17BF50VO1Uxj5jTEFA+/wwKbhJIQm60bzubpTJ8tJ9a6H4ldorkUSZffPwzNGBGmhhXtPXFNZg31cv5MXnmu/+3d3cgc8MSRf9h0KNyGsSVRDVBS/MOpB2tJDMr+TFpLPQDHtnsW11xdTBFl25SlCM9kBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270499; c=relaxed/simple;
	bh=d30DrM0gtBOp8L59Qs9cS2oxnwrN+M8EGigLRkNuUj4=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=Sll5NOxUhGD1xGEIMP+QGNvUJL1gWSlN4UCiVyUo7+c19YNnl295xhYh845Q17M43DiX+2DEXrYA8H+Bxayqvu8PiO9SnMmryHDrRofEMwFtoC8tdyP3ixT/WQVcBQVJAJxq+NgHIjJBrzhg26TEOwVn9P1egIVW3FmYTCpqEME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c2ehct/9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CxADyo+t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c2ehct/9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CxADyo+t"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NLNMGB000737;
	Fri, 24 Oct 2025 01:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=GcJ1BEWPECUGgfXSvB
	liaajaTvDtCSJLQ9uTymf22EE=; b=c2ehct/9Oq3w8VkeKCIwG2dvGN4yxVmtVM
	VeKsssodE2OvkTBUiWDGptYK7TtlW4Bflc1MgBbNW50gaqPN9mb2QVW7HTPw1FE2
	URE6qilP1Edq8ooMzgly/7CGNjK3M3wYnvTwafgR7lozWRytahdfMdnN4sp9vFW0
	mq2L02IE3bXZdecW7BIwYANjqMVP1J8F5tTsvnhN9w5/cXUsfC7j1T6O//Tl+x2m
	yCfXwy25txs5WIeZ+Ec8YVBddm4dUa77Qwmoxopp2o9JamUTf1jGmwsG+dgIH46z
	Ha3qIrcByOx+6EZujkDVHgXBrYrP0imdHYGGu7EpOLdxOkdnI2xg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv3kurdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 01:47:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59NNscHG000801;
	Fri, 24 Oct 2025 01:47:56 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012043.outbound.protection.outlook.com [40.107.209.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bf96up-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 01:47:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VuKA2/nmZonfq0xiTmOJdoD8xVMhP9ZPMf0fShGUp2y0swl4LkQ37FY5kCiU+obkAxpGPk+T1+vOnXPg2qREz8n6/Sjr3hLM02lBUBy083vQ8Ku7OrvFBHcii30qHaI2YPxbRLI9mgLRDm7xY90OAmi/wifQEZuCoWk5JPDFNpOsCMOY/PCr4WzUoxYPc9yn6IRtQqRZ7EcZfhUKZupBqelRxnCDXtWBwjyZzXm7+Y36w+U2DFbYQ4OKg4IlS0yFo3BYszDcGZ9JcJR76i/U5mu5zE3WmQ/BeMgTZb0n3ghl2OyKs6B4W2iOeEpmGLknR5je8gXQBhHsNwWFo1sP9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcJ1BEWPECUGgfXSvBliaajaTvDtCSJLQ9uTymf22EE=;
 b=Cs+QgAL4kSXjL7tz1kjR2qAc6AQxyWzO4BETjOOt2SoWYahkTPqvsqlZdGbG7VI8oKA7CAxuUnBiMg6Z7CLoJ+tvbmU/iECdaZLydEpXzpsgBiiDDWBn04a/BRTdM3NPOnHym9r8KdjC7bLLzIMaGAmU6CwiGEOxb8HWFIFFu6DM2NF/Fc8757C0BkyfhxpuCmqcAOObAgmn/87p934h3B+rJW+vJychx1BgK8PuUk2uhd/ZOJuGwRiw6Bm/PHz4O0iIUHGgZmBub/mb6ZRpvNneP6tfjZKOaA7H8wTEoAVQgyZZ5eYfzPrjzM9AtsZWGI8dSdNUpL8EndXUUG7OnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcJ1BEWPECUGgfXSvBliaajaTvDtCSJLQ9uTymf22EE=;
 b=CxADyo+tjPq4/ixR13PKzQMaRSIHuKAdQlMp2pKKxInbEp5d5C4o+dKHb7Ad90voOmCUbZOuJTs7JjHIr9Zp+HhgvfC19RBJvOVieAiSF1PPwk7e8AmvTJVwvVZNWaYsRQv7YY0jg7ajggjXCzG/J6O7Xa9d3BBvOJE6xWiPHEw=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MN6PR10MB8069.namprd10.prod.outlook.com (2603:10b6:208:4f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 24 Oct
 2025 01:47:53 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 01:47:53 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin
 <roman.gushchin@linux.dev>,
        Harry Yoo <harry.yoo@oracle.com>,
        "Martin K.
 Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] block: make bio auto-integrity deadlock safe
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251023080919.9209-4-hch@lst.de> (Christoph Hellwig's message
	of "Thu, 23 Oct 2025 10:08:56 +0200")
Organization: Oracle Corporation
Message-ID: <yq1zf9hxebm.fsf@ca-mkp.ca.oracle.com>
References: <20251023080919.9209-1-hch@lst.de>
	<20251023080919.9209-4-hch@lst.de>
Date: Thu, 23 Oct 2025 21:47:51 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::26)
 To CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MN6PR10MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: 247828d8-b0ef-4b50-6d71-08de129f5916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EvZnibJWvUeohwot857uDR9K9eRnLLN8o8kdRiRYTqx3NuQHy5yP8RRP6HBs?=
 =?us-ascii?Q?QNc4F7RgTbG17qb4i6rcPKS7nVwRUV1wX00bkRM3WKrGUIgVfa4CQtRviJT3?=
 =?us-ascii?Q?x+/W2H1JPIlty9VLvAFQrbmyBxJL9GhizxAxab23UiOipzsi1zJ0feWjh3ZL?=
 =?us-ascii?Q?QnuEaf+s6idbYlN8DnWoYaTqX7V6vZ5PBGMRQsnyW60Bq4hTHMB5ysyAW10P?=
 =?us-ascii?Q?k7dqZOrTfl0DSMALmMPb2ZEPdiFZjKO8bQdHQGPO7zmB59Rjm3QU1JdaHHvM?=
 =?us-ascii?Q?+imKoc81jWqc3CEztgNsTnH7WqZBrt3I0wxfdvj1dOvLnd/lWivKfE/DJFeX?=
 =?us-ascii?Q?zKfM4mkE/DUW8quZAd+wMiT3r8Utqul1aZb+IAN2mZdl5HGhwdMVSu2Bupv4?=
 =?us-ascii?Q?ifcD8sEm36igCgWLQhT4R0LHLGxE6rR1slWHeJ1fcB8Yq2xokPmRDfAzley4?=
 =?us-ascii?Q?Djsp2wzZMcPYPcEErrIhWo954oUZCtkWkEcK3sy7YvgAG2thicOpYYTGoY8b?=
 =?us-ascii?Q?rQ854fbykuSF73qWbvF+jT/lzjRfgWG8PUyW4Gm57dVw0ChDfD428djwtGDa?=
 =?us-ascii?Q?M1ZLqshKGH93v82Yysiwp7fQ2/wa53j8fOQXe8yhf41khz+pWOhZEArgSGcw?=
 =?us-ascii?Q?bIYAVE3BPN1+6eG7y+RMwSIYXj753FUYZQMIUxNzAGv8n1bNCW/XklkMV1z1?=
 =?us-ascii?Q?t+vF97dwasYVf7wozx0hvGq8Uqui9DrM1wsPdhckAd/f/dFFvK2qefMvKz/g?=
 =?us-ascii?Q?ZtNAiripgI+qfR0+b7SJfEc0Wg2l/HKYgxoxyDeEnTA/RBpYVDsyCk41lh8Z?=
 =?us-ascii?Q?xRHj13Sa9mMEkU9g407zy8nXZtxlmz8hWsagT/jTwK2N05DhxbVRtNHHGLBy?=
 =?us-ascii?Q?bBPrPXnFuoJIFkw+qEy7ZjxUyoaEBrTNkH3sxn/YIOkd6sK4Tbm6f+cC5+XP?=
 =?us-ascii?Q?8yZdB9dlhJiSAeRpUXicCzp5f4twtW26LAv25224Jk54isjzaceWy0psNFe8?=
 =?us-ascii?Q?Zr6ES0fLKpXthfGrUepUCYu19sV80saucKSKLLldrjbruWIDepUypwqlJ4YO?=
 =?us-ascii?Q?tatnphXRJHuWrnD+iZPAwFFRdwobqG2DmDUF0hZXJ92Pq7l+wT7o60063e1r?=
 =?us-ascii?Q?XGkBSkNCFzPWBJ4UczZpJhTQdkBoV3QjBR0lix0oE9Q9tJKDIyu0mMLt2vK9?=
 =?us-ascii?Q?1NlRljaW3Fhq0VopYMMuLVjOP+oY+n0pAgoc9IMN2d79qeoCAwlbiLe1h2eE?=
 =?us-ascii?Q?x0oioBfYDlrWiNU0vNKgmSmysNfVFfRF4dCCPjnZgBl3/uuhL25gQDpdcNiy?=
 =?us-ascii?Q?3sX9xKuiFlQ6D79tSO2sq8N6o50geoAW37BbOs0CW/p3tqSlqKquoQXBqsyD?=
 =?us-ascii?Q?QRCjSRc9hNMdumA0WHT6RFYi3bvlhI32al+iDwrZg2u0WS7p1WGO+884e77m?=
 =?us-ascii?Q?9P7VEJwaxKkjkg9iMAeXr+x4gR8bmIkC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x6ruDV7xeVc+Ld29CSmZqFy2n7FKqZ3VNPcFLCIxjP1xi1bjC09NwLWSuVH7?=
 =?us-ascii?Q?WUVaGUfN2nINNScUEFXDd4fsCSJgVqynDfotn/DCdpt65tHA+4M/RF4ji5Cc?=
 =?us-ascii?Q?aqWafwj5ur7ShHrky34KrluM/ZiShmwmTuKhfC3/td9et7zsEQ9KuMoV+/oU?=
 =?us-ascii?Q?shNOOYFIHdM9J1GyuUbfMBRuXrwqzJfRbdf6/mCiHcm8l+DOm3RppXL8dB1I?=
 =?us-ascii?Q?PGy2qHWP/o4n6eMkz2IzKHdMB+NQcN8W9680lrVyt5GkmyTx8Id806ciuxCB?=
 =?us-ascii?Q?zfhmENZyFqWlE67WF8y8mvTG7wMYYfeyPcjkhGOMpaV4QlGHd5nCGiGkL2o8?=
 =?us-ascii?Q?+Y4BUhlvENuTvwCJpxWjELgPeY/mnjG/41CqFnEHaLrtX+9VxUnJcEZMD8so?=
 =?us-ascii?Q?FaLfPM3LvNPBx5iCaV96G6rV21L2dP0W2KO4uMRVVpRriqMaa42o2OoiKgHC?=
 =?us-ascii?Q?TrWoZZoixyMm6bSG1Uz+dwPD6tDDA7uu81Bu2qChiy0j+h4kPPk/MTlK2pIf?=
 =?us-ascii?Q?jncP5Wbxf6+Bxvm4Ui2c264ZlKXFcMEDOhJYnhr+EE0GyTwBrfWFU9r68BOu?=
 =?us-ascii?Q?W7C4pfQCl2wPisMIW1MYQpoKrwddzuDkHYYTZ244DHeG+1hI7HCCNAPnQSD8?=
 =?us-ascii?Q?p0OgyaUu9ODEQ1gUzCULosfKQs3lt7CveUurVMewKf8nJ6fw5Zn5VeqNvkA2?=
 =?us-ascii?Q?fuxGCWS4yvjJ5podWtGgeKZIcXQAQUYWPBEXk410KqtvWjxIc77/ObUAkl5O?=
 =?us-ascii?Q?mtUA4QrAI811tfLbSZr53LCDfuXLLN341w84sCoRzHkmzoNvPBoqcKg3hjl1?=
 =?us-ascii?Q?55thTHGh50JXPkInCtJLx0BCq8Qv2wEYmmKBi5i6O9bKBe2ZFtakmO4mqMJk?=
 =?us-ascii?Q?S/mzCPkkZX/19xrtXd8QvCPGGA8t+GfttsfIU7b6ZhfpAvk0QFsWLX0nFLNM?=
 =?us-ascii?Q?U2ImtrLNQzMEufUMKvgmDMSGGjvT+8djjWqIgt7iBSQRVN3HQ7zBK1wBwwPx?=
 =?us-ascii?Q?nK1qJjqY/DIvUb4nNzChbeM5UBtqVbeUryu4eDwXpHkXgbD32PQBg1QJ86HW?=
 =?us-ascii?Q?8SSSWLknRb/MTWPKldD6YdQbBX+dW9E63FprrFTP3FtdwAufAm0w4Ptc2onk?=
 =?us-ascii?Q?qPR7XMbpzCxXAywNDCcSLtNhnfajEAPxoUuJBs612EQYJVUVvwPqsHz7wG/Z?=
 =?us-ascii?Q?u6C6iNUP4SxMsRRblYGjiRvUCT9zQ/NZR5GG4kLv0jGhU22XMat+PbA/lv80?=
 =?us-ascii?Q?9b8Lw4cI9X8Wf4GpfmsF+IrYwNeeUzgU5JtKZSTaE9UIEzw5S9xod20pPZwB?=
 =?us-ascii?Q?Uow8CD2zEwNGUsXtUhh1qfQ5lqIghLiwk3YkCC9TL3pfpt5cx4ppuKUXlftS?=
 =?us-ascii?Q?dJUsGls2v6L0eXvtvYeJlxOxJq6Hr2hBBgvUXEAMgLd8Pm3vC0AQalukMs80?=
 =?us-ascii?Q?0h/Lugymm/hnHXIl5ZOvU2rWcct1IZsAJK694d3mkKOYZEFhsPK/Optr/Zpb?=
 =?us-ascii?Q?gFU7lqKIbxaO6qtVKVCl/NnWWiXYy1uDYghseWXa/S3uVqM2qh3s6Q6n9Fp4?=
 =?us-ascii?Q?WBJKfcu0PCpPHWpynRZ5PRSRjDLE/ugwMNg7lEu9kjnGXVlWURRuPcu9Ljr+?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cHCO/KwppOc4mUdlTLi3inBnGRoy2VJMOfUtoFpip5TrjOVPvLb7uTGVlG2iEO2TlWZ+AdF4KsihWIA6E8SFxqsvhcwe9SDsGlGVDZdseTBT/Bf1ebvMjBmSuO8J6oV2aZNeZSF/HTga/LsaUE2RzW63hghqTqpGhxEeOymrlePYHN/2LrUSu9NvJ39QN0h0kzbTAls5fp+e4Xn7AwtyxoTRj4LC4lfLEcymiEUdyfPwi2s/d2mhJ5oIj/HWhd+U27S7RwkjhbdJ3kHHsqYJjQE2G7PvoNHb9eR0iBdkbOaoaiL9T/RXOs3+bZYb2kDS8+jzs1pwkwKH3Y94gt8i+XpSULMn9xiTBXlIySD4JUPeKmqoiPHHKlF8fcl7kXHhjq24cc0WfeLVVLwOsJ63its/9lmumtqTl3smiOKAphDhTcqkAQMvAOYbdgnzgC5rsFbnO2Ak/GFiIZIKtBJbhJUvGBFz914S1zYoxI6wu/jT71yKVqxrKXnAp3GNpOHqOB6pVsm+nD9t+SADF7vVj/0bPQToauxYnX+n1R3nIMkR0fCjWOgrwyQJ3FHhw7sNDcn5k+ZqoQOERkJeNAp1yGemxV5axNOyCD1Nii+LcRY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247828d8-b0ef-4b50-6d71-08de129f5916
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 01:47:53.8045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmnvQfpAgnBURxkaRW/n8iNfqxF90OQOrKkHA7UA11IijJtzLFQiX1ZKk5Mym3Mvx83sElPA3UMzdGeQQnpNEnUxRXKLQqnHsPGDA5j42v4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240013
X-Authority-Analysis: v=2.4 cv=acVsXBot c=1 sm=1 tr=0 ts=68fadacd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=vKwATiFn6duffFLMh7oA:9
X-Proofpoint-ORIG-GUID: qHNsnVRiFSHxQUOe2dElJdUnQaBhG2wu
X-Proofpoint-GUID: qHNsnVRiFSHxQUOe2dElJdUnQaBhG2wu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfXy7ALDjQBvzCb
 yNCuWBZbpjLq8+YhOWyuRdypkwl2QyJ1R4+HFfshdBc7sASs0V+u5n2ocfkv3ESDHh7JXrQabDV
 OZnumE8kYzGl7ft7IDm5MY9MmUzJCC1Wocx12h2yqoC72g4Eb5GWOu1krY/+ZkRD2vXmOtSY33E
 YvaRpoj8eZBjD1ZnOckpR5jJsMl/zq70p4ibgc22Y+p7dkkiUQE8dKZiI1/xvREYQqGjbZW71xj
 X5m6RBl8h3shSE3hilCbUZIlcxo40qAHvYvPzbexwpHyH64UeEhMvHwIp1pnJN7h2o6HyaG79gv
 TOWG9/evUaxE3JpWWN3wTcVyNb8AmbXrzb7Sd4HstfD0bJjPxVcU9SKZcib9e2VnBxI8ktVh0rV
 a/dkWgKA8+EPjd7HC00U4ZzCWNMqZQ==


Christoph,

> Fix this by limiting the I/O size so that we can allocated at least a

allocate

> 2MiB integrity buffer, i.e. 128MiB for 8 byte PI and 512 byte integrity
> internals, and create a mempool as a last resort for this maximum size,

intervals

> mirroring the scheme used for bvecs.  As a nice upside none of this
> can fail now, so we remove the error handling and open code the
> trivial addition of the bip vec.

Typos aside, this looks good to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
