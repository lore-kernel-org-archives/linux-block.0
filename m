Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D40C4338F
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 02:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D4D60F9B
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 02:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhG0Bgt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jul 2021 21:36:49 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:10316 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbhG0Bgs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jul 2021 21:36:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1627352237; x=1658888237;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XHrvagYrxdFY46NytI/V8BbjOkTB7LAVn1PcEAGFcVo=;
  b=aAumqzrAW4MtGDo6gqjXX39R6fkAVDq7M+f42BL1Qgprpjmbb277Le9u
   FOvV8GDzSn/ga6NkIG+VzgW1MEJ9Cm3hwddMHgnW8DthSbcPnXRG602o7
   Q7puBjXU0GGMQk2OGcQP7X1UPjIRYGFE2WthdQBjYSFg9N4vsstRcjg4E
   0pyYzXZkJAAnDUxq/FLDECi48ZguljVunJhyGzn07hPKgQmcxe/z0JKhY
   4Z1oArUAXR/OU0rqw6ix32L4dxQ5ByhvQOCw2IdMXc7do52PVEt534Jxb
   10Fkw+S4b5rSsNOMpduOkff/WIn6oSe1mjHlUSVWD06hrkxPf6pllJQCB
   w==;
X-IronPort-AV: E=Sophos;i="5.84,272,1620662400"; 
   d="scan'208";a="176127880"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2021 10:17:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nA7NGiZzzitckYb7/Js2fm2QrZwgDVAhpVROBb9J209OM3akZkXNQ7TQsaDEvlkcDH2y8uHKzdKVSILISQQxPZ4fKEYk3yyBOD7kOj6o/F8TLItNqsNJuchbXiR3OMOWxit3Qtoa48hfFr4uQV6RhEc7i9B77n51IUJ3m1GHM2DovEHk/0tDJBikBSuGve0lBjOYdZuN6xS8WNSkFXT+LFCYpimO6u7sclJwwOP5eV6fCG7GuPshuuc8xxVZ+Enr4tWy34s/b31/ZpmtQqUPYTWwmH7UuxR67yQNCbccnWYKtS7phc+9sWdrTOjVcUD7pJE4A2R1oTaH4G7BtG/aeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYb55ehMI394VnbF2NjznsubLg/V5gJK0FGl7RI6dbU=;
 b=Qa6CHf1F3zEOqEpBv2/6pxy5zM8xkP9xXNshki18eY0Q/qGf7VqLZZBRyoQS9bBUveFcfrYXKv6iGCwqsl4Z1Khsnnb2RSS4sD2DptUjXVVJIsfi7IcLqP1TDq+zLaBKuPNeyj+dr1aCvj36LXS68dA4OPa6xamvhkpx+Irq2Piv5fdwzBbsz61fNgbvOdgvPOrp4VDUYC4IIIHk70wrRSvOpxnuE2yr5ke06pfe5ZUcFDqJV2Ag7eXmU/uiRNhicDPSyvsKL/Mi+svBiUUhdNNcEbxZoQeVKe7Lri4DtSBuojaHgrsRQvsLp/7mn12Ak83PRnenDG+yTl6EpyFn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYb55ehMI394VnbF2NjznsubLg/V5gJK0FGl7RI6dbU=;
 b=U1KRi/QpiGAlWLQ1ymVohz07tCHuDaiXZcvpau/XpiNQfPs8GHGvGK1MvcoPh1fh+Y0ykTmEgUHVfGPBR9UUBiBVo++vqojGwXg/MpNuQmBa0DlvhnlIGPTkLsr5rvPG4Ovf94s5/iv2r7VU1NqimhjmAf/4rl89EPT0pDw6MYc=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BY5PR04MB6931.namprd04.prod.outlook.com (2603:10b6:a03:22d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25; Tue, 27 Jul
 2021 02:17:10 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::801f:2817:2957:5625]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::801f:2817:2957:5625%3]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 02:17:10 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 0/2] zbd: Support dm-crypt
Thread-Topic: [PATCH blktests 0/2] zbd: Support dm-crypt
Thread-Index: AQHXd8+en1cOVKve5USZqbzv9mDJlatVsewAgAB5dYA=
Date:   Tue, 27 Jul 2021 02:17:10 +0000
Message-ID: <20210727021709.o3s27hzhf7qeajc5@shindev>
References: <20210713101239.269789-1-shinichiro.kawasaki@wdc.com>
 <YP8GwrYGzv+Q/CQR@relinquished.localdomain>
In-Reply-To: <YP8GwrYGzv+Q/CQR@relinquished.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: osandov.com; dkim=none (message not signed)
 header.d=none;osandov.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2911da81-9e18-4f09-7b36-08d950a4a416
x-ms-traffictypediagnostic: BY5PR04MB6931:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB693127C6CEC4AEEB4B47F580EDE99@BY5PR04MB6931.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cBfuhFIMIYm5+CApjSG8a5OcNOfdZ/d4S5M1a7wKVHh1QOInKTLasavPmbM87+yx68qvaI+4WA9pAQSquHHVJFvYyZARPuSTeZwxlVXRON7l1j5zyTN7t8nIF62456Won3fn0+/k+vWPFSJH7SunJBmYwr5/dFdxhc3I4GQ1Zs0/o0bj7SaAnfj0aZSmYzdbsBVJ76i8Unj0Uii7h727wQ7ZuDKJsbnliv7zPXcbaou6fPutATk5aaSVEf3SwC2BQPIAhH3LT1Ztf1YVw0/8EgINSuEI4WARcCVMxDrp2C0DQE3IbRNhOs2XacfkyOtKf1ILu8o7Pkndzk7XZos7uQAPIVcnwdQhG2AUdSMttnN4VeEYStoFCt8pCrylWwByVkJOw9RFsqd6ZLfRObtfCh/nmPwFT8JEMjo9jhFpN/bmtp2gqY3oYM2YwPWzK5REzAlWeYbJfNzR1Ooz1GfKIxskU1BV4eN3udAUKHKUvjjTq9Cm2cFdjAH9WBtxe0hOfPOzIl9T+lBkxx0Tvx3UFgrYDths1z96qhb6MWhB8FcWempKmifRHb1nvFtOn/uat3/ypWqMnnHmkfaiOzMc7r0MHQJJrSOfhclXvAc+aQejeS+6WchzjzGlary8woWhYPczEWtunvbETyFwp+zxA/S1xUyw+Jk9rG5+reT3tqqcL7t9Z2rgt21PAWXWXw8sA3E+fUyxVzYPPFV5l4H7Ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(6916009)(316002)(186003)(66946007)(71200400001)(54906003)(86362001)(5660300002)(4326008)(38100700002)(26005)(44832011)(33716001)(6506007)(83380400001)(76116006)(66476007)(66446008)(64756008)(66556008)(478600001)(6512007)(1076003)(9686003)(122000001)(8676002)(2906002)(91956017)(8936002)(6486002)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j8tGWrTeyJnml9wQZ6NJlIdNLXDsl88fNeCRyGQtXyJhE+aihZLaYumhBTWq?=
 =?us-ascii?Q?WDVyXP6D1whn+MUHOJBIwKNbDAWQ7MW5P8nrVms1SLv6f5TPZepuzCwD3Mhn?=
 =?us-ascii?Q?4Q8U/w61x3Z7UMsAHS61+sSSzgJkRtQlyhKYdkOwdqqQfM8OUKAuRkqCqXHd?=
 =?us-ascii?Q?HopT3dNUQX156sBsTwf8Nev82HCQxpEsRjNAgNWX/XaylgHzDjv7NFmB4z/u?=
 =?us-ascii?Q?aikAC9hlhx8s7IGI7Rsu3nmUiT/e4CEN25O82BwaLGU6g2jGlDUrB4ux2D+8?=
 =?us-ascii?Q?kPpUy4HBg3uExh7txVV8cbadVyDBAdB1ixHJua/GSeMlxYH8yRrdfsYCzcjn?=
 =?us-ascii?Q?Y67FdZ9XxphUL73UXTl7ROcN2me7CMrQt8tbFX3h3y2sszATTOFqNwDfMuek?=
 =?us-ascii?Q?HOZaOxpYwmnzM7ELnQghh4UJUP8EeVU5NaDgeSjejsVxf78giEbvJtEoy7q3?=
 =?us-ascii?Q?y08OCBobqdajJhTrztjLGLnSR2sVjkSAIIRY+72i4VrfI/RUVNmbxibA+apK?=
 =?us-ascii?Q?6W/E4Tgw7V0rEoH3rDy2cItflYHV2QSyO1enfqqMDrJx6Eq2YlNTJJDsZ7Rs?=
 =?us-ascii?Q?DeybcD3gEp6SRfXD7i14FU6iV+CT4Kzz2ItYYsvohxsF5NK7OV5jRAIMKRDL?=
 =?us-ascii?Q?V0mZvAAkwPGuUibEbyvLp7Rj8gkIdg2yyu9mcOoF/6j4CRHhemK7yGW+Gi7k?=
 =?us-ascii?Q?F/zef778B2QVAf+Dy6he/10x4XtSZd18NnmBk81gLFTEqay+fqsckY7iMLQG?=
 =?us-ascii?Q?J3k4cHALck5JD2u57Z+ewkNsImD1cFuUv1EzY261c15ohOScxEuflNy29Zuk?=
 =?us-ascii?Q?lhgRjBRpuSUblTvYbM/RBCg2BayA+HmtP05qjxOcg1ESKZjWVfIS/xbxANmw?=
 =?us-ascii?Q?I7oxSBjQ+og0XaoHIlj/4C8ENM0nGCCbKeS320Anp8k/DTVPj/4wc3ajNZYf?=
 =?us-ascii?Q?pWtt5xWy67DOZz8P7k3PpwrOo2AmWgWfkl51N8he4YSumUSf4ykpQ8Vv0SzI?=
 =?us-ascii?Q?Z8Or7/4Fejo10KXmXjMs/wv2zC79Oa8auVf6DZobXWoNha+V9oTHHYOyHtuO?=
 =?us-ascii?Q?8ZtT+vn/TCzMEdvF+i+SLirh4mXk9wAZRrqrW0tKnuEyR6bw87PAQiR/yGhj?=
 =?us-ascii?Q?EiwSlNLeTTfh5/iKcZeHd9RqNbpiCorsQl88yvN7gAru3S24cpm6q2WkGlR/?=
 =?us-ascii?Q?1lfeGNfT7pM59xOVRiqqwidaooD97Z4j6xsaQYjsTlan3/GB9NRbzPNwQyws?=
 =?us-ascii?Q?YjgWMpMYvSgY6fj7LWCsQpz4+yELuisuY5K2T+bIeWnVjO6swOfUpnt3gei3?=
 =?us-ascii?Q?sXfTkKP6/ENXhvpHbvZOyvdVse4TT89gAfa6hMxdBXIHlw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37ABE845E29F894C8CC0CFE414B42F56@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2911da81-9e18-4f09-7b36-08d950a4a416
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 02:17:10.6216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cvXeS1KHT5d8b8fuEkDQ3jm0eyrirQ49zpyhRpi1SViKm4g8wwYGzEQdThcXLw9ctcOKZ0qLGV8glh0OHuE/9BYcVuOerVWuwWctr8oBqyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6931
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 26, 2021 / 12:02, Omar Sandoval wrote:
> On Tue, Jul 13, 2021 at 07:12:37PM +0900, Shin'ichiro Kawasaki wrote:
> > Linux kernel 5.9 added zoned block device support to dm-crypt. With thi=
s zoned
> > dm-crypt device, zbd group test cases pass except zbd/007. This series =
makes
> > required changes to allow the test case zbd/007 pass with zoned dm-cyrp=
t
> > devices. The first patch adds dm-crypt support to the helper function
> > _get_dev_container_and_sector(). The second patch wipes out broken data=
 on the
> > dm-crypt devices which was left after the test case run.
> >=20
> > Shin'ichiro Kawasaki (2):
> >   zbd/rc: Support dm-crypt
> >   zbd/007: Reset test target zones at test end
> >=20
> >  tests/zbd/007 |  7 +++++++
> >  tests/zbd/rc  | 20 ++++++++++++++------
> >  2 files changed, 21 insertions(+), 6 deletions(-)
>=20
> The patches look reasonable. Could you provide instructions on how to
> run with zoned dm-crypt so I can run the tests?

Sure, the script below sets up a null_blk zoned and dm-crypt on top of it.

--- start ---
# create zoned null_blk device as /dev/nullb0
rmmod null_blk
modprobe null_blk nr_devices=3D0
cd /sys/kernel/config/nullb
mkdir nullb0
cd nullb0
echo 1 > zoned
echo 1 > memory_backed
echo 1 > power

# set up dm-crypt on /dev/nullb0
KEY_FILE=3D/tmp/dmckey
dd if=3D/dev/random of=3D"${KEY_FILE}" bs=3D1 count=3D512 > /dev/null 2>&1
cryptsetup open --batch-mode --type plain --key-file "${KEY_FILE}" \
	   /dev/nullb0 dmctest
--- end ---

Maybe no need to mention but I used blktests config as follows. With these =
set
up, I confirmed that block group and zbd group test cases run without failu=
res.

--- start ---
TEST_DEVS=3D(/dev/mapper/dmctest)
DEVICE_ONLY=3D1
--- end ---

FYI, two commands below clean up the device.

# dmsetup remove dmctest
# rmdir /sys/kernel/config/nullb/nullb0

--=20
Best Regards,
Shin'ichiro Kawasaki=
