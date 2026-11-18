Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794963973;
	b=LFd8kyWF2S0nOZNLeuTEkNoAMoiTbebw/pIYworjw6XWrK0xYQ50WzC4nlSk3UOOFEFP
	 upo3J76bb90WyKlb1xyt9v5DqT6aAaukmcXIbzZineacT8KqKNyBHTZcbpfi4p/RPq/nB
	 G+dAwXFKmvfIDKURHsQ+E+ILr8ZwZEUDMYd6UPpGJYYMfLLks+GfEGnOvQGreMADmEgp7
	 jJlf8TxPobp1pfKkx2B4Ndc0c5dIYDVOutPsIUydkRGpeFkaVeCqL9R7qDqsMDrgJx7XN
	 6QFWgdCFYeo4OFXQ1aFGXlz0HbQWSO8GYl19xekG60m0144rHH/V/XxL4fjLzoliylQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963973;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:WDCIPOUTBOUND:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=/VFuOm3FLVt4iX+KGdCRSGzKKkLOh5lsIm4qRn0z8L8=;
	b=n4QNsthnPyGblhmpQ5yeDl1wQRx92noLBoNRO1EN8wEQqo7vlLEqjZp/Zj9IBf/EglSo
	 MFFgwjlfbEXWGJh8RYMVe/mokLaUjMH/W2nRf9SXQVvyryi7q+YDbybGaMP2FKWCsk1Xf
	 f43SBIgDSvi5wi2gI3co2L/gL72wkgT8+ZiVhmtXDCjO9MB6SHEZ4EjX8UovKQu6iSg2a
	 h4Y1ntpe1vF+bVAPejHXSMuPUn6/BEiTmmLOQj7KEQU15RRwkg47UXV8Mou8OIJz65EYS
	 L32Bznb1SvvP8CMWGxVsQ0eiOGL7uzC6AtoXfMuiQ/2J0dqWQkDKfwPODT3xeHPyrHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=fail smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=blUUSSff;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=Lf3wb4gI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068F5606A31C
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 01:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 068F5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=blUUSSff;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=Lf3wb4gI
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794963973; x=1826499973;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=dukd8c35609xEbkunyPTQzPwL95wNbl/0sM0H6gooSE=;
  b=blUUSSff1yVNXmc9WMthEJWFgBNq0j8U0lPyHN6Tu6rcqmL5FVBhhyUP
   ULd1JCEKC9kOMe0dm0RrD8YES6pAtsQdyuofWaiPiD4ZsctF2ZILzHmYA
   1MScxY9ZFaJlBR+V4l2lvEfvbQVO+Wd2zz0rgITGfRsI4NtD+OIHQO0iw
   Ax1XdGTyJ6BaDICO5Jbo48wjdQR+h0usm6CKB34IizSxH4U3ORp1Y1PYC
   PzsKWK9gtYbio0K34xSYWDH5dXTPtcZombfaz6//1mWfcOHuZbzBMfphe
   Evt5SGeCoDOiQo6Jb0p88/5qWJWcgy2mzsXTlh8JwoOm1qXT/cNnrdeHw
   w==;
X-CSE-ConnectionGUID: figp4p1dQuCp6/D6V3sRdg==
X-CSE-MsgGUID: CYBYF+r6Qly+uSppzOo5Bw==
X-IronPort-AV: E=Sophos;i="6.27,219,1786982400"; 
   d="scan'208";a="161069980"
Received: from mail-northcentralusazon11010069.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.69])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Nov 2026 09:06:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=til9lA4rp3PHora/L1MMJU4bkf8jeldjW9DEAlbKxQ/Khf7RrWfFykzDZeFoSLpG2ISZza7D7CIiPs7hXIomuSm+e7kLbt2MMdURRmWkwGEXhwoa5x1f14ss8JUzefM6hlmOUx+PONvie3pLJddm/QiitNt7TlC63YnwAtjwhXtdEvLir0WSSPRp7pz28tnEUv4195AyRnIA9i8gpBzrBiPgu8WGcDQ9QUJ8bYIQg6Jo/RTpFNk7f+d8MGYa3FdoIS+RhIFVY84/yCapUQ29GOuWRwXSdmS3jYREQkqTBFjTuOft/aaCrXE4108t+VRsVOn3Q5De9SrAzKcrtPsIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VFuOm3FLVt4iX+KGdCRSGzKKkLOh5lsIm4qRn0z8L8=;
 b=TtifirLzgeKHhQb275mugfUgwnBg/d/yEOm/NG6SF0VRw8z5H+jUb1OpU+ZLKYJZ/YzhaE7q0ECJVecxZoF375BrNxgNloGvhKqE8gcnDvG+b5v5MUaSRgldOVb7qg+SAMVibxMfRFvj8UuHYQO+c5mY/M9NbyG/auWgOc2li61dBmR+653Si1djznILlDMhGzPX82gfb3niNPwEM0rQ1ufFEDWWi6LFdQL2cIyzLZEem4zwfgvLqbR4no22nARCck3fJa7qftQlTxwaEx2SK5mgyig5KQ+IuKCEwgWoFs0CjQIcljYTqtjOJlmzb0jpyGiwuUjjYoGw/SAVb9BJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VFuOm3FLVt4iX+KGdCRSGzKKkLOh5lsIm4qRn0z8L8=;
 b=Lf3wb4gIXsKqvGDfMy3047nqO7CfDQsOzd51O+j4+VnJOB5JPICbTQ8grTEapnXgK5cb13M5GBEdKD3TFRdbvUAMBWyWU0Kc9PibraKSB0cdfbn4bdWX68Bb4D1lgWSW9j9zGlK/LhJ10FG6Wpv3ANOs2rkdK6u6pk9LD1xu124=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CO6PR04MB7522.namprd04.prod.outlook.com
 (2603:10b6:303:a2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 01:06:02 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 01:06:01 +0000
Date: Wed, 18 Nov 2026 10:05:54 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <dwagner@suse.de>, kbusch@kernel.org, 
	kch@nvidia.com, hch@lst.de, sagi@grimberg.me, 
	"Ewan D . Milne" <emilne@redhat.com>, "Claude Opus 4.6" <noreply@anthropic.com>
Subject: Re: [blktests] nvme/077: Add ANA log page information leak test
Message-ID: <avz5VW5H390JN87j@shinmob>
References: <20261104173842.2937092-1-jtaubepe@redhat.com>
 <avWUy2nQQChS7dsu@shinmob>
 <CADRr4bdwGdeQsH5Rwhzd0HjRYDuPopK5_6SLi7BKnpg=XOLpbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADRr4bdwGdeQsH5Rwhzd0HjRYDuPopK5_6SLi7BKnpg=XOLpbA@mail.gmail.com>
X-ClientProxiedBy: TYCP286CA0089.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::16) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CO6PR04MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: b993d89c-5734-48e8-e2d1-08df45101c77
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|7416014|376014|18002099003|22082099003|261009223027099003|4143699003|6123799006|5023799004|11063799006|56012099006|261028144727099003|261102123227099003|261022105027099003|261021135927099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	vkBEKGAK9bOs+KxaSOA6Yr71R0C1e/s2KmcHvtNQSlYMcZneLQY1lQZrQM/o+Zq0bxHSmdBjUOchIvbPrBFI612F+fIh5o4qt54vtuhWd7K+w4Zw3BeEXceeCoFRLEARy8Q4pQt9V9hFXc5OM0lTbsCVKGRgBjdnqWmXNyivbA+iiFTnDYDnVqBPv8Upnjf+4L4LdUPo7MGp/yANIZckwOS1P0OVJCz4IGu133hSIIdA3r6yoaEBcbXWB9FHnZb7oty12isEjIFm2mlrwHpVzyrMvAuR2OSKx1VBTBpzB45a44xHRMfFYqlDiVMYTd7Lj/A44RREh3LmAgaOKZPpUSzLEWA3pjzsrj8kJuijEJn6w7QE+eMeH2IHIw+p+qvIIsu1H/KiyxIaLmpNzuWWrKxBQE62vrWZvIFuzVm+WZGf0gXlAtzrK1LZ63nRqWLJr7wf3WL0a9gAJvMHKt5P39yJs/NgZlcq2X+aBykyUM6dXYOz0XarfovS4TiGd71lLUX3vwJTTAgwGKABjMI2oOcmbzSTgeQWL30kj0aEt/b2J+AnenxIXu6KvNQp44Mmgr/RW9cAzdc8aUDVJckQilCb9fsu+1X7U89sLxoKhoPDUOEoFrhxLAQRpUoeJXyD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(261009223027099003)(4143699003)(6123799006)(5023799004)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261022105027099003)(261021135927099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3FGaUxHRERFRWpPRTR4T0Y3VHlxNHlEZDRtOXprdkxqMHBIeDRLRnBPODRO?=
 =?utf-8?B?MEh3Y056MEtGaDVxRVNpWFhqa2xocGhZdXFQSzFGRDQ0WVBTYnQrRE5rNHNv?=
 =?utf-8?B?cVBzNERTYm9icDdzSzllVlo5ZWhLbVNKallFSXpCbnBjMUtaMVBpbXRUWG5U?=
 =?utf-8?B?TndUTW5UQjRQWlZvTWNuTmFpNTg3SHRpUTFPeDZFK1VqcHBJZjUvNlB0aTZm?=
 =?utf-8?B?QzVsN3UrMGpvazNiTDFsbW5ZUCtBcU5PUkNBcGJWTUtlWGQ1QUtUc0xRQWx0?=
 =?utf-8?B?SEQvbDVGUG5qN0NRdGp1aW0zOS9zQkQ5eGIwRW5MYWNCdk9lVWlKaEdjMHJF?=
 =?utf-8?B?aDhsY280WGFEc0JldjFGLzlEM1FoWnp6SXFHcFluNWhPa0dCRmZtS0diV0lX?=
 =?utf-8?B?cURuWCtMeE9nTkNXYndmZDRDeFZLc1VZbXNDSWNkVk1rSlIwWWszT04vTXU3?=
 =?utf-8?B?aFA3cnM3TnBBcmYxTEVNZ1JDM0hVOFk0WUhrRmZqcFZSNllqVXJOZHBHKzlF?=
 =?utf-8?B?eWF0QzgrNXFJcThLV2JkK3hYUXZCczJ1YjhRNm1jUG1aWVpBcjRDY0tFTlVY?=
 =?utf-8?B?amNGbTdHb1ZMUXRsTHRhSUtxWDNuQm1CdTh5bEhyYVllUVN2RXRjYklpNXRJ?=
 =?utf-8?B?S0RyTGpwajZoMFdkQlljT2xDVHVkQUNnVURQVGh0aVVyWDN4anFzNXR0SHFT?=
 =?utf-8?B?Y0JGV3lMSE0zNHFCRnd4ajhLaS9HTUxnS3RqRGxsbVBEL205QXFOY0xSdm1C?=
 =?utf-8?B?M0VBMGlkZ2VQd1FWUjI3YVl6U3BJUkkzR2lEVzVWK2RnU3E2V1RPMHBxcjVz?=
 =?utf-8?B?YTA5aG9yL0w2RVZWR2FOTjhLaXp0RHhHUjYvMlBGTkxTRUZ1SFg5eVU2ZlhL?=
 =?utf-8?B?OHJQQUFyZ2JDNmlRSVZsN2F2U21wTnczY3l6aWRzUkZTNEYzdDRib0lqeXpM?=
 =?utf-8?B?ZFJmcVVYTzl6bGxlSEJmb1c2UU9CdWhtY2o5eFdubFA5amdzZDJyd3ZpNlJm?=
 =?utf-8?B?M0ZiUXE5NVZWUWx3MVdTR21CWTAvMjJFWEttSkdBTUVpM0F0Qzh4MW9zWUY5?=
 =?utf-8?B?czNrRi9QM1pYa3lUNG9KNjdDVWJybVhHUi9nYjVZTUpLUkhVRWthL2N6VG00?=
 =?utf-8?B?a0M5aitUMnlKdWN1OUJaZGIwaTFqWW9TS2YvTWt6K2x0cjQwSktmRnUwSFR2?=
 =?utf-8?B?dVcvRzkvZmZoeFdoV3dMRzEzQVZ1NlVJNCtQSkNPL1hoZFFhMVMrL2NHd2RE?=
 =?utf-8?B?YXBORUU1cmR2Qk9KYThlMWJvTHVrQWk5L2g3dW4wNkJnZGlWMjlKTWRGK3pR?=
 =?utf-8?B?N2RCcjJZNDdxbVFDTDZ2cElORHVBZS9Wc0hwbzZaRTdFQnZaaUMyVG9BMWxx?=
 =?utf-8?B?dXRwNEZPckgwQlNaYnFrSmdVb2JvamFxTzk1Z1dHNFNDQVNvT2hDZGRpRE5p?=
 =?utf-8?B?RUExeXZWOE4weXM0K1RzVEdGZFM2WWM5bU1Rd2dzNDA1dVRiU1R1SFRuV0dz?=
 =?utf-8?B?VEFVZXVvSURadXRvQUJvbVpaOUNTKzJXSmhMb01manJ4azhNZUswdmxPUXcy?=
 =?utf-8?B?bVV2SFg1Zm85dklDNDdYQkJ2bmdady8vNHRWdUs1Y3pyUUxCL3RpdmgySnll?=
 =?utf-8?B?a2Fvb2dpaFdZRmFWSkhROXR3cnlvVFIwYk8yOVdyYzhUNGFjeVJ5enh1R2pV?=
 =?utf-8?B?QzN4b3NtMkJwaHZvL1ZwZW42V2FZVytsMkJXVVNyUHBEakxjVkJweFNPSStN?=
 =?utf-8?B?Z2hPSUdKRWEyZUlNOUhDZlgxTjlydXZyZFpMazBIZmg3b3J3S0FYQ3BTQTY4?=
 =?utf-8?B?V0xVaXhOZFlVZjlnTkMxRW5RL0EvRHlqc3VrNFhlampILzg4RG9CcHRXak85?=
 =?utf-8?B?S1ZLOXFDQ3pjazBZSmRtWTRCNStOMzI5OWYzNWx4cms5TVRYSGU5bkhrTWoy?=
 =?utf-8?B?d1llQ2VjLy9GLzZ5Smt6aTBHdWlTM2hGSFBtWkJBTC9URjN2QWZhU01CNktD?=
 =?utf-8?B?clpWRmRvc1JQbm1TUlpHUE5yN3Z1N2VBYTRTRHViU3dtNkNYUTQvNjhEYlpC?=
 =?utf-8?B?M250c0FETTBvdFNQTWVjOTBhWjVzdlZoTjdaY1pJbnp0SGt5bGtqMWRmQ2pK?=
 =?utf-8?B?MFRMK25Xa3pwaFZEcHpGNnEzVnluVWtrYzgxcHFPN29EbHZWVU9vaHlPVEsr?=
 =?utf-8?B?dHVCWXFoZTAyVWkrWGN1RllSeDdOdllVbk41ak96NWhVRnpFTkdSS3lBSjFB?=
 =?utf-8?B?SUpEbTdKenExdi9OaVRxVnFubEtBSDM3cnFmUmVWdDd1UFRBN3hrclgxYTdP?=
 =?utf-8?B?dDdoT3RoYk9aY09Wc3JNWUd0THFrZkN0ZzdwUjkyaUNKVE5SUUd0YlJKLzc2?=
 =?utf-8?Q?BegbgbCQBQA1D878=3D?=
X-Exchange-RoutingPolicyChecked:
	XD7iGPg4kVNWbAZO5VE4+27hBhnzRTWT3ZqVbKQJUnw2rO81uD2ysv8n7i4NNxUyL43DpZ3Jh4MlY3gxu96XK5z1mcVnjtF+sA52O0gOOt5R27370enKN20ysgRi660qW/3iAjsYhj7+9fUjV2wwBwxOp5qebCojUtUJJXMPNZ8T+nGHx1hiovYmrfBro+1h8l7iLauOEd0IFv6CVYb8naJ/YT2Aq2vrgTIZzUxRqqICq3sXiQW64jzP3/+OQWIMZ/JG0Bkj6Oi5JVDP7xgAVfOPF8n5HUSfaeZRQ4JqfCu5Su/Tww1cMTQdF8taCdL9SdNTMtOWvl2NWv+0uVxtWA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vaQsFYC/hBl9h8PmlicLDHVZJDrGGXSWrS5KSijXwo95y+D7ZurQB3WNMuhtu19C99Wq2eC4s9bSYB/a7bcpvXj4PIjmnCulsUC+/g+T3+4Oc+eeA8so8WTRpyB+EGQZRyv0LYOr+UR9q9N33a+IJlMpSjyXffW5VDgu6DsOawPS6tSI36/jDn/WpkVrCkD1HOXa0yxGkPcfVr7oOJaOgd50Qabi76xadn4v9Um1pS+ihSiJeSmxsPUDv4s0EbfZZjW2vvRZD53kx4BkLYM5UxURE9o5TgMBTgS6VzgvAdL5O4lUeVNuz68pZ5jO3ht+NFEsomi64OYtizjbtdhjxR4tfub2akkgas19nOlY1xOPdFuhcIV1PSWsO39R9Gt4IFqvr1l9cMX13Du7rHDO6Gy6JlJxfQxqdVjihN6Zt8TSPkDqG/S/X/r5CXC4wcWoX7tw6vXb2UwTvwRwOk7yZaJFgQ4fGk5e9hw90qNyy6MbzLnz04o2iwh4R4RDPS6hmzAXFZW6Z3j3LaH40YLGCnFpOSp27+w5bg6Hhf0wg+MicmzVIsV02KOSEdFd73vIlF8GD4jE/o7i2yr+58v4T0A1ZI+yBfn8dOXMqoSvS81nQ/gkJX8dsXH6/zDQ++Qc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b993d89c-5734-48e8-e2d1-08df45101c77
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 01:06:01.0486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjmTHVagG/XqqUgA38jHGs1V0Bn2fRlhc5cnSudYpi2CSm1xSjCW/VeDLD5nrso11c/wd2nizJ+Q1nioSdaaDuZKYDgJC4VF8sFDbCzvFc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7522

On Nov 16, 2026 / 11:13, Jesse Taube wrote:
> On Thu, Nov 12, 2026 at 5:36 AM Shin'ichiro Kawasaki
> <shinichiro.kawasaki@wdc.com> wrote:
> >
> > On Nov 04, 2026 / 12:38, Jesse Taube wrote:
> > > Regression test for reading memory contents beyond valid data when
> > > reading ANA log page. The NVMe target must zero-fill the ANA log page
> > > response buffer beyond the valid data so that stale kernel memory is
> > > not leaked to the host.
> > >
> > > The helper program (nvme-ana-log), requests the ANA log page,
> > > parses the response header to find where valid data ends, and checks
> > > that every trailing byte is zero. The check is repeated 64 times because
> > > leaked data may incidentally be zeroed.
> > >
> > > Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>
> > > Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
> > > ---
> > > This test is meant to test:
> > > Lore Link: https://lore.kernel.org/linux-nvme/20261104172833.161567-1-emilne@redhat.com/
> >
> > Thank you for the patch. I ran the new test case on the v7.4-rc2 kernel and
> > confirmed it passes. When I reverted the kernel commit 29b8758b470 (" nvmet:
> > don't return memory contents beyond valid data when reading ANA log page"),
> > the test case failed. Looks working well.
> >
> > Overall, this blktests patch looks good. I have three minor comments below:
> >
> >  1) src/.gitignore should have "/nvme-ana-log".
> >  2) it's the better to note about the kernel commit in the commit log and
> >     the test case comment
> >  3) I think "--port 0" option of _nvme_connect_subsys call in test() is not
> >     required
> >
> > Jesee, if you are fine, I will make ammendments based on the comments above
> > and apply this patch. Or you can respin the patch. Please let me know your
> > preference.
> 
> Sorry I seem to have missed this. Yes it would be great if you could
> make those fixes.
> It will be faster than resubmitting and waiting for a review again.

Okay, I have merged it. Now the test case has the number nvme/080. Thanks!

Of note is that I also dropped the tag "Co-Authored-By: Claude Opus 4.6
<noreply@anthropic.com>" because a mail to the e-mail address was not delivered
properly.
