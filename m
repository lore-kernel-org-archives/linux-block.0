Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888BD10A1B
	for <linux-block@vger.kernel.org>; Tue,  5 Mar 2024 09:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709631891; cv=fail; b=JlhFOYjoCViCXEpXD3tuXBdS7Vv05bDWuwIn3fg0ekfijDJJ43GhrCZgsQ2RJnAHHrKIzXhkNQYH+sViSwaVKvqvSh+kE4JUlEzAIe429VWkpkauEXuSxOZeqXA519Tkcu++k7wj88BVtcpbQDwOPoAxxWBfsivuFKXxgdV+Eic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709631891; c=relaxed/simple;
	bh=aEzhuhzNKzlZm3KHuXhuMnLHDFd4sjz2EvFJ4tZzOp8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iDrvXL8olfv8PwEjp965fWx8ZxUq3S4zFSNS/sVmCcr0tO4PP5BvtHW0ApBwAWIQe+hrJi7sXSyE9QwxrkvHHh0yJf4ScnQRtXAMnnNlwmioH33s5crVhzTQPRSHEAl2cLiNNGjs5X9WfFEjSB/6l8h/1ukG5nvqcRmEX4cAt+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FlefpWiC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XUdY62kI; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FlefpWiC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XUdY62kI"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709631889; x=1741167889;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aEzhuhzNKzlZm3KHuXhuMnLHDFd4sjz2EvFJ4tZzOp8=;
  b=FlefpWiC0Ru7pq7navRIssOZtvu/VRR/BCbP1eS89A5XorrJVW0Ykg0D
   6o1Km9bHDG20+pw+QqZSB+OwyA5ISyPyJj4eWxdECxiVi2TEjSDDPQmrr
   yshn3VYl5vQxpd+yTrjDzRzS+GwqKVchcSgR4lKUINtYh94lP13G0gVcv
   fqygkKMhlnpAgAti4ujn6AAvhPOAz4AhMwdqJa7S9iaMALHDu7s5Jwpcb
   o3qgvE7nEtl1aTCXVikbvAaK2y54LdDC6VfLcgTmDJ0kmeOv1XXgFHRyj
   V12BtxhaXvYgqnEwUYj07x72nWsgByShIArD3suM+gXl3hFIeWlTyK6Qn
   w==;
X-CSE-ConnectionGUID: 7aEPuTfzT7uTQUqohXqzdw==
X-CSE-MsgGUID: 80q0GNK2S8uNT57kw7Ne2A==
X-IronPort-AV: E=Sophos;i="6.06,205,1705334400"; 
   d="scan'208";a="10829263"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2024 17:44:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L17mhgbkV+Mc3FzvXZzLtkBjv1pb2HAGS4uz1iKHKA7j7EU1xwO/XckA7mjRM1hgyOJxZJaTqXjn6RA2fYu+m2ddVP4Q/6YsycC50GqbiK6uMAC4lgzMnsriAxdHBARo6hngGn7Mng6hfMg3PcZ86OvYIm/Uiducvu49Q2OCwXhKoTNARGhAwRCetgPhUlf5SUIRN8LXD9dN6GPOAJRu5ctE2Oyy5JKIvc08IpPpo+mMkEjCUTPMica2YnLoMIT8pE+HqevYwwUPDhSnf37urVAS+Vrt3Jp848Cj+MSus+5huRNPBE7263vDbChONKurv3fDUc1kvJKVuWSvAQ3LQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Dl0ZHLJWbLKlJqAsH2e5b5XtvcmDbAZO7Z5ikPKHR4=;
 b=PIJ4T9IUFKJGyaiJ/x1VHzuE8HpvPmjbnXD8d8gjjC5x8TD7Wy1sc7TwDB1gdOq3gjNbrzLMqVq+U9vsaBPTvV+mX56kbqh3fM6BpK5gAt3ps6NVwIWiUcpcwL+UA6FxMApSKZZd7wnIj6tbuDoMjswZJywLYYYwYcVXatlIB6xXpOuDGS8Sx0mg69qJcZ3T7w8AQxwcF1Big253SN9GXVGeHrW3xhHFz7J6m0DNnDI39b23CdApPXHs2rdyiiOKqNdXbVW/sV0frwF5/Z+ECohvmiEN6bVFqD4yD/Zwci+dl8HLgHPXPl06qjbaGY6pKyYgHAt8oz9/q2l2gTZU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Dl0ZHLJWbLKlJqAsH2e5b5XtvcmDbAZO7Z5ikPKHR4=;
 b=XUdY62kInCa3uUBGH3w4qe1I+OXtMc60kIsgXHbzYNCYJj53LNr0Ib5JLhfExn4eKlBuneEJyYpOo03fqZPJFHWQDqdo9M3Yab3HfmA6E0u1q2vh4Xla2/WjbIUoH3vASR0Kpz7KJm+nclGdropZtbPRlVYwe81hTd320ipvTyk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH7PR04MB8508.namprd04.prod.outlook.com (2603:10b6:510:2be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 09:44:46 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c9e3:b196:e5ea:909b%4]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 09:44:45 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Keith Busch
	<kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v1 0/2] extend nvme/045 to reconnect with invalid
 key
Thread-Topic: [PATCH blktests v1 0/2] extend nvme/045 to reconnect with
 invalid key
Thread-Index: AQHabk7cqNwSTpUn+k6UjReb5QwC+7Eo5uSA
Date: Tue, 5 Mar 2024 09:44:45 +0000
Message-ID: <2ya2o6s6lyiezbjoqbr33oiae2l65e2nrc75g3c47maisbifyv@4kpdmolhkiwx>
References: <20240304161303.19681-1-dwagner@suse.de>
In-Reply-To: <20240304161303.19681-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH7PR04MB8508:EE_
x-ms-office365-filtering-correlation-id: f4e92bf5-b199-4068-7a57-08dc3cf8e44b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 G/Ga9qA3QZVngoc7D2BPeJgJoYujqJFQiJLxm0QfTf3rC+5cS6+LeIOkIwzxYl+g70d+BK7wvjmHXfepHhH3eIJABYvZH//mVkX7v1dfPTSL5zOh3FJVtSBndTWQiXUOZ9tHNweXXjTNYnaMrOxwwppENR8LSwk+hhtm/Qxl71d+J7tMsvIquPhhHUopajcEJthIMuBpk2AkQejcMJPOJm5PXQM5vP/a65gSTa6b4Ho44OZi6tPxv1NId4SaATaut1T0DgDNz29h/wEit8E2D+HIvWA8Wj36FbVPtlFS9NxdZRgzim9zDBgFvvZxThOCvOljWYMIaDFwINIQA4x8Abls68ED+y5sIdFPA1OuTKxfIc0dUxp+dAdob2o0tNKXHnyZ4FDwB2OcVr65w6vvpIGmVCdD834m967jxl9ZYhJlixzbjTNWEz6azXI2qObsdR1SlPPV1jMffh4vBmDAtJghXrMQmZRvkJFWyCOw4mvnywtsNfw5szBP8ZaVL0dQ00zK4oITuDlBcQSPmgBctkYM60Toi65eCK2oW2paDgPgo1gjJ0kw84eIsEwUIaCvL0KqsLLqF/nd8Q9BojM5icpEEb9nguHVcSTK3+yzayW2rXezjBYCji+acw3alne8EBDa7jOAcGi4BranLnnOb4NtKGC4hoyTX7VyAuR0jNA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nh8dSDAVrieHY3BvJpLgxrzfuzXkKXY75wWKzEZVDo2qSx9yuumNwVQicC8A?=
 =?us-ascii?Q?EYk6amj8MrUgZsWm4b1zI+bWpqC5RpPkvBs0iPsi+0Tt0SZKVcMVCUUiCPMs?=
 =?us-ascii?Q?UEmtBjBkFBf2mTYy4ABLsC8u5/5ivbjsFTeGWQhBib8I+zN1HbWp2LR+vcN+?=
 =?us-ascii?Q?VshlMYzfY1/CKputXzrkAJCROlbe2ryKoqRZetVH0MAGBIBpwx2HdoLJLx/j?=
 =?us-ascii?Q?Jlgx8+GgFj7ncvkpW4Mn6YL/xMWjEfqnP0PeLN1nQhcr4lDnNWeCTZ00rZQF?=
 =?us-ascii?Q?rhweQ0RpIIMCUhWLKpMEl7fqEtLrXfuFUoIyyiK60awvW2hoHfICRIa6XFVB?=
 =?us-ascii?Q?dWnzegb7EJd66fdHT59ZIWIruKK4PcjLPvyXXhmh5x5sJ71LUYazG2Yyynv3?=
 =?us-ascii?Q?ec82PSwArtQgAQDwJZACUm0xHlK4eds11jBy7zw20l0B+/fgQb/Vk4aJEzSv?=
 =?us-ascii?Q?1KiVOdSemX4CwjvH+JgoLL+sENifraW4RQ83/Mxd9eagCx+seYHMURZ9bR3L?=
 =?us-ascii?Q?SKPTrfe1Cp6XSRxkedF+ulzBK8/oUvSc/nQfbkIQatwKL8C/w7CioFT6qmKQ?=
 =?us-ascii?Q?Y9/7Q+8TGDq9kvNHfgPK0E9EdrwoVTXhbsArlCinCkgWArrG8G/XlCef/TxG?=
 =?us-ascii?Q?oge7jgAfzcQcvkHNp+hy+GA8r/7Pie83uzZJ8K0YRMD3ik+uBIPhNYVg1Em8?=
 =?us-ascii?Q?3r1Kmqz5IahaR+C5qwV5PFl7IDr5m/BBgAyWgUHGTR2Pz9UhmPqjTN21Jev6?=
 =?us-ascii?Q?sebVLsWG9CLitQgku48ld7cigClde77gyt6O348MfKV7NmtS/KsTXnr7nJx8?=
 =?us-ascii?Q?AQhuBp6Je5Q590yRjTK7EU9FtDLI6nczqEFhUzT9wOKnoK/seVkqPfFL7h+B?=
 =?us-ascii?Q?//C7kcGpYLKsZDNoGXb6IZLa2yYo1wsJGBdDT4sLU4vP6a6huAqGb4wiM9Tq?=
 =?us-ascii?Q?T+cxLeBI1rQMreB0fRwcYlRspYwhMi/W+6hmJNKYp6biKfa6i8a1imBfR7+J?=
 =?us-ascii?Q?K1q65I7kO2Y0YSxPnj6fJaFDB9eYEp6dCf8INAlFzFy9ZCP976cM6Db5kksJ?=
 =?us-ascii?Q?8UgZbAeUZxDkRaTq1SCT2Mn88OX7wswx7ds3UUUKD5vzHA1AZVjQfUA8xHVU?=
 =?us-ascii?Q?g5VIKhcyQNcAF41JtNSbBq82U3KpB7vG6AasnoLgseL1uZzQxhtIprhxRZKE?=
 =?us-ascii?Q?sid8w8r/JJF8hWebjbqO2I3auoBQFuBevKGtoDLY7VI9cx4M+FjsHRNEAOIt?=
 =?us-ascii?Q?XYugEeJjWkJ3o62adtJi3gXdwFK+Id1nZ/8vu3Cn9duqXXFf73p/7yuUILAQ?=
 =?us-ascii?Q?pE9eV9NU/vLIOKj+Tsd5K7/lcwwYajnsGz6kfSxe3COa2ksdu57KVB31/pmt?=
 =?us-ascii?Q?1aWjEdDSQ9BCSo8KTgAxQNnaO72zUMN5RTy1pCqDkFpKZFecsYKA6ISuOykh?=
 =?us-ascii?Q?UEHwdOQr2in00OMbu20CHNbmRLFBVNgAa9sOj/HPB/QeWsZ1A0p+TB4ajv01?=
 =?us-ascii?Q?NV5DrLLGqXSVeNlLKzwktgSbNS6CAAObuwMbjJ2bk243SjMVt3uNCEclwksy?=
 =?us-ascii?Q?jYxN2V11wW2+qt9rUqq//VJNV9sS8m0QqTUcUChqJ/se7pyNs/1bdaAMg0e7?=
 =?us-ascii?Q?p9vHYcfOdK1TG0qX+0ZWUGo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <28F6771A83EF8B4EA3A4342523D7FA4C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KypDrkPwKmr3tfoequbX8KgymD3dY049r84XWnTQLaHai3G4EN9eESes2CZ0NKPvCfY0gzZv/kU0c1PKKZcE7WegaKEBx0yzFepsCasBpfYW/yLEX+3a6ek2hfpvV0I8L6TIdFuWQwAh03ZJ1IMrxpsk9V62m7e17ozyJfajuqd4uIULwU6TuZcr98WN4L4N+rsQU3nqOI/DdEVKMzUhaNw8mTLzisRcD4hsgvMeCX1gDAJbLFMeVM/o/00CpaGQJdUGs1QbN+X3GRAhol7gVTlBfGHONm5SAzvGh7mR+i880ALrYoRb48XTIKc2DxxveAmesDeiUzGEPaQuyusPG9ORWrf3WMFWdHyYkH2o1zPYQj0bet6D2rhjE/K2kU+Iug3UOVvqGCJSBo3Lkd8Gp2jugB1JaOrm1mYMZ9VjV6x7GrVyBV1hsPQXdv7W1y+0N5i2xYtj0+qauknaHGaqTXoxSWhvxiknCn34sYzuDbRTAvWKsdfwtCDRLNSBSU/K0+qm2w7KVEoPDfAYwa8eoEZxRarDmSR+tGDEkoeTUO7Eb1Okr8NFebYrz7BdzP6ZYb3GR9xNFX3/VwUYQR0uZN8wlk6qjrdG/YGE8ntMmEkwVlLji1+J13LN4HaE4TKJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e92bf5-b199-4068-7a57-08dc3cf8e44b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 09:44:45.8922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4fdw57ashlk0lJY5BczR0QKZkGHVXIcwMcASJc5XRDjLUxPFrOwW5w0b7UcyJsOtJIoKOA9uRSVMR9drt+quntBvHV7Q/JEHssXA/mT6pOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8508

On Mar 04, 2024 / 17:13, Daniel Wagner wrote:
> The is the test case for
>=20
> https://lore.kernel.org/linux-nvme/20240304161006.19328-1-dwagner@suse.de=
/
>
>=20
> Daniel Wagner (2):
>   nvme/rc: add reconnect-delay argument only for fabrics transports
>   nvme/048: add reconnect after ctrl key change

I apply the kernel patches in the link above to v6.8-rc7, then ran nvme/045
with the blktests patches in the series. And I observed failure of the test
case with various transports [1]. Is this failure expected?

Also, I observed KASAN double-free [2]. Do you observe it in your environme=
nt?
I created a quick fix [3], and it looks resolving the double-free.

[1]

sudo ./check nvme/045
nvme/045 (Test re-authentication)                            [failed]
    runtime  8.069s  ...  7.639s
    --- tests/nvme/045.out      2024-03-05 18:09:07.267668493 +0900
    +++ /home/shin/Blktests/blktests/results/nodev/nvme/045.out.bad     202=
4-03-05 18:10:07.735494384 +0900
    @@ -9,5 +9,6 @@
     Change hash to hmac(sha512)
     Re-authenticate with changed hash
     Renew host key on the controller and force reconnect
    -disconnected 0 controller(s)
    +controller "nvme1" not deleted within 5 seconds
    +disconnected 1 controller(s)
     Test complete

[2]

[  938.253184] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  938.254995] BUG: KASAN: double-free in nuse_show+0x307/0x3c0 [nvme_core]
[  938.256400] Free of addr ffff88812d318000 by task nvme/1564

[  938.258777] CPU: 2 PID: 1564 Comm: nvme Not tainted 6.8.0-rc7+ #155
[  938.260188] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.16.3-1.fc39 04/01/2014
[  938.261695] Call Trace:
[  938.262780]  <TASK>
[  938.263950]  dump_stack_lvl+0x57/0x90
[  938.265157]  print_report+0xcf/0x670
[  938.266372]  ? __virt_addr_valid+0x211/0x400
[  938.267554]  ? nuse_show+0x307/0x3c0 [nvme_core]
[  938.268790]  kasan_report_invalid_free+0x72/0xa0
[  938.270025]  ? nuse_show+0x307/0x3c0 [nvme_core]
[  938.271242]  ? nuse_show+0x307/0x3c0 [nvme_core]
[  938.272447]  poison_slab_object+0x141/0x170
[  938.273574]  ? nuse_show+0x307/0x3c0 [nvme_core]
[  938.274826]  __kasan_slab_free+0x2e/0x50
[  938.276029]  kfree+0x116/0x350
[  938.277133]  nuse_show+0x307/0x3c0 [nvme_core]
[  938.278326]  ? __pfx_lock_acquire+0x10/0x10
[  938.279433]  ? __pfx_nuse_show+0x10/0x10 [nvme_core]
[  938.280669]  dev_attr_show+0x42/0xc0
[  938.281668]  ? sysfs_file_ops+0x11b/0x170
[  938.282733]  sysfs_kf_seq_show+0x1f0/0x3b0
[  938.283818]  seq_read_iter+0x40c/0x11c0
[  938.284888]  ? rw_verify_area+0x179/0x470
[  938.286016]  vfs_read+0x606/0xc70
[  938.287106]  ? __pfx_vfs_read+0x10/0x10
[  938.288153]  ? kasan_quarantine_put+0xd6/0x1e0
[  938.289234]  ? lockdep_hardirqs_on+0x7d/0x100
[  938.290313]  ? __fget_light+0x53/0x1e0
[  938.291267]  ksys_read+0xf7/0x1d0
[  938.292233]  ? __pfx_ksys_read+0x10/0x10
[  938.293301]  ? kasan_quarantine_put+0xd6/0x1e0
[  938.294300]  do_syscall_64+0x9a/0x190
[  938.295253]  ? __x64_sys_openat+0x11f/0x1d0
[  938.296292]  ? lockdep_hardirqs_on+0x7d/0x100
[  938.297277]  ? __pfx___x64_sys_openat+0x10/0x10
[  938.298328]  ? ksys_read+0xf7/0x1d0
[  938.299245]  ? lockdep_hardirqs_on_prepare+0x17b/0x410
[  938.300301]  ? do_syscall_64+0xa7/0x190
[  938.301191]  ? lockdep_hardirqs_on+0x7d/0x100
[  938.302148]  ? do_syscall_64+0xa7/0x190
[  938.303107]  ? do_syscall_64+0xa7/0x190
[  938.304009]  ? do_syscall_64+0xa7/0x190
[  938.304936]  ? lockdep_hardirqs_on_prepare+0x17b/0x410
[  938.306017]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  938.307103] RIP: 0033:0x7f57658da121
[  938.308065] Code: 00 48 8b 15 11 fd 0c 00 f7 d8 64 89 02 b8 ff ff ff ff =
eb bd e8 40 ce 01 00 f3 0f 1e fa 80 3d 45 82 0d 00 00 74 13 31 c0 0f 05 <48=
> 3d 00 f0 ff ff 77 4f c3 66 0f 1f 44 00 00 55 48 89 e5 48 83 ec
[  938.310749] RSP: 002b:00007ffe0fd8ef98 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000000
[  938.312023] RAX: ffffffffffffffda RBX: 00007ffe0fd908a8 RCX: 00007f57658=
da121
[  938.313215] RDX: 0000000000000fff RSI: 00007ffe0fd8efb0 RDI: 00000000000=
00003
[  938.314464] RBP: 00007ffe0fd90820 R08: 0000000000000073 R09: 00000000000=
00001
[  938.315668] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00004
[  938.316871] R13: 0000000000000000 R14: 00007f5765a4b000 R15: 00000000005=
3bdc0
[  938.318077]  </TASK>

[  938.319688] Allocated by task 1564:
[  938.320623]  kasan_save_stack+0x2f/0x50
[  938.321579]  kasan_save_track+0x10/0x30
[  938.322532]  __kasan_kmalloc+0xa6/0xb0
[  938.323477]  nvme_identify_ns+0xae/0x230 [nvme_core]
[  938.324529]  nuse_show+0x27a/0x3c0 [nvme_core]
[  938.325546]  dev_attr_show+0x42/0xc0
[  938.326485]  sysfs_kf_seq_show+0x1f0/0x3b0
[  938.327429]  seq_read_iter+0x40c/0x11c0
[  938.328483]  vfs_read+0x606/0xc70
[  938.329401]  ksys_read+0xf7/0x1d0
[  938.330441]  do_syscall_64+0x9a/0x190
[  938.331348]  entry_SYSCALL_64_after_hwframe+0x6e/0x76

[  938.333140] Freed by task 1564:
[  938.334143]  kasan_save_stack+0x2f/0x50
[  938.335067]  kasan_save_track+0x10/0x30
[  938.336078]  kasan_save_free_info+0x37/0x60
[  938.337101]  poison_slab_object+0x102/0x170
[  938.338124]  __kasan_slab_free+0x2e/0x50
[  938.339082]  kfree+0x116/0x350
[  938.339965]  nvme_identify_ns+0x1c5/0x230 [nvme_core]
[  938.341006]  nuse_show+0x27a/0x3c0 [nvme_core]
[  938.342003]  dev_attr_show+0x42/0xc0
[  938.342931]  sysfs_kf_seq_show+0x1f0/0x3b0
[  938.343882]  seq_read_iter+0x40c/0x11c0
[  938.344804]  vfs_read+0x606/0xc70
[  938.345708]  ksys_read+0xf7/0x1d0
[  938.346611]  do_syscall_64+0x9a/0x190
[  938.347538]  entry_SYSCALL_64_after_hwframe+0x6e/0x76

[  938.349308] The buggy address belongs to the object at ffff88812d318000
                which belongs to the cache kmalloc-4k of size 4096
[  938.350299] nvmet: creating nvm controller 1 for subsystem blktests-subs=
ystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e=
60b8de349 with DH-HMAC-CHAP.
[  938.350311] The buggy address is located 0 bytes inside of
                4096-byte region [ffff88812d318000, ffff88812d319000)

[  938.350314] The buggy address belongs to the physical page:
[  938.358511] page:00000000389f3330 refcount:1 mapcount:0 mapping:00000000=
00000000 index:0x0 pfn:0x12d318
[  938.360009] head:00000000389f3330 order:3 entire_mapcount:0 nr_pages_map=
ped:0 pincount:0
[  938.361388] flags: 0x17ffffc0000840(slab|head|node=3D0|zone=3D2|lastcpup=
id=3D0x1fffff)
[  938.362644] page_type: 0xffffffff()
[  938.363627] raw: 0017ffffc0000840 ffff888100043040 dead000000000122 0000=
000000000000
[  938.364958] raw: 0000000000000000 0000000080040004 00000001ffffffff 0000=
000000000000
[  938.366278] page dumped because: kasan: bad access detected

[  938.368303] Memory state around the buggy address:
[  938.369384]  ffff88812d317f00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc=
 fc fc
[  938.370661]  ffff88812d317f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc=
 fc fc
[  938.371983] >ffff88812d318000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  938.373295]                    ^
[  938.374311]  ffff88812d318080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  938.375618]  ffff88812d318100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb=
 fb fb
[  938.376954] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  938.378356] Disabling lock debugging due to kernel taint


[3]

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index f2832f70e7e0..4e161d3cd840 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -221,14 +221,10 @@ static int ns_update_nuse(struct nvme_ns *ns)
=20
 	ret =3D nvme_identify_ns(ns->ctrl, ns->head->ns_id, &id);
 	if (ret)
-		goto out_free_id;
+		return ret;
=20
 	ns->head->nuse =3D le64_to_cpu(id->nuse);
-
-out_free_id:
-	kfree(id);
-
-	return ret;
+	return 0;
 }
=20
 static ssize_t nuse_show(struct device *dev, struct device_attribute *attr=
,=
