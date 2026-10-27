Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793086986;
	b=oFBcQiJarSfzBPHjU0SwlcIk6x1r8r3UjiZPNIhE6tMPYccRuFfoNS3kDy/4yWHRzqXn
	 0qhgCaIyYriPFEUwm9MUebdr0OdwzvclbxHiGhrl4OKhpRgndj4u2r2w42XzLRIuOuTzM
	 6DV3vs6h4tq70TxUFCDg9ASVQ/9Feq8ajyYxP9Xb19EUqqO4tmxc4Q5bwd1ntr3mE/dCH
	 Y4WHeoIT1fvMiO78BIhq2976TSdXEY7LaI3coQYnpHrdwWpGLlem+uslM0qNGi0DkAW96
	 2Ne89QqzMsW7FRjCVhvvgiQ6ewMDUQppH7UXDi13vxoT+MThqIgMxJPAyQK4r61AMnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793086986;
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
	bh=O7mjCrMu/w4BSeIm+vrrf9zfQP+j+QiQxGGp3hHvl3U=;
	b=FfJ+v3YwfbdegT1XyzGuliX36C0NhRSdPRsSlisPQ+lwiLcIUsWwkFgCJwXMtDHePDd5
	 a35azv5p92IejNsbREMtfBl1huR2TL9ZbnxlazoS8c0GwZJgNq44ZjwsELsQ46EMicLQx
	 Nn51JFy5CDpOPBB4VnwuguNig6RwiE6UjyMxy0MVIalC+JAemcoe0lLHMHNEim46vrjCX
	 vP5xavHlu8SnDFU9apEH5SF9LuDZzTiBYmXFes5ux1NjaDGfJY7VaeIPu+TGL/IVbvLuZ
	 lBb6/jX7+TWK8OO3/+FQ9DO3o70a3dQ+MqdpRrEyNEmJ91YGmxDAPL4aKSV9rsLJ/SQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=gGv2yr5b;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b="mnX34bs/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.144
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E53606A31B
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 07:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16E53606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=gGv2yr5b;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=mnX34bs/
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1793086992; x=1824622992;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MeaoSAtOGFluGnsruvx61QbT+RebuncEzT5bk/EBPjE=;
  b=gGv2yr5bWwP5GvhAcpO6a6/kpBUnvJKBJu2kiRWkF5L6tIWBQFb0V9ph
   bHPjo72ZXtrRvoqMM0lkUU2oOL74P7pj90001/GKR7ooYPryLJGt+4hLO
   fgfCC8L89OZFCnLvI6/lsZ4wn9BZJcsy0xLQ62kPU9wPyMODOEcpzLYpH
   ApFlzSScX1TkGpCdWeFDNib2DmI/OEmlizSasfjIAOt6LTCTHo6SYRiHu
   h5RB5eblUj+JkyahlWVRBdZOkdHLYiPf50PvlP/DO1JsczQx87LoODCYo
   UeFWxPGCMRaDJIvX9pZhgOgc3VOrUDXAI+aQp4X05KLEfWBMDN4sZSTXO
   g==;
X-CSE-ConnectionGUID: pvRvlDITQpG7RWoVoD2UJA==
X-CSE-MsgGUID: 6OYaC0caQ5qXIvKv6ajhcw==
X-IronPort-AV: E=Sophos;i="6.27,180,1786982400"; 
   d="scan'208";a="158129361"
Received: from mail-northcentralusazon11013068.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.68])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Oct 2026 15:43:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuWiHOYH//HQrjqXFAsXqzxmk3f2DQx2pT0hj8CEinJOOaFBDJNr/oX6fW3MCLQSOpojcAs7/HJ/cG3478eaUCp2A5S/9vmYNDCakp9x092ZWhHE2vzcxNMSS/nNwGoibUYK+TB+A5148NBIWzgCmuUbZcTlUZTr0VFyBCEGoRW8zDe6uQDV3GFT/Y9D2mOWkio2lITm6EIhXuD4BodoU/kuv4kc2in+Kqk9GeL67ItRvkeua//snjqw2YgDXlSDz6xWW+wGyLVN9FsB/pe6XSbc2vTRd8pWx7r5ap0YLrzno0hI+YRqjMyX3YQRZB/EelYg5QeCc3aL5tBHTq8TOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7mjCrMu/w4BSeIm+vrrf9zfQP+j+QiQxGGp3hHvl3U=;
 b=bciAxYY4AYFXSCtk0/R5tdVpECW55NLT7as1dGiOqKEPszXlA02oDqH0OQszMIE9Xv+oGaEu9vOuGXmHTFrsHG/9KpXpOSXNHSjlXAaoUrxsKnaCtwf8zMyK0W5AnM6J6Jyosfe4NZr6dLJwx8PICP1zIJoV3wIajOrnryNLfhCzJXwXwhlrvvfk+UilJ8WLztmVh+iJ+NPDHPrKy9MDODNq+uAwJR4mV30waZU/LcRVlL30obCaL6r906k25lYIScGhMHSewkF3Bh4sy8LK88jOt+ROB/wfm0VUoSOeTwZQvL5vNDRrI4T+JVC3nY8aobpOWuxJltXtJ1g/3vDUUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7mjCrMu/w4BSeIm+vrrf9zfQP+j+QiQxGGp3hHvl3U=;
 b=mnX34bs/tGvhW0ctIA8+9d6fDAIvCAtYP69jemLK5ImwpDMchSpMsy4nzc4RMBLFFrpj9iS/Mf10r+zI1KpLArugUgl5vCp0GBQLFpt369wAxjpV8RWnRS4lME2MHfnHxsX+MCXUYGJECtdd9id8ABbmDF8elj/ECe8eN5vPGLU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SAWPR04MB993677.namprd04.prod.outlook.com
 (2603:10b6:806:55d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 07:43:03 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 07:43:03 +0000
Date: Tue, 27 Oct 2026 16:42:58 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Tal Zussman <tz2294@columbia.edu>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	John Garry <john.garry@linux.dev>
Subject: Re: [PATCH blktests v3 0/4] blktests: tests for the direct I/O
 fallback, splice, bio trimming, and atomic write fixes
Message-ID: <auBU8E_ZpqqApgkG@shinmob>
References: <20261015-blkdev-fixes-tests-v3-0-b6ffa6410514@columbia.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-blkdev-fixes-tests-v3-0-b6ffa6410514@columbia.edu>
X-ClientProxiedBy: TYCPR01CA0128.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::20) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SAWPR04MB993677:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ed196b-e710-4a50-c1c6-08df33fdeeb6
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|376014|1800799024|261026121527099003|11063799006|56012099006|261009223027099003|261022105027099003|261022075727099003|10067099003|18002099003|22082099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	S18pE/yb7JTPecHkRJIFqiS/bqp5XaMIf9l7RANsQRUP69oqCA5wS2kAcoQIe2qB2TU7Mpi32nIbQQ/SYtQaY80lXKvNfTufDx4prooq2z3BlucjRitOP93zHBXGTyIe6U7HxktodhzCfga5f/Kj8DGPuYjV0jWiXjNeyM07tsStj732qfyb2FP7iUfyH7h4qffjoxdI/YPs4F/PMf9GmUkD5nCnklZEX6ky3vKwMTWqEkZtvBK25Eq0M6sE5BjCC77lF3MVo3NoYsMDJfCd+2tWY3c8PZ1fgpnN6UlAzq1DDNxA+pdcJwTTe4oiUc7Ev7lQ7KKQyPlTvW/JPgYuiRvkRNGd5jOQz0haDCMbxabce1sNVLp5WLn2SF0usfSY5IwVjtltAFQC9BbNcxzQr0/d6rzXlCilmqC58POGhfsly4pLjgTYCGDuW5TiipXHBC0eUf+czwJlgnojf6f908Zcm+EiNpHlaAbd4olULU1avZyd2YN7hsh7PfVyzbY/ZK206enZQXG9qrMwxzPEG/pe0zG3kQ86eHb+OcPkAsBnJHuBY7LG8hsHt9IYfKFIEc8QgiWuXPI3hhaxzW8KA2m5coQlfGtnlp+3IZv2jhs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(376014)(1800799024)(261026121527099003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+uIfRSQDqdsZdE7mlNn2QG1YSdeVcE8fKgKrW56isstotkPgZKkgjfd9tmK4?=
 =?us-ascii?Q?wpDFwZhuXIrDPEG19hDB7L3xBfCLOkajdaI891HLpsMNRcCQg631nL82OX/o?=
 =?us-ascii?Q?JPPts30air1ivfw02juaaMpS4ilvtHmi1hRg8efFLiVlG8lDgN4A9u+lXpI6?=
 =?us-ascii?Q?NnmuYJeOgkWfTMQudtTncDChqa7fM7UZOqdqqjzYTfBBAGH9YX07kXhs8/CS?=
 =?us-ascii?Q?4U5ZKd72H+lK9yb37Dl+9UJvAtIftRW9Rg2kMqhrWd8FAjLKxVx5A7WfJ8i7?=
 =?us-ascii?Q?b4/2yOIt6rZCRzitXJtCPSVKNScpofFfO9KMa+4/5qJSDyJzl8vX7M1QdkF+?=
 =?us-ascii?Q?U7emX0+r8NdYra2aeXTwN01ud4HDUYNIOhz2F8icIqZGhcsw4h05v5YRATFm?=
 =?us-ascii?Q?A8WnFwGGPARycLdJUaqTXveG+i1OpgdQPVnvSPtZaE0d01dk1SgGIghT/iJh?=
 =?us-ascii?Q?ZWOdokn2RfNkec0ds737s7lM8yQkJ3oNE8B6zrBthr36L77A92U7n0gKb8Pb?=
 =?us-ascii?Q?fQ0sp80tfZKYwM7lAcf+KH1afGhGp9X2xhyMZ7+QKzDN3H16dCjcGBERwe7n?=
 =?us-ascii?Q?6hGVUSOhYDCfwM5lHbMHO3yGhF6+5APlSJMV+LWMDiJHJCJP9TIDKtOG+KHO?=
 =?us-ascii?Q?ldBbQM1xhzY0EHXr4CzUkNZ/ykv6hAvmc146yanin1QbEvb44vhCtQQWdIzp?=
 =?us-ascii?Q?WcPjTvMKRr4rYtfPcVCADSZTzU8xnjSpZuQug1wOG/XPUCHejM7hv6rQOobU?=
 =?us-ascii?Q?KPr/s7gxl9pPxE8PKK554jl3FQzsMFOyRudz2vmxBr9k2Pwb2J3QOwb6XyRi?=
 =?us-ascii?Q?Y+aoYTGP9ivUGAH4V1pRJ0TN936NcoZo3zXqgH8y+ypy8bzbM3ZkbeVYDSuI?=
 =?us-ascii?Q?XfMijaPY82XW51XMru5EARPtfbFIsNWq9Va+OBpF19yrMIWw0JofM/jA5Ybn?=
 =?us-ascii?Q?6n4YCnXBguCFzQdEiyGSGhKJiqpTl0x3XCiKVGNgCIyuyGB+NdRstjUeto+b?=
 =?us-ascii?Q?9V/ScKlIJPFLiv+PYjgwaRaT3E4McxSBxhqKfqyzyEYbqnY2K+FbuImFTBY2?=
 =?us-ascii?Q?jkpfzSAmRer1JqLfsxSK6NugHvLAINegjh5RX+a+3aTqOvJ9vb2eJ5cYWlx3?=
 =?us-ascii?Q?6OgMtbQp5MDJRhT1Fie+Y2TLo7JzbTSWoNdkl1fStgchxZpM3o7Kfdt9/+/+?=
 =?us-ascii?Q?7brOscjQnd/E5vmxqrxGVrsreU5QX80CPBUenZomNOig877Ez3TLO+w9FLVk?=
 =?us-ascii?Q?0LYN2z+aWyBuqujFl/L5Waa3L3ogk+OwDUSsIL/s3LqRYEtFR0zL4D+QlDaB?=
 =?us-ascii?Q?sqE2SOefs9SqCwbkXrZu7E3HcNAgCssia6SDO2Ja+ZhQDA0lP06Juugr+ApA?=
 =?us-ascii?Q?dMb5dWrkw0nC5pudb43cF+Z2JpPcR4+U77nOKPsAXW+gO8o+LURfInmLJwnG?=
 =?us-ascii?Q?8WcEaeqN9YHEo3dlMNODCGrZc8NmvI+IORKXH+x204K5av5Ns5PQlroXV+wW?=
 =?us-ascii?Q?iIrZXsronoihyWHP3ij14ocRK/h6f+pBAe/xMwCB26TJG4PrrfnY6qhU16CI?=
 =?us-ascii?Q?i/wzvi2WG+eAADI2hTrNvahx95IdvBiggU7AFrYXnVJMd4WtjBajFhCoLpK+?=
 =?us-ascii?Q?UppLRDVYcbT3c3CTS2wvgYmGVBCizKknjeKkPsEbVwQFVqp5a+qJcpaZFm6j?=
 =?us-ascii?Q?U/v80hCb2F6h9gLvWY4Yv8WDBgUjauvZO7l+rWDjk4n1wWuYpqHEIATQbpyF?=
 =?us-ascii?Q?SRyagR8wgVs9YicWA7HZRfsdFULO/mM=3D?=
X-Exchange-RoutingPolicyChecked:
	mkvRdZ/DBmsltmXJrQasNPcVFw9RpuUp94G0QNOG/eNfpNmU1DJjn8boik57ffK13M5zAr/iEr8XYTm11uqLwTNmN9Zu0CW7staS/g90HKUIbNss0TumfhhgI5KCrZMq6DDRpjiPuj4ZX9RX8WoWWz9ChHSDD39kE/L9eBEHg8KOEVGqeva+zigW8qwbNIBv7vQeyRg2aRwkw4J46FmmoLFcC0hJuvIey6lx5lU2K/xqjeUAEieCPdE7ckCRzDlZv19dfDKO/M5cBaakfiKdNwx+nxTG6dd7uxGPw1I0i5EjNl0ZsXQQX/P24+fAxJIpDFzDJV9MvQ2u3AGCuCO3tQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jgWd9KhMfVgAcFX+FuVyROiZVUrNmGoMeAygcLDLUlabFkSsYXFea0yAT51/VY0pg7MUTq7ylqqi8Kii1L5mit7CySuBAJ1B7Ydvsn1FE+YGhsDZ+Cwa6uECmoD5dabOacxoVlklD3+L5kWZBa2A841BzDb7cl70iQvebfTUOtPXgf7pq3NoTSnB2gQrhVF01lZSqKweo4G64kGPYWio/26UgUDg+7+Y/lEb0FhWBOF3aIiGHM03n5wtBurcVS2PHZXFoC5v80CQNXrxonoid8hl7RY0SxMKQVP+pVTzjiCRwFFbcgkQDYVKZUqyMM/EBhRQbihUkR03m7emuOlhxbGAd9mTxcHA+ryx2d+NOI/bylDbvQPAv+mMIWqspbUXeKs7och9DMu5M3jqDcyP4XjT9nEAZ4hgQKBhnsosDe/N5UWYcXYlk1JTTNqlMY6pLs5RwhwPVfKDv23ZTwZYwamGsQhKEcurVD11lu5Yq55Gs0tBK3IuWag7qOY6VzeVg/QknjjM77uT9gN6L+51ikpZMAt/HeV25SD0UZYvzwEedm9eEkJjHG5/yqMliM3q2D0hB21uZeQY+exBwCvGsBrzRFHHdj2GpUsaK7kGC25oTJHMN7TROvhAqu+hkZJU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ed196b-e710-4a50-c1c6-08df33fdeeb6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 07:43:03.6598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9PsEcYsEZm0e62Cy0aRV+GZaSZUDdsuMBRJBZJ59l/BW0vAQHkeHZ46pKotmHy9cCZfhrwMZ463OSj703+rH8qlY6f5CEp5rRUz/UPDa2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR04MB993677

On Oct 15, 2026 / 12:29, Tal Zussman wrote:
> Four regression tests for block device fixes under review [1],
> following block/048 for the first patch of that series.
> 
> block/050 races partial O_DIRECT writes, which finish through the
> direct I/O write fallback, against BLKBSZSET. block/051 does the same
> with splice(). Both need CONFIG_DEBUG_VM to report the folio order
> mismatch, and skip on kernels without a 64K block size or with 64K
> pages.
> 
> block/052 issues trimmed O_DIRECT writes from a hugetlb mapping to a
> device with a 64K logical block size and checks that no huge pages
> leak, covering both the dropped and the shrunk bvec.
> 
> block/053 issues a RWF_ATOMIC write from a buffer whose last page
> cannot be pinned to a scsi_debug device with atomic_wr=1 and checks
> that the device holds all of the new data or none of it.
> 
> [1] https://lore.kernel.org/linux-block/20261009-blkdev-fixes-v6-0-307939c387df@columbia.edu/

Tal, thanks for the patches. I applied the first three patches. I left the
last patch to wait for your response to John's comments.

Of note is that block/050 and block/052 fail or hang with the current
block/for-next branch or Linus master branch. Another kernel side fix [*]
is required to make them pass.

[*] https://lore.kernel.org/all/20261022062513.77372-1-mzx199711@gmail.com/
