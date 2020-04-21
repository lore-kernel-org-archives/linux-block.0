Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9D7C2BA19
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 09:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F10C21D79
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 09:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EgTGUiOq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pOx5Zpf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgDUJKn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:10:43 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21364 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUJKm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 05:10:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587460242; x=1618996242;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XBHd7xrxO9Yuspti8d87Ae9nn4TafOoUKJziCm7jDg0=;
  b=EgTGUiOq2HJ6YgxTblHEGuy+wC+WJbiGLspiJg1Z3vqugCXHZN7CQD6k
   eXIJgKcb7Ga+yL6ZjRkhPxcayQlRFsU/Tt4ygY7lLLEhWq6tUhiWolp+j
   wf6ddqmNUVrTHPUQomJRgxbufqOwHdAF7ss5btCPkdlDaPRQXjNDxgMvd
   WEsqHt3l0qWsn90xQ92RhaYAhACaDo5AmgrgafzhSi8o/QpzFJ5m+KZVs
   JAGDfZx5oWZMoVJHFmemUgUJTp/DMZyO4PLuQcd1i0CgzZoZCI5CZVjhZ
   BUezCV8oZGn9LQHjKLcBsFWaQHtLYkxbHAfTaw6IV61yOjUTclSuOfnFm
   g==;
IronPort-SDR: DG8Nso9MHgUJTaWaVE0min5esb6IfRdfWgO8H0c9Dfjafo4gmpZHUWPaT9uMWwXH4lIYyGwE+S
 zN1D0zqsV0tGvKpkSRqGsO1L5lcyNET3m0T8P08aZ24I5sMlDTtZzFqx7CIPYFMCRqFblFZEl8
 TOEThHH3Wd2mSfxgLyj9DR3czn+2nYN9qK/yDGvllRjyahuLTctY7fgmODguNUyNdJELNapEmo
 Vsr498Rj+kXsyyAOlnzxeL2z/Grmtkn0DitGgmg3NvadBFV/S5hQGHQQ24JRm9IukJDstJ1sC0
 gUU=
X-IronPort-AV: E=Sophos;i="5.72,409,1580745600"; 
   d="scan'208";a="140136621"
Received: from mail-co1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.53])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2020 17:10:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsVq8WlTtWMkR0l1xLZs4VHcoek1fRe2BuglnidZYB0W/+F4pFVOW4O4789UdyPuM/4clSDkYdhSptsXjqvDHNQmwsATYXqr+RzYX6Ye4MDiEze8ng/OREbIsfWiHl7jorp9KSFMf8v/4N6j312+dcBuD7gmK35HXeH8RvpLA7w1tDLBRXGilymD+WsIjm4OqE6KbNzkCCzbDKs2zZy0LOxNxdg+G0gNjA9HFuqDwaODq1lycrXJ10CX/VGhHQ1kDQkZo+4kyrIgHiJCp+ZqGtDhwV/cw6dsCbx6RChgsCJSXAfJvzrMvzsqQAHB3jFX/r53cLyYeHDcWW2agxOmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyynwXW4XA8W+GNr47BXANvJyccz+U2h/29TJfGX7As=;
 b=QeV9BUq01qOLL0P4cLSuFwLPo79NRR7zIIWaMXycyJH04x6B4vks390679ynoGrOjCcLCJomCiXeuBgJ1bWqP3nHzuQaa3QcfA/wBRIpSYRtNrHxI4zTlcqlTVYJhJLaiI7fTco0/4cIfJN5R27V+vpxJsJsZeVt/v4mcTQXJLT8iADUbTliV4673KujxUTGSI+Iy9Td6zFupZq6yS+iKfsGowuQdZP1UfPwwUl2OhZEs6ZCwqtvqW5jCLeOnBjAScwudiPqqz//htO0JuSCm3Q+lA8Vw38tZ9i6lTbs2f+Y7M/JZPZM1rURG6w4K9/iWS17P1IUKoquux/V/+3WVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyynwXW4XA8W+GNr47BXANvJyccz+U2h/29TJfGX7As=;
 b=pOx5Zpf8U6klAQqIZGelEzZq2xDi7OIeCnGF9lV1cxDtvx8sq+IeJEGWjgqYuAqgPbrdtUF3xmM577pQWULpD5HvpOBrtrNDJ5YxQv80jaFNKwgC3RquqI2sHTdXnd3Brf/1DrfyqQSTZXrz7L+KR7D2m+QOUxqOs7HVYXwL678=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB7122.namprd04.prod.outlook.com (2603:10b6:a03:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 09:10:40 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 09:10:40 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 0/2] null_blk cleanup and fix
Thread-Topic: [PATCH v2 0/2] null_blk cleanup and fix
Thread-Index: AQHWB8HvzF+EykXVX0qquEPDKiPwEQ==
Date:   Tue, 21 Apr 2020 09:10:40 +0000
Message-ID: <BY5PR04MB69002C510DECF1439C33FD32E7D50@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200401010728.800937-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82745f4f-479f-4092-62d4-08d7e5d3dd17
x-ms-traffictypediagnostic: BY5PR04MB7122:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB71221A18F04D8B56AA81C5C5E7D50@BY5PR04MB7122.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 038002787A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(186003)(8936002)(110136005)(2906002)(4326008)(316002)(26005)(6506007)(53546011)(86362001)(76116006)(7696005)(5660300002)(478600001)(8676002)(55016002)(71200400001)(33656002)(81156014)(52536014)(66476007)(66946007)(9686003)(66556008)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DEXeWCrFi3vdNJaox+O8mQRFdztOpGpOYgXFXmLRucfYuJW2i0Xj5BP+fZgB4W8dxmrQDwNJIpfxzZDcuepCMMaT8XJGBwRkUPYL2ZScln1w7BTPqu4kaTp6xql7r3sVOMmmaSeGZkGv/SkFZzUxB9qiioVDNx/S3cReDEzoEnhoioX/OURVlhMaloZmx5kkn/ZFmx+K30idoObmJWQU25ErEUnXYJi9i8HYA4pySBUYSB+vGsat1z1dQGC/Cd/akiYscA4SuGPLIXRCe/Gi5975CKBO0ZJP+ifYPxgUcjtKwauMlzVfHGjeSrWpET63fdT1dc7XeWAhs1kC0KHNXRc5yByBSwDWZx04xZX/VWyXcjFLMdgWVw23UP9Hyvlm8Wt3VrJu32IXuxEwXjroYe/WFgj8/Wk8R7KGTMhZd6FWm5YcA22tSXXVONRYfjHv
x-ms-exchange-antispam-messagedata: cli1RbgSe3ihiEuWdkCwN+frbY7oof8h4JDPZ1fhdlvOBflo6xP0pLN+LqVEFK3I13UW5tydNqKqkzB6H+1IvR/SR01EIg99mUtOHFhpQYV/IW8DMu1HCRKAzAcBscYMVj/LjLxJvd+yVV+R+asdeA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82745f4f-479f-4092-62d4-08d7e5d3dd17
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2020 09:10:40.4390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MeFJir0KNK+4CSVMpg84s7uSInMxikdNNYWHP//xAkynW9weJD+nEGUMorsUpMR/hl1EsxdWm0we5uVNGrd8IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7122
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,=0A=
=0A=
On 2020/04/01 10:07, Damien Le Moal wrote:=0A=
> Jens,=0A=
> =0A=
> The first patch of this series extracts and extends a fix included in=0A=
> the zone append series to correctly handle writes to null_blk zoned=0A=
> devices. The fix forces zone type and zone condition checks to be=0A=
> executed before the generic null_blk bad block and memory backing=0A=
> options handling. The fix also makes sure that a zone write pointer=0A=
> position is updated only if these two generic operations are executed=0A=
> successfully.=0A=
> =0A=
> The second patch is from Johannes series for REQ_OP_ZONE_APPEND support=
=0A=
> to clean up null_blk zoned device initialization. The reviewed tag=0A=
> from Christoph sent for the patch within Johannes post is included here.=
=0A=
> =0A=
> Please consider these patches for inclusion in 5.7.=0A=
> =0A=
> Changes from v1:=0A=
> * Reversed patch order=0A=
> * Addressed Christoph comments on patch 1 (function name, inline, etc)=0A=
> =0A=
> Damien Le Moal (2):=0A=
>   block: null_blk: Fix zoned command handling=0A=
>   null_blk: Cleanup zoned device initialization=0A=
> =0A=
>  drivers/block/null_blk.h       | 29 ++++++++++------=0A=
>  drivers/block/null_blk_main.c  | 62 +++++++++++++++++-----------------=
=0A=
>  drivers/block/null_blk_zoned.c | 41 ++++++++++++++++------=0A=
>  3 files changed, 81 insertions(+), 51 deletions(-)=0A=
> =0A=
=0A=
Ping ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
