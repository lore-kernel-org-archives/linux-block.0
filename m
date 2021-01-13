Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2812AC4332B
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 07:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F6E23133
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 07:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbhAMHNb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 02:13:31 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:30430 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbhAMHNa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 02:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610522084; x=1642058084;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fkjJtgEbbcI2o/7c02ehlHGcJ4l370+33dnrSwU4dgg=;
  b=A0rX8KtKFKdKEUnEGQmjgBLcxhprhr+In7YMUQCbG7pFEmxSPL0ftijS
   Le/pY8RSstIuZC6vPw6vI0wRnWfnnsgXQfzgzaBlCMi5kfU41+BW4Zmww
   f/e5LcprhYKdv+Qj7GWP4+jljYwHnXwkC73w1qE0DeIWFiXF3hNMwmr7o
   F7pyj4q0fWJlZoTlAgeVkCpFtxaBAwDuCzbU8mQ8y3hjrOdbb+V4eE2zX
   05c/HbEo094pb7JIwa/+MnsJL/rHyFllaYGxf1tQJx5DoA05wA0DNNwyd
   STwza4ydp83ZOzuoJw+yC8jtTsx37/4kv1Z8/SnfIJYK61NYQqOhCoTg0
   Q==;
IronPort-SDR: lK/7N2FIaYex4bNR4TjfVj+z+ADNSYlokvB7bV6Mffn+V9R6qCq6q62nPrf6ozn2AmfHqjVD79
 pL/4KpqlIeW11/LX24picPr6e56L37NzSEtWefTfC98TVwkzc1z8WClne3MyrfUTCNxUczpyTw
 619p2TIfN2GxootWvjB+Q9EiZF6JZ+i/PN3r5nWbyF14izetKazl1V+um5Bkfodt49ZPoCLy10
 GTrruqk8ZBemAgMg+Rn8CXcOiIKbE0OLF68ZOgBwJCnF1zRu5KOUG8mlm8MZTZv+vp6t/48NoP
 CfE=
X-IronPort-AV: E=Sophos;i="5.79,343,1602518400"; 
   d="scan'208";a="261218229"
Received: from mail-co1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.52])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 15:13:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJsodGgzCNhpCK7d6wO1QyFsZAbhibkdqBIGPhzADVs+6L0F6EAtfIn8IeGWtX7lmj1XpInqIwPt1dI2LzyZ0KLNqlXK/WPnCyVUEROHrOs5RVO4FOtkXb6D4K+tPO0ZF27SRlNk5H/D3hB2jLjtJF0nBrq7EgNdK39T9Zwpb33bjIv+s0n2t9tRvIIoIjLZe2vqQIKKTfGrStmi3JoQV2FX/5yQ6xOsBWEaApiYQbz4cYhTWwPMFZQZePg2HkDQ+fZG02RL3O8FWPDh7oWusKaMR5pyE7GcgWF559WNpiYqEQSJu6XLMkwNYKeA1Gowd2MXB3KY5eBbpUoZC5IR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hekEKQ4NZeDKFiJPn6n8nIPg+qIT/Q1P3FSxoR6zdxc=;
 b=AgVrtAD6zMYQpGjER0urVscnvkOcG94sbbLC06neNy3uaClY+pkSWIolGBgCUU6LJNfA9I4WOuqf4CGCwiGIEl7BFeXRlxy0xIeOYALBk5YnJb7h3tu6G8o4JaBACReRAPexYSPVvt03GIeJy2X7FvigbRWvBsRQCbJK2ZRqpoTF4zSFF1o3hl9m2REUiy+/nPuWgm1RWBGHD7fhfv1KS6kHh+yeBnvsVqCSU1FYaNiKPBTZZAOnEtmaXUB2ohfseJyzAFAlEha2W5hAJdp/SPRRDNtQIY3aCsLjlGU0txWxaaHmtgO1tKuFeXxQUPPZHLTAveZPtIAhzH2Xr0sQqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hekEKQ4NZeDKFiJPn6n8nIPg+qIT/Q1P3FSxoR6zdxc=;
 b=qynEPmR4FNFRz+wnQEW4iXX3yZjalxgfn4Rux/r7pNhf7cbfGdKiOdSs1GDrKIgwsvyU7SP5FRuAozzmB3M2DagYMUoBwaxnOCh9NhwxI+83Ff4i8XNyKtUaZUo1+eUSsSa2L50/X1WT5QAWN5IoKZs3MTI/xeynMSWMvs/DLIE=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6920.namprd04.prod.outlook.com (2603:10b6:610:91::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Wed, 13 Jan
 2021 07:12:21 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%8]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 07:12:21 +0000
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
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>
Subject: Re: [PATCH] bio: limit bio max size.
Thread-Topic: [PATCH] bio: limit bio max size.
Thread-Index: AQHW6Xtv9VT/M8bs90CRZ+HpKiPiIA==
Date:   Wed, 13 Jan 2021 07:12:21 +0000
Message-ID: <CH2PR04MB6522842D40DBAA0B5D855ED4E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <CH2PR04MB6522091DE371F5EB7EE98200E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <CGME20210113065444epcas1p4b8ee3edb314a06b1a9f92fd0e38ca856@epcas1p4.samsung.com>
 <20210113063936.4189-1-nanich.lee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:e53d:bea0:4863:19b6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a534edfa-8858-4c3b-7765-08d8b7929223
x-ms-traffictypediagnostic: CH2PR04MB6920:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB69203EE39865723932099418E7A90@CH2PR04MB6920.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dZ3p92Sm4Jy2+iFJ0VX/9fyVuTYRe5O1Y9T8DbnZtev734S/F80N95trh8UXNBueNBbqnzED8ZDfBhpSjQnoR8mZXfwdYgdc+IzmHq22/xgC4bpnwAI9Qxl5g+hD1M4JNIQ4SyG6tKH54sCYI2FOuHgxqMMay/eL9dSOSdyIos5kpLwuUo2xXwHeJFYHDL20Cwb/ij9mT+C+AQjHdNcv144sRWKfKzItnazc8fblnzMMnJa50sWTNPfXDiVzD41D+p8V5cKY2hiqOu8502AkOWzDouvCag97a5OC+WYHtq25solFKw/jq0PKKkzaKe1N6tjushwS1wP6QO5e+gbWZ1axFuYAGNZ1XrYGecAJmCaj3mu+RshOpGMZUDC5WCE0sSXq8WnJLuppBushpYtWIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(66446008)(54906003)(91956017)(76116006)(7416002)(71200400001)(52536014)(66556008)(83380400001)(316002)(4326008)(64756008)(7696005)(5660300002)(2906002)(33656002)(478600001)(53546011)(8936002)(66946007)(86362001)(8676002)(66476007)(186003)(55016002)(6506007)(9686003)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jLutmIzrFtH5yaZgKsfZuYyOmeA41h3+SsbFkCw6vdn5WwyIqlmdyO3d8M2v?=
 =?us-ascii?Q?PYZzabaaDOM731E/7e96OuazFk/1Uc8ZzM9KdTUHus+IzkmAisf0IMKXILeN?=
 =?us-ascii?Q?p4ZDLf8pz72+gEOkqgKMVR7JfTWbl7OeP4mDYYzeqMiMDE42N5AbO+SPEV/R?=
 =?us-ascii?Q?vRTKPy1fRarnyE+XYgal9SZJRBO8R72XFjdX60eKosI6kO3YdvXrvcCnqYOd?=
 =?us-ascii?Q?MPW06b9GUXpQ+4Phr9gYmmeQX1UZtQJlEInpi8qEjLDcMaKhefe4KWtP03Ss?=
 =?us-ascii?Q?Vo0yl6gMqx8S8o5LsdsW+/x1lp4lc1Mnw4GSzPrVHJMdVc423BlNuHhtVfVY?=
 =?us-ascii?Q?NJ36woPpN9pKVjzedRDzlshO4bUUVafiG1wGWg19D0xBJQDXXRqDzSQ72khF?=
 =?us-ascii?Q?rHePp3U6gt056wzik9b97fQdS9e6jBuDpzQdXyOTS25T77PBZtaoCmdoUWPe?=
 =?us-ascii?Q?vFKsPBpbK9CxLVtUhnyIVMFKfh6XSEy3Vw+ssfS9KeaW1gdD3To7XI03Y7/n?=
 =?us-ascii?Q?s5GhFixVmFSmOzHJI8i3fWw1o+iQluRoh+fa+PgiLl3D0VggaCca3iMQrrqi?=
 =?us-ascii?Q?r7FxxOYyHVpaYjWSWib+muwrncadzmz221rP64ZI7XI2UC+N0OjeCCsN0b/1?=
 =?us-ascii?Q?nZf2Mc1APS4zDXPz2Arb0aPSat5s6EJ6aBd42JAuMLM5YxXfGhiU9OWj3Xdi?=
 =?us-ascii?Q?uB/PAt4h0Sv8qfLLyJw4Kt7CVI9UvfUQcba04BcJg8Di7sw2/CqN+C9CV3iM?=
 =?us-ascii?Q?EYYPQqLAP8dHsnlDbC85/jVLWtLtWPtZuTgEL+jBXdzHPRz0tZ60sN+jp7/U?=
 =?us-ascii?Q?AnAbVaj6gNNMA47dktMB/3oRT2MRWqr4hX882L7f9/Xlc2MNF/9/vaEd1hmc?=
 =?us-ascii?Q?pWeBYjJjozeCELSsuSJwArfTrALRddg/b2jF6bPdmDSX+KpYRfFMYgoVD3C8?=
 =?us-ascii?Q?bpl3MGML0T2i8XK8+u56mNVhozM+QJlpPbyjLLw01rwOGmxMTFXVzO02Fw4C?=
 =?us-ascii?Q?fe/tbzRwFOwVVJQ9OnQE6iOXpVtu68QiistTuIcQumgaiNz7SYkGtXJrsqIS?=
 =?us-ascii?Q?n50tX/vB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a534edfa-8858-4c3b-7765-08d8b7929223
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 07:12:21.6467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRe/xhQXx979rt3RAQE8p7SJv82PfVdIEggSh7Zq/P4S7BDnHKc/shxpjtu2oiS1Evl/DPv07mOgpBnWSvSi/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6920
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/13 15:54, Changheun Lee wrote:=0A=
>> On 2021/01/13 13:01, Changheun Lee wrote:=0A=
>>>> On 2021/01/12 21:14, Changheun Lee wrote:=0A=
>>>>>> On 2021/01/12 17:52, Changheun Lee wrote:=0A=
>>>>>>> From: "Changheun Lee" <nanich.lee@samsung.com>=0A=
>>>>>>>=0A=
>>>>>>> bio size can grow up to 4GB when muli-page bvec is enabled.=0A=
>>>>>>> but sometimes it would lead to inefficient behaviors.=0A=
>>>>>>> in case of large chunk direct I/O, - 64MB chunk read in user space =
-=0A=
>>>>>>> all pages for 64MB would be merged to a bio structure if memory add=
ress is=0A=
>>>>>>> continued phsycally. it makes some delay to submit until merge comp=
lete.=0A=
>>>>>>> bio max size should be limited as a proper size.=0A=
>>>>>>=0A=
>>>>>> But merging physically contiguous pages into the same bvec + later a=
utomatic bio=0A=
>>>>>> split on submit should give you better throughput for large IOs comp=
ared to=0A=
>>>>>> having to issue a bio chain of smaller BIOs that are arbitrarily siz=
ed and will=0A=
>>>>>> likely need splitting anyway (because of DMA boundaries etc).=0A=
>>>>>>=0A=
>>>>>> Do you have a specific case where you see higher performance with th=
is patch=0A=
>>>>>> applied ? On Intel, BIO_MAX_SIZE would be 1MB... That is arbitrary a=
nd too small=0A=
>>>>>> considering that many hardware can execute larger IOs than that.=0A=
>>>>>>=0A=
>>>>>=0A=
>>>>> When I tested 32MB chunk read with O_DIRECT in android, all pages of =
32MB=0A=
>>>>> is merged into a bio structure.=0A=
>>>>> And elapsed time to merge complete was about 2ms.=0A=
>>>>> It means first bio-submit is after 2ms.=0A=
>>>>> If bio size is limited with 1MB with this patch, first bio-submit is =
about=0A=
>>>>> 100us by bio_full operation.=0A=
>>>>=0A=
>>>> bio_submit() will split the large BIO case into multiple requests whil=
e the=0A=
>>>> small BIO case will likely result one or two requests only. That likel=
y explain=0A=
>>>> the time difference here. However, for the large case, the 2ms will is=
sue ALL=0A=
>>>> requests needed for processing the entire 32MB user IO while the 1MB b=
io case=0A=
>>>> will need 32 different bio_submit() calls. So what is the actual total=
 latency=0A=
>>>> difference for the entire 32MB user IO ? That is I think what needs to=
 be=0A=
>>>> compared here.=0A=
>>>>=0A=
>>>> Also, what is your device max_sectors_kb and max queue depth ?=0A=
>>>>=0A=
>>>=0A=
>>> 32MB total latency is about 19ms including merge time without this patc=
h.=0A=
>>> But with this patch, total latency is about 17ms including merge time t=
oo.=0A=
>>> Actually 32MB read time from device is same - about 16.7ms - in driver =
layer.=0A=
>>> No need to hold more I/O than max_sectors_kb during bio merge.=0A=
>>> My device is UFS. and max_sectors_kb is 1MB, queue depth is 32.=0A=
>>=0A=
>> This may be due to the CPU being slow: it takes time to build the 32MB B=
IO,=0A=
>> during which the device is idling. With the 1MB BIO limit, the first BIO=
 hits=0A=
>> the drive much more quickly, reducing idle time of the device and leadin=
g to=0A=
>> higher throughput. But there are 31 more BIOs to build and issue after t=
he first=0A=
>> one... That does create a pipeline of requests keeping the device busy, =
but that=0A=
>> also likely keeps your CPU a lot more busy building these additional BIO=
s.=0A=
>> Overall, do you see a difference in CPU load for the 32MB BIO case vs th=
e 1MB=0A=
>> max BIO case ? Any increase in CPU load with the lower BIO size limit ?=
=0A=
>>=0A=
> =0A=
> CPU load is more than 32MB bio size. Because bio_sumbit progress is doing=
 in parallel.=0A=
> But I tested it same CPU operation frequency, So there are no difference =
of CPU speed.=0A=
> Logically, bio max size is 4GB now. it's not realistic I know, but 4GB me=
rge to a bio=0A=
> will takes much time even if CPU works fast.=0A=
> This is why I think bio max size should be limited.=0A=
=0A=
I do not think that the page merging code is the real root cause here. That=
 is=0A=
fast and does not depend on the current size of the BIO. This is essentiall=
y an=0A=
O(1) operation. The root cause of your performance drop is most likely the =
fact=0A=
that your device is kept idle while the large BIO is being built, adding th=
e=0A=
8192 pages of the large 32MB user IO. Building that large BIO is a lot more=
=0A=
efficient, CPU wise, than building and issuing a lot of small BIOs. That gi=
ves a=0A=
lot of benefits on high-end desktops and servers with fast CPUs, but is cou=
nter=0A=
productive in your case with a slower CPU.=0A=
=0A=
I wonder: what is the user IO size when you start seeing a performance drop=
=0A=
without the patch ? It is clear that limiting the BIO size does imporve thi=
ngs=0A=
for the 32MB IO size you tested, but what about more realistic workloads wi=
th=0A=
128K or so IO sizes (typical IO size for an FS using the page cache) ?=0A=
=0A=
> =0A=
>>>=0A=
>>>>> It's not large delay and can't be observed with low speed device.=0A=
>>>>> But it's needed to reduce merge delay for high speed device.=0A=
>>>>> I improved 512MB sequential read performance from 1900MB/s to 2000MB/=
s=0A=
>>>>> with this patch on android platform.=0A=
>>>>> As you said, 1MB might be small for some device.=0A=
>>>>> But method is needed to re-size, or select the bio max size.=0A=
>>>>=0A=
>>>> At the very least, I think that such limit should not be arbitrary as =
your patch=0A=
>>>> proposes but rely on the device characteristics (e.g.=0A=
>>>> max_hw_sectors_kb/max_sectors_kb and queue depth).=0A=
>>>>=0A=
>>>=0A=
>>> I agree with your opinion, I thought same as your idea. For that, deep =
research=0A=
>>> is needed, proper timing to set and bio structure modification, etc ...=
=0A=
>>=0A=
>> Why would you need any BIO structure modifications ? Your patch is on th=
e right=0A=
>> track if limiting the BIO size is the right solution (I am not still com=
pletely=0A=
>> convinced). E.g., the code:=0A=
>>=0A=
>> if (page_is_mergeable(bv, page, len, off, same_page)) {=0A=
>> if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len) {=0A=
>> *same_page =3D false;=0A=
>> return false;=0A=
>> }=0A=
>>=0A=
>> could just become:=0A=
>>=0A=
>> if (page_is_mergeable(bv, page, len, off, same_page)) {=0A=
>> if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {=0A=
>> *same_page =3D false;=0A=
>> return false;=0A=
>> }=0A=
>>=0A=
>> With bio_max_size() being something like:=0A=
>>=0A=
>> static inline size_t bio_max_size(struct bio *bio)=0A=
>> {=0A=
>> sector_t max_sectors =3D blk_queue_get_max_sectors(bio->bi_disk->queue,=
=0A=
>> bio_op(bio));=0A=
>>=0A=
>> return max_sectors << SECTOR_SHIFT;=0A=
>> }=0A=
>>=0A=
>> Note that this is not super efficient as a BIO maximum size depends on t=
he BIO=0A=
>> offset too (its start sector). So writing something similar to=0A=
>> blk_rq_get_max_sectors() would probably be better.=0A=
> =0A=
> Good suggestion. :)=0A=
> =0A=
>>=0A=
>>> Current is simple patch for default bio max size.=0A=
>>> Before applying of multipage bvec, bio max size was 1MB in kernel 4.x b=
y BIO_MAX_PAGES.=0A=
>>> So I think 1MB bio max size is reasonable as a default.=0A=
>>=0A=
>> max_sectors_kb is always defined for any block device so I do not think =
there is=0A=
>> a need for any arbitrary default value.=0A=
>>=0A=
>> Since such optimization likely very much depend on the speed of the syst=
em CPU=0A=
>> and of the storage device used, it may be a good idea to have this confi=
gurable=0A=
>> through sysfs. That is, bio_max_size() simply returns UINT_MAX leading t=
o no=0A=
>> change from the current behavior if the optimization is disabled (defaul=
t) and=0A=
>> max_sectors_kb if it is enabled.=0A=
>>=0A=
> =0A=
> OK, I agree with you. It will be best for all now.=0A=
> I'll try to make this.=0A=
> =0A=
>>>=0A=
>>>>>=0A=
>>>>>>=0A=
>>>>>>>=0A=
>>>>>>> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>=0A=
>>>>>>> ---=0A=
>>>>>>>  block/bio.c         | 2 +-=0A=
>>>>>>>  include/linux/bio.h | 3 ++-=0A=
>>>>>>>  2 files changed, 3 insertions(+), 2 deletions(-)=0A=
>>>>>>>=0A=
>>>>>>> diff --git a/block/bio.c b/block/bio.c=0A=
>>>>>>> index 1f2cc1fbe283..dbe14d675f28 100644=0A=
>>>>>>> --- a/block/bio.c=0A=
>>>>>>> +++ b/block/bio.c=0A=
>>>>>>> @@ -877,7 +877,7 @@ bool __bio_try_merge_page(struct bio *bio, stru=
ct page *page,=0A=
>>>>>>>  		struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];=0A=
>>>>>>>  =0A=
>>>>>>>  		if (page_is_mergeable(bv, page, len, off, same_page)) {=0A=
>>>>>>> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {=0A=
>>>>>>> +			if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len) {=0A=
>>>>>>>  				*same_page =3D false;=0A=
>>>>>>>  				return false;=0A=
>>>>>>>  			}=0A=
>>>>>>> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
>>>>>>> index 1edda614f7ce..0f49b354b1f6 100644=0A=
>>>>>>> --- a/include/linux/bio.h=0A=
>>>>>>> +++ b/include/linux/bio.h=0A=
>>>>>>> @@ -20,6 +20,7 @@=0A=
>>>>>>>  #endif=0A=
>>>>>>>  =0A=
>>>>>>>  #define BIO_MAX_PAGES		256=0A=
>>>>>>> +#define BIO_MAX_SIZE		(BIO_MAX_PAGES * PAGE_SIZE)=0A=
>>>>>>>  =0A=
>>>>>>>  #define bio_prio(bio)			(bio)->bi_ioprio=0A=
>>>>>>>  #define bio_set_prio(bio, prio)		((bio)->bi_ioprio =3D prio)=0A=
>>>>>>> @@ -113,7 +114,7 @@ static inline bool bio_full(struct bio *bio, un=
signed len)=0A=
>>>>>>>  	if (bio->bi_vcnt >=3D bio->bi_max_vecs)=0A=
>>>>>>>  		return true;=0A=
>>>>>>>  =0A=
>>>>>>> -	if (bio->bi_iter.bi_size > UINT_MAX - len)=0A=
>>>>>>> +	if (bio->bi_iter.bi_size > BIO_MAX_SIZE - len)=0A=
>>>>>>>  		return true;=0A=
>>>>>>>  =0A=
>>>>>>>  	return false;=0A=
>>>>>>>=0A=
>>>>>>=0A=
>>>>>>=0A=
>>>>>> -- =0A=
>>>>>> Damien Le Moal=0A=
>>>>>> Western Digital Research=0A=
>>>>>=0A=
>>>>=0A=
>>>>=0A=
>>>> -- =0A=
>>>> Damien Le Moal=0A=
>>>> Western Digital Research=0A=
>>>>=0A=
>>>=0A=
>>> ---=0A=
>>> Changheun Lee=0A=
>>> Samsung Electronics=0A=
>>>=0A=
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
