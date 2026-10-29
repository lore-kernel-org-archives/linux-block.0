Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793274747;
	b=URPqPIpdzQNvVUVLwFruT7PmiB04cd9RYUou/1LlKeKZK2crzjVfL68aFfC7xxPKktVG
	 Xr8+cgRA344uUJiSw6jGxKd2tIE3uvBA9TGpzEw1Ev+6Hh3+7CZUXQIAWmP/UANvuRNvL
	 8bZRH2+B/FcC5HqP0HwJKqs2dar51t3bUs1CqPVP7w3184+qdGwo4wmX9zADHZdUanxTT
	 GCImTqjyIQ0VpDILEA3/4mmAFHHiXC/1TG0q3e/E1G3DN3KfV6p+vTx2S60Cy0KhJ4ZEN
	 ex8RPyVKIUptpd0Fuh496d79tqW2XiSM5enJl5ViykUugfddlD8v6SqEr6LuBpjhEyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274747;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=HTQEGCJJGnfwVM/vn0ITE/2OxHXw0tPXcdLEqXuL270=;
	b=r40k1X139RkyUn7cbGGCvQmMFCRwQ7S8av7p8cviP/F2TZFbMk7IcLa5PWwuKp0pnma+
	 vuHejdFsOiNdW4uTTf8H5uWz+mdYYVN8jgwCt+TZnrJK4xm2sF/cJkZnSsEnwLefH5Hr/
	 MRwO42THfP2+kHwB6BRYvRs8nWysHYXgVfaU8q70XTdxC3rqqMRpMOaaD3q88PshVdyks
	 bM3RB+dFw9KPm6shWaGERbT7pzJSsXXd3pJ7uF46NfEjBqhkEfXQTyXNq8v1bgOtEuwlZ
	 Pz2CI+zo/5qQpcMCF/3xT7ZKMJu4U+ETfjPgCFXiWe7D4Tc94b0h7o1zqOK5HJs4YhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=aDjjjll0;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=KiPBBVLj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76117606A31D
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 11:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76117606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=aDjjjll0;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=KiPBBVLj
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1793274746; x=1824810746;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pftElnogtIV09ViGPgWFt3oa8bK+md4cmTzlxwmrN4Y=;
  b=aDjjjll0UR/SRbOQtzcDNRnbCBjBa5QTfIZpMCBcj5FogiO9vB8Xigw0
   sZH/WSMWsB6FWXwmyvIfZEh7ZxC5u8InC8CsVogx398Lu2aorIJrR4VK3
   NgmlVt8Lfw+jJLNHN7JjgsBLOtuYN0YwExnDJWz0m/VK7D7C1+b7W8VBd
   1CKf9xzUyE7jI11vq/1x/b7+mi+UOk8pzDv98xkkFqDHwq/KWNMY7ZW/h
   8xZY6SoHbJnjOTrdxkaCCZaWRq2M9/fAEq5LrCXFAubUxOBSGXDbOyj30
   Pz04qsSY4hO4GnwHduBgAjNIJcsgkpgJ/kI5dZm3/tR3uN9Pxf7cVeqTN
   g==;
X-CSE-ConnectionGUID: wEvKvsDoSHGCh6A3UsSATQ==
X-CSE-MsgGUID: WuX5xVp8RhC0MlpGiSb4bw==
X-IronPort-AV: E=Sophos;i="6.27,184,1786982400"; 
   d="scan'208";a="158339360"
Received: from mail-westusazon11010070.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.70])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2026 19:52:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgZ6We6BVWQAy7gCNcVHLnV6hh1EssPHJcoMMloeC8eJMRU6AWeJJ5+mu3fDdgZG6Cu1xFBpmoOJH/hrh8lHYrSmf75Qr5wiJsMdW9v2WNYKilRZ6oXFr5/PnPQf/41hlMd3Ezp2ekmUwH0sgIwiw3Eh1Bx15yhsRy4t3xGerpEQWQBwNATnNk3aPT6wQm6twOdlOVIj6nhhmPZoeJHVTmhUi9sOuJZ3nQ75E1Z22PW+g/8o/iwyRaQrJnZXiVJn7FLGEVL5Zi7QJ44SjhhDYvKf6kaiQT9QhKcI/vqE29lvXg+4hUdI1HSljxGA5Z71yA/cXMDMLICyeo8qXxUwFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTQEGCJJGnfwVM/vn0ITE/2OxHXw0tPXcdLEqXuL270=;
 b=NtI27ICRDIap8ob9aU/ENQKWcGO6WVIB+c2VCRgYY5t4OZgxoMn/69Ewj8xh7+IZn4zvf+mI7a9w/+zcCuaVeqmPNV+WcfeMgOHjJBLEM/0LXRXGqGiJWCXD96TKo/toNvpZGGyhgvR0oqc4Oiub25o6KiP5uw/v/mvXCnsDDaysScLAdQX7naDgiuSm33Cp8IgZYyzgCceDcNshmaXmi3XTe2AC2NKlXwRhKy21N1zW4WJ1O1p8TzmOowSvcrgDbRSwIiLD9I+OrSXx2z+LYtO4Cx83hfap4cjhuvnkPyL9MN2G7TO2wr/5JOoSObyZ1VB477UkXVfWFe8OErKcGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTQEGCJJGnfwVM/vn0ITE/2OxHXw0tPXcdLEqXuL270=;
 b=KiPBBVLj1HZgDp6pgJ7XKthsr67nu9uilGo1aduQsatgZVS3BdSWPMJORHo5xBEeU70+YOm7Fb85zHqOt8P+8rE/Q89272zNDwgaQEeVmcH8YGsaJ3b6ofufzRAqPp2axEllDo5isxAwoxSS5U4W2iq84o3GwaEBdTh/6TQJRQE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by LV1PR04MB993689.namprd04.prod.outlook.com
 (2603:10b6:408:2cf::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Thu, 29 Oct
 2026 11:52:17 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 11:52:17 +0000
Date: Thu, 29 Oct 2026 20:50:39 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Saravanan D <saravanand@crusoe.ai>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	dwagner@suse.de, hare@suse.de, nilay@linux.ibm.com, sagi@grimberg.me, 
	kbusch@kernel.org, iyamahata@crusoe.ai, kiyer@crusoe.ai, ganbalagane@crusoe.ai, 
	sjpark@crusoe.ai, bchen@crusoe.ai
Subject: Re: [PATCH blktests] nvme/075: test the per-queue io_cpu sysfs
 attribute
Message-ID: <auMw5Gxg6toa8GD2@shinmob>
References: <20261023230426.6425-1-saravanand@crusoe.ai>
 <20261023230809.7869-1-saravanand@crusoe.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023230809.7869-1-saravanand@crusoe.ai>
X-ClientProxiedBy: TYCP286CA0219.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::15) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|LV1PR04MB993689:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fc93e9-a3f9-4a28-f646-08df35b31483
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|19092799006|1800799024|261026140227099003|4143699003|11063799006|261028144727099003|56012099006|10067099003|261026121527099003|261022105027099003|261009223027099003|261021121427099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	v7ngoILWMd+UjwRO2I3O7nU74oGXPfNCHWhO7wvSEYGwX3KWFxRcGGZKB9mc38y8N2MaN0BeKwMZKtEY/z42vpfUMBP+KLIgLG8/ZxqV/rF7b2ks2PNSeCZlqe7OMY8CPU02t/ZyhfKC821luWxjQcv31lYDF3VXqu7op0R1Yaxl1r2uUri6yHlwRWYOTFEK3uIlIgWctkrrcpOxmQ2KPQ5MuLDLCrfYPOaF8SxJZThwOEZ79Fy3Kmq+cd/qOhHolhY5+WdlznX82V+wYwTGKYKuvnchuDNYhZNY++4lstRAJLCb+kxeBoAC2sj0nZnw1rKfpxc4cXfNuAvYdAzUXYrzXpNQpYd+6pL2mYnvgznje5a2wphiXPVkeOdaxK/C3fj96sjlMN8y8dHeRV/LKkrUw0WHcSh1gZYRc5VsD7uaSLoeanRwafaXTynmB6z/fQf+sNeCfJr+Bx0cXy6Ju/FfTeEAnFIcbT3ktNbldlZ6EyMSMTHiQ1Z2eyTJtimIqIdUgcaFkeFCC9xpD4vZMk13pM19I9lvdnWd0jmFhI9d3cWxhSAbGUpEYSUhoaj1aD9q469lPFwv9Oizh+a7JfGscFq2RaBF8y6NwbtLurk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(19092799006)(1800799024)(261026140227099003)(4143699003)(11063799006)(261028144727099003)(56012099006)(10067099003)(261026121527099003)(261022105027099003)(261009223027099003)(261021121427099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tb339ShJieODZIG0LCxMC/zHrEuhFrTsd/1VTWuD9O8GPMWiDrDqDqJrP4qv?=
 =?us-ascii?Q?9T3cAL3F37zOv0CVXKMgoO1FMdD2rMW2lZfzklMk6N4rzBM3ayx+0RxRYuL+?=
 =?us-ascii?Q?jBvh9dCvRX69sUbZWxUOQnk/IGLVPAgBc6DXGvfL5ylBaJXlVWn+EmNB4d4D?=
 =?us-ascii?Q?pMbUEYGK8+AK2+hUn9MvhmVi7J4uDB+xK4KzQ8Mby7OeYgBNu3izIMsZ0e2c?=
 =?us-ascii?Q?s98O4iCdFSCr2iz6b3/dmzDgEJUSY/LrTpSG+ZZuM/onnHLMFgvx4ZxrXxK8?=
 =?us-ascii?Q?4LxVg870VXMFm9627xm9IN6Ty/ZWX5X226jfROGDDpHQ8CGV28ZOuYy6Gx6U?=
 =?us-ascii?Q?q8dKc6OQD7pclqsBCnruRJxJZhkVSgEwA57eaEBgY884Fsl8rTmOr8x5b2Hy?=
 =?us-ascii?Q?BCpGS5Tox03OzjldZlgESLq7NVCHJZTwgLO6PsU09GWfenAb8G1b5N7g3wnW?=
 =?us-ascii?Q?OgD7r911UY5VQ7d7o5Ka5f/eHMVxCv3cv3QWYqwf1BedKwTwmxojkvSYePVr?=
 =?us-ascii?Q?NF47xQS+KPu0ciKQ997DyP3M9u8iEAvE8ye98rhK5zHMguj3bbSrV614FB76?=
 =?us-ascii?Q?kjPKhg+StsaOF2yLLwG9TRNbjJuI2HskV/4s+LwGmQ/rb63pE07XV3AieLhE?=
 =?us-ascii?Q?xRAQYhR/Z8PRfHGh1zzt2PagLL6DfP0bHBkgsL5POPcaWKlQe6FJQepfsxvu?=
 =?us-ascii?Q?kKz+X+6so23GXdGrQF2P0k+2dkpseHn1X9v6bU2+HuxeYJ1MsqApEsjP+eJK?=
 =?us-ascii?Q?YfKvmCYB5VSwaU7FoMyXoq5C2sG6gst4SBgzMucoZT4/CAuWhI+RcJH9nIK0?=
 =?us-ascii?Q?F0wH3ISM8piuz2U8yHWOialkNhOj0b3FkXRgHgEIoQP2BrevlgJhpVEWX2nN?=
 =?us-ascii?Q?rnyaH5tBmI1l45OCDOuzA87G11uZL0yd4+2W3hf/7KDzFX3/HQmBKcmxFxdl?=
 =?us-ascii?Q?gB74tyVQJIm60q7SSHAWaCnIf8EMhWDSoyZB+r7jwOhaO3n8FIUE67DMTgqs?=
 =?us-ascii?Q?ehmAr4AiIUUNAHymC8n87kJ+f3KayZRyAl5yH3IghkZsELUBnknqssiFCAgV?=
 =?us-ascii?Q?pndRo+KXbns74NDYuI06OMdI+mRQvpaOvEBvtyb29B8Ve6PStEYbHKIg3lzT?=
 =?us-ascii?Q?NdgdoD1318zqyRuJbncmKA8m6cnE6AiFw30Vc8ZHv78ojiHnvol9He7BykQI?=
 =?us-ascii?Q?i7kpjBCFACZPX+AzE4OnuQqJBZlL5+1BbksnoCjv+bphsWAErB7qYh0F/lhU?=
 =?us-ascii?Q?qwoIZUZDkNMkSC7vP67TVgXGkmN2vcR5A/Itf5EPjSZUKAIgtwVxjFvUgAnM?=
 =?us-ascii?Q?kY+ft8rVhPTnYUVZOfV7N5AsOSwDn0Jlhffq1lFk9ojXO9lTR6iTUGnNrWi/?=
 =?us-ascii?Q?Ju2K+w5IKBJJEVTj6kq+6+MpN9/GAa5xnXYEipf8g27lvX7r9+vZ3k0qYZMp?=
 =?us-ascii?Q?SSdA5Gmj7i1UC8c7Qm9Zhakjz6jp+itUf/fLNziLERYHTN5fzvtDsg1+4PIR?=
 =?us-ascii?Q?Ox9+pI4F3XS32VGlpB5xyNW/R+E7GqbbFkSBwwxLy8iCFL5yYm1XvC71XJW4?=
 =?us-ascii?Q?IJeDi47EQLmiz6rV1ku9Y2QtgTUpgaW4KaK+6l/Tbud7BKteyMF5PP9hEv5p?=
 =?us-ascii?Q?+GJvT/XWPiZX+W1E6jNVwTex2bf6wJK8yV0XWbiTnab/9ce0/VwyKF7cHYsr?=
 =?us-ascii?Q?FUpm5hf4oGpaeDRvEAvQ20hBsmHR6+9Q9Tfsewd7ZZuA0gkr3yzLEdyOb+pN?=
 =?us-ascii?Q?J8wG9h0qExkUIUSL6SqWxoWss5NJoVg=3D?=
X-Exchange-RoutingPolicyChecked:
	r3m0c+uSPZrsGqGCOr5T8nl7zJEFVumXdMNX8v05N3h447ZcADL2mFD16i/0qllQESuWFVW5VWn8c7syWehrd2O1L7hYDpT4FMiRjy7GTd3a8tsOuOqXqUVA6ggsviqZf+oisRrNsnpzdqSJ8mP92Sdu0WmFLvGB0gng137Y9+DBzkSES1ssa2qwUJdSZiK7qn6Gl72CYD/L6TbviaWPqpRGqZtX3WItLJqeuz1uAtgAD6k9F70l57ezxiZTKXkDjOjXgyVcK9r1zIG1boWL8v/aNVbTMCJxVx6EYP70uYwdWjiviVQlByzrDF5a1EvRXmW9V1VmQo/0eUQ7bNodzw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ory4rtY2F3PtQcXSwPyQXriGYAZtPT3dNmUvtKB6Ms7SGj7u/xOjxxevxDnuMoDyriotEtrNLoss1v6rnGAcyJtAo+kL+msdvFK0/gwxyamU4qErCgWTMyg3M2444gKGc2DiTOH0t11j8cimeqigZ4oi9Vq4yA2z6qM21Impcf/+XO/QLjuVvf74FEnFjvNB1t7oS8zzEsMh8n3RsYhSx4sHvcGRnRUA/c2+PLieoyuWD6AHqdr6ItE+YpRFsuxeMuZwrmV+iZvw85ed3Lz45dWpEznVn228iq+k6ZW5scKVMrv3dHWcDZM16CSmV6eKcx2jy+ex8kX/Sf9TBqE6IAa+gv6K57HSyoVbRB/xE4nybOJb8zHsTHUq8PayQq7dsisy3/+gxorEy9FaIdkmSpnW5I18NebqNS6R1tQwPt4nf190c9uC0W62LGUST+r3XMgU1MxVcoL0fsPg1/YIqA+Awn/x4qKe1+Ml5Tut3j4qE5t7koVKu/oc9w95zwsHYS73ih2hD8iBczVLwg4H4O/cInaWDPEcP8JC38zxEiVA4CIRFJP7q6lur1jDxfimtXto19KHCYQybY7t6MLhrLfvFDMytskeNivYYbLNt0ES+/ibxdU41UAkxocZlOsH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fc93e9-a3f9-4a28-f646-08df35b31483
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 11:52:17.1618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/VeE6wQ2U1SBICtxu3u8vmozOWOPwafJfa19JVpael+eIjv1YY8txtbZgR0Gy/gSpbaFfJFwp/quWYefXrNhZjjtuUS5bX3IFnqH4rcNI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR04MB993689

On Oct 23, 2026 / 16:08, Saravanan D wrote:
> nvme-tcp exposes /sys/class/nvme/nvmeX/queues/<qid>/io_cpu and managed,
> so a control plane can choose the CPU that runs each I/O queue's socket
> work [1]. Test that
> 
>   - io_cpu reads back a written CPU and rejects invalid values
>   - managed is read only and turns 0 once io_cpu is written
>   - an assignment survives a controller reset
>   - the queue directories follow the queue count as attr_qid_max
>     shrinks and grows it
>   - removing the controller while io_cpu is written completes
> 
> The test skips when the kernel does not have the attribute.
> 
> [1] https://lore.kernel.org/linux-nvme/20261018010059.83120-1-saravanand@crusoe.ai/
> 
> Assisted-by: Claude:claude-opus-5-5 [Claude Code]
> Signed-off-by: Saravanan D <saravanand@crusoe.ai>
> ---
> This tests the kernel series in the parent thread, which is under
> review on linux-nvme.

Thanks for the patch. The patch content looks good to me. I applied the kernel
series [1] on top of the current Linus master branch, and confirmed this new
test case passes. Good.

I'll wait for the kernel series get settled. I expect the kernel series will be
revised a few more times, and this blktests patch will need to adjust to it,
probably.
