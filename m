Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527381;
	b=EMFBAiY5aJCZvjSCGHc7dadPN3guD24MLIqmexFKJ6JlJ3v13PKt4k0+5kd/Cu19NfyA
	 GXn2s5uJw8yh4wDqizYwrI5Ua8cn9Xbf6dnUhipfgYtivGukmZ+Yxum87GbvG3lKhpD1R
	 WVDkIRPhIhGTNdf+UtuW25qG7tEhcystAMxEeTWquKfV9QjrFswWbZKlNyR2JxfBojUk8
	 fiM9HKQn4pIBnKNZni1Nr/bu9fAhzBDFBjNwuA/MTRU76DPmO7sob/5aDxVV8ilJiSwu+
	 3hggFOKrxn10ksJjWZLBqfFWLWRrHgeTp93O/atAl9G9sjfsRB1r7N5NNWOz6LOIhIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527381;
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
	bh=JpORwx3V85feWyBSExCq4TwL2Zwss3xv99SNYF1YdTo=;
	b=AX2aK5Rz1axf0DPo4JxThuF8Q6wQrseHrvzdwXjtu+8+x6o50+DudNuhYdB9x3lAl0uR
	 GAkntitX1kxP573C5A6d91QZnWqbfp42VPfqce7YrgAU7PDOKu66DyqFQhIeEHI7CmxKX
	 liZ5X4rCh2ikygUuBApgNgKENdW+cVrQBPa7KSyN8lyPWrl9Z1U0TUP1k0daMLU6JFOiR
	 HaDwpcrMMZ2YCG8mc6zrw23TOnOd0lWf1mfZZQkR9VR5RaIzx3y/UhFhP07DQ49NcgbjL
	 UM4g3nIY866c/AMH/lZMXgj/oYDdOkRxclnN5K6Q1edWWUqlcd5FQ2RYczCnl2I+zkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=CkIR2lJb;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=MhnVPUNq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14803606A32D
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 13:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14803606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=CkIR2lJb;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=MhnVPUNq
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795527379; x=1827063379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=oH/ny07691Ml+ibJ4ZU7gJ3KbVSLil6vr92QHn8Q+WA=;
  b=CkIR2lJbvV3U45c3BsOrHeu3uqJdAdLIZp+XlCtO6kwgk1LznlbBKk44
   Nfm9cKVe/FUvww1gw/i7XXPcFc8wcwbsuVv/FWxeVGrdhA02GVKUVjJlY
   lUuGy4h1UCQmuEE58xPFTMQLIyk02RbKpB4GmtaSBWBE51c1sf6MyD2M9
   0NfOPtR/6CxvjlEdV6RuGs+9PjGve5x+NUkymJ/3E7nwjtaCf61rhTLeh
   S9Gr4v/PxruxnLc2xfXFtNf2BGoPAWytk8yhjPhosoOcfoa1gIvqoKmqm
   KxmLzq7WlofmURGRfGEG9c5E9NAiIKAMudIytyMilYv60ef8ur487qnu5
   g==;
X-CSE-ConnectionGUID: W9i9CLXOTHKvMqHWvOHkrw==
X-CSE-MsgGUID: tggSyXm0SgKsIKZUhJTO9Q==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="161579894"
Received: from mail-northcentralusazon11013062.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.62])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:36:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8ckEDINTv0EIGfEI0jaYWCdINDDUcSXMogT8EMVmtjvoxHd8nC5XEs14qn5iOFro8GCcdNXPCLAHUmcXMADwIdjvLDOUhnMRe0tnPZj89QvogD7W/qBdX1SCuCG0ToT4YFhS1ql+Gv4NEDkPp7FajNQCg9t7Ez0oBl/G5EKnLJ64XxDn5/pkwjESdjw0myg1op0InlmJdEQthpI5jQqpGanpgEPybpK/dQ11JrRfFzN+LspWN30Gh1drjeL46dw5FaQ1DXsMR9fXn6rAhecqFffOvaqiz8hdzuPmyfoy7/DuaPhSX4VNTnxgprp56Ed7FMfl/XXFtn0/TviFVIerA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpORwx3V85feWyBSExCq4TwL2Zwss3xv99SNYF1YdTo=;
 b=fwPlXJCTn/z3uuZHuu4eKO19elqJJmj4vtG984v0W4s4weNhxDHOHQS99/6sEzVZF/Tr2JMlsfCHwqBxEjNJ5sHPZD+ko2ciI++IN8ZmSaTvSS9RfWDMbcXNrtJdHuPwWAGISSSgZtLOyof20IdL8/lB8RvlWzCYzAucXy155NA5nNM35ofvSrMlyaYdRzXX/A2rScGPTD7nk0rPu66G+4DTra9lZaqXjvSxxWyq3ApeEpB20V1wppdtkhxP+aLcv/zHCNU0GWpYeade6dmo9HJeNE1PaFnkU/9/BtSqJhafitwYgTK/OXBQaMnhEOxL8Unc+1jsXJod6apkgW401w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpORwx3V85feWyBSExCq4TwL2Zwss3xv99SNYF1YdTo=;
 b=MhnVPUNqjyWgZH64vCRNID6pjBnHEUjD8qognVZt2wA4HuM/NmULTQwvvWSQn2m2vi9cUiefoSd/16UUoIalI2n3aMxBkSjAdg+VN2vnEiMYjbfvn81EAcF9i4lPJNBRhsrlI4RIcwsU2oty6a8txpJX9W+fUeNqgV7usfiLyKo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by PH0PR04MB7527.namprd04.prod.outlook.com (2603:10b6:510:4c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 13:36:16 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:36:16 +0000
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/5] blktrace: add ioprio field to struct blk_io_trace2
Date: Tue, 24 Nov 2026 14:35:49 +0100
Message-ID: <20261124133553.152463-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124133553.152463-1-johannes.thumshirn@wdc.com>
References: <20261124133553.152463-1-johannes.thumshirn@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0239.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::10) To SA6PR04MB9447.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|PH0PR04MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: fb3f9fcf-7fe6-4971-6bc4-08df4a2fea7f
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|23010399003|1800799024|19092799006|10067099003|11063799006|56012099006|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZK920eQNTETwiWlE6r4BlojBXnybURdyiHWz2Nh1rs1VpyeS40n1TeWJW/TyxBIuYVIk1PlqA7FkNz8Ja8r0gCqLvDH2TKg8vA8f1A6CoRe9E5lf1zFaysW0aWb7KDnIUUrUmZ29ok/Qvn7ADfmyNHfe7tRGsIewJyoCxZlNB76LcfQ5BPJ+xdg1tPzY0EzYLM6MQmdqRJ/fqB/97XkJ7O/vOIVGgVAPPJqcUZ1VI3w8RhBwGm6N/XIrF1vbHZQxixOKAWWsPevb19C+9osvC62qESwpniHyESgaEgWn2oDD3bjrQGZ7eE7K/7db54p5mKU6m1fXvKhRdp5TshpsFm0lZNllINqsAtMPwO34grUxSA6vHQHB+fae2YhObgiwvHKlnDys1BBoz6HQIC0rvouwW8ZmPL1mnxUtuiZgy5RXisPnTlqvgigrj30vSsb1znWbE6WnPHdUvpLuaZSUaSR+YmSCm2qIvBgqfu7tPCeBpaFhR5FhV22z5ynckScPuIDuXg2IOip/j2mRbJSj1y6yReoa+TiP4sF/NVpXaO1QS1yKO3nuWwD+/z4k4Fj7piiIba4eMspQe9g0rcb6FypSI8X7wTywVyieFa1xr6qbOPNFoF15RakMLIGx2a3tZsjUek/4V2GzzZid9U+woBmviCGS6WUJuEYtPyFkVjk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(23010399003)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yPzwMhuHWZCCW3/J2IBu6UhVZ30CrRfLoV+AVgOmgKQioe/GXwQnN7wGEHYZ?=
 =?us-ascii?Q?Qz1SC3k0IS5EXPQHKZ7yEilCkkCDGSg7OgBm8pCm0tIKJZhDi9BElsXCEWjZ?=
 =?us-ascii?Q?+oTMEhi6AQ+A0KJQaPTDus6UOX3RHfueEt/idPrwmEMv/tY3Pvc+6mVTGDoS?=
 =?us-ascii?Q?q9j5FC3FVnuH2Lt0obJBnyGxoKOX5nL0yw8a6xbVI27H6O3F7yff/iVjvu3e?=
 =?us-ascii?Q?keGYAMVZLzAKYeXx+WYm+N3LPD25X+V8u4CtFwI+o3YwnKnHaqVihQQPBbIb?=
 =?us-ascii?Q?p2yJCMzq7SHoucHdr6VkegWX8GTTleoCuysSoAjDJcuHFkG8D5X6bcOfP04u?=
 =?us-ascii?Q?rzjkMB/aqqdOITJxsfiBAWFCletGTz33ll3O2EyaviUh1vrJEPoTSKIRBlBP?=
 =?us-ascii?Q?CIlNI/AowbNj2L5z5tkHE/zxl8RSKbNEoTr730VF7i0cumasq/XbDsv/oUVg?=
 =?us-ascii?Q?Eh7rxotWp6GnpljUQV2/Qcjvw4eb57e4HslVKbxjoKKKOZ+2owatS6BzygME?=
 =?us-ascii?Q?eT8O0Bv5cGCYEVDHlkSMCBm7pIC7l/qlvLqe+Qo5v4zyoR4nqCSndvBp4PP7?=
 =?us-ascii?Q?CS77Mik9zuYLklnjkx+YhaQeEAkAv4V1OhcJzBSk2C/jLamgnIb8i6ip3k0R?=
 =?us-ascii?Q?L0dteNLefqQ6gE3oVmedDKKcg38ZVwA0Hi8YRM4H0fxbRcRbw1CV37MEYgl+?=
 =?us-ascii?Q?76bBO5oQl6Fmt/JgQWhgTh72LMafnAf1Q4FAeN7CB2cG3BM0SVwHO5qXgheT?=
 =?us-ascii?Q?Vmm+rwszPMvtyFlTrR47+JkcxZe6sRHjk8hNc53XmNY8GGNDOITZJNpxIlS6?=
 =?us-ascii?Q?k/KUJIJBB1F1BBnjQoakMFGSxCN45HBDeH6niaSTqpLf9yhOU67WWJEuYJnb?=
 =?us-ascii?Q?6OPWZ6V0aexeA/u24I0E1I/fRZd1pbHarkm7D88tC8Lu8lFVvChHRPyWUjLZ?=
 =?us-ascii?Q?7blsy/9KcPsP1Pe9ZcPtW6AlKl8OcDpyE9TqCvjML3AWslK73Dwlzaca2FFa?=
 =?us-ascii?Q?0N9kNwecKCDba7zW2H3ZaeusEFDnHkkmcinHuyGZ+lyaCjQNkxbu007Bz7BZ?=
 =?us-ascii?Q?WXa/xwPBtc6zJ1SCAaexokks1HsE1Q2sBvB4u0CWifFC2mKLuMIhjPS+jl6I?=
 =?us-ascii?Q?HHhF8ZT1di9gdFyIGpcuFIl48DT3mgTHXxlFIuD3Rfo1PgtXDqjCl7doEMyZ?=
 =?us-ascii?Q?uqyh6zAhf4l5fE5QzWfJm8aBJExyBAZb9R1VjYchGo3su9z4l/CCJTckOcRx?=
 =?us-ascii?Q?jOPSK9Vzcn9+cywM3fFBC/qdji0V3QpLuSZjvXVwn/9MqW2XnuAq3sFVB9RW?=
 =?us-ascii?Q?3Vj2hCeRIZV4y/lIJRAkE6z/55PY790PKQhYb+LA38eeubCRRFygiuo6bQIy?=
 =?us-ascii?Q?LDOMqVQaGD+iIlO0DcK+YK/vsK6VWmLhLp4NGYxrJ2NGBHN9/dtl4QtcjOCJ?=
 =?us-ascii?Q?g9sQJphyzNYzUg+fwR/JeRnqGAAB64IogtT6jDX8zfoHSlpFw98y1RpHwZRY?=
 =?us-ascii?Q?p7TFjF3FtC+6PERvddiDK2iVtvKw9tomNQ41GJV+wSWUaQE++63SZVhs4ba0?=
 =?us-ascii?Q?ys8W414qHAkOgP9rGVdrEQK+T4DmeU9nTwuiFp5rWdreDQGe7IadfRAtbnAa?=
 =?us-ascii?Q?biCJmkXEhaXgQqAL7vURu9/2iC/mDrShoEO88VdnKFcnMYqsm/oNuHAGNLNB?=
 =?us-ascii?Q?HKK9fbMiuAMrQKQJtWNdD/f8c6Ck7ECgn3uSg04uRniI7Uy1ZkkoOoqcdMgZ?=
 =?us-ascii?Q?J4rcUJ/mT90CihScqjsWC3zmlPeoX8uHoPBo6pa0vG+T9ky7jEOVq0xJXezS?=
X-MS-Exchange-AntiSpam-MessageData-1: DgR8sg94Yi54Ku0zEkiHKT6NRAOBBPSz2+A=
X-Exchange-RoutingPolicyChecked:
	gTNZuEz/uGVHGGnVsj4AmtnQ9CAiRDd7C1dfcm4CfYpORwfwo547tR995xYnGjuYp69iaCqfL+65JsTb3u4/7RoyZi/UU4TRRRzO34sfyt3umLe+yLrrOIVatqB80AGsW+YQ+0cvxqmMyZfoOpBbHA+VRPuJBdd345Irddan0DOZcC6K9a5Xh1DUMXbuKVhWvmTfr9G8jdTCWeTu5BJsK55ppPcUi9yXwcaGvDXMKfiGcbJq0agxl7/YoYSmz9pguGfASYzReqTsrwN1IZBAtQNOCc43giz/v2lGY4WaG6J899PzrldgRtP5EJSjCwdna5PCBoOIv5tdrurRYaksFQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OevQGhWMOuFEDreDtDUYB2GPX2/O8GGc/K17sy8EdVb1LFKkgxOAC7aJnD68KzJj7DOtrbTO5KPn6ZRtub7b/iSgJZpCYihIv1G3BIu9dQIadmk6fyQ65NgtuOCBnuahSYMmhCXnk7258Um0mCcFsY90GgTvXAKZETThnUVt3nuaUsjuPpZjjAx8UqB5d17haJ2MuTmrnHXl3V1KzQqR8a0PjXs5+uj9P8lNxT/4fHOrVjc3L1CnUzNMCGx1mDvrRk/M1ZO1nwKE50xwcDwXeNHjpoAnKNE+ms38G3xTyGj2BjnQpiDyRepeo9xmKk4uHFTunpj2uzIcrFeW3JOLUkbHPLKo53rC6xSONiJSF4BctzaQ/nGhwysu+Zoz6tGzYLyurcOt3rJQ1n7Gq3rH5+OcKmRKa/klP93GBzD+/AvhGtLz2DZnLDyI/EVy8xa+ALD0LOa4BdWQBPORPhJExgSct43SaAfDrILaBsp4RrSyjCIIEEFx5fjhXLs6ChxNxvEIUjQlrPWrrIsT5l+48nxh/fzyifahM88zanl+wDEZjhvnlJwCZgcN+lE9uaaCxrI3i7jgs3kwQn4cwBeIW/bwHhl/YTseSJgTe19XgOVZH5WMLNANf/cqrrf776FQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3f9fcf-7fe6-4971-6bc4-08df4a2fea7f
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:36:16.8903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXYhYLtZboXkQ4X4cXuJNSx54dIunpWMzEMtRwFi8aXB1n0Q6+D3bPQrudUmg4KK0jb+3pKZfurvkhC3PB/05aj1JhaQpDTnx38EPWoC8gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7527

Add the UAPI definitions for passing I/O priorities, and with them SCSI
command duration limit (CDL) hints, to user space:

- BLKTRACE_FLAG_IOPRIO in blk_user_trace_setup2::flags to request I/O
  priority tracing,
- __BLK_TA_IOPRIO in the action to mark events which carry an I/O
  priority, and
- an ioprio member in struct blk_io_trace2, taken from the reserved
  padding, so the size and layout of the structure do not change.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 10 ++++++++--
 kernel/trace/blktrace.c           |  2 ++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 7c092d9f3aa4..7c580e5f62b5 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -67,6 +67,7 @@ enum blktrace_act {
 	__BLK_TA_ZONE_PLUG,		/* zone write plug was plugged */
 	__BLK_TA_ZONE_UNPLUG,		/* zone write plug was unplugged */
 	__BLK_TA_CGROUP = 1 << 8,	/* from a cgroup*/
+	__BLK_TA_IOPRIO = 1 << 9,	/* blk_io_trace2.ioprio is valid */
 };
 
 /*
@@ -145,7 +146,8 @@ struct blk_io_trace2 {
 	__u32 cpu;		/* on what cpu did it happen */
 	__u16 error;		/* completion error */
 	__u16 pdu_len;		/* length of data after this trace */
-	__u8 pad[12];
+	__u16 ioprio;		/* valid if action & __BLK_TA_IOPRIO */
+	__u8 pad[10];
 	/* cgroup id will be stored here if it exists */
 };
 /*
@@ -190,8 +192,12 @@ struct blk_user_trace_setup2 {
 	__u64 start_lba;
 	__u64 end_lba;
 	__u32 pid;
-	__u32 flags;		/* currently unused */
+	__u32 flags;				/* input, BLKTRACE_FLAG_* */
 	__u64 reserved[11];
 };
 
+/* blk_user_trace_setup2.flags */
+#define BLKTRACE_FLAG_IOPRIO	(1U << 0)	/* record I/O priorities */
+#define BLKTRACE_FLAGS_MASK	(BLKTRACE_FLAG_IOPRIO)
+
 #endif /* _UAPIBLKTRACE_H */
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 04a450542389..4d39edc6730d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1860,6 +1860,8 @@ static int __init __init_blk_tracer(void)
 	BUILD_BUG_ON(__alignof__(struct blk_user_trace_setup2) %
 		     __alignof__(long));
 	BUILD_BUG_ON(__alignof__(struct blk_io_trace2) % __alignof__(long));
+	BUILD_BUG_ON(sizeof(struct blk_io_trace2) != 64);
+	BUILD_BUG_ON(offsetof(struct blk_io_trace2, ioprio) != 52);
 
 	return 0;
 }
-- 
2.56.1

