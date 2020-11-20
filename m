Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95993C63777
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 07:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3220722253
	for <linux-block@archiver.kernel.org>; Fri, 20 Nov 2020 07:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="SmE8w/hD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pVnWgu9H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgKTHbc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Nov 2020 02:31:32 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:32796 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbgKTHbc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Nov 2020 02:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605858704; x=1637394704;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=SmE8w/hDgMTin+/pB12GxA0tLXzXbBcUsiQIH7hnPtWV347BhIluMDGE
   KH8l7sTkMUUUDxtaNvc+K1UdbDiaYbA2+j844VzIGZF/Jj9O7ClqCjYPQ
   4YjLoBv36lUI3tVnX/wzDv+vWIaeO8pjFBGXog477/szcrll2VqhUGzVl
   tuZ0/kszqWqJ8FaCO1/3Rwabdi/1faXMLZP94JzW0DPBY7D2K4m8pxzq6
   WV2SyJC6h46tj18EF9NUJyZZIIFs+oJvTfZ2cEfBqXcJxPhqpbvR3jJCS
   Tv/hnqj6VEab1C2+LUfQeSo+Ctkj27s4Cn95RHIXRpOrO9hi9rRwP0T3c
   A==;
IronPort-SDR: +L60eAMwz+co7pdBLcALGm8MtgEjWxl/RrixnFj6URM7cyiAV4wL1Ci3Hmi58s1lKEzpgeU8mp
 TCrfqWLObD5MTvB9IaSIKZHDDc8OctIOpTjGuAB5jN7vhlWrxF+grGTQ6mZjRwgqP9EM3J94eO
 xN/KsCMSCai6vegkL57s4RNUWFZLlUbKZQ/NrUvYSqM/50qFL06kZVUsSxR3XogLFO8/Pvay/J
 9SEHj27YiAtDsiduGOBW3fFJRSDqn2ZB6mOM1YyLOgKWWyL2cR5IzKwpecE42kDTVcimyzwRkL
 c0w=
X-IronPort-AV: E=Sophos;i="5.78,355,1599494400"; 
   d="scan'208";a="256660918"
Received: from mail-bn3nam04lp2056.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.56])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2020 15:51:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlhFDSqxLrvymaaFEnPZcYNbWm3y7wU6+cfy/BwCC6ymMswPudxpW07D0hnBQaWgdu35GJGFxl6Oz2SF2Jb84tf98rdE+cVhdxNmDYw6gXHoOwOZEy/dZ3mB5M0afs4Rm08nCWTtHselbqPYiuXyH2SOmZOUtCXPLmSp2rnEBjYYTyuu4XpxIM0TQOK/FVFaL2sWRIathTcz4VGoDtVyLhawUD2lYoDwL+Wp8DLvwYAk0SJ3sJoZBU76ZHPyXCxRcwkHNan3L3Hs8reSlsXrY84MJ/ghEIXE9GyM8GeGsNHN0gtbhXn3j5+oDqt8kfuZJU4qIKtHN7iBpuaD3o+bJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=l2fjKIDIRFPo/B+Q22KUu85CMe6sDn6b/01hMxvZKs8vEPJMGG7dHyXcZUtZQuExNk0xb+WUAmGYdZCmUdDB29tdzTUjc7sxzS7tY9agBPwKUXFm1ZMdIhrcL39+bNrrB0Q62egPIHnuEcZCfWFHdeYeN05tvhTYn8i9Ag7iZ6zc9j6y+P3//iROfqtth8QpxAF4B5BMddgfifbXUPXXNDttR+u2FaQM42EHTVHgnupB9/o/XoUPNBZrnMceW2fxpYM696IUmVjal3ri5NgJTdO75G5H6Yo6pI0/tOq2OzMk/PsBIfX8yfIb71XZiWvNYTi3SlxMuK1XyHmsSQDlWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=pVnWgu9H8j8d/kW2TsHrFWDEOmdc71wwt6ZoBMXiJtfOJM1rLh0YQf/lhz5TbFfJIdtiI2SVTAdlTLOM5TCfFBqOURM29gaG0y6ZSxZCqetIvQBvw0Gb7UMRn+U/dXYxZpw/uWy0A0IWv7RNCc/LLLzQ1O3qhA6QWQ83PAldmwI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5326.namprd04.prod.outlook.com
 (2603:10b6:805:f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Fri, 20 Nov
 2020 07:31:30 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 07:31:30 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 5/9] null_blk: Improve implicit zone close
Thread-Topic: [PATCH v4 5/9] null_blk: Improve implicit zone close
Thread-Index: AQHWvuCGSXSn25AaqEKOZFb1eMSGRg==
Date:   Fri, 20 Nov 2020 07:31:30 +0000
Message-ID: <SN4PR0401MB3598EC37518668B25F3A9FDF9BFF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
 <20201120015519.276820-6-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:157d:bf01:851e:5636:4e29:3e2e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 39ac7195-635e-4fb3-0007-08d88d264c4d
x-ms-traffictypediagnostic: SN6PR04MB5326:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB53263A2B9A4E0D177C7BC0619BFF0@SN6PR04MB5326.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MKaXDIytES7kiN+YI1rl3wv2ld5EnmeJUCTAqo3KvmpZmhtyHOKltVKRnYBYPdiZ9SUbZJDDJ0+IJC1Vx1Hzh1sG4gTskrp0ckOce02C9hMNxO8k/CdKrhKUyTaphWQzPIb/ozgj3VlZZUIHwkr+t9sgB0dv04Z/jdXWQRZyqUsl0/a+S3VRs6y9BYOARiM7WmunEgjYp75r4JqIj63O7xaK5NppGmBB0u48R0+0ah6Vof/qHHIrU+UeG10ACk0wA/3seVYavFwmOAI9B0heGAvfnTxIfQF5xl+xniM899F+p6yTnILvZr9ky9u+b2sQzt3MFQfatJHmBpNhmBCa1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(8676002)(91956017)(66946007)(76116006)(66556008)(86362001)(33656002)(71200400001)(4270600006)(7696005)(64756008)(2906002)(66476007)(6506007)(66446008)(55016002)(5660300002)(52536014)(110136005)(19618925003)(186003)(8936002)(9686003)(316002)(478600001)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: T3xXSzikuJrIDK9UmsV3qUK7SiAO9YchqTz7t9dr6VoiV8YJZGaz2VaLtQfKl++jIqYeVnlm9FzeVJk92UiOh9wYOQ8FDRs+CYh/iHuT5ukE9EeCinCUXAHqv+4fFFolCyWXqeyc9ChoppqEeP0g+AUQS6wcdfw4hsjFIFKDiFhGh5j5EgRfzX9PEob89qYKF9cROwGTkzSXI7VSHpR5+kxDbnanMtvfW2bqOU1tIgiw2ORBZRmYuth8ksk/VBvA6XBcVx/hKQbPxFVquFDPsnx0jt0aaVVF1CvrC20UsuxsFmxM5jBT2BAErp9KW930iDezKJJXcfiRjgRaPi28AtgGosjRYSNKIn6sisDps0f8Mdyrokzq4tzfiKJ+6IazBeY1HYxQI5b+Gv6U07UtOXyZOMQQowmrb7v3rDLeBEul0pRHogmYou+8c7sprg8v/a2OGOZ06SkiwtWAnyRVVi87ZI8zEXlOru+ComIz51DZv/QKG9aKTytD90eOdjm+usX0HBAyABi9GiXpOl+DdlnDKG8CPihgGerjzOJ7m2zVcdHGHMaTholajX5dmLhqBNesDszqAT2upqKX18mLOXx8XLCyG7tB+/Mb8H9Uexb+Axh3s0zqwGm72Z7hbCN060O2trrQlgpx/lPmzlBetqCiLQnFTdA4IYmkcWSN29gf9BL7YVPHc6IzczbGPzFJbL5cs4ATBE1RqF1AYtkbrA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39ac7195-635e-4fb3-0007-08d88d264c4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 07:31:30.0364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WDdLx2VkPgSjqQiSl9sxe4ij2GCKUvAlyFtlCB9FJlGCrrPLpcJ+LaUiB9W+NOxG/cxBGYJVT1tZZuV8xfk3xH0CnxIqbOLvt7n86/UusJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5326
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
