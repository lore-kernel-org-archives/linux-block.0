Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C0F50246
	for <linux-block@vger.kernel.org>; Tue,  5 Mar 2024 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631527; cv=fail; b=r/1C+LUOB1QejAERNlx3OcDbh6j36BCZrTjExoJcLIQToAK+KKlBxqF0TTRIgzdW3pEjAoRcDh84gQQFu0aTbjhi4D1FoXT8oA9+ECFE3frioJ5jC+QIxdlIXvd/a7iWjBMIOvZG55nimk5ivMF+BgBM+1u0HsCe8MDnakluI7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631527; c=relaxed/simple;
	bh=V2gPoUQWCSFt/Ls1o/emKJ+5l6sVGW7/qijIdHqs56w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UMVmXstCodrIcFdRlpPqbcgImzJ5aXOLTOHPZHlC+bXx1dLicjxqPYm3uSNNT6MwyyLBM5UKy2kF38Jv34NKrNnVc++0PZzVwW8Sx6nfisWp7eXOrrBbNH/+6bKdmUttDUBq4jHO1vgFjXGURCMO8LLsfX/QGYyE2Qm68aqLoHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mTkpALZy; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WdnxccZm; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mTkpALZy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WdnxccZm"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709631525; x=1741167525;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=V2gPoUQWCSFt/Ls1o/emKJ+5l6sVGW7/qijIdHqs56w=;
  b=mTkpALZyqJOd4R+8wE1od3JpjBZ7MLRllsfMZybnRDt/jMgMzoOZNOH8
   UANwyZE0zBtWtRrH0GjujtVx8RbExTftPz6+nFUGgMxib7h2fnyi5DZVQ
   sCLocePJ3fP/ZAu0cjskJTfbgrSNoni1blG0VGF7fl1eUNpvpo8G4et/R
   E5KAMQYNsim8yqLnm1KiiHB66mkNG91Qf7W/Z62VfIUnSRwKLeyZeYb/I
   F5pqqtFnUStcttJJmzCOsLqwCRZhNcanK+mLmN2X+GzfZ6eZOlzANUYK+
   npPb/UnS3jXhgoKvyldoNMb6Majn27JDsyX7l03O53+t/3FeDMIP73MXS
   Q==;
X-CSE-ConnectionGUID: Pb2jvTy/SPedHwnN2x0cfA==
X-CSE-MsgGUID: dOtnlMerRjasW1xtBpr/Ug==
X-IronPort-AV: E=Sophos;i="6.06,205,1705334400"; 
   d="scan'208";a="11073698"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2024 17:38:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVbc0ZpzoC5axsXdO6kUm0C+rG5Es1fJNf2De6F8eVhtI1TfQ6GvtcOlDWICZ67bwgEkhruhesgVfpX1N++qhQg4yUeTsaXLwtOoL7oMbCXY5oG9Wq5xLqZYvmuNgxemkyskjSVI5/YroHOJ75SFDBBIjhApuer33Si0SrJfgbOXTLGBrEZCV24OTW8Xrp58d14dbXai/xmIJ+sEq9+tuHQ4Fw31GbIxjJwi+DbnD5TDV4ewelNiOPc/WMWF0ezRC31HphXnAZF2+N/dx/Betrkb+OuCdJSWzM01i8uZseuX/SJ4E9nnqrQyDIJd1JDRxoZtwoiaJNy6q8LOcGqPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/Bpu05WIOnJDBdgSUpMwMPwtE/Epl1GLgbwhLZE8nI=;
 b=b/f0xf5ajf2iOj6LqFqiJFQ418EZRiXShZxXr7IEMk9aZezS1RPqEUJ4NNZYhoFbqXkGixUINw3S1mN6sM1nFYll32DU12tKZrOk0g6EHCEXtADCHIJAS4ALxLJH7hI0fiRHjujLLb5jc/AYBG6DfBusK17VDGJy39W0MAI3JYI41mh88iS6cuCodhQkvRvoPxDUIJ0UeWWinDfdzjiqtmPBTDD9+Kgu98Bqh7cxT3bJTozXzMC3hzFbONcvh+Yf3f7pSzcuXh025CfSvaUfOON0EE6zTwPLb9HYfp2mc+zuBVI4MWYaXHKPz9eJM9CNzQTVDXtLHpzGEss3VzJyCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/Bpu05WIOnJDBdgSUpMwMPwtE/Epl1GLgbwhLZE8nI=;
 b=WdnxccZmjs3NI8Cm7dQMC+WZTTrSWgvvI7dmHeU4PgHUeUb6wsyeEAtSqN/GKErTC2LRzhKeQAgKjI6Um050VlNC6xBKu5QFDVQrmZDU2FGTqTpX3/XhyEvyhyYUSCfKR42xl2tU47pNe8QtQ1JrFG2pWMfkN9QuEZfm4J/FoFY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH7PR04MB8508.namprd04.prod.outlook.com (2603:10b6:510:2be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 09:38:41 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 09:38:41 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch
	<kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v1 2/2] nvme/048: add reconnect after ctrl key
 change
Thread-Topic: [PATCH blktests v1 2/2] nvme/048: add reconnect after ctrl key
 change
Thread-Index: AQHabk7epkdw5Z47ZECyvnSxjgGuo7Eo5TKA
Date: Tue, 5 Mar 2024 09:38:41 +0000
Message-ID: <hidg7tztvsyak5kjlrvglwyd5kb4kaaqfwbztxcf7vzpmsv5rc@knbau5ucdigs>
References: <20240304161303.19681-1-dwagner@suse.de>
 <20240304161303.19681-3-dwagner@suse.de>
In-Reply-To: <20240304161303.19681-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH7PR04MB8508:EE_
x-ms-office365-filtering-correlation-id: 0d7051af-cc69-419b-58a2-08dc3cf80b3e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ax+3y0MokRgHFzvWBk3jNidaIGgqAPKSuVym4essScxFMXPVTjvC+v0JvrB1JwXaULEWWdkk0ZWxk6QfGDHPMqDp8mMZaOsroLFJt+k7J1U5+7ofSYyTeRUGCYnTttRXKlua53dhKhvsHrMYJdPzr+QddDwaG/TKL+3/SI+foXP5Mi0wpew0IJuN5cvL+f8ARuFUDXEaurO1flyAsHNT9HANFVYSx9pZ6ji5MHIrYY0AamCY6TtTqAy5XbFfqQaR+CkSerhU3H1GVzY97/oRDpKvE+6DpQzdGoFobzS9t7P7I2iF4pVRNY2ZcqmxEQ9sTm7jAXvJE0J/S9M1SyJIyKt2FQTEaqKTIve7/W2C/Zqy6tpGzA8/r/8PJRcr/f6e4iRR/EJQoObuXwXIFw7wnceX1GRx+/XQRZejQXiGWKRdT6gqPEHqvpIsuzuij259g3fbOTOWDntnZ9Cv45AXiXE234+YMERsQMkK9tx6iMOyjoZgrd5lrgaHg3NJOiE7Zyj7TkB73OXU49xVSoLH5OqH1EtrY2OOh/gle6J9tkyftmLOnGcGPIXNJw8y3NJHCJNpFPgOseVrIXTbyMi+NzJ2CO8aJ8DzWB9SpF7Ux1Cm0w0fGZYG0vZ0YQDIzZWLP0g5hVbvvyYVPPw1ROzCJrrsg8r3ddMJtSNTV4IMEeAAwlSmCi4yDYNy6w2iXXrQPAelVsx2J+M5B2/mE2D5SyGg2hnkYBVJPSx1GZ4Icxk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0zvhclJF+MRwliQukPYCG6/MEbO0qRmxgFSyW6nG+RxAP7HgAQeWYqp3TFGu?=
 =?us-ascii?Q?J+VCYqI3bJPqrorj39iC4cj7QS/LPySpaHqsd/uJ+uJJkdUd5c/MSTWrQeWy?=
 =?us-ascii?Q?qew9IPZSxXYEPoEs9JoWo0G5TpGq7fNavfpv8jltD2gL2tFCoO4SCB+Vwgoi?=
 =?us-ascii?Q?DwKVLIgAg2/lKV+pomh792iLilXiy3fhS74QWujYKDInQVzeCmxLPr4WVEOY?=
 =?us-ascii?Q?aFkozYSploD4VNog2jBFAMd+gwHklEh+sfSAAgwUIcPFpC+2WBivHn+yapAg?=
 =?us-ascii?Q?XGk0XzR2dTGcD7ZTS7gbDupT4A9TVyvYpRK8oV3SJ/nypl3WrqOfDjpS4qH3?=
 =?us-ascii?Q?H8aiDYDuSW9xwRUzj7KRJ4MKP0+bufVzwD67OHG8HbvfQG+Lsh1P8DMCs0Nu?=
 =?us-ascii?Q?kThgH4EdMp5O0e5NTUrSJBJWrIi6FKm2+4qPH6/y+EGy8WHgNGxXZMFn6OXu?=
 =?us-ascii?Q?h1h4uNxW0XJoygACZsHJ1EdAaAgOcnWe+QncHNvn8UG9lltpiewaWcknZO+B?=
 =?us-ascii?Q?XLgA52zRPNF/2p6kTwa9gTzt3M5Q2NnHN2AA3k4p8tJmWbD2TqN3Svuhx38f?=
 =?us-ascii?Q?qMDkILVc8bkUKEmhQV3XXZ/y1qiV0+TqMCb/ibN8uLJBfdfG0i2mwCW+0k5F?=
 =?us-ascii?Q?AXSVZCMYUwjdI0VGpbp8YcvbCbyd/7YzElAFV09txWt+vJbKAibucuevw9LV?=
 =?us-ascii?Q?RaZKRRXfos1v471Ufk+IP9EWF8E5h+HhEY/XCgjWUTjuyeoZhNwFzx3scOXG?=
 =?us-ascii?Q?cij7ALGjWL0ipF3C5eNQH32cydRqotdMYiEjg8OsyoMh6OI6OqgrJAon9Wku?=
 =?us-ascii?Q?0y4QxoME1NQqJw2DNQ6GNAV5NZ5KUpvrOUbSEq2wpzIBbZ2fK/lCQPN/gqBR?=
 =?us-ascii?Q?p00nL2i7bPXK6tE155GyZx7HTfMYf9CX1nsKWIJ/xk+adxd60N1Lzj8LsgI4?=
 =?us-ascii?Q?sXZDJ1QbMyuNwfvjjAhqsD4lRyyXfo5OsBQFJ82o27/dvZKiLz8ovDpUgXqE?=
 =?us-ascii?Q?D5tB24M4Q+F6jRq+QkRRhELBHxgdPTc99feD72KWKNvs7OqHA8YM+2qkFJR3?=
 =?us-ascii?Q?2XAVTm3sIDYgnv9q/Dqxxmu3phyNThV9eYMGXcX7Xem/FD+gmc9d0LhcYjBx?=
 =?us-ascii?Q?g1j4b+Ecc9hJFb/6slJ3BSKL5+6gnsFM5XV7q8S6V/Y4ZuznV2kSaHo7UMOG?=
 =?us-ascii?Q?b3oweGp4YQEUv1U+Ip2BY2rqIYIl9oY/8JRmd9R47lTbOyO3ey6ZHmg9Q8x1?=
 =?us-ascii?Q?Po85x8u4D+ujJqAD/befqrI6Y8R2KhaSCJUnIL4GGth0Go5hV3sQUg6CJIJu?=
 =?us-ascii?Q?Bmofp1mFimr5QZWFThDSjfHjRXCPQHanKYB65Ebs/4eRk3bT4dC+Zk+PFCtM?=
 =?us-ascii?Q?MbjQ/vOo99Qb5xkd6XigxGOGO5tzqzENbRO2HbduDhcoQH+AmE+cQvsALat0?=
 =?us-ascii?Q?9VMKes3fwwWx4aVj5v5aB+slZA15rwUciGwGbNmZW4+C02/vMocvJrTYQTBZ?=
 =?us-ascii?Q?pIouaRCfTzpmdRugV8tnHUc7c4sNnS06g1PbSR8n610ALLQmlWA+n5fhWYKi?=
 =?us-ascii?Q?/f+2YGipTj5UQiOauYt2pfuw6puR9rXCji02nj/CQEWtWoOK8uejLaFxRR8f?=
 =?us-ascii?Q?bPQGxJbC7hMpDEn9MRqntgU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <50EBDE9ED44875458933354BB76A3D16@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6BVL3o80GDULsoBhMZ0TRr62v+lhyAsrwPspPk5WptnF/JU/osuZggLzfOo6kFB1RH+X8v9KO6ZoI+lZf+KKS1foi0CpgnCfFLqnZk5i32mVxjOsAbno73G6Zaf4bCx4jugrG4dnr+IpAre78tGjOi7FFNXw27jHl9sE57doLW0v43Mf+CHzq9SCHQvyTpQXt403KQRnJJ2i3B3CxBHzG8OdftDSdm653wyc85FLzKfKiY9c7Q3yLVWtebQYkxTMURP9sh3W8+EqliynGEcViBGP94aEjeGQef1MuAo4ABP/8Eq/xKyVFPiCaTICuSWRdhewux79pYfboZVqRrn1BgPJhDfA2U8Yyz9ynxdPB49gcKEsKPSmiufaHCrUIJihWBKtTKSiM+u9DVBxs5iqcqSHRYHWFP/10RTR1rUzCM57cIOx1KjRI1+FErYT7uPOAcZrhuEJcUxMmrwieLYvRCz9mWJlby1bvK5k6UhkQcRDffW40WLR2JGhZxIbQVXr3Nm6XElNwl551wsQTdc5/Fmf50CwKfon5ZVbb0Ux9h74itS+hdyLxVKUEVRneoyYyTcfJ1yTx7wwhq95YQaPooj1ta7hJ56dxiHagvkJAGd75wfJWtoCrjgenf3NDLow
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7051af-cc69-419b-58a2-08dc3cf80b3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 09:38:41.7840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WTLmjML7w0R74Wml5OlIVtF4MNznSbQXJy+fbvpi/SAWLjqP+pDmx5sMtklVD0OLEkI8Ea04vJtfMLL/gIX5GtqeFTmjNMYK2H8x04USiqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8508

On Mar 04, 2024 / 17:13, Daniel Wagner wrote:
> The re-authentication is a soft state, meaning unless the host has to
> reconnect a key change on the target side is not observed. Extend the
> current test with a forced reconnect after a key change. This
> exercises the DNR handling code of the host.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

This looks a good improvement of the test case. I have two comments:

- The commit title says nvme/048, but it should be nvme/045.
- The helper functions nvmf_wait_for_state() and set_nvmet_attr_qid_max()
  are exactly same as those in nvme/048, aren't they?
  Probably, it's the better to move them to nvme/rc, as a preparation patch=
.=
