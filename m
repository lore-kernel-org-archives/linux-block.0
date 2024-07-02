Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB05150993
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910338; cv=fail; b=eWr8mnECHJTp457YOO6Vsu/+xB+9KTjab0LrvSwCDwz4sw2+RdGCRn9XABNzshXdKx0TSZfDOY2Xdi8IE9G4O2Re7QbN1vXUfXoFLTQCARSfaazN4xEKtVo02t+47SaU4RcKtyGYyTxHKcndpq2iSF7Rz49TdJRVpbZ7iHEAYqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910338; c=relaxed/simple;
	bh=S185kgbkrMZ2P/J0QJ+II1xMEXHd8KcCUh9z1YdDhyM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=btinzTMM3vja3pJxXeRFMAhvrpfhbRotVtnUyK+Vc4ZX6/9zgUQ+7325RmaO9VPoUjblxigddGWiXrcIZmse36FUfN336rH6k0T+i0Zm11QtciGi6s04QrsIv5QEk8clH7BOvpH1eFKF9wjqgJCs6aZnbaKxerIK7ROH6qAeId4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RLp6YQf0; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Wm3dcsPb; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RLp6YQf0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Wm3dcsPb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719910336; x=1751446336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S185kgbkrMZ2P/J0QJ+II1xMEXHd8KcCUh9z1YdDhyM=;
  b=RLp6YQf02DzYD6U/bIx+ef6T6NTdo0IAjBB1M5C9C28uKKjEw7UVHwOO
   qKSdNQ8Ho8jbsFcy3j5Ifel2iBKP/gPPXOMW65FSnbg0EcLlR8f5TuvBk
   4hKCyaNnvg26n6V1ZWZ29O/JpUzUj08wKN+gCgTc5guUsV4EFnyVOSfsH
   2gwgEw00MYX5Uqm5Mpu0hZp7Pp6ncJvmm0uMuDaTjpvguagyTT78HJRvp
   7QgE7dyG/2wA5xbVbYCEdgHLSqYcLRjRvwf57XQUJ0a9GwtxX1gnjgRDJ
   okOzJc30I/C/tQRT7a09Xa5Z8M5fJd/2vOXihNyzXNo7K2aK6VhXZMxQh
   w==;
X-CSE-ConnectionGUID: Wi/DUtwvRTqzvLQCIFIrTw==
X-CSE-MsgGUID: 8QZDGKoXQ/C5tqiaz9zOiw==
X-IronPort-AV: E=Sophos;i="6.09,178,1716220800"; 
   d="scan'208";a="20683678"
Received: from mail-eastusazlp17010003.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.3])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2024 16:52:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsEq9Orqaz+hrlenjpTKwOFfiyj/XzOG0tZ1WXBP32/n7G38IeacHuGDhc0GgriiUaS3hwss0U3863+DMPw00GaJTjl0q3aXMqsxQdBp+KHuasyrFXBNc1OwfQhgc1h8po9r81f/SkQo6/VB5ucgj0rVtyfp7Yq2hWBk85lHpRgBOUJU4EWWxKwL8MK69Xi3nZcpcGbQgqXXIfeL4XtdUtoZdwNKPCD3wlXpVHMkC8o1NnNrtj6GNMWDQIpeUsKTCduP0FI/ug2VzZH9/fo5UHiOdr5PXbh+nfUBKcyY3N9XhEFu9kJonjGUsLQtw+qlgmRY82BLsTioiJANby66+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mk/yqCJTzE7awIUGtFkVVSVOSLq1wN9AN+gPDu6ofwM=;
 b=JZxXVyqbxPlv985nbwoj2IwSHDRmE52wt8K5pE+EVp4Kercy+sQ0/fE+m21g4BFQdTjzy84vHUx58/ntTkuVplpbi6a0qFXTZZTswwnKFPhJv8fjxFYCHVo5IN99WppMXsig8UGsl4c6Rnl1p3ivUJ1st0GWEF2+s6kZGOUwKcssN0reK8k0BNUr7ajoA0BCGme1MdcA9Zv1beHuUO0PXXuyqJR/VMmA2PnYRmc9P+quQGsI6Xb5Gzf1T9AGh/Kmygj1uD/6Ha5l9cpvZrtUm7tSmmoNYxVRyH0Zt/RBjaKD+grYlVzN2ZQq5/PdxK6PfQ92dZ0iiHLIO6fyLifj3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mk/yqCJTzE7awIUGtFkVVSVOSLq1wN9AN+gPDu6ofwM=;
 b=Wm3dcsPb/4VwCsvsj7NZfDdE2/JBG7PFXRMoFCac0+pacg4FN22HuEbiCeF54UG8B1uwt+rG+imnHb8w/RrkFOmFPjSPf1bAqJyc7dXxqZ+jVjqBfVnpI0oskDjygO9GvD1wyKwoirrEjQFe/xUZ2pQ9g53q4tDAG9FnbrrTEak=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH7PR04MB8732.namprd04.prod.outlook.com (2603:10b6:510:237::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Tue, 2 Jul
 2024 08:51:52 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 08:51:52 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke
	<hare@suse.de>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v3 1/3] nvme/rc: introduce remote target support
Thread-Topic: [PATCH blktests v3 1/3] nvme/rc: introduce remote target support
Thread-Index: AQHayHHfaO+i28+dmkSocZJbcLbOWrHjKUQA
Date: Tue, 2 Jul 2024 08:51:52 +0000
Message-ID: <2le6usvr4sfzconrglndjq52i5zwykftrfqc43ddx7cpqanq4m@g4ocikmnnw4s>
References: <20240627091016.12752-1-dwagner@suse.de>
 <20240627091016.12752-2-dwagner@suse.de>
In-Reply-To: <20240627091016.12752-2-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH7PR04MB8732:EE_
x-ms-office365-filtering-correlation-id: 29ce1ebf-a6a2-4a78-4615-08dc9a7437eb
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kQThgkgKe6NCXVGEFUNyhe8L/USXc8APlkRhi2s8UYw26nm3H3cL6y+vo8HH?=
 =?us-ascii?Q?y2KUG+tKIuLwRpRyg5SjXzf3vfseI2G/CIOQcNBi1j/w4OPsV9wkpkE8W2go?=
 =?us-ascii?Q?76Hn1KNurAF6B8qN2D1Da5lL0KeomNxvHZRoEkfMLjp3+xkmEmy8hVjAhRTu?=
 =?us-ascii?Q?/RAnvVKrdydbVQ5+mBtPGsmMyTdzLVvYvZRbkBmvDzgAYf5eXB1no19NfmLP?=
 =?us-ascii?Q?saKn+o0Rh3GivQqa7QByEU2JnMUNueoxRjiyHXEkPdt6ufKf5lbvsgvVJ9AV?=
 =?us-ascii?Q?3u8qo6HAPZaS7haw42+2DuLKxogwOi9I84w0JjgZ3g9QDVfB8TMz6joKyfYv?=
 =?us-ascii?Q?BbMIPi7pgTQP0b4slO9lDoxg+R2+aV+3rpFqfp4FVRi+PJ3+8r3fBBdJp6O/?=
 =?us-ascii?Q?pJ7HdnJLKlLucMpq6oLIdlPS7PHn+aeGvjiq93Gp61wpjXcYHpmVUiihNcz5?=
 =?us-ascii?Q?Ks6ZUrztlfSxyCwIsNwsaEfIH/WviomoMl46L2y2ePor2WPtuNmYxIMtp5rC?=
 =?us-ascii?Q?fygbC/+KEds+RjdelcK2tQXJybI4wIZCpNCV/nuMzOwRTfer0i8ynUkc/cZG?=
 =?us-ascii?Q?CStvOSuVfWG4w+NA2zxtkdPLpIBKqWNwC0XN+nBWFS48qUapVhdLU4dJo0QC?=
 =?us-ascii?Q?8nt8ZIiqevh12N4fToc4KvlnKEoWsuRsNZ5C9zr5XFZ4EV/eb79CM9HaQzgG?=
 =?us-ascii?Q?diGqpM1dBzcR43S/j4yj3mHWHrcwDHBD88uX7FYi/u9QBf9zoIyhFLNQQ69x?=
 =?us-ascii?Q?HL2p12jTtvsYZi9rnd58dy7SUPVBiJY32bvAXDD1yOGDAmaBk5Mt0fjlE0YV?=
 =?us-ascii?Q?TvwkMjSmhJvxBlCG8Gfr1IMNZC1QxAknKrsJxhJXxoIHXzyg2RGmjKH2TEWA?=
 =?us-ascii?Q?37rrCp0isoMsRavdpgsM70A7twUds1RAl/GKwX2TYbgVuTWDsWWEkgEdDhmv?=
 =?us-ascii?Q?WYd5TisaOFpBRXSOLI6H71aqdCP/8uGZWGsPSYwrRRsWK1SKpvCPVvMK+uEC?=
 =?us-ascii?Q?bZZYdlM4OuCK2z41Da+50ujBwfpfUSg8gPKWt8nx6v2+4apLwin8mSzskbvl?=
 =?us-ascii?Q?GcTpTnil0j5zPx9FzUosVQ6byxwX8A+BkRr/EGSjFrJOknW+l0T4FrZcbfaj?=
 =?us-ascii?Q?HGNAvhIrhz4Br/D+yIMR38KORkzo8vpN0SC9XOUzOZmjXic4T+WGzc5YF+Vv?=
 =?us-ascii?Q?NJHufKWFrSu+RCU1ZOeQS8jEcsuMQ3Koj4pugccm2nF7RGvzETPufGLfhbjF?=
 =?us-ascii?Q?FUEERaLZ3mOVRGl4m4Gz6wGuNItDecFUVNs6vL0keb59Eldtd5uJQtXqcYL2?=
 =?us-ascii?Q?brRCCLKln9d27VdsUhSH+Ke0gn3Khzpnme2QThZDGXx6cdcAkRdE8SJpWLtI?=
 =?us-ascii?Q?+c12dt4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zvBvxRMvoEYQ9Ulf8xGjgZHHjB9K+PF/fnxhPJi/hxCY2ZCqljTXElvoCW+z?=
 =?us-ascii?Q?sb8ci+sNnKjn2lrdvYTGd3yI048c5euJ4kGxIxs46FKD3CewkzKsCDzYma1P?=
 =?us-ascii?Q?a569gF81Kmz7JQKOE+itdSPidS9Ro9SMsfej8mpsWnmSrUIsb1skJALVUMZQ?=
 =?us-ascii?Q?5QDvzYicu60IabBj78HVhJ3u46IYAsym3W+olDBTtqk95GZP87dzEn3EUf1A?=
 =?us-ascii?Q?joPhNDVeDAyjz9i20o+6wKVxxw1WMjZkPyaLc7KIHkTbC/LCNde7itLmvbfO?=
 =?us-ascii?Q?PB/6CIrq/tbsTcWmAnOe6piDnjwT2q7t2fVvzmlHhP27mIb1vYQgchFH4rQ+?=
 =?us-ascii?Q?/lj9RABE+EyohV34UPu5IB5Uvr4Ph+6+U/Xy+TN6+WYg+ZHWvD59x2cui1l2?=
 =?us-ascii?Q?hbfzwc1WGOGtqur5MsHEONVVS1fZpn8cM4uEQU/DrDDEaGTnpQ0CGmU5frvg?=
 =?us-ascii?Q?Z5JhT6DtUfd1nk9UfpSv2eCVcoijDsYdRiazQ2W37MtVCGpPAUX5esmwYF+T?=
 =?us-ascii?Q?8nM8dvZ+rdvcPBXWe9LEZIlSPfjQgsXNj3zCsTbqyoK4d8CLF8JnB+R0JPej?=
 =?us-ascii?Q?9gC3ILGsIR4GLM/zqEuT+6HN+lpkb9u/uXlc88TTE7h786ljWsY5MaTTeOYT?=
 =?us-ascii?Q?u3ALzxq68nuJGrEq6z4zLX6IIPerXVNP7btVnX3HseepL9XavpHUWoOODXQU?=
 =?us-ascii?Q?5iVyowUu2ADUpm/QjKoJTViEBuTSSW0mG5XcgrFtnHymJVu+Pmn9jCmjZRoe?=
 =?us-ascii?Q?tItTAeg+NRPfHlZsEl9C9oN6UhqPRwAp8VhmABffeq0eISqHbBZGAjV2QGPm?=
 =?us-ascii?Q?b6emePBGy2QbaceWAOZLR9Wj7+rfN2kUk16XgUWfCXzIDjjlEwk5IL8vbM+z?=
 =?us-ascii?Q?PF7OXs31uxmicX5o7rXi+7ENAaYCRcghnIRTHO07/v29JpjJ6ZFaKghkBFea?=
 =?us-ascii?Q?tHIK5P4z9DIIs0oTW3c20bp3xld/6TytUPXK44F8K3nlKDxUJq/AJjeajYSg?=
 =?us-ascii?Q?wODaaGAg8HN6K80TS/Yusz81wKcqXN7GVdMqBRM3/HWNj8TuuecdLiocnUq9?=
 =?us-ascii?Q?0u4QwelUEWHQY+aToM0lKHUNbXqOo4Zx8XlBEX7PtEYbTuNucLRw3Ol+JZy8?=
 =?us-ascii?Q?Hu40CElsBZTzyWYdqXHhkJriU3Zloe9SXKazE9axJMCMtYURQZVUlNgcaaqU?=
 =?us-ascii?Q?fSTibFBr/ggYht0qITNoKFmVAHsWyq6yURu7nV5guOw4uppYaU6lI0wwiBvG?=
 =?us-ascii?Q?MPQGzrC+Rofdrldb2uYQ3foL2koTxZ9kU1e1Ksvgh+tD0m5S35goxf5FMDcy?=
 =?us-ascii?Q?Lv/bqC48M0i9KU2mcprNcJPAzX7i6ABkSjWpsUITDJ90eRYW9ngb4x/BfkQG?=
 =?us-ascii?Q?IVbga++eNE2dOCF9iQwXWBTjiCO0XN5N1haX9FvnfCAoMv2bOq2J4wsZ9ths?=
 =?us-ascii?Q?WsuUrCWhf4EP83FEpzRoZ5f1c0kscpCXvae8ckyE5VDXu57X6c5GXwOn/ZEh?=
 =?us-ascii?Q?PcHolfA9tvrRWjGWchHMWvHKQF9S1twX50yeXQbH5cUjLfiNsu8C4/aQzPML?=
 =?us-ascii?Q?i7NFdirbEMhcyFjEStaYeJFN75z5oOYBOIyYaTOKUsrAuEjsIoGmDDpkjL0P?=
 =?us-ascii?Q?di2/VWU+LlT2scALTEZplXA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65F4B341F7D3FD43A4086E2E02728898@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p0p2EJ36GTnxiCB/dHUh1RHSqa/IrTVlNchbH1uvYFIEE4JigWlgWiDdwTjAo4qUXYcjjv3O2Q8vJuOvxiUVa2kXV/+g8xuaxESQ6/qV+CIsDlfuWDdjc/q+ak6TfLL6xSwTHipGclMStomWMmWBlekpFukokRAl/lUfs+U8UgEb/Gs4OgczFZSwrJx9tXFltUFvjDZYBDZuxOIS3TERsqll45O4FrgGT6sw6cnSGRgCYry3Cz1QRjJR7gV2dS/uhgfikYJ8rXUcTYH5OwczVzQXUOMMdW2VnAnG4jZyMt06kw+1u+TYIUpQ70YmClc0kFUe22Hk3naw2B37nl8dLHVMGAqhr94avOOW3cPX1ua2LW076RpTlkpaaPwqTQHY/o43CpReqm6YYy3sRCbPmyve+LnDlz6YWejT0rORQ3MaebEBBnKxpZbGnJtQcCpzAOQv9Wh7SAA7B6zlo5iPCydD4ppE2UD3B3aIqLOUnfpMzw2NomD8G45zTcpyLX0SUuZNmt+gLevZPy3Q8pMtMoGgn+hk3syFRnW4E0V+QjaR/1rH6h/dZV+HU+FPwuJEi8N/y2IqRIODg5AU807EYevjExIvY02JRbNfkBkOXuWtQYgR+2+g2Qk1mMBRAaMC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ce1ebf-a6a2-4a78-4615-08dc9a7437eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 08:51:52.4640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uq6rXztZKWt/gca3MnQ7xL5RsAeTgjJqYjwp5R/DFjcWTD7KX1SZ7NdngcmviWYjteFOj07mabmCIIuL15gwxXjMNIyVlMl4Cp01pg1k1Nw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8732

CC+: Ofir

A heads up: this patch causes conflict with Ofir's patch to move tests/nvme=
/rc
helpers to common/nvme [*]. Depending on which comes first, Daniel or Ofir =
will
need patch rework.

[*] https://lore.kernel.org/linux-block/20240624104620.2156041-2-ofir.gal@v=
olumez.com/


On Jun 27, 2024 / 11:10, Daniel Wagner wrote:
> Most of the NVMEeoF tests are exercising the host code of the nvme
> subsystem. There is no real reason not to run these against a real
> target. We just have to skip the soft target setup and make it possible
> to setup a remote target.
>=20
> Because all tests use now the common setup/cleanup helpers we just need
> to intercept this call and forward it to an external component.
>=20
> As we already have various nvme variables to setup the target which we
> should allow to overwrite. Also introduce a NVME_TARGET_CONTROL variable
> which points to a script which gets executed whenever a targets needs to
> be created/destroyed.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Daniel, thanks for this v3 patch. Please find some comments in line.
I ran "make check" and observed some shellcheck warnings:

$ make check
shellcheck -x -e SC2119 -f gcc check common/* \
        tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
tests/nvme/rc:962:5: warning: eval negates the benefit of arrays. Drop eval=
 to preserve whitespace/symbols (or eval as string). [SC2294]
tests/nvme/041:34:36: note: Double quote to prevent globbing and word split=
ting. [SC2086]
tests/nvme/042:40:52: note: Double quote to prevent globbing and word split=
ting. [SC2086]
tests/nvme/042:54:61: note: Double quote to prevent globbing and word split=
ting. [SC2086]
tests/nvme/043:37:36: note: Double quote to prevent globbing and word split=
ting. [SC2086]
tests/nvme/044:36:36: note: Double quote to prevent globbing and word split=
ting. [SC2086]
tests/nvme/044:42:36: note: Double quote to prevent globbing and word split=
ting. [SC2086]
tests/nvme/045:41:36: note: Double quote to prevent globbing and word split=
ting. [SC2086]
tests/nvme/045:47:36: note: Double quote to prevent globbing and word split=
ting. [SC2086]
tests/nvme/045:72:43: note: Double quote to prevent globbing and word split=
ting. [SC2086]
tests/nvme/045:82:43: note: Double quote to prevent globbing and word split=
ting. [SC2086]
tests/nvme/051:40:25: note: Double quote to prevent globbing and word split=
ting. [SC2086]
tests/nvme/051:41:25: note: Double quote to prevent globbing and word split=
ting. [SC2086]

> ---
>  Documentation/running-tests.md | 33 ++++++++++++++++++++
>  check                          |  4 +++
>  tests/nvme/rc                  | 57 ++++++++++++++++++++++++++++++++--
>  3 files changed, 92 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/running-tests.md b/Documentation/running-tests=
.md
> index 968702e76bb5..fe4f729bd037 100644
> --- a/Documentation/running-tests.md
> +++ b/Documentation/running-tests.md
> @@ -120,6 +120,9 @@ The NVMe tests can be additionally parameterized via =
environment variables.
>  - NVME_NUM_ITER: 1000 (default)
>    The number of iterations a test should do. This parameter had an old n=
ame
>    'nvme_num_iter'. The old name is still usable, but not recommended.
> +- NVME_TARGET_CONTROL: When defined, the generic target setup/cleanup co=
de will
> +  be skipped and this script gets called. This makes it possible to run
> +  the fabric nvme tests against a real target.
> =20
>  ### Running nvme-rdma and SRP tests
> =20
> @@ -167,3 +170,33 @@ if ! findmnt -t configfs /sys/kernel/config > /dev/n=
ull; then
>  	mount -t configfs configfs /sys/kernel/config
>  fi
>  ```
> +### NVME_TARGET_CONTROL
> +
> +When NVME_TARGET_CONTROL is set, blktests will call the script which the
> +environment variable points to, to fetch the configuration values to be =
used for
> +the runs, e.g subsysnqn or hostnqn. This allows the blktest to be run ag=
ainst
> +external configured/setup targets.
> +
> +The blktests expects that the script interface implements following
> +commands:
> +
> +config:
> +  --show-blkdev-type
> +  --show-trtype
> +  --show-hostnqn
> +  --show-hostid
> +  --show-host-traddr
> +  --show-traddr
> +  --show-trsvid
> +  --show-subsys-uuid
> +  --show-subsysnqn
> +
> +setup:
> +  --subsysnqn SUBSYSNQN
> +  --subsys-uuid SUBSYS_UUID
> +  --hostnqn HOSTNQN
> +  --ctrlkey CTRLKEY
> +  --hostkey HOSTKEY
> +
> +cleanup:
> +  --subsysnqn SUBSYSNQN

Thanks. I think the NVME_TARGET_CONTROL script command line interface is we=
ll
documented.

> diff --git a/check b/check
> index 3ed4510f3f40..d0475629773d 100755
> --- a/check
> +++ b/check
> @@ -603,6 +603,10 @@ _run_group() {
>  	# shellcheck disable=3DSC1090
>  	. "tests/${group}/rc"
> =20
> +	if declare -fF group_setup >/dev/null; then
> +		group_setup
> +	fi

This new hook adds some complexity, but I can not think of better way. So, =
I
agree to add this hook.

> +
>  	if declare -fF group_requires >/dev/null; then
>  		group_requires
>  		if [[ -v SKIP_REASONS ]]; then
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index c1ddf412033b..4465dea0370b 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -23,6 +23,7 @@ _check_conflict_and_set_default NVME_IMG_SIZE nvme_img_=
size 1G
>  _check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
>  nvmet_blkdev_type=3D${nvmet_blkdev_type:-"device"}
>  NVMET_BLKDEV_TYPES=3D${NVMET_BLKDEV_TYPES:-"device file"}
> +nvme_target_control=3D"${NVME_TARGET_CONTROL:-}"
> =20
>  _NVMET_TRTYPES_is_valid() {
>  	local type
> @@ -135,6 +136,13 @@ _nvme_requires() {
>  	return 0
>  }
> =20
> +group_setup() {
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		NVMET_TRTYPES=3D"$(${nvme_target_control} config --show-trtype)"
> +		NVMET_BLKDEV_TYPES=3D"$(${nvme_target_control} config --show-blkdev-ty=
pe)"
> +	fi
> +}
> +
>  group_requires() {
>  	_have_root
>  	_NVMET_TRTYPES_is_valid
> @@ -359,6 +367,10 @@ _cleanup_nvmet() {
>  		fi
>  	done
> =20
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		return
> +	fi
> +
>  	for port in "${NVMET_CFS}"/ports/*; do
>  		name=3D$(basename "${port}")
>  		echo "WARNING: Test did not clean up port: ${name}"
> @@ -403,11 +415,26 @@ _cleanup_nvmet() {
> =20
>  _setup_nvmet() {
>  	_register_test_cleanup _cleanup_nvmet
> +
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		def_hostnqn=3D"$(${nvme_target_control} config --show-hostnqn)"
> +		def_hostid=3D"$(${nvme_target_control} config --show-hostid)"
> +		def_host_traddr=3D"$(${nvme_target_control} config --show-host-traddr)=
"
> +		def_traddr=3D"$(${nvme_target_control} config --show-traddr)"
> +		def_trsvcid=3D"$(${nvme_target_control} config --show-trsvid)"
> +		def_subsys_uuid=3D"$(${nvme_target_control} config --show-subsys-uuid)=
"
> +		def_subsysnqn=3D"$(${nvme_target_control} config --show-subsysnqn)"

I guess that the lines above caused unpredictable values in $def_*, then
caused many of the shellcheck warnings in tests/nvme/*. I'm afraid that ano=
ther
commit will be required to modify tests/nvme/* and address the warnings.

> +		return
> +	fi
> +
>  	modprobe -q nvmet
> +
>  	if [[ "${nvme_trtype}" !=3D "loop" ]]; then
>  		modprobe -q nvmet-"${nvme_trtype}"
>  	fi
> +
>  	modprobe -q nvme-"${nvme_trtype}"
> +
>  	if [[ "${nvme_trtype}" =3D=3D "rdma" ]]; then
>  		start_soft_rdma
>  		for i in $(rdma_network_interfaces)
> @@ -425,6 +452,7 @@ _setup_nvmet() {
>  			fi
>  		done
>  	fi
> +
>  	if [[ "${nvme_trtype}" =3D "fc" ]]; then
>  		modprobe -q nvme-fcloop
>  		_setup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
> @@ -873,11 +901,13 @@ _find_nvme_passthru_loop_dev() {
> =20
>  _nvmet_target_setup() {
>  	local blkdev_type=3D"${nvmet_blkdev_type}"
> +	local subsys_uuid=3D"${def_subsys_uuid}"
> +	local subsysnqn=3D"${def_subsysnqn}"
>  	local blkdev
> +	local ARGS=3D()
>  	local ctrlkey=3D""
>  	local hostkey=3D""
> -	local subsysnqn=3D"${def_subsysnqn}"
> -	local subsys_uuid=3D"${def_subsys_uuid}"
> +	local blkdev
>  	local port
> =20
>  	while [[ $# -gt 0 ]]; do
> @@ -909,6 +939,22 @@ _nvmet_target_setup() {
>  		esac
>  	done
> =20
> +	if [[ -n "${hostkey}" ]]; then
> +		ARGS+=3D(--hostkey "${hostkey}")
> +	fi
> +	if [[ -n "${ctrlkey}" ]]; then
> +		ARGS+=3D(--ctrkey "${ctrlkey}")
> +	fi
> +
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		eval "${nvme_target_control}" setup \
> +			--subsysnqn "${subsysnqn}" \
> +			--subsys-uuid "${subsys_uuid}" \
> +			--hostnqn "${def_hostnqn}" \
> +			"${ARGS[@]}" &> /dev/null

I suggest to replaces ${ARGS[@]} with ${ARGS[*]}. It avoids one of the
shellcheck warnings, hopefully.

> +		return
> +	fi
> +
>  	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
>  	if [[ "${blkdev_type}" =3D=3D "device" ]]; then
>  		blkdev=3D"$(losetup -f --show "$(_nvme_def_file_path)")"
> @@ -948,6 +994,13 @@ _nvmet_target_cleanup() {
>  		esac
>  	done
> =20
> +	if [[ -n "${nvme_target_control}" ]]; then
> +		eval "${nvme_target_control}" cleanup \
> +			--subsysnqn "${subsysnqn}" \
> +			> /dev/null
> +		return
> +	fi
> +
>  	_get_nvmet_ports "${subsysnqn}" ports
> =20
>  	for port in "${ports[@]}"; do
> --=20
> 2.45.2
> =
