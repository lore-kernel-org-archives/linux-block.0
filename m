Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556B3C433E6
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 04:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B50238A1
	for <linux-block@archiver.kernel.org>; Thu, 14 Jan 2021 04:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbhANEBn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 23:01:43 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:20378 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbhANEBm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 23:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610597510; x=1642133510;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pYCtX0pl6Tyjhk5Q4Q7cDi/fNAi4fNym8+ZOCRgvq0k=;
  b=O+0tBV59kX1nI9+Q0ZjaiA6QSEn6fbxE+s54IuYQI1Tl9iPPGSZvnOU1
   USGOqFMQZT1PswA0xy0rvohBtiNPSxrM9vEPf9konAvR04pB1iscaG/BC
   jtEUrJixdbsyHe7PhBc6FoUxuBeHcwypTv63WjdpKh0MGqzFj4rEoToZN
   IHsGrCPIrkSkiXqX4Yq0xblM5xYfZuaOJd2urEQ0ovxw1/BIbO29ryyoo
   Zmcec4zhA4d28Niyxwl3BLPisweaUskxPuNXtk2hRAd0FCPBknCvr3kxp
   IIxzTRjcH6EZBeUL3lllK5Ns91JL0ZgFkS/i7ed9WKeRVcFrPkCw/XYhy
   w==;
IronPort-SDR: ToLkHBklhexdyVMjGimD5y2wXS7+5MeZ0dzP4K3QMrXsH8iWUS1gU+fpu0RdW/lMCnPpVy0XG+
 HP9SyzM9wjiReP6omhGQfAyzmfyf2c/kWwARzpjkFcCj8BEIOjT6X0DWtP5S2GXoewhiAkCyco
 +Hl5p1W/njihp2JmB55Hv/NM5rFMKIlz1lu0e0WJV7KfgXS6tK8eJ/kRtgKdSBCOPjEor4CqoY
 nTcXYGmuJNNux4JT0OGUsO4MHvewP6TEOwf7aDhrM/M2JgZHCys3BME63dZpPpGy2FPSip7Fnd
 V20=
X-IronPort-AV: E=Sophos;i="5.79,346,1602518400"; 
   d="scan'208";a="261301465"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2021 12:10:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diYpFERmcRiab6czL5aZu+SfxVqPv+EFxguOhFkydg0F3hfDbHy2C6/jxXGMqM0Fmzn2kqLQacVcuPgxrDExLKTahY6MapXlEJrrkUMe3BJf2y0NQbpeMSwQiSP25QajWBmBuIaTwOdkQz8IoOELhdkNeRS5qGur/s6f38P0kKUdydmQZmTnUVAl/Wlb8aNP1WAXvSaNEcIpJUAiL+V8iDNS+pUujVWOkkvVPwmSng/2dOwEHJ7DbB2WRXH8EsMXlWePfJNLLAh++tCtkCO1zPbj1+K03QBsj/7LE2vF/gR+WYyF3XonYn3iX9y29BqphEPaA3QM+p2WsdgtkoWyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqocrcGPFCBERlJDFNN+jWgJy4dUF1T1fbLb004b/A4=;
 b=WsVjjJyqE7y9nuwmn2Yq8DV07Y4l6WYJrvK5e278LnOXnas3FAFnBaTdfjtc7cVmqwJDfbyyHSAgZeX89t9jIP11xSpMcD4QEFYdDHBz/E/i03XiUf2JvvszYLM1l713QafDb7CF5KUKPHgJv9p7R/HRXk2envtz8cz6AHcR3dQ5HQV9D4zC2jfMI4H94Pt9jy/vJMg7N6WoVIc4D9CYCa6pB9P52mAPJnQEZtRUSnhHIMj7eTeZtzjFERpIWNvLvOWdMc2Xhsd9ZAY3xdmRH0YfeTqfjQK0F3Op53UsOlPwnnA6B2LDTgjKBe3Kzkb+f15/1zeC4CPZYseY9NADyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqocrcGPFCBERlJDFNN+jWgJy4dUF1T1fbLb004b/A4=;
 b=C2PNR+qzXGQ35a9oSPH0jKk/wrgkTayhJkgmy9+Mz4cVjg583Mrw5Q/Whq+rJAnd0hFqGWnKHMvudMGod9w+zhIhKINedYA0t2B1hbNQHsYCcRxuCLWBMkIJUNKC5PmM4F5XZyminKYxXcvPfyqP4f7nk1Gn3xF3/0fqGyZi2HA=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4851.namprd04.prod.outlook.com (2603:10b6:208:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Thu, 14 Jan
 2021 04:00:33 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3763.011; Thu, 14 Jan 2021
 04:00:33 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Ming Lei <tom.leiming@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        Tejun Heo <tj@kernel.org>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>
Subject: Re: [PATCH] bio: limit bio max size.
Thread-Topic: [PATCH] bio: limit bio max size.
Thread-Index: AQHW6Y5jqVlL4YJWRkeFSjyRBQwtnA==
Date:   Thu, 14 Jan 2021 04:00:33 +0000
Message-ID: <BL0PR04MB651470CA7B3AA843E57AF85EE7A80@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <CGME20210113040146epcas1p230596c7c3760471dca442d1f7ce4dc55@epcas1p2.samsung.com>
 <CH2PR04MB65225EDDA7069CCD47A459A5E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20210113034637.1382-1-nanich.lee@samsung.com>
 <CACVXFVMb0eE5-yo2k3KvnJjKN+aDLzOuT9rKQ7LY5-4WTgM3jw@mail.gmail.com>
 <CH2PR04MB65228D54F66068DA125CCE47E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20210113102450.GA220440@T590>
 <CH2PR04MB6522CF231DAA4615DABA8457E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20210113114722.GA233746@T590>
 <CH2PR04MB652295091E1D9455D2132BD8E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20210114035242.GB237540@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8c78:be0:63f5:4b05]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ab17fd9c-c4f2-4bf0-d301-08d8b840f0d6
x-ms-traffictypediagnostic: BL0PR04MB4851:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB485151DCD37E6263FE43FF4CE7A80@BL0PR04MB4851.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3AN0cwTM8e+PNFx4tiOhtwonqHxutES+wdfVLSv0FqSA4/drAk06sIJe/3x4nkkv5KanwMqQm5k/8Tz4IE1lVuFi4VQ5l+ssvPkhXM7tFVdBXIYt6jCNrr/c3+cYVHgnlAdqSNFMQJgoQgtvz9JZWb7r6vt0JXBfWPdnSFV7WyzYsIIdSOUZXTifSdOxLXrjt8Aig3ccSFM1fmllvKdXGMNThPPFS/LxlDKM60Db7wRAbInKKItS9ccOzyBCN6FPUO1EsYsjBgSQZcLQAadSJ5E92Z9CanbwGV4jYSi63QDZg+7tmWJHea1LCqiakA+l496zk+SNbeznKJaTvHKs5dSLOBir9w2Wvw3vZ/uxfu0UK2QGp4EYn2nySGEciMCuvdmXB+T9WngF9RyHNLAZXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(7416002)(91956017)(6506007)(76116006)(66476007)(86362001)(64756008)(52536014)(66446008)(66556008)(6916009)(83380400001)(54906003)(55016002)(71200400001)(2906002)(9686003)(7696005)(186003)(4326008)(33656002)(5660300002)(478600001)(53546011)(8936002)(66946007)(316002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SwIOXc8EOIFxgZUmyThf+ZScujLkx/+MbYF7eVfBHYJtwNx4LZ1txdK4CzKP?=
 =?us-ascii?Q?GAReWK7++nx17oV1/2DQZFSATuD7S7h+j/Kq5kj5wqVA5SfYyP2ktv/s5X+X?=
 =?us-ascii?Q?5YNGDROoAsf1hjeI8T2RXg51PHuG3Ap8uB3Krr+juxcMXuY5WEg3YzhdPmsX?=
 =?us-ascii?Q?mXc40WbUFMovGqv2eyXrlfzuwCZC4ghY0+ZN/1OmkYeJVgTrfbFiuz/icUIW?=
 =?us-ascii?Q?hfS909UN8lL+HVVVK1QqfDyRP0/0KT/5i9CzFR2AYyGTs6a2pvoa3faFRDc7?=
 =?us-ascii?Q?uY7KMK/EBmS1T3VURUv0xteGjM1a4gvzmxJz7Kj5WQtlsVpfaE8wUwZmzYWJ?=
 =?us-ascii?Q?nGhRDeXMKNFXCQvZJR+NNpp1UdGVR9F3hS/y+EWR/Z+4sLFnb3LucpDkZZci?=
 =?us-ascii?Q?C606LsPfFrSIsiLzpSPwmWC28jdYaMi8pRnnz225yFG38k+wukGorM+F1tnw?=
 =?us-ascii?Q?YdY9UzMAgQIk4o+/89nk2+uvn7hPr7lirJQ3G/xAubmIxYLrKr0AbM+Ara7p?=
 =?us-ascii?Q?IQGUdOK2eVhTVzWc1hv/+/yYi/I54RcWNPNQ92ifnBkeQLEQavUCC8h853cK?=
 =?us-ascii?Q?qLZ5oUUJQjL6Na9GE1AqBZi3bbvGzaYJAkGMZT0/5DQuZK6OeevQe5+sPM9j?=
 =?us-ascii?Q?ROYXIl1ktROyb5qUtMZy69yPWroKlxbIu/2s1ftC3x9gxaR24vlxmELUl5ge?=
 =?us-ascii?Q?sUhujBFX4KWgPo8i5ek7bSPyOzhq0CjTDbKgUUgjBVLdYGVoZsR05unhrSAn?=
 =?us-ascii?Q?SFAc50VmAP9cJ7fZSk4fXN+Dz9lGMY1C2KnqgNcuTZt0R2UR5tGN6Q7WmtjV?=
 =?us-ascii?Q?Q9VLHvzCEEE9fokEo3idKMYFgmrwPXcFsCNuvekUCgUoa19MuXbUI+pTlOdJ?=
 =?us-ascii?Q?IeMbEX4n5IAVmZOfAjGO63S2j7+Yaej9LqvuDRUciLCveCyEDqU6qadeSVH5?=
 =?us-ascii?Q?aCgxHuteeTYpdO2HSxY3oiSpyZ4HH86PG4fCi6d5CDV8QqrGGh+V+AG6sg30?=
 =?us-ascii?Q?P5jQAdfl8Wn7Z/JBa3jmmMzlfc7FP/MHAugnAvBFM7J3AQOYG9PXQY+vzf/2?=
 =?us-ascii?Q?fGvPfIwI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab17fd9c-c4f2-4bf0-d301-08d8b840f0d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2021 04:00:33.0385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Z1BjcG3/ZsJIohOCEgQht/4KprawSaUYOK/ukaFm9md3F7NAcfYYBaPNq2RiG3YEnXgH1rS7vLOa19WrYFmhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4851
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/14 12:53, Ming Lei wrote:=0A=
> On Wed, Jan 13, 2021 at 12:02:44PM +0000, Damien Le Moal wrote:=0A=
>> On 2021/01/13 20:48, Ming Lei wrote:=0A=
>>> On Wed, Jan 13, 2021 at 11:16:11AM +0000, Damien Le Moal wrote:=0A=
>>>> On 2021/01/13 19:25, Ming Lei wrote:=0A=
>>>>> On Wed, Jan 13, 2021 at 09:28:02AM +0000, Damien Le Moal wrote:=0A=
>>>>>> On 2021/01/13 18:19, Ming Lei wrote:=0A=
>>>>>>> On Wed, Jan 13, 2021 at 12:09 PM Changheun Lee <nanich.lee@samsung.=
com> wrote:=0A=
>>>>>>>>=0A=
>>>>>>>>> On 2021/01/12 21:14, Changheun Lee wrote:=0A=
>>>>>>>>>>> On 2021/01/12 17:52, Changheun Lee wrote:=0A=
>>>>>>>>>>>> From: "Changheun Lee" <nanich.lee@samsung.com>=0A=
>>>>>>>>>>>>=0A=
>>>>>>>>>>>> bio size can grow up to 4GB when muli-page bvec is enabled.=0A=
>>>>>>>>>>>> but sometimes it would lead to inefficient behaviors.=0A=
>>>>>>>>>>>> in case of large chunk direct I/O, - 64MB chunk read in user s=
pace -=0A=
>>>>>>>>>>>> all pages for 64MB would be merged to a bio structure if memor=
y address is=0A=
>>>>>>>>>>>> continued phsycally. it makes some delay to submit until merge=
 complete.=0A=
>>>>>>>>>>>> bio max size should be limited as a proper size.=0A=
>>>>>>>>>>>=0A=
>>>>>>>>>>> But merging physically contiguous pages into the same bvec + la=
ter automatic bio=0A=
>>>>>>>>>>> split on submit should give you better throughput for large IOs=
 compared to=0A=
>>>>>>>>>>> having to issue a bio chain of smaller BIOs that are arbitraril=
y sized and will=0A=
>>>>>>>>>>> likely need splitting anyway (because of DMA boundaries etc).=
=0A=
>>>>>>>>>>>=0A=
>>>>>>>>>>> Do you have a specific case where you see higher performance wi=
th this patch=0A=
>>>>>>>>>>> applied ? On Intel, BIO_MAX_SIZE would be 1MB... That is arbitr=
ary and too small=0A=
>>>>>>>>>>> considering that many hardware can execute larger IOs than that=
.=0A=
>>>>>>>>>>>=0A=
>>>>>>>>>>=0A=
>>>>>>>>>> When I tested 32MB chunk read with O_DIRECT in android, all page=
s of 32MB=0A=
>>>>>>>>>> is merged into a bio structure.=0A=
>>>>>>>>>> And elapsed time to merge complete was about 2ms.=0A=
>>>>>>>>>> It means first bio-submit is after 2ms.=0A=
>>>>>>>>>> If bio size is limited with 1MB with this patch, first bio-submi=
t is about=0A=
>>>>>>>>>> 100us by bio_full operation.=0A=
>>>>>>>>>=0A=
>>>>>>>>> bio_submit() will split the large BIO case into multiple requests=
 while the=0A=
>>>>>>>>> small BIO case will likely result one or two requests only. That =
likely explain=0A=
>>>>>>>>> the time difference here. However, for the large case, the 2ms wi=
ll issue ALL=0A=
>>>>>>>>> requests needed for processing the entire 32MB user IO while the =
1MB bio case=0A=
>>>>>>>>> will need 32 different bio_submit() calls. So what is the actual =
total latency=0A=
>>>>>>>>> difference for the entire 32MB user IO ? That is I think what nee=
ds to be=0A=
>>>>>>>>> compared here.=0A=
>>>>>>>>>=0A=
>>>>>>>>> Also, what is your device max_sectors_kb and max queue depth ?=0A=
>>>>>>>>>=0A=
>>>>>>>>=0A=
>>>>>>>> 32MB total latency is about 19ms including merge time without this=
 patch.=0A=
>>>>>>>> But with this patch, total latency is about 17ms including merge t=
ime too.=0A=
>>>>>>>=0A=
>>>>>>> 19ms looks too big just for preparing one 32MB sized bio, which isn=
't=0A=
>>>>>>> supposed to=0A=
>>>>>>> take so long.  Can you investigate where the 19ms is taken just for=
=0A=
>>>>>>> preparing one=0A=
>>>>>>> 32MB sized bio?=0A=
>>>>>>=0A=
>>>>>> Changheun mentioned that the device side IO latency is 16.7ms out of=
 the 19ms=0A=
>>>>>> total. So the BIO handling, submission+completion takes about 2.3ms,=
 and=0A=
>>>>>> Changheun points above to 2ms for the submission part.=0A=
>>>>>=0A=
>>>>> OK, looks I misunderstood the data.=0A=
>>>>>=0A=
>>>>>>=0A=
>>>>>>>=0A=
>>>>>>> It might be iov_iter_get_pages() for handling page fault. If yes, o=
ne suggestion=0A=
>>>>>>> is to enable THP(Transparent HugePage Support) in your application.=
=0A=
>>>>>>=0A=
>>>>>> But if that was due to page faults, the same large-ish time would be=
 taken for=0A=
>>>>>> the preparing the size-limited BIOs too, no ? No matter how the BIOs=
 are diced,=0A=
>>>>>> all 32MB of pages of the user IO are referenced...=0A=
>>>>>=0A=
>>>>> If bio size is reduced to 1MB, just 256 pages need to be faulted befo=
re submitting this=0A=
>>>>> bio, instead of 256*32 pages, that is why the following words are men=
tioned:=0A=
>>>>>=0A=
>>>>> 	It means first bio-submit is after 2ms.=0A=
>>>>> 	If bio size is limited with 1MB with this patch, first bio-submit is=
 about=0A=
>>>>> 	100us by bio_full operation.=0A=
>>>>=0A=
>>>> Yes, but eventually, all pages for the 32MB IO will be faulted in, jus=
t not in=0A=
>>>> one go. Overall number of page faults is likely the same as with the l=
arge BIO=0A=
>>>> preparation. So I think we are back to my previous point, that is, red=
ucing the=0A=
>>>> device idle time by starting a BIO more quickly, even a small one, lea=
ds to=0A=
>>>> overlap between CPU time needed for the next BIO preparation and previ=
ous BIO=0A=
>>>> execution, reducing overall the latency for the entire 32MB user IO.=
=0A=
>>>=0A=
>>> When bio size is reduced from 32M to 1M:=0A=
>>>=0A=
>>> 1MB/(P(1M) + D(1M)) may become bigger than 32MB/(P(1M) + D(1M)), so=0A=
>>> throughput is improved.=0A=
>>=0A=
>> I think that the reason is that P(1M) < D(1M) and so there is overlap be=
tween P=0A=
>> and D: P of the next BIO is done on the CPU while D of the previous BIO =
is=0A=
>> ongoing on the device, assuming there is no plugging.=0A=
> =0A=
> Looks you are talking about AIO. IMO, if AIO is used in Changheun's=0A=
> test, the UFS controller pipeline can be saturated easily by many=0A=
> enough(> 8 or more) 32M requests(preparing each takes 2ms, and device nee=
d=0A=
> 16ms to handle 32MB req), then there shouldn't be such issue.=0A=
> =0A=
> So I guess Changheun uses sync dio, and the 2ms preparing time is added=
=0A=
> to bio submission delay every time.=0A=
> =0A=
> Changheun, can you talk about your 32MB block size direct IO test in a=0A=
> bit detail? AIO or sync dio? Do you have fio command line to reproduce=0A=
> this issue?=0A=
=0A=
Maybe also provide a blktrace output of for one 32MB IO execution ?=0A=
=0A=
> =0A=
> =0A=
> Thanks, =0A=
> Ming=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
