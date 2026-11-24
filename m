Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527385;
	b=VBYds21Gh5UA8JIafAZ3kbtRlj6+lkhoKUO0Dpe96qBAMCWJFf8hULNoq1n4otJjOK7d
	 eC8bBP2LXM3WbFHLwHX5JdoX+m9jJBrzkoPfL7T40SNOiiue99vRS4tZvO5o8EBdaZ2is
	 /dADjs6GgcCvTnZ+bbGThRqRCJcfq5SvMtIqzZZOJFnT+E5JLIxQ4xZ585aG6A1LfM2t6
	 aatvD1FnljqP0U7Xsil/uRhhZnVuE04Q7349R7spF0IN+ywGBokcCu2cTXBbhZDszeHA4
	 BD1UrKEqeH5Y93jimBRNQXbOLkDn5LlW+boxYamJxpqSxtaRmox7fmdnIgGoYciA6Mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527385;
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
	bh=oXdobKX4QgbYN1I1mbB6NF1w6Cv0U2PIbSgshFPUFFw=;
	b=UAvISZOunk+3MtoOsHI9HXC1bK6V1/rwCe67AuEsC6rqjc84uL1/HFIUeg+vgn6RDj2B
	 rPrKEZ48Pbifce7+cfKW0gtHrBMykCPn5RYxBH68UM4fLD7Mm4MNPL37aQ3MWGfPsWr2p
	 b1HoKrj4l9vTG7zZ1YVJcTGA4+fkK9Hv3lHj9kfkM9iOXAs2bielCRhjTNUx3alCB3Ogg
	 lvOc+/8w5T7lEXPv5ggN8G+3EmbNNNoN5gSxIdRzjibLR90rOB4h62dQcrUBILcoDABit
	 jFPJOH12XZbBxWgdiPUX8GrENgsyABhws1y+9vTAvcTHyNzQJKAh8k+W2cLUhed4M4w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=lWFDjV3R;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=ypcVtNq9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F90606A31E
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 13:36:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37F90606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=lWFDjV3R;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=ypcVtNq9
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795527384; x=1827063384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=HNI5FUnm/ymHTLVS4GluqMcdX45dnksfTkbF80rgAtc=;
  b=lWFDjV3RGCQDGW4oZydkTf06isTjfrLhyiQJf0Lvb/hnFV9f+/otmRt7
   xWFD1lwflMFTM6kEvhCZ7sKa+g7jSP2JWWv5IIuVrLCJECc9RUZrld4Sq
   1aFj6Xjwu4U7aQbMmYfKS7CaxTkFN6sAsLSjqJk0asoiNgrXRL5hIfPgG
   G7mJmu/TIddC9v+gBUeEY5LRZ183w57Khth4dUrWZmtZwNby3K2nhtWBL
   yk1zI6ADBv6jeNRI3Bg2Tk1Zc9s32c6eMxx3vTucvkMusU+Srqs/ebVai
   2hOS+lHD+T4WKvCxOcMvousUMVWfZ88Y50e9uua9YP5TdSU56NqJy94Z0
   Q==;
X-CSE-ConnectionGUID: CZJzN7L7S+iagwN5LfUY5Q==
X-CSE-MsgGUID: yFnvavkvSk+5CymMfzKsrA==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="161579905"
Received: from mail-northcentralusazon11013034.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.34])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:36:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGF1QheURW6KFtrX9tq/aBKFXxv9Jv+3rAOA25SOdD0x5JH4zGUFUEzEIAPZlFRLxsTUo+4HaIDZl8rjmgiLYS2V0R7ijFbxFXjXpovUjar6KrcmSi3I23V87hBr4OnMbNxFnV/vvP5mc1eI6Vw+MQv1ZH5m9uuHhZw8aycVLDMeBV1KIp3mKcwzsEZbpJGj9eiZzXhGj25K1AZfXkwtUGkmuKixiJ9e8IocS1dn+AXkoXjE14ey1NdMh9w1exVSvfiXrTkrX5cTp/Iigh8Q1tTzSOL3PN1ibOVTaZ0gmyZfwcEUqV88myisDT3lce1ID5b0och/uJitMnsLFJgAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXdobKX4QgbYN1I1mbB6NF1w6Cv0U2PIbSgshFPUFFw=;
 b=vg3qvdSQvUZvvgujaUZ7Mz+Kj/v5QAMe3TN7ex51qQGQSEtodD88PRUkwbO0TefBKDC9A7qS7Ed84cPnQuNsTxGc5J1MJXrK4gL1ZtgmEOU0QAgnlJ3tTaavAmHiQ7jKN00TmPtc8Kb9VEcoG+iT6anaEpOkvQPpu+ZTyMLEZYu6xmGtmg0v40/2l9ixTVX8hbmAIpf7LKQqd69lLQDghyPltynv7veTJYV5SNdo1VNJvg8SvGa5v8RzVQkB+ro3LQ+/EdATTp1+XIymW1B6rBIKx8joBkhjHrGDgKfcCkS+I/9QIZad/2L3HajzHRVHRNa4vMW749yIOkGNAjhmpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXdobKX4QgbYN1I1mbB6NF1w6Cv0U2PIbSgshFPUFFw=;
 b=ypcVtNq9v7UbsB1lmyQ9PiCfUqIy4GKKgrxyABY7eILaSYqG/rykMYNa0kgjE/4YLhQ6ye3EW3wFrOwFUGah2++gkYoBkxBMiEdHiVfDvDM51Ofh7duTCHFmLFvyw1Wa805NNWwjaHaKELzNhvmYO5PBOTs/PL0kRsGhb8nFcks=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by PH0PR04MB7527.namprd04.prod.outlook.com (2603:10b6:510:4c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 13:36:21 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:36:20 +0000
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
Subject: [PATCH 3/5] blktrace: record I/O priorities if requested
Date: Tue, 24 Nov 2026 14:35:51 +0100
Message-ID: <20261124133553.152463-4-johannes.thumshirn@wdc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 12420a7e-f118-409b-0dd8-08df4a2fece1
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|23010399003|1800799024|19092799006|10067099003|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	uhmgwRQzQ9WGza6rjriWKoTz/oomz1LVcs2Haw0gOj15NPX7sea66Rk2B3jdR83GfnmDWioKtZfQzHYZyhPckZVkgIw1Leawl85xkiVIkvflTy1sDPNNU07mHgFXSFJqWA79oYsvySyuTg/oxaEuFq/hS1+Ya886Rbs+b6vrHWfKg4Vf9wJwDtmdIOuswzdPS9+OGw7Z5UqXTaD7DMm1tMZsKS18HCpOUqtajYoYOLzKinQuxF935+s3MB5w+JFW4kEovqaEuW/hHaue+rfIlIj81UfGwOsWLfqqrxQvvWzeUvefur0DhAH+OZUjLO6m51N5OLk8tlLNlwrk19wycjTjnFIrOIpR1hiRGsdM6WiJNaI3Chli5iy8KAP3lpSWE7iCXis1AlefDmUb+nN813XG4fh6S+Ns4zbM0C+/+k+9LP6znVT8L8KeJ2jh6ifT+CczsZX1CWZUX6RDEZOVBZWln6sO1ebZ7teB2OF8XJnRJmCq9MGPCDGQXhK0Dge1DTKxcTFGYm7GXh96tdEUvjUAQwFDA41cim2Wb5gWa5rs5TubHQ3IJeHjmUkbLmLqaS8gycScIL4Rp2MNfnWxut2gVQnIDqRc8a29uu7erP472TzLy2fNvHt0EX+azPIB3gE1txrZdaimryUoHEo8DfF2yFmrtmXAZfhsxUFilTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(23010399003)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2Vxn70fi9y/MINmgueyJ2LmymXycmfjDW9fyYNjW43j4QdCLM16cDxodVnv/?=
 =?us-ascii?Q?HnnSKXzHavkC8zjewm3HKynK0FnepAmfHXYecDmI71llruEAun8/e0s8SBaV?=
 =?us-ascii?Q?uoqxrmQ1GUZygMQxoawV8QlduCqvZ52qqWimfmAh+DeX4e0a2Lq40d3K86+x?=
 =?us-ascii?Q?4pizvLsHY41QUB/5k8i6b2fV4wV4cHSoFwKlM3e59AWUEBmghKbNcjtUI1yY?=
 =?us-ascii?Q?TzCQ0clpobrHlpSvIKHU9MJe/cuB7hchOpM72qNItgL94aEwZ8G4YATnJP+N?=
 =?us-ascii?Q?y7KIOZHCCpoBshRrE4Qle9MC8afobNJ2JTbG/roa3nCXApKyX4NcYrvo2cPL?=
 =?us-ascii?Q?eeAIyzrB97jGH+V5GDDrTNLA7Qwsu5loNvZsU5psfcofZ7qjvNUBXxQRZoLx?=
 =?us-ascii?Q?jUXIlTwgJbICcPBNyI7uRMgAbajn6GMeVeS7fLES3AeBqviNyizuQy8+ESP6?=
 =?us-ascii?Q?V0c5B+UNT+bmXT/9wkhoGKH20Q2zejcvBYzM8tzoD/HrnaCIAIHGwTVGXx6y?=
 =?us-ascii?Q?Siw/+wrLYtUk10tgpaW1HvQ9m1ZzplHS3YrgeHqOEPrKTP1lbgSHoUdZ8+/e?=
 =?us-ascii?Q?VDV6UB4vx/eamP9C1eL6Wgzg690xLHOkE+GSlRJva2WrGpn4TBC5vtDmOsS0?=
 =?us-ascii?Q?BaeMvPAClvK4PrRlTnrK5CY6o5B2K7BHXQBvusqHmfq+YQlQXNGQMMTIeVZT?=
 =?us-ascii?Q?ddHq3vNLGyNUlzNb0Tpc9ywKG89IgbzH7JVWY8fz7fTvo+UkNoqrL5wf4F00?=
 =?us-ascii?Q?n2yG4qBMDySd7ZijMJSLSwcFMnRDQJ3u9wHHXQ8jXZO9+QSA3yoHBJe9sZfu?=
 =?us-ascii?Q?9108hi1YwmhPONAS61VzW0kfGJyYHntgA9Nf3kgr5TY9Pis/LCnPURUsiYPS?=
 =?us-ascii?Q?HB4xOF8a68g8CzIs9jId7n55WMpvqvagGrNRJi12qV9mik0voU/X3JcvsYW+?=
 =?us-ascii?Q?P8kl13YAxH7lwML/eNvTOAt1+EKjGK9FQdkLWKA4pG8srhwOkCcizv2gu7lA?=
 =?us-ascii?Q?Q1JbldOdybEr7R7nfZ09dxOYDig3JW5ot4zNyIU2Ez624yjTE9g4Emi6Bvzt?=
 =?us-ascii?Q?/2YwKorsd+92fyXb/4ItjGbK1Q7J49qaxgvx9Nd3xQq/8NKw9iVfjCdZRFRu?=
 =?us-ascii?Q?S2z3Oe6It3Nzzmt4quBf3zppcefRwqwGnHSNcLLry+Ns8gfLEMEzLmsO17CT?=
 =?us-ascii?Q?POgkmChYQlchEM1aOE8uusbgmjm9gUd2uSkRVSHTan8phCsU6ZVn9aoA2Eig?=
 =?us-ascii?Q?qx2Cjfr21kSSYkW1LkGQOY8SCM9q4OAIZ9RFz0dnLFWkCccjWHBkTVZMfFtc?=
 =?us-ascii?Q?xfATsrnDemmHjIgNRZK3SFSJmheG+OfXtQIEef01E/BKuFU10pr1QEkfLTMF?=
 =?us-ascii?Q?F0i1GyYOpkDWqNtNM84bd2kuI2qMoiA4vukskBuO/iY1OjPNBzV3xyG3pkqG?=
 =?us-ascii?Q?maLxAbGOK78X+P11E4Bs0cux0xPpi7/Q68ySnLzJEydyZNIg03VgeU/Ca1+s?=
 =?us-ascii?Q?kZYNyx5Z9VsobwQ5Ji02fvbtinHBGAIVvMD+TSdBPSIDV15qmde2wNSQcDrI?=
 =?us-ascii?Q?3fKxQOBbJjcOxKic9AO3z9+Lt/qcEL3ocYFzm828hSMDhgaPtQodGfQoSOrU?=
 =?us-ascii?Q?u6BAQmed4xL85ulUS7fro/odhWuEqaIZlpYf21KOlrrk0jVihMPdksm/JxO0?=
 =?us-ascii?Q?iAMOtb21l54X554HvPYL7CVXyZA/vvgFFU1Sf4JlNq4mX/ACijKf4bUrLHMK?=
 =?us-ascii?Q?oRLxh1JETDnMv0coPSopSDqcOIK0Rgs/SwnUQQNAPEms0+uELXuHe1MYnoyW?=
X-MS-Exchange-AntiSpam-MessageData-1: mbSE4MDHCmp7ZcPQhFvRlXbKnuQ/GBTNP+4=
X-Exchange-RoutingPolicyChecked:
	aSPCi5SAmrJuhUiTFOuUZpBRzwhuCyEUeonQY7ML0cFArdCjKu0zSfh7J2yzTnOnz96cotPnpHaw/fUzFXYt2gJWnlt0UNT6mAGxT3WO7dyTinTW0yQ5+SsYTw2bw8VU62lq7BWTqaIcB0jubBNbtK4/f/5GHJuA3uDRQDq0DuQYR5jUbrAj1VMw23X5hPn9h6aI2kMzmVMsw89ACIsC7tM/55jrLy0RrGfx9vVL36T/BXpRGMDLpEOibK4YCjJzNoL6tnD2D/dC50yqxSHY3sLBkLRJOeU4H0jROVAcqkNyNcX1tpJka1+QAtGLRl0esCaGNAWb9qF1bEZkRHFfEw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6cz7cfw4iB7l7Fw+ZEy0mwWu+3+kgPAPbtA1GB81IUWqUGUWlX71l5qksMZvDiiVS++s0YLyt9mti66Ou99IbHkh9O2fVg/AMh8vaxWaFxcr69sa3mrHCw+ENOA7m40WSO5sd34YiB0bc/37xLjocyufztgTxmOVZn0xWkv0BVIOgbj3pwz80jGyk+aUhTWkBqwappxL9t5KSAkaFDtEdt+ix+CY5Lo9UgzAFiNgkUrCArQ4MOgtDPHRkCiQzVSqHNP7h3tzbu/5/5GkJzeIGQiBJrJNUD9dkKDMZIFJ2KPvm3ZpSZn4bp5T67+tp9ICPO2tS+CqkaP3kygGx99MIFT4AWsGgAcrPxv76CW6LXcLncKcwHRx9gWeeMzO5VJXyEzXj+8UDNJbWLQlszD/688U6vfGNHcgzTGxqU7F4auapTPzGn+5DTJyJ18qn9l7GIvCcDtod4xBsD9FoOrxQITi2+K4BA2/Hu8hZZOb+oCM6h2I3XoX2x1ue9D0ASuvrJFHOp2aOYGtiZv7Xd0ACymDXhz+Eq+NxLTsb2rl65YN91Tm9bFKS/krDENSmfL38dtUjXAnvFhmyHBSvOFUxxI86O3MBu5ruE4n13/KZ8d7FYTJxY8SpMDdw0FwsPP7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12420a7e-f118-409b-0dd8-08df4a2fece1
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:36:20.9146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Suq581jhGqSFDS1SPgm/vBu78LyxyGRw5QNfhd+chuSGxvFzQgX/GNLnJYw4pzUnBP6Xmji9Mu6gCMF7StQqv876BUfa621mpTEooobRrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7527

Accept BLKTRACE_FLAG_IOPRIO in BLKTRACESETUP2 and, if it is set, mark all
events that belong to a bio or request with __BLK_TA_IOPRIO, so user space
knows that blk_io_trace2::ioprio is valid. Old kernels reject the flag
with -EINVAL, so user space can detect the support. BLKTRACESETUP (v1)
has no flags and therefore never gets I/O priorities.

For the ftrace blk tracer the TRACE_BLK_OPT_IOPRIO flag is checked
instead, the corresponding tracer option is added together with the
decoding of the I/O priority in the next patch.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/blktrace_api.h |  1 +
 kernel/trace/blktrace.c      | 13 ++++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 05c8754456aa..63d76a176e9a 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -27,6 +27,7 @@ struct blk_trace {
 	struct dentry *dir;
 	struct list_head running_list;
 	atomic_t dropped;
+	u32 flags;
 };
 
 extern int blk_trace_ioctl(struct block_device *, unsigned, char __user *);
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index c57df30750e9..f1a3407d36c9 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -40,6 +40,7 @@ static __cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(running_trace_lock);
 #define TRACE_BLK_OPT_CLASSIC	0x1
 #define TRACE_BLK_OPT_CGROUP	0x2
 #define TRACE_BLK_OPT_CGNAME	0x4
+#define TRACE_BLK_OPT_IOPRIO	0x8
 
 static struct tracer_opt blk_tracer_opts[] = {
 	/* Default disable the minimalistic output */
@@ -308,6 +309,13 @@ static const u32 ddir_act[2] = { BLK_TC_ACT(BLK_TC_READ),
 #define MASK_TC_BIT(rw, __name) ((__force u32)(rw & REQ_ ## __name) <<	\
 	  (ilog2(BLK_TC_ ## __name) + BLK_TC_SHIFT - __REQ_ ## __name))
 
+static bool blk_trace_want_ioprio(struct blk_trace *bt, bool blk_tracer)
+{
+	if (blk_tracer)
+		return blk_tracer_flags.val & TRACE_BLK_OPT_IOPRIO;
+	return bt->version == 2 && (bt->flags & BLKTRACE_FLAG_IOPRIO);
+}
+
 /*
  * The worker for the various blk_add_trace*() types. Fills out a
  * blk_io_trace structure and places it in a per-cpu subbuffer.
@@ -381,6 +389,8 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 
 	if (cgid)
 		what |= __BLK_TA_CGROUP;
+	if (ioprio >= 0 && blk_trace_want_ioprio(bt, blk_tracer))
+		what |= __BLK_TA_IOPRIO;
 
 	pid = tsk->pid;
 	if (act_log_check(bt, what, sector, pid))
@@ -760,6 +770,7 @@ static void blk_trace_setup_finalize(struct request_queue *q,
 
 	bt->pid = buts->pid;
 	bt->trace_state = Blktrace_setup;
+	bt->flags = buts->flags;
 
 	rcu_assign_pointer(q->blk_trace, bt);
 	get_probe_ref();
@@ -823,7 +834,7 @@ static int blk_trace_setup2(struct request_queue *q, char *name, dev_t dev,
 	if (!buts2.buf_size || !buts2.buf_nr)
 		return -EINVAL;
 
-	if (buts2.flags != 0)
+	if (buts2.flags & ~BLKTRACE_FLAGS_MASK)
 		return -EINVAL;
 
 	memflags = blk_debugfs_lock(q);
-- 
2.56.1

