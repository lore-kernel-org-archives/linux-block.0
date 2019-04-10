Return-Path: <SRS0=Dmuf=SM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98178C10F11
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 08:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553F820818
	for <linux-block@archiver.kernel.org>; Wed, 10 Apr 2019 08:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c6lLGOHk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="D29PDGiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfDJIG0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:06:26 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51485 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfDJIGZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Apr 2019 04:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1554883597; x=1586419597;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BSsXKPikFsfmCrBGeVIWSOMN4M/BybYryOMAGflCjB0=;
  b=c6lLGOHkr3uauP2fHhn+2NJ3PNy7vo7dIN7exZY4YCyreEAEcvarTZe8
   yhymdCYY8gfP+nKoODEqMdvQzz2SJSK2VTL6Wky9BGlREJYBTwppnJiTZ
   EtbfV/hOXzrLMQM7nutpvJ15xMIGYLtENA+m2SNSzr2Mka0qVGa+4fQ7k
   i3O/xRZ/BMpVjjjHnH7v+vTTVQmmH3WeldR1fawNMHji3aM/VONU/eMLr
   8MazglXZxhz5mo4Aff/0bD7Hzsa7rUfk3mH39Z1W/svSenXYbh8q2+XBE
   dvIUagNuFKPBWJSsi+8AkE8ScPdPz2ZZS9AUUXVQiDQXqSzoe1Ash0Dh9
   g==;
X-IronPort-AV: E=Sophos;i="5.60,332,1549900800"; 
   d="scan'208";a="204329956"
Received: from mail-dm3nam03lp2058.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.58])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2019 16:06:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMUZsgtNXG6yYmOIaacLkDG492+YsGDdlscd1gIGlyQ=;
 b=D29PDGiSR54EZCiJZRm/8pomn5ApWhxUW395C97nzx0fnyVfkmI4onsRImKgxAdyUsFlLW+QgGW4OkRNm9Fiql8ZJ4B8XeXusUHltmNkvwRwChpx3WOKpBzuGTWS40nSMhHkybL2Dfw8W/p8iPPvtBMbY9IUhHoxmzs/Oq8bApw=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5574.namprd04.prod.outlook.com (20.178.232.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Wed, 10 Apr 2019 08:06:20 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::ec3e:1844:ecb1:6637]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::ec3e:1844:ecb1:6637%5]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 08:06:20 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Edwards <gedwards@ddn.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Omar Sandoval <osandov@fb.com>,
        Alasdair Kergon <agk@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [dm-devel] [PATCH v2] dm zoned: Silence a static checker warning
Thread-Topic: [dm-devel] [PATCH v2] dm zoned: Silence a static checker warning
Thread-Index: AQHU73HNUX+W4p/PyEWznhtFujpE0g==
Date:   Wed, 10 Apr 2019 08:06:20 +0000
Message-ID: <BYAPR04MB5816FEE78EAE7806B8AB955AE72E0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190410074735.GA28842@kadam>
 <BYAPR04MB58160DF520B305A4328FC438E72E0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190410080305.GQ6070@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9fe66ac-24d7-4f9d-bc7b-08d6bd8b6aad
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5574;
x-ms-traffictypediagnostic: BYAPR04MB5574:
x-ms-exchange-purlcount: 1
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB55746C9E3A8210E1A71CEBEFE72E0@BYAPR04MB5574.namprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(366004)(346002)(396003)(136003)(189003)(199004)(6436002)(9686003)(14444005)(55016002)(6306002)(966005)(54906003)(316002)(486006)(33656002)(478600001)(305945005)(66066001)(4326008)(7736002)(14454004)(476003)(72206003)(256004)(86362001)(99286004)(74316002)(186003)(7416002)(6246003)(25786009)(446003)(52536014)(229853002)(102836004)(2906002)(6506007)(76176011)(6116002)(53546011)(105586002)(68736007)(26005)(5660300002)(6916009)(53936002)(561944003)(106356001)(7696005)(3846002)(97736004)(8936002)(81156014)(71200400001)(71190400001)(8676002)(81166006)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5574;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7Xxa5VjoNJ4I/BvjVKmd9PHmUVyEtVtY643MKngd0y0w6iS0yYwJtzD6QXKEzcwIL/XvnRjNUf0xCrougrKjjklMlvR7ETv/RH4VrUul2Nrrp9dXH5/lV579i3zvvUPfYMsHoA5Q3OhXBCFeC57/eBrdmWVIR+drwyAcQD3r43P1mic82+tCY6S40Z8F4WwW+OmbvMVEwSsiTP5FM4cLmeXS9ONwGi7heAFQ0RNRsywGFGm+QB2/JpAcqFD+yU2dCloi6Dx735DIzaMsOJiGYQYWUWrMhVx8KmBpfPCAzN2IBzo00XX1vnYpqtpbREwL0hLL61xCUQT9JiGjzdBzn9CwrFuB5YJ7k032SNMO5HRYQV6FnUzVcnlrr6nhdNnVwfCVVucX80sNF0LrNlhn5byJDovJ60uQQkgCMMl789k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fe66ac-24d7-4f9d-bc7b-08d6bd8b6aad
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 08:06:20.5537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5574
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/04/10 17:03, Dan Carpenter wrote:=0A=
> On Wed, Apr 10, 2019 at 07:56:14AM +0000, Damien Le Moal wrote:=0A=
>> On 2019/04/10 16:48, Dan Carpenter wrote:=0A=
>>> My static checker complains about this line from dmz_get_zoned_device()=
=0A=
>>>=0A=
>>> 	aligned_capacity =3D dev->capacity & ~(blk_queue_zone_sectors(q) - 1);=
=0A=
>>>=0A=
>>> The problem is that "aligned_capacity" and "dev->capacity" are sector_t=
=0A=
>>> type (which is a u64) but blk_queue_zone_sectors(q) returns a u32 so th=
e=0A=
>>> higher 32 bits in "aligned_capacity" are always cleared to zero.  This=
=0A=
>>> patch adds a cast to u64 to address this issue.=0A=
>>>=0A=
>>> Fixes: 114e025968b5 ("dm zoned: ignore last smaller runt zone")=0A=
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>=0A=
>>> ---=0A=
>>> v2: In v1 I changed blk_queue_zone_sectors() to return a sector_t type,=
=0A=
>>> but in v2 I just add a cast.  The v2 fix would end up going through=0A=
>>> different maintainers and reviewers so the CC list has grown...=0A=
>>>=0A=
>>> Original discussion: https://marc.info/?l=3Dkernel-janitors&m=3D1554876=
63405737&w=3D2=0A=
>>>=0A=
>>>  drivers/md/dm-zoned-target.c | 3 ++-=0A=
>>>  1 file changed, 2 insertions(+), 1 deletion(-)=0A=
>>>=0A=
>>> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.=
c=0A=
>>> index 8865c1709e16..b6cb44fa946d 100644=0A=
>>> --- a/drivers/md/dm-zoned-target.c=0A=
>>> +++ b/drivers/md/dm-zoned-target.c=0A=
>>> @@ -643,7 +643,8 @@ static int dmz_get_zoned_device(struct dm_target *t=
i, char *path)=0A=
>>>  =0A=
>>>  	q =3D bdev_get_queue(dev->bdev);=0A=
>>>  	dev->capacity =3D i_size_read(dev->bdev->bd_inode) >> SECTOR_SHIFT;=
=0A=
>>> -	aligned_capacity =3D dev->capacity & ~(blk_queue_zone_sectors(q) - 1)=
;=0A=
>>> +	aligned_capacity =3D dev->capacity &=0A=
>>> +				~((u64)blk_queue_zone_sectors(q) - 1);=0A=
>>=0A=
>> sector_t is an u64 only if CONFIG_LBDAF is defined (I think this option =
is going=0A=
>> away though). Otherwise it is an unsigned long which would be u32 on 32 =
bits=0A=
>> arch. Not a problem in terms of arithmetic, but why not cast to sector_t=
 directly ?=0A=
>>=0A=
> =0A=
> I would have prefered to do that but I didn't have strong feelings=0A=
> either way.  I am always slight annoyed when people don't just copy and=
=0A=
> paste my code when I tell them how to fix a patch so I decided to go=0A=
> with your version...  :P=0A=
=0A=
I proposed u64 cast without checking sector_t definition.=0A=
After doing that, I liked your sector_t cast more than my own misinformed=
=0A=
proposal :)=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
