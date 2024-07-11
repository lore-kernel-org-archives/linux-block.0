Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E971509A4
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 08:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686262; cv=fail; b=MlXFhjepitx8BmbdvpyUwH2BtpNyUzmRs4QpmXyEBzGLyxgE3sFzIxXjBkQ7Cil+6IPpLnCOixHiVsQq9HZm/rVZCq41iCZ5Yc0FJgM5Yov8lY0g3Jucsv7gwIn7f+2SEbJnS5+x2MrLbQyeiSh3cfNQpAWXxarKSe7d4yrwCPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686262; c=relaxed/simple;
	bh=7xN0J1N011/SBSZ7WxYAndjmE19sLpghLPwX9EZuUlc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uo3ICT7PXHLyDWW5d2plRQbrYOFxg7Hd11QAWM0UYWC6YABrt46igE+aTh7T8A1wVlQSmn9pEF0YvyuZSeJOOjR97IN+YIuyveUyXqbfIo7y6NvmvwQLrlrjcsc7rkXGeRRCbnXUgk0x1QjDmrJrwwlXOOWVH3wuH8BA9dWYYFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=akvnwjOu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pM0MPQiy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="akvnwjOu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pM0MPQiy"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tbBX011828;
	Thu, 11 Jul 2024 08:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=1/ZBh9ktrUFojjs/C8PKS9yzavqM7GRmvkh0+neoAyw=; b=
	akvnwjOuSvsfdxvttRjg0+ClQECwMrcw/yJS82cSPsC2mpJUGyzG3MFksumAgHVj
	PO65o9W7sWM3CSOzkkZlc92Dar1vo67097XQI+k51rS7gyMjmh73PCSuwZ3Uzrww
	FBYvd5YLi4FkeCaNPHQYreJNddcjzlf7AmJ+sQy61VPjkEfrzRjqF050ZUMQuAqZ
	9l0hGPo+6RBshibzbfnTUs8LC9ZDRTTmgUgjlp2Ufz/tNYQ560yrCPnPIQPV75ZV
	0ikMJbaDiW/2eFQP8wz8Ggq86Or4ads5cwj0tp9O0ZZKIQtAhRtKpkYaM+cJCywI
	RPmz8Zf6podnLFTFsmCMsA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8gyww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46B6WBFD008720;
	Thu, 11 Jul 2024 08:24:16 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv478k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtA3DL1aIUEoSgpB+n8ozBKtBXD9XjOYjuTFl+ll4fiFYOtGu1dn+VNCSKx/1do3i42USi9WjCiN3IM/fCaf7fY0P0WABBtcXKe0s1IdTHQJtBZXn0Aov4OtISDIP3xEDouDcxTLISPalbP/GIpeEofRMHt/EY3J2Mh5Nn0lUX5X1FE/4yz5v2eN0ImZ0x57u4YW+vXOFb1f5vgQEQilHexTwqW391/jQQfT880sIGn0P6KgCTiAO/pszh7y/2D1xbtsiKHeUI70u0gaxIbS7a242/2Kt4QZOKvilk8sY91Lm5XReEH/ZWgiQVE6Dzxh2JjfZ+OksP1CZB/Y+Wacbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/ZBh9ktrUFojjs/C8PKS9yzavqM7GRmvkh0+neoAyw=;
 b=mNlcCdBdQBdCcncKXHiawhH1/zDMFDLqtYiMJRPmI+EJP8obYf228Qs6wITN5Do5lLf18R2jiakboDG46bv0pIyD7D1EG3vHkz0hDGMzMVNRiXXg39gzeKHJJOXQAdN572eLZ5SWMxzh6j5NIf8jh1e7VwS2tsDzWrJgpGgqIsxNr6/OSDwq9ovTrVs0RhjePtlgabsYcHpOLkqIC/aequEAVW3sgkryTmUHVPlFkcoM8anfQx216lJEco9CSZmOXCPsitN4ULhfrw/WeRvl1p8LT+kwLVJhvKHjSrLYGK48kvkZFdwZ/kvYbkfgCV1WXKPsxH62w5/fdODarL6MOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/ZBh9ktrUFojjs/C8PKS9yzavqM7GRmvkh0+neoAyw=;
 b=pM0MPQiy9+pUc669g2D2LRPhOaG0iaN9b7gP4bi92Fa10d9NiY4HWfVO8sDCGNtHYUPBc6wrxTlqmW9zaMSmDek4WjRHRpQbEkT5sPmOvMuMZ/6K1wdd0b/nQWFwxmqHa4TAd13+xmFmCa224qPQxEGIS2n3pafaTGARZTj4A58=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6672.namprd10.prod.outlook.com (2603:10b6:510:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 08:24:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 08:24:14 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 10/12] block: Simplify definition of RQF_NAME()
Date: Thu, 11 Jul 2024 08:23:37 +0000
Message-Id: <20240711082339.1155658-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240711082339.1155658-1-john.g.garry@oracle.com>
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: a5f602af-c327-471e-0ea7-08dca182d93c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?L/qqnRa6nPtamJTI83YG9bzNwQoRgrkmwk9d+aKHDrjT2l3JUdy8LqETBwxp?=
 =?us-ascii?Q?GoHYMWkM8kKGIhcK6wFKMqGt8ejYKBlKIeRMxu2H+AQlHAB1IoQ+rJRJy+8C?=
 =?us-ascii?Q?iwwV7CFcTkZH2gjurZHVcoJC9oLXwnR/VPyLTGjCaRvwLHILljcHuzJax7SL?=
 =?us-ascii?Q?/dxHA0FvlnE3fTPuqyBDIY6qyjFp1RWfZf8yGfArPCrK4fhUHD8t7lpnQ9/8?=
 =?us-ascii?Q?ggOdn9ltmtf3b75CHZkqL3RNAfNYqMTIiyWokhhzWDe+tQtQYC99mw8IKZli?=
 =?us-ascii?Q?4ylc7Dg36YfoD9ZyLiGsX03LIoOwZ0hGvsZcf1H4UmyxEqEKMXac8HoNew9/?=
 =?us-ascii?Q?X+VMJEDKd7gtSD+VYpc8mEhoxpdZ04fK6UlP5TB3iDtQxnmG0PwdOFUDviLu?=
 =?us-ascii?Q?RJzO7t0SnG11m+ogzLdtIzQwW53MPhvqYLdnhBWd76ftAprdAQg+yoXohycY?=
 =?us-ascii?Q?MJtObcXDPL3sndxWZq0+hxMv8xVVjGEus3hv/ICuGrm4aYPnaGqnVzP3m80E?=
 =?us-ascii?Q?H2pf/IYmEpGYA3oRpQtuX9pVMn9kLj0vH/PVmzGJYVaWvOq1v2K+iljh7ePj?=
 =?us-ascii?Q?LZHcY7le+FSciUy9qbcJdfP02Bq8oNm61r5eGjZY2hYN4k2+5yJLoDsxObtS?=
 =?us-ascii?Q?8OT25bSJN06M/OlotJm5AZPNY5QMUo+hR3PmZuu7RtWvH4Ki65RHPgyw50OO?=
 =?us-ascii?Q?F+ArIPtLAbXwJlAnnF01lKlRIQ26wJ+diGx6RNf9sVCWUj9SS2p29T2U7rvK?=
 =?us-ascii?Q?CRl/mxBE7GStygfyOLUb10WK0FAPFmjpzOYmDYgP7PXsSfjGWo2ht44c/AeZ?=
 =?us-ascii?Q?bfz1eP6oM02DxBPdsAmX6XMDKze9cSOzv7mTv10LTJ8xOmA610u1OOrU9PIm?=
 =?us-ascii?Q?SL36vdEqMhnvg43IEXpgUf0bjXMIYj2quhR/GC+OsSWVNjkQQnIHKJ+mG/gm?=
 =?us-ascii?Q?DsGOQZfd5X8lK1958Cj6lvEjI1lzNCV6WGiFTn6su4OKqi1SDeqqBjQ9JiWq?=
 =?us-ascii?Q?CEUfTG8ABSVEECbn5K4wgBAXqD2UwM5+QXETKVSL3iPYEQPsaDM5VIhqnxJq?=
 =?us-ascii?Q?949iHVoKuirEFc0yWbIvMLw/hhhzPPFbNOr/VdftwMuNKUbYNftNpfk8qR/p?=
 =?us-ascii?Q?p0p2XLq/nYUeXjmso0LIe4TJmJInNYXPDkXclcrRkCkI4Twn4lXyH23narnz?=
 =?us-ascii?Q?Mza1vE1pi+gor6QSFyyQhT7Z0rJ7HbVuBj8MVYFj8hWg0IKbInOr2lA1Z9bx?=
 =?us-ascii?Q?GRoUdZqAEqJBQdYVBNrK13n1prHYPrdhZlviDWIP9ppUXL8t+jbfhxp7IWt1?=
 =?us-ascii?Q?bxKf2Q01z2qcY0tjm4SgRbd2rv5u5a1QAa2ebhWZJcXL1g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?kG1oAMcHcRwGOjbliKy9PzlFqFhb4/3CIKriZCA9rHvm3Gm9EStHWA5rHutL?=
 =?us-ascii?Q?JmrFMAy7Ab88bVJJjL1ccC9cX2u/ugWF4EbbchrJE+p2q4ROgoGGt+F3E22d?=
 =?us-ascii?Q?rZAqnwZ6RQeLfVCpDnCH5BV3+hRgtpawCksXILA+3GzMWGm6s6qiTZfrNgp3?=
 =?us-ascii?Q?5kiJHrLI2+G0nAzfGcJ2Hh/TD4ac4GQhJ4xKBDujVw93VLoEK4QUAet0WAI8?=
 =?us-ascii?Q?OZz1hJPIGUhEYMPWP7yR2JpfF7/NYuH/NysS0XxFutdfQVSHM6gMJgLVbPHS?=
 =?us-ascii?Q?LUChL3X7B5earQY0ui0++V4WyeduIbTnQzwUY2ANbNtpTaOsFJVreTRPFCKX?=
 =?us-ascii?Q?L9Ro9FZ6nWx6WgarZi4dKKhOS8cRsCe1YO7iODMXoqR/Jz7rlDgogA+i71LU?=
 =?us-ascii?Q?UFuSk24PgL9eO5qlqh72SgvUTuzx+y/chYd3FtI17nrdxwawH4dr+p+odWBN?=
 =?us-ascii?Q?BchWZVi/vPcIA1S/Mllnn3NNEUW7ot/AOjQNMyY9wIQQuZGI0YFcgrcbt2l1?=
 =?us-ascii?Q?I5wb89jMUPJrDHiX+ZKMnT937g5SqtkF5VCubk4YZX7urVphHqXqNppF8lVd?=
 =?us-ascii?Q?0yH2v0dAbDXBpihC70q9JHuBKmNIbBYdIZAC1EsG033z4d7ZfrCmboiNGEW+?=
 =?us-ascii?Q?vdbVc+EAfxgaOylwvMYjqqHpqVQuaHcrWFePvW7fj29kqwHuDjDsrv6G4wc4?=
 =?us-ascii?Q?U60/1VPdiOFzezN4XqkEpZvyoyB11DGkkOe46Rtqcru0L234DQbKedUYGgYS?=
 =?us-ascii?Q?jUoxJFe2SnLTNJV0rh5oSAz8Q8Jbsdtg5heC7jwId34wRTo5SPYdS925JXT4?=
 =?us-ascii?Q?MbF5duIjjyTNCJmyEuwsxnKlRuQ2sQYdjOLaWR+Dz+Ls4Bll6qgmhc7yOoC3?=
 =?us-ascii?Q?1oDhy2Fy3g9ZeVP6p2yVhlFuh5MhgonY98lMdUvUJWpbRf+93ph07Q3FBtqa?=
 =?us-ascii?Q?CmTqBR5e9HWbdz6yrA1o+G7Wa0lSBg3QulT09V3j9B7XRuWpmzsfXlPiKW4m?=
 =?us-ascii?Q?v9UczPoSmyIQHKl37YiHeDaQCwaQsbcAXp+9AsqFkrXiUO0yf6D0BMEcwBe5?=
 =?us-ascii?Q?OV2qqrBFTCoerllymUDkLA8nQDOct2aumYHnE7UIg2YOBlGgccyplKhTN1VC?=
 =?us-ascii?Q?OpNuiS2w3pQgS24W7t6Vq7rzCvcQ3SZ7BgIbTKKffsr/b+d9KD+42nCVHqC5?=
 =?us-ascii?Q?DXFue8k+pnIZYGHULBTXHa85Si+Qm19WNRhLKAOVTuDZ5gWLlfI+R3QkKIGg?=
 =?us-ascii?Q?I2aXdJmHMDpp+kpG9yEyQaAKk0qmnNcytQocWwE0cM/yE7hJx5xl8kLP3tkq?=
 =?us-ascii?Q?dtM2NW5zY5UJqV1nYyRiZwKyoZhZibovrnv1vwCtdoOHL/g51QGpqla4l9Xq?=
 =?us-ascii?Q?PwsbDGIsPpn5ng/+m9uFDU+r2Epam/adgIjQAlt62VfB8UGni2WY4FkhjeZh?=
 =?us-ascii?Q?aJBCeOSnKOGplFHQl1Q6HFz5U7s3pks9xzoiCWlcgAHnJCb2ylY7Ngft41Ju?=
 =?us-ascii?Q?75kK5ALNUa0WO18K2f/f5Oi05l9jWFQYxE/L53xcI3Ps8NlnYGrKf4YaXND0?=
 =?us-ascii?Q?6RUNvxvvtifCrTtH0HQQwXC6F+jilNo8SdjE2NCMIssuzS/hS8nTyf3BVVci?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2GD8/wSI6lY4YGG9AMJFf/ph0iZap/hmhIiAd0ooFdPs16gWIWBYNwXetZ/X4mSMXFaGHTby/3XxBDqNW7MkUyCFmvB5a4ReRhisOvOHZTULKSv3SXuQ10P1OQoRBDOGN/B5XWjdq1/x93p9zgcROPAzPoUuDpEmTuiYaiqINNIm3a7fgqv1qiDYbxu5GdfSQQBBCDK+IlktuIE7SILwzojL8bV7xEDs3t6pnr6UuJRPk+vhThx/6zRLolsJuhgXkX7rnhacQ+Mx3LWwk7qXy86wPPXhEZIQRfe5MZHNoivBE5zcXSMTEWjdemwC4y3vmxUwds64Dn+5AeA06jc0MxIy34IguEDP9ehTy7PH94nQ89OcfUE5X5Cdb5rJMJH9ukVh9TzLqxolQMjf8zcSOpVppDR3avmjX5n2puQm3lNcouOX8AxppELdJnS/9x3T9CVZRkqKtClw0EzxvuziEsJ5bPB56c5WHfnKhpXjVop8xqOheiASxIipKcNWM3rBgqvXm2YmwS/GishtLY6U4eSJ8mAYHP1gVRkQfauhljJW7CwCuZzxjmMHb8zNDknxpz9kL1OXIZe5z/9jSVhnY409FL4CN3MaCs1/6vnD/PQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5f602af-c327-471e-0ea7-08dca182d93c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:24:14.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPftbdOg2evbeq/RXBqCswA003Mxmk/D4ffaEPSfUV1XLU1yxVgV13Z2JLE10mylL+zUI/3aI7nfH/5saMRLQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_04,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110058
X-Proofpoint-GUID: pZ57wiQg8vOVx-HfS2T5OsPwALOKugCr
X-Proofpoint-ORIG-GUID: pZ57wiQg8vOVx-HfS2T5OsPwALOKugCr

Now that we have a bit index for RQF_x in __RQF_x, use __RQF_x to simplify
the definition of RQF_NAME() by not using ilog2((__force u32()).

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-mq-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 971457b0a441..305c53459fb5 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -240,7 +240,7 @@ static const char *const cmd_flag_name[] = {
 };
 #undef CMD_FLAG_NAME
 
-#define RQF_NAME(name) [ilog2((__force u32)RQF_##name)] = #name
+#define RQF_NAME(name) [__RQF_##name] = #name
 static const char *const rqf_name[] = {
 	RQF_NAME(STARTED),
 	RQF_NAME(FLUSH_SEQ),
-- 
2.31.1

