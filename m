Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E060381D9
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 05:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713244866; cv=fail; b=njECx/WaLoAwxeahU2PoRr5romNUrkMNJZgA8zfMiL9CquycGN6Bx/D80CWeYlWoiN3cveEQ78ro9EKWfUrP8ASmmBn9tFJmHtbEeoa6pcyKxOienwLlskU0MBpKHVOsbh9eDMbozpfSZIU7nT/fx7ED9LErbZr51MeNPRq74Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713244866; c=relaxed/simple;
	bh=m3SPKQUCu/67re4BofhVODOR7cd4rAYZPxAK1wx76s0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KG2yZkuIfaQ7Ro4YAu+Yys3jRcCL9u6axXic2mQ3NOh/9+ZJGBHRS1E4nZqidw86x7EKMQIV/TKRX5gM/Af49p0LAMrM+Ro4+CIRKKIceTi7RfgQZaT6ZKwc+n4E9av9p/UV8e+vNLCNQ2ZDUf48cXCOIDLAjeg0YGIA12kjQM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=n++WTyex; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Gn3Lh1ZW; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n++WTyex";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Gn3Lh1ZW"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713244864; x=1744780864;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m3SPKQUCu/67re4BofhVODOR7cd4rAYZPxAK1wx76s0=;
  b=n++WTyexH4Ma4QTFSV1Ail15QjpoA+huGZnKtywnS2uaJzoXohvkhtEI
   hQw9amybCK1TjkTG5KWFsDQEQykg6s9bLSPTm9IqS7lYBZxiBzAQCH9HN
   M56feeAkz6R0X0o8UYa8bKYJPke25ZqvnvbW8XbrdX9aHz9xMchExeJic
   K3iorEWDWNf/YVE5GNEO10fE8PtSh2B1F5rFWkI5+B3rM6KPXorODVpzP
   alE1U63q28WNvd3Ji+iybpIJXlLBV9QhNe/t+Rgxyvfb6VbK28P73e4ke
   QQDtYbqwQ2eq/vFd6Cv0XZ/2iNtiDOYwbOaBaIkatuWrRfVl0wkQS/+Eg
   Q==;
X-CSE-ConnectionGUID: AmjWCuEyQCKvw0bmg863WA==
X-CSE-MsgGUID: RssAhezETY6utRZUjGsb5A==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14777676"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 13:20:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3ZB448+xWtAQscIzCsg74BVq3+1/+GC3hEnfP2Azn//mFZsPosZ7ihtswFA08yOmc+mHT9vaRdHa+NOy21oaE/MsZDumloqiuJsHW4G6/DWqwUVapvvGfXEoEL+IyWAewu04VBJKrds15JRo6QfY0LgLHrgdQppwv91iFMRObdadPlDLK/2tQMgtqA3RPVp9h7guQo//VG/GE4B5dO+PODEQTOkqx+VMvplVR34V98jtMgU7hYG/iVddeuo3Viq7H+vTwDeAYQpB6A2C3E/mFGlHOszcQ64ZXkW7RAhH4/SxZk9IHJciGl8cSCD8qw++mev+KS2dxtCm6siXYZSjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7DuXlRBu7Dppi+6SY46S2TzSZkthgQDshYvgx+Sjt0=;
 b=ltrC5ctCNLbW9xFg5Bn9Y3lIn3zXKVAP+5BD6T0imhm4nG2hS/5ypp35GWMHIgUCckTf/KOr0ywg/RsM/nQji/mVuJ/vpCWsy23gINa6aJBqIk1PoVaCZyYI8Uzij24RxBXcGhD1onXuTftSXwDjtsAWVNP1PxTpRq1oSoMDaTLvRhhYJjFPmXaR7Qg8ftVFPy7H7TjgciwFv0l79qjEWcluwaVu24AQr+vxIIWD3S1o72FsyzCqdPy72Dm9/R2wDVXyeB9Eq87n45VGQbjudKl9KxfQUBc3Jg+LqBc+DAxEis1KXOHaQLhg/mfjbCiZnBY/6ECF70HTpFj9n8FPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7DuXlRBu7Dppi+6SY46S2TzSZkthgQDshYvgx+Sjt0=;
 b=Gn3Lh1ZWyUd34z62FYhCvNBPSp3Uf5p34rsw1YlR+qqaOR2YvKUq+4Pth+AbKnmREXPgjBov68gAI8gtYQ46oH+Qn6eXFFTkw00A/zE0kxXuh0IKhqJ0UQlBu5ijkkLee3MlPKSv9z21Fc9PnKXC9E/SbsnlxOH8oqZ9kR6pWRY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA1PR04MB8466.namprd04.prod.outlook.com (2603:10b6:806:33b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 05:20:54 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 05:20:54 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel
 Wagner <dwagern@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Topic: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Index: AQHaj73aHKCgSe6kfEa5k1xtmLrU0g==
Date: Tue, 16 Apr 2024 05:20:54 +0000
Message-ID: <7okerxv2q5k6d2jl4ehdvido37rmycxopqalkt3xcouxeuxxe7@q73je25fv33y>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA1PR04MB8466:EE_
x-ms-office365-filtering-correlation-id: 68e38890-a38f-48ba-a89c-08dc5dd4fd4a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zWXDD2nJfB0WnwQcr0JoaNDAt6fMTOv+SF3oCmFTua0+FxLVbKH1ycRhHpyYDi0THenaX23PhiRD82VqCJaanSjU7RV33UrDseVvizpEOBl0QnhlLcvahm1fHAqiKvSI7n9f2DRJkuiSoqg3Y4vam0cTzNN1zRQD2UinA57v73ifJvwo7EeE26sLWCo/FgO3BoxTV/18ThPs8mEI24JGV7wM9pkCgqwbjksBBWxuTOfdHLK45G2yAwhxlxIXnftsgVbXEGVNpiOAHbHTSICr5pB+GWKNzE9/Zs0u861t8VvdPBLtWJ3usvTs+rBlT7tqeCgAuPD/o2czWFi5mXABxIfPi2Zkf+CuZgeYOpY5RhWhZH4pO3P/NmemvcIWnXd33okIA7j9bCwi+v8v+wfBeJl2pzE/x/JXt4L/6vfbU/kiVnpcL0I0eoh2Gi7ksvg/9/EBgdee7nllxTEKpTWIZhLPr8rnfp+1oE0KGFetxJUQAgVsye86JPPWyFzD0m6OyG1DZ+50PluM+Q8UWaK4fSTmNvXuZJm8d/2VrOGcgQIJKbryhgCFKakNN6bVkaugvsrwvFX2UjhlGVB4jBfxUGh7VHeOF4NTGXFYJiFLSFsELi/QhgWG8OSXZv+bGAqd15pbJvk5oSabzwqtUuTIVLKsr2ipJ5Z6AJBoT0TA8Rqct/HA88kubmZTWrbcMDpKOLPWVEhCSARoYOH2nvJ1raQL59YQrrF3vYDRGq0Gj/o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xsfZWlJaTfwLYZX5jm0lTtyYxHY8h6PELXQqiCiP/k1yzO2ytxzn3FEuauy8?=
 =?us-ascii?Q?xY9Ijsxvb2N6ZVoxCRG6j9uL82x9OfSYLPXmI7zbU9gpwbBeXjGQjuarkGtu?=
 =?us-ascii?Q?8WF+LWFf5BF4L30+ktNJgG+Oozb3FFmZOZsungSxVZjhA3xDuXTww7UAxY9I?=
 =?us-ascii?Q?qW21D7aeRgu6c2Zta9jnOQTuyt48UO3OXsETDsU7FIxJFpukDixsyWSPPbih?=
 =?us-ascii?Q?Pjeu+Bnquku+jVR08Oz5smAA7xAWyNtdh14Am8jIkZL4SHl0EqER9umHM+QF?=
 =?us-ascii?Q?i7Cx0fEWXZ9SgW8xgc7YBzb2HVRMxZVEG0+Xb6yQ2SQ0XxuV9yBvMNVAMAtJ?=
 =?us-ascii?Q?S5lmyBnhgyKGsVeARGPI+csHLcxqDcOMclbG4HUskSOTJURzUCkcTl/1FWT4?=
 =?us-ascii?Q?UWLMn25as8wA5B5ITZI9piSkea/eRHO76yj3PNeEf0y5rLR/v5LnbMQeisKi?=
 =?us-ascii?Q?1PNsKFdqtckWZhx5FJb3BqtDStSp0F8GVJAgNJhS8Cbqk6blURaij2gm1RzL?=
 =?us-ascii?Q?Y6UzMmqzvy291LZC66lmrxU7zy54AVyKsMxi/RiJtFmUpxNBFAx3FhRqKpjC?=
 =?us-ascii?Q?5/aKIgfN+ePf3qduw7Dcum7t/OrH3C6R6X/AxJd+zyD1RhySnhFDR/iaS+QG?=
 =?us-ascii?Q?EMnRtqj3HEpuRq8c9h1JFahAs3k3fEAziHP3407WzbZnIy6JGobJWLs4sVFC?=
 =?us-ascii?Q?Pr8rpTD+cob0UkvCYE1ZXWWlR7hrxYmN4I8zc3GWE0x4V1py51RxE4qkQ1r8?=
 =?us-ascii?Q?QXVUs+oUAkcV1OLKg7EOzwaUsZpB0H5SIMj5DhjRiosxYVq2FNECrj2BK4YV?=
 =?us-ascii?Q?Th4njFdQ0uZyJwQtSGiRm+po4O6XdNGK2BggEh2k0ZI9P5TeZigRoMQlaCKk?=
 =?us-ascii?Q?aGyp5nsUgzXltLzCg2/CC5NqyjnCfXjNLnpfyXYPR/xMfMFFo2HMiPBbZDPk?=
 =?us-ascii?Q?eK84uyBTyZsV1Uef9pvM2TY95YV6q39lLYwXAEKpv2ZrMKIr2DCSLUqitqBY?=
 =?us-ascii?Q?M96Va7ugq9bPj8sDzFeCmHnhBgjx3hugANAuLXFgFhFOWYofinvZTZCGzJtx?=
 =?us-ascii?Q?YiHPvZXXf8on8uDcfgSYptJZ+rRAjHY180aKTQhb14ZO7cdLO+jNrDLwy+6O?=
 =?us-ascii?Q?eUYw3DfNb1PJqYqNRLxLPNc6kJyCA0cOYAv5Lji22pSUsxUZtollhvmpQTzy?=
 =?us-ascii?Q?A6QxiRWxDjMN6y5h6MJPk8LZnH49ASlOanxvAOh7KwBRSaOLX518RihkCGkm?=
 =?us-ascii?Q?ZNFkjVK7c3n8l6we1g6HVnNcypCEm4ZzomPAHTWiDLiNhDow21Y+EIXoaFh4?=
 =?us-ascii?Q?dWR2WCvTqfJ8WyHnGv06X5uR99bvPSq9bIMR9DjJTKfCWuSU8o/zMbRDfJFE?=
 =?us-ascii?Q?F8gy6XQyHc+ISP3K0JjFRnHwZRvgcxeqeMEUzhjn6QDiuWPCTmSbJXhdSbyN?=
 =?us-ascii?Q?USHpeymeP4aEhd1Sqaie9wl+4rf5hGjcXvKVuobWvroaaFOeOzf/ghdy/RXD?=
 =?us-ascii?Q?CUxBRtqHUQ5zeR3KXb3ZUgBrD+mpZsl1KbibMNgL1V/XqeBZo2O/kcKHT2QE?=
 =?us-ascii?Q?VE9fGFx/ocHbCP58BYlmTmldTwd/m7GV9qpibQtrH6AEsyjzDDoLpmNvSWX/?=
 =?us-ascii?Q?/pk4Jv962PoKyjH1eiP/gQc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <884553339DF62F499DE15E91D4CAA8C4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HYkrhHrfUDGHlCdef0CIKr8xdfezjnWP4sezfgQmc5PPtb0yH3Xg1WkCb8d4HJnpq3BuThxNfKyAJAnDzxGLwmX9p6xYtLuKakKt51DzGLbhtF3ctg7i3HjpRTYkZefvmqMLnUvezaT125HUeVfr0vORF8tiG1bTteTGtsOzRYwQF4KiE9sGB+mamxBtLYhe5tS+m6sXQhYphhXkWnKJTkxbQYJ7VVgw2k08fGyIP/5nxTb15EmJr+5ZIrH0xcH0bnOa2k2jm/nYIHnyYPfypcsb08TNbv6PslyjpRZVFKrIfY0YW0ylAmBYBhxhNr/9Z1U3f5CvVYHDvH3lseq89l+kUQwvIAWWVXvZTRXlr39zOs8+odGOxAt+bJ9IQtmPty2mfv/rz0NvQZ0CoHfmNJnc5XE6WaxawDcGEt6IBgkI4256bEEc5b1VcHMPAVNBLSyHFLg97mno2J1FKCPrQfLOlU43K029y41O1iRHyyIk2k93tOrhk0QPz9iDDfErVNMe5B5/yUshiE1Qv+O68627o+40KF02ZXPAowoluW2o7wVu/cfuMPJCr008jmr2uts9VnhIX0ZbeQpy9Y7ms0yohvr4dlSvTn78mzXBotmGLU0pj/TzZYHsAYR9mQx0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e38890-a38f-48ba-a89c-08dc5dd4fd4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 05:20:54.3157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iIsZJdcpIWtMYYOk2oM0F8j3VGoTzCdmwOvfAKriBQken5fWljmbTDz3PAeyJfN2ZLOI7sXVM8zcYy0tHezvLFDLSvAYZGykzhWhRj9Uggg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8466

On Apr 11, 2024 / 20:12, Shin'ichiro Kawasaki wrote:
> Some of the test cases in nvme test group can be run under various nvme
> target transport types. The configuration parameter nvme_trtype
> specifies the transport to use. But this configuration method has two
> drawbacks. Firstly, the blktests check script needs to be invoked
> multiple times to cover multiple transport types. Secondly, the test
> cases irrelevant to the transport types are executed exactly same
> conditions in the multiple blktests runs.
>=20
> To avoid the drawbacks, introduce new configuration parameter
> NVMET_TR_TYPES. This is an array, and multiple transport types can
> be set like:
>=20
>     NVMET_TR_TYPES=3D(loop tcp)
>=20
> Also introduce _nvmet_set_nvme_trtype() which can be called from the
> set_conditions() hook of the transport type dependent test cases.
> Blktests will repeat the test case as many as the number of elements in
> NVMET_TR_TYPES, and set nvme_trtype for each test case run.
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  Documentation/running-tests.md |  6 +++++-
>  tests/nvme/rc                  | 30 +++++++++++++++++++++++++++++-
>  2 files changed, 34 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/running-tests.md b/Documentation/running-tests=
.md
> index ae80860..ede3a81 100644
> --- a/Documentation/running-tests.md
> +++ b/Documentation/running-tests.md
> @@ -102,8 +102,12 @@ RUN_ZONED_TESTS=3D1
> =20
>  The NVMe tests can be additionally parameterized via environment variabl=
es.
> =20
> +- NVMET_TR_TYPES (array)
> +  Set up NVME target backends with the specified transport.
> +  Valid elements are 'loop', 'tcp', 'rdma' and 'fc'. Default value is '(=
loop)'.
>  - nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
> -  Run the tests with the given transport.
> +  Run the tests with the given transport. This parameter is still usable=
 but
> +  replaced with NVMET_TR_TYPES. Use NVMET_TR_TYPES instead.

I noticed that nvme_trtype is still useful. nvmet_trtypes can be set in bot=
h in
the config file and the command line. But NVMET_TRTYPES can be set in the c=
onfig
file only, because bash does not support setting arrays in the command line=
.

  # nvme_trtypes=3Drdma ./check nvme/006     ... works
  # NVMET_TRTYPES=3D(rdma) ./check nvme/006  ... does not work

I will modify the descriptions above in the v2 series to note that both
nvme_trtype and NVMET_TRTYPES are supported and usable.

>  - nvme_img_size: '1G' (default)
>    Run the tests with given image size in bytes. 'm', 'M', 'g'
>  	and 'G' postfix are supported.
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 1f5ff44..df6bf77 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -18,10 +18,38 @@ def_hostid=3D"0f01fb42-9f7f-4856-b0b3-51e60b8de349"
>  def_hostnqn=3D"nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
>  export def_subsysnqn=3D"blktests-subsystem-1"
>  export def_subsys_uuid=3D"91fdba0d-f87b-4c25-b80f-db7be1418b9e"
> -nvme_trtype=3D${nvme_trtype:-"loop"}
>  nvme_img_size=3D${nvme_img_size:-"1G"}
>  nvme_num_iter=3D${nvme_num_iter:-"1000"}
> =20
> +# Check consistency of NVMET_TR_TYPES and nvme_trtype configurations.
> +# If neither is configured, set the default value.
> +first_call=3D${first_call:-1}
> +if ((first_call)); then
> +	if [[ -n $nvme_trtype ]]; then
> +		if [[ -n $NVMET_TR_TYPES ]]; then
> +			echo "Both nvme_trtype and NVMET_TR_TYPES are specified"
> +			exit 1
> +		fi
> +		NVMET_TR_TYPES=3D("$nvme_trtype")
> +	elif [[ -z ${NVMET_TR_TYPES[*]} ]]; then
> +		nvme_trtype=3D"loop"
> +		NVMET_TR_TYPES=3D("$nvme_trtype")
> +	fi
> +	first_call=3D0
> +fi
> +
> +_set_nvme_trtype() {
> +	local index=3D$1
> +
> +	if [[ -z $index ]]; then
> +		echo ${#NVMET_TR_TYPES[@]}
> +		return
> +	fi
> +
> +	nvme_trtype=3D${NVMET_TR_TYPES[index]}
> +	COND_DESC=3D"nvmet tr=3D${nvme_trtype}"
> +}
> +
>  # TMPDIR can not be referred out of test() or test_device() context. Ins=
tead of
>  # global variable def_flie_path, use this getter function.
>  _nvme_def_file_path() {
> --=20
> 2.44.0
> =
