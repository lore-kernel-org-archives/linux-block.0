Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168EFEAC7;
	Wed, 25 Feb 2026 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772004008; cv=fail; b=YTXyJXq/JssHJvKAE02vJeCdlmfwcOBGF3qU+cfLly2LMPwhrN4ah5/0i6F9bfC9Jy1P6KWCqKrmZtFYHapM6w0g84tPeQy2DEOOtLrFP2r5E436n+XbhtVkh49UQp1JXuAe9OG6VaGzcAIhS3SUhruF6xAEFQaznDqRz6RaKrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772004008; c=relaxed/simple;
	bh=4QOHfKmrNg2LsbJR823ZQ7xOGAtqoIfrhn1FZB1mVd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qh8fEit+skiTW5BXgHSZVAH/stK75w24bzQDY7QfU4uRnjArl9SNzSeh4CZWuvKXA5kz+gfKYOg0CXfk7HqDTtzlPcOa748tPcFVjLboE7AGYwn5vTZbzm+eIET6JQxgZ7QIyoET5+uJkF1O1LIkmVAWZVZrytmzGGYCbZ8hs1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bsXr1G8T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GxDg1d3S; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bsXr1G8T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GxDg1d3S"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OItvGr817332;
	Wed, 25 Feb 2026 07:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=CkFecPxM7nG12bBDgY
	g1JCIC9BFHbjUE1vaF6+IKu5w=; b=bsXr1G8TUMquo8QoXZ5d8/iXO3tlFZuo9a
	3fFv11SbtgO7GOC8Po/VUC2B0cLe7FUqLiZE6lczPTWjjc8pG3CRkqZIeaFJcSQK
	xQrWSuK+fA+P+TtCntFwZt0xIkiIf00quswdQ6rx0YL8EK4D4NV4QTD0dO3+j/X9
	JRI1YjY3rPfZ02Mzeg1NeMnfYL50ryxG8jIs9B3qclcdBDQ7aWwqsAbWnnJVGr6Y
	vVBrQOBfaUKKseaQhN3SB6DCg4mbFxZs7E+T5BwFaWBSmkY2gfAPx8dOkor9akn0
	S/LUO7YXrRJ5JzzGEnJt0C2yrltoVG+jR/wB4QJ1T5jPo9yIbamw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4ardkty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 07:19:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61P5DfP5038418;
	Wed, 25 Feb 2026 07:19:55 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35n027d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 07:19:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IrfWf3xMgTl/F6mM02VAguqR8DAIWj6CPwAUauFKVCWif1XT5PIhwNzZHzW1R0YoRsg8UuTGvJ1b18Wqtuf3RiyNfQ7cSpVxcOJ0j4YDVrnT5Rw/fborUj0SRcm8Wm1n8xvrwOZ7Eek1QqU5sYu64OO+YrXuxsSjvSoBXNBp4y9CRM5NbX+drYH8lF79C13Q78T5U3f9/MQsd5QXfsyd/gj5/wfWHkgFbD9C93clVH6Sxcr5BbqYQ8oA7Nq1s9/9haYlM1x1at7/HiYQi7pX6OKNXx/MICJ1/cKd/g3RRMtH1FIQ+XwR/0ec4KFouM0n0ozA+rxn8oKRyjYaesBXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkFecPxM7nG12bBDgYg1JCIC9BFHbjUE1vaF6+IKu5w=;
 b=RGc9qlfdP0CfhPRJLRBddsS/JfwOmtU9+Q/iG2AuRcxRjvki1xR7RGnsojGzbDAcBEN0TTiSSpbldmZ9RMNwlDS/2y9FwqTsQHimaO59z+77Fvtz0gKbDlNOsRjceKpWmF+5ljHgDm+cU32q+B/qh+l/FJZdEPpSpJcyr6Jn23SImVBa2K37rQ7kb5XNFBeif+qR6cNFY+BNaxDmGwmkNcROXps4k6wd8WYu5TwbFgcQUINwy9cyXe8blKdV9Zdpil8nWRdLYSpj8QAGzPc9BTZ4zbFkMcKIHNAgq5Srda2D+/4iLS5bQFAxAh8aunLPb0oPu4ClYlMoE6UBwJJwHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkFecPxM7nG12bBDgYg1JCIC9BFHbjUE1vaF6+IKu5w=;
 b=GxDg1d3SmZgOeswWg5DEjwtT+TW1IeS91whXhBxJoYdBFn3kNBPHcDijFArSccxliXgRZVxM5JoRqchG19atywG9pYG5LHtSAbBXCLKQv9OVxR05V+yEjMZEvv5eykDRjhk1/2tT09xQjNg33M8EDXD4zb/XS+GUqLJ+qx2dGYM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB6399.namprd10.prod.outlook.com (2603:10b6:a03:44b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Wed, 25 Feb
 2026 07:19:52 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 07:19:52 +0000
Date: Wed, 25 Feb 2026 16:19:41 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Li <hao.li@linux.dev>
Cc: Ming Lei <ming.lei@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        surenb@google.com
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <aZ6ijXgDKj9D-kDm@hyeyoo>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <aZ0wX_QuxNTxXHMj@hyeyoo>
 <aZ1qRhIGDAR7d56r@fedora>
 <qiqptuqsiaufeasf2xukfzoumiyoau3zfpokosn2amgc6zskc6@vl6ie2h2zj4m>
 <aZ6cjpU36_EmXslf@hyeyoo>
 <zn7q75k7u2mspvmspwiao6245kmaahti3kwagablp3advcx5ga@5d36ctyi2a35>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zn7q75k7u2mspvmspwiao6245kmaahti3kwagablp3advcx5ga@5d36ctyi2a35>
X-ClientProxiedBy: SL2P216CA0193.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::22) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: b5f3157f-d933-4fe5-6c17-08de743e44c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NtLAyeF1LKiFZmcusMWTuPxWByw+XiOIVJNmnqXFHwXt6n5dMv4U7jZo1ahu?=
 =?us-ascii?Q?Meg4DpzbATmPnQq02EzTznyaX12Gxt8079e1O9uhAP5slFYl8QI9145zjrZI?=
 =?us-ascii?Q?/NvbWpk6/IghfX7TRuLf+vxXR9tuekFSy4puOPQn7b/zpRrUNlG7YQuXl0n+?=
 =?us-ascii?Q?RuF6PuKY1/hL2rLPwuMWybNT6zSPBZTuQuGoYjXvA2LCFapZTtxAAR91aBT+?=
 =?us-ascii?Q?HjVNjk6iV5AR+duUMU7joKrMBfYjH5dVderN8nVjGRssErCb9kjoACH2BE94?=
 =?us-ascii?Q?CgweEUvtxhBrM2MveC/EBWLlZLhXmyk/4i0NnfHB19k5FX+drYZggGBW7e0F?=
 =?us-ascii?Q?vlV5UZQo9Rl03Anl9nIuU5Rjpt1c187r3GRHFUBlANIbOQCGewQphIhdeJIV?=
 =?us-ascii?Q?T2hVFBBzSYfqmykC0oRX3v5D2EABXS8BiHvnCOeRU5kLfQaFS58nNqhfWIEg?=
 =?us-ascii?Q?XB/GyFEiI45qDM3tsg40n996S+S7nXkVJbxtENq6mCjtqjY7HY/V5yCj+GbG?=
 =?us-ascii?Q?yoLOG4MFDGlq8lpFSS6v3WzzmWDLNOlwDaZKfkGIjFOGNXLRYa/e0v69k45z?=
 =?us-ascii?Q?oF+Z0of6sGOQy4Ps86bAjlqTE+4b5oX6wPFYanSQL9a9wQYERTKKJ86h941c?=
 =?us-ascii?Q?qZ3huo9AI+F3pfCs9Gq9kuPVLpGmw15JFJX7nliTgdoJhFG32N87DMuuo5xN?=
 =?us-ascii?Q?UOtnrSxRnHngSHtRWbEaCIEBy/XstUhLPT8szDkAMy2Yn+XYsRylqFqG7uK7?=
 =?us-ascii?Q?j6MJHTUj5sxtmbhP93aZbtv+ccRF86/ISB9zRedZxUlUgkKrI/ZXRAyMU57W?=
 =?us-ascii?Q?BS9aiWBvsKiUfwYtBysXK4CQxvSUpmKQLx/YRO7bwOTUcP7XVkVO4zReCKj3?=
 =?us-ascii?Q?ro7HkUUJ/sRLcGFN5sBbNqOCoo+mKwAHktobgOhsuS6is3feNlXq/TkiS65x?=
 =?us-ascii?Q?3U+VxtZ6dTBs/iXf29xNOCYqjVC3+HxoZCBnKJ36zTVId7S3vqkvQ5SN4p0T?=
 =?us-ascii?Q?cy7VmgMWMINXWiTBtxFifGL9AHZlKpLumcrUHtAYeWFM0fDsHh6Fo7gzrset?=
 =?us-ascii?Q?vEa0jDvwtEd2orcUhc625tLfHhYCk8uWbNeomjkRMw1g3vx956/uqpd6RNQa?=
 =?us-ascii?Q?hyNyGXsdYRBJh8b6/O7gEqKTSIvoQaHOuZNxBjMNqq5mBuAw4rPhA24Brpze?=
 =?us-ascii?Q?bWS5o3ACzRp6KzlxMvrAtY4h7MvU3GiNdHrCLLPXF6+WsXgW3zxG9uTxAJP3?=
 =?us-ascii?Q?ZgAjF18kMIKMBrPc+oQvm1PvWkfkaNOU5miDUltiCMYbt++7MBeE+0fqOX2o?=
 =?us-ascii?Q?f0Ag8HCL9FDyBXmYFwU/O1r6YsOw32ilMuH0dNdRzzt5Q4xk0xmHaBx+Wm7b?=
 =?us-ascii?Q?3I61n1RK9FHF0Q5fYkvtNp4I/dNe0tQ3KarfgwEvdHFYYeKh0bkkCg0TE+A8?=
 =?us-ascii?Q?m4hoSglSk373mEukTo1JN0bR4csxdhbzuKPHC6/K8K9ugIFhWsX2PgVtrvgB?=
 =?us-ascii?Q?yMJNysEdsnuMb9okPCn8Fqfws7boBumuN+o4XDXQnS+R6URZgb5jw1clhxNw?=
 =?us-ascii?Q?3t2YZSdYawq4l/kEwzE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kC2OuazMNf58e08SD/f2V2DmPWcmWP0k8or+OWiQdw6jaYsG4XQi1a3Bipq3?=
 =?us-ascii?Q?34xdQtcShq830jxgymBrBgsJsY36Jk8sQdcfsjNmzXke36swMzeKivLJ/lke?=
 =?us-ascii?Q?qpy4eO75x7vOcH2KdrVN/alHSJlHNwYfL3GkXe8vhZ4ZCB3IVK5QJPx1nmfG?=
 =?us-ascii?Q?dzvqGspzwWudS24HiYom7f0q0nooL0jem2kEi7fCGwOnbYz64Iv3aPL4/dxC?=
 =?us-ascii?Q?zH64shoAVVjebf3ZWlaO+yAnXyTMgmUddham4NZy+t8dn6ixTg+A5YwtDRss?=
 =?us-ascii?Q?cM16dVtcevNz7KwhnIT3/gd+oKutPT1Zxp8UM+Q5aqEfaPxCXvCgxRgPp+jn?=
 =?us-ascii?Q?G8ZkK6T9kE2YiNwEqpKnLfI4HZWlqy9GxpqP+kzT6M6WjL1ostYNxX2NU6MY?=
 =?us-ascii?Q?W5Fasp3XP1/+gROIiwDm1/bEKvWYx3GvkgcXQ7OEnvm2pgZW7iQ3Dqm9Sb8U?=
 =?us-ascii?Q?85al0PvmRFq189us/reyx5/DfzMLcGaIJZhAPNj1oTqBYTYv0rbeSMkwGX2x?=
 =?us-ascii?Q?RqZoW7Orhxq3hWh0RwOMcIPv8AXlLHGO3iAL23UAqEV76xNHhViUrKHrUUSh?=
 =?us-ascii?Q?c4mE16MrhaTM5VqqVx+KuFv+rQfxgDxSfjfmGAGOCMKt01jh0oY6QfkMKeqo?=
 =?us-ascii?Q?Jxu5/ftUA1hu0VqMrcxBVDNDblREPCK65Y0sBAzwfKW14YTUquN/ta+jruMF?=
 =?us-ascii?Q?Qcvx2UBrC/lpgarjZf0DPC8OIByLeStZ48OOqZCxovjmgYcF5S9QXzzVlikI?=
 =?us-ascii?Q?+3D5qcVscWGlcSZWfTQDDAPqkUp6XJQds6U5dMnm7+7eIasa6YUtj/fw81X6?=
 =?us-ascii?Q?De7tcDsB8LfohTikqt08SJ6cS1c7L59kjBp4wwPDlyZ7TS1XIJ/Rk5A8ki8V?=
 =?us-ascii?Q?qbmGl1x4/j7qzFAlzfIH/QCRviXYPQQWAbs5ZKpvP61CseWOuwoTvMY50lq4?=
 =?us-ascii?Q?2dy4MAgg9C85gr7ij/TNCp5IrAZvz/NK380+SFfjygFmar6AIhEwpv8u+iaf?=
 =?us-ascii?Q?zL+2WYStuMKw3P2GQjThGokmJ3qq3o9Tc8FU3s8WcvcYUpbKwIPbyKlbfNYY?=
 =?us-ascii?Q?1bmtP+D1g6E26NR50JMBZCsCx9BzrtAaqxv6/F00l55qNIBSjAFOm8l9KM2+?=
 =?us-ascii?Q?1aXEBQKG1e1c8kRGE+VwdyLsSPvnrBYMFU2kJInAs9Y6EulSZcUTen8eElnk?=
 =?us-ascii?Q?s1W/vMmvJR18V3xg/FLRY6171xkI+whEFyLehHI/eE4p7H++6K9k+2LPAqSz?=
 =?us-ascii?Q?3FV6+g7nrJk7BNqbblXEsidTv7GTJNdU+9gsdEeAi7OT7rLigAv7vS7+ND+r?=
 =?us-ascii?Q?U3KpbIHmlTngcThos/cfsjd/5mj4txQ9SomDO5rj1xu64bavNcQBHyzl6jTo?=
 =?us-ascii?Q?FQFmHvd6VWqXKGRQJ9HuqNwtfbuvaIkCM1+uwTTvXAk9mW9jNekObFzxYGfN?=
 =?us-ascii?Q?TDCpYTaAbUTeO904CyRTKv5C09GWtLvc9on/iuub4BQb5HR8CK5SKHpOza2Q?=
 =?us-ascii?Q?E7cOQgIBgfeRllB9ICA9KFC2CB1yZOWTeIHiTJ7PKj4YO/3cCvRObA9lM/tu?=
 =?us-ascii?Q?wNP51W1gAeOIVZ6kHczP1cR46jU9YCgJI0E1oaE+IZGvn2VRljmVbtfb90ZC?=
 =?us-ascii?Q?jmjDh2aawpN7pNWmk5cbRXYmGIMKeqo2X2TuxF79EMAGLRQit1LFo+eLIFUi?=
 =?us-ascii?Q?VzqVOkKYlOzMT78ELxoPdO+ErgrOfCqD+4W7NKiVas9IIHXRjVKu6P2R7AyY?=
 =?us-ascii?Q?Vdn23tbn2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DalkzsuIVBSLFyZURJTXsHIk0VS8FBHwgPqipXezbJZaiVlymXogJ21ykqClbGh8Lkm9akZpgUtDBgm9LJUhbTsv72OeJraTsLokiuW18/XSVaEuwWyt+h8oIatuUrF9MOh/Yd/Yuh++iD8L3PwdeKUJJHTTFRYxAMuXINVX45Iy+1WgWACDKp3IrJPlfntQOZSN5KrjXEYoj91ERN/rt4v3UEczZqMEpSTaDEnVVwyQqd95K+Jhf4brOdIQgtQZuR4gqgNAXz71TYjJkmMUOBCLdoTKUY9sRVW2vJzRHFzzZ0cN0pzqXZpL6FzTWWHefeyfl1pDPusj4fozK4RRRMGPPY1rSbfitSPAlumV9XyQMELiXdwGXf6A032FitLRz1SUYNs7oUYl2+cU6lhwwKYKZnG8su9kTe4DkPz7MaYt18DhVf38A86wSQ0FXLqPohJBvQm0V56ub4/mVM4/L2k6uv7Z84vOa00Da9T1I2YQsw2N9g20z2Pqbdh0RuEq3BTWawMeVDgp6lyXm7WpmyPjS9GSzKW+BZCzjGRpVXdPtTX8769YNF93/zo/Nj23XMLmcgbaqMEwHb+pytIXuXpPCLPeDVqkTpWygMGZRbA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f3157f-d933-4fe5-6c17-08de743e44c8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 07:19:52.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5/mLbTetn0JLMnLmBo6J/cTw6ND0thi/PS/wG15rzC9h070jaHydTblcKGERRnBpfJNWDCZ7Qssj1B94X7mRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602250070
X-Authority-Analysis: v=2.4 cv=La0xKzfi c=1 sm=1 tr=0 ts=699ea29c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=u9taHm9h3gVzBHmIwZAA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12261
X-Proofpoint-ORIG-GUID: t5syJ-Dj-kB4viTbYvEEd2kDwYe6GBMf
X-Proofpoint-GUID: t5syJ-Dj-kB4viTbYvEEd2kDwYe6GBMf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA3MCBTYWx0ZWRfX4iKQ+j+i7kOu
 igpZXFUpB2nNTu/UCgb/AJLH7K3KXimbOf+yA0v9SziZ42S68s+Oi7YzFpvru0Z/kDRwN/vfz01
 IUUElp3KcaCDAY9QaaSznOzcsABGyJpSaJggpqmHKLQeY2Cuebv42hR57AXQEuR5mvXleUsdiUh
 E2xrzEaJy9W3E2pNAGktWvlDdBag1GbaFWJ4q2TCBKPYVK2/J/9qjPMJboLQw7NguqugbBaMhWo
 2PSbMShhW8r6tjqjSyDS4gShM0semOSp1H7Ztstd5IaTxH37RysUX7Om1NFM+g4iJ04PMNEFYdp
 ZI612RSSPbJiizMruvKhyW7x9HB4nfWc2mnZQ8wcFjRXArSmFeh2375Ev4u3Pe7HyWHGAr9DFyw
 zl28b7BAmFCmVgZngpZ2qqQG/RICyYnf5FKBooYcIthHY/9c1Z/BrQGmnlnCJ5u0gOv8qgtK9g7
 Ccl1AafcpuuZD5Nn2+xw2eLTNcToye7LTRfO9K0M=

On Wed, Feb 25, 2026 at 03:06:46PM +0800, Hao Li wrote:
> On Wed, Feb 25, 2026 at 03:54:06PM +0900, Harry Yoo wrote:
> > On Wed, Feb 25, 2026 at 01:32:36PM +0800, Hao Li wrote:
> > > On Tue, Feb 24, 2026 at 05:07:18PM +0800, Ming Lei wrote:
> > > > Hi Harry,
> > > > 
> > > > On Tue, Feb 24, 2026 at 02:00:15PM +0900, Harry Yoo wrote:
> > > > > On Tue, Feb 24, 2026 at 10:52:28AM +0800, Ming Lei wrote:
> > > > > > Hello Vlastimil and MM guys,
> > > > > 
> > > > > Hi Ming, thanks for the report!
> > > > > 
> > > > > > The SLUB "sheaves" series merged via 815c8e35511d ("Merge branch
> > > > > > 'slab/for-7.0/sheaves' into slab/for-next") introduces a severe
> > > > > > performance regression for workloads with persistent cross-CPU
> > > > > > alloc/free patterns. ublk null target benchmark IOPS drops
> > > > > > significantly compared to v6.19: from ~36M IOPS to ~13M IOPS (~64%
> > > > > > drop).
> > > > > > 
> > > > > > Bisecting within the sheaves series is blocked by a kernel panic at
> > > > > > 17c38c88294d ("slab: remove cpu (partial) slabs usage from allocation
> > > > > > paths"), so the exact first bad commit could not be identified.
> > > > > 
> > > > > Ouch. Why did it crash?
> > > > 
> > > > [   16.162422] Oops: general protection fault, probably for non-canonical address 0xdead000000000110: 0000 [#1] SMP NOPTI
> > > > [   16.162426] CPU: 44 UID: 0 PID: 908 Comm: (udev-worker) Not tainted 6.19.0-rc5_master+ #116 PREEMPT(lazy) 
> > > > [   16.162429] Hardware name: Giga Computing MZ73-LM2-000/MZ73-LM2-000, BIOS R19_F40 05/12/2025
> > > > [   16.162430] RIP: 0010:__put_partials+0x2f/0x140
> > > > [   16.162437] Code: 41 57 41 56 49 89 f6 41 55 49 89 fd 31 ff 41 54 45 31 e4 55 53 48 83 ec 18 48 c7 44 24 10 00 00 00 00 eb 03 48 89 df 4c9
> > > > [   16.162438] RSP: 0018:ff5117c0ca2dfa60 EFLAGS: 00010086
> > > > [   16.162441] RAX: 0000000000000001 RBX: ff1b266981200d80 RCX: 0000000000000246
> > > > [   16.162442] RDX: ff1b266981200d90 RSI: ff1b266981200d90 RDI: ff1b266981200d80
> > > > [   16.162442] RBP: dead000000000100 R08: 0000000000000000 R09: ffffffffa761bf5e
> > > > [   16.162443] R10: ffb6d4b7841d5400 R11: ff1b2669800575c0 R12: 0000000000000000
> > > > [   16.162444] R13: ff1b2669800575c0 R14: dead000000000100 R15: ffb6d4b7846be410
> > > > [   16.162445] FS:  00007f5fdccc23c0(0000) GS:ff1b267902427000(0000) knlGS:0000000000000000
> > > > [   16.162446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [   16.162446] CR2: 0000559824c6c058 CR3: 000000011fb49001 CR4: 0000000000f71ef0
> > > > [   16.162447] PKRU: 55555554
> > > > [   16.162448] Call Trace:
> > > > [   16.162450]  <TASK>
> > > > [   16.162452]  kmem_cache_free+0x410/0x490
> > > > [   16.162454]  do_readlinkat+0x14e/0x180
> > > > [   16.162459]  __x64_sys_readlinkat+0x1c/0x30
> > > > [   16.162461]  do_syscall_64+0x7e/0x6b0
> > > > [   16.162465]  ? post_alloc_hook+0xb9/0x140
> > > > [   16.162468]  ? get_page_from_freelist+0x478/0x720
> > > > [   16.162470]  ? path_openat+0xb3/0x2a0
> > > > [   16.162472]  ? __alloc_frozen_pages_noprof+0x192/0x350
> > > > [   16.162474]  ? count_memcg_events+0xd6/0x210
> > > > [   16.162476]  ? memcg1_commit_charge+0x7a/0xa0
> > > > [   16.162479]  ? mod_memcg_lruvec_state+0xe7/0x2d0
> > > > [   16.162481]  ? charge_memcg+0x48/0x80
> > > > [   16.162482]  ? lruvec_stat_mod_folio+0x85/0xd0
> > > > [   16.162484]  ? __folio_mod_stat+0x2d/0x90
> > > > [   16.162487]  ? set_ptes.isra.0+0x36/0x80
> > > > [   16.162490]  ? do_anonymous_page+0x100/0x4a0
> > > > [   16.162492]  ? __handle_mm_fault+0x45d/0x6f0
> > > > [   16.162493]  ? count_memcg_events+0xd6/0x210
> > > > [   16.162494]  ? handle_mm_fault+0x212/0x340
> > > > [   16.162495]  ? do_user_addr_fault+0x2b4/0x7b0
> > > > [   16.162500]  ? irqentry_exit+0x6d/0x540
> > > > [   16.162502]  ? exc_page_fault+0x7e/0x1a0
> > > > [   16.162503]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > 
> > > For this problem, I have a hypothesis which is inspired by a comment in the
> > > patch "slab: remove cpu (partial) slabs usage from allocation paths":
> > > 
> > > /*
> > >  * get a single object from the slab. This might race against __slab_free(),
> > >  * which however has to take the list_lock if it's about to make the slab fully
> > >  * free.
> > >  */
> > > 
> > > My understanding is that this comment is pointing out a possible race between
> > > __slab_free() and get_from_partial_node(). Since __slab_free() takes
> > > n->list_lock when it is about to make the slab fully free, and
> > > get_from_partial_node() also takes the same lock, the two paths should be
> > > mutually excluded by the lock and thus safe.
> > > 
> > > However, I'm wondering if there could be another race window. Suppose CPU0's
> > > get_from_partial_node() has already finished __slab_update_freelist(), but has
> > > not yet reached remove_partial(). In that gap, another CPU1 could free an object
> > > to the same slab via __slab_free(). CPU1 would observe was_full == 1 (due to the
> > > previous get_from_partial_node()->__slab_update_freelist() on CPU0), and then
> > >
> > > __slab_free() will call put_cpu_partial(s, slab, 1) without holding
> > > n->list_lock, trying to add this slab to the CPU partial list.
> > 
> > If CPU1 observes was_full == 1, it should spin on n->list_lock and wait
> > for CPU0 to release the lock. And CPU0 will remove the slab from the
> > partial list before releasing the lock. Or am I missing something?
> > 
> > > In that case,
> > > both paths would operate on the same union field in struct slab, which might
> > > lead to list corruption.
> > 
> > Not sure how the scenario you describe could happen:
> > 
> > CPU 0					CPU1
> > - get_from_partial_node()		
> >   -> spin_lock(&n->list_lock)		
> > 					- __slab_free()
> >   -> __slab_update_freelist(),
> >      slab becomes full
> > 					-> was_full == 1
> > 					-> spin_lock(&n->list_lock)
> 
> In __slab_free, if was_full == 1, then the condition
> !(IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && was_full) becomes false, so it won't
> enter the "if" block and therefore n->list_lock is not acquired.
> Does that sound right.

Nah, you're right. Just slipped my mind. No need to acquire the lock
if it was full, because that means it's not on the partial list.

Hmm... but the logic has been there for very long time.

Looks like we broke a premise for the percpu slab caching layer
to work correctly, while transitioning to sheaves.

I think the new behavior introduced during the sheaves transition is that
SLUB can now allocate objects from slabs without freezing it. Allocating
objects from slab without freezing it seems to confuse the free path...

But not sure if we could "fix" that because the percpu partial slab
caching layer is gone anyway :)

-- 
Cheers,
Harry / Hyeonggon
