Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F30EC433E6
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 09:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 097D664F5C
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 09:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234167AbhBDJDH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 04:03:07 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53603 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbhBDJCl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 04:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612430249; x=1643966249;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=0RRx3ef/MiXRvMNLU0N/qq5t8rn58V+cbADovPUSw4s=;
  b=i7Y/X3Fsac0SE1KgQCAzZyW/DYND+OLqpClbwmn4/f4rs8lkQqBovU/4
   42F7DJFcAp6jzpxYb1RtgvxkO6CkxAfpW1xvFeed1mzjg+V63IwRKeKTf
   5F64L7UcI6cKsz/Jc+a/XAdttcyRS7hTDVMgFrva+Lot5p0yS+vPhAK0E
   3+RtWjDNQntkFs73IWIKrUAyor0o/92KXG35vRcwyMOzER7WXMGVWABnK
   Xz7v5W7/qMfegVK4pmDr2hBWX6a3O068L8WYx/K7hnw4K8qxnWc/IwtG1
   sMd0y+RtkyiOPY3y26B09pnreY7lNKH7xZ0un9OhYTwNWBoS9TWJWnLtr
   Q==;
IronPort-SDR: pEI9k7gciEHD2LhitofqVfCRzLu3GNJ8pWR4XRHWSc8c6MY4xv94G0YM5hf+Ld61gDzbZJN9Za
 EAGMlHjOc9k+8fP6JJKeEJfJBs0NAPgXhGr1b2QtgVlRDILaau7uyF5GUnG+NP3yDnbA9uygIL
 /Cf23YU7BXk3UVDqofCHLkls9MPBIkHGHx0/z5pIoaOLFdsppiHAP6jqSgAulkhbJHYx4if6Y6
 qRBjTAY4MgjkWfPVOyZqWR/I5nkDBU6WrmSItJbEz5kctzgTyacxBj8AGQj+EYMxhRlAlP7aTH
 yOQ=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="263193339"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 17:15:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPY5WMtGA0VrS9XDMJn6sjeoXCpRv5TOuhHv1ypH89eXWd8T4whw4ZqVXYCgXw/vzjY562aH7UBw7fjaSOW+6L6SAXSAkVshoft8aMKUou21k8IdGO0EHUchiZbFUauWzea2RRn225wPkuciqQgE2atz1FUU02gqJxUIcbYl/yl4MqrtX4FoWgp6wu3XrPCFCsK1CejgKxUE6jQ/CXaof859ZwCGu70MuCEuFwtG6pj32WD6h0KC5UAhkJAzoFqMgVvIjJE0KKxs9mWSjIlI9FQPq1zsuBGV5nqcb+SIj5ONq1kobbo1hSvBaFKda/+5paTyJ9XWHixME3vmYxUEjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RRx3ef/MiXRvMNLU0N/qq5t8rn58V+cbADovPUSw4s=;
 b=Q99/Aiz7LF/3I2jOzOu6bQMm/pBtJiKdRX4O6oJ8zgZt20w0Z9Ky0eHstOusdxIiAisHcDhONo5yTsrz6Uj5BwoUni02k6ejMoNFwQzPnGrr+SIil5syRXw0Ba1T68/vJMgKTIcT0uAQJ0bce5GKhkPkwtu/niDt2XVoCh2JO0WS6/i+Zrm17hGKrkDaA129WAIDrZLDpAG5wHB9VbBBOEZpswrQOVylQ0GRbGicm12f4G5D9u38sbQBdeox26KBZ3znVsJrkefThxauIEHW3jW4LAfS5ay3z3oqfm9g23vq5my8fhpAchHM4J4RC8vWlwI+nN7RftJ49POigzOD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RRx3ef/MiXRvMNLU0N/qq5t8rn58V+cbADovPUSw4s=;
 b=N7FERQOjlKWUWSTGAt3jMB0YZ1lfmgpZEOEGP/y0u3q8vRK7/s0DAJyIjVYB/b6Qk4ybBkRR+5zSR62bCA7noR9bUApWXDT9NP2d6F0CEQQb1iKLeh1kCYA8LgZMoUrEXFh5N59+hb3cEAgQunLJ56Ak+NEjJxa2U4imf6DIiOo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4157.namprd04.prod.outlook.com
 (2603:10b6:805:37::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.23; Thu, 4 Feb
 2021 09:01:32 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 09:01:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 2/2] block: revert "block: fix bd_size_lock use"
Thread-Topic: [RFC PATCH 2/2] block: revert "block: fix bd_size_lock use"
Thread-Index: AQHW+tJckzeVsveL8EqbiqYBSLlIvA==
Date:   Thu, 4 Feb 2021 09:01:32 +0000
Message-ID: <SN4PR0401MB359853B6F1875CF1233A495D9BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210204084343.207847-1-damien.lemoal@wdc.com>
 <20210204084343.207847-3-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:51f:6b4a:2171:57e6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57a9e11d-6493-42f9-8c97-08d8c8eb778f
x-ms-traffictypediagnostic: SN6PR04MB4157:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4157492C1B0C3C0AA5C6DC699BB39@SN6PR04MB4157.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /hHgdy50BBeJHcw2A0w2cV4J1iGB2caBjyVUeXv9NHMZINMiE4OTWunMHkA7WHbfs3ofr61joo4STGnhhIUoH+r3hhJcgasobgc3uAEVjnYRJGehpbOVD5xsE6i2PdtZ86WuaVcu2KZ8GmmVH3dQ0kmyKAwuDukQpSwh6qZ1WWjQ+u+IlTtqdL1nZSpV+UO8T6e0F/HQJ8QT1pRH/co0yfjdjtm2dU/bAtwA4ctOwvY8tUFNam6h3bJdxGZauZ/ri60lMbtHTt8D0rRrdN2yyiHM5KlceKF1diDay2uOPpbkv8EdRnQxsfwg68o0Cyq1Ji40nY6gAeZ5rFfXUYFngUIC1gAXPShVCWqDrJRke8MhwvixJanoc8AKC0u8jtNiogpIcvfpIrOdDxgW1zM5BNLnlFvThL0Az3wwlfKTjd2IZfZ1bfxp4BPZHWD3/Dw2IFiaNrXfFcOObSJFtObr2cdRYeYgf8X67O8+Rdpvcc3L9Vsg0JRBL5lV+keziUd6nb7TYZ5c07zLsTfCPfEngw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(66556008)(66946007)(52536014)(66446008)(6506007)(186003)(76116006)(64756008)(33656002)(9686003)(91956017)(7696005)(66476007)(55016002)(316002)(4326008)(558084003)(86362001)(2906002)(5660300002)(8936002)(110136005)(71200400001)(8676002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kQbzScPPtYLOt63zt5cZC8XQeYjiB4DD+NBDSialqqxl8fAlvXJ94+/Z9dhE?=
 =?us-ascii?Q?rI32MDX/jZ5mzIKw+9wp287H7Qz1gXY77vJGgP2uR2qczwqPD+DhuyloEvsY?=
 =?us-ascii?Q?i29iTt1EcLE/5Phf3qj5Y/yRKTGv9/GFjtLDJK6lb1RpHKzQRrM5TOeOfxRB?=
 =?us-ascii?Q?m3fP1k8B0aJ/2qsljipRrEzesvRBcqPrUX9V9FTswQnjZl2p5bVEemrD/DsZ?=
 =?us-ascii?Q?0Foaip6zjiQA4vqciCLwnUuOAQf9HSwTvDfNDhYL+TVdIrHtdRfxRjSuVWsy?=
 =?us-ascii?Q?uJjwzHT5rfLn0/P9Dw3XyMbXqDdiQF80mqsEf6NWh+qKcvedL0UP6tAiC60y?=
 =?us-ascii?Q?vB/1SBy7y/Yh+WGS5HqXicak/IC0Oq+F/lxrseSvrrhnmA36dP6JQoXeQM0c?=
 =?us-ascii?Q?nY5CZ9ZiEty5bYjUMmPj90MfPmQMPW5N4Ld4JOnLJDpSOLyXPtt1zeOlROwD?=
 =?us-ascii?Q?KEeSr8CQ+VNjly4ZWfZ6Nd05suxibZ6cWFYoEIjC8QjJPAtrjMAt5zZHkGEm?=
 =?us-ascii?Q?IxwOCYOsvWyfUH93eS83bCAv45RmOiMMpUnNk2HG6CCbFN0xLng9SeTyURDr?=
 =?us-ascii?Q?RlU6erHhhVBLTc2N0RdwgwoqyP5Qlj+S/2MmeBhTBPFtc31svLIHD18TVvHs?=
 =?us-ascii?Q?2zOGNJwEd49peclN21kcPGo3IgvB0m0NmgmlwRqFimH+qdhl5GnqXIS5Yu/6?=
 =?us-ascii?Q?2ueUSLv8REeYWo6vsj9Da8B7/nlqmCjslLc06qVjtzSKEmWPb1qQrtZ0tWUU?=
 =?us-ascii?Q?BbU4GM88MwrBObUJ/7jweR+HJ7kGleml9B/YDhK2QYUcCzbyfqy0ymMVKwbV?=
 =?us-ascii?Q?R3lZw4MSIIkXQSYjAEzqEo2eVP/6xjsOZWgRALBg+bwuhtiIz0WJLbguLx0W?=
 =?us-ascii?Q?077a8caGIl0VPIdtok+a8oGZmCMsgScEIpHHaaiRPFhhKdYkMoTajaNb5JuN?=
 =?us-ascii?Q?/0XHf2bk0uiKQnrULpqrYX7L2hj109rPKr42FfduwHenL5C9+KdpJqcP450p?=
 =?us-ascii?Q?yoQflh+8x8ONVjg7QEe5jIo6U2FtmF6bKDeyosm1O8KDa4NS+WI44Hnr8sPC?=
 =?us-ascii?Q?rrnWBfp1XwJyyYhau//MqEZziG6SJzjOmpTSnW2xwoCPbDQI8GtdcSjxpY7z?=
 =?us-ascii?Q?wJMGrGsN27yu7ZkXGaO6WIpFqH7VSA0AnA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a9e11d-6493-42f9-8c97-08d8c8eb778f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 09:01:32.0112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hCNjzVfsAIA+sggqoKvp/0ibORXmBlunND0GpMJn/hwWHfZLkPFDoU8gEAHN7eSYsDwRczyBwEUA4ewSAJBzNOd1O1ocFidKpk0Ot5asEyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4157
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Given that #1 in this series is accepted,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
