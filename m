Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860994087B
	for <linux-block@vger.kernel.org>; Fri, 12 Apr 2024 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919395; cv=fail; b=pd36koFpBUjNcLb7mbk6JNocTTfp/mam+SFnWwRTh5n1stgogmgILgJ/7KEF7qLAq9H0DRfE7cKDlrF9q5qAyKtXmkYjq1nXunUWDZ30a44wgVj0WiSbQidezvFL1OpfaJfHh7Iix3ICtZq9HXY8/7gPrq6SlWj+SPz06d6fRU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919395; c=relaxed/simple;
	bh=+kDMWTHfU1jn7bmLmMmdGDGUz+36f5AlxjsvbQKub1U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FkvD06tpEy/UWc/SuzIqDsYM/aseMj7BRBL8wYJju73/Tv0hzxL7gJthQokLpHaPn/tY9bn/kyOuw7dy1tK18156rajZ+aeciUitKmKFsfvJS2IniH52eqlpM2SnAUb8BE//XiXM1AmwmM5vg87aZdV11dYkKMCLsgMAV9fy408=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=atOEUQFP; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mWnFUPMM; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="atOEUQFP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mWnFUPMM"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712919393; x=1744455393;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+kDMWTHfU1jn7bmLmMmdGDGUz+36f5AlxjsvbQKub1U=;
  b=atOEUQFPqUQFuyIECFYeIqR/BJuGf5h/r18VtY9JbTWgsyCVRR+3hDua
   bysuW+kt+VZcPieg8II8240p3NpBJsvUbnrvd/ZtCx2NFW0Oax0y62m5l
   RMPVToeEnMGxNARMTr4g56yjXkT0sAFqyiSkxDXo9lXHc3LTFJnjACo8X
   2fmFMM0qrjExK2iAJI4mwZZk6CLoK4z1hb2GazVZruboOezhOSwkbVwD0
   HR+b05lm3p31mZaWw+gOQa4B+l7YdAlmrLrACJfNHY+j9iEzpXvmDjtYC
   x0U19Vy60E1AJRaDUAIBp9tXAfsFQVIsTVGq9c/NRh3JTkfQL8qNzXJu8
   g==;
X-CSE-ConnectionGUID: RO9zgPz4R6SEci9e6rveTA==
X-CSE-MsgGUID: uZR8aO0MTp26hL9PPgIahg==
X-IronPort-AV: E=Sophos;i="6.07,195,1708358400"; 
   d="scan'208";a="13310063"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2024 18:56:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ct8U5XSpG/uH6i/l1gufl8yeG0U3w7fwnuEDq5kCWCIULHEQ+tXkQb6XjBlCg0QFQgY5NVKRNPC6dY2BNrzCzTva8o2jH1EITHH4tkpZLJa9FE0/0yJ2ZkUhOByEhq8Iy4iNu2HLbiuoOayybiEa8Vc4hyUK0ryopa4XlCKXpWbdvXSDO5mphlw0k+2SRkMOmBd3fAFh05XRc6sjR167FaKGYl3QYp0fd77rTWL4IM3Yg2CjnO/20yOnIjbW6nkyWYNULDza5X3IW2jw2EI2dywHzWACIfFwuTi6cCI775XvoEewaP6zQfsXgTRjnLYKn5csAhlQtueUdgYzg2QKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTVZtOCmCxQL0vzOLy9dj3lGWyx53rE/KutHH3Rg3Og=;
 b=fxJtrnl2Dzh2lfPCJ9is0FnpaVpJtoHRLBssHzpPVOWhY3uu8Uneq3AxxLSmqYcSMMNdAjaKe2ymhAlSIzn4bfyK9B/vilbjnQbBh1+NtLuf3NfM/lMLlZP9GKtt5naJLjMia0Jt7IFfQZInhoCK0iKzEaG+0H8a1SX/Wc93l6LvWjMjzHK+barcYkKltsX6VVVGZzVjIjNLnJyPCXeE3tCe9MO/mkmbPJHK7VBmGXZ5x+RS9SwH8SE676VlI1RwkcYQdj0Gl9C2GYMp53z1r64I/a3mF6SseE4yl5Q7ICyEiAWUtzRFNmC1W0T49x8ucP48IcAmQ2m/InBH1XSlkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTVZtOCmCxQL0vzOLy9dj3lGWyx53rE/KutHH3Rg3Og=;
 b=mWnFUPMMrtf3scLXdn9yhj5Q7UIBHHxBoNSTJnb3l5knuGFQkMBp/cvAlwvPmAZH5UWTatGffGRwE0lIUL1GBbHsYmsORZ0k3o3qEGz3gd6lVyQRoTjC8sd++F4bAV4Evjibjjy/xnnlFKregLxolfbGX+X4qCRnJFHiZPc6BcU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH7PR04MB8706.namprd04.prod.outlook.com (2603:10b6:510:24e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 10:56:29 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 10:56:29 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests 07/11] nvme/rc: introduce NVMET_BLKDEV_TYPES
Thread-Topic: [PATCH blktests 07/11] nvme/rc: introduce NVMET_BLKDEV_TYPES
Thread-Index: AQHajEBBNQZczZZBt0CN9/AkCOoNq7Fkd6IA
Date: Fri, 12 Apr 2024 10:56:29 +0000
Message-ID: <xsu56nrlxg7asyoig7oquaeqlitzp3vose2wjoxrd5hw4o54jy@36yu6heotpa3>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-8-shinichiro.kawasaki@wdc.com>
 <xbrhdihng3oazsnanxi5egcidbxd5bwz7i5463volkp4uvgkn3@3nu6yyhx5utb>
In-Reply-To: <xbrhdihng3oazsnanxi5egcidbxd5bwz7i5463volkp4uvgkn3@3nu6yyhx5utb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH7PR04MB8706:EE_
x-ms-office365-filtering-correlation-id: 77fa65bc-8da4-4ae4-dca1-08dc5adf34e9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pfRtGkzX3s460sHU6wcqfV+2XZBzKKfRCn1FbU3qBL+CG5npC/yQcW4E+6g4Qh76vsTzvr5qZPURUjlY4el0l/Y6OYMRZqa3ud6x7cFZU381Yi2myItCcsxvtpF5DQWCb38H6WeKQxkDto40risWzV6E2r3rzMLFzPEisFB/MDekC0a8sy5sebdTWDBOMk/IrTHhxsFJxNb/Ru03uG2h7E3eBF8Gq7qVkeA+tBH5KU5Twlx5xFajIjtxtnN290IxrU2+SpvmFLMQu0m4N8QUgkT4w54TnX1scp32ujGF5kSfV4/uuh8wAM1H96Y+4BVbwlLKChxKQ8PcztKWePFpxlptGayWeYgiqwGVzZywjIT8fKkgl6Ac39l6YL3ensgVQ5G3M0KirPG4nK278AsscNZqdcb8T3y9Az31uzSw/2nQNn6f/xfB9/iJlJygWwS9bifjWY1B2OFqiWrUrgIwvENp/cAeBN30Ip7lIkdeK9oHw9B3CEereH8yPnOq2ZGNw2JZ6+a/ZDKJLGnP6JJTskZyvYyErpfaipoHxVY6AhTBmSb2YESGtnZPncZn1PoSsGurWOOaiK3vT1J4v74xdXFQN8byvqXwT+TeU7eNVnhAi/KiVvy31FVSL19xnA4jnUKik1OPcg+oxH29wrfNaxO791imHD4ToYdaQS9jsRcmOrqA5RKcQhMIvRScjRz9ctd8SIghLK9tbGuOJ0wdNB6nJMJ3ByOOxBEAHFAqq6U=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yTiOYprG9g9X1I3Gn04Vbtal0Ktpm4VzsK96+F9yE8RGyAc9LJCdoOtipId+?=
 =?us-ascii?Q?tTn/KVsMswf3p/PC3vw8CfUBkcaeZRkavs3HP4aYbeJS9yKxElkC0EorOG6L?=
 =?us-ascii?Q?U5JETcYCmq+QQeTl1Rr5DtxBbKT0AINT65XFKmcyeQ/Tr3eq1XGM0e3w/Njl?=
 =?us-ascii?Q?mknvgJ/AqyF+O8SCNTAAjv/xGhdhJc4gqE3qbkD2LlMbe5DnvIXyrrElsAmq?=
 =?us-ascii?Q?8gznuh+r5wRKcBU3du/4m57wlRQMclspETjsJcIXx2oiY9bbVhVY8ALavkJW?=
 =?us-ascii?Q?qBuVNQ0BEIy3eAQAcrULKSrvb4nq80txVtixcnXibt643sMJtlVw5cKmdGfM?=
 =?us-ascii?Q?ueA5ojH60H7h8WCc+ERWDTcgsdAqjurkNS8pKLVxixz6gbUIuEpS1vyAiGed?=
 =?us-ascii?Q?bImSpJkjfT3M9wVx5XO2iMCLm39dGy4VSXHNdE/kFvqXWiXwbi34ZiUMB7tx?=
 =?us-ascii?Q?Wnuoy1fiQrlqLC9goJpK9U5PVPge1U6fKQoEdFmr0mNSGoPZGoFxLid1EvQg?=
 =?us-ascii?Q?IRjLPJoCVEZLH1fB1Hm9TQKbPVKhrM4Vj5QrDWTCQHabgGGSQH0AxOLSAt0N?=
 =?us-ascii?Q?zTZbpRQ6WUtRMy7XTp86MZoesu0d1uJGxnKSVpodl7RfRvFAu/TTyt+KsFsX?=
 =?us-ascii?Q?sk0Q62wrB+EUruzwO+rGV4pymFXbysZHl3J0P3IBNOougvG+wyLGPqCtbEFv?=
 =?us-ascii?Q?Hr33YKgoakGSiZIdhl0dNRbX1UOBzeXSPjOVJTs6VV1TyRddcNylfAwu0Jpq?=
 =?us-ascii?Q?G0LvhUoDJ01E+8xk4MvB8D7xua4dBNfrdgDvHXHd83c9KJ93KkMImBbYK1cy?=
 =?us-ascii?Q?SWgcwX0w/TP9jQOLU7mqL4SQUDhko4oRmnM1LgcrA7FBgbf/sNkKaX95SBpf?=
 =?us-ascii?Q?amxXx9WZ42vyizaQgW9gBVozPfVYN/rEzXWTvOQtNa8/sXvbS6GRVe/ArwFf?=
 =?us-ascii?Q?O65Ryqyfk58XoOOTzB8le3scdpaPZYlTmoTLL6EVVd4rZVwOpgHMiCTD1kLD?=
 =?us-ascii?Q?vv7ODId0TVHi7fIh8XdeViqaf5swbHDYGmUO0NMb9eKusG28Y/jiKDhzugkR?=
 =?us-ascii?Q?mbnQeaFA/XhbdJnqL9bofs2XO+kiOpJsVd3MYvsis77plIhy2iP6k449Yr/y?=
 =?us-ascii?Q?bh+1xCUuC7z/HLWqOXfQjL9HrpHuvdYhgzQgpGUr71eulGme12YPmv0UXJqm?=
 =?us-ascii?Q?WblBtv4FvKiG1XZTtZZw2lhuK/XM49+GRfZW8xqgAMhuoXzW8p8p/k1U9u8g?=
 =?us-ascii?Q?RT6wS/TmqtXKN9LDmVXkQeO+FlcJNSwURkHwftvALUA+QWDr6vHintEaBkZ9?=
 =?us-ascii?Q?6/PCgPuBUlLFJHnTHdGDOWDlO6yTEXIA/svwYMRRS38ESHXMEdIc2Pc2CPqq?=
 =?us-ascii?Q?vCnWJC6HTR/U0Avt3Cew046IufbmKCHqV0tkKp/29wzn/xT0QUDiEesBx4SR?=
 =?us-ascii?Q?/cjIY1ckCarzq7h+2zqKcEaQWpRqC7C6+pLLhH5rYG+3keRvCAMYv1houR2h?=
 =?us-ascii?Q?k53PzCbwwL45v7E8AtcIQm7AJ/ujalYnXBUAFf6szi+W14Plsp0tYOmhVxqR?=
 =?us-ascii?Q?W1k7YgUCCufly+QuSmKh+GdNO1BWnUqxxAR75DJWzz8bDHZF4lQfYrLH+ifP?=
 =?us-ascii?Q?MC1oIm17redrO65pVSTg8jk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3149BDCCF03C4144BCBAB70CD637B8B5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bKuE9S5kc3l1kF30bwOGi2Wqh5bbgSsDNfcnpA6ZPHNSmyWVa1nc4/cjUuqrKgC5WW9u6CWl490N2MNCGsxGVTeslXYGim90ROczW6Fkd2V0fAPanb+3FPyKvrljHwSrF8vqCSEmVXHAM+Ulo0mofkeaS4j3/4QIf51m9QJijgb47Vic+fI2ZD0tQ429HrJzW8xH6c6UTWL8f1MP+btovg+q5MxjCIWIRhSIVGOJajmWDyxlBVTtXZrnxcnzn2JNUYcDkg9ZhgotBx6GWLGDx3qLt6gCgxOAEujHBGWFOxg9fmgMZyOC/YR74lk9CKUeKc5uX6htdMUntrQkyfTbADbg3l0re/iSbUcozpDqmeSfawVheRt0vsOiKCxfSUSS+RTHu4eMIkaVNkcwPDAPdM+EVTA8u9ZjmFHm9HUrliUBka79GX8KRmIaZD2sncTFFWW0UW+1099+reMR8SxNl/b5r+cKBPP8/Vm0tdhAzVq5cHw3/6fPZx8DdVMJOFUorS5SaaoNk29R+TMINrY+NBm1lpRoZz/KBDHeCt/O/agcp0toG5DlMPurGy9P9WBk077IQHaJUbr57Pi68KlHTfl654Ypo4/DlF6Q7QGoDYbITuF/1ujrPGWhfxpEg8sg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fa65bc-8da4-4ae4-dca1-08dc5adf34e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 10:56:29.1327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3EWhN04YPJbu/Vei6803Astr6V+cNya7Ma6NDgidQRUl/r0GNmXE9xQ9wKbqYtDLHdSRq7uOmhXCuC1a3dlRQ4UPNexe9S8TsN1NKOGlvxM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8706

On Apr 11, 2024 / 20:44, Daniel Wagner wrote:
> On Thu, Apr 11, 2024 at 08:12:24PM +0900, Shin'ichiro Kawasaki wrote:
> > Some of the test cases in nvme test group do exact same test for two
> > blkdev types: deice type and file type. Except for this difference, the
> > test cases are pure duplication. It is desired to avoid the duplication=
.
> > When the duplication is avoided, still it is required to control which
> > condition to run the test.
> >=20
> > To avoid the duplication and also to allow the blkdev type control,
> > introduce a new configuration parameter NVMET_BLKDEV_TYPES. This is an
> > array to hold default values (device file). Also add the helper functio=
n
> > _set_nvme_trtype_and_nvmet_blkdev_type(). It sets up nvmet_blkdev_type
> > variable for each test case run from NVMET_BLKDEV_TYPES. It also sets
> > nvme_trtype from NVMET_TR_TYPES.
> >=20
> > When NVMET_BLKDEV_TYPES and NVMET_TR_TYPES are set as follows, the test
> > case with _set_nvme_trtype_and_nvmet_blkdev_type in set_condition() hoo=
k
> > is called 2 x 3 =3D 6 times.
> >=20
> >   NVMET_BLKDEV_TYPES=3D(device file)
> >   NVMET_TR_TYPES=3D(loop rdma tcp)
> >=20
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > ---
> >  Documentation/running-tests.md |  3 +++
> >  tests/nvme/rc                  | 16 ++++++++++++++++
> >  2 files changed, 19 insertions(+)
> >=20
> > diff --git a/Documentation/running-tests.md b/Documentation/running-tes=
ts.md
> > index ede3a81..ca11f58 100644
> > --- a/Documentation/running-tests.md
> > +++ b/Documentation/running-tests.md
> > @@ -108,6 +108,9 @@ The NVMe tests can be additionally parameterized vi=
a environment variables.
> >  - nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
> >    Run the tests with the given transport. This parameter is still usab=
le but
> >    replaced with NVMET_TR_TYPES. Use NVMET_TR_TYPES instead.
> > +- NVMET_BLOCK_DEV_TYPES (array)
>=20
> NVMET_BLKDEV_TYPES ?

That sounds better. Will rename to it.=
