Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794393406;
	b=wuMhgHAmFaxHMedW6TnMOJEu/s6RC4oi5yswzJygG2fXpZ9UOcUDlsdbJWqJI12lnALR
	 KlE5VxseEuNVqoBRINDxHbl2VG8/CTCN1oGi72PkvJC+Kh03RDXZAjF0b0q+w02W+q7+w
	 BeBCTPJzqsq6xoCtjMCXwcmMZfKMDSa5wkLqPefF8AVmgzQhItqvC4mzGEYkyhnTSC7y2
	 oBTK99gcrlgWIBK4phxZ9bh19g1TXX5+SQYUcfgW4WyTw+Z1PrO5ofimh9GR9j+7FyU2k
	 iAN2MVnMa6Y64iFmb6AVxaxFRyYkQ9MC5aA6g4mDmK8gWswuoizJEPoaTc6F1G3JQYA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393406;
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
	bh=EMdB//qG1bBeox7/T8gujy1n6Nswo75oEMqY7ndZjf4=;
	b=1mrr6c1nVWcMFUvCB+ZResBj2xSfobUrtartnfHk/Z5BzcJx/qSKTN/wwwiujHSc1yHG
	 rDrUx7zwemVu+zE75qphzVSAVmOY3QgFXy2RVHFh6jvpLfCZwPAbzPQXSGn93emAv4z4G
	 O8XEnjesj9pXvFRKzhUq2YZcqMcghvKebg1ln8dDt3fymG1qfzA9d1Aly7fzsHB2+h+4m
	 QiepTgzG3NGDJOytPrSJSP+2B6Imz4I2pUdKKkMg/ars5GyEWEtlOc2/mz5jvGwxpaFm3
	 WVH0vq9+c7iGgB9rAnCFxNSYMnmC23vWbFnzjHGaXbey8VmUpNZKjWm2C8Ba5Gkh2QA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=YlR1ZcYH;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=bjqpnTu9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.45
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7036E606A8A8
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 10:36:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7036E606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=YlR1ZcYH;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=bjqpnTu9
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794393405; x=1825929405;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xYlg3WBQ8njZTbkXEYOiqnx/F/OexuGe/5Kk1khC/ac=;
  b=YlR1ZcYHE/MYyIsSOCMi4M2FBDb9Hd3kAPQTkrOzicn+8lQp3dwXTXvL
   SxkhmFXuGmaICw7QXES9EZ+BHJaHJjaa4nSmlZuk9o1unsuwwPWG6DIyU
   ruyVhXo9nHfaP0kczv26FRoRqV6YypnjON03+eOd9wvqOIS2ae3hGBP0X
   Oqo3obXrrMtdjkPTyOiXgPnXsuHBfxmokZQ2rGlzjc8Zugc25nacG5/Ir
   FrV/E2UrIJ3WQ++E8yEYPeL6I860ONBQLc5bC2UzfebrZ5dJjFoF8wH8g
   IdvhsWzZtF3vw5v3IUMXC29+Eau30nMfs3iYftzGAhhz/h1E3hRYJOhvy
   w==;
X-CSE-ConnectionGUID: 7KZ9bcY5QfSFf4tTXbWGHA==
X-CSE-MsgGUID: tHU9zfd8TpK1S9G5+nlvVQ==
X-IronPort-AV: E=Sophos;i="6.27,207,1786982400"; 
   d="scan'208";a="159017902"
Received: from mail-westcentralusazon11013012.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.12])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Nov 2026 18:36:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8zCRgVYH9w6S5uZqSZGBn7/1KezvcFR75B3/2YqBrOspWnf5UIgB2oMlnZCxIEX28P4Zk2tdDRL/67oDlZ1BGZFN7ULj1pc0bffR1+gsyOORnvyr2buNfeTdn8d3ifqj9OfCdgWlbpl5zRPYl2pqSIZkvXxbajrMgHimNoWFaWmqRjbe4utIQhigEYNRvWFQDSpHGQ6NTkWRrsDOiKRFDLDpPvf+kquQOsQbmI67l1iv61gqpYj/dnPx5EY5b+Vhc9FHAf/5uqQ5eCaZN/Tu9MJ3d8fb49BXaTFMRC/bRa5BSfjZs2OlMgSk4zMQDWW8o9Q/WqLLw6GFwS8IzpaWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMdB//qG1bBeox7/T8gujy1n6Nswo75oEMqY7ndZjf4=;
 b=xDXwlMNVp1yiHfSRnMrxLnE1nAnY3TDTKUfKGSnJr1v0vPw3eF4vzOPOHSfAzSTBJbOCU7vIWENPdtf0hBxLpxROO14U5PeagKWYTzyLuwJVVT8rqPeLUQoeFOnP/G74Vhsx6/dYpbtNXZXld/7M5YYUXsyosNMwNqNUH+tiKVAjCIZyZ+y1a6uyiE1fS0uoWpQKoc+4A4i9FSRrgkOKt8w0XlcI69r8vUUVA9eY9im7tbTaHl7oMDl4eFyEyMJnFlRT9SAQX8zfiG3gdDgK2pw+Kp+WHsHv8pK0Q6wR1XpnAluCYJiJ7h5HQpzGcoKO0qGVSF6K37By4mq4edEO8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMdB//qG1bBeox7/T8gujy1n6Nswo75oEMqY7ndZjf4=;
 b=bjqpnTu9mQQ9BTs8zpPuxINrfhcHqGqunv+6Tu1e4Akhh3hO4yPW2TUDxSaKvJReOfGFJTWSTqrR+JOI4Fcqwykkk9+8EcHlIjYrgW8Xcgj7Dqdh5a4C3o7FzNSF3TWIgmSNwU32OJzT4sQyHVkUu6Qyp3Jjfaj9QaDhSTPGIOM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by CY1PR04MB9716.namprd04.prod.outlook.com
 (2603:10b6:930:104::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 10:36:37 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 10:36:36 +0000
Date: Wed, 11 Nov 2026 19:36:31 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests 00/10] nvme: make NVME_TARGET_CONTROL work with
 remote targets
Message-ID: <avREkjfeJjzFg-0x@shinmob>
References: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de>
X-ClientProxiedBy: TYCP286CA0232.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::18) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|CY1PR04MB9716:EE_
X-MS-Office365-Filtering-Correlation-Id: 60dbd08d-a542-454e-b801-08df3fdfa9a2
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|19092799006|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	h43N0eSd0khdj+LvCNNa+puW3Nk0N3CM2/hO2yDhoA1H83vF6ClsNmUDiKsTrUz3a96e2wZl379KgKBQ6kThxox7MgPpQW7oer4lxB/oLD7U3CabGd5d6p5ZiXg6XgdJG0jRjisvTP0hQ7n+nP5D62Fq+luRiVTN0hIEjAbs/fstz4U4cSDOzYsQ/5sXkEaNxSpvgKVwgzzeJFzeaeomvniJX1L9AaalJszyYCV3/nsRAHd4GfMyXm8yf5kEfeDR/8Dyn6LPqdJr+PqJ/SPvpUYGMvZ4JpGsRDTnzVW18X+PZBsYWUTc18rgblMQnYDKy2Cr90T4Lf810e60xaCwqMn8TaY1QxRy/Hmq8RrXGOXZc+wt7pDjLX9jT1RvOWIBAwsm3nj7e5q8v2K5n23oCd1IHxse/8WKoaMlbN11s28/04xXKFVCcBt/fDKI22+JUhOcXj0tQyzYbn3IAgrnlCy8F8c7DwTydrEaoILK6589vKuhP4btXj9qzaJ9wjEDUP7zIKA3iD/dvJ/XTq8qPDZaaexNJhSlp1nBeUo4ZRDSNJ7gKtOK5FbK60d4/uC4tt1iFdyybB1sqBnIDfhI0HKicUZk6HyLIN6R1RP0SiIvuxnxqMYRdDuA5Qnhm4EBMD9eMGL+Lzdq/RAWG/k8P5W1wMbE2sGgFDIu3L3Mu64=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f7hCIbJ5h0Te6kn9OrqOK8y62vf9z9yjq+AwFP+009kJc0/qWNcdv71srYYC?=
 =?us-ascii?Q?fev/qezpaliRvdibXuyLcvNsZ2m1TkwDbEK+LTFJ75ufCT3F8/64qyhIR+6J?=
 =?us-ascii?Q?NH6tTv3UWRGn5fr7NWUTauvZqAEeMhOTYQQgG2ZYWXAOog5C3QeDCMEmUAAG?=
 =?us-ascii?Q?zWrLiRQ09XGgJgs3WpVwC5WRe+gOjLzB5AJtr6Rvx6VoNxoID4TQijr9z473?=
 =?us-ascii?Q?sAvJEXQsVce7zRkiSNSrTDkTYgkK4kaaT9n5w5HrZn1kJ4v7GtTt7GeAD3aJ?=
 =?us-ascii?Q?zRwq3P+rgNeJMmtVolJ9PdX55OtU70ekdmf8BLeaYWIZ8x9btZi/ubwucZ6o?=
 =?us-ascii?Q?ThTCPNeDR7wNytxCRvhjSCID9rrMs3ra2E+Fgmn4cyzi/YPzhsPTaldMMLTj?=
 =?us-ascii?Q?h6S9SZCsFYTL92vT1H/xt2o+zf0ONLvrCKE/eCeVg3xwYrtV6NXROSP8m9L1?=
 =?us-ascii?Q?KamgP6RSW8v7waPneOW5aWlJF0av72biuUOmSSFSoV3jYJLNGuSW7wZccP8Q?=
 =?us-ascii?Q?UgxB7hz27zjodUgXRPa11njCvdGu1cm1Hr67FEZXzPwmxBfmKxqh1GRJs/NJ?=
 =?us-ascii?Q?0TMUoqrs2y/GOZLStHgde+3+qv3jJcwtALDCw+NBGHFQKf4lk6UMO4z2azv+?=
 =?us-ascii?Q?3/MPTTOunpEM0nfn1wSEw3s43OrpLqNDLpxWc5nsjFp+78aeduaJ9JrXOeZn?=
 =?us-ascii?Q?exzYdc2PQQ27S23LHg5XzRWMJK3FF8Kr4EokmA79e9r4Pyp1A7zNlgQchn9X?=
 =?us-ascii?Q?YHMWZJdaExyPI4mkT/d9MHBQimP6soXagtgH+B28mp5CCu4wSRzagO4T/kR7?=
 =?us-ascii?Q?tpeoYKb3EY0Cq+Gwga4QESxZP/zpoY0/ztID9tEXhmRGTsDsHeqVNAeL1hxi?=
 =?us-ascii?Q?6HKaKuUAC6DKfc3qo5O/EZ2Ia4yQTVYs+EwBLWZhQAtMLLjqwgsExADyKSPQ?=
 =?us-ascii?Q?oqRccV8LhDUFw7zPQsoq/u84dd+Rrprt4nshn4gvHSseebPdjVRruvpiVg9j?=
 =?us-ascii?Q?4QT8TafZobvIrmlncy8NrYrtECwZwumzd+iC/b1ymUBX/jDuRgqjDMvMzB7O?=
 =?us-ascii?Q?z4GM0gzIKvT0U/4TrI6kZPTLlewiCPzHVndi+270taXb4jLsPgwD/yAFrUQI?=
 =?us-ascii?Q?+kLtrwkOx5YbGGardMczxXFyXKRevp72w/XcTrJ+c5mRszS9P/uiuQ7nrw1S?=
 =?us-ascii?Q?zP+UTzNfc2L15eF0j20g6b3X53PvrA0kO+cqlDQFxh+PvMMH3gtM7d64irg2?=
 =?us-ascii?Q?2SrhsccTw+D/1o1FAYy35ZySnPMaSdpfwKSYE4IusyMTo2F0BImgbdeYnWic?=
 =?us-ascii?Q?1JmeZMZn1VQw7g/mk5L2bzXLj2BkEYRJltbkMmJCD/V+lCKoMu2n57VnkiOh?=
 =?us-ascii?Q?7zNyYAyOgMHCTT3EXt5rlaAO1onUvTijuwj316WaMqrJDZUwtrLYCKa/ko6y?=
 =?us-ascii?Q?DbQekJIU8TKIJqKSUkR3bW+aeSRgHQeaTtSUF7VmGouefV1MdYcf6FMLuQdk?=
 =?us-ascii?Q?gj1FQ4ow5OO8Tw8IcxPotAQxDJWg4uyur8iqmMcZH2tpyuoc+wA02O9ib+2D?=
 =?us-ascii?Q?DCUegEDj9alwGGoCl96FT4d0GMH46z6dOB9ig8vVvJTCWHf3v8y/3AfTMSzj?=
 =?us-ascii?Q?yxCFcu6jBnI70TiTwIdX60tsy6RHj+UpwZVRjrSQmgdQZQaM5juncopLhOgx?=
 =?us-ascii?Q?RFdYEQVSw4gALLt8ta8r87sG10R81e5R7/3NwLPaMQ3dpQ2dSagJXVvyTPJG?=
 =?us-ascii?Q?9Hf72/I/bjOmGWaCuN4urmgkDwGuWr0=3D?=
X-Exchange-RoutingPolicyChecked:
	n0Gu2MzY1lf4wivPxN/h2vzI+4vvXFoFPTJ0S0QTvk6v5w0e/PwLumZwmBOv6bdSym7i606OA2dTrYgrOgKNt5+wy3Ck8Q64UNwgWa7HRE4vLydg/3nbLAf9wCP71t5AlCXfqlaWeHfkREH1uXjM1fqXsbOuzxWaYIF2UwJfZdASlaLyper+kma1YymieQa2kKQZm31JaP0m6kegIhMX3AkT7n/gp+wMXEz7WMLHVDnOgKopEPxT/t426e7z6UD2H+SXehWTJcJiQ5/Lka4tthyGmu/gPYVCrQFYBpZXT3HgyBgeKeVYqhoFWNrxEjwVIGM2za35lBcVrsv14GpUgA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JQ2gEfaoDZziQLqrsXltk6gwTq/rZJzgZHWq9ZaWSJFaV5ytW7MLAvFQnK9L2GQqPLtfG+RtxDNdfDCSC3L8etvZfR/fgsLI7YJLHdxYM2dFGml3IL5MT10FKAQ1Yz8phs2W7h8wndCEOsDUJOZhopvIQWAXIzsLZg2+zY/jNcRs4D01GfRk/+3uy1hx/GMgTBKOLdfuNCANr7n4FDf+DC/0GiqkERSc8JfQqdRLoiG90Sm3t8oYvzsg7VIflekbNnuBjqsC23Wi7OMzg4wU7NzI13+z2Md8/4Kl2FHzu2rznhyQoHObU9MK/aCDVs8PgH87bjHskemoqb04InnafezFa1uaRdwvToRq1qSbXeIFi4Z5rO+dfQEujrz0uji9uj8TmbG60VSkOYUSM1FiNs5FPCZm7SPtlajs6Lw8UwoIE8HOyGstusoZWgo0XELrRq5rJgB3R7nlnJxo6HRRIepRSrnSml6/0GBQ2PF7VHbkmo3Pcn8rhz+xp1zogmFEB7NPvRPWmCC/ntLwOg86aKJwLF/b3ENA/Oo8jB2AxcSRAK/Gk6eXLbQQP60FLoK6Ok0or938zmjhPoeydof6zo+D7GtYZq50Mz9V4FixTt5DcaBdU9tRmJWZxBHEYZNI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60dbd08d-a542-454e-b801-08df3fdfa9a2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 10:36:36.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Frl2f7t+v4dlaUcQemmKKUrMKhDd8ovDsOmrlT2xUln+jUJ4Zk8ZcS3eeE5G317dYaon9PCM+fX/av+JVKbO9BhJOM8fmERoVf5TkUsZrw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB9716

On Nov 04, 2026 / 17:44, Daniel Wagner wrote:
> Running the nvme fabrics tests against a remote target with
> NVME_TARGET_CONTROL doesn't work in current upstream:
> 
> - contrib/nvme_target_control.py configures the target with nvmetcli
>   through a REST API which only exists in an nvmetcli branch that was
>   never merged, and its nvmetcli client crashes with configshell-fb 2.0.
>   The target is never set up and the tests fail to connect.
> 
> - With a target set up by other means, the tests pass without testing
>   anything: _nvme_ns_ready waits for the namespaces in the local nvmet
>   configfs, which doesn't exist for a remote target. _nvme_connect_subsys
>   returns an error after every connect, the tests skip their I/O and the
>   disconnect, and the harness reports leftover controllers.
> 
> - The tests which use more than one port configure the ports in the
>   local nvmet configfs, and add-ports is a stub. The authentication
>   tests change the host keys there too.

(snip)

Daniel, thank you for the series. I walked through the patches and all look
valuable. I applied first six patches. I made minor comments on the two patches
out of the left four patches. Please see if they make sense for you.
