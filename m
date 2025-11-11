Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AFD2D3A96;
	Tue, 11 Nov 2025 06:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762842239; cv=fail; b=Lj8JLyS82NLkNggn8wQ//RxtHHG+rXVmBJWfjZvvZiYlkT1thdI1H1Y80zkaBnl+vuC38GZslnB77qrjSpKxERQyGjnuXd1M4cFjROUPJ8LSmVankb0mtK5Wm5rTQy3FR2uvTjmXtyNyGEGYNf/SpItwJvzRORruvxcHDw2vOwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762842239; c=relaxed/simple;
	bh=AnOHDW/cXuYyHob9Wlu1jIi5HBj0BeOCmTROdgAPV5E=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iSEhGp9GsRY2DREmhpVDyUdVH5MoRFETRkPJG4htZLjTLYUeVx7Lk7xjLh98BqMmpN6aTf7FOMc8Gr3mRKbfPB2J96rvL4zPJmV3LvPocDk/pAr1UkwqCUJi5JnKcKpxj4jBIhwuv83VPMNmPJcmvKXXIWIc42iAazaTXaJa7wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K4bBBEp/; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K4bBBEp/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762842237; x=1794378237;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AnOHDW/cXuYyHob9Wlu1jIi5HBj0BeOCmTROdgAPV5E=;
  b=K4bBBEp/5DiJ3DCPLFtxfnUMouCWLM+xySRXhkUdkPSBvLCBU1/OH2rh
   755dBeKC/yW15S2h33/t5CRFz+sE0oqzKgo1DAMgt57TggBsPWcMA0HYt
   3vKaGmXluTxhnRXWq98240EYuPIEpQKw+SJnBo5lMyBQOw0ROTqDW5mkb
   hJAv+3ijbLlGldyODl0R8mK7HCrusfBZZnI3VP91bsAQJx96j4t49W4lE
   oMKeNiveccUOh3F0EqKTdYNWfKgWnAosfd7bnyqkK2AENV5spb4XmBzUz
   9M6Q4aSEiqhxM0CXs/a0irlGbBuUdAWXcMkmnLLzvDydDxXxzvAgRNVpo
   Q==;
X-CSE-ConnectionGUID: n7DQM7RLR0qY2MHELldu6w==
X-CSE-MsgGUID: gAeVA/1oQOqxHLn2rwbXkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="65056057"
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="65056057"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 22:23:57 -0800
X-CSE-ConnectionGUID: E+yr3WnZRX2v0jFZQIKJvg==
X-CSE-MsgGUID: LTG7uOWIRFK9qqP/XJndiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,295,1754982000"; 
   d="scan'208";a="189052171"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 22:23:57 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 22:23:55 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 10 Nov 2025 22:23:55 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.41) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 10 Nov 2025 22:23:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i33/mufM7Ltkw56EecoVUJTI68rCBY642c+jXVHheQloP3CfxeHULAA6DI7zZqnc1z88mUnKUde7iEuuOB1H47oLqtOlLpmsPxeL3jagzkP7y2FE7QXDH6HBz2RxhH4AtRuXuJqcdltMvOpFSC5Vqq9cF9w+b9M+CUlR01Tgcs3sn3HRX4vD5dc3eJ+YTnadl/70JJ2ku9T7d7iaZX2MCZDhqzd1i4nIEm8ubBXhhNuRDbeYrrJYPvGNRQFqNip1nlBmU6ErtlxqmTHQCPA5LBAZQ1bQM6U97eieEkZ/S22QM1RdYAKwMHl8D8T4STNUX3xDahZ7/vGvOqR/L+saeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAOezd1UU7bOQvR/z0LScyuouJXVstvtPxUMtSAdU0Y=;
 b=raU2MtjPUUoCqq5syiIyKddgNJ2Nsw8NaRC88wWuFks3xy3ffuvP0O1c25sVxdynqTtKJI2mu01T2CiVwSCntR7uW+Hj8m9o2/afBK7qXFegnF3I5B86E1CbgGjfipGERLGcMjQUPbZK8fj++5X7dNW0WQ0tys9ADlCQ8VZZ7VJLqIca39y688OAbJaqoRq6+BM5S28reRD91lWHUX0/nJXwTdQmN2ChyAOzh8sZ5sCMZXUq+7puQ+NahytoFtPOGQUUYXtJSOAa0DyBI/IajbcaW3drMNSdxh+Dy5ibApjZwDY9/yBDZDhQJTo/af3oNr8/dxUzVYamgHfWpUbyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM3PPFE441933A2.namprd11.prod.outlook.com (2603:10b6:f:fc00::f56) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 06:23:50 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 06:23:50 +0000
Date: Tue, 11 Nov 2025 14:23:39 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, Johannes Thumshirn
	<johannes.thumshirn@wdc.com>, Anuj Gupta <anuj20.g@samsung.com>, "Kanchan
 Joshi" <joshi.k@samsung.com>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [block]  ec7f31b2a2:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <202511111411.9ebfa1ba-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM3PPFE441933A2:EE_
X-MS-Office365-Filtering-Correlation-Id: fa05b7b5-c6f7-483b-bdc8-08de20eae0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zgH+xQAgg7yRMnAFIga80r8dJj2UL835VwJaOdeD/EEcYmFHbun0uiYb2baV?=
 =?us-ascii?Q?jhZqtQXcpSOvlrwfxULbtaylSe4ksaViUFzKj0+dHcEOMnF9kjh2qzZw8zKZ?=
 =?us-ascii?Q?ZyHGEtMk0olg7l0GSneGzQQv6UG3dqlNpTuuoJjvt8cFq8sye71fnPja+YzW?=
 =?us-ascii?Q?1DHjs0drgpRdnsWaGzC5nvSbyi+cEymE5ALyNTMJf2l+wSnzzYVIkpTZUYE4?=
 =?us-ascii?Q?NZ6rFX2Uf13024Mu9sm2dVU7hQAcy+8EJGMKj1i11dYZI1WWo/fUBfK8gyiz?=
 =?us-ascii?Q?DlHTURmJsEZx/HkBsqun3+X8zVtHvmCy5zZ4TL272IVJxfCXTW3W4qgxHZih?=
 =?us-ascii?Q?XXW1Xg0HVsE3y9zsshAKglRwZtdbX+6tsmBBB1TyfnRZkTFxfmzED/OuJY9a?=
 =?us-ascii?Q?cYOt88EFh/zrdKGyF/3YYpTsirhEnfho3UrmCR7pq2IpkLkuOoX0hnWK6nRh?=
 =?us-ascii?Q?1r+Bca441cKILlOuqGEVmOImiOLJ4cKAHPFXwjWPgBKdIySjGkal6CabgY9g?=
 =?us-ascii?Q?2tyN9GyHIPTxLSwWCQ89afa44y47MJHmr2msO/8Yv4VtnQwMvKffuRvJa+qQ?=
 =?us-ascii?Q?EPLEgUl/26iFMNxucD8n41AT6QW/sYvAsb4XCxBc6HlWyeMvt9jptopp2qmj?=
 =?us-ascii?Q?n8mKp9L+B73krPxGGKI/gzyZGYE6E6OgZjo55oI/mVa+mn1WTtcQrA1c3pcC?=
 =?us-ascii?Q?xk/ilxKEp4KuUlekiw/QDxkRa9d/Dw+sY1rhyjs6iE5gKjMMXtjlg7xRfAQX?=
 =?us-ascii?Q?DHhdvlQ9gKI+lnlvxeaXJFq36fpV78pbq58j8rNSDUgKrjV8Gx3um8Khai8P?=
 =?us-ascii?Q?WXswbYkSZb/gKFEZcVqloSiZGbGmxQCKVKiWOQ3+mM9BdKCp4AXBLusP9Mj5?=
 =?us-ascii?Q?4RxwQdtlB8VSN1gd9Qex9PAJQO7Kmbrau+/EKQHNAtqJvnS4y8mrUH7qmP/g?=
 =?us-ascii?Q?A81puHBJgx/9hyJZLbd6YTmuH5UW0bAq3YSC7xZ6593jzH6Y3RUmO7tV4YCy?=
 =?us-ascii?Q?V8NYSQS6mxLWvPS3TPr/I3XoX1ZhGeFHBjVJx2/yoQ0jWp7XxqSj4h8JJOVX?=
 =?us-ascii?Q?cWiiZRVoAckS2MGeki3VeMDC14qHV8z86SFUD5uIpr31BCYrj56CiEnIgq4Z?=
 =?us-ascii?Q?9Pq9YMV3jlAmukiWUthvuV4EmbPSltbOhdMfE4ifIB9yNWeQ+6RuCaxkaw5Y?=
 =?us-ascii?Q?rJ84M0MHkJZ2w2ruMR2NsRVONm70NJ9CLA3ZDdBJvVUeeI10PkK70LBhvE7W?=
 =?us-ascii?Q?SChNGHYI/2Ipb8rkr3eA0SbhZ15aXnxqsZqSJD2XwSF1s/E+zbBi68CAPdLO?=
 =?us-ascii?Q?RwzrRbYKPVHvBB9Wt8aG1LB66s/k7gB/mLu+5E0mCtMus/tZqLqR4jc8HYc2?=
 =?us-ascii?Q?gejrmr7WmANPbHXb2CwpyYU5CtD0r0vYdBD89nBkb3jOwQ1z+p422+u/azO8?=
 =?us-ascii?Q?Zs+LAGX4iOQcSrmYUgsvPztAxGWfO29jqOcDFBUMVWrlYaR5SxQW1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MpCjqAqUqvflJkIqQD3a/7kDOAoVTRKrI0OM1LIoxGWuxqzbzQtCYxqviqSW?=
 =?us-ascii?Q?DDouGI8yVLasCGrBLXKteJYE1woukUhf+wKmOreOOjM2s6r1SO5VvFSbsQrX?=
 =?us-ascii?Q?9rYIRMztRKNExSwqA2GumilPmyRDpif6QTxCFsqtl5FuQ4ATvEko/W3llBL+?=
 =?us-ascii?Q?oC70FoPqWV19dUJH4rzU5hnOEJGR7iB0ejnYdoK37jqSFK6ATPwxyJawTTlo?=
 =?us-ascii?Q?DZwxuYYxZAYQbT1bIs33vauMoO54LxTl5rh0XvkaX8wM6IAuK1d9kTq2Pr5K?=
 =?us-ascii?Q?gfamNu9J7ClZkXmbdRxUukd4o4oumG5NRNTR+fiRLHSlvNW1bKW9lSk4MyI8?=
 =?us-ascii?Q?oIvRSh/2lWa/YoJwpt2mrEy1k0B+sbbCEhQj9FPoRdCSTY3AZd7Hamq8aLkZ?=
 =?us-ascii?Q?bFP+Kovg3tcbHgWXxoywSIXsWCll3c5hSp3uTPRWJeIs7fZ+hzGMmYDR8U+y?=
 =?us-ascii?Q?FoBnwoD0rA5vpbONwtN6TjXmuXVpKA0vP7y2M3lSZW02LUOBRJ0HrdrUnQRb?=
 =?us-ascii?Q?Y5FPTslbJKQ5CGLiW5Bx1B62AQDvDAtXZrJsE6oIzJfw58wLGpj3zGAaZTzr?=
 =?us-ascii?Q?ET5WeDKqq9WHlYl/BNQb2BiWEpN4UQs1YgIpwgww/ztcxcdlJxyP4yg6F/LE?=
 =?us-ascii?Q?bgNNTTARcRArhtytIl364FKSf37FxE5YzhC+BbeeBQbrXjNVPvtFBvnAck2W?=
 =?us-ascii?Q?VNoQIpERk3Q6jv+K1qU4B4H0b2eZ4PIQcZxmQcPU4eyOfa8Qm8okSIkEJ/xM?=
 =?us-ascii?Q?RS70aTQsz3LXgBRRv6hkEMSZ/KqZx6hiuYewxlUVHM17urobdBrcxqIThpOm?=
 =?us-ascii?Q?LMQrNtXi8XT7wrljAbYsqfhpn8jyDuCRhc0aeK6RWuugfCr/jPRMPeH1XH08?=
 =?us-ascii?Q?Dp63WHVnJ+JUk2ZrQk41fEQVDkApGjMRih1/w2/T0Zt09sXyO/MRwGRP6n4O?=
 =?us-ascii?Q?0z9o5TnTJQj3TlR6aEC3ESMHMlTryBjGoYca9mhf++Rdrp4Wv1oHaow3gogw?=
 =?us-ascii?Q?cGAlalXMgorbSoe5tZ3YZTjZsoNE36Z93GMm9150H8HRSBkg6shbYLx4xk8E?=
 =?us-ascii?Q?BNcUznS9QKZZ5KN2GvCChkxUyLiF2SAUpzvi+1/ZuXNqWEGFYqrvznreAgOC?=
 =?us-ascii?Q?Rq+X8ghxZPaqS+2p2vEqO25vsrnlGQMY9eo1hsji4Yx4EHHAOV+P4uLI4VTQ?=
 =?us-ascii?Q?8HF2PYxFB5/HNNpM7ZSDUXHeufjW1anNdari0arXdBXoDIUBPTG8cmsWDxZX?=
 =?us-ascii?Q?I3X+zaIhN40c7VWVwBHP2Ns0wPGbgwbZZWPbuDDh/H1/AS11TUQveI5oCCi9?=
 =?us-ascii?Q?1WlV6laemu8/JBGADD75lXYchPF7RlK/qtRyxuhScHEEnLPQcZ7ZtYNQ8VNB?=
 =?us-ascii?Q?jvScfZlF6qE73pNfs/ZeRx/CcGyFCcBgSIursqMbZIskCRhvTMVkDCfBZvy+?=
 =?us-ascii?Q?S1C9+eXCdY1QlZs4gKAxY07xq9hvO3tr4IQvQQ3hh4kttNMVLusdwk+wlMEa?=
 =?us-ascii?Q?fo7UN9jxgLsMQORuYS8y2fl3/47pYfjgWxTqsMUmUYZrw3NybiFJvZd9V74V?=
 =?us-ascii?Q?GjNF4h3+BAfDb+3/mYRl3pzC6An3l4frNw90rFMNVtcbPzybtRuM8RKAmScq?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fa05b7b5-c6f7-483b-bdc8-08de20eae0ca
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:23:50.2341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYkdatDArTxupw/8CtjnrwVTCpwnmnImXkFw7n50KL8/ue1I4VNmypgThEHTQw1S0BZqKYIpJD+mYnXqjMtLwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE441933A2
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:unable_to_handle_page_fault_for_address" on:

commit: ec7f31b2a2d3bf6b9e4d4b8cd156587f1d0607d5 ("block: make bio auto-integrity deadlock safe")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 9c0826a5d9aa4d52206dd89976858457a2a8a7ed]

in testcase: boot

config: i386-randconfig-016-20251107
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------+------------+------------+
|                                                | eef09f742b | ec7f31b2a2 |
+------------------------------------------------+------------+------------+
| BUG:unable_to_handle_page_fault_for_address    | 0          | 6          |
| Oops:Oops:#[##]                                | 0          | 6          |
| EIP:memset                                     | 0          | 6          |
| Kernel_panic-not_syncing:Fatal_exception       | 0          | 6          |
+------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511111411.9ebfa1ba-lkp@intel.com


[    1.770141][    T1] BUG: unable to handle page fault for address: fffba000
[    1.771287][    T1] #PF: supervisor write access in kernel mode
[    1.772177][    T1] #PF: error_code(0x0002) - not-present page
[    1.772326][    T1] *pde = 03171067 *pte = 00000000
[    1.772326][    T1] Oops: Oops: 0002 [#1]
[    1.772326][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T   6.18.0-rc2-00031-gec7f31b2a2d3 #1 NONE  a1d066dfe789f54bc7645c7989957d2bdee593ca
[    1.772326][    T1] Tainted: [T]=RANDSTRUCT
[    1.772326][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    1.772326][    T1] EIP: memset (arch/x86/include/asm/string_32.h:168 arch/x86/lib/memcpy_32.c:17)
[    1.772326][    T1] Code: a5 8b 4d f4 83 e1 03 74 02 f3 a4 83 c4 04 5e 5f 5d 2e e9 73 41 01 00 90 90 90 3e 8d 74 26 00 55 89 e5 57 56 89 c6 89 d0 89 f7 <f3> aa 89 f0 5e 5f 5d 2e e9 53 41 01 00 cc cc cc 55 89 e5 53 57 56
All code
========
   0:	a5                   	movsl  %ds:(%rsi),%es:(%rdi)
   1:	8b 4d f4             	mov    -0xc(%rbp),%ecx
   4:	83 e1 03             	and    $0x3,%ecx
   7:	74 02                	je     0xb
   9:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
   b:	83 c4 04             	add    $0x4,%esp
   e:	5e                   	pop    %rsi
   f:	5f                   	pop    %rdi
  10:	5d                   	pop    %rbp
  11:	2e e9 73 41 01 00    	cs jmp 0x1418a
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
  1f:	55                   	push   %rbp
  20:	89 e5                	mov    %esp,%ebp
  22:	57                   	push   %rdi
  23:	56                   	push   %rsi
  24:	89 c6                	mov    %eax,%esi
  26:	89 d0                	mov    %edx,%eax
  28:	89 f7                	mov    %esi,%edi
  2a:*	f3 aa                	rep stos %al,%es:(%rdi)		<-- trapping instruction
  2c:	89 f0                	mov    %esi,%eax
  2e:	5e                   	pop    %rsi
  2f:	5f                   	pop    %rdi
  30:	5d                   	pop    %rbp
  31:	2e e9 53 41 01 00    	cs jmp 0x1418a
  37:	cc                   	int3
  38:	cc                   	int3
  39:	cc                   	int3
  3a:	55                   	push   %rbp
  3b:	89 e5                	mov    %esp,%ebp
  3d:	53                   	push   %rbx
  3e:	57                   	push   %rdi
  3f:	56                   	push   %rsi

Code starting with the faulting instruction
===========================================
   0:	f3 aa                	rep stos %al,%es:(%rdi)
   2:	89 f0                	mov    %esi,%eax
   4:	5e                   	pop    %rsi
   5:	5f                   	pop    %rdi
   6:	5d                   	pop    %rbp
   7:	2e e9 53 41 01 00    	cs jmp 0x14160
   d:	cc                   	int3
   e:	cc                   	int3
   f:	cc                   	int3
  10:	55                   	push   %rbp
  11:	89 e5                	mov    %esp,%ebp
  13:	53                   	push   %rbx
  14:	57                   	push   %rdi
  15:	56                   	push   %rsi
[    1.772326][    T1] EAX: 0000006b EBX: 00000015 ECX: 001fefff EDX: 0000006b
[    1.772326][    T1] ESI: fffb9000 EDI: fffba000 EBP: c611fbf0 ESP: c611fbe8
[    1.772326][    T1] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010287
[    1.772326][    T1] CR0: 80050033 CR2: fffba000 CR3: 0316e000 CR4: 00040690
[    1.772326][    T1] Call Trace:
[    1.772326][    T1]  poison_element (mm/mempool.c:83 mm/mempool.c:102)
[    1.772326][    T1]  mempool_init_node (mm/mempool.c:142 mm/mempool.c:226)
[    1.772326][    T1]  mempool_init_noprof (mm/mempool.c:250 (discriminator 1))
[    1.772326][    T1]  ? mempool_alloc_pages (mm/mempool.c:640)
[    1.772326][    T1]  bio_integrity_initfn (block/bio-integrity.c:483 (discriminator 8))
[    1.772326][    T1]  ? mempool_alloc_pages (mm/mempool.c:640)
[    1.772326][    T1]  do_one_initcall (init/main.c:1283)
[    1.772326][    T1]  ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
[    1.772326][    T1]  ? sched_clock_noinstr (arch/x86/kernel/tsc.c:271)
[    1.772326][    T1]  ? local_clock_noinstr (kernel/sched/clock.c:272 kernel/sched/clock.c:309)
[    1.772326][    T1]  ? __lock_acquire (kernel/locking/lockdep.c:4674 kernel/locking/lockdep.c:5191)
[    1.772326][    T1]  ? kvm_sched_clock_read (arch/x86/kernel/kvmclock.c:91)
[    1.772326][    T1]  ? sched_clock_noinstr (arch/x86/kernel/tsc.c:271)
[    1.772326][    T1]  ? local_clock_noinstr (kernel/sched/clock.c:272 kernel/sched/clock.c:309)
[    1.772326][    T1]  ? local_clock (arch/x86/include/asm/preempt.h:85 (discriminator 9) kernel/sched/clock.c:319 (discriminator 9))
[    1.772326][    T1]  ? lock_release (kernel/locking/lockdep.c:353 kernel/locking/lockdep.c:5542 kernel/locking/lockdep.c:5889)
[    1.772326][    T1]  ? clockevents_program_event (kernel/time/clockevents.c:?)
[    1.772326][    T1]  ? ktime_get (include/linux/seqlock.h:391 (discriminator 3) include/linux/seqlock.h:411 (discriminator 3) kernel/time/timekeeping.c:828 (discriminator 3))
[    1.772326][    T1]  ? sched_balance_trigger (kernel/sched/fair.c:?)
[    1.772326][    T1]  ? run_posix_cpu_timers (include/linux/sched/deadline.h:15 include/linux/sched/deadline.h:24 kernel/time/posix-cpu-timers.c:1123 kernel/time/posix-cpu-timers.c:1428)
[    1.772326][    T1]  ? clockevents_program_event (kernel/time/clockevents.c:336)
[    1.772326][    T1]  ? update_process_times (kernel/time/timer.c:2481)
[    1.772326][    T1]  ? tick_handle_periodic (kernel/time/tick-common.c:120)
[    1.772326][    T1]  ? vmware_sched_clock (arch/x86/kernel/apic/apic.c:1052)
[    1.772326][    T1]  ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:80)
[    1.772326][    T1]  ? irqentry_exit (kernel/entry/common.c:224 (discriminator 32768))
[    1.772326][    T1]  ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1052 (discriminator 6))
[    1.772326][    T1]  ? handle_exception (arch/x86/entry/entry_32.S:1055)
[    1.772326][    T1]  ? netdev_bits (lib/vsprintf.c:650 lib/vsprintf.c:695 lib/vsprintf.c:721 lib/vsprintf.c:1787)
[    1.772326][    T1]  ? strlen (arch/x86/lib/string_32.c:167)
[    1.772326][    T1]  ? next_arg (lib/cmdline.c:273)
[    1.772326][    T1]  ? parameq (kernel/params.c:90 (discriminator 1) kernel/params.c:99 (discriminator 1))
[    1.772326][    T1]  ? deadline_init (block/bio-integrity.c:482)
[    1.772326][    T1]  do_initcall_level (init/main.c:1344 (discriminator 6))
[    1.772326][    T1]  do_initcalls (init/main.c:1358 (discriminator 2))
[    1.772326][    T1]  do_basic_setup (init/main.c:1381)
[    1.772326][    T1]  kernel_init_freeable (init/main.c:1597)
[    1.772326][    T1]  ? rest_init (init/main.c:1475)
[    1.772326][    T1]  kernel_init (init/main.c:1485)
[    1.772326][    T1]  ret_from_fork (arch/x86/kernel/process.c:164)
[    1.772326][    T1]  ? rest_init (init/main.c:1475)
[    1.772326][    T1]  ret_from_fork_asm (arch/x86/entry/entry_32.S:737)
[    1.772326][    T1]  entry_INT80_32 (arch/x86/entry/entry_32.S:945)
[    1.772326][    T1] Modules linked in:
[    1.772326][    T1] CR2: 00000000fffba000
[    1.772326][    T1] ---[ end trace 0000000000000000 ]---
[    1.772326][    T1] EIP: memset (arch/x86/include/asm/string_32.h:168 arch/x86/lib/memcpy_32.c:17)
[    1.772326][    T1] Code: a5 8b 4d f4 83 e1 03 74 02 f3 a4 83 c4 04 5e 5f 5d 2e e9 73 41 01 00 90 90 90 3e 8d 74 26 00 55 89 e5 57 56 89 c6 89 d0 89 f7 <f3> aa 89 f0 5e 5f 5d 2e e9 53 41 01 00 cc cc cc 55 89 e5 53 57 56
All code
========
   0:	a5                   	movsl  %ds:(%rsi),%es:(%rdi)
   1:	8b 4d f4             	mov    -0xc(%rbp),%ecx
   4:	83 e1 03             	and    $0x3,%ecx
   7:	74 02                	je     0xb
   9:	f3 a4                	rep movsb %ds:(%rsi),%es:(%rdi)
   b:	83 c4 04             	add    $0x4,%esp
   e:	5e                   	pop    %rsi
   f:	5f                   	pop    %rdi
  10:	5d                   	pop    %rbp
  11:	2e e9 73 41 01 00    	cs jmp 0x1418a
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
  1f:	55                   	push   %rbp
  20:	89 e5                	mov    %esp,%ebp
  22:	57                   	push   %rdi
  23:	56                   	push   %rsi
  24:	89 c6                	mov    %eax,%esi
  26:	89 d0                	mov    %edx,%eax
  28:	89 f7                	mov    %esi,%edi
  2a:*	f3 aa                	rep stos %al,%es:(%rdi)		<-- trapping instruction
  2c:	89 f0                	mov    %esi,%eax
  2e:	5e                   	pop    %rsi
  2f:	5f                   	pop    %rdi
  30:	5d                   	pop    %rbp
  31:	2e e9 53 41 01 00    	cs jmp 0x1418a
  37:	cc                   	int3
  38:	cc                   	int3
  39:	cc                   	int3
  3a:	55                   	push   %rbp
  3b:	89 e5                	mov    %esp,%ebp


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251111/202511111411.9ebfa1ba-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

