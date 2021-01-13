Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160B1C433E0
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 05:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF3CC23125
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 05:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbhAMFyb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 00:54:31 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:49429 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbhAMFya (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 00:54:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610517270; x=1642053270;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jkqFbtFlFgAdN6sKoSe5w/pkCC18udg4WHCbRBmqwUA=;
  b=B3n+UJ0/838M9fEo5zF04grzmmpWBYjMTOokqAgIu36Y1geZFztp2UPd
   Xga5CRfbyXbyMr7k5ZeK4xSyis4A9ibeaOogHpwJnIGZ36HtPhktPaLBM
   6bO9Kgvxb2se/jeK2mVUiGtoQdFFKe3b4zq6M1HFhk2hnoPh1HHr2bNGY
   FVIn5ZaIf4XqO0wiAcKxMDkKoctYeq6KG+vcAIRgWJgCOOb0QPzzHR5XP
   QGfsSB3M9AP7ci1yOz3bU8b2fa0ey9lkyBBzlvj5FoWsaPsoZc81b99y7
   LCN03K9pQHgAkFHtsMd4NzSoh7mixjAUFnJ/gagEl+RV5k56tq5xKjQnO
   g==;
IronPort-SDR: l5SVX+tPhKE23raR8Jrw9w8futWM42yX4bTerTvrQFigRY6pnrO8ZhpVAUICF3bogg+Wt4cy78
 TnGOTTwBGZRmCuUK6cz6jpv9fRKRInFvxxZoR2ot9+m7mlZKG4iiO528sVu2XcDKdmpbX15Yb/
 uOJklyr6AChf4bcvJ3WmDrT2rdnHxT+z3ai22xwNcwJS4+TZ8MfOdxaqRw+NVet5JPkaRhM879
 Lv3pSoaceQB41sCZSwpfNvBdkfRcHxcqTHVXFXVeLlbgE2zemiDZLf0BX7js58ZRC8bN7xVgvz
 dZU=
X-IronPort-AV: E=Sophos;i="5.79,343,1602518400"; 
   d="scan'208";a="158482579"
Received: from mail-sn1nam02lp2059.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.59])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 13:53:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjTN9OqVlfTE9F4fENLp2+Zd6WS7i/7tIIU8hD7qKWzyJGZcY/LsytO1Jbo6Abtr72kdXx1DxQdPFAFOiZLzH0sTpJRhn/7TjuUt9332LkkkDCF2ldMnaxkOJioclgwSlkARI0qYea0Ht/FdKjUiFmhhAApyvHLOGDBkbncmoFDqQgZMoJSwG0lyhAVLO+UPE+o1MFgDobSXxl4Q5L3aBW61aGWcE85PF0o7IOD3BIIkQvDsDB3RZsgzAw6VrnVI0OKh9pskBBWvy27b2YQsubMdD1CVFijwFCOlU4nZSKV4ZFKjKLP4B1R296342xgXb7US5p681nRtvRJEiiAdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tbt92DQZAVhGP0zEP0lRUSh1yCLjCHU2zQROKr42RBY=;
 b=Gv+TvTvLjRD3IQxod0TcG0dBDnMM7Fmi2AFKDj3aTcIkQgX8T3b6zYT0l96DCTSOCugmRwtbMz9etiChbFH2e3tVUJxQNOw5LoDrzzL30TQUclpLaqGbru+l/B+oxxzY9JT00yTrw0YEx3yjes57zU0jPDcZCuuf5jb4fOBhOBUcGTRxjWxRx/DXYjTcuTDp3WAqIDJ44YTHzH7iv1oCVtxMcHxU5v5uPIpIjbrIm/R68kXJQPmFDWJpZK28EI0jBUgodphw8+xvmXiS7Xmr8kFW4d7jmzH8jC2xNfwc1LfB7LeN9f6OgXn08M87E43oo82tMDMmXJgG954+YQOTgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tbt92DQZAVhGP0zEP0lRUSh1yCLjCHU2zQROKr42RBY=;
 b=vm5+dRnvLHinMD2SQdOw+UOct5tiSRkmuUsM5B1X8jHbJf3PNqrjy3Q3NP3wx6TfX/smFmwplxZnAHEFijLv4Rd7JakS0DPsbWZkMZG4C+WIBHje6U4GHFwnTYKBTcxcvRb73vXyi2g2lKoqoEnVjZxxAhxXLXNHaIYTlsnItr8=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6645.namprd04.prod.outlook.com (2603:10b6:610:92::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 13 Jan
 2021 05:53:21 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%8]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 05:53:21 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Changheun Lee <nanich.lee@samsung.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>
Subject: Re: [PATCH] bio: limit bio max size.
Thread-Topic: [PATCH] bio: limit bio max size.
Thread-Index: AQHW6XBl+2obOSh/hUezqTwOunqlOg==
Date:   Wed, 13 Jan 2021 05:53:21 +0000
Message-ID: <CH2PR04MB6522091DE371F5EB7EE98200E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <CH2PR04MB65225EDDA7069CCD47A459A5E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <CGME20210113040146epcas1p230596c7c3760471dca442d1f7ce4dc55@epcas1p2.samsung.com>
 <20210113034637.1382-1-nanich.lee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:e53d:bea0:4863:19b6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0057f6c-036a-4313-7613-08d8b7878893
x-ms-traffictypediagnostic: CH2PR04MB6645:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB6645691857ACCB29D8C7C671E7A90@CH2PR04MB6645.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6PM/cW047ZRI+SCymPTDWmxWyXDQpanbZhYg8keYj8CxKqyFSrC6EFGvsK9wlqNecvoZxVNCTPFhr2Z6nz58eqdRXX/BhCievP/A6STtXU3wGaffAs+W0p8UqMcoOYgQgs8B6o+0i5WwlA3xliDQcIPQW0rrkSKA0RqCLz+7EzCsvT2Mnri2TwbYd1LxlEpqSCUU1dod7lmz8ea/AdXWOO7IpLvvj0bWgesJKZ5AIoUClt88JLPccWzhoMSWKeDRYQTwCzMbiFM++HKBIK93bVkz5bdV8/oJ3UqDc+vbiVHGS5FR0RHi7Kix2lDQ6PGhwLfuQ6+HD2CepeULL918+LIMdCfe0HdX7MWuq9sUeTNrVEkY5oxdZ2nGgQeM7Vb0+mt+FlXMhCTCaMGTWFUtIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(6916009)(7416002)(186003)(8936002)(83380400001)(53546011)(2906002)(9686003)(8676002)(55016002)(4326008)(478600001)(7696005)(54906003)(71200400001)(316002)(33656002)(66946007)(6506007)(91956017)(76116006)(66476007)(66556008)(64756008)(66446008)(86362001)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WEhWhDKgBwPOI1Rxr2qK3cB8tKCbWRDzebZrDikYBm7BJNXkWaZVPWOpZyLw?=
 =?us-ascii?Q?cwz+Z2nI8HaEE/SK1KqyQMo/smwkNni5NGdzSWxki7FPyMCV7CH+ln2MnVsO?=
 =?us-ascii?Q?g/KbVHTYNqBr9zAEoouYhJK8y5FcELXHp0We8PwkNxSrNAZFRt3a9/8GqEru?=
 =?us-ascii?Q?OUdSB8E+EsXxR6AZv4xgOm3aS2t9miZBU84rFnrI0dNt4wqww1/lTEgkzL2g?=
 =?us-ascii?Q?B81a18ehP2EJo30iml7RooB0SFgpqe7dgWqFirxycZud1V0ltnk62nQM2878?=
 =?us-ascii?Q?k/n58tTCyPDkro/IRNFmRr42xey5jubD+fbzE1xf+cxnD2mkeNhiFOJpEFdr?=
 =?us-ascii?Q?lJTNNOabZK8fR35BR8j9ckPZAn8ILxxlK1OmDXlVWwQ12YOu+CEThXuLRXPS?=
 =?us-ascii?Q?DF+9l+Wq04h0t4deECsBKYp2dsJvopz5l/L3mnAg6znSXzi+ChREjL/KWcpc?=
 =?us-ascii?Q?1NbZv8fCtUhWZyk6/Ale/7Zm+YNa1oIXabbLl93TZ4XP3tK51RozuObD7dCr?=
 =?us-ascii?Q?CI9xJJ8Umn8psyeQJP9bwRNm4HMimrRccMqwizTVY8lw186t9+kZHnIsLpJu?=
 =?us-ascii?Q?NsnzWkACnHAigfHF2wrzlHOp4Q3LUl+ftfvrsZmPkxkiOGGYfJ7Xua0KDjVZ?=
 =?us-ascii?Q?Hsz38LOSdncw6l+L36LB6D3lGWzVOuPQMI03biPJgdD1oa7WMtWY+XIRSyfJ?=
 =?us-ascii?Q?EQwi+oKf5xhoUFL3YSonZtcJLWm7PjZ0iNTl9p2liixJoV5PaXGmLmcfvb+h?=
 =?us-ascii?Q?gdS8kS/8A5k8kWVdSvlEMF9J26Upxm/LauRzDd6RiXEh9Kra7f0bg6cibfiH?=
 =?us-ascii?Q?hGeEIKKXrmqJsx7U52Ov+JcMzcircfSglw/oExlvo0csTkfcalgQTZXpd8rq?=
 =?us-ascii?Q?+wZia1A9VdOsJQWBUlC1ewVSaaq3gQ0SFrUCNV5wNfuyK/c5myJ89ZPRwlD7?=
 =?us-ascii?Q?repGVBnYOU36kSmo3kQ5ypV4+X6ulWToi2Ma4IuUVqpeRzXy+LMcgmHXNS9Q?=
 =?us-ascii?Q?tP/A+WEasK977mFAZYGQTgFvUJ/1bDMbMqwlN9SA1d0wJWo8IrQjCRWTYcMM?=
 =?us-ascii?Q?GNujr/oK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0057f6c-036a-4313-7613-08d8b7878893
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 05:53:21.1085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRknsuizfvELHbdV6w33Q8hIcF7DkgtqEyaZGVB2Eac0QYUyusbX/+h10WKlMouizHyXjBH836fthn/MFHh7ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6645
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/13 13:01, Changheun Lee wrote:=0A=
>> On 2021/01/12 21:14, Changheun Lee wrote:=0A=
>>>> On 2021/01/12 17:52, Changheun Lee wrote:=0A=
>>>>> From: "Changheun Lee" <nanich.lee@samsung.com>=0A=
>>>>>=0A=
>>>>> bio size can grow up to 4GB when muli-page bvec is enabled.=0A=
>>>>> but sometimes it would lead to inefficient behaviors.=0A=
>>>>> in case of large chunk direct I/O, - 64MB chunk read in user space -=
=0A=
>>>>> all pages for 64MB would be merged to a bio structure if memory addre=
ss is=0A=
>>>>> continued phsycally. it makes some delay to submit until merge comple=
te.=0A=
>>>>> bio max size should be limited as a proper size.=0A=
>>>>=0A=
>>>> But merging physically contiguous pages into the same bvec + later aut=
omatic bio=0A=
>>>> split on submit should give you better throughput for large IOs compar=
ed to=0A=
>>>> having to issue a bio chain of smaller BIOs that are arbitrarily sized=
 and will=0A=
>>>> likely need splitting anyway (because of DMA boundaries etc).=0A=
>>>>=0A=
>>>> Do you have a specific case where you see higher performance with this=
 patch=0A=
>>>> applied ? On Intel, BIO_MAX_SIZE would be 1MB... That is arbitrary and=
 too small=0A=
>>>> considering that many hardware can execute larger IOs than that.=0A=
>>>>=0A=
>>>=0A=
>>> When I tested 32MB chunk read with O_DIRECT in android, all pages of 32=
MB=0A=
>>> is merged into a bio structure.=0A=
>>> And elapsed time to merge complete was about 2ms.=0A=
>>> It means first bio-submit is after 2ms.=0A=
>>> If bio size is limited with 1MB with this patch, first bio-submit is ab=
out=0A=
>>> 100us by bio_full operation.=0A=
>>=0A=
>> bio_submit() will split the large BIO case into multiple requests while =
the=0A=
>> small BIO case will likely result one or two requests only. That likely =
explain=0A=
>> the time difference here. However, for the large case, the 2ms will issu=
e ALL=0A=
>> requests needed for processing the entire 32MB user IO while the 1MB bio=
 case=0A=
>> will need 32 different bio_submit() calls. So what is the actual total l=
atency=0A=
>> difference for the entire 32MB user IO ? That is I think what needs to b=
e=0A=
>> compared here.=0A=
>>=0A=
>> Also, what is your device max_sectors_kb and max queue depth ?=0A=
>>=0A=
> =0A=
> 32MB total latency is about 19ms including merge time without this patch.=
=0A=
> But with this patch, total latency is about 17ms including merge time too=
.=0A=
> Actually 32MB read time from device is same - about 16.7ms - in driver la=
yer.=0A=
> No need to hold more I/O than max_sectors_kb during bio merge.=0A=
> My device is UFS. and max_sectors_kb is 1MB, queue depth is 32.=0A=
=0A=
This may be due to the CPU being slow: it takes time to build the 32MB BIO,=
=0A=
during which the device is idling. With the 1MB BIO limit, the first BIO hi=
ts=0A=
the drive much more quickly, reducing idle time of the device and leading t=
o=0A=
higher throughput. But there are 31 more BIOs to build and issue after the =
first=0A=
one... That does create a pipeline of requests keeping the device busy, but=
 that=0A=
also likely keeps your CPU a lot more busy building these additional BIOs.=
=0A=
Overall, do you see a difference in CPU load for the 32MB BIO case vs the 1=
MB=0A=
max BIO case ? Any increase in CPU load with the lower BIO size limit ?=0A=
=0A=
> =0A=
>>> It's not large delay and can't be observed with low speed device.=0A=
>>> But it's needed to reduce merge delay for high speed device.=0A=
>>> I improved 512MB sequential read performance from 1900MB/s to 2000MB/s=
=0A=
>>> with this patch on android platform.=0A=
>>> As you said, 1MB might be small for some device.=0A=
>>> But method is needed to re-size, or select the bio max size.=0A=
>>=0A=
>> At the very least, I think that such limit should not be arbitrary as yo=
ur patch=0A=
>> proposes but rely on the device characteristics (e.g.=0A=
>> max_hw_sectors_kb/max_sectors_kb and queue depth).=0A=
>>=0A=
> =0A=
> I agree with your opinion, I thought same as your idea. For that, deep re=
search=0A=
> is needed, proper timing to set and bio structure modification, etc ...=
=0A=
=0A=
Why would you need any BIO structure modifications ? Your patch is on the r=
ight=0A=
track if limiting the BIO size is the right solution (I am not still comple=
tely=0A=
convinced). E.g., the code:=0A=
=0A=
	if (page_is_mergeable(bv, page, len, off, same_page)) {=0A=
		if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len) {=0A=
			*same_page =3D false;=0A=
			return false;=0A=
	}=0A=
=0A=
could just become:=0A=
=0A=
	if (page_is_mergeable(bv, page, len, off, same_page)) {=0A=
		if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {=0A=
			*same_page =3D false;=0A=
			return false;=0A=
	}=0A=
=0A=
With bio_max_size() being something like:=0A=
=0A=
static inline size_t bio_max_size(struct bio *bio)=0A=
{=0A=
	sector_t max_sectors =3D blk_queue_get_max_sectors(bio->bi_disk->queue,=0A=
						         bio_op(bio));=0A=
=0A=
	return max_sectors << SECTOR_SHIFT;=0A=
}=0A=
=0A=
Note that this is not super efficient as a BIO maximum size depends on the =
BIO=0A=
offset too (its start sector). So writing something similar to=0A=
blk_rq_get_max_sectors() would probably be better.=0A=
=0A=
> Current is simple patch for default bio max size.=0A=
> Before applying of multipage bvec, bio max size was 1MB in kernel 4.x by =
BIO_MAX_PAGES.=0A=
> So I think 1MB bio max size is reasonable as a default.=0A=
=0A=
max_sectors_kb is always defined for any block device so I do not think the=
re is=0A=
a need for any arbitrary default value.=0A=
=0A=
Since such optimization likely very much depend on the speed of the system =
CPU=0A=
and of the storage device used, it may be a good idea to have this configur=
able=0A=
through sysfs. That is, bio_max_size() simply returns UINT_MAX leading to n=
o=0A=
change from the current behavior if the optimization is disabled (default) =
and=0A=
max_sectors_kb if it is enabled.=0A=
=0A=
> =0A=
>>>=0A=
>>>>=0A=
>>>>>=0A=
>>>>> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>=0A=
>>>>> ---=0A=
>>>>>  block/bio.c         | 2 +-=0A=
>>>>>  include/linux/bio.h | 3 ++-=0A=
>>>>>  2 files changed, 3 insertions(+), 2 deletions(-)=0A=
>>>>>=0A=
>>>>> diff --git a/block/bio.c b/block/bio.c=0A=
>>>>> index 1f2cc1fbe283..dbe14d675f28 100644=0A=
>>>>> --- a/block/bio.c=0A=
>>>>> +++ b/block/bio.c=0A=
>>>>> @@ -877,7 +877,7 @@ bool __bio_try_merge_page(struct bio *bio, struct=
 page *page,=0A=
>>>>>  		struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];=0A=
>>>>>  =0A=
>>>>>  		if (page_is_mergeable(bv, page, len, off, same_page)) {=0A=
>>>>> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {=0A=
>>>>> +			if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len) {=0A=
>>>>>  				*same_page =3D false;=0A=
>>>>>  				return false;=0A=
>>>>>  			}=0A=
>>>>> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
>>>>> index 1edda614f7ce..0f49b354b1f6 100644=0A=
>>>>> --- a/include/linux/bio.h=0A=
>>>>> +++ b/include/linux/bio.h=0A=
>>>>> @@ -20,6 +20,7 @@=0A=
>>>>>  #endif=0A=
>>>>>  =0A=
>>>>>  #define BIO_MAX_PAGES		256=0A=
>>>>> +#define BIO_MAX_SIZE		(BIO_MAX_PAGES * PAGE_SIZE)=0A=
>>>>>  =0A=
>>>>>  #define bio_prio(bio)			(bio)->bi_ioprio=0A=
>>>>>  #define bio_set_prio(bio, prio)		((bio)->bi_ioprio =3D prio)=0A=
>>>>> @@ -113,7 +114,7 @@ static inline bool bio_full(struct bio *bio, unsi=
gned len)=0A=
>>>>>  	if (bio->bi_vcnt >=3D bio->bi_max_vecs)=0A=
>>>>>  		return true;=0A=
>>>>>  =0A=
>>>>> -	if (bio->bi_iter.bi_size > UINT_MAX - len)=0A=
>>>>> +	if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len)=0A=
>>>>>  		return true;=0A=
>>>>>  =0A=
>>>>>  	return false;=0A=
>>>>>=0A=
>>>>=0A=
>>>>=0A=
>>>> -- =0A=
>>>> Damien Le Moal=0A=
>>>> Western Digital Research=0A=
>>>=0A=
>>=0A=
>>=0A=
>> -- =0A=
>> Damien Le Moal=0A=
>> Western Digital Research=0A=
>>=0A=
> =0A=
> ---=0A=
> Changheun Lee=0A=
> Samsung Electronics=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
