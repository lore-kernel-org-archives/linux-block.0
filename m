Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BF2C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 07:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D3F2133F
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 07:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FO0A8L1r";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BvIermmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfF1H5l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 03:57:41 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20220 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfF1H5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 03:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561708661; x=1593244661;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3ikUtPAEwNcJjjAR1/2PodzfmBQwjpfrOdftop3Elc4=;
  b=FO0A8L1rIUkIm9S35mHJ3FYXlkvMR74H8V8g+YkIAIrqQs4pJtW/tYYq
   xM5kwHHNrOIGTVzm/baKltxpEXrNgLt8YGhDewgOycHFdAzVW9zTtcZ/N
   7vNuGmzbxgyxkz9g0lQqbmpzTWfnVwpkcyWKDH7h3bSslpiQnbC0KZOPZ
   TG3FScX2M6nj2+UM2CNtACkIUdeGFKo8WjiB0F+SJ3Oj3pcuOOLZkVlzL
   tde639At/3XwjsVJzlm3r8vyo0T97QTyqbb+WBWgM6qlkypZtKL+xqxAj
   hKUWg+KomqsdO6hnmPhFAvoP5RCNnwTKANGQePGxy7MysZ/Bhj48VKzo3
   A==;
X-IronPort-AV: E=Sophos;i="5.63,426,1557158400"; 
   d="scan'208";a="116629038"
Received: from mail-by2nam05lp2055.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.55])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2019 15:57:41 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/WnsZvAB7l7xBI/dvrc7hbh0TCCBwgmcxwBvmWomIU=;
 b=BvIermmM/kJz8259WjaOiKl66YnnumqObV3fw9TITw86tAHpt3ohN8ZMNEkXk0XPcT8bfHp7EwJuzvLm0rbR2S0365zUb0a1JSJMlmGsj0Ra3YReMnqamqrksKQvSW27hn8TClRnOpQndInEBQH7Lo8NCetYK28xsi6nT4mgy98=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB6166.namprd04.prod.outlook.com (20.178.235.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Fri, 28 Jun 2019 07:57:39 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::e94e:8ead:40b1:fae6%7]) with mapi id 15.20.2032.018; Fri, 28 Jun 2019
 07:57:39 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V5 2/3] sd_zbc: Fix report zones buffer allocation
Thread-Topic: [PATCH V5 2/3] sd_zbc: Fix report zones buffer allocation
Thread-Index: AQHVLMrihbEnR+8IoE+An7DqTf8gCA==
Date:   Fri, 28 Jun 2019 07:57:38 +0000
Message-ID: <BYAPR04MB58162BAF677D0DD658B41ADFE7FC0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190627092944.20957-1-damien.lemoal@wdc.com>
 <20190627092944.20957-3-damien.lemoal@wdc.com> <20190627140900.GB6209@lst.de>
 <BYAPR04MB581641F8E665ECD324B6C397E7FC0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190628074450.GA29550@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44ea45cd-1758-4c73-cf7b-08d6fb9e4a7c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6166;
x-ms-traffictypediagnostic: BYAPR04MB6166:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB6166C9E2C7E127E7B08F0872E7FC0@BYAPR04MB6166.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(66556008)(6246003)(186003)(53936002)(9686003)(26005)(305945005)(25786009)(76176011)(4326008)(54906003)(316002)(478600001)(86362001)(8676002)(81166006)(81156014)(8936002)(53546011)(6506007)(7696005)(102836004)(66066001)(486006)(476003)(446003)(14444005)(99286004)(5660300002)(71190400001)(71200400001)(256004)(33656002)(14454004)(74316002)(2906002)(229853002)(55016002)(7736002)(6916009)(3846002)(6116002)(6436002)(52536014)(66446008)(66476007)(64756008)(73956011)(76116006)(91956017)(66946007)(68736007)(72206003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6166;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IdXKQblU3P6SRjD+/HKowsxXrAlTMOc1U9mVizmdFr62H9NdMo4UCNWW2JyTSeYZ7QlR9XyRh+CebMEEHoVO8QYQ/KlZaPGO3g/539vgryRvHQFOClLRGV3TNdvUEzK2UkFdlUbR3fiKvhOPKA6QOzLnSudjg/Zr6Cp4pNKov47I1U6nal+Mm0sVFF2lcYlR3OFv6ocJzzgeTTkCkC9X+AjhzrYbNk+ouj73M0y+9Pc5kJ4DvGkk1IJMSDKe9lJhSSqdE3lD/1EgPM6kLlIZ8vzg7j7W1EpHgXlpizHM4CIK3ekXt3zqls6u/h/EM+19vCG9wKx+4puvxM787Kx8ay8TG0KF76UvytCWJ6KjhUuqrocpgtl9bdj/bqz+XBweu2uQEtccqcDdsRbKLd+aNh/A+Y3AzQuMUYN7/vJ4veQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ea45cd-1758-4c73-cf7b-08d6fb9e4a7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 07:57:38.9793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6166
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/28/19 4:44 PM, Christoph Hellwig wrote:=0A=
> On Fri, Jun 28, 2019 at 07:30:49AM +0000, Damien Le Moal wrote:=0A=
>>=0A=
>> Yes, indeed. However, removing the gfp_flags from report_zones method=0A=
>> would limit possibilities to only GFP_NOIO or GFP_KERNEL (default=0A=
>> vmalloc). What if the caller is an FS and needs GFP_NOFS, or any other=
=0A=
>> reclaim flags ? Handling all possibilities does not seem reasonable.=0A=
>> Handling only GFP_KERNEL and GFP_IO is easy, but that would mean that=0A=
>> the caller of blkdev_report_zones would need to do itself calls to=0A=
>> whatever  memalloc_noXX_save/restore() it needs. Is that OK ?=0A=
> =0A=
> I think it is ok.  The only real possibily is noio anyway as far as=0A=
> I can tell.=0A=
> =0A=
>>=0A=
>> Currently, blkdev_report_zones() uses only either GFP_KERNEL (general=0A=
>> case, fs, dm and user ioctl), or GFP_NOIO for revalidate, disk scan and=
=0A=
>> dm-zoned error path. So removing the flag from the report zones method=
=0A=
>> while keeping it in the block layer API to distinguished these cases is=
=0A=
>> simple, but I am not sure if that will not pause problems for some=0A=
>> users. Thoughts ?=0A=
> =0A=
> I'd kill it from the block layer API and require the caller to set=0A=
> the per-task flag.  If I understood the mm maintainers correctly the=0A=
> long term plan is to kill of GFP_NOFS and GFP_NOIO flowly and just rely=
=0A=
> on the contexts.=0A=
=0A=
OK. Got it. Easy then.=0A=
However, doing everything in this patch will make the patch quite big as=0A=
nullblk and dm also need changes. Should I kill the gfp_mask argument in=0A=
a separate patch before this one ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
