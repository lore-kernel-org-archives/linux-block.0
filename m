Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C9E219FE
	for <linux-block@vger.kernel.org>; Fri,  5 Jan 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QjLz5K+Q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MSbAd2sn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704444676; x=1735980676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XHGWW5+PPOdr3e+F2CmNPMdbil/+yaKVatZjet9tqWE=;
  b=QjLz5K+Q75deqr3S324l5+oBsI0peRJrmfBcZA8ut6eUR5vs407uDAbB
   oV7RZUhoknpSCAmH0dQV0nf4Bxs4Fpetx41nR9xaESpBxVWOppP5o99Kw
   EZoO+gaXhQvcQPwtB8ez2N51DUR+frRhFe8KeOJFhSCJ/dnJsyu6xTBw/
   3Oo9Ys/0PemK+nf5QvhzgiVlkClvvRBNYmRj8GR6IqSdsV6Dksdb8Y3Cl
   fqrO5OL3bxrL4FbT34rFqAUH9I/pKmjRCSCzqpQONmKeDCreCm7S/W/26
   wkd91VoHNi3VbmerSN7nvYybrnRFbnurqATOpwz11JxZsklatNjdZGniF
   A==;
X-CSE-ConnectionGUID: /6o32C3xTKWhqPaGW3lyDA==
X-CSE-MsgGUID: qVfrrpt4SRuZ/kdlg4w40A==
X-IronPort-AV: E=Sophos;i="6.04,333,1695657600"; 
   d="scan'208";a="6443743"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jan 2024 16:51:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTV6vG5B6p25wPGKn6xiNry8y0IEZuAr/2rCaDFm6SLNB48/vl8Z3VWaKyJUgCEWqb+t7+zPEX8sMxHRA/C97XlG3joO/Vl1vBLcgWadNa8TFwIeZm4Qbh3V1Tig794KoAIKHPUr5WDjGBbVR8+qyHmK3ETqZur6qaBEhgHUL7sZunfgMVN4ncB7DhYwGZRzFTjY7ZeilGdYxFkADQzXSf5OmU4uu3h39G6JiM4LVBafntyI3QCaRomrlTsUZsnC9WLinPCzWYbhIfF/puIHKhPsfkUm+5hiESh/Mdfru8mOKmpYyZqF4QykXCpOWKR/XR9Ww+L+tEsGdWTXXcZAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRdXUBz16+pJSfr4Kc/mWQ+GrGYBwtGAW71kidRbqRA=;
 b=YQvb4pcEt2osNRRYcWjleTokyOBJmr6KRy9L5UD3pvXbLEtWb7xNQ38VjvsWz9rS5cY22GVkqXFwbZuFDR7qQ9w+sIFwAdjTpusGDEGxU54wRAzvrzj3i0Mv1mXp0QV5emhtJvU78FvxF29ejxMdvfKzGJoJClzQIyvAmsNjwbfAZnOU0RDwG/lhaxviO+7Wv0qr+EHXFv+0XjEfr1EYE4c9Pcf70Stdu3KGr1BZj3/LAwJmJt8Ps30DQpPNeeUfuocx8Vaj57zPOTMamGN3kljdMz/2851CG9lCFuh08Ea7sPdiNVViqixYEyAjI7AhdiHsfJ1T5CVe6dObOlgEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRdXUBz16+pJSfr4Kc/mWQ+GrGYBwtGAW71kidRbqRA=;
 b=MSbAd2snWCEsorJ+O8LqWDYikXIQuWCpUxbdSTISSAfg13zoMTWueL7wcFL3D45fCyz4f42wD6k3Rm5qjdD4/KZeNDsl6PaiS558MbB0W0bW18EbLxMwS+JScEtHMXgxuujg+KKJpN32QAbNQ7P3wnuDpOu905U74ucbPoB3oQU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6285.namprd04.prod.outlook.com (2603:10b6:208:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 08:51:13 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7159.015; Fri, 5 Jan 2024
 08:51:13 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 1/2] common/null_blk: introduce
 _have_null_blk_feature
Thread-Topic: [PATCH blktests 1/2] common/null_blk: introduce
 _have_null_blk_feature
Thread-Index: AQHaPjr3Fe+ti2U2MkidPUgTddv9qLDIPgsAgAKuKQA=
Date: Fri, 5 Jan 2024 08:51:13 +0000
Message-ID: <gotmnckavfr52ceu3pbxmuqfkvoujbpbrrub5uwdkoj72qha6a@2ycmu7vfmgoy>
References: <20240103114940.3000366-1-shinichiro.kawasaki@wdc.com>
 <20240103114940.3000366-2-shinichiro.kawasaki@wdc.com>
 <34ea6da8-9ac6-4449-abb9-5be02df08869@acm.org>
In-Reply-To: <34ea6da8-9ac6-4449-abb9-5be02df08869@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6285:EE_
x-ms-office365-filtering-correlation-id: fc358a62-66d1-4ce9-e66b-08dc0dcb78ad
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BAQF+LCmSvLPM6kGFD8QIRbqf0MucLmZJjuG2Ex93Ql84wd+pjOPAhykdJDGSKgN35lwQs7p0dvCH1vHdmO7VEpnW+v49CGinn3EWYVxatx+5Lo4kU1BiFMXcM9Xqx9EP4Ij+p+hUoveOiOgyNp1eq5ssgcJwx9Ouq5YYOmg9NgcG1ULXUPmxwqnBtOg5kpSIyT/pzDhGbxWSoMdaFL52XKGBHNOISF+7QX15IcefAqL13vZUizg8sRlxeUNm2r8QhQpvrJ1oIvf6v/RdKU0doYdlIue+moqNvifRiKfUhY9Qjff9jINpKaNzTpJoBCZlYxjmfceDasNEjXsrKJN+GolFvf0J24cSv6d2UQ65ENNAAbTzErSpZiCCojr6s5Jl196Euk1S2AkqDkTrcfwQ/gi81V/3BgJD+WL0ajRU4J7b4wbl4SLBju+U/UVvQ4gIOxFvgzoUoBuyYXo0ii2EMfB0LkFkBHlCrxqyOU9qBSn03qSR38PYixiAKLvgVrApTZLh+M9303nXDmDwlH9Vp3zAbtwfqoujBlsuqPxka+A7zRf03EvEwT2G6IAjlXHXjS8fpsBlOZZbrPPBGROL8EusaukqeEZ63p2fIxvVS1zrz4yuTUWVFpv4G2mZNdk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(71200400001)(44832011)(4326008)(6506007)(53546011)(6486002)(38100700002)(478600001)(26005)(6512007)(9686003)(122000001)(91956017)(66476007)(82960400001)(316002)(76116006)(66446008)(64756008)(8936002)(66556008)(66946007)(8676002)(6916009)(38070700009)(86362001)(41300700001)(2906002)(33716001)(5660300002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4zx1TnyCEeZDelcGDk7wr6RrXp98BHvhKeXhgcBlLfM6cI83MZXmoRRUy8oa?=
 =?us-ascii?Q?NrVkRxtpVrcbcHH36VYR8dAnEVeRXbh1WvaL380feBQlMKcnFOLhkwClpq+p?=
 =?us-ascii?Q?5OEHc8SvSNZ8kQpOlU4geETHDl59iOSzKBknXmyUy097ksWxUZOQM+yIIicT?=
 =?us-ascii?Q?4gOkV9E+ii2926y4ztYncAff8bqRd8jkqsi0FnOU28+UXQUMCGS2CTjlKdXs?=
 =?us-ascii?Q?ox/rqtHtHqcIuUmyGj9GEbbhtyR82KkDPrt4SyZ5N0T77KWQQ8m4gxnshQ+l?=
 =?us-ascii?Q?ipix/nanmIWcbTOvLg9GBP5uS9VmNkWqjQvQh0VJAhPmq1bccdcgXUq73vw2?=
 =?us-ascii?Q?Fout/31OQ7FMEiap2ZoEg1lllM1xicREdaCX8eYus9fZ9Ndi1yDiOrf9fGrt?=
 =?us-ascii?Q?cY/MuxlOBOGJadgkqbElvoiXWYxks8w0Jh6WjNrdAtlQ45kdRV/IYZ573u6F?=
 =?us-ascii?Q?FrvcegfY1FHiU3/zZuR3/5FaDbzB/f75HzAZGmiQRqQTiILsbMeWzWViJZHr?=
 =?us-ascii?Q?U+1z6juagJlAv70p6ak0AcV9RVAHBMbfuxLjWDshwyBoWNa24usuBVYrqpA+?=
 =?us-ascii?Q?cpvz6ISAfuW1x8TV+QPN57YXWf4+7yI10BPbESCY5wBm6/MT/7bRAfGsmgyz?=
 =?us-ascii?Q?SZYcR5JGP/JNb/ifG6JJHoJzSZkYAd11wChuAjykFSJzfhlYzXLToXY+6hbm?=
 =?us-ascii?Q?TeziIEPgRfa++j+pMlHH37DEkzecnzkOrvB4tdBBSZmu7fHEzl+fx0flLc0Q?=
 =?us-ascii?Q?Ziey8ddgVcCLCtjXMeHpHMVtziMtrMnCkhtZi6MhmhXtzR45wgDtGlylvSr9?=
 =?us-ascii?Q?pC8M3bKqeIR4qYqHOQsc+RlXYA0p73cX+0BOrYnlSZhxN53ZJ9KvAhK1zlsr?=
 =?us-ascii?Q?LlUqw7zBCr7HEVpVv0WfwlhNVaXstkIrFW2yhuhwdab9nNZ0d7fE/Ztm0bZR?=
 =?us-ascii?Q?IL19EpOZbH0G99e5phBt63YKaVprXP2GbUeEU0Ei/tr15HVKpowiyr+40EOS?=
 =?us-ascii?Q?zC5rvnjuaSOkepThb/s4Stw6Bqs/EJHMXhV7jb/vmfdVWI6wi9zv+BcmO4VL?=
 =?us-ascii?Q?h/L6/Y2+G1ZxObzRgjGRMy9LckSO64xffjDHuI/5m/32m8xyD89ju/PetB3U?=
 =?us-ascii?Q?pNAiddMCRRfGU+bD97w1uJshJUcEFhzkz3RVMqJHA4sNr0LdZ/rd/EsJFO8X?=
 =?us-ascii?Q?IwXS0u7Rs0p3U204/kJ+aKRiS0q0gNmw9MrDqdvYF/IRRLXepg45F/GXv5YZ?=
 =?us-ascii?Q?lMMjEzellqepyRZ04UO3HdDCog4YijdZBx36tx+0NeJO4ZOG6QLdbqUpZYZr?=
 =?us-ascii?Q?E8VTOpFTkyTHZy1nydRj6lRZDU5LiLAs5P1VvCW2Lsv1CW6ptw2CmoPf6mKH?=
 =?us-ascii?Q?LrJOOu7ZvoNl0kw4g4y0E0OJ3b2TLMPbZHxooNQWO8KGOFWDkJzBgVn1IPrd?=
 =?us-ascii?Q?d6M82/K9yi2Y+CKi9G65SyH2V/3syDbP0cunfp8uU1/SBvWyF0d5wxC1VI/E?=
 =?us-ascii?Q?0S+D+g8cFio/Esp9p+Jn5qo4qIEsufCuJMSYxPHuwFxhiYivdOU+f7C8+Mnj?=
 =?us-ascii?Q?R8Sspu9isLtmtaHwewfxvyb5lw59urEmwpt7Rs7ySqg6OMJhYtH6zj4Q+WhN?=
 =?us-ascii?Q?ZGxgSGyJ545uJb+IcWpbG0o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B039A421ABC5CB49B3466754C2AFFFEA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D58qRmrmkAzeupWKR6Akcx5PxfFumJ2oX+1vcjC+3aGmERK329pw96LF0Kbxjt1gUxNAfQkBFY7JFQyaILoQhtzO+FHwlNI/niRrUlbTcFukEILb66HfyajKs0E+FjGk4Pqgyf5yl7IGCb0QepGoGmDxzXsJUkM3mzhedpI8vwyF5Cujh5VqpqWx9l/LlOK8+z+cMIifAjpiN4GOZO+K8kY14BtuUrKhcotG+X8zB3RnD57e98yQOrxY4a960k8C8UGyaF+/6HLMwuejpRV11U062tvwmXSO6KHXz8s7JKFWXA/7ARK+lYy5KXHvX0yC4I74mes9ZmFEOH4WJkvwkYBoPV/s+DNtx/D+f7+BAci+WLvIM3RdT5fjafO+4Sjn0CyaHnRtZpe2mSrjBaQ5IlCiBmpdmzkETRwm2CUb24ox//Q+qI9R1y/U19FkAtSPr1MhU9UBhqy7+eRs5dy7/bFNGbARaKLijliVD7wDFz4JsvrgBXaFKi/tfPN2eDqGxxUbN0DcCUrMBfWfRM7KDNPKVua0GQI/n8VdOwZgWthZBQz9xz4gD+LXjjb2OWvjrcMrWIGPkCq7Ijgk0969MuvV/oelA3vXKHEWYNcXJ9yQKgPOdrUm06splhwmaY6v
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc358a62-66d1-4ce9-e66b-08dc0dcb78ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2024 08:51:13.3806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ICsMwbArhUa9cYlTIANqbmAq4OOq0DSClug7dbx8TyvV9VOCYNdbBMj9Np0rLBDY66u/fD/4D1t3UuHteSUgj+S549T+b1p8GOGgO4viVOY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6285

On Jan 03, 2024 / 07:55, Bart Van Assche wrote:
> On 1/3/24 03:49, Shin'ichiro Kawasaki wrote:
> > +_have_null_blk_feature() {
> > +	grep -qe "$1" /sys/kernel/config/nullb/features
> > +}
>=20
> The above test can only work if the null_blk driver is already
> loaded. Is it guaranteed that the null_blk driver is loaded when
> this function is called? Wouldn't it be better to examine the
> output of modprobe null_blk?

Thanks for the comment. I agree that it's better to check the null_blk driv=
er
availability in the function. Will improve it in v2.=
