Return-Path: <SRS0=2dDp=UK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB0DC4321A
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 16:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0856021721
	for <linux-block@archiver.kernel.org>; Tue, 11 Jun 2019 16:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="koNleBf5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hbR4bBBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389804AbfFKQsS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:48:18 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40729 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387814AbfFKQsS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jun 2019 12:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1560271698; x=1591807698;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+A8SzBnvZkzpZFuN3yjKpligRBmnFDRVtfLqI1+wAV0=;
  b=koNleBf5zL2yR/hDt/Vc/eeBOMhsEB2gkUZb/ol/hS4nkMrBaHAtsqKR
   BWgXxtzRCYG23qAJqxhSPdLRVSauOjQvCtdxGEGfSN+yxMxcxn+biALt5
   rckCDdupppCsBriEIu6MZUK/hNEVGWZPHDSLdEaqeSt1idUglV/ntSkGd
   qUEzLhItUUu59oDnGAiDbbrCmZK7mGVrVDnyR6jEnFX3kLh8dB5BRTzzw
   jGsK55w0dYi6eNor8VszmdjbbYHfr/3yBxBYxbHQYoQQHMIcMPtka+XhW
   kH54nxk7wyLjeQIR+Y4UkMdtAtXFoYx7gvQFv6jYQB/dSEVtq1BRQs5hN
   g==;
X-IronPort-AV: E=Sophos;i="5.63,362,1557158400"; 
   d="scan'208";a="111566367"
Received: from mail-co1nam04lp2059.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.59])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2019 00:48:18 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c9sWRXw/Fb6GoXfQhXuLQUTOPYJ9EOTkkfYF0JpiZo=;
 b=hbR4bBBAgz0KNAilyINC53OkG4ATsXHFqlVdaR9PnaIhlpNGdkeR2iTqrCgxUYesUWL4D5dmSw2zs6PZLRm1RiOy0CR1wd09sVz9FxwWiKVQjZP24ZWDfrJMyeyN20GW1OvXOS72neenQ/ZApTcRMFGheSKBSQ/idDJPw1G+aSg=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB5736.namprd04.prod.outlook.com (20.179.57.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Tue, 11 Jun 2019 16:48:13 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 16:48:13 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH] block: force select mq-deadline for zoned block devices
Thread-Topic: [PATCH] block: force select mq-deadline for zoned block devices
Thread-Index: AQHVGqZxdWamftnvMky58/SCjon5MA==
Date:   Tue, 11 Jun 2019 16:48:13 +0000
Message-ID: <BYAPR04MB5749B050A968D9C641B431BE86ED0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190604072340.12224-1-damien.lemoal@wdc.com>
 <BYAPR04MB5816ABA7E2F4E1B05E2F3DF1E7ED0@BYAPR04MB5816.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e65a107-c1c7-408d-5d4f-08d6ee8c9835
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5736;
x-ms-traffictypediagnostic: BYAPR04MB5736:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB5736B87BE1D6DC91E7438F4C86ED0@BYAPR04MB5736.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(376002)(366004)(346002)(396003)(189003)(199004)(76176011)(256004)(8936002)(55016002)(4326008)(52536014)(68736007)(3846002)(25786009)(478600001)(6116002)(72206003)(6506007)(102836004)(229853002)(53546011)(53936002)(14454004)(7696005)(99286004)(186003)(9686003)(5660300002)(26005)(33656002)(7736002)(74316002)(2501003)(446003)(66066001)(2906002)(73956011)(66946007)(76116006)(6436002)(66476007)(66446008)(64756008)(66556008)(86362001)(305945005)(476003)(6246003)(71200400001)(71190400001)(81166006)(81156014)(486006)(8676002)(110136005)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5736;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0NXaniTjvM5p6ee7a/5H3zTi6fV1+GXxyFOd2sKlCS0/GYYqeM8SOvo/uwW9VkARAkh0ICekpQIG1BBupjv0xJq8rNqemEGpTho1xr/GgS1g6NVhJ0CPW/gBBvZQuDiEYIKPn2k6/0OJYECvv0FZQ2i+C+zcx5f+z4Cfw1o9lql/jQcuGXKpQlYR7Gamm7in1CGiY76EJmqFt7i9V7e+3bcHU8laPJEcwK3qqXMAEuPkvOsAQtUCGsagBPC8pWMCxI/Cn2ziMjcfpQI+eq5VcFcBrgQ67HWswMKOTiKUywbIa/88IHZbFxG6F40rpkkGw/dKVjd11BJQGb0EknJNuwRrLDwq0mKYRIFjKUqwRfETU7MzD5fijCIoj2GKGsvdInX+SQguE8B9nh6wwT7j9FpEbWZema3Et1ljcWNtGq8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e65a107-c1c7-408d-5d4f-08d6ee8c9835
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 16:48:13.4371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5736
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good to me, I did make sure that when selecting ZBD option=0A=
from menuconfig MQ gets selected automatically, from make menuconfig=0A=
command.=0A=
=0A=
Tested-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 06/11/2019 02:31 AM, Damien Le Moal wrote:=0A=
> On 2019/06/04 16:23, Damien Le Moal wrote:=0A=
>> In most use cases of zoned block devices (aka SMR disks), the=0A=
>> mq-deadline scheduler is mandatory as it implements sequential write=0A=
>> command processing guarantees with zone write locking. So make sure that=
=0A=
>> this scheduler is always enabled if CONFIG_BLK_DEV_ZONED is selected.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> ---=0A=
>>   block/Kconfig | 1 +=0A=
>>   1 file changed, 1 insertion(+)=0A=
>>=0A=
>> diff --git a/block/Kconfig b/block/Kconfig=0A=
>> index 1b220101a9cb..2466dcc3ef1d 100644=0A=
>> --- a/block/Kconfig=0A=
>> +++ b/block/Kconfig=0A=
>> @@ -73,6 +73,7 @@ config BLK_DEV_INTEGRITY=0A=
>>=0A=
>>   config BLK_DEV_ZONED=0A=
>>   	bool "Zoned block device support"=0A=
>> +	select MQ_IOSCHED_DEADLINE=0A=
>>   	---help---=0A=
>>   	Block layer zoned block device support. This option enables=0A=
>>   	support for ZAC/ZBC host-managed and host-aware zoned block devices.=
=0A=
>>=0A=
>=0A=
> Ping... Any comment on this one ?=0A=
>=0A=
>=0A=
=0A=
