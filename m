Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7588C1CFBD
	for <linux-block@vger.kernel.org>; Thu,  4 Apr 2024 07:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712216620; cv=fail; b=D/o+H4+JqGq4G1T+0CG0muc3rwyuNYcVdsnHu3KE7WUkJKUm/pV7ZwhT9AhKzKc9aUrCnoj5L3YI3vRtKu4wCqTO/z51lLo0OBUosVJHa7I+aeqxsEOiJsvtvWtlBBVaSvqcOkYjznShpaYS+26DhHRNswcmHzWdbnCJA0rzCdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712216620; c=relaxed/simple;
	bh=P/G07P0cDWdZbRzZRPZN5pw+M7w6ByKM9LP3dCwc6+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J299Ox1mo/mxEaEsQ8ByzkRHeECdnamyXxl6urtmZ91LuiyT9uJkoziS9Bn5/eEhdP8cspILNdYRfeg8PUW0eA5nxm7e4RtMIk+kSCPLIXas00eI4HrrSY38Qcv0DbcJUWaytJlDE52mYNbmag02Cs5MS1D4GxfNHqsLgI7JnCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XhqjyUvf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rlwVwM6m; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XhqjyUvf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rlwVwM6m"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712216618; x=1743752618;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P/G07P0cDWdZbRzZRPZN5pw+M7w6ByKM9LP3dCwc6+E=;
  b=XhqjyUvfPnz6T1d7mPdwsUX+z2mb5iZnpnfUBUzkjA7fKOFHsXjIIFCw
   t+bnlRJ3ZVvPozj1CTi0ltqKOzmvVlVRpA0HOjbHJ9ZbfgChPvJA6nKoo
   zrDCl4t79iqVrk9xun27yrazZ1V57DK8PY19CsKeBt6CIeKI09rhXxxlI
   aNKhmlgCMyOH3X6wRGi5c/O2+kzsXCQypvLM6fsWa1hueoDBmga4DMNHx
   jDMBHotXkUZPYFajPEJbkRlYrlF0ibTYSLKcQ3t6Tda6PjHAj/8IrJNnv
   ZEYUtsbGauQlRMeAZ/M/CfTaYMW7sLJuZX3+9eL1U2XfrWraqf/OLrwbG
   g==;
X-CSE-ConnectionGUID: fQYMKYb4S+KQnPQvCCKaPQ==
X-CSE-MsgGUID: vozEdrLdRlqHAp34Jg0Apw==
X-IronPort-AV: E=Sophos;i="6.07,178,1708358400"; 
   d="scan'208";a="13470743"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2024 15:43:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V3DjeHH3R3iiITCIHII2otSn4/04naFF/TdQVn2eB+qndLtptVGYTsq9Tn617keKQ2tJQm5o3Lf8o3jFAndQzlzKMdmf+kU0BeM3lkUrxNl7Xjk9HVhsA/4vF2BX7B5Atz0fd08sKL7KU9omTHhAiyUXqHtXFzqpJGKZq/u3GalBxAsS83FpMFa9jIrfg1++iPEzxcKd4emYDrKLN8pm/VKG7SbwSR680KytsXHmePuNCpSYTM62KHYtib+qz13TE0aqnpcKD+tPIO5Lm97XM2wQ+1axS/tICD6W1X8W2DvUjjTWnFJVUED1xZPg4fmLt3XiCA3SwgYEZgH9+BTmtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=syyKXHcd2GJYoFuyj5PmfBRE0DAV3shgtPlo6xgk610=;
 b=MlVmo9ZeleEbGZMUFl8oLDZwg46KLLeJKMi78I89UrHe7qFsJSBAZYHll1r2o6LUNgP75Dg6uLg9G2JD3Ex3NmtzzHTCM0o7m1YfFG3/WdcGiurGvctdvlcSyUaunVDq9b6TI6rFdPDpimHAk1WK8xLxRDMRtm1vn7UlQPES4dCTs6Swm4pWaZhfZBiuJwTcmuFmQCK1gU60P0F/HygRRmJEI2zsF5wAchfQjDkb82FFhO3FHrX9Kuc0Bqym3MnAuHsLoPhlGAtjLsVHb+WaLJryCoHGx2IUW3gkQKdhVryWK/I+YfDU6OWJFjp/8a27qrd4Ee9Ej4kun/CxJlq5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syyKXHcd2GJYoFuyj5PmfBRE0DAV3shgtPlo6xgk610=;
 b=rlwVwM6m3TMG21tmCFtVBbGqLzE8s1hVSFuJKkshR0tPmhbueEyHNZ/p5wqdbfMtSBshe1lUJtlo2g/Zp1mY65GE0/AceNxl5erwNg84ReZzsMt90JqpoYVhwe6A2zSBRLCqG5zuz99r9eZVzuQVAt+uyl44uiYdIRCVPcvlcMA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB6276.namprd04.prod.outlook.com (2603:10b6:408:7d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Thu, 4 Apr 2024 07:43:29 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7409.042; Thu, 4 Apr 2024
 07:43:29 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 0/3] add blkdev type environment variable
Thread-Topic: [PATCH blktests v1 0/3] add blkdev type environment variable
Thread-Index: AQHahOUD7cM19WGut0Kq15XIUevcELFV/DcAgABEoQCAAXzpAA==
Date: Thu, 4 Apr 2024 07:43:28 +0000
Message-ID: <w2eaegjopbah5qbjsvpnrwln2t5dr7mv3v4n2e63m5tjqiochm@uonrjm2i2g72>
References: <20240402100322.17673-1-dwagner@suse.de>
 <mqpuf2a7obybtw42ydte2wq7ktema5odvc3dqm32hknjmamgdb@rbo3i6lqqkld>
 <j6awxljufwg6r5rs5kojwsnatfb4aj3vnqsq43hkuuhgvcflvh@u6l5cf2ponaw>
In-Reply-To: <j6awxljufwg6r5rs5kojwsnatfb4aj3vnqsq43hkuuhgvcflvh@u6l5cf2ponaw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN8PR04MB6276:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UVJZKg90wrjS2Z7QY44YntFHjSgH/yYWey19qNpGaiqV25BAidpSinjGqJ86QBUCoIpA0aYcxEMs2HB1A4NAn6PBgRUafmuGwHPVxma2DWlKQj5DLxEvleRu7O3G9v8kOG5HF8Jq4JN9/3Z0OHZu7GwLMH8M32w0X9Q49wuYkrbyww65FAvWLjSrqOd7i5GM0phOsT5a6mEsR7ZxKs47i5iFxV9oKSD/EQi4Qx4bPuFebMsYLrXQDADUEEj3gxZo9mNRZmYtxCaYYjE4auet8RfHb4o6Af8g57xJCcnt7Vc19BakIn9ZFXwd9SFcCSb915itMqT9qtYUJX6JdkZxEW82SaS9/8Soof39vZ8XtbwaszcDQn1onaa6V1w7/+rxkegMYWM2QtvrGfwA/D/nlF3P9kfNXoUUYFi4QVDVLCFW/iJZM5nfAiLlhoqzJU+j6YpixstgpWi+9g1/1MipNVGv6bIUSR6JVNvz33brAD03DePMo/T0zWMc7B6kCA1jwbmf7+WZMaufX71tPb13Jn3XuW8Fg/ItuvuaqVB+F1+ZqEq7ZDdGJjaKUsOmsUCIvLSYDg+DWIbxhPJTI5xW0rDI/Tdp53vFeUa3fATFp2k=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eHWoAdyxYcuqdAU7nE7qpqjj5Gml0SiOqkv/WWY2p9Xd4BLGdnQNCjhVVlE3?=
 =?us-ascii?Q?QQqPolHlExKFBVG01WBxehA5W3Kqek8gMHMvsBMH4bDzKqe9E5vIs9ibPILd?=
 =?us-ascii?Q?PsAN4iL0ahkLGHZalbWgVnhSSKBzCVn31bdz3E7F/qNIusAtPkomvymnCkzv?=
 =?us-ascii?Q?wj18v9IzQsbmyLJWXLP7piBjdRr0zdUekW0LTVFKnWiLbr3DqBSvBXTJRUBg?=
 =?us-ascii?Q?kxh9wc2/J6+iXn92eqjCJCSOQxTpmbWHTVhmWUxn8AZt3GI3kCcKZrWqpaMZ?=
 =?us-ascii?Q?R35ux7cuELZdFMX7lDnElAGfRHmnHCLmPUOKi1PdOMAOb+LRlyodAJVaKrA+?=
 =?us-ascii?Q?qJpNrZm5CptD00CaOLNgN3+T3e43+z8bB38RzFqhAoDDAv8i0zOZAgokUHcP?=
 =?us-ascii?Q?f2n+Ud72mDg58CNeAy+pU9AIYk/cZ5qDGrrWmKAzZbqfAjyaU7ngjFllz5QA?=
 =?us-ascii?Q?8Sj2Zg+uXEd4wpZH9dDH2wSlmz1N9bsKQemQ0nQYbgCkkGub1uW/vkYteRt2?=
 =?us-ascii?Q?bd4rIcoZLn5DEY/yWIzDCpJI9WbGd84YdBU8Q2foiGBjX2dFl2ZmvXg5gzUu?=
 =?us-ascii?Q?BOpagRFinsMhaZF3qveopCj1faV5VB9SX6dGYqLIisp+FgpccXG7SkioP1jz?=
 =?us-ascii?Q?ALWX0jilgVMNklX3ajCQ0HFZqk7F1PirN5U1pcpBWAcggQ28tsPSuzodcVwR?=
 =?us-ascii?Q?S12lSEhp2TJdv9pcPNdeYnoqziq+P8xfr9uJtjxPNGIlSa20Jxvd3tHD+rId?=
 =?us-ascii?Q?x+Kpf0NRpm8UsZtA9hbXN5fPEjvLLuRKJkAqlYFI3iP/Z8kwbDNkWfCjqfId?=
 =?us-ascii?Q?EMufh62P9q0NjpsTsdqglnBaer+wAL9mc2ArU+Xc0EUJJzqW01RB69W82uHC?=
 =?us-ascii?Q?vqGO0DWZ8kKMCBlW+hkGH7295fU5W1+oju9dLOTZ9Ph+Zq1mxyKFVxnm0+wZ?=
 =?us-ascii?Q?wFdzvq3UFClGlMeAu8BYJ/45GROPMnTpClkbmq/ETGrFmfEMA0idmUUIKA6K?=
 =?us-ascii?Q?YoDTe20DTw0cHy4nTWfKX9qlEUdwStZG+dLaCQDJaDGXPD2BJpqrIvSjXSn+?=
 =?us-ascii?Q?O3IVZG/kRKeuJFHxGkEQUWvNEjBWVzOALW2OP2WzV5nh37uUxPTN2RFc5GRr?=
 =?us-ascii?Q?CfnKz/wuLrCvCzBXpvk0hwJVEzba+4RNrp5U4nM1pHpej4652ViQLhTFriWx?=
 =?us-ascii?Q?NpXwCFaIZtcuL/x6uwBXn1zum1M2P0Q3sCntQoXbZmmsvvCA6QgueIvnag2K?=
 =?us-ascii?Q?sms2ZaRqA7baVcjdXeSJfF6uviVAcSH7QOCRifXTpuOoX+PFxzEBoXOncJoj?=
 =?us-ascii?Q?F0gEXOtb9E2wLXERahH37ujmwrJZ/ldCBfdSEn5IOZN3MKxWB4C/T/iZLlza?=
 =?us-ascii?Q?PxHWoBuT1MaPKl1omo/Drp7pHVmBQbX1AZ5xfgtb5Jgf8hU6aJr3JLWNDcsW?=
 =?us-ascii?Q?r+8P84xU7XlzMKDVESj2gr3NA0mcfWomzLGEt0hlh1p29U5q1zMy70Um7nwG?=
 =?us-ascii?Q?AVgze/c69iMIzxZV8+xo2D4DT1+oZ3HqxJN/6/qvQ1d3tU5BXKy8zvnvM+KE?=
 =?us-ascii?Q?jDBGGH6a4Q2J1FR5FqqPcidWh5sVQpoLFKEQtMeRTuKJyqm3B0YK+n1rVoqD?=
 =?us-ascii?Q?OJhJCS9la7R1aa7m4JGKhok=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30E65DC9F3740F41808B8C95C0EE398E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e4d079CuITZsntMrYzyxA5on4O8AmieiydaDl1FJMkLyRZrTIv5JAFFDCs3VYCc68CkYkvGWo3bMPegwEteI0ebRg3EoVdrHwh/k3Y8DNRmDxA3owBcfXhnlV0cHu/8sERrnxU8qCVYQt0urYl6jylAWKd/zS3RnJfUdyasH6F6apheC6d91QIAcfDwrVYREJqv0wngdZQwEqTHUjkNkNDk2ZgwEwH2PhOMZq5uETVLewc0x7frM5CS6GCrY0S+IWTUMoxgqaGrCOwoBoG0Bjh93PlNCc45Yo8nvONw8nfF0Wwwzb6fAN2f9fs1/JNR87M3WtcJCCTMekzruHR4KphI8Bxf6kx5i/RFXKhIJP4K7Fo6TYZRnDwMfCNH9N6Mtye8dcHuspxwlzxlBGVtvCxtY/nB8wKGunnjYk1JyvRFEnWsiCg/Y0OJVnJ2bYznHkBs/sEZMlu/GPh73MK95EmG0Pf+r8v8U7XthGoik+EiMWExCsZBPl78HzCBGM4DuyYDV2rw5XRyCQyKFIf3oOiJDon0m6keFvBn+n/dtDF6nIuMtTqUW9FNNjyVTXoX+BJPXKoVoGQi66ZM4IsDmYcw5PiUP+EY6yy3QqHnIpOkwfPQCrqGQX/jGsAAO/SWT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4fd7fa-687e-4c06-644c-08dc547aeb50
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2024 07:43:29.0218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+P8Eou4krq+MiXQAkZlIXvYxHLhZCMUUCrc92AU1arjkDmg3neOjjgb6a3BjaHfxL3EBoP79QkJYH/43TnMr1r4pYjZIL2hMpw1kDBPtoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6276

On Apr 03, 2024 / 11:00, Daniel Wagner wrote:
> Hi Shinichiro,
>=20
> On Wed, Apr 03, 2024 at 04:54:28AM +0000, Shinichiro Kawasaki wrote:
> > On the other hand, I see that the series has a couple of drawbacks:
> >=20
> > 1) When blktests users run with the default knob only, the test coverag=
e will be
> >    smaller. To keep the current test coverage, the users need to run th=
e check
> >    script twice: nvmet_blkdev_type=3Dfile and nvmet_blkdev_type=3Ddevic=
e. Some users
> >    may not do it and lose the test coverage. And some users, e.g., CKI =
project,
> >    need to adjust their script for this change.
> >=20
> > 2) When the users run the check script twice to keep the test coverage,=
 some
> >    test cases are executed twice under the exact same test conditions. =
This
> >    will waste some of the test run effort.
>=20
> Yes, I agree. These drawbacks should be addressed somehow.
>=20
> > To avoid the drawbacks, how about this?
> >=20
> > - Do not provide nvmet_blkdev_type as a knob for users. Keep it as just=
 a global
> >   variable in tests/nvme/rc. (It should be renamed to clarify that it i=
s not for
> >   users.)
> >=20
> > - Introduce a helper function to do the same test twice for nvmet_blkde=
v_type=3D
> >   file and nvmet_blkdev_type=3Ddevice. Call this helper function from a=
 single
> >   test case to cover both the blkdev types.
> >=20
> > I attach a patch at the end of this email to show the ideas above. It a=
pplies
> > the idea to nvme/006 as an example. What do you think?
>=20
> Ideally we don't have to introduce additional common setup logic into
> each test. Also for debugging purpose it might sense to run a test only
> in one configuration. So it might make sense still to have user visible
> environment variable
>=20
>   nvmet_blkdev_types=3D"file device"
>=20
> as default.
>=20
> > -test() {
> > -	echo "Running ${TEST_NAME}"
> > -
> > +do_test() {
> >  	_setup_nvmet
> > =20
> >  	_nvmet_target_setup
> > =20
> >  	_nvmet_target_cleanup
> > +}
> > +
> > +test() {
> > +	echo "Running ${TEST_NAME}"
> > +
> > +	_nvmet_run_for_each_blkdev_type do_test
>=20
> I was wondering if the nvmet_run_for_each_blkdev_type logic could be in
> common code, so we don't have to add a do_test function. Basically
> having a common code for a bunch of configuration variables (matrix
> tests).

Actually, similar feature is implemented in the common code so that some
test case can be run twice, once for regular the block device, and one more
time for the zoned block device. You can find test cases with CAN_BE_ZONED=
=3D1
flag. They are run twice when RUN_ZONED_TESTS is set in the config.

   To be precise, this applies to the test cases with test() function.
   CAN_BE_ZONED has different meaning for test cases with test_device().

Now we want to run some of test cases twice for the two nvmet block device
types. This is essentially common feature as the repeated runs for the
CAN_BE_ZONED test cases. I think it's time to generalize these two uses cas=
es
and support "repeated test case runs with different test conditions".

> This could also be useful for nvmet_trtype etc.

Yes, when I run for all of nvmet_trtype variations, I see some test cases a=
re
repeated with same condition. Waste of time.

>=20
> The generic setup could be requested via the require hook.
>=20
> requires() =3D {
>=20
>  _nvmet_setup_target
> }

Hmm, I think this abuses the hook. IMO, it's the better to introduce a new =
hook.

>=20
> What do you think about this idea?

It sounds an interesting idea :) I prototyped the common code change based =
on
the idea and shared it on GitHub [*]. It introduces two new config arrays
NVMET_BLKDEV_TYPES and NVMET_TR_TYPES. When these two are set in config fil=
e as
follows,

  NVMET_BLKDEV_TYPES=3D(device file)
  NVMET_TR_TYPES=3D(loop rdma tcp)

it will run a single test case as follows. 2 x 3 =3D 6 times repeptitions.

$ sudo ./check nvme/006
nvme/006(nvmet dev=3Ddevice tr=3Dloop)(create an NVMeOF target)  [passed]
    runtime  0.090s  ...  0.091s
nvme/006(nvmet dev=3Ddevice tr=3Drdma)(create an NVMeOF target)  [passed]
    runtime  0.310s  ...  0.305s
nvme/006(nvmet dev=3Ddevice tr=3Dtcp)(create an NVMeOF target)   [passed]
    runtime  0.149s  ...  0.153s
nvme/006(nvmet dev=3Dfile tr=3Dloop)(create an NVMeOF target)    [passed]
    runtime  0.138s  ...  0.135s
nvme/006(nvmet dev=3Dfile tr=3Drdma)(create an NVMeOF target)    [passed]
    runtime  0.300s  ...  0.305s
nvme/006(nvmet dev=3Dfile tr=3Dtcp)(create an NVMeOF target)     [passed]
    runtime  0.141s  ...  0.147s

I hope this meets your needs.

[*] https://github.com/kawasaki/blktests/tree/conditions=
