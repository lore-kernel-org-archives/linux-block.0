Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795528237;
	b=s1fnIdQieglwItHKvJ+iS3d9NkFYXRB/aSs3HNjq0x1Zk7x/pP66Z6o63UJQKSuO3t5e
	 6GPbVRxWcfaZHtW0eS1MVh3RMflsMtPt4JNltnXQWM6I0RK8GhAF4HyukNUe0oxVLT/mY
	 1G/qxCcv5gck04qDNrGIZZ6s6oezI71mqr/bvJwKUX3D6oK0sgcJ7j6hI5mW8qrB+kNiH
	 Mobc9TyOeZRNd0qToWF1kQCaItTbS/ccfwqGyXsV9z+Djs5hraMFd6h1L18ZG+trBNrUY
	 hkfLwBEmrZUFhueKPlTnlFkjFoqGbg7R+7E7pl2f85qEdTMfe7VO7KEQEswtD3y4zeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528237;
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
	bh=NI0Xo/ibvpIO+Iv/w11B1i6hZuyFYzXyQjR9Q7DAtSA=;
	b=1T4t7h090ktRSS4NN91ArldggWweR20JZCPLDrvTPvsLw+zYuK9OUJ+wpqbwtVslsdxi
	 43a5TmP3G2UGlNoEByfhMPz1m4pNWYgv/x2Ra4n/OTRp4Ea+gRF/tU/vIWrrg4uKTNMkM
	 pAg02AGMbpiNTU3Ii9gM5iASoWdCs4qmJgv1SyZqsB81ITeewOMHJvWuCcFZs7Bzn0b6c
	 144yRpDX7Rfc4rnrJXMhcUesWnS+JVmT7YW6dzfx4zCQ8GQepSMviP+is53upozynlMIi
	 Ll0RqOOWabgzGcPAQA/2twgLhVMODoUeWTeJsz7UV44AsOQRxWECL9f5oETy+/6B0VA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=VGLqV3S8;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=cQp2WWKM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3195606A321
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 13:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3195606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=VGLqV3S8;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=cQp2WWKM
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795528237; x=1827064237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/6Ql3Xo2iHzTfHmz6W56+6ADjP68f8/JlTle8NCBOpg=;
  b=VGLqV3S87JlcA5wGmiEmCUCVjCvOniaNdkcShuqE2AoObrpzMQ4XGsKk
   pQX56FimyuA6XED58Nxh75UUS1GspkFsqr3aZ+j+DWDsvq7enVNAMYoeD
   7iKbj4mnp20PV6gVAHCuR24cUrvp5SOZqI98f2DzlLbWnodmCC5MbDRyq
   dJHMOa9gfPMRFCgKkZuIzQv9TGdPKKEJx6Yus40bXTx81AOKgZXjU3h7w
   CHm87iPaov1RleAsBRZXn7qmK32tt6bRYbDZA/+mD21aUAdUrp2lI2qRW
   M3eknah/rCHlok/hOzqgOhQVDrqYL8D+skuDDSwepgXkXcyNvBH5hjLZ8
   w==;
X-CSE-ConnectionGUID: mlksGydDSyqHVJw6F67fGQ==
X-CSE-MsgGUID: Xd+iFo1FQZyVQxLRpp5tvQ==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="161651031"
Received: from mail-westcentralusazon11013053.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.53])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:50:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkipSbf0EB2qvU2utw3YN8JUjcdF9bqvYgb8wsB376a+6/yotbmFy6PWdPnO7C2hmV+TbO1DDzSNwXxVqUnvtZ+FJavscmjfx2WCqJQ81iVPOShihnxr+Ah939lp2t4hjjPjdkxzg6FFjX76r1IYWXMoFsa+Y11VeYgID6cnezJfa2yvNrSezufn7ivB2XQZxu6gdjkutgWpkWtVS+hZIl05G0G70Cqsv5oCqIO2hs53lPjam7jxh1NMBQoLIVLa0nmoH3E2lxhVjvK71qBSeWubBY4xWL617z9636FNAO8OCmAt6ESyLNf4IxDeHiThNfMyUsvS7q++fnXUweho6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NI0Xo/ibvpIO+Iv/w11B1i6hZuyFYzXyQjR9Q7DAtSA=;
 b=rBom0XpVxVlXszHuIR2sXaBzqnJ2RIrr7wceQKOFAxOhpf8g/To0gSOFaKUOI/wAlI3IQP1xqzl1VT/W2XjJU2b8vAmHARRG3/WPH1ATddSqRbccrfgrq6YnaD2okOsv36MSK2rJdi5yJKxSN86mtSK8yaVpLr7U6evPVVJqkaB3AuFuG5b2MJc+HDUQ55mF9vRNHuiCvzcqCMCUjwpb3q6Yikb6ccCENpMOKB8oe8NonCjyuTXUI+A+XacncdmfhIdbon9O1DtDr6BXxHMVGIIDe1+HMzwO7wjAEsaT4q7oeHdRCpRd7S9yY1UTg3awy08qaS/1sZRCOSzgeUXYjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NI0Xo/ibvpIO+Iv/w11B1i6hZuyFYzXyQjR9Q7DAtSA=;
 b=cQp2WWKMqAJ5VLPQ4dnDYD+sO8qa/ueOree6STDPHURfllP0y9PmG3s5Po2OJ8/f8qkeWLQiihbL+Nf0UckTdtkIGDIAdPPZVLjmXz5IFV5ZmXB3ZVrJQK2CfRQIDlNkCX63yQgwxRfZ6S8giVxidqPqyuRQIpVirjJVgJU6vyk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by BL4PR04MB993740.namprd04.prod.outlook.com (2603:10b6:207:300::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 13:50:34 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:50:34 +0000
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Niklas Cassel <cassel@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 4/5] blktrace: check ioprio output of ftrace blk tracer
Date: Tue, 24 Nov 2026 14:50:15 +0100
Message-ID: <20261124135016.153657-5-johannes.thumshirn@wdc.com>
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
X-MS-Office365-Filtering-Correlation-Id: fcb398af-0ccd-4c09-d5d5-08df4a31e9b8
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|23010399003|1800799024|19092799006|10067099003|11063799006|56012099006|261026140227099003|261021121427099003|261102123227099003|261022113327099003|261009223027099003|261022105027099003|261022075727099003|261026121527099003|261028144727099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	own9cpdtHT5JhG611hBtpmzU6lJAuT7Bftc13Wn+y+FoO7BvKiB8H95N589bI/nyOBBnqv0dqqJ4ImmnCENJtpWFMK7YZaHOCuZqupt4bZu8cZ1k4iYUoXAQwSK+Yq9VBIzWXu0OHfUrnA0dJHcGAx0ZxLQG+lhKcciSTvFqm3iRjEGuL0ulH6QghCf+VadkkhJnLjHZhOxyORpkPac/FP4X86t6ZCIphImBmlvQp2EMIewvoXHi5LE38muk+bEKPfPFCmMNFVGh3zlPXY4xRad5EIjpU4AAVU1GAHtB6hTywC11/3ERbp3B9BxgBbr7GTVVmk3hFh+NhCUrfmofpFLnfw0mxqmEP657mbirAKgXJvCNHsncgORX9EnQd1BeZ00qF7uK6j6iKMx80iC+pzbbAQonWXLC6FT+d8pg06dqjysskGLf1zxKtXSAubM4CGszsW6GbKh2j3d8EFgk+4pDBxvjqqrGixQ++14Gvh6rcNVTpNt0gcbuaIuFxHnwCPlZY1K4k2uwEHNZ8vQEeibqNGLbYBUYTmd/MSUAbXuBH/m221OHBG9OZNYs7jxBFxx2R+zEVmbsqggqrRZO22lLYmT2kfezIGooxhz5qUYG4VIT8jMH2X9Rb/P9hkdWKb3uEBZxmHpzBpax3fMNhSE4tjJs5x8dRiK2UcA6bn4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(23010399003)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261026140227099003)(261021121427099003)(261102123227099003)(261022113327099003)(261009223027099003)(261022105027099003)(261022075727099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zNxBTkIEB8kmam/m3OBbI2ljOrIKb444fIyaJnCW5ij5dPGZKIAlooMnfzCb?=
 =?us-ascii?Q?/4rvqdlwL3iAjsdNfOFI3iF7+u7h+B+jsQ6XBno16CO4RKs0tJItHHZQirce?=
 =?us-ascii?Q?dwpOIl6eRNjJe/aLVIYhDAfF4ci3b+V0sLdSEryGknrOrBZ9Z5YF+uBIv4J4?=
 =?us-ascii?Q?StcP60Rd1sfWIOcfeQTHtbQ6hk7gh5gdGfQDDCDixxqQLtyyeA5Tf9FFZDTZ?=
 =?us-ascii?Q?1PzpP/36aXpYbzqkS9+l8OBOV6g6Ja75FOwnQPT/FLMWbzwW5Pbdlx03DK3g?=
 =?us-ascii?Q?td/d0tl1YBENNRACH93DithIWYX6wm4qSz72OZk5mUOsDcp3Q513heAM3hrL?=
 =?us-ascii?Q?EnxdYdveMlmaSrYSh6ZK5DEAOyP4Jnn61Bfoudua2KKPaxKHyAwyg228P/tF?=
 =?us-ascii?Q?1mFJ8aAirp/P0FSm8mny8rN6Yl4AJsWE0kmey5aOVjnptLEicvw1qGxYsp63?=
 =?us-ascii?Q?TtVr2EKEmKYp6qrE4ppe1xpL9V9euvuQS1LBPQQUMVQ6N5mT/yUgmGcDQjrI?=
 =?us-ascii?Q?ia2CwKBKOLT6rQIIhLv1V65HIZvd+/otWE7O2Aw6zXBx3dmKX087CW96Ya6B?=
 =?us-ascii?Q?aJcZ8eOcYJv7weB6xFDJMpkm9kfzth14RnjneVUX93EVxkrsCYwmKMNV5FoH?=
 =?us-ascii?Q?AfMRLBag4ZFCP4Nc8GEPcluQ3FXUpnmamvlE3OQR8ZFG5qGgg/FSE0aYul2S?=
 =?us-ascii?Q?AeHiSAmkefV//SYrzgGx5xlyKB2UqotD5PviQPMpiin3Ub8Yg8OpUTzeNfY0?=
 =?us-ascii?Q?HShNQcPFW9CFPBrmLHFlYWSxpDutKtLTGzjKsFOWKMtkCvL9nyQN7SHL+hS2?=
 =?us-ascii?Q?slTA7G7cThST4KgKqTDl+SY/MRaWtFPqmH0kAuBviYCtXwu9U/rt84xM5FH+?=
 =?us-ascii?Q?sZ0juE8K5OL2Cgm2hATcsCaufysJDxaa7ekM7qH+3s/WQqT6jd+Lv+NAJPv6?=
 =?us-ascii?Q?xQqeKe0jx6PpfiCk7v4cuUpRO+6j+/tzpIXOXzPx4i+mKQu0AJyeybJE3tQ1?=
 =?us-ascii?Q?Hz4+ogIrXGV/SqDMeTvQLPKLgdRhkHKAeGiwdc75zNFin2Mb1Q6qHEv+KXCQ?=
 =?us-ascii?Q?o6GSNOwkNrWRGQR/UIHKNiXFK4SUb5+myzd7UnDMzPb8HiyHFBQ3DzwT3g2C?=
 =?us-ascii?Q?HV+bmzwaaE0P6UP//653ETme01P+8ubLoT7FLTCRvMQaKeUXj9Pzq06MfUA4?=
 =?us-ascii?Q?c5AQShcSt62/qbsNEpx0UK9z+Eii9rmhDb6PGU4uPYxt67x8s62RfF5e3HLS?=
 =?us-ascii?Q?sg5JNSwVsbgV5CEeut3DeiEiDpGjBRj3L2u8cc8qB5l5/8eFAjJWJYd0/hOs?=
 =?us-ascii?Q?tp1kGtnmB6a1hSxf2CnR4eSirtUc3C0q59Pk1yCfsD0iaNjZeeTj5BrpKJQb?=
 =?us-ascii?Q?C+q1t/pBCrxJbza6VO1sddJdj93lhE3eXTaa1izCFiArkIkTNuSTuAy5RYJd?=
 =?us-ascii?Q?soVvYPTCtSAO2WXxUX2qVQiX18WlNFimEKPi/0Z6dU6Myztlj8a+dRAWSYM1?=
 =?us-ascii?Q?Z6Wmj219vOxnLGuBLHE8goRqnVvP+MedDdz/mHvjIZKq39f2h1HAX6zYSIsz?=
 =?us-ascii?Q?rwDVI0qTyYNDH+fgLb8YVU3KxalgqRSrVL3+SBH5JvzidYmVIzsj2RXkRTyS?=
 =?us-ascii?Q?sNNzqb8sDczgR+upbBL74jpNhdGkHlQNUhvFsYmXb/9m+lg2wOyAYWd04JMF?=
 =?us-ascii?Q?cBfYqk4vIMWP905IJ5H1ekZ2rQAu5m2RInwJTXDfwY8hEXAWp2mqd5FCvD3N?=
 =?us-ascii?Q?Fr3tV/6jSzG6S4qtp4ln1uejpuxRNbDZsImiEp/GAyN0rFJZO4jSTOqth8au?=
X-MS-Exchange-AntiSpam-MessageData-1: ht3VU76hf2uaf0C4TR06Yzh0MVmSZGK/m6g=
X-Exchange-RoutingPolicyChecked:
	bMv3x1u1T3K8of0Q5WkqtNrtd3L81Rr/tQG5sqIIQrBlTOLT+BsIxPFg/9gNs/nvQ13a4+yl1EFVZbwihEwy/RUpmVhDK1+NcZy5b57Fd+F/p2cqLn8E+hM+G9k7j412FugdRLNv9E5n4iZKIyN5BVhN018gVmsYN2I2+CzUP/o3qxmxSGi6HKLTAx2ApU21XkoIiGK83G65/EKFI3iDkTRXmAiWjXt2s7lt36+s5herYf6FnSKBw3ET0eSH5ZQHOQxtiueHnfQeorryUvTCPC3yyK8lQ90sClqYekfewo2la32pLlhZ+cy9tZwiXvzBCis2SfUYKyahDgynIAercA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BJIWggFdzof7e+wNfRS6MrzadGt8/RdfMl8M4KD/mdBHBtdusA81cHEjaOoovi24YKEPoPrsBcN/W47c6KaDy5hjc87K++PtU0/ff+aLCnB3j2VWFpQLN83qod1tCOc/ub2+oTunOMwnanZrXU9XQ+PGinWcB6CwSUJRFcrgpXB4EfnUlVfdcM/9iD25rzmbuTaMPZtUlGWa7oVK6R1czzYhItcnrsSIJ4sIH6Q3cFl71EFvZxOUqIhQ/6tSfxbGjrg7KPyJhAAs3toOQKAz3ezSGWvHg2VBjKDbUiEPwd88ox3HNboKS6YA/wzM7+rEplACgGuJ7xV09jB85XM3GTEpNu4HPewCM3mEtUF929NekURiDyaSRCnQWwG/ZjIh0rzIU+xcETEkHlztyqXGwFK4dhI5GQ5VRkpxJJYT5vH8aqL7tt8HbuRFlSFKhjm197fXRo+yR6sJj4dIDfxOPFDoh/hJpTK0Oln47IpnlGNdvpYxN23q9pA2wgZVg4Y+a8igtmTNlttmssrPv2W19wcLVXPUM//w+p6D2aGRn29mexxW/XHwcu8kLiei4EDCnaq+WCqIdIIz1+V+5tS8wVkgLopCvHGHem7jVaE9wv7WcOB1ygzPlaEg7HRr9v7E
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb398af-0ccd-4c09-d5d5-08df4a31e9b8
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:50:34.6918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgejGCIg9gRj10ZLJ+LaWfatfWEK6gQgPWbd6SjMNl18H3MR5Io7UmXNYGW226pTb+7nxta2RE7IbzUbRedetaTK+mKrbWlcT4cv23kCCg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR04MB993740

Check the I/O priority output of the ftrace blk tracer. With the
blk_ioprio tracer option set, events carry the "class,hint,level" token
after the RWBS column. Without it the output must be unchanged. In
neither case may the trace contain "Unknown action" entries, which would
show that the __BLK_TA_IOPRIO action flag is not masked when decoding
actions.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/blktrace/006     | 77 ++++++++++++++++++++++++++++++++++++++++++
 tests/blktrace/006.out |  4 +++
 2 files changed, 81 insertions(+)
 create mode 100755 tests/blktrace/006
 create mode 100644 tests/blktrace/006.out

diff --git a/tests/blktrace/006 b/tests/blktrace/006
new file mode 100755
index 0000000..4e9158b
--- /dev/null
+++ b/tests/blktrace/006
@@ -0,0 +1,77 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Western Digital Corporation or its affiliates.
+#
+# Check the I/O priority output of the ftrace blk tracer. With the blk_ioprio
+# tracer option set, events carry the "class,hint,level" token after the RWBS
+# column. Without it the output must be unchanged. In neither case may the
+# trace contain "Unknown action" entries, which would show that the
+# __BLK_TA_IOPRIO action flag is not masked when decoding actions.
+
+. tests/blktrace/rc
+. common/null_blk
+. common/fio
+
+DESCRIPTION="blk ftrace tracer prints I/O priorities and CDL hints"
+QUICK=1
+
+requires() {
+	_have_null_blk
+	_have_tracefs
+	_have_fio_ver 3 36
+}
+
+# $1: value of the blk_ioprio option
+trace_ioprio() {
+	local opt=$1 lines
+
+	echo 0 > "$trace_dir/tracing_on"
+	echo > "$trace_dir/trace"
+	echo "$opt" > "$trace_dir/options/blk_ioprio"
+	echo 1 > "$trace_dir/tracing_on"
+	_ioprio_read_job "$dev" be 4 5 1 || echo "fio failed"
+	echo 0 > "$trace_dir/tracing_on"
+
+	lines=$(grep -v '^#' "$trace_dir/trace")
+	echo "$lines" >> "$FULL"
+	echo "blk_ioprio=${opt}:" \
+		"issue=$(grep -cE ' D +[A-Z]+ ' <<< "$lines")" \
+		"without=$(grep -E ' D +[A-Z]+ ' <<< "$lines" |
+			   grep -cvE ' D +[A-Z]+ [a-z]+,[0-9]+,[0-7] ')" \
+		"match=$(grep -cE ' D +[A-Z]+ be,5,4 ' <<< "$lines")" \
+		"unknown=$(grep -c 'Unknown action' <<< "$lines")" |
+		sed -E 's/(issue|without|match)=[1-9][0-9]*/\1=N/g'
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local trace_dir=/sys/kernel/debug/tracing
+	local dev=/dev/nullb1
+
+	if ! _configure_null_blk nullb1 size=1024 power=1; then
+		return 1
+	fi
+	echo none > /sys/block/nullb1/queue/scheduler
+
+	echo 0 > "$trace_dir/tracing_on"
+	echo nop > "$trace_dir/current_tracer"
+	echo 1 > /sys/block/nullb1/trace/enable
+	echo blk > "$trace_dir/current_tracer"
+
+	if [[ -e "$trace_dir/options/blk_ioprio" ]]; then
+		trace_ioprio 1
+		trace_ioprio 0
+	else
+		SKIP_REASONS+=("blk tracer has no blk_ioprio option")
+	fi
+
+	echo 0 > "$trace_dir/tracing_on"
+	echo nop > "$trace_dir/current_tracer"
+	echo > "$trace_dir/trace"
+	echo 0 > /sys/block/nullb1/trace/enable
+
+	_exit_null_blk
+
+	echo "Test complete"
+}
diff --git a/tests/blktrace/006.out b/tests/blktrace/006.out
new file mode 100644
index 0000000..3396640
--- /dev/null
+++ b/tests/blktrace/006.out
@@ -0,0 +1,4 @@
+Running blktrace/006
+blk_ioprio=1: issue=N without=0 match=N unknown=0
+blk_ioprio=0: issue=N without=N match=0 unknown=0
+Test complete
-- 
2.56.1

