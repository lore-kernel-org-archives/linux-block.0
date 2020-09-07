Return-Path: <SRS0=p3ox=CQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4480EC2D0A8
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 08:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFFFC2145D
	for <linux-block@archiver.kernel.org>; Mon,  7 Sep 2020 08:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lNUoAk1l";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xVifmo3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgIGISf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:18:35 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12899 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgIGISb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Sep 2020 04:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599466710; x=1631002710;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Bwy6NJ+FQINbbJTjM9nYUqjqhBh5epnoA6wDjxYm2aU=;
  b=lNUoAk1lUoTwCZYRCiA5XpAy5MgwwaYapAF6WizasP9mu9at54iPtjMH
   xBJG84ichv4eum8Ct1WEMjR0KeF43nbXU9PkBh5mHHXYX3F/t6MzxVDxt
   BSjZEppISrWSpYaGzwx1qByacASbHxu+4ma3rN1v/DNOKYiI1DXGq5EYx
   V6j8vVJ2GeNihdVt0oFyfaJUc5XGf441y7ETYAT0kfV4MF2TZWcSpESj1
   g+Z13tKU2bKIGgj0J4aIKKNKVck+fKSae5rihcKRFDjaeOFvjVmYLCeM2
   F2z3EDkhOgqs2pa0P1WHDLvj2tNscO4pE6EuY8wX3sC0LOC2C3jLgRnHM
   A==;
IronPort-SDR: vlknauIbP98AK81tZpx5VvAqkS+og/8BhPTc5aOEloUZWG4GCirkX6ckU+6WwNNMmXguqJGRL4
 kpAj/nte1+zqHO4gWIoM5hEv9+PziPBW874dmR/tFx+pAZHHLpXlnagOzcygm7XUQkm1PkGOWM
 5QUWu01VIpfoqRip9ZrVqxZTY93vQ47SW2t3lrSI7yNMu4hbH6CYu6IWLLOT8CLtqVxbfFLBQG
 4bWk4x5Ii0QgsUZEF8pN9sKujbEMtcp+IiNugmHn9/QRNDs/+ihoY4Vz+zJSH9Gammnu/f7rJk
 u78=
X-IronPort-AV: E=Sophos;i="5.76,401,1592841600"; 
   d="scan'208";a="256290911"
Received: from mail-cys01nam02lp2050.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.50])
  by ob1.hgst.iphmx.com with ESMTP; 07 Sep 2020 16:18:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDBoMB1t1294jsJItYWSwVOaOhdzcLzBKdSUtf5PHRlV+idUijZKwbGEn2REz+o8mNoobJd2SDrC/DjGIqhGXz0TfM0ezPIcWONgr35LmpW1atIHFJADUOnLCk4Lk1c6iz9SaaWOdDKtlwF5pna5Vvttff3WUJDMz5f9chmPbKLsHRAmhn8d+o+QsjfZma/1uZwXTNv/gbRdWX9UY7pqxp4MCLGql1zlngVlY7tpVJ8oDTUOXdW9agFqdR8zj/ly50gBjQxxLDk8g5ElFo/xM/TNTnf+tEchDUNM5IuLECn1TUt5T6RxhrUibw5SxEJ75eGsCtppkJe3+noGFJSwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVdhC66mySjoMqtMQW3uYABHxBlQl8oqQyQiVXG12jA=;
 b=cXoKcHdZUabnc0JVybS0KfsWxE2y05B3JY5oy2eJQcB0VfIdu+nJN1zRkGl2KAM+VHXqfSx7Cxlq9ASCgzzPD72/hHukFeNNw2KGH9TbPyny+AzQgRYClYbNbKeBjw6KqhjsBnb2RYYDfhAgCT7XzBSq2JwHBTYvmLTt7+luEgdS8eibyid9+O4PVl6VsVjTI7oaB+e2rCJL+dRf6BtZry9LFHuMJEevaJ24J/+k3UJXqyI89sQgHJvcYoe7VcyQ3w6Rel3/sh4cVtETRhyDOWaEU/0eyR+pEsf2ZDjANsFmdfcH6ktnvPatNpgpzPk8NRz7Zzyjn8CDDEIPhFUNlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVdhC66mySjoMqtMQW3uYABHxBlQl8oqQyQiVXG12jA=;
 b=xVifmo3eDFdbaOb+/eQGoejKducKIsfTmVEaOazivtROSPGVYQKH+DRVITDbZBaPoGkt6L/ETpu7o4y+MaoziLcJwNPhtORP7VWpSsdE1+WTU6fBtUlafK+53rzJOJ9SjU5cFJMXb6f8GchPdPrUDCX6EDEZCzVhz8XYC6llQoo=
Received: from BN6PR04MB0724.namprd04.prod.outlook.com (2603:10b6:404:ce::23)
 by BN7PR04MB3971.namprd04.prod.outlook.com (2603:10b6:406:bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 08:18:26 +0000
Received: from BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::1a1:f188:57e2:1e0c]) by BN6PR04MB0724.namprd04.prod.outlook.com
 ([fe80::1a1:f188:57e2:1e0c%10]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 08:18:26 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Topic: [PATCH v3] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Index: AQHWfSmaLTmCYxbnp0e4nXLEl3R9Fqlc5JUA
Date:   Mon, 7 Sep 2020 08:18:26 +0000
Message-ID: <20200907081824.GA260080@localhost.localdomain>
References: <20200828105400.80893-1-niklas.cassel@wdc.com>
In-Reply-To: <20200828105400.80893-1-niklas.cassel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.243.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44c0351d-dc14-41f0-a16f-08d853069861
x-ms-traffictypediagnostic: BN7PR04MB3971:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR04MB3971B8E29B706E513A80231EF2280@BN7PR04MB3971.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nn9YcNS53uh8I5+LS8WLa8RZgAz7i4L4oZP9C1QdXkv0/FfTuNAvprgVoarpk5jj9pb6KkBvpTSgQkxCcx55AfZjhZDyywhGzxpNN68YT056dkgY54p8FNyMP1uvWhwSP1mtd5AjUyO9eRHmB6JAbCbff50tv18wYGxTLfTM8D+fbbyGCBg+GsESPdbk/S+D1CNWUzcYyM2zi6K2uF0Of3Zfuszj/V5Zy7kgO6BF18oh67UMeIFFectcq3V6mr6VbUfy7iwbeP+09OrFGE0FELFAehxqjEk3FhjFZDZD6m1Y3JCh3+GTnugkaDGJvrhv8m36YL+wiXKnTmkDF7Ld9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR04MB0724.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(54906003)(83380400001)(8676002)(1076003)(2906002)(6916009)(478600001)(316002)(33656002)(5660300002)(6486002)(8936002)(26005)(4326008)(64756008)(6506007)(66446008)(66946007)(91956017)(76116006)(66476007)(66556008)(186003)(71200400001)(9686003)(6512007)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HbJ5ez/fIYiVpw1nvnMErkAQljLP51YGHTqXxDDuuJRoRaOJSKzF9DAInGjUSuXAPsjNrHyw4f44BIG41TNgbcnqUOzQuYRB4OIUEfG2WFCM/SNT/z499dybX8Vbd/HiDcbPUYsGhbTri/1V0HEOs2+++8wmHnk1fATyIC4rnp8OR7WptVmY1Z1RHDJ4SYh4DiEhdq5RhWCS7xDYyefQiKnwm3dRumMqof4UPvrJxvDBSaKtJd9LcTIRJSPY+QT8uz4KJYbAE/uY2GHRzf36MpQzAEM8AVgZDwjn15YZqC7gaxBblnzbCUh8Hkc/XWspzW7diSM9X4ZN0UpWBHSzerxmCES/XfoW4+H6pOkxiGvZOSiNXozJ7x33oxwxjjmrptvxMZRaVRsfN4Pfxj9Q/sk7Jde/qQ2wkZMIyzelSmIb41mHm/SDH8OptTTUk9p1JmpTHAJAy6W86glrUpohE0WBehxdTacob0EuA7mIw9aFz2v48Nke24nz/mH6ibgGCsLNBa6X3sO/5VOSS4CT1PKF3Q28bmy2mehE0sfIQiv34fpRgHfZbUAZkTiKFVtPKi2VzTHVM4rTioZL0JAgwJPIr+ftV5b+NiEy/IDvUhtwJ6UAexV31SkIuYWFnb7cvhNC0OVaktmanx1IxJK+6Q==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC982DDA9665B345872552FD459D587D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR04MB0724.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c0351d-dc14-41f0-a16f-08d853069861
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 08:18:26.2320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Zz61/ABGNcgRR5WJecXTi8DxF0xH9r6mwT5xunS1aPCDNI+x7W1tql5ARn/tX92erb1ZzXysXvL8hrOXPlJrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3971
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 28, 2020 at 12:54:00PM +0200, Niklas Cassel wrote:
> Add support for user space to set a max open zone and a max active zone
> limit via configfs. By default, the default values are 0 =3D=3D no limit.
>=20
> Call the block layer API functions used for exposing the configured
> limits to sysfs.
>=20
> Add accounting in null_blk_zoned so that these new limits are respected.
> Performing an operation that would exceed these limits results in a
> standard I/O error.
>=20
> A max open zone limit exists in the ZBC standard.
> While null_blk_zoned is used to test the Zoned Block Device model in
> Linux, when it comes to differences between ZBC and ZNS, null_blk_zoned
> mostly follows ZBC.
>=20
> Therefore, implement the manage open zone resources function from ZBC,
> but additionally add support for max active zones.
> This enables user space not only to test against a device with an open
> zone limit, but also to test against a device with an active zone limit.
>=20
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
> Changes since v2:
> -Picked up Damien's Reviewed-by tag.
> -Fixed a typo in the commit message.
> -Renamed null_manage_zone_resources() to null_has_zone_resources().
>=20
>  drivers/block/null_blk.h       |   5 +
>  drivers/block/null_blk_main.c  |  16 +-
>  drivers/block/null_blk_zoned.c | 319 +++++++++++++++++++++++++++------
>  3 files changed, 282 insertions(+), 58 deletions(-)

Hello Jens,

A gentle ping on this.

As far as I can tell, there are no outstanding review comments.


Kind regards,
Niklas=
