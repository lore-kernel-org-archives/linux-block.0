Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16C4C433E0
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 07:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7963E20679
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 07:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbhA0Hiy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 02:38:54 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44930 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S317393AbhAZX7y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 18:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611706697; x=1643242697;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xm14UQOLXx7wSE44N785si03gWHJG2mxP4GYuFEeDeU=;
  b=J1AzTffTa0A2yV4z3JeiVkhGWkbiJ62+/vSkFQVgBD1coEE+yLImfvar
   7ElwYGaefgqXno7PywTxjjUE2y0uKGImymyZlpi4F66Zm3wxtKBMQAnna
   Y29osNXLsEUcQcovvO5gkOUJQcyLemF3gJvMZnBzqw10ewBaIS2tBksbs
   CABgXJQMKUlgDeoSiDOAyFU3zGDIADHojOsRfMQv8SWnYH6shqti0jKIE
   ajPYGn0HBZei46Pz0OGbIOJxnoEuNzf1ouFVCB7YjCuKqN/9HqjrDYOxA
   sIT6rXPDZrnv86Nh/TuFnlCzfHi9hD6lzD3b2s3UugjJ2Bk5ck8M2cT09
   g==;
IronPort-SDR: df9MM/IC4mtUZMG4uj4C6lHXXqHNXaOs4y0GJgibJLaAR3P6x6xuouozXy4nlIBjaybFPK4Nkt
 /38ztiyfeEVzk6g5AWDZUfGAFj1qI7O+XB8TbCWkkvmHYTpaJoCsnPUsMqLzFvvtXR9ZNr1s/X
 xyjXAtxHsrG6nq/2alf9WfGfwHJ5WqbHclnyS27A3tEgnN2HvfIsNekNeIOplgVy+Z1clpHKmN
 QIOYrb96mkr7Fx6d3933eiTmV3GefAhO5mJ4SVKh5dGtbOHLO1jQSN7+g3/vhEbTQmjIcBoJnp
 1HM=
X-IronPort-AV: E=Sophos;i="5.79,377,1602518400"; 
   d="scan'208";a="262415578"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 07:36:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8jbkFooSHzi8VFB/DpuCO4Y97wG5wVbX4l0QCDafWyt1kk57kPi0MlU23WK+KZQ+p852aW9j1fOaGaxkr35D9yWoWG8urITBbBqynboMn/pDjAdJtlnKUV29f+4kaK9XpTkNgf/M5qyO2FPMGydHOZTTUD1Mvgxhr+CJRSjRm/suy3IW4Dz7XdNS0707QiaftWzFvIur/MKWzvs6s5fQ3dOaG1jicoDxYcppfz1CbZhv43G6cNT30w+wADK8iP1lUTnvYZsjVXvDjz//XtepalO+fSJNlb6BPgN4tN3rSlCQ+Z5oznUoTJX+5V/ZUxUXeKzE7AQkO0ELBfZID83AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5EKe6OX4yrWUWjyFGBkuhgR/ZX9ew6g+MK4nGB3Ohg=;
 b=mea/5WQiGr7Wtt3Z5ti6/3xlk3s/6QQBWjb5OhZIuKCM6WupqmdMm3Y2KmsoOarLh9TnKo5UQuH3kPnAHaoGjZkkZg3ihqMAWqTmcHsdi+0LvbmN6BXM4B/09wdxm7dt74XPOSdmuQSNALebJ7kX1MrxoxBrpBoAo4uo00QKo68AKygozTg9kY2L8WsGGL19+hTJc2n+3KcIYmOFCO4Qq93HSYIe7FYZb6Hyf28RobV2Eb/JTHRo+VIfiWUsFLV0emA06wdgzoztOi8fd5Dx+LTWdBNvBWZ88Ib451nI1APK6tADXajwEiE0rt+Ed4yaO78ew5Q4lYhQux7NPcQSVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5EKe6OX4yrWUWjyFGBkuhgR/ZX9ew6g+MK4nGB3Ohg=;
 b=BuG1Ao3aMfmLJ7/GCSOJLzINrGxVqdpnFvnKszizg+thA4LiRLPekZMUfvOMWxVOr9isaMEXmUX/pkfEVSyWlaipSz4kUX7Bnv7OheTpXMHLrwksbIgXCedqNU1RzPbIwo8jP+x5OcZCMl3/4Xt0chbfkheunLnw2X4oggm4dC4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4104.namprd04.prod.outlook.com (2603:10b6:a02:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Tue, 26 Jan
 2021 23:32:09 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3784.016; Tue, 26 Jan 2021
 23:32:09 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bjorn Helgaas <helgaas@kernel.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] mtip32xx: use PCI #defines instead of numbers
Thread-Topic: [PATCH 1/2] mtip32xx: use PCI #defines instead of numbers
Thread-Index: AQHW9DCX9RtNxF9J2Ui6R7ku9PxAZA==
Date:   Tue, 26 Jan 2021 23:32:09 +0000
Message-ID: <BYAPR04MB496569EC5AB6FB3A8A2D562786BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210126200433.2911982-1-helgaas@kernel.org>
 <20210126200433.2911982-2-helgaas@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 520a1a39-2e65-4fe4-e6aa-08d8c25299ac
x-ms-traffictypediagnostic: BYAPR04MB4104:
x-microsoft-antispam-prvs: <BYAPR04MB4104AFC0BF425F635183A92A86BC9@BYAPR04MB4104.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qNnrKS6rnOgbcMmm1MzLU3RuJm70K26bnPRUvQEYNwADKRCA9Ht2HuNKWwQNbqGzSfhQWj00ujS6y7F7c3wZMWd9ogRhtwAvoTY4shXUH9zMEvkRVMJWaxir25g6jIhRJxRefs055iL47nyHZe0VHPN0dczYz4l0OFcztIJ1jQOGdA50LjYpaLQT+L3yeGQ16JAT8Jvgi4AXXVAycG58AjvCfxrMTUEgHHOaKqwAQm4ARbCqDmk+eWAuhlZ8Q85N6RqouekBAW9HIDQniLlLpD5mC82twcp8fRyiek5vnO7Whnr2R/Lish0XXBg68T19kAH2icPCvhM+A5QtypfVt+Rv7iyuqQpLx4m4rPKVMAmp1v6+g0eq2xEXfOgVOk2jGm1Z7IMvQ/LfGwJU51JMBI2cIMFC9zDps+CQ9h3qbXJQHa2aZRop9q/mK/xv3+/cp6vd6YHa5W9d8kw3t4eVSDJnblN2JmRpVgDxOPAJ1cZ79ITjWkioyG6BZEyMKylJFA5r8KDjf2oU3j7bwyRuKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(33656002)(76116006)(71200400001)(316002)(26005)(110136005)(66946007)(83380400001)(6506007)(8676002)(66446008)(64756008)(66556008)(8936002)(66476007)(4744005)(55016002)(54906003)(4326008)(478600001)(186003)(9686003)(53546011)(86362001)(52536014)(7696005)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0xNNFIeuN68F1ljer6XAK8SUGdkU01UL9L39sMXkURoOunYfxVU+Usm4c1ix?=
 =?us-ascii?Q?fUZkxHJbCHLdnv8ZPWb0/4L0x6Baw6XiBjU0dASmLgLUFoLVq2m0xU2wNj26?=
 =?us-ascii?Q?MoTflAowX/qHUgBgZsjTy7fuM0RFwUu3hKINFFvFJfYxQEs/ry6iPi5ejrjA?=
 =?us-ascii?Q?ezIduFLXvP/5nz9dBkl3f29ia4YUJhRD8hGPZUJ8uv+oemAoT7zML02PyBof?=
 =?us-ascii?Q?HRQNqYJcoCqyT22NfV4ANTtRqr65KoTidxxsWb3qv67TuxGBxAkP2pRDDPNu?=
 =?us-ascii?Q?WH13wGtWoKwm6RBRWOzG/jDtF7M6q/g8LpRDDo0KPjEf2Q5DLO1ksn/sQFPu?=
 =?us-ascii?Q?6fnflAjNDRCktM8WxSt2T8qZ3UI+L9EpPWatKPKwoY90cUCfGyMhrbs9ub66?=
 =?us-ascii?Q?C+lz5x0C48L7d0xozGIxvtZNcrDU9UeX8nxK3lfCHoYXT+WrCFSUk0ArwxK3?=
 =?us-ascii?Q?uWMBWAOfUggdqNI04T8dQp65Ap5YTmFX6cxh6QUs2jVRvsQlAdE9czcof49t?=
 =?us-ascii?Q?7rGKbsCoJr6WLeoNjugCO09xFDOu2dj/Kj2IlkOK9UOGEFj37/zKn8wBDsIl?=
 =?us-ascii?Q?t8GRVHqsiqhgNCfp8DVfmSK72HOOiIVx/Y9YtTEHQOOKqXGhps/dsRIL85Xs?=
 =?us-ascii?Q?OvAqpTYSrQOMLlifwrDNsU5AfDMVgqw0Lez+Cb8IcmR0IcAijlcKqujV3ABJ?=
 =?us-ascii?Q?EpBbT+amMMO+IQgNHzrFHG0M6hRlnqObf7Ph2CoB/r9HXfjOsI+dMitgMR1H?=
 =?us-ascii?Q?PLvYJZvbUsxp4pWgU/yL6vwgiyzd/SL7Oc3BPDulmwujcJ0gA7VI8ERufBEf?=
 =?us-ascii?Q?VIdKEZ6QvulkdA4pe6ClByp7R7NhSRSWI5pt4dYVN+XuS57ae2wps7IgOPOf?=
 =?us-ascii?Q?lluGpCba9FUzT7BRFAAjthQ7Vr60g6JJK9vfyGBYVmY3Xam8CacmP6/DntF7?=
 =?us-ascii?Q?FrxoAFA6n9LqThmIc+RlvR4L6wlScT1mVZC4Uv5ptxe8RyQWCbRz15bygFuh?=
 =?us-ascii?Q?3Ww95QdSUB7Jybzfegldj/wGS3E5AzhJM9my9lxAjdZRXYyMz30Jy46XQjD1?=
 =?us-ascii?Q?aAY5FK9SDRsP/zajnwzUfSbT2WBIYg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 520a1a39-2e65-4fe4-e6aa-08d8c25299ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 23:32:09.3617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRJ6lP9rc5FMALL2PtvkolE5AD3KBcaBEkJog1tF2MQaGGM8W+YhBVIJxOolyPw7YcHjRr12iblAObF5FaIEzw7FRKWfeFIUciVTEmEhu40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4104
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/21 14:14, Bjorn Helgaas wrote:=0A=
> From: Bjorn Helgaas <bhelgaas@google.com>=0A=
>=0A=
> Use PCI #defines for PCIe Device Control register values instead of=0A=
> hard-coding bit positions.  No functional change intended.=0A=
>=0A=
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>=0A=
=0A=
I've verified the values present in the include/uapi/linux/pci_regs.h=0A=
matches open coded bit shift values. LGTM.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
