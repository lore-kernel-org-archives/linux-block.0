Return-Path: <SRS0=FYaB=VM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530D3C7618F
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 17:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE4492081C
	for <linux-block@archiver.kernel.org>; Mon, 15 Jul 2019 17:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LbKDyQ01";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ePZwL5Wd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbfGOROH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:14:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45396 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730782AbfGOROH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jul 2019 13:14:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563210845; x=1594746845;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pgaczY4N7A4DAjlYSkaBs2q1mo5hGvvPqk7MYQOWvhg=;
  b=LbKDyQ01it/piMQqSvRg8Y7QuBUyAM6AHL/Zjw+hffWLjb5QuY/Ig2KA
   95bKX2OmGifrmJQemszuFq4Ls0JZjKNHN1SjUuSz0vgnt4UybP4WdzQBZ
   jxoSwkYaP6ZocG/2QMkuyKzp0HbMXJFXg/rC5EfKDdQqy+syRyiZJh9bT
   r6zQazGSzZe5/ydrCzFd9lF/SXmAz9kBVs3nYiKoynjoK26GX++gaSzJZ
   FgnASET3SDHsRcBU2vJ8WsqaHCvkLrL3esO6oNHROiUa1QsLU9IcFZp1Y
   xkU1E1E7QsvAmuuFUTitBJS1TEMOYxPSDnqjWzzNzsDUiNEUbtR8MHjeM
   Q==;
IronPort-SDR: Pm2qQy5/9UxcYTmiMtP5BDAj1mDi0Y5XVYaXY/zYztgr6nZ2TkLvgi9FT7j+5sHE5N4D+z789i
 U5kSoPTsDMX4ukIQbdjCpI3OjSyjSwQfSvvuIQXswtfWZvXevPkvK+iBV6B/w6DEpP6iJo0vS/
 oZqe2Ujx6tPGwrcsgkUSU5gb3+dKHAIg6/fgRls/AWWVfdnR80y47cyVbGXINdKYxCFQWikvuB
 HY0IoKAFw8Jx6WmEWCwyHCndfuUHwTvz7zb2/bjCphxDRVLOM67I/s52frPVYeJjuN3VXp/5VT
 MBs=
X-IronPort-AV: E=Sophos;i="5.63,493,1557158400"; 
   d="scan'208";a="117861108"
Received: from mail-co1nam05lp2058.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.58])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2019 01:14:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDGWZUqvNQXLxjSS8TWNr0NGHenlOVzZ6bTCmsZjfw7H32QkAIHee4Q3ofMzvgQZHyMZ7RPgK17Z7M3csvsT3fNKgkiRAT9aKS9QeWrhHTSwur5KC1D+5TSfus+a0XVr99pEb0mwznLmfZ73c1oUi6DzWOnDLsXQWUAuONqsFWNDUks7Z3+IaVYdKVuU/g4+z5mqwKq0NP+qxr7HzHbe485KRqYc5swyelqzdF6V531E3Z/0LV5TZq1NaE5HCWMXdDVNiN31dIT8xKOQzul4OYyyjXtLmQ0+xPKQ+g0YBpQDXDm9OyacZdlEykg2kkK2QV/DSryYb6sdNXLeeC1bUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UynnawN4qoAVJSVBaDBLQ4jT9cS3KdE7/R7cgxj3ShE=;
 b=W9jHgm7AYWiK2rYh1XOwMppE9K6Yo984iCjA1JvHeNR2W5pxPHY3CCjVtlHu37vjZWURCqstW1UmEzJh0M91gWRwUrh2sqDRmNsJvdfKlX7hm3ylU3CvC8F+vxcvc//mlschG+vHzcZ2kgcgWVo0mmDqTxvE2ba0J9edmhxlEx3WiqRwZrmQX+Haih4jZp2fxl12f0Q//MfodRfaGjG+bECbcJ2T7LM9nthwS8ja8HeUx3UZfUFmdp5sMAhA+ZQqAALSyzzjcsxZ9y12KGRXvwjC1x8bi199YHlz33P7+TZtuX+/Xy4b6+XWAhEGJ177dIJsurr3NmHHAUuiulLLAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UynnawN4qoAVJSVBaDBLQ4jT9cS3KdE7/R7cgxj3ShE=;
 b=ePZwL5Wdb0kORHRSD1YXOVHMWm5o3HjGosS02gLDidTWBPkUYYf/JOMnEE5IG28L573U2ENErKQ2ZU0Kv1MJG8q8eDliAwHTd2ZAT+3fWuDG5ZTZNkny+9UNmr9UOb6a5n7nAtn1tEfT9Pd1hY75qzln3p4KCnH3gTk6z19F/Fk=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5782.namprd04.prod.outlook.com (20.179.58.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Mon, 15 Jul 2019 17:14:03 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078%5]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 17:14:03 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Michael Moese <mmoese@suse.de>, Theodore Ts'o <tytso@mit.edu>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH blktests 00/12] Fix nvme block test issues
Thread-Topic: [PATCH blktests 00/12] Fix nvme block test issues
Thread-Index: AQHVOQ2j96MWFrsRX0KhibpIudRQNw==
Date:   Mon, 15 Jul 2019 17:14:03 +0000
Message-ID: <BYAPR04MB574921F8E6F38535AD161F3286CF0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190712235742.22646-1-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e80e3c68-b604-4373-824d-08d70947d611
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5782;
x-ms-traffictypediagnostic: BYAPR04MB5782:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <BYAPR04MB5782EBB38853153B9006F1B286CF0@BYAPR04MB5782.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(189003)(199004)(7736002)(52536014)(305945005)(478600001)(8676002)(4326008)(68736007)(26005)(966005)(476003)(5660300002)(76176011)(446003)(7696005)(66446008)(76116006)(66556008)(102836004)(66476007)(74316002)(66946007)(53546011)(6506007)(64756008)(229853002)(2201001)(86362001)(186003)(9686003)(71190400001)(316002)(110136005)(486006)(54906003)(3846002)(66066001)(81166006)(14444005)(256004)(6116002)(99286004)(6246003)(8936002)(14454004)(53936002)(2501003)(33656002)(71200400001)(25786009)(6436002)(55016002)(81156014)(6306002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5782;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jraGA1qmiErmZDSpCn8okXMkmVBluTPvUEocWW6dI+eIIjQgpPkhlUjxmMPhg6jnYKZ92U6FXiwoFGj6hNRaZdKcRLOLlbNGWkXOYsKE5Ae/gvHRgEbuh8pM3tdWwYOzspIKaWN2sv+GlOG4POdEUxvyouDfdou+079K69j6b4aLxG92ctZfhwvMyhueobv1FnUh9Vww8xfIrUgSNB5a4vcw/8LO5caBE3sMbHWLQIcwp+//nJacuYur3WurD5BMwqBtvD2RLdzTpZ6k2Ni2KRbthz67ijhpoDIIY9MW78v2Dd3EoNFBnwhSvls5xLI8LGQkJFc1m8VgG3dqEqZvB/CkI0m3Oh8XNNT6hECn2tWL/Uss1fpaiKiLqaodMSqlSW/O5paoJxZ/4ukrmyWuwbP0/c5LSG4wultvicnBHjs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80e3c68-b604-4373-824d-08d70947d611
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 17:14:03.3824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5782
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks Logan for doing this. I am overall okay with overall with=0A=
these changes.=0A=
=0A=
Once you post V2 I'll test it on my machine.=0A=
=0A=
On 07/12/2019 04:58 PM, Logan Gunthorpe wrote:=0A=
> Hi,=0A=
>=0A=
> This patchset cleans up a number of issues and pain points=0A=
> I've had with getting the nvme blktests to pass and run cleanly.=0A=
>=0A=
> The first three patches are meant to fix the Generation Counter=0A=
> issue that's been discussed before but hasn't been fixed in months.=0A=
> I primarily use a slightly fixed up patch posted by Michael Moese[1]=0A=
> but add another patch to properly test the Generation Counter that=0A=
> would no longer be tested otherwise.=0A=
>=0A=
> I've also taken it a step further to filter out more of the discovery=0A=
> information so that we are less fragile against churn and less dependant=
=0A=
> on the version of nvme-cli in use. This should also fix the issue discuss=
ed=0A=
> in [2].=0A=
>=0A=
> Patches 4 through 7 fix a number of smaller issues I've found with=0A=
> individual tests.=0A=
>=0A=
> Patches 8 through 10 implement a system to ensure the nvme tests=0A=
> clean themselves up properly especially when ctrl-c is used to=0A=
> interrupt a test (working with the tests before this was a huge=0A=
> pain seeing,  when you ctrl-c, you have to either manually clean=0A=
> up the nvmet configuration or reboot to get the system in a state=0A=
> where it's sane to run the tests again).=0A=
>=0A=
> Patches 11 and 12 make some minor changes that allow running the=0A=
> tests with the nvme modules built into the kernel.=0A=
>=0A=
> With these patches, plus a couple I've sent to the nvme list for the=0A=
> kernel, I can consistently pass the entire nvme suite with the=0A=
> exception of the lockdep false-positive with nvme/012 that still=0A=
> seems to be in a bit of contention[3].=0A=
>=0A=
> Thanks,=0A=
>=0A=
> Logan=0A=
>=0A=
> [1] https://github.com/osandov/blktests/pull/34=0A=
> [2] https://lore.kernel.org/linux-block/20190505150611.15776-4-minwoo.im.=
dev@gmail.com/=0A=
> [3] https://lore.kernel.org/lkml/20190214230058.196511-22-bvanassche@acm.=
org/=0A=
>=0A=
> --=0A=
>=0A=
> Logan Gunthorpe (11):=0A=
>    nvme: More agressively filter the discovery output=0A=
>    nvme: Add new test to verify the generation counter=0A=
>    nvme/003,004: Add missing calls to nvme disconnect=0A=
>    nvme/005: Don't rely on modprobing to set the multipath paramater=0A=
>    nvme/015: Ensure the namespace is flushed not the char device=0A=
>    nvme/018: Ignore error message generated by nvme read=0A=
>    check: Add the ability to call a cleanup function after a test ends=0A=
>    nvme: Cleanup modprobe lines into helper functions=0A=
>    nvme: Ensure all ports and subsystems are removed on cleanup=0A=
>    common: Use sysfs instead of modinfo for _have_module_param()=0A=
>    nvme: Ignore errors when removing modules=0A=
>=0A=
> Michael Moese (1):=0A=
>    Add filter function for nvme discover=0A=
>=0A=
>   check              |    9 +=0A=
>   common/rc          |   18 +-=0A=
>   tests/nvme/002     |   10 +-=0A=
>   tests/nvme/002.out | 6003 +-------------------------------------------=
=0A=
>   tests/nvme/003     |    6 +-=0A=
>   tests/nvme/003.out |    1 +=0A=
>   tests/nvme/004     |    6 +-=0A=
>   tests/nvme/004.out |    1 +=0A=
>   tests/nvme/005     |   16 +-=0A=
>   tests/nvme/006     |    6 +-=0A=
>   tests/nvme/007     |    6 +-=0A=
>   tests/nvme/008     |    6 +-=0A=
>   tests/nvme/009     |    5 +-=0A=
>   tests/nvme/010     |    6 +-=0A=
>   tests/nvme/011     |    6 +-=0A=
>   tests/nvme/012     |    6 +-=0A=
>   tests/nvme/013     |    6 +-=0A=
>   tests/nvme/014     |    6 +-=0A=
>   tests/nvme/015     |    5 +-=0A=
>   tests/nvme/016     |    6 +-=0A=
>   tests/nvme/016.out |    9 +-=0A=
>   tests/nvme/017     |    8 +-=0A=
>   tests/nvme/017.out |    9 +-=0A=
>   tests/nvme/018     |    8 +-=0A=
>   tests/nvme/019     |    6 +-=0A=
>   tests/nvme/020     |    5 +-=0A=
>   tests/nvme/021     |    6 +-=0A=
>   tests/nvme/022     |    6 +-=0A=
>   tests/nvme/023     |    6 +-=0A=
>   tests/nvme/024     |    6 +-=0A=
>   tests/nvme/025     |    6 +-=0A=
>   tests/nvme/026     |    6 +-=0A=
>   tests/nvme/027     |    6 +-=0A=
>   tests/nvme/028     |    6 +-=0A=
>   tests/nvme/029     |    6 +-=0A=
>   tests/nvme/030     |   72 +=0A=
>   tests/nvme/030.out |    2 +=0A=
>   tests/nvme/rc      |   64 +=0A=
>   38 files changed, 208 insertions(+), 6163 deletions(-)=0A=
>   create mode 100755 tests/nvme/030=0A=
>   create mode 100644 tests/nvme/030.out=0A=
>=0A=
> --=0A=
> 2.17.1=0A=
>=0A=
=0A=
