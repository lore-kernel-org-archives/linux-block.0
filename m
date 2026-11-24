Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528231;
	b=ShHT8vkENwpm2GWXJtlhMrF9WhFBxjXMGUmPOnNiRs3ZCep12zP1LxIOTxr7RNZy68j1
	 DEbwmfbJNs8zoxSaWkk2LNgETzvfQq7swwRh4O/WXUYhqRJgKhNVwjUZSWKLKUQQyKDe/
	 6aU6HJfyE3/bW9HYqMCMc+8q0jfnqRTiQehg7Zw/ZCRf0WpqP0JVdNmb7XqNPf5W7l7IJ
	 wObVWYX6bW3cDW0v8ZASxmLYd/zsgLbNirCIAcXNzXIP8vMWSrX1iYUlfXKir2EMZdEIj
	 yBQ2LJVbEfjUIvMAMtIo+uk8w1SQGxKm+5mAKrK0gNhydSNeuVffcB3Go0QWvFr8+yA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528231;
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
	bh=XB68ighT7h/bKMXcuLH6jaC1TdN4kpyp0Brr/Mc61oI=;
	b=efSlQzmrgv1ncp/ZoKntzq5sDL+RZJr3hIBZbIqdZt9kqgeN664l/b1Hzod/XTc7LlF4
	 pK+M4UoT5MI8I06hTaHSvfQIlT7mOPSRF3ZXkK9WS0MYEV2V8txrme3KVtQcvrJmccKa4
	 LWWF4pKnPk2xvL1VN1i1FLF5zqdg63wPKzucOiwxXh/+e0cZy0DCPWLtduqgdR6W9CrHl
	 aV/3beW+8P/mmunE6iBzx3JSn4W3nMi6Ti2Yp+U7EwH89Ra14JDhBz2VAsqXJ4MbuK88j
	 IuC60YJ1HoKl5PVh18PlBB7ZVag55FC8cxwLXRB0gjkvW5yohOoMq0AsN4DBiCiI0xQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=CyZPhgTO;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=XOrHOX0A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573B8606A322
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 13:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 573B8606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=CyZPhgTO;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=XOrHOX0A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795528231; x=1827064231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=I8CKYHpO0ub+AjyVpt0fTEQdPGC6UXqw5DrQcngkzUo=;
  b=CyZPhgTOaBJgDFQKxleX+QwCy66WCZhRWlMUroQssqCTRwGt9/i3p6Jd
   dWf5XY+FkG/mRl99mbNFN9HeUDvA+Jgqhtwwsze/Em2RGSrH3P+bR0KQ5
   rZKrDclyFzgWlcJVv8n+DcKsgXaqbNUzWJPmGpYwX7yLvJtcRWtVfguGJ
   ZZLaxgb2gu8qYLW1SBuqCViHRKUlqvczEgxnOiQBqIJrrO2hXUSb70hH6
   lLdWt4RuGCiNIblJlQN/ALnGwq1G9yLtnORF2WdKwtQwbPR62eRsFrORv
   ak9PYHeqQf2c/Kbjk/tSCEUTAjHAdqLuRe84eaOMvWMYxLTgfVokot1/+
   Q==;
X-CSE-ConnectionGUID: M+fLZJEHSlOVZV4Xazsj5Q==
X-CSE-MsgGUID: z/j1crcQRMCbD6CdevFBsg==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="161651018"
Received: from mail-westcentralusazon11013052.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.52])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:50:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sc9KAZ12FJPrAxnJyiI1pAs5eZNBXRDy60NXFkkdXHMsd3GX/57PUpiyuzB5C6N+oULmWonxtjqgFw0vDoFL4uf1X/MtjE+Ckz3yDrPw8vD7u3hEf7EDx7aW8cvVGPTZaZVYmHg+WDpyzT6tV/HXijCi2k8thrX9MxXi5uUE0Jmnk1Uspw/jpW87nrnVgaNDYHZNKWhuqIbhLsVPwFAmsWPtwYb+yak9jA82875UT1jX4dUlV5ZSIixJXN7jny094mECqDevJ+tOyHr1EDuyGtKTypk+d92CogNE9gMUxRx9HOQWVQIq9o/jFKTp0D3bHwX9/2aM3Efa7XU9wiyCTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XB68ighT7h/bKMXcuLH6jaC1TdN4kpyp0Brr/Mc61oI=;
 b=QQ4kFdQ+Cg81VikNBCC/XtZGSMunX66L4wfbOY8cbYjtdgVBE1Y4+usc1xo+dxdm8YzW32XdxI2tL/oKTvq+psh+hIrrOHOZVzHwEQx1DjIp9R+C8RSe9araBXXwFvg5wLPg/e0TWd/y4WDpoOEKYf06OnGPndSOuONy3RlXVd0D9KZQ2uHq+tGSF9ftTbyN3BnXkyXcbRJb1jj0GIq6ycqjSNCwwFZRz3xVdRy6ywSj4B/FQ8m2A8DjSu+kfjst9BAhAF1plqYg6yD5WIib1XTsyGFsoXEQhwTzFxge49FzxxoRHJVX31z5ChHA7P4Ebs7v3VoIWP9Ng8af5SjD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XB68ighT7h/bKMXcuLH6jaC1TdN4kpyp0Brr/Mc61oI=;
 b=XOrHOX0AgFs5Zlh77ofNFacZk/WgGkX4vwGvJrU3nH7Kio5oaWkjhz4Ll0H5s0fdEgMcmd1FjbuasVWmvySKGtDBNxOQDAwtd3yJMYswM9W0WJP/pfrpwKUO6e7R/8aI9f+gFVxQ7aujz51ZFdJ119QRXI5F+GyFAy1Et/+BOek=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by BL4PR04MB993740.namprd04.prod.outlook.com (2603:10b6:207:300::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 13:50:29 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:50:29 +0000
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/5] blktrace: add blktrace ABI compatibility check test
Date: Tue, 24 Nov 2026 14:50:12 +0100
Message-ID: <20261124135016.153657-2-johannes.thumshirn@wdc.com>
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
X-MS-Office365-Filtering-Correlation-Id: f08b52f0-befa-408c-591a-08df4a31e6af
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|23010399003|1800799024|19092799006|10067099003|11063799006|56012099006|261026140227099003|261021121427099003|261102123227099003|261022113327099003|261009223027099003|261022105027099003|261026121527099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Z9U6ePp3k1cM1virroEn/LkkZ3EChWoEmz2YXB+0IJ72oLf10cu58VjuobiIuhF3lFW+fqEuTCQ43DeiiCkIpWm59rmg/DbhvSNdegHIgXYgU1jDEWSwcIC2PnbsU5m9yLEvRqRREj6igRJcgTJHCcphOrxyExI9DYmRlmrwfKwprcPJlEjiYQLgTh9wzgv670Et5SDbCTUylW34JHltFYZ1JqIu6BcZA2/6zVxqMr5PRCZnJxNep2mEIzetw1M3giP4gLVaYe1TkjARuA65mzRONnV7S4ZTVNo9P8Va86uVRcjVHkZgG2njD/IRUCLxwnIth/UVGWz1rc3ttdfw9WeIdZP/1QaGBzSFVC2ZIRWP2Lf+ci+5PehJ2Q6mpqMBXJsH0ojXx2pdtElk0S5Y8hhUYLibVwdkvPPRhh80ZWXWpBXB3IwQlXIdMH++EaG5BEV30K91Ak6aPnTl/WjuxeVVshDUMcaPenq/HUERh1rj8HemH1lfhqokMygrT6kb+8ELT991gT13ny887dI+XEyxukAoFcKU2DTdKQLdyexfawAsqE4rmZLuBFP9h2rukJqsQkuyM5aKBb7QcAYXRMebK/rjuKNdd3q663Xr4M/wGDyg+ac0voeILuwDKTjFCGimy0nsGcgP8VgvXel5KxYXxS5K+JMeWG0u2gOpKbY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(23010399003)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261026140227099003)(261021121427099003)(261102123227099003)(261022113327099003)(261009223027099003)(261022105027099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SP/qqyWmJe3dLSlETvFv2d6LBad7n9pSERK76aCn82vM1sHVbUWSqQJ2mgVr?=
 =?us-ascii?Q?AvokhGBgmrAJZyXbDnKspI+nbirgTrvw3Lpvkv8MvW2busX6uTkppDEs877g?=
 =?us-ascii?Q?0XFx2abw6BwotS6fPIvGNPUy0GDYg//ZyREJMjjRbqKTNPOLf/8r4NPe9Z7q?=
 =?us-ascii?Q?y6aXvu8+0kCEDPrTnJNUnv4VcOKmAh5SMZ001KHypd0KVYobnxF//XmICDe3?=
 =?us-ascii?Q?AEgMLuJNMlzxyC9ymQ5ngarqE67kQekFxd5V7Mg8XOkQxEkWYb7u7x+jL2ZE?=
 =?us-ascii?Q?nAifSKfENJizXtl0rlGraTw8l7E9Vq3BnRPl4/x2JqjD25IccLlMNR7FvmX1?=
 =?us-ascii?Q?/z9ypIFdPJASdnl7wA4ee2rVv1YdTCnKJOCzNmTC3qI1/dbzZqm5KsoBI6D1?=
 =?us-ascii?Q?wYIc/SlDjpQECgcYiOfJXIDj0MUjMLo41FP0AAPSRpQ6CNQw8tWkULfLpy0K?=
 =?us-ascii?Q?Vh2kA8UTP91t0mDMv2EvFxuwvfYkXuKGtVy3EaHKuyrllfmfNIT8VIK55NIk?=
 =?us-ascii?Q?sXuhLlZIkaHKziyNt38OSu5zgqJUIjOE/FqPZXBbAmOI2DdwhgwFbGaXfzVZ?=
 =?us-ascii?Q?c9AVc6D3OLVoqHzy6a7Bd45NbUYUfvCT92LUOUoyQkU8KSoqV9COyexNGqVF?=
 =?us-ascii?Q?xmvR6zdWvcU35QM9m9v3q4Md1pSCF5G3AI4vwXwkYV+DJGMjFh+ul73qF4l8?=
 =?us-ascii?Q?K7w/dmhmyKWZ8DiNjgCYyTbRxEn1ofEj/VZoILoDDMUIkFt4c3zSBdMvezYo?=
 =?us-ascii?Q?b7YbAt8LTCMeMl6II9guVikCRPuQgGnY139v7TDZkxqxE7CHwtD/+O4Q4s0m?=
 =?us-ascii?Q?+v444M6L7VoIJMJOWtTre8SDLynVdT5EmQjMQaGHZJ4i3YDqY7jXHMJskOmc?=
 =?us-ascii?Q?xxfUIkp7i576qGyVdiuiZOudyOmstTCk8EArZKc+i1G7Z6K5elC0VBnmm50a?=
 =?us-ascii?Q?NsnXY91YjV9HZhVWKmGrlMBy7YSxRBIrYuMiN52ISD9aNk/x+i+g75yAPigz?=
 =?us-ascii?Q?e0xZg3PPTsZba8be838WhqQkJ4rCiaF7oeCh7m1u/EqgbCVc7hCdJUCsKPAX?=
 =?us-ascii?Q?aXifhVy8miZAkJf0ZyKPxgTGIvDC9LJoE6HYzz6bVqNm2QiufQ0JIvewdfMS?=
 =?us-ascii?Q?Iq+1/BU4plPpjy9dCkUmcecdowVujdpoeQ+fDG3Hq/tYu9XX8NPxNkaGT4X+?=
 =?us-ascii?Q?JrlGIQXl52dwSUsTtNIQPjRs8lUz4KqwoFqEuBfHb/lA0MlXbcI1TZEzrLxS?=
 =?us-ascii?Q?U9DgfaN3ALZLFVhZG17+s212WZkhqpaNHXT4nsiRfnxhYj8oCIws9GRT+3aG?=
 =?us-ascii?Q?ShTz4XrgSMXcJhyduj4Weqs/KtBO8yP+BjPgKHLWZAVYEtSJAY+j4Xsfjcq1?=
 =?us-ascii?Q?KqmUQQND59s6pjRxxczI1v82MCJkX7O54MMtb9jiprRi7s3eXm2siFigXv1j?=
 =?us-ascii?Q?b70plhi7e8iXL1XZzerqenEYQye6AVGj3razbSxQPy0P8gdnPctWIcP8B1IR?=
 =?us-ascii?Q?YrtSI1or0Cyc1ESGVNKdgGXR84ascHvt0HL5wbKLN5L/pVCTsEHEUF7Ya3R9?=
 =?us-ascii?Q?721L/4C/aoAl1427KcbH/2yKaaAOqCmbxio3/bFi0zxM9pL/49B1AEEmsGhy?=
 =?us-ascii?Q?DnpVUOfeAVy4ymK5sf/gYjntWpg6L9lyBMcBBcJD92l2gA0Ngjw44XE+zvU1?=
 =?us-ascii?Q?uc1ZZDkj/NDTXQPjJu9pDEfKFLgr4zhrtbozIjNUN9O7/ngNW6LCNfF8u9g6?=
 =?us-ascii?Q?DZQwe7DWGCM/WpIBC74TleTbX0//Ikmd2ymQx8G+y1+9akURTu/8fUXmstJd?=
X-MS-Exchange-AntiSpam-MessageData-1: Shfvi7C0buY4N1QNqUKOFdeA0HaTaq+MIZQ=
X-Exchange-RoutingPolicyChecked:
	olXab/8gSLIWGKP+Zr8o9Gy6nzk2CFfO+L9C6ujCNkC7lUaqmjPXhe1RaYUiO9kJiWBIF04cTOo9pIOL00VALVnIaE9V5UZgGtxzQVclo9dp7jIbfYLaq/F+oxNlVEpRiEmIFJqmODCC4ejqPNCBeL5kbnBsVHaUM7Vs6FOgKZ8MIN50FC7kzIuLX2iEsJ2KpWiqKnX+7wha2K5aoTRUthhvma5J3Ivk58ItoivsP5m9wI0rzyY+Ig/6GyyisV/Xk8p4MmrmJWbKZCxlAGmdkdlCq3daByUKaBoRkwNnly7fTPk8TCYuBg/hzMaoILa7LuGeotWj8raTYipmE2i6Rg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X2NyT7jzdZk04WLC13vXhd/mxCrKwebBovPU5YZa7gcagK1gHnL0gUZXx0PNRHAR8KIHo6T6ewt7zv+at7m9ZGFz8ClgJCraymf0g46frRTKzLdvHbaUZ3n4zQnjpmFwdmkLziYdjF1mNIk4dd4z6tR9Xhnr1BzKd0nuEjh6+QCGnNU9ezWtT9UQEIcuWFJg0VLNPWAyVL0srk/YygYdeWdxfMmLvQMb2H/YIbE9XykhSWVOF7wV7fT/dqw3enEc6HF8tyCBBXgY33x3TVEkmlyVmEVD60zVY7eobx46BvtCZLngoBfsyYT7JdslfmNY7OQGA5UCk1qEc5j6x76DrD/2G3iFl9KxcQly9HBD4BPOcl3NmQUP8Y+1x1exNem7NKW8I06f0Q0AXLkDh0RPRypAa/4lqCV/gVGru615JJ5UZ7gXaoMNxTf7Bf0gi+Eu1aQ8LjvaTbyqVbYofUfwTsOVtmyB0gg+whchOSthJiE2JO2bVYs/Md7arJdR1PT5UMsoaXtQr2qRVbTNw1ykz+Fdlkph7TFzvdGMBSPiKUKW1Tc013DK7pZKMod7auQi/uXOSsarz7uBAk0Ep4e0cn2LcgOyPJ4J7OMyStY1kNjRqsU5u8IW9vrm7iodm4UV
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08b52f0-befa-408c-591a-08df4a31e6af
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:50:29.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +O+bKmrq6eKTLihUvGD7VGy4b5fkYAWMbOg/ueU81psifaKSRB/ZaT2yKPEayPRQgk2TGIFY7qSN86MJLCYvQsrTEH5BiA/3QTp7g++EPSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR04MB993740

Check the BLKTRACESETUP2 flags ABI: BLKTRACE_FLAG_IOPRIO is accepted,
unknown flag bits are still rejected with -EINVAL and the existing v1
and v2 setups without flags keep working.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 src/.gitignore         |   1 +
 src/Makefile           |   1 +
 src/blktrace-setup.c   | 108 +++++++++++++++++++++++++++++++++++++++++
 tests/blktrace/003     |  51 +++++++++++++++++++
 tests/blktrace/003.out |   8 +++
 tests/blktrace/rc      |  26 ++++++++++
 6 files changed, 195 insertions(+)
 create mode 100644 src/blktrace-setup.c
 create mode 100755 tests/blktrace/003
 create mode 100644 tests/blktrace/003.out

diff --git a/src/.gitignore b/src/.gitignore
index c299ecf..cbe70ec 100644
--- a/src/.gitignore
+++ b/src/.gitignore
@@ -2,6 +2,7 @@
 /bio-bounce-read
 /bio-full-trim
 /bio-trim-pin-leak
+/blktrace-setup
 /dio-fallback-race
 /dio-offsets
 /discontiguous-io
diff --git a/src/Makefile b/src/Makefile
index 5af0c9f..e5888b8 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -17,6 +17,7 @@ C_TARGETS := \
 	bio-bounce-read \
 	bio-full-trim \
 	bio-trim-pin-leak \
+	blktrace-setup \
 	dio-offsets \
 	loblksize \
 	loop_get_status_null \
diff --git a/src/blktrace-setup.c b/src/blktrace-setup.c
new file mode 100644
index 0000000..bb4c57a
--- /dev/null
+++ b/src/blktrace-setup.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-3.0+
+// Copyright (C) 2026 Western Digital Corporation or its affiliates.
+//
+// Issue BLKTRACESETUP (v1) or BLKTRACESETUP2 (v2) with the given setup flags
+// on a block device, print the result as "0" or "-<errno>" and tear the trace
+// down again.
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+#include <linux/types.h>
+
+/*
+ * Private copies of the UAPI definitions, so that this builds against kernel
+ * headers which do not have BLKTRACESETUP2 yet and does not clash with headers
+ * which do.
+ */
+struct bt_user_trace_setup {
+	char name[32];
+	__u16 act_mask;
+	__u32 buf_size;
+	__u32 buf_nr;
+	__u64 start_lba;
+	__u64 end_lba;
+	__u32 pid;
+};
+
+struct bt_user_trace_setup2 {
+	char name[64];
+	__u64 act_mask;
+	__u32 buf_size;
+	__u32 buf_nr;
+	__u64 start_lba;
+	__u64 end_lba;
+	__u32 pid;
+	__u32 flags;
+	__u64 reserved[11];
+};
+
+#define BT_SETUP	_IOWR(0x12, 115, struct bt_user_trace_setup)
+#define BT_TEARDOWN	_IO(0x12, 118)
+#define BT_SETUP2	_IOWR(0x12, 142, struct bt_user_trace_setup2)
+
+static void usage(const char *progname)
+{
+	fprintf(stderr, "usage: %s <device> v1|v2 [flags]\n", progname);
+	exit(EXIT_FAILURE);
+}
+
+int main(int argc, char **argv)
+{
+	struct bt_user_trace_setup2 buts2;
+	struct bt_user_trace_setup buts;
+	unsigned long flags = 0;
+	char *end;
+	int fd, ret;
+
+	if (argc < 3 || argc > 4)
+		usage(argv[0]);
+
+	if (argc == 4) {
+		errno = 0;
+		flags = strtoul(argv[3], &end, 0);
+		if (errno || *end || flags > 0xffffffffUL)
+			usage(argv[0]);
+	}
+
+	fd = open(argv[1], O_RDONLY);
+	if (fd < 0) {
+		perror("open");
+		return EXIT_FAILURE;
+	}
+
+	if (strcmp(argv[2], "v1") == 0) {
+		if (flags)
+			usage(argv[0]);
+		memset(&buts, 0, sizeof(buts));
+		buts.buf_size = 4096;
+		buts.buf_nr = 2;
+		ret = ioctl(fd, BT_SETUP, &buts);
+	} else if (strcmp(argv[2], "v2") == 0) {
+		memset(&buts2, 0, sizeof(buts2));
+		buts2.buf_size = 4096;
+		buts2.buf_nr = 2;
+		buts2.flags = flags;
+		ret = ioctl(fd, BT_SETUP2, &buts2);
+	} else {
+		usage(argv[0]);
+	}
+
+	if (ret < 0) {
+		printf("%d\n", -errno);
+	} else {
+		printf("0\n");
+		if (ioctl(fd, BT_TEARDOWN) < 0) {
+			perror("BLKTRACETEARDOWN");
+			close(fd);
+			return EXIT_FAILURE;
+		}
+	}
+
+	close(fd);
+	return EXIT_SUCCESS;
+}
diff --git a/tests/blktrace/003 b/tests/blktrace/003
new file mode 100755
index 0000000..b89b803
--- /dev/null
+++ b/tests/blktrace/003
@@ -0,0 +1,51 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Western Digital Corporation or its affiliates.
+#
+# Check the BLKTRACESETUP2 flags ABI: BLKTRACE_FLAG_IOPRIO is accepted, unknown
+# flag bits are still rejected with -EINVAL and the existing v1 and v2 setups
+# without flags keep working.
+
+. tests/blktrace/rc
+. common/null_blk
+
+DESCRIPTION="blktrace setup flags ABI for I/O priority tracing"
+QUICK=1
+
+requires() {
+	_have_null_blk
+	_have_src_program blktrace-setup
+}
+
+# $1: label, $2: v1 or v2, $3: setup flags (v2 only)
+try_setup() {
+	local label=$1
+	shift
+
+	echo "${label}: $("$SRCDIR/blktrace-setup" "$dev" "$@")"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local dev=/dev/nullb1
+
+	if ! _configure_null_blk nullb1 power=1; then
+		return 1
+	fi
+
+	if _require_blktrace_ioprio_kernel "$dev"; then
+		try_setup "v1" v1
+		try_setup "v2 no flags" v2 0
+		try_setup "v2 ioprio" v2 "$BLKTRACE_FLAG_IOPRIO"
+		try_setup "v2 unknown flag" v2 $((1 << 31))
+		try_setup "v2 ioprio + unknown flag" v2 \
+			$((BLKTRACE_FLAG_IOPRIO | (1 << 31)))
+		try_setup "v2 all unknown flags" v2 \
+			$((0xffffffff & ~BLKTRACE_FLAG_IOPRIO))
+	fi
+
+	_exit_null_blk
+
+	echo "Test complete"
+}
diff --git a/tests/blktrace/003.out b/tests/blktrace/003.out
new file mode 100644
index 0000000..5fa47cd
--- /dev/null
+++ b/tests/blktrace/003.out
@@ -0,0 +1,8 @@
+Running blktrace/003
+v1: 0
+v2 no flags: 0
+v2 ioprio: 0
+v2 unknown flag: -22
+v2 ioprio + unknown flag: -22
+v2 all unknown flags: -22
+Test complete
diff --git a/tests/blktrace/rc b/tests/blktrace/rc
index 04c599f..5b521ab 100644
--- a/tests/blktrace/rc
+++ b/tests/blktrace/rc
@@ -11,3 +11,29 @@ group_requires() {
 	_have_blktrace
 	_have_program blkparse
 }
+
+# blk_user_trace_setup2.flags bit requesting I/O priority recording.
+BLKTRACE_FLAG_IOPRIO=$((1 << 0))
+
+# Check that the blktrace user space tools support I/O priority tracing.
+_have_blktrace_ioprio_userspace() {
+	if ! blktrace 2>&1 | grep -q -- '--ioprio'; then
+		SKIP_REASONS+=("blktrace does not support --ioprio")
+		return 1
+	fi
+	return 0
+}
+
+# Check that the kernel accepts BLKTRACE_FLAG_IOPRIO for BLKTRACESETUP2 on
+# block device $1. This needs an existing device, so call it from test() or
+# test_device().
+_require_blktrace_ioprio_kernel() {
+	local ret
+
+	ret=$("$SRCDIR/blktrace-setup" "$1" v2 "$BLKTRACE_FLAG_IOPRIO")
+	if [[ "$ret" != 0 ]]; then
+		SKIP_REASONS+=("kernel does not support BLKTRACE_FLAG_IOPRIO (${ret})")
+		return 1
+	fi
+	return 0
+}
-- 
2.56.1

