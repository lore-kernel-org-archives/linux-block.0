Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637A633F597
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782163846; cv=fail; b=P2EUJ8q6H3Xf/J5m58IKIJyqOYLHFVzNH6H3ntsnbDmKTxFPembbrtf9tqJKcNPaa1COs5l8c0q/oq8lGPkMvSUzaSY70655vzWU3bDufMO/wBKpPXyS+3yWpopxyJ2VBUM8oviXOzLPscZGU/d2zOeomo4eAhJzG6hGCHMeVfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782163846; c=relaxed/simple;
	bh=2UF/E+XvwLm2Cw/6wRAHXxaHdQO2H2ZMQI4l5oXCJbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JKn4oLlyl9F/sTrgVQbi6wN5N5+h2oHTsy5nATc/19wRoHcMjY1diQl8djmE3aNIkMu+u1P3Oc7ABXXaJrF+b+YkTdMFOcIqGYXwc27MAWy4bHdcM3zkgoNMvC9uJevs7eZ1PG6p0cVGs8N2wm/rM3h412zrFJQzFrvGWU28kMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BmQWjX0B; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jmxqB7+G; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BmQWjX0B";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jmxqB7+G"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782163844; x=1813699844;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2UF/E+XvwLm2Cw/6wRAHXxaHdQO2H2ZMQI4l5oXCJbI=;
  b=BmQWjX0BvhMhkEAxg8JjbxyzENG0V2vUQ9/m/ebPA63VifAOJpdj9LEF
   IbECYCK1eK4/tOIFgkutgBTNGQrJFQ/Vo/bX5NlioI11n5VaXNcVqfJcW
   i43B+XIKuHxJV+xqjHHUlqf+Ac0nnGKlX/dvkRQ34GSu95pjyc+Cr+nB4
   udeFKgJmFwfzKG6JK88T9zFxFIZFBfBICrWwVaFPxN9eeyKILRUniNzT+
   g3FeV04zD4a9y/ZHeY+P1a2HRN+6w/TGuac5CxmvFh8+eoX40mvyCK/d9
   fZHnXlIUF8CwwqpjeJMxl59ih0A+w3inHt/pr/WiIaDgvRdArQwNKJehn
   w==;
X-CSE-ConnectionGUID: RAdVq84qQYGqjA4G8ZWwjg==
X-CSE-MsgGUID: 87sT5dg/SAiRnkz7jQQBIw==
X-IronPort-AV: E=Sophos;i="6.24,219,1774281600"; 
   d="scan'208";a="149628812"
Received: from mail-northcentralusazon11013062.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.62])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2026 05:30:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VP8MS0ZzNVR3v5qWJXV1nSKmfR3mihvj7Gw85EalVK4AE6clNvhyXjDr60KMX1icL82m8VdNWB82EIbKua8qWt7NAR2ZGkGpTuOVBEdzu7SAUCDqgscKAdsUfxh/9hxxhxxWadbP+AtVEQTCsE8Q9n+0yeZoHNSYB23a6GJkyXlPuj+3uJQrAKvQvDeZ4c2n2Wam5yUSYgNTwYOmKDKmMRzKe5blG9vakOT8p+9o78lvQvxza8X1dc1ubepdKNZ8UqzLmX2UZlcvXcZ8C8gip7B21EU1RX76TSURwKxt5rp1+e0sZbKraRaVwMx755XoYf06RMGsirpOuE9Y1XHyog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8H37FWV5u+MeRKkvSp6twOElGLn27eVRsoC7WAW3xJE=;
 b=l7GQrvb2okMMcEFQd11Zf75joo4qzSdnpYYkI5xf7fF/dZK2hmci+K4S5gqFKiE55kqxneq+IThqlsRfa8xbsLOervKjXZsQ99IS19Vtc/tRc81m8tuUBg67hPWoL4I5p4Ob+d60Kxpmn1Gn/aF7jbpSaqxKScAruM5rWqMlTtUuSpQgwYYGqnz7fUwyq7huWiAFGB2OvC5fju/UHxHjmV+ZjsDPFF6QmeDH1PQvuL3xnmgKNubAGV14ry/mjugIoC8bdKcXaI+Zl0TMDEIojMtlVvplvtY4Y0JN+gGppJvjLXtoDMW2okgpa3OmCPonuu1QugFKWz3PgGaIJrj8Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8H37FWV5u+MeRKkvSp6twOElGLn27eVRsoC7WAW3xJE=;
 b=jmxqB7+GdsYUoYJ1Tw3ZPzG/oK9RZzvMGIV5VnSr8/8Wfc+bv7qCBya+FDw/ifffYbtwmMl6YS3c0mch7JvBle/nWuBB1AprMIcYqGODAeVqhtOA4MB5f4a/cIOOlJs4j92Nd+2w1rOYpigJUHAu5i/KJey8Dk2YZ2HfoIDyPUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SJ2PR04MB9022.namprd04.prod.outlook.com
 (2603:10b6:a03:53e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Mon, 22 Jun
 2026 21:30:40 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 21:30:38 +0000
Date: Tue, 23 Jun 2026 06:30:32 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Cc: linux-block@vger.kernel.org, 
	Sebastian Chlad <sebastian.chlad@suse.com>, alan.adamson@oracle.com
Subject: Re: [PATCH blktests] scsi/009: fix unset bytes_to_write in TEST 8
Message-ID: <ajmpaXaaz8zsyFyJ@shinmob>
References: <20260614181651.11554-2-sebastian.chlad@suse.com>
 <ajIhtkOIMXeM6BAI@shinmob>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajIhtkOIMXeM6BAI@shinmob>
X-ClientProxiedBy: TYCP286CA0156.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::20) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SJ2PR04MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: eff67fbb-e04f-4196-6786-08ded0a580be
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|19092799006|1800799024|18002099003|22082099003|4143699003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	i4lq7YiO7W6+zIUtbZa164HKfel/KjiUIkGEChr3XekA3aqH/LRSENTjs8VvhtuMWLRgCSVYlZ27es3HmH7g2D51aqty5/tUWYh0DdJKXd/Plm3OggUc/ljLaRA+vc4Eu4lWd+MDWqd1stosxPgEJif6UoOws4C4LcAcj0V6k+qsO81DzyQoVP6ioGFkpz86ZBv4ZQ35+rA2s88dWvIhzftyR439OxZebNbbsSuuExef92Lo1tWmsJlNfy//w5g3XSzy77zIIEisb+eKRBb/fKR6uIjCqS8pT3HokIA+X+az784HpP9V0/eKomWHcqAwMqGcUqghIh6RvD8m6WqOsz4wVpebtqU1N+WM7KmUsC/77yEIpcSXgKpBsHqk+8TbpQHY60Yp6NX7VFWYbvg9duxzQbw0ok1aaL2n/ccjSdqwjg2WTVz60E/zc6VL1RIu9Jdp0kLOOPaKgb/sH+vLiF11ezcjWIJ+jGhGjMllXQGp+zaznTnSPgTZM8wLh2qoh/jM1zQz/PFnxlWPl4rTPvg1dyPwzOGgYTt5XKt3DLSdAQLXwD00rXFC2MNPc2+krQdzDgKqTk1ykrjsH61Oph2OpAX3kvH+CLV9seDYLoc3YIiVmEydEkpj9+zdd1C3wGYtXZFIe9nS6YsxMAA0ssvJF42lICQ4VVBSJiT94wg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(19092799006)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dWKG+9sIOAFBEm/VrAzEXKE89/CYu0k3Hra2+9QGL68aSYB1sKJgBjOJI1GZ?=
 =?us-ascii?Q?N5PvWY/6CmF4wyk6JFGfEg2BFQRRLkx3S0mvr5YctFTQtqPST3EP59S5xCS/?=
 =?us-ascii?Q?RSWW0e01k0bfY2kl0luzZl2JRvSpqgqQVKo//0DadX+4uxJLX07252LnRalo?=
 =?us-ascii?Q?zNYUpj0gaJvjNuj0S3y3ECW5vh92+a1pmJAWZieaE0nwTYs0rqibeNN971Xx?=
 =?us-ascii?Q?CDqx7MClQL4Ewu8hqvsfWKE4JH+hST/9zaXR+hJw16SzrAWknp3yHB7KuQmV?=
 =?us-ascii?Q?Vu5wUsn7YH9hfd8zOGtrWjXnSWIIloC8F5AxL/cBGjQkZJjzAu5ahOd/M24f?=
 =?us-ascii?Q?Cox0Y6/0V60HSehuswf2khONkL5MalbTmU16ox4NCG8f1xBrayqqxyCMTT07?=
 =?us-ascii?Q?9bdz63JQpEajXOePTPolqYrgKq7omjkil2Rw7oD3hKUuGKnYUJs4E067xagV?=
 =?us-ascii?Q?Vizh/9BDcnYyt/yML+aCpAgpkcHPkJYILw4U1lCJIeA/Tr4o/7Xu+PX/IUgJ?=
 =?us-ascii?Q?NqqLBAr4jqMqly3zaXufVESqFzKPAedAvKlLXd31wR6IdimYb9HJE0mst5E1?=
 =?us-ascii?Q?PyDJCH6t14HFdsc0O47j5X7MIA4J6igro33HgCvNhC/DJhbxM47OSAGhOFmT?=
 =?us-ascii?Q?oONUJzFbXD/KfQIjL7nWnEqw5IWAgSEaUK//Zg5EZQSMFigA3L43guQ0CGNm?=
 =?us-ascii?Q?DJGvWhw+DZOmT5Ae0cLXkUXmcL2FR/KScGvmbU39DdBnYAxedjJD+xCG/pLm?=
 =?us-ascii?Q?AQVQVCyblvUu+wxNut2pzT2kadX/u74TnPOSdmOs8jxRmZIydq4X6XsGDH8f?=
 =?us-ascii?Q?o66xRizAiFWP7WNb0vydRU6enzbVCxWm9Qx7l94IpE7YRD0RXomZqKp4kSUx?=
 =?us-ascii?Q?i/O6Z1I44OG4hwk+o67ujpqfGP1VxbNrPh+kuI3Qc8NGcPKGGMNHMkHgbzha?=
 =?us-ascii?Q?1zP7Su/zdlruR7yYyiSpwRdPTwZcjvs/HrmAbLPG410Lzj92xFil5VQAxXqJ?=
 =?us-ascii?Q?l9JpV2sZ7DIgap3t24tREnTbHYN9UxsskNRnQi9hrA67u9Uu9qlu6D1x/l/A?=
 =?us-ascii?Q?7+O/VFUws5EX+33wBgoB5H73wxkp6OtOavD5K2hF6zAdIMCtEDxKw0zNk+9L?=
 =?us-ascii?Q?qpJa34z9r8YzuLnDWO2mqy19meN4GAKF7AnxcPiYNCKQZEEfmQBWQnVOHJDO?=
 =?us-ascii?Q?MYC9vAk1NsBQZLG0G8T/5HawUZR0zMTnjeHemDJ0PLQtX7cc5Pwo2zXcMuNp?=
 =?us-ascii?Q?1fUedDQDEtdr6aOZu3H6SrCtvcjiazfrG6+SAxVlbn/56rSG9Egml4pqOnFx?=
 =?us-ascii?Q?2aqnF8jPwNfnUgRa9L5tEXPdLGIaohzcY77jAJR+AvI+GAkrzKIqxV8kmZqB?=
 =?us-ascii?Q?SFKqOl79fVFjjK2og63Sj3YC41nxGAfIetkAyxB/oTHo9X+DxSnHldPYrFcQ?=
 =?us-ascii?Q?0e+sw9iKZzuhEJXb19zW7qGTCd1mEQRB9zPSlIlPmpSGXoOWcJhbStUSgs+E?=
 =?us-ascii?Q?/Z0MgEoAXMNLbi4EiKYu6MAh0d0DcUEdg/4oHMU02i98dgwP4NZIY1bArl2b?=
 =?us-ascii?Q?4Q7H2INyTdZgLpW/94JrHsfqmYLiSRCKCrPPjO4ue3OsVEj2lPft7elw+GBg?=
 =?us-ascii?Q?2xgPIy2v1u3RUlTjR6lZHOkejx1nT7hAIBG6CM1I24QMx6pzqQrl2NJyU1rm?=
 =?us-ascii?Q?D3Dl+C/sGbsY2kXXCIt3DP2C/biLff0/IbtqQ4p6NtLIA0r8xB1BO/gVy1Wq?=
 =?us-ascii?Q?0gUMB0PNCyKf+bKn3uu4qvfTmdb7UC0=3D?=
X-Exchange-RoutingPolicyChecked:
	Dc9tfz/PqRE/3ehx58FczsehGTMgIFtHLMeZVLSVYAqZLhbOi7F3gv/pxKgvlt3KaQ+gv36+oPZ76BZeLZt4QZ/ZH8Xe0EnRDY5rPlxss7eBXBkLdYlIQCdk0zmq1MTTu7g5VsyihPkvTOyNoWPsM0CL1tA6sY50wOTqV2mCLGrk3Yry0LQYPU6Xy/I+ppUbI3XILwKb91m+sreQcKgIY+hetJZSeHQs+NPHZgp2xh9+A7xEh7q5pL0QL5+mJls8Vt4LQPJWFeG9UEGJg889E0pRIqIumskFGksKlavWmPaEvyEiJElo+qmm5VExTAYCUh+QiWtdZL3y+GaAIviw2A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jhtd/vLTBZmc7YaMhwFAK1G60YIZUH0CAVd7dYH9fFLYr8tQ/17vCsGVZdq7RkuFm7SSutY1ghmAszEIMaVhad1FVvUixlQf1XnAc6JSbZxcaN/R+h9qe7YDcx9gbLvJkrrC7W9gGASYbDlSfKBn4+vZSrEo4TV7/7pvj2xV6KaiVAF1MWgzkOSl7N6rzaNrAkAd7rQvNcakwL6mMHE4RY1Jt+0Omktb2lJtEz6jfCECRbzFxtrl7Si3IiCo3qcDsGhouoOI24huIkBDUOwLkBDMS6lFZKIw9MmMH/ojNN5Ksi2EcbV1TJ1MpmbNOdjAL6Uf02sL7MzXRPfmSAEFmHUmjQDZzrkCl6gXcuL6HZTQOIrrCZaNjHxshaoBIAZQ45WuFzgwKDDA0JmC7t8GMxiwn0nJcQ5v6512wMYMnZQnD3FJNuP2SC17NXWJ/Lophwv/9prn/iWiTGt7UtdSHW6GNRdgTXNLCKrrBwzk6sqF4WRehqQd78JUgwN74L3be3y0A1aVxMEzef0DMp+0jUHaQGdQFi+iXYxx/Yxfq4kPIuiiQsnfd+WHJyx1PLLrJeATphyQS9O/SfqPwmt9C81D1hNiR/EacCrcWpTNJvsuup+CE6dmGWYmVwLVT7Zx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff67fbb-e04f-4196-6786-08ded0a580be
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 21:30:38.2046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/jg/1o8/a3Yxf5IsQWwcbCYcTabnuIKdi3Ai24Da7aZ+9yuCQEy81r2xrrEetuaEJrnUTCVVRiZHaqHHq0XeUtlytLJjroJDe0HOXLiaf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB9022

On Jun 17, 2026 / 13:29, Shin'ichiro Kawasaki wrote:
> CC+ Alan,
> 
> On Jun 14, 2026 / 20:16, Sebastian Chlad wrote:
> > bytes_to_write was never assigned before TEST 8, causing it to pass for
> > the wrong reason. Set it to atomic_unit_max_bytes + logical_block_size
> > and update the golden output with the expected "pwrite: Invalid argument"
> > from xfs_io.
> > 
> > Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> 
> Thanks. The change looks good to me.
> 
> I will wait a few more days just in case anyone has opinion on the change.
> FYI: Sebastian posted a similar change for nvme/059 [*].
> 
> [*] https://github.com/linux-blktests/blktests/pull/245

I applied the patch. Thanks!
