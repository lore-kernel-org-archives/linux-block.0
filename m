Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879D9C433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Nov 2022 11:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbiK3LPg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Nov 2022 06:15:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiK3LPe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Nov 2022 06:15:34 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8624E2B191
        for <linux-block@vger.kernel.org>; Wed, 30 Nov 2022 03:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669806933; x=1701342933;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Jhq61lQRxmyS0h1Qd4jepn1scLRKmiETscFrHHth1yk=;
  b=JuBoXxykRmL0gDQcEUUmk3b04mj2vv6BF2K7CaVWO3Y6FXVR5BphGAzp
   sOi7C1fvSW+VL08ZUSB1sHZoFFDVaT9ZEN5/q0sOVLF5x9VWx/AgVKaNU
   c4XhIhxA1cNDAYdd3CnoveS6DXBaqYLYZ4zavE1cL4A7Bmc/0pnvpv28U
   LSD3owKfXIJOPpS2VDjCpfUmQM5jb6A115hjDOTILzcXQOy2UbBpG9yCh
   1dQYHkeDTr7dHp3Y0Dw9pOG1lv6LJ7WbBJPtls3tcnfM5MT7e4q9LZt5W
   ulNkzApCgldu7SpLOqp9pONyHtkG1DAUpBbipBulGutgeD+tPnKUxMoLP
   A==;
X-IronPort-AV: E=Sophos;i="5.96,206,1665417600"; 
   d="scan'208";a="321895906"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 30 Nov 2022 19:15:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGBTRTRn6vB7hEKU2ca5SD5KMHZG4XIB2YM15XgcXT8NCi4zAQrb9Mya5Aw+rsj8JtyRBWfl989fbr5ui6BAu0RWXhIzW2s/7C6Ns9kd3nVg28YgfUthWt6TGl8u7s5aYrsyfIzH1pDt2dDjM+EvoC0lM8upYQaruVVsWbvEhDXLeWoAx2qV19RZ5G/ZoL+bPpF4CPiHfEviv0qfCh9ey6RwNftdZwzXhOx9x1W/gph4ASiTzGDiFoq9KyYmQhRgaM222EFDC6mKAmWc0fBzU+c8CbBRw/g25ym58wA0QCpLuzK3XAIGzyE30GSI56HgOvjGdTPFJCsKruXuK10Acg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aukdGeT7vHfEcCsrDX34fPOmMrqtov7gI28g8oWzX8=;
 b=Oi6nIDPl9XPNOAoR/2Mk6nYAr/lggZxsVj0KB/Yq0gDFKE3Hgb0WfQjbZlE40CciD78ntOTBMOsuJrj+61hTIxpmTcSS5av4DwbKgJFjfF2MbaKiL8wRd62dxlXeNNhnJYaGYyLWqNn5IT4kmDS7javaFfO3CaPwMvifxpM7XgYf123U4AmzMsLbmUIFyFYoJnutiksgqkLJ3K7MZJZ3UTQX6T+/YWX8b0Iu3sbf1KglGyZEzMk22iZsS21aY67e2pXv7BqPgf5Bju4hS30GVoqnSAOEFLX+hLHAI4DMb+b6s7X5EOaZrGyi8y421yU3QH3CAijm4Z70+xnsZ/7t/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aukdGeT7vHfEcCsrDX34fPOmMrqtov7gI28g8oWzX8=;
 b=FAjxx0BZ7nky2uQKYS0M8IBinOn1/GnOwXWcTGFEH37hUnQPIve2GRpfLMtz4Nlrr8CniYAytzzM6cZeftKO9cC+MBsa+U0Bjc1L8dMeQyJ6YeuEYctsDbzJD3quDDa2CSGeWJS962maTmjlXRaFWl6z9Lbz0CjZCWctxPG7OJw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MWHPR04MB0305.namprd04.prod.outlook.com (2603:10b6:300:7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.23; Wed, 30 Nov 2022 11:15:29 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%5]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 11:15:29 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH] null_blk: support readonly and offline zone conditions
Thread-Topic: [PATCH] null_blk: support readonly and offline zone conditions
Thread-Index: AQHZBJ/qDIbeB32Cik2eyTwcrpVqZq5XQPiAgAAP4YA=
Date:   Wed, 30 Nov 2022 11:15:29 +0000
Message-ID: <20221130111527.unxyntggkkyk2fom@shindev>
References: <20221130094121.2321485-1-shinichiro.kawasaki@wdc.com>
 <fde23932-d8a4-5a14-9298-7022edbb20de@opensource.wdc.com>
In-Reply-To: <fde23932-d8a4-5a14-9298-7022edbb20de@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MWHPR04MB0305:EE_
x-ms-office365-filtering-correlation-id: 5677a478-b5b1-456d-5ffe-08dad2c4306f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OQttBSUNwsDvTPb2fw53dDTfE5Vd1nAM9HuxuWYAq5xuKLycTuitfAgIN8oSCV9YChACISIrj2NeekZARe12IcQV38srCvwKm7C9/ElM3J0AomVUg4IXWOFyzqZT29pUjXCooAU0r9j8YM+GdbgH0mo0iSsf/jR1gERBfZj3VUpqBtb1hTrX4XRCrRYXw3JDSPwmMWXSZzlGtfHb60XzfkqW5GFJk8bbZF4uyBD7YImEHe/xZh1ZFYjJcpZPbTjaQxEO+wz7meeVs6vgJ5LLXYmeYKaVFyru0HsxtatOMry5FN2X+kRuUeR9pYkBguslAr5fc9WvYblGK5cXy3SiOpqXto9MaAawgNq1w+2HfOh3vxzBWus0m17jqT3UELV9O9tAIAO/Y0O9dEXh25XZEWf1dlkmuzRM7K8i9pCd8HN0iKT1vwn3rSCe5j/M1Lx0hzy8HBj2dlQOFr6Hg2xoK4eJrz9gASXrp7iOPPG5wl8zz/mHGY5OGh47A8o86GXjfFLyBw7NUUZ39evajuozZJh6nOUhIp9fK+dHk4SijI3n6R7S4qJCWr/1J2KDK5cgndyFHwsYPXa+XHxN3Ov1AEB9CFZ3k2y911kiOGXDTLh8AKBo3K0iWLw9HllxckeYi1YL4AdYz06ZmePUbZAHMGOIn4ePChrn6JA1+REsDnqmTX3d7A0LOf4tiWmej38RvsIGNytITGtfbYkxhomhCQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(451199015)(5660300002)(33716001)(44832011)(41300700001)(54906003)(6862004)(9686003)(26005)(6512007)(316002)(82960400001)(76116006)(66556008)(66446008)(8676002)(66946007)(4326008)(66476007)(122000001)(38100700002)(38070700005)(8936002)(64756008)(91956017)(1076003)(2906002)(186003)(83380400001)(86362001)(6506007)(6486002)(71200400001)(478600001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2XW9JK3j2ijmmhE9PYXY1z5R/fYZEtHWrIaERtRXgHQ8vOk+5AQo7bWyY+/V?=
 =?us-ascii?Q?eZ9GpQb+DjgwcH+YdljGiyHXspExdnyMm6NMCwS2oDRiYDN88QNrjHyUDcZM?=
 =?us-ascii?Q?bnhr0v7w13LK87y042ISRlg2poJP8pekjNbEMFrKmDKTwD4i8TnEkPMXGN0/?=
 =?us-ascii?Q?3G/yiohHB704/huhzvlDvm/HfNc44Fpf1hDP1vW+iuyLzP/03TMrJVMLXl68?=
 =?us-ascii?Q?79DbBN9iI9gN+ri6wQ7L7Rf4BXwlyqyCRb2SeaTRgU9nXx717WsIvXx2Ef0R?=
 =?us-ascii?Q?zgxvw+9ErRfeV/hshWlsmmgzcJI3yDDxnupSjbXjO756wWzCdp6eBnAh7VCJ?=
 =?us-ascii?Q?7RN6OE61dpTggmxBR7sZPIwYJxoP1B2YTUo414x1tfPlIHIXZQePCFstWlfm?=
 =?us-ascii?Q?GU1RAbg2acbx/9VidP/L64Ry2VEEDgKC7V0DSWPfhcboEQuCnp0OXfHh8UtF?=
 =?us-ascii?Q?nvUklxwoI0kR6YiLLQH5pWu9dTOXJx36tNwdWyP67P8CuRF2ef5PgHaDSytq?=
 =?us-ascii?Q?izlAmQNqiNw8Wx6vJHS4H3AYiE1bieeKsNjf5cjaGtU5qtXXjsY/BViiVfEY?=
 =?us-ascii?Q?JZkgGtfqeyIN/eNx3WLLZhqFYRzZpYi0C7TNXk+01BoB0/MLk4lYXAGO34LR?=
 =?us-ascii?Q?RPjKNXRXQ0WAUW5kQOlBZhk7AElbS7x2ordcN1QWjI+NsoO3Gaeu30amuStf?=
 =?us-ascii?Q?nAXxKWfePcls04tnKo70YLgDQ+EdsW671fDpch0xSDLQrp9qdV6L3gdvQvT0?=
 =?us-ascii?Q?MHUh3wMbRcy5mJVUVykRMVUoFhE3F4WzK0rMkD4LZOfFR1YSSCW+bTzfwx1X?=
 =?us-ascii?Q?ILzkV74kPZfQWhpxm/+dR62rlPIpqewNVZGK/y3fW63UP73YxKQE1YV2cc4/?=
 =?us-ascii?Q?yBtmC7a5gv4K3dh1CZ2OhMAdw9VpPcHpS+oub1VMIfWa2L2lON9yrH3ndpcr?=
 =?us-ascii?Q?EAOrU8I9QA8DFdjS059u3II9yq9ssy15YxiHS4/3dZ/ZsIWKuQ3t6wEc7FYc?=
 =?us-ascii?Q?WH3hCyvAoCSPIRO/97wwSFRhCe+MJUe0KOt3n5S01OLo0bv+cIJIfST1Nqnl?=
 =?us-ascii?Q?zaboSRpbkkX4QM7Ue1HZTHySGb3EnVsvys7YxAIyNOM7BzWU8vdIotaYlhJd?=
 =?us-ascii?Q?gg8ZZrs+YUlllht03gnloIzE4HCMBkvCSCegf6d28zqPJBMgY8G8QjNz79tw?=
 =?us-ascii?Q?9jq/SmXZK764eKSvJJcMbz01UbHb46iL+rGdOTZJSk6EY+DDWkTkGRg/qrSm?=
 =?us-ascii?Q?RT3Z+5HAbIl34YF7NM5o8Xj8axwQm+GjYTdxxPJDyFJ5jTdckw8LH7BBkOTq?=
 =?us-ascii?Q?4gxiKU4AHdKBIS0Qdyk0GO+jvbqPsK4dMY70IhSGB1uv272FEBJ9eeuGAhlV?=
 =?us-ascii?Q?t0GZ8j7OgO3laQlf/BR4VmuPUjEsDOUVxXoIHm1kNgMgdetRrqvrSoSnQSVj?=
 =?us-ascii?Q?2lc2AbNOL211y39AcJxN9/kzjMKNgcLs4IMfIRWWga3dP02mXGbkFPhtvIOQ?=
 =?us-ascii?Q?fqt8ZusHDb832wT1rR9CBn+blADBc0kVZlVvBDKdeNCiiBGbRhFmFcEG6mKF?=
 =?us-ascii?Q?ugKh4j0Qsa9GrOTPNJfUrF5UUvzgHtV/7yCK7TFat2LSgQ//dYLFpztiE0AZ?=
 =?us-ascii?Q?Njhm27ZzsPAL5/tiiDntlI4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A1EF06C4ED0A542B12C588626AB4BBD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PPCQtKL9zwkk3RNFJe4W72KkAEy2ReohQbcHKWqAbka5AcoP8Waw7nRipScM4mDaQHTnssJXJxQsBhZWjVW/dtOBxC/2YbaHX7DdBxEtgl2Ya02W2TZS164/5BSPY1blCmY/B+avrgKx0cKOXIbkhX3edP+p37Ixh5OaiVTVyaDJxE7YX5rhhEFInNGAzgA3KaMTVdi3HkCvHBBGWy/czgmjXlOWKAbbIL33U75xJOh9lFQzVP1mX1yt6UbANTPTq23aPTI8GxrASRqtcANnYLRpAL7SxkYVFewnzUpqo+Bigj9i55yFtNiXz6/rwaFEDrQ/56u577f6PMrqhgIEslLaKdMlKW5ByAx/dkNn/fZT2n/RVnuUCxuQJXBDEFmiTfizHLdLmxtb5QqbKZytmlJdKG9FA4ZNPUYAQKgEJVhE3vF3MwBAW+PSj0+dlUD50oVellXzIHs9gyKXhEvCmrAYd4coT0jZB7Kl+KBEw4yczIPUudo5J6nK0X2qRos1EV52MLbu4wUetZJirHEyyPhrYWF2lQE2IZB7vUtoAk7W+SkKw0dbKgiW0DRUmsmMU7eQ+QfyYVsFA1aNJHEcYbyOzI3tl4XPZTA8dS+IbUA89OWzwmyogVS2yVRAAD1hcKVXzFekrB+bip0zMLrAK/4iQvDA3S6M/697zNBVLg4DOxgfUnVonSma89OOMGxMxTTp9J32RWAPPK/4E9skMeLXsQ9gRrJtLQqTuTbgv0osr3wmyYY+gbuMULxSi7Nv5Zvwolp4tmhPw1SBSwNe7lrzp+fJAVCeG0DbIHnYS126ion8aDR3WawHgqGGoP5P4cQe0BmTALUYELwiuf33iw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5677a478-b5b1-456d-5ffe-08dad2c4306f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 11:15:29.4218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1CFJ1M8Vz33C7bbsgO3+0XBJGmeNCqO4Tc01UqGF0u4sg4E8GIYd8qECb7Uf/uVp/ZJBR396Pj+6798bMQPrjpnEWV2uvvkF6Us+BcSevtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0305
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Damien, thanks for the review. I will reflect most of your comments. Please=
 find
my responses in line.

On Nov 30, 2022 / 19:18, Damien Le Moal wrote:
> On 11/30/22 18:41, Shin'ichiro Kawasaki wrote:
>=20
> [...]
>=20
> > @@ -627,6 +631,12 @@ static blk_status_t null_zone_mgmt(struct nullb_cm=
d *cmd, enum req_op op,
> > =20
> >  	null_lock_zone(dev, zone);
> > =20
> > +	if (zone->cond =3D=3D BLK_ZONE_COND_READONLY ||
> > +	    zone->cond =3D=3D BLK_ZONE_COND_OFFLINE) {
> > +		ret =3D BLK_STS_IOERR;
> > +		goto unlock;
> > +	}
> > +
> >  	switch (op) {
> >  	case REQ_OP_ZONE_RESET:
> >  		ret =3D null_reset_zone(dev, zone);
> > @@ -648,6 +658,7 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd=
 *cmd, enum req_op op,
> >  	if (ret =3D=3D BLK_STS_OK)
> >  		trace_nullb_zone_op(cmd, zone_no, zone->cond);
> > =20
> > +unlock:
> >  	null_unlock_zone(dev, zone);
> > =20
> >  	return ret;
> > @@ -674,10 +685,103 @@ blk_status_t null_process_zoned_cmd(struct nullb=
_cmd *cmd, enum req_op op,
> >  	default:
> >  		dev =3D cmd->nq->dev;
> >  		zone =3D &dev->zones[null_zone_no(dev, sector)];
> > -
>=20
> I would prefer keeping this blank line after the "return BLK_STS_IOERR" b=
elow.
>=20
> > +		if (zone->cond =3D=3D BLK_ZONE_COND_OFFLINE)
> > +			return BLK_STS_IOERR;
> >  		null_lock_zone(dev, zone);
> >  		sts =3D null_process_cmd(cmd, op, sector, nr_sectors);
> >  		null_unlock_zone(dev, zone);
> >  		return sts;
> >  	}
> >  }
> > +
> > +/*
> > + * Set specified condition COND_READONLY or COND_OFFLINE to a zone.
>=20
> May be "Set a zone in the read-only or offline condition."
>=20
> > + */
> > +static int null_set_zone_cond(struct nullb_device *dev, struct nullb_z=
one *zone,
> > +			      enum blk_zone_cond cond)
> > +{
> > +	enum blk_zone_cond old_cond;
> > +	int ret;
> > +
> > +	if (WARN_ON_ONCE(cond !=3D BLK_ZONE_COND_READONLY &&
> > +			 cond !=3D BLK_ZONE_COND_OFFLINE))
> > +		return -EINVAL;
> > +
> > +	null_lock_zone(dev, zone);
> > +
> > +	/*
> > +	 * When current zone condition is readonly or offline, handle the zon=
e
> > +	 * as full condition to avoid failure of zone reset or zone finish.
> > +	 */
> > +	old_cond =3D zone->cond;
> > +	if (zone->cond =3D=3D BLK_ZONE_COND_READONLY ||
> > +	    zone->cond =3D=3D BLK_ZONE_COND_OFFLINE)
> > +		zone->cond =3D BLK_ZONE_COND_FULL;
> > +
> > +	/*
> > +	 * If readonly condition is requested again to zones already in reado=
nly
>=20
> If the...
>=20
> > +	 * condition, reset the zones to restore back normal empty condition.
> > +	 * Do same if offline condition is requested for offline zones.
>=20
> Do the same if the...
>=20
> > +	 * Otherwise, set desired zone condition to the zones. Finish the zon=
es
>=20
> Otherwise, set the specified zone condition. Finish...
>=20
> > +	 * beforehand to free up zone resources.
> > +	 */
> > +	if (old_cond =3D=3D cond) {
> > +		ret =3D null_reset_zone(dev, zone);
>=20
> This will not restore conventional zones since reset will be an error for
> these... So you need to do the reset "manually":
>=20
> You could simply do:
>=20
> 		/* Restore the zone to a usable condition */
> 		if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL) {
> 			zone->cond =3D BLK_ZONE_COND_NOT_WP;
> 			zone->wp =3D (sector_t)-1;
> 		} else {
> 			zone->cond =3D BLK_ZONE_COND_EMPTY;
> 			zone->wp =3D zone->start;

I see, manual zone status change to empty status could be straight forward.
Looking in null_reset_zone(), I think additional null_handle_discard() call=
 will
be required here, if the device is memory backed.

> 		}
>=20
> Then the hunk above that set the zone to FULL is not needed, and the
> variable "old_cond" is also not needed as the "if" above can be:
>=20
> 	if (zone->cond =3D=3D cond)

I agree that old_cond is not required to restore empty condition manually.
However, still I think we need to set the zone to FULL before calling
null_finish_zone(). Let's say that the target zone is already set read-only=
,
then it is made offline. In such a case, null_fininsh_zone() fails for the
read-only zone. To allow such condition change, I added the old_cond.

> > +	} else {
> > +		ret =3D null_finish_zone(dev, zone);
>=20
> Do the finish only for seq zones. Otherwise, setting a conventional zone
> to read only or offline will always fail.

As I will comment below, I don't think conventional zones can be read-only =
or
offline. So conventional zones are handled as an error in zone_cond_store()=
.

>=20
> > +		if (!ret) {
> > +			zone->cond =3D cond;
> > +			zone->wp =3D (sector_t)-1;
> > +		}
> > +	}
> > +
> > +	if (ret)
> > +		zone->cond =3D old_cond;
>=20
> There should never be any failure with this. So we should not need this.
>=20
> > +
> > +	null_unlock_zone(dev, zone);
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Identify a zone from the sector written to configfs file. Then set =
zone
> > + * condition to the zone.
> > + */
> > +ssize_t zone_cond_store(struct nullb_device *dev, const char *page,
> > +			size_t count, enum blk_zone_cond cond)
> > +{
> > +	unsigned long long sector;
> > +	unsigned int zone_no;
> > +	int ret;
> > +
> > +	if (!dev->zoned) {
> > +		pr_err("null_blk device is not zoned\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (!dev->zones) {
> > +		pr_err("null_blk device is not yet powered\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret =3D kstrtoull(page, 0, &sector);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	zone_no =3D null_zone_no(dev, sector);
> > +
>=20
> Remove the blank line here.
>=20
> > +	if (zone_no >=3D dev->nr_zones) {
> > +		pr_err("Sector out of range\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (dev->zones[zone_no].type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL) {
> > +		pr_err("Can not change condition of conventional zones\n");
>=20
> Why ? Conventional zones can go read-only or offline too. At least on
> ZBC/ZAC SMR HDDs, they can. So allowing this to happen with null_blk is
> desired too.

As far as I refer ZBC r05 Table 10 and ZAC r05 Table 5, conventional zones =
can
have only zone condition "NOT WRITE POINTER". I think the tables show that =
the
zone conditions "READ ONLY" and "OFFLINE" are valid for sequential write
required zones (and sequential write preferred zones). Do I misinterpret th=
e
specs?

--=20
Shin'ichiro Kawasaki=
