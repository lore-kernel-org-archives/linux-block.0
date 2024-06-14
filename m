Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C171922CB;
	Fri, 14 Jun 2024 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355852; cv=fail; b=OoyIIMkNozTuzO3MA5K4m6TMbuL4kxgufI1fvLDydKYuuigBoeohZaz0OEXuwry4ctIURhNg+IX7PhMobVvpZwhCtt0+9xCWJvzv5FJzW7aPt2wfLtwBRfGsLClFxX3j+gx1SjpQLUhwvPoumDFScQwvbEkMpFXPkYJHm6+agpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355852; c=relaxed/simple;
	bh=1A42AGfDMmqjO1nBBhfg3H5DS2lp5+tQ+zbcqd4KSIk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=aTem3FnCvkKtH6Nr8xyOUPLHzsbmVTBD0E3LjdE42Bc6TD6HfTdH63Fi6KZAhaANhTduW6j/VUjteHSdbHss1ogYLyiFv/QfS/csYLhw8CHlfnx3qeF8d+p0oy7SaHl2vwKxAIH+226LeUh/U7uVb6xkkKskeE/iCBuoc53k6qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dRKhlLfM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O5KGG5Cz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dRKhlLfM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O5KGG5Cz"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E1g0sx023517;
	Fri, 14 Jun 2024 09:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=RZWS+T3JIzmCtO
	ohowESbWiFCr+0lsYGwX80cqz0Cd4=; b=dRKhlLfMWHSkbJPlpazFnymNLOs6kA
	XrTAkK4dX9S9nyGxhFw6W+Ofe3fAPTh5AV2gdhpTTcHfa/b9zlvYsmpg4841v6+P
	JqveweZoj/gU0P5U/qEWDuyzQInqH255QYpCmQ+CkPbjDF/lpUebYjpdVz9F1QBb
	dYJou265reFHggMb9TpKUyuiwbas6zYbtffVIoLTg/7KWhFdTx9kSHFu8F+qfv7H
	yPbVMsbCCq6p8aCBw9Laolb0rvpGmiUZn33zRtm/0hOq8kscBcVUJGsk+FlkhEjs
	iAnU0JHR3fQw+aqCZiRCz8x/lL9yiHR92F+J76aoM3a0FMHjMx0o6SRQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7fu5dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 09:03:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45E7J7MF012563;
	Fri, 14 Jun 2024 09:03:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ynca280y0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 09:03:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMYFXFBuUO2UZr2Zias6p/r4Ke1NOxlzaUz7lLvGeWGDav6AsOOCdIbtkzyLotxk6EIayUkYx1KSultpVtJnfuufHU6BLvAkrPeJcJ2X5u4YL6rlrEp5S1mabLXVKeF6oD7Fh0ir90ApDRK0vbdSsOG4Xqrvl8OLUPhItbg8kE9XWhI9M/1CnN/ZX7KcuhUBp2euYLeoxLI08zq0eBnO44P0wnSM8f5Ys/kghf4ba1FFYySL9+qvXyG47UNWFx8vu6guKloSbFJw2fDSwtvLOLq6s9CCc0pl8xm6FyRhvhkuzt4suWj6xpGG8iwM0lzJFWHz4NpqaPUPmuGC1UwX2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZWS+T3JIzmCtOohowESbWiFCr+0lsYGwX80cqz0Cd4=;
 b=Y2k1rvKHGx/lFjmKntr8DuOCwJ8bvRtF4ljb+f7GEiU4VWPjfZr+TZ/4KYpK9u84x9glUt4goqI2XjJjDYzHO9Sp0a2P6Do2tAi1agIovDSXSjTS5mXbuXTOXkDapR/djKUNM5CqXI980TWIyVLRPYWMteLzIPNWRjbYuiZ2tUWCUkqA+aL4p7CC7xFXpLdpA7d6phWjHTjIXQfK3hDkUuVICejx3MvsOvuotxaqOrweNTtGX3L/RJ1WZtWGHbHQZjB6zIr+1aJSTr3D14wh/qbttxNifrr5KmUoXWrDpflfT8btb6KV/HXfjKcYm8M6FpkXih3foN2tGOBwrEDzsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZWS+T3JIzmCtOohowESbWiFCr+0lsYGwX80cqz0Cd4=;
 b=O5KGG5CzZE7dSwoX4K0UgzElOUJs2bYjnB/G7qMJux7FUEzMf0CpPX6dnMAB388ynh90veRbc4AE2dq1zXnAMVy6RYdU+TeNif5IE1kQzLqgHcCRl2zN/YZHogl6AWmtCmUQbf9RIVHPSfVqxZ/jZf/J8jz1OH9PQEmkT3u+vto=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by LV3PR10MB8105.namprd10.prod.outlook.com (2603:10b6:408:28d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Fri, 14 Jun
 2024 09:03:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 09:03:55 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, paolo.valente@unimore.it
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiapeng.chong@linux.alibaba.com, hch@lst.de,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 0/3] Some block sparse fixes
Date: Fri, 14 Jun 2024 09:03:42 +0000
Message-Id: <20240614090345.655716-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0038.namprd11.prod.outlook.com
 (2603:10b6:a03:80::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|LV3PR10MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a2d8c7-7f1c-4a7a-fa2a-08dc8c50eb37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pZpAYuToZGwlpcgr/HAjIgOvykMzU8ZjkQQ0x6gR51irkArXLw0xp+i0/Scd?=
 =?us-ascii?Q?hmg/qY5erzQlE07tEN5yPtlISRbjS23oBtDy9cH5FRy2AVafKxEbR/XDVcrV?=
 =?us-ascii?Q?n7hSJS2zfe9AhR1B5RT9qwrnn+e2eBt8swzVcQloqC8qld10R1rubhLqdOok?=
 =?us-ascii?Q?ljRSg0yTHyRl+6y6UVWbIXTgtIFnxW7SiXa98fFiJjp0vMJegZTZGeid6FBV?=
 =?us-ascii?Q?naHtSLrEkBxXR8Les6CYEWTNx1a5HJKmKHlIQ7Wy66pCxepr/zmi2yR3mE70?=
 =?us-ascii?Q?5N0EHrXbIEwskuncbh3JuZpINgPNAugmD2Es98vHJGtqgfVno9/eKy5QXQUl?=
 =?us-ascii?Q?Nood+yY6y8EEElrANySY0q0Huwrt5wHV0LFxGBcTjcGRxiLvjq+9HGQYmJiW?=
 =?us-ascii?Q?XxdD7VP1Um2kZpqrl70vpBsfITy3OXv05likWnEe8SFHamcpuZAx1Swae+Xl?=
 =?us-ascii?Q?MsDQ/sEcZscSCR4Epb1tVxW5w+OyLUwRzECVZcw+yhEM/Sy8VnVZZ5JkRAXH?=
 =?us-ascii?Q?4zhFSPToa7Ml5upxUVlAfS8q0AHBLASQm/LMTCqc2l1yefWPlCLI9IAh+DwP?=
 =?us-ascii?Q?FaK01ZcJoS5rQ9qsk+sQhYH6+wfVLNxkuwf2kr0Pcr8GEFHh3Lf1mmyCZjmt?=
 =?us-ascii?Q?y89T+MLk1CywJ4s3XFvEQNyTaWhz10fS9RI6Wax6pkupHYAKr9yntygVg9tH?=
 =?us-ascii?Q?9EkJbDeAhhai32tTVOMswjgoe0HCj+MENQZM6N0CcIUYp+weStYfVBbG37UN?=
 =?us-ascii?Q?kKi5lGGAA/cY/362zi9sImXzxqqrduk8/oxNMx+hKJoWlAVGxqx8+k+/O0fJ?=
 =?us-ascii?Q?obluZonjOp5/fvAqOc3m7TCE2TZKV7o+cl7Y16r1RG2xUiZu+mshkF+c6rg4?=
 =?us-ascii?Q?mEgKVDA2EFMpavKzjwMu/XwGRb4pVfI5YW62sQ2HYcYSczWaP/4CdR6IY2zJ?=
 =?us-ascii?Q?GthXv4rb96iV1DWmf41DkAdXnBY3BKhEdAIXksKE06yHV20dANju663hIMSH?=
 =?us-ascii?Q?EYQPOeB0OrtVbQnGjTWorY3qEl4LxNGKHRpF6euiumJTWqC88hzOLK98uf6V?=
 =?us-ascii?Q?o80PAqVnpzMeyt8CIa06StN7qVsVuWQJMuzw8GleT0tR+6w+gb+Q8hCq2Pw6?=
 =?us-ascii?Q?j9etkUmvudkiLf285ZOw8VAzk88PXM6oCddyMNb84dwfEsrhDnVitRApZLrY?=
 =?us-ascii?Q?3wRt/Hc8g1Cecfq1TO1Q21rkn1aUBNVb1bx4NE68C6GPnSXwjWc5ff/G6OR4?=
 =?us-ascii?Q?Yy/xGfxnQ62/jq6x2usSvRUDV9TyS4tILa025wviUDM1BT3hiOnFTzPSk3JG?=
 =?us-ascii?Q?JkMFQz6VfCNnxcvixGkuhMB1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uJc3LM6ntn0aXSOsliGkvau0jdMJ7g9zgTYxvBtRItJk0kauG+TBwzgqdrAJ?=
 =?us-ascii?Q?7ZKUnp6ohBtd/eNybkTbOEmtXO48J0O9hRjDNE5Ru/PLRefaTUw8V8GLxMdR?=
 =?us-ascii?Q?hT79j80KEyVP+BnAiHj/XZ++kpC4vT3S9s9V72eX64f81Mbb9G3ldJ1b+FnI?=
 =?us-ascii?Q?mXg5wLR80qfNXkV3aijT69yaW5qgsMlvJGiItZlSySvVCWEWxxxTKampQjIW?=
 =?us-ascii?Q?dHnTMywdczHx5/CwvaUIj4u+hA/I6RW8j8tCtJWLQuHp+eeLLX9H1B8QLmcU?=
 =?us-ascii?Q?0CFua0ycFy2qsbYoLR5a9Dntrd6CLHEVZt3vvK+R9fCySjPeOasJ31i+y05d?=
 =?us-ascii?Q?j53u7qVxKTkz9e1PoPivBBzjFGuWscBZBpUyPhpDgljP5uWMYbaFuxjMhcyc?=
 =?us-ascii?Q?iebRhqWtp9xDNTFhMVEcdO2Fp4an3GjHT9CL/E1skviBm/yfYDJBTe+UK971?=
 =?us-ascii?Q?ltJIJyzKWxD4D/o6dKPyEbfI0fS78z+4BalcYPofIQmANcVLKkntefglhnO4?=
 =?us-ascii?Q?iHyn8BuU/nvwYHYOxIUVokNLpfXVyWn4EMUBmI60YszcYXy7OLGuOa2XmeYE?=
 =?us-ascii?Q?VTI25J5XDCMdkCuHc545Trt9IQKzEEw2/AyG6IKFH6lFCzicadxeKy4bHJHG?=
 =?us-ascii?Q?VwxEARk1QLJObBWOIpLJiN8z4kAGJ426AAxkzJjM912dEHLTYkD2Qkm+2vpP?=
 =?us-ascii?Q?QF9CK58Hclad0ubgNw5xOUxphaKgL2s9dnx3blXFdoh3TRQTg+mdCoE1YfgA?=
 =?us-ascii?Q?G3iUaPbiQZTBlnFnzmziwCsO97ShaMwmwCUzjKqkFTPXT5KfV0PVbYlwWgwJ?=
 =?us-ascii?Q?4svkjhZqXO0vQrvPyMxZ6M2llTxnEMJgf+X3DZyjPrpcvt/xlY0tZR0jvW5Y?=
 =?us-ascii?Q?eUHGiT0NYjV3UotK5X7QcHXyyHTfLXTX46cPoFxD88FnU3Fuwe4YYmGDlH/S?=
 =?us-ascii?Q?lhykw3SlcmX2eLHBEf8SOvAy1DhiAc/VQ8IsUFfZayUnhXC4YgC0ynd/PHqK?=
 =?us-ascii?Q?2meaoVh1d8KIA8221S6L/6jZwaKCQUqd/oHyyT3CQ4C8Xwm7ZD2TMVhtJJ1I?=
 =?us-ascii?Q?9qIHGPdfPVBrJhZeN7LML62tV1kAZdb1KNEO4xWGkGhnKbWnxkg5gEvaWUw0?=
 =?us-ascii?Q?+cBBVCuI7pQm/KIXmeZ8WCavo4Y5+rtOBqPKuE+h1yzfZdzBYJvbuA3tdP0x?=
 =?us-ascii?Q?5ieJ43N1vxj1nOmRccJaeJiUeiTBOQSRIJvtPz03wNr7ye5WRCKeDklYjb6g?=
 =?us-ascii?Q?8Gg0LhUQEFqCrs8C7xOTJuFLyhFF4k1AP0Y4hzrz9TBsUHpF/by3Ymb6ymX5?=
 =?us-ascii?Q?ARYq9dLmQbUuMwE3U/nKJFde0+oujDi34z0ENpNa1t2QAipjFMlf22FOpyov?=
 =?us-ascii?Q?wv4rgXszP/G4UVEEwmo8E7rO2SeqpHktWk+6rFWLmxbZBOUnbGlELddY7QJA?=
 =?us-ascii?Q?CDRX1WBKGDMfGjUzo604Rqct9N9X36h+HqnAgZ3b1IZAL1MldsW6D1IrcTTw?=
 =?us-ascii?Q?1OAA8ESbgREbpSrkkRgz+3EfMVemMCiTuO/OHw43tPfPtTDhAS0JBwpU4XPe?=
 =?us-ascii?Q?USXr44BrOVpvkfagpJ2mss66HP5T4h2dIzArBUyYIGJqUYcNe0ccklk7q0AO?=
 =?us-ascii?Q?0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OtP4+7hJrvlSXmq41Bck2xopqdANsNf1kou94xOkUX4umfD7yfeTYLo8Y9CB3NDj5ahG4Df4HFw34v5NrlkRyFiKr/CWHkyJRSFiWhSvdtxNV2RGCrAwHA8lZ2LjIG8EThpOZ1j0lSD0X79H041d8gQra5C8tD/qWVF1ahCta8LEl+7ZbJYohzPzjA1p1pMl2Fyf1mOKSscDYpkDuco+BIQ/LrV3NIKhkCxGxarGqNkwId/bLZhpHL2+SV9EvzsPgIXlM4uKdL6wih3DA0L9XlQpMgukFTqm/IAIPlJjdcQK4srr9QxkoGcVoEiYsf49P6uqP5gIirXPvZLbPVWEGrhMgiQmgy7exaQBIkmPNf4BulVU4OQ2quAkdsShUp824DHP7ihFkSQpOjyjnuhnfkHU7ouRM+jbcptn5KTJyOftRy5r3xEDI7IrxI2qJ4frbx4I8JlRLCLKL0EP21kY3q/fYRbNgmkhlLtd5uI10xmPCi2oRgp1rFuUN/UnFiNZLtyfmzFejWVTleJBz42u0f2d36m2JSJvrZbFluUfwEfuf/ZpK+922krjgbCdhxyFR+0xWQcyXFETsJxKlJYObRx3wfhV43cMAb23tM0dMT8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a2d8c7-7f1c-4a7a-fa2a-08dc8c50eb37
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 09:03:55.2551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqpLuK2wutBS+R0ZuXrKcRvlJW6H/Xu05NjjdInXxqYMvxLZ+eHILHRqINRci0FStPAzP+/bNjhJUfTk0YrHkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=806 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406140061
X-Proofpoint-GUID: gQhU8tHiCAgloQITOn_AFb7Ge3LopG5-
X-Proofpoint-ORIG-GUID: gQhU8tHiCAgloQITOn_AFb7Ge3LopG5-

Branches for-6.11/block and block-6.10 both have the following sparse
build issues:

block/bdev.c:388:17: warning: symbol 'blockdev_mnt' was not declared.
Should it be static?
block/blk-settings.c:266:9: warning: context imbalance in
'queue_limits_commit_update' - wrong count at exit
block/blk-cgroup.c:834:5: warning: context imbalance in
'blkg_conf_prep' - wrong count at exit
block/blk-cgroup.c:965:9: warning: context imbalance in
'blkg_conf_exit' - wrong count at exit
block/blk-iocost.c:732:9: warning: context imbalance in 'iocg_lock' -
wrong count at exit
block/blk-iocost.c:743:28: warning: context imbalance in 'iocg_unlock'
- unexpected unlock
block/blk-zoned.c:595:30: warning: context imbalance in
'disk_get_and_lock_zone_wplug' - wrong count at exit
block/blk-zoned.c: note: in included file (through include/linux/blkdev.h):
./include/linux/bio.h:592:9: warning: context imbalance in
'blk_zone_wplug_handle_write' - unexpected unlock
block/blk-zoned.c:1747:31: warning: context imbalance in
'blk_revalidate_seq_zone' - unexpected unlock
block/bfq-iosched.c:5498:9: warning: context imbalance in
'bfq_exit_icq' - different lock contexts for basic block

This series contains changes to resolve some of those issues. Some issues
are not addressed, as follows:
- for zoned stuff, as mentioned by Damien at [0], they are not worth
  solving
- for blk-iocost.c issues, at [1] Tejun says that lockdep does a better
  job (than sparse)
- for blk-cgroup.c issues, at [2] again Tejun says that lockdep does a
  better job

I am reposting the patch from Jiapeng Chong, as it was never picked up.

[0] https://lore.kernel.org/linux-block/5e04760e-1334-4514-b2d0-be0d7df33865@kernel.org/
[1] https://lore.kernel.org/linux-block/ZmtwqDsMnTJHQB6o@slm.duckdns.org/
[2] https://lore.kernel.org/lkml/Y7x9t+4EwXFl7OwS@slm.duckdns.org/

Jiapeng Chong (1):
  bdev: make blockdev_mnt static

John Garry (2):
  block: Drop locking annotation for limits_lock
  block: BFQ: Refactor bfq_exit_icq() to silence sparse warning

 block/bdev.c           |  2 +-
 block/bfq-iosched.c    | 38 ++++++++++++++++++++------------------
 block/blk-settings.c   |  1 -
 include/linux/blkdev.h |  1 -
 4 files changed, 21 insertions(+), 21 deletions(-)

-- 
2.31.1

