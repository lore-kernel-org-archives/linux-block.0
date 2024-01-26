Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF5E13FEB
	for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706267409; cv=fail; b=EEQBga4hdSYGITHUJwArb0YLQgj9OSplXU54+G2eopk74vB0L0p+wtcNJZDZf7SDYU7TVmeA6eFBZmqJ/CfS/Iy8hLL40LNayPPItvt6sXUqpUC4sq634oyCUN2szaFtP64g+gxXCc0bxNPyQfOIzZcho3dcIhdJLeVetOlUsGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706267409; c=relaxed/simple;
	bh=JzaS7mbD9VI+TvtCVQgO+d7bxMgS+3D08zoGPwyeDqk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tz18QjEcTel2FBwPGGPTMDBJpAR5pLCguq06obluU2CyFt0fxt2rimUkulxP3SFeGxAgmf3dVngA1mYQnXL5qYFONh5JTVj4gW1C90xSMEV17w/cCn989JG4prg2xFOahU9IPVRQizgu42xerC65RgZ7zl81d+NBwIyYqNaq720=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mS0J8sjf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=oqJp3PEb; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mS0J8sjf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oqJp3PEb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706267406; x=1737803406;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JzaS7mbD9VI+TvtCVQgO+d7bxMgS+3D08zoGPwyeDqk=;
  b=mS0J8sjfc9Lb/bVVHIOloht5ZV4/BZN327h6vVFCvH/GG0KaIHDOITky
   8Yi3zhRsgvpyCajL6SYivc1zIGKhK2D6+IhFAJwS+5BIuKYpm0YbFdGxQ
   M5p3sQilaaXw5IDVKSJkk2vPbTxnL07JhU0k28n2vfS7LqIqZ0JAtGNC4
   EW8cPc0PdawntuaLUPQBLTKZJXXypyWc/X30xdQEnc5hGMLscUWkSp78Z
   rYI8CpQeVF7puN/vNH71B3HdC4kNau74X5hTKn1Vw+C85GnYOlA25Ub7B
   5b6AG1/5bUAiNC4Eoz7s9WZqIOLcef5O3x9NPuFNn3gCKRxG9etKWKg2m
   A==;
X-CSE-ConnectionGUID: W/qZVLVmRumBB7RS83zqNg==
X-CSE-MsgGUID: GuAY+AAXR7Gn4qkWxUeg0Q==
X-IronPort-AV: E=Sophos;i="6.05,216,1701100800"; 
   d="scan'208";a="7517996"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2024 19:10:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJtK00iOW1m1ZLesuh8fy/ngTMcQynhy9AW6JIyd6zlwvhjolQyvTUR/LbhAJ4lkuEdXyUARyNAqyN6N9t5YikWdWGSdP4knCN/0X7adGZeXxeJ2WRPZJljAjeGOxaOP2S9MEjfOAcU0jZDBzDB0aPuQhd6XERYJOmn0b7Ytkh4GCVy5sEkZ+b7axiwqPUHPkkHP898swC3sQxyvSebKfSLuZ1jbGw3SU+ScUV4KQT5nkBpmK0BGrKW9dEuUc2ejIk5VTkM4yzA0VYCm7HO0LhumXxzGOzEKuDLQx7vA+bKb5AKJPFfoesMqZ4ueeF2QqxMS7OQbyy1eK562mXAoaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+nA3m7Fl10CInq7mc6R99UgJ9zOZpyfSWbvyPlgACQ=;
 b=c1RY0D6IE2Iy00DJioNyG10yoCu2X0ZlfVajf5WWQ78FOvekDI8IpJo/+tE54kkT82kR83EwrZYRv0ZmQ0OwpzpF/PrfxpSAqq15QSofjEQlJk/YGu88Hp2qkWkZbu6M7JV+JSeVYsWrbcfc/i0a8upQCJQpiIwcXvFsZJATwhRIWmIfDJC6HMoqsXy5d2uzWHdObCrd0bgn8eYLMQTPbnYXJDRTJp+3uqQR6JmdDmG1fnWl+D969RuHRwBaQRrEuLpS2jNuRgk/fGpALxz6F2O5GgrAQLubN4CIDA5sB5TKM32XWNPBVaYIfyDUMSwNbENNnEalTWhACSY9eQMVgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+nA3m7Fl10CInq7mc6R99UgJ9zOZpyfSWbvyPlgACQ=;
 b=oqJp3PEbskbQLOao8xAgJxl9aAaljmPZIm2pfPbeh1Rbk3w1VhEtkE1DRUO5qRmQHwyF934zsn0T2L8VeHzmWT8ByIKNQBPwq+eu4bQJOUf4ZFIrVYWv8rrMG2h2AMDmjXOBGTHJn1EEv/lKSac4AAJ8FQNwwSACEY+dJc2fbe0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH8PR04MB8613.namprd04.prod.outlook.com (2603:10b6:510:259::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 11:10:00 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::25d0:1445:7392:e814%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 11:10:00 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH for-next v2] null_blk: add configfs variable shared_tags
Thread-Topic: [PATCH for-next v2] null_blk: add configfs variable shared_tags
Thread-Index: AQHaT3dJ7QOQ/NfNgEeOFnHjKBviibDrpFcAgABNHwA=
Date: Fri, 26 Jan 2024 11:09:59 +0000
Message-ID: <6cx2neamoup5ze6mzpmfgsx4ni4zoi6jufhc36esgkz2vqzdjo@owzusgg75saz>
References: <20240125101425.2054263-1-shinichiro.kawasaki@wdc.com>
 <9a263919-51da-4188-9fd7-52c4bcafa65a@nvidia.com>
In-Reply-To: <9a263919-51da-4188-9fd7-52c4bcafa65a@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH8PR04MB8613:EE_
x-ms-office365-filtering-correlation-id: 03dd5ceb-d4dc-4e2e-a787-08dc1e5f565b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 yZKhutXATqeS5jbWfhf0kFIMMuwlnNxVQBwJ94V5hpZ81MIpTuvL6Kh0lP4Mag9MNFugrE2scEbPAxuyXT20you6rhH4INzXcuJHyPkR448Lz/Ph6IXahITGvzZ4b2enwcA1nNUqh6aIuyA/76JT3N+IccoVKZ5h0DuRCx3ahYAlmCW97XfH00+fPo1xb0+z+McmZ2clCh+5P47x5dCsRoQDIn84lPCTk8A7Uwzuf6m3QAfRLpJTGpJC/3CZFgrwb6nc09/m3clgV/Y9KvCCqG8Yd1t7EwpTF78TapIk3rvstn9AIAD06HkvqMsiMqaCOTxmMEL+zA5bZmqxLjoxXk5+3lpqBMmSw9wlHA2jcC/rqN4WDpIrJZx2Fx8UjGarVY7OA9f2DG0OltbA3t9/xCHUh+9Oz5rpJtnP3iF4GpPT5axn1Zqxj2nanrMwlQchbFyn6CaZZca6FAkFl86Lcysha6JdNwRKScUCyF+BVqaAvIBTH4QuFsHDlnc+6FEW3QXPnaQC9SJKKvBeWmgs3GLFXRT7Iid+hL8BfnO652eoK8br3EL1xLeKMHCKONten8xVQ1vxrQHgnWAyasYMQ3l41HFfS08vKjKm3vuI9ss=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(39860400002)(136003)(346002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(83380400001)(41300700001)(6486002)(6512007)(9686003)(33716001)(26005)(122000001)(38100700002)(4326008)(5660300002)(8676002)(44832011)(8936002)(54906003)(53546011)(478600001)(2906002)(6506007)(64756008)(66446008)(66556008)(66476007)(76116006)(6916009)(91956017)(71200400001)(316002)(66946007)(38070700009)(82960400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?IUqemGKMOG6RN2METX67sLZYJ7OepGTb/oHYzJbHTeDSXIp85QNsUFJ6qC?=
 =?iso-8859-1?Q?GuMXfUubyN7N5POeIkHIu/q9zx5u/sjNTCpkSCJcDuu9U2MpDH9pFzOQcV?=
 =?iso-8859-1?Q?jbBLRTMM7VBL4gFQCGePcTN6+nqfdUdLHSEANwV+4HJxfJCV68LfG9+O/0?=
 =?iso-8859-1?Q?qXJKyljsa6U0bNjxi3vDQEsLHV14fYVjt9ofxw/QW8NJVLis6SMzjiJWPA?=
 =?iso-8859-1?Q?jVcGQJXzA3o9TIWWytnyjiSLD/8fSU7dz4HOgnpPSlgU96oa/XNLWduXXm?=
 =?iso-8859-1?Q?cf85hE9eM3Oc3Xrf3/8AhvV+ZcVF/140OM/J2U3SI76FK6MQMfpjHJ+sjT?=
 =?iso-8859-1?Q?w2EON15BFpMow69R8PAuY8axNup8tOGwChSz8Kiz+YiShCbh5njeAomgx5?=
 =?iso-8859-1?Q?XmrtkIj753dO/I1ORFzcKkUkqucjX89vKzXvQ8PAHaHvdP8rZQadWq3r0J?=
 =?iso-8859-1?Q?4tGy0ZKhraKCcC/vl2vUoZjeOEdjTTIKML0iIohM92T/NwrBxoIxmCZPWY?=
 =?iso-8859-1?Q?mSHjLf/zMZ43U0pM2aF+tQ0t0K9pIDizIOcZHSjvs9wH00eMUHjnhkJa7/?=
 =?iso-8859-1?Q?SmmYjHMDOJUPLD5k1pJhbAJ8JzA24fII1wp4iEiflTKV+4MbgrYVpAoNEy?=
 =?iso-8859-1?Q?JN522BC9c9PB7s1lERyB70dWyP++BDvBcQlrf0CW/G/kHo5mYViTUBo9V7?=
 =?iso-8859-1?Q?yHTFp8E6KMBfZ08CjxGkf7tFoTkfrCw/eS+vUJHNM5VHEafSviw2NekB4E?=
 =?iso-8859-1?Q?3h327xFowdg5jddgDDdHSbMS+uiu09jZwHw00BI6HbfDzUzeKw9/8OGI5c?=
 =?iso-8859-1?Q?wAZqNGZBU9lHVxHEO9leKYA2XzzuGDmxeob4Sj8+npXTEa/LhtgHqltFdD?=
 =?iso-8859-1?Q?Jn/KPSuu3DS6N9GwS7XNAHVu9AgTF9kkHYuaNwu1dcdFnB+f/wbQ9i9ApE?=
 =?iso-8859-1?Q?+JXpfIVNZcK0ulSiVnCe3mBYSRnFZXMzm2o4YlOinUrBNXqCp8Lclszee5?=
 =?iso-8859-1?Q?AGm0JzHRv50u21XM63cea+Ir844a3uQu40LcAuuGub+40iZdkIZAbD/u1D?=
 =?iso-8859-1?Q?8Mlh/ss9WkIJDdMPHYWhnwLxjknqt8lBqr/sQJNi2WsclS4YCQX+/+uBir?=
 =?iso-8859-1?Q?dO+UyUf/VWt4lRQQKh77pEX2PMqLu/DWO8yYEDRXcMyRRbQsJCv08s6PLU?=
 =?iso-8859-1?Q?n+ObOgpISgeN+MQ3t/ylARffiGN+8qutUkfdzE+riFWqL+6DUmw3alL0mA?=
 =?iso-8859-1?Q?FE7EGlWDEd+NuKqa/hyF/Ebxy3J4Dxg1FUEF0rsQ1FYppllF/1PcXvR8tq?=
 =?iso-8859-1?Q?oReixWTgI/bRXWgs2xZw/UsAuNsCD0Fz6G09NNCOAKnN4lrIEqW05j+XVX?=
 =?iso-8859-1?Q?n2zpHDvYqtIXh3k4MwTfG6MaEKiID2qBtwUJ2f4jOttABjmbdWDfx80mWG?=
 =?iso-8859-1?Q?0ZP8Xe91tD2EzVKYwQ9PqB62VBJDXfl/Fm/zD90QHSKmk1ZGxoYLAoim/B?=
 =?iso-8859-1?Q?WLjxp15smtbNDYSmnhnndf9J+Sbnul420mRUIL5Rsbi6Plnih6hnbLcuXf?=
 =?iso-8859-1?Q?XE700bwWrKZmiLsSwxIG7wYpgPChGNuSGIIjKUyCJv1Bb5c9qQDikPlsE3?=
 =?iso-8859-1?Q?lmZBSJr0geojyxc4xDnugTJR3nQuUcqkjPJIX7Bt7we0N7IUzrJTUFS26c?=
 =?iso-8859-1?Q?Kwsx083N5eijsgDJBCQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <8299185D1527FB46AE5B292DEE207D90@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mB7pHnPJO53ifB069YQdTZt/KAbR2cz4HXBJrg+XVzchTeY93JDjSfVWrxr/dXjZB4h5Dy/fc/menHHHIwTsXw6yMd6VEp23+NYRtH7uXyyTIihkokMKkzZiXe1tBZwAQf8BEVLhWTlh4Ddf8EFKXAWs5NthwXs16DfUH0pGD8trP5ZhBiGCEOUai6Twe74fUbt4oNkExtiRoAaZ07KQTtL+3FGGb9fe4hbNO8R4r+r66TzdiVoYMk8vb78grmhauCROtXTpqumPUgCYDJscETo+Nh/079jHUlkOicEt+BEAKnV+SqeYFc7VKj+ZIqdTHDajuFBoDHiPj45V6uGAj13CrrFv1aLwtuOunrZRkRa+PrK/i805D077+TOWx1LkwamDYjs3lzYA4Zp7VHLrlItB14DG31+IzwBtKhi5uSpsJfocc/NyGqINZ2uCdq6YPXnlo+2/vZVofQ9qS+wFxH/DfPpCurLuMUIWIvIBzQC/m4wC5VzX75DlWKNGTuY/MsVHvWHXnBoy/l9T1EnEbHs3IE7t86s318zkUAA5a7F2oDUEv17QpYcATdAZMUZTVy1ZnKNPRI5CAtvl+rJDs/l4SBzRLdParcOIx+NvHA5V4gaj7FThYoVXwAtuVAh2
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03dd5ceb-d4dc-4e2e-a787-08dc1e5f565b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 11:09:59.9227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PclJwyZbDC0JOashuOabrj4uFggCHId9kJHCFahXtk+0DdCJVwLfM/l1qt51K5Iy55CUrDgPHaKOm5oY2PRQFlbnCQks2/ZL40hFaiYC0LE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8613

On Jan 26, 2024 / 06:33, Chaitanya Kulkarni wrote:
> On 1/25/24 02:14, Shin'ichiro Kawasaki wrote:
> > Allow setting shared_tags through configfs, which could only be set as =
a
> > module parameter. For that purpose, delay tag_set initialization from
> > null_init() to null_add_dev(). Introduce the flag tag_set_initialized t=
o
> > manage the initialization status of tag_set.
>=20
> we probably don't need the tag_set_initialized see below ..
>=20
> > The following parameters can not be set through configfs yet:
> >
> >      timeout
> >      requeue
> >      init_hctx
>=20
> I've not seen something like this in the commit log, but if everyone is o=
kay
> sure ...

The commit 7012eef520cb ("null_blk: add configfs variables for 2 options") =
has
similar log. I tried to make the commit logs consistent.

>=20
> > Signed-off-by: Shin'ichiro Kawasaki<shinichiro.kawasaki@wdc.com>
> > ---
> > This patch will allow running the blktests test cases block/010 and blo=
ck/022
> > using the built-in null_blk driver. Corresponding blktests side changes=
 are
> > drafted here [1].
> >
> > [1]https://github.com/kawasaki/blktests/tree/shared_tags
> >
> > Changes from v1:
> > * Removed unnecessary global variable initializer
> >
> >   drivers/block/null_blk/main.c     | 38 ++++++++++++++++--------------=
-
> >   drivers/block/null_blk/null_blk.h |  1 +
> >   2 files changed, 21 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/mai=
n.c
> > index 36755f263e8e..1407d4e3452a 100644
> > --- a/drivers/block/null_blk/main.c
> > +++ b/drivers/block/null_blk/main.c
> > @@ -69,6 +69,7 @@ static LIST_HEAD(nullb_list);
> >   static struct mutex lock;
> >   static int null_major;
> >   static DEFINE_IDA(nullb_indexes);
> > +static bool tag_set_initialized;
> >   static struct blk_mq_tag_set tag_set;
> >  =20
> >  =20
>=20
> [...]
>=20
> > @@ -2124,7 +2129,13 @@ static int null_add_dev(struct nullb_device *dev=
)
> >   		goto out_free_nullb;
> >  =20
> >   	if (dev->queue_mode =3D=3D NULL_Q_MQ) {
> > -		if (shared_tags) {
> > +		if (dev->shared_tags) {
> > +			if (!tag_set_initialized) {
> > +				rv =3D null_init_tag_set(NULL, &tag_set);
> > +				if (rv)
> > +					goto out_cleanup_queues;
> > +				tag_set_initialized =3D true;
> > +			}
> >   			nullb->tag_set =3D &tag_set;
> >   			rv =3D 0;
> >   		} else {
> > @@ -2311,18 +2322,12 @@ static int __init null_init(void)
> >   		g_submit_queues =3D 1;
> >   	}
> >  =20
> > -	if (g_queue_mode =3D=3D NULL_Q_MQ && shared_tags) {
> > -		ret =3D null_init_tag_set(NULL, &tag_set);
> > -		if (ret)
> > -			return ret;
> > -	}
> > -
> >   	config_group_init(&nullb_subsys.su_group);
> >   	mutex_init(&nullb_subsys.su_mutex);
> >  =20
> >   	ret =3D configfs_register_subsystem(&nullb_subsys);
> >   	if (ret)
> > -		goto err_tagset;
> > +		return ret;
> >  =20
> >   	mutex_init(&lock);
> >  =20
> > @@ -2349,9 +2354,6 @@ static int __init null_init(void)
> >   	unregister_blkdev(null_major, "nullb");
> >   err_conf:
> >   	configfs_unregister_subsystem(&nullb_subsys);
> > -err_tagset:
> > -	if (g_queue_mode =3D=3D NULL_Q_MQ && shared_tags)
> > -		blk_mq_free_tag_set(&tag_set);
> >   	return ret;
> >   }
> >  =20
> > @@ -2370,7 +2372,7 @@ static void __exit null_exit(void)
> >   	}
> >   	mutex_unlock(&lock);
> >  =20
> > -	if (g_queue_mode =3D=3D NULL_Q_MQ && shared_tags)
> > +	if (tag_set_initialized)
> >   		blk_mq_free_tag_set(&tag_set);
> >   }
> >  =20
> >
>=20
> The global variable tag_set_initialized is used to indicate if global=20
> variable
> struct blk_mq_tag_set tag_set is initialized or not, it only allow=20
> tag_set to be
> initialized once when dev->shared_tags =3D=3D true first time and in=20
> null_exit() we
> can call blk_mq_free_tag_set(&tag_set).
>=20
> One way to remove tag_set_initialized is to replace tag_set_initialized w=
ith
> global variable tag_set.ops with NULL check.
>=20
> This might work since in null_add_dev() when dev->shared_tags =3D=3D true=
=20
> for the
> first time tags_set.ops will be NULL because it is only initialized in
> null_init_tag_set() and for subsequent calls to null_add_dev() tag_set.op=
s
> will not be NULL, ensuring only one call to null_init_tag_set() with glob=
al
> variable tag_set.
>=20
> Unless there is any objection on using tag_set.ops, how about following
> (totally untested) on the top of yours, that removes tag_set_initialized =
?

Thank you for this idea. I think it is the simpler and the better.

>=20
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
> index 1407d4e3452a..3d69c7b9fa7f 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -69,7 +69,6 @@ static LIST_HEAD(nullb_list);
>  =A0static struct mutex lock;
>  =A0static int null_major;
>  =A0static DEFINE_IDA(nullb_indexes);
> -static bool tag_set_initialized;
>  =A0static struct blk_mq_tag_set tag_set;
>=20
>  =A0enum {
> @@ -2130,11 +2129,10 @@ static int null_add_dev(struct nullb_device *dev)
>=20
>  =A0=A0=A0=A0=A0=A0=A0 if (dev->queue_mode =3D=3D NULL_Q_MQ) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (dev->shared_tags) {
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!=
tag_set_initialized) {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!=
tag_set.ops) {
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 rv =3D null_init_tag_set(NULL, &tag_set);
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 if (rv)
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 goto out_cleanup_queues;
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 tag_set_initialized =3D true;
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 nu=
llb->tag_set =3D &tag_set;
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rv=
 =3D 0;

I think NULL should be set to tag_set.opts in case null_init_tag_set() fail=
ed.
So I think the hunk above will be as follows.

@@ -2124,7 +2128,14 @@ static int null_add_dev(struct nullb_device *dev)
 		goto out_free_nullb;
=20
 	if (dev->queue_mode =3D=3D NULL_Q_MQ) {
-		if (shared_tags) {
+		if (dev->shared_tags) {
+			if (!tag_set.ops) {
+				rv =3D null_init_tag_set(NULL, &tag_set);
+				if (rv) {
+					tag_set.ops =3D NULL;
+					goto out_cleanup_queues;
+				}
+			}
 			nullb->tag_set =3D &tag_set;
 			rv =3D 0;
 		} else {


> @@ -2372,7 +2370,7 @@ static void __exit null_exit(void)
>  =A0=A0=A0=A0=A0=A0=A0 }
>  =A0=A0=A0=A0=A0=A0=A0 mutex_unlock(&lock);
>=20
> -=A0=A0=A0=A0=A0=A0 if (tag_set_initialized)
> +=A0=A0=A0=A0=A0=A0 if (tags_set.ops)
>  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 blk_mq_free_tag_set(&tag_s=
et);
>  =A0}
>=20
> any thoughts ?

If there is no other comment, I will revise the patch with your idea and po=
st v3
next week.

>=20
> I've tested your original patch with blktests:block/010, it looks good
> to me ...

Thanks!=
