Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AA8C6783B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 22:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49B3F20851
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 22:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Y3qoRuH7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="j8PTw4YY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B3F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeLKWxe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:53:34 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:30365 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeLKWxe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 17:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1544568814; x=1576104814;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=84lz0z3ZiVnirxcnWgXHzewpxag135IURBVLjDLv6VM=;
  b=Y3qoRuH7JSW0CyY7kL3Lesg8vXeuumffvWA0e4owwMk9BiC/cEeEYAZ7
   TEBH/ZXJqgi4JZenDTYyKzsWbAruuz6B0LMx7S+MotY00Mc70UKz8dj+N
   4zuOixcH7iUMqF0iQGvGz6wcIkVmI4Fzm5zeeDyF6JIzeLmiGDPbbA7or
   +g28bKaIQxGofACSoO3H8v3CsH3sXM7Q0ekPDlF3O1AzXrYpjryZ+G96b
   4XIFqBqPuGu31oV0g4EkPCTpddVQZVh/xZwYiTc9wCL8XM/+o8nHf0LTv
   C3l3qPTo7e4l9vAEbN4Cg00sjP3DHw6vlUFwRoDuNIdWLlBpbx39yM+QW
   g==;
X-IronPort-AV: E=Sophos;i="5.56,343,1539619200"; 
   d="scan'208";a="96358096"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
  by ob1.hgst.iphmx.com with ESMTP; 12 Dec 2018 06:53:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZ37KBl8/IC9ahrBJEnP/fzG3Y1f3rRTX5RB5ohdWI8=;
 b=j8PTw4YYCkvk7lM+/oPeP9Hp8JDfZIvfaxcm7AVjePbAHcGf/UdE/SYnhSfByfjqZo+TbS3DExPsZvsC1YYbGVaPPgEthtJGgLXOJocrF9eMMI1Jj2TNMeN4awvh9S07t+As9wsb5raNZZ1oyly7DEFtXGR8kk3YSah/pl6j/dg=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB3957.namprd04.prod.outlook.com (52.135.215.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Tue, 11 Dec 2018 22:53:32 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::957b:6353:d3c5:1b8d]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::957b:6353:d3c5:1b8d%2]) with mapi id 15.20.1404.026; Tue, 11 Dec 2018
 22:53:32 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH] block: Fix null_blk_zoned creation failure with small
 number of zones
Thread-Topic: [PATCH] block: Fix null_blk_zoned creation failure with small
 number of zones
Thread-Index: AQHUkUo+tJKkBfZhpECElV5qbdGoRQ==
Date:   Tue, 11 Dec 2018 22:53:31 +0000
Message-ID: <BYAPR04MB5816F2BEEA0B725B6BDD8D57E7A60@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20181211120826.28852-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB3957;6:XvCDM0ZzPaKuo+0lg6dnleaNDVstnYWaWZCT7igtVy/58DmKXijf1WCfcYS0hryTJI0YJ4k9oibl1vDSC2efze7g0O7Kwpl7/gqCkrLK2END6IWsy7fgswD8ohmZcux0PHZn/TeszKVtuKRLtFU2ahrCG3RYrRHnrQfjy7Q3pShHB70O6cqa6lQ/3DwVQyqnbTBYNPjzR0o0v0zCpETf/5LutGcE5t08P/lClK6tp+k38MxJuxBHGnYJPNKUg4Z9Lyop1Nc/VVRD8/58L4ZFYg16sNk0YYQl5p5WsuuRdr/d77YIqa1j9HL343kIedKVSHExpWHdaECIxV0iqguytEV0x4J/9d1ZNZtqrRrdZl9zYojzLHy+yHme5/al+nFU6YsG8KyFEncdpOLOFljw3FbqyHLXmr+Kt5xuZOTc9KtF8dKEnJkJCp3jZdK/zCWBjq8bI7TJ1ed3b5xbA2R1RA==;5:5VKWprR/R7XeUPaNA98QLtu+qdYcSwM98GbQwyxjOmgxWKHPGsBjB5bdG0UjywLuDjyVXMnUFWzlW7xmYUoUUYyCqiMdUNpwAdr5tZ88ZAb91/T/SpdgKApeO+V6mrBvR3XfUdWA4YnG+fbel7nCblMr49uaphntKa6HGFl3zkI=;7:EZB9i6BzzHor1xeN34gObr/K6RuAqGcQwTn0VwAUlPxmONdwxqCSctAdUbD4uFI3tL+4ZcxHnUeTUfh+im3IccPwIgkYszZwosQGUM2DeiwMNIRhREYPLLexpmtAgIl6vy8WuWNfJgPUy97le2kLyA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: b442ce78-3498-43cd-8198-08d65fbb796a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB3957;
x-ms-traffictypediagnostic: BYAPR04MB3957:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB39577BCA810B69C8AF77EA44E7A60@BYAPR04MB3957.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BYAPR04MB3957;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB3957;
x-forefront-prvs: 08831F51DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(366004)(396003)(136003)(376002)(346002)(189003)(199004)(99286004)(8936002)(186003)(110136005)(2501003)(486006)(7736002)(86362001)(55016002)(7696005)(5660300001)(102836004)(26005)(9686003)(6246003)(4326008)(2201001)(14444005)(81156014)(81166006)(305945005)(76176011)(256004)(53936002)(105586002)(25786009)(3846002)(476003)(6116002)(2906002)(106356001)(6506007)(53546011)(71190400001)(229853002)(71200400001)(68736007)(8676002)(6436002)(446003)(33656002)(14454004)(72206003)(97736004)(74316002)(316002)(478600001)(66066001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3957;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: eqPWOGPBVDoLF9h1NbOuFjKr+zjar8U3hDiOx8v8qicqiJtIRDY7WHkBOcQCgBlPCcsvkgjvdP+I+7SUjm7oJHg80Xu3dPoR+ILt6fShqtn0dMVYsThF1WlcIVI/bTNKm6BIFtL6nrRWNetV0kFCD3Hd/0UG/DXEPsv5NQbdqMDuvCDLvq46Ds3URgHe5kcH53HN/1qtvbCDcvQbrHOmoXC2Vdq9FQn0YH9LnmmHK7wMDXN4axpRyRDrfQ83ui4MeB6kjQ1wqrlBalDq20rjjTdB0HMe7iLDIkhdGFR7gjZ6eLfhs/nBLLfLSHvWOL5I
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b442ce78-3498-43cd-8198-08d65fbb796a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2018 22:53:31.8679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3957
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2018/12/11 21:08, Shin'ichiro Kawasaki wrote:=0A=
> null_blk_zoned creation fails if the number of zones specified is equal t=
o or is=0A=
> smaller than 64 due to a memory allocation failure in blk_alloc_zones(). =
With=0A=
> such a small number of zones, the required memory size for all zones desc=
riptors=0A=
> fits in a single page, and the page order for alloc_pages_node() is zero.=
 Allow=0A=
> this value in blk_alloc_zones() for the allocation to succeed.=0A=
> =0A=
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=0A=
> ---=0A=
>  block/blk-zoned.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 13ba2011a306..a327bef07642 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -378,7 +378,7 @@ static struct blk_zone *blk_alloc_zones(int node, uns=
igned int *nr_zones)=0A=
>  	struct page *page;=0A=
>  	int order;=0A=
>  =0A=
> -	for (order =3D get_order(size); order > 0; order--) {=0A=
> +	for (order =3D get_order(size); order >=3D 0; order--) {=0A=
>  		page =3D alloc_pages_node(node, GFP_NOIO | __GFP_ZERO, order);=0A=
>  		if (page) {=0A=
>  			*nr_zones =3D min_t(unsigned int, *nr_zones,=0A=
> =0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
