Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D5332A3DA
	for <linux-block@vger.kernel.org>; Fri,  2 Oct 2026 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790910219; cv=fail; b=TP4kDzGXEiART2djGgn/18Olcz9Rt9Zt/u5zNHSVwGs0nav5AuP3cTCdZ5YvHHFz4DcCyc6JzwCcPHCWC8nKCJTveDwRFMJooOqH0lP3z3RU7b2D6anVhVixMsdZxUPy0o1fIwdCNzT81fO5O7k4ltWrXNu9DGjDC140baGWiAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790910219; c=relaxed/simple;
	bh=BbvLwtIb7sNt/NYVi+a7NVU06qy9msdeOJylM6QCkJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PB8JdCRdX+v+Y0ryJD7GsMd1KKvnWuV7knocrrWp4X1H//pCG3woS6UQ1YXxxJ3KsbqxxGLzOzjJefDTSayZZGqptUB8rXXUeioh/9nCCw2ysCloBalfyjg9ulp6xX2JQq8/RSaPnL/T8aFGTfNOFjaHldu0K2FGf7WwXK02aHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=e+eeVM+L; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=aQ6rOZTt; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e+eeVM+L";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aQ6rOZTt"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1790910218; x=1822446218;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=BbvLwtIb7sNt/NYVi+a7NVU06qy9msdeOJylM6QCkJM=;
  b=e+eeVM+LG4WJrh74oSp+7rXcOoDKXgVtnsbrSdk2tU1AbxTIobUOCs8Q
   btwM4uYYrxExjc7W95QJ3dxPietYyQIY4e7SDZps3IhPBtbL3idOuKPuV
   mUJ1kCDEGXKmIKRBCJKnHG/Z6UAOCX07NgEGpX8+f5bkG6AMyE+LwbI/N
   9lcMMY/eGWIDsQywDCXANpViEscxp1hayNAbHlryur37IbIlqFsJ/35wV
   PLvLPEPLTPHmDNMVWMvOekEkjd6sQgRQbP3wJlXW7q/ZNhuxg0CoyG+bi
   sgC1x07h/T/OvL0uV3OT36B/hJKqrXQSsV4p4pifFri+nbCSp0ldYkget
   g==;
X-CSE-ConnectionGUID: j0rKBVksQ6KDBf3BvYVd6g==
X-CSE-MsgGUID: rU4REYW5RcKJjZ43Ls2FTw==
X-IronPort-AV: E=Sophos;i="6.27,135,1786982400"; 
   d="scan'208";a="156136664"
Received: from mail-northcentralusazon11010033.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.33])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2026 11:03:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmsYG7H+R3WoWUzSUYXtmq0qy9c/5r4fBZF6AvBCMKU5136yrc+HL9HcdoKXV8YdKEBM1qRFECWQVOFDoL17XhW4aLxYiacN9aKRH80nebnjZAJWcDPq8aBb+/Li/rO2YyYfZzYG0agICjHGOI/3eS6NoSBNEL8v0OBH1wFF6fEBXHO1PkLvGI6yNgLUzmboZ1N9p3FzB+h4FOMQa6Zy4NaG/Rxoqxknaum8RBD6EhR745siCTg0umGSX4+KnEbRvjFwUIhCXP33EpPnr0OVyVOK0IWIX4HBtKj9Cd0BFt/Hp/w6sQewY7EGvJURxAIABmZK9Wq4OPYfg38Y9Tk3cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Daz7TUh+dkOScJZ5EZfGhLOsuF6fk3AqzbVc5fuKZIw=;
 b=xzMzqMNgKNMa+UfuW4vmsglKQJpC3hKSXyWScZ+BQ3hI2JjACrHzFhxt4tkcjeXJT30rQZQTLcXm1Um2zRgPJvIrN/1F/OvTXjjRUZUoYeNvBcYal5i9vHimvjwwjSpzOnWC/vgoGKx/fWfcg0J3VEuwqJGXsoUjys4sP9VEeP20luM41pqgr1uz1mvoXHFYvnPHsc/2C/w3ZOsfbBBZvyhD0TQlpEpTl70XeZExOrUAKWiRWQNd5LbXeNl31mE8rSFuO4PQLPBD9rPNqnZNqDG6mjn+ty4pHA2vkB6Lb0aOkPN6BtdlYJZErbkNTnN6aAlMG968D0FxZNBDlZzW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Daz7TUh+dkOScJZ5EZfGhLOsuF6fk3AqzbVc5fuKZIw=;
 b=aQ6rOZTtTrMjhUQpyDPJPT5UgMxw52ralqJ8ZXJK6X2CBcYJW33+iE68YzXf4tva2N5HcSfxTMIIqd9rp9yElL/NO6co6JieULi+q6N+WYYUtDIyoT8saCH5Ycwbq/3WP8Klfl8wwaT1RA6xJX6PaJiUvB2ycjck0yq3cdPYeK4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA1PR04MB9873.namprd04.prod.outlook.com
 (2603:10b6:806:49e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 03:03:33 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 03:03:33 +0000
Date: Fri, 2 Oct 2026 05:03:20 +0200
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Hannes Reinecke <hare@suse.de>, John Meneghini <jmeneghi@redhat.com>, 
	Jesse Taube <jtaubepe@redhat.com>, Randy Jennings <randyj@purestorage.com>, 
	Dhaval Giani <dgiani@purestorage.com>
Subject: Re: [PATCH blktests 0/5] nvme: detect ABA ghost writes on multipath
 fabrics
Message-ID: <ar8eGV4jsEchjk-R@shinmob>
References: <20260917020752.1672578-1-mkhalfella@purestorage.com>
 <arOFG9-sM_GrrbQf@shinmob>
 <20260923170238.GH2931-mkhalfella@purestorage.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923170238.GH2931-mkhalfella@purestorage.com>
X-ClientProxiedBy: TY4P286CA0088.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::19) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA1PR04MB9873:EE_
X-MS-Office365-Filtering-Correlation-Id: a9d85bfe-74b7-4683-b432-08df2031be74
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|7416014|22082099003|18002099003|4143699003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	hv684YbijLZPiw3fFgLaGLSb8sfUvCSPoNAEyhZU8+pWK+cIsny/EcKz1VL55+xBJtErF5HeszuoHOX3vybj2OzrUid+lZxK83uKWKCLW36eKWH6bJrjodREO2sV7UHkZNFbWN2ggLwa2Kccw01RTUSbKbm14BKtra/rnZosZGcp+XHzPq/BR+kQQA3yIQEEKXgf6LHsdTeZHWq6eswDdTEsAnheU2xF8UN9e6TR3849e2JWI8h/PoQDpNOYA7I0y0yGUZNjHj5s2AsWBA2o+lhrgVtV+nnNoiMIcGbe49ouz9MYoQYrdAYKy7tfkUuQWbnntVfaWx0VxYPJ2yysIgfLn6ELzng87x+jsT2KVMRLcyWY+gBCeUHMwGHFdZizwcbbZ0vhw6QoMZZXc8x+fwLs1U/K4xaeO7bgeFh1oI2gPen5DkF+zPX1M54sq31UidmfIvJMrxzZx6jelSFr/+hhKks3+ybdnusevQBYV/n4Bv87GuoguktVmzCC5A/rs9kseR588ORcFtbVZ1Ovn+lsh8UxjGDEqM45TEnfTKoTZwGJwdngrBgRnlUu/zHKkkrJ/e69ZWy8C8KRF5III/lPHS0kpbeg/6WjR30/FAqT53I2RABueoZfr0AwMsrQr1xTlqaG1o7ivlyWjhJX3qaCCnWct+2TTWAlPOm6DuQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(7416014)(22082099003)(18002099003)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?44saeQz96tj0y9FTF0iJxgVPn7EBmQLD66jVwLIjTMZgzZcE5IeFggNBGyD8?=
 =?us-ascii?Q?G3bsbYoXEypkg6J32GshLo4p//K/2EdBiijhlzwaA8EICNCy5QYt6uq2E7KY?=
 =?us-ascii?Q?qYzRxI2itiSsckwEh+q9riGmWTvbLUZ87JomR2HAynsc1q6X/fuAcpanea1G?=
 =?us-ascii?Q?ZHSpZi8y6rb06beJ0CLGBBKc0nizlMtnW2d0sz/SSuk1QH5qz9KckhStEbzz?=
 =?us-ascii?Q?Yxo1AGAIYuWldVEq60I9D+cfDBa6bStY+/oTc6D9uuw+kIan8gvzd8FyJm/S?=
 =?us-ascii?Q?YyCkGc52ssZUrP5U9gXJDHNlleM22LMN54LP8TqH3/LAYnFEv0ESb7Hq8quW?=
 =?us-ascii?Q?cPzz/Iizr4WLMXBlLT3CVrInQvYe/zj0ITYMbsuWmjENFxJm/IioZBZ6NSdF?=
 =?us-ascii?Q?739nhJPOCHFye7L0lPGBEtb8EOlrUAXeSv5yUecRWWP8+/h9O/OT7ud07iMX?=
 =?us-ascii?Q?XLPBvR+TAAIjV6XsMAYJ+KxBwULfniRbGMK4tpNTZmO6DI4OYVvVMkLA91yi?=
 =?us-ascii?Q?qxv6JSs61nIZ+GG4bVmGJ/dUCSaBk4X+KdEpsRVUjLVLRkVjrP1SqWmZPGwP?=
 =?us-ascii?Q?T6DwQSqA2cCRJ1RlUIOmUgQG77ApeHxQmQ3tQFbVLvWFZvRhdEeVizK0kjgr?=
 =?us-ascii?Q?Rp29/xd6VJUkrQd2RX4jMk1ZsD2hVEHdsYBOBtCqGhfNWPoESJQ+SjNvUvoz?=
 =?us-ascii?Q?sqk0+lz14TUk7vYeAePNZwzl9Abn3QyX4SDF+okAnTXm7a0WsWTBC/sHM11t?=
 =?us-ascii?Q?fmncIv8T8FSRnap7N12s5Lg+oeUgHrfFwChDpEkw6Dqrc7SppXeW4mcxTV7L?=
 =?us-ascii?Q?QHtHOUrjt3VW7goQGLarDgdOk5d6Dz6qyl/qQeUUDYfQ694lh3E8YEgV8ppO?=
 =?us-ascii?Q?MTHceoj2ZaHb4AtcFSfmGKZKdekVtPbR3obC4DMc5rmGOYrqVLEfjzDsDK5E?=
 =?us-ascii?Q?XAM4Oiw+QzJg5Q/9HAt3NPCoeQJRsK7RSJlCXd8aoqrwv6asnhbUrgrj01da?=
 =?us-ascii?Q?LE/wPagiK56PBt5FbkHGfcUbF56OdBJNgXQVzZMyPRLiwbWDBPX16pO+uXxQ?=
 =?us-ascii?Q?kYBDC83xWptRaablC6V7xi0FbLlWtvpjeuYPSS3K4daMVIM9/euJPsnU1wYB?=
 =?us-ascii?Q?zGU1+YRcBgTuevpHi5SZ9EiGw6m3rcYYNDhC0l43UV95BZDCQaN1JDynODTs?=
 =?us-ascii?Q?Y86TCVTofilZbtLhgVx0tc3vqhfflO3CX3OtwC+QBEp5ZGzmcHmeHX3vlUoD?=
 =?us-ascii?Q?0Km0rTPiKNXm7Vvl0ISGK+EUYXM6pB3hBh1j4l0lTy3Whak/GORB3/ZWRvlR?=
 =?us-ascii?Q?K3VaMt35rE+dVjAAIKagLpDFLHBpZcwDQ0Nsktdo2JzolwlA+N30N1Nus08C?=
 =?us-ascii?Q?EWhUKdP4nOqURKBuHi++TwzxkKBH4mMfLwM3HnnBb0lvb3Znb4wspXgOCbg+?=
 =?us-ascii?Q?NVXAswumwXhcTuyHn4NIp1djWN0uMTmRP/Ey9J/YWTGSDNDf+eDQttnTOk1Y?=
 =?us-ascii?Q?T1qegx2qb5EKJ1BFiL4rRMUru5TDGvdmUFoDTSSh+qaQ8mQ2dHIEeagatZKr?=
 =?us-ascii?Q?xwtAnuCoMJBycw4NNIEig2GtwL2CYMionuPftqETqETXlVdmoaGR/4R9280d?=
 =?us-ascii?Q?5p4RJcL4CZrDgI1snnKxyFkCdkECEDTJZrmb+EsZhC8HRdM/H4+LxUGI3JkO?=
 =?us-ascii?Q?UpH1BukuKebHBHfrcU8pfp2hxr88hp7NiWLIynF46P1WHxpopKItOV+Pteat?=
 =?us-ascii?Q?v9XoqsBkiJcIK3SlbRS93RxSEtuJxiE=3D?=
X-Exchange-RoutingPolicyChecked:
	47A7sEPTgA02hutGAhnqn4pL7BLJebu7cCXvUNrfo1BLw+0woVwOobSiEw14wS+SEZhjFKc9cce9epZ1GWf/mlYNGTmsg6SnVLgwQqM5RBB+JRytJOKR2z0gU+qMoGT1GRlYBCFMofmZOYHi9U4GSF/Pim2JcqHnZ4OuqyN7LaKGxyJfNwDfKVcc49Gt3C/gMMljHVdJbPbqFWAZT8vDlDwV74sQ5mbIJxLyJkeVFQdiWKKBBmkmVqM1WLY2G/90RZqaBNLkXh22rd1ZgKt5HVCnYb709H75Bs4Gkwe23emrRps0u4GHwgMFNzC7Qn91ppoqifp0ug54nhGli/v6IA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	plKrru6TtmUmIqVzvafu3JyAbpXRMbNrgkPkePBmvlad/r9fEDtiIBxp5GRn120wdsWiTKvjjj0ziQ96nUHrAgjirIkv6drvCtypsqj/FwyuBNQF3JqYpqWY7lmAMQm9Otso80sysa1TPuioUWsDsBg0YPttj24GkqtDZ0BCdowAuHmYHgGX0LFB1VapArmIC3FYO1Ao5Ds7sItdU3cPbMFRMQ/GZyi/IhW1y8MTeuG6Jwzr9HsV0od8QW+icV6lxiobOW++cXlLVAGvKyECfzco4pC5dBKTEXuft1QIkQhRbxOWlrRKSLqQ0H8l+LG9UljY+8yRVbnkutWps8Ibb2uRrdkTDjRrhK6P7pQeqQzWZGKV2tIpoLoLdAnJoFfOxS87UcCmsPtNAYu8Lg9hpo8Vyt1hlqqlhZZHaJ2ArzvTncjEYn4IdCwqi6AzGXkUGxyRLhS29W/aPexqBKxtzFghl9m7tOzNEn3W+NWrkVCfRGPGrcFSOnRj0tpK80O3OZXjhRvVMDe/okxVaPTNzkMGt5NplFyy2YD18FzeQ1x2/MWeoa7kiQcRGKy4AD/5RrHlTWhsXZ/hUC1kpO3xb675cjjXMdF8N3QsrtIhlFDmURi1oNhY6fXxelh5HIqq
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d85bfe-74b7-4683-b432-08df2031be74
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 03:03:33.4989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KW8DPqBSIAIZXUTTRZnXI2lmWE2v9e2vO/dHr5rLhg2aVQdcIuLlmxpfGKRkDUluJ7Bk0130JLTeIKUSy2MJzZ3pUMPv4fqfZ7LjVNVbOfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB9873

On Sep 23, 2026 / 10:02, Mohamed Khalfella wrote:
> On Wed 2026-09-23 17:18:21 +0900, Shin'ichiro Kawasaki wrote:
> > On Sep 16, 2026 / 20:06, Mohamed Khalfella wrote:
> > 
> > Mohamad, thanks for the series. Before I look in the details of the patches,
> > I would like make a comment below.
> > 
> > > Reproducing the race needs an IO that can be held at the target for
> > > longer than the host's io_timeout without being failed. The first three
> > > patches give miniublk that ability, since there was previously no way to
> > > talk to a running ublk server at all:
> > > 
> > >   1/5  adds a loopback UDP control channel to the daemon, served by a
> > >        detached thread, one reply datagram per request
> > >   2/5  adds an INJECT_DELAY command which delays a given number of reads
> > >        or writes as an io_uring timeout on the queue's own ring
> > >   3/5  exposes it as "miniublk inject", which returns only once the
> > >        daemon has armed the delay, so a test can start IO immediately
> > >        without racing it
> > 
> > It is interesting to implement the delay feature to miniublk, and use it as the
> > testing tool. But I'm not sure if this is the best approach because of two
> > points. First, scsi_debug has jdelay and ndelay options. I wonder if this
> > existing feature can fulfill the requirements of the new test case. Second, when
> > rublk [*] is available in the PATH of the test system, blktests detect it and
> > use it instead of miniublk. I guess the added delay feature is not available in
> > rublk, and the test case won't work well. What do you think of these points?
> > 
> 
> The two points make sense to me. Let me look at scsi_debug delay
> injection mechanism first and see if it can be used here. I will also
> look at rublk. Thanks for the pointers.

I've learned that now delay injection is being added to the block layer [*].
This looks more generic and could be the best way for this use case.

[*] https://lore.kernel.org/linux-block/20260928221634.43239-1-haris.iqbal@linux.dev/
