Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DBBC433E1
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 10:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7D620717
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 10:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jC8rLaEY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="o7ZBOsrk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgGQKz4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:55:56 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:60973 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGQKz4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 06:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594983354; x=1626519354;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=j0zoJ18a1vOEVXMc6IgzIlMNL8EUY3vfMxArLng47tg=;
  b=jC8rLaEYC0AhD4btF6u6qftmgx1MlBXhhLLKM/nPXPGImSLGNy0MMerA
   qMamaoxYWOrYEvUXz41mqe8yVIVNR8XOlP7OpfmQccOHzTeigKfotzLhN
   d6izvxk43zjWEzRwiQBhWwMKuM6XOLf++IieqTm396Ue10oFGlCTPDiyI
   IcmqoKDRaFd/e7LSAFDXQaCBh7+yrvO8e674+nYrzKzlupqgOrCf3DS+4
   l68WX4T2mVehcc+4SJ/WMr88oy681vsrdXiEAEqvU0U54huPP5dgpmHG8
   alxWayHkBwCSP5Mf8pWFeR0jzuiFpMbv25DLteotHARad+gMZJSEVOoAe
   Q==;
IronPort-SDR: 9qDgNgQIYTqX3cA13YmCgM4hKUPxyqb5CSrf5o5PGvNUWN5G9IjUQcqioE48EEyET4ulO9XOf3
 iX8xsDD7+vuMNJ5OAac8VIGncmj8w67U1RRJEfEE4pmWRqan4Yl5yL1RnoSGNj5guxZfjywD7T
 hOeezMpug9xp3BhJPV7xv8qo8o1hVK60UTr7bt0563tsciM6YvuO2Oo8m2PSzpF79SP0gRcOAA
 oKxrM68wgcisY9XHD19KL0bWeOZFeLfniiLPB21ZD8Vb/lDAS49a5n2FNNIKuwbrJGrmEP6/Bv
 uq8=
X-IronPort-AV: E=Sophos;i="5.75,362,1589212800"; 
   d="scan'208";a="142707519"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 18:55:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0h89JGWKA29dPu/rORWSNCyZvmTTWMYR1nTS1a/RnUqOvP5GG2ukwhLcdpkraKFQ4B9Ia8NaqgZtjH03WlQWgRXpE1G+bUAvuF5m4+na7cXle075n4Uult+drx1y2P34Od18qev+jcEIUu/zrhymiroh4BUCGvLiblWHvkiJgRZ+gTheBj5L8EUGP5+vPmiMey7mQsNSPohPjQxVGC4qxmTL0RRnIsuvvcJ3KEtI0I5hkD5gshoDqbM/omilf791ac38YtSCpqJKgHD+mPYUkXC1g5AsZN8PuMeqxWgKSzh1Mwb896jROaieBY5OovMIx31t47lg+nfHkj8Fv5BDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KYZ0x/3THOF5nOGhv8jjd4ySRsGU9vGWTBjOaKxue8=;
 b=PDtEesn/c98g3GT+wiP7sMej+OfVOX6jfINP4QL0bQE8JT6v0oQsoCV+kKfEsPULUBCLW0Hu1P7h9iyZKJhH4DW2CvvWBMWopLF27nXRkAvyJGwLTCqMRewumGls4136So94Jx1AkR5TdeNVdfYaSBd8kXmc3018/K1aza5i8+1afoENL/EkI9BSKr3nliNYrnZpQcW3PKRkuXhyoOisEPCGrOsMEqnpndr56Mc0OsbMEEaGe3bjiWAgpWQ1Q5PJkJXdGE/uDXZYON0T1iorY8lGmOpKlVVKjfk/JmNQT+6RBCq00oaQj4ouF7N2ndN1IyKjuwbMRY74hb8vByo63g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KYZ0x/3THOF5nOGhv8jjd4ySRsGU9vGWTBjOaKxue8=;
 b=o7ZBOsrkiGOBxi2EtTiLPp/9hpvGh3mxqmlIGA6iftA0hzj9veE8x2PpWc7yrYldS3E7zeMJaKHQHm8gxV54J5ZWof140Y8VxaYW+kaFvDEoCI0SiWGVr+i49IGocNBCbWNpzqoL9Jp3g/ZoClCtPmcE2gawH4kbu22gxNosEJU=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0758.namprd04.prod.outlook.com (2603:10b6:903:e4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 17 Jul
 2020 10:55:49 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3174.022; Fri, 17 Jul 2020
 10:55:49 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: align max append sectors to physical block size
Thread-Topic: [PATCH] block: align max append sectors to physical block size
Thread-Index: AQHWW1k90KwUXjQMWE23AxcUX8lDNA==
Date:   Fri, 17 Jul 2020 10:55:49 +0000
Message-ID: <CY4PR04MB3751B7720950B99A50CEF485E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200716100933.3132-1-johannes.thumshirn@wdc.com>
 <20200716143441.GA937@infradead.org>
 <CY4PR04MB37512CC98154F5FDCF96B857E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717075006.GA670561@T590>
 <CY4PR04MB3751DAD907DFFB3A00B73039E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717091124.GC670561@T590>
 <CY4PR04MB3751D86F13E852C1831FB3A0E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717100232.GD670561@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a924b8d-926b-4a54-5e2b-08d82a3ff772
x-ms-traffictypediagnostic: CY4PR04MB0758:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR04MB075870B6C06A170FFD6005D7E77C0@CY4PR04MB0758.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kojgTucpZVR/z28YAw8dpmRnOVwSG144dgqkV4bdIaU9fF7WmcvVNFeqdeI3VN0c5DdPNNGkT/Zi4cfLx+ceMeQHQyORN2Hp6j0SQ27bU9xr1cPO2m5DLHurjxicoFewS06nlB3v2g2Zl7H6BOhsa0w6XHxtEK1RmS1Nas0Y0yf43v+QSwC5FPbG6PKfC5+B1oXz9ul2YNijkTq1sRFf5x4e0D7j8fflIEewBaPX7cJxf+Id/h6D7RBFHh9lU1pSp4HnJt7SBErfYW1Qf90SjvI9z/p252+AOtT6FIHzl4LfOECiEpENus2BvX17xoEEugdHzwNTkwvu/Ijemhpoeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(86362001)(52536014)(2906002)(76116006)(66476007)(91956017)(186003)(66446008)(64756008)(66556008)(6506007)(26005)(66946007)(53546011)(55016002)(33656002)(478600001)(83380400001)(4326008)(8936002)(54906003)(9686003)(71200400001)(316002)(7696005)(6916009)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nvojg5evIYh5+Li2765eA3TZxtQOJqZvkGnLdgr0ZZ3mWKczg5k3HwdaMd3fU/S2Kqv8HilN/CQFiF5YZ0XcXZxjwT9a3oXM3JqtWsnKFn3R2Baxx4l74JF6l9vfDFj34mnxG286KwB8gyvU7nkBoHBHArGW4oRW7WE/vXmzwPNhlUd/kdW0xnkgxXS2BXW4qN2TVK8OPtCsZGJnOx8p4z6mNgK6NIMFxqFrChirUXB4P+lSzoWne01UQ/4oEZZpaYdHj7WuSWyvrh8G7z0956+aYsDKD5e5KWVpb3K9qOboi7PgTD9LqwN3EuTXrbbwwq0UXJ5G8na5uy5fsl2Sa17HfLQwJ43Mu2YKFU3boq4WzINNQAeuQBETNBwvPNm0erzCxm8bPJoJZCxB3NYwM1bpmMWaMqJMYxNLGbfV8IMPmPQugynqkhf5TQq/lHAicFfREAVb1HgIgqKVO8BznsDKRRdn/zkIM+gI1fEUJ+UQsjaqZEPWKqOCivr3Wc2N
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a924b8d-926b-4a54-5e2b-08d82a3ff772
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 10:55:49.3989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCpKYjUpOzY0npHe87suJ9UKH4S5soU6nWUu8J5/+G47G1PUMUqR2QtxtOX2wlIntjVD50c7H0L/7DTEWwvCWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0758
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/17 19:02, Ming Lei wrote:=0A=
> On Fri, Jul 17, 2020 at 09:19:50AM +0000, Damien Le Moal wrote:=0A=
>> On 2020/07/17 18:12, Ming Lei wrote:=0A=
>>> On Fri, Jul 17, 2020 at 08:22:45AM +0000, Damien Le Moal wrote:=0A=
>>>> On 2020/07/17 16:50, Ming Lei wrote:=0A=
>>>>> On Fri, Jul 17, 2020 at 02:45:25AM +0000, Damien Le Moal wrote:=0A=
>>>>>> On 2020/07/16 23:35, Christoph Hellwig wrote:=0A=
>>>>>>> On Thu, Jul 16, 2020 at 07:09:33PM +0900, Johannes Thumshirn wrote:=
=0A=
>>>>>>>> Max append sectors needs to be aligned to physical block size, oth=
erwise=0A=
>>>>>>>> we can end up in a situation where it's off by 1-3 sectors which w=
ould=0A=
>>>>>>>> cause short writes with asynchronous zone append submissions from =
an FS.=0A=
>>>>>>>=0A=
>>>>>>> Huh? The physical block size is purely a hint.=0A=
>>>>>>=0A=
>>>>>> For ZBC/ZAC SMR drives, all writes must be aligned to the physical s=
ector size.=0A=
>>>>>=0A=
>>>>> Then the physical block size should be same with logical block size.=
=0A=
>>>>> The real workable limit for io request is aligned with logical block =
size.=0A=
>>>>=0A=
>>>> Yes, I know. This T10/T13 design is not the brightest thing they did..=
. on 512e=0A=
>>>> SMR drives, addressing is LBA=3D512B unit, but all writes in sequentia=
l zones must=0A=
>>>> be 4K aligned (8 LBAs).=0A=
>>>=0A=
>>> Then the issue isn't related with zone append command only. Just wonder=
ing how this=0A=
>>> special write block size alignment is enhanced in sequential zones. So =
far, write=0A=
>>> from FS or raw block size is only logical block size aligned.=0A=
>>=0A=
>> This is not enforced in sd/sd_zbc.c. If the user issues a non 4K aligned=
=0A=
>> request, it will get back an "unaligned write" error from the drive. zon=
efs and=0A=
>> dm-zoned define a 4K block size to avoid that. For applications doing ra=
w block=0A=
>> device accesses, they have to issue properly aligned writes.=0A=
> =0A=
> OK, then I guess either:=0A=
> =0A=
> 1) the same write alignment issue for zone append can be handled in=0A=
> same way with normal write on seq zone=0A=
=0A=
Yes, absolutely. I think this is fine. The point was that we at least shoul=
d be=0A=
exposing a meaningful maximum command size for that, so that the user does =
not=0A=
have to align that maximum too.=0A=
=0A=
> =0A=
> OR=0A=
> =0A=
> 2) add one new limit for write on seq zone, such as: zone_write_block_siz=
e=0A=
> =0A=
> Then the two cases can be dealt with in same way, and physical block=0A=
> size is usually a hint as Christoph mentioned, looks a bit weird to use=
=0A=
> it in this way, or at least the story should be documented.=0A=
=0A=
Yeah, but zone_write_block_size would end up always being equal to the phys=
ical=0A=
block size for SMR. For ZNS and nullblk, logical block size =3D=3D physical=
 block=0A=
size, always, so it would not be useful. I do not think such change is nece=
ssary.=0A=
=0A=
> =0A=
>>=0A=
>>>=0A=
>>>>=0A=
>>>>>=0A=
>>>>>> However, sd/sd_zbc does not change max_hw_sectors_kb to ensure align=
ment to 4K=0A=
>>>>>> on 512e disks. There is also nullblk which uses the default max_hw_s=
ectors_kb to=0A=
>>>>>> 255 x 512B sectors, which is not 4K aligned if the nullb device is c=
reated with=0A=
>>>>>> 4K block size.=0A=
>>>>>=0A=
>>>>> Actually the real limit is from max_sectors_kb which is <=3D max_hw_s=
ectors_kb, and=0A=
>>>>> both should be aligned with logical block size, IMO.=0A=
>>>>=0A=
>>>> Yes, agreed, but for nullblk device created with block size =3D 4K it =
is not. So=0A=
>>>=0A=
>>> That is because the default magic number of BLK_SAFE_MAX_SECTORS.=0A=
>>>=0A=
>>>> one driver to patch for sure. However, I though having some forced ali=
gnment in=0A=
>>>> blk_queue_max_hw_sectors() for limit->max_hw_sectors and limit->max_se=
ctors=0A=
>>>> would avoid tripping on weird values for weird drives...=0A=
>>>=0A=
>>> Maybe we can update it once the logical block size is available, such=
=0A=
>>> as:=0A=
>>>=0A=
>>> diff --git a/block/blk-settings.c b/block/blk-settings.c=0A=
>>> index 9a2c23cd9700..f9cbaadaa267 100644=0A=
>>> --- a/block/blk-settings.c=0A=
>>> +++ b/block/blk-settings.c=0A=
>>> @@ -311,6 +311,14 @@ void blk_queue_max_segment_size(struct request_que=
ue *q, unsigned int max_size)=0A=
>>>  }=0A=
>>>  EXPORT_SYMBOL(blk_queue_max_segment_size);=0A=
>>>  =0A=
>>> +static unsigned blk_queue_round_sectors(struct request_queue *q,=0A=
>>> +		unsigned sectors)=0A=
>>> +{=0A=
>>> +	u64 bytes =3D sectors << 9;=0A=
>>> +=0A=
>>> +	return (unsigned)round_down(bytes, queue_logical_block_size(q));=0A=
>>> +}=0A=
>>> +=0A=
>>>  /**=0A=
>>>   * blk_queue_logical_block_size - set logical block size for the queue=
=0A=
>>>   * @q:  the request queue for the device=0A=
>>> @@ -330,6 +338,9 @@ void blk_queue_logical_block_size(struct request_qu=
eue *q, unsigned int size)=0A=
>>>  =0A=
>>>  	if (q->limits.io_min < q->limits.physical_block_size)=0A=
>>>  		q->limits.io_min =3D q->limits.physical_block_size;=0A=
>>> +=0A=
>>> +	q->limits.max_sectors =3D blk_queue_round_sectors(q,=0A=
>>> +			q->limits.max_sectors)=0A=
>>>  }=0A=
>>>  EXPORT_SYMBOL(blk_queue_logical_block_size);=0A=
>>=0A=
>> Yes, something like this was what I had in mind so that 4Kn drives get a=
=0A=
>> sensible value aligned to the 4K LBA, always. However, with the above, t=
here is=0A=
>> no guarantee that max_sectors is already set when the logical block size=
 is set.=0A=
>> I am not sure about the reverse either. So the rounding may need to be i=
n both=0A=
>> blk_queue_logical_block_size() and blk_queue_max_hw_sectors().=0A=
> =0A=
> OK, that looks better.=0A=
=0A=
OK.=0A=
=0A=
Johannes, care to resend your patch ?=0A=
=0A=
> =0A=
> Thanks,=0A=
> Ming=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
