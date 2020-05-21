Return-Path: <SRS0=t9QE=7D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB278C433E0
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 02:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77D70206F6
	for <linux-block@archiver.kernel.org>; Thu, 21 May 2020 02:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fkd9Wzph";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UzEXV+Lz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgEUCTI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 22:19:08 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28220 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgEUCTG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 22:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590027561; x=1621563561;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dIbvKgE8dwQNf2ZCkn8a3pkqo/c3C16tYPG6lb1f6Nw=;
  b=Fkd9WzphputJDQu1jH3H+c1IGMgFMyc9/4x0ctGW1a/WgrtkhxI3rtag
   YPB2d1mxmvY7WE69PX3WujzG7qDwzLylpt0aidvGpHWfeJ+8jBjJosql9
   qN1shV9TtE36nlFpUNv2xozML7v8WPlNUpJprEGnTLnNW5Ws3TMIZuMcv
   vz12Kgdn0410/MSdwdUpO0gzhb8Pp83NKzAyjui7LzaUTkxejmswf3Cbp
   jKJox4jSYae5dmV6qWrE4jFcL2dA+Lt10EljgK5IkmKayt6m07TRt3M4w
   dF43df/0tB8BpGW+3SCLw+GsAHSJeiwWEEKZUMUR4GLi2soLambgr8eGP
   Q==;
IronPort-SDR: kbpF664y4HykxlKFhWywJtqQmHLDh/l7FoZ1NAOQtjX7UAcvRAx/hWvAcn/Z2Nij9dYelKjg8g
 +5SA4KgERWbcc3vcKTEEEY2vs6xQ1ATEeAPbzVqlMjVN9QbkYZY1Br5H/ezFVBFg7T72XenbBH
 XNIC0ZRohEP9+GituouFjstb8lDYn+984Soihjzyx/zimApH9n6p9LqF0tA+qfRFBzfFZTEhCR
 PZoNKGEqJjK/OCbhUJ7CowaxaNDWttTWZahywfdphJIjrln9m9FGp8FJumOqFh4A2r3fwxopWc
 xpY=
X-IronPort-AV: E=Sophos;i="5.73,416,1583164800"; 
   d="scan'208";a="240928766"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2020 10:19:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NMrSVFHhbRcd28rCubcF0mrtTP4hHvUcEpplOelWaiw2r+IewZEP+ZA7KvleyCFRS9QkWR20JE9BdjnKZZf7dI6l4m4GYdB/lGPBCOQfewrUQbY6pAGe30hwDG/q4ziU0tRcXcTcwzpMMZ36CuqFltetbsiOm1ScnNXCmcLyJW94RLpqi3H0nNYgac/ldI8Jie/f3BMoQKwH681d4lN+1XZRRiggWOv2O5u2SU0T4/yNdM/tPY4st/PQoD1SXAdgKaao92j2K61cT+CvnUOWceNkEOFWHvzi8xwRZ5OdxlVy+VDw4DYOuMCvMRFO2NB2S/YU+Ad/u58nXKtPrnaHLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEq9KKzVJnDIhJH4hBUhkDn0IpGj/iAcag+NAiqGSWs=;
 b=lG3Lr+xXm0eeynI2i5tc1V9s2KBtXETniggHWoFYFXBcYncxvvylnT/5UoIwIS8E67OA0PZAAoIHnWJE38x5SIBd9LoSKjdUBPyoF3/qKYFn735Rh1pWzeZFuV7inJFiK5TglauiKnmiphN8hCAAvPY5my5boKPhOoOujdH/pgkEl/FU0sH7zbr0mvTCHfZjtIQiABr4loV2Irooi6SaYx9UQvq/2LMPsGeEPvRis3ejbb6w9LgaARwSJa+uXm6jg+j9ijASoiJo/n9D+5FB/tQPyTPoXyIfw0dtiWL/f1xq9ZyfPt/vS9k09FQSkxuWOVp1tdTDSY8ax9yxVYJIIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEq9KKzVJnDIhJH4hBUhkDn0IpGj/iAcag+NAiqGSWs=;
 b=UzEXV+Lz3wWP3zW1O4eEJuYsy/DJy+i+VoxYPeauF9RW+goTZxhXAVOhhKoLC7w9NWoWdVEY9OhnjoU7pLdKISfFwbZU1LDKZ1pvKqLREwQXcPLjdebU09HwzKgvz+PtVKh9QsmS5cGtNbicSZJT+5Q7paX6iBvYLXfm77CB34Y=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB7043.namprd04.prod.outlook.com (2603:10b6:a03:223::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 21 May
 2020 02:19:04 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%5]) with mapi id 15.20.3021.020; Thu, 21 May 2020
 02:19:03 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] null_blk: return error for invalid zone size
Thread-Topic: [PATCH 1/2] null_blk: return error for invalid zone size
Thread-Index: AQHWLvqwn+S5DK8XREikqvtYaNWlnw==
Date:   Thu, 21 May 2020 02:19:03 +0000
Message-ID: <BY5PR04MB69003201220D4DFADC4B0A12E7B70@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200520230152.36120-1-chaitanya.kulkarni@wdc.com>
 <20200520230152.36120-2-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8977393e-aea5-4dac-f09b-08d7fd2d5515
x-ms-traffictypediagnostic: BY5PR04MB7043:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB7043D5B8EAD0C885FD215CFDE7B70@BY5PR04MB7043.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 041032FF37
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9i4uFXdLFrO/jDMzzTScMtkaT2uwmWN7CJJ60qH+5vOe4z/pnDkfMfaLvz+1/Ed15eM2wq7UEbxHy4Auv2C1iSfx6WeAiaCqXGkN/7i3apJAdEwGtCGxuFH7qT8iJI3TefN4BBIaGjIPM9uPTy/zeHKdtDSDF15j4lPUmzYsI914d6tPNiZdFItgJV9JiSP/esKWiku33A9MlLCK9Ub0J5nhWFh02gra7Tqn6irD4+CVB5ZbtKfmP1VNzgmkVQkbfAV2uPP+Ib7wbh6XiRw/xF+HxyvgW6m0g1cBz/l4YG47uAf6P5kj8VwQFhLR3VWN1f1W6k0RjJpQMGOIkv/N24FRAGpcVYJe6kjqP5oKqPy1fFfeOnfaUp9HuXf4og0NYAKpNLvZL7pCFF3tWYcB1veH92bINTOic8/4QDODdw2k14rT3mOxS0BR2Ssl9Mw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(55016002)(66446008)(9686003)(66556008)(26005)(86362001)(66476007)(64756008)(76116006)(66946007)(2906002)(6506007)(5660300002)(53546011)(110136005)(52536014)(8936002)(71200400001)(33656002)(8676002)(316002)(7696005)(186003)(4326008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5XrVA7238L56YBGZNfKv5L3SJGQuOSQYXzeqoCeTZYUXAEWg8okw45IIrmJFZ7r4nC9gwJGLt0OlMqNwqaSjTdu1CslKVpFDnLyPhnQslw2nJYmJclPqKN6RNrJQkJTA0JzUXAlCqIqbg39t9UOR+GOukWLbDxtqx21TiXvzHf65pjR/993Bjf/1/s9jfJCcUZEg5obkqt0Ooajf6o03YIrszAkR16ibJyOS/bgmHOxmLGRQbD3YXv5V7rXfSIBTGt8eLS9JPmJJBqgslFQu7IaT6yo9GnH6Vt7MU7GgP9XA29c17zSMlhbqWcoNKqK19MVap36qf72dTFJcTiFii5Kb1h7V504gd4yhYfaAKSpb0BoiHWAtfYlmQgbw+A5hYfWl3c1+WNyAVq0wCz+cRh2ORNg0ADH58CQK22opXSEVIHOTxwEirOTjTzH6RNMrKK2W/heyk33YDIfNKb0lCoh8t2JrXxR6+S0Yf/heA2yu5UCS8MZ3i2c0zSAtVlUu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8977393e-aea5-4dac-f09b-08d7fd2d5515
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2020 02:19:03.7926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJPxC0QVVqEmqrIrEo/CNepeRExErdjznvc71w9fcHSlwe3StWX1ip7gCZ2oj+LhInxGT/1f2CRkhK2KJHqMAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7043
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/05/21 8:02, Chaitanya Kulkarni wrote:=0A=
> In null_init_zone_dev() check if the zone size is larger than device=0A=
> capacity, return error if needed.=0A=
> =0A=
> This also fixes the following oops :-=0A=
> =0A=
> null_blk: changed the number of conventional zones to 4294967295=0A=
> BUG: kernel NULL pointer dereference, address: 0000000000000010=0A=
> PGD 7d76c5067 P4D 7d76c5067 PUD 7d240c067 PMD 0=0A=
> Oops: 0002 [#1] SMP NOPTI=0A=
> CPU: 4 PID: 5508 Comm: nullbtests.sh Tainted: G OE 5.7.0-rc4lblk-fnext0=
=0A=
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59=
-gc9ba5276e4=0A=
> RIP: 0010:null_init_zoned_dev+0x17a/0x27f [null_blk]=0A=
> RSP: 0018:ffffc90007007e00 EFLAGS: 00010246=0A=
> RAX: 0000000000000020 RBX: ffff8887fb3f3c00 RCX: 0000000000000007=0A=
> RDX: 0000000000000000 RSI: ffff8887ca09d688 RDI: ffff888810fea510=0A=
> RBP: 0000000000000010 R08: ffff8887ca09d688 R09: 0000000000000000=0A=
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8887c26e8000=0A=
> R13: ffffffffa05e9390 R14: 0000000000000000 R15: 0000000000000001=0A=
> FS:  00007fcb5256f740(0000) GS:ffff888810e00000(0000) knlGS:0000000000000=
000=0A=
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=0A=
> CR2: 0000000000000010 CR3: 000000081e8fe000 CR4: 00000000003406e0=0A=
> Call Trace:=0A=
>  null_add_dev+0x534/0x71b [null_blk]=0A=
>  nullb_device_power_store.cold.41+0x8/0x2e [null_blk]=0A=
>  configfs_write_file+0xe6/0x150=0A=
>  vfs_write+0xba/0x1e0=0A=
>  ksys_write+0x5f/0xe0=0A=
>  do_syscall_64+0x60/0x250=0A=
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3=0A=
> RIP: 0033:0x7fcb51c71840=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
> ---=0A=
>  drivers/block/null_blk_zoned.c | 4 ++++=0A=
>  1 file changed, 4 insertions(+)=0A=
> =0A=
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zone=
d.c=0A=
> index 9c19f747f394..cc47606d8ffe 100644=0A=
> --- a/drivers/block/null_blk_zoned.c=0A=
> +++ b/drivers/block/null_blk_zoned.c=0A=
> @@ -23,6 +23,10 @@ int null_init_zoned_dev(struct nullb_device *dev, stru=
ct request_queue *q)=0A=
>  		pr_err("zone_size must be power-of-two\n");=0A=
>  		return -EINVAL;=0A=
>  	}=0A=
> +	if (dev->zone_size > dev->size) {=0A=
> +		pr_err("Zone size larger than device capacity\n");=0A=
> +		return -EINVAL;=0A=
> +	}=0A=
>  =0A=
>  	dev->zone_size_sects =3D dev->zone_size << ZONE_SIZE_SHIFT;=0A=
>  	dev->nr_zones =3D dev_size >>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
