Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B138526E
	for <linux-block@vger.kernel.org>; Tue, 16 Apr 2024 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713263340; cv=fail; b=eIefqQQha5pVpVYARlopEhuvT8MK+PqPR83qCmJJVr1NPSrt8hUVdk1QRKKbKLPnDOmuB/fGa5CmKfPrOBKJbPJcMXpInAtUgCiXzX7/1v/WyjqPtApCg2T0TJcLhjsBLgM3KSaw/7waCMGzafolORRY5/6VOet4HXuww3fgu7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713263340; c=relaxed/simple;
	bh=TUaSe170cWc0NhN6SrDfHDZ/5WoqOt5+FguA81aXt/0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=scYfw72fFUTYdOifBMTU0zghmDYBkF43JYkq9OA0apanPjAL+RA7nHvTTQxCeJRl+ZZAzfe3KC3pkWGVb3kFflokzMgi7oihI6aidaAf1UtB1Fttm505agMvTsfpkomWmfPl3Yf3jDwxJUo3/JXzcfGvh9Z2itxf+UVIjsAVzsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bu2e7vXI; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=u2qWg5Tc; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bu2e7vXI";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="u2qWg5Tc"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263338; x=1744799338;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TUaSe170cWc0NhN6SrDfHDZ/5WoqOt5+FguA81aXt/0=;
  b=bu2e7vXISaJnJIGiRQ8QlhM99jfldInce1Ria2qXgnCOULaQW4mu7UKQ
   bjjgO/Y4t71fhMvMSGsuLgRsw0sKfsJhmNdFLiqiMhvkRMrYCCHUyP7ap
   QcZEsUYubUphu6mn42w6/Mtmwp35qfhgdJxdwUXjA1bIex1c4ge3C5NNc
   Bou+fUPmbux7zOL2CECPwXhz3NC0NMc6a5D8fNzJ7gyCJhkpRRVSrcsob
   2izzsDTLng1KU63vfZ0yuF7ZZIS1S+Ya6V+lwKqTVdZ51RiCW3hlvzl2V
   pjGHMPGBaP51D7kS/2zlOg3+RJfN3DolWE7fvtsTDar0P9kR/ftuWUfi/
   Q==;
X-CSE-ConnectionGUID: DCZY1jMJQ06IQsDqqWIXIQ==
X-CSE-MsgGUID: vp8QF1qlT+KTJuTMiusdww==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14085493"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:28:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nzuchqqWThU/uB1oUNkgT0IQYOgmKUesPRxphu+HttCo5ysdJeMv1vwWWfwQgSa02+Meh2BeMy5B8VIUx09c0Ar72fJSjX6zBeT3o648P1w6Vsa4832Q8Rw3pgWCrbW5kBuABkojzlFaQpZek249bfO0hp8MJxmawGa4ZOrgwbKbaBb3Bu3L7WD8IitBrGz+yU6oOnvWAJH1tb3wfYGouowVl6GjvZDatOVidpEkS7J4+R/PR2ubbT2kpuI9BV/w6LE3Ac/cHd2XsDH2dZ3VMKujimR6YvRCwrLu/LnwjB8k3xE9aw4IjBcjiDcbAa5k4ZOUDX1pi/WU3oFMiC8L6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjEYhlsuiB7lPDrufz5aaFf7jf+BCDviKDzftOPtfsc=;
 b=dIGDvO/FPUpZ95R66zRrR1t+lXbc0/CIqRi3v01tnwGEr9dubia0ezbO1YLIosQ2xRErKXMRtXFxY+DqNoAJ/eiYo3p1q55xhQccBegQv0dHm1FO1VSAR+b/TH19fMEpIfkMs/zligI96scw9rFPDdM/5RyvQH/iKrNDaDmw4Jqj8MrZOKHRNdo2flMXJjxXt3ljsPdmoZZSbyN6puz9nWRbLmGEKX+qBp/B/7ncSi82XYKiMRiQmZdjIlaMUPhLzquQlUYUIyDwqawA+PByM256WplqglY8p4YRk2Xy9+/r29e3sJtWh6SfEb3JkEQIwyfQsHercDGZw/UePji8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjEYhlsuiB7lPDrufz5aaFf7jf+BCDviKDzftOPtfsc=;
 b=u2qWg5Tce6CvOxYqZYd+iGyPVTPxSx1VtTV24kaXRzbF8Mbei7tdl6hW+6w9Q59xAK4jSLvjIcDJsXYlXe3Jh5VWpVvXyLRbr/IcHZOUbENcXZUXlGQlamhW3c+E8PtnrY589ZAF94hTq/MeDo7/5TL8PlXv4qCP2ipirpkB4EY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA0PR04MB7436.namprd04.prod.outlook.com (2603:10b6:806:e0::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Tue, 16 Apr 2024 10:28:49 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 10:28:49 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel
 Wagner <dwagern@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Topic: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Index: AQHaj73aHKCgSe6kfEa5k1xtmLrU0rFqskAA
Date: Tue, 16 Apr 2024 10:28:49 +0000
Message-ID: <x5xlzl6g3riybq4uuoznt47yp2ieixtltq2sw7w5uodpcosln5@pmx2vne4qgjq>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
 <7okerxv2q5k6d2jl4ehdvido37rmycxopqalkt3xcouxeuxxe7@q73je25fv33y>
In-Reply-To: <7okerxv2q5k6d2jl4ehdvido37rmycxopqalkt3xcouxeuxxe7@q73je25fv33y>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA0PR04MB7436:EE_
x-ms-office365-filtering-correlation-id: 9abb7ed2-30e3-40af-c9d0-08dc5e000139
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xUqfYBBxV0UE5yHWp3i2YXeyT1At7VFgfu0R8hY97WDOKLCkqEXFyfuECp40mvD7qHyqHUr4B3O9O7KLL+kP8/vfv1WxNdy0ubURH/wCF0nUssAZA5qcUWJq4Tz80ycnAsk+zIjorMcw7aak6VVEoLMxXHJKX5xdYvg2N66H0eyzHufJGe6Fq1L7awJ9yPzBa4snNQrLjRYHk9OM9EVGctieXQyqGYSWyQulS1wwHiLlnxMQBhfxyqfR6AMXg6Tnn28wcGeuF+jNrMPN+9ZTYj0to+MRLR09pO90H7+dlfvX2V3oTm7RPrJ7Um+Nk1e++BpGlimUFRKO8Y37gnR1klgfVs6DB4TVwQuC9sPTfAmGwNiCr7QxTjFPTMsuVMnywafyFBW+pwmm451vpssDsFYxsjX3VoUzQU67Nd0Xz9sFby4zh64FzZHxwFqJimyfKv+6Ouet4FFwvN9eBVBHgrmTebimjOsXgSJv3QCLPwHyfxkuItE9L9ftU+LJkRqQ9Rvf+lgWwSTgeSMI1UOiBmJYOUxOyLEUYPlFP/Hy9xp4WQWrS0cu5Zxh/q4b7QBNwGISqvSb+w+xOVBVpJAI1r0wj5KbLos6wnyYs+eYsEpjTJue6t/bOuoFJGKEnpH+LDPveDbfMBoxqDc3fRB/eCboTYU2XZYy21mqG7lt2mvhQxu4d9AcnuHc+Vcm9zmvXZB6mvaOv1Hh+HGezK+Mq7dhs95V2ELjyyX9yzWFYNg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0r69Qr4VFQgtccjmMnXL+0nrYXZvDkAJ0Wm31KaDumxXteTPHRuI7u9Ff+5q?=
 =?us-ascii?Q?WrQNyb8fhw2WQmTERgdiH6eS9Ly2o4WZENeIKVspak2d5cLOlyp5qtlLh7Qi?=
 =?us-ascii?Q?s3AWGwZ726KjvcnEVBhkvZEURqGLwe1pK2FzfNYhyzbgej2dbt1rZHcexS8c?=
 =?us-ascii?Q?vfAvJA5IbV+POPq52CWPsRgF0kmZDcAkrXUhsWj0LaVEegkgP/j1H9pTwhtq?=
 =?us-ascii?Q?iEaS4C4V3oTCWHe8JgDdE24uN7bFB+tybOn2b7xlOvpazpEw7zgTFRmFGNWx?=
 =?us-ascii?Q?lyQH/+RkO5WSfTpwTD8HmgVa1RFtFUgImFxm15a9bIozMzCp+bjBfJ3rg0nF?=
 =?us-ascii?Q?6IOmAVsWjTjbPtFFOnT7NcTuPPJlisp9300RezZNYErYZFJ78tOVmlTWMONr?=
 =?us-ascii?Q?k8RIALROEI0xpvcsJmRiLMzNZiNDXE+cAFJ01+D2e0qaowGvZmWsBaI8Ax/0?=
 =?us-ascii?Q?/NQSiq1hSlaO2P6u6f2ROBnuzI3+AZ3Fdl1Q/ejqs/8FI83OnmmgHBmxGn49?=
 =?us-ascii?Q?M2yZ5IZ6cFbRTOEyJAkUfRBB+JuB3tPppCjK6z3WFUOLDM9bmI8J+lIycs5h?=
 =?us-ascii?Q?ww69b4BzplBbmt9oE2Lives7rH6ya0DDCmeLsqtT8UYXP0ymgwSZW/AW4TKH?=
 =?us-ascii?Q?G33Px9X8BIkbpfSPFU68TorMsjM5oTlexldTQicl8spJ4zAMHcTtkXKk/fvS?=
 =?us-ascii?Q?ks9+xiBQwbTVz3/HVZ23hhoC6jZ2SljXmHj7kBNUVJaak3VL0nyGT5ILTuEk?=
 =?us-ascii?Q?9BzIdAP0w150x3q9BZVk5M4gLyN6zN4kiCrGXuBfc8Ffnv7YURLVyhi4ZSUK?=
 =?us-ascii?Q?wWgqPoUkYVQWI2sPR3IhLM5RQjDVccflSBv67Pf+Mh5npRU9LPgdhEgCw2tN?=
 =?us-ascii?Q?dX3SBYL5Q63wEkGiF8dqygTZAuaHkjBwSfdMVOvoS5MpT+gAIhotyAvTvSGy?=
 =?us-ascii?Q?36204M3c0badeQ0X/en4PAVBsfjkkBbW1jEQV+FThiSt1bjZS18EOq/rHaLk?=
 =?us-ascii?Q?OWXCp9g4nhheF4WHt69RDkHtzcqF1y7fkIq5bRBGvQ/WHy9/lLXY+PvjpP2H?=
 =?us-ascii?Q?ncZxSyJ/xjBwiGNCr7zPwgifDqEL/xznODIxxZODGK8+SD1QZwYJcPPhW+PA?=
 =?us-ascii?Q?3+Od5F38STdMcDrX658Myr0oMIvoYHC5JVEKuxt063PhSY4zTN/jcWnQEqGD?=
 =?us-ascii?Q?KyJTxYlklKUQ38isho1vvyzox98gcaFda2FMOREqob2F+b76DF/ikvSPmetl?=
 =?us-ascii?Q?HnH+dwzbsOj/0wRo2G+OxkdMXv5DNx9R8ilUsJTA/3agURxr65v7hO2ZuewG?=
 =?us-ascii?Q?TglroXqwW/bwmZkvgEJIVH9zLz1vwqI7aOnZelyA5rNMBsNsmb3VO+vJC+E2?=
 =?us-ascii?Q?XrAU9IiMvJyH4kvj3OV6HklDlOTXcJ7Hi+Tt3w/Khczut+lizc+BSsnQOV60?=
 =?us-ascii?Q?FXq/UaIbav6PZXRefugTgFYL/9FHLWtly28mbBQLY4YYADYMA+rnUbdb3H+E?=
 =?us-ascii?Q?w3kajuVKIa4ePwd1+Up8CpSJ72T9O/2J33LMzCclgRGVQJ84fRncj1Gl409z?=
 =?us-ascii?Q?mqu9Pgm9Qbc+/bPt5yxd/iNcHOo5fassJtPRFU7HKXZ+LDmVjVFYETewNJPG?=
 =?us-ascii?Q?39zGijoI77vRH7Tj+Z2uIDo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EB01A5EACF95214B99B5BA2F72700D0A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MYCauYiUvc7OtE3FGlvECmeb8DVXlCRpsgus+NhdLC4/e26nlql3y0PPPsv5vvk2Uw5vrEaIgN/wxGmI7TNYDU9+UzZbBXTMeG9onF1EgZGymCiY02haLvd4uZYnu8LiUqJm3PMDxg+7g33R4Kk6pvE55nXxy7Uoxmc1UZB5M5i6SndZfG/ugLdt8R2plN4GRtdR3RYPRLcyeSOo+yXw2EIH72H919GWhpWT0kwmGU7gFFUB9zDvPgLt+BqbZUT9L78YolcCHkqR+YBdS9a0TkmA79SdtwuV4Jip+5RHUp9WtO9n09Lp2kbyi/C1ZL23qSjWELKCAM25lpRIJvCYqmQvOyXLQ1KiRerpYMW/ZrRRCdtwzjpt1nf+UhNZ2ns5WuI28jYZti/B1P+ESrdpu13OFj8h6N7BtTCxuhOFYbp8Ej3fPa6U6hYCZpoodtdoqCywlJYMiEVx1kePa7R8zA9mYsHRt6FSWVPO/y0ydNiP9amZjP1byobyETWHRJT7AjBdn2aAv93tDLRHKGXyjLXBwaZL4H7LohN6FxMCCWtP3h/ZHD1paIm6NAVWmBdrVMDvOw6tON5ew2aBbSkOpJPOLq+KmxMlWXKP8p9fecTWmXXh0ZyFcx6T1Nbe9Eyp
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9abb7ed2-30e3-40af-c9d0-08dc5e000139
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 10:28:49.3119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /EvGdljhPSRHqxI+iApaZmlUPDwDkz3F0Lgw/DFrW5BsDAxnoELbD8QsD/LIakxeEn9o4P7dGtnYnoNzkAEi+oMMCBDrWFck26Aq4vr2kP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7436

On Apr 16, 2024 / 05:20, Shinichiro Kawasaki wrote:
> On Apr 11, 2024 / 20:12, Shin'ichiro Kawasaki wrote:
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
> >=20
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >  Documentation/running-tests.md |  6 +++++-
> >  tests/nvme/rc                  | 30 +++++++++++++++++++++++++++++-
> >  2 files changed, 34 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/running-tests.md b/Documentation/running-tes=
ts.md
> > index ae80860..ede3a81 100644
> > --- a/Documentation/running-tests.md
> > +++ b/Documentation/running-tests.md
> > @@ -102,8 +102,12 @@ RUN_ZONED_TESTS=3D1
> > =20
> >  The NVMe tests can be additionally parameterized via environment varia=
bles.
> > =20
> > +- NVMET_TR_TYPES (array)
> > +  Set up NVME target backends with the specified transport.
> > +  Valid elements are 'loop', 'tcp', 'rdma' and 'fc'. Default value is =
'(loop)'.
> >  - nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
> > -  Run the tests with the given transport.
> > +  Run the tests with the given transport. This parameter is still usab=
le but
> > +  replaced with NVMET_TR_TYPES. Use NVMET_TR_TYPES instead.
>=20
> I noticed that nvme_trtype is still useful. nvmet_trtypes can be set in b=
oth in
> the config file and the command line. But NVMET_TRTYPES can be set in the=
 config
> file only, because bash does not support setting arrays in the command li=
ne.
>=20
>   # nvme_trtypes=3Drdma ./check nvme/006     ... works
>   # NVMET_TRTYPES=3D(rdma) ./check nvme/006  ... does not work
>=20
> I will modify the descriptions above in the v2 series to note that both
> nvme_trtype and NVMET_TRTYPES are supported and usable.

I rethought this. Now I think it is bad that NVMET_TRTYPES can not be speci=
fied
in command lines. To avoid this drawback, I think it's the better to change
NVME_TRTYPES from an array to a variable with multiple items separated with
spaces. For example, three types can be specified to NVMET_TRTYPES like thi=
s:

   NVMET_TRTYPES=3D"loop tcp rdma"

NVMET_BLKDEV_TYPES has the same restriction then I will change it also from=
 an
array to a variable in same manner. I will send out v2 soon with this chang=
e.

Daniel,

I assume this change is fine for your use case. If it is not the case, plea=
se
let me know.=
