Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50297C43218
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 09:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26357212F5
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 09:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kDYX7+/D";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="F6fYXvWB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404406AbfFKJbK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 05:31:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29951 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbfFKJbK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 05:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560245470; x=1591781470;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=EokEQuz7L23qLPRU2BlQ46RJoc2LoRjEx+BHbwQIK9k=;
  b=kDYX7+/Dglb46PeL2SoL6sAzRIi8rYfLx/uSFM6mX0cNjohswZT0JC/k
   OigZyhqSeh7eBqlPSxhWsi4BzG2LiMHm2vNxDLz+TDDj7NYbcJD9WOb39
   yP8BPX5CKA7/7bVqA2iWDYJvL3l+sUwtcts70z3P7ftCnjLace9rLp7qj
   X8rfo60Ocn1/dyjLTCsFhv8R5z36++7RMhxgQadBjSK4f0yKV77hSEXny
   4EOWYA0+cb81XmeaVymWm7gJoAyKMsDq70hY0R6blqM19BbEDQNwqiM1W
   T9P/qaa8wYiZ/kNENH2ZxdfFZCOoroGLEC5U3j+yD9ARePUCuHl6IL1Ql
   Q==;
X-IronPort-AV: E=Sophos;i="5.63,578,1557158400"; 
   d="scan'208";a="111538422"
Received: from mail-sn1nam04lp2050.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.50])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2019 17:31:09 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7AG5fRNO56zmt1UryczI6BVb52RTpGDZI2lbBp8pVK8=;
 b=F6fYXvWBQPprUDHFhuX4dV7+3deLBTFDNCoLhNIWKt2Aq7uRT8t9RNdsNHB9nJO8KSKoPiivqtLc8/E+WVEZHOf3g/faYc0k5jRZzgcYANb38+bo5OMCSIbXf8F0KjYGwNgezSdjELuONJqQozl3tY+uOLGEZ655/bf0dugYzQ4=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB6232.namprd04.prod.outlook.com (20.178.235.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Tue, 11 Jun 2019 09:31:06 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::d090:297a:d6ae:e757]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::d090:297a:d6ae:e757%4]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 09:31:06 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Matias Bjorling <Matias.Bjorling@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] block: force select mq-deadline for zoned block devices
Thread-Topic: [PATCH] block: force select mq-deadline for zoned block devices
Thread-Index: AQHVGqZzwmpXmiAKZkCOfVJGzQK/aw==
Date:   Tue, 11 Jun 2019 09:31:06 +0000
Message-ID: <BYAPR04MB5816ABA7E2F4E1B05E2F3DF1E7ED0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190604072340.12224-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [82.130.71.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f774ca86-7c9d-47ee-aab9-08d6ee4f8793
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6232;
x-ms-traffictypediagnostic: BYAPR04MB6232:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB6232AABCDEDCC37A5368D8F4E7ED0@BYAPR04MB6232.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(366004)(136003)(39860400002)(346002)(189003)(199004)(5660300002)(99286004)(4326008)(66446008)(66556008)(66476007)(64756008)(76116006)(91956017)(66946007)(54906003)(25786009)(110136005)(256004)(316002)(73956011)(305945005)(74316002)(7736002)(86362001)(72206003)(52536014)(478600001)(14454004)(53936002)(4744005)(55016002)(9686003)(76176011)(486006)(6506007)(186003)(53546011)(8936002)(81166006)(81156014)(8676002)(26005)(7696005)(102836004)(66066001)(6246003)(33656002)(229853002)(2906002)(3846002)(6116002)(71190400001)(71200400001)(2501003)(6436002)(68736007)(446003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6232;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: un/SrZbu0tkqk5YT52tZq+3AyjYcTG5l/73bR+pM78+G5XYHs6Yyv7mNLzkHW2hBhJ3Xd0dpqXValhAGjQuPTC5/v5ZNCKgvkGzzUvx1NMHbW6Cow5OXMyL2VYOcSadasBcNQoKnltQN0VQ9XmMq9zO3yt8HjM9SGJFTlkitawAuPW6eW57395VIM0D2qInwedvT79dVE6I/u+1GpF9xbFZL65CCkKBBDUiV+f6qfRFfdk5aB4o5pRwyPmX3DHVtQhqWfBubzegjO90baBzV+SNKyvJcs0JRaomWFnk0Gql0BtuBRmYzo452Edc6sfW2rRzGFxHeE7j341bO3LPvy9QEsy2gFLseVVDmm3sBBjutCEUalex7qc9wHLitHgV+ZMzsc0oL8xMN26zbWxTPN3nIXMXpWjcdRaGB/1M7bhk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f774ca86-7c9d-47ee-aab9-08d6ee4f8793
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 09:31:06.2323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6232
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/06/04 16:23, Damien Le Moal wrote:=0A=
> In most use cases of zoned block devices (aka SMR disks), the=0A=
> mq-deadline scheduler is mandatory as it implements sequential write=0A=
> command processing guarantees with zone write locking. So make sure that=
=0A=
> this scheduler is always enabled if CONFIG_BLK_DEV_ZONED is selected.=0A=
> =0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> ---=0A=
>  block/Kconfig | 1 +=0A=
>  1 file changed, 1 insertion(+)=0A=
> =0A=
> diff --git a/block/Kconfig b/block/Kconfig=0A=
> index 1b220101a9cb..2466dcc3ef1d 100644=0A=
> --- a/block/Kconfig=0A=
> +++ b/block/Kconfig=0A=
> @@ -73,6 +73,7 @@ config BLK_DEV_INTEGRITY=0A=
>  =0A=
>  config BLK_DEV_ZONED=0A=
>  	bool "Zoned block device support"=0A=
> +	select MQ_IOSCHED_DEADLINE=0A=
>  	---help---=0A=
>  	Block layer zoned block device support. This option enables=0A=
>  	support for ZAC/ZBC host-managed and host-aware zoned block devices.=0A=
> =0A=
=0A=
Ping... Any comment on this one ?=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
