Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5434C149DF4;
	Fri,  5 Jul 2024 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720180332; cv=fail; b=SEy3hp2sqJr+NfxGAsP7e5rf4WpM/+KIzoskDct5g5RDysFFfwyznCXP6RP4gq/1xYOhNvl9YTovh24rC2JnmUr+ALSRK6i6Qv9Zz0EVn882IKn/+x+KaEfM/bGsmhNfpfZbXIDYosi+kkAIxwzhYfi2kS3Lr7qAHqs3MuvX1q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720180332; c=relaxed/simple;
	bh=ncHA8SwfItHsbOL4yv3d6NBtLPJrYNNnxtzRWXb5q7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EtaLKqn2S0UOr1U8rpqWKQuNkG/kopbWxFCk67qUMBBhaF70kAnU9dbSAKOYIXMxAmVWpue7QiEmsGMVI71qcc9RL+wN9fF24jT68ACbfrxiQfJIWz1ILnWiT3ScKH+O/FTwIECqJfzCwjA2737D282vDh+LWg4ddIQzMRG3UVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E3OCYe3S; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PVTWdxSb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E3OCYe3S";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PVTWdxSb"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465BfUkx018372;
	Fri, 5 Jul 2024 11:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=c9CMuLYa5e9ILib0LpTRq4VURr7DXr6TolNKz+p3t0A=; b=
	E3OCYe3SGFNdmaeb4IIDN2anQr5aor2mFKWBCNRwct2yhhpLRoYjovnQYooUeUgi
	w9WV6fElhx6PW9g8Z9lb7QfS/fp12xUcA8uTxljcTh//oAiOa01M6J6uTVjLSzhQ
	+4eGgHeIo45UTrZQsn5R5cwG25QMQnFssRI/3YdKrYAQ7JFUxtUSszICTujPC/1Y
	L1dupJk6qlyKSZgQKFtuszf6iG4sO/mYhQ55qMoUpXvbypyk4QiJ7U/oRCyl5+Bo
	7/Rz5Oazre82euzmmf3cXtkltUokTuhDpS5QjkF/sfmbH/ftbAN8iBG9k3q4u2xT
	1VfMF9csCKUgrv2taza33A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402attksfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 11:51:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465BDgUU024718;
	Fri, 5 Jul 2024 11:51:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qbsb77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 11:51:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DT0UyDd8YohoB9jA6QKfwAH5ZKPpZZObo7+F7bZbfIpkL8CfmPyBlnPJAWX52yIQqQx7pahFxBw80PSiye48qrW47FFDkgxWqSNCwasPKw+r1+ixAvx9DTDtQAZ48qIhAlug8two4wthzkj4OgInOvcckOmUOv7rxorkkSyaXN2iTv3KpGAC80galE/oG9Rdgl2u1GPdde7jqGV3j0Rvehz2tPNVcYYRkVhAfQxG9Y/OlAXowO94k0wb6Azq5M769HhCzDzECpNzg9WHFILMBBXYnop6bpHoW6IGazHCWY8R3XDxotepzSzBpazCd30enQedR6p0fgZm1XPXgfxOXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9CMuLYa5e9ILib0LpTRq4VURr7DXr6TolNKz+p3t0A=;
 b=IAO6PnfGbNfANDQDjrH9DIAeNvtYb82hD0BM+FrKsdODNrG3yLfSmp8GljINUGYp7rnifLePvtJCQEsFI72YInoWyOusRNjUDXyRkwJfeVlYHvkc7ZOV8dGLcFNVLccDZ8BMhDFjqvECm86A53rjqBmGNDWQ1Lfdi1gs2I1LVKFxYvRUT7A44MgVRSpFuChYFFSFF1H0Ig6pEKUaotZlyt/WyebXqfv6zefUXVuvLptDgzI7ayicuOW9xQ5HfHI1ieR0+/urqA798rakfJlEatG0aVhH9WXYsT0XLSy7VM4Jo1l+jbU5OTyrznsb5mm7u5rK7FuHl5sl2neVBtKjwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9CMuLYa5e9ILib0LpTRq4VURr7DXr6TolNKz+p3t0A=;
 b=PVTWdxSbl2F4FNdgN4CxsMUYTnmhDNNLesEkP82yaULvJBHWQJ8xO9UU1vHP6EcDEg4no/8ArR0+BODn6Hbl3HCmGdi/Fv1k8xWCBEmRgBBfhrL4p7YM+htmOrjEqYnI6PhcqZq4SF2v6kSADhyEduI0tNQ29kGM+7nPIAD88KI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB8080.namprd10.prod.outlook.com (2603:10b6:8:1f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27; Fri, 5 Jul
 2024 11:51:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 11:51:44 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, hare@suse.de, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 1/5] virtio_blk: Fix default logical block size fallback
Date: Fri,  5 Jul 2024 11:51:23 +0000
Message-Id: <20240705115127.3417539-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705115127.3417539-1-john.g.garry@oracle.com>
References: <20240705115127.3417539-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0035.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::48) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd3ae65-49c5-4c3d-e29c-08dc9ce8d752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?MwJWf+AI811iC4lwx+1z8pmxmu1UOn0wI7B/GOJjFFAOmBODRtnFvuU0qIsp?=
 =?us-ascii?Q?3YrlFvmnKs4AuOdIvtG0JzPoApcanIf+0KMATZGOhmNkVDwn0EG00eU0u8vI?=
 =?us-ascii?Q?YgPuhobcnmnlLx2goKhHPjrnhDDs0iuCniZIXBa0mF5Pj/hDG0Aqjt4rsWiM?=
 =?us-ascii?Q?9JtVd3v6HHmdwO3i0Kz877BH1kXAfqpXU5YnhjSMYxek9j4L9SM8zgqYBf0t?=
 =?us-ascii?Q?EZk3H+ASOA048L6/GrtyACTrRGNcGEfUhTW3C3MtP6++YLfKkjP9/2mNA8zL?=
 =?us-ascii?Q?cHsMFr0aDAYmBP/CT1H50VlFmiNJquMncka5mHDzA5no54k083mjKkfefSaT?=
 =?us-ascii?Q?UZgUiPfyppZysscoEOJrX3NTRTTMKI6D8Wngr5n8FCRlkkZuQ2qRXpvbrD0H?=
 =?us-ascii?Q?Ll/HMwLzcOJI0Dam9g0lWCgrIqxl6/vTHDEQtN0JzosEPvDLrCRL8GG7r8yX?=
 =?us-ascii?Q?3RWM3FeyQMhVWgTzQx1gYSZrmqTQVghwXPjRF7VgZJ/xZrDl/oPcF9t0+D9S?=
 =?us-ascii?Q?AjVaTg6xN900vnRrR0hS5X7QxJkKaZWUPBWxXX3Bj8P57fqUSZYNj2mzHBOc?=
 =?us-ascii?Q?HkJzs3NnuvS24BzMoHxpVGkqAvt7FPQePXHaaEPk8BHNBFIQ7XGXt836fpnT?=
 =?us-ascii?Q?zpuh3UAKJi55cCrdAtNUm1YLIG8/mz+fQ4th/Z/+5E58GB4qxNptWItTuJeq?=
 =?us-ascii?Q?c9F3wM+OYUbi2rrMp1ZNHc/YcqaMBH+3vhwu28j7RfXUVt0shx1JLMtbvk/4?=
 =?us-ascii?Q?uELfAvQK+3Kul0gFmwgZtjDA3WTRUQccyQvP+HTO1jz2tT8gn7ioCP7EXUB8?=
 =?us-ascii?Q?TvsyeAJi3d9cg82oCgR02RvyKPGQx+Ai0F/d6JUjoRs38rfMzNddGObaIc3o?=
 =?us-ascii?Q?B3b9yWH3OsE594Xi8RzitqE5NtMNvz42wvds0EkTFc3ymeRqlrCRt5P8VXsc?=
 =?us-ascii?Q?Eqhprr14nVEbMkfw7gNJYrQNmM4HWE4UDUVuR/dheZbmSJfP271UeLl28HuJ?=
 =?us-ascii?Q?7llGVPbVeQgbtheLEF3K4Rlgmx+NluUrYkhc9rdL6ySYwVJ8cBOgaO93vVUz?=
 =?us-ascii?Q?4wNdcc4zGUKCp1Xors5EfyX6lyONWB/pMsO/tsQn0dEvI61bDtbuLjP21zCF?=
 =?us-ascii?Q?SaHdNt6L8PdFGfuPHIV1p7zg6WosRJfqEgHQkYY08/q39XGqFIPB5LA3bx+/?=
 =?us-ascii?Q?slRIVtLRhVmt5m8t6HMLNwQQ9UzyE03PdD1AttgquR8A1LNTd4tdmIv1lxvO?=
 =?us-ascii?Q?8bKPBLXEAVoGffoq81M8HpnACNE+14Rgf7pnb9fHt3hmi/D9bJTrJk3Tmta8?=
 =?us-ascii?Q?eMw4PrE4aH8GdxIMqYDYDQRpPprivhVS+kjRjc8uhcw16JGWeQg73o6ZFwC6?=
 =?us-ascii?Q?aDa2UFbvpsxrua/tQt9IOxZ32pCj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?w+1lupItHkvERglqKTJLAYZG3LjwdDauLKyccOWwRNy6C6ESoPvVbxw4gbbE?=
 =?us-ascii?Q?NPNIpWfElA+j2s+vNMJJO088ekKy87PyGBHajijfEm0C80RXqWzKWZwHtmDl?=
 =?us-ascii?Q?lHKZdEZ4fWdzhekkxOaKQe+KkBeIzGiWe9moXoo4ApRWKOnl/ZfGSYA0adBE?=
 =?us-ascii?Q?EOSwTBBZSpTrgHLpLzxmapXBZ850puV2iDSkZuCni5YWurfd+VaLi3AzE2ns?=
 =?us-ascii?Q?gLTdOL679g0ERWLw65vVu3HIETLJcxx8NDm04BQiNpXfHABNgsB7f8iSeB/1?=
 =?us-ascii?Q?l8VPHtPxwSTvEIKCr10hOIOhfk3g9zlqwGO8HnleLxFWlrFW7bCoMpvEWD8W?=
 =?us-ascii?Q?cvPzQLgg5ms2z+ynqhY28V/gtwBYA+Jl0lJcrDydXikJYVGDTmMnCoLgHI4s?=
 =?us-ascii?Q?vw0coOR94Qv4JMCybATX921qT/t2OElyIvWb72EieB3f7zwEa5gCCnbtC5mh?=
 =?us-ascii?Q?4a8cUzM9k6YKWgb6zKgpSlD3jEbX606xoqokhVWL7APL3KyL7kQ+com27OE5?=
 =?us-ascii?Q?4hkiFzg5n/FnZ1pp2ETR55LLTtgrfCHqogyMY+IO7YPOXrZ72t3EHWUVwS1U?=
 =?us-ascii?Q?CPwoxmM88Wxc7Fm0+YURN/DTwgn9pvNXAwLBz1RqJsGFjac/WsgCIuAkHXkW?=
 =?us-ascii?Q?IXAlau4Ivh8XHdsDlhUJWjM2DyMm05hvyMk31GB8TC/SR0y6XtabJBnFNZ50?=
 =?us-ascii?Q?sNiNlRd+BzUjVLK9VZE1DCU4WhqDune/NIjT6PPPzKnBiNrTMpUrJRtekUpN?=
 =?us-ascii?Q?whcUy/Kc6aFjI+9gp++vBprwjWrefP7eDOrw0SD2SDZCLQo6BIrjaYwM3sxj?=
 =?us-ascii?Q?dLUYpDlWvEQpu/42QtNBkG7YhXIexM+R7AJslZoBZHDUWndlOgwRGZBe5rsM?=
 =?us-ascii?Q?MOquQ5Jxvd/6qIbOnuey7rIy454TDgYW76HbXvQZMtsbXnn8EHm02cg/0sww?=
 =?us-ascii?Q?W9ZQAAurSUfLahkVcCVepl5ErFqv+zrMsalc6q4RfrsUU0vEj5G0vZO3WTdc?=
 =?us-ascii?Q?2VJp5ix9Q2rBOXGDAKmrKIz8ok9PeSmTBxgvaQailIeH4oxuJu92vcOKzz+c?=
 =?us-ascii?Q?/5nfvixo9Yvry3mCbd2ISpYLSjfEadpETlnvMKQiZEeybDPEjr0teHmljb1J?=
 =?us-ascii?Q?MMcounEf4goGisDBxGy0tveouDuAnK/NQZkrFWGmeQ+8kP4HMh+cfn3Jhe5C?=
 =?us-ascii?Q?QFsqzeJceQtjxDmAPtF/u72zoQH5cDWiTv+4T9qMTTjLGzY2LEfzZYs6c70s?=
 =?us-ascii?Q?JsJKOHefKZaanQ8thjc3tBnwHx95TwH/YU/WFLmyxwwTKrnyl1MFIL/nVN3y?=
 =?us-ascii?Q?cukvrmaCG3G/ce5nNSqLJFQgk8YkH3IojCTL0FpWnW3LuNz4lKQAlAdfsrmd?=
 =?us-ascii?Q?B82pm9fenbs9J0lYkRYPPGe3u87Xuq1bV9o0frozVaaVo7cSQ2ZnNSOl259R?=
 =?us-ascii?Q?G5H6pIXMoDMsUy/3D2Hcl6LaBDCZ3QPOXVPJVBPfDDoguTdn6ic5xWovnxR5?=
 =?us-ascii?Q?cPE8coHOXc0KDODzl9c86SE+gAGyEN6tRZT37k+Ew8JlvrsyKVEkaHIJLLMQ?=
 =?us-ascii?Q?1PgK1hCmfkLfggIcwxXbUa4gKfpFQE3d9lvJyENo8sdMWlULb/ExATmnO/JJ?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XhU9OksYS2+A+t7EHl7Z7AXRW+g7OSbDCLjNh6po9bAPAo7kuxcoePBMcnul6vi/XLoqdVQk4S304FM0jI03Rc8HGbS+fH4RN+SRU9hjZvFbKBhB5lu8W8JaLKa+klCSpYplwDxXZawrM4o2D5c1PI4Pmq6rK6Vpzz5r6R7tfWoEKayQSuSC2NLvsd0qJs8LzUfiWV8LPQwa4T5MO8py+IvAtENxhbfcCeWmbJcqVvk4+aAM2jy6I9Z/AhxXRHFWtO8XGCfex3HuhShCuGRC0R7WL8sg5bdIDXhRHJtRDYwGRzdpUEEptYelJ05SRfa6yVVERTM9/OpvMvpxDIf2Il5VZv5PSCAEMHdd+830tNBb+NnEPyLnfnQdpAgyTE6lBxFSW74Ruos77d3CiJG67EhrXPOL8/ruGgYPD3qIRG/ZmO4WrGRz61FXSX/uC6Fbl8VkdOr7HuFgnsv+XgacxuVkSLqy7FzFPHNNzXFzlocF8Ut7rjyfpJn8RSBxwSOnnEO9lsMS4/2HNC8d5Y4Evks4pDwp1DppCCnKoMmv7Rg7gyhK3etZKerYT881Qd/WeQJZqKuGY6ITTisjqDupanDt6SQglmGNnMpHS6wvvKk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd3ae65-49c5-4c3d-e29c-08dc9ce8d752
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 11:51:43.9597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EWZ2qPAo01n6YheNkcD+biSde5yD3tNkyYD7Wk7eTRp5i5t021rmrpauuMyvCr8pFZn/YSk6wcAh/QMBW/2jjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8080
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_08,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050088
X-Proofpoint-GUID: LePd1kwQhJeBcKEmJPgNa98ueFmK7FK5
X-Proofpoint-ORIG-GUID: LePd1kwQhJeBcKEmJPgNa98ueFmK7FK5

If we fail to read a logical block size in virtblk_read_limits() ->
virtio_cread_feature(), then we default to what is in
lim->logical_block_size, but that would be 0.

We can deal with lim->logical_block_size = 0 later in the
blk_mq_alloc_disk(), but the code in virtblk_read_limits() needs a proper
default, so give a default of SECTOR_SIZE.

Fixes: 27e32cd23fed ("block: pass a queue_limits argument to blk_mq_alloc_disk")
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/block/virtio_blk.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 84c3efd0c611..f11b0c3b2625 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1250,7 +1250,7 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 		struct queue_limits *lim)
 {
 	struct virtio_device *vdev = vblk->vdev;
-	u32 v, blk_size, max_size, sg_elems, opt_io_size;
+	u32 v, max_size, sg_elems, opt_io_size;
 	u32 max_discard_segs = 0;
 	u32 discard_granularity = 0;
 	u16 min_io_size;
@@ -1291,44 +1291,43 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 	/* Host can optionally specify the block size of the device */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
 				   struct virtio_blk_config, blk_size,
-				   &blk_size);
+				   &lim->logical_block_size);
 	if (!err) {
-		err = blk_validate_block_size(blk_size);
+		err = blk_validate_block_size(lim->logical_block_size);
 		if (err) {
 			dev_err(&vdev->dev,
 				"virtio_blk: invalid block size: 0x%x\n",
-				blk_size);
+				lim->logical_block_size);
 			return err;
 		}
-
-		lim->logical_block_size = blk_size;
-	} else
-		blk_size = lim->logical_block_size;
+	}
 
 	/* Use topology information if available */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
 				   struct virtio_blk_config, physical_block_exp,
 				   &physical_block_exp);
 	if (!err && physical_block_exp)
-		lim->physical_block_size = blk_size * (1 << physical_block_exp);
+		lim->physical_block_size =
+			lim->logical_block_size * (1 << physical_block_exp);
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
 				   struct virtio_blk_config, alignment_offset,
 				   &alignment_offset);
 	if (!err && alignment_offset)
-		lim->alignment_offset = blk_size * alignment_offset;
+		lim->alignment_offset =
+			lim->logical_block_size * alignment_offset;
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
 				   struct virtio_blk_config, min_io_size,
 				   &min_io_size);
 	if (!err && min_io_size)
-		lim->io_min = blk_size * min_io_size;
+		lim->io_min = lim->logical_block_size * min_io_size;
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
 				   struct virtio_blk_config, opt_io_size,
 				   &opt_io_size);
 	if (!err && opt_io_size)
-		lim->io_opt = blk_size * opt_io_size;
+		lim->io_opt = lim->logical_block_size * opt_io_size;
 
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
 		virtio_cread(vdev, struct virtio_blk_config,
@@ -1422,7 +1421,7 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 			lim->discard_granularity =
 				discard_granularity << SECTOR_SHIFT;
 		else
-			lim->discard_granularity = blk_size;
+			lim->discard_granularity = lim->logical_block_size;
 	}
 
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
@@ -1453,6 +1452,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	struct virtio_blk *vblk;
 	struct queue_limits lim = {
 		.features		= BLK_FEAT_ROTATIONAL,
+		.logical_block_size	= SECTOR_SIZE,
 	};
 	int err, index;
 	unsigned int queue_depth;
-- 
2.31.1

