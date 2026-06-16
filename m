Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B48264614
	for <linux-block@vger.kernel.org>; Tue, 16 Jun 2026 01:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781572878; cv=fail; b=qJgL/mypecb6M/cf6nVcsbsoKPhvTODrdrMecM7WThXfU8pFk0yGVgMXEuKXeL0JLL7P2olv5YC8qja/W+SE78C1TpCrSebIkjlaC6h18ykncWJSYXddquGNM7uyyeE/NZHpttJrtSWDMdEr6yaK5msuz8wHswGnfjvq64WOkIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781572878; c=relaxed/simple;
	bh=WB0g1EDQVh5JvyeCmNL+LUXqxAJiBjkAn4hy2slt/y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LbAnp1jN8XcvIcjAXwQF/Kn9mp6jJ/nIK/41hLawx2NdJPrDx6U6xESfeB9a64JntHpZHg310nvfYNCTPYqF3r+y8sUeyAJm0WXwFzgi1Nzaw5tSBgCtlBVON9XEvzWmOdiHrJF5i7OL5++VHDGK9e+V485EtTxkxxQDyfE4J5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=D6f0Om+7; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=uVi5NrqZ; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="D6f0Om+7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uVi5NrqZ"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1781572877; x=1813108877;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WB0g1EDQVh5JvyeCmNL+LUXqxAJiBjkAn4hy2slt/y0=;
  b=D6f0Om+7Wl69Y5D1STO4/XXJJNFUfY82HAW/fbalG0h29HKqz0J4QT9E
   SHkRuQyDNxqzCEpfk9OJtmddAjQALA693bC81LPLa6MWXsHg33NGoL0wY
   KN0sm+2eM9ZmtPSgtXBaNxTUtb/oB6TOMtrWDlvzlwZQc6HD84FYyX0Il
   GMk0tcXVFe08oJlvx2m9je93GbDxdXbyZOMj94lVZbx3khRk4hpKppDVa
   Ru+CoDLJ5WM7kOtDPWJm/NO4tomLqVJuiHIcG4mGf8gULL0fXuG6xxpFE
   ZeuQ79+3e6lepNND35HbeHGda8xMGqurZOqrkEyHarUMrCQ93scUe0VQ9
   g==;
X-CSE-ConnectionGUID: OFiAViCtRJygSPW+zxX5Xw==
X-CSE-MsgGUID: a3o7NLnnT7mPTrkuifWiVw==
X-IronPort-AV: E=Sophos;i="6.24,207,1774281600"; 
   d="scan'208";a="149204599"
Received: from mail-westusazon11012058.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.58])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2026 09:21:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXvMmxwy0XvbckMpU+q718EhmeiLlH0JpK2VWTpfUnoi/bblky6fahraMfVi2yhI+3GCZ7PRUJvlb4flTIe7hmFThGnTTKNiQoxQBniaX0arouOwYOShL5GcLVIkQBictwLTZ6ZjnhGtamFj08stN2HY4sbx8WoE5OpYZKr1xtUR/V1mp5IFpippHdUzV6ziharP7lAwzR8eF1JCX/bG8m3Od6iLaGF7I1+si058yuISuMBHUiVFZl5cLl5/o4r64EwFyEplVMnRK2lKZWFh49/Wqqas8bPk7ZsCbPrFPpChTBOPHEA7ew2yc7IglzWP3Oj/FQV2B9X+OgXVvkeaKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fn1sYw/QWiuRSRYilAYfl7F6DOJN6kuD1Uf+skjVL5o=;
 b=AVwg4CjcDXsOSeoOTm65GXHxK4Bz1AnHagkhd5LIyL01PHsfYT0Hhc0ZXZwraTYKUXGZI+j0ktf8ilDEZK9eNeQ0/lSnrOq9/DRZ4oWttakfg+LbT45esUwQuFvB9oXlZAaYGVhq/ptQ8YHnbyyfonlB0mNpskl8D8uzhzlR5VEndv5LdugzjUFjBj8H+DWfhbj0FGo5nsQU+nhBlucqdMkeOy2o7xDWwzysLOp6qoY7Y6lzaKa57MlEKkhI4swOGxv1neMVrQSErg6SFhsabiSZ/GTd+YwZwioJdMZ3mTUpsKmFVyyH/9zTpBqroXnhsgmux4vK9I0lxEEJounlQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fn1sYw/QWiuRSRYilAYfl7F6DOJN6kuD1Uf+skjVL5o=;
 b=uVi5NrqZDLzW0EyH9NkSmn62yAEu23LNSLNXGDsS3i9Yoa8nP9c0VSat6l4Hh0hhnHI5dIRUwLbgz5ojPg8/TuKehVYUhIkCs/zxmO9c/cP81yW3uowaxePA+UrwDVIUrtvsEIRelxIlX7pvQzYT9YO0L9y/3TdpJEdq32YYq5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from DS3PR04MB10053.namprd04.prod.outlook.com (2603:10b6:8:38f::5)
 by BN0PR04MB8110.namprd04.prod.outlook.com (2603:10b6:408:15d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 01:21:05 +0000
Received: from DS3PR04MB10053.namprd04.prod.outlook.com
 ([fe80::faeb:7524:f842:9f3a]) by DS3PR04MB10053.namprd04.prod.outlook.com
 ([fe80::faeb:7524:f842:9f3a%7]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 01:21:05 +0000
Date: Tue, 16 Jun 2026 10:20:58 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Ming Lei <tom.leiming@gmail.com>, linux-block@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC 0/1] block: fix concurrent elevator change failure
Message-ID: <ajCa9GrGoB4uXRpS@shinmob>
References: <20260611074200.474676-1-shinichiro.kawasaki@wdc.com>
 <aiqaXfTqCLMu2DwF@fedora>
 <aivMxPCd305WbBsk@shinmob>
 <aivoHk4DE_pkKkDm@fedora>
 <3db036fe-747f-44eb-93c3-595350278297@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3db036fe-747f-44eb-93c3-595350278297@linux.ibm.com>
X-ClientProxiedBy: TYCP301CA0055.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::6) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR04MB10053:EE_|BN0PR04MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 629dfd21-9b6b-42fc-e324-08decb4588e7
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|23010399003|22082099003|18002099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	LfIfjIMYG7N/15SsKekdw0/kXqPtv4IA4xj9rrvUeGSSb5LUDaLCnYsoYySy5yngQWAMSd7LHw7MlrIQOR5fdit5Vqo9QUfPUofj4BBuyzf0/9MDtikh5S9hRQWOjI5FaDbDqZ1f3ftxupLjkj4ikjnuG5XWfpAt1YCxV+wsxIcNzvmdgebyTJ6odsyw3PFXYsxJsMPrv91N4JwigF+UPv/aDSTkeucqycLQmhFLvEJaBNFf6C3djxt7rz2dC1/cfeeNxWfi6FCVP5Sx2Qky3imz9sWXzg+2j88hut1Z+OB3GB9Xh1asD5+SJrS+cMEqKQZbHCjXR/xbPHl0skmQmEbpo5rUJm+XOGIV++PEcZJloGoUhaAib3VwkW68Weg7RX8iag4OYtTYIGg4Kz6EYNistVk+LM9gMxaXzWD0q1u1kOv7CkS7hFJzCo064fFc4cRH70WEGVPfvxDFMZxybhuhtowr38yDnLA7X+tdHhIMAdLRbsZvNsk2Rs63c2Smksa/0aeSigvaEfGsfETFJRTvCYR88Yi5CZUxeq3MylI8UrswtgQOgD12TQmMIw4k4BZYXRJR5penf/07FLOABFpwSRIIMO1n4lw54GouBoeyt77VmL85gHUoHP315lQmXqFLrCStWiUwkdXWEGcivxD4YJ22+UJvpGlg3eFU0FIyioXkzEYG6GpMeXV/QWqH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR04MB10053.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2MV1K/2RVLmi8QUd4scXjURmphal2LyPqy8nft28HxlFOZUN+PZI9JI6lp9k?=
 =?us-ascii?Q?J7/PrUFNjVcfgYqr7PoXRkQUAHnrtBgmaTFJBlTfxb4PQ8l844ayhGr63EOn?=
 =?us-ascii?Q?637KA34tGwfUPnb7mzLolq5diOsv6mvOVIxMBVArzk902KoeNBXdsbUT/Zp9?=
 =?us-ascii?Q?yr56X4+DLPQX0WBDmr95bcjStJ5cmpGDXOtfifoE0tGM0MovviF9srm7NdeI?=
 =?us-ascii?Q?WI2CoNvcJBRcgOfSKoHGieicknPhMiFk38NdTey4hgx85Wyg+KssoH4oLEdI?=
 =?us-ascii?Q?yCcjEw50fPlK8RV2rg16YqWGVN+gV5tXXcrB0BkI1wGV90tuvp9NQsWFg1hN?=
 =?us-ascii?Q?+kn1oeDhHvzixu2X37t0nFpaB4yfBO82I41IBj9I+AaO4v7hHZwpcSwOzogO?=
 =?us-ascii?Q?Tl065BBY7ogbHr8sKjk61mV2sA5x6dWjpbZoX8L3HdONt2uw1R8rF7RjUpI0?=
 =?us-ascii?Q?X4w89r7PX+MVlzcN1XG8hTQmxUVmT2u+S+x8NsDWM3/edPRI7+0sY9BZ+k6Q?=
 =?us-ascii?Q?jvOuTLo/NAQ0u437HNrMoiKpynfHn11RVjJs4qWA6Y2HS6gB4LXUK6fBICzJ?=
 =?us-ascii?Q?T7NiOPd25n5Ie2LRkBAEFr3HNmPOdsvsV1CQKznFukVJsd+ev80oVH2NeReP?=
 =?us-ascii?Q?x0f6sYVHW6NvuaADQzTCBZfLmE8exchNQ/jaOJVYy/nzGT8RfKKuDW5+Qdgl?=
 =?us-ascii?Q?ibyrArdT84f8UKWE5zuhbzcQbC+G2xtyTFmfuPNLwKV7miJkk/aQPMEHcnoi?=
 =?us-ascii?Q?wnfew47dQX/dJlkUQ6WTS5EaNAjpr2hILHzE0WxtqNFbgoghqzyPkBdxKzz4?=
 =?us-ascii?Q?LwsipALYlIuylha6LvJjHuMUktZt/Qu8IBHBzSJxB0WG/HFhvtW/ufmL5cVG?=
 =?us-ascii?Q?7QLKtMVd998JFF6h9yg0h8Vplfr1e5a8+EQOCb0ADDDqYGCDhb3Kz9EqAD7d?=
 =?us-ascii?Q?KCL/bNHg5a06q0uGJsLhTCO/hS1NJRylRVgwhvILz4A6RcoSY4W3mC4RicL0?=
 =?us-ascii?Q?Ej/QFUCuS8hjUXn5bg4S6TnqSmMEXgbZWd0KWEaZoMBx6CQ4LAak4eREnbq3?=
 =?us-ascii?Q?7IU6eznYHtEUVJP0ChlH52+ZNytK+bWifQMTxPKobu7RYBifqjUiZbuvqrAW?=
 =?us-ascii?Q?fQNqI3MgNBWKo1RaeBAHuLjZch5OpUKh5QCCL3cBYart0EVUmFLTxSdlBuc5?=
 =?us-ascii?Q?qNlPJYIBjxAVm+X6GgV9Kq+Hjx79e8kGGNlTrM5EqyA2gZluhFaaoNsuUh34?=
 =?us-ascii?Q?m3CllAL80DhFvUN/08eO4DdQ2fn/c2pAcUxaYp0yZE1aw05aV54+cYBKXLqf?=
 =?us-ascii?Q?dcl/a5M/z/T+sNfbhk872rsNIvgWCKiMD1cqF6+UjmqtzL0X8nF8jF/ndgeo?=
 =?us-ascii?Q?8GoGa8S/ENMsjgebD9ghcSdaYiXZT6/QWX7Zdu1vN4/KXF3qMuMzalgZY9vq?=
 =?us-ascii?Q?enO3Hhb32rrQGnm4X73Mk6KBEpSFZ3oS7zlE/LNRw8v3f786uSNODHB3CbpO?=
 =?us-ascii?Q?HrhdLnAbWl4Mmhpd/YjvZuEP+diLiH1KjTx4hp4IJTFyt5jza9nDaQ2BZYgY?=
 =?us-ascii?Q?eYIfxWOxxK7rzuFpSO8fYQILMJ7yH4vAFIoWNaVAq1zzClDgos4ZwYVZsZXj?=
 =?us-ascii?Q?KBkO24Im4glbZrYPqJsEyavYKvdjHjZdY90LdRT2v4Bvk3vIkcA85lVAmo0n?=
 =?us-ascii?Q?hVS3So0m7wpq+LGEPxmJ3KsTMDucSrTVyl4c6k8XSA4o3O0SvTClD0bkRUyG?=
 =?us-ascii?Q?ld6eVSb0uhL3IZv3eeoKqIyOZNy4Wyo=3D?=
X-Exchange-RoutingPolicyChecked:
	DO0laSKffh3OwDLAJQiOBiA8SmXuQB1Ct0MUUIQrf8CVec+6ANFa8XsK6zaiPIes/2GhuNXrRmtK9/gK9DjBBU5avbNt7jdhTE/egAUe7N+LT/gdpPosfb7fvtmNtx/3ZBBsdlmVdWJ1wC0d5YInh9f70LlUQR24XAnE1O2A4jtKTWQbzkOPYjRhgaMTCm31pp4iNSmv48z5VKz5MoaWE1qfyrumGg8Tt0IT5VUVsP4D/rfRQgx52/wOVKsM3Hc/gAase0U2x5zIooXV3zRIwhrQKEXFkghciZFDNo3UqC5ttZScm0ErYF4gqFFoFESRrhGm/hJlGPIpxQ4GUlPHyQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WsTz0rARUO+p8Kt/JfXqFh0LW3Zr0hyfaPMJNVNSHz6nDmDZ6CUIbon0meN1Le/xCX9NcpEZkhGy30G3YAzlbz6WYEbMxpdGnS9DvWFoGUs6T/G04lZWTG7Zr3RmFQOy7bPhG0howE9wpkXiMk7i4tA/sgmU83B1Q5LPNivrqlaZSZIz93B5ZLZdjUNdX6KkKquAXltoBpX1FW9aXzfIqEgS5g5raREjMnlbeY7Lo4IdmLVBCB2VuLLNsUdblpbjGBMHx2xt3Jjn7pailzVSOyXPPHxHOAkH3I8zvV66iaq1EaM0cD7rRUjrTUwOU3UqQZ4UmIgWMS2ZLW6HBnakidbYdZ4eegAJ9nBAfMEjlYdV3kg/Y4k766Xk4OxOOvBjPJq4wVmtBAfRgIm3tLwAtiyNRKKnnU60RlAjL6e3e2XpBMU380726SWBgzZH6jgnlNrkGmR//0m1rLeH69AVYD4rnV8BlRq5vXWXTkYdS5jr6wEOgF+vR7TCz/v3pvcIWC+rybzu9vRkN1l5sfX/WveMV3B3E3uBKEFq0+ozncoNo1bM3/ymhV4z+FZQREgOKMaE7C7P+JdPZBf7C9t51hI3zSxwdodQTb1omNPAEK/J53wVyJ/mUWs/LjXxfjVi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 629dfd21-9b6b-42fc-e324-08decb4588e7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 01:21:05.0205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qY01jbQyZ+qPF6dpQcJHMQOD2OJznfn01VK8e6lMCmoc028rGpKufK5jbAYvdQAtU5btXA92PrzuamngubuZQC+RQSw+JhkpIDYBjQhxbA0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8110

On Jun 12, 2026 / 17:15, Nilay Shroff wrote:
> On 6/12/26 4:36 PM, Ming Lei wrote:
> > On Fri, Jun 12, 2026 at 06:47:50PM +0900, Shin'ichiro Kawasaki wrote:
> > > On Jun 11, 2026 / 06:22, Ming Lei wrote:
> > > > Hi Shin'ichiro,
> > > 
> > > Hi Ming, thanks for the comments.
> > > 
> > > > 
> > > > On Thu, Jun 11, 2026 at 04:41:59PM +0900, Shin'ichiro Kawasaki wrote:
> > > > > I observed that the blktests test case block/005 hangs on a specific
> > > > > server hardware using a specific HDD as a block device. During the test
> > > > > case run, the kernel reported a KASAN null-ptr-deref (and other memory
> > > > > corruption symptoms) [2]. This failure looked sporadic and hardware-
> > > > > dependent.
> > > > > 
> > > > >  From the kernel message, I noticed that udev-worker wrote to the
> > > > > queue/scheduler sysfs attribute to change the IO scheduler, or elevator.
> > > > > The test case block/005 also wrote to the same sysfs attribute, which
> > > > 
> > > > sysfs write is supposed to be serialized...
> > > 
> > > I checked the sysfs write handler elv_iosched_store() in block/elevator.c.
> > > I found elevator_change() call is guarded with the rw_semaphore
> > > "set->update_nr_hwq_lock", but the guard is not the writer lock but the reader
> > > lock. This does not serialize the sysfs writes.
> > 
> > Please see kernfs_fop_write_iter(), in which mutex is held before calling
> > ->write().
> > 
> I think you're referring to @of->mutex here; however of->mutex is per struct
> kernfs_open_file, which is associated with an open instance of the sysfs file.
> The important point is that two separate opens can have different kernfs_open_file
> instances and therefore different mutexes. Thus, concurrent write to same sysfs
> attribute from two different processes may still be possible.

Thanks Nilay, I added debug prints to print @of->mutex address, and it observed
the address is different for each process and each file open. So, I don't think
sysfs write is serialized.

> 
> 
> > > 
> > > I tried the patch below to replace the reader lock with the writer lock. With
> > > a quick trial, it looks working. The kernel message is no longer observed and
> > > the new test case does not cause hangs. I will do further testing to confirm
> > > that this change does not trigger other new lockdep WARNs. Assuming it does not
> > > have such side effects, I hope this fix approach is acceptable. It doesn't add
> > > the new lock, so I think it's the better.
> > > 
> > > diff --git a/block/elevator.c b/block/elevator.c
> > > index 3bcd37c2aa34..b03185a217ff 100644
> > > --- a/block/elevator.c
> > > +++ b/block/elevator.c
> > > @@ -813,7 +813,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
> > >   	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
> > >   	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
> > >   	 */
> > > -	if (!down_read_trylock(&set->update_nr_hwq_lock)) {
> > > +	if (!down_write_trylock(&set->update_nr_hwq_lock)) {
> > >   		ret = -EBUSY;
> > >   		goto out;
> > >   	}
> > > @@ -824,7 +824,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
> > >   	} else {
> > >   		ret = -ENOENT;
> > >   	}
> > > -	up_read(&set->update_nr_hwq_lock);
> > > +	up_write(&set->update_nr_hwq_lock);
> > >   out:
> > >   	if (ctx.type)
> > > 
> > > [...]
> > > 
> > > > blk_mq_sched_reg_debugfs already includes debugfs lock, so I feel the proper
> > > > fix could be check & avoid the null-ptr-deref.
> > > 
> > > Actually, null-ptr-deref is one of the failure symptoms. KASAN slab-user-after
> > > free is also observed [3]. Then I'm guessing adding null checks may not be
> > > enough.
> > > 
> > > > Adding new lock should be the last straw usually, especially this one is
> > > > depended by queue freeze.
> > > 
> > > Got it, thanks.
> > > 
> > > 
> > > [3] KASAN slab-use-after-free
> > 
> > Then you need to figure out the exact slab type and check if the pointer is cleared
> > during free.
> > 
> > Anyway, there is guard already, not see reason to add new lock for covering
> > it.
> > 
> Regarding the observed failure, my understanding is that blk_mq_debugfs_register_sched()
> and blk_mq_debugfs_register_sched_hctx() access q->elevator without holding q->elevator_lock.
> If multiple scheduler update paths run concurrently, one path can replace and free the
> elevator while another path is still using it, which would explain the observed KASAN
> use-after-free and NULL pointer dereference reports.

I have the same view. I think the use-after-free and the null-ptr-deref indicate
that elevator_queue object address in q->elevator is the problem. The references
of the object is also kept in the struct elv_change_ctx as ctx->old and
ctx->new. These multiple references are used concurrently, then I'm not sure if
adding pointer clears and null checks would fix the problem.

> 
> With the proposed change, upgrading update_nr_hwq_lock from a reader lock to a writer
> lock in elv_iosched_store() would serialize concurrent scheduler updates and therefore
> prevent multiple elevator switch operations from running at the same time.
> 
> The another way to fix this might be to acquire q->elevator_lock in blk_mq_sched_reg_debugfs()
> and thus serialize access to q->elevator in blk_mq_debugfs_register_sched() and
> blk_mq_debugfs_register_sched_hctx().

Thanks for the idea. I tried the patch below [X], but it triggered WARN in
debugfs_create_files() in block/blk-mq-debufs.c [Y]. Then I'm afraid, this
approach does not look working.

At this moment, the writer lock in elv_iosched_store() looks like the solution
to me, but further comments on other solution possibility will be welcomed.


[X]

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 0a00f5a76f5a..12c582b6c713 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -394,9 +394,11 @@ void blk_mq_sched_reg_debugfs(struct request_queue *q)
 	unsigned long i;
 
 	memflags = blk_debugfs_lock(q);
+	mutex_lock(&q->elevator_lock);
 	blk_mq_debugfs_register_sched(q);
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_debugfs_register_sched_hctx(q, hctx);
+	mutex_unlock(&q->elevator_lock);
 	blk_debugfs_unlock(q, memflags);
 }
 

[Y]

 612 static void debugfs_create_files(struct request_queue *q, struct dentry *parent,|
 613                                  void *data,                                    |
 614                                  const struct blk_mq_debugfs_attr *attr)        |
 615 {                                                                               |
 616         lockdep_assert_held(&q->debugfs_mutex);                                 |
 617         /*                                                                      |
 618          * debugfs_mutex should not be nested under other locks that can be     |
 619          * grabbed while queue is frozen.                                       |
 620          */                                                                     |
 621         lockdep_assert_not_held(&q->elevator_lock);                             | <----
 622         lockdep_assert_not_held(&q->rq_qos_mutex);                              |
 623                                                                                 |

