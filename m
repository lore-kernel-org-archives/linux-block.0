Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42FB20822B
	for <linux-block@vger.kernel.org>; Tue, 12 Nov 2024 09:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403329; cv=fail; b=t5bt2bddMrrwfH3TD5LLFYIVCniiH1xNYCKO2cNKIrZM+g1/TTYtH3TIXcmivW4+7tBNGCMdjwosbpc2oH9Gz5ubCdKC+zv+2xmH3HNtAFdO+dHWj+AVlFvzG14qko531IUJcxxVpnBEaPIxTD17uQq9SxBsEpCF6VYRDTFHL+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403329; c=relaxed/simple;
	bh=WLlCQk1oZfF0COlJtmGIeWn39dfpSAI+sp22PXnff58=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EJbvv72iiITEOp4YQnuQmcJm9zKRDsj503uloJxDTAq3ZnnEnBoUjUSGJy45LXiH3/10LlnJGm+vh+a2dWs534h+Re9ezSI4aL5SJriYOcjSHVFW/4lcwfaejOkXNPF/0NtoPpVto1ENvHLw6LuFswFK1rk6FLqaoEMww0o6Tcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aKWSg7W/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hy4TewjQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aKWSg7W/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hy4TewjQ"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC8fafU004112;
	Tue, 12 Nov 2024 09:22:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=CgtyfBF4hjPax/0K
	Hq6uTwERQlJQgaLTqq4sOMYp4Mk=; b=aKWSg7W/ATqObxTfDqSZq9mGPgbaDlNO
	2jOPHpFfYR2P+xAGivyZPEWe6ltCdyzjEk9JpHzkUJLi3I+2eCIGmKdhY1PCxC0S
	VRtvphTqXLnSLzAsbmAaPwo+z4yOBioFdED+sfe1pXjAnDgpfUmurwWlQWKKpnhW
	i5Tk8ppH280s85J582Q6u7FiQ7BX6X3kZUBcU8h28phCC58zlaAFjlHIgNL78T7s
	TQSQutmeAVDAhxf+Pbho7twobxVSVNHVs070qUxwXGBkY3cYt7wM5ZKhmkn4CikB
	Uhv7PWhIaisavslI9g2E9CUrLo2aBOKfYQnIUtbiZXjVI7DkIJC3IQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5bvsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 09:22:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC94Vfw034326;
	Tue, 12 Nov 2024 09:22:02 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx67xm35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 09:22:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tF7Dd2M2hAIEesyCXV2e4WVd9V1rOOnrlk9GsDtexibuY6BihVviLXvGqkevRUYunf48P688GFiXvAB9QP5/gctPK02ICFbsxZUjR6TwufIwPrc30ck+UVx4FcPdsLL5+/AmbJp/oM9A6tzBlO/pRBhbWMsSxGzcDMvdZqxLyoj/+ZOqnD5rncsjY7HErdGEJk46kPGps+K3XTdnA1ZuPQl9pficu8oh++skt9uwQv6eB/lvwp1DWf+V8EyVWpxr29jaqN0Kk8oz4RKIBFzetFcpFrhDD1h87B0jo1OMZEfMvsKzuzPtFuh3oMZTi+WLALKZ37f2q8SaEzlm6S3OwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgtyfBF4hjPax/0KHq6uTwERQlJQgaLTqq4sOMYp4Mk=;
 b=hPz34eT8UEp62NY6jr/9eZDTFmHgWJlxPHhbYp8DxxY7+WvTPED9tvo8XUU4vr1Eey/is2R9Pcl54zFIAbWXzbaQdRhPGoXja2hVOvRFjoVAN35O4PUeLnnibbrEvQ8ILTwf0cDfo1bClPiJnV4D3/UfG1OU5gZrPYLYBtbGl2+AISYHxQ7W4YxbNnoJIwURJDgntekMFnnOjn0Wg0VxALZn9MHbWLFgFg6Cw1OHMB67G/swc83NZ/quMSFIHhxsr9XnX6w5P523IFMto6Zv4E2jO0KOwPYjmd7gQwZVtKiJKAjliw/LT+bYoL20TFcq5UeTX8Zz7KWJP2eocfMbBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgtyfBF4hjPax/0KHq6uTwERQlJQgaLTqq4sOMYp4Mk=;
 b=hy4TewjQ4obG6ym9r5awaS4WS7yLRgYrdjoqljW9NbVLXXZdEpPGerpPmm7kOkIghbrwyNm6DRDrgtyCm76/6yG/12E1jdhGXrOT8qYbb7eL4c/bEDsSWZUHzWEPuKRlpS0B5ZUUVVOZL7ZLMjBjwfe9opBziDIl12y9bTffYrA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5106.namprd10.prod.outlook.com (2603:10b6:208:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 09:21:59 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:21:59 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] block: Drop granularity check in queue_limit_discard_alignment()
Date: Tue, 12 Nov 2024 09:21:44 +0000
Message-Id: <20241112092144.4059847-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0901.namprd03.prod.outlook.com
 (2603:10b6:408:107::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: e0141972-6d02-4a63-7584-08dd02fb75ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oH8ozslxY8zRzsUTWw6nu7zr+9xWM8lTjIdsV7rH5GyUWa+NGHsZEk3MrRys?=
 =?us-ascii?Q?t53NNqz255F+v0ltL31rErUZ5MuAJCeJKHmEeNqNI7N/PumrvQkV86i3UzP8?=
 =?us-ascii?Q?8T+PNIwjzsNMNZJuB0EjUySBbm6nydaL/UTzyQXalVYDQhhP3KsAHVdfCFLD?=
 =?us-ascii?Q?RsVqus1q3O2lZ0cqKk9nvKAx1SeVLdiSc2OIGHD+T9t9AlEb1TvlzcaguCWi?=
 =?us-ascii?Q?l8W5/Rkg9pes3rx8yGJmkxGpfzw+qFV9A9HtNeTUBmdobq9rAXBkoBfKaxsQ?=
 =?us-ascii?Q?O5QITChIsSB3+vwYFOiRshLsi/4IGy/tQ9B0BFw5gyUEcFkaLyZMqRe8mvUL?=
 =?us-ascii?Q?V+XyBHgeq35VEQKYOYKeF7FawJv2Ek2ikXQlllbq4NnqYt7lgih0mMeT0EhD?=
 =?us-ascii?Q?kQU5HnTkAzLpM++l4H9s3v2zIkh6ARgDz6LNeyoBZ4fMKmWOd8Mfev3Zy9gO?=
 =?us-ascii?Q?t83DeZHZCFrBehk9raeIbFA73JIkRk6hJnyXQHCN+SQgwhLvK2lDKSbal33K?=
 =?us-ascii?Q?Q+Dn8AjgWD3RiLfy4F4QXbU9DGcfWIXbi5eSJwPa9VpJfEP5wDfr6zAMzL2e?=
 =?us-ascii?Q?e0mtjnBcZPQE8ifyvrE5AQF9tP5Kzcn0ft6lRCfQtOGNf0TLNSuusE0rHG/v?=
 =?us-ascii?Q?uu8U0kyGR40aOaV3VpHa4ktZKZWqEXIP0Y5mcPUjR4scg3m6TAU9xU86yrLd?=
 =?us-ascii?Q?MHLdAy58YT2INmH3S5CI/n5f/lEhSVuSYlgMyyxaxgxaJsmTVc2UVhYcXRMU?=
 =?us-ascii?Q?S3H59KYSqkKno/J7F9Cqs/x0VqcUFmbWWbRmadoLAFPuY5ygqdd8ULWCiT5a?=
 =?us-ascii?Q?NdoR/eI/llZVmjgcBHsdEfs/ANyJcJFSxHT/N4Rwsspk/ehGDjH6QMQpeoAb?=
 =?us-ascii?Q?D/SSuo25SubwEH1kh8JRoFuaMEEdlkcoOixeBHopkprS/NwLt2wF7mykEiTj?=
 =?us-ascii?Q?Uk9ZgAqQVEKd1AYFDzsdHvUyL2/1CK1mVhuKj6Oi+HIvNAo+nA/A8ASHlUMH?=
 =?us-ascii?Q?St+qVnXR/PSei9P/Vk/D4TbcKhNwud8asIge/ANIrjuOq90b5mAoVBFvZJBf?=
 =?us-ascii?Q?cjGVhtNI7STmVG5sgr59JfwAxhrtk8pEIw0Jspl071k4jYcvCzkInodMNYzO?=
 =?us-ascii?Q?AA0bMhWN4juiZEl/mnFDqPxTF89c6LrzWD9uWlVE+3Jur9czY+B+aq/9dVvk?=
 =?us-ascii?Q?NeR+Am4C9y70ykHSGrjPC9kYcy0fD0I5i0DIlKDmFt2tEBdLYSzBrW67S7YO?=
 =?us-ascii?Q?p4i6oMOx2JOP/lQGAcUkl6Xtkhj/1u08b0NFqSnQgQ0/E5+3xjkLzAY9y5tV?=
 =?us-ascii?Q?T4J6evkobTy1K5pgPJ2az6eo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Owg9xLOo82BuqeiXPN7uv/JsQBQ9i6rd2VvZ/2PbuqrV0pdGcrzPATM1gLYM?=
 =?us-ascii?Q?a6EV33ILtfRB9vrn2FgrbqyB1V4vSiav971o484eTqD7Ncg9Rh7uJotovYBA?=
 =?us-ascii?Q?6ftc8Y1OFOP36yj9jLrC79AeRSTXJCM73gAS+1xXj0/JM7puGQ+NT5SlmAyf?=
 =?us-ascii?Q?jPrha42TcHjPsxAf0ivTl78TuuYIRUFJzX7oE7C3EsRJOmS50JV926nHRt+8?=
 =?us-ascii?Q?J2gCub6GIdUbGiz+8syeQyHzQA1iSonK6fdAIPIuawuRzt15RCutRtgOH0HM?=
 =?us-ascii?Q?H5938iiZsX3TwZPThWUT43y5W/6SBkfRECe9wHo3je8Uf9DkVCoe8IXknFsG?=
 =?us-ascii?Q?DsBjpTMuAmmqgsIPcnEgsHOClmpzmpTeRHmYVQ78bpecJR7pq0LtuDBMLUW2?=
 =?us-ascii?Q?Ih/gw0MLgATsiQq1dGfQqnOrFcQgE26JSXJ7DQHkwjnEMeaPCnDduPROVonf?=
 =?us-ascii?Q?qqY+t7gc72dwxklg+8aEIz7OUSDxAHVo5GiomzrIPjjTFRTIEc/XHZRkdm4P?=
 =?us-ascii?Q?g4FAxT1O1DahCCAgcbhAooHpRRNFop9GXRslbIMDZyHH4LM5cdB9D8VWSAih?=
 =?us-ascii?Q?W0hArTHKQ/WSlnR/dKLFNadmi3rmmH/GWY6NziG4pPeFhk26H01ZcsuRG7Ko?=
 =?us-ascii?Q?imoNsZggQUrAH4Qz2bJb2EGw6U4+SoOzURcl/pyx7mm84ywW+0HlucL25kVp?=
 =?us-ascii?Q?rwdkS+g6XKaY7wTP+YJpf1EUDv21k3fo7Vh2YPqRvf0JgBM+cBo7NWzW/7Xb?=
 =?us-ascii?Q?AL6350rUNpP1pwbg0Z3PsooGGvxBdrfgPL9t+wijOII0JfJc9Q+q/dYO9LwB?=
 =?us-ascii?Q?KZ+VMLCuWHfOAAy5+WaMzp+0LjI17NBdShu+A7kLbuSJmq6BCOHTJmsj9EPO?=
 =?us-ascii?Q?+Pf0YsFVkRRkdzZ+Lc8IYB/6o/gTz2yX8h3BrnjZugSXy3ZbZFsK5pQWPHYB?=
 =?us-ascii?Q?2YE+HjEkaaClyWOzJXzKjj9IMIuOFl7MLNutcnZW6BKq88m+W1Xri1rHG5nw?=
 =?us-ascii?Q?iqIX2EBCtLcUfNuuBOFASWsM2+DdyEh1ODnWtGyPIxPDZ8ffAcw3bwUs07bx?=
 =?us-ascii?Q?C6egfWY/oinixEL5wHBPeEqZN3sp/YAF8D/pZFgE2rdSm5dvhraoB+NO+k7V?=
 =?us-ascii?Q?1n2bOAqd/rOrOgl5G2yakhOK+vANCWciGGFObsDrOQ4tso3MuQ008lmQDG3p?=
 =?us-ascii?Q?RFQZeQOTfXrtkbKlCJLgzA8KxX924mm6F535m7FWDaShK2/XL6cSZPxSW7pc?=
 =?us-ascii?Q?eWv6RbH32cEb3Ijj3aY+GUHo60uc1PTugrSgMUWk1VZZbWqIXPVmTQ9u58rw?=
 =?us-ascii?Q?+8dFtNsyG2XgSHzDt5/vS0jKV5ifDubP0TXZTl7pxi4toQKSuELlUrImnyAA?=
 =?us-ascii?Q?DJD8tXTvRMyE8OGLpHxdux6urx9UAfVCvyqsNuDQPju3ek4m7Y0dhSAnFVuJ?=
 =?us-ascii?Q?LhVj5RIEAO3oeMfT10+ZNqMGUiWpGK/Xa8apDAhgc2SFtAmdZTKrIqayxQMf?=
 =?us-ascii?Q?X+je5vgQ7ijKxvBPtZhPJze6JdI9pDwzuB0r2jVF3wyMg5Fd5hTFcisI9et3?=
 =?us-ascii?Q?FtK5B/Vsh25AB/IjLvr/LlsbR6RbYalE395UhaDlN+j4IpKYQDJqoDAUYFZS?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VGofRRvqLfZAeQJGiV1buxSfb9yBjzjjAkjplPWE5oNDILpWZ0Pb6I7QI48x6V3P6/P8LrTC2II3IBejHbWtnqh/epR3Y1gvwgzWvX/4HVARBZ/co+M+Qhk3ZVx8djgl+BBzmB0rVoBJUy7QIc9YgnBFLuq3h9OJFUctdSV1Do5YYuRsLucYR86TnNkSSVjcIFk/QltlDZSLdm+7CJwXJkGUsPBs5qmqyYafsJY8cwwYQ8tsZ4yKSKKgbRs29aof4EglSLEpfgcN8z6pna1c0OLG15mANhsfk5JsCJ9TlDPVPSupGGOfG1kFVKbGtTz0ebC0EwJZkFKMyxq/Zbge/XgGxYoVDKJX5c/+S1d4TzFGDm9rxgSvVPcgX3AFvqC4fwF32vZgqLKLyh2AEpmT5gF0qj+HAtKTrOjwAyquQimSpbSn0/vBu2myd5p6LRzA3I0C8MSOapaLwhl0yKprSp9qwO4Xz+q5UKA+yTY/ekugfD4i8+b2MiO4QPpbdDdZYyf6pTBg45Qqfwr1GmaPFE9GjRBih+oz1wHyawHBhONJgVc2X0ORvPYSh0ETO+nSYzzbQ4/BpBHdMTTiFdOeltp7BR+S7j3rxp2cY2JNkT8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0141972-6d02-4a63-7584-08dd02fb75ef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 09:21:59.6397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iW0vWs9nkD7eb9H+cpmSxpnbd0HadPIOHkE6PTGD06WNIinbL9ENu47mxd8RahBbssFfGzUhtKtqmgio7MM2Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411120076
X-Proofpoint-ORIG-GUID: 7m7JsuoeiAqh3HB-wH_VratZy03UcO8T
X-Proofpoint-GUID: 7m7JsuoeiAqh3HB-wH_VratZy03UcO8T

lim->discard_granularity is always at least SECTOR_SIZE, so drop the
pointless check for granularity less than SECTOR_SIZE.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 7d6b296997c2..4091794c5a1c 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -457,8 +457,6 @@ static unsigned int queue_limit_discard_alignment(
 	/* Why are these in bytes, not sectors? */
 	alignment = lim->discard_alignment >> SECTOR_SHIFT;
 	granularity = lim->discard_granularity >> SECTOR_SHIFT;
-	if (!granularity)
-		return 0;
 
 	/* Offset of the partition start in 'granularity' sectors */
 	offset = sector_div(sector, granularity);
-- 
2.31.1

