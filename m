Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC94DC47095
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 07:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2AA061354
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 07:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhFIHHW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 03:07:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11671 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234536AbhFIHHV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 03:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623222327; x=1654758327;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Bi4co2n3bXFdRSEhewry8IhUkqH0P2oOvruV+q5qRZrYGzy8vCLmoPFH
   VYWAhMONrGOykm2GLughugFbfPrHUJCk7UJs7yid8aqh1wJIaGDcPPVjN
   a+hvoWLJiy6DUVQfazLxrYEb/uYCWDwlkUhpYyG/HaLTfUay+snPvhbSd
   1dCh5+qARVuKKgUtUu4uh6VpZNsGRTLeqrFfs41F6F857OUFXFFbDJeBC
   wTlLZKZH7880Xtsb3xZwkAEzDKdDKH/wdh4XBYkc2d6//GtUJIPmwfXig
   UzjnLPBYoYYMZ2WKg/8XqlkKFwNnau48zpr8xyWr/jAYAR5C7gf29sIc6
   g==;
IronPort-SDR: o89QrKfpsZ//uf+4bkSkOJvQ9w0UdWeoRcQ8uz6VXh/J31nbZam99D0lSbF5/TQTwHBbg6Mepw
 +7RSaZUUTaal7saKK5hTqig9EQmXDQYR/yLlMcbc0Qu7GXZMdeJ2PsWB3uewe8gn4ssVFT9beO
 bK/J/Z4LRnZR3RIX4Q4pDHKJmbaOVAZgOEjD52W0adCoEex1sSjf2d0Vn1wGdn/n06vM7Tv+br
 yCERKwl95qUdC9/9+oVFoMYBZCf0syACwX7WRrUmyZtClOOLarCkDXQpQu51QAslTx7CBsCj9K
 Vb4=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="282697621"
Received: from mail-sn1anam02lp2044.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.44])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 15:05:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5cCOlxPKX/rbZrN2Hn0BGY8KYFsmTp8yQfrUzK9VT04zTxxGsAfL7L1mxd3L0UJXDThCYkBzDBosKTnljxmB+5TKgv0/r1V/AaCc9/mClo0qUvkiPWcT2Pyf2hfoPMryQZpqxuOu7jWBcKrFWqwJ9Fmr4quPNL5bZe6lZmbWMsWZBn7NTpqG1BghDA5zYuSvpHDZaTfGA94saA0zP69o9gpf/ftSpO1jwN4A69UWgrA6GbT0C4xpNzYrcpEhN/y9brnv+xQKms8iIte4W4BKl1efh48gsyFvh36ZmjMClMBTduN9QQyP8cYAG7/TMRx0wMBff13IM66XFLMlYuXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ensrDrsvhA2JzCMqg5DzjMsL/ZR1fswEV9RHGJcr/u0+VcTjC5bdjXFTDL6BDx7Mx4rlBPNzc9x0b2TRNNv2g8MrE269YJINrEe8hwHrZ3n2rO9aNQwmK8i5HlVDbN+qpBRYACzmfBjkFUiqiMRaR5HxrrnC9DxyyZ/lZ9u/z9PvR0V3MKArQiaO0FxbrmovxvJY5+1yJsBVDPfBSb5+BFivrT4505N5wTPm+RkNV+hiRqMAp4QX01wpJl0+X2QciwIXOLTjt+1Q927SpWhm5F1Wx1oJEgyF13VTXTRGlQbfmKtLLrv4oeJ+6m6s3S1YPZjNbeFsXNeJBlM0dqjiig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=p8dK0WJdJo863CxYI8hSXv+bJES35PI2k7IUTye9hYHT6NH5smlToqg+0bTApNjzIrKCzLdBcSXYV69SYTudyeXdVGQ079nZd4y576RZJBO/u8ShEaFuKrFVMPx9hBFhKmRGzH6ROGPmeBlACW8oqbNsqKueaLkErnI0Dp/acPU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7190.namprd04.prod.outlook.com (2603:10b6:510:1f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Wed, 9 Jun
 2021 07:05:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 07:05:26 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Tejun Heo <tj@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 02/14] block/blk-cgroup: Swap the blk_throtl_init() and
 blk_iolatency_init() calls
Thread-Topic: [PATCH 02/14] block/blk-cgroup: Swap the blk_throtl_init() and
 blk_iolatency_init() calls
Thread-Index: AQHXXLsI/hbIo7wgAUSZ83UxylJc9Q==
Date:   Wed, 9 Jun 2021 07:05:26 +0000
Message-ID: <PH0PR04MB7416503079FBC24EC308BD7D9B369@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:141b:f301:2906:41b5:83cd:3a40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95523753-a38b-4f12-4bbd-08d92b14f525
x-ms-traffictypediagnostic: PH0PR04MB7190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB719001174F580073B93918A79B369@PH0PR04MB7190.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g6RwVEe0Chd2vP2VyA2Nbu4NRp06aZq/VSTzpMbgyyFHNAgSp6jjpCyxB5mCj4NjeHeGIdGVRwuZ8CuZpQzdGcN4pYvR7OWZtJWKZOLRPnAoA3a0/5HJxMwCi7D94m1e96q57nCCquEjpjiWt7atbT+haZRgy5j4kwBcvWTKQqzSibYyujs7uMvZ7QcOjayiPnseXCASN7jvaW1RKb9klq52Q2U/TCOL6ls+eANE+6rlqgqnV8BzJOqORCY+GHQUu6/nZinAtcq5w4FQs8ro+9rSTz7S0bjq5A3U5xZ7kk2ipzmSQL8kmsU6+YUny/uqKic36VuUHOEP/u+1dnAVgILcBGbOcGRV5k3Z7iWgEPyOLu4hLIjrJzkpf3a0HAr2ZQAP87a9sgdlY2WBnSwINnYqDXyCoDEcobvXAxTXAsaWIWxBnSzF4KLPSejbl7mc4YbIEQfvsnWDOHze6WSysaLyJSt0lOz6bLPbToGHb8P4px5Kox5IM05fBvZbXsfb+nI2GS+2rWx2xpzxhtF4ySCOjAWoUqyFVrSCywfe7+QkJPTvm9Rx30Lyn20X7/IccXnhUgoOpqUzTOQqAqcp8YM8ZA7hWEAC1oFRV2IcmH0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(19618925003)(4326008)(186003)(2906002)(6506007)(9686003)(38100700002)(64756008)(110136005)(66556008)(4270600006)(66476007)(5660300002)(71200400001)(33656002)(66946007)(478600001)(558084003)(76116006)(8936002)(91956017)(316002)(122000001)(55016002)(86362001)(8676002)(66446008)(7696005)(52536014)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z5uOD03LDp54NYS1apZ6ThGi7u1OWpWdqE6IGaFA0p2PudP8pvIfcbszpH5T?=
 =?us-ascii?Q?kfqAI8I/T84CnEuWgIQ2ZJPv1VCqQ7PRb0bX4fD7ioxLUKfEHKkHLWAoTGk1?=
 =?us-ascii?Q?Ap+xbwdXBlrllBdSo83lAs+AP8B/acnV2W6e0RDUgqyTlzXWEwYo5vbN5PkY?=
 =?us-ascii?Q?0LcwvIaddbI3bETllmsyMWXOB2dvnVb7I05Pko9H0kNfZ0XOhTfhUyHZZazs?=
 =?us-ascii?Q?v06BIpoKHzFMd3AbYpLqx3E9oUzx3K7OWaOPyBQxq5xhYFwlODQnB+Efxm6c?=
 =?us-ascii?Q?YXU9tVdeYcwn4crNWx6h/NOhJMLR3KLc/4ORhrcB6U83JWYpLr0QRcgKe1lU?=
 =?us-ascii?Q?hXfHn3TzL1HUIVC0ITIMhu8uX8AiIoaLvJkDRINgc7eS9VHeJh1K2nPBFCVf?=
 =?us-ascii?Q?6gySC2v222oo2E2dYj2q9KE2bS1zkvOddoAVgWhBfd0G6DI/Vyt9zQGAHJeD?=
 =?us-ascii?Q?33+/lmD2gqmVc3XHwYKZe8dEo69cfHagjT/brRURGHfyAKX/6tT12QMkirf3?=
 =?us-ascii?Q?ulDxELe5xIY9BtiYg0lqcp52P07CHsRo7TDpWGiYKiVNh5TJ4NDAqzS1b2IZ?=
 =?us-ascii?Q?mId6SC+kUmkt6EA9JzPvO8f7LTWy/30vnR4SWN3lVx+vWgH3aLX6uaQHHIm0?=
 =?us-ascii?Q?Pslg4UX+f0yl0ihuSoyUl7T6mFNPLoLsdU30Amf6gz1EYuSY4AeBwLjflHw+?=
 =?us-ascii?Q?DwMt+p7W+/VSsugTM/FVd7kgyvQA17OFlW4jn8SyOq7Yq0bgVv8XyiXAjEPc?=
 =?us-ascii?Q?/o1//wpAUyK5E5AVoOmky609821iSzg2oQXk7KOUbGcvj1cKJkpdsEURzI05?=
 =?us-ascii?Q?fOWubOK4x7RbPrKFMc58yyhhiF7B/Dp3uZFlZQdSOB6v9CUHwJE3eJCwdpIB?=
 =?us-ascii?Q?KhjlUZMqmtNziMdSgez7Z2sFATjLYgWmHnQy8I3URWjCmiTLgsdFR2tlFRbb?=
 =?us-ascii?Q?6V7g7PnjgjR0MOQ0e0mGoVLHGdHxIrphOpHrDY4wbdpO2PonM2kqD44aqg00?=
 =?us-ascii?Q?15OjnIoWUYHTVVo0kFq01OTpA8VTd9rbppZ/0rAsbrCm23rlUtrQjpspnKNl?=
 =?us-ascii?Q?C6gi31scZUgZyHnr5L4d/1TbZrCdEvxxWp8oYkBQueqKxaGcy+yb9cc6rZ0f?=
 =?us-ascii?Q?wmDmb1jiktx2GBPBx6xxCcfKiHdxaqmMRA5xzhVxEPla0S8j22bhUFqQr+Kj?=
 =?us-ascii?Q?Px7B90c9z47habr8LRk5N2Nzy5wIHR9muPGcokfa4TcL7ebBRBEl5ScyLQoh?=
 =?us-ascii?Q?5riY915nJ3DYx5cjjDonwrKORh3/95liw0OVoiNnJOE/AVfu5oKt+KGKJ3Xp?=
 =?us-ascii?Q?+Gz+Kf32sLoZqdSVSXfrUuzfFbVAWLR+zF0hvsBgK1lUMqnF2KQKc1JPPlIf?=
 =?us-ascii?Q?ZC1tRVmUGFC4gpyjCJuY9RXlMyc8NhvjUvkxO9Stc6BC5lSyEg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95523753-a38b-4f12-4bbd-08d92b14f525
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 07:05:26.0095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WhEi9E9ujfofh0re2yMURNwEM8B3EyChBsUqDmgcX8umJpnBpAO9NuCDzBYbkRJ6XCDau73pu1XbhmqWMl0u2wJfpDsxWVJQDbnL2lb8Y/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7190
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
