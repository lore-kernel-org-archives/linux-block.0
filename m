Return-Path: <SRS0=K2Ob=YP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4B4CA9EA0
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 09:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACDB20679
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 09:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eTJ9Pqi6";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LDCpbbqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfJVJbz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:31:55 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:39735 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfJVJby (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Oct 2019 05:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571736714; x=1603272714;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bLfr7+6+6YsmAaOcdHi6Kiyn+9EujxZNyhpUMaCgB/k=;
  b=eTJ9Pqi6+u1oilCssPKLgdec/iaMsoAZ6XgkwC/CD4/Gs8PGT3HOrgEh
   A724BFUOCiJ3f48pB5hcNhQzgCr3TiMwne9CzmT5N7G6O0NQcA4aj+8uC
   DhRYHRPYgvklFInbuxGZr5x7vET+iU4xy79/PkUCAaq1YbbNqZ1KpD8Ho
   Kb/g8bCJgkUGxgw/Iii9tLWMPRvJUvX1/x6coOjrg3Exd2L9NE3GvSZuT
   DuuebQvdFat/I6sxP7KawS1BohWP6E0ePRMbU0+u7ZQptgTx+ltQkWW+s
   tj89q/JCED0Mho2DLaOnDTlMnQwUUS3onlDUVFyzwGfXwYNycCMCX3RQe
   g==;
IronPort-SDR: YYRlM1aoKz3DV+HDcvcPm/N/JhlRuhG2CnJH46EyN6gMNXXhAfIKIOIffoXEvAmNr1I7ybExZW
 E3PN/tauNIeyWhp24JfmoyyKZMG/KEiI1xeActORqKAxa2GEaBxVb7l2o1ajG1F+4zTQwm3HHI
 XleMkkm/6oO1Q/K1df4nfN9RcClfk8EdisoKwTvG2IuQjBzcW1PNHi5+TT6P2sFmqXrSX+abFp
 dmZAElZzE5nam8A1tcCbtxM/wcHjlO8vOF3172fEPaGt6lAKX9Oc3WSaDFOzXlBLXSo65xplIQ
 bUM=
X-IronPort-AV: E=Sophos;i="5.67,326,1566835200"; 
   d="scan'208";a="122626508"
Received: from mail-by2nam01lp2050.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.50])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2019 17:31:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrktFqETWnO4CQuNPSDmCuCcOI6Ke0puQOvReSgLuaXK3Xq2RBritAtzQiwiYyzZx/xd2510iatRCXUjOxC2vmkp3GKdDmHqni0BQzHXF1OSmQYglr4f4q9M+aJJ2JzkC1zlB5zWFUHhhRGWL4fRwNn5Y+PbyRvF1dMyADhVzIACNoqq75y6i66teWljicDpm18URFrsCnHiw8Ng8u2Qh3f3JTafkwzSywD3T/ugpAePBs+qnWR1141knJ1TcxopRBjD0yPcz73W870SGcKsvS0zZJ0MHpu/PQlEAhbxLc2pBEn1KXlMiZu+ymisZJJi/nQVP0aZPQh+pr1VbxDr8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6TH50atHCUTosJPPZzut+PZSMDIn8sj0YfR6PeR3pw=;
 b=cjhJ/LgUwknLHuZ4yLjhbmRVxvSmVT3dCRKHW6/RNRJIZyAKv6w2V96ikmhs6jKFPBWDXUD3vCdVWNHQbEbds7qrc1klKLBc4Gb9duP8MnszQxqA1yTd9X+F/AUBAS34l9Rf2sgtIUJVtpi8egOwvzn5XMp1CplljjfX0odPt/+AEeDLfLLUhYX+qmFoINn3abm9iUC+HKz+7xFxqpVwv/dO74IRYU8oFy4J7CjkFNF1vCQJuLGRzWcIZGsAXH6Y17vVYyh9Zfb/DatPd1oMcHzfeyLvyTDH8JWnwoiWermU0RW1PNcPQpbYvrEgfprIq+urvyWqBHgnFh2fa1w0VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6TH50atHCUTosJPPZzut+PZSMDIn8sj0YfR6PeR3pw=;
 b=LDCpbbqIbtFhF7TgU1RUQYQB3TdnvvB+LnVUVg6m6f8JbQ8qsvculrelTV7kH4YHZAxZcvxJ7nqDuSiNILQgH+sI8LkGvkui8YbjqT0cePNmX3vWvXcDPWtOYM+9RBkZTLaQIYss+bLzFtuBukYH9cn8t6k+6CnX5NSTH4MyHWk=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4695.namprd04.prod.outlook.com (52.135.239.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Tue, 22 Oct 2019 09:31:51 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::f07b:aaec:410d:bcf3]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::f07b:aaec:410d:bcf3%4]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 09:31:51 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jan Kara <jack@suse.cz>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] bdev: Factor out bdev revalidation into a common
 helper
Thread-Topic: [PATCH 1/2] bdev: Factor out bdev revalidation into a common
 helper
Thread-Index: AQHVh+riG4Lptu8Z2UerJEi1BxoETg==
Date:   Tue, 22 Oct 2019 09:31:51 +0000
Message-ID: <BYAPR04MB581650DFE043B7B01670F6E0E7680@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191021083132.5351-1-jack@suse.cz>
 <20191021083808.19335-1-jack@suse.cz>
 <BYAPR04MB5816C126635CB91E06A6FF48E7680@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20191022091513.GF2436@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d2e93cbe-9a61-4b28-0d6c-08d756d2ab7e
x-ms-traffictypediagnostic: BYAPR04MB4695:
x-microsoft-antispam-prvs: <BYAPR04MB46955608D80715743D42C4F5E7680@BYAPR04MB4695.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(199004)(189003)(66476007)(64756008)(74316002)(6246003)(6116002)(305945005)(186003)(86362001)(66066001)(476003)(3846002)(4326008)(54906003)(5660300002)(76176011)(316002)(7736002)(446003)(25786009)(66946007)(6436002)(76116006)(2906002)(66556008)(66446008)(7696005)(6916009)(14444005)(8936002)(81156014)(81166006)(71190400001)(33656002)(229853002)(478600001)(256004)(99286004)(71200400001)(486006)(9686003)(8676002)(53546011)(52536014)(102836004)(14454004)(55016002)(26005)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4695;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CQaQU42EvuCfYUKmUvnoBqic68ILmqQ6cBiYdJS1m9v3TuBRBZ9ZRoPnpk6l8u9znfuvdjwnJWU8kDDOqFpvJzRG1pGQjwaZO9958cYbCBT6s5VFp82D2zanoJUHynOtGD07HS0ZhHQGeFwkN73RB++4i+QCiuV0NYRpx4S277mWK6gM+uZf3/2s5P2D41dc9No7kqs29B2zQ9DAVXhFl9ov+vpFG2q20+xucnx4ZheLKGqXY+uG3LdOmVvyil3LXvK085/J2n0k0YDTavwbPxSLEYywnfmscieDBaV9+CRASUJiK3ybLV/H99UQQaYiQVkyuullNgM4LjRozuV9GJiMzBhKriiSJZTE4PgmTzhMmV+G9ibzVt+tBN9Q72XgpaeYMEDKAynqkh0XbZ9mzRgrrIzy1PBVKke7vUqljE7SCBuu99zSDO2/3munlCbS
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e93cbe-9a61-4b28-0d6c-08d756d2ab7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 09:31:51.6060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vWql1sBgcV3uAe8OF3xfMUQymyVhhLkaCxkgvw4bzTEFqHczo/JApj8w+DL2pgIMbiGw6vtHG5qI5Rs+ngeliA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4695
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/10/22 18:15, Jan Kara wrote:=0A=
> On Tue 22-10-19 07:58:08, Damien Le Moal wrote:=0A=
>> On 2019/10/21 17:38, Jan Kara wrote:=0A=
>>> Factor out code handling revalidation of bdev on disk change into a=0A=
>>> common helper.=0A=
>>>=0A=
>>> Signed-off-by: Jan Kara <jack@suse.cz>=0A=
>>> ---=0A=
>>>  fs/block_dev.c | 26 ++++++++++++++------------=0A=
>>>  1 file changed, 14 insertions(+), 12 deletions(-)=0A=
>>>=0A=
>>> diff --git a/fs/block_dev.c b/fs/block_dev.c=0A=
>>> index 9c073dbdc1b0..88c6d35ec71d 100644=0A=
>>> --- a/fs/block_dev.c=0A=
>>> +++ b/fs/block_dev.c=0A=
>>> @@ -1512,6 +1512,14 @@ EXPORT_SYMBOL(bd_set_size);=0A=
>>>  =0A=
>>>  static void __blkdev_put(struct block_device *bdev, fmode_t mode, int =
for_part);=0A=
>>>  =0A=
>>> +static void bdev_disk_changed(struct block_device *bdev, bool invalida=
te)=0A=
>>> +{=0A=
>>> +	if (invalidate)=0A=
>>> +		invalidate_partitions(bdev->bd_disk, bdev);=0A=
>>> +	else=0A=
>>> +		rescan_partitions(bdev->bd_disk, bdev);=0A=
>>> +}=0A=
>>> +=0A=
>>>  /*=0A=
>>>   * bd_mutex locking:=0A=
>>>   *=0A=
>>> @@ -1594,12 +1602,9 @@ static int __blkdev_get(struct block_device *bde=
v, fmode_t mode, int for_part)=0A=
>>>  			 * The latter is necessary to prevent ghost=0A=
>>>  			 * partitions on a removed medium.=0A=
>>>  			 */=0A=
>>> -			if (bdev->bd_invalidated) {=0A=
>>> -				if (!ret)=0A=
>>> -					rescan_partitions(disk, bdev);=0A=
>>> -				else if (ret =3D=3D -ENOMEDIUM)=0A=
>>> -					invalidate_partitions(disk, bdev);=0A=
>>> -			}=0A=
>>> +			if (bdev->bd_invalidated &&=0A=
>>> +			    (!ret || ret =3D=3D -ENOMEDIUM))=0A=
>>> +				bdev_disk_changed(bdev, ret =3D=3D -ENOMEDIUM);=0A=
>>=0A=
>> This is a little confusing since from its name, bdev_disk_changed() seem=
=0A=
>> to imply that a new disk is present but this is called only if bdev is=
=0A=
>> invalidated... What about calling this simply bdev_revalidate_disk(),=0A=
>> since rescan_partitions() will call the disk revalidate method.=0A=
> =0A=
> Honestly, the whole disk revalidation code is confusing to me :) I had to=
=0A=
> draw a graph of which function calls which to understand what's going on =
in=0A=
> that code and I think it could really use some refactoring. But that's=0A=
> besides current point :)=0A=
=0A=
OK. I guess I got confused too...=0A=
=0A=
> =0A=
> Your "only if bdev is invalidated" is true but not actually a full story.=
=0A=
> ->bd_invalidated effectively gets set only through check_disk_change(). A=
ll=0A=
> other places that end up calling flush_disk() clear bd_invalidated shortl=
y=0A=
> afterwards. So the function I've created is a direct counterpart to=0A=
> check_disk_change() that just needs to happen after the device is=0A=
> successfully open. I wanted to express that in the name - hence=0A=
> bdev_disk_changed(). So yes, bdev_disk_changed() should be called exactly=
=0A=
> when the new disk is present. It is bd_invalidated that is actually=0A=
> misnamed.=0A=
=0A=
Got it.=0A=
=0A=
> =0A=
> Now I'm not really tied to bdev_disk_changed(). bdev_revalidate_disk()=0A=
> seems a bit confusing to me though because the disk has actually been=0A=
> already revalidated in check_disk_change() and the function won't=0A=
> revalidate the disk for devices with partition scan disabled.>=0A=
>> Also, it seems to me that this function could be used without the=0A=
>> complex "if ()" condition by slightly modifying it:=0A=
>>=0A=
>> static void bdev_revalidate_disk(struct block_device *bdev,=0A=
>> 			         bool invalidate)=0A=
>> {=0A=
>> 	if (bdev->bd_invalidated && invalidate)=0A=
>> 		invalidate_partitions(bdev->bd_disk, bdev);=0A=
>> 	else=0A=
>> 		rescan_partitions(bdev->bd_disk, bdev);=0A=
>> }=0A=
>>=0A=
>> Otherwise, this all looks fine to me.=0A=
> =0A=
> Well, but you don't want to call rescan_partitions() if bd_invalidated is=
=0A=
> not set. But yes, we could move bd_invalidated check into=0A=
> bdev_disk_changed(), but then it would seem less clear why this function =
is=0A=
> getting called. This ties somewhat to the discussion above. Hum, I guess =
if=0A=
> we call the function just bdev_revalidate(), the name won't be confusing=
=0A=
> and it would then make sense to move the bd_invalidated condition in ther=
e.=0A=
=0A=
Indeed, we don't want another partition scan. Missed that one.=0A=
For the function name, since the goal is to revalidate only the bdev=0A=
capacity, what about bdev_revalidate_capacity() then ? But looking at=0A=
the code and seeing the partitions functions calls does not clarify=0A=
things though. Oh well, keep the name you proposed and we can cleanup=0A=
everything with a refactor :)=0A=
=0A=
Cheers.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
