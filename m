Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D60C433E0
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 05:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB012065F
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 05:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aquL23pl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="adkcw81Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgEOFZT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 01:25:19 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43448 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgEOFZS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 01:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589520317; x=1621056317;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WPY4EuvV9+xztTHCMY84xsXTANucfO0zqs+MlQCJrLI=;
  b=aquL23plXQsyD5aWKf7DIrdLpA5WTwqfG5EWb+wbgfWZP8cHOzOLEw+e
   gamQm0Pv1jXNJK2u0e1/q5MP+Fhpp3nZ5D4V9s3dR2jnkes1qONEAQv9O
   cya8cQnoGxW6139/XJlRGfzeetCkLLCvU9PyyAHpCO0ec0j3QIdT39DOm
   EkQn3gnZ02sWgmiDvzba4W5Ic9P1B3uSG/c1+85qN7DJhzq0kbtIb2/CN
   7xuMw2Nc+F6L+YL23gKWK22VSWXAwPMRu+DtCo6rBpstLNLWRYPV0D3Tj
   WwU5/6S24xtFAM9P9WkMA9009ue68Gzg2pi+prh/5JsirHCc5JtFdHHcI
   Q==;
IronPort-SDR: MygH64CeY13JNABLrpsQKSWa7Q5mtLQAzOyQbTG95mYfiXqWrspx0121eUcpyYbrxkoGnhFjCf
 reGYc/f088TlX4I/DLHnx80LDH7TQ14lAo80NpeHliB24dBfYV3eJKzdxdtp+/B5dT4U3UoQgY
 Szuxl6sIkog4GXquVN4IZg0tvo1yRWcCNsqShEBE6C5osrTBlIgbmrzHhvVEXdLRx5jwm5i7aX
 xnF94V6grFEMFgE8VjVjPe/LuMar97JSlWtQNXZSKooIWLyTihpaGnkF+ixHWp9qvmPVNnyv4w
 Tw4=
X-IronPort-AV: E=Sophos;i="5.73,394,1583164800"; 
   d="scan'208";a="137749080"
Received: from mail-bl2nam02lp2051.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.51])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2020 13:25:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAxxvoV0bvAxegL+wD3DNbkImooESD9VPA6PeeHUuIt94otMudvG94+P6uVUXMET6E1XvA10ge1T+FV7SJzkHzOpAITo+OwqCqCa5anhEa2+MBEhNA4/clP9/vftP81mqOtvXHOo8Lv4b+Yv3DmmT8Z+ihiGac9Qx4kMx7j2rT4pgvECvUvKsHZFO0watOel8trwcW6qZ1qD+weOWtIUHlkkkTrlg6V0PKcSgmLCldU8I18BfqD0tgn2hOWDU/EtkG6IbIATkCFvHWIOd0+dNG+uadIwIdQ2WYQXKpIkVkR/j7UScNuqcHlIXXChSI+Gac1j2Tk02kXPQyLNltgMiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZvtMMLtvqv0wgNAKbOJ3icuXAFXMYPrib6DViE7qQ8=;
 b=ZKQoq865xwUMQDpfyXrJCGBwv3eFYeNesm4ywO3352CcB8tPYcQaoN12xzdy9TaUKqTR0VawzLzKlxTlLE+KOXz6lxZblXqGrtMltgekJsgBd2Ls0Ew6ySJH8bCtQEMgCn5GDMxoPgq0WhioUmE6tZ6oha20oy2/7cFtds54VrsxF5f3lCENBxu9qj/vJcM4CA+xIU8UEjHrenVNCxbFe6e6YRfYxUoSQMLx6P3cS3ikLC78+3TMGquXsppMzHHOSyPP6VlLIiUXxOgCWWZqzVqxq0NuSA+jVcCb373iZ1cupc/OGcbnUZXAZ4xknH0bJQdjZl3Na1EBxJDw2kBZzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZvtMMLtvqv0wgNAKbOJ3icuXAFXMYPrib6DViE7qQ8=;
 b=adkcw81Q7BEFdXQUdGaKmXzC7laA0/NruXCiobV1mezIYQ0yH9rpWyruRnp/TLF0Z6d6/GQogtyPR5jKEHXyGfNw7V5iiyHyMoEzc6j1ZagDpP7y0solvobhg77ObGlMiuWMUjv2riVjgS0Sx0p2uinj8HoBvgGNk2uCcSDT0MU=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6883.namprd04.prod.outlook.com (2603:10b6:a03:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 15 May
 2020 05:25:15 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%6]) with mapi id 15.20.3000.016; Fri, 15 May 2020
 05:25:15 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Coly Li <colyli@suse.de>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: deny zone management ioctl on mounted fs
Thread-Topic: [PATCH] block: deny zone management ioctl on mounted fs
Thread-Index: AQHWKgx58zbe4Ia6T0+rduO1YoE04A==
Date:   Fri, 15 May 2020 05:25:14 +0000
Message-ID: <BY5PR04MB6900E4FC84C094C4FD51C9CAE7BD0@BY5PR04MB6900.namprd04.prod.outlook.com>
References: <20200514162643.11880-1-johannes.thumshirn@wdc.com>
 <BY5PR04MB69006DE86D1050620B5EDAA4E7BD0@BY5PR04MB6900.namprd04.prod.outlook.com>
 <8bc40310-6d2d-4b2f-ae56-17899fc29d22@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85cfe80e-0482-47b5-17a2-08d7f8905930
x-ms-traffictypediagnostic: BY5PR04MB6883:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB688317299DB820419AF1749EE7BD0@BY5PR04MB6883.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bGB3RAM3BYLV+/R4XdIffo8BBpDuVuP3PupVPliesB9ntTZ4CMbG689UiefZ8+4le8PpBs4zLc3bOvhdpWVkn5+nOdWRCXojZLJvJug88xjV36iJf0Han2DdV+KglJajjY0LLAE4POGg0xkqXguEhazplDmyTwBztP69CxEY0v3ODHq9pxI6wjKwu6X09LI/2rXVW9wyJom+XMrpFHnBuO68/F0H9P25/eMYWAlnIRv+r9YjY+X9IWxNcBswRLzPU/Eh77mywgMqH9E82m4mDvf+vX+0B/fHfFXZjEFL/h2CmGTtwKIJiofADq4aB7feXkilNE8qbU6Ld7+eZjqHF/t2kGa5vqNQu94zCFeXRQusqcKBvNAlfotTRI/zv2gMzdlsk/4Z28WNHHK2tmJbSmav/SZOtuM7A0zfWbNK52/T1uw+vF8RMqr63Gk8uvgCRZFlgEOJ0yoAkr2T7pxNGuh0HiBPsAyP4pZCbn5IMgdY7go9G+Of8IRl9Ov+kg9PqFgtmMz+c5bXcERe4Je7lid0UR5Ac+/GtPAUwbnwCgec8hnigLOA44AwNsO65hA3CWufwIDYOnfC/i8FJb03nA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(52536014)(66446008)(64756008)(86362001)(5660300002)(66476007)(76116006)(66946007)(66556008)(2906002)(4326008)(71200400001)(8676002)(8936002)(55016002)(53546011)(6506007)(6916009)(26005)(478600001)(9686003)(316002)(54906003)(33656002)(966005)(7696005)(186003)(10126625002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: V/Z+ybngOazJMCw6CbnHR8FaPg3rFr+vjM1JtiRUC+6uVdw8/QsLD/mnoOMR9D+bHD4lYZdtRMrjr/AtSOXQuqxC6OJZ0DiTcxEgWhIUejxhgzcc8CpuZec3A3kUABSj/Nm1DHRa8E7RSfL+MdxXuN0+Y4QcWn6lsM9vQtZs/LuAO6GHiw3Q2m0g/OdEEwllyoGu7E0pxWE+7svPqVrigxinjeYFZXZuecXMxDq70K5IblmkFFg5Rgkd9Ug6XCUxOykY+T3S00vygQixTXnUNRJYC1cNH1zbXCu0OTip/yPE7ukdCir9S21mzJ59XzHb7XKHdSjrxOEKUMvYJbMo8oU+OT1yP0uU84pUt3XhoK4oAwuNxymQbjxofziQgqUs/6JdNpRocR3Qwlw0WyIPl9Fkwiv/za3Gnc7697VqAOv+aC0qoS15GezYs5sp2fBl6A7FQNDo76FIktmcpHF8+oGa2f2Y7y5YehZNrSxzzw7XkFItCkjjl5z1XqCnRKTI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cfe80e-0482-47b5-17a2-08d7f8905930
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 05:25:14.9765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/xo1AbQR2AzmOi0n5cLw0UgdpvSGokNprWW6T9EWbKis52YCSieCy3BVr17OnLUINwaTo+OWqzS6uiJKdCjxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6883
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/05/15 14:09, Coly Li wrote:=0A=
> On 2020/5/15 12:52, Damien Le Moal wrote:=0A=
>> On 2020/05/15 1:26, Johannes Thumshirn wrote:=0A=
>>> If a user submits a zone management ioctl from user-space, like a zone=
=0A=
>>> reset and a file-system (like zonefs or f2fs) is mounted on the zoned=
=0A=
>>> block device, the zone will get reset and the file-system's cached valu=
e=0A=
>>> of the zone's write-pointer becomes invalid.=0A=
>>>=0A=
>>> Subsequent writes to this zone from the file-system will result in=0A=
>>> unaligned writes and the drive will error out.=0A=
>>>=0A=
>>> Deny zone management ioctls when a super_block is found on the block=0A=
>>> device.=0A=
>>=0A=
>> Zone management ioctls can only be executed by users that have SYS_CAP_A=
DMIN=0A=
>> capabilities. If these start doing stupid things, the system is probably=
 in for=0A=
>> a lot of troubles beyond what this patch is trying to prevent.=0A=
>>=0A=
>> In addition, there are so many other ways that a mounted zoned block dev=
ice can=0A=
>> be corrupted beyond these ioctls that I am not sure this patch is very u=
seful.=0A=
>> E.g. any raw block device write in a zone would also cause the FS to see=
=0A=
>> unaligned writes, and any other raw block device access is also possible=
 for=0A=
>> SYS_CAP_ADMIN users. Preventing only these ioctls does not really improv=
e=0A=
>> anything I think. That may even be harmful has that would prevent things=
 like=0A=
>> inline file system check utilities to run.=0A=
>>=0A=
>>=0A=
> =0A=
> The problem I encountered was, after I write 8KB data into seq/0 file, I=
=0A=
> want to re-write from offset 0. At that moment I didn't know to use=0A=
> 'truncate -s 0' to reset the write pointer of this zone file, so I use=0A=
> 'blkzone reset' to reset the write pointer of seq zone 0, and I saw the=
=0A=
> write pointer was reset to 0. But I still was not able to write data=0A=
> into seq/0 file on offset 0. Then I decided to reset all the zones by=0A=
> command 'blkzone reset -o 0 -c <zones number>', then the command hung=0A=
> for 20+ minutes and not response. From the kernel message I saw quite a=
=0A=
> log error message (an example is on pastbin: https://pastebin.com/ZFFNsaE=
0)=0A=
> =0A=
> In my mind, there are 2 methods to reset a zone, one is from blkzone,=0A=
> one is from truncate on zonefs. I guess I am not the first/last one=0A=
> which thinks the two method should work both, and has no idea when the=0A=
> above error encountered.=0A=
=0A=
Well yes, that is correct. These are methods to reset zones. But for a moun=
ted=0A=
disk, any raw block device operation can corrupt the file system on it. Tha=
t is=0A=
a principle that remains true for zoned block devices. Resenting a zone dir=
ectly=0A=
on the device without the FS being aware of the operation will (and does)=
=0A=
corrupt the FS. Same for raw disk writes vs file writes on any mounted disk=
...=0A=
=0A=
> =0A=
> Reject blkzone reset command when the zoned SMR drive is mounted by=0A=
> zonefs, it is OK to me to avoid confusion and further mistake. IMHO,=0A=
> This is a solution at least.=0A=
=0A=
libblkid now includes patches supporting zonefs detection, so yes, we can p=
atch=0A=
blkzone to reject zone management operations if the device is mounted. We n=
eed=0A=
the same for f2fs and dm-zoned too. Time to clean that up. Will do.=0A=
=0A=
> =0A=
> Thanks.=0A=
> =0A=
> Coly Li=0A=
> =0A=
>>>=0A=
>>> Reported-by: Coly Li <colyli@suse.de>=0A=
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>> ---=0A=
>>>=0A=
>>> Is there a better way to check for a mounted FS than get_super()/drop_s=
uper()?=0A=
>>>=0A=
>>>  block/blk-zoned.c | 7 +++++++=0A=
>>>  1 file changed, 7 insertions(+)=0A=
>>>=0A=
>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
>>> index 23831fa8701d..6923695ec414 100644=0A=
>>> --- a/block/blk-zoned.c=0A=
>>> +++ b/block/blk-zoned.c=0A=
>>> @@ -325,6 +325,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bde=
v, fmode_t mode,=0A=
>>>  			   unsigned int cmd, unsigned long arg)=0A=
>>>  {=0A=
>>>  	void __user *argp =3D (void __user *)arg;=0A=
>>> +	struct super_block *sb;=0A=
>>>  	struct request_queue *q;=0A=
>>>  	struct blk_zone_range zrange;=0A=
>>>  	enum req_opf op;=0A=
>>> @@ -345,6 +346,12 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bd=
ev, fmode_t mode,=0A=
>>>  	if (!(mode & FMODE_WRITE))=0A=
>>>  		return -EBADF;=0A=
>>>  =0A=
>>> +	sb =3D get_super(bdev);=0A=
>>> +	if (sb) {=0A=
>>> +		drop_super(sb);=0A=
>>> +		return -EINVAL;=0A=
>>> +	}=0A=
>>> +=0A=
>>>  	if (copy_from_user(&zrange, argp, sizeof(struct blk_zone_range)))=0A=
>>>  		return -EFAULT;=0A=
>>>  =0A=
>>>=0A=
>>=0A=
>>=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
