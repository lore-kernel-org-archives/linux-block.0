Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8178040C15
	for <linux-block@vger.kernel.org>; Fri, 12 Apr 2024 10:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919370; cv=fail; b=rxST++Jiena8PlO7AltKVKv+vcCSo34tV07SjdCWcBkQtZFYlZZfhkm/azljuMMUX7EOa/Bs3xLbFefyVJEOiyj7UYRcdYsafPCvxXcmjsWlvvlU7MvXGsvtbEkHX7F1v4n7lfcmq8348OkA7GPtbILIJQcpMO+iJ/v3mSQ4C+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919370; c=relaxed/simple;
	bh=ZeZfVoQOeCG52okLjp8InIt6Tf7TBDWbBy7HJ5p+uYw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OcbYjv4XRdgpTawtvj8k/tgFW2bI4/7ExXREPduvBWUbmNX9Th59gTmu7W0yqpXQXr61CsEsRZtov4TmQHdv+jBSkiODE8q5J+ZAIefojPtvCII9Pagc7CFBIBMLhYlVdK+1Kzu7D0SrLdMLX+CTUvljjgnlrZG/AIrDfygHeK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ba4wm3+D; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UmtL8SLu; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ba4wm3+D";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UmtL8SLu"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712919365; x=1744455365;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZeZfVoQOeCG52okLjp8InIt6Tf7TBDWbBy7HJ5p+uYw=;
  b=Ba4wm3+DIT3i1KAMxTqk+a5h4rjAGcd8tRTlKwiE2+Du+VtRVPBVcCPX
   Hs0xqvqvuZF1Egz22a7no6ndWjoR+uZDNHOqwiCU6eZFdq/o8JsFKwmzJ
   mzule1wlcNsrcK7dpaTCE4Aju22kY3VX5tuWUgNALX1i16jBAwYbGhveb
   qFLv9n1Zuw8ohfTclc6YkQwMEAuw6VxDA1UDMt0yzz3EXJ+9RGuD+7u6i
   vr3igJebTMpPCMKiMS1d93Dw7EQrH/chHuAOw1s3WZJHab+IApRusjZwI
   RmHt2+KQZn7u0ri+6dvkNlouwBNcQX6Dg6wlQyqsmPO3UmGJBH0JVRpsL
   Q==;
X-CSE-ConnectionGUID: P6i8RHlBRjKibyuoFvdGgg==
X-CSE-MsgGUID: nrH3AO6CTn+FhiMG+rjfKQ==
X-IronPort-AV: E=Sophos;i="6.07,195,1708358400"; 
   d="scan'208";a="14547741"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2024 18:56:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dj58i22EJqo1CXnkogi1LegsqdWMxHzA+eTnu+IfDb+rnGGxHhrfdcMOVHM9FF2j9XcneShva8kmJ2E6eS0XteoeDjM3oiJHRB+R/PexJl6KwiOYBJul/lxlhjxmq3mIH8cyNArF5qUE83K42aKtMCu4oe9L0FCxdSQTxw/mily86h1Wc1DMhCfeDlCRb4AYn9VMFyxFGC27EceA+Hb+S/beXndON9CHYOV1ou3M8eQnUmzUJpl9L1xHz/7y45qJdDKnKxarKiXIuS9QvWXOBrag0+BsxyLxJwOa8mMhv12Dyzu5hgVVOaLsFDoI47PZoonTS6mGbcoUJO1TnEm35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHdqmslrMZWmrsPq2kjbv6ij8xZwuHO9co97Zc1jZbk=;
 b=OXKGgVG4HYyAvQMrTmpGfnLcpF+9TJm116VQyL3NueQ0+H1/U+1DXfcsdzQSsXb3CvyiBqQnA+xpnjz2PXtO8fXt0xf8Ho8vfSwh+iZlrxGKjdNm++qYu3oRFHlfBx4MZA7mUOAk3bF4bUWgeoTJnC/KkBUVhkhSGDlWySJ3tWajboKSlc60I9hdlH7LMcwR8nlcztFk6j4toz0crJZvFG7QCTk8YB8wK+YDw30MhqwdTxOWUNWzD3WMMcDcrQ+o5hA7GqerowVN5EUby7SUOuwA08wC6XEW6+R93cKFljflJAgpBg7fwEd8Xo+HFUmmzi5oAO+2yxSyHRmmBhagEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHdqmslrMZWmrsPq2kjbv6ij8xZwuHO9co97Zc1jZbk=;
 b=UmtL8SLuLJuphtSUc6DeL3sg3cLOv172CNOENVF11r7laZYz3o1T6L8Mdp6nfQzYP1N+W6VTwjalDDf0sFMSN+ywxrm9eKWEPekj7IuSx7C+vB2H13qRba8o9dAtIHT14xjOiJJgmU46QFmJEVDeEZVdewJfBva8imxDpo2maks=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH7PR04MB8706.namprd04.prod.outlook.com (2603:10b6:510:24e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 10:56:01 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 10:56:01 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Topic: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Index: AQHajD/xHKCgSe6kfEa5k1xtmLrU0rFkd4IA
Date: Fri, 12 Apr 2024 10:56:01 +0000
Message-ID: <sacgb2ysujrkf5qlu3hlqywg2jzfqkg5ljlbai2tb7srakvi2l@axrmnjehzkma>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
 <ccnazevlqz6dybzhe6asib3rtlz62ynv24jc22q3cgsf666b4e@6sd6youpsrrb>
In-Reply-To: <ccnazevlqz6dybzhe6asib3rtlz62ynv24jc22q3cgsf666b4e@6sd6youpsrrb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH7PR04MB8706:EE_
x-ms-office365-filtering-correlation-id: 5d80c9e5-1477-4ada-56d2-08dc5adf2466
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 N/t2CyeLbr+e8jNCy0U5OR8w9K4sYVIJBz8TD5IyJxPrq5NeYsEDhUmJN/YBQCdQi8sh7TzjPC3fINbOS5lYWZSOAzI1E6CGEj/r1X8auf0n45dtJNFFRV8BBxf2L061AoG7oM6ZNPSvswyhui6dKL2I1JhR/ga0Z6PUH2Icg/Ji51TDPSd945BkeojKHvJkdEmNM5tfM8pG1FkKh6rriUQNFSc4uwl4kXh1LjRNP1Zm/OUZ3CkhUbMC1TNDcoZMbRmcXJJagOQqtqaqQ709HCdlcw1kp4LigASGXQlx+/s9qOVTgtbgbTFGtB1vEYmRHZOrQk8CvhYhQ8RANSKMeu6vPWG8GUo7eA+jVw39NaBh6Cg6eIRjwNWnMssbzEpIpsJBUGPYI2XZ5INk8uunlh3oPoMMKPDTyDyEOxN0NhKvOdCDou0ie0VL8R38h7mC8OUAbFi9EfBAXfC1ynqTXyQ206a33YYGcne8VcjqZpRa+h1Atlycb2gX9tBKeYoPZAF8k2xwB+4VhEHjl4kRlklTwtqrTR/fkRkOoRLK3Wvoanv/0X8fFYMUgY1xrO9ZVFp6xDrJDdw4y/8phdopBFWK/r/c/oyJb8mYHuqpxgGNdbtcgkxU5h0N30y5olQ/fs3HIBR1W0nBmtIJHgBFZWXpU2VHwqAlIWG/ihERbtuUdijiFDOP3mfKoEgnSelgUN3dws1H5iHGzbkjwMvFMRj4s0I7e7Slhv5c+Oei4ARk5V+6HXAHIh4FMDUUo0A+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009)(27256008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xbR1z+zxB3i6RRodpqpFDfVa+4drPFK3Li5LIBww0LkXX50H3WwgNM9NM2zy?=
 =?us-ascii?Q?+04ZbZ2KQe51t07INOCux08i/8kKdnzSXPEz/lQC+pDcyxYb51IS+5ibEIxL?=
 =?us-ascii?Q?DkotnoN7izMHccpANBEsKIVrToisa+Hv8ZwUnQi0/0TiJcgg/+3q4Lp5Bc0P?=
 =?us-ascii?Q?789b0+nqeweU2YbXHD1NANWEiAjFcgDyQx13ypxoL0vhpKsi7GKNoBwECQR/?=
 =?us-ascii?Q?YXykh2IpErsR6+H+bvvtG64PKL5xhWZMJV3MK+JpMXe4hy5ChG6y8AbbaxkU?=
 =?us-ascii?Q?+YR5yQYmd4/Fe5BDCcAhJ7GrbgEeJyP49wvqgQeJvKq8zWWXr8nqVwqVuA6l?=
 =?us-ascii?Q?tRoJbo5r3GFqPi2AYDZv0jmzdVGTyziJENt1GY59czgy9CabLMO22DKV7Bx3?=
 =?us-ascii?Q?k3cD4SXm1o1nVFJNpREq+zZbbAdE7AQQSrMit3cLPfd9vPyLZTrFpKg/dwt9?=
 =?us-ascii?Q?xcrGoikBH48dMRgjxy9q9dBvcwc2ocSSXkOLYNPnqV/RezmncnZUYXt0u3/B?=
 =?us-ascii?Q?nhSkLk2YKzM2OJ5geF00T4N+KF+Bg5dwqWk6a3oiMyfw9BqJoCBsVDXmXMEi?=
 =?us-ascii?Q?Q8sOQx715Xe7KzuPjqxJYvy4pO+kbaP1kFpYTJNEu1Rm51mhHxPyD70uNFkA?=
 =?us-ascii?Q?OG37VyfsD/aRtb9obZJx0nVVO8YCaVjVXbmeGwngvV+fO4bgcgf8KjLLa4P9?=
 =?us-ascii?Q?QR3o/fkUjGjD377eAFYldAuWMK0ugXx6jILOFbi2d2c88T6NEcdlmWhESrOv?=
 =?us-ascii?Q?z+xw/i/ID+tUIOb5lLyiycD2f8Zlat33nHcmGmxNaOmqUxYVpx/vun/vH+SJ?=
 =?us-ascii?Q?i+Ox/ZbziOaeGy7vulxL0iqUXEi4WkENQMqT6z8ePimQnqTYg4kP6hlHjhTR?=
 =?us-ascii?Q?hA3f+i551kqcZvE8A2WDwj2UugEDYQcwkgbxUsTPI/QwdLTWIQoEI0TGei6t?=
 =?us-ascii?Q?6Q+dfdCebYK7He33DE9ptdDwMEm8Dmvuvc8mQOzdYt3pjdGZLM5hGo5HelYC?=
 =?us-ascii?Q?IWAQJcjEceu7HPCKgegDbiHq/dmR06uFXLZVF/xuaiTu7orbAogsC4uT5X3K?=
 =?us-ascii?Q?lVvx+r7aMdsDapjzbPAbx8wTiAtLeq6jpp20dq5h7kDZqJxa8GzJjmylrpgn?=
 =?us-ascii?Q?IgNr1JhndU92qo0VAxznMBLycFKipyg5HMQZlt/cmk8jp+d7qUSxJSC5Ix/Z?=
 =?us-ascii?Q?L2/n9YHr7QhVGLhOcMlK4obEV/YAqP21691SX7c8Aku6JU0mnSixbJwV6VYN?=
 =?us-ascii?Q?BQDvi+7FzVIOsw7czkPcyqLUTtLA/dT7OFtMAOXLZEWAWdpg2dFTz1OHiJh7?=
 =?us-ascii?Q?o9/FqQvlFzfg3LcNdOjljQEajRf94CTX5UuVqmFRt39VIsgVeHyNEKrxpBg/?=
 =?us-ascii?Q?asG9mQiBlwDxtK2WQCwEWN/R6K/ZHKJt5JGCt1FDrejgDwaeJqIkXQR+pwpA?=
 =?us-ascii?Q?LKrWVFwGRdQ7CI0OGVGFlPwnB2TNv0aZvPaYnHJapWMQJE/rDNKLXndDETZt?=
 =?us-ascii?Q?+2ZWrxvPl6jbguapi9aT96CuXZjo1syz664IuGIAQFwbOZvoZaOsl3fWpcWm?=
 =?us-ascii?Q?UzcYGlhwbWeMFu1e6A/qmec2qG1N5ziXJbICeIZ9UvogWu37MxySTblZ+Bev?=
 =?us-ascii?Q?strR/FqpzfRNVUWxxmiDOhU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA339EA37B47A34DBBD9D15F4B1CEF89@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PG9ZS9SsRJR5HocjVcUD7xy6l6sdUcaxdj4LPGTTSvbyKicuAfuYdO4bnByxk/vO263d4DazVY13q4DRU5cVVROrXFeShDJFPqX1PBRPN0ggYFlFTEbK+O52oUVFGiU51hrceOrEtjLahZSJ76JNpij/jFWTlPkTLCindH85//AReFZZKKnVg/Okrd7cjM7Rre/ePUwKHcYARJiMX331tbNWxvqsEbOhkZ4UaLB3UBLMRsm5wtJ5C0zBY02XNcuTTR/UsMuaSL+hwHogZsFsGpaSwHNOIj439pG++jWHoInFDaj7mjKZgyC6IEeIQ8xHbWkscFK7YfCRqOtI91UsEnqHV4gWJbPkJRaRVm1LG8UIJ8WaZJSecXRWSb7g5hichieuoHct30uytCk5RnbKzQZ0rDX933c5ZaFJTflYdM4+ZU9LbnStNjiIjKCFQqavGPtpoba1+ntIpih0u1ztbdM4QvRgMVbRdZqCROLg3z7xLIzokCymO8s7vmO9qUu+fqaMbkTppb96aEQWqBRhVeZPpZQqKMq+sEFan6DAXRZzcaoShmvg0RpvJeQv0efJNywxWQaNw4+Ple+KKfthUXnCstcEuhRr4j0LG2z9Q9QnnVMbKqu0dnuwzNF8x6vc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d80c9e5-1477-4ada-56d2-08dc5adf2466
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 10:56:01.4300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5h9sMY2u7a9bS4+T6qzc/3YjV5Bw9oQacROH0MZY4BTp4AqUE5aAIQRcqxk2tw0nlMAG0g6OKHUx5Skfo7yNByIh1R+D15+kT8mY89tH2jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8706

On Apr 11, 2024 / 20:41, Daniel Wagner wrote:
> On Thu, Apr 11, 2024 at 08:12:22PM +0900, Shin'ichiro Kawasaki wrote:
> > Some of the test cases in nvme test group can be run under various nvme
> > target transport types. The configuration parameter nvme_trtype
> > specifies the transport to use. But this configuration method has two
> > drawbacks. Firstly, the blktests check script needs to be invoked
> > multiple times to cover multiple transport types. Secondly, the test
> > cases irrelevant to the transport types are executed exactly same
> > conditions in the multiple blktests runs.
> >=20
> > To avoid the drawbacks, introduce new configuration parameter
> > NVMET_TR_TYPES. This is an array, and multiple transport types can
> > be set like:
> >=20
> >     NVMET_TR_TYPES=3D(loop tcp)
> >=20
> > Also introduce _nvmet_set_nvme_trtype() which can be called from the
> > set_conditions() hook of the transport type dependent test cases.
> > Blktests will repeat the test case as many as the number of elements in
> > NVMET_TR_TYPES, and set nvme_trtype for each test case run.
>=20
> I suggest to keep the naming of the variable consistent, e.g.
> NVMET_TRTYPES.

I see. I can think of NVME_TRTYPES and NVMET_TRTYPES, and I'm fine with
both. If there is no other voice, I will rename to NVMET_TRTYPES.
