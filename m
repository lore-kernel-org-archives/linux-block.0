Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Wq6WEXrG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EUdzH23U"
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FBAF7
	for <linux-block@vger.kernel.org>; Wed,  6 Dec 2023 18:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701915749; x=1733451749;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v71yOZtwoV7qa5QH+71PtODk//+Rj+alSUqpt6uBG38=;
  b=Wq6WEXrGPwKuOu0YdpbKL2pL5lOm4vg3uNjFlzpWhulqhumaeOLWMMcm
   Ubq2XlPIaMO8LeXLwC7syDotQrzhNNJXxdCLAA2F9EQMXVtLC2W7F+5gp
   zIwz8ew2ywbVE8zECl2wBvlcUQSN0dXtSJk3eZS5Ll5KLkENOVFlgFu7U
   FORcpHKgiUnYKU5D7HwnRohRLZAYMheh76aHbdjyNbDcyVa81E4V84fVq
   01oN+kAHCcDwGmuAEau83b8RfoWYQNvxS1KClpD5gVzc5ABwPXcEy/iNq
   rPmHI/VHkFReKKK31k1VWIe47Poe6E8zOyJOQXa69z1x4Ick0ckNapmV1
   g==;
X-CSE-ConnectionGUID: hsofh20WTPeowDZkUWSxXQ==
X-CSE-MsgGUID: socyfTHGRaCswFMl16QMtA==
X-IronPort-AV: E=Sophos;i="6.04,256,1695657600"; 
   d="scan'208";a="4064350"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2023 10:22:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yl/mf89HpyaSHoqlMrjKoQ+dE+CfPBvbsFA+j+npqOZsQx8cbagTkKrAjqPMoyNs3CgpLt3pP5it5iIpxVUjy1BHE0RD2Ul38m1tR3CabVb1U91dug1zeksFbn8MvCeCKGqA0imtDwTio7GdCLAf3wCzFX1ISzlFaccBtK0OHuhZ7lJ7KeG4R2vz/V648W8YgVXrS5H3P6KsUB0PH9gNrS+lkpQvsDQSeoFBdr2ZTxA9LhqJPpvaQ+CTojJkk4OXvUgZx6h+MeLRtJCVORs9tavX3ft/H/UrpK4jWKr72kJlmAyF88SawWc0AvVS8WnuCecOFo0dkDkuSccVS9u1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97VMGrXcxkBiB5aZp+AnuinCZS9WVpU62vAWKJRrezk=;
 b=VNHg3WEd09/f2tMEFYCdYs3z0k2cedknuiq4AkPZFOxjwMny6eTswrLsUVbgBX9kz3VfRbN+OzXDh14daQoLq/2eZZ89Rw3lCIq5TBvS+rPaDD42DYQVjzTVlaOnLWEaYhpLrIISGeTB2YmncRvMCeMKhRt4IcWRbh1m0IW3d6IeUoyri9YQAC/6Z1p997u7MCBt7XY5B0MLsxPC2fH1SAaeN1zMOHjt+ian9xwsrMQzLXVrz3Arz4KyLiwhVThEh2wRF7CXMsEpw0jt+RGBBIoY89ybR8PMIP+tUZkWh/sAHmR+5ucYq+XNHBqvoiNKtbW8X7UJRSXt66wpJtngoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97VMGrXcxkBiB5aZp+AnuinCZS9WVpU62vAWKJRrezk=;
 b=EUdzH23Uvdsla0t1u1xhr3LqGwBndxC6AqVV4BgjgErVFMQPylJuxX7lgS6sCTdR6fwQ7Kun4cNw2c7RSWAFznQ6JSleThErdWIlGbCp6HBaiHVAipC+XW+VhFr2ElaHDVvq8wfgnTFzgd142WrBISTxC1lTRGGOMPwR62mtTN0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB8565.namprd04.prod.outlook.com (2603:10b6:a03:4e4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Thu, 7 Dec
 2023 02:22:25 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 02:22:25 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests 0/2] improve block/011
Thread-Topic: [PATCH blktests 0/2] improve block/011
Thread-Index: AQHaIq9GMOGFC8xc2EyAkNng7bS9ZrCdIxCA
Date: Thu, 7 Dec 2023 02:22:25 +0000
Message-ID: <nqdy2k5xs5wd4l5m3ijg3qhvw6wo4vbvkyxcaaajfdvv3kmqa7@2gs3ra6zrdzz>
References: <20231129103145.655612-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20231129103145.655612-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB8565:EE_
x-ms-office365-filtering-correlation-id: 16fa010e-b3f1-4a14-f911-08dbf6cb5a4d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 l4sL/m1Cme5aCDU+u/e+pA8lK7sehwjpuW3GsQkTzNsIPmYED+BxkMj+ntxkBm3uEctdtlE0dVVTFITgsmCf5kPpWoJmw1D47cbnJtRQegnOfAStrQS1pqarpItgvQ3OqvSiuWYy6eHjigXtD1IB32iNA8TqGcHoaEshnr6j0P/Bvg2nYfwRXUBVL8Tr9vdxLUCmPdOp2Ya9wpxgNz9khRdnjbiXIWT0ovSvzuvnM+ocVvGTxU+KjR+jlPViKrnsBawipZL3eXp6Y9z+di4d75PN4qGtniq3wJXsP36z0kW2lptRcYFvjFCn2G8zcSUUcgbNA/RNi9LQJfYaLCt3gyfoZkhgYqODDgxZ56MVcleH6gECHO0b0U26CaIzc7XodgKV3CZczQ6ntAfE545uJiDpUWSCLobJ9qhOqk4QIUjZ+fJ5ZCw8r3/VHmmfeIgUw10v4taQ++yVAxrwYgxR94tiKhMwJGzMha5qy1Aodzumd7ZrJl4VA4Bey2ELk1mAjkAZc/BzQaG+WEotB/NV18BL8PPqoqxrsa8UOGvbb5ymMrSUzj6Awq3zg7Gd96wqoW82FZRBqlHtkPF+pa7uW7NCM3VMcbQCsVYUQvxkTc95luoCTB8JQxOio4ZV/05+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(33716001)(38070700009)(5660300002)(38100700002)(122000001)(2906002)(82960400001)(4744005)(83380400001)(9686003)(6512007)(6506007)(71200400001)(26005)(6486002)(478600001)(41300700001)(44832011)(66446008)(66556008)(8676002)(64756008)(8936002)(4326008)(66476007)(91956017)(316002)(66946007)(76116006)(6916009)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kJaQyQz6SCPEcxgg1IrMx3nqAW1m65BRcYU4ZKAgvTbmCrUJJ9M7gPgWfGBJ?=
 =?us-ascii?Q?0HMEnlFwS6fhf031gc35e7hokytN9lIm+v+q91d85YvF0okSe7AN3nNKRGCy?=
 =?us-ascii?Q?la3J4xTgXrkLrTnDFNZXdhtIYq6pTVDILLUk7x9yzmmpQi7nJ2IN9cUxLTyC?=
 =?us-ascii?Q?myjqQpnQpl5oQN87NEZwXtfnKJFnbYpiBdn/mowGrYKeoPrXBh2RNmTaeGqh?=
 =?us-ascii?Q?iN0t/2eDS3LFLQ0Bn2T20GowuNakFA4ltBbLNsfqJ2uq/vr+a5OocccgsmGA?=
 =?us-ascii?Q?QUmnJ9HVVsmFnMM/E8WTgmOAzXWkBMl8aa07VwJCCnzMyiXGztOzFYaVV4nS?=
 =?us-ascii?Q?No7H+LnsNKA+oKMLWJSTJCe1jLirtP8Nf2T/AT93C9Gw2ZajyrCdGyW1mSuv?=
 =?us-ascii?Q?6bE+IuC8yJMbHG6ndp/lxn3fXKSvtjskP/87H4svIzCwEIRyp77tOKVwSrwU?=
 =?us-ascii?Q?ucZhNVU10c6sU/VV6aLv9VKMjo9W9CMPtcYZqdATmpLjMCTrNJShOacunIGK?=
 =?us-ascii?Q?lST/ecDByaUlLqjArCTb+eyIUZs1Msigx7q/akHCICcc1FapeMgdvBLDSynw?=
 =?us-ascii?Q?M4AL8fPms4OW2kn0BlaePA6swElHhNcIl7mf2a9/an7qGGxhVXGITPUUqD6D?=
 =?us-ascii?Q?CZ4c9elwM26YvZafwtre4YkcFcUkh3yVK0T63ViLuna4SugxWtZQNv1CBMxD?=
 =?us-ascii?Q?vOoRs+aaoXUM+yNrHtkWGLSqglnw7MzUkfuw+9tPW6hQpJI19GlcpP9W0dpD?=
 =?us-ascii?Q?sfQ8rkdTCcVpwRoS+vX5HHAueuQHtuvIL91ftMAOexuBC52z3FDYkiDArfWf?=
 =?us-ascii?Q?mh7RcSevBpIj9ACFkF+yblCYSBxbjv5USJVy54Ofxa0YO6kwogv5jzSBkXKu?=
 =?us-ascii?Q?hyh3C/2ihyYHop0C9Gp2rlm/KeYDTkuiZaNJ8k+a5zFuXcXsaaRSRkNq5aHB?=
 =?us-ascii?Q?IPw01G5zlHgLYCpcCtdrcQmr7MkBIycucbh/zpGrgWZpBWl/5A5/hZWEzEQ/?=
 =?us-ascii?Q?S2yn/l1mQCxd5geGJQzE+AtVJ0/G2ZhOJUSvYNRUPm0H2HHmOxGnf8BeHBy3?=
 =?us-ascii?Q?vnwWMDaqJEzOhBNTCsXm35yKI6hMJSoZ1P7Xokz0GyTypxl92tw6+XN2+cYr?=
 =?us-ascii?Q?qG9YcEi6h7XjpfUgJype0DBkuQfedOmWxB3/b9L+3XlMP3aVXS+kTPjWDTiu?=
 =?us-ascii?Q?E5BuOyAMaZok65nyJE0hHVZcr2l8AMvQWI6WUGPNWeY+mXAXm+lcR02ZDemx?=
 =?us-ascii?Q?3cDiXMDyceYdW2HqQuO6on6AirGVUnJb6MNl8hi+q72TzCQDXuM/y/1erqJP?=
 =?us-ascii?Q?CLyO9Wk6OCZeZg89l4JODBXqwS8X3xOuVPwwm/oeboNBES6GFnmyhZdyPct9?=
 =?us-ascii?Q?8zSPL+z1QHrqbCbKfooRWfbpfPWVzB0oyOpQs+35GWKWBWjk+qylKwETNffA?=
 =?us-ascii?Q?8XIE9DE7PiIwWZC8PGdm30q9l3PqFRllEPNtDakHNXqtHvfhv5no2dUAvExi?=
 =?us-ascii?Q?nMemJbZ8agGIirj3GWaCE9FGICTiAZ5Cg8BHM1SXkQ3U7VVJVNzKJz8ZI84y?=
 =?us-ascii?Q?+XHqxQ612jJBLbJ02i/JSMlY66OIo6teqMa76MAxRM018AAInBcBeMx7EgGj?=
 =?us-ascii?Q?gg5MqozkGfecscnskBBNYV0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <11278F471D05F246ACC72AA4B01A943B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T8yKMXh4SgOy38SWc1i7+yP1SbbVXFyzmwZxuE25QSpp/Xy49Ls1aITBYiv+L7AgltlKIMKJRYibj/rbX/K8QGIkcEEqoennjOOEzaNMR5JUhCs5gIfrGN5BCpwHtJ39xGJUhVQbTEMdf7VtCpq/Amye0MiRHOl883ctiP03OSEM6IdibCCHyI3096ch65hubm8RxBhqsbcmuuz04a8wQxV8ahF5WSmpt5xmzXv/TjjPMcseky5Pens3hDAl8GlUPi0hZwP0AMDhnOJOQS+IOgreZLRTf+oAQMBYFDIgj51R4apPCszoRE0p9+JgHwTJkMJjij9dB+eolZeBOuFKsy9guO8vpvSR31uQiyMVC1i01AlgQ85dCD6/gKCryUeoB6QT433DVDb4ziWfNn8oXtUL9pmjHfHgE+bXHYm93FbSfUhG/TTKyZSZBc/hO0VU7ntdgHAyXuibbwB3XtxsMtvgXbE6gpzUW3VUWmr/zpU1kgK5qUo0+40MzYE2g3CfdcMdNBsQfIpfrPEMqVX4kZUMTftptPhcIE3XpGbEnJWzRO73+3liWUj6aP4aAZO59NDddZl/IMqr39BECzC9Pabnm62cHJ2j0Okz1frKaZPR0qvvPRiTfDFnjp13OhavqH0n2bM+EuHMEbLE2lpsVAYZmutwNCLDmAqiZoOSP55nHKRMaFmUK8AEXSgtfxJRbrBI/nO/OjqeIXpyrwwvnT1a5dSWmx8Sr/XDpZTnmj0Z1Gn0/Al4XUK2d+UkoYJ0qyEzm9W2amSOigpFMW3kEQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16fa010e-b3f1-4a14-f911-08dbf6cb5a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 02:22:25.6311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UoWUYDS67H1Uw+71/evzSVyfVmWJoCO2AqWMaYb5fCwo4y2ZdpvvBppL66mOTc6rZxz6ohBmMjVM9knPRimMPFxsWwgl1Bh4pruVwGkM1Xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8565

On Nov 29, 2023 / 19:31, Shin'ichiro Kawasaki wrote:
> This series addresses two issues of the test case block/011. The first pa=
tch
> avoids bad status of test target devices left after the test case. The se=
cond
> patch caps very long test time of the test case.
>=20
> Shin'ichiro Kawasaki (2):
>   block/011: recover test target devices to online or live status
>   block/011: set default timeout to 20 minutes

FYI, I applied the patches with the suggested fix.=
