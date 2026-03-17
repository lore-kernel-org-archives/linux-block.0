Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8272390CAE
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773733041; cv=fail; b=djtoVmCHnTEM9y7UDW0n4BuVH6JiiZ3Y9PcfMI1coyZ7Umc3Z131+9JF/QxAx4ZObCA3tOCiJZ/YjPP/6/R3Ux4TkBFRVvSJlio4wHrf5K16CzbRkIAuxFOrhqenmX7MXtJw2+QAvw5Z9ZvuNQfd980jS3onArZQOLNpGof6DMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773733041; c=relaxed/simple;
	bh=v8TYSI6gj2MMn6mBRzkmazcaEMwPBor7kU9N4lqn0HQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f11fjXTWfBpQaqRLT+fd8V7j5dT7KQ9Ikm08No6L5iJ7DtO+YGIpmp+q046B0AypMWfUF76aKk4I5xKqbrzJm4SM5t4o5rYYb9+XzGi8F4XsdsNOM/BAaPjfd384s0JJebZGvNtL1NWTSanehQ4Qe1a5vN+QZLGsixIcfvpylHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kXS2Vj02; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=lS2dVqEY; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kXS2Vj02";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lS2dVqEY"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773733037; x=1805269037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v8TYSI6gj2MMn6mBRzkmazcaEMwPBor7kU9N4lqn0HQ=;
  b=kXS2Vj02J1503y/yY9YXBxBI6QtPqwIpkD2cyB2jEPhzmNjPQw8Rkrvo
   wICCZcmE2t5Hy9tcmgt5GKhf6POTucEoHZKYwDCkiOWPLCJnhiB0dn2Df
   KoNlt6ZgFRh/85uvxlAuM5p/tAXeE5TZazdt9jFB6HIiGTh6gIR4uimDi
   wnvPeJ/nQH71WNtbwATsB7Ylj0xkNygg+blIWQ3sfLpl7KLlhmm/fOSHy
   EOfgxp+5pXvVzMhivDgj+Dw2iKgc+oVfHoSC02r5VSrEEOMLT3i6RGD+V
   XnqNuamybM5XJGPVGjTUuZJXn03+FDkq9/Vq9nUSDVenogdA1Av6GdqLr
   A==;
X-CSE-ConnectionGUID: lmoRDvRsSFGNI4UrF9VF3g==
X-CSE-MsgGUID: BdD1jtBLSMOnarHGYqNgUQ==
X-IronPort-AV: E=Sophos;i="6.23,124,1770566400"; 
   d="scan'208";a="142672423"
Received: from mail-westcentralusazon11010056.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.56])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Mar 2026 15:37:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0ghgmhN7cZiu/S898sJeO1ZRhzWW+SKjwNdSbtxA3F6Qvih9a5cEKzCwCot/9Lm2aZR0lSK04la0m4iWO+3GLyL0RU/8X7s5xi+pK4bPwr+zH/JusaIJVoRPE/ttnVWV2zWMWPXmqc3bDhgPCEeriJnv7MBlEW+AnWrtMk8GiKNsEFwJB0WhpeRRsX+dEXZEG/o0YOZqkjldENpOuzBNmdKfhSEPc0fesgGTkUY/8eBDokuXeiwyCr+2zy8r6E7L9pOssBg7F3g6vojN9fTCIbi2/5t377bCbpRFoJi7j2zS+g4c0HE20K6QMKoqGFuesRrqtyZtKP4i0Iz8iTNWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76bmxMWAgyvqQfddxZr/v2e0HTenAi9C65IP2xpMSC4=;
 b=Jr0FNssls5r3o0jxltMAfkvxMSvuITu8SE5/zx1zSP6SvwDaiayaSVC9VYfgDC+AdgRcuDMP0AqvzBFxvzJcnshJu8D/EXAZGJvIhNmDVCy1Q2Q0Zts5hKFLvZ1zINIsyKyjqO9MXG6wQkd5CZ262hvQtUEYyh9uz9ug//QXCp43vrwWfbM8lc3gBxmq/7Tvj2ugkZ3349GEgcSo1EiuDKF7tb9MwwjrAZ7RRCwyQh6o3gktVRcihQTOU6hwYKtjJPbVXaOgDME++rnWtssGuPgn2LZzC4sTY1Q5sYFlTxvPy0qADEg8tDyVqx1acErEhx024wYIFRIcSWFnvDhgxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76bmxMWAgyvqQfddxZr/v2e0HTenAi9C65IP2xpMSC4=;
 b=lS2dVqEYe2tOoNR6EMWypCYV82M43PY/8qu0ek8luh1aOx7Sukw/OFknlDWoWgC2rkG0qgfysV3F+V+T8rXcDkZTNn6OBqAFC2rKrepBj98xUAdTgiq5qWXB8VzgGuOSIyhfWppQgC5ncrNhQZO439ktBRG31I02Z+Uvx4Rbni0=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by BY5PR04MB6455.namprd04.prod.outlook.com (2603:10b6:a03:1ed::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 07:37:06 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 07:37:02 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Zizhi Wo <wozizhi@huaweicloud.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, "yukuai@fnnas.com"
	<yukuai@fnnas.com>, "ming.lei@redhat.com" <ming.lei@redhat.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"yangerkun@huawei.com" <yangerkun@huawei.com>, "chengzhihao1@huawei.com"
	<chengzhihao1@huawei.com>
Subject: Re: [PATCH 0/2] blk-throttle: minor fixes and cleanup
Thread-Topic: [PATCH 0/2] blk-throttle: minor fixes and cleanup
Thread-Index: AQHcteDbNhjkOLyiGU+j8xJDLbopQg==
Date: Tue, 17 Mar 2026 07:37:02 +0000
Message-ID: <abkEKqXG_FkZe-l_@shinmob>
References: <20260316084455.3323966-1-wozizhi@huaweicloud.com>
In-Reply-To: <20260316084455.3323966-1-wozizhi@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|BY5PR04MB6455:EE_
x-ms-office365-filtering-correlation-id: 98e07e10-04e9-4f9c-71cb-08de83f7fb11
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 0GZ7iuVT3OQBK3tpBexeWaU8uU9BGd6EIGNuaxJdo2ZItElH6fqjbGng4HENVRjZVV2n98GCfuDUQgNu5olwXW2C81uX4uxVW3wTjKTnG4S7Sm8UVBKdMMp0QKlp6UfuKO0OozcqHM1XwS1E23Zqc9E/kl8p2v3R409P83xECnLVu/s6tj/WSPFbVIDVEii/GOjELnmBRtlZZ+FMdxP0p+1DmZ9i+RTiOzrNl2AB1l335NPP8LVCMV1Bn2fwr3uHE6SnR9hQyGwizrcahQI0TbsixxVenIj7Psi3S6ew7kAihcaTzLJJjt5HX7Tir17C3aznUh8NF90/buJr3UA3d1X42Ipy7Ih5c7C+34+JRL8nC6w6VGCofwnno7kkJLGrh9pfFuyXUQPTjq/Z6g9gPw0VUc9Pkbbt583ADV2iP1yQaxYvEjP730d9P3k/yO51d/OK9uQILXzonyaoB1mAH1ymZ8lAvLs63GRmZXqm1Dp4JeqeB37qkm3xCRT0p/Y5osMYlXgkDqhvTw1T0UwDyVH7wqfPdiynsMjVh4bymdbIhOlLXN68pQ/E6EuXVJfpxB0scbzMgy/aDe5m5WoQjiO/EByrZIzmC3gS3loj/I4GFX4DTV8JWg829ERGadsc68zA1TNEf/uJv36ZuS2ZGakQfk+BCqP2wWRivRVBg0K95Wt4J/q2+PtUpVKhxD8DFnA7gEYGHc+Xdkoi4TEaLieceSBhJpNdTeYE39mbQsfPXTPHH8VC2WJd+HULAkZK5mt9MzJ+OIti9FT4ynWGQu8oTphvlrDz3RYrCoaF/+A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wT9Pzv8i/kDVAIK490Quu89ZKS7ahqJO1c6mEzZAtvcMFwFZPbK+w2NxWbOZ?=
 =?us-ascii?Q?N1uFD1CPI6bLUe+ja+3QjJR9SfmNVlRmElLyUGtQvfbazhueLOtALtbzDF67?=
 =?us-ascii?Q?f+kPm8RD8ayioAgQ8bDbHNzWdLdgcFAa7/m7Qdm8RVpkT4CFquBcNwh16Aub?=
 =?us-ascii?Q?WcBaSK6ZlPSqC+Ob82FELnOW+lJEjUGz6dohAwDrP6FJX2CbSJSY27PLRL0Q?=
 =?us-ascii?Q?TnDNze6yhmt6ZiUOFGHVbP+HrY4GlmB/YVPHrq1VKYFX1OMd73rJugmTuKzX?=
 =?us-ascii?Q?QwFIMO7c8D5BwwO7kEMXqYq1Z7HHQDvJxjOoEZc0smIYdQXP2o+shHabvWjZ?=
 =?us-ascii?Q?1ui6hiatsji5MD4tL+woXTY6k7iFRmj+oraMNa9CY2m24IQU4yWr+2MZL26A?=
 =?us-ascii?Q?iSqzjakBH++44NWoD1BHQ4/caSfPEx3sM3PJT7+w1K2J5Vl4xx0OwUQvzltk?=
 =?us-ascii?Q?7hV3Ip6F42CYOYQhHOu8inE0SYbWCyqf7AiMNo+SdwonPzaW8+vqA4ENhoK/?=
 =?us-ascii?Q?yrwQHxiw7TE5rdniartZpZq5If3ZhCmGPHL+rxlJUADPE0jjMPcJ4T4W5QR0?=
 =?us-ascii?Q?ZmwgMzrYPo2rsD70RqNMuzpzY5fFsYLy7I+P2fy9K5t8vw6NWixxhshj9g2A?=
 =?us-ascii?Q?h6ZLi0I/du58Jh/DwuFqfjouKq1hwcEy70BsdWPw64u+vgj5u+43VjJnenrt?=
 =?us-ascii?Q?VTYFUoNS8LABw1+qCVTH2qkHfDDhYYsSByfcpGQiOGvTay1p3Qe8Vom1X1hz?=
 =?us-ascii?Q?l7r7SPTyGJ72K3bgbCFUx3VRE7sQKXaqhF99bR74HiRDDet5Yxg9RNNlSs/h?=
 =?us-ascii?Q?MVAXX/10qcN1bgoWhnPpPEHByTSmRS55hX68fsJRo8WdjKLIzGXoz3VwB4hi?=
 =?us-ascii?Q?HP1ZyXhN8H+ZZZCHTqk4s+f/ttQmGfVOhQLVu5C2clRdVxbROPJ3w0uZVo7V?=
 =?us-ascii?Q?1FaMXeZpsl33cmfgwRDzjnZPN7NgkqbYCJkLb41fxywkTXYccTTs9TP2IEf+?=
 =?us-ascii?Q?igmnXzVedYXdirfdrZs+8UT6aAhnRwsxLndbvEq7Y7LGksy5MdPP2fg8bz0H?=
 =?us-ascii?Q?1QOvsmfTbO2DDNFlejabT24A1T+4aiCljrxmav2lWzBbLSNELDwNhrG+4EKD?=
 =?us-ascii?Q?sgxtCmJ7IYouADxdoAynnZq70oEUsaYuxyM0HXktmWk7Mla6scW1bMYywVfS?=
 =?us-ascii?Q?Q51jlSWQcFwCX3ql/xVsuu/u1o1I+WUDXIxl+CBH4XkLy4OMIrb3SKXCVEkq?=
 =?us-ascii?Q?Jn20rdAKXcTFQt0QH2DT1naBubSGnbKP/3xDbBFzShtfC/+bCKqAz5z8tbF2?=
 =?us-ascii?Q?h3l41RhWxf88v8tWAr1Of0B9uhmLYZLL07xRX0BjhRJ1EKQ5h3j670XckW0S?=
 =?us-ascii?Q?equ6rZBIChwBDcuGVE6k0SjKeuFgV6taEiDToH7Mo4TBEGelxMMiqQwvU5pE?=
 =?us-ascii?Q?7566x1QMbyH1SNu0DU0LCEQKGmCc9V6XZox2XXhmqYYjJagtVvDRUKHEu9lM?=
 =?us-ascii?Q?8rIlOZsWEfxsUk9jdK6jhTMoGAA5Q6swQ/m/bl56ZVrsHmF2lzLrthlBFhpc?=
 =?us-ascii?Q?STHvNqiYh/cmChQPujE6A5qfKJ5+11Biz8pF6NDoBginsPRvRmxnOC8TPdoK?=
 =?us-ascii?Q?G2EBCsGh7KQwvqSD9OqzaaQrCo3U26/R5uG6JRorFUW31gbhLpvdBAFE0HYJ?=
 =?us-ascii?Q?6V4mwkJdiNI7ZJU2N8QYxB3/3G736n0t3F5+Sd53meA3meohWTQee+9sDwwR?=
 =?us-ascii?Q?9MiKzJftQcFE2ukRVCAeKUjQ/EYkVoA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <599B988B03A0DD45BCA9CF7635CC981B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	TDpfze32XL2yDBwmAFWQsCI8xKHtMfT6WoFDNb1M4xYsszUhnGu4GN9wO4slgozZsyVFUCPqVOCmDHyRgS7dx8q0jpbT/F1Irrllon8HEiQtmHXiXd6eNx5IcpYSTDQi9vaKrLvWmrNE4WDe2+JWZYhu2a/Z+1udRZOkz2CYwmHjv+li21T34H51GFGV5TdkuQFTdwy8IAXj7bJ/idY2IWLMJCnxLO4bg/dkexeB/qBvGlQY1t5kRumEdETl1zPGydTKqCHhRu0NW8vMSZ7Shp/2KmolAITtsSqQKIeiswX4H6w8ziHIDlr/oqImtDK8j4FhYdd/9nZwr2SOXuvKPA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l+HkK9O5QG1xJV/phO5/fK4WNOekRKbmj/cwB6VmFLaix0Bu3w8UmQnwiDVuqfe4QvX41ZEbcuLF1Qc+ck87R4VZObroxMA6FuhV7e7Fskc80hsCsjdZmI/Enm6MHuryTv0hb5qQqf7OTLH5ppFfY/1KydD20j1SsAkANq7UvbISo6KvNVZrr5eGLH7SVTUqYP8+mK/x1zysarWCyRdk6SnBVS6QQdxbttTgvBhGOmpTEDg4HJSgIaw47WEpEXVH/v6adWIczWzMHco1SJo1J+dC6GzG31/Tild5t3a6YjDWKMOut1q4avB1pxM4QcrzO4H814C4llkrt1572n130T60gricC60Fl4aCzbDCCjfCEWF1OqimDOQ4QZRuBtuN09PcfyFnnMu47jq4X5lSSBzNL01jttGyQLKZIKcpvRclUHatlm9yCJZjPZXWJrH4FjZsuPnIhuyXUX6WGfMXIrF/GPpcahFApECLykiugCWHMfOFBsU9HXX3MWk+OToJCunZCh3upHXOjyhVJit+mgLgCWMDlk3r0bVt+Yikno7Lj1r50nOAnB044TWxQ1We8xNv3YIKEtlO4etR6MlKTs0YW0kUsVTDlt0YyFAR6LKa7i6XcDlko7rO5l+CzWg1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e07e10-04e9-4f9c-71cb-08de83f7fb11
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 07:37:02.5337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kSVbCdg7x/48zIaLeOcXs51qtmcd8/HWkpeVmlP2N1Ng3KwulDMznko2AHKzo9/Z3xBwhulqSWc/95slIrSOekFNXAoGy0cQktW+3a4h37A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6455

On Mar 16, 2026 / 16:44, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
>=20
> This series contains two minor patches for blk-throttle.
>=20
> Patch1: simple cleanup
> Patch2: fix timer scheduled on tg_flush_bios()
>=20
> Zizhi Wo (2):
>   blk-throttle: remove leftover carryover checks in
>     tg_within_[bps/iops]_limit
>   blk-throttle: fix timer scheduled on wrong service_queue in
>     tg_flush_bios

Hello ZiZhi, just FYI. Blktests CI trial run found that this series trigger=
ed
the failure of the test case throtl/004 with sdebug:

throtl/004 (nullb) (delete disk while IO is throttled)     =20
throtl/004 (nullb) (delete disk while IO is throttled)       [passed]
    runtime    ...  1.667s
throtl/004 (sdebug) (delete disk while IO is throttled)    =20
throtl/004 (sdebug) (delete disk while IO is throttled)      [failed]
    runtime    ...  3.273s
    --- tests/throtl/004.out	2026-03-16 10:29:46.761897543 +0000
    +++ /home/fedora/blktests/results/nodev_sdebug/throtl/004.out.bad	2026-=
03-16 13:31:54.355173644 +0000
    @@ -1,3 +1,2 @@
     Running throtl/004
    -Input/output error
     Test complete=
