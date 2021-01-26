Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB8DC433E6
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 06:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D419D22D04
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 06:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbhAZG2o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:28:44 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26054 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbhAZG1Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 01:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611642435; x=1643178435;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zeqby7w2Ga/nGiPXyA+vp9YZPuYW0VjticIIr4bQjVY=;
  b=Jdt+as//6lu9Kk1w+QVRvyMwkTDmgn/S7t4HWnEMXNO6Rtslyz2qHqfj
   b2LG1DRArbOMxra+93cCoUlOFPu9P0ZfgtshRZi1Qq7dL9oOLszU7viGC
   y9M/WVQ71hR3QNNnevJaJOcL2OqpQejRiVlDdtwQmoiMhf/BXVZz1SV3M
   +84DCgCAabvUfw+1W7fEqltfTudddAvKm3fT0qI+ze5+jcLTo2Y+VhU53
   a3hjaRt7RtGZFuYSaSILMhlThbw2BRjicyYrS9QjFu4rSylzoczayJha1
   Ok/Lp4wctHtjLFRW2LbsMxt0OYJ81q1w03RNHi2c4DeMC5IbyxDly59rF
   Q==;
IronPort-SDR: JHhJeyumR54D6d6W4dACdt6aoabpDPgy2GcpLvbF4Yl/Tc5UOxO2qiBIPnpLCD86saw+HGeqNX
 GLihHr9kp4GbkACYdeBNXQwbeaYRRWeqdXu0k18XkcsUZwWAyZvQk76xj4omc3FgodTOYlkvCI
 nO2HHEMOLcvv16yqH+dH0TQpk8/5/72oSXrZNxgJsRJFn15Qtcj9C5IM0ZSJxER/5WGW3zJoNp
 PwntL8B2iwuWKFMQ6n4PPoOcpHEeRlyLwFm1SSNN1lJzWxeRCzKX8TPfFRn9wU8qVRvX5l3MDB
 SPw=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="158321879"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 14:26:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eqiff4YJv8zHBNmK5M5fIeKXtgYuDplA6wCbNhbIVaxzQIK48PQ/f10vHGnAqbIH8BdX9ByCoM0dPs1cIQFkNLGTk2ioJ0FZ4YqfDijAzjaPD4JGfURf6m2x9DLPoVk6OhQYdWzUw711WdhrTifSnPNgtAV14M++9yPDgduqC3ccoCL1gXOkj9HmdriMCP6keDByIKFp2rQc5I6fp+848xX6lI7g0hdRcNZmeMMxoMZNNHClejy0hMAd1i9NPENCGjxxgdeOZ9+cj66UImUJifkKOBejmyCw51q4WNfqoMMGCHklokg4EaAVM8d4cGlwNHjNN7Qj3fQ6YCf/6EB6bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UUatJyq6BNOYWE0BPMnlSWZTURH0LRY8VPZxPPVL7c=;
 b=H8dtU7gSPO+lSjs/uxVbbickLG2KRFyBZdV4st0iqXeGCLMA0P3FxZ865S5PylMztEUOtTotnzJTh3VrnLAhTEvidtoyB+HUVQ9ZurgrawmBcvJq2IVDNggvcr3iBtL0JVmG1huaNdi7CZU6IHwYXDnypGsVzLL/NE9PEjez8uvgV8C+7b3d6DhZ8zNhltyVmc3dXj3MPoN0X5qRHM21/Gj3NoboGRv5fURSdRbYltUF9gqkKE+vu0jMB1yOIJAz8FWloEAJmz9eDQ+jb3j/cfEfr7TOO25bYlImdk9NCJuP6pHaOXqf7SRd3Cgb+prc1HLNWmVEWfrFJ//QEoM/Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UUatJyq6BNOYWE0BPMnlSWZTURH0LRY8VPZxPPVL7c=;
 b=UhijJV+3zIzbept1VPa/Yq6BXht5uJSai+EOy/jb31bnetFTsza45ShodUGopHyXcCcjver15xri4U7pF9RyDvrlWseGIxVNFWtBWMVRh3ysMSkyCSYnxEtGkQydDMcgkZPBj8P8WZd5bM+iRvUh1psxm8NCEsawICh2s0Mshcs=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4852.namprd04.prod.outlook.com (2603:10b6:208:59::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Tue, 26 Jan
 2021 06:26:02 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Tue, 26 Jan 2021
 06:26:02 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Changheun Lee <nanich.lee@samsung.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>
Subject: Re: [PATCH v3 1/2] bio: limit bio max size
Thread-Topic: [PATCH v3 1/2] bio: limit bio max size
Thread-Index: AQHW84VRloabNXvGbkml+gtfdHfb2g==
Date:   Tue, 26 Jan 2021 06:26:02 +0000
Message-ID: <BL0PR04MB65144B93443C4F8EF9C48024E7BC9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <CGME20210126014805epcas1p2c4fc40f01c9c89b0a94ff6cac5408347@epcas1p2.samsung.com>
 <20210126013235.28711-1-nanich.lee@samsung.com>
 <20210126035748.GA1071341@T590>
 <BL0PR04MB65143B60B6062996764423C3E7BC9@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210126060724.GA1086419@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:59be:e05f:a0a7:a46c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dad677c2-3f02-40a3-3a46-08d8c1c3411d
x-ms-traffictypediagnostic: BL0PR04MB4852:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB48520BDEE10E26568E335F3CE7BC9@BL0PR04MB4852.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aYblKxnPDv4TfrJQZCMOCnrrrN2Ec9zz97D2LI6zLdi4MK55CQpeDxXLnSRSl/DQpR916XQAQ3s+1W2qYpkz6GKaXiSQOHwBnUc/hHQr3QD95UKE37JtSLY3uveFqYsRxoPELrx69H96Xz2FLlKrY/G+rw4q98yuq+ulwlHy4ARejWomZ4eTo+Bmrrr0ToOjx3xqPwnfFCDRUisyMoaJijNq/NN9kBSEls70gg02UMYY2crNlq8yCeo0h1KFUjyeB/vuqDPhEqLdQPtCg6xV3T23Lko4fthVzZ8n9niHvALCF++JFPGk8uGtqDKLtPuK4mc4mLXURSwBSQrU4FhQ7PYRH/wgcGf6V3BBbmlwinzwsSJoaDYz8XazXd74JmmGeRLm0Baa6lo6xIC6tgRWJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(186003)(71200400001)(53546011)(6506007)(86362001)(8676002)(66556008)(83380400001)(64756008)(66476007)(76116006)(316002)(66446008)(91956017)(2906002)(6916009)(66946007)(4326008)(7696005)(7416002)(54906003)(52536014)(5660300002)(55016002)(8936002)(33656002)(478600001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?leDYLjWh9r0gKgreh9ZJsELNPlydATyxaCOl0au6SYEPxMl1f/0Rto4BRzRa?=
 =?us-ascii?Q?Y4BDI3Rx65noEG+lrScYEVIDcHkAEYTIIgEKGFtuUiNh/fO1yVFPq1A0KCJW?=
 =?us-ascii?Q?bWDQFNqzF246OlhnpGihoipVLEuXOTg6Szn2X/PB16Z4l9NwQk4+SctIZUeJ?=
 =?us-ascii?Q?gznuHvo5SvPN+d+yq9w4KHlo+sohn/ip8Dfu0cHIuWgAHZuYbcgA9oi0Txla?=
 =?us-ascii?Q?enZKAeNHkOEcv4Hs3yQsRYQNTAiswH740OuGCHdcbUhkxIg71X5oPVkDOBtV?=
 =?us-ascii?Q?oBU0Kq7hAFRFqT8Br21lBTYqxra61GHNK/kur49j/swgCZhJPvFSP+K+orYN?=
 =?us-ascii?Q?3CAvbOs0wd/oTPBKk6jfEZFX+GDJM8GPQfJ2HCfT3WRbgzt+z3AojUpQrGFK?=
 =?us-ascii?Q?QEgUA7eSEjyoM+BD6aJ7fmHWfX29HWhjJ73fl+BAjLIKK2k6+fp+UMUMEI0Z?=
 =?us-ascii?Q?E/46z5fwgpjlYhV0ONSfIq7RFXCktEZgMr0899x6lvUdfRHfFNM8NLpXWqUr?=
 =?us-ascii?Q?FUxkEnPRGaHIuUVglhzuItmEcevNtLf1wMrM/Mwk02qkIdJCugP04oimBb6v?=
 =?us-ascii?Q?jhbZS6pBX+o+xUFN7hraDiX0nfEe0E8SoBEeGLZgcvwvfgH0EtByAdke3xya?=
 =?us-ascii?Q?89kl8C/sq9vcWWXs4tRJ43iDFBXQi05+doZi7MGTOJoBvt+7xoVEglFwtzaE?=
 =?us-ascii?Q?fl8HjMEVnHe/1S6IpUUhiYTJjl58n4TA95YZGPeEvR5+CHwlrFffwldPSo0o?=
 =?us-ascii?Q?qi4fy199FnYY/77D4+fKr3kETfr/V01AXzsROHMPq+kERp5pL0xAow1RdqC1?=
 =?us-ascii?Q?kDKbOkCvY+zKmZf8akifVLjryUL+7fwaAVSoUFbaszk+9qduZmbI00Q47QBU?=
 =?us-ascii?Q?vvsxU2VvAp43SA2nhmqWKrWXGm4npITocov/muVmX+F526WIpm9hYQ26T5Jt?=
 =?us-ascii?Q?o18YUo4bJWAKf7VwJ/VwJu9tiDFH2Hd/FGtFuHQbsUnTwVImoRmYFWlZtcAi?=
 =?us-ascii?Q?xl1reh+rizaTUb2BGqkUsCnNdk6tjzdDwEAF5sUsyNCm9UD21GH9m57UeKkG?=
 =?us-ascii?Q?AQhNlnnwqEiXPqjM/xYKEDYODGxXBJ4PsR6kl+U41v/lN3hMku4UgYFCU5E7?=
 =?us-ascii?Q?1nQ8ZvIiteiOuu405mcF6QTz0j3DzPAwGQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad677c2-3f02-40a3-3a46-08d8c1c3411d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 06:26:02.7047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JdiigEeanmYJwNWTLRvPVuMghuoQee2yXgNmZRiAalxgSiEkpaAu+5fU9HNhTfwiHAX/yi+1ZnntdoVmstuBHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4852
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/26 15:07, Ming Lei wrote:=0A=
> On Tue, Jan 26, 2021 at 04:06:06AM +0000, Damien Le Moal wrote:=0A=
>> On 2021/01/26 12:58, Ming Lei wrote:=0A=
>>> On Tue, Jan 26, 2021 at 10:32:34AM +0900, Changheun Lee wrote:=0A=
>>>> bio size can grow up to 4GB when muli-page bvec is enabled.=0A=
>>>> but sometimes it would lead to inefficient behaviors.=0A=
>>>> in case of large chunk direct I/O, - 32MB chunk read in user space -=
=0A=
>>>> all pages for 32MB would be merged to a bio structure if the pages=0A=
>>>> physical addresses are contiguous. it makes some delay to submit=0A=
>>>> until merge complete. bio max size should be limited to a proper size.=
=0A=
>>>>=0A=
>>>> When 32MB chunk read with direct I/O option is coming from userspace,=
=0A=
>>>> kernel behavior is below now. it's timeline.=0A=
>>>>=0A=
>>>>  | bio merge for 32MB. total 8,192 pages are merged.=0A=
>>>>  | total elapsed time is over 2ms.=0A=
>>>>  |------------------ ... ----------------------->|=0A=
>>>>                                                  | 8,192 pages merged =
a bio.=0A=
>>>>                                                  | at this time, first=
 bio submit is done.=0A=
>>>>                                                  | 1 bio is split to 3=
2 read request and issue.=0A=
>>>>                                                  |--------------->=0A=
>>>>                                                   |--------------->=0A=
>>>>                                                    |--------------->=
=0A=
>>>>                                                               ......=
=0A=
>>>>                                                                    |--=
------------->=0A=
>>>>                                                                     |-=
-------------->|=0A=
>>>>                           total 19ms elapsed to complete 32MB read don=
e from device. |=0A=
>>>>=0A=
>>>> If bio max size is limited with 1MB, behavior is changed below.=0A=
>>>>=0A=
>>>>  | bio merge for 1MB. 256 pages are merged for each bio.=0A=
>>>>  | total 32 bio will be made.=0A=
>>>>  | total elapsed time is over 2ms. it's same.=0A=
>>>>  | but, first bio submit timing is fast. about 100us.=0A=
>>>>  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|=0A=
>>>>       | 256 pages merged a bio.=0A=
>>>>       | at this time, first bio submit is done.=0A=
>>>>       | and 1 read request is issued for 1 bio.=0A=
>>>>       |--------------->=0A=
>>>>            |--------------->=0A=
>>>>                 |--------------->=0A=
>>>>                                       ......=0A=
>>>>                                                  |--------------->=0A=
>>>>                                                   |--------------->|=
=0A=
>>>>         total 17ms elapsed to complete 32MB read done from device. |=
=0A=
>>>>=0A=
>>>> As a result, read request issue timing is faster if bio max size is li=
mited.=0A=
>>>> Current kernel behavior with multipage bvec, super large bio can be cr=
eated.=0A=
>>>> And it lead to delay first I/O request issue.=0A=
>>>>=0A=
>>>> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>=0A=
>>>> ---=0A=
>>>>  block/bio.c            | 17 ++++++++++++++++-=0A=
>>>>  include/linux/bio.h    |  4 +++-=0A=
>>>>  include/linux/blkdev.h |  3 +++=0A=
>>>>  3 files changed, 22 insertions(+), 2 deletions(-)=0A=
>>>>=0A=
>>>> diff --git a/block/bio.c b/block/bio.c=0A=
>>>> index 1f2cc1fbe283..ec0281889045 100644=0A=
>>>> --- a/block/bio.c=0A=
>>>> +++ b/block/bio.c=0A=
>>>> @@ -287,6 +287,21 @@ void bio_init(struct bio *bio, struct bio_vec *ta=
ble,=0A=
>>>>  }=0A=
>>>>  EXPORT_SYMBOL(bio_init);=0A=
>>>>  =0A=
>>>> +unsigned int bio_max_size(struct bio *bio)=0A=
>>>> +{=0A=
>>>> +	struct request_queue *q;=0A=
>>>> +=0A=
>>>> +	if (!bio->bi_disk)=0A=
>>>> +		return UINT_MAX;=0A=
>>>> +=0A=
>>>> +	q =3D bio->bi_disk->queue;=0A=
>>>> +	if (!blk_queue_limit_bio_size(q))=0A=
>>>> +		return UINT_MAX;=0A=
>>>> +=0A=
>>>> +	return blk_queue_get_max_sectors(q, bio_op(bio)) << SECTOR_SHIFT;=0A=
>>>> +}=0A=
>>>> +EXPORT_SYMBOL(bio_max_size);=0A=
>>>> +=0A=
>>>>  /**=0A=
>>>>   * bio_reset - reinitialize a bio=0A=
>>>>   * @bio:	bio to reset=0A=
>>>> @@ -877,7 +892,7 @@ bool __bio_try_merge_page(struct bio *bio, struct =
page *page,=0A=
>>>>  		struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];=0A=
>>>>  =0A=
>>>>  		if (page_is_mergeable(bv, page, len, off, same_page)) {=0A=
>>>> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {=0A=
>>>> +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {=0A=
>>>>  				*same_page =3D false;=0A=
>>>>  				return false;=0A=
>>>>  			}=0A=
>>>=0A=
>>> So far we don't need bio->bi_disk or bio->bi_bdev(will be changed in=0A=
>>> Christoph's patch) during adding page to bio, so there is null ptr=0A=
>>> refereance risk.=0A=
>>>=0A=
>>>> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
>>>> index 1edda614f7ce..cdb134ca7bf5 100644=0A=
>>>> --- a/include/linux/bio.h=0A=
>>>> +++ b/include/linux/bio.h=0A=
>>>> @@ -100,6 +100,8 @@ static inline void *bio_data(struct bio *bio)=0A=
>>>>  	return NULL;=0A=
>>>>  }=0A=
>>>>  =0A=
>>>> +extern unsigned int bio_max_size(struct bio *);=0A=
>>>> +=0A=
>>>>  /**=0A=
>>>>   * bio_full - check if the bio is full=0A=
>>>>   * @bio:	bio to check=0A=
>>>> @@ -113,7 +115,7 @@ static inline bool bio_full(struct bio *bio, unsig=
ned len)=0A=
>>>>  	if (bio->bi_vcnt >=3D bio->bi_max_vecs)=0A=
>>>>  		return true;=0A=
>>>>  =0A=
>>>> -	if (bio->bi_iter.bi_size > UINT_MAX - len)=0A=
>>>> +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)=0A=
>>>>  		return true;=0A=
>>>>  =0A=
>>>>  	return false;=0A=
>>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>>>> index f94ee3089e01..3aeab9e7e97b 100644=0A=
>>>> --- a/include/linux/blkdev.h=0A=
>>>> +++ b/include/linux/blkdev.h=0A=
>>>> @@ -621,6 +621,7 @@ struct request_queue {=0A=
>>>>  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */=0A=
>>>>  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is acti=
ve */=0A=
>>>>  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */=0A=
>>>> +#define QUEUE_FLAG_LIMIT_BIO_SIZE 30	/* limit bio size */=0A=
>>>>  =0A=
>>>>  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\=0A=
>>>>  				 (1 << QUEUE_FLAG_SAME_COMP) |		\=0A=
>>>> @@ -667,6 +668,8 @@ bool blk_queue_flag_test_and_set(unsigned int flag=
, struct request_queue *q);=0A=
>>>>  #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)=
=0A=
>>>>  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)-=
>queue_flags)=0A=
>>>>  #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_f=
lags)=0A=
>>>> +#define blk_queue_limit_bio_size(q)	\=0A=
>>>> +	test_bit(QUEUE_FLAG_LIMIT_BIO_SIZE, &(q)->queue_flags)=0A=
>>>=0A=
>>> I don't think it is a good idea by adding queue flag for this purpose,=
=0A=
>>> since this case just needs to limit bio size for not delay bio submissi=
on=0A=
>>> too much, which is kind of logical thing, nothing to do with request qu=
eue.=0A=
>>>=0A=
>>> Just wondering why you don't take the following way:=0A=
>>>=0A=
>>>=0A=
>>> diff --git a/block/bio.c b/block/bio.c=0A=
>>> index 99040a7e6656..35852f7f47d4 100644=0A=
>>> --- a/block/bio.c=0A=
>>> +++ b/block/bio.c=0A=
>>> @@ -1081,7 +1081,7 @@ static int __bio_iov_append_get_pages(struct bio =
*bio, struct iov_iter *iter)=0A=
>>>   * It's intended for direct IO, so doesn't do PSI tracking, the caller=
 is=0A=
>>>   * responsible for setting BIO_WORKINGSET if necessary.=0A=
>>>   */=0A=
>>> -int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)=0A=
>>> +int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter, boo=
l sync)=0A=
>>>  {=0A=
>>>  	int ret =3D 0;=0A=
>>>  =0A=
>>> @@ -1092,12 +1092,20 @@ int bio_iov_iter_get_pages(struct bio *bio, str=
uct iov_iter *iter)=0A=
>>>  		bio_set_flag(bio, BIO_NO_PAGE_REF);=0A=
>>>  		return 0;=0A=
>>>  	} else {=0A=
>>> +		/*=0A=
>>> +		 * Don't add too many pages in case of sync dio for=0A=
>>> +		 * avoiding delay bio submission too much especially=0A=
>>> +		 * pinning user pages in memory isn't cheap.=0A=
>>> +		 */=0A=
>>> +		const unsigned int max_size =3D sync ? (1U << 12) : UINT_MAX;=0A=
>>=0A=
>> 4KB max bio size ? That is a little small :)=0A=
> =0A=
> It should have been (1U << 20), :-(=0A=
=0A=
Sounds better !=0A=
=0A=
> =0A=
>> In any case, I am not a fan of using an arbitrary value not related to t=
he=0A=
>> actual device characteristics. Wouldn't it be better to us the device=0A=
>> max_sectors limit ? And that limit would need to be zone_append_max_sect=
ors for=0A=
>> zone append writes. So some helper like Changheun bio_max_size() may be =
useful.=0A=
> =0A=
> Firstly, bio->bi_disk may not be initialized when adding page to bio; sec=
ondly this=0A=
> limit isn't really related with device, is it? Also if it is one queue li=
mit, it has=0A=
> to be stacked.=0A=
=0A=
1MB can be used as a fallback default if the gendisk is not yet set. If it =
is,=0A=
using a queue limit that does not cause bio splitting after submit makes mo=
st=0A=
sense as that avoid useless overhead. I agree, it is not critical, but it w=
ould=0A=
be nice to have some number that causes less splitting than the arbitrary 1=
MB.=0A=
E,g, most HDDs will likely have that 1MB BIO split... And max_sectors is a=
=0A=
stacked queue limit, no ? We could use max_hw_sectors too I think.=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
