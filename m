Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A25EAD27
	for <linux-block@vger.kernel.org>; Tue, 12 Mar 2024 02:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710212000; cv=fail; b=b310hEpKBgndtRF44g7Q0GN8Hx0mSLFN1oNvN0VU+vz7L5jfwxP8tr4Csnaz/j2ChOK56nOfoHTYqjtPYJyzFjLHT8h16HNnLdxjOQtHV5vM6H0VglFIbWoRRk9yZuK64gP0xqH44S2/vWmMACw+0caLv4L26Z+Iv/T0D+IQVxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710212000; c=relaxed/simple;
	bh=BsjVuiYnvM9qibs8PgRPyWluZG1YBkwj7rNVQ8/xBAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uvUMuNVD9XNODB4G4fEIJW9ed07gQ+tjMd0b1G87IBQSihFA7hjAQ+58Qs6yPAatL3eFSmVzcbjbJIiHevxg5ylN5cl1ILmgyV6CW5k4EV+mZ7/kWnbrewtB5kLEF6iJbueY7D51j9gX4Q1fdB17EBvYWX1GFxCCsiuamxji6ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=a20cFKxS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IADQTBPU; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a20cFKxS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IADQTBPU"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1710211998; x=1741747998;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BsjVuiYnvM9qibs8PgRPyWluZG1YBkwj7rNVQ8/xBAs=;
  b=a20cFKxSAhvHdhUOluq8hgv1Gwiv1bCOSEFHzQ04PJQQ1s3L1tC80bjH
   ENvQX9o/Sx5KBOrD780bOv2dj2LTftmCOlvjOMVlnUVwGXliXXlqQ8vk5
   scPu3a9B0uJFzubdyD6EgZwmDdNd/T2UhvodRsSysCADVFHJo6q4JQmSA
   5c2GCIdRzsVwICNy3V+uoL3RZ+00b+nF713By2y5LnVN7hhxcmH9iYbmV
   6zNEMMdd5DcQ1or7pjSjpPvmZ1JxmKEz71N71iK5eJKzqUI+AfyRxOTLr
   lJHHcCswmiHpa/A4rbhlFwoGyogoete5n9R5CbRjdzYcwfmFnSbUkYwiG
   w==;
X-CSE-ConnectionGUID: Q4hGC73yTLa21NT9om2TlQ==
X-CSE-MsgGUID: QOE8LV3aRWy9OfECFB3qDQ==
X-IronPort-AV: E=Sophos;i="6.07,118,1708358400"; 
   d="scan'208";a="11195765"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2024 10:52:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBfK5l90dhUrU5W8IOLhmiaCwjTS+45j651DsQzMre/LxqvhY9U1MAn/k7ZoVjQw2ETcTF4uGnWOJWG8vGrDxSUmIWHCEEgRBFlxodOFHa4Z5LGjSYL805XuRhO3xUG4Dd1jHs1dX5sH0o+wPVHV8SK9ZFAZ7L/ihOPZNA1WiwTWor/LN9qjjh+aLWapqXKikkBJAGiWUns0/MrerGb4udEqXcwEzoQ3fTyRQ3to1h2me1H0heEo4Q4hyQTbn1Agjc1dgFKBbFndWIS6acPQhGTIWB4EgiswGKrJJ9Q9Jr2CeJWXOIKv0q77oKFQd/DVQlQ6Vs60GM2U7n6aZGTKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BsjVuiYnvM9qibs8PgRPyWluZG1YBkwj7rNVQ8/xBAs=;
 b=k0CZmSqrTan1ZWEYpY/DEjjJRzA7PiY76J8HZ6tcTYxJpGze9TNL7XPb/yX6tSxMNS8gcE8GUvCzmj/6uApjSlV3aN0SKRu+BM9QHNtJotCJaRE6LRwve8YpKiqHXxUSVNQDzQTDk1KEv8CUgLiCCWWaV/FE1eoYk12hLM/H9vaFYJBz+dxYobl3mpdwVzCUHzx1KHMnFg3y6c4rj2tP7Q8c60SInv+VbtgUFp3gy0GFQJ+mKlV8dGjSkef2RbnuTijHoF7bQLhzId/7ju1pVzI14TTtXUN8bJmEFjqg2suD+nye+JvWVzJW4syoDFCu5Vadx8cgXHRJc7Wk/cHDcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BsjVuiYnvM9qibs8PgRPyWluZG1YBkwj7rNVQ8/xBAs=;
 b=IADQTBPUlAr6MkOouB9964wDrcMC9K1JkWG5A4TRFubTchvNwATfCQzp5zlyBj74xpfp2Ekgdon/hXpST53H2q2/ihQkyzrijx+CLIDCIsRV40UUCMcldHi+n+ztpEwE3GkTrFzXhuTa+PUJoAaps0qBWHgUtKiqfLNOCaSdsWI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7155.namprd04.prod.outlook.com (2603:10b6:303:79::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Tue, 12 Mar 2024 02:52:05 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 02:52:04 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, linux-block
	<linux-block@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
	"chao@kernel.org" <chao@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [bug report]WARNING: CPU: 22 PID: 44011 at fs/iomap/iter.c:51
 iomap_iter+0x32b observed with blktests zbd/010
Thread-Topic: [bug report]WARNING: CPU: 22 PID: 44011 at fs/iomap/iter.c:51
 iomap_iter+0x32b observed with blktests zbd/010
Thread-Index: AQHaYovQw4Cp4i7GhUK8xyPo7C3fjLEfp86AgAAQ4ICAAtxGAIAQ9nqA
Date: Tue, 12 Mar 2024 02:52:04 +0000
Message-ID: <msec3wnqtvlsnfsw34uyrircyco3j3y7yb4gj75ofz5gnn57mg@qzcq5eumjwy5>
References:
 <CAHj4cs-kfojYC9i0G73PRkYzcxCTex=-vugRFeP40g_URGvnfQ@mail.gmail.com>
 <esesb6dg5omj7e5sdnltnapuuzgmbdfmezcz6owsx2waqayc5q@36yhz4dmrxh6>
 <CAHj4cs874FivTdmw=VMJwTzzLFZWb4OKqvNGRN0R0O+Oiv4aYA@mail.gmail.com>
 <CAHj4cs_eOSafp0=cbwjNPR6X2342GF_cnUTcXf6RjrMnoOHSmQ@mail.gmail.com>
In-Reply-To:
 <CAHj4cs_eOSafp0=cbwjNPR6X2342GF_cnUTcXf6RjrMnoOHSmQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MW4PR04MB7155:EE_
x-ms-office365-filtering-correlation-id: 13bcf4c6-f2da-491f-e269-08dc423f6675
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HzRhItV3HUBamNR5T60B4YpU/a4AlZT5Z4FITRdQ7WJIry1laLBB/gcnwqebtSw2D++oOoyLIMKopeI40Wct4sRhMeULxfF+LzzAwQxQL9XKLdV8fWCQuiHJyBsZOU98XhnEMK3v8O/4ur3ZHVMR4NATSSZdtLnOcORwg3wujs4EHzR4p2aqjmwudRX+gzmp3GNQZ3G0IX/n7LyITGEltttlL/Q2/mXSLzIFPwC3yzyd/MTUVAv/6xoJCqQ1s327f71zzlss6et1YgKKNENyO8t/6sFQIkT63N5n6jFmXbwqRjv393nGYZs7HCsAGIve8C9YcdLjLCdXzJ/ktChvJ6wNgOoFo5yC7UAvdk6DGz3Xtn6O5HQJt9rz2SHh8dlQNIekQxmwh2tf1SOUSoWxfpthJ81ozo8auRx7QrZG8hbO621Zfmi+wTVQGchEzvbi678932Nj5OVwVMnXu6hzr3liQeclGbRbS2CopCiA68xOvf4xXytnsrpBVo6kuGhY5Z3SKGwpMJQYQjIDiKierIM6BjpORQy1+nxSGzWC6/NOKWoAlHk0AmlIXFCbsCNbdhowzq66SI1lYyurJcejtdunbIfhKXHT5q40fltZ8rKgzEFi56+VaNFsfqC5HrecjjQXIKrHaGYDbEIUrnDqZNdYW7l1OOWSH2WbMJIsqA8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MlB0TmRjRTFuN293REVrTVBYMkNqcDlXSFJhc09HQVgrdU9iR2I0WlRzQjJ4?=
 =?utf-8?B?N0FZZnplN09yUW1Va3UzYmlhUXZ0S2hVK0JXNzhob21IdU9VV0svaE40R05v?=
 =?utf-8?B?dG1GdFBOQzNpd1ZkbEVKRTRybnpqYi91QkN1MkZKd3puRGJVWHVVdFlIREc5?=
 =?utf-8?B?QW1DWFdwTjFTR2gyU0s0WGsrenZVbllGZ1hMcnJYM2FkMFZTOG5xUU1Jc3po?=
 =?utf-8?B?RnJGbDJvQUVzb1dXTEh2dmh3V3Z1bVE5UnhaQ1ZheHpjMHZOdkgvTmxMRzhM?=
 =?utf-8?B?Sm8xYW5xZkhLT0JCbk45TnZmZ2JCV3BQSUxucFVhMC96SmthdU9jYWFqU2F2?=
 =?utf-8?B?emtraVlYWDNGKzVQelI0VzZuVksyb3VCNGRzV2p0eFVyMmJ4Mko0a05tbTRD?=
 =?utf-8?B?SVVQaXRTNVhHY0dyN3o1VWJaZy9TQ3JTZTd1VEo5cWUxN2NoWWVSc2lYZ29X?=
 =?utf-8?B?a1hRWVZVNGRSdEY4Sm4rRk5oU0lUOFJ2ZFZrUTh1MVBQcXBQNjd3S0hBKzRF?=
 =?utf-8?B?M2xqTWFjc0I4emdyVVBZWnB4SjlpQWt3ODJoYTN6SllEMVp4NHJxbFNzUGZi?=
 =?utf-8?B?ZC94YlNUM09odWx3c0JYcno2dFpzb0lTblVRQzVFdHpZL0JwUVhBUDNDMkFS?=
 =?utf-8?B?TlJMblZWNzVJWlNDVlVoZ1MxRm5uaTJTQzFMb3NGcFNtNmZkamJvVmpBZnN6?=
 =?utf-8?B?eEpuV1RkbUVwVWM3Z3dZYThNeWs5UHIvcGxmb3JrQ3JUWXFzSHdKbUNKaCs2?=
 =?utf-8?B?Yml5NWZmNDNYbkIwN0RlRmFQK2taSGVEWG9WQlhGdnYwZldHWTdJTUtZVXRT?=
 =?utf-8?B?cU5WYW1BZ2EyTklTOTFVTlJkUXh3Wnd3amc2VW9BNmwwZW1MbG9KNklJSzBt?=
 =?utf-8?B?TXpTdVh0TERBV1lwVWtFZER6enZTeUQ3VUt3blpaNmZub3JEMkFMb3dlUUFS?=
 =?utf-8?B?bit1SFlBaGN5VEdkZ1RUNGZNTi9uMWtYLythT1F6L1ZyM3ZIOGJjUEF0R0NQ?=
 =?utf-8?B?YzdvNXlkUEFrUldySjAzazY2cU8vYmpKVE9KcmdnUDVsVW5XV1FsbndRaWlH?=
 =?utf-8?B?NmVacmZOajEvK2FPeGd4Y3BjM012eWhjam9NcXlId0U1aTgrejBOUWtFc2V0?=
 =?utf-8?B?b2FLMDdFTDVacnQyTXgybHpJWjh3OWVaak4rUlNKSDJSTlZFWmlpeWhRMHZa?=
 =?utf-8?B?SHJyNWZBaFUybmk4TGpCaGp0NnR4eXhKWWlhYWZOS1NVZjJ2Qm50eFlxSzBC?=
 =?utf-8?B?NzNLZkl3QldMWTdnMXFsem9VVWw2Q282VTNQRERheDlsTHJjMEhHcXJUS3Jj?=
 =?utf-8?B?Tmp1bEp0Y2ZDUXFBUlZQVFBoMUlJdVpBT3pSck4wV1lFTWxsMjZKeEtjZTI5?=
 =?utf-8?B?RGhoS1RnM09VN2sxMDAvMkZqOW12czRvTjRFRE1JdTBHRUorTU9GNCt1ZFJG?=
 =?utf-8?B?UlZkSk9OSzlXcDN1SHFZaFdFREFpYWFlVXNjdWRlb041clhXTnF5cks2dDlw?=
 =?utf-8?B?YUNzWktuM1hzd3ZjYVpZZGpCTzZpaGZhMi90MGt1SkJYYmZCekNkdnlqL0hU?=
 =?utf-8?B?amRJU0RSUmpnYWU2UHdmRGowVHVhRXV0KzFQS2czVEpLclNZeXNrclhHMVZT?=
 =?utf-8?B?eVZ0M1g3T3JsSEdTWHJKSEJFTDJpZFhwb01uRFlGUFlyalV4VGlSVU9QUzJa?=
 =?utf-8?B?a1AzcktDWUt3MU9NZmZidnhwZlNXczRYTkdWSDFsMGt4R01WUkxUMlhVYldw?=
 =?utf-8?B?eDg0SmllMitKRllRZW9RQ2FTdE45Q1czYVlTZ0oycks4alFkRVNTSHRmY3dl?=
 =?utf-8?B?YUpPOTlrbkt2eVZ0eTREOFJFdVBoK2ZOYUVicHczUTBKV0JtdW91M1lkSWtM?=
 =?utf-8?B?d3BkSGUzbWUvQXJSTERaemg2VTJ4S2tRQVFPbVRtZC95TFFNN2pBdUI5NE9N?=
 =?utf-8?B?MjFra2ZIckFTZ05uUFN5SkF2THZMd0JGbDVkNlQ3a0dRcWRkckMzMmNxL2t3?=
 =?utf-8?B?V01jV3ROZVlHK2pXVmNuVGIrT3U4V0FNL1ByMTFETXZURGdOQStHQ3NaZDJV?=
 =?utf-8?B?TWNqaW81cU53bGxTQWcwZ1duM3MyTWg4S2VWdDRHakhsWSsxM1JPVGgzbWlS?=
 =?utf-8?B?MnQrUGE4QVEyUk1EN0lTTEYxeUVTYTJNczNpZDFQcUxPMTZQcXlOOUFrck5J?=
 =?utf-8?Q?nv/k4cplTkO76R47bF24qZI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E84A7EBE53741E4BAFD867499E5BBB96@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	23wc2+MfI/fmzxPYo+gJ0WowZydHqwqS+tqX1wZVjKrySjOKrJr3xgZkYl32d/K/5HjtqyIj1UHWv15xzTEsa2lZqkMG/geQkUa56eNbN/Q/az6TGo4DSaVLwmHLr+Bf0FXon0Ys75u2zYeT8wKgu6vRLn/D4HSr7ehLSePrnBCVwE0JWRaUZtHklSUmxUIskSrml57ZKkXz1vwT6Fqkv/6h3K/Ypyj48iKapoFNE4WNuQgbwsTZxKDmI9fCLuvtX3uJOuAowMBqS/5DJ0MFtRtD709b0FQ4xNu4Afn8C+PUjeT3TXLwhsUiDE6G0MPhBxBgp0GQWx6138xdH89sw6Lni8lQzuEh55/i205bjBBhYoep93M4/wSupQ+0GYSOD8NbTeGDhOeJZ4Ekl1krs84AYhRAws8DD/2rQjEIKpHapb5Fqo94jguZCskaMz0RXIOFyAFpk908oiFYTL3nN20jCUaCZ/HIrE/BUtJmK3oHpnmpYUkeWj/FYsVF9SkwAdofKRBfYAc0u+xzwxeSLh0AAw82vsnHHewjgK2iWxuUJ/1jlSyZIcdLFa4obLq4XEvOm9wg1vMxMTpO8lBFFKxiPG5WNFUK7zieaY1n/3qB2NOVdoPvpy8YjXYxw9Nh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bcf4c6-f2da-491f-e269-08dc423f6675
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 02:52:04.8538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AAKhzAp3XJS3OzrPp/Bjeui8u50YJgsCqgOZ4V0J0WiQ44xTob4uwuu4gVQpsVxiuBt/EEu2fkImskVg228xQPqvVb/+huv2ZHsrZ6FdoIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7155

T24gTWFyIDAxLCAyMDI0IC8gMTU6NDksIFlpIFpoYW5nIHdyb3RlOg0KPiBPbiBXZWQsIEZlYiAy
OCwgMjAyNCBhdCA4OjA44oCvUE0gWWkgWmhhbmcgPHlpLnpoYW5nQHJlZGhhdC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gT24gV2VkLCBGZWIgMjgsIDIwMjQgYXQgNzowOeKAr1BNIFNoaW5pY2hpcm8g
S2F3YXNha2kNCj4gPiA8c2hpbmljaGlyby5rYXdhc2FraUB3ZGMuY29tPiB3cm90ZToNCj4gPiA+
DQo+ID4gPiBPbiBGZWIgMTksIDIwMjQgLyAwMDo1OCwgWWkgWmhhbmcgd3JvdGU6DQo+ID4gPiA+
IEhlbGxvDQo+ID4gPiA+IEkgcmVwcm9kdWNlZCB0aGlzIGlzc3VlIG9uIHRoZSBsYXRlc3QgbGlu
dXgtYmxvY2svZm9yLW5leHQsIHBsZWFzZQ0KPiA+ID4gPiBoZWxwIGNoZWNrIGl0IGFuZCBsZXQg
bWUga25vdyBpZiB5b3UgbmVlZCBtb3JlIGluZm8vdGVzdCwgdGhhbmtzLg0KPiA+ID4NCj4gPiA+
IFsuLi5dDQo+ID4gPg0KPiA+ID4gPiBbIDQzODEuMjc4ODU4XSAtLS0tLS0tLS0tLS1bIGN1dCBo
ZXJlIF0tLS0tLS0tLS0tLS0NCj4gPiA+ID4gWyA0MzgxLjI4MzQ4NF0gV0FSTklORzogQ1BVOiAy
MiBQSUQ6IDQ0MDExIGF0IGZzL2lvbWFwL2l0ZXIuYzo1MQ0KPiA+ID4gPiBpb21hcF9pdGVyKzB4
MzJiLzB4MzUwDQo+ID4gPg0KPiA+ID4gSSBjYW4gbm90IHJlY3JlYXRlIHRoZSBXQVJOIGFuZCB0
aGUgZmFpbHVyZSBvbiBteSB0ZXN0IG1hY2hpbmVzLiBPbiB0aGUgb3RoZXINCj4gPiA+IGhhbmQs
IGl0IGlzIHJlcGVhdGVkbHkgcmVjcmVhdGVkIG9uIENLSSB0ZXN0IG1hY2hpbmVzIHNpbmNlIEZl
Yi8xOS8yMDI0IFsxXS4NCj4gPiA+DQo+ID4gPiAgIFsxXSBodHRwczovL2RhdGF3YXJlaG91c2Uu
Y2tpLXByb2plY3Qub3JnL2lzc3VlLzI1MDgNCj4gPiA+DQo+ID4gPiBJIGFzc3VtZSB0aGF0IGEg
a2VybmVsIGNoYW5nZSB0cmlnZ2VyZWQgdGhlIGZhaWx1cmUuDQo+ID4gPg0KPiA+ID4gWWksIGlz
IGl0IHBvc3NpYmxlIHRvIGJpc2VjdCBhbmQgaWRlbnRpZnkgdGhlIHRyaWdnZXIgY29tbWl0IHVz
aW5nIENLSSB0ZXN0DQo+ID4gPiBtYWNoaW5lcz8gVGhlIGZhaWx1cmUgaXMgb2JzZXJ2ZWQgd2l0
aCB2Ni42LjE3IGFuZCB2Ni42LjE4IGtlcm5lbC4gSSBndWVzcyB0aGUNCj4gPiA+IGZhaWx1cmUg
d2FzIG5vdCBvYnNlcnZlZCB3aXRoIHY2LjYuMTYga2VybmVsLCBzbyBJIHN1Z2dlc3QgdG8gYmlz
ZWN0IGJldHdlZW4NCj4gDQo+IEJpc2VjdCBzaG93cyBpdCB3YXMgaW50cm9kdWNlZCB3aXRoIHRo
ZSBiZWxvdyBjb21taXQ6DQo+IA0KPiBjb21taXQgZGJmOGU2M2Y0OGFmNDhmM2YwYTA2OWZjOTcx
Yzk4MjYzMTJkYmZjMQ0KPiBBdXRob3I6IEV1bmhlZSBSaG8gPGV1bmhlZTgzLnJob0BzYW1zdW5n
LmNvbT4NCj4gRGF0ZTogICBNb24gQXVnIDEgMTM6NDA6MDIgMjAyMiArMDkwMA0KPiANCj4gICAg
IGYyZnM6IHJlbW92ZSBkZXZpY2UgdHlwZSBjaGVjayBmb3IgZGlyZWN0IElPDQoNCllpLCB0aGFu
a3MgZm9yIGJpc2VjdGluZy4gSSBob3BlIEV1bmhlZSBoYXMgdGltZSB0byBjaGVjay4NCg0KPiAN
Cj4gSSBhbHNvIGF0dGFjaGVkIHRoZSBjb25maWcgZmlsZSBpbiBjYXNlIHlvdSB3YW50IHRvIHJl
cHJvZHVjZSBpdC4NCg0KVGhlIGF0dGFjaGVkIGNvbmZpZyBmaWxlIGhhcyB0aGlzIGxpbmU6DQoN
CiMgQ09ORklHX0YyRlNfRlMgaXMgbm90IHNldA0KDQpCdXQgdGhlIFdBUk4gaGFwcGVuZWQgYWZ0
ZXIgZjJmcyBtb3VudCwgc28gdGhpcyBjb25maWcgc2hvdWxkIG5vdCBiZSBhYmxlIHRvDQpyZWNy
ZWF0ZSB0aGUgV0FSTi4gSWYgeW91IGhhdmUgdGltZSB0byBhZmZvcmQsIHBsZWFzZSBjaGVjayBh
bmQgc2hhcmUgdGhlIGNvbmZpZw0KZmlsZSBhZ2Fpbi4NCg==
