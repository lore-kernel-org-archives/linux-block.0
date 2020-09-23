Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28302C4363D
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 07:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF49021924
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 07:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qr0oUyWD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QemCjlRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIWHqw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 03:46:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:55369 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgIWHqw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 03:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600847211; x=1632383211;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Kuqy8iNsBi9Voy9ePmKTy3xHwuu+Ew87/eK8frFsh2I=;
  b=qr0oUyWDo0SDs3OH44X3m05z5U8EDDmcz6/nOQ6pFy13QV1xg/GT7hNo
   FgE/B9xBnD0sZknCZEZzYDWGEynd6YUtdU+XIqrY85z4c/6bAf/JQ83SK
   DxxQeQ6S+HAx8esFPlvXIHYGxS8m06bBai/xciOGDo9Sfo5MJCMqtRGtm
   vjSr8MvALaVr5aQFNGC3sVXpJF3Y9BH9LQrb44e4+5iTPzN3YSHH4pfhF
   VQ2bgrawbQnFBqKpi0j0PN1N6C0VlHconZbyWDKoGA8ESzb2YJ/vgvV5e
   1RcyKCJxRS4jomEzkIMaLFdHkWSwe5sMSR1XJQ+z6fat5uqFR4xD1yhkK
   Q==;
IronPort-SDR: 8o4X2MhmNedNwatHp0CQBp96N9BP5anpSoIb71Y+2BeRy/Jfj3e2Q3XG/uQeFv88Jx4YcJupKd
 oGpM9x0IZ+ClTcDrF/NehHbrnoEsxAm/yHPykt0VfQ+b1oIap2JfSNJvH2sGNZBa6HHVHuuJJb
 Z5P/jPNjkzWs0Jxl+D7fiLrtNXl9L1KhBuZeR2gNOpwAOVPGjgp55cGo2CGsLpFIvmUdPwrWSL
 4KINk1ixctJ/LzK+peAYFE9bRQHP1QBoYLp/qUBHDixx8LBP80q3tOY7YmF2v9b/PBIAVAaWo3
 +Hc=
X-IronPort-AV: E=Sophos;i="5.77,293,1596470400"; 
   d="scan'208";a="152435394"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2020 15:46:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co9kN16IQLJ8Jvxxj6OEDqjwupmEZc/6zVb5YdmewmBuQrWjtraDTcAbIRd/CzythQlTnfIGDWwy453/Ac7U3L6XT4vsGQtG/iM4aLxbKrSRBnCJZUxxYfoQguXUbSqRFJvXOG+4oN6ORtqNy8/jILjthngsEScLuVgoPMFkuyOrc462sxQvTKwmz9xKEeaAF2WuMSDIR1z/BBj8GvSnx+nNoEVe1pN/S8t5T/sz54qSi4h2HzmSj2pwnxsDq42M9BpS5C1DkNOdctRtWvggc6IqGppN6JorkL2NKvG9Lgw1tmcJgleza/YWsJedph8z+sAxCyjuLfeW/vp4p9Hiew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKdXc8Fo3RX+bvAKb7uGvOXYkbxmONFzteatNdxREYE=;
 b=UHi6I6RME9/CWNwZlbMK/hTuJ4HI5q+L/bY23YrckJeKi+hdwkdJP1xv1KlmRCsHs9MaGz95Tgpt+vkg39BSnEVtqFujBl/E/RPhj2nLFggdgUXyfcmAZALPW2D9uaaFVgpwZAJPdKg11RPVjygwNmf30M76Q6SHhQvvRh0/IgKUYK+44mnd8Ch/fnTZ7/XwuwYKSReWuwfoRl1qN/cZxxgWrZz4YWcR1RZAQ9erfomkFr9md/LuLrpQazmiXtiNgrk7A5QXKoMJBkFBLymu5YAbJXutzuQjWoAvsx2+vx1k4EG1Q5KLO8EKwYKzrN/51iJSLqkInSdkaSQ6vEjGqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKdXc8Fo3RX+bvAKb7uGvOXYkbxmONFzteatNdxREYE=;
 b=QemCjlRRnPYEyVzn2gOmrjevQW4hW7AUvijpjMoLXvUnm4L0dYrXaVvNmf8Bka7dw90SEC6+e5No1GitShrCt8ZF5q4tU9B0R355gXcAjMXDomvyAzIbDGlF03kcHhAPPGFB9h2/NVmISk0eIfoGlPeP9RhlqDdcY/hBPmudS+Y=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5245.namprd04.prod.outlook.com
 (2603:10b6:805:103::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.17; Wed, 23 Sep
 2020 07:46:48 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.033; Wed, 23 Sep 2020
 07:46:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Niklas Cassel <nks@flawful.org>, Jens Axboe <axboe@kernel.dk>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH v3] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Topic: [PATCH v3] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Index: AQHWfSmaV4Z1Tg4VL0+Dee3d19pWQg==
Date:   Wed, 23 Sep 2020 07:46:48 +0000
Message-ID: <SN4PR0401MB359871B467B7F5FDB3115ADE9B380@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200828105400.80893-1-niklas.cassel@wdc.com>
 <20200907081824.GA260080@localhost.localdomain>
 <20200917075647.GA20845@flawful.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: flawful.org; dkim=none (message not signed)
 header.d=none;flawful.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d1cf75d3-ed2b-465b-bdf7-08d85f94d3a5
x-ms-traffictypediagnostic: SN6PR04MB5245:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB52450959156B0EF70B7534039B380@SN6PR04MB5245.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hRry124EyhMO0mt3Q2VKguV/epxYcMHCTlvtlUn9FM8qwjvaVscQWlVKFr0sZ4xFUXBkE1icCYVHwfwb+ojGG81KaO/w9FZfFctS/SJxm4eYnqNZQR17PuF76kBCB8GhXo5HTtD+NQBLejHnQJeFXXFEV0OICtjMVZg3tNWexGGnZdWk3C0uIDeuUdpR/tOYTxT9GGOaHMLpB8noZpP+GdZY4mxS5R1pi4Bxe3ig/yj3s2v7tEdTvpd6Ht6tMgxqlbocJmB2f5tnrL2brbWAybM7M1ZiK8rYYMIvrghE94HSQvdoSQ1A0gr7Pwz/fdyog48cfcQCGZUd/8xg630kNKF/7hruLk8B0T+xCvyZoTclIjbPC7/Dore/hhua1dza
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(366004)(136003)(66946007)(66556008)(54906003)(8936002)(7696005)(4326008)(26005)(478600001)(186003)(2906002)(6506007)(8676002)(76116006)(71200400001)(33656002)(83380400001)(66476007)(66446008)(53546011)(91956017)(52536014)(64756008)(110136005)(55016002)(5660300002)(316002)(86362001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: C/v32zyleOL/NZMijx3xHWjU4uNleNlOS3qtQqW0XT2ChOoCzd+FT3agl3v7uy0lKVhrwGlit7PNl4dhww4LQYkDfTorKluTmrP+/nhD+c7kegRHAFulRSQd70fWo1jYg9SnRlgDJByPrpi50BZ6hfFo1pd2UYRqDfdV9Ir41ClWQQ7+yuMIrLUbRnDO4ceFg+cW3gWtDcSwxO3AxqRhWwylRAU456uhZXVQ4oYrGJ779GdYN5VPBJaxdIvBQQGE4PmJaUe8EfT6Lq/0HqAHffNkG9TmADDKsi+dVHQqAeVF9TbLiHV2C+YHDCHtjVfiRvLK1X3ljHtl1tiPwwegu6maAltOmGMFrOcSc3dgUXb5kzauUyJfc3+jf7TKJCk56dU3Zjx81tNj48ojG+Kw3KvnwvOXpTcwcwet9eABGhdOd+xWA8+KTGz8sInWmRhepKRBf9ToPkBVbPeG4swO14V9j31L3X47pDkOO6kpspgC3F+17NmS+fKUHxKWY+hc/bMgMEftM7Hmqego8n4q+3kXJbc7tlwl3MHr0+WHeMlHCbjZMhE5+0ZbXgXuV1G4xvf7wq0wsetdR7Jq6Eg0IJ3opF040yGIXaT+SNuk94QuhWlrpIBTlsZHWMYFOHVwodyxo4f7sl7gtursH43WlQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cf75d3-ed2b-465b-bdf7-08d85f94d3a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 07:46:48.2439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1Lqjx6gyJEvJbMW3XPFygNlJeZ9N9GYIzqZBXJWWRBxZ9HXNzoMiw7gTlbSqiX77VOncRan7agsnLIe3RBH3wl2dwiVRJjf/C9d4hrccaQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5245
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 17/09/2020 09:57, Niklas Cassel wrote:=0A=
> On Mon, Sep 07, 2020 at 08:18:26AM +0000, Niklas Cassel wrote:=0A=
>> On Fri, Aug 28, 2020 at 12:54:00PM +0200, Niklas Cassel wrote:=0A=
>>> Add support for user space to set a max open zone and a max active zone=
=0A=
>>> limit via configfs. By default, the default values are 0 =3D=3D no limi=
t.=0A=
>>>=0A=
>>> Call the block layer API functions used for exposing the configured=0A=
>>> limits to sysfs.=0A=
>>>=0A=
>>> Add accounting in null_blk_zoned so that these new limits are respected=
.=0A=
>>> Performing an operation that would exceed these limits results in a=0A=
>>> standard I/O error.=0A=
>>>=0A=
>>> A max open zone limit exists in the ZBC standard.=0A=
>>> While null_blk_zoned is used to test the Zoned Block Device model in=0A=
>>> Linux, when it comes to differences between ZBC and ZNS, null_blk_zoned=
=0A=
>>> mostly follows ZBC.=0A=
>>>=0A=
>>> Therefore, implement the manage open zone resources function from ZBC,=
=0A=
>>> but additionally add support for max active zones.=0A=
>>> This enables user space not only to test against a device with an open=
=0A=
>>> zone limit, but also to test against a device with an active zone limit=
.=0A=
>>>=0A=
>>> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>=0A=
>>> Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>>> ---=0A=
>>> Changes since v2:=0A=
>>> -Picked up Damien's Reviewed-by tag.=0A=
>>> -Fixed a typo in the commit message.=0A=
>>> -Renamed null_manage_zone_resources() to null_has_zone_resources().=0A=
>>>=0A=
>>>  drivers/block/null_blk.h       |   5 +=0A=
>>>  drivers/block/null_blk_main.c  |  16 +-=0A=
>>>  drivers/block/null_blk_zoned.c | 319 +++++++++++++++++++++++++++------=
=0A=
>>>  3 files changed, 282 insertions(+), 58 deletions(-)=0A=
>>=0A=
>> Hello Jens,=0A=
>>=0A=
>> A gentle ping on this.=0A=
>>=0A=
>> As far as I can tell, there are no outstanding review comments.=0A=
> =0A=
> =0A=
> Hello Jens,=0A=
> =0A=
> Pinging you from another address, in case my corporate email is getting=
=0A=
> stuck in your spam filter.=0A=
> =0A=
> Kind regards,=0A=
> Niklas=0A=
> =0A=
=0A=
=0A=
Jens,=0A=
=0A=
Any chance we can get this queued up for 5.10? This is really helpful for e=
.g. =0A=
the zonefs test suite or xfstests when btrfs HMZONED support lands.=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
