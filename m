Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2153C433E0
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 06:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A41122571
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 06:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbhALGOH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 01:14:07 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3980 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbhALGOG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 01:14:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610432045; x=1641968045;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=I0AnEjoA/3Ln/ZlqaCB8yMGiA3NqFrqlzHf2SlrqItw=;
  b=jR0UA8ZS+qbkcuwplVfcRBSwVeyRKmnKLj+tSGWNFkIQnNbgwcFzNPAE
   58ryHzclMbGqo54lNUFBdB5KrDTBKtq2stSXkVvZF4bostklnLs3LI/PD
   6vYz8b1IuVT+eIDdw8KzIbk0U7it8EO/dJ5Jc1j7N3uti2IZVgNR8mJ+W
   /em9hJQ+UwJsVY3uzzXtfq3g/aOqzvOBuCxHv4xKQNOZ9QucVWFBBsEdr
   G63M/XjCFziLuJpNe3f8m/3CymnJRxMhwgqvYblLx2Ey4qi2aZaKDvxxX
   trMgUfEeo7ZPnf+rDJo6lzZAE4xnOLv3To9qBJRDooZTL9WDX+4mgNyMU
   A==;
IronPort-SDR: Bs5PaqKUg5m3RkuKB4PDfztBnnOv+Bsjf7wHwRCKXTcghgVc3KIFCnmZFN2LiKOpi8Oe6x9tpS
 G1RyuyfiiEkORhPiuD3T9+XdEebO+FnOHqq7PB4ysV1E7UIRxbw+V9AP3+jq39dxylXpOGDJoT
 zI0HFqLsYZIB2ONtFgi/IqXG4a4+3y8TPe8x+0O6FKgQl11FIz1/x+u0UDaR+ZIgrytmfZthoY
 3967xMUxfvS2IRNVVvM+110vApBrur/EzLmJa9tkEKk9kSdkfUcdWF0P3Xh0ohUqZI7r0fpZ9R
 IAk=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="267511203"
Received: from mail-bl2nam02lp2050.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.50])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 14:12:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuHf6MVdIOCwW9+ogHEddBOB6W6jZy9DEKgLoviJACr9DDJ632Ri0SmOVL2PWWXFtGzUMmFvROOn4utU5NnpFtnEUq3EnA0fiZ4Y6JEnX4s/oaUkajYNokoK+uHVzRi7OMal65jCKUcfTkOmqWCGi2TWnSj/5NMWfQlURenCU72ETDZVeBt8aM8UtPqYxxc974J68hDUthFK+iLRD+sv70LHrcnguDvqpTfzMrgaCw5LgMREbF29Iz7pHGrwHvei9rce+ZurSgDgNOL4ELpPeTWRbtpbGhOS4wiqI+2UJQBMInHS+I6tWryYDfqx6IOsw7PMXL4RoyCk0vmttqWlwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0AnEjoA/3Ln/ZlqaCB8yMGiA3NqFrqlzHf2SlrqItw=;
 b=nttJKc9Rb+5gzHs2WSGIdfIFY5tXI1pBsa3/wm5iA30yFr43VTwLYQuOLnpzwQvOjiZ+N11WaSOaxj7r9IzIqXdccQ1ZihPcEON7lnmIhYQfx0u0zzdYgCGK0VDV1LYP0uM5tA3QNqHUi9GHcl5bDeENmP958//ejFixIgb5vQBMJCLrE2kvqwUcpnwFAyQB4te5Yw2p+0e5DLtTua43SzGSrRUXvRn8bIrkDwRaJLZKIQmceRIswwOdx03T1PqLmLX/jt7uTWP24Hwyb4szKXN3UWvSGw5k10ETERSxNPOp2PdiaH9byvkABR0IsakzBzoTY0IG8pn/hfydsT0ToA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0AnEjoA/3Ln/ZlqaCB8yMGiA3NqFrqlzHf2SlrqItw=;
 b=ArENIJZurFGqdy7qRxOiBVLhacMWXYbldLIUKftVSWA/n2nGFosj4DXZYrOjKRQZZq5kDdOE4vA3eomFCwlynvPeLlrj7u45+FOZffoHGV+3+QrWx1pI77S53LZj1IoBc+QkV27BkNYzMeTegE+d2O0XnQTpReL5ezJquStJHVY=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5895.namprd04.prod.outlook.com (2603:10b6:a03:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Tue, 12 Jan
 2021 06:12:58 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 06:12:58 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V9 0/9] nvmet: add ZBD backend support
Thread-Topic: [PATCH V9 0/9] nvmet: add ZBD backend support
Thread-Index: AQHW6JsaYjPbWYB4pkeYj4FVUhUBMg==
Date:   Tue, 12 Jan 2021 06:12:58 +0000
Message-ID: <BYAPR04MB4965A5ABC937908A0D88C0AA86AA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b653c27-cea4-40f2-69d1-08d8b6c11c23
x-ms-traffictypediagnostic: BYAPR04MB5895:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB58952C079D222D52C4E6CDE286AA0@BYAPR04MB5895.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: trq+5VZYrB+7G/rIxDPOcXIRaEab/3IJB9yZ1hcRD74iV8td60OHFuFUz3wMH4eWw2dc3xqcsESIrvaUX/h4ZKFqq5GgrIIWPTaPRhpDWEgJmqmZSrlN1iNZid6L9om7aMfHEIMQ72ZKlCpQ4ZywPeHbapKbElj9YHBmPPs2xuHxQskPd7WrDwaasWueomYn6R9kxrrQ8Vr7DbLAnhyVgsYJDL+n/jgLLEwsqFpPaMz7VDvLsxqoQGh99jZW3NnOMf1ZSfS4msVGLyuP5mhvoeSQ1r4sP9KA22XTDZGHB4KUQSzBXms3+Eh4hsx0tezmQF4Z5mZBxRTAT7PABcgtuX3Fb+/6nQSl621UZ+Cnv25frXRep2qKzuVx1GHQ4FMtNGqRFPqx/gQZUjNQLJ6fMtOtchqY/BO4aqQ51wBYIuw7Z3iJG338JsnYu4kcmEO4vzZkWZHhhIkX6OZScrVCjg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(54906003)(6506007)(316002)(6862004)(5660300002)(53546011)(2906002)(33656002)(966005)(71200400001)(26005)(186003)(76116006)(8936002)(478600001)(86362001)(64756008)(4326008)(83380400001)(9686003)(66476007)(66556008)(7696005)(52536014)(66946007)(55016002)(66446008)(8676002)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?//ZVErHzQJErNBrkizJ4TIBrhNYpIqqZypMDxRgJcT8mCH69z90TmE3fE8/0?=
 =?us-ascii?Q?iKxzm+ashF6lR9oA4liykKpR6jAj+X5hAUPeaCjYlGGKgWi+5ilRPABEjY3h?=
 =?us-ascii?Q?/QiKu6tUaAwWtFZzRTJMswp+KlU8n5rZ2UXxxAc7xq8HvX6JH1rqaQGoI1ZL?=
 =?us-ascii?Q?/fH7GqOZZJDxdIKceR3TER10zKo0Hlb4Hn71yb2ULe3oHCU90qQBwQ9leTyd?=
 =?us-ascii?Q?XQrKRAiAdlsQ5ib64B4tBP0RJgYi0x4P3XYq0joFu9/zJw+i1W/th7m9MyWf?=
 =?us-ascii?Q?a052QZztJdPxcUX2T+kUteo9L1v6+OJ0ZqKQGqYq5b1qEo1JCxdeFGYiVZPb?=
 =?us-ascii?Q?imnfXZkC+WJdbcjQP25g2hsJHBCCFL/cJdZMDQI17EjZWJh3UrHTgPvIHoYs?=
 =?us-ascii?Q?OQtcrLBLaTCmGWx9UcRsuCVHA+M7AYPH5gu4QYprk7NX/O+hcNsi+ZKvDP6i?=
 =?us-ascii?Q?v9aSmv6Zlv91k4PHpkWHXIZfyIRgcL4fn6Vhlf6PuPQihc24a4+ON5ncBKGz?=
 =?us-ascii?Q?M+UZkTzXw2fzlee2Q761P0nMpKAc+/Peo2TJJ45hVEV5eThRwGK3jXh1+zKJ?=
 =?us-ascii?Q?ptyqUP8w3pzHosbIxc2nL4o4bzsJeHbZnDeZim0040Zd17oUJjefG+gOXXqs?=
 =?us-ascii?Q?sKb8d8jmDLqPUNJNH66ukY1+W5q15kFD4F5bOMzfjv1GkQSkysvaqfpAc+RJ?=
 =?us-ascii?Q?bQ16gxArujyc+wLjn2rPaa6tCT/ND7j4C9JPVW4jmeNuB7kEMIyOtCSi1RQO?=
 =?us-ascii?Q?U7XJUu6K813JIfN98yjU85IfF/l6/pJgpm179SvFq0WRhuaBcISX3GrSTdJi?=
 =?us-ascii?Q?KMy4RzyMfI0L42v76a4CAsVy+HzQrRUiS+Mfb1ATgbIkE0F3eD2DmniJld9O?=
 =?us-ascii?Q?N1Wa+DiK7hZLhWbJkQDTJO1FlhUJZbR4Tllx0H4s1Ysar2BtwtyKzdCNNb/t?=
 =?us-ascii?Q?K+mlwAEy6eF83z+rtrxQwKg8eFRyHlIetnGZlI1NHG9Z5BKliOFjao0sdLEH?=
 =?us-ascii?Q?CSPY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b653c27-cea4-40f2-69d1-08d8b6c11c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 06:12:58.9033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6JNibz1pxm0jcnAjxkPQo7pj9XVRLQP4dpR6YZa5N3rpMGS+eXa7Ahjmd04h09nV8UUFOmeoPmWjybnht7cJr5i48R73oFxrgJ/QJaqyS8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5895
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Damien,=0A=
=0A=
On 1/11/21 20:26, Chaitanya Kulkarni wrote:=0A=
> Hi,=0A=
>=0A=
> NVMeOF Host is capable of handling the NVMe Protocol based Zoned Block=0A=
> Devices (ZBD) in the Zoned Namespaces (ZNS) mode with the passthru=0A=
> backend. There is no support for a generic block device backend to=0A=
> handle the ZBD devices which are not NVMe protocol compliant.=0A=
>=0A=
> This adds support to export the ZBDs (which are not NVMe drives) to host=
=0A=
> the from target via NVMeOF using the host side ZNS interface.=0A=
>=0A=
> The patch series is generated in bottom-top manner where, it first adds=
=0A=
> prep patch and ZNS command-specific handlers on the top of genblk and =0A=
> updates the data structures, then one by one it wires up the admin cmds=
=0A=
> in the order host calls them in namespace initializing sequence. Once=0A=
> everything is ready, it wires-up the I/O command handlers. See below for=
=0A=
> patch-series overview.=0A=
>=0A=
> All the testcases are passing for the ZoneFS where ZBD exported with=0A=
> NVMeOF backed by null_blk ZBD and null_blk ZBD without NVMeOF. Adding=0A=
> test result below.=0A=
>=0A=
> Note: This patch-series is based on the earlier posted patch series :-=0A=
>=0A=
> [PATCH V2 0/4] nvmet: admin-cmd related cleanups and a fix=0A=
> http://lists.infradead.org/pipermail/linux-nvme/2021-January/021729.html=
=0A=
>=0A=
> -ck=0A=
=0A=
thanks a lot or your comments, I'll send a V10 with fixes for your comments=
.=0A=
