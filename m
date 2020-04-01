Return-Path: <SRS0=ADX+=5R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5819C43331
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 01:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B3B20BED
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 01:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Xxqn3oke";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UI80UThA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbgDABwx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Mar 2020 21:52:53 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58503 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731506AbgDABww (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Mar 2020 21:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585705972; x=1617241972;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=T0r62fl8229sZ7pntIpwHapRrikBFpc22dOgIb0VBzc=;
  b=Xxqn3okeoiZg7ywJez6WoAGCtqntTQOGAwOYpTPNbInSTeTARQKlSF7v
   3nkP+KIcipLWneOcLC/nJ8RSFtk6hzI+1LdqRYyswwNf/8AC4bCuUPsCI
   uz3FqFgASEziDZm5naLFQOmn3iDGaOYbsstuXmVieG4GRr2JZ7Fz6LFTX
   jbYVpwJ6XBeY7+0QhRkGsQbe3N3KVV4IL1fpY5Um7KNd3mause00lAQuW
   cX4jho+An9yJkSn3bRvWpzWK8Ef03aEDnFHJY4yy/4cK4A7aKeu9+aiV+
   yEfw0TPCEubSsYqSjS5IYpNMWES66ocLxz0LBaPJBWfK89NQv/Cen8cp7
   g==;
IronPort-SDR: 2pbvWcMSVIqZ479T0kQBrsteXkf1BXsSMKhrlTEox/XIskkDT+NPdUBXHGQcl12sYbhd93aGJb
 Aafu9BAXbG2JfdYNpcpBxjLsgSiSONAZl8NZ5K/me2/g5qSZpt7UZ8HcbbCjsNQujc65isImRr
 v2hKas7+/xG/MBStOin1RVOUBA2zX3dSc1fcI3LycMS5Bx0ptct0SErpOqdIVqzIHnvH/hQbXX
 7IB7jnka4DZcVPL3CCer1fkX7rICbFWsqdPo48jXfMAsQfDh4/b7G1sQXX4rDc5Fi1IPVqbn9O
 +K0=
X-IronPort-AV: E=Sophos;i="5.72,330,1580745600"; 
   d="scan'208";a="135622685"
Received: from mail-cys01nam02lp2053.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.53])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2020 09:52:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iC0YVlWGRDFcE9vMPmQ9UWw5ryiL3t23NZSWVAlzUvn2pr+ANqU08HaRoml+jatDQ6zUTKSfyOWg6yFPKUC8lKRFFDM0UFOUFI9DHPHaUMOsY7zST6AuRM0xbjuiZEORebRgS3ZjrXNj9ZuMYRZijq6cyuW8nEipzpxuKIf2Jhnnsr/M2cHz6gTK+FKVXqIa2TpsEqhZl6pnPtHVU2rZbrZglIOhdEJ/tpFPwqQ9WSYftPnWKmN5rngefzRiHNrkxYyABHerX7g2i3kL8HoEQVhCU4K7rXxzqSlr4s//e9Yob3DzzinVKekdLFu0CxYWFz79KbSNAWiF6nhxRzWaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0r62fl8229sZ7pntIpwHapRrikBFpc22dOgIb0VBzc=;
 b=C9dhbSqLovXjkGZHePSCnNYb2yzB8C7MUuKLg2L+yGXZoJ1GWGLsxt/umaEIoqiv6rXt9Y0DhPaWnufEzm3W0gpQRr/HUgDYNjEg7ogTNryc04endOZiJPnqDG3E/dWuRR7DHA7Zk+n8f97gr6WrwG53rySIg4zUCcXKHCwihaz70S2pwhbhpz1TOnq1Zx7aOv8ZjBXqLG7bXwAXsf0gxAa7tewdPCzHBTNjc4sPdIPNepFyr9JKc52Z+7HwrMXJ122V3D0tIg3DjsrmRwpBc2i+7urABuQHJoMWOlUfHhhZ5kpIZV4QcenrReggkXGVzOdITvxCnRCf6THXAnPIog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T0r62fl8229sZ7pntIpwHapRrikBFpc22dOgIb0VBzc=;
 b=UI80UThAvnawwOVA4vS3xMI4wqUm6m/ss8HfuRHCI0rQ9z06OSGT4a6EqcShPn1OnkBub9O61sI1/mXMCKS8bCK6BbVZTwIhnYfOUXdzhccYEMS9EGm31M2lREKCYyOhaMS4Bnp9U6N61mrk7YsDstesn+kI/nbaUJ8NifcQMj8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5189.namprd04.prod.outlook.com (2603:10b6:a03:cc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 01:52:49 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 01:52:48 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 1/2] block: null_blk: Fix zoned command handling
Thread-Topic: [PATCH v2 1/2] block: null_blk: Fix zoned command handling
Thread-Index: AQHWB8HwVlc7E0TU70aw+swFUeaUzw==
Date:   Wed, 1 Apr 2020 01:52:48 +0000
Message-ID: <BYAPR04MB496553B2A4CBB1559587F20086C90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200401010728.800937-1-damien.lemoal@wdc.com>
 <20200401010728.800937-2-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 11bc6896-6893-4d09-118f-08d7d5df61af
x-ms-traffictypediagnostic: BYAPR04MB5189:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB51891D316B75D51D0BF7CDEE86C90@BYAPR04MB5189.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03607C04F0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(86362001)(8936002)(7696005)(110136005)(53546011)(4326008)(6506007)(316002)(33656002)(71200400001)(2906002)(81166006)(81156014)(26005)(5660300002)(55016002)(9686003)(66946007)(8676002)(478600001)(76116006)(66556008)(52536014)(66446008)(186003)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZzsaMalVFkxE+9u9nXrMbJfOapbStRxSpOvNxOG/DBNCGqA5dffE4GD9YziryS32GRUNQQXCpBO3YUQoJdGN23670eHZ2gohSlLtGmAFGKbSEaijqgOuzYAwGe6LxQwvZeGcsvXY7jWXNdq33LCG3dUMQEApPDWckkE9FSZytHkTuzfiQPSLc3rmv6CQGRwPeQM7RTJm8CPGrgtBe0hPwA2D8K9uoOqIQTYB3d//VoIkVM5G/TkiNXLquIqMMiv6X/0RPHtHCeN93xDWzM6InODoXVoy5GjmmNJMSLRcgr9tGyBXz67b1/AL4CYgnBl6osBaDw6MwA5F4/V750QUONeLxraKJaCXuNxqPKVMwNbPcGTQd60r5uU6R7Spg6EtlI1K8iTCLZKqJyW7zbiWDD6gflws2U7RfnQKqnEGqYek5Mv6N+nKxZDLMT0NgabC
x-ms-exchange-antispam-messagedata: 4ZqxF8lWmyY29RYIO0KPkHHei0E0JVMDOSUdJ6i4JBp+Z4vz4LEfBLRVLX0Cgz8kQizHxWGtw7yuRXa4TrUFfDoh4mK/qqwNhwg2AkI4qYIIU2FH5lZH0+XLGFOTVjtivgCJDBmBRSRZQAxEUD+9zw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11bc6896-6893-4d09-118f-08d7d5df61af
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2020 01:52:48.7901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 37dkO8Gq6CAMYhGZytA5KKkbZZB1u3A65S8Mu0k7F2LsxS1dFc+OfY+hINf1ceDKGjqcQMSFvGn2dxj6Vnk/USOY3FCtwWkBqOV5P6CGzGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5189
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/31/2020 06:07 PM, Damien Le Moal wrote:=0A=
> For write operations issued to a null_blk device with zoned mode=0A=
> enabled, the state and write pointer position of the zone targeted by=0A=
> the command should be checked before badblocks and memory backing=0A=
> are handled as the write may be first failed due to, for instance, a=0A=
> sector position not aligned with the zone write pointer. This order of=0A=
> checking for errors reflects more accuratly the behavior of physical=0A=
> zoned devices.=0A=
>=0A=
> Furthermore, the write pointer position of the target zone should be=0A=
> incremented only and only if no errors are reported by badblocks and=0A=
> memory backing handling.=0A=
>=0A=
> To fix this, introduce the small helper function null_process_cmd()=0A=
> which execute null_handle_badblocks() and null_handle_memory_backed()=0A=
> and use this function in null_zone_write() to correctly handle write=0A=
> requests to zoned null devices depending on the type and state of the=0A=
> write target zone. Also call this function in null_handle_zoned() to=0A=
> process read requests to zoned null devices.=0A=
>=0A=
> null_process_cmd() is called directly from null_handle_cmd() for=0A=
> regular null devices, resulting in no functional change for these type=0A=
> of devices. To have symmetric names, the function null_handle_zoned()=0A=
> is renamed to null_process_zoned_cmd().=0A=
>=0A=
> Signed-off-by: Damien Le Moal<damien.lemoal@wdc.com>=0A=
> ---=0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
