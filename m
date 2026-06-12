Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB6331EA6
	for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257746; cv=fail; b=pu008My2Muu7Guc7uwjEAhbvisU8sXwSKsbYh4MAqqbdzvSnBmo0YDuw1y2bG4zz7Ukre3BX9o4YLGjdnQeMVnrKFcP2xgg0X3xwJaeuZZfXo5pwzmMMNikVYRpmk+ZGRte6nu1skxTjlfMg1LOPtGF9R9PPaS0J6nE5XmY9whI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257746; c=relaxed/simple;
	bh=mHbs8qMOCBFRBK8xBTpmOd1sCSG23kYl+CkF5jIiCXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y7+uPvBv94wfpk236usWWThuCO2zLhh9inh2EYYAuWx7bx74kieyFc6F/V5pn1fdVuO5nFLmSBgyzHqgs7W0UoTDdZcOuHnTVKAZT6Ii8cZTjqoI2nf6fKr43JJ5JoYb298ZDakl/p4ERT6kJya2rY/wt9uWF10bzwnOEIH49Pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Hl7pmtRn; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IgLlWdYU; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Hl7pmtRn";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IgLlWdYU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1781257744; x=1812793744;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mHbs8qMOCBFRBK8xBTpmOd1sCSG23kYl+CkF5jIiCXE=;
  b=Hl7pmtRnLNc98AkQpa7EmNi6Mw9rVDkKEU5OPjR4ZWvOSDsoN9FiZZ9Z
   HMcZ2I5PTPkhDtd1JQnWUjVrEFSHNPe4xab2LIhUlAPzksNvtn0KF2IsZ
   3BJLIovM2Z69vdoSu0u8JiVlxO5ToQxcmdGji0d1LAEjMJJzKJ3dxFvPG
   +7YTbwUFrjs/Z9EWB9Tknfmd6EOiiK8Dw5pgTaFPqtVelVBNbZuLU3Ut3
   Tpm64tPLu2zlQDnksJ3derDP8Ff4AXTqs9rUOP3xH4ZHdBYvJpVihD5Q3
   YOnFbsjO4PnRglwhYj35sfHy3Bp+f8BNHZvxSZiVQvC/jnSnodpqlXfGP
   g==;
X-CSE-ConnectionGUID: CrbuezN1Qoyg1VjbCg4Nkg==
X-CSE-MsgGUID: omVqVkLwR+mla8iOdKN7mA==
X-IronPort-AV: E=Sophos;i="6.24,200,1774281600"; 
   d="scan'208";a="148031026"
Received: from mail-westusazon11010048.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([52.101.85.48])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Jun 2026 17:47:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AbaUUOY9rPDYKVp7IIKwD6UDwzLllFp4Z0rgTn6K09z5BQuzKlR4XKXSotbtR3k2+WNb+iGo2xJniKC0Spbq65w5ugYIA+/vsJ91iimoQsyQNfex2nXNVm/Zkip+sRrV3PeAWVCMYF+NwakHCirdQoT6dstb5Dpd5ekIctnGl2YnePCPIZSXAF/k6ab5nX3wcdvvhQiEy/7Heu6190dzscDcuWuv8d8BrjVQ09ned7caRKa+R3IFuYYC8/JcRT3+wwJYRq64xqQZN5jaArloME6JCQ6TGu8OS48WFWn+MpCFe3/icjU0Y+sm9Gtkpij6k09R1OwNRbeRrlTdW2uzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJXr+jnQbuW+9NCAvOVQUpV6a4z5pXyMNvs0MAMaM9Y=;
 b=tTZimvUTPVm/0XoOrGDM7kOnrD5YzBElZRjzefRNajXdMfg0hqK5ChUluc4hYRtPERwR28yl7f70+T4cIp1HheDtXm+SO8wFM6+4S3LnVI8vO7A+7odZX1TRVJstZFlV2x/vjA20b7Khx7n7OY3qrL48oZqbh/I+lQ7dMTWs7lmsUrJ+LBFp7RBdXWy6g2oy3roCxe7b35fmiEgXlXG64BSXaULVmkXLqb6q3+YFuJN/eMMBzlK+xsUKU+C677Wp8xXffZ1z1kgaFlVXdkVEFFMSNHn+FHLurl+Hvy/7QfJfnhleABBgGsS7uXdGGljFxglJFCP7nCLEOyuoVkwpgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJXr+jnQbuW+9NCAvOVQUpV6a4z5pXyMNvs0MAMaM9Y=;
 b=IgLlWdYUdaxloT8LpSOyNLqa4cVVEaG91RKi/kp9O4UW12k1Kae8gxd/3t9kGQKWCo0w5ejwxGhD1/sV1SIvzDb0orSpXURUtZCZI5oqyLQFhFiTjqeXnh5XUqB0ZwBXxV0Tab5TqL4LzWhH9QptoeaQyTYSJH8cVXJpcCYy6CM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BY5PR04MB6706.namprd04.prod.outlook.com
 (2603:10b6:a03:22e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Fri, 12 Jun
 2026 09:47:55 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 09:47:55 +0000
Date: Fri, 12 Jun 2026 18:47:50 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH RFC 0/1] block: fix concurrent elevator change failure
Message-ID: <aivMxPCd305WbBsk@shinmob>
References: <20260611074200.474676-1-shinichiro.kawasaki@wdc.com>
 <aiqaXfTqCLMu2DwF@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiqaXfTqCLMu2DwF@fedora>
X-ClientProxiedBy: TY6P286CA0037.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::11) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BY5PR04MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fbc8136-0075-4320-a901-08dec867adb2
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|366016|18002099003|22082099003|11063799006|6133799003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	CW8TKxLnruNNhqZTHOAiwcgxAYWAeFFoFXSZnOgzsp/4B7N+qYRE96YZnadQoXJfFulMwSxZ+5POAPXSMf+Yd68PiQ8vnqQcqkgiFNw8tbydOf8XQEWNElr5Zzjr3k6J3FdEFywFQGpQBqtba5Xarb0G/QCSEhGA+zJdtazpAao5u683RnR+Gc5dtSWpc/d8gHx5Ssazuea/9Ja1zgIh8kgC7w8jM1fcYflhsv7YSsFgovLk6/RsRXiWskB7BsabCou3x1s+SFkcNt3q3qerQQ6mvOu0XVKA6nfItzTazWjt6480JUG2jtmE4hyGP9NAteACnUcKiRCohH42XZvwuyMNDfJO2s4Wh025fsLfjI9JXajbXOuvc1cdcfShUUsYqqhxoBs/yaiEYGuTdINTcjBUeagP+6JDNFvplS71lYIo2beQg6TMstuhtd+VwO2NU7Ah3LBAD41VEzB8HR34z2odR60aW16LftK2rcGQJTNEQgSCDsPTSGExyTZ2jnflZMc6B5z1lx8LTsq+N4yiqpEeo0u83i6KU9CpfSLCmQdLDezbY6BUlyxjl1ouwuUHbkL1F3o7GcPs4TWFsKvryIUPOIPseSM2zKVUqOUISmKxRUhr9tbIC6hU6809mHqsCWrR1vZLqYhhKjbBvsn1NRaeSxSwFGdhJcC1fuQ1IufteudywqhouGBFOk1x7VZL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799006)(6133799003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6dN4p0JwYJVPli17LyqI8pIryJ5+AiVI66jH0UkvztpaA22fY9FwaEqlPA3d?=
 =?us-ascii?Q?LJF6ueDMIJyqP+AkdAXed7qHiGBrVphgFPIhqpCwlzV2suDSonaGbZeYjOME?=
 =?us-ascii?Q?v2un7jQZlVqeaLBlLFP8U2Jl2LuFOcqS9SRjjU8QtFQOg66KQMAabAE+IlvR?=
 =?us-ascii?Q?UC8zj5vuKNlpHzjCbOMxehAKuxPCIhezMysL/14dIhq7N76hzWXwI7b8AMWS?=
 =?us-ascii?Q?UhWP40HPzaVP36il/aQYnFuv8iZD0lUEUXvI/gMgHrFmUl1KwwXSlhrQ6ymg?=
 =?us-ascii?Q?+5K0YkENCU43fS9lCjK53hRTXbtQctyg+SmCwK5LOvlqGqQSXsDV0RVf/IFX?=
 =?us-ascii?Q?wwEPC0mpURVaecgfGqLWm/QFn+IMvX5BSG3/LYKMufnvQEZPIhwy+OR8Fb9S?=
 =?us-ascii?Q?Tv6AJR/o6Pxqj+ubBFtSIax7t+btOtH40Im/VVERzskbsoOpKjvdR2EOs2qu?=
 =?us-ascii?Q?IR0mAzHliuFQtbIOd7clt5FzqE4sLTDO6WfiPlUZJ5dqFm0j2iYoccjHd8qW?=
 =?us-ascii?Q?u9vgTyxOAHXrEFBlP8tfP6RRsmFa2nT3MpIBX1admFtWCDPNBuCwAn4uPjJt?=
 =?us-ascii?Q?BxExeTcvGjHZOwVYnhRP1DEBmC4kNPp+1YAoJ8UXKPfI1kCOXP7sIZAf20dV?=
 =?us-ascii?Q?u2z4kJCcJESzgT6mR8OhVWW3a9fcyuEzu3i3/hV3u9CPBJuNtrIuWbKIL3Tn?=
 =?us-ascii?Q?SX9sKH0nEYdGV48pNYdy7nAoK+KqKg++oUbxbZ0hE6gV7Z8Tezs3Alziyu/U?=
 =?us-ascii?Q?sFKBNkEBh2rNfqmYdH3Bx7ImNsEFca8LswS1tuk34QVfvjAbOM54QUkvlOKw?=
 =?us-ascii?Q?SCWEVjRij2mDmgihKHFMDfsQZs/0Hc+Hh6AxW+ijtvtiOlxrmfw+NUemvOVw?=
 =?us-ascii?Q?wuE8qnFdPW8Bil/2Kb4hAlRgbxuTniuFZqGQxBcF7qWObQmT2OC4EUVLg7aZ?=
 =?us-ascii?Q?h8HE83hM3CuJ0QTdiSXMM7Rc8zmPBXByhGpF77RSnsg2y+sXZ47pesFEFuK6?=
 =?us-ascii?Q?/0PeE392CX2T0fr9IBDoek626f44sg+I00X7c3YrxVTenM8B4kx+D1jHlQ2m?=
 =?us-ascii?Q?dQq3Zs7vhlLh4FcKn213UAwiyhOqgbWUpt20b1KXtiY4G5oj86D+vgGqTu5i?=
 =?us-ascii?Q?b932YgEaL4jEjDvB02x/GjU5Ptgv1JU3JOqAEVC+YGPMIWkiAwvDuaN52CQe?=
 =?us-ascii?Q?k080ruwqDzMskgrLIjDaLxxSbm4NQyzMOjZLPh80p3jiVqwCGAU4sCagQWp4?=
 =?us-ascii?Q?qbR7Qj3nD+1LzFEtTKUiRrBlnMkRUHNKrjLIIjSYcwixcXWvUTwzNcBWzK+3?=
 =?us-ascii?Q?CIPCPRanGS/XGsqnT/EPFVhLG7IlLkG2PCYk+HptOFBADofGMQWXT8IVA6eJ?=
 =?us-ascii?Q?i9hO2JMS5Al5r6ySCyDqZFFaq7C4HJCvMdeMlBT575XjREYU9XnNdj+kPemv?=
 =?us-ascii?Q?x4brfjkXq4u9lJHaBGFGX6ZXRM8IIUXS9QBDBrslHPfRPAlBwtD2xumdSqsM?=
 =?us-ascii?Q?6eTLMwEUhM4P7jRoh2JGNwmqudvA7xiDf+xZcIlCHPzIPOteZZSzxx404s+F?=
 =?us-ascii?Q?ufom/jBqzmB+6t0b8z2SNI77fJFVF2LLe2bCiqGUciY5lHZqMNZ67s72l6Q2?=
 =?us-ascii?Q?DxUOZJpM+VHq8q7uqUUtgJCjo0lXZGdU6wRf1VDTg3SFyC8ujyTcw4gy5cU1?=
 =?us-ascii?Q?8kocn8xPsx3JCAkvuwenQbPgZSb+5ZmCAwqr1eb7jgtrSM2/+O68bnMXs6jT?=
 =?us-ascii?Q?jOBGL+7b781IbfncYuEHu0GzXri6hAM=3D?=
X-Exchange-RoutingPolicyChecked:
	U8aQxtn+WvwOwzXnirDyg46lNYjW7FOUhKrAzfvU/ooI6GAd4/7MlzIalut+DpGcZlea5uLkLxZ1Zjp8W6S3bPmn0LNv0he/AOm99BwoxMLqNSQl2zcjdgt1U9mOKJaB/jrCbD+Lh0Z2DUjCYYGPHHPmS3nHHDbBxBY1AnuyHB/KZkuIoZhZ4bLp41SX8aIkDAIYz0eML7VMrtsFHLGun0kkJiglABAL0RAA8phb63vZQIHzfSyDlcJXVHvmyoK1H4OK97Q8I/+4YoqT/BWSah/IsyLoj3EECC+MY22sKK/z0v2oD6IwetYsCutWE8ds16AIVezC/eGSoxFzyohwcA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FHAZMpp10JOTHhEY5HQT7iHQQka0os/U0ZMzoqiiHZpQ7VzO3S3HWIz5zTXmDnRfDdpSjcoxl17tiyCFvtkgpJKJm0y0ENZRot3L0yLBEGQ6NN/TPtOxA8i7bm17r6mgfrIWYFGAjkmdYGaerIRP7En2GMdrEGDKjhtWcE418Ld38YvDBn5xF35ex/BSWKJZaOpsuU4xMPlMqNAkzOWq/Kt1FVhpK0ex/xHD4mbCZCKWhXxdgny0KfYo25DHI88uXscd6TS/x+OJ/fMR179os6zsJs/Mh8uzelKmnUW7Kse0+r/MrwaUVoDMV3KzVbFeDp4z0B558ULyQhPwNjW9GZ2v2YvO4WuxIPediRC68xSlHKRicGb9tVoxSqXPE2kj905gCAtGkboEoSFjppz35CbuhY4K4mioLlLxbFfXNlfKw3XM34NjtrTuJ6oPPMRj6EFdeFQdVCcX7QHfLnib8XBoy+EgbqFCsGtuplPs5x+qixaA8iCsZcqIjnngXW+gehEg82hMlQwiL3AHuNQaJV0277c73L7KqNWPAbz+Q2kKJzTmXWj9Ch2EUL9gbP1gMlLUmePbCc4F3fZvzP7RWud9GJQz6AoCwEi+RgNA0oohR93m7CO13JejF0EVA9bY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbc8136-0075-4320-a901-08dec867adb2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:47:55.5693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYReE7ASHoyO8ke2puZaOboH5Hz0QamqGifnFgOjPPSA2ElCROR87M/hqLE3GXN5xyqwdxHgPddquK3VE8Z/YaJ8UcMbZle9q63hK2b2Qfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6706

On Jun 11, 2026 / 06:22, Ming Lei wrote:
> Hi Shin'ichiro,

Hi Ming, thanks for the comments.

> 
> On Thu, Jun 11, 2026 at 04:41:59PM +0900, Shin'ichiro Kawasaki wrote:
> > I observed that the blktests test case block/005 hangs on a specific
> > server hardware using a specific HDD as a block device. During the test
> > case run, the kernel reported a KASAN null-ptr-deref (and other memory
> > corruption symptoms) [2]. This failure looked sporadic and hardware-
> > dependent.
> > 
> > From the kernel message, I noticed that udev-worker wrote to the
> > queue/scheduler sysfs attribute to change the IO scheduler, or elevator.
> > The test case block/005 also wrote to the same sysfs attribute, which
> 
> sysfs write is supposed to be serialized...

I checked the sysfs write handler elv_iosched_store() in block/elevator.c.
I found elevator_change() call is guarded with the rw_semaphore
"set->update_nr_hwq_lock", but the guard is not the writer lock but the reader
lock. This does not serialize the sysfs writes.

I tried the patch below to replace the reader lock with the writer lock. With
a quick trial, it looks working. The kernel message is no longer observed and
the new test case does not cause hangs. I will do further testing to confirm
that this change does not trigger other new lockdep WARNs. Assuming it does not
have such side effects, I hope this fix approach is acceptable. It doesn't add
the new lock, so I think it's the better.

diff --git a/block/elevator.c b/block/elevator.c
index 3bcd37c2aa34..b03185a217ff 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -813,7 +813,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
 	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
 	 */
-	if (!down_read_trylock(&set->update_nr_hwq_lock)) {
+	if (!down_write_trylock(&set->update_nr_hwq_lock)) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -824,7 +824,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	} else {
 		ret = -ENOENT;
 	}
-	up_read(&set->update_nr_hwq_lock);
+	up_write(&set->update_nr_hwq_lock);
 
 out:
 	if (ctx.type)

[...]

> blk_mq_sched_reg_debugfs already includes debugfs lock, so I feel the proper
> fix could be check & avoid the null-ptr-deref.

Actually, null-ptr-deref is one of the failure symptoms. KASAN slab-user-after
free is also observed [3]. Then I'm guessing adding null checks may not be
enough.

> Adding new lock should be the last straw usually, especially this one is
> depended by queue freeze.

Got it, thanks.


[3] KASAN slab-use-after-free

[  802.836569][ T3919] run blktests block/005 at 2026-05-11 10:42:39
[  804.256901][ T3866] debugfs: 'sched' already exists in 'sdd'
[  804.874743][ T3919] debugfs: 'sched' already exists in 'sdd'
[  804.882124][ T3919] ==================================================================
[  804.882154][ T3866] debugfs: 'sched' already exists in 'sdd'
[  804.890039][ T3919] BUG: KASAN: slab-use-after-free in elevator_change_done+0x304/0x610
[  804.890053][ T3919] Write of size 8 at addr ffff8881273e08e0 by task check/3919
[  804.890061][ T3919]
[  804.890069][ T3919] CPU: 4 UID: 0 PID: 3919 Comm: check Not tainted 7.1.0-rc2-kts+ #1 PREEMPT(lazy)
[  804.890080][ T3919] Hardware name: Supermicro Super Server/X10SRL-F, BIOS 2.0 12/17/2015
[  804.890086][ T3919] Call Trace:
[  804.890092][ T3919]  <TASK>
[  804.890098][ T3919]  dump_stack_lvl+0x6e/0xa0
[  804.890118][ T3919]  print_address_description.constprop.0+0x70/0x300
[  804.890135][ T3919]  ? elevator_change_done+0x304/0x610
[  804.890145][ T3919]  print_report+0xfc/0x1ff
[  804.890154][ T3919]  ? __virt_addr_valid+0x1d1/0x3f0
[  804.890163][ T3919]  ? elevator_change_done+0x304/0x610
[  804.890168][ T3919]  kasan_report+0xf6/0x1c0
[  804.890176][ T3919]  ? elevator_change_done+0x304/0x610
[  804.890185][ T3919]  kasan_check_range+0x125/0x200
[  804.890192][ T3919]  elevator_change_done+0x304/0x610
[  804.890198][ T3919]  ? sysfs_file_ops+0x70/0x140
[  804.890206][ T3919]  ? __pfx_elevator_change_done+0x10/0x10
[  804.890213][ T3919]  ? __pfx_sysfs_kf_write+0x10/0x10
[  804.890220][ T3919]  ? __pfx_sysfs_kf_write+0x10/0x10
[  804.890225][ T3919]  elevator_change+0x283/0x4f0
[  804.890233][ T3919]  ? __pfx_sysfs_kf_write+0x10/0x10
[  804.890239][ T3919]  elv_iosched_store+0x30c/0x3a0
[  804.890246][ T3919]  ? __pfx_elv_iosched_store+0x10/0x10
[  804.890255][ T3919]  ? lock_acquire.part.0+0xb8/0x230                                                                                                                                             10:42 [84/1747]
[  804.890262][ T3919]  ? kernfs_fop_write_iter+0x25b/0x5e0
[  804.890268][ T3919]  ? lock_acquire.part.0+0xb8/0x230
[  804.890274][ T3919]  ? lock_acquire+0x126/0x140
[  804.890281][ T3919]  ? __pfx_sysfs_kf_write+0x10/0x10
[  804.890286][ T3919]  queue_attr_store+0x23f/0x360
[  804.890295][ T3919]  ? __pfx_queue_attr_store+0x10/0x10
[  804.890300][ T3919]  ? __lock_acquire+0x55d/0xbd0
[  804.890308][ T3919]  ? lock_acquire.part.0+0xb8/0x230
[  804.890314][ T3919]  ? sysfs_file_kobj+0x1d/0x1b0
[  804.890319][ T3919]  ? find_held_lock+0x2b/0x80
[  804.890326][ T3919]  ? __lock_release.isra.0+0x59/0x170
[  804.890334][ T3919]  ? lock_release.part.0+0x1c/0x50
[  804.890340][ T3919]  ? sysfs_file_kobj+0xb9/0x1b0
[  804.890345][ T3919]  ? sysfs_kf_write+0x65/0x170
[  804.890352][ T3919]  ? __pfx_sysfs_kf_write+0x10/0x10
[  804.890357][ T3919]  kernfs_fop_write_iter+0x3da/0x5e0
[  804.890363][ T3919]  ? __pfx_kernfs_fop_write_iter+0x10/0x10
[  804.890368][ T3919]  vfs_write+0x524/0x1010
[  804.890378][ T3919]  ? __pfx_vfs_write+0x10/0x10
[  804.890393][ T3919]  ksys_write+0xff/0x200
[  804.890401][ T3919]  ? __pfx_ksys_write+0x10/0x10
[  804.890408][ T3919]  ? __pfx_pte_val+0x10/0x10
[  804.890414][ T3919]  ? folio_xchg_last_cpupid+0xc6/0x130
[  804.890421][ T3919]  do_syscall_64+0xf4/0x1550
[  804.890429][ T3919]  ? __lock_release.isra.0+0x59/0x170
[  804.890437][ T3919]  ? lock_release.part.0+0x1c/0x50
[  804.890444][ T3919]  ? rcu_read_unlock+0x1c/0x60
[  804.890449][ T3919]  ? wp_page_reuse+0x160/0x1e0
[  804.890455][ T3919]  ? do_wp_page+0x5db/0x10a0
[  804.890465][ T3919]  ? handle_pte_fault+0x54e/0x760
[  804.890472][ T3919]  ? __pfx_handle_pte_fault+0x10/0x10
[  804.890479][ T3919]  ? __pfx_pmd_val+0x10/0x10
[  804.890485][ T3919]  ? __handle_mm_fault+0xa02/0xef0
[  804.890493][ T3919]  ? __lock_acquire+0x55d/0xbd0
[  804.890499][ T3919]  ? __pfx_css_rstat_updated+0x10/0x10
[  804.890509][ T3919]  ? lock_acquire.part.0+0xb8/0x230
[  804.890515][ T3919]  ? count_memcg_events_mm.constprop.0+0x22/0x130
[  804.890522][ T3919]  ? find_held_lock+0x2b/0x80
[  804.890528][ T3919]  ? __lock_release.isra.0+0x59/0x170
[  804.890536][ T3919]  ? find_held_lock+0x2b/0x80
[  804.890542][ T3919]  ? __lock_release.isra.0+0x59/0x170
[  804.890550][ T3919]  ? do_user_addr_fault+0x811/0xed0
[  804.890559][ T3919]  ? do_syscall_64+0x34/0x1550
[  804.890564][ T3919]  ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x140
[  804.890570][ T3919]  ? do_syscall_64+0x34/0x1550
[  804.890575][ T3919]  ? trace_hardirqs_on+0x19/0x1a0
[  804.890584][ T3919]  ? do_syscall_64+0xab/0x1550
[  804.890590][ T3919]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  804.890596][ T3919] RIP: 0033:0x7ff08cbe3bbe
[  804.890603][ T3919] Code: 4d 89 d8 e8 34 bd 00 00 4c 8b 5d f8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 11 c9 c3 0f 1f 80 00 00 00 00 48 8b 45 10 0f 05 <c9> c3 83 e2 39 83 fa 08 75 e7 e8 13 ff ff ff 0f 1f 00 f
3 0f 1e fa
[  804.890609][ T3919] RSP: 002b:00007ffc95718820 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  804.890616][ T3919] RAX: ffffffffffffffda RBX: 00007ff08cd5f5c0 RCX: 00007ff08cbe3bbe
[  804.890621][ T3919] RDX: 0000000000000006 RSI: 0000563340f2c390 RDI: 0000000000000001
[  804.890624][ T3919] RBP: 00007ffc95718830 R08: 0000000000000000 R09: 0000000000000000
[  804.890627][ T3919] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000006
[  804.890630][ T3919] R13: 0000000000000006 R14: 0000563340f2c390 R15: 0000563340f96890
[  804.890641][ T3919]  </TASK>
[  804.890643][ T3919]
[  805.368835][ T3919] Allocated by task 3919:
[  805.373543][ T3919]  kasan_save_stack+0x30/0x50
[  805.378559][ T3919]  kasan_save_track+0x14/0x30
[  805.383559][ T3919]  __kasan_kmalloc+0x9a/0xb0
[  805.388465][ T3919]  elevator_alloc+0xc5/0x2b0
[  805.393366][ T3919]  blk_mq_init_sched+0xa6/0x5e0
[  805.398554][ T3919]  elevator_switch+0x18e/0x680
[  805.403702][ T3919]  elevator_change+0x2d8/0x4f0
[  805.408802][ T3919]  elv_iosched_store+0x30c/0x3a0
[  805.414116][ T3919]  queue_attr_store+0x23f/0x360
[  805.419289][ T3919]  kernfs_fop_write_iter+0x3da/0x5e0
[  805.424938][ T3919]  vfs_write+0x524/0x1010
[  805.429600][ T3919]  ksys_write+0xff/0x200
[  805.434159][ T3919]  do_syscall_64+0xf4/0x1550
[  805.439064][ T3919]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  805.445273][ T3919]
[  805.447927][ T3919] Freed by task 3866:
[  805.452231][ T3919]  kasan_save_stack+0x30/0x50
[  805.457287][ T3919]  kasan_save_track+0x14/0x30
[  805.462282][ T3919]  kasan_save_free_info+0x3b/0x70
[  805.467645][ T3919]  __kasan_slab_free+0x6b/0x90
[  805.472736][ T3919]  kfree+0x21c/0x620
[  805.476953][ T3919]  kobject_cleanup+0x105/0x3a0
[  805.482039][ T3919]  elevator_change_done+0x196/0x610
[  805.487633][ T3919]  elevator_change+0x283/0x4f0
[  805.492730][ T3919]  elv_iosched_store+0x30c/0x3a0
[  805.497989][ T3919]  queue_attr_store+0x23f/0x360
[  805.503144][ T3919]  kernfs_fop_write_iter+0x3da/0x5e0
[  805.508747][ T3919]  vfs_write+0x524/0x1010
[  805.513381][ T3919]  ksys_write+0xff/0x200
[  805.517944][ T3919]  do_syscall_64+0xf4/0x1550
[  805.522862][ T3919]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  805.529118][ T3919]
[  805.531858][ T3919] The buggy address belongs to the object at ffff8881273e0800
[  805.531858][ T3919]  which belongs to the cache kmalloc-rnd-13-1k of size 1024
[  805.547392][ T3919] The buggy address is located 224 bytes inside of
[  805.547392][ T3919]  freed 1024-byte region [ffff8881273e0800, ffff8881273e0c00)
[  805.562078][ T3919]
[  805.564734][ T3919] The buggy address belongs to the physical page:
[  805.571446][ T3919] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1273e0
[  805.580609][ T3919] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  805.589411][ T3919] flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
[  805.597524][ T3919] page_type: f5(slab)
[  805.601916][ T3919] raw: 0017ffffc0000040 ffff88810005c640 dead000000000100 dead000000000122
[  805.610881][ T3919] raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
[  805.619808][ T3919] head: 0017ffffc0000040 ffff88810005c640 dead000000000100 dead000000000122
[  805.628815][ T3919] head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
[  805.637838][ T3919] head: 0017ffffc0000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
[  805.646901][ T3919] head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
[  805.655983][ T3919] page dumped because: kasan: bad access detected
[  805.662913][ T3919]
[  805.665657][ T3919] Memory state around the buggy address:
[  805.671717][ T3919]  ffff8881273e0780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  805.680194][ T3919]  ffff8881273e0800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  805.688697][ T3919] >ffff8881273e0880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  805.697130][ T3919]                                                        ^
[  805.704717][ T3919]  ffff8881273e0900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  805.713179][ T3919]  ffff8881273e0980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  805.721720][ T3919] ==================================================================
[  805.730526][ T3919] Disabling lock debugging due to kernel taint
...
