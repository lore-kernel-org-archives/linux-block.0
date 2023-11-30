Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N2gzR9mm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XRLQikEk"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B92C4
	for <linux-block@vger.kernel.org>; Wed, 29 Nov 2023 20:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701319038; x=1732855038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YjHQINe8nKvcIiBK6mkx9iJQA9LSptFNygLYS6dz7Jc=;
  b=N2gzR9mm3BJX7LaBxxD3DFq8iQ5iNbu8WtkglLfj/xE/53IacbsSFu5E
   7/FGzqNru6t4uQMTU9Aa+KU2u1fgexwlUQrd3zF6G14+7VDglACK/kMbm
   Oa+BibHPemLlW3w/ZHwKxLLva10S5AttJzzQPCx+Z2VlR3HTDlhEi3Som
   iRWohPSHPBSshd6XF5vmMwT08LzPfcpiCk9gVzCyWRmFu9VCibXg/BaVr
   6FnnVEMFYBA6nF9XD7bRZnSa5GvxVpkQNRcLxwAq2JgGiL0hozwmQ/JwO
   mNkcMTi6wVTF18tA91C7G7+0rXLqwHm96XGzIASM4E9dAsLW97upmv6Dy
   Q==;
X-CSE-ConnectionGUID: 3jWjjS67QR6RxDcmFToOVg==
X-CSE-MsgGUID: +0HN+7yMQVyZgjl/nAycyg==
X-IronPort-AV: E=Sophos;i="6.04,237,1695657600"; 
   d="scan'208";a="3685685"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2023 12:37:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwNh+Qid/pDboMCciKrNB6sS3O7tBcCrduffyMEBFe8M70DpGVam8Jj2RMRMdKiZMQ6Vzakr814W1aedcy9YVMVvNw67nLcEX/Jj1dt0WB2avp6zP5pfrMvaTZUDfkxT4x/6TxQhshtoXvC3falGhrj2Q4QImFHbHpYlqw3tsVMRVNLrUVcThJnfhfSH478VOd3pSTt9SrbGena42gQP8tfrykx9Sq9HXEk7ESHW0YjZ7Z0OBJQB4suQmexR5shxRg2Z2kj4LFbi77lg2LZiMo8panMbvMpMmzZSsWPDi99ySuRJIoew3S9PZoBHeZqevkfk8YTblE7p3ACboJPmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjHQINe8nKvcIiBK6mkx9iJQA9LSptFNygLYS6dz7Jc=;
 b=ivDgCRVN3csxy+RtIIRi1OaBqjaOKwfjDXGLD6MeJFj9yGRqNe9r9psJw6kPbTs4NDtXL7rWRlUajhkWxZ9P+3RcBfYnMibVoUHsIdY7VSUAkERvNc1JA21T25ZHB8c9UAgCOChE18YUOASN9OV7/6X40rRclTylQPUzc05/zZFhkP0DAB2E26+z6YQZS1bS2zO4DK/yxio6hd0FaTxlC6VmduCj+xhIYQQmVexLvPqluhs7nAqvgJ1EOqKYpDejEgNT5K/9kdUMhR10dGimPIuUiQsh/JRmTr+CtkuPLXu9ze38eF+ucYx3toFY1HYUzE/et4zCYfBD7tlkIILsqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjHQINe8nKvcIiBK6mkx9iJQA9LSptFNygLYS6dz7Jc=;
 b=XRLQikEk3rVsyVoHYtNuEF6dmAK62fu8FIgqyrU6hlHm+o+YTvC5o7Cw3YwH1KfOdAmqfbxlAXqC/H8jr26gy5h8EOcfA+HVOlMUUkyHpOra6XMSLpCCZItjTkxwglZzHI8bCyoOYCUfW94Z6OBiGj5v5Xi2ftdp/UkIRHs1kbc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB8439.namprd04.prod.outlook.com (2603:10b6:a03:3de::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.22; Thu, 30 Nov 2023 04:37:11 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 04:37:11 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Alyssa Ross <hi@alyssa.is>, Disha Goel <disgoel@linux.ibm.com>, Bart Van
 Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests] loop/009: require --option of udevadm control
 command
Thread-Topic: [PATCH blktests] loop/009: require --option of udevadm control
 command
Thread-Index: AQHaIrhIty9CQNVYYUa7IJZLjIom5rCSSFOA
Date: Thu, 30 Nov 2023 04:37:11 +0000
Message-ID: <2fkfg3zuasjz5dqs6aj53uq2u2nth5znrno34qdbime6fgd5rl@liuasrtxdg75>
References: <20231129113616.663934-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20231129113616.663934-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB8439:EE_
x-ms-office365-filtering-correlation-id: 12bb1ba6-bdc2-4de4-ebb2-08dbf15e0504
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0Sf6wg1eAXU2hthH5fkwrfOgKTbHkrq2KPlPj2hkkNx6aJF2oWgvBjZgCYAcQIv3mDfTekE2MsDFySK6mqtJX7DcSIHzMlP4wbwAwiwE76H2ixYKSwTJx2aw45UDRwmrbOELxGU7g8l07qIh/JZQ9yIyDZSkDdrH0phAkHH47f4+sKoGFsU8n80wnyC45N40e6itT05AV3SvIJNx/5NfxjNXsjXyi7QTrft80HLuxOTu1EYYzZliQeiJl1W460/fdedyd2pVfEOSleqxjEwP51ZZ6XP8QfmOMlTpHglNxRQsg/lp0dxDeAakAsVy4/1asFUSowqItbrF8x6aDb5Y/JezVJE7YcEPHOQ4RhmOoOeTPdCFHaZndkNe7UhNvaAGKqnBIB2jtl13a4XQTbaOzP36cJL4n6zKN0TbwJlDRN0Q/lY9YJbL9AmEO3DAXJC1jSCFbGF5Gl3opX8AcNwJow34ubyV5CQNdYpwW9iEltSjrRU1KGX5aljgkQ0my2nSlyBsTrvDg1GOE0+NU5AjjMVHpLs6f5HSG6G2qF0Oslz14RtxjwtSOFf0tvyzbmaacHGYkKsSzou6BoI55CXYVQHEe8UeO4JdgvjOUrXEkRTkrvyBuCOFaliDkAhEfdXwhExOu2qja2Zlnk7zyfhQhg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66476007)(8676002)(4326008)(8936002)(44832011)(316002)(83380400001)(82960400001)(5660300002)(91956017)(33716001)(6486002)(54906003)(64756008)(66446008)(66556008)(76116006)(6916009)(66946007)(122000001)(966005)(2906002)(38070700009)(38100700002)(6506007)(4744005)(478600001)(71200400001)(86362001)(202311291699003)(9686003)(26005)(6512007)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P4jtQka9MGhufH/4j9TcVChX0/VKy8QTmee+vyoPlStnURP4GTWq+XJlihVh?=
 =?us-ascii?Q?5SbTt0DOsY3uNkfKxY2M2Jpzs4WQzdgSXqpNb8D4s7cA/JbudHx+ktHrH8C0?=
 =?us-ascii?Q?7TWfbeG0AWvGdDzLgn29F/nT5j5kFvAR3dpFhVcqZNhZzfNOjKWLarvstMEd?=
 =?us-ascii?Q?2ZTWAuavxI8oT8AHgKQlNvyGazfj6864pSXOZQeVGHMLk/TPd9Rqe88HTGb9?=
 =?us-ascii?Q?zqdUFeWT5sk9S+EW5Ics4t3Ozu8DtkZce1h7Ds+71o11QqkxOGbt8+8YS976?=
 =?us-ascii?Q?dEE8lKNkAcp1iRT94HmvHcYVpAmu6oRzaMViaV6HARMtDaqqktTOm0JDb1JS?=
 =?us-ascii?Q?Evum9VTrcY68heqFfCQFafiLZNDkEF7sDRbYHxY7bpaLa8RT9TJ1hFCcC/96?=
 =?us-ascii?Q?5ufpjvi+9bT9muyUlS2J46RaGnhO4LrMzKeAsz61pEwAK3xIDmuGgq0aZEuR?=
 =?us-ascii?Q?oAamsUHGI0RA25ImlbFGN/QbmiwF5Pf2I5mOfcjEzB3DOk7T8O4gX02ezdlp?=
 =?us-ascii?Q?L/Dgg48ggenF0tiGDEQGkzZBnDTyzt/b9tvo3jLoCQURYUF4gvw1T8T2VK3J?=
 =?us-ascii?Q?1bfj7b+cbmHciWJCZeYrhdzaqntGhVBZYePXathlbnDuRXjLJuu2KD/sFZ5j?=
 =?us-ascii?Q?h8XYzKrSK2PQZXiCO0i5Uw0FNwSMXn1C718vInvokqeE4NVuFlzkuu56uGcV?=
 =?us-ascii?Q?N6erO0ow6o3EJ9YXD8HTDU4x93yvcg/nDx89I2ZULo+RyxQ3X0mcBlJLmnRr?=
 =?us-ascii?Q?XEeIl+cZ9iRDIeIOqcWzQAzTSrhXSCzWS80sYLYE3at8mi3+AMplzMzlOij3?=
 =?us-ascii?Q?efH7za/PJ6XebxJMB5PxYRhBTdXoC9F1+V193kHuVIAMtp9UuiOWxCiadoWY?=
 =?us-ascii?Q?J9oFp38BtN90jqibAVYW91aotEjV5z8qxbgt4b8GtRlLxC45tpEyk8r19UbX?=
 =?us-ascii?Q?7TMxp6LWJ79a/gKP7Kfx7UBC2LyPQfAOXmwej7RXiiydTbkzRUClJALP0A8p?=
 =?us-ascii?Q?xjhUnIm33XCJi3sJFD8FfJsHD/Gf0lDIov3Sjrm4dxg2X5kOXLStB8/YoPGm?=
 =?us-ascii?Q?rmt7jbqPFGdTPOp0nS2HAC74Hnky6QaBDJ/nyTxyR7yV+jVeNVFHUbq4Wpfx?=
 =?us-ascii?Q?1JWl9NIOuPnq/MPnNZaPRDwpQ55kRzaKjtT9yRwpJbhDaEKVoLdvOu+jUxsD?=
 =?us-ascii?Q?fRSn0mukM5cRQlkD5yGv81hYjYuHeipJdzPivBYpdztAjlJFM7wY+iB7dYel?=
 =?us-ascii?Q?o3K97qlpJG5m011E5uw9mt3XaOdaR74RuKelqZl4lqZwy0ZTXhw2m4o1Lm4R?=
 =?us-ascii?Q?S90XP4YbYd6hYGWcbzavbeMXUfVi7c8YgL3qYIdjRAxL9FBwFmdi3ZDD1FEY?=
 =?us-ascii?Q?9c83dRBSGkRmfWkLqgDzhFWivqUvY8sEWL2q3LgJVy5DDiOkY5j/2d7lBTp3?=
 =?us-ascii?Q?SS7uLCac5eXSfrggC7L1deMbbmpIptTG9fu2K//9mO/9W9ZftJa4fSLVxydh?=
 =?us-ascii?Q?/n2uwv9un53Rt6Kfe2HRWbJkqS9IjGhwibfH2euk3CX+lZhBkRHAI4HZmIv8?=
 =?us-ascii?Q?HdNTj7iU0FyPKjHGlmZ31bVsp7KBBF2HvduueZy6oDVSSPSSYmel7A63+kum?=
 =?us-ascii?Q?GZ5HMVtX4w7AvfEssRMX1ak=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AD928E93838A9D40A4B75AC3DA53DBE2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DOZLv3bUOjwZ0+XL5tyB9l15bfAbITjW+dgf8u2QkwY021HbPNaYUqne4knY2ThpYofAiUNXs3PWHUfjhxqGV4h9imFtvZZkMvUGS0v0olz5pfuipGhylCyu1k2SePETSVWeRp2nQttfg3hnv2rQbj+hyikl4WO42My5/8N8UqPZVZDWvqCq308RmxZHgifItTqvBU+kCKQudAKasry9RJXG2NL4nsOrprHZP0nA60ewYVranEru2MlYM/OsZ6238s8V7TwfprkcsW+tLrsd0KrsM/RwW/vDOdM71/FeIUoDULcgtDHCYbmLYUTl9K8IQ7+KZYDy+AeA0TapOa1prkFm2UoTAe6CS4Th+UVX52vhWm4KnCV/O69Qu0xVooKRqTt+DXHY/xJXlUYFLnnDIbuNA2UspBSAFvJ3xCibKmHowYCTExFmGkB+HejoBjAvW+2LtoBIcLFh4x2zupaZc1jdOYZCyBALT4nIPItoG6P2QEHttSzc/glWL3Z79ZYUc09Rdwd1p6oqgYH3hsWyGF7MC59NQrLTwQDGCYjJhjGkXvgW7rBJwsDEvB3i4nQt6esD+VdZWf3ZlrtnRGj8ANeNLA8siE5/gyUexJuGOFDpPwZ0d+ITZfqpoJuLs3qxRnNUgptfKIM6cfuADd1TM0DYDpNi5YX7nucQfKfTyVZTQFgZwVa7quKQXtmf0ny5+iXZx+JFDEEJcYasB1yWaf5kff6aHyrbD8llpk31M3l/Vq3aWt2KQBj2WoFU8TD40z1HDkA8tA9r2oWZCrQIPW8GKhmfQCIrJb7j5kU8sZ5syV+mZPY4DC+9ZcGd/xQHXNB7A7gOZFcSnNTUBt1Hz3FBbvGtnRqi903pkLREv5huqZX9tO30r6b4/n2ihvzl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12bb1ba6-bdc2-4de4-ebb2-08dbf15e0504
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 04:37:11.6364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qPpAFfmr+QLdm0yvCBO4vcLTHIy3LQoaSs8ItC1KNTyJMKBmaZz+QNGZZu/ybA77QCCbrFXx42lM4KZaqGwzW+8cpme8vgNrZMouB1oWqV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8439

On Nov 29, 2023 / 20:36, Shin'ichiro Kawasaki wrote:
> The test case loop/009 calls udevadm control command with --ping option.
> When systemd version is prior to 241, udevadm control command does not
> support the option, and the test case fails. Check availability of the
> option to avoid the failure.
>=20
> Link: https://github.com/osandov/blktests/issues/129
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Thanks for the comments. I've applied this with the fix suggested.=
