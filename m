Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6334AC433DB
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 23:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FAF4619D0
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 23:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhC3X4W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 19:56:22 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29587 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhC3X4I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 19:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617148568; x=1648684568;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=vNE01DwTp4DW8zrfISVMR4/OXvWocJidqUGEjMgnpKE=;
  b=KiyTXbRkvbhJt+P0Wt6prkXF/GG29GYdX7VldKuwZK7t5joRAL4K5+2g
   UX20oak49hYk9Zr1acOnvMIrMWWCboPiupmSeRys2esVvDWq0TG9xhNI/
   DxJ31DygU2AD+pqTSGgany2fBeGNV6QWtlxbIc/Dvz0duZLjwlLYBhU6r
   fFabKvlYE6xkHUMi5TuDrl4ruMnhrr/seIsD9PF1khKWEvke4rPQ+mMKS
   aIZKHFqOhxpkkfnz8PrGwVGsVN/1pYB7o5cbtvhbjlUrbYGQBxuRWNjLo
   wJ+fmdpWRVOW14KdoVx33kl7EsJvc+chMEaR0L1Bn4qO2CMa6B67DDH8w
   Q==;
IronPort-SDR: SB7nggZ0FvFBLcseBzDXn+eSQtMAIntqj+kRo6jArEEeHBpvNqkgVByFx2PeURpG1aSXHor+5h
 /bnX8m2H6dDP6nQIg7GhdnMGdojEUsjs0IScSPKSqdfxZb3m06WQvySVLPmuUbeeeFPEnMiScw
 g2pZR3IrdWATDO7buxfE1srPrlsVbVBpj8BUp3llRVs1YuQO75AADXivU370j+lrEXSyhQrt6j
 uWyG4cxS2LAu5YoGmYNMTr24fpmkxbQHhPD0CX20sQaaP7nH/ho1nZOrk268nFbyD3mDouXF/9
 vko=
X-IronPort-AV: E=Sophos;i="5.81,291,1610380800"; 
   d="scan'208";a="167868801"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2021 07:56:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMb81p7ExI1I9liseOgquQ7FPj/CYAGRGyHwcPyBoO4peWvwbSn/58IxGRAwFKsEfnojTO3DVlf4HNoBAjJZdaTXt/fBnZidwwXsAIrpK/kQcGqdB1zI9tlroSio0uVIKtcA8ytz9ENa9CEGn6g2efNWd1DyB/sgl/DXLPEz2JcV0zxNQjrH3Rnrip6YezUmkWZovw9p8u0B0Z44S0/59WbpPF8s/yO67iNZc/ywmvcAYq6vbSMOp8vtWMjw/96cvXA03o9XoEtXeh+5APRg5elqR54/WJuEX6B5U3SvmXm2sFNy8+G9TTuh9a75xmkOdl7MbpckwIPjfWAO32nBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNE01DwTp4DW8zrfISVMR4/OXvWocJidqUGEjMgnpKE=;
 b=I8Oqq1Pr3RGJOTLIRlDA0Eib3T7r1z/Lm+FYiHV1Vv8nFMZFavqnrOdw5tqqLKFNOkFrSp7X9UUD8ThRniNuEy4txBEGz4FRyrMoJMRSB6IdiCq1Natvv+9v3a/ygyRr68PZvxN8iptIQrWQjmgwPniDRmHVGAH0v17jLqfQ7sEuu4ZUWiin7WA5c2bP8mC/rgBs2/dix1+nku6MGTZNI8HMSlFjKpoPxU/eM0O44wB1fF097lGAhz8R2ca+9V93RvhM9pDJxgVYrL8wV0efvW9RI46NFzGJH+0iKyAwWzlAFjNfXDog10u+yEEhEuJboab9UAspi3VCUt0Ehl7Qeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNE01DwTp4DW8zrfISVMR4/OXvWocJidqUGEjMgnpKE=;
 b=ZqEzFfnqSUjqVvpXg+mJFLNHLdEOKYzVgtS/rqNa3Fb9eoVQD4jhNqttGCywx0yRrb8JxDjFC0HY1JeGQTbKff7yQR1eiM2ZDypM05FoCbP5ltkw8SqlRM2KoUs3drOj8GzisJPbtM5bxPtMxHkpV2CSW7LPOUPLB5kGfQck8xA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6424.namprd04.prod.outlook.com (2603:10b6:a03:1e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Tue, 30 Mar
 2021 23:56:05 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 23:56:05 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Gioh Kim <gi-oh.kim@ionos.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "haris.iqbal@ionos.com" <haris.iqbal@ionos.com>,
        "jinpu.wang@ionos.com" <jinpu.wang@ionos.com>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Guoqing Jiang <guoqing.jiang@ionos.com>,
        Danil Kipnis <danil.kipnis@ionos.com>
Subject: Re: [PATCHv2 for-next 11/24] block/rnbd: Kill
 rnbd_clt_destroy_default_group
Thread-Topic: [PATCHv2 for-next 11/24] block/rnbd: Kill
 rnbd_clt_destroy_default_group
Thread-Index: AQHXJTfTtNtPhUdb4EyGHKqmKCXPqQ==
Date:   Tue, 30 Mar 2021 23:56:05 +0000
Message-ID: <BYAPR04MB4965DA5A61B94CC95DDE82E4867D9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
 <20210330073752.1465613-12-gi-oh.kim@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ionos.com; dkim=none (message not signed)
 header.d=none;ionos.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5e9441e1-b0b7-4e24-f864-08d8f3d761b6
x-ms-traffictypediagnostic: BY5PR04MB6424:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <BY5PR04MB6424BACCD83AADFA76F95281867D9@BY5PR04MB6424.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:478;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RaLnP+bKlmkLzL/IxP+MtOLIBTItiOR4W+3HhMzLQWaNJw2K67IjIvc5uyNJkdZoQfjCPSLuMOLcIIO7gZhqw3OYMDUEi0IgMfX0ciOAiHkmuDNE3TnRLFIq0TH3A7ptTN58smMT2LpmjSmS9Hd6hLNnzJfg3Lud9+gFQ0uTeAs7GdRr5f3uismLaS6h92lkz8JYkC0BqEqgaT3ZOzWL3TqGKbUu3mArSb1e4wiPgXoNIAlMt1M1au5thWaG1N0LEDO6dgSKPdxgILijCDqkNFftPHEdrsiwinLOgvJeLDJa7V3yjXYI3sti2KechG4M/4/SYnnS8+uLJe3sVHt43CS5xd0FQ99F0iKqUTa2uJ5AqSYbyvnUpKZ+uHTJmBrzuhTuy44QMBYXiHURZLrg8IYJQooRZ/YvZkQhQdJcq/1k2n11IsbZuE5iE1/BD3ERcI+l2YiFwZG1ib+apNoNWF3gsfRaD7LkmdUPwBoH+M3XZLiZK6ovHn7dINAXUu0/FRmhAdY1QZXaqhhcoScfD8YRAMME/dZm3SlQ7PE7SYuSPfya7VqU79QJX2w+yVavmyOdk5Dl0pRcaQpl9rVfgiKTCHTGhgDJLqfkqIS+7lyGJi2TLZNv68lUjP0Mqefsm1/BeOy0qCy4z6sZWRjoL2IZV6owZ38bUrYAWF7aHd4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(478600001)(2906002)(5660300002)(110136005)(7696005)(38100700001)(7416002)(66446008)(4744005)(6506007)(71200400001)(186003)(9686003)(8936002)(54906003)(55016002)(76116006)(66556008)(33656002)(26005)(66476007)(64756008)(8676002)(316002)(86362001)(66946007)(4326008)(52536014)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?e4fdfz4sTugzkqIBs2OajVxTDKxWb5J7bGaop25wH0veKw6D5os3lIM7kdOI?=
 =?us-ascii?Q?tsWv/k/yLEp0Tc7a48ELroAYWMLiZ3Uq7B4yUZLbrEW1cTStcKPlW+5x5yHC?=
 =?us-ascii?Q?jf2pDi369bAwsJd75HFR1MRdRn4sRUE6m9OSJOyvFUlL+UBR4xZJ/V3Z+AoQ?=
 =?us-ascii?Q?qDKy+CuiVSOkS2ifk9wzZkUOawRSXusEdkc9HryQKtO179U3I7MH9BZp5XgK?=
 =?us-ascii?Q?q+fjwyNNZEygry0ogk4kCP39v9TwhNZgbRa9HHbyJ56UydOTUeHycgvPMZKc?=
 =?us-ascii?Q?ijQxfga6kZIm1oTv1PKaqLM+YyvJiw+/7YbWr3pUuy13fkxP9ZB/XNREuct9?=
 =?us-ascii?Q?Q1cYB2MdsLrBX7Vp4avBIT8TZR94CIJY/mrbn8B6x9CLdTDFR6o2wtiHRNiG?=
 =?us-ascii?Q?TKAGAD7yjmaItiBZj0VXV6YI+2vPkKZfrhGFXTCKpR8TtL7J2UMkBVTcSmUL?=
 =?us-ascii?Q?7kSG4rwLppbD56Y26mc948u/Nsad7T0MTopniEFDzNvmgsyP1e52chVbpAu4?=
 =?us-ascii?Q?oJ1+iSrpUE8VubBnAyBgBgE4Iqy6kR9+tl6byrhVDSV1SnX+Fhj6/m3AU2Mp?=
 =?us-ascii?Q?XL4rxbneliPy1FNcfP4SYt8WRB9OhfJGNaqAFZeFHwCWTP+0hSGMyxnogVfK?=
 =?us-ascii?Q?fLoxqwMeWGLFSpczMV2Qmbg508AhMzT0Reh2v8YijTtSURR/uLNWsmfa2ttH?=
 =?us-ascii?Q?0Lgky9ngncp5iEJU2oOFMIIAKOXtwce8DdPMQzeTAbYrcQwIPdbHaPZwt25z?=
 =?us-ascii?Q?wkiE4hZwpwJvXa7hGUN3E2aEhl09szkFIJf5dU0exC6dnKph+nqGJTzPBU3Z?=
 =?us-ascii?Q?loNxg2yQouh7yygqwGR2c3mJj/axNczx7U3LFNy5qGHYYyQND8zV+H90aTwQ?=
 =?us-ascii?Q?Ni0BdHuJtL6y1VcsROf4J2BNhB7n37YtLrUJWOCm9Z9qappxypg3QrSBfO5j?=
 =?us-ascii?Q?wt0ekXcWYgUbdwYUpeUXFxURy5FX9WXQax1JpSvbmJy25SmLp4+mHTGKlHyd?=
 =?us-ascii?Q?VJ/jWv/RC+sqplHrjoXHc4fIyfDhkYnbMuSDqzuvc4TcoQxdH6Qca5HLL1zS?=
 =?us-ascii?Q?djg4P/dmmmxxMc3+omdd4U2r/8NHeDXwRsrOe3R+L2uN0isoWFCHMtYdjzuL?=
 =?us-ascii?Q?Zw4dmQkohxRzG6EZm0XWDBU+7wdE99k82aNzDfuMkX1nH90tcm3e78l6hPvp?=
 =?us-ascii?Q?u51zwRwJKc+tOuKEudHAEAdKlhUiklD+sHH+rPC0k4SKLRoBu28fn3B3ggIj?=
 =?us-ascii?Q?sc7hO4GiJ7s13sFAO1AkYGqYiwWgHrdZplf711bt39BG5RndPW/78pqqXtvU?=
 =?us-ascii?Q?rCBb4vr11PLqK3No8BMFat3YjBVpU1Dbm33oLdg+iXMhYA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9441e1-b0b7-4e24-f864-08d8f3d761b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 23:56:05.4825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hRGeJ311WbedSlUUYUSQsCoZjCNH2ciOocP0ByYuRUcvMObrOpDTJKssH9GfknUabzfeXvfxGZ9O9pcoFAWWO9e7qf0MumrwJn6o+H6MSe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6424
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/21 00:39, Gioh Kim wrote:=0A=
> From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>=0A=
>=0A=
> No need to have it since we can call sysfs_remove_group in the=0A=
> rnbd_clt_destroy_sysfs_files.=0A=
>=0A=
> Then rnbd_clt_destroy_sysfs_files is paired with it's counterpart=0A=
> rnbd_clt_create_sysfs_files.=0A=
>=0A=
> Signed-off-by: Guoqing Jiang <guoqing.jiang@ionos.com>=0A=
> Reviewed-by: Danil Kipnis <danil.kipnis@ionos.com>=0A=
> Signed-off-by: Gioh Kim <gi-oh.kim@ionos.com>=0A=
> Signed-off-by: Jack Wang <jinpu.wang@ionos.com>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
