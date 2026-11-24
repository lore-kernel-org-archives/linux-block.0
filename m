Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795527389;
	b=fC0xApZJWAirwN9YBOzl97JaxlkORlfNgu0TUL8p7vCIMJlKQp5ZJlk6rEh7YwTfRN4u
	 va7tQg1hLy88ysKhlrauX5PhCC1f2mBGJRkUVrh62w9EKV9HGmCww1nD86IaO1mypzRIW
	 1y/M9BwB2vjkuvXLoPtKWtuyFpz7p2G9+D/2AYb/3LNmCxJrnbbLP3r/EE7Hrra4Jqnd3
	 dRm+ZuQmyFSnNHjP7AwDYPbx0g9aD3EYmdT601N21kNQweBwvhP5MxC8CAT/hVi/cXH19
	 wcCW8+M9ji5B3BVVrmVulVdDFcoy5vyizovQjyTP3FTxqm9QfVbYr0+7UDLAfaTYe4Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527389;
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
	bh=klT/+OkH+r/wbiP3rE1rDA1ToaApad/VpQGCIVqqU8Q=;
	b=slFy3PJ74jxNfDY2XGsghbfpguWpJqzsZ5EwulSdB8ZKwGznbw38vMOoeB3H4u/zQp2a
	 jfRHDNajJrvF7n0RbhOHQVcWi2n/Vfc8kXc8ImbVnqmvPbbLnmPqjhofcO4Ji8i9OVOLx
	 4hlL9kg1WvW/qIyJH4nL1V0oWXb7SELc6+NGYOJEEZPPC21VbXNBNFfbCkUT7yllJUfS8
	 EB6Ipq/C/83/345Dnx+xZGAYcVjO1ioqGX1fuyqwBC+IAcsMNRGPg0YNPyJHiygNrxvVF
	 bAiKxp2os7OuQrUK16L/6uch0tIaY+dFGKMCQl+uO8wRzIA+BNNSvv8kS8HLxywr1Jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=KOfqPjRn;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=rB0zHltO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D98606A321
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 13:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98D98606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=KOfqPjRn;
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=rB0zHltO
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795527387; x=1827063387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=4PpYE0j8QAODlazifRkEvIFlpsJXZxObLLR+Sf3tIps=;
  b=KOfqPjRnDZd9ufxXsAZbhykV0lyaNVT11sbN6T4RsEbg6w2/NVV4wfNi
   7HdblKUyU9TTqCeg1cCS2hF7puLxnwIHvu5DXPNRp/mkNHNsradEZmICk
   eT2EzvMvZS9cOptqCWCklseXrtDhLtdT507pfPwsInsH+6ZPD6aIJz1tV
   zp86qXjBE6xOGfSxwj7vqwFyO2+X6iNPiOHaE7PMlSSdx7xooWuGeqfGP
   5hAO0URdd09+U7C0TrHcTPwINIFFDqkatJwxf/LWIEEb0642mkAYdbY0l
   wsuW4Xz8N4p3UuYJCRUr42eux0js86tSYxGPbSA3zIbJIfwauIPpjiw4n
   w==;
X-CSE-ConnectionGUID: NeTy7bOFSSeBZil3dwzjeQ==
X-CSE-MsgGUID: UgMbsW87TdmnCG2EhSi3aw==
X-IronPort-AV: E=Sophos;i="6.27,230,1786982400"; 
   d="scan'208";a="161579915"
Received: from mail-northcentralusazon11013027.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.27])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Nov 2026 21:36:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOE+ZN2yWIhrzQF+/+MPPX1py/GA73kXX6lhap47V4lAWLlxX7XW6n+ZtOQTcaGG7d6YZSlD8hhZ6PWqVA4nBWjNXEzroJnOwnGcqLHbDQ4pODCn+VL3M+lXIQmGODi2t1JULLsVvBb0JYoQnR/B2+CwmaxCH2dChpbv/p6AQPVfyJz5nsYZjKUUQYgOxzspXN7W/Dfx6tB0gEscww4NBRrYcSpGJYjNOYKR8L2ZLm+CmxVXWye/XNH5f3GcOZ4BZYD2A52IFJb1nSYXmQiEJOn9HXNymaTJeBOMfGGMIuSeW6/1EKF6RUUgQ2ak3+dQZripxrfAbYtyc+PvGRJEwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klT/+OkH+r/wbiP3rE1rDA1ToaApad/VpQGCIVqqU8Q=;
 b=tF9+3Ug/spnUtrRqe4FkuyDEgmo7KcKiED11oBWQP/x/cUgM8fjgEQa3bsQWX0PfEeu7ebYQjWQ3vTamhqoZdMtrQwBkrVvpMj+D53/YIklEmgfkUuqVkiBLZ1NjaVtdKdd/wK5Xn41J979Q7ayKjNQ6XEnmfMP4zt7ewrQymxZKHfsYsLH5faoefAKBUagLSwlBap6cIttCXKCIozh8VjEet0roLUhX49t+fVelHcv1T+mJeUgOceD0QOCoi5sjYRg0+oDV6QqqwClHL6n4zFKe0Zzz0qFg7Zks4iS96ZcF9GRM5R9Vy4+swYfbGqPVnHw+lKPSlJ2Ba0AlelPwRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klT/+OkH+r/wbiP3rE1rDA1ToaApad/VpQGCIVqqU8Q=;
 b=rB0zHltO+eUBqIJt9hCuMxxccNb4jQP3xeUx3ZLu76u6CPmFJmM+uobQjYnj1bBA9ExDGqeDLKMFoC7BipGl1pmIK+AAvONndH2CnhjzJzUDZlo9jVQNmFZ+44EB7gkivksTBgz0S64SbO+JzzFKqwgrcq8aZxUL0YIH3uxYxcY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by PH0PR04MB7527.namprd04.prod.outlook.com (2603:10b6:510:4c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 13:36:24 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 13:36:24 +0000
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
Subject: [PATCH 5/5] block: add ioprio to the bio based tracepoints
Date: Tue, 24 Nov 2026 14:35:53 +0100
Message-ID: <20261124133553.152463-6-johannes.thumshirn@wdc.com>
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
X-MS-Office365-Filtering-Correlation-Id: 35c2b796-8114-4ef5-4080-08df4a2fef26
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|23010399003|1800799024|19092799006|10067099003|11063799006|56012099006|261022075727099003|261022105027099003|261022115727099003|261022113327099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261021121427099003|261026135527099003|261026121527099003|261026140227099003|261026130827099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LI8W9JJ04XFJqz6PqAOBqfk69dxyn4B8q4MLA6MPH0Dsx1crKGZIOXtkb+huVlg8j2JJby/Xukv5oSfl9cGu+U4z9TIYCpHK5CUVHTnUsJ8fryGR5MQqq5yJQfRB9uElXcXYVBrJzil5F0rcNhyIDOtV+WE4RB8RuaKYxn1cNFBQQsFjsEOFeXCsJhJcfU7pogwNNWGW1GG0YJQDhfhcStZr9kU7Hvq6V0VIV16oEHX+DI0Wne2+DRFu54h0oYjnmf4jGgGJ/oUtQtvOJ4fSXsmkwmrNL5fQv0sR4EjnNo/pnZS6NIx2HmIcqhpVAoBw5PHaT1a/chKQPkYmQVxkEBBgQIq36DBN0idih4ellZen+jKaqC+SsE/XO1VuGVxuEA0Q7K3ZiWVZoJo+mc9iYWUQkiBxjFAYeUXwaNKn19wYb/jkH2/1DL9zVWVOH6JxSuxr3N4dj7caQOg7HMgArUodS9nw85QobT6h1m+VXCkH0Q6Zyo+3dOyLbfS++iHGAJrw5VtJPUCw2YiOZBHg7Rjq2xKj8cQ7Z6EmVlzG/ciGM49pqeT8vipScIaXBkrBB84VS9Crf80I9/KwSl618iCrPucNIxuQSvsl0Z7zEZD60eDv1sUL7gQka9vST6MPKeYk6Hg+WfMgHUaSqHBH6m3TG8maVFJZNh0mHTexqsc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(23010399003)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261022115727099003)(261022113327099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261021121427099003)(261026135527099003)(261026121527099003)(261026140227099003)(261026130827099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OiUv29GmKfmgDXel1uhEbpGO8YNEOhJ9/1VHV7JrOoKqlOur2cDxeK+A4SKy?=
 =?us-ascii?Q?nPwCXy++YC/OdWbu6F1BTNMsr6JKRrJjYkBdQmKAcGpUQGQYzbhS8IHwbz2m?=
 =?us-ascii?Q?ijo9DVAj+UsU4nFx1b1QRld2zu+DFw46vVwy3fHam3YjRxI799tzjfnEjKFC?=
 =?us-ascii?Q?IqcCFggXoMm0xJtAlYlv5qejxKpL34MUTHIK6BAfV3tCEZK1cJ0Mk9HDuJle?=
 =?us-ascii?Q?m1gHBfvLsvRs0c9hcp7Tyw+NkHBTy1iiHJ3XFeU6PHwjWzyxDQCHTyIsh5/6?=
 =?us-ascii?Q?ayEVEam8sBveAZjbRakkKpHqGs+IRc5qZc0VbKc4mnQyRPLy0ZHKQmSYNJYP?=
 =?us-ascii?Q?9XuQbmbLn8vSDSIW9sz19yobZTs3XVlBJYQgsWwmx9S1A9G6QI3u2LrCBGhA?=
 =?us-ascii?Q?nbDDFkLha+2B9NYAELRntUCDvzETww7U7G/TqZmYNi6HNfFTdOm4NRUTC3YR?=
 =?us-ascii?Q?naC9K98MkM32sSAxDhuCeMzmemnBnuAhk7/1/33uyKNUu57jJp4h5W2/i56G?=
 =?us-ascii?Q?8BQoxZ2h3OMpHn4xzuM0fWv5vV2ElSvVeTn/aVrxSPz7ECsHwSm29XXOmU1l?=
 =?us-ascii?Q?TEtyRFLkPc9w/5B0iI2d8bNFuGddtaPNVW7kiz+jL7UVJRCUHoQLalzDT9PS?=
 =?us-ascii?Q?ekSwICEMmjz6YDluiToWJwQpH74cl8BGPQTKTTokaWU5QuzHwIYrGVD0bkGx?=
 =?us-ascii?Q?iVnfwHXZQckt7gcS2MpUmoKEm9kDOevdFHDSdWLSvN4uSDIB80zB/rXPCU73?=
 =?us-ascii?Q?l78vvwMnmL2HmiW2b2f4jYQYvav7GGnNPu0/wCRioFlmOdeAwce2kcHniuka?=
 =?us-ascii?Q?8V+eN2MEqxsQi6N1y5EVxRoDpATFyXeyTOBTSIzXFkYy01BMh41d87bpn/ew?=
 =?us-ascii?Q?MnZmqkUzf5MNBqaFXZijrR5pd6XPyDYvFA3Lby3VqY1/QZ1tGQ//rLG2CxEp?=
 =?us-ascii?Q?xyvCwpBIUm+EC8vj1xHP1t6tRhuNObTdx5Krm6HhCt+R+z3s46iOAsv7DC9o?=
 =?us-ascii?Q?Ke2V9cStbj/yaht+w56WPEsiw1SuZ3TN7XVprFPMMuy8gIzMxsodIW54QPol?=
 =?us-ascii?Q?rf4LgfYi9w9kX3gmyl38SH1XF6o/I+nuqWbER9nnYCA1E9+9Z85m5zV+VcC1?=
 =?us-ascii?Q?KjmLJenRXRU4ldBc2MJKSFn+jidbZN+sWC8bf7d4hR3YPlLkRD5RBQHDp66j?=
 =?us-ascii?Q?8LyvBKaAAaiFhiChKdd1oln+kRvCObAbTev/O1P8B7S9RSrf01vVwqjxyeGT?=
 =?us-ascii?Q?r7vIjNP/NNUks63oHFMLoRdXpjWx7UF4NJ5XT/O7njEkpXcjY0OBRD4OD6pb?=
 =?us-ascii?Q?+RM324kKisSp7yi9YZojchnDz8t3LF56VY5WLGF0sAEPx8ieLF6sGD1nEKJM?=
 =?us-ascii?Q?wIDBAIcd3mdJpYKS3Z5pR+3P19T3dRM2zaih69CtuxnrMllEJufEyLU57JJd?=
 =?us-ascii?Q?DSjdeLdj/awMCIwgFvtbm4WigwwdigOSNP/IKyUQePdRxynM2wG0o19fGbFq?=
 =?us-ascii?Q?TxMleUTejWuXW3pTw6OXj9mYWk/MqbA+Ss2nqqX3VaWRAiRJR6kF+MEvYZGz?=
 =?us-ascii?Q?xWzC2jh8PloYqgeqthTG4K3MrHtKSySxVlBa2yH6WezXqhgRHOARTXxFKfuD?=
 =?us-ascii?Q?2j+NXnwijKJEaNhqsp6FCJq4gZPyXSLehOoV4cx14rrKzCJUf1UpdiTs93K8?=
 =?us-ascii?Q?Kmo6FuFfIGnK2ErnMBM3v6z9v2D1xttMm0/CQrvAOocb+TXAv1eXOY9ZVlxm?=
 =?us-ascii?Q?5YfiNJqDaE2/zE1Wo8czGcyeDvAG6S7oTBoNtdYW7kn4jpc8lWXpdTJTUjm7?=
X-MS-Exchange-AntiSpam-MessageData-1: mSG3AgryeMfOOdN/r7lglK0Toq52mm8ps+s=
X-Exchange-RoutingPolicyChecked:
	Xmr3C8rLFeyUjiKHf3d7CLnBNoXQSC6XiMJ/qcH07HTcRTAdU1siImLWtx5eLHCSeGbXTuBjFnubeUh6Zoapmjg6CP+kiXlxp5GOu02HVJ38sGwzasYcOlcMZSqHuctWH0Slbl7aemlQqYm2vAEdOF4+XpYyniqHScRF/Xq9f3GaRPKZUBuNFRYhlAgPSs3M5L1AX2UlUuQk71XyxjOP5vSPscZdBudx2koif0zUWAPCd6mGdbQrzsx2Ymh5PtQVFd6RKsW9tFWpK6OAMNYUdTPsaUIxZ657EnZIVYTBKHpDbir+9fPLLZXThrzYF3XGl1kBmz4Q30Fh04XJ5+1IFw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WaAiXQveCqgVGzKf6HUy7aPMaOHvc2Jbg5e6Hjckt+RPL9jxwRwgzvWjwd0U4I9pBReSlTLAJc6zFsrSQi6iWf/71fAY0YY9V5N0+qn7xhkn4smZ5ADKkUg9RktyfzLuzDBcXSlNi54yrwzVaFzKG9/iLEAK58R4yW7pQsC+lGeHqaI1Eq/O80jgcXxnFzKvWMhXzBupaZ3avjvIG9BlRH2xqJhaRFt6/5gSHJPj45poWzt01Vlnpi0/jVqD1oemPAQaeBSrSgPaxXCxX6WzCIWXjxiFbIMbUscXop6BauHEIQ7IcQ047YNlMfiO8VkRVVkgLaSyZgXq/mVmbWtLVnbEzLyyN+qLtiSaAP/dO7X6RvzARjsCwRQrjGsoDcgq32NjKhdHPGYp0oKEADcIN/K/ufDo3OeF3/JxkcX/8rSkoJSG7grW3rP4iMKXJpOIGld4NfMUcNDS//cyFvTNrNUDFbDTP4nZlpY+CMfhf+XHxkToPiZvyXegvSuboY6uJ9cv6ljpKwKc9NsTkSLsYqmdRxqmtQgR+UWDTfoR5+a897zmpbKZWH2hEXeYWdToBFKoysCRFiP9NzODfHGA64PP07NSmujJPjIdPsjNphzChgSVttCoa//0NEVEKlky
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c2b796-8114-4ef5-4080-08df4a2fef26
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 13:36:24.7025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7ywpV890rnsbRdPAC8EkulWTMqao5pDN+Qe9lPSBUEwrGKkdAULpNo/llQhh+7xxlLC7G1NFyg/HM2GA1ifZoEGNFzxx6y3Kmqfe4aj4iU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7527

The request based block tracepoints already report the I/O priority
since commit aa6ff4eb7c10 ("block: Add ioprio to block_rq tracepoint").
Add it to block_bio_complete, the block_bio class (block_bio_backmerge,
block_bio_frontmerge, block_bio_queue and block_getrq), block_split,
block_bio_remap and block_rq_remap as well, so the I/O priority and with
it the CDL hint of an I/O can be followed through the whole block layer.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/trace/events/block.h | 50 +++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 9c97a16850b9..5828ed5df872 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -373,6 +373,7 @@ TRACE_EVENT(block_bio_complete,
 		__field( dev_t,		dev		)
 		__field( sector_t,	sector		)
 		__field( unsigned,	nr_sector	)
+		__field( unsigned short, ioprio			)
 		__field( int,		error		)
 		__array( char,		rwbs,	RWBS_LEN)
 	),
@@ -381,14 +382,20 @@ TRACE_EVENT(block_bio_complete,
 		__entry->dev		= bio_dev(bio);
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
+		__entry->ioprio		= bio->bi_ioprio;
 		__entry->error		= blk_status_to_errno(bio->bi_status);
 		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 	),
 
-	TP_printk("%d,%d %s %llu + %u [%d]",
+	TP_printk("%d,%d %s %llu + %u %s,%u,%u [%d]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
 		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->error)
+		  __entry->nr_sector,
+		  __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
+				   IOPRIO_CLASS_STRINGS),
+		  IOPRIO_PRIO_HINT(__entry->ioprio),
+		  IOPRIO_PRIO_LEVEL(__entry->ioprio),
+		  __entry->error)
 );
 
 DECLARE_EVENT_CLASS(block_bio,
@@ -401,6 +408,7 @@ DECLARE_EVENT_CLASS(block_bio,
 		__field( dev_t,		dev			)
 		__field( sector_t,	sector			)
 		__field( unsigned int,	nr_sector		)
+		__field( unsigned short, ioprio			)
 		__array( char,		rwbs,	RWBS_LEN	)
 		__array( char,		comm,	TASK_COMM_LEN	)
 	),
@@ -409,14 +417,20 @@ DECLARE_EVENT_CLASS(block_bio,
 		__entry->dev		= bio_dev(bio);
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->nr_sector	= bio_sectors(bio);
+		__entry->ioprio		= bio->bi_ioprio;
 		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
-	TP_printk("%d,%d %s %llu + %u [%s]",
+	TP_printk("%d,%d %s %llu + %u %s,%u,%u [%s]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
 		  (unsigned long long)__entry->sector,
-		  __entry->nr_sector, __entry->comm)
+		  __entry->nr_sector,
+		  __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
+				   IOPRIO_CLASS_STRINGS),
+		  IOPRIO_PRIO_HINT(__entry->ioprio),
+		  IOPRIO_PRIO_LEVEL(__entry->ioprio),
+		  __entry->comm)
 );
 
 /**
@@ -554,6 +568,7 @@ TRACE_EVENT(block_split,
 		__field( dev_t,		dev				)
 		__field( sector_t,	sector				)
 		__field( sector_t,	new_sector			)
+		__field( unsigned short, ioprio				)
 		__array( char,		rwbs,		RWBS_LEN	)
 		__array( char,		comm,		TASK_COMM_LEN	)
 	),
@@ -562,14 +577,19 @@ TRACE_EVENT(block_split,
 		__entry->dev		= bio_dev(bio);
 		__entry->sector		= bio->bi_iter.bi_sector;
 		__entry->new_sector	= new_sector;
+		__entry->ioprio		= bio->bi_ioprio;
 		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
 	),
 
-	TP_printk("%d,%d %s %llu / %llu [%s]",
+	TP_printk("%d,%d %s %llu / %llu %s,%u,%u [%s]",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
 		  (unsigned long long)__entry->sector,
 		  (unsigned long long)__entry->new_sector,
+		  __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
+				   IOPRIO_CLASS_STRINGS),
+		  IOPRIO_PRIO_HINT(__entry->ioprio),
+		  IOPRIO_PRIO_LEVEL(__entry->ioprio),
 		  __entry->comm)
 );
 
@@ -594,6 +614,7 @@ TRACE_EVENT(block_bio_remap,
 		__field( unsigned int,	nr_sector	)
 		__field( dev_t,		old_dev		)
 		__field( sector_t,	old_sector	)
+		__field( unsigned short, ioprio		)
 		__array( char,		rwbs,	RWBS_LEN)
 	),
 
@@ -603,15 +624,20 @@ TRACE_EVENT(block_bio_remap,
 		__entry->nr_sector	= bio_sectors(bio);
 		__entry->old_dev	= dev;
 		__entry->old_sector	= from;
+		__entry->ioprio		= bio->bi_ioprio;
 		blk_fill_rwbs(__entry->rwbs, bio->bi_opf);
 	),
 
-	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu",
+	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu %s,%u,%u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
 		  (unsigned long long)__entry->sector,
 		  __entry->nr_sector,
 		  MAJOR(__entry->old_dev), MINOR(__entry->old_dev),
-		  (unsigned long long)__entry->old_sector)
+		  (unsigned long long)__entry->old_sector,
+		  __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
+				   IOPRIO_CLASS_STRINGS),
+		  IOPRIO_PRIO_HINT(__entry->ioprio),
+		  IOPRIO_PRIO_LEVEL(__entry->ioprio))
 );
 
 /**
@@ -637,6 +663,7 @@ TRACE_EVENT(block_rq_remap,
 		__field( dev_t,		old_dev		)
 		__field( sector_t,	old_sector	)
 		__field( unsigned int,	nr_bios		)
+		__field( unsigned short, ioprio		)
 		__array( char,		rwbs,	RWBS_LEN)
 	),
 
@@ -647,15 +674,20 @@ TRACE_EVENT(block_rq_remap,
 		__entry->old_dev	= dev;
 		__entry->old_sector	= from;
 		__entry->nr_bios	= blk_rq_count_bios(rq);
+		__entry->ioprio		= req_get_ioprio(rq);
 		blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
 	),
 
-	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu %u",
+	TP_printk("%d,%d %s %llu + %u <- (%d,%d) %llu %u %s,%u,%u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev), __entry->rwbs,
 		  (unsigned long long)__entry->sector,
 		  __entry->nr_sector,
 		  MAJOR(__entry->old_dev), MINOR(__entry->old_dev),
-		  (unsigned long long)__entry->old_sector, __entry->nr_bios)
+		  (unsigned long long)__entry->old_sector, __entry->nr_bios,
+		  __print_symbolic(IOPRIO_PRIO_CLASS(__entry->ioprio),
+				   IOPRIO_CLASS_STRINGS),
+		  IOPRIO_PRIO_HINT(__entry->ioprio),
+		  IOPRIO_PRIO_LEVEL(__entry->ioprio))
 );
 
 /**
-- 
2.56.1

