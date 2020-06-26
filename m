Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA32C433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 07:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CAB320768
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 07:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j2AiI9Qo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MKaJwVVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgFZHGk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:06:40 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13378 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgFZHGj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 03:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593155197; x=1624691197;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=C9NdNwRcHDIdkR39gpY0ry8Ns5xsG6Iyjh3Q8KgYGgM=;
  b=j2AiI9QoH5BAEGvzZkHT5SXesx2ixqjVU5pvH8eV8SUCU6Q9F5DsYUPx
   wVWVBLNJIOlxA9fUgIx4Fx1RYVCq7/6gXkzy1c0XM1VXQDr+yWWs/sYCp
   2GFyftjSEtqhpcAlPM1cCs5DYh3C6KqQaI5jwd4rWcfzE4J4o5pex1+4S
   GDUNX2B3aIMRe7aGN0qInWi+h3pDDWqUEg9hiyDIbntqCRLy0FEC9SRz4
   wbtpFF4tmgSGoAAXjtz+y1tKSiTWtqeSiVsy90vShtiosTI9x/KJfCNl1
   cVxAntE5FBOsn1lqssRZPcHPXJqNKzgrIXD8dcH8oK5j088XD069qnRK4
   w==;
IronPort-SDR: 0ju2qf9KulTnrcn7yT3XuvpfED74IzfPdig3HU+rlMwULP3Av9rWL2QxbtCQa9n0636lhNiEHx
 AXi+KYHge6w6/ODUYmfMeS6OHlC4u28g7/7ZCl9QuQty4PRoRWyXJTk8GPe7U2hsS2vswGk4D7
 LEPKfJV7WwgIjqQOSEKepeC0gvaQskiMqwYA05Ljnf+yFqah9osAIEfGx3mkZ2/H7tcTKqtPKK
 cgeVlXPFypSj1k0tympgBeYgkpDCFfFKvvh2F3/mKXWdDzioV+kSPnrTV/sDkLKEZWplisnVgc
 AqI=
X-IronPort-AV: E=Sophos;i="5.75,282,1589212800"; 
   d="scan'208";a="142346710"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 15:06:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkJbYhoB9WhvttygzGo+vLPKrJ6aIh6JrTF+dpA7TdysjXpK02ICU/r49dyg+JuFxvonJWvWBwdzdJhJH8LCgGsL+PXLPQPtNBJ6jdrLV3+QNu39ggY8hgzBnvwg/qfu+FoY8i0HNeSB4Qf2sVaf1miYH2cAItEWiKTe5ddO5df1lVdBprvMPzZxPArLYtIRKbtdNDUWTMFe2MVyK3MhYwHA8yzbe1+CRssiQXRbn71YlAiDFRUvJowt5u+aZBI8QOyNwEyXcyIrgaMvYxwFuQzH/mdi24VBvrP1UHidyNNALTMknkk6zeN77YACzxJ56GT9c+wr6ramb1rQVmvhwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clnAStJUcMgNAK5FKKBCCZS79EBLTojaoXzkOvzXlSI=;
 b=lcZq7NFPc99whZ0wCY4eqYz6XEqXPt0tubz4MpRmYgZxRzhO1V2Tmw+ujw8MMx+rPoGIs9ztuwG/opTCPYw8xpNtK+7v2qqiIr4DrBk00N7vuNQPlplnBLqlHXt65eKZ9TZpIAfnYVL2Mq+GOEg1ym/+rYI0ypLUHpnqWhYyGEBEnFWUbdIcEECu8m9fGPb0ryTRbCbXMdm9VAyBTVPXTXjHDC2/k7Hi4LVYs3CmFjYgyJd2BSzXnbqioK/UFysdiNVF+xCSpcJPWcj21XMoJUYzz5lU9AmJ67Zuo/tkBQOTO0Y7P23EVQKT+ZDACRr20t/f4F84IZZVmAPF7m7d0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clnAStJUcMgNAK5FKKBCCZS79EBLTojaoXzkOvzXlSI=;
 b=MKaJwVVaIbEynDvq7EiDK1xo8G+LTXmuSb/hFzKJXGb9gCUCLIIYM7YdP8l5rEuilwzsSMLiCdUxKP6ch5WEs2Ugj9/m05jm8i5ejMWQvGlT5BMCujBSR4oOJhU5DouD45FiHtWYbXTH0LPmOv4JRVdzM+8Oai5D+70Ak26nwOo=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR04MB0344.namprd04.prod.outlook.com (2603:10b6:903:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 07:06:34 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::c593:f271:eebe:ac7%9]) with mapi id 15.20.3131.024; Fri, 26 Jun 2020
 07:06:34 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 2/6] block: add support for selecting all zones
Thread-Topic: [PATCH 2/6] block: add support for selecting all zones
Thread-Index: AQHWSutRrDHAt43U1UKTuwgck7oDsA==
Date:   Fri, 26 Jun 2020 07:06:34 +0000
Message-ID: <CY4PR04MB3751CD082BC0F77A5284EC34E7930@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-3-javier@javigon.com>
 <CY4PR04MB375143652B4BA25F1680A91EE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626055852.ec6bfvx7mj3ucz5r@mpHalley.localdomain>
 <CY4PR04MB37515E78D85933EAFE159B0AE7930@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200626065241.u4fd3m7624kdsonw@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5946aa23-a38d-4b97-263e-08d8199f760b
x-ms-traffictypediagnostic: CY4PR04MB0344:
x-microsoft-antispam-prvs: <CY4PR04MB034477B9C07AB2913BC0E8B1E7930@CY4PR04MB0344.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKIM+zK0gRvCvdcSRcLIGcxjOfnQNi1Mv/OLX5UxyVpV5B2pVq7LtjlNwYMwTitRhkjcs9sMMyoYBrzWG5iDcYzEhoJPXfE/DQUEk0Ba4rz6zYu9GvlRUa8wuv/3x5HgO7gyeph+Xx4U1IgYijNGTF6KagROomDYNvg1MSdUmVF4rP+CrmAfmZctT5hneJuV3AJVqpGo7Vhi+CLfjksMwgvDRqLeV71JrAoPjZuj+6XrDpvN2Xh8yV5Z9gWetPrGGDs8uoYlXGz/dLHbni/DgesZ4Wfl9fTo7oAa4vppgBMY/b7igC9qzbWG2h3/zgV2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(66556008)(54906003)(86362001)(316002)(5660300002)(33656002)(4326008)(478600001)(9686003)(66946007)(7696005)(66574015)(91956017)(64756008)(55016002)(83380400001)(6916009)(66476007)(2906002)(71200400001)(76116006)(7416002)(66446008)(6506007)(186003)(8936002)(52536014)(8676002)(26005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: UnYfSUkxD44fpxUMw1mWrdLoluuQ86bvWye3pd9r/SS8NNtliWnn8gyL1O9TF868j+TEB9OAAqaJiZemU+wu+VqYQ2hRLGHj+OmHmYH9f+RzTy5x5adOXUwspoPp/B5FR2xYfkQwVOIA3FJ5VeBD7NOiRgS8dZAuAClgWevlfF2nNcC24hC0DsLUQH3H4cuOGvuE+gsmk1Dh0PmFiatTsMa7Rzf0jSxfbWthW0DGIq6oBn2d/Iov0tfzsBxEsaFPhjM/TvPqL9oV7LZtoQW+Gvuj2y3QAzHx11Bnov2jdlmsZd+5CfDZGgFI3SwyAXA9w6SHaopOymtGxAWHKD6QD7r8/Eavj7OIEjG50WavnfaeBUqq0iiLU8Hr/ui3VBfI+KB4DIhityIYjxbNkTSWb/LQtpXBIXc0bDwIGlTQtQC0eUbcNiwia93u3CpQ9lrCXPqACPSlnvFImX/Pee2t66iPh62vRt2yoU7NompX5cNLkTabLd3AqTXbQ/EvfSyA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5946aa23-a38d-4b97-263e-08d8199f760b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 07:06:34.2772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rkJX5ygFY6I6L5NFABdwEuFcCkppUqlrvAnvJkXarVjGlQI0YhE4TlyKmj5GBB6NuVUCB3pWDLe0CAIxuClldw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0344
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/06/26 15:52, Javier Gonz=E1lez wrote:=0A=
> On 26.06.2020 06:35, Damien Le Moal wrote:=0A=
>> On 2020/06/26 14:58, Javier Gonz=E1lez wrote:=0A=
>>> On 26.06.2020 01:27, Damien Le Moal wrote:=0A=
>>>> On 2020/06/25 21:22, Javier Gonz=E1lez wrote:=0A=
>>>>> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>>>=0A=
>>>>> Add flag to allow selecting all zones on a single zone management=0A=
>>>>> operation=0A=
>>>>>=0A=
>>>>> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>>>>> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>=0A=
>>>>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>=0A=
>>>>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>=0A=
>>>>> ---=0A=
>>>>>  block/blk-zoned.c             | 3 +++=0A=
>>>>>  include/linux/blk_types.h     | 3 ++-=0A=
>>>>>  include/uapi/linux/blkzoned.h | 9 +++++++++=0A=
>>>>>  3 files changed, 14 insertions(+), 1 deletion(-)=0A=
>>>>>=0A=
>>>>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
>>>>> index e87c60004dc5..29194388a1bb 100644=0A=
>>>>> --- a/block/blk-zoned.c=0A=
>>>>> +++ b/block/blk-zoned.c=0A=
>>>>> @@ -420,6 +420,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *b=
dev, fmode_t mode,=0A=
>>>>>  		return -ENOTTY;=0A=
>>>>>  	}=0A=
>>>>>=0A=
>>>>> +	if (zmgmt.flags & BLK_ZONE_SELECT_ALL)=0A=
>>>>> +		op |=3D REQ_ZONE_ALL;=0A=
>>>>> +=0A=
>>>>>  	return blkdev_zone_mgmt(bdev, op, zmgmt.sector, zmgmt.nr_sectors,=
=0A=
>>>>>  				GFP_KERNEL);=0A=
>>>>>  }=0A=
>>>>> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
>>>>> index ccb895f911b1..16b57fb2b99c 100644=0A=
>>>>> --- a/include/linux/blk_types.h=0A=
>>>>> +++ b/include/linux/blk_types.h=0A=
>>>>> @@ -351,6 +351,7 @@ enum req_flag_bits {=0A=
>>>>>  	 * work item to avoid such priority inversions.=0A=
>>>>>  	 */=0A=
>>>>>  	__REQ_CGROUP_PUNT,=0A=
>>>>> +	__REQ_ZONE_ALL,		/* apply zone operation to all zones */=0A=
>>>>>=0A=
>>>>>  	/* command specific flags for REQ_OP_WRITE_ZEROES: */=0A=
>>>>>  	__REQ_NOUNMAP,		/* do not free blocks when zeroing */=0A=
>>>>> @@ -378,7 +379,7 @@ enum req_flag_bits {=0A=
>>>>>  #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)=0A=
>>>>>  #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)=0A=
>>>>>  #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)=0A=
>>>>> -=0A=
>>>>> +#define REQ_ZONE_ALL		(1ULL << __REQ_ZONE_ALL)=0A=
>>>>>  #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)=0A=
>>>>>  #define REQ_HIPRI		(1ULL << __REQ_HIPRI)=0A=
>>>>>=0A=
>>>>> diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzo=
ned.h=0A=
>>>>> index 07b5fde21d9f..a8c89fe58f97 100644=0A=
>>>>> --- a/include/uapi/linux/blkzoned.h=0A=
>>>>> +++ b/include/uapi/linux/blkzoned.h=0A=
>>>>> @@ -157,6 +157,15 @@ enum blk_zone_action {=0A=
>>>>>  	BLK_ZONE_MGMT_RESET	=3D 0x4,=0A=
>>>>>  };=0A=
>>>>>=0A=
>>>>> +/**=0A=
>>>>> + * enum blk_zone_mgmt_flags - Flags for blk_zone_mgmt=0A=
>>>>> + *=0A=
>>>>> + * BLK_ZONE_SELECT_ALL: Select all zones for current zone action=0A=
>>>>> + */=0A=
>>>>> +enum blk_zone_mgmt_flags {=0A=
>>>>> +	BLK_ZONE_SELECT_ALL	=3D 1 << 0,=0A=
>>>>> +};=0A=
>>>>> +=0A=
>>>>>  /**=0A=
>>>>>   * struct blk_zone_mgmt - Extended zoned management=0A=
>>>>>   *=0A=
>>>>>=0A=
>>>>=0A=
>>>> NACK.=0A=
>>>>=0A=
>>>> Details:=0A=
>>>> 1) REQ_OP_ZONE_RESET together with REQ_ZONE_ALL is the same as=0A=
>>>> REQ_OP_ZONE_RESET_ALL, isn't it ? You are duplicating a functionality =
that=0A=
>>>> already exists.=0A=
>>>> 2) The patch introduces REQ_ZONE_ALL at the block layer only without d=
efining=0A=
>>>> how it ties into SCSI and NVMe driver use of it. Is REQ_ZONE_ALL indic=
ating that=0A=
>>>> the zone management commands are to be executed with the ALL bit set ?=
 If yes,=0A=
>>>> that will break device-mapper. See the special code for handling=0A=
>>>> REQ_OP_ZONE_RESET_ALL. That code is in place for a reason: the target =
block=0A=
>>>> device may not be an entire physical device. In that case, applying a =
zone=0A=
>>>> management command to all zones of the physical drive is wrong.=0A=
>>>> 3) REQ_ZONE_ALL seems completely equivalent to specifying a sector ran=
ge of [0=0A=
>>>> .. drive capacity]. So what is the point ? The current interface handl=
es that.=0A=
>>>> That is how we chose between REQ_OP_ZONE_RESET and REQ_OP_ZONE_RESET_A=
LL right now.=0A=
>>>> 4) Without any in-kernel user, I do not see the point. And for applica=
tions, I=0A=
>>>> do not see any good use case for doing open all, close all, offline al=
l or=0A=
>>>> finish all. If you have any such good use case, please elaborate.=0A=
>>>>=0A=
>>>=0A=
>>> The main use if reset all, but without having to look through all zones=
,=0A=
>>> as it imposes an overhead when we have a large number of zones. Having=
=0A=
>>> the possibility to offload it to HW is more efficient.=0A=
>>>=0A=
>>> I had not thought about the device mapper use case. Would it be an=0A=
>>> option to translate this into REQ_OP_ZONE_RESET_ALL when we have a=0A=
>>> device mapper (or any other case where this might break) and then leave=
=0A=
>>> the bit go to the driver if it applies to the whole device?=0A=
>>=0A=
>> But REQ_OP_ZONE_RESET_ALL is already implemented and supported and will =
reset=0A=
>> all zones of a drive using a single command if the ioctl is called for t=
he=0A=
>> entire sector range of a physical drive. For device mapper with a partia=
l=0A=
>> mapping, the per zone reset loop will be used. If you have no other use =
case for=0A=
>> the REQ_ZONE_ALL flag, what is the point here ? Reset is already optimiz=
ed for=0A=
>> the all zones case=0A=
> =0A=
> OK. I might have missed this. I thought we were sending several commands=
=0A=
> instead of a single reset with the bit. I will check again. Thanks for=0A=
> pointing at this.=0A=
=0A=
In block/blk-zoned.c, there is:=0A=
=0A=
static inline bool blkdev_allow_reset_all_zones(struct block_device *bdev,=
=0A=
                                                sector_t sector,=0A=
                                                sector_t nr_sectors)=0A=
{=0A=
        if (!blk_queue_zone_resetall(bdev_get_queue(bdev)))=0A=
                return false;=0A=
=0A=
        /*=0A=
         * REQ_OP_ZONE_RESET_ALL can be executed only if the number of sect=
ors=0A=
         * of the applicable zone range is the entire disk.=0A=
         */=0A=
        return !sector && nr_sectors =3D=3D get_capacity(bdev->bd_disk);=0A=
}=0A=
=0A=
And:=0A=
=0A=
int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,=0A=
                     sector_t sector, sector_t nr_sectors,=0A=
                     gfp_t gfp_mask)=0A=
{=0A=
	...=0A=
=0A=
	while (sector < end_sector) {=0A=
                bio =3D blk_next_bio(bio, 0, gfp_mask);=0A=
                bio_set_dev(bio, bdev);=0A=
=0A=
                /*=0A=
                 * Special case for the zone reset operation that reset all=
=0A=
                 * zones, this is useful for applications like mkfs.=0A=
                 */=0A=
                if (op =3D=3D REQ_OP_ZONE_RESET &&=0A=
                    blkdev_allow_reset_all_zones(bdev, sector, nr_sectors))=
 {=0A=
                        bio->bi_opf =3D REQ_OP_ZONE_RESET_ALL;=0A=
                        break;=0A=
			^^^^^ This means one command only...=0A=
=0A=
                }=0A=
=0A=
                bio->bi_opf =3D op | REQ_SYNC;=0A=
                bio->bi_iter.bi_sector =3D sector;=0A=
                sector +=3D zone_sectors;=0A=
=0A=
                /* This may take a while, so be nice to others */=0A=
                cond_resched();=0A=
        }=0A=
=0A=
        ret =3D submit_bio_wait(bio);=0A=
        bio_put(bio);=0A=
=0A=
        return ret;=0A=
}=0A=
=0A=
And see scsi/sd_zbc.c and zns.c. REQ_OP_ZONE_RESET_ALL end up setting the A=
LL=0A=
bit for reset command.=0A=
=0A=
=0A=
> =0A=
> Javier=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
