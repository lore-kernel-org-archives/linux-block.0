Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6601EC433DB
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 11:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F16BA23359
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 11:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbhAMLRV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:17:21 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52921 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbhAMLRV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 06:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610536639; x=1642072639;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ehfS5SIobKsbkG2me4hz341VVf7ihgln6iZhP/s+mCY=;
  b=I20VCp+0WLUQBwPrn6rBopGiJ5kijU6GPX1IUYYK8ifUXP+yV0Nbiu7t
   HN1qwVLPLzRt5uQBA5L+FeayE6lnc7U3rc0ROXDS8oTbaY+ygT49RwmNN
   XeCx8PvMEH4FYkNmY+lSHiLwl+LutCLg32fPBtu3jHYwvHP3fBQoYj+CQ
   lp/VcdU16C711y73LOE+Ua5gbvHFhYOhWB/VW/LcBKjOYmRiB7BSTJRQq
   moWhbY9eameiQZ1O8HTdaJO7rnmPV8SIbec95tlCycPVDbKegI56sEt9o
   y1e4YvqySgaDtgQocK9S1mQUOdhNrEo5EgdhjbOrqGjL1GJz+e1IWSPdJ
   Q==;
IronPort-SDR: X0uZqL5e+4LoeGEuIKytzqoeATAHC2KGX8wsLownpNmmJ5m/TcZ3zNmdLW5/16crQExRiRWk1u
 AmSIakvZM9RTpoPfqZqIoGx+2U/uTjNHslRBL6nCWB1K+q2wKTM++aocxAdT0oSALmkwFGDZ92
 8glZLTcBl1BsByf4tUi/RLTLlhczONGSgYo+0vtR2VCHJNIf6aIfcctLEtvQaFi/3uuuc69v9N
 bGy+YTbfwrvA4dDa2P8B5EO78LoYwgmSRddq2w9/tTTQ2F5miQ/MoD5yRmGVvuMpIU5lkyini5
 hNc=
X-IronPort-AV: E=Sophos;i="5.79,344,1602518400"; 
   d="scan'208";a="157328421"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 19:16:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcW2225PjCNStiWkn40inoLlRLaKMY3Tt6mfT3D25VF37ZniivwG0e/zHmOK6bGRumpR453bT/FF4o/a+UQ2CSdITz2l60BpT4nCxH0gu7ubdig99+cGd/PAIto+ww0IFuThufjrSR2236+hhFFV5/NzkaLY06dTcwdOqbbGTU+AVeCc7CGwp31f4xXTqpIf/6AxrUg1unIfJxwfKwd4j6IV7rF17dUW+vhfwOpoHOiVnFYXsa8mEMi1mSyi9YyUMJQm5gXxpHB8Iw0pdwz8vGusu0ei2eilpHr1/t6ghirKo/qa6UHB9c0o+V7GQAyzPFWH9YD8iqg0nVGsMDq9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0m5W0JcBhgdeb5cueqgWspTPB2aJeTcrWYBz9N0Oqw=;
 b=fxNuJkpDPRgYueIpa+Ryu4n7dCl6qXfPQ674HhQ4pTB+YOfRRjlc+jYznPHMWi3yVCvWXPokWjSJ0kRg91shPfblF6S1G9f3k+3zkTavc1NBF8vA2mmZuajwAwNjn4aD8lJOq+PMCEU/dVj2I9QlPUmSDnlH3DRg273v5h8ltfGBqgmEdu5SsfrHkAg4aVQx3Tojia3egzCUjQjy4uh1Hyz4T9NzrrZCGSh9IYH9c65KO11wLBtAg/W1OhcUHwsBiDJ6957hCNRmE0GwROut3b7qSlLXpkttw9kYoQ4exAPSpL/oyqYX6pPa5fNFMH6FGPGoAWC5rV5M2XpjnlzwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0m5W0JcBhgdeb5cueqgWspTPB2aJeTcrWYBz9N0Oqw=;
 b=xjY8GlRofKcaziYO+6nLPIUJ29Hglw+FUslc32kflTcsrucOFYB8R5Ph7PhjX69T7d/u0vPd09r/gv4CXkz+FS8NeXu5XgHaBn2VTS5YivWNLp09+FK5knFsnxqPHH8UkA6Ke/VItsTwQgtuaWbGHck2vbE/LfHONiBtSKnxJ5A=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6727.namprd04.prod.outlook.com (2603:10b6:610:a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.12; Wed, 13 Jan
 2021 11:16:12 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%8]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 11:16:11 +0000
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
Date:   Wed, 13 Jan 2021 11:16:11 +0000
Message-ID: <CH2PR04MB6522CF231DAA4615DABA8457E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <CGME20210113040146epcas1p230596c7c3760471dca442d1f7ce4dc55@epcas1p2.samsung.com>
 <CH2PR04MB65225EDDA7069CCD47A459A5E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20210113034637.1382-1-nanich.lee@samsung.com>
 <CACVXFVMb0eE5-yo2k3KvnJjKN+aDLzOuT9rKQ7LY5-4WTgM3jw@mail.gmail.com>
 <CH2PR04MB65228D54F66068DA125CCE47E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20210113102450.GA220440@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:e53d:bea0:4863:19b6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7870d59-b9c2-46e5-3aa0-08d8b7b4a263
x-ms-traffictypediagnostic: CH2PR04MB6727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB67278FEC2FBE092186599D2EE7A90@CH2PR04MB6727.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K08o6b83jBc92xojDfEF1MBnU9kfy0HHBwf3cY52mEJq9MyjUUhAFj6uChQvriPDyYk9RUk9poObpbqT10UimhcWH52JpX3OLxIJfvQUoA1NaFXEBACqM3+6X6WbSjZ3NTvtZY0VlBq8a7tCpBXXMjFimSa6M8huOQu5UM1B4aLmtgQJ07UknGlY4QLnWkdiSjXPZp7zpm217udJrtPqREmuIUFwGhbFWTl5mlglw/AZjoOk+SHJB1xl4YHeQuH8B4yqWkzy4kxP/7MW77hxjJQD4kVLEaCo6K1DvuykFs67iUXTz174OTVPPvjKwexvAXfSxVEWxfk/xabgvCPIyEOklDXoj3SMkJdIqOF9twNjDSVxPAuf2CqM+scrZKJQvwOoq+XPKWHj09uLL9wRSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(54906003)(83380400001)(55016002)(52536014)(7416002)(186003)(66946007)(6506007)(91956017)(71200400001)(478600001)(7696005)(66476007)(66556008)(2906002)(4326008)(66446008)(316002)(64756008)(5660300002)(8676002)(8936002)(33656002)(76116006)(53546011)(9686003)(6916009)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3ib1qZ0A9FOX1awqg90+ONspZ3P6zqCBAmqkhLnzZvbPyccxQKFGkJqSqQ6n?=
 =?us-ascii?Q?aNtTBM7ZJGFEAMoIFIZVuhaUzCCyPKL1Rr8ajcxPzRO7sQ+S6jc+vKFZnaEM?=
 =?us-ascii?Q?cUWGDellmXFi2N8I+39D3vIkeDlRDsqRgL+U1ekjTD2Mql8SV930/B4MSWw+?=
 =?us-ascii?Q?Zq6zbkOyKfZiM3lHfQY7eSiUUzFWf5UafOBn/0WC2EQ4c/cc0EiLstJBGjpl?=
 =?us-ascii?Q?Ig9UW6u20bW2NzHyA3X7kWaNvTsz4sriDg+ZrsYhdsVnvkr6nF+rvy/H5/9u?=
 =?us-ascii?Q?2nFjdQ8zMrTGDirFTxB3ut3oPwS/h3CrKBScaLdvljVtaCFIOYVs+ZN5vWUd?=
 =?us-ascii?Q?VjILfIOsUHEOhgKppDF43b1SFhBCY8V45CEuAQgKH6cBwPJkER0fvJTN7MZg?=
 =?us-ascii?Q?EPTI+juq0HZDW+bAs2NiJpvl9RFRmtz7eMGvfMB/AAADflIei8nIHv6FVAE6?=
 =?us-ascii?Q?I4dqimofNXo+D7jmZiP6rOSxLihbVVdb76sl64W04xBetg7AO+jC6SaSUZ+t?=
 =?us-ascii?Q?mS1fPph1PABVLQmXfmYUbq4EiJQBzO9dfLQRagxfbL90DzwhkaZoHTx3JbKw?=
 =?us-ascii?Q?qTlqCXH/zsbm+61bE6O+SivGCi8CJNwodLMBBQ4I1pdv+U20w57HrlBrEJz4?=
 =?us-ascii?Q?K0TPydbVVLrXCCr6jYOODs+q95nKnWeD2ROZoGlnmFpC8qkjubwjRoEIOKS9?=
 =?us-ascii?Q?HHBvWg+9ccCh931BfrHdAEmQG/Bq1rwtTyR1G5AquwWygrK3WyXW6ilw5o+b?=
 =?us-ascii?Q?6OJgnRRsl4Jxkl6DBkYrTmHe76PuVHv7gbjQ+NAaPaBOpq7OGK/NktFJFgm9?=
 =?us-ascii?Q?LdiFgpWWlQtmxTq5RdxoJ909JiXnf53nlt4EDR3fE1k87vCUlCzrjcnlom6K?=
 =?us-ascii?Q?GthqHD/+9X8kOHeDTWKFad4Zmz14eBqkmfSwTgiMgNI9peC1wwb+7nUIurmq?=
 =?us-ascii?Q?H7nNh8XQu0L71I2XtCCNpT/2tir7RK4csMLsxiQl0z6f+j0MShUsQl7+R/A7?=
 =?us-ascii?Q?2N7rcLpD+qJAq88AGYa7YuTn3tdkKns7R/L5m9tfkbQgkTHsGBGnR/BoukYs?=
 =?us-ascii?Q?V/NWCO6O?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7870d59-b9c2-46e5-3aa0-08d8b7b4a263
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 11:16:11.8288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D31Pzi5ys8mLIF4wUuMs6FITFPmkAlcHllOm0xhYTEcdIbE0yW+Y35qmmrD3F4auHpbrY9jYbOVUrk5XpNEUTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6727
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/13 19:25, Ming Lei wrote:=0A=
> On Wed, Jan 13, 2021 at 09:28:02AM +0000, Damien Le Moal wrote:=0A=
>> On 2021/01/13 18:19, Ming Lei wrote:=0A=
>>> On Wed, Jan 13, 2021 at 12:09 PM Changheun Lee <nanich.lee@samsung.com>=
 wrote:=0A=
>>>>=0A=
>>>>> On 2021/01/12 21:14, Changheun Lee wrote:=0A=
>>>>>>> On 2021/01/12 17:52, Changheun Lee wrote:=0A=
>>>>>>>> From: "Changheun Lee" <nanich.lee@samsung.com>=0A=
>>>>>>>>=0A=
>>>>>>>> bio size can grow up to 4GB when muli-page bvec is enabled.=0A=
>>>>>>>> but sometimes it would lead to inefficient behaviors.=0A=
>>>>>>>> in case of large chunk direct I/O, - 64MB chunk read in user space=
 -=0A=
>>>>>>>> all pages for 64MB would be merged to a bio structure if memory ad=
dress is=0A=
>>>>>>>> continued phsycally. it makes some delay to submit until merge com=
plete.=0A=
>>>>>>>> bio max size should be limited as a proper size.=0A=
>>>>>>>=0A=
>>>>>>> But merging physically contiguous pages into the same bvec + later =
automatic bio=0A=
>>>>>>> split on submit should give you better throughput for large IOs com=
pared to=0A=
>>>>>>> having to issue a bio chain of smaller BIOs that are arbitrarily si=
zed and will=0A=
>>>>>>> likely need splitting anyway (because of DMA boundaries etc).=0A=
>>>>>>>=0A=
>>>>>>> Do you have a specific case where you see higher performance with t=
his patch=0A=
>>>>>>> applied ? On Intel, BIO_MAX_SIZE would be 1MB... That is arbitrary =
and too small=0A=
>>>>>>> considering that many hardware can execute larger IOs than that.=0A=
>>>>>>>=0A=
>>>>>>=0A=
>>>>>> When I tested 32MB chunk read with O_DIRECT in android, all pages of=
 32MB=0A=
>>>>>> is merged into a bio structure.=0A=
>>>>>> And elapsed time to merge complete was about 2ms.=0A=
>>>>>> It means first bio-submit is after 2ms.=0A=
>>>>>> If bio size is limited with 1MB with this patch, first bio-submit is=
 about=0A=
>>>>>> 100us by bio_full operation.=0A=
>>>>>=0A=
>>>>> bio_submit() will split the large BIO case into multiple requests whi=
le the=0A=
>>>>> small BIO case will likely result one or two requests only. That like=
ly explain=0A=
>>>>> the time difference here. However, for the large case, the 2ms will i=
ssue ALL=0A=
>>>>> requests needed for processing the entire 32MB user IO while the 1MB =
bio case=0A=
>>>>> will need 32 different bio_submit() calls. So what is the actual tota=
l latency=0A=
>>>>> difference for the entire 32MB user IO ? That is I think what needs t=
o be=0A=
>>>>> compared here.=0A=
>>>>>=0A=
>>>>> Also, what is your device max_sectors_kb and max queue depth ?=0A=
>>>>>=0A=
>>>>=0A=
>>>> 32MB total latency is about 19ms including merge time without this pat=
ch.=0A=
>>>> But with this patch, total latency is about 17ms including merge time =
too.=0A=
>>>=0A=
>>> 19ms looks too big just for preparing one 32MB sized bio, which isn't=
=0A=
>>> supposed to=0A=
>>> take so long.  Can you investigate where the 19ms is taken just for=0A=
>>> preparing one=0A=
>>> 32MB sized bio?=0A=
>>=0A=
>> Changheun mentioned that the device side IO latency is 16.7ms out of the=
 19ms=0A=
>> total. So the BIO handling, submission+completion takes about 2.3ms, and=
=0A=
>> Changheun points above to 2ms for the submission part.=0A=
> =0A=
> OK, looks I misunderstood the data.=0A=
> =0A=
>>=0A=
>>>=0A=
>>> It might be iov_iter_get_pages() for handling page fault. If yes, one s=
uggestion=0A=
>>> is to enable THP(Transparent HugePage Support) in your application.=0A=
>>=0A=
>> But if that was due to page faults, the same large-ish time would be tak=
en for=0A=
>> the preparing the size-limited BIOs too, no ? No matter how the BIOs are=
 diced,=0A=
>> all 32MB of pages of the user IO are referenced...=0A=
> =0A=
> If bio size is reduced to 1MB, just 256 pages need to be faulted before s=
ubmitting this=0A=
> bio, instead of 256*32 pages, that is why the following words are mention=
ed:=0A=
> =0A=
> 	It means first bio-submit is after 2ms.=0A=
> 	If bio size is limited with 1MB with this patch, first bio-submit is abo=
ut=0A=
> 	100us by bio_full operation.=0A=
=0A=
Yes, but eventually, all pages for the 32MB IO will be faulted in, just not=
 in=0A=
one go. Overall number of page faults is likely the same as with the large =
BIO=0A=
preparation. So I think we are back to my previous point, that is, reducing=
 the=0A=
device idle time by starting a BIO more quickly, even a small one, leads to=
=0A=
overlap between CPU time needed for the next BIO preparation and previous B=
IO=0A=
execution, reducing overall the latency for the entire 32MB user IO. I don'=
t=0A=
think that the reason is page faulting in itself.=0A=
=0A=
> =0A=
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
