Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18AE390CB7
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792192658; cv=fail; b=JW+h5JRu9DtGHjhlbiIcZSaH9NqdixojmM8FT5CZcIS9kynGkwShDZ7va2ggWQmyEjExo5kXgSNbAvputEVwrblihvqV0/sa2uFX2j/4T+8OdrRvJVYFt7kzGaqPwmZd2bleIbvaI/UP7s3ceH6PkBkL8OiHidsA/G9t4lQggm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792192658; c=relaxed/simple;
	bh=Tw5PSoFzypL893jTy806wKZpqNePTa5d4u3Zh6PvpYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C9rErcB4mZ2ZjIEk+nkBxiu95Xt/CtEwT8oJO72Q+ZLE7Muqx6UH+h/9aJlIZEKUxakQi1nMSIQRJe8Eb/3d+YTV8uEv8fMGh+qXJBSk1aa6uUWXvxs3nIgrMzcWWUY2wTZ0s5o6rgJSBuR0le4sy8xfh9uJRVLgGYrcZQunFEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IGe+M+aU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=fqp3XOEw; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IGe+M+aU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="fqp3XOEw"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1792192663; x=1823728663;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Tw5PSoFzypL893jTy806wKZpqNePTa5d4u3Zh6PvpYY=;
  b=IGe+M+aUNBVoHNZUe5bIyWASNl6LumU/6OP/SFoa2XoQpD8FxjVDD6E9
   Byw8osjPEDfckFPxtHK0Xz7wMYyXdaUcjFQZeRJJLiTbR5ie4/dcJvXNi
   oAudv3tIqu4c2h9+0GPSIRUsJcJ4vB0/Anwaz5N4FfKxwxIbLqIpTKyWu
   yR+y+gpv35yofFr6ddnvGsCtlGeQTJcehkLZoe/MTXY96rV3CLpFLX124
   5bNrGzbpYrdx7umcOg0U3QBrXQCk5617opk9D5WfN6QwBiMjhzcbEQI74
   qwhtLq7APzj4Xcn4TxyxXLnM6DpuVYeV2ph8rnBYJ/ZGXWIGWIOnE0LGV
   Q==;
X-CSE-ConnectionGUID: DTA0CJ7zRsW6qdk9MOKcYw==
X-CSE-MsgGUID: sH2h/UmOTJuy17MgNWE+4w==
X-IronPort-AV: E=Sophos;i="6.27,162,1786982400"; 
   d="scan'208";a="158308066"
Received: from mail-westus3azon11010032.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.32])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Oct 2026 07:17:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W76bWySgVehR8SFSr1Lvy4EPIbUSnk9MKirQCB83J6t8SUTDSGcNIYcuP7354eXEaV2yyGEIr18XAuXZoAscJvc3WfwgajXYosZ7vU/1PgYR7/feWb4RovAzb/15y1GaVLFPY+TSBuUaxkTWDo7bCsdUqeh/AMp4ts6Vc7O/xgINbMv14gaZGm1HBE8EPaKLnnZwr1jGwXspmb0BLwiN5A1KXg9fj1MzbGOrjWSKEZGCY2tX8YvZpO4hRpTRTNmPAxr/lFdbMADxxcWjIFjcD4kSLWa6mqJPUqtxHhY1GrX+Vmyz6nrNHC3JyAa94rAFFFp9yL2M7oY7ejIUaWgr4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xNWlaElUy5UonIUDbrayFlUiy3HxgJuZsSr51U+Eh4=;
 b=LVHBVdZoa8JqLM2BkZMYQSujW5xIH32GD7Wlh19jubXMGHg/o7MyqQGTnEXPDd3rqEQmG89hYy951dUmtdsTtJy5/7Kjtgms9LQcDdgUTYHH2dku+ZHks9RVosB3wqTgr155fFQV2d95kTbVJVtehB4MmSGoKroPeK/z94yxLqWkpET0XmLA8uK1KCuRBjtirsPmgqsRsy9qq3k8BahAGd8p6E/C+L+MKv07WsuWvNtuZ/hdcilLURqVmhMv0Zj2/y+UM9CQgoSgiaMIcvsBxx9eC6vIYr5Mj0/mcK5onzH/ak3LpdnG/kl37fqax/hrXQrM1LXHdkywQQgIaxAQLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xNWlaElUy5UonIUDbrayFlUiy3HxgJuZsSr51U+Eh4=;
 b=fqp3XOEwKLdfJ71ccDGVYFA6gzo33u04j6XRCXuiB12CyuyR9+eQS5eIrG5vpmZJ24Tnvq14r4GWM2k78r7fjCbFV/1sdxqXTaVwgA8JwtKg4fLMwcM8n5wUbJHmkI7um7E6r/vaBylt5cOrH8n+soAi2QeOOyFBj5PENZmOLn4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by BN8PR04MB6404.namprd04.prod.outlook.com
 (2603:10b6:408:7d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 23:17:34 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0522.016; Fri, 16 Oct 2026
 23:17:34 +0000
Date: Sat, 17 Oct 2026 08:17:29 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: blktests-ci-bot@kernel.org
Subject: Re: [PATCH v2] lib/sbitmap: add KUnit test suite
Message-ID: <atKv-V5gYmiua2SG@shinmob>
References: <20261016073253.520971-1-szwyb123@gmail.com>
 <52bd3c015dd078eb947ffea0c9a3e6b0fd8c20593b5796cf30bcb8a4fed51a44@mailrelay.wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52bd3c015dd078eb947ffea0c9a3e6b0fd8c20593b5796cf30bcb8a4fed51a44@mailrelay.wdc.com>
X-ClientProxiedBy: TYCP286CA0258.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::6) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|BN8PR04MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fdffd1-faaf-4273-36e3-08df2bdba8c1
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|23010399003|56012099006|4143699003|11063799006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sNyUiyleLH+BQ1jEAXam2eXjOkviCrgQfntII9NHvahf44pI14mqTNuikITJ4EUf87NV3LIktE9JhGnhpN1n6N3H1m8woKY0lxBD5Ho388Ym+982ElDhWCfSyRIYRViv+7Q3PylRU5gQxIJ2vOWSFir325HQVrEYMvN7V8/1PfP61Tkd8OvO4F4k4x0Q3PBhsDCO7IEw6LDr5G2p4WUjgJ0Pf8Ec52BBl3kT4pzHJqLrlCPwdR6wGBgEycwG6JYTZYgf1k4TqIJ/FtA+keVYoOeSqoZ8wqAvwvWTed5H0D0K0Yw7D3pnxiOvg1eBqi0k2gyK/uiqoPBSD8vXS+eOWiWWCrA1bWIoeiLsJHST5rKtvAfg23+3m8NeviqAwi5CxsRGHpby5D2kd0gLNN4c0mIhYPVegS43YPfFJrNE/FFJpWR69B5CDyXq+9tIMLDaVzFCGS/0liyiTIR7G0nVRs2G0tYx8A/erPIBhsbBGDRFaMPgCWzzBSrJs5S065BVwlh2yMIhCUbnNwka09JvwP8HPbD1ceQV4Fp/V2LGP5KtBldmHhsUHz0COdZP+BL/jLAiksxWJiurlD+rhu+n/dzSovsasoUW8UZeB1I0sown424uBJldiE0FS9a0Kr5e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PY0DhWtU+4iAzuAQjmOn7oiVC9/lC/dNxdquKvaGmmnZZpN9+hq1cCPu4EBC?=
 =?us-ascii?Q?FwefzQLjjFlAWHN8y6lj0lGeGW/oW3wYPu+D6gzac3pd1tG3NRIj9FTfdk87?=
 =?us-ascii?Q?5+JRO1dTbOCG0lYDxLuMb26Gnbd2upNpSYQNP80CxB3M0/fyZdYsl1JPPO8E?=
 =?us-ascii?Q?nOpegz40e314HoeS/mJbEYa4s/29xlS5Qx7ouEhByR8Pvm2oSLsLBBiwnbbO?=
 =?us-ascii?Q?Gjf1O3hdGk8NxWLXJkNwK2isrOuMPtG4K9qaQ9JsCpD1UOc6CcIwUCwBbiOu?=
 =?us-ascii?Q?/gbNyyST8kppT/ikEsAaokOBPcJN8AysEiIJ0hubTbxsV1+3qmW7GQqO+CJ2?=
 =?us-ascii?Q?8s+N8pjSBv6Ppx8GqKQrszlhYujEyIA2HPg8zM5ve7z+BTh4ES7D1qjnUUuB?=
 =?us-ascii?Q?OUBY3D4s60474aBWpTsn3SNEjW5H4gJaWlKAKBiLkKjcOFwyTxB7qvCd+mGN?=
 =?us-ascii?Q?u1uGpuBTentoMUDp2Bc2n3IkOFQ/GaBepV6eY9WyAMnjZMOW4Ry8DJe0qQnL?=
 =?us-ascii?Q?8j49b0MBEgu3B4Yx53b42MUZmWFovce/IYdpEWL5O2tsCCTFPkWd4iH20iun?=
 =?us-ascii?Q?L//076ngAj21QzUdNBW8JxeahQ9txuiykOTGwRvs9f7pjL9c+YY6MP7x5uza?=
 =?us-ascii?Q?l9z+ZdMZoPuQhRM/sDkXNdEXSZvq9SJGe6eVvf9J0whSYGxKedpn0RagcgEJ?=
 =?us-ascii?Q?5i/puHA+JdwBe+uH0GKJeHTanCEmuIOqRtvXacN871oLd27whcukO3LhXLHJ?=
 =?us-ascii?Q?UAIZ4a3e5LIBMqLoOBYHdNq9G6mRo2Z5QEIPhGM30ZQh/+LhOtP4jkK8vjAS?=
 =?us-ascii?Q?sTR6xcxs4sgEanlJV78jHJetRVDTpcmS9N3t9fE+F0BJYJOCsaAt2mXHIkbN?=
 =?us-ascii?Q?IchjHF6d9qoZyDEeRdFXECqfW1VeI6QdzJrBtbnt9aOHj9vw/xwu/YNznqvY?=
 =?us-ascii?Q?UU2276phO2aAO519xDxILHMJ7tLyycfzwgPYCb+hQsZpv1NKu4k1xkMCqw00?=
 =?us-ascii?Q?xpXBaS2W3Iwvn2rgaJvrGuWiGtFOnB5fcwf7SU5qVuudQFCbIBejwVpVA8qf?=
 =?us-ascii?Q?tzcuE5z47idat6rvy6cLbnbWdaO9ta85AHWwuxL65VWwhyvU0HYOIK5/ySu9?=
 =?us-ascii?Q?vffr6pLnchdXebz7bgMY0XuwhfZGno09zkwqYcwA1d9lcMuaJgFeCSE6Mnan?=
 =?us-ascii?Q?Kh2YDFP8KQDp3RE1RyBchCx8LOe2DqV1p106AZHYuYvdjGP3GqllTQ4zZYkk?=
 =?us-ascii?Q?z/379L8mSM7TV0+cyh+GQB50Xdu+dO5OBiyPEIch5JHLkKf5vQ4VVt0ErPQ4?=
 =?us-ascii?Q?T3q6TBO5oPxAp0YBQyF8Z5V0PI+fOKJDO7pnqegOEouCxJQEy/VNJjn0/Sxm?=
 =?us-ascii?Q?ZLRDxbDqGftDj3D0xPsAhU86CqWHEabhpyHaVbCGk6JX1rkenwceWdIKwp/q?=
 =?us-ascii?Q?P6U/2sNTFagVp+Zusec2ZGsbPhdgeZqGPiC1uPsKqwyHCG1fP6uomJvcZAWX?=
 =?us-ascii?Q?ldZLwcKIrqg3U8maKDE1e7jCyYnZcLA5Y3EXzEY+MgxT7LdHWwQkYB5SSdu8?=
 =?us-ascii?Q?+aMALzNxiLrtiDFH7hxeCR/tk/myPl3RG3REO73yeXoLdIGNTt2NOXwtRWqO?=
 =?us-ascii?Q?qMU1FGkGcf4syNBZrq4hR9aVkff9N/Az4dlHN3rsFLmJFuge2lGNeH8Bjhi1?=
 =?us-ascii?Q?pJUdV6zojwAiRKhrCrag7wyxqQc4g8cjhzX4U5AcCh4OVBt+ukRmKXt16Bdc?=
 =?us-ascii?Q?5yQiDeD1gLd28rRdg2hiGdGX6Eo2NtA=3D?=
X-Exchange-RoutingPolicyChecked:
	hNstLS7NEWJkf+XdUktX3MeNtR5BymT3F06d6UgakNZZYYu7NpnyCQ96fd6NFlV2o+FCJhe32XQ++6lXvD0bXkRDX+1Y+Mch2waIANb4ip2xrq/VX4Yh8JkBjyjNDtG/E/88jTMLKXPhRevXzSHKu0QP/yI4OBdLVoOYWNXmfGUlfp9PV62F3Zxfgqi0wH+7vmXk/l8oMHo4zZa4h+aDn3plNMbC/Iyt3l5dfcmPXtd7Gg5c+pL3p2lSWbE5phaO0Mry+4kwrP3JhyJrDj7JVF6beRWT/qBMOOQJBbeSUC3EvuN5q3OQvFTP+hRg7z9IjuM9cm++1U26YMOrZE7/yw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lOM+bUGb4/0fPu9dpAuXbZp6ZyL0Rzq9tsiORrnyyXYsDPrn1S2OwLVbW7pfXX/nHLOmRMj+TzKYMytsr/8YQ3vetdvY+J/YMbdgzFCv7OJClx/2sr1s8ykABkSRjaPqiO5rAoGqFXaxuczKdyzjYnfernLQClmyQfLwNmblGlRC90t2UgHpXW4pcm1e3XH4T93bLensIUIiNVdOWaJRbVAMV7hl/7T90RqeSC88616i4tAtCdrTHC0hQ+kD0uHwI80jOmYHmxMgK5cxc1CAId21GdpeqdY+5ZeAnuErG6ppefIjrYFBzFsf8snWfgjaVkwAPr+Qr3pbOWKRmlK3OD2dpV6P/0s0uX0ZDjdv8L0m6LHI7RUa32UZ+ZiDEWy/GObGUPj31Ntm/N0JRfPZUy7A2SZpilFiRkefG7DTZcQPQNY9/08xyKA3+IG8LlxMuodvHFtm7NnoQBDsDZzcAsv0a0lrQagb0EoGwfIwuyEONYJCs5C0Upz2de34PZooXLyTiMGvcA1/+V3qIK7gT6/AwJoY+6oBcu7XRJXkBPvgGqW02TjMNfkrD1Isg6qdfeMQbh0iY0C8d2mLDULP+jgPZsgiYsHPXa6FqgOP+lMJPR5YXeZYWQ3wxgd+3n0N
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fdffd1-faaf-4273-36e3-08df2bdba8c1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 23:17:33.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KA9mzRv1OwDf219UJLhat5etrm31ev9uy7N2JiIfql1MPOIrXsAtBsyw9n36INFX2HxS5l1nkAm0vF2Qyv7FeQIATNO83a9ZY5Ryy6/zDxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6404

On Oct 16, 2026 / 09:22, shinichiro.kawasaki@wdc.com wrote:
> Dear patch submitter,
> 
> Blktests CI has tested the following submission:
> Status:     FAILURE
> Name:       [v2] lib/sbitmap: add KUnit test suite
> Patchwork:  https://patchwork.kernel.org/series/1187055/&state=*
> Run record: https://github.com/linux-blktests/linux-block/actions/runs/38868812396
> 
> 
> Failed test cases: block/017

Please ignore this failure report. I took a look in the test case, but it has no
relation with the patch. The test case measures null_blk I/O performance to
judge pass/fail, and when an exceptional number is measured, the test case can
report false-positive failure, probably. Sorry for the noise.
