Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA3F1E0495;
	Tue,  8 Oct 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728401231; cv=fail; b=IgHHQIXxHSnqQpvhNgB5AXsVznTSXtlUhkfMNMLCZad8lUXVs9WiizIlbOLfq55rAJvo1RBijvaX13ZYwZPX/rjF4FXO28ZcEy3+OkR/oIKImS7j/HPWw51PIOtxevR4IVV9hyF+FgSwK49Srmidss/oliROuRHsbuDiw0+ScC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728401231; c=relaxed/simple;
	bh=Q0RllmXIFH3BVaZVRoCa3I7p5eoejR5FwBCixd2YUmg=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=exZpqMLt1faT2FtIHGm8vR+uy/pFXuknvhlH/10+wC0omb9Jovlndd0S5xcuvnF0qzUsRvYY6uuThEzD3MOf0gH+RunD/SsnPnOFgsvBHwzyppaFr8ErtfwhQYCM6jxchwbAo5V2BiaiCaTLQSL4laBhrzg6A6DveZSFyTP9xp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K+HjFVBD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q2erR8Mv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K+HjFVBD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q2erR8Mv"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498DtcA1010925;
	Tue, 8 Oct 2024 15:26:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=88MYgvLeI4crMW74gK
	k6POVWjN9dUnEcONWZNJM0nyE=; b=K+HjFVBDWM0rInOWYVBOPqf7Gmkz5AIMTS
	9l2ak27gP3W8eSuHello9Ek0rnGz0NpUhg0nNYC83nhsyOMBOw6HqW7PVeblCNAW
	N6ILU05iGf2X50aDPlmRhSvQyaJAO7n8zYKXNA3SiAdSFsxumh7UB5oYxl38RmHL
	t/dMlxhKOu7epN8TTAvvpsg+gFXSrItFuZ3g7M80Mr2Rm2W6Ix2cfXtmxIf3EBCb
	ZSiIAR0AC1RuQZjF1qfn6iNhlKI2LWPLsHPRmBOvKFRK3QQeQkQ4Wd9zuuwj4yQW
	1d/PCOQBYrkXydvvOffvshqhU9rZXvi+9rqUd2UeiWbtiEAcaDDA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dp43e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 15:26:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498FF8LG003132;
	Tue, 8 Oct 2024 15:26:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwdm74e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 15:26:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVMXazvvRBDoRrs84eHttLxEFhlEzZQ6atUGipsQS8ZH+ZYApwUg3GstIzOOT1mWrOYjjPn/mp4LKZg+tJIYvKn70gM6BvlDxnS8dzPQJx8XH8ow8DNtdHS9SC7LOYs+ONwiGcLZCt2YyNXcKhgFM/4gGGZJ99Uh1awe+Zea2gwceXTxylOlALrfM/DC/Cu+uWiDk4o8ekKqRj9y2JqiDVJOeamu6mSrsz9r+tOaML0bOOOnappdYvYNz9ic+m1zzlhMdGpBGuwzge0PifW/m7xlY4/G9kqEeZPgyev+k236n2LcMMsQTA6BdsFCfT1/t/MCAzV1bZy10WFiBFcNaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88MYgvLeI4crMW74gKk6POVWjN9dUnEcONWZNJM0nyE=;
 b=gHT3OwocAjFhIvqbBt+qtx+6Wq67dROchayi2uiHBSdrRBsBImYpa+JzX7DBXnCGMsXmkJ61PGgZSgXb/i4jEJD0Jqb7m9kVoV4XrKMK9asAFLCm1Ys4avRzlZ4YFRVsT2NlzbjHKzTef72ZaND9N9GEUmXglR0LC85PkilYUls8qi9i6bBarIOEOmCzHQE/0VfAfeazlFdI57ik5pzrVyHoI+0XRlo4PXSoKMaQqq3ahwNVzsK/7a73jfJNBTIMeAyL8XoLM8E8Yoi4SpkzwGaApNlGJLFpVRHWkjosA6cC/aPxMJrOoPpYWFIxQD//1uBZx3HMAFPQQaymzmVGbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88MYgvLeI4crMW74gKk6POVWjN9dUnEcONWZNJM0nyE=;
 b=Q2erR8MvVdcPNbeDKMHtz0VoI+51mBD4FbG6mfK+VGr2qkFeqB4j9TOgNLlcTkY/M5i9M5Vo9SN5cC4NGuoNRJhinmamRZpicaFH9UbMsvC/lJt+Gciz4JmY4raBNdVim2SDppxz8Jskn8pmqK6yhzWaTha9d9Ni0+usYC4wCSA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CO1PR10MB4786.namprd10.prod.outlook.com (2603:10b6:303:6d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 15:26:46 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 15:26:43 +0000
To: Matias =?utf-8?Q?Bj=C3=B8rling?= <m@bjorling.me>
Cc: kbusch@kernel.org, hch@lst.de, dlemoal@kernel.org, cassel@kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matias =?utf-8?Q?Bj=C3=B8rling?=
 <matias.bjorling@wdc.com>
Subject: Re: [PATCH 0/2] nvme: add rotational support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20241008145503.987195-1-m@bjorling.me> ("Matias =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B8rling=22's?=
	message of "Tue, 8 Oct 2024 16:55:01 +0200")
Organization: Oracle Corporation
Message-ID: <yq1zfnewrfq.fsf@ca-mkp.ca.oracle.com>
References: <20241008145503.987195-1-m@bjorling.me>
Date: Tue, 08 Oct 2024 11:26:41 -0400
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:408:f8::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CO1PR10MB4786:EE_
X-MS-Office365-Filtering-Correlation-Id: a92a7f89-10b2-4f5d-8bf6-08dce7ad9d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DNQTeDBvN8CDEAqjISrmk8T/ng7OMrmKG6rumGO3jY45LakM7yNIc7SAlPBi?=
 =?us-ascii?Q?sYvqWZBqN8woyntu3xDHDQLqLYn8O9uITwzfDa82CQyOQwZM07/ZaRpJ4kCO?=
 =?us-ascii?Q?GKHFZLoNNsFj6FMLdmNI1eg1bLngBi1muE4ACQ0iWts6QztX8jy4Ycw/z0x9?=
 =?us-ascii?Q?hH5lipC0Sw4B/y/bNZ2gSIT1PCM0GBvgYYyc8LwGXoCimSg9mIcMpd4aFSJg?=
 =?us-ascii?Q?G4is2r+ENVzFFQVWmoXZ0Rgs9TJXNBFkzzOlFArv9tdUGzMD//3Q/e19dio4?=
 =?us-ascii?Q?artE4SXcTpuOWvFqoKatlKXoCO2kk4XZJBX7rwBauXHpVjRDBFAc40MXUgU7?=
 =?us-ascii?Q?3FslX9/FWR/1o7OCRC6xKe/f5ld3L0c3nZKK7LMAymZ8pgPbYUFseQUj06lQ?=
 =?us-ascii?Q?UtFd/NKoQXhQKILWFPHHQ+AtOHuwF7GUMxxxH1nuqck/MtVZQ+Llf9bcZfzz?=
 =?us-ascii?Q?CHYkNQROVm/QQEtNjXBlipAegVfsX7T298O1V2H1P8imLOGSFOfKJ5JeqgUe?=
 =?us-ascii?Q?TBH8UMYzsFTUxh71br2y16zWdXkqFiIsiWAWYtpcqwe/Y1Yh1k90o9UEq5TE?=
 =?us-ascii?Q?IotKmU6hezepg7827MvkncLF4G+3KWJx5iI2XoZsidi/c1DYq0WaB1IfnlR+?=
 =?us-ascii?Q?ocSd0GQMs2gI9KFcRvvDJei8L/fSOT8RsClmXaNnujStFQIaZCvFNb/h479e?=
 =?us-ascii?Q?4SgqJHA2h8/XkbeG8ODERtghbMIverLEv5EfPNKYI0qIzIT+VvazahOm3ZDH?=
 =?us-ascii?Q?3zRHnCizhKrMFX9Pys+e79/XeacTWEbC1KLmuZBdWidwPOpiyw4dleOQCsg8?=
 =?us-ascii?Q?fNqAxSy6MEtlvrMZx1QbabaAhlqj8MfN6R92hqgBBioGhKpKvximWVNeF9Ew?=
 =?us-ascii?Q?fEJ1w0yusqumVv33rE67ydObQn0orGVRmviLN0Id2b9NIjjp094o9BqRKpqL?=
 =?us-ascii?Q?IJZtNXLTEygE9fEQVbPf72cstOZB3xpCMGDvSFdgojUvj9kHlUUhW3MLY8Lg?=
 =?us-ascii?Q?amg2qemXyFOPex+XF4L32fWeWKvrLJoFW2i220ecYytKZ1qGiPuDBbOEGr6t?=
 =?us-ascii?Q?CmbRTX/VSS1gqsXpLwqrEqB9JltneqHKwOSBTb9G5wwEGlGH2FVpOPOq7I1d?=
 =?us-ascii?Q?GzYQ7r3H3hfSCWVktK8csJjoyWtGUMFMsrBeSmRNAhg0glsjT3Dp0CkTCno8?=
 =?us-ascii?Q?L7r4YHzLbizrvRlL9oUNQLBQZAPdmczFddA3CMPzTvV0YISI7ckEP7R0v1rB?=
 =?us-ascii?Q?/uueGzHte7yrOAkUo9bAVfF3j9qI817t/cB54ZAgzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9hr0eZIQJWgiKgBhUnVjQutr31fUdwQBbpej8DvXEh/FPJ+IQrM2WmhfXr3q?=
 =?us-ascii?Q?QGmfHz4EC26fuvnNp0Oq4RxiLlvrU3PWvOQVYIQkbeA+rCtKjzrUlilHwlvA?=
 =?us-ascii?Q?0DPWDw0EoWF4UVukX8b3Dtr72+jkfnGrUSHVYV1P0GM10fCUQHf9DrWxQwV7?=
 =?us-ascii?Q?QBoXW/tpL6JwSv/j88BpCH47fkeogYIu/GzSOAfHQ7sp3Ok3r6qaIPn93wpj?=
 =?us-ascii?Q?f0aDQLPmTF1KCX73ya3GGWEnLt3QbK3M9dJSlGDtDrzdVCD1gJQkuDGBIK4q?=
 =?us-ascii?Q?WHStRr0rfrztz6RlQOZEckwPgkZtWR8t1kfXjNiM9MUptziycjOAAAsRZ1eO?=
 =?us-ascii?Q?URaKCJbBAoueLU5c9P1BdoZCWCN8upBI230utlknrrQBlkUhtalBc84p7luM?=
 =?us-ascii?Q?hRj0gTIxV/ulYMqu2+tX2GL/zt4oouiJ61SWB3ba2acXpS1CSCauNC34UPkp?=
 =?us-ascii?Q?9v/05xB6SRJLH22oUGirrV22OpJJK4psoR3a1mBljwDceSKIHGTrVt8pvvue?=
 =?us-ascii?Q?8p4z1YZimfxhWUoQS+HnyFWPFsFh8ptsIJsD9db95D5Y4DCVmJnlOvlG//aH?=
 =?us-ascii?Q?4h+1cUD2BWvyec7JyWBKtAN6YEeAyg0hyi/JifaBDuRmvFJpCUBcIRU/B1Wg?=
 =?us-ascii?Q?hRa54j/trw5ZthUBGrX81DVQsygMqRyMXyltGgmACXB9xT0yLA/XufORRdcI?=
 =?us-ascii?Q?6NFzpOz7seRCjD6j5QtiagVk/A7Zxa4sAIPjyvSp4KprbZojaLrw9J9i5LZO?=
 =?us-ascii?Q?k7V0hiaMHCcijNPIZxLYMDju599hGUgxsQGQ8Vbea3tozZxaYdwlsj2ZcsFt?=
 =?us-ascii?Q?7KAopewl9+YIuunLtN1gkvFrwj+t7PRlSGj7jIFTvXfbGecnrUj85URVe5g1?=
 =?us-ascii?Q?Hq38E3e0SHVYcWcehBi4yKFvq2pmy9SUILvjvgPLrl5fgHAJJ4vrCzNB/CtY?=
 =?us-ascii?Q?C0ldTFHRBKb+DEu0DqBbgweN6Y0aBvq7fHCug+PrD6kBKxWZ90bRp1w+A0sd?=
 =?us-ascii?Q?BGKi9lN0mGwL8uYbMDSEs1vugRro07mpM+JSP9jgEIuFWc9Ma7ll8buh11XM?=
 =?us-ascii?Q?HguOLxqjv2uKz0tqfEacj8V4SQZr4wvd4hCmZ47lXm3Qbthvw2WmHvv6Zh5Z?=
 =?us-ascii?Q?3rlegE3qCNBEwJXe0qMcLrjNWQleIRyfatyZJf5bfkqc5zRlVRPwWAPfkLVS?=
 =?us-ascii?Q?BY1zWNm46mt3HTELjaFSa0e+wPQ80C4ZJjQ4lRgQ3YWHNyvQrIuh4O2WfcZb?=
 =?us-ascii?Q?NjJON9L47SRYmTA08ZRvKz8UOj3CXWab5fJmxEbPxEADB+LxXCCrDqqF5N18?=
 =?us-ascii?Q?am3rOdNp5Pn0pGRtc+3rNjdtP8EeJTIt9abAQ3q370qj1KV7ffKrujrGCzB1?=
 =?us-ascii?Q?nlMLsxGryf+fd0T2XyP7eH7TjUEnjSi0Pumg/tNE7L46hpWTbY5DeusJMCJA?=
 =?us-ascii?Q?RlbF5WQ8ENh88bcNgHXYU9oUp5b8RMEw8yqIuU9w3IUwvl9EAm5JOfijhVNB?=
 =?us-ascii?Q?7F1WL5v9FBWPKAsDKTLuOPiJn42jCyDpF3iTgn70ipiWPxLqRiRebhXz9ogA?=
 =?us-ascii?Q?7mWPcezQYkbb/27MB1w13PE951qGKXGZYCVCoebVcWDhaRLIvK3evHb9smSK?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fQx7yrJrVqZyrpk3D3elLgsOM2V941PRa9+Oa7fUWxs6eoBDeOSRWsvdxQWxZtlTjGZOEK7HkQirKz42xJoEHXFl2uQgRUUM24nVAfnIvaN2L4P5pablxt9iUihfH7dvtr2BPwg8+9S0mp0kGDEoSso80+HsC86ZQ7IvcbBTta2eCYaZDkNq3qcPdJcxR7DSmXVQfojbE7J+3opuGiO3X+9vIzfzM4ui998nSf/PErQvC1ZZUPMoWptnSmweYdlWk1OIkiHUvbEM5Hyrx0h74Axx3T77CfihkfFEcDP9GPL9c4nl/loYrbxFDHwhEDaU2GPUllo/DobFt4HRk7d+FrNzZXQIW0EfswxnNDdya2ttV11lelPJYLR1xRXFA4AszMvj90UJiAWmI+T2iTsRsytPHdn/VVPFGlRItsIE1woBfOx8E6ZwAMS8w4UuJb5s4OY+DTcvbogjtfiJT+us8lnGvfG1xfal38jIQt4JosN4lyWcxjf52Bd0GYTuWoOFYQROeYRoM364OUAHZHFy4m/xrc1vn2pEmol5bftfngyIzqoZAQ8k9hxk8Zp5N2AQbn2Ep7KTvToQ0zgBx5GWK9ODWqUVBhFyF4DNTPIVOIA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a92a7f89-10b2-4f5d-8bf6-08dce7ad9d64
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:26:43.6703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wW49o7bJxv6G17guJLaL5OOnTZNX6AIwTzGu4WHDdfAULSxIBEQS5wAQQOIUs4uumTRl9pun4yUQbJQOac05vWhtBaWHHaI4ID4x2iSu24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_13,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=918 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410080097
X-Proofpoint-ORIG-GUID: GmUAwcbifdS0y10wKygCUqpMlkRYlqkl
X-Proofpoint-GUID: GmUAwcbifdS0y10wKygCUqpMlkRYlqkl


Matias,

> Enable support for NVMe devices that identifies as rotational.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
