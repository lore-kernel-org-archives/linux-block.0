Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1984155389
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720523166; cv=fail; b=LXsEAsAU823MkwWaAYuHGt1nVNOVjMy1e+FlW/O8kSwu7LbLhANzMfScyGlutmtR+39b2xoCpZiUtKojWcWBkCn4f6QSMzTJ3ednzCEdUxW+mWLu3/s2tgLQ8opnWj1jcnxduUAGc+jmXt8MACmJdxn7Sa4FM36op+Zynd7ak0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720523166; c=relaxed/simple;
	bh=RlsFu1RZBLRNHL/pd0T9NSWjn5fl30F3Swwwjkk/RD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ItLJTXw8ApDY7yugUp3JeZsgspotNqA9kQlzTEHKjOxRe5zsi4TXWjVZYYjzD5eTws82uz0XKTX5HpeMzryzbMr1iEOv8qp4MCRVqjSNoy+WJ5c7R1rT1/dTNA+N5aDjRaGWBDWZFhdua+NMwQcJGIgQ2pqh87rlwSmPWP7hjw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y+VoNt1e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dCaZlubF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y+VoNt1e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dCaZlubF"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tUhg007106;
	Tue, 9 Jul 2024 11:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=XWwLZFHR55qqHxuquaMBGu4+6YwTbj6OH+EkqacQJ8M=; b=
	Y+VoNt1eZbHboKybIXhrQ78u6k7K/ACAFHnCNWQ+DcoYgFyK5SzHvXXD4hAPVHtb
	eOsvHpc71qwdE0fVGiYp3oF4S6W8SQIBrXihp/zb/4xlTZJKOKWe24brRtNf7K3n
	s2nfrBg0kZNlK3bvj3WJOwXndWwsCW/KP47qffpA73A1MzyekgY/jwwdxHYpt9Hx
	PrCGHMCt5sKMtftsrotO7pwHqJn8SLCNzF4ltWL8wPLBdxDZZLSGkXgEGpAqrQ5d
	ohpRwZjhBzWnnWIVWALUsZ3QnD2oMgoXZWZQh1IOHA7wpj7R3awLXr8IRnROxKSA
	7ejg8cvBtsLPsNMxQvMong==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybmpte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:06:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469ABW8N029950;
	Tue, 9 Jul 2024 11:06:00 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tttg5h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 11:06:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAH/JhULuTN5rAvp0VM7u78qqHRl08OrjM7oA5Kqno6ZbbzgWQ+ocZAnqzlfg6QLqExzCX9i76ireYox5gGidFjs4qZcMGJzKvGIYYA5xPBe9+8uDxpJ1jZ/mFoggAaEsBc2aQ9eg6ue9PFefxAfdtlXCIf19xFyiprvwtSoLAXwYsobKCnGQUxvorL5sMEPfR32TVpDsCZci0rLuEaMhjRbqBA7mQO4RTiB5885Wsw5y9jR5IE9RtPwEi94mE1zX3gwmyEGGS76bOSd7jJYz81o9Xisk9F9kavHoB7RGr8zyrupIBEHqVkoEbI3kwAHhUCfCVt69uyo75AMHXeRAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XWwLZFHR55qqHxuquaMBGu4+6YwTbj6OH+EkqacQJ8M=;
 b=NsaeYkuU4BdV36/z1YBQ1S9ondvn3+6ZJnO1kH15tLrxNmPW2Xpt8oYminzlXBqwK3ctbkanOP6ME0GdDJpSIZ9h1WFZ3Dd4jC8bYHr04wS8Ha+UBn37UTt5fKcp8/gkzRHiokD8GjddIUd3dqiPNnYPD9Nf8MV7S1SysUxa5tNeYki74UqzjuHrSX8AFYGpaG+uaVoqkJMkdvYYRXkKpo6bUAsEyjJwAteBkSgFUwfqAcySEOBDA3KVbwbVzd7N+oQv/gmKDlJI616k7D/SXTBURn3+PAMXMf3pxIA6mHHWD4HEPqiPLBCX0Zg1pO9t2GfcCN1krnJJ2QO82BAedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XWwLZFHR55qqHxuquaMBGu4+6YwTbj6OH+EkqacQJ8M=;
 b=dCaZlubFyw9KtkYFgMRpF+Xa2Q1JK+nAjVx71hjeuEZ5n+jPAzgS9McSkKBkk8jbTSpsI/cV2PC01tQkash/Ga+ZsEe08odF8em8Ng5fIQGVjPEIDjMPEBkpvIRqs5Uro7NfIxZOzKMiv3GiJFuzPLZaDHXjZUd/cP4cmveBvBU=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by IA3PR10MB8068.namprd10.prod.outlook.com (2603:10b6:208:505::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 11:05:58 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 11:05:58 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 06/11] block: Catch possible entries missing from alloc_policy_name[]
Date: Tue,  9 Jul 2024 11:05:33 +0000
Message-Id: <20240709110538.532896-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240709110538.532896-1-john.g.garry@oracle.com>
References: <20240709110538.532896-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0084.namprd03.prod.outlook.com
 (2603:10b6:208:329::29) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|IA3PR10MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 940de3fb-e00a-418e-d264-08dca0071c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Veb3V8pC9jR4XW7L6aoATGAgeA7hQq8VWTZ91PMbLxiT7yz6tKs1djMFcGST?=
 =?us-ascii?Q?eVfba7WZ/FEMitCZPbfJk9XKAB+XRsgXVBlzndsi9QMBmCmzMKwgTO67PbNK?=
 =?us-ascii?Q?7qFUeopKjV+yzoXAW4uZujkUreLRuFhqhQVJmHPp4O7Y/vi0W5e6zlDrHnXL?=
 =?us-ascii?Q?AU76pfwFjiUIhkMmQzrkUem73+UhzAHehVlYg0PEOAjrCTyloji8zqBvIZHI?=
 =?us-ascii?Q?XviZWQqzzBLrYWDsgR+YsmRGz0WbwvgWtJiQyshXLI76FzuWohbzE2wMnOv6?=
 =?us-ascii?Q?LJFXlOaHYHcbbM2hxq/+c+2oBkQ0gSHUaDzqC0f4S5f0MXgxVXD8a6i/SXQG?=
 =?us-ascii?Q?PUpb7IirLuLSZ71iC3Ps5MKqD4uT9S+EViwr/tflktFwFtPRK7FVZUQILOki?=
 =?us-ascii?Q?6gHPe2nMWNOZYZIuaTwc2YeRnOafH55FCNRWRC+pP/EK8gZqqAT6QUOaUUGS?=
 =?us-ascii?Q?zG3pLCFJQeja668g0gi2gnSAp2rpo1H1eErsv7Gw0kxZ8biXEw6X2+0KnEr5?=
 =?us-ascii?Q?EyEIcAvaSGmRau/7eA/HeQJDjkZZuzfcyONBHcmetmW1U4xZnLLqUC+vGf5T?=
 =?us-ascii?Q?tyLCMw9ltGxYoxwP5QoVT0H6TWXqxoJ2prfHgqEifNq+iJpma/9CwzwcS6Bi?=
 =?us-ascii?Q?LZubyIn6THHG20Q8/ArumzPFbOKw6X9gbEaj5FLZf6Gc7NrnqubxAWIb5pim?=
 =?us-ascii?Q?mKXpzTfepEH3uKq63aW//e9xxJI5cLLO9x3xda9iEg7faouMGpWjhAA6FibO?=
 =?us-ascii?Q?EoUNo0i1zXAQpTvcQyvqhoqOjJSLfYFuXNcSp4sdga9QaXojQ989u7ZO++nK?=
 =?us-ascii?Q?QVej2tyGF6Y34Yxr6NlCLHibeXA2ohXMu6kH8Y0DZchLeECG68i5DnPW5IvC?=
 =?us-ascii?Q?ZQ4xxI+YtUS2xgg06LSYGlRAWpCCZU8boPaFN8EB4hWF2O0SRoihngh2jFFK?=
 =?us-ascii?Q?ZkdWXEkdfvvuAk+WmYI34WG9yvT3fgpIcv8W6ao2WXlORxEY+X4+aqS39Ugw?=
 =?us-ascii?Q?BQ8PAl257gKheY9DYblLHRZHZszP15RRBBwAOnlR/UQgj2mZ9Nao67B34/E2?=
 =?us-ascii?Q?RZfrP3CtscJBEnUR0sR7417hTiH6PTCxXJn4iSjPmLg+VTkmxEvfFFtsxyro?=
 =?us-ascii?Q?qpIsn+VaCeC5cfDcqP5zZg3rk9JjTeIJfwBKO5DNor61d0zJMnexiJ8Yzce+?=
 =?us-ascii?Q?k2bQ5USS2DlU/WelyNxhhmys0UQuRiWdLbJGyvbPmQB1gtArJBMGvXVWHk4g?=
 =?us-ascii?Q?zL2lpw2b4nh9GddaOoES6XE38CZM/oG8b8MS8ywV2V1aEbrV0N6YEZ4kwEz6?=
 =?us-ascii?Q?aJzWUIAExCCnNrVbW2ViSwdg6FF7fObQw6fT7SQg+H+jZg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?n4tyJypxSlJfEISWBqba4paDjT+9P/ZemjXEmzsI1T/AZKgnMZT69/5rVXrM?=
 =?us-ascii?Q?6XA15wKtHxYfyVoSZoI4zDuFYNro+xOutplepVPbgXJZ7KkuvvlqqIJ0aeSk?=
 =?us-ascii?Q?KkrdbYTXTZ7XU0DJkaAPe37GDzUnlFaRTJWXSMRn4pdnLVETK9aPrhY6UK0E?=
 =?us-ascii?Q?i1n9QbWJrssVMdjPlqoY76BU2QH16eVoPJLBTY3eO+wcWqF4fTinpCNO14cG?=
 =?us-ascii?Q?yblcje7oi5GCiDD2W4Lp8/aJeh456miaE6ojkV6i0GcSbkErlKU7OCXlMY2f?=
 =?us-ascii?Q?S500ygRtXA435784jYKVstva4opQBV3cX3HmIwdyHSFp5RdgREIqMr1tUvL6?=
 =?us-ascii?Q?fSleLz6SXRGGbPbReS5So5nyneQsOZK9Az/HRDX6JwqoMs42GM+JbfprcLot?=
 =?us-ascii?Q?9X+/GZhE4Zs0Q4m0uppwm+/hImsI2LoM7JP8Mi+8lqTPxzIbhCag0RwzQrfN?=
 =?us-ascii?Q?Q4L4F0/u5S9qCrGw4HpOHqNk0RzZG3REam0pVZTBIzOuxL+gAiE/KI35vfWm?=
 =?us-ascii?Q?2g5KMC5pLm/uqBg9S6siLNv+s/Q1tOJL78gy1i7N0HA+a9dCg6gCQOmoYFbw?=
 =?us-ascii?Q?15Od+VKC5+t0jZAXKImxWaRqGMTx9EJqhFFH1aNx6TZf3zTyWJo2aM+I6Izd?=
 =?us-ascii?Q?qwE0N/R4n0Pg9XUuVbXp7zxhYWngHLbMfw2sJtB+Ne+bizhMlOJjwsMMux0d?=
 =?us-ascii?Q?J4VRP+VWyr/dibv/pBEmCaYX4DdqqGZPrHy1V7BCsBB7Y/PFGFqfd3fH4UEy?=
 =?us-ascii?Q?sMhGLe//7Dcig4/nZVmeNqvmuVlC8X/p2IARzIXec/XtKNApajgJUgpFSUFq?=
 =?us-ascii?Q?yivHC/rfxqKFJrnyi+0Yx0kysG6PIr1+ENF+dwht3JXhau1v+siq2R1Ss2kD?=
 =?us-ascii?Q?9zGQEd2iripzS9dgrGDu0iG6n0sl0EO5RHGm24oEDqtRwzNDcpnVv8Ab0o7i?=
 =?us-ascii?Q?HvehbzhN+w+ZeFLROFUNz3RLehd3bG1EhwzL3b0K05f+cJmwYDgYgUp1ptdo?=
 =?us-ascii?Q?inJO0Mpq4gIulU9FEyc/xEo0Z5TA49ij2ChvxgxF0WI0GJHdujxafEstw94W?=
 =?us-ascii?Q?9JuN+fP6SGX1mmvNoenBQihYqp36OUDs1Z+WwgMq5Tb0AACegbf/z22T0Rgq?=
 =?us-ascii?Q?Hc8xVzY9uaau9aRDBNPqOEKjtRtH1sMrRkGzgEwxS1qABPFk97nICQpslD8p?=
 =?us-ascii?Q?ZBO8QIRnFVbzVoop4R5SIaP4WiekdrPjDp2KLF9CyhytxqWNdPkhv6YwbBDq?=
 =?us-ascii?Q?ZSLz2/GPAXorkx/zxsTcgOQ9DhuBMIw25+zy/sl0EbyY5jaHbOxXuWSDxMaG?=
 =?us-ascii?Q?4GHM0ugJ0xf5+IpKMp9L7KAVFRC5Tcfs+S7owytoEz6A9eAAHWH5tUiPD1bl?=
 =?us-ascii?Q?HM70i8KzXKtwoSA15ywIO73rnb8bfMifHhrtjdEqRXEdcCcXFhRhA/6c7K1b?=
 =?us-ascii?Q?/Dvs4NDHuCAfSO4zinc8YN0o2cyG/iMEoTEKiYdl4Bw1xPRiX8rrkEoD3HvW?=
 =?us-ascii?Q?BPPr2CCajGX9Q+iOZrHVd7f6SYpibi7I/U83FIWiS9lceGkqWflJ5ZOZM1HY?=
 =?us-ascii?Q?4LrgfrZA8L5wGd3vbuijcMj8Ove8aSXEUtkt2+wH4kA2AjBSDcVaKzW+i717?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tQmpwnUm9FM5gpuy+wcrPw48DTqPBEx00kljiG5HhnMoj5W48s29ZYlhMiNNiYCAhaIgZl9CKFmJTjXcflvWpMhW6FmNBmsV/Gi9DdanxuyReaLWI1hnCAF7BNbOW+9f1OpfTe7mfMUU5jQFSqQlKb2uDvzoKjmArBWV929eIQZ7cc8sVD2Ul0kKdzcjogBRwZdiEiP/TV0awMA13mmLXOtJzCL+W9hNa12ocYVK/t1OY0g3TP4XHAChGLYLWroo9r0NxXNKCz4y81thIfYp/yR1vbd/y2ghHe9sWLYssBxkO5w5cJOkMcQrRDY10QmulMRE4G8GKNiDVV4iR3V2wVnbZlX1cvTMCU8oxfaXPxury9zPf7KxPEmopu/XYr3ivCi4urAkQEvehi/jH8yL41rUYsUu2ej2yDkdAGsRawSbt0xts5CuOBuJy/JyJ+g9lkDS7mBCWYgX8S4ViFlwwplojL91xKa03ZUnEIilc1iwgEsYZTi92wiGAb9FtjrNsj5H2Y8OJ3lJNmx+KWdf0b8w/PL922SWyJCyhYpDXnYRYvjVJxB+hAkXaAccnRv4q4BWy91CcldABWDC838g0NXni6XS1UC8K0ImNsJLW+k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 940de3fb-e00a-418e-d264-08dca0071c54
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 11:05:58.3319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wr5idf2nknhMII/8wWdLreKdjQ0Kdh+Pe7rfcol6LBiqQulPE7w7fHzjy57l1EDoANFgH4z4FdwYEhfe/G+uFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090076
X-Proofpoint-GUID: atr61YmQ7oka416KRBqEKnj-ezfp13QH
X-Proofpoint-ORIG-GUID: atr61YmQ7oka416KRBqEKnj-ezfp13QH

Make BLK_TAG_ALLOC_x an enum and add a "max" entry.

Also add a BUILD_BUG_ON() call to ensure that we are not missing entries
in hctx_flag_name[].

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c |  1 +
 include/linux/blk-mq.h | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 74f470d0e1ea..e37d5a2dd942 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -196,6 +196,7 @@ static int hctx_flags_show(void *data, struct seq_file *m)
 	const int alloc_policy = BLK_MQ_FLAG_TO_ALLOC_POLICY(hctx->flags);
 
 	BUILD_BUG_ON(ARRAY_SIZE(hctx_flag_name) != BLK_MQ_F_MAX);
+	BUILD_BUG_ON(ARRAY_SIZE(alloc_policy_name) != BLK_TAG_ALLOC_MAX);
 
 	seq_puts(m, "alloc_policy=");
 	if (alloc_policy < ARRAY_SIZE(alloc_policy_name) &&
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b3905b77f375..aefbf93d431a 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -278,8 +278,14 @@ enum blk_eh_timer_return {
 	BLK_EH_RESET_TIMER,
 };
 
-#define BLK_TAG_ALLOC_FIFO 0 /* allocate starting from 0 */
-#define BLK_TAG_ALLOC_RR 1 /* allocate starting from last allocated tag */
+/* Keep alloc_policy_name[] in sync with the definitions below */
+enum {
+	/* allocate starting from 0 */
+	BLK_TAG_ALLOC_FIFO	= 0,
+	/* allocate starting from last allocated tag */
+	BLK_TAG_ALLOC_RR,
+	BLK_TAG_ALLOC_MAX
+};
 
 /**
  * struct blk_mq_hw_ctx - State for a hardware queue facing the hardware
-- 
2.31.1

