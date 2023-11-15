Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA134416
	for <linux-block@vger.kernel.org>; Wed, 15 Nov 2023 07:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hMuBWFos";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IQSKSDCc"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5461B9E
	for <linux-block@vger.kernel.org>; Tue, 14 Nov 2023 23:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700034382; x=1731570382;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PFzekGstVAZSDal6kGYymb61VEk6/JwIGF+aEr3j7rk=;
  b=hMuBWFost1aLIl7uBEtmUtFAV+JVtZX2QB1AG/g7Vf902d7l2zWKIhEr
   jHYrM6M/ZEw3vH71g9yslH/tvyoWDC6bdjT5YpWiS4o1fCETQINOYPwK8
   l5PxKJgTX6tVPuA9a69C+xqHtwxpoluGaJZOGDGpFXLS+hE+E+Fnnq5gU
   yyW0dc+ddSjG2gqviqwHztWCjwU803lTuZzg1XIwxV/Aam8gbdEzNemTI
   NV47IMLodB8qEvITzomtf1CJGs2kzAaTcm894qa1+ExT2ou01DjrLyfyq
   ZeJSq4TqrgTQ4rjj7dJl2wOClqq2b4NzqIXlleOSNOTVCrq4BkGygjBsk
   g==;
X-CSE-ConnectionGUID: 4Zwnhe2sQJesT6kOlI51gQ==
X-CSE-MsgGUID: 3beCNnYQQdOZ03is3uIRvg==
X-IronPort-AV: E=Sophos;i="6.03,304,1694707200"; 
   d="scan'208";a="2307161"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2023 15:46:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejQiKfeUeK/3WD9xxaiDf2bklb/VJh9dw6H3jYb4Gg3P8xTawasDow+cCeZybKc6S5bL/5J+gbmxSr5NsVPV4ALCzbgfo4F91FNUC9qENKF3MMTmZg8fkUvfAE009DimkEXS0SZV6ELM4PdsuJuQPQx81alF/67e4vzDAOnXvQ99HsrRK5kUpWRqI5wwaTae0B8E800HBgaf24RkjFeXuvkDDUAlq4Fje832rOqEBcjT01/Y2prmB6kCZPw4ICdj71u2pQP1fkLHBLv25NEkMD8dqJOZsEueuYOJQ9WvCD9R5njhU3QVnKHYiK/30o8EAQ9j7dezPTLiwhRBWSpRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+7LxjsQZGYdsPxWiNQILKJcySUlxSI6B80W3Rp98Zs=;
 b=LVK7uFqvsEqkOMLvGLNvR8eMPFI965ZvUDlLKfnXBGcLI4pDnk6M1iuJU6tcYko+OSrX+Tx1OzfvBgtDB0o0Gu1Duo7wkFhum6t0G6jWlyEhLDNFgoEhtWqXFqn5ggLpyPidMKvsHqU5Ku32PKG+n+4Lrd3MEs900b7PkKgtX23Cm3o05H08MYJ/DpRtG/Zx1Vj9V8qVII9PcanQxRljnqEfr2kTVpccO+/YB+Aj3VQizcM2G06M0wWmORu1FzrUsibNv6S0VPO1+FKSXQp8QX4hIaWu8lJsFRA+6PM4tpbTSWzyglWs8otyirwEOOnho+pc6CdxNiEejY5cqJ0P4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+7LxjsQZGYdsPxWiNQILKJcySUlxSI6B80W3Rp98Zs=;
 b=IQSKSDCcxdniyLW5I/y+AfouS4+AQB19bXtIaUdsQ49NawhxAMLvrcv66ugJhoiI5OgysMjO4z3i/zsdGunoC1RvKWrXSqOqwAxEKhX5N+zk0d/W021fVZ3uA+6dpDS6zo8YV4fgv7Mc92EiDLZQXnRRBJggqz1eDuS9cCMEsYo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB7080.namprd04.prod.outlook.com (2603:10b6:610:9f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.18; Wed, 15 Nov 2023 07:46:19 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 07:46:19 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Yi Zhang
	<yi.zhang@redhat.com>
Subject: Re: [PATCH blktests 2/2] nvme/{041,042,043,044,045}: require kernel
 config NVME_HOST_AUTH
Thread-Topic: [PATCH blktests 2/2] nvme/{041,042,043,044,045}: require kernel
 config NVME_HOST_AUTH
Thread-Index: AQHaF4fs31V751Pswky+3T/QxhjUILB64sUAgAAdzQA=
Date: Wed, 15 Nov 2023 07:46:19 +0000
Message-ID: <xikiwdcssvdc2dvozscny73e7pxcdf7b7qx7oys34ote4cv4qo@3msll2uqsz7y>
References: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
 <20231115055220.2656965-3-shinichiro.kawasaki@wdc.com>
 <447d68cc-91d1-4d17-aec6-0105d3b188c5@suse.de>
In-Reply-To: <447d68cc-91d1-4d17-aec6-0105d3b188c5@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB7080:EE_
x-ms-office365-filtering-correlation-id: b4169b45-dec5-4605-5311-08dbe5aef4ab
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IGvxhjVXHlWuSCdRKoBeMR2FQ4TTgkHuz/uqV/jUFI/4eaEfwK7QHPlp8Mv9wcxcz6DAu2D8OGo/UCYwlXu3+fx/JKMwrqyFlr0gmuTMLgyp19V7NF7y5WSsXAFlWrVoLTix2ttYqxBaGYmJJvxJISuOZc+WvvyRtueiTZbOaQ98we6z5ZFpauwd8cFw6WEq6Sc2gIvjR+BpMcfxu+PYVsoGdQIDtug3ZtNeUgb71cWLvN0spVPBPkvWShE+p0ONAocSWg9LE5+Lk0bw0hpz04dBRC4qdvHik45WDcdIOL/WqT5yPuifEw67yH8l27BlYm9XeAeB/N+DF3vwMQLGMiZ9YnBVaqm0HmRABcXLroZrCGHqTMPCQEI9VsoCz8SJd/z0/q64KzQiBe0sEn/0X4zlQhj5ryx/PSKXdkm9nwjp0SeKsX5trLpkVR8BChdy0tYEibMquZr4I7/iK+fZQLcI+4tQS4kJ/+OWaWsO5l40ubulty5cX9bhcAoRPJninCNdopi0jAu7FUIaONDyhfqcnD3c+lyIKqv48uY5/2AadoZuDoGfBF24ldoi+tVoSFEmICFHM6uFWfTaB0kXQDELfQAwWqBeVLekucMepHk+VlhwZvtdAQI0G6sH/AfO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6486002)(478600001)(2906002)(6512007)(9686003)(6506007)(86362001)(91956017)(5660300002)(71200400001)(44832011)(6916009)(316002)(64756008)(54906003)(66556008)(66446008)(66476007)(76116006)(4326008)(8676002)(66946007)(8936002)(33716001)(38100700002)(38070700009)(83380400001)(41300700001)(26005)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?j2pfx7KukpgjB4SzAd3Izw+O88LOKDCs9PiOjwi+674cLIVc2SnZaNCoNrLJ?=
 =?us-ascii?Q?rSuORYumTf8B9H9HQBGvkzdNNE0JneDhIgKX01cj9WF0CyPYKTqhdBPssWY1?=
 =?us-ascii?Q?Lls8PlSaKYcemkjcaSMmHoNMxc+pv9P5DQi39iC/D1ci7a36I2h+7pGqb0Lf?=
 =?us-ascii?Q?fFjUEuCzFAlljCF2ZanOHi+dyGvLytgJ96CmwaipRV53McRgrTP56hgZX+va?=
 =?us-ascii?Q?SQtlNUAXerLbLVjk/5qzvTr977MrBikxIezTFuwaWr35aPQy6wsqvp4GJB1t?=
 =?us-ascii?Q?J5s5I6EFJ/wYP16NH0FFlbRp1LQPd6JE6yQde24SPdctHuJLAU/9UenegjEc?=
 =?us-ascii?Q?RwkQPHV4fm5Cg4UuljE5A7WDxJh2R1mqZGSe0QM213HvvOFLqReQ5mtZMIYN?=
 =?us-ascii?Q?Lys8RzjjhzF/0mZ0joDwwkFcpkjNwYlmCuf+ZL3ui2vHBfS/71WBq8Q81zrq?=
 =?us-ascii?Q?jdVKQJKtRDiGf9ISTUxSK4LqgLrkTgIXSS1JQzbVNBY/eVNGC25UpATcG0EH?=
 =?us-ascii?Q?jlycGpMT1cIu6FhWhQ8yr7bnwaKlRSCMGEbrkh2FCc/u9Dg6B1eEuHOqMwpn?=
 =?us-ascii?Q?ISOjzoLwGzb1w4r5U36KOoQSPP4VCe8PHCA8DUJfuBPWrbALN0MJpC2nBFH9?=
 =?us-ascii?Q?SErQyDIUNFcHGDULK5tvRPHsaDMEftDftXj3fz2WLMvOs8sZpxcYbsjQnVGS?=
 =?us-ascii?Q?sAqJHwFM51A7+7DoNoSF70hM3LmmBRI4lpyi9xCOgA0mYxV0xASOOD37ZLlh?=
 =?us-ascii?Q?ZFQdSmZ6uUMAn6nPAEqFJU2IyiX3WnCg9M9eYbqVpII3pY1hPbaZfrqkPVE9?=
 =?us-ascii?Q?5cpcLwOKzHobV4/kRK3JHHirYM+qNpKm3F9B0M9FNG6YIn7zjdmGauKDjzt1?=
 =?us-ascii?Q?8lvUIx2aaJYz9kq8FXJYSsgb/pBBvK76hZxImzRpp2L4lygXdxOntCGMtTvc?=
 =?us-ascii?Q?r0JoKHyfKTv00aDQb7okU+78tnPeNXlRy1C7/tN0L3dWcouvsKPpDz1qT+gb?=
 =?us-ascii?Q?JA063vwQKbEqQknAehDClDWeNwrNTVlbZJbS/ig4Qo1x34kjznFz5x9KrMXX?=
 =?us-ascii?Q?iBMIP9gWwPla+sMZs09A93ysgfTxpVK0vtvD6DmanrlH4t0TyTD0BVvyYYDl?=
 =?us-ascii?Q?NymtJbjJuLHiGgGzRH0FC/sv2L+taVw+wNAAnG0uU7ryrMfmyC4XcfOwh4vV?=
 =?us-ascii?Q?MhaKcfAZtvQ31ojWAeXdIS+xtflgrfZud9W7zaQVBA51XSa/q38TlJhwA2/v?=
 =?us-ascii?Q?mo59zIaarU198QKerv2A7BJtu4lPEI8qffXTq74q4jvtgY3I9YQZx7ZkRrxv?=
 =?us-ascii?Q?bskbrr9HKfdoAwqXaxmdJgwPQSlOnnnKynUSl1zxO/U+AFV3/uuWHUSOtjza?=
 =?us-ascii?Q?nJnftPHmDaqXEZgxC6XAyq9Vno4LxMTyGsiWzk/b7IbyTMkGsEe7+jUTNxM1?=
 =?us-ascii?Q?izbYubrQeCXq1gg/CwuL7HVIXKa+MSicgu6X60E+PCThzJ359tspGZljOQJt?=
 =?us-ascii?Q?innwGiPzp8Li8XmG2UGKhtf7A11noLyh3jE0AtIk0/0o0fUC4/OQlszCiTaq?=
 =?us-ascii?Q?HQpouqlK8F25iZbJ6Vq1XhgKo87l+A7XlYrmZFzC3538Gt9vJyFAJy2rSV8I?=
 =?us-ascii?Q?E9oJnCbajfJgBNObPWdzpOU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E13180A69294CB44844181D29013A737@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vlko1xqrDP8P6SWLmt73td4fKCt6E2aJlogGcN8zTucRTS5X1xlGTYEPtJGvHvt3crd37JQcEEw9FKeQKc5/Se9hh+QAcE9WMbpMx0NEvTjefbe29bD9pH017xmK5GqQn1G+CuSDk7iBeqx8akCy7k5cjGDzqb+KitqJTVRfpqPp7kZcVM0BxW3wQxqc+VonOk3y1pj6ol941/A3hxZk+Pl0ORDeZkxHOh0t9J+UCs+6GH+QRrlYjuF2piJhaIsfFECbVGkOoNIwQHU7VbaKZBDdnDJmosVAK7OUl+yKK0iqk4tvYpVSeEZjr+4crCHJAKRazdPfifHPLN7JhUrcVdvoRNpLOS938w1Ed5Nb9JaOJJma4lWxtq2IURYlmJ4aiJlVkfsJ2KTqz3V31EyCOFBzeBqb3jtFxxjTMGxel2NrIMdjBX/5rriyGenaO7NmHpC8xZbOy5LK9It7j2qorb73Mv8eBFHsEiRitbYgU9Vcaf+SLuMZXmV6N4pJ/0wADIdsnFMX1N44kDUS1gVzOQUCRsK+faUIW23+axdAtBkxa6EArE/3F9aX7JFqWWDvPFcHfEhTQVVHROlrcHwhMIatJNN8cUZkFCuH4HemwsoL7hck6r/yHqx0wbaG1E9lTFJxNi+tJOG2bqYJvkYEDUs8gweZGeJBCaJHqY4z3XvWo5sgnK30Xkt6vLzo+9G496c+Nk4rB+uZV+ni2jmLVEw0/Ox6t8UsnEc1C8hsY9663t4aqBShgXE4IStE6NZhHBamwm4jvLwGspJAGj+7R9H0qsoP17DnsyhZaAVK1YUMLxLdYVELueBD2e+7AB29QFH2UgFZTIoQ/EFLRNsl9X++F2UZVqp140f2PsvDtrF6ovISWXdduef9/wWeA3c0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4169b45-dec5-4605-5311-08dbe5aef4ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 07:46:19.4670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFaoiRSWbbr9/cHUCo2kxlYBr/GB1nhxINcnNmavSLXU2VpUGoCuIstAQPwpU9+pU9vaTK/tmW285qsWx4iRlfin6tlNrIOx9pn7PJaUXGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7080

On Nov 15, 2023 / 06:59, Hannes Reinecke wrote:
[...]
> > diff --git a/tests/nvme/045 b/tests/nvme/045
> > index 1eb1032..126060c 100755
> > --- a/tests/nvme/045
> > +++ b/tests/nvme/045
> > @@ -15,6 +15,7 @@ requires() {
> >   	_have_loop
> >   	_have_kernel_option NVME_AUTH
> >   	_have_kernel_option NVME_TARGET_AUTH
> > +	_kver_gt_or_eq 6 7 && _have_kernel_option NVME_HOST_AUTH
> >   	_require_nvme_trtype_is_fabrics
> >   	_require_nvme_cli_auth
> >   	_have_driver dh_generic
>=20
> Why do we need to check for the kernel version?
> Any kernel not having the NVME_HOST_AUTH config symbol clearly will
> have it unset, no?
> I'd rather update _have_kernel_option to handle the case where
> a config symbol is not present, treating it as unset.

At this point, _have_kernel_option() already handles NVME_HOST_AUTH as unse=
t
when the kernel does not have the config symbol.

> That way we can drop the dependency on the kernel version (which, btw, is
> kinda pointless for the development branches anyway).

For the newer kernel, the test cases require NVME_HOST_AUTH is set. In othe=
r
words, the test cases are skipped when NVME_HOST_AUTH is unset. If we follo=
w
your idea and drop the kernel version dependncy, the test cases will be ski=
pped
on older kernels which do not have NVME_HOST_AUTH symbol. I wanted to allow
running the test cases on older kernels, then added the kernel version chec=
k.

I agree that kernel version dependency is not the best. As another solution=
,
I considered introducing a helper function _kernel_option_exists() which
checks if one of strings "# CONFIG_NVME_HOST_AUTH is not set" or
"# CONFIG_NVME_HOST_AUTH=3D[ym]" exists in kernel config files. With this, =
we
can do as follows:

  _kernel_option_exists NVME_HOST_AUTH && _have_kernel_option NVME_HOST_AUT=
H

This assumes that one of the strings always exists in kernel configs. I was=
 not
sure about the assumption, then chose the way to check kernel version. (Any
advice on this assumption will be appreciated...)=
