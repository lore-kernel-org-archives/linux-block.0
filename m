Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6E4C64E90
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 03:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9038B2064C
	for <linux-block@archiver.kernel.org>; Tue,  1 Dec 2020 03:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PDwBDsfm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OiLOc6WX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgLADoA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 22:44:00 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57281 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgLADoA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 22:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606794240; x=1638330240;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mN7tZ2TvwCN8HSmHaBekv1Lsn8ZYvkSY7fulT0ifols=;
  b=PDwBDsfmQk/uboPPRlCIQXR1mG/ur1k300/m88nXhS5oLHN5xzvdvgza
   XHpHFHXEgEsZuQpsULbOxpcZaQE2VJRPFoJDKGHJ7Fe4wLmZYXOC55qCq
   69lyvhafU6gDU0da29ObfmTiXpL5L2GUqLmVgoyB4PTKUvIHXwW47srhn
   iPZUafyWgLTjTl6sGBKfF7IyCeJgmuZUkiknil0h5XunVEvFUS1R3WxcQ
   E53b11PI8Otp3hrcoq4Ei/gqU7HCJa7Rx721pDUSnBrMZVcgJru9buwqU
   82Oa7/dumuc4kvfE7JTKr0RZdL900wtWaME0s6EuROzZTGAGbmtoJQ2jP
   Q==;
IronPort-SDR: vxoV5F7w7hh5pvT5GRVaqfcCSViAuF3Ig/mBJ+7Cwh/LrnADQk6CwnSUTeBFQsE9U0SKWuG9un
 dRjL2i/uFMHLJiYc9RnaOeGjDHMrIoRa63Ej4y8X5x6fxmYxCXkTbFjz7XWogSS5o5dmBsZC7u
 ugOTCPdZEbqxqAvk/aAHbDG2kS7CMQovxWDdXibdkPylY/LqblDaKomEt6zjqPQda6FjJKwY1p
 rcpcIV7wCx8mOnR/R0IMHtRE8+KX0GVAG/wPkf9ysQRuve29VDEDU7QV6+ll+3666twmtwClkn
 gvE=
X-IronPort-AV: E=Sophos;i="5.78,382,1599494400"; 
   d="scan'208";a="158344543"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 11:42:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WgWptCpGRYyy12Q5jyl73Bc9K+GlUPfkUyUvCXMh/jOHOpPLI69/OWuvNtwp/AfRIubNxKZg7g26v0bstIk/niFVLk91LrC1J3w733VaNX1aDwjHvfmPB7/4yFAD8svhotHy/oQjzIIj+th4/7m+D8Z1yP1AoscDwCvcA+k97LA9EYBKJXMsB86MdDArJMvGFNmJyvWrm20XqcbG738UpXWOXprnGkibS8JiV7qDTV1i2zeo+pucTo7WbX5rMiIESfPVnCvt/wS7LPYwZ40BGqrZWYbjS1FMJ7sW8W8YBOTemh3pflYx93UQ2dQ+gUw+9EwIEr8NEiSs8+LQEj5rAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFAk3NwupXhiw7Vv7e+u2p36lLUL4wMsThwKTixGOQE=;
 b=G7Q9J+8STnS3F/+2uQ/KI9ifyeQBC3ZcnHfHtYhQxgs1UcrQ08/IDOID4+ZSpTaHunDz3vi1qcQxqJJA+BlDFtzO8ic7JfZYSucm83X88+/MiPF25qyBpZUsnJ8pKjT5IRtLV00Kreika5PPsXjpSY9RNE7gjpqmpCA3xrfEtCjs7vcspsYGIvsgauD8Z8bdZkFYcaMvVS3nbMWLRimwiF9Gl0+UAJxLRGn8F20Ex5U34+ATN7Gv6dI6/8y0cEahQVb+PYmkm00AIMgWb0A+p/NMM3dcopVKnAIv3b2VgXpGw6MU0pBCwLKv0KmMJ36Q4ZWucn6FK/f5Nd28kg7p1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFAk3NwupXhiw7Vv7e+u2p36lLUL4wMsThwKTixGOQE=;
 b=OiLOc6WXoS78dzkePgZOECc8/wCmcYDCBwwY46snL/+a0RA1mi2vs1XKnOI668fqmyo+MHIhBLlBfmZIJvgIrv/lwYM/FaoRjA1nLazna5e5EYbO6npKldrukFhh9UPjVY2V/Pj4UhHR3mjYlXIQTCiodsVxQGgbFKTtrgVxSKg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7152.namprd04.prod.outlook.com (2603:10b6:a03:29f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Tue, 1 Dec
 2020 03:42:53 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 03:42:53 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/9] nvmet: add genblk ZBD backend
Thread-Topic: [PATCH 0/9] nvmet: add genblk ZBD backend
Thread-Index: AQHWxsj8TyZ0e1G8w06nimw4K1wW2g==
Date:   Tue, 1 Dec 2020 03:42:53 +0000
Message-ID: <BYAPR04MB4965E996DF5785D273EE7FDE86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201130032909.40638-1-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522E1D0137093EC187E7AA3E7F50@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3e918bcb-416d-42fe-0656-08d895ab2ee8
x-ms-traffictypediagnostic: SJ0PR04MB7152:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7152F6BB1CA95B2690F5C8A286F40@SJ0PR04MB7152.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M2of5fvXOq6BZ2M8VSDVWO9CS7OmTqGhT/29KrhauQgb3P0ZmUf9w9YAx2LIKyfW1+Nh11cvNKqxwG23ZwGlGSV/3rE/Yr+LLYdUkrbXQWyj94GKsnK9LiTy5zTzhFTVPuEgMkol+aGEpCSbTGUEVxQF1VuzflL50QmeSQI2mbX52+BZgnqeIILbVx4tBYEe0wuuYRk7LkKVyy8iJOizrNhV6a1vijv+9QRTmcxYhYMVGOXtce2eCOtgb+XtNVw3278b1zQatcO2VKduSWExosqOsDcnS04VLxkgug5v/MsdLNvL/D4cBhICzitpkGy8VrKqtt01icmtHWtWimLODw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(33656002)(66946007)(5660300002)(8676002)(8936002)(76116006)(4326008)(186003)(66476007)(83380400001)(2906002)(52536014)(66556008)(64756008)(86362001)(66446008)(71200400001)(55016002)(7696005)(54906003)(110136005)(26005)(316002)(53546011)(6506007)(4744005)(9686003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?nOKrXIWMcyB5/pkk0B/ZAPeMUSGNpUhwBB9Z4qlFmTzc+05py7QBKSQFpk6U?=
 =?us-ascii?Q?Iw/xN4zTRLdg9ZWVZ9lC3JX7yufKM80dWdDjTjZbT0QJ2Nxhz5rnVYJodOaj?=
 =?us-ascii?Q?hky96UObNFG0cdjHbu/hY5m1OGxDz6s/QmUJ/bUNFU+bOjR+xKMiyEB2Euq2?=
 =?us-ascii?Q?0L3dQNOEf7WNvYvX0/2jDfW7GlVj3kznR0A1WfV3/lGUyb+kW+v6JBBGvrCr?=
 =?us-ascii?Q?0Tk2igQZgwKN867tjH1hod3XhudmqWEGWCDOtzZxUhNEwv5Xo7tM1e6pGrPc?=
 =?us-ascii?Q?j78YCOixkIE1fcVIM4ToMBZo13BADkjLfYW3wEDebzdZULl+g1ncUV4uOQyH?=
 =?us-ascii?Q?8MkhuuhQ9Ym43gwSen97zfzBm9YN+sSpmq6F+60DDZhQ2gac6ei4Uout9vjA?=
 =?us-ascii?Q?vrjo0EqPb+iJUkf62mQpBcYiPcco7Ac2eAxiqnqerBLWbHre8+HefeY5/9pK?=
 =?us-ascii?Q?RzM9eolNYeyEGlxRUf1yY20crab+jzjeqAMZ4oOdrHfW/SWbtxz1uGgHK3Wl?=
 =?us-ascii?Q?3GAZ9gGJBy2jozx+JruDPVPnrCJ1BD8LNOgQ2V9WzBtHa/uiUpw//H4inkod?=
 =?us-ascii?Q?n/iIso8WIe92hsAOcCZF9zOZDskeO/vpo8xJdGP/silHEfGq2672KAsKEzzE?=
 =?us-ascii?Q?go/3VmFUDA1c7vNHBdNIby3Spjc4FKa8DtJBsWehtyDRQOSfCDX3O+r8zPpX?=
 =?us-ascii?Q?0qSLVDwfxTolG1HgTt1P0CA0qTES+fAt63wr3FhL7smQpDqCWZoKQCnM1L26?=
 =?us-ascii?Q?gBQ+f9r++AlwTY7okc6RF0dW9QKVLewQ5xRJ4WaJskhBaXRqfGRIpzMUCHZC?=
 =?us-ascii?Q?VsviXbIgdi7CjpQw0l5mDuG/qM4GfJbGTdnVdPkHYBOLM8zxNldNX5OADBZu?=
 =?us-ascii?Q?l0EzhBuWE5LtZ8eUYLhK80L2RGhaKjUAIBLWYs68qhzIK3OTwiYHpqZShgBx?=
 =?us-ascii?Q?IgTOPIncjY1iU2nTTkVB7d10x9LvZmxJBH9e6BrFOyZhG0rnFJezX5V0kdQC?=
 =?us-ascii?Q?ylvr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e918bcb-416d-42fe-0656-08d895ab2ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 03:42:53.0460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAHqkpI9CEcBKZQZxcUM+r1E46ehOp6sK2wvtPwbVBeWSTthGCCKXLHT8TD0oZhlqN88D2evt/ABb4d7YnC78bYAFIkVQqBWl0OrKV3ilE8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7152
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/20 22:52, Damien Le Moal wrote:=0A=
>>  block/bio.c                       |   3 +-=0A=
>>  drivers/nvme/target/Makefile      |   2 +-=0A=
>>  drivers/nvme/target/admin-cmd.c   |  38 ++-=0A=
>>  drivers/nvme/target/io-cmd-bdev.c |  12 +=0A=
>>  drivers/nvme/target/io-cmd-file.c |   2 +-=0A=
>>  drivers/nvme/target/nvmet.h       |  19 ++=0A=
>>  drivers/nvme/target/zns.c         | 463 ++++++++++++++++++++++++++++++=
=0A=
>>  include/linux/bio.h               |   1 +=0A=
>>  8 files changed, 524 insertions(+), 16 deletions(-)=0A=
>>  create mode 100644 drivers/nvme/target/zns.c=0A=
>>=0A=
> I had a few questions about the failed zonefs tests that you reported in =
the=0A=
> cover letter of V1. Did you run the tests again with V2 ? Do you still se=
e the=0A=
> errors or not ?=0A=
>=0A=
Please have a look at V3 cover letter, it has updated test log.=0A=
=0A=
=0A=
