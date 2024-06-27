Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621021BF24
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 03:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719459879; cv=fail; b=fIV2zNUDTB87f1zamUo4TmvIDgEmFWnJGSMP1ChVGT/yuUyvI66UElDr+Zn1kLR5lTCNIIjciDhDAS22K4PasMbZGhPkR9xNMqWS8k8o0+En7WsfCjS0Gm38jz6IfpyOGeMo9cZJmWa+57Xutw2z1yxoDqMzGOQsz9W6xp8dQx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719459879; c=relaxed/simple;
	bh=8KHPiIiyTx27LgjrEYTKZdOmn1YukdadzSILA2LfPX4=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=t0HmwtZ6MuozumTUDdEDDw06JQ0dIBHEW7q/lE4ZC61fbMiA39TwXYMU/HiHJD86RsEbVxkIEnxqBjLBkR9eJzhaEl2TvXxYfV2isuUAxX1QwnFlkp7ww2KoADry/VtyGadtve36nw1+D7nDWQfCZQYoHuznsmaAqHzum1eOD/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=boDceP3P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F5srrRPj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="boDceP3P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F5srrRPj"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QLMTeM007265;
	Thu, 27 Jun 2024 03:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=waI99BIUe1mm2/
	KQ6lwwEERKAer0fmt6gfffNPPZL+Y=; b=boDceP3PZwWYlVXji50+YGa/eMpJ36
	LHf8rp7vvpW2QXE0rBPXb+vnmu/VrFuEoBQq7tZsea/NBwnH7mlqNutacPGqHKEp
	7O29wagx1WW+U2LYvT0HQzDxURlDzigGfC6YWQ+UcifspIbDH1sZ0TVBaqisNwlb
	CFNfFCyZwI3Zd1Zjgn4sujQzazdjnXBMNfNeviG11hUyCOTocf6xhNyTUECh52u0
	6doyv1hMVAfScVv4w7jgOtcpAzcdTO6eoinyxwnX3NfvewtRyLeIm+OSk/8pyu1x
	TWBwWs/HLnKqondSFCxCT3rKxVv+seT5rNseTp8ruRi2rQpHvoIbnSqQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7smthm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 03:44:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45R0VMPZ023445;
	Thu, 27 Jun 2024 03:44:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2gbwsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 03:44:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROqQZ5zKh/vfVBm2PyIFlLJE0ebwNmhxnnMkVrs56zQySDd4sO3+MtaQVIiU5knt+IhfTpQogH6bxP+XRNluc7THCbJDsTCtCXq1Y1LOc1cmi4oJhKl85otarRYcPSp4wlis/MQ81JNVIpApBNSXpFhLP5vLpmgSUJQh5ODcGRbTsRl/QsWBAgRJ7a8yaXBWf/21JvNLYLjMwrZL4zs0ul+a0jO9Fx9W3A9cd4YPXTXv56Et3a1ZZaz3GDwgAvOx7KBuueBrSx6E9ujzkAxKQY6QdphObMXUPWHJPy39hYWRtCSJfTmE4UpgOHKVyj7Ebi7HJ9hQhsNKT+b17DKH2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=waI99BIUe1mm2/KQ6lwwEERKAer0fmt6gfffNPPZL+Y=;
 b=HVlAOn8+85fftVz0pUUUp0RdUuojwvKCLhiCFo3NUWeZOzt525dqoqlEgPNZ8+jfT0A1vFWRikuQ18cH8KNf1I0KmRDD6S3GZUx+FRueLAA1848hR0OMnwAYi4f7EhkOrJ71Mt2fk3713mTvu9QbcdZ0+RET8jHfhP9nkuvDfM4ZdMVCC/npnFrtWmdsxZPRRA+zbPEjKTLKeF7/88RJgBMqF47AL1+yloQj6HBCICAst/9FlNnNE49+WY7PXOOyZGXb4/IPn2/yz+1j0HNUgEO1q08AXDUeG+34z4BYF5qYuIph8TQ7Q61j4jTXBEkJhbcUu3KO30E/EgDBxomfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=waI99BIUe1mm2/KQ6lwwEERKAer0fmt6gfffNPPZL+Y=;
 b=F5srrRPjS82PknbxxAKdslt0xLm7NBrbBriIsSlB/hrISJIpOLbm8PrR8t3gPYLKUo4FT14++5uFJxy/BWiBje4FK20cfv8lP/oXeFQzDPI/D209yy6vPqnQVpFHE4yggQA3yTOpIVrMfZwvCFPDc6Ny3pwZmTNw51W+YABg/ZQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ2PR10MB7670.namprd10.prod.outlook.com (2603:10b6:a03:53b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 03:44:30 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 03:44:30 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen"
 <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org
Subject: Re: integrity cleanups
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240626045950.189758-1-hch@lst.de> (Christoph Hellwig's message
	of "Wed, 26 Jun 2024 06:59:33 +0200")
Organization: Oracle Corporation
Message-ID: <yq1h6dff3sq.fsf@ca-mkp.ca.oracle.com>
References: <20240626045950.189758-1-hch@lst.de>
Date: Wed, 26 Jun 2024 23:44:27 -0400
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:208:a8::36) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ2PR10MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 94698094-6870-4906-e2da-08dc965b735b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KXtpej6w4h7//bQzgifiyG1tzrqJlbHyvbAl+zQK4H6bpW5Whv4FT/sLZia3?=
 =?us-ascii?Q?YDatmzCD0nkdE8kWzm9zEG/LayiTnO1VcX5yP9G7yf84Z8LZZJW7ijQ6PmL/?=
 =?us-ascii?Q?3jImP5XewmxOcYEn8Y/+sBX4EDx5BJFEE8vBzJfu1r5EHViXooHgJRkgpCJC?=
 =?us-ascii?Q?L5mQBc+BtFUes5KgawhlYifVgpZmAnsyEDScPz/px5MZUWDkCGh/9Ry6ISJM?=
 =?us-ascii?Q?vA7d7yDpPW3ArWtiZDiwXrSpRf7bzeRqI0Zo+iMfVnuBnzJ2wODlbJr11fYB?=
 =?us-ascii?Q?fMu3RCgXwrUBAe5vLXGRVd/AZASosZNDmvifxwBvToGZn1b6bKlvhYAe/TQ0?=
 =?us-ascii?Q?G4AM4ECnqo7GYNOQ3PJidInhlXlqw7YsWOtN++BY+SiLyecaBbigmiYU61Q3?=
 =?us-ascii?Q?raK2H7QjwijWxK4i92f0ZlkPfDFg2yx5XmgT0czxNISba7LXbZGwp+Ep7Q+/?=
 =?us-ascii?Q?4xjb5UggpAPTjlxK3qctXogIOHjjg4ZKWQxyXauyAyzKx33GeDaCxm/ZgCwx?=
 =?us-ascii?Q?6RDFaZET8MtcH43lDz1HeM+BmW6CV3dF1mR2TT3nFKTSa/IZa/z2eNun/2hu?=
 =?us-ascii?Q?cL8BNqR/JbILA13MBJoSqVxOZg29q/cEJUN65DRWQk4ZPPKc/12nE1X6jN/I?=
 =?us-ascii?Q?hbAJCF0O1NttIefx/F81k/34X3ZyCW43FtUPjIQrixywuzCf1B2XgD0phCL2?=
 =?us-ascii?Q?B2JA2NGvjwVyufXtidtRtfPTqHDHw2izR4erQqIL1DoJNN6Q8HMvS48gZ1LE?=
 =?us-ascii?Q?ubBTDDJAUJcqPJDaDv3xzzFuWXUtru4F0QqmhA8MQ/ISSh8QhchR5UojuJqd?=
 =?us-ascii?Q?aq7z9MCMOw7oGqFXMWwqQEiMDUwne5vx6Tcv/BxLGZRbnX4A0rt2mX1cojaw?=
 =?us-ascii?Q?vU9dWDY7x6H5NkGxlJPhi16lnDIEevBomhsdNr2Ql+tr65JnrK559udQ/GOA?=
 =?us-ascii?Q?p31pVz1680GMNN8YVigl5iXng4K9S9ZYfljOYAdSmx8h3L4rAXeCip+Rnz7k?=
 =?us-ascii?Q?Clcm+v04hIkaOy9+PodwbsxixUsBPm6b64P4UeRquWGEhdG0XbBR41XJn4cq?=
 =?us-ascii?Q?IDmhXkovgTC1j+kaCHid3SpSI7do3MemhDHC/ivkHSvtDO2lC1Om9ARpgnhj?=
 =?us-ascii?Q?G72dhel7RxHlKksm82p6Y/o1d9sbsE34j9oP93nidEu+ZYIS6Y845ZeLtJNU?=
 =?us-ascii?Q?3NJgYy6ZZX4a154kV/KbU49yfWzeOwe8MdKXAYiQxotjCIr972/+dC6bJVV/?=
 =?us-ascii?Q?rsMzyLnnYLo9W1hZrvViFKEqxvusNzo9A+MuJ0CnUl/FxETtUlBseeTOqocw?=
 =?us-ascii?Q?40uZb59Nx5zWZnIlWS1STkLZ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1NX24slfyA/GpVfkHOsnOHB7c9PtVJuCobhW4/mvAwO7EA9Ikn8m//2Mry7k?=
 =?us-ascii?Q?GzeyHSL6SltBp/ysKyePFlJ2zoefkMRxetDPBUxUp4IYRo0Q77eQhlGgBY/+?=
 =?us-ascii?Q?1TKMm4m57nEvBWrAf19wnUB8VaE9rIolcm8XZS+XGG59GP0HuYo1u8/TEEOs?=
 =?us-ascii?Q?Zu6lCJaZvMqjiL5NDSkiGLfbiw4mXg2lyGPYxN9JxHJv6kcGsmoQ8moNyRgR?=
 =?us-ascii?Q?HQQGlEuJacBE61A/mJEWENOwp9MeTQfc9ijKQWqf27xcl3670OchwEjYmoi+?=
 =?us-ascii?Q?yO0wszd3KwKPRJ5SLTZ9HYAjGeuUSlnqH3vghKRka4AWKSGpmcog5IiEMmz/?=
 =?us-ascii?Q?4wAQN+S7dWoHwiLv+9AXvJYzFKORboE09dYLbkg75Qk3ByYik79YMqi3dMkG?=
 =?us-ascii?Q?1SiDz5kXl4I9CSTUQlylwdPDtpMI7xtcVMd2RcQMguAa6ORt9WSQ3Qvtvptc?=
 =?us-ascii?Q?yAVUHOqKKbgycks7e5VouMsuRHnAfBMioaOWzzVlbcPhwZz60gBQ5Ve8pqUo?=
 =?us-ascii?Q?O8XuH0pn05DqWSjbuiSVevhUDkeSddEqY+cvRVzwLn+i0YMrzklNpc3vYDf3?=
 =?us-ascii?Q?DphSJmvIMgk0FGru3mJCGoCqNxxtQlCkF8QPA+um7US3jPaRO65kz/FGCpl6?=
 =?us-ascii?Q?qoJdW7rcR059Vbf+2myj2IYB86Ia/N/oCFSmeCGOv7fdmjd8V0cJcFY3ut/s?=
 =?us-ascii?Q?1okg1XlBNfQwg/ST64QGhvWs50Jnv2ngwAeQAcOW/0ukhiHYRCAjN5k/74ru?=
 =?us-ascii?Q?f3AfBONMPAEHQKSJnhgaJoFPdYoQsURY8yVldIkuvfBc73iGQxgE8Lyt1AYD?=
 =?us-ascii?Q?IBRPOsyOnXU0rS0X4IstMetaZm8UfB4zWCGQ8/9O7ULAjwEbYuLMaJ7nO+PF?=
 =?us-ascii?Q?ByyU3SCKcxR+ygZhFM7nYFzGK0odLpPjpB2kLnNJ4yPyGVH2oLeqsIghGaY9?=
 =?us-ascii?Q?QxUjYYVm2usnXnHPI8XtnqfYhs+Rczji1U3eFbrQW4VUHiD0iKYB/s6+Xwnx?=
 =?us-ascii?Q?R5uIjbo7KdG2T2afPNQATnqAOeUO/9efl+HbOQpwrrcfDn6HdY77OafpfwMU?=
 =?us-ascii?Q?L0EUJMoyDc5nQa2ZufTfzBpzOpsYyg0D9/zpSIbEom5g9vByGhnGzK2W/Dq9?=
 =?us-ascii?Q?bnYqxkvJpoFe/4yP41IVKcx7oDjlpwLyZfOeL5lOdolQBlU94Ft44Puq3/zb?=
 =?us-ascii?Q?vXi0KLWHMA1KHoPjnL8ecv59EeSipSyJ+sDl8vHw4fqVNSn4adSposrRpBiW?=
 =?us-ascii?Q?DlcHeNc4JDoZlbxDtnqVqkhTsJYnpTWyh1wZHnF6mlnrHYjbjHvZuOG3lILb?=
 =?us-ascii?Q?f0RfhDFV3Go8wdFkS6cwOCUBHNMK+bQwBcrYjIs5fNW83tHhBw9+iI05bDEK?=
 =?us-ascii?Q?Zpl6mJSrquOUR3uXa1M6UXkhajUjWhNsHW7Z7PPvIo18L6EHxXVc+IpTXQnO?=
 =?us-ascii?Q?vRqo3a2j/cuH6qbtRQ/kFyhrCMhI5/3msY62xJg8XKqi/zTzov3HkZns5w9L?=
 =?us-ascii?Q?eeGviBH5cA5kFSkoDb5z+8RD5EUP+M870vuW9jFK1kSo/bqfm2ykH8KwX+5E?=
 =?us-ascii?Q?/SyIR3BXPvKO3BJGA0PCdQArz1xkvCg5YLwF/WjFJ3WmXX4xw6nNEtDvstzx?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GXCrI4gv2uNBeJNkQEZbSeQEq5U6YM/baWxa37ZDk/I0cGcT2JvhnVCx1rmR5zyi6DETdyDWN1SMngLenv0+F/lusBO5cjCkccIao5aki7D8NEsYLL2GOn3A5f6D3Uq1eFGT7AvK+Mx7z9moVpr118SL3BZq/8kPB64cJqGlYSLexjLTUVZ+ir8BMQhQK/hI4U+E2q+FR5jES7cLL406kB+sXJzUEJmvoPJ2E9+tZ0yEhq/bAfD9K2I8OxMKdgKgdyEDGd5OYoA5LYG+QyyQrmu8Stcpq6KD9dIGiJvnbuLCBdn5CjekPCFW1UnurOGP56On0scaFxtdjsHTIZuJZM3ayKFeOYzk2wxc82fiD+9gMh8v99+ikNKncbQ/uMvDnFkTxIpB+9uZluucjcfg6lkyLGpuvuxWrbFqqM0DP3LgR9G2qOQtKkMjsA7//JF1+5mhYb9MeJii7aouUoLns4g8+Dw9JLhwcMrD5Gzs5/U2oD9DM3MpGWm5DliYl02aCAyjL793qqzbK5s9VjSMxZ142M9yS5KPvFRye6VWMf+EqHzznPXhMsprX+vEp5s3AJu+W1kgMT/2hDJgmelGFBMNbtwgdmQQXypcv4BF83o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94698094-6870-4906-e2da-08dc965b735b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 03:44:30.2235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5K57d6QBx3bOAMSHE19oPduJQX2bSqwVOuG7q/Rl5PbeqNZPhfWiMGZgTOKz/tQOc75hJA+RWCUo5de9taw+8YGo4fytyYx7w6djmR2xM/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_17,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=826
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270026
X-Proofpoint-GUID: 2tghqskcrkiiOaUJl7hs29s7Y65v_cO-
X-Proofpoint-ORIG-GUID: 2tghqskcrkiiOaUJl7hs29s7Y65v_cO-


Christoph,

> this series has a few cleanups to the block layer PI generation and
> verification code.

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
