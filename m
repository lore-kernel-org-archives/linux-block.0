Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795758150;
	b=xGb/qjZZTz/roc9XOqin1kzAE5HsO+mINtwkOObPq3HUH0JpXjtqnVEuHBA4nNqtwtCM
	 PixzskQlFuC/ybX6MF9WWVbV+u9QVh4hgCJY/+t85duoKISISjSkmfsizhkRalhLv2UV/
	 5Ow12RKoSfEA5Kdk7CbcXCD/L6EokiLqcf9b0B83C75WqPwV/PLiJtNZbwau4dUkSsCqu
	 f//77kpwzJskZDgvRJlyredb98pLuJqhHhSLZIgT0BCzUVbJHMpndJedlul7jMrMeB/S6
	 G44lThbki6wFmNLp0RwRoIsRFmR4PzJqbUd196ttQJUEhDsJYD7gHsXmUuesvG7ERQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795758150;
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
	bh=rzsq7JTeMIgepdkVoIIobEuVu84EPUObLtLeUHqVfeo=;
	b=NIdNs2Ramp2RhjJA7aej1AEaUjboULmYEmZWixau5uTeUU100Yvmpc75Bahl4j5Cmpnh
	 6t3mvmOc+X4wJ+swjKEqeLmOzlMCQrKFzn+TaGWQ27yNauWHoL+gdU8N82fgwNM6TlxGZ
	 WZzDK6iWvD5J+61pPD1yuxtxAoCYs0Ydqs4w//XNbQUDfruF123TvTZUXTniJ7AKy5Tya
	 9eqEfggEllAOQpPDTwuYmCMi00cw36tL15qezvhGeSVTKjq/5nlPzdDNpySlATG7DTiSr
	 V7O63siF4kD39nN2GAXC71OnjvOzYIdPEIhIQCalqyrWSnWMkhWs36cOJG5n0s69pQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=iSrp4wQj;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=dB3iLnt6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=68.232.141.245
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FCB606A31C
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 05:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09FCB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=iSrp4wQj;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=dB3iLnt6
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795758158; x=1827294158;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gMPpxoMeqNNwaP7waacczBaSQadlYR+mBFKZpmtYBj4=;
  b=iSrp4wQjhM7oVMU2zoCaHZym94BZGJfrGWGDv3sUjXAJLrNo0ol3c+Tp
   FzDA8Rr+mjS/6UE4o5nke2+js4jGvFdRjFL3U6I50UXtawvnWryaChPSt
   Xv6pu+fqgV+2XNw1K5O1/Qr5T2Fv7CEf+ab1WoNBpGhAwwSCitiVzSIl9
   zyp/YiKSzkZOR8VNPsmvN8LwV5n3YWMNE0NiO/0Xshcz5pLNYOD4LO9JD
   UG5iBZOjQV01aM5FO22OYIK+/NzREesFA98QjiR/hToYs8MXIux7rnPWa
   aerZy1qElHm0ELlCr+RwFt8DMjgTXZxS1U9gkofwYXNk0vuszytNFXjwe
   w==;
X-CSE-ConnectionGUID: oo1cgeauQFKac80qgsn6JA==
X-CSE-MsgGUID: GBoxwlLyR4KfPn8ASZDjAg==
X-IronPort-AV: E=Sophos;i="6.27,236,1786982400"; 
   d="scan'208";a="161811513"
Received: from mail-southcentralusazon11013021.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.21])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2026 13:42:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ykFgaemNi6eVvgF1LpwFgKwc7J5s3Y8F3gII+YfCibPnufjiXHwJ7sJ4WVGGmz0X85gMQeflowWSMJ2c08Zu6wnoYKEOq4CbgW6amms7h5v1r5cEaXagYslstHV6g4FAPvlkOF22DXKNJPauqx24EzhRYFFG78lzpPvcnSEr7cITNnFUk7eJ+Od9xivcFP6a2huazO0fzyf/N+a0/GotyWVL5VxuDU0JKr+XcSOUlkC6wWnVeMiXsAt7jZUYScV7DQCsnwYJK50YXyGX1z9Y1/8JMlfp/6RKwN0myehvgV7K2Do+vmar8nC4mO8p9JYnjjPkQNNpkdWBJLNVkQtGgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzsq7JTeMIgepdkVoIIobEuVu84EPUObLtLeUHqVfeo=;
 b=f1IUCabkM1C6yQmki8L0ayMwQXcGAyFDyyJ31P/SzTtNkZus1oQIWDGAmYteyKVfol5sKdz+WvPUILA6b59BapNBXBrTK9prJ57YHSJeQEs3Q0DFRS8Twi0dQ3zSZ6y6zpH8XP+Aamp22H2Kp+IZDSh9upvuB/r/CKcWdrHiGdeTZXuskU5zAv5yLiHwWhJVuVeKKNweQGNvd5rodx1O+NEZkhQNTEG+7AKW7kaOLKAexoewQl9FCndZpXyn6pBbI4jBoi4muwswEKSorcxdtuolds3by8AJ54wtUviGwnZhi+508obgLT2FHiNXs5r+zs/GDHG4b8qayw/HZZA+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzsq7JTeMIgepdkVoIIobEuVu84EPUObLtLeUHqVfeo=;
 b=dB3iLnt6GLkPTD8XiOMXV5WvlsBSLklqHrExiTVqa4mJ2ZB+1tJMDB072LPbGAVQUAcKnbVLz8qqoFkLSF9ElicU6DnnDHzvD7biMbhzOywHOjxTHoZVWAESDqEwRFR0YqVBisXADihV1pSgU7JrD+NjZ29nn6BNnfP2aktSMHY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DS0PR04MB8620.namprd04.prod.outlook.com
 (2603:10b6:8:124::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 05:42:26 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 05:42:26 +0000
Date: Fri, 27 Nov 2026 14:42:21 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 0/5] skip tests when a program they need is missing
Message-ID: <awkYJgHKSH3_tFBD@shinmob>
References: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-skip-missing-deps-v1-0-a9b4a5a7cc94@suse.de>
X-ClientProxiedBy: TYCPR01CA0169.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::12) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DS0PR04MB8620:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c49332-30a3-41a7-f313-08df4c4937ae
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|366016|1800799024|376014|11063799006|6133799003|261009223027099003|18002099003|22082099003|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	iTwE1W7QtKerRJ3tDBC942MW9eqUz5Z5/pQfB7XNBQzgAnWNQRI5dq0YhIntrZdN8ou4QsKtw+1PhCAUK4UNBVUmH3Ie0tH7g09r7L0wzIOx2sqUsU5khWf8wml1T63pSKCN41BXHVU8UPEKZhUJh/oWGU56H6AdVVG53zHJdkCeK+MEfRaiR6+aApa+/wfLk1RMQAnSChW5VxXLsaatlhCQUGmMG0psSPYTyNLnXg6QK1gmqpCwaYYRrUar7HuXCOKQY3j78GkXDUqBoFM5shZsZECEqFUDy9elGmX58NOc9Enimm6j2hWfmTq0ai5PJR/6f7xt9EiPB+w5wlyaLa+Rbtr82JPq/43c7z8pjylGCB9LcOjKYjiW46OH2gT3aBWyIxAhkyRF1L2oZiNDIoiKJQG4/qvjmIsLcLYq8aQ3WvjFp1zWP984ouoAPbwlkKzbmaKCga/nhw0gwsFrQ9MAlr/zmCCctBaF/hhH/rA7xLLPFXbGY9Ytmt2QACF/XfgqOYD5TbDM5jZCSxwVPdnIvnR02VqJi1msbwKISmAM3k2uuAKcAcWvndQ1Tp6Y018hqNq1YF4nKEgK30LA8JjBrA9fYlgPX2YMk+60jdgP+pdaJ5JSPaUXkPC1ikPThcT3FmZzlb2kKbqpmo5YKbeC/Fzu8AYB4YOsdRCZWTs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(366016)(1800799024)(376014)(11063799006)(6133799003)(261009223027099003)(18002099003)(22082099003)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0GI/ImYbXgiOb1hlZN0SdYCEQQ3MF3FSsKzn6RCl0MT+v/SWlQFPlQ5lwxak?=
 =?us-ascii?Q?LxALD3jUbkfVBIgE7YOaXcjAGT8aaArss8BMBB5fjwr3FC0aZi3zwaprB/0d?=
 =?us-ascii?Q?7QJ5kqcvgYheQN2Q542ennPOnyqgSW+nlCG4Vcu4L4i8hcotyqsbEpDMaMS7?=
 =?us-ascii?Q?BJFla9uWKR92HPcZBuMHJ05lQRxXZ1nX8jL6i4B1DNcGSmxr/DFDTtlfJ/NZ?=
 =?us-ascii?Q?KCw5mfhWnKz9ziZQJTuH9+1MHJ0cbNTFfcGJ2jrLkuMm4a4QeTL15FoPJo8Y?=
 =?us-ascii?Q?baoF7PAIHsgxJtCZVSKlQWCif9DQYP59rTnw0ACzWSfjRZxKAvTAokTQLOtI?=
 =?us-ascii?Q?yy63Cd2Ce/z20sigK/exvnol7xMChVQPLFg5jZsnwZJpwRW/SXEdN1+c+2Ls?=
 =?us-ascii?Q?jl3x2Pkn9lv4ucwikQWh+qSFTMSiG8NASRS3ryVSfR0w2Ad93KhT5ux9QM43?=
 =?us-ascii?Q?dLuBKYlUtCT8hKTi0MOpG/3zQf3nQ8kXtymY114zq0Lv8sCQYulOmKUSduXR?=
 =?us-ascii?Q?lRlZvqHby3Pjj2K1sC9n6B2k/i0LAoOb89iYaLtTwgGvZY9qHt6hbWFQNFvi?=
 =?us-ascii?Q?6j4R8SJ3r3z3jyki3NmxorK8bRU9THr2B7Mmngu4IljVgfcR5riqDYbUsbvv?=
 =?us-ascii?Q?VwKAiz7+k6vR/sFrE/A98cm5SYqLDw55yU/7tGKH5+pHbbcOyNglOi1qNWXC?=
 =?us-ascii?Q?OZsPmqPdInoGuns8D6CiF9hBE/lxaBupxr3Ruxy7skpm1RtRIRsybOkrv+jM?=
 =?us-ascii?Q?1H1yHtgWk5Pn8rqGZ83eY/YgcZZVEoQWnEqNT1PFCRFCBoVjE7CHtax8YZtQ?=
 =?us-ascii?Q?hhaUZBOtFS8mJgGHf4RezmzQO/mmv6o5weGZfOQ3+pCSzeNc2Vjzi6uRTeKB?=
 =?us-ascii?Q?fZxwOrjR7VhMJYNPULyIn3deJEKzaj1puyi4Bj+6zHZIJE69/Cz0MkgA6/ZW?=
 =?us-ascii?Q?IK7pUen1+OgNYMHkpbsRL6i4muwf+5lv/M4VX+VoYanVDGSx2NEv613UW/fz?=
 =?us-ascii?Q?wSV8AwcxZ9vXiSvQj162Mm4ydMh46VsR8hUw73MFW+fI+VPGkPIx508VIc7u?=
 =?us-ascii?Q?znIqXCaCQ+A5k2NSdF9uIcADlVvWK7WK4wiI7gPrd75sNo1WM9zDOq5DzBj4?=
 =?us-ascii?Q?aota7YkF7dqUn4sNRLAEZPr9VwMqabM0FPRbADOd4N21r4gYXKQKWMjN9I0f?=
 =?us-ascii?Q?zqAJYUT9A0KOJgLuZZXkoWaSd8W8lrmCap6Xb3hdbfxcqyEyEie5ei/IfvNk?=
 =?us-ascii?Q?V2dk1AHoj1hAz4XUyAyRqTXdWa8n/Q8HuHugRS4eLgTAVGBtxiYGa2osAnyG?=
 =?us-ascii?Q?P7G4Q2E2KXNMzao2sLhztriak8pQRZthFhOkGNEwzdok1hhRt5h//8PfyIyF?=
 =?us-ascii?Q?Z6bjyzyxQovVLKQt3DDlXKVB/yVjIPd+f+fatD/rKAxkPypdDzdwuSPe6JoB?=
 =?us-ascii?Q?pH7L2JbwS5ZSCf+KoSwQq8k6R293Wf+NwdmqpVDnM5Y2AIqZSWQWzO/DdJyT?=
 =?us-ascii?Q?t2j9OhWn34mKAJzrAPlfH/tgKPigAZiXzGNxnN6ewEVgr8GoL6gwUHB0g4hC?=
 =?us-ascii?Q?MVMYYDMzCiw4E4PLnQHLXZusc2ua3P7GWRhtwr9JaORNZ7c4LT1qQt25D4i6?=
 =?us-ascii?Q?lszWBP0B6BmNJw1Hn7khXFoVWsu1CMT2Yew89xCc9AoCpnV8qQ2R5g7QSqOF?=
 =?us-ascii?Q?65nN5K9JHX4Irf0kH742MgptLXRlr9UG5M3YLwHd0kvaO/f3D6LbfIV3HuHx?=
 =?us-ascii?Q?D/oN23nebE09guZKPUZp4YNWLE7uec0=3D?=
X-Exchange-RoutingPolicyChecked:
	EtknZrXvTqF9+kqsO0dKPo3o8xiQaYj7Yy1KpS6xNQ5rtBGyFKpGdNajlZrsz/Y7XDuS0KaEdRhM9PjgCyKAc0cejcLIqzp2xDAo+PDLbBrQcxi+ujud29qbuCHwj8jj9PppTkDRovvL3XwpcWcvRjrACHyL6gGYsH183B5SHtECqhZGFuf+s7/miyyN861glmokF165sbhRc95QE+J449rXrvHjCFWHDUpcy7GSHrgx6RuA/gdKW7oVgLdjJ7cNSm8whx9JG1epHzh4YIXXA9b+cf93xsFgv6MlM4NBoK79TCF7OvWCZcHzE1cKeHzJ1AJYBXuW12JQNmbE60VP1Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6QTqcJhE0jLmU5beN6DxlZUkXmOb7t2qHNZ+OeiDI200MABTuS6qoWma/7NeVNvjTvRdcP2B9pkp4Jjth6ee/FQU0Askebtmfe21wk3UMFGbuSAgZU5yxaFyKEPDLW8mlNIsdxLhP6a9E052tq5d/MnJCciL4f5fCoNfIFURNXHFaja3ezSD4wDBa17rr5ayQuPEcg+30F4sa/m3QdvWAYViLHceIZ8EHuGIWB+jgM2Dq4kWVxcFCfPz1mElOmIwMiTTD00Iqu8Ko1Ud1IjSgwjBlX7vRlvfns3MLAVSGpXHhYW4B9tRP+ASW50vfa0C9Knlcq+6nYZa3yszX3f9lIEOiFbkBYjVI6Gg4MrSDm1ignWKIKLyY2Q3PEYsqbqR9MvG6jO5zGhcfsRsVt3aAa0Bpp3Ofe6W2Tt7DUnA06awlr25dsoDreogCU6zvXJ8ijKkdu0MjM0Ovv0cGSNUcKzeP/T87CS+IYTXqJErYbCbU9H2sN6OOYDHyYaj2cIr64aj1kW8YNjdCAlgcFVCNagVgSaES1Typpx9joQmA8uzP0i+hMBUoOtUbi8Kd6u7maG2R9hEU0X9yYglreAgHTCAwVx+WSSSsQhUuYBqLWxY/Od3LVrEtDxBZdmHPdlH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c49332-30a3-41a7-f313-08df4c4937ae
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 05:42:26.1531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TnPDuryPHGgoBjaALqDESuZIhJ+Q3xki/NGN+tywU54Rc2gF1Q+o98vY50dz7EZbbH+7fKKRb0Tu1jVLSj3o2ZE3yY+a28gnPFD6Rx76I24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8620

On Nov 18, 2026 / 09:42, Daniel Wagner wrote:
> Hi all,
> 
> a few tests run programs they don't check for, so they fail instead of
> being skipped on a host without them. Worse, check leaves the modules
> loaded when a test with a fallback device is skipped, which makes the
> following tests skip too: a missing xfs_io for scsi/009 took out six
> scsi and zbd tests.
> 
> The first patch fixes check, the others add the missing requirements.
> 
> On a Debian 13 VM with a 7.3 kernel and without these tools, all tests
> that fail are kernel bugs except nvme/068. With the tools installed, a
> run of all groups but meta goes from 81 to 120 passing tests. The
> remaining failures are block/052, block/053, nvme/073, nvme/074,
> nvme/076 and zbd/009, which hits a btrfs warning in
> btrfs_schedule_zone_finish_bg().
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Good fixes, I applied them. Thanks!
