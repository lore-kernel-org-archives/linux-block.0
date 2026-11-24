Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528239;
	b=t6Sl/14qHO5Mt8rChTo6auAmB00OaOoTHqIzooFkFYI61EjnB+dNJNYmlcCLOGAFaTzR
	 phX8Fp9E8vQDtM0uq99fF9k0whOhj7L39dRByU+Jx6MqFHonKxmdesHlpX6cKXDoIJGNA
	 DamnQ3VZS6Ih0Lyu1b8+r4hr+FC0iDZxaGUX/ucDFaBnZpFzybqYMDqJ0yA9i8XcZjajH
	 JcRV+U8ioc3OAjc7LBqSd95xXgO8r+8lLI1Hd/zkITT3Ef9Ve9YPQJlpzc5T9ABeWdcZP
	 LFcYgnGIHWTcWp8N/F3kYacpR/z4ydEWFIuf0g8sMKldWIaoWIkSId8ynlWpI8Gr5Kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528239;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:WDCIPOUTBOUND:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TcxFvI1smoRIQn6TfbrAKf5vuJtAFdP5L7q5qQnwBic=;
	b=olp++HkXddZd4P09dhiCuDtHK/VaOGsCYgE7IgUblQxsCnEXYjwpcWMkr/VM8pcxik3K
	 Vw2wtRHdcPj6HrxLKTOQcS0IqCI6wthVyuld4Oq+7ob6yjcDUPUXeKl+4dGNnk0Htlu28
	 eSrV7Fk4BRW7pNWJHqUAva29z4l//BhSIX4KcNHaRnSsmTVipotMqNjb8D/fxd2u7Y7R8
	 jjb+yIEpYi6ej6+Scdi1VvLEkyTxzrpvk0xJb8BNRQets6eRtFjQ2LEpASIIJgp20fzLv
	 Y8024Mdf05VH9fEVbok9wk0GP6VRh7IZCwk0rfiSmSV6cLRQT0pPZUglAHSSpYMkxTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=iLx9+MUw;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=mKo3Bwkd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F1606A32A
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 13:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C3F1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=iLx9+MUw;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=mKo3Bwkd
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795528238; x=1827064238;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=TmgaweWg1ERA+n+oBFwJs/TOpOZbK1nNdOf3b7/dSUs=;
  b=iLx9+MUwMmyOSP/3oeMWzG/2gNlWKd10W+fGPFycYMXm320NtcRUWRkI
   sdt3ohN3mcWOmEh7xg+59NjjBGvDSqXd7lT+fZ+9VHO9H1pdBpZ/18ecx
   wC5Eb+z6GigdlxMH90DeS95hW+2tQiLI4oeHl4mkIBS8l9Fzj0RUvsq38
   otH368EYyb6ZtOO7RRfbqPQzcIc5a44lilXSwL+WMMLl1juOuPz5TJkQy
   2c6o7Fjcn5fJmutoP/1xd+7y8+Ts8wFXiDC2hnqnDaHLHJqjepMHZVyWG
   OSrR8QkxQ5E91ATiLIYhaTQef2Eym85OQyEltAEh8Fp+MWahEsEYF706b
   w==;
X-CSE-ConnectionGUID: t7V/sRsQTR2/mwOoN5X4PQ==
X-CSE-MsgGUID: gscY6n/PQBS1YdwjK/tfTQ==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="161651037"
Received: from mail-westcentralusazon11013006.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.6])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:50:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vU5Si6L7WOuQ+0IXLapd3FJIqSwQOz3CqJzRAwwPImNsUaxmbEfhKgMMyNqrfPS74RBqlMfHQ7718RG2P/NSMssL9Hg67Ihy3eHJHARyxmdcOomt3zmEcF4QIB9nfuSZSBV9kK9AyR33A3xx6ucO9M6a2vQp4uB2BpvShYAfGYK/+jN3HAFaT9IMTFXImOg3V7h4fpavcLYMml2v1+qLh9d6B2PHCo3ozhHTpiNGeEGdJMvzkiOyKkx7GR/AXfAsZACEGJgw7wwGfkzBCwp9SnzDguCdU4Z3x4nvEgsgBuLdqq/DkRci+rhZ+Du9m6/pDjie0ciATQTBuu5azVQhgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcxFvI1smoRIQn6TfbrAKf5vuJtAFdP5L7q5qQnwBic=;
 b=Q9yjifJBnmEfL/0aE35Nno9n1p48YRCX2YZmvIkuOtu4//7uSSYCVTjfeXuHrOJXtQNJq0nYTez6bg8uxrVABAlWjFyzsEsVGxKiIBoJ1xSu7lZvAO6uSjTdp2QCK1tNTb/X+kBqfWyPjEtAOgc1fbnHbtG1PAmf9sH7Urw7h9l/Ru+RnSEE7Eb2Rnd8fcvtSRAN8jQ3W4CUbno0attyjxQR04KNgsimuLebTDKsnRGXgl9FbmHzGxKqtlAYXIJfgKsA+SsLjE7dFajgO9jjR5uGJb04juy+3mugMZcH79a7k20i5xPOydHJL8w/gPqbZf5Co11mDApzBwjCs5UaNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcxFvI1smoRIQn6TfbrAKf5vuJtAFdP5L7q5qQnwBic=;
 b=mKo3Bwkdk/MzE6aNGBuDDHOCKnuPE15WUq/lR5OFfxBvhp1ndlu/vp2QWVM9t5i7OVHy+V6JjEaLJRf/JctnTwrP3/ioP+4b01E2QVWiGY1shwiXoRZBESNdhfb/aCkUJ7B6W5CPtvPjVEqIUnIITStS3T/HZAgxNczl5ywavBk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by BL4PR04MB993740.namprd04.prod.outlook.com (2603:10b6:207:300::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 13:50:36 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:50:36 +0000
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 5/5] blktrace: test bio and request tracepoints record ioprio
Date: Tue, 24 Nov 2026 14:50:16 +0100
Message-ID: <20261124135016.153657-6-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124135016.153657-1-johannes.thumshirn@wdc.com>
References: <20261124135016.153657-1-johannes.thumshirn@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::14) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
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
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|BL4PR04MB993740:EE_
X-MS-Office365-Filtering-Correlation-Id: 558a9ded-c3d1-49fe-a5e2-08df4a31ead1
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|23010399003|1800799024|19092799006|10067099003|11063799006|56012099006|261026140227099003|261021121427099003|261102123227099003|261022113327099003|261009223027099003|261022105027099003|261022075727099003|261026121527099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fA6hLdzV0bwb+Zya2tNMc+WMFAQS8QuwFyZFaDWrGcBQJbtuje5tCwUyLMnL6/OAXXWMxtB9FWOFHZphfiWCUX64+omKqhOu8yHyrRNieoTd8uTCMXb8+SK9zStvkyrb/2xVNEAWeTcSr7Op++fPcuUquw7KaC9t35YCkBA6+XjZPcFBgv9HRsdJB8qV1OcFsz/PTDHbun3WA8Mlf99/WKBRQpy4ksyTUwaga7dUK0WTixWGNPISPFpJeZD+sQiMLyMa3HZlyO5M7mwcRhwaKgF9l9mgBeMvSdS2oudxWwE4D0jwriw+qnfFbYthKf8WDJ05MrsqXKAZYZQIOYijL1Zh3zbFnyh3Fo0CxbdEKeimT/cBEJ9vqejj/PM5YymFgLT6GB+QNmef0ZqnGNyHLix2dfHl0Wsoy38y6vQtUR72lDEfCEaZsH5QdHtjrxfww/C6aGlZegnwyhvV72MGcI3K4KKX9yZAGhTyGIzEPmO9NvaM4wvnFS3Y5UkwELyeevxOhOVcvyGKfHpb06D4clnsiyFjNEJrHuOn6bbLwG0uOfN1vaLTf5EgVOoLFxkpw8lWGznXZ17rbZi85aFnVW0KN4b7uwdC5AxeFFd3619UXUMxa2la7377mRM0XP3Hd63i0dh75q/nenA4TCAEkarHxE8n1JrqrrT665qNP3U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(23010399003)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261026140227099003)(261021121427099003)(261102123227099003)(261022113327099003)(261009223027099003)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4fgQzqQG8ohZb30jslxeOJSleUeNWbGdMNrvvzj9EuYGrUtOEz+I0/RzfIGJ?=
 =?us-ascii?Q?WrldIWK5O5/yTnBLPmhmRfMLlXXKOgoXf7KsdZXXK2ZC6WgvwCrVKElXIRdl?=
 =?us-ascii?Q?xF08ubWjsTh+wiVe/j8pWhIU6lFFtjgimlrJC4djb0QaX0kJV/iqd0+Y5TFo?=
 =?us-ascii?Q?Xfx5SgZQlOk46PGc0JbC8QXm/AsXWNChkJQg8GDmr8KffRLZLOoPrYAtrbmp?=
 =?us-ascii?Q?BV7p07MXCCp57psXNmMBp0aWFEQAfuTBP02AnrvGubERPM/qSdWmmw4RfYB+?=
 =?us-ascii?Q?Ae+aOGGLgx83YZIRdBxRlVUkCNv6YvXlPWZ5dOeKBaARoERp1TgEtcQfK11g?=
 =?us-ascii?Q?iajAfWzD1uO6tVHvjoaxGMqOovnB+Hhx+cRfwHChxGj7aZUweorNp22K9xf2?=
 =?us-ascii?Q?Ir2UeuRwixn63sx4jgHp1PcLaTVb4Sh67SwTNbu6TsGw72Zc9eVbojVxYQbA?=
 =?us-ascii?Q?5LFlqOic/txoEYZAIPJDa/rSyzgDR4fe1hEP24j+fqhqqeBkJze+uAZviWSm?=
 =?us-ascii?Q?LlQyTcbDY08aADSZqWKVwM5M/ZQe3wH+/6slbNtao0+DOYczskTlfyBaug7P?=
 =?us-ascii?Q?MXQWEnSaUugBTXwHfis5aVUlC7KSdzJnRwvLSVsHAtkA/kPjU9g9koABlbhJ?=
 =?us-ascii?Q?PSghuQw8TfjGGtb7156Z8nObxoWMuv00dnRt3wrTvsTe2NRCRLoSdctLOemI?=
 =?us-ascii?Q?db1pgsCiYV2YHM+xrlxJ0zuFCj/zispIaQeSmJK8cgFGFTCsR9kKDE5jUqGC?=
 =?us-ascii?Q?RbJUsSqv5LdxOc2qUgMvcq4sTA7eyLicVE0NUk6IJQG1Jmgz/U1W8Pr4eXQF?=
 =?us-ascii?Q?G5N1WMc91rsR7XZFFdHJEWW+eAqPR7ius+4IQGfaqtNTIcPUwMM1RFpos7ba?=
 =?us-ascii?Q?GND6nNrAHc8ouN2LZRPqmEGRU4cur/C/jz9lhU4M+JFV12wjZzkACTVlWOka?=
 =?us-ascii?Q?gzsv6bPujzpN7D2FrxOyBZAuIPXDGyfCzXJHzaK3MUkacKq4auXtV2EMA8qK?=
 =?us-ascii?Q?V/Ne3MFuD8nJ8pOvxilArFRNblHPNyVsvKYatVWetelcFzGhzNwYJ0mrK2QM?=
 =?us-ascii?Q?GUB/46Xw/xYZp8rgwsQMK77UG8f8uo3HXDQAtVI6Dkk81CcrhYAgbCvqmrq5?=
 =?us-ascii?Q?nBcSGanlKHpeu/h12NS8eLJ4jb7TkT5HNhVcsyjIuvsvhdpnCJuWa8yAtouM?=
 =?us-ascii?Q?LLpMBzy2iWrfjcyMCOTXPF+VFSZEAsUQclIH8wd+q5Kb8sdI36/m/MG5bkha?=
 =?us-ascii?Q?6sR4JL+o/xZKpMTLTksivT8sp2VlKMnuvqJZkWlxIxCNQ1I03XBu2tVGjrhh?=
 =?us-ascii?Q?2CmQ1q0PWCTjJmt0g2zaYkoVILz/61PJ0CDJjpk2MZ5jMKO+fy9AjXlEU73G?=
 =?us-ascii?Q?nyesnNNkXn5zyrxNmp0qlHRPXsYgbGjKRi9qSrWjM7diLFt+0EWCdGq7s1b9?=
 =?us-ascii?Q?O2kRlhqmHqQ6KXDK+J2/6DPDkPkh78SJYkr2TB/YXl1j0CFT2/nzksEgj/pW?=
 =?us-ascii?Q?VofJzk3wRuCnlc0B3O+23ziGM1n6eM7njuvO9CGlfElagZab++KOnHNPDYGV?=
 =?us-ascii?Q?QyOk944guMe/DXQASLjlxzKP0ukVKtDpoVTrP2qjIVoNMjgqr6263td9h6PL?=
 =?us-ascii?Q?dGARCwsR42EtsGKlcy9CMAI3YFoFcqcWxyTJTIc7LYBPC5dtz22O6qTcSrDe?=
 =?us-ascii?Q?Kr/jhLvT9bXkB8V64xA6TqS5Y9gwTjv9Yq6RFhVJtRA6Q/+lQ0/TqaNZed8v?=
 =?us-ascii?Q?E3j5YEcHPVK2hhKydUDlrosG/rUQLPj4S8ZX33BpBZZXlty7JkXRrsPozUAb?=
X-MS-Exchange-AntiSpam-MessageData-1: olPc+VfnBpOUsS5gfbEtTHK8XSc418vRkZU=
X-Exchange-RoutingPolicyChecked:
	GkVMUCCw2Y8wq7DDJRY4amvItGlKVQswYLE6vgqVK54kY+os4lOaGWA/MuFNyOUmDZ7do8qhJhBQjzhDo+czUCCP2E2iYSIuWWs5cIeyB3Y0PddJ/KyCxgLNVih5MdNJwjbuzKmkTSrOb2EOEdRW2FJLH/c3mVe9zS1G84OHEX9a64y6DKJdSMEU4gJ1ZpVTPn/Ii1jTb+un5w8GYrS8c5PrBI8UOKp6FNf3mEwRs6dFQk6AkTDoEm3eTKgzPjiebWS6w9MFL+u1Sj39aLw6ZXFWkEzksir3g1MRUWprzk028jdS7D/+X7BvwO2ncnO7NLQJpSI3dJOyuIATVsYs6A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Mea1zl6skUSy5+AlltevGH0mJQmcvOMc5tIO6TIADfTXWn2Yg4WUkDwQ0hx/JlNZGG5OTzrHnyxTRiH3F2s6cx4D/kndPsqkPB3kIfzYMyHXiB8+t1sh7jE1JkNvD+mYFclQ0Eq6El+Mc1zRCGZF2hyiu8eI6Gy0XtHAw6u2FC/mKRtaD6iQO+NUs6oC+KASgvzm7QtkGZirZZQWL7W6FqL8K9hKAJ6Mvc198LdiiC5kx9a/k9LX6pRbVJ4BZyW6dAEhm5fRsVbohYZjx172/InfX8cES5I0G2Fv1MJmdi8YfZ61O1S8YOgVfIHHHkfM2hEkVpxOEzAxfE/rIHKVo1j/S9gIT+0YaQQM1TwJ4oOd5Ltw5+Rm/Q3trIJ8ET9cHZU5S18Dq2EvWIOuyQfZipusJLvkAynnXCtPFiyZrN8xbHi8lnFIP0jhHPmteCi/xGpf+gYsnT6ev685in2fGX97AuVf/IA/GjQUOR+w9fbDXLbJtSGQ7iOsiCIa+oCXkZhftNfiwER/1SqjAQNZjp+G8jbiUPkt8S99zmbD6lazc5p/obXoj33xc3fZwI0IKhA77xmre9oxtNnZ9TMSnOVQr6pig27YJ3TL/BFOPou6z6r8ch8nNQS6YQSDgAPf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558a9ded-c3d1-49fe-a5e2-08df4a31ead1
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:50:36.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeyFGaP19BLaqTy3JpK2SuWnlD2WQjWV+fzmJJyzTrHUylmfNORdA6QnDs9ZQlWi7xSjLGMZt+NZxWnJn1xSEISyC37OW0lYG7/2PIQ/Pjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR04MB993740

Check that the bio and request based block tracepoints report the I/O
priority, including the CDL hint, as "class,hint,level".

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/blktrace/007     | 84 ++++++++++++++++++++++++++++++++++++++++++
 tests/blktrace/007.out | 14 +++++++
 2 files changed, 98 insertions(+)
 create mode 100755 tests/blktrace/007
 create mode 100644 tests/blktrace/007.out

diff --git a/tests/blktrace/007 b/tests/blktrace/007
new file mode 100755
index 0000000..cc2dd34
--- /dev/null
+++ b/tests/blktrace/007
@@ -0,0 +1,84 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Western Digital Corporation or its affiliates.
+#
+# Check that the bio and request based block tracepoints report the I/O
+# priority, including the CDL hint, as "class,hint,level".
+
+. tests/blktrace/rc
+. common/null_blk
+. common/fio
+
+DESCRIPTION="block tracepoints report I/O priorities and CDL hints"
+QUICK=1
+
+requires() {
+	_have_null_blk
+	_have_tracefs
+	_have_fio_ver 3 36
+	_have_tracepoint block/block_bio_queue
+	_have_tracepoint block/block_getrq
+	_have_tracepoint block/block_rq_issue
+	_have_tracepoint block/block_rq_complete
+}
+
+EVENTS=(block_bio_queue block_getrq block_rq_issue block_rq_complete)
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local trace_dir=/sys/kernel/debug/tracing
+	local dev=/dev/nullb1 devt ev lines
+
+	if ! grep -q 'ioprio;' "$trace_dir/events/block/block_bio_queue/format"; then
+		SKIP_REASONS+=("block_bio_queue has no ioprio field")
+		return 0
+	fi
+
+	if ! _configure_null_blk nullb1 size=1024 power=1; then
+		return 1
+	fi
+	echo none > /sys/block/nullb1/queue/scheduler
+
+	# Kernel dev_t encoding used by the tracepoints.
+	devt=$(( ($(stat -L -c '%t' "$dev" | sed 's/^/0x/') << 20) |
+		 $(stat -L -c '%T' "$dev" | sed 's/^/0x/') ))
+
+	echo 0 > "$trace_dir/tracing_on"
+	echo nop > "$trace_dir/current_tracer"
+	echo > "$trace_dir/trace"
+	for ev in "${EVENTS[@]}"; do
+		echo "dev == ${devt}" > "$trace_dir/events/block/${ev}/filter"
+		echo 1 > "$trace_dir/events/block/${ev}/enable"
+	done
+	echo 1 > "$trace_dir/tracing_on"
+
+	for hint in 1 7; do
+		_ioprio_read_job "$dev" be 4 "$hint" "$hint" || echo "fio failed"
+	done
+
+	echo 0 > "$trace_dir/tracing_on"
+	lines=$(grep -v '^#' "$trace_dir/trace")
+	echo "$lines" >> "$FULL"
+
+	for ev in "${EVENTS[@]}"; do
+		echo 0 > "$trace_dir/events/block/${ev}/enable"
+		echo 0 > "$trace_dir/events/block/${ev}/filter"
+	done
+	echo > "$trace_dir/trace"
+
+	for ev in "${EVENTS[@]}"; do
+		for hint in 1 7; do
+			echo "${ev} be,${hint},4:" \
+			     "$(grep -cE " ${ev}: .* be,${hint},4 " <<< "$lines" |
+				sed -E 's/^[1-9][0-9]*$/N/')"
+		done
+		echo "${ev} without ioprio:" \
+		     "$(grep -E " ${ev}: " <<< "$lines" |
+			grep -cvE ' [a-z]+,[0-9]+,[0-7] ')"
+	done
+
+	_exit_null_blk
+
+	echo "Test complete"
+}
diff --git a/tests/blktrace/007.out b/tests/blktrace/007.out
new file mode 100644
index 0000000..abf792a
--- /dev/null
+++ b/tests/blktrace/007.out
@@ -0,0 +1,14 @@
+Running blktrace/007
+block_bio_queue be,1,4: N
+block_bio_queue be,7,4: N
+block_bio_queue without ioprio: 0
+block_getrq be,1,4: N
+block_getrq be,7,4: N
+block_getrq without ioprio: 0
+block_rq_issue be,1,4: N
+block_rq_issue be,7,4: N
+block_rq_issue without ioprio: 0
+block_rq_complete be,1,4: N
+block_rq_complete be,7,4: N
+block_rq_complete without ioprio: 0
+Test complete
-- 
2.56.1

