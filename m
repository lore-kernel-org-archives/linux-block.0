Return-Path: <SRS0=+9gR=V5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EED6C19759
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 08:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C2220838
	for <linux-block@archiver.kernel.org>; Thu,  1 Aug 2019 08:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GuQt2AC0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ydEXLg9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfHAIkE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 04:40:04 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23402 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbfHAIkD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 04:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564648804; x=1596184804;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NXwDAbIgiDDvbuVu1ZnCxCOp9FvcLD04ZJDFvbzcXfo=;
  b=GuQt2AC0r8UkjENkNIuBQXIBmJsTI6dJbV/yHirBb7EC0CLMO2lrZSI8
   d+L/AXdNVsZIPrvggvLmv4FhTCGaQGG4Ml9aTbVJMOodhF7LTIwSKxmSH
   czsezRCvYvjVbXyas8aO7vy31DhErEDSDD+qkhUIDi11Ztv505DpibHG+
   C7rOaHLoHWYHvO3iCnzeXFuCcNe4nNJjsqN3zunrPaI2OrtUCFKQJPwbU
   mNXIYWX9l8wdtBDuZ9mnXhWGAww6Ip29pPZD3ZSPZuiJMfZt7WJbjwZF2
   39csNWkJ1cBCzbyQT/1ijJs07oBEvphrlaZSVZxKa9bs0ZyfHjLODmb3P
   A==;
IronPort-SDR: G9la1yAsiXi1Y7mUQgTdaY13sIIftlNHQjOnAywtWaE2sM5E4tFXN+khQ4BE7L14KybfPji/QC
 kKUSWHiS/jCj3idL/kBGuwig0CMfRjL1Jf3e8uUmaLUnyMvX7vWytqCHUmYJLf/hzzb8ffrGiT
 zYYODooPMA45/NrmINxUxsPWNzJ9XncNCrMA2AE36CZTeknMcErGU+7hmP9ZFrHOuq7f6BxQ/i
 m3cg3PhMjtMwhQDEimTV64hHFDe+Of+wiFERdRowVZZ4NqKcXmkOTyoTqM8J3VMqJEmavZ7uY2
 wPw=
X-IronPort-AV: E=Sophos;i="5.64,333,1559491200"; 
   d="scan'208";a="115680891"
Received: from mail-sn1nam04lp2059.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.59])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 16:40:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNAHQhMwwZxVL7Gvd9MBYTJVPC02kO9Dfj6OvSAee5IOKvVo1Hly397XzxrrPamBjukWJPVK9HeDI90P4QWiYO1Mc0jvdwBF+kTJ4vVuBAxPtjDkkXFS4mzfdIlTbLC2hmt3iwDBBe+Wp7kiBJJB1c/8Yji6TWQtWufJUY19nLJacG/s6UPLtR0w6Gshfe1mRXrX4cipCwL53Bc79f16ZsaK+fgsjFV/ooa/3oza5/1/pd5ta5aXC88OM9dk9aCK3NP/22QFudH4xjrlCboendMg6HzwZbGWTd/DctP/yS2gFZ8BKs7Zli/RzmWIVKHnpZMOzL9Ok0RG39dNCI3oKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJsjk+pTJKywKFIaj0UdMIhdEEvdQ9WLxPalVWYksws=;
 b=G0S3LGLVoUPkyj7tjFeO94SxZ4Ea5cnqIQUoCnlXxdQC7w0x/l/632u+yOLs1pxLgIxz6Ht5DFO2VxtnDFY8eKy8/3FOfbmmLQBlU4pgy053fz/BG/ejt5lT7ppkChT0cL43yM/I0watzGrPzoZKZBsw7zH3zPutJEHFXhUw3GSEIl/bu0b0oIKsecOMQDHRYDrrTgcnNBKqVFHux/5+QOJ1HoeeNdAuX/rlyoYbWfCpPBWe/Ip48RJx7LnPfjXkIueg9KLai00Jk5nwUFtjRg7sBCGI7rjRgkXGRkaaz1RRN7l5THlbhZEJFl4PeNpHkJOpQBkt3ma1IGfew6y1pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJsjk+pTJKywKFIaj0UdMIhdEEvdQ9WLxPalVWYksws=;
 b=ydEXLg9jQHuzbverhUXejWeDpLyuZbSo+5zrPbgvtjpIFlGEBFYXY+ACXxDI00zZFu9oVBnR/UF2HsTh+BAho5J3KHSsJ98RTadXFZLckHr3ZE01RMV1pHqMmHLqLwApa35qcw/2sD2Oihek6HrAMUGABt2nZ6AI32R8xfgNnI8=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5879.namprd04.prod.outlook.com (20.179.59.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Thu, 1 Aug 2019 08:40:00 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.010; Thu, 1 Aug 2019
 08:40:00 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "dennis@kernel.org" <dennis@kernel.org>,
        "hare@suse.com" <hare@suse.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "dennisszhou@gmail.com" <dennisszhou@gmail.com>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "osandov@fb.com" <osandov@fb.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH 2/4] blk-zoned: implement REQ_OP_ZONE_RESET_ALL
Thread-Topic: [PATCH 2/4] blk-zoned: implement REQ_OP_ZONE_RESET_ALL
Thread-Index: AQHVR+MrYDKP+5rFjk+KMFOZIoF+xw==
Date:   Thu, 1 Aug 2019 08:40:00 +0000
Message-ID: <BYAPR04MB58166CF08BEE9427361B30A4E7DE0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190731210102.3472-1-chaitanya.kulkarni@wdc.com>
 <20190731210102.3472-3-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB581622D19EDA3071AE618634E7DE0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <BYAPR04MB5749C69F6D0A1321DD21B5CD86DE0@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd90fbaf-36f0-488e-9e2e-08d7165bd716
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5879;
x-ms-traffictypediagnostic: BYAPR04MB5879:
x-microsoft-antispam-prvs: <BYAPR04MB5879F1DBA13747BBB91379ECE7DE0@BYAPR04MB5879.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01165471DB
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(396003)(346002)(39860400002)(366004)(189003)(199004)(68736007)(186003)(478600001)(91956017)(7736002)(110136005)(256004)(2201001)(66066001)(76116006)(446003)(33656002)(8676002)(305945005)(55016002)(2501003)(53936002)(71200400001)(71190400001)(102836004)(9686003)(66476007)(6506007)(476003)(64756008)(66446008)(66946007)(54906003)(486006)(66556008)(4326008)(3846002)(5660300002)(7416002)(76176011)(8936002)(86362001)(81156014)(81166006)(25786009)(2906002)(229853002)(52536014)(26005)(6436002)(14454004)(7696005)(74316002)(6246003)(316002)(6116002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5879;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4BFJvELtdF++yiU7tlLsJnbjmJOOloy+2EmSDwTSw4JjIPekG2D/6112xGaSryOisiCgmTtS56lWXiE0Mm9bzCCYoSP5hUb3nqh37LGoo/ORVfvkdPU6c0qluYoy0xiKtKdU87US0lLO/YCOhx3ItnTNoyKxw9dYdNHFKd29yxgZx5Rl0oIY3WRs/Kahz0BIGIqLfb+JsWiWrTDDPF40Fwz18AaTtUnAYOUtukIhPf4Fbpz73R5nI33S22XFC1EOIqUKT4YkMl0brSnpxh125+TExsJhsdtoMkIksfoNaKuZZNa02Ju8kLvcT4oobQ5mV9FvpdNO7pvnEa7iemT8qJswAXUwk9lU9y07Jy9uaTihBx79qOpGCa+CLH3k/U2iX170j0QaQRjwFfg5PeTxs2JMQe2IBh+LbLi9KoWSrPc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd90fbaf-36f0-488e-9e2e-08d7165bd716
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2019 08:40:00.1234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5879
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/08/01 13:51, Chaitanya Kulkarni wrote:>>> +/*=0A=
>>> + * Special case of zone reset operation to reset all zones in one comm=
and,=0A=
>>> + * useful for applications like mkfs.=0A=
>>> + */=0A=
>>> +static int __blkdev_reset_all_zones(struct block_device *bdev, gfp_t g=
fp_mask)=0A=
>>> +{=0A=
>>> +     struct bio *bio =3D NULL;=0A=
>> =0A=
>> There is no need to initialize the bio to NULL here.=0A=
> =0A=
> [CK] Would you prefer something like following that declares and allocate=
 in=0A=
> one line which is similar in blk-lib.c:-blk_next_bio() function ? or we=
=0A=
> should keep declaration and allocation on the different line :-=0A=
=0A=
Whichever is fine with me.=0A=
=0A=
> /*=0A=
>  * Special case of zone reset operation to reset all zones in one command=
,=0A=
>  * useful for applications like mkfs.=0A=
>  */=0A=
> static int __blkdev_reset_all_zones(struct block_device *bdev, gfp_t gfp_=
mask)=0A=
> {=0A=
>         struct bio *bio =3D bio_alloc(gfp_mask, 0); =0A=
>         int ret;                                                         =
                                                                           =
       =0A=
> =0A=
>         /* across the zones operations, don't need any sectors */=0A=
=0A=
May be change this comment to something less cryptic, e.g.:=0A=
=0A=
/* For REQ_OP_ZONE_RESET_ALL, BIO sector and size are not needed  */=0A=
=0A=
>         bio_set_dev(bio, bdev);=0A=
>         bio_set_op_attrs(bio, REQ_OP_ZONE_RESET_ALL, 0); =0A=
> =0A=
>         ret =3D submit_bio_wait(bio);=0A=
>         bio_put(bio);=0A=
> =0A=
>         return ret;=0A=
> }=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
