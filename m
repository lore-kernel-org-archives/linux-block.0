Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B07F1E864
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 05:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710740849; cv=fail; b=s+YGv6xIs8Yuinvn8/OqmbQDCliSjMx/SDZfkCK/xJX9YoFHwTfMLXjg4jRID9RdfMtjD1G9rtVNFLx5UEt7OtRrMDsiBJHVlb/aKiC3tLAXWVKxa38KufsVeEWs9i9wqXqDbO9Yj50mPGRJgclZ4C5qr1ec2vIXeuZbqy+ME+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710740849; c=relaxed/simple;
	bh=+fFe5pFoadDsVpcNqp0g6uH3/ORuA8nLJpiPAumuKrE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SZrYcDGf6cOPy6k7IB4zWBr2Cocr06691cFBsfju4yYt1Z32RdwCLAT0IBALCYxRgp7/DnQwBldxn9Fv/fOFQa6IJqhwVXW0WlauiLUsBvfTfGYwA0iSLqy4BQYeYAd0q+q8JUQYIGKkQoea6YlVSyTDr4vON5foiMKOaXvgEcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fDf/IQRa; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=I4aO1iJN; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fDf/IQRa";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="I4aO1iJN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1710740847; x=1742276847;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=+fFe5pFoadDsVpcNqp0g6uH3/ORuA8nLJpiPAumuKrE=;
  b=fDf/IQRaGJBcF2GQApAvQXkWQLlAsUuXLotw+oAQ5NPD+Ztflz3U5eFs
   +tR7Z/VubEfiCj/nIwQgwdDWpSOqp+JhD644/XM6XsMqtwNnfQ2yZy2zP
   TTEILBoD7QNwvNB0hny8zDbT5RQWlNJ1R9PXjGILuLH1mS2Kx750egguB
   kOuqwFmb25O5o18DzjC23AfZA64VFgiIelKy2GSxp+58EEh8dNMC2L6qC
   6haVXgvjcgLK9ZSqXYO4+01x4Nc7OLAZwT++p/gYb18mtg093VsG9YwUf
   j/WhxLhfO5SWbaC7uAaJwVINH1PG2mZfbTPBAmOOXhjjAhGxrcsRLUuLP
   g==;
X-CSE-ConnectionGUID: UpzWtTA5TeeZFisTUxv8ag==
X-CSE-MsgGUID: I2T/74b9TZKO43isK4wjog==
X-IronPort-AV: E=Sophos;i="6.07,134,1708358400"; 
   d="scan'208";a="11340343"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2024 13:47:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiEiMEjiRdMXKQWdsdkfjPVb0F2Nc4AvwkoB0gQv04rFCIFSwXjZIAmLqp3Vvn7PhreiEUUzu9wjeFDDguN8kVvo8kpoqj58WwvE750LjJpbXj8asGw6vvlrFBOtgPHt/aVlJ5sNINt5dLP57ErwbR87lzjD0eA48ckYWpQHEX72RoUWgxWObvxAIeBlzDjOLINqRXQidQL3eyHMmszTTZdR6ZRW9dV5c+EtU5mwkXnkQTMr0avfdpaG+E8QV+iaOGiZv0bk2FLnlUaPQ7AOWOXjmLGSmIf4OEslaA5drivsYmVJKckUap/tPRylXn7+KZHdp+YB+fnxJ1AYLgEo/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdlFaDJpuiEw+1hxhzke5W6pHlJC9524eKDXDmFaGxE=;
 b=UatHLmHK0H0LSNuNDBYyefYyjaTnN0uG6N0ZxB+uAUAiCafiIjbaGcS+mNOQU6w99KZtg35NSx3iVYqql2GNj1Iy4TQ+l7+mIGDDui9rXkyuH606krMUkq5yb1vRCiVteh4kOXBEraSF7ihTO4lu2upWaIPSF6b8QdC2sVjDwJ/gqsR20ls4VdU9FJ2IAzFJz5Az6qychieU4pvpV/0yGXIOiqQHXwP0TWviEIys1GE6Mwp5o9d/FPIWc5N2eN48K8J5RJ1j3Co1Ez/23uxD3gAHrUJb/SIlWZBphj0igHp/xGxKivEA4APAboqgeRSk7/Nh+po3zlwSQ1I54aY/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdlFaDJpuiEw+1hxhzke5W6pHlJC9524eKDXDmFaGxE=;
 b=I4aO1iJNGY2/h5NaPGHr8omIfRz07FcUb+L044XsQCgpoWC57enLQ4exnYhxGxH8X7VkFp0HBAGmCnY9YpOpei6RDnkQQJa6EZCw20eiGV4QgqyFAwIy4qH7PczHbDFJCRVMiC78xzg0L5rzu70knoa7rG5vV5v089qamOU7Z1A=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB6451.namprd04.prod.outlook.com (2603:10b6:408:de::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.27; Mon, 18 Mar 2024 05:47:18 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 05:47:12 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
	"linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [f2fs-dev] [bug report]WARNING: CPU: 22 PID: 44011 at
 fs/iomap/iter.c:51 iomap_iter+0x32b observed with blktests zbd/010
Thread-Topic: [f2fs-dev] [bug report]WARNING: CPU: 22 PID: 44011 at
 fs/iomap/iter.c:51 iomap_iter+0x32b observed with blktests zbd/010
Thread-Index:
 AQHaYovQw4Cp4i7GhUK8xyPo7C3fjLEfp86AgAAQ4ICAAtxGAIAQ9nqAgAAi6wCAAE15gIAJLoeA
Date: Mon, 18 Mar 2024 05:47:12 +0000
Message-ID: <gngdj77k4picagsfdtiaa7gpgnup6fsgwzsltx6milmhegmjff@iax2n4wvrqye>
References:
 <CAHj4cs-kfojYC9i0G73PRkYzcxCTex=-vugRFeP40g_URGvnfQ@mail.gmail.com>
 <esesb6dg5omj7e5sdnltnapuuzgmbdfmezcz6owsx2waqayc5q@36yhz4dmrxh6>
 <CAHj4cs874FivTdmw=VMJwTzzLFZWb4OKqvNGRN0R0O+Oiv4aYA@mail.gmail.com>
 <CAHj4cs_eOSafp0=cbwjNPR6X2342GF_cnUTcXf6RjrMnoOHSmQ@mail.gmail.com>
 <msec3wnqtvlsnfsw34uyrircyco3j3y7yb4gj75ofz5gnn57mg@qzcq5eumjwy5>
 <CAHj4cs-DC7QQH1W3KSzXS8ERMPW-6XQ9-w_Mzr1zEGF7ZZ=K3w@mail.gmail.com>
 <d6vi6aq44c4a7ekhck6zxxy4woa5q7v5bnvn5qmad7nqk7egms@ptc72tum4bks>
In-Reply-To: <d6vi6aq44c4a7ekhck6zxxy4woa5q7v5bnvn5qmad7nqk7egms@ptc72tum4bks>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN8PR04MB6451:EE_
x-ms-office365-filtering-correlation-id: 5c0b8d13-90c6-480f-2b96-08dc470edc04
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 a/XebzXH5ZcLB0wu7qDLSnHXJ602xcSLdq3jn3JvVnUm1Ac7A0+oSCIlo4wGGBbxvzSLO8LqCcQkZ/DVV2QYdQS0KEPnyh0+DUwyNzlYOo8zU5iRXMdikINzpXndbf5KaJLc1q6fQO+A+tCLAUCeoWW/G4KdFHlLpvA7Gxb+QzGCGiiBuroypUFLZ+h4V7pFgC/8eA8H/udJz8+w3JTDapWf/qoxyxlQC27SLClAx6B/Lw6CAxT5cyxqZv83eOaHQNcJ7lMrDftZPNXhoR+8Y8Q+BDibYA/z/4TjtTZ/Sm5oCD3+GgetMCjeyl6tNI0DT4F03W7nj8xZmycN5tW22yWdHwdd+c2HXCN+sIg676aAyoslo5fCIDMvuWemQh+c85p/l5dePNaMMjd6t3AWcmF6VAGlD3Bj6kdqQKaRXIoKJe8nrP03a7l/sDb8RqS1YxZhnMRPFwfN3OhjyeQVwh7b8Ik92teplr0d4IcrsD9zwYT3OJN2zVeT98iFVc5k/ff1wyuPgxieuuMGQzCQr4Lf1v5s1tqMNKEeZa8tHpHLEDBslsZ3im/jBWN0CoVnNuV29CbCMkhuV77v70v5saOwMepgQxQizOL+T3RHxoEPVPS0trRDfsNNsr52jA75Ya0HWERXfLeiBh7mAJ516Qg1ndG92pZRA4okVcAu1h7MD1UrJnZJlRcII/ktGKgaPAGeVN5MeSzpufwHu4nuD8U/Iz6mG27VcnwRLw1uWTE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JAnHz6Ko3P/gbBSs0x+OlHJtvF0GBT5xl0iMaUFcZ1tFfg1o0lvM/rmmzICh?=
 =?us-ascii?Q?eBMGoULR4sbdCm9xsbKb++Xs0hu8IpfBmLa/zbCjWUz0KMGZO5wnG1bGN3ak?=
 =?us-ascii?Q?40GZJfLAIO58FEqcQ7O5RWaMgh34F+Pm/KGBl57SlSrGv0Cvh+jzoosko5Cu?=
 =?us-ascii?Q?uEKr3x4Rte8+1CQUoqc/KQPx5Ho0A7B3dA+5qUVHv+MTnLBpUCdYCwxkKCBr?=
 =?us-ascii?Q?TCfIF5Cf/EyuEOBlLe405tyb493HD4M6P+G8Me/eyjvVsmR98swWSBokCFcR?=
 =?us-ascii?Q?5Ok7oHYcQ4SBICjXZYWy7f8Kfgl3/UqZBfLyyQrfjfTZVAu6M9XXAuyKeZIi?=
 =?us-ascii?Q?2P/RVhgR7cUaFagZ/ycMlnYFwYgm+4kiaTAK9BGSgei6K0OFadLvcFldN5Ks?=
 =?us-ascii?Q?DNU/1lp13dwl/V0PBNhyZeLDem3VElH9ji0jGy/y+F4A2Qjt/wK7pt+vEfK8?=
 =?us-ascii?Q?aiKjiNwXQcNoRaeVIxkz7iHGFrkGmxaz2WTqc9UtmIlIP9i/BMzWtAJI56uk?=
 =?us-ascii?Q?boVtThN/lPpNYZCRN4VbgVzX9QcGnrdnCMyw0jcX7eWg4FLCjN/gGwq+gqX2?=
 =?us-ascii?Q?ePjzng9a1b9UqsWLugzeusfbkc8fxjXgpycqp5QX9cSs5h8vAHZqNt/04Sls?=
 =?us-ascii?Q?EyPz41/53thbblwSCmnMjHoaoBgNNhi4x0WOp/Ojj8C44YDwwim+koty7Peg?=
 =?us-ascii?Q?jr1M3F1EXUNJ9Te5r867nt1n2gNSRK9ep/6nICPk5yGfSySF+Kn8hvD2ciWt?=
 =?us-ascii?Q?lgM8jS49ninmRdUHfLItoU2QxQCwyiMrXO5xfyBi4HTvIrGgRBaAf/o/z2qR?=
 =?us-ascii?Q?+Md6KYXmW9sHe/+tKkqdJOUc33E1tv7FtBJ/kpzHHIttBG+vIb4l8L4G/dgt?=
 =?us-ascii?Q?B/Iw8tWUl9eMSq/xQhoUhL3asWMAzpEGtUdXlt4x1QMsXCSqNm9gsoUAMq0o?=
 =?us-ascii?Q?Oi5NfjzDWYmFkp/xdAP3NiV/n5JvxAhnCqsAd+ke6Iu1fcUvv2DfHxG+xHSC?=
 =?us-ascii?Q?vUlm2F3gLqYZA+NdxUQRk3NJs3z4jZpa3iBzGLGnRXLmmIf5p1o/Ecw0Ybgb?=
 =?us-ascii?Q?SlElWyOBZB/R61XtSyWgFAbFjLykyEloDl+3pBDL+h/J18jXiIryyr4JQGLo?=
 =?us-ascii?Q?xPNKe1o+WokiIvQ6t+6/viP4prE25lc7+fGtNCk1rB8pt6OvOYWLScASSoma?=
 =?us-ascii?Q?VCCx0wIwQTbAL1a7qFp4muAkzIvqtlmRkCUZLvIKJM7pztnX6m9MivVD2WNg?=
 =?us-ascii?Q?vjMzZFDoOSLKwlZF2HShXmqZ8BI/FpyW8nRs0n5BrQ5F8akM164O+Qi3gL1x?=
 =?us-ascii?Q?2CgQekYn2gPvsLOyCzZWxZfW0lvnlYfA00qmOvudj4mpghiABqD2ueZWchtO?=
 =?us-ascii?Q?WZ/1b3v7QlJAsCN4KIrSRJUU0yipwRG0tOiVVx87mxRFNsEdF/tZYA5XETDV?=
 =?us-ascii?Q?3e/sAthUuMtQemgzaDG+wALvQQUXAL5fumMntRoYTj09o5Xt2ZeqUbnC1s1s?=
 =?us-ascii?Q?zMcxuIOnL64zt8vAv8E60x9j40SGiqhe58nqEBPoDZ5gb8cqFMB+QW3o9r3L?=
 =?us-ascii?Q?VTg1pE+3jhmD6JWarYIsQdCJdo/Y7bI7RfGkkbNUa1jWs1MlDCdDvQk+7rCz?=
 =?us-ascii?Q?j8uxlTp5CoFzr+4qxNvwyik=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <182565A75455FA4989BF497C0439A9B8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xNVa02w6dqkIZHlZlrvGP8fTyvVVan2ZboFuNuVS5pVaqW0xZMjkzb2In9VjAhfLRlbJl91yX5n2fzp2GUgPuAyQi5l1o9jPjTbmHvdhHhhTFZ8mVcJu1TBTAantit/KfbMyeMJzVKwPMSuttjpYUsfcDRXTh0vCJyS5SkGSlj7Q4x71KW47YSP3c/adTWwCPOf2avQFP55PfzI/P/TAy7HUNUj0mlNsn/o/W9kunw1j6B3r9NxgtW+Y6s4ZSSnetcd+WGRIny+1foY0U1rIWeB/d6yodKfJwIk3SnBfJ617JqSaxiMjco3Q7qIEM8c6WXVoDP6yQh3g4F148u1NBMNRfsnkGGfKENSZUik4dMmkpRh5drwWFEx+ksINyofweJIKSHyQsCIFAe20Zh/OFwV2ypQZAaRt62LZ2buHwrrIJx9ZTyi+ft6dO+GpDIPB3BEvdTrg6iPut2ahaYsHV4gEGLIrWwIPL9xs/4ELbCtFFsvoRGFXxma4erg0oB1NiQxKpyEFDctKzVvxDc8fQk3WpE6fMWWt+PtT0xnBe3Ta36gpK3KU71DBdtlzMxpf7DfcSq5Gblgwd80Xoq0osxLCPGOv6psMQyReDrHymgYEqr3c9cOXdr6zo/u3nuZS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c0b8d13-90c6-480f-2b96-08dc470edc04
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 05:47:12.6021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vFuz+fQJ3fa4wuf1cUS2gqiQs4psn9M85FbxlxZntHTXRB5bCdIwo2UxXLSeX/TeOsuWWnr8BckWz564UUi7Itj8eir1Y6L1cvrYzDWdFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6451

I confirmed that the trigger commit is dbf8e63f48af as Yi reported. I took =
a
look in the commit, but it looks fine to me. So I thought the cause is not
in the commit diff.

I found the WARN is printed when the f2fs is set up with multiple devices,
and read requests are mapped to the very first block of the second device i=
n the
direct read path. In this case, f2fs_map_blocks() and f2fs_map_blocks_cache=
d()
modify map->m_pblk as the physical block address from each block device. It
becomes zero when it is mapped to the first block of the device. However,
f2fs_iomap_begin() assumes that map->m_pblk is the physical block address o=
f the
whole f2fs, across the all block devices. It compares map->m_pblk against
NULL_ADDR =3D=3D 0, then go into the unexpected branch and sets the invalid
iomap->length. The WARN catches the invalid iomap->length.

This WARN is printed even for non-zoned block devices, by following steps.

 - Create two (non-zoned) null_blk devices memory backed with 128MB size ea=
ch:
   nullb0 and nullb1.
 # mkfs.f2fs /dev/nullb0 -c /dev/nullb1
 # mount -t f2fs /dev/nullb0 "${mount_dir}"
 # dd if=3D/dev/zero of=3D"${mount_dir}/test.dat" bs=3D1M count=3D192
 # dd if=3D"${mount_dir}/test.dat" of=3D/dev/null bs=3D1M count=3D192 iflag=
=3Ddirect

I created a fix candidate patch [1]. It modifies f2fs_iomap_begin() to hand=
le
map->m_pblk as the physical block address from each device start, not the
address of whole f2fs. I confirmed it avoids the WARN.

But I'm not so sure if the fix is good enough. map->m_pblk has dual meaning=
s.
Sometimes it holds the physical block address of each device, and sometimes
the address of the whole f2fs. I'm not sure what is the condition for
map->m_pblk to have which meaning. I guess F2FS_GET_BLOCK_DIO flag is the
condition, but f2fs_map_blocks_cached() does not ensure it.

Also, I noticed that map->m_pblk is referred to in other functions below, a=
nd
not sure if they need the similar change as I did for f2fs_iomap_begin().

  f2fs_fiemap()
  f2fs_read_single_page()
  f2fs_bmap()
  check_swap_activate()

I would like to hear advices from f2fs experts for the fix.


[1]

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 26e317696b33..5232223a69e5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1569,6 +1569,7 @@ static bool f2fs_map_blocks_cached(struct inode *inod=
e,
 		int bidx =3D f2fs_target_device_index(sbi, map->m_pblk);
 		struct f2fs_dev_info *dev =3D &sbi->devs[bidx];
=20
+		map->m_multidev_dio =3D true;
 		map->m_bdev =3D dev->bdev;
 		map->m_pblk -=3D dev->start_blk;
 		map->m_len =3D min(map->m_len, dev->end_blk + 1 - map->m_pblk);
@@ -4211,9 +4212,11 @@ static int f2fs_iomap_begin(struct inode *inode, lof=
f_t offset, loff_t length,
 			    unsigned int flags, struct iomap *iomap,
 			    struct iomap *srcmap)
 {
+	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
 	struct f2fs_map_blocks map =3D {};
 	pgoff_t next_pgofs =3D 0;
-	int err;
+	block_t pblk;
+	int err, i;
=20
 	map.m_lblk =3D bytes_to_blks(inode, offset);
 	map.m_len =3D bytes_to_blks(inode, offset + length - 1) - map.m_lblk + 1;
@@ -4239,12 +4242,17 @@ static int f2fs_iomap_begin(struct inode *inode, lo=
ff_t offset, loff_t length,
 	 * We should never see delalloc or compressed extents here based on
 	 * prior flushing and checks.
 	 */
-	if (WARN_ON_ONCE(map.m_pblk =3D=3D NEW_ADDR))
+	pblk =3D map.m_pblk;
+	if (map.m_multidev_dio && map.m_flags & F2FS_MAP_MAPPED)
+		for (i =3D 0; i < sbi->s_ndevs; i++)
+			if (FDEV(i).bdev =3D=3D map.m_bdev)
+				pblk +=3D FDEV(i).start_blk;
+	if (WARN_ON_ONCE(pblk =3D=3D NEW_ADDR))
 		return -EINVAL;
-	if (WARN_ON_ONCE(map.m_pblk =3D=3D COMPRESS_ADDR))
+	if (WARN_ON_ONCE(pblk =3D=3D COMPRESS_ADDR))
 		return -EINVAL;
=20
-	if (map.m_pblk !=3D NULL_ADDR) {
+	if (pblk !=3D NULL_ADDR) {
 		iomap->length =3D blks_to_bytes(inode, map.m_len);
 		iomap->type =3D IOMAP_MAPPED;
 		iomap->flags |=3D IOMAP_F_MERGED;=
