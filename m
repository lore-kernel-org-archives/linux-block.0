Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A2A368D45
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448828; cv=fail; b=tJsCrUDci7EBY5kYw9NIeIQIdQTRLZH8NQt8nbuMscSDM6T2Aq9E+XyhOCYwpktLdkn8iebp75WqYYeFfAMopJxGX1nX2RzRZxJAySxrQ73HdrIA/KWXgP83vE2fkPBvjgoIpym/NBtzo1xCYuMJDZPkMvETZWyBTMXEgv374qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448828; c=relaxed/simple;
	bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JOvA3E1FofBjdWzEv7a3qTbwumX9+0fFuaLwBZGGWZPRWrkIWCzGfLkXyjFbfc/H72b8YYx3k+x40eXtqrUGroQRIsOXLV51viSUiuDE3rpdpIEyOiwIBgm3L9dpFKSlS6NDjp8TXUq4BhmTxh96vadexTVewhTQXmghApCZzeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NDgVU0n6; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KOlWGCi0; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NDgVU0n6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KOlWGCi0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1786448827; x=1817984827;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
  b=NDgVU0n6w6MI4aqXUPXGj7MhETbmCqgAmYtlhuD69t/n03A/iUw9mm4+
   0TlM0mMt28lgJJOo00N9H6C2tg1GxS24+WAvliMNr/IxngQly+VieYO2V
   3oNND0bDIlHZCeRI6C1oY9+ncwD35/iwe8Fvp1UivqQrsOno5QWWhI6U7
   HvC0gOldSUpdEvqhwngHj3gr9/Dpyr4ycldjWSqA3MMgvhL6ce21iJzTq
   R3KChe34vyrGahdJK+EnCBZnbZKuthc+BGJccaXZQZcdVoI/zDd8p4rIQ
   dzGUGlrgo2mT7zbTMlIS5slNhavDZBnrNzdSHUTub5s4DbKceh87TTmEi
   A==;
X-CSE-ConnectionGUID: 9w0rIsyLQmemavM7mTuZVQ==
X-CSE-MsgGUID: TUnnQnqUQWeviV5KKSCxww==
X-IronPort-AV: E=Sophos;i="6.25,217,1779120000"; 
   d="scan'208";a="151965825"
Received: from mail-westus3azon11012045.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.45])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2026 19:47:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVaFEw0z7akt0YKN5/dSMt6ce3zHWmXjc69D+z97yh3NbypH1Zzp5mrhLHq5AZiRz7bsj/MsIEqDFKi5Q6zk2Mfuu/nVfaZMABbHOUcDWGDfQyIO5ApbxonUkeHcQaotkz5QsNfcIN6w0Lrjv77mpLG/8lxBIlEMWM2xkURUmedPfr8aalnN/+QulPCq3JAmqpzllrOWHtvSBQQRZU7ncu6EDFR3DwKqnBLijlYbVLcGe6hEgnMGtv8yr+CcJUu2EXitNaGPNr6uxmjUeaQHJjCDLRR9rwVTR5OYeoicMQKGIY7ddKETembTiIrrwFdriDePxgygg5Raa78sdXyt2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
 b=iLlgTO5la/mJ8f92djE4JhsBez+Ed6+5IxH3ueiaMuNmBepQwqzvP6+jCPOVaySPZWC4xgObPSepsiM4H3ubWIwrTlzhrbtBwTubRXxv+LJR0z4c0uAcMg6GEVt2l+FekQFiZfq/yZL0xz1LPlGze0cncp9mj+xKYKW/yQQ9y2AVyUDJc74S+vw/m0u56ehhRsz+Z33SWJDF1rNe4yRaLeUbSyqAG+PVXKmPxVR1A+DTXwKPSKw64bsJ5SnIAKEp3ZsH8tzJDehDwr79QjnfzabNnXUOeCp3T9iGYtqKdUN3NByQpJ1vvZnwejH/Wjm/KudH4m0+rqfcLibMCiOoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
 b=KOlWGCi0BCMFfkB68sn/lzdMQ+bZV61yRcTxUkYSX+wk3zxXzm6+VXdSb/YcWGo5xLsMwJ/5UNbTRqLe8iLbT3Bozl39KWzZICSiEp5YM5Js/azEnvShIM2RnUBmYGQ82k/GEg/QHAHyHL4bz0gyXdy6Hfxbu0OPtq8xtJeptHo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by DM8PR04MB8200.namprd04.prod.outlook.com (2603:10b6:8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Tue, 11 Aug 2026 11:46:59 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 11:46:58 +0000
Date: Tue, 11 Aug 2026 13:46:53 +0200
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 02/13] block: refactor disk_revalidate_zone_resources()
Message-ID: <ansLkyB3HQCMAdvB@mayhem.fritz.box>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811105852.1245357-3-dlemoal@kernel.org>
X-ClientProxiedBy: FR4P281CA0340.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::19) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|DM8PR04MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: a1fba88e-6eaf-4476-613a-08def79e4006
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|19092799006|376014|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	aHfYaBdnl3XQnnB1sA0kcMGtgCc/yIxslPiET25WDUqer+5aOILbEj7CN4qNikCTK4hMi/pu5kEbxprOY2HdNCKH5oPwx/JVCC8uhBLbyEgnFNSIB5E8erUztGnzVObS0jzd68BFCqGELUpQ6nr6WTGB7txUoP0+KA17Acamp/l3jGVqjNnR4GMZf1LHhr5O2G0rweDt2uaJ39Wq4ge75I9E48aU6jzO1nPrzP/LEEnuE0IUxMQx90gRCTRxbw2efrY270zVxrI300DDv6VYerB9RrRu988hNLFb0U0Rs9hB62x2E8ly9pbE8vjekQoLXvrugcckCiIXedpBHO7ftwlIPhIcOzcshwZWLn5h4fu/hHGoTlk7H0HlpM3sB2yd73IwmGQUyVvJEGJYYQiwqPQbdQTIOEmxnNyKJr/k6sh/hE63zl0OFdB+f+qFKME+1ijXSiUP7UWtYmegTvU38sBzgSwEPmyx9l0uXlXIirKJ1X4WzzFbs2xaI0DAJ7bb+WO6J+T2SUCHsA1qKfjYmUaB88K4V0HAkY/Du75Q5FOeQALLRqtyyVwK6ouekmkj77Kawuj7MHCchY3+OfUjkMzC6QDTYhVKBSiiJr9H4jITg7usDDPXxer+QX2YQDTP15VIcprQJvgjNmNWc7gaXyzA0jL8KWZD1I41oXehIGY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kORdFhv6BLfZOWoZgugWeOIK8o35729BBH84/thhDzsMRwL24OWyXjZJr79B?=
 =?us-ascii?Q?Rd1QZAUbPXjcRzYMTMKE02LIxgbwGRGX5AaUVeUtl50QTX2OEVZ2txDRCl/t?=
 =?us-ascii?Q?/4ixnef0Ok5bNcZHjV1rQv9ZY104P1CRSQ2IBJViYA0e7dmjudhaRdWi1qGj?=
 =?us-ascii?Q?RtDYQbieEfLPg3GrIDSU9TyFEQRPNPkNt0qpb8IzYcitFt8v3fTdQtNV4uyO?=
 =?us-ascii?Q?3aPZJxqYBBiPjmrpjKynO1kBKqs3KrjJ7bpDtBaZ1ZYH4/AnQmEQjx7sccKe?=
 =?us-ascii?Q?NW5AKLDeSg/xF/gz2sWTsVivHt67wl5oRJ2yryWmY4Nz5xawwpJgIzIa54fM?=
 =?us-ascii?Q?pIl7CPuHIsxRFA3VaExScx2DH8DT7GFgC7nX+0jklMywEU9P9nOPoKd898SN?=
 =?us-ascii?Q?G4pBYdPwCAtOam7+meoLV+But80aSbKsY2riyCwje5NAMIclphWhPB6q5cVZ?=
 =?us-ascii?Q?cEtt9Bfuda4+YF67418N077fDH2jR7Rsps37CbfM9Q8U/nDdaIA6xM9jYIzu?=
 =?us-ascii?Q?L4XIZSH01L/aIjfQZ8ZSNmiEevQdP5SiyVoiJDcrCvAOVrfthlg92wFDGRR6?=
 =?us-ascii?Q?hSiZLfhMqvPYMBguof9px9LOYtIoRgjO2kFs5AHfMraciJY3M97OBlGku03e?=
 =?us-ascii?Q?U66p0H06ONh6gCq1HRnBmVosy7qkhfjGdtYRQ6veDtcBm+gS0Vv4cl6ddTUh?=
 =?us-ascii?Q?7ge8gB8l4snTFXq9l0Oe+8ay6MFyAUbp2BsWyLHVzV3BxB5qBYGkvKlXST4u?=
 =?us-ascii?Q?v5ieSDzteuBsxcX2fKBzgSN7WuoFLCiubSUxy+8m004O/nar/8WiVq5esn9q?=
 =?us-ascii?Q?WodxWqwzgg87uuq/rg67t7R2/tAEqUpQtudxbaPMZyWugbbP1xZw1zRjj+NC?=
 =?us-ascii?Q?XkchLl+/jixkdfQRHxFrN/RghOgUH7OT8UG1BwmaV26Xh8R6r7OoBBIH1hud?=
 =?us-ascii?Q?cidnk53k1bYWq/uL+7auDl/dnGTtbPLZfZ5s85lSkly3VZ5DMGvwg0QHJAjQ?=
 =?us-ascii?Q?NB0Bo6dX8eFShtymZ1OvM5Kr4DZdaqz3cAh68YopWsAOWmE6jpvbKcgmF9Cs?=
 =?us-ascii?Q?t8nhCKYxAuS3THSLLlOQi6MHMARK2vbWviGUty2W4JstguDeKmnb3nqokicu?=
 =?us-ascii?Q?4eBs2eMs0wRWYaPtd9ojmXchCXVlVSW1pH82B4FPnI44x3hsG7k96CJkfMT6?=
 =?us-ascii?Q?bz5K5KQ0rCHiV9ZgFSlgL+AI1HBY5noYhHJEI1xT2KqB+q+FX7zm95NWE8xH?=
 =?us-ascii?Q?5PFL20q/pbcCWbzDVC0AKItGx3YjIKqW907AGEBfhLAxmVtqm3IQMXpAQCnu?=
 =?us-ascii?Q?M+Gl7yWLPKSkGlPUrP+l+M53s3KJfIcSiUb9v7R4z8357ao7bfupbZe27kRo?=
 =?us-ascii?Q?NmVieAdS/1/Jv96lO3ExJxfVNKiiR2urANhY6eKwElB/YQWnXG1mRztjr0qc?=
 =?us-ascii?Q?wGJBHqRHyU14FRlosCx5W3lNBhuooCuh161MlhABGHX2/PPB96HIS9fQ2xC4?=
 =?us-ascii?Q?ww3uqjJ+9FueQaZI0bCpRZkkpRU2podW9jw8wNPV64lDFQfcEUB09CG6X0mo?=
 =?us-ascii?Q?jZglt8Ww2UGIquDf35fQBob39jqDShs0dkLO1yxJv+qr15bbbe81OAPC2iCw?=
 =?us-ascii?Q?MCeAQ6SSa+PQxObwxQHYB2Vxb5Yf8QfQhLL+FV+wXwSZd2CfFYPw+feVq2a3?=
 =?us-ascii?Q?d0FxRVgl0WxtDOCqHA/mmdhS3UTnqpoEJW0Q2qLcRomAO9nBXKqaqkag3h4g?=
 =?us-ascii?Q?e4TfLtO6Inpg63mSo7GnlcGrlEWXFS6JjkyTf40llw8+SGo/aX7vIOaesruW?=
X-MS-Exchange-AntiSpam-MessageData-1: hq6LqnyuZYTv6OWZjyOcL8I44F/5sj+JYkg=
X-Exchange-RoutingPolicyChecked:
	bo1a1PthuZp4ZA76ZwXSg8Z6wTe2fiMrUWQk7OwxyVubBHJK+4Pm5L2Z8ddUYOmSZW3fenMwokFo1KTcv30xK3sPNKYhATVURqWvSkNV6coXQDo4Vpn8+W5OtZykdqdyBxdoABM7wwm46X/T6sOVzeh8TZ7tQg0cR9sz06vhs1BId/H/j9krU3xCWy3kVI0sO9BnjqG+gDlnkZLFM62NKss5ozyUhQRh/7EUD1wJbXASfuXGgBrV2l7VjM/ilQkEARcWtE+8VMzdmoB9YUdbuMzBHOVXlXNjx8qwZBpxo+yG4SXG82RIs3mRgrrym1QtcEx8jW/Q6YrXWCpeecXchw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bl8gG+YjKLD71t78J+8Uxb4binZDbUB7vgm45L+NAadiBI3Ad+pNStXf2z9bQqAAUGUr2rpPb2YXZCZFRzW7QiwbA1G9thkIawS9wNGPMm76RHrEv9eROwVoGmvEebxn5JRHuV9pUlWAavZBXv020KZu9D5KR9FpHvaSa3Y8a7PNKdm2jXFX4uIjqj/FZED9pXAzXox+eDk+0x5NoI4/kQKCspLs/Ql5T4n0fBKD31uEn3Z/ryQ82PTeNA6IcjRpFABcY4EPqebI1dZNZI+0djDILMUfJz2puVRdD6kRChVKAXg59QFihovByc/YQ0ZzGe3gBjm7nVlOepnGokhHm2Ce6IYfhRQMPYGNfAIXhvVV0X0MMq0ivaX/DIwK4JXVPfO7nL6PiJKq9C8II0oIoH/lGnd5MQ04f67O93/n3l3ojsEy2/h+SZIyM/ytaJrxKjjxCPBejiAA8i22wSmr9cOY5S3tK+YfLL/RM3PJTDmQsaD6Y4Z1rmrChm6dXEAZ+XmWftn5rJKjzxIUYplHfS8rQr8YLSvlIDEWK9c1NvjSnE0hb85pfxNToXpA5U3sDNgPHGZfs6+gQvfz2oxKzpYjBj7xAyHjW8pp13fymQ+devttKZjp9Gt5TU1qga8l
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1fba88e-6eaf-4476-613a-08def79e4006
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 11:46:58.4848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oL5guMsUZccRMPFbkJCv9/Zfy2BytNEgyRwF3xcmTL8/9PxK8Xrog3DnOtqLTp2p601YN3SI1VnSNqXasC2cWFpiFFVklJmggn74BiSbXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8200

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
