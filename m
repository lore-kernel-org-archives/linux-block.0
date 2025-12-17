Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699B7345CB1;
	Wed, 17 Dec 2025 14:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765980766; cv=fail; b=uy++JwTBSC4eip7zm+W6IpZ1TPfbeGoTsifbymhHNM8y4f9ardsg+m3ypj9BOOuviuqSYB4cpAs3lG3RXwYalB8saHX/VuABzC8xyMdw1l+5+YwDzfWsjW/DiJhd0bQkN18nISfz1pw8FeOrC+IGVjR6VDKnu9yD1SYO9lJzcec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765980766; c=relaxed/simple;
	bh=WiAgU0qkcVWX5i3CifiCv7Lvo/UZUGyIuyzpuohT/1A=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=TvaFmldNK30BBbyvnyJWniLr/CGxijUChgrpgHqkQm8AeP4KfLlFExzv3OqFa76/2oWDzIhlukNIi0YDjNCHoZLOabVwm221sTIzp2dbF3ALZN9ltSQliC+dug6mHeSUy/rG/MkhE0JocYuNP+C/6w2BqWdYJaMFrb+J3za+GW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YUUd2/kR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YwL75nwU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YUUd2/kR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YwL75nwU"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH6Q4Ps2144500;
	Wed, 17 Dec 2025 14:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=kn2PWIPZk91omt+LYn
	uf8OeTCyzwRENrHyegTanNcN8=; b=YUUd2/kRTCoAeSmRHSZbFcPhCeYFuZAdPH
	vPwknhfeNc5dCpUEfEYxRFGzlxFrmHzGBuKpWN/8yFeLKyBifsoRRKcA0j7OJ0/c
	rpesAac3thDlTBR80HuSBaLiBpa0IkG1jlhd4ejQ5vprVNIH1qRTASLqvKFAxUfg
	wPZSsOLJFwlr1KmwEt4QmZ2EEe06ATKmefeYDR6YoqtyQufriZpzwpJwngSB02dd
	0GCHHjsnxRqtzqEZK0jEcrfGMHsJnZXvSY8EWIY3tvmTFGif4FPNGWonz421HDd5
	6JiH3o7uaruloQzYDbhfwAazFMhmFDhXOdKpXJ4XUN1jGNu4q9Fw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0y28dyph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 14:12:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHDUYZO016413;
	Wed, 17 Dec 2025 14:12:30 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkn3v2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 14:12:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tT4LIEO2IudcEOs39JGFXuh1hnP0dKX5+eCHenkn+MWIl1+X1UuAzNIpNYT7KrTHio+/gEj2Avbw+Z/8jLG7bTPZCoRhv/mfY8uf4zDu4M31e4zwvyoCGn7LlRhbpe1VMpt98sdcmIIPn2KWuhxevbjmZBR+o1EI3gNKAULecZSdbhUfGS/CxozLnlgf5lp0re7cR1a9Ko30Dp+6EopdsiNDrnOxU77VZz1Imaeumiv8z7RSkTcJPfk0Y2S+UcCl1HuZFcDIXG4KuL2AuZYwsA9DYKng1t3A//crskit2FTpnLmlzGD/2Jl4pHNZX1Dh5XIe9VVoEpLF7hckStz1MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kn2PWIPZk91omt+LYnuf8OeTCyzwRENrHyegTanNcN8=;
 b=ewSkhIE2ahRcXk7TOkaczO2DvOrh1wrE0yvpSZ1sZUjzjd6hLGnT0xaqaz9VsvbK2ddsFncbRlQ47xkRC0D6hC1RWZ+mHTZ2k/jdDjM+V48rHEgN49GAh8ERhloepneMAZVrN2LjE/mm16B5p3GRblpN9cGaSowUQK5Ib89YrO1x1i6uXDiCfGjxnPP/XWBhOK9P9n5aTIVBlTNa88zfmeIaBtNJvr/ulA85tOW2KVhjKxJhKARXr87EIVdiIwTRNto2fe9xqx+1s+UgUMWalHPiCP1I1SpzjTeSYm5whPLrEkZEQAhEN4H8TGfj/ZxMQL0RAQCLgzRW7o2PfYfYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kn2PWIPZk91omt+LYnuf8OeTCyzwRENrHyegTanNcN8=;
 b=YwL75nwUwbsqfqnbLqVQdFRh0UihD/+mSzpUwG/hGvsBYTaRfRFJaEJQs3XWSTzLtgSjil6l5rGlcZe3IUaidgS1Bej637UXro9Ch8EBYhj0ErFQ5kRDgJt9pSTJdlVRSY3nibAhGQWMNlSrJTTLN1/Xaabwrss7uAU3vFXjr8o=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MW4PR10MB6419.namprd10.prod.outlook.com (2603:10b6:303:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 14:12:26 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 14:12:25 +0000
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, stefanha@redhat.com,
        hare@suse.de, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
Subject: Re: [PATCH v3] block: add allocation size check in
 blkdev_pr_read_keys()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251217014712.35771-1-kartikey406@gmail.com> (Deepanshu
	Kartikey's message of "Wed, 17 Dec 2025 07:17:12 +0530")
Organization: Oracle Corporation
Message-ID: <yq1ike542t5.fsf@ca-mkp.ca.oracle.com>
References: <20251217014712.35771-1-kartikey406@gmail.com>
Date: Wed, 17 Dec 2025 09:12:23 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0302.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::17) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MW4PR10MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 456f448a-f922-436d-e8ac-08de3d764de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?plxuUN0zgJX7exmr5XMpVnt0/yaw+v1kUA6jx7oBPMX7GEgmK5vh1Qas25+9?=
 =?us-ascii?Q?+DPSqulUIBSEbUUeuGCyc8qU9CFVdiK5wrgv5P3+8aHvbDR/ODzRDwTyMVql?=
 =?us-ascii?Q?EqsABemcGhffSsYYDJmJUIg/vei2QiPkVdVkhmqclsbXli9kXQhRflnXzLMq?=
 =?us-ascii?Q?PVPbcVUPyBszoL1Idf1s/qLSLTwrxuA41/+TRfJUYHYZRr97/2Qt3Bzd3Hpm?=
 =?us-ascii?Q?DDLoYoIseGCAjh+pd6mmt/SXUZRyqjqf/305N5w0oCLM/pteDJlkzZVEHOcd?=
 =?us-ascii?Q?QyUNW2RVLGIHRYMaq4GUbahtz05+WlkiMIbtnHHYFH63wnqxv2ZVjdXusadJ?=
 =?us-ascii?Q?BgPdG457UbjBCCVXlcKtQwKf4xplale4yJV/GcbLQfAPzsbxThU6XSIyFum4?=
 =?us-ascii?Q?MANjLqsAwMR9+D+0pYuf9dUlhp+mC82NdZOaS+m+YfYJIITTc/OCv6NPF/ry?=
 =?us-ascii?Q?g1eGhisIVrzEnaxoRLrId6Uaz7R8ZZM4TwfLyawj5V9mqofuUVu6GW6DQPMY?=
 =?us-ascii?Q?H9s8kBgjz0PS6o2ouscHa4jUOK6LN8R7yxMXrD7VFXjaPr4hV1NcIT54X5bl?=
 =?us-ascii?Q?8FQN7DrO/uQvXxi/xASMQZiaw+arGpuOFbwJLvkBrlmgnbdVNXW5cjmR2aiZ?=
 =?us-ascii?Q?TcA0YRfK7Spzsi8XVgvN8j85obeVqSkvh3BFGeZMRRcGmM6Et0WIFjMLui9X?=
 =?us-ascii?Q?93qKpVQGQtcElMf+7B2yiMEZA0++1fzkWlRlTswJOKhahk6DoX2MxxApgFft?=
 =?us-ascii?Q?C0jPiruXXxCBzqoiP4lbIQovVh4BjJAdcY83LP4lyw3mJt/dTag8ko1jOZE3?=
 =?us-ascii?Q?M1IkoPqnO+oPwoUqDHGpiTu5h4YSrXNcWGq9c50sgOXubJ/El3IZ+JelsBTN?=
 =?us-ascii?Q?2LVGW9NrE2YTJuvNU9o7G41m8MaSIcoh24w8bASB9LPcz6CrhZHmX8WXDfsb?=
 =?us-ascii?Q?R2VAvEBvzF63gnlOE40PnH1rqu4EjR31UIY6yxrGXzBubNnlaBNcGGUalXbO?=
 =?us-ascii?Q?bPLCDhk0CfDIF0FHaxg0lI0wOvGEh+/qvUS8hGY8UA7tT6utj6XsLq4UZpSN?=
 =?us-ascii?Q?hYGlVP83WZQiSHWMFeKt/96ErWPebhGzHSQBmm9aeeqa0KqhtcWQiPMrEIIK?=
 =?us-ascii?Q?3iYsfqyLrTSQixS4Zh/mBMN6u4wOx1DepONfzHGzmoOH+ZjeM77qk5ZALWnr?=
 =?us-ascii?Q?I4y57oLFeOPs5q764borUe5cOYC11CG0Ev0Wr+FYXgXQIS1oaJLrG1OshY31?=
 =?us-ascii?Q?wcWcAxkpNbqYR0pYhx1SZPGZLjLwMvTx035RQyvoYN36ZEtCHzNrmr51YmbJ?=
 =?us-ascii?Q?E1feYj9gDLOqMR2g4AViPjRSFZhSqkAWtGNfNf7d5Vto6E30vT0UMzv73rBJ?=
 =?us-ascii?Q?pYvODpfPSO2pHaKT1KuIaLSvaTAxxNubUGYN7nrV5lOwPEo3EH5CPQ/p2enu?=
 =?us-ascii?Q?ZHgCwbWzQeQ4ji64bysaHu7/n3LJcgns?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8m1qR+efI62+1JTa9whyIigSUJtQ2nkUGDqZB2TG2BwkevPO+hH6zqZvux95?=
 =?us-ascii?Q?jFjeGma60zyeSGkKJ9Shya+U4VuQl5hvjO5z62I1F/sn5EkiCv/uEeoRVn9R?=
 =?us-ascii?Q?FZGTz2+omZXLTiaI1NoI1GiY8+u2VMgOs8SeMVxdLt4NfEliDvX8+wgfyrHE?=
 =?us-ascii?Q?3Fe3TLg8QMxvTEhsHfpLOH5gtenO7TFL/Op5/l9JfGjdmkqVH0nLKetRcvvk?=
 =?us-ascii?Q?w7jhglSUQ0C9ZIX3WIJtZmJlokoVtSwMdDUwZjDIPU9IfDnMhOmHdOFPK3NI?=
 =?us-ascii?Q?QP5Do9A0qeEVOC46EJ/H2Uul0Nz1pqEBoXhsm4hiY3IIFwlmGL8/qNtBtVSJ?=
 =?us-ascii?Q?doYdlWpV3nVzxWEnaQebV1zGG+lCHGxBHnyQ5ieeKAnFrNl2W3RgJwdX5C37?=
 =?us-ascii?Q?uG7/rQbQBXPKbX2MQUW+AHc52tVewrrOIfE8k63268f5VOxWVnpnmgHrzij2?=
 =?us-ascii?Q?0vTXQ3QqKtVbKQHFv2/Nha+sSpKpvt6nk/EwTxdO0lIi45wuYl+ZFQS0ralI?=
 =?us-ascii?Q?HZWGq0aRDMuAeS+Idzr11+xhA/Ak9fWKkMuEliJZFkvcMIt2TpExXM1AbQHb?=
 =?us-ascii?Q?pZiflPp4l80eYMRC8tXqXI5Q4NYT69JMGbSss//qL5SJatlzrdv1ta1TTdoR?=
 =?us-ascii?Q?AX+mBrEzzK3vG0ODKx9GonDfiuPjzx8YrcCK5Um9DMS7j1nqz+pYrMmdDhHK?=
 =?us-ascii?Q?2n0aiS4h9Vpv4TIbatxtBl73nrjgyqjD8WZPK556CaFEjIDH0p6LwDTGvSuE?=
 =?us-ascii?Q?BjhVXo2zjH3RQxtf9vJcPZD7Ep0ehF27nuQ97Xjg17OBfMiGBbHd3gA5nwon?=
 =?us-ascii?Q?LBqihBTwqazifTOWgUbSw/pRynNK22K31WSgLxoIdI+dnAPiE09fAifOUcR8?=
 =?us-ascii?Q?E58BiH/hpw536C6LSzmixUb0sO3236F4AHeEl2302CAGf9ZjfC1P2diOLpIj?=
 =?us-ascii?Q?aBFKnPeIous8oJHQ7wq2McOPa6FimFirDXj3JeaYKFudjGNnc5/MqZ93zOqJ?=
 =?us-ascii?Q?zygmK6U5lZQ3361X/azpDw6mHr2IVedRYdM/S4uAOIWIHSN5O7DuO/RaOeo1?=
 =?us-ascii?Q?Oa8WkB8mUC6S0eSUQKFCahlwyCRKQDUAnaCH6iAnAsxgHkTXUR/Xp83xQJG+?=
 =?us-ascii?Q?sfhumvtOLv0Zwm7oijQ+V0GjSptQcXi1oMmFPrPOjgaRxhUJr+HEJr+gGMBM?=
 =?us-ascii?Q?PaB/FvEM3W5IP//1sn+Hc6GW5jSeC57qShIEZac5ZktMlOZQkZAiuI/yvUtl?=
 =?us-ascii?Q?D5ElD3euJTULQt8BRiYoe0EYdXgm4DY/0fXv1OqO2J+44sjXX0z9PPRutPAk?=
 =?us-ascii?Q?X2Z0wUnNDLql0pGh99/zasJpVi75AmW1KQmGi9Q65wNCyYw4yIunbnJL8pcO?=
 =?us-ascii?Q?0Z6+2akvB7pm7+G+G/3WSDjkGdyHuLPwcGBJKMU7TrVm1zcXoftzy8siRW2c?=
 =?us-ascii?Q?cG6ivEL6V5AbsMS5b7KLqtx6a6zehXQLO+aOCUKyhOqvjwxidMHvU9LESd4D?=
 =?us-ascii?Q?EKFobDyObz7ECtBXHTh0OkAKjdffvhVAvFJVbWjoZkp4rNANIuflNqgrM7qQ?=
 =?us-ascii?Q?2w0f95uqCdhWlzNMudNnk2/baPk4lxMTFPZledqaQTFNSfZpm72rLVMBC6AV?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Rbs8XxinK3HAbmEA8Zw/j60fQZeRq1S37RwCDEaPUSw3M8J0cgbsYs5objEMFKr3VxFEMvfGeZ3Qz8pYi3dwOJf/EooIJVMA/eaiP6L65EgRo8iSmNriMRHrgQD0en3rVaYEOBuwPN0sNF8p/rXy8jHnkrX1FwX+P2bN/szcuHkBhqgd9NhrRyYmemDkMgVkFxZhzwsDL0Jmzdy/Mr98IfgY9vQZk3/39KE49w0Cnp6MmlBqBt0nHOzJxLP8FxEGKP3LLrfSYc0hUII45gdIVFByuLl2vJqJsAxZDvgXEu9yFEivyXktYS0Aqscx0TzqFf/xFDgkWsxNWpFm56VXgyNn3KGoLW6Xzsvu59eEidvtHPYa1ILoruJtoFlePyg1S00yojsWpXRZhkZZteB79OyNmULmsjIU27gS8URgmpPck70ePCd4fW5VwwldWS+LdCh2kzb2jHMtX/EJcJDWD576r3ErSD1EiKPZFYCDgCKbSNa8b9JXFDxgkg4xSgDvI+ehJ5kRdNAxk2MBKHW57LZJCe3wyKH/BEKKNnJGYsh/kAbeg/XMw1KTNIRc0bLvKMQE72dQof+KAZ98DfgakSwkeuaPGMlxWKl0t+vt7Wg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456f448a-f922-436d-e8ac-08de3d764de9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 14:12:25.7149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/DMMY1uHJsgGn5J/yY8uFaOtfRlxXG21MRXg9sWz1LZLp9FxoQZ/bbY7neckwBTM1lfPqJQGgpgHKttwUsePoA1pHtGAiQPtqEtoPQQ90M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512170110
X-Proofpoint-GUID: o7qTRlOd0HWhhIXVTElk2WrI8cCfed47
X-Proofpoint-ORIG-GUID: o7qTRlOd0HWhhIXVTElk2WrI8cCfed47
X-Authority-Analysis: v=2.4 cv=fOQ0HJae c=1 sm=1 tr=0 ts=6942ba4f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=utshqUsaubzgWdY0xF4A:9 cc=ntf awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDExMSBTYWx0ZWRfX/+OMi/b+2N8A
 xaUZapmkjV7tmLdFYPgT5s4lpWBdDnyad/kgXam5I8KLWvx/Z3afmXrhzOVTy4ob1OhR1iosB0E
 FM6ShAxtRXthYlZpIOPdP3xFgzuTjLARF45mZ59J+0bH6qgQkSzK/yEvrIYAxuTNRbhoIsjpEJ4
 7trYMMweSzC5YzGH7yv/eTVAogdtzEV0MAh3C8TzAsQbM/U6zON/L8k1SDuE2F2Ege58xuMlTJ9
 2f/bVBNXpZLQ9/fZ27nbftfQRE07+DlAN+LZfA7SoUnWzDGFVmkOgJMBd7gE8vYJGe0/CloAHV4
 2SG3MDNto2Gy1CfjD+v5TnrLOcfkkHYboZw5FImuOCxixdzc9dVqq+J4/ZnM6t/tOoDue4IyMyi
 QPzevI/NmOd2XbajxxC3XS1hXHjQgIB0ffuPfLe8ppMStpoZVGg=


Deepanshu,

> blkdev_pr_read_keys() takes num_keys from userspace and uses it to
> calculate the allocation size for keys_info via struct_size(). While
> there is a check for SIZE_MAX (integer overflow), there is no upper
> bound validation on the allocation size itself.

LGTM.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
