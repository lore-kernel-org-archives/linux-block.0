Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726F9C38A30
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 06:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E0E206D9
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 06:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YZyn1rJk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tmVt3W9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgDVGt3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 02:49:29 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6197 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgDVGt3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 02:49:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587538167; x=1619074167;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oBXu6aNXy/SMRVeqEus2mMOgDOxg3NEweEdNlhs9pbk=;
  b=YZyn1rJkQJq70nP7KT8DRUtJ/Lh1NeOt7T+QNxijATNFBAuG7kQgHKKI
   hJ8Rd3L5sgz7tBck63sMahif+njnm/Z2el7Q+fLAOTfk/NBzopaVkV30l
   dGnmdka7tLq5BAgdQlZbehFFSzwmldZO02kzRv0ZTRa8/VKBb9W/W31V6
   jPJ1OSPpQJLXAdVrYOEsaxTSW1a60B8CCTQyethTYJxSxZ2ZEFBIqX4kE
   nBZzwhwgQdL4rGDbi8f/r1+u5uWB6FAELoxxjCmNL66cTtpWShhtkHt4M
   fEJopme37Ew2jjtpADuSi3Oj1E/oa8bFujxjGe+owQLW+vaok9akUSVnz
   g==;
IronPort-SDR: ow//36sP/052KgivS16CiqOWXQjMCAjRo4r3Ex9AXZOCXdd+HkK9NAr3CMnSdtCrNsSa3Jl8A7
 oFWo3reujSqeIBQ6m592om3hZ+Fht0AkH2e6tuO0Pn6wSmn34dIcogLBPhTMt5c7VzjCZqPWA+
 TR6WYkS8h1tVTHDZkIfzv3gT1/jAgMotYaxlMV+yAbtoUjafkohdy0lLG5kNDML3b5URnBOKEe
 f0HM3GWdTzdvFbHGphNyZSsmSP//73xici9xU/fA6Db4LVemJ+QIumLx+pYwLYh2WbakONJHEx
 KWA=
X-IronPort-AV: E=Sophos;i="5.72,412,1580745600"; 
   d="scan'208";a="137286132"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2020 14:49:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFYN8CPpmqvN8zTbtWmjwSSiBhnm1v71c6nkbOxAT86gOCcyVte9+nt+Wm+h4R8fiOQKwg0Wero9ubghjWX4kO1hFD/Iw2Dq8dGR/JvOByKO1OOX/qvsizHbHo9s6bEsEp/zKNmvHh9bwkOEdBQ6KapVggKZ+IwP0RusAMF7UJOgDboXEfN3yQ+zpH+sHdhI0ASRdUTs3w4aXOkYN+srMil1zsjTL8i4T7bWHVitOcP20venQ2v/ecaGczWK2WuH8cRj8oLsgtiVO94HQmjBym/mHTwA6H9DQ8mLRScCzSk1KO0hZ+MfiowRHMUcukYT+V+cgJs3xn2Mliat6M3MUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRSzXDGRTg5YYId93qyjrosuEy3M2wHbLOKhup0uHhI=;
 b=VjwfT0/28wlLZrK1eZqlmtjU3k881gSIn2PWQzZIoOQyinIvczEq/JmM7ItDCRo5YefA3/o41gTu40u5h0TcTSOczkbCcShVj4ANa0pCEX25Kv3MUUTu4gtT6WeKPXMWBzNtEjvNBVh/PLnt+MN4V9a+6sbCZix/ZUqQ2NGRmzochnU+12bDeiDHVNL9FI/fl/foZ5zGYRHdVBC2DaLi3lROZWnGPOz0iEFTsrZIBGMAY1+K+d2P8EljO9WITSFnkLnOnB9ZWxRKejbw4EyhNKUUFhSAgvY0j/d99/2BpvT/EVRvxN1jHRKkQq2grgsTIq9IIsE3U1kK3J8QmqjqdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRSzXDGRTg5YYId93qyjrosuEy3M2wHbLOKhup0uHhI=;
 b=tmVt3W9Mi62+w4rFXRWcgrWK5brF3yDTUZcADUhAW7/XdgHG2FbGLhY6w4r5YBWIdsNp/EVk1A8UL+wGVVIl4ykXdtyUffXuUBujgtCwi31goZS6fggQMnajTgmPfDpI+EtCVzkWPnXo18RCLh+4WsDW4ZTpvoxOu6Pid7CxicY=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BYAPR04MB4663.namprd04.prod.outlook.com (2603:10b6:a03:58::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 06:49:25 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::f555:dffb:9f17:7d35]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::f555:dffb:9f17:7d35%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 06:49:24 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Klaus Birkelund Jensen <its@irrelevant.dk>
CC:     Omar Sandoval <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH blktests v2] Fix unintentional skipping of tests
Thread-Topic: [PATCH blktests v2] Fix unintentional skipping of tests
Thread-Index: AQHWF69CKwO0zD6OTkGNF5Fz4okO8qiEVukAgABDGgCAAASzgIAAFjwA
Date:   Wed, 22 Apr 2020 06:49:24 +0000
Message-ID: <20200422064924.3f57azcl6tsdlhsk@shindev.dhcp.fujisawa.hgst.com>
References: <20200421073321.92302-1-its@irrelevant.dk>
 <20200422011250.bsl5epjclhri4fqd@shindev.dhcp.fujisawa.hgst.com>
 <20200422051300.w2efeam752fa56ew@apples.localdomain>
 <20200422052949.z4pcqzhvgtpaqmhl@apples.localdomain>
In-Reply-To: <20200422052949.z4pcqzhvgtpaqmhl@apples.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 51121bf9-d625-429a-2555-08d7e6894b91
x-ms-traffictypediagnostic: BYAPR04MB4663:
x-microsoft-antispam-prvs: <BYAPR04MB46634EF7F459F6677B10FEC5EDD20@BYAPR04MB4663.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(66446008)(6506007)(64756008)(66556008)(6486002)(26005)(66476007)(66946007)(8676002)(2906002)(9686003)(71200400001)(186003)(44832011)(6512007)(1076003)(478600001)(5660300002)(86362001)(6916009)(54906003)(4326008)(8936002)(316002)(76116006)(81156014)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQOz0+R3TjnfGvcgzne2pkI5IhhA6b5wc/Tu5P+ASUfDH696qWian6559bL5MlTTwgdclW27QWSnXiQrdiS1ow4L0+qxp9HntX/ft5iu2mviDZENbJETT3+4T7zZTRETtd/PKDyyVKZTXWEB0UrhLFo7axp0zbh6gTrVBKIRlrmq6FvW4ljn/mqkUoCVBTrdCuJGdhh20J/vXyERu/t0jNhj3jw+CPC0QbbhtMv38cJLWO+aQhpFw1BCmeExQG0zqLxIyIk0pdzqFhyo9qEzDfoziBLR34LiRVhvXxC6dnx51FTRhh1WbpktH/FLLcjo7YKLApGmEcLCwf+VSDgJ+cRBde5Ves1Cz+kJTOlQ8G8OTUZDHHdXSEdZy5DfmiTeJCJjRkZHqt5+oB+La7Ti8zosespeALJTsJxl+L7eHJtXp9GqrA7UyI4Fcs/HCI2d
x-ms-exchange-antispam-messagedata: UHim8KPix3yeJOM8D4y6mulenjfIkSVM5GCQarn+qVxcNMOJbFqs2LYq6u5Ts+h1rS8GHDa76xwWagJ5FlZ8dCx/Anq0fqZuniU2PLhJJ3hh+EO+OA+85SSODzOqKdFuMugkHpqXgHD/BIGDS82HIQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47493942CB961049B6F62769993DF14E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51121bf9-d625-429a-2555-08d7e6894b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 06:49:24.7057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EWr2Y3VLMY0S/II7THg8WxknPRYlelAEs1dVyQlAkADKhZ5f3DedM2GUHRyPfyNLpEFa+OU/3+2WSN+5tlOZiOP2NsZomvp20ZCoT7ZKF3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4663
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 22, 2020 / 07:29, Klaus Birkelund Jensen wrote:
> On Apr 22 07:13, Klaus Birkelund Jensen wrote:
> > On Apr 22 01:12, Shinichiro Kawasaki wrote:
> > > On Apr 21, 2020 / 09:33, Klaus Jensen wrote:
> > > > =20
> > > > -device_requires() {
> > > > -	! _test_dev_is_zoned || _have_fio_zbd_zonemode
> > > > -}
> > > > -
> > > >  test_device() {
> > > >  	echo "Running ${TEST_NAME}"
> > > > =20
> > > > @@ -25,6 +21,10 @@ test_device() {
> > > >  	local zbdmode=3D""
> > > > =20
> > > >  	if _test_dev_is_zoned; then
> > > > +		if ! _have_fio_zbd_zonemode; then
> > > > +			return
> > > > +		fi
> > > > +
> > >=20
> > > This check is equivalent to device_requires() you removed, isn't it?
> > > If the skip check in test_device() is the last resort, it would be th=
e
> > > better to check in device_requires(), I think.
> > >=20
> >=20
> > I did fix something... just not the real problem I think.
> >=20
> > Negations doesnt really work well in device_requires. If changed to
> >=20
> >     ! _require_test_dev_is_zoned || _have_fio_zbd_zonemode
> >=20
> > then, for non-zoned devices, even though device_requires returns 0,
> > SKIP_REASON ends up being set to "is not a zoned block device" and skip=
s
> > the test in _call_test due to this.
> >=20
> > There are two fixes; either we add a _require_test_dev_is_not_zoned
> > again or put the negated check in an arithmetic context, that is
> >=20
> >     (( !_require_test_dev_is_zoned )) || _have_fio_zbd_zonemode
> >=20
> > I think the second option is a hack, so we'd better go with the first
> > choice.
>=20
> Doh.
>=20
> The _is_not_zoned version would of course just cause the test to be
> skipped for zoned devices instead.
>=20
> So I actually think my original fix is the best option here.

Thank you for sharing your thoghts. I agree not to use _is_not_zoned versio=
n.

I think _test_dev_is_zoned in device_requires() does not need to be replace=
d
with _require_test_dev_is_zoned. It does not check requirement. It just che=
cks
if _have_fio_zbd_zonemode check is required or not. Then, how about the cod=
e
below? (_test_dev_is_zoned does not touch SKIP_REASON.)

device_requires() {
	if _test_dev_is_zoned; then
		_have_fio_zbd_zonemode
	fi
}

The above code is equivalent to below (less readable though).

device_requires() {
	! _test_dev_is_zoned || _have_fio_zbd_zonemode
}

My suggestion is one of the two above. Your original fix also works good, t=
hen
this suggestion is not so strong.

--=20
Best Regards,
Shin'ichiro Kawasaki=
