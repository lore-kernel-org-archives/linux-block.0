Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528233;
	b=f9Iw1whL7pjHh33YSUTNhmgDVHsDS5yTFHmc1LTSnmUcJRnCmKILMrmHBUqbi9hLPfV5
	 6gF6V26gmRXScr1rr8yqkjdMyWdP50i1zF3U/sDY0gbYUx7hIwDnwTvYBJly9IVQhe+fr
	 pqGM3Liw4HWQuhDf1bkwUDnY8sqxH+7s0lzKFp7cgc44GaYoV2tYYT1igl0rAJihow/Do
	 NhlxIYDJKeh1mx852Mzn+qyq0WBWAZG/Q0tvpgkKpNW7Bjr1FGH3jReDsfgK+gB1EBnOB
	 0o+kHCUekL4YMPS3U8l8bayA2LfkeXS1+isqyHvAem4EIOiPn4MYGTa85oRUaL96KrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528233;
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
	bh=aL7A7vl9NH7+rUKIsVhWcZCj2Wid6QX38FkGlw0cdJk=;
	b=RPKO4qEi3BlCCfPQfsn36DSjLqwLvNWzCYBvgDxZXWObVWxgpRwp9XUAAHpSTekKoyi3
	 9lde3JsYRJQt4k26iIE5bqCW6/xgPLLcVDSuD662yPmr0Cr8x5iX/qAwOxgrfJUnh86hW
	 wMyqJq3wDf1U3g7C5ufDSf0NraE7bq8GfVYRtD8JZvvZaT+VUEFFlfiyhEEmtvShNERAD
	 2K5HDXUk2ihi26XeTt99oHjDkYUVbqLg1SHbEB9FY3tT8NiugPbEIBGS+fleWz3ZGxuBJ
	 WEx1P2rpuUBEWJeEObry1DdCmXITL0Abp7ApULaSckCdI1MEIo3X6pYVCV4c/6k+e7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=BlRG2vJQ;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=EPe9xFrh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA1606A330
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 13:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19BA1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=BlRG2vJQ;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=EPe9xFrh
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795528233; x=1827064233;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=LDa/TGBAvOquaHOHAJlS5Kty7Zz2KIjhepeI4y1Sm44=;
  b=BlRG2vJQC3R8UNJI4QJxr+JT2MrRbVzQKv0lm8lu+Vaa2GhFeKAGqjAo
   wYQ97efewIPssRwtmhLYvCxiakHOLRl63+E3X+QUDD3f1r2VoBqrCGT7C
   EYZKj6og8d0NRhF1HS02n9AfwC5yEH8RHE2jX2dp6FiNUw9zKwayl6Fwi
   bzmNa551v8+mXdyZhY4aDKbM4DevXroRwrJqomIaiSncETHi85dljVtED
   wuK5eCZS/UjQiP9o0hRAtr9ZQLYRUZkBOx1fpdt8ACs3EdxNWaflQJukY
   XfxO1+mX1/bJN7F7Y3TL+xCYDB92MuXiM6IzzNdaKPwE2R67Nhbl+FE85
   w==;
X-CSE-ConnectionGUID: 14jM0rVpRMG4H2i7DzD19Q==
X-CSE-MsgGUID: 37BxhN5bRRSCkXZ1+b23ag==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="161651023"
Received: from mail-westcentralusazon11013063.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.63])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:50:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5bw+pVRGYqz521CMFYWe/eO73JLGybI9YeUl6CNE6pb8O7TNEy10I/bX6FPFbgj5OBIO/RHTDLruMAVXaDnlw9ADKgkrEA6ZHu4GPML0J35S/4NM7lhAj9c4NwkgwP+rGktNiLy7xEdGjxk8jW10qwms/D3xCtyJkA0tVqF59/n0hH3J2h7Fk3XQV1YVHVsGTQcxiorIOVvi9oWir8U/0SconRFbhGo4O6U4DXCU2D6gJMK2uTQZy95dD1JQ4daoPSS8fQ2zWMw3W0MIf7WiwKMBlZQ8U5oScOD1/hW7qSFqRKSXphNgPa/B/Q9Lhp1Od+vK62cwC2qKzAId3gHow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aL7A7vl9NH7+rUKIsVhWcZCj2Wid6QX38FkGlw0cdJk=;
 b=hUtzMaNtxP+RzYqeGlSfR9vkffsiDzxwbnh3Vlbguwwli6+6Klhg3MMKlchYW+OQ3lrT8qzBMnbGXygvJkTrhBzmN5q3C8i0kvUGijrovsO47IVf6wF0Yb954q/0C3ey5MmhfLPJ8r6yaIRonTjr+nF371j8uB7ii4e092Irr1rygrpdd3vBXf4KzDwlun1dc8Uhka7LuYez496peQEKupUzUK8201tvfL7a9+i0PmNAa2fe+xdDnOyjFdrn5r/yuc+Kqu05BompPvysXrZm32frlpA1ltC8uuAzHJWnYB4lSWpsZifgwsDmKWIUA+VIStiFUsQm7PGdxYjbrcngtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aL7A7vl9NH7+rUKIsVhWcZCj2Wid6QX38FkGlw0cdJk=;
 b=EPe9xFrhmI9P9p0HncQF09NKkiqQcNRSDGfBGM4mJ0kqv+ytlskZeidFFFsWWUUe82t0k6WiX5eoR2mHJRk36ani7TDNywnlKJHOBC2FlABb4/YEuu8b0qMFo4aAe3TfIxhUPu7YV12eEzfg71xQIWZtkt6tkNic+z+dWtxYY2c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by BL4PR04MB993740.namprd04.prod.outlook.com (2603:10b6:207:300::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 13:50:31 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:50:31 +0000
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/5] blktrace: add iotprio recording test
Date: Tue, 24 Nov 2026 14:50:13 +0100
Message-ID: <20261124135016.153657-3-johannes.thumshirn@wdc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 83f9571c-6f33-438e-5470-08df4a31e7ae
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|23010399003|1800799024|19092799006|10067099003|5023799004|11063799006|56012099006|261026140227099003|261021121427099003|261102123227099003|261022113327099003|261009223027099003|261022105027099003|261022075727099003|261026121527099003|261028144727099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	WHdVbtiNC8um2viIxt0oIlwoW/wdqq3rOy08dOLNXkoOcDdKaK3y0X6lVeZoBQYW5M4zJSlkDFbkbujywHAnUsG+0z3QQRKjw+K4NcNp69xsYeEdtuP/aGlF1GwajBdCKrl8ZfxR3q0hpYEooff0x/T3/fjfypSHLXP7LxXJeBDR1XdwR4smPHdRxeiRI+27LTJRuxKJSWASkaZf9u+8ve2rQtdb5wbunpgCNv9EHFnIPRVkc462mJV7ymQwFQ7sNllnpDxlqDQ18l/dmUbJh4VDMI3Qjub1NUS0KbNiQoiEYQNwO2z2gHCItaaYlABC9z80OQFwx+cVFSs26xDpBxLgWwBxMoRxty+hts2ImUxgnzOhNxE3X83Uzdv3G076TR3hq7m5olhmrMpE6v3Vj9neA15kuVgcl8N3UscjXuhqB5n8Z9fPpfI8y1vncHzz32JCYBJmkdOtvdFtjgPbjNCRV/klNrAuH/xEo2yqm2ykC+etMASbYKOVQYpCN0NjSRE6xso5BlCtms0L9a6VjCxDCyUr4FF4VoIrpbVt5kXeZLuRBs9LxE9kDYJyB2boqp8RYf9tmHBF/5Vjb4HQnI0Ge2hMkMf9LDn2Ih3LD5XxM8y5q6t2yqL2FPkx4ZdhI/Su/xt8GpKzAQKwUW2OWZj+7O0F796KJLY3trWgGjU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(23010399003)(1800799024)(19092799006)(10067099003)(5023799004)(11063799006)(56012099006)(261026140227099003)(261021121427099003)(261102123227099003)(261022113327099003)(261009223027099003)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RSAb1pRo5RJSqqhTHsArUmAbnexWBw6PaM+K0r7/+YPn0cpYtv3PuIXbJft5?=
 =?us-ascii?Q?dBallWDmQBxeMMXD8nUefI29Dc3OGZmZgpqSizvpLyRvt5LriZQH4jWZEdcw?=
 =?us-ascii?Q?mYEeh43E4EeKu5QwjrACH2SsEaEcb1qqeGy4rRgho8IU6DSHkZobdysfZX3L?=
 =?us-ascii?Q?SfjvyZlceyNpgZ0hG5BAjSQDh7swx14m+WIlBIhL+PJ7p/32Au/nlKJJxpiR?=
 =?us-ascii?Q?9ZNZ/UyPHF8vnjSgQRh1PVM8NraTm5tn/7UaOzYdnj0IYWG400xweVAXrK3l?=
 =?us-ascii?Q?v4BKDE7i4NubxzXXYm1St2MHG+CcVaqJ4C6U99E+FSsfYq0XA/4ZKQsOxA8e?=
 =?us-ascii?Q?sMvSwG7OiFYt+hfPIKouAWu6OqjZ18sNM9/cm8UllDZUaBCaJ32zlvDZFPNl?=
 =?us-ascii?Q?Tqdn+e+SrNkuVOVgTAKSeL0Z9Ew0DzHAh7nxookLICi0aHLLTet8iNzyYCCF?=
 =?us-ascii?Q?q/pduMwCuHJfjTgn9PFTCj0wOnQ+LIiEMSS127mB4QQDC3jbFanPI0gN45tG?=
 =?us-ascii?Q?B6FrMSHwo8b9ncPKmvsQW05tBST6rNCe3QJWEuLWSvgesSDog93GiGpSFeF0?=
 =?us-ascii?Q?gY0u7HaqpebeSDyzNJhFzKaMQtR0J3SV/dQ1aHFstVHOnrabM2Qq3fO0cYXv?=
 =?us-ascii?Q?p7Y2r/fseyoFbeRHuCjq0lMN2Mam3EFICKdYg8D47IZ24QCP6bR1g4V3VTP2?=
 =?us-ascii?Q?4WTY++fC5OVm4jkO2Bdru9Eiah94RMcu0QZYQtPLZ5bs+H1p4FI4mAD4V5XI?=
 =?us-ascii?Q?a/lH5jx54Zi1G32gagSiBbXhuc6EVIEzIz2cNfJgMA8giZIVtgmrNxfe/8BI?=
 =?us-ascii?Q?Zk7KCav1hW7OfgWkZL1Mo/XyLh9cYvqSGHipIhbsVMa7kGJBQYD/NwUIKAPH?=
 =?us-ascii?Q?X7rXrqw3XA8YMt98o/G+PVfkfFAqlOODp81/J6x4XPUVC8aQ4MVbSAhLYFoe?=
 =?us-ascii?Q?2eBJAhJKbvF6NYF69V6iYyQF8aK/mVbcFT8Q/8twdpcf4TzroTUvlUGUSj+1?=
 =?us-ascii?Q?cc14S42/NUcQFVxhRT8X1oAQAO+4j3NHyKQakQdUXWG3La6t08q4ge41aMuo?=
 =?us-ascii?Q?8fUGbMgtVGmaD0mvrEi4nnRbpnKFoSW0Bma3+romdYbDh+ShprQ3rmVRtNV7?=
 =?us-ascii?Q?vCUJS6PkEtRtX4gB2/bP4r6HNQwKZ5rIAfRDzoB/5fz1wR8djNLf00yogufd?=
 =?us-ascii?Q?JPjbTONG6A5BUw9GEVGPpEKnVx6SIUYTg2uCUOwLW1Aow3gcS6R8ss1yEx0J?=
 =?us-ascii?Q?OGtuzsFTQswV8A4yfngc0uV72kOgfl78c1iZcVtNZzcogQvCJG66FCI8sCB6?=
 =?us-ascii?Q?G0S40ae8GrORuVssRbNvb3zniLWCwMhtP1BykI7P8FYdynWCdCiI1Q7r6HQa?=
 =?us-ascii?Q?LjF7Ws5xZijtOumPPXikuQnn8NjN6di2+lwAfdk6SQ9sZS8+EuwhHuwJk9cm?=
 =?us-ascii?Q?EyrebK9H4c0W8Zuv27U7ae1XaEOj7xP1pJNVhGqno+IB8CflkZn2dtsF6Nlw?=
 =?us-ascii?Q?uQ9ETXmhSmqWKj78ebwLF46StRhyj562NoTnh+gmd01ggb7+y8o1E1ffUCpi?=
 =?us-ascii?Q?CRwyXM8oGcyGUgjhIyOlsyXqWvxqqUvGZKkz1lVbZ3oRh0aHgkkqvEc0s0Ge?=
 =?us-ascii?Q?mqHysMYGNarsjtfECH+++lPs4Wt7ed04DhOUduCwO/z+4j+sGYMxXrcTkPSi?=
 =?us-ascii?Q?jczwVEb4MvDDoA+dsslhnmZZgxQomkegQF4yJJourXoaXLkkHNEjBOHnzSFr?=
 =?us-ascii?Q?v1GIRA24NPGIPJG3MCMRpZIse8jKCFYsWLWoCNhYKsTHDf0g39qvheNg6z7z?=
X-MS-Exchange-AntiSpam-MessageData-1: E6sKA0MH1RJlq2Q4RTVwiy8Bt4Oe43L9ADE=
X-Exchange-RoutingPolicyChecked:
	gO8v3VT+qbNUlysYEbBgtL6coFZ0TQlUFsLD1vW/YTscAuC9AEm7QqvG0BW/c67JVLdn7iUz9M99T3fJrxGTjWaaB05c+/2xX7p5sLztYU6kjTYBTLHh81tLamkxwxNUSo/0Q9KBRDPxeDRL+2vx5ywZu8KYB4pdX6sWtGyUqk/tLjt7SwJw2XD+SblapN20sBS5g1HT5/inYLZgBbWArXMg0nlULrRLI807zgMzyzO3Y4WUCfrHkHouJhCAeqEcAxgUIHdXJj72iNZ0OZNI6XSlXbJHc1qgUaAUlGG+72GtY2vvwyfG4FA3M2Q64pPizmyLqPYXBsHbsA91gWi4Fw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EuNtdo7wPD4P75Eg0KJt39/Or9hzDEIN6Sd2HdSezklAa8HGq5lvWoasZWG32vGaFpoC4qduWCPzj/M8z1Rz2jdBP4eSGmlZFH3bz678/VF/gcogUgXt1EcZLoHsVgmJRQwGxdMpsFEP6l5Ksdp3/eHx+vphbqa7pFMLlOVXVxJODxfO12I3IgY5kj1hL+2K9TJs7FbjYsttezdUiqqkxTe6uU5NbKGqyEBiqB+4dQjaCmRDoguHirP/NNTYFNadn3q/Kl/4YGwCJcvqQDB+Q8oeuH7BNgTmd8AIqUgIY/477KxWPg58iGhNzYd8nyQbySqkKxho01G6FFTvYhIevxMVicWohUUpJf7wwHewlbIN/7HQMh7aKmMNgKZoYLqOw6/dyBroQ+2IroY+w0wi1/pB491F0Yo1Li/Tu4/65regkbyq9fSapKj58weUrhzhYJE8nW7GcGQjzrKdFkcT6nmZqeuTVIASNBEj/PzvN0BoFygjsF2MZfCLxZoPxZfEkQ8ooFPcaTuHQDAMyHh015hMS8jAwPs6Nqh78bXUx1bAfXI1DJLSx4ze8y0ICplbctihWJwfzQ0cRj9rcPP18gRWAbhdD0448nPSF1/XbjwrdfaB7CyoN37IXlsAFdbW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f9571c-6f33-438e-5470-08df4a31e7ae
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:50:31.2541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WRPX3tsfo5drsxuuWSDmXPkLnuuHDB8tPTsvLz9qqzPmvofibw3W3vNmntSt2wtGY2HQt9MkaGsKpZ4LvM62fgqaclLj7vnHBhjCf488TAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR04MB993740

Check that blktrace --ioprio records the I/O priority of bio and request
based events in the v2 trace format. Every SCSI command duration limit
(CDL) hint (IOPRIO_HINT_DEV_DURATION_LIMIT_1..7), no hint, and the RT
and IDLE classes are covered. The hint is passed through the block layer
as is, so no CDL capable device is needed for this.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/blktrace/004     | 107 +++++++++++++++++++++++++++++++++++++++++
 tests/blktrace/004.out |  13 +++++
 tests/blktrace/rc      |  70 +++++++++++++++++++++++++++
 3 files changed, 190 insertions(+)
 create mode 100755 tests/blktrace/004
 create mode 100644 tests/blktrace/004.out

diff --git a/tests/blktrace/004 b/tests/blktrace/004
new file mode 100755
index 0000000..4f863da
--- /dev/null
+++ b/tests/blktrace/004
@@ -0,0 +1,107 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Western Digital Corporation or its affiliates.
+#
+# Check that blktrace --ioprio records the I/O priority of bio and request
+# based events in the v2 trace format. Every SCSI command duration limit (CDL)
+# hint (IOPRIO_HINT_DEV_DURATION_LIMIT_1..7), no hint, and the RT and IDLE
+# classes are covered. The hint is passed through the block layer as is, so no
+# CDL capable device is needed for this.
+
+. tests/blktrace/rc
+. common/null_blk
+. common/fio
+
+DESCRIPTION="blktrace records I/O priorities and CDL hints"
+QUICK=1
+
+requires() {
+	_have_null_blk
+	_have_src_program blktrace-setup
+	_have_blktrace_ioprio_userspace
+	_have_fio_ver 3 36
+}
+
+# "class level hint" per job, job i reads 64k at offset i MiB
+JOBS=(
+	"be 4 0"
+	"be 4 1"
+	"be 4 2"
+	"be 4 3"
+	"be 4 4"
+	"be 4 5"
+	"be 4 6"
+	"be 4 7"
+	"rt 1 3"
+	"idle 0 2"
+)
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local dev=/dev/nullb1 i class level hint
+
+	if ! _configure_null_blk nullb1 size=1024 power=1; then
+		return 1
+	fi
+	echo none > /sys/block/nullb1/queue/scheduler
+
+	if ! _require_blktrace_ioprio_kernel "$dev"; then
+		_exit_null_blk
+		return 0
+	fi
+
+	if ! _blktrace_start "$dev" ioprio --ioprio; then
+		_exit_null_blk
+		return 1
+	fi
+
+	for i in "${!JOBS[@]}"; do
+		read -r class level hint <<< "${JOBS[$i]}"
+		if ! _ioprio_read_job "$dev" "$class" "$level" "$hint" "$i"; then
+			echo "fio ${JOBS[$i]} failed"
+		fi
+	done
+
+	_blktrace_stop
+
+	_blkparse ioprio -f "%a %S %i\n" > "$TMPDIR/fmt"
+	_blkparse ioprio > "$TMPDIR/default"
+	cat "$TMPDIR/default" >> "$FULL"
+
+	for i in "${!JOBS[@]}"; do
+		read -r class level hint <<< "${JOBS[$i]}"
+		awk -v idx="$i" -v want="${class},${hint},${level}" '
+		FNR == NR {
+			# "%a %S %i" output, 2048 sectors per MiB
+			if ($1 ~ /^[QGIDC]$/ && int($2 / 2048) == idx) {
+				if ($3 == want)
+					ok[$1]++
+				else
+					bad++
+			}
+			next
+		}
+		# Default output: the ioprio token follows the RWBS column.
+		$6 == "D" && int($9 / 2048) == idx {
+			if ($8 == want)
+				dflt++
+			else
+				bad++
+		}
+		END {
+			printf "%s: queue=%d issue=%d complete=%d default=%d mismatch=%d\n",
+			       want, (ok["Q"] > 0), (ok["D"] > 0),
+			       (ok["C"] > 0), (dflt > 0), bad
+		}' "$TMPDIR/fmt" "$TMPDIR/default"
+	done
+
+	# Plug and unplug events have no bio, so they must not carry an ioprio.
+	awk '$1 ~ /^(P|U|UT)$/ && $3 != "-" { n++ }
+	     END { printf "plug/unplug events with ioprio: %d\n", n }' \
+		"$TMPDIR/fmt"
+
+	_exit_null_blk
+
+	echo "Test complete"
+}
diff --git a/tests/blktrace/004.out b/tests/blktrace/004.out
new file mode 100644
index 0000000..1b36040
--- /dev/null
+++ b/tests/blktrace/004.out
@@ -0,0 +1,13 @@
+Running blktrace/004
+be,0,4: queue=1 issue=1 complete=1 default=1 mismatch=0
+be,1,4: queue=1 issue=1 complete=1 default=1 mismatch=0
+be,2,4: queue=1 issue=1 complete=1 default=1 mismatch=0
+be,3,4: queue=1 issue=1 complete=1 default=1 mismatch=0
+be,4,4: queue=1 issue=1 complete=1 default=1 mismatch=0
+be,5,4: queue=1 issue=1 complete=1 default=1 mismatch=0
+be,6,4: queue=1 issue=1 complete=1 default=1 mismatch=0
+be,7,4: queue=1 issue=1 complete=1 default=1 mismatch=0
+rt,3,1: queue=1 issue=1 complete=1 default=1 mismatch=0
+idle,2,0: queue=1 issue=1 complete=1 default=1 mismatch=0
+plug/unplug events with ioprio: 0
+Test complete
diff --git a/tests/blktrace/rc b/tests/blktrace/rc
index 5b521ab..de61e13 100644
--- a/tests/blktrace/rc
+++ b/tests/blktrace/rc
@@ -37,3 +37,73 @@ _require_blktrace_ioprio_kernel() {
 	fi
 	return 0
 }
+
+# Start blktrace in the background on whole disk $1, writing to
+# "$TMPDIR/$2.blktrace.*". The remaining arguments are passed to blktrace.
+# Returns once the trace is running.
+_blktrace_start() {
+	local dev=$1 name=$2 debugfs_dir i
+	shift 2
+
+	debugfs_dir=/sys/kernel/debug/block/$(basename "$(realpath "$dev")")
+	blktrace -d "$dev" -D "$TMPDIR" -o "$name" "$@" >> "$FULL" 2>&1 &
+	BLKTRACE_PID=$!
+
+	for ((i = 0; i < 100; i++)); do
+		if ! kill -0 "$BLKTRACE_PID" 2>/dev/null; then
+			wait "$BLKTRACE_PID"
+			echo "blktrace $* failed to start ($?)"
+			unset BLKTRACE_PID
+			return 1
+		fi
+		if compgen -G "${debugfs_dir}/trace[0-9]*" > /dev/null; then
+			# Give blktrace time to issue BLKTRACESTART.
+			sleep 0.5
+			return 0
+		fi
+		sleep 0.1
+	done
+
+	echo "timed out waiting for blktrace to start"
+	_blktrace_stop
+	return 1
+}
+
+_blktrace_stop() {
+	if [[ -n "$BLKTRACE_PID" ]]; then
+		kill -INT "$BLKTRACE_PID" 2>/dev/null
+		wait "$BLKTRACE_PID" 2>/dev/null
+		unset BLKTRACE_PID
+	fi
+}
+
+# Run blkparse quietly on trace $1 in $TMPDIR. Remaining arguments are passed
+# to blkparse.
+_blkparse() {
+	local name=$1
+	shift
+
+	blkparse -q -D "$TMPDIR" -i "$name" "$@" 2>> "$FULL"
+}
+
+# Run a small direct read job with I/O priority $2 (class), $3 (level) and
+# $4 (hint) on $1, starting at MiB offset $5. Remaining arguments are passed to
+# fio. The resulting ioprio is printed by the kernel and blkparse as the token
+# "class,hint,level".
+_ioprio_read_job() {
+	local dev=$1 class=$2 level=$3 hint=$4 offset_mb=$5 prioclass
+	shift 5
+
+	case "$class" in
+	rt) prioclass=1 ;;
+	be) prioclass=2 ;;
+	idle) prioclass=3 ;;
+	*) echo "bad class $class"; return 1 ;;
+	esac
+
+	fio --name="ioprio-${class}-${level}-${hint}" --filename="$dev" \
+		--rw=read --bs=4k --size=64k --offset="${offset_mb}M" \
+		--direct=1 --ioengine=psync --numjobs=1 \
+		--prioclass="$prioclass" --prio="$level" --priohint="$hint" \
+		"$@" >> "$FULL" 2>&1
+}
-- 
2.56.1

