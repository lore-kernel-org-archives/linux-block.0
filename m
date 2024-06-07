Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0D23D6B
	for <linux-block@vger.kernel.org>; Fri,  7 Jun 2024 05:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717736438; cv=fail; b=MvNO/VeGS4aLD8MUXrZ8w13HnEIe/LF4ok2+SCjg9YmRwZ8uNs1Qek9+1uKzfMjQQ40TRBKJXfIMSIkNgYLv0T55CUmtDPT07gd4E8m00dyJzL0DqcFZi7E7D4OnqihamUwhSLPPIB5VR/SXp00e1jw3GukYgaPGx7YnIHIfdto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717736438; c=relaxed/simple;
	bh=MldwgzS+3TGbZzKSFUPLDpSwF2It+tIg6t3bTgmp5JE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XPHHnWQ/LGYooM6se9Rxfg/UNhICoQoBbV235T5tpHIH/urHRFjLZJ84wzdkJ4IjdB+nxXfiVZ/MZoFB+nFMFiiIysY3Eu+7CHNzjd25XtChbjX0l8dVxgPacGtgaD22pWKH3Vo9AKzUPvcpjmXkeC9MVlpBiDOMNTJhwapuXwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aeHzbu9N; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ngi6K0gv; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aeHzbu9N";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ngi6K0gv"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717736436; x=1749272436;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=MldwgzS+3TGbZzKSFUPLDpSwF2It+tIg6t3bTgmp5JE=;
  b=aeHzbu9NhUpzDZ0k3aVC4rxLnCCqEczLq39QVWlhFxGaa4hBNkCRP0Ky
   q38YrQBSNEwvJapxi16VAnxOXI8JklEnmy0yxd90l+vhbyxpzhjO0eLVd
   aRGF/PUzEem4C+3Mnli+hgNOgU4aJ5g65ARz7Vmv9h+jjycOEslDEsWIp
   Af640rReSUNdhenSRkay4UJ/KsucEUbLLaHTgrEAmm/1IE7D+ibIU6wBG
   kNmNFhjv6JvIJH/p0e1R38E+wetvMhjKZny7NM8uzDH9jg8PYQmyGA2NL
   AI/QopDmiYzNxTukaxuCe19rHdAKVyDTWu/pckjZryFNsBKL5+BiXNB5h
   A==;
X-CSE-ConnectionGUID: Gh4xVDJNQpS03hmdaoJubg==
X-CSE-MsgGUID: YSC43XB3QdautIW9nhhPMA==
X-IronPort-AV: E=Sophos;i="6.08,220,1712592000"; 
   d="scan'208";a="18184854"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2024 13:00:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APgq1RLoFSG8A46Il6V2Jh6/Cf0NkB/sQCAs4Z8Xt5TKOVubnuDUz4alI3QnHPoBTUgOiRVz3JivD3s5iK3cUkd2JlwwLHw/Hd+puYIQYsUP8G1ZZcz6/fxdMeddYUloQX/luCw5Rj6HHE0gNOq6iHiz0lo2ynD4e8XMEuTgf6EfkRv+J8ZMwGucVpbMXRkYc6ILU4LJ5nAPVvFPac55LMuPujf75itNipmbCF1cxqD/gcS0ZReJ2o4bWI5+eoGBS05jqskbb3ij4VAVH+PmYskFRMPFzUvjNS7pReDvgWqwxsq6YwMixs8yXlRqMN58JqRID0r7u3mWQQQ0erttdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xRg4k+ncaCCV25mC6p5mg5tdTf3ToZSeslIG2Gl8UIE=;
 b=U3WaZbwyEh2CaLSNFY6pO4zygyCGWtsrqOn0+m2z4vhUyDBWfVLDFGaIGNjGn17xTBM8Kj8MWQGHcVSHSJYDrx3/Mk2tIppT/WPktkK2+zA8OrBBdvgZx5QXgPUSbljmjNhrZC/gVXta56lUXFGhZib92xMK2REVzjzkwD1qRxFE6gqSduu1hCYDK0iDSLsTw0JD8epvV/oxhXD7vpgBSvwP8Axp/fP5oSwjeJGjD1L8sh2V8elTTqhj3WnFRY6RV0f3FIJIWfZInJic8L+GRWB2HaFwR3lFpaJxibYRK6otDL8PyIqYNr0nPsEe4iFVZr9dngWsTxQ7+2Anp/0xfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xRg4k+ncaCCV25mC6p5mg5tdTf3ToZSeslIG2Gl8UIE=;
 b=ngi6K0gvcJZiTFEj8PebXIb3s7wZYNtyjnl+odZeE6mI6anQXVcCALxogrh//ckY6z4FvpqAH4YnnR6LPEudUfv7uiUcQlS0UgD0SwmTC58ZQO3YuzAd2RRdfXKYDADJ0NqMcUrY/5POkIaaECq//iTJJuccPCX4NbSGTBUXtcw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN7PR04MB8545.namprd04.prod.outlook.com (2603:10b6:806:32d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.31; Fri, 7 Jun 2024 05:00:28 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 05:00:28 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] README: add dependent command descriptions
Thread-Topic: [PATCH blktests] README: add dependent command descriptions
Thread-Index: AQHathgeVRGyAjFh/U6gELy4xk1uRrG7wwmA
Date: Fri, 7 Jun 2024 05:00:28 +0000
Message-ID: <4sia3lb3uepnlgslu7y7irrs65xjlnqa6n5c5vgte2gr4lmm4e@yk5xmdtnnvbw>
References: <20240604004241.218163-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240604004241.218163-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SN7PR04MB8545:EE_
x-ms-office365-filtering-correlation-id: 27a3f9c1-c057-404e-5259-08dc86aec018
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/okasyRZhOlGC817ZN4giXbX3gl4Uqf9jeB8T0YS1GAxcxsPzVxMLkFt2RYp?=
 =?us-ascii?Q?FFUcXl1lrW8GBHp4yJgFQCrN544tV8hAfjYPNmwwwJ0qXtNM8WPy/6rcxh6I?=
 =?us-ascii?Q?qtAbXHQ9/F7P0i1/K2BlRVo8KVzb1x4TNZ9nJENcms+dDcfaDp38RQz8agsK?=
 =?us-ascii?Q?FcW6K6PyCJlIywQQ56qP66fVm+HzqtoY7j/6PpxseJePFm2s0o8MkNYZpgl1?=
 =?us-ascii?Q?vGQ49agORizn98lfCbUvjPG3JSIAhv+sRX7EkxC67BmqGVClZGUIgfsoLYjl?=
 =?us-ascii?Q?vXKIkI8wFsADFuBuzr2wrraYBWNjTW43peStr4eJk59bHvq8SlwSKFIlPW6y?=
 =?us-ascii?Q?pCDRPAgKUg8gMxviGzec9yJgnS/Us+7g/DZvIJVyaHfJTGrXgKMUb8yd+k1e?=
 =?us-ascii?Q?JZMKmN0UBMHVjFJBqC9haj6AIxjqHxC7PXRG3EyRuEN7xtxesoz4Qks4Rd/i?=
 =?us-ascii?Q?qrHRd1I+Ip57/dhkfKwSnqvmMp7TiFsxZ88qEVFsPYDL53A3MgK/pNQT2qij?=
 =?us-ascii?Q?G+EqHkfcLlWSVzqzRldYh62mMR+H+xeZcUU2ogXgh5TPBbGX1/poAtLHBXT1?=
 =?us-ascii?Q?ajaU0S7CvX6MitkakObaTSJvNr12ldg8OvGcccC1Z7aHyzWLwK7F/tS2niTF?=
 =?us-ascii?Q?7zm/K0Y7ghOFWflP9he4K5FgCfd03g813a5Po3lbX3Ia5DuOebCBQnk+hS2a?=
 =?us-ascii?Q?KQvjcxzGbnMRuZWIxvAQytK66qmY8lXQE499Tc8NYD7p+q2Ad2uOQPyGizrB?=
 =?us-ascii?Q?qZ/Q71i+onPifgS+FctijSN5nqTYXm5FLQ8SqgHkF+N6RTjD4eY6DvFmv6gw?=
 =?us-ascii?Q?RBS2EtxQGHKXCNDtpe+CTqkQeKk67MjQj1EVUAqWjDYqrLh0zmMs2/IawWKk?=
 =?us-ascii?Q?w2JRVa61V/kBHEOPPkDLXHFEbIfpkWFiqi7p16IsYHAkxiC6lIlMOvZPv6vq?=
 =?us-ascii?Q?dJHoX7Aq6xEHEJK8a0VLwsu9mlf3HZbD44o4sCtbwEjh3OVTU40UT5TmUtpT?=
 =?us-ascii?Q?AF7LCTDvH3DyBUxriZ7kXZiqV5amwW4LcG6uwEizLMNkAjUlGph0NX09mibi?=
 =?us-ascii?Q?06j3Tv9CZdhiNwYTD6KbWbH5Awvd2WbvkS3QVKVO+z7fwxqiiBAHlbshK9Tx?=
 =?us-ascii?Q?SDR1ngKkWt3uvtBewNo31o3ea3ZamX5m4NVqcr121AlOJ9B/P3FvcFBYFPaJ?=
 =?us-ascii?Q?EYOH44/HpHo9nW7cMdnm2ec9spemkyLqOr5BVbxkS21Mw5woq6YshxkcnilR?=
 =?us-ascii?Q?egygsH42N1eIRSIqVU7bV/EQfxNMKH/IRJSuUKAVG4VQw9aLnyR2rE8s164v?=
 =?us-ascii?Q?QQEvY6BnTSccZoHK3c9P+OLIBobESxysRUoLBRZ0Dr+TsnnzZgYOikyixBLK?=
 =?us-ascii?Q?I3xM2lY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VglzspePCb3nHsXOZ9NSKCelwhiHTt0YBFywX9AYdca/AVGp5fBBhmKyjI2h?=
 =?us-ascii?Q?4YFXqb0/L4G7TJY/IqS8T10y0vj+iN706jcM2mrvA2vjV0kE9ZdmvQgf1fn1?=
 =?us-ascii?Q?YlBuZY1XKj6k4oTRCiTmTC6OmKGDxKbs94UwtS0cz/I2u3o3xVJgFQZGKbZG?=
 =?us-ascii?Q?IorA4ui0fuFkxBIqaqRWaqM54DeC4xH9lWRv/g2wsGpkX8EQ5Ah2ur5K41eO?=
 =?us-ascii?Q?7PlETGX1cTypMPfPyudlXtpxQDZHY7WwUmD4Qfw872oPMQRaf/dNkbRvHL06?=
 =?us-ascii?Q?Mta/TOU287qxKIznVqsJ7QgFk5WpxWOjqd1S6cuK6EwLn4Qf03EvZ96Vf8Up?=
 =?us-ascii?Q?5FmtpUNcEcZpPEIj42CXB1403X4RCgw2tXDCMaFtUANCtepwYRmKfW7ZkISe?=
 =?us-ascii?Q?NvBMA7PYkBa/HfNXwjrSIJmfgBkneDbUw1VV6E2Fr7sxiqrh5DTSL1iZkPYv?=
 =?us-ascii?Q?Ruy5qXVXVYkmMGfx8yKtfZB62G6SpeRXRSLUWW9qzhrh43+S52ltIqM579vw?=
 =?us-ascii?Q?Slwt7Gf4HOPfON+/zxbwpW8yKHNaOTfOOV1f0LAhPlnllexGuwQOkAEX6D4q?=
 =?us-ascii?Q?BS/MmTEMo5BZ2rmZGZ2XOODyMl7qFmilrLRXz/PRQZ60S7I0rA4y9YeUnF+x?=
 =?us-ascii?Q?NtiKnsSzRZgkvjdmht2/noBdKqoY6izM6SkuHl6SP7V+ahLhCt6Ppd7cAxIg?=
 =?us-ascii?Q?vxMQ7/es6P/XJ3M8ULr90IGW7JKLIOvdNA6Uct3kJ6luBGDUQVSZVabaoXTK?=
 =?us-ascii?Q?pV/LDE+JTClQNw8czqmOMnE+wsnbhTcQHwTyNnNd+EyyEX46jyR/p1HWRtkm?=
 =?us-ascii?Q?d6pbquNDuTA5qptBa6/RlzYY2Y+USoDDtKWmTSqvqIYyGmet3NVt1LEZjcJS?=
 =?us-ascii?Q?Dl0+JgxsdiJ1MpUGWzcUqR/PN9zzWnQu9JTMObxCghrraERUmmMdo8TDytNh?=
 =?us-ascii?Q?I++xtdmfhZAuU8Dq76QSDcIM941PYddsCactDxRaRObBujE5hzKEgbiCPjiP?=
 =?us-ascii?Q?XVYkz8H/JOdj4IUZOthFhfuyBDKWghlG3sehW7nmE/yKtoS7QiK8Wk/tOpED?=
 =?us-ascii?Q?tHyMnmzTbDn+ObQ+i3zsmyxBbtryTcxcoCHw+t57xZJYuJtRvq1IxWIPMvN2?=
 =?us-ascii?Q?+dPtBpbNZqYJ1pSmZEceAXi3mHLl42FkUi1B6nGkZClLERKZWsgxAB1TjeEs?=
 =?us-ascii?Q?C1apQ3U1MjujOlkF9Dlc/nLJw3YBSfzkVSrgrIRvKBrCYiGHWDIKU86fHTS/?=
 =?us-ascii?Q?HP6X2f4uUW+gbLFEXhfOMYHbSfTlGUkB3UAF0ip8O1eEv05B/jgCa3a3IBbr?=
 =?us-ascii?Q?rqJU1/Gb63MAQsJGl9jCPNjKQ5N4yIQtss20z7/PMfRcaFHVz1kTwANMfSS3?=
 =?us-ascii?Q?ZT08RLVxWsJv3VhlVp/XIGDPqfAU2QCzwX0xj78LrO5h9ID8KYClfXEHN1BO?=
 =?us-ascii?Q?0zb0gfwATwOCXNm9fVLCV2PrWiMIhqZQa9MI5Lsdqj1yHkyQUreqQI/ISurV?=
 =?us-ascii?Q?EzrDzzldDLvy1kWgdc141CgMCK4acMAE8Y8YyFdIp76mHtUcQ6EmStcxXHxT?=
 =?us-ascii?Q?QPEJ+c5nbiyHeDDIs/6R7R+entEAZhOjYjQh17WSGphHTGs/gUzIBEVyewjf?=
 =?us-ascii?Q?9xE5KvdQlRzmSWUFpPVDiaQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9EA6E1D7C9403143B7E0F92BCD2041DE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	clDcBlcCvNfg0Tre7dykOAzSUBjHOTVbp0UUCks91T43u5jlGjoTIZlx3sE5TWCPndBJdLhd1xQGeNUQC7tds3Zxu4ZltMBjeZOqQCp1Jxrntz6YYBJLbotCB+FGRbEXvgVzuRUKxeAvwZbDwzH39tRuWEOygmL9+UvvSecYmziCxxM1BzgLrI1MQMh4Nzs82yciIy9t4MaKq9/RdhXmCX61hayxwUui75iuxTd5pgqYJlPBK5EanSMJbjx5AbDHlqoWC5/7DGOVJ0F4eq+bnwsrdoW13ZAF/Vfe52Iw3vhA/3euPgmgKAm2txR7AkgqAgLIGMv4Yi/rU46T5CDUK6lQHVqHCK9P1Cmd2MNzeiOB3eGzMT/Ajenc5/slyR6rXSjCjZXm7HcAb77GqAPMif3lv6t63p8hwBQ3D9zRcH2GnP+Lwo1p4ghKmIiapHoyY3EKbTDRvlX4Cf2/r9fGxT5fiT7KJdz15NqqegSVDiGI3vQ/wDeLhuzZqnlodvofoSeXhEDObRKaH0SE4B358feYcL4FTAo7LkULHIdfw2LAQ+o5LgcXY+IuCm8bkTCj/LSShlrlZc3HSG8tDVudnju0TadWWVpc0+e8I10abfMJrM+qPtTBJxRJcFmya0vC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a3f9c1-c057-404e-5259-08dc86aec018
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 05:00:28.4535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kkewEcRz2r8zY8WtijdaB43cPXN37fWlRCcsIanMAEL5f9V80cwSJVlgkBzIzECNq1anqNF/QEMOu5sZ3UhOEnLDG82b3XkEiu1GmZVWBP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8545

On Jun 04, 2024 / 09:42, Shin'ichiro Kawasaki wrote:
> Even though many test cases assume the availability of the systemd-udev
> service and the udevadm command, this dependency is not described. Add
> it to the dependency list. Also add optional dependencies to other
> commands: mkfs.f2fs, mkfs.btrfs, nvme, nbd-client and nbd-server.
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I've applied the patch. A follow-up patch is posted per review comment=
:

    https://lore.kernel.org/linux-block/20240607045246.248590-1-shinichiro.=
kawasaki@wdc.com/=
