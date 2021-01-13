Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0519C433DB
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 12:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E01233FA
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 12:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbhAMMDz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 07:03:55 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60049 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbhAMMDy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 07:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610539433; x=1642075433;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PAd21m1wulsNxhteK3zNEBZn9zOcsTiL4AwQw4D8Pjc=;
  b=oapVICE3LHYOfcwtZGXLiyz67Ad1ZrYFtg1sjGrcV12YaADhAFmkNY26
   sK37iXDdzbJS0ntH4n+PDmjQQ3MLDL3HxIv5mGZW5CZzIFrtQb5SarvpK
   apjkaGR0B1zvcfqDBPGQNE+yYNO5cv15Pupr2hOIgjZdxZDvw37ACHJ76
   kNP1W/0aO+ZDs1697ntDxliAiK/LzaCZkRyc5/oKAbBkrdTKjvXkZllch
   bQ2cGV1ZARKDf8OpWFnObsuheHCuXlj88cCxTw5eB1xmcR0Q+05+YnmYu
   tYgVleOJ6dkEAFkSMedtwBk33e6X0kCcg3++o3jIdjAU0P586E5jmUkKX
   Q==;
IronPort-SDR: YyfWsUjYIiwzpf5whQBr8fsBnbYjotnSZmBzK9zpbOqCQkSMuNFdoqGYGD1/d90vMC/F4CUgG4
 joW6U0kWry+JvJYjeTcIvMFOZS98LWOaRsEcS/JoJ6E0kRll61ifxrYK1IwnyAvWT1nlkkk1aE
 A2+J9tRjSDp1c5rE99EOpV6N4ar8k4oPHRThBRMywHMwFGZAgGOlxQOka/emtOWxj5FkYqv7RW
 ZmniidgdJjphR/Dqls4S5TtCY5Rh01R15CUao266TS1DRX87lUzx2u7RYms2qC05BLRJiktJbJ
 nTc=
X-IronPort-AV: E=Sophos;i="5.79,344,1602518400"; 
   d="scan'208";a="157325652"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 20:02:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W87AIQmUU8qGpyZ//h/ER+iB0gLzymf1CkXHQu9Ahjygs60taq0FlRSMsLDsdlw7qNBuwxcC28lurcoF8EwUZfXXeVpACFm+EXPr3JscD65HmlLnUuh4d+YUSmWlHTV92qfcbiTZuOdY6MIOhH1GDDJtKKxV6eIjv69hAoow0HPTgN6OpMZ2+emzqGAmel/OJB5p1EBSm/2eeS6XXWl/NzKCxjJLZkW3vToj73n1B69J0wjCb+EaA7/10Em4jU1GleyFEqBcRYh3OInmTZxgV05VjCby7/b2BMFHa9llgHIM2ga8QdrdMRIBVtZGV69UGALLHzUN5XLb6icxdnoZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjSRjzvNTOoHMUxfkdRLJM5tqWaZqEOzAAQql31D0fo=;
 b=NSnpRYdAHjsVVh3awr4HUiw7NRIynSp3c+9QVEF23C8fjRoVGF9K6od4jkUZFUsn1Ao7FyqlQ8AnQgGiButwiD4jc5PZtrJL3kHbMorz5AbHfDddozEKa0FzYyLQXhRR58/B7T6S+PYmFq+pk5p39g645Qu7+K4D918TFKnJsmu5mrOcwOZyG8syUW3+Vc+p0jppq8dtZHwwknBTsDylOboOZEAJ7Tg3SY/uMWW3uQrE0sHPq7OYaIIbh4BNqsxTHlp58uLgOdSQJBhdGvXD1SxStkSJFtAc1/IGWK2x6j3zL3lmwNmFvPcfd2EJqXXfw7GK1n2uF2vOH1cuggiYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjSRjzvNTOoHMUxfkdRLJM5tqWaZqEOzAAQql31D0fo=;
 b=q7vJvUfGBM4npSSPNvEeWPkpH5/ynHxKDQh5G8UbUpE7hXSanN3uw6r5jdWTYHH9Nw/Tdv4/oi5E+ZEoU7DQDxuI1/rk+SYieFRZJrgGsg80y8b1CdrAd3v1kJtf2oIoy/NtBI/Y48woXHmb9NaRwMKEqFLBLVwmdodUuK8Yv3Q=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6966.namprd04.prod.outlook.com (2603:10b6:610:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Wed, 13 Jan
 2021 12:02:44 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%8]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 12:02:44 +0000
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
Date:   Wed, 13 Jan 2021 12:02:44 +0000
Message-ID: <CH2PR04MB652295091E1D9455D2132BD8E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <CGME20210113040146epcas1p230596c7c3760471dca442d1f7ce4dc55@epcas1p2.samsung.com>
 <CH2PR04MB65225EDDA7069CCD47A459A5E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20210113034637.1382-1-nanich.lee@samsung.com>
 <CACVXFVMb0eE5-yo2k3KvnJjKN+aDLzOuT9rKQ7LY5-4WTgM3jw@mail.gmail.com>
 <CH2PR04MB65228D54F66068DA125CCE47E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20210113102450.GA220440@T590>
 <CH2PR04MB6522CF231DAA4615DABA8457E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20210113114722.GA233746@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:e53d:bea0:4863:19b6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5116423a-3b95-4a65-fb5c-08d8b7bb231f
x-ms-traffictypediagnostic: CH2PR04MB6966:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB6966F67774F401145CA21137E7A90@CH2PR04MB6966.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qNjKz4rIoDQgKJssvgohOWHJTsu3iZZWMTxqw9KCOW2RggaMRHxeZCzRBz5hllUpJ8xAcZtuum6eZnnoU0S7hxeDs/N3CLGCnAf9tetpO4wy5O0c+OGW+7zqYULNSsq1udQG9D+Mkes152KgnXfEOr2QgfjsILxGtOTbguHupRpl6KWP4/xRoUy7gTQLArgXHPTGU5r/OUkpco0GbuY1IQB/ds+rPukq4m+HnOaIVrirVr/aDhO67ZxGpWVHnN5njkkmBtYAjiuVSusZj3Q+X3FZKHhwUtjkYp60lk75MWXibD8Aiz1kgHszfN0xlWO/4hZ8cpskpQQAEK9m22OKSbeaeZkDz30VpaXeDWK3gg0qU4/BQuzu+p4ScQpe2YUne34Ls4kfi4a4H021MUIcXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(396003)(39860400002)(136003)(7416002)(66476007)(66446008)(55016002)(66556008)(7696005)(2906002)(66946007)(91956017)(6916009)(71200400001)(316002)(64756008)(76116006)(52536014)(9686003)(86362001)(5660300002)(186003)(53546011)(8676002)(4326008)(6506007)(478600001)(8936002)(83380400001)(54906003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8inR7GdnsyGZnIXodicoq42ZPdypQ/Gs50znJqWDda5bZu07lH2gNjP+0nAa?=
 =?us-ascii?Q?pjGdD6B+4JsMJ+cG12xf3svZ2gVzqwkEB27lcrX8ckoz3a96i2K80MrUyW6B?=
 =?us-ascii?Q?ivBhBYZLkoVOPQxNMxLZ4ekAltbGMaCow7U4Gofv0phpGy5LEeihLfNY2SWy?=
 =?us-ascii?Q?xBnzgPE7LZvxEUS4uir75k2vQ1zja3vEWaEywXmQ07dnm+H9G3SrXFvk37ET?=
 =?us-ascii?Q?QqRiqn7r5IvBEEhqeoi7WfO54EvJm9BISBXg9ktz7fh/kZ80uudWou9lToXH?=
 =?us-ascii?Q?+IIxB7xMIyAQcwPbxYVlBmzFogcr3gGxN6blIvX5kgSXV47LXyOrSdNpa8tz?=
 =?us-ascii?Q?MykvHAKB11vBdVxMetfuUiXiKQVF4voOIO5ZbXSh2B3Sr1ooCelnt9f3kQvB?=
 =?us-ascii?Q?Aya/5lp5Tc0rdazuDh1HumR09DwB+w/lVszSB14GaExOD49qRKF/UaNeloGZ?=
 =?us-ascii?Q?SdO8+sgpvABOjwYR4O3Ly2KxnPT2LvWAoFpZ/l37LriYHrDPpXMpbAGsCYCy?=
 =?us-ascii?Q?g0IK18euAdJEt4OkQa1uGNKh6mnz6mPOUzfsezeiI3oafbhfa9w9ybqcbdMO?=
 =?us-ascii?Q?Hd0guIbXuG8binx8+v4wCDPRy1c3e208iZBmAyHbsXRMJsmIHdpueW2XQOI6?=
 =?us-ascii?Q?hiVnGeV0upDUoXe8dZcn8XWC5sQcmNRPeXAAQVMoqZ8s0GGKIFB2QBc7dnOC?=
 =?us-ascii?Q?dMGlrXdwjHSc9sFTjxQv/v8+Sy7wQpF3hhm3on8gLsrt8VCqioucaHNr2m70?=
 =?us-ascii?Q?lPubSfxgwLjbTes/aUDcrWy2A2AVG7ukRtAFdExuX1sm28OH9T4Dxv0Sb8CN?=
 =?us-ascii?Q?chAQd7ORJo28bbAOonKTy6vZ1KN1i/gZIW8KevhmRNMHKYoo9csPQazL/VpS?=
 =?us-ascii?Q?G/EHh167ggHe5Fst2RbmIF3Ya0L0H7crrt76bRQzzttMJHTkcPUC/UEiQ+8R?=
 =?us-ascii?Q?WdY0otCJRRSKZbAjTXxFsMiC8/j83xI+t1OYxJO/dlrQyPlaS1tYuegcbda4?=
 =?us-ascii?Q?X8gf2dNuUmEqPe/et23I6KVbRuk0i7J0F+K8wnCo7tWjvEhLZN2NtITD/F3t?=
 =?us-ascii?Q?HpzUymso?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5116423a-3b95-4a65-fb5c-08d8b7bb231f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 12:02:44.7507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5MKNELkA8FTrKwYCM3ml5b6ixaV0cQWAavIHVxFVIjsibCWOKiAKhKkMGL9FC8aBOmoRNaPAFMlK0wcVpuBSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6966
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/13 20:48, Ming Lei wrote:=0A=
> On Wed, Jan 13, 2021 at 11:16:11AM +0000, Damien Le Moal wrote:=0A=
>> On 2021/01/13 19:25, Ming Lei wrote:=0A=
>>> On Wed, Jan 13, 2021 at 09:28:02AM +0000, Damien Le Moal wrote:=0A=
>>>> On 2021/01/13 18:19, Ming Lei wrote:=0A=
>>>>> On Wed, Jan 13, 2021 at 12:09 PM Changheun Lee <nanich.lee@samsung.co=
m> wrote:=0A=
>>>>>>=0A=
>>>>>>> On 2021/01/12 21:14, Changheun Lee wrote:=0A=
>>>>>>>>> On 2021/01/12 17:52, Changheun Lee wrote:=0A=
>>>>>>>>>> From: "Changheun Lee" <nanich.lee@samsung.com>=0A=
>>>>>>>>>>=0A=
>>>>>>>>>> bio size can grow up to 4GB when muli-page bvec is enabled.=0A=
>>>>>>>>>> but sometimes it would lead to inefficient behaviors.=0A=
>>>>>>>>>> in case of large chunk direct I/O, - 64MB chunk read in user spa=
ce -=0A=
>>>>>>>>>> all pages for 64MB would be merged to a bio structure if memory =
address is=0A=
>>>>>>>>>> continued phsycally. it makes some delay to submit until merge c=
omplete.=0A=
>>>>>>>>>> bio max size should be limited as a proper size.=0A=
>>>>>>>>>=0A=
>>>>>>>>> But merging physically contiguous pages into the same bvec + late=
r automatic bio=0A=
>>>>>>>>> split on submit should give you better throughput for large IOs c=
ompared to=0A=
>>>>>>>>> having to issue a bio chain of smaller BIOs that are arbitrarily =
sized and will=0A=
>>>>>>>>> likely need splitting anyway (because of DMA boundaries etc).=0A=
>>>>>>>>>=0A=
>>>>>>>>> Do you have a specific case where you see higher performance with=
 this patch=0A=
>>>>>>>>> applied ? On Intel, BIO_MAX_SIZE would be 1MB... That is arbitrar=
y and too small=0A=
>>>>>>>>> considering that many hardware can execute larger IOs than that.=
=0A=
>>>>>>>>>=0A=
>>>>>>>>=0A=
>>>>>>>> When I tested 32MB chunk read with O_DIRECT in android, all pages =
of 32MB=0A=
>>>>>>>> is merged into a bio structure.=0A=
>>>>>>>> And elapsed time to merge complete was about 2ms.=0A=
>>>>>>>> It means first bio-submit is after 2ms.=0A=
>>>>>>>> If bio size is limited with 1MB with this patch, first bio-submit =
is about=0A=
>>>>>>>> 100us by bio_full operation.=0A=
>>>>>>>=0A=
>>>>>>> bio_submit() will split the large BIO case into multiple requests w=
hile the=0A=
>>>>>>> small BIO case will likely result one or two requests only. That li=
kely explain=0A=
>>>>>>> the time difference here. However, for the large case, the 2ms will=
 issue ALL=0A=
>>>>>>> requests needed for processing the entire 32MB user IO while the 1M=
B bio case=0A=
>>>>>>> will need 32 different bio_submit() calls. So what is the actual to=
tal latency=0A=
>>>>>>> difference for the entire 32MB user IO ? That is I think what needs=
 to be=0A=
>>>>>>> compared here.=0A=
>>>>>>>=0A=
>>>>>>> Also, what is your device max_sectors_kb and max queue depth ?=0A=
>>>>>>>=0A=
>>>>>>=0A=
>>>>>> 32MB total latency is about 19ms including merge time without this p=
atch.=0A=
>>>>>> But with this patch, total latency is about 17ms including merge tim=
e too.=0A=
>>>>>=0A=
>>>>> 19ms looks too big just for preparing one 32MB sized bio, which isn't=
=0A=
>>>>> supposed to=0A=
>>>>> take so long.  Can you investigate where the 19ms is taken just for=
=0A=
>>>>> preparing one=0A=
>>>>> 32MB sized bio?=0A=
>>>>=0A=
>>>> Changheun mentioned that the device side IO latency is 16.7ms out of t=
he 19ms=0A=
>>>> total. So the BIO handling, submission+completion takes about 2.3ms, a=
nd=0A=
>>>> Changheun points above to 2ms for the submission part.=0A=
>>>=0A=
>>> OK, looks I misunderstood the data.=0A=
>>>=0A=
>>>>=0A=
>>>>>=0A=
>>>>> It might be iov_iter_get_pages() for handling page fault. If yes, one=
 suggestion=0A=
>>>>> is to enable THP(Transparent HugePage Support) in your application.=
=0A=
>>>>=0A=
>>>> But if that was due to page faults, the same large-ish time would be t=
aken for=0A=
>>>> the preparing the size-limited BIOs too, no ? No matter how the BIOs a=
re diced,=0A=
>>>> all 32MB of pages of the user IO are referenced...=0A=
>>>=0A=
>>> If bio size is reduced to 1MB, just 256 pages need to be faulted before=
 submitting this=0A=
>>> bio, instead of 256*32 pages, that is why the following words are menti=
oned:=0A=
>>>=0A=
>>> 	It means first bio-submit is after 2ms.=0A=
>>> 	If bio size is limited with 1MB with this patch, first bio-submit is a=
bout=0A=
>>> 	100us by bio_full operation.=0A=
>>=0A=
>> Yes, but eventually, all pages for the 32MB IO will be faulted in, just =
not in=0A=
>> one go. Overall number of page faults is likely the same as with the lar=
ge BIO=0A=
>> preparation. So I think we are back to my previous point, that is, reduc=
ing the=0A=
>> device idle time by starting a BIO more quickly, even a small one, leads=
 to=0A=
>> overlap between CPU time needed for the next BIO preparation and previou=
s BIO=0A=
>> execution, reducing overall the latency for the entire 32MB user IO.=0A=
> =0A=
> When bio size is reduced from 32M to 1M:=0A=
> =0A=
> 1MB/(P(1M) + D(1M)) may become bigger than 32MB/(P(1M) + D(1M)), so=0A=
> throughput is improved.=0A=
=0A=
I think that the reason is that P(1M) < D(1M) and so there is overlap betwe=
en P=0A=
and D: P of the next BIO is done on the CPU while D of the previous BIO is=
=0A=
ongoing on the device, assuming there is no plugging.=0A=
=0A=
Somewhat the same should happen for the 32MB case too since that would stil=
l=0A=
lead to a D(329 generating 32 x P(1). And again assuming that there is no p=
lug,=0A=
the first 1M BIO generated by the BIO split in D(32) should start executing=
=0A=
right away while D(329 split continues on the CPU. I guess the fragments ar=
e not=0A=
issued (a plug or an IO sched holding them ?) so the overall latency become=
s=0A=
D(32) + 32 x P(1). Leading to the 2ms D(32) difference in latency that Chan=
gheun=0A=
observed. A blktrace could confirm that I guess.=0A=
=0A=
> =0A=
> P(x) means time for preparing 'x' sized IO=0A=
> D(x) means time for device to handle 'x' sized IO >=0A=
> I depend on both CPU and the UFS drive.=0A=
> =0A=
>> I don't think that the reason is page faulting in itself.=0A=
> =0A=
> What I meant is that page faulting might contribute most part of the=0A=
> 100us(preparing 1MB data) and 2ms(preparing 32MB data). It can be others,=
=0A=
> but should be easy to figure out.=0A=
=0A=
I may be wrong here (need to check again), but I though the pages were faul=
ted=0A=
in at get_user_pages() time, that is, for the 32MB user buffer, regardless =
of=0A=
the BIO size limit. If that's the case, then page fault should not be a=0A=
significant factor in the latency difference.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
