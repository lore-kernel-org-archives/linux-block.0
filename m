Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A05C433DB
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 09:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626072339D
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 09:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbhAMJ3N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:29:13 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1387 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbhAMJ3N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 04:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610530736; x=1642066736;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=plRe3HGluyjfhB2CZv69+shvoghO0aCdob4NDfz7c5s=;
  b=psICSGDoWe1KUd4x0xU0iwB0ED/1xXTucF1w9DmIrCGvQIjEOPh7JHai
   /3gJczmPGO5wZyO60m6X/2Nt+Zb+pmkGt3bhKQJpAZuEqKhMsSV6ct/I0
   x6mrL4pJ9JPVGYkQnJbQ/5OkCCBVhhySaqsUCoSO9Nd7rYtVslbQnj2o8
   H2TZKVH6hq7SCJ0esiUcYMIIgpxD8yPs9274/CvMhspaNqSzB2ZQdscaS
   atmDNeLNz67CB1I9dSXyNaPq32i+eO8p3Ka6hnhVwlPBd7aOQQaa2wSHd
   ZUlnMgOklQUpqiTv3IojzFNPvUiXWZkg/Ejr35SMjHyjMkK2hlcbRjdkl
   A==;
IronPort-SDR: wacTIo5+t2FzwH+88WMUNPbNzlw24Ma2+BLE2JOfs/SN5wL1g87mv8qstej3ydKpOsOpxj9fdW
 E8O7LYLePbhNjzLWfXERSjOwNtE8xmGR9s8LBDvN3cdi3432n/lpv6s/73kRyzp/I66LTVoLn+
 AX/c/QqpkiDArgVZhCpndV5gn1Do+9h+asmqV4bDVB+6mDATsFjJ2AFeRo//ez5Xopjs506GMe
 i+RGWJfTylxNgb7LHECVKtW63SYJUtoljONJFcT6NdhQ4QRv4T0Mpyx0y7TLDY/h5+MQd3dAV8
 UtA=
X-IronPort-AV: E=Sophos;i="5.79,344,1602518400"; 
   d="scan'208";a="261228293"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 17:37:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoSGn8gYVO6jPNKRfovnk3GSFM4CPIeCC6SUh3kr1hE4MwRidMxjD8jmJJpKe+hzssUGRKvre9x87StY0Q7F4xm5B9CldTZMZbBifXmyVWkaText8Tlf92iVHj1L/nINVfe/a77rs/i0Kh7Qpv+Mf47fYZBFCFYn1o2aEyvKkvZfbL3OojXBAFxYoKCl3DQafiMt4Hh8iYLsYGJv2FSti7v/zsnX/blOJgKyPiT3wQ+vGXcil7UhiSHT7ep8d8dpilWVcOjtKZgEJP8jFhZ8rRmBclLWZq4E+o3dBp1WM3cKqNB9lfoHdBJ8wrIFbfsU6ZAXg2yeGJW8AtopB1vS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpQQjOP3tY1pCveFPQ1E1zNzTv1fexmeuoBrXiAhz7Y=;
 b=MwYTRaBdhgmwMUDasy3elC+6PJOu8AtbXALqzaDSrX2cHJiWU8TpnYqgEcGKiXtFGgZTuGqSOdk7WZ4btmtaIInM6cZbHlgkfPMUXFE8AjHz6UuRM0gRFLh7dpioXhwuZzuli5gepoQC41qayMJ+kzhfL99HCM1YqjQEJ5XgKQGnlL4lqV3rasBscvlOWsgqRVua7mvlT5LYufsgivSRMIQtP3vf8v+KcNOWXNXAsW75/Kznxoc9f0zGTZQHun4iGOnePV8vqNk4erb9ma4edZpnUnwjvmTZCfspTnyQNuWDa3NJOWcN6AhD6cJL5r981dDZ6OomLTSczAKVoe3Lzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpQQjOP3tY1pCveFPQ1E1zNzTv1fexmeuoBrXiAhz7Y=;
 b=lowUyfotIzAncFWGMhwdJWqkpx1qr8qZG+407vM80mCalEW9u4WBUtUtG36mCrUTBkBoJqQET87y9lQYepi/Oq3ivxQGLImxL67/odVom+/dpcbjQGEmP+OAqjglki2y/oxYhQw92KOWlfbiTq6s+UbOa3ZhwVB01nSlbIcYCkg=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6981.namprd04.prod.outlook.com (2603:10b6:610:a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Wed, 13 Jan
 2021 09:28:03 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%8]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 09:28:02 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <tom.leiming@gmail.com>,
        Changheun Lee <nanich.lee@samsung.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
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
Date:   Wed, 13 Jan 2021 09:28:02 +0000
Message-ID: <CH2PR04MB65228D54F66068DA125CCE47E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <CGME20210113040146epcas1p230596c7c3760471dca442d1f7ce4dc55@epcas1p2.samsung.com>
 <CH2PR04MB65225EDDA7069CCD47A459A5E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20210113034637.1382-1-nanich.lee@samsung.com>
 <CACVXFVMb0eE5-yo2k3KvnJjKN+aDLzOuT9rKQ7LY5-4WTgM3jw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:e53d:bea0:4863:19b6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79ccc1da-5896-4daf-77bb-08d8b7a5865c
x-ms-traffictypediagnostic: CH2PR04MB6981:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB6981C6D96E6D287168522581E7A90@CH2PR04MB6981.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J9ACJbuN5JAHOgNnvev4XTeobBWnxalNUIU0u/2EJAGw6UO8d6kFNaxTWyrIslSA73bItzRRlBnrlf2+W8irN1uCcgBnaaxv6lVLEm+i9ibbfuE57TUSaTcSFJvodcuAWdV6CWKklUgXy+KGM2LTpg4BquWDzle41W3PzlrxyprQ/AnhBrtbKm0ECsWfGuDr3Xax87vHQkaLsC2YmAzf0n+oHCi05ghpyiYzcYV3B172Ekwx1guFn3jr5uQpCVUf8vuj67DTGSndMTzFD3H/DdDweAMgfmEQp2kDPwsQ6Se6CGMjtbWgphRoponQCk6CjU5V2nayN3f8HmdDhzycdQO4szeS8lpDnAOxUKDvOa/2oOes0TqsBZQubpagCBvMOJvmGhGum3sEsKiBaoRLeA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(4326008)(66946007)(76116006)(86362001)(66556008)(66476007)(91956017)(66446008)(64756008)(33656002)(9686003)(55016002)(83380400001)(71200400001)(6506007)(53546011)(186003)(110136005)(316002)(2906002)(8676002)(8936002)(5660300002)(52536014)(7696005)(478600001)(54906003)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?g2aw+QGZyS6HFSv3mLbYTkminqn8XZL5n8Uyt4ngGalftQS6+nbdbUhV2F2m?=
 =?us-ascii?Q?Rg5wemuO77Maam0zY+kl8//w0VKWil0Mdl9VIaz/uJeBo5xzHQR3DM3n6k7O?=
 =?us-ascii?Q?ryp+wYFsN8Wdbe0t4TFfNt6iIFzBsotR0pPeIRBXwMrhqlyxP0zJ6zNiDXHY?=
 =?us-ascii?Q?N8MtpO/n/NO/3SopqN2SwJl2xszKsQgJqM77xj4XEtrRUmJAgB5AQscvLLZ7?=
 =?us-ascii?Q?SNv7Lu+YkpzKfTPgK3Pg+0uhUjScWjzucWQ6maju1BufB6sCcEnU5Q7SpEgJ?=
 =?us-ascii?Q?O9d5Erl+jF1TVb0wp+upViEcrX1m8S4J44j7V2CEPfaClv8AnhPFxaI/uS1h?=
 =?us-ascii?Q?q+glYFq2ThS5Rxjtss7cD8O/qIOxh0MsHo9z+R7zLQc5O5MHrU7G0k6vTQc0?=
 =?us-ascii?Q?HiXO10gbd33Rjyb3s/5j3v2MEqY/as6tRf87+FmteXZLsFYj72/wEyi5cwqC?=
 =?us-ascii?Q?LoHz3qcy0D9ld0JJs3os4JrnkUbVrMv+OPp1t0oTojp42jkhiq8lwnkBbJbs?=
 =?us-ascii?Q?fOtVVXn6CqSW6JpXA8xgNIjrjE/t2hWa5YA+Yl5zPQX58MXQkK39N1cw5x1k?=
 =?us-ascii?Q?SmzacOyXopIZU2s6RpOyq7VrOpcdZU1ho4LIxyxd5PZ8+vS1FtlLrL5Hg4gd?=
 =?us-ascii?Q?19RSlpR9vCkMrLL2icpBJ7X91Z/un3UdW561DHMH2wqglv7sRPAImYxhMyZe?=
 =?us-ascii?Q?K4WBGAh36lujbcXJ8KUobqjQkHJ/d2P9YyArfece8W3mvPALKmjTSQdfDleM?=
 =?us-ascii?Q?sUNaiEYiVJQ7FzbLx7tMZm61kFr6gzse4WiKJJ/UhA/tnm4cHznlwZRhoVXY?=
 =?us-ascii?Q?LdEixIOLDL4oqCWuxlmPfJO4yYKo8bLxiw+rtIE0dTRTRiQGRq0ilt42jgzP?=
 =?us-ascii?Q?A7/wyfZvpIFUm/0cuy+F14+MgttJ4vnchQ+W+CqHyiRiW5zdz+6S2ZHPVj4d?=
 =?us-ascii?Q?MIU1mZlU/gepv9aEa8mg4aN0qpRtWZK8spKx7zWcl7p9JmTvtEd6MnFKi2TJ?=
 =?us-ascii?Q?H0/sjHv0TnMqwQYTaMfwGBlPHgQS+2UoEqWt8e8hF1ZrSXtxmMAjcy5d1I+s?=
 =?us-ascii?Q?b12X0bJ5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ccc1da-5896-4daf-77bb-08d8b7a5865c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 09:28:02.3274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5CGTxPTo+ENnxXJBPD6xbiP0BIQQO03RgcMdVCPg98wobUIoQJ4C3EV1YtXEw3vHTua5XiGCaFhpZH1rDkvWZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6981
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/13 18:19, Ming Lei wrote:=0A=
> On Wed, Jan 13, 2021 at 12:09 PM Changheun Lee <nanich.lee@samsung.com> w=
rote:=0A=
>>=0A=
>>> On 2021/01/12 21:14, Changheun Lee wrote:=0A=
>>>>> On 2021/01/12 17:52, Changheun Lee wrote:=0A=
>>>>>> From: "Changheun Lee" <nanich.lee@samsung.com>=0A=
>>>>>>=0A=
>>>>>> bio size can grow up to 4GB when muli-page bvec is enabled.=0A=
>>>>>> but sometimes it would lead to inefficient behaviors.=0A=
>>>>>> in case of large chunk direct I/O, - 64MB chunk read in user space -=
=0A=
>>>>>> all pages for 64MB would be merged to a bio structure if memory addr=
ess is=0A=
>>>>>> continued phsycally. it makes some delay to submit until merge compl=
ete.=0A=
>>>>>> bio max size should be limited as a proper size.=0A=
>>>>>=0A=
>>>>> But merging physically contiguous pages into the same bvec + later au=
tomatic bio=0A=
>>>>> split on submit should give you better throughput for large IOs compa=
red to=0A=
>>>>> having to issue a bio chain of smaller BIOs that are arbitrarily size=
d and will=0A=
>>>>> likely need splitting anyway (because of DMA boundaries etc).=0A=
>>>>>=0A=
>>>>> Do you have a specific case where you see higher performance with thi=
s patch=0A=
>>>>> applied ? On Intel, BIO_MAX_SIZE would be 1MB... That is arbitrary an=
d too small=0A=
>>>>> considering that many hardware can execute larger IOs than that.=0A=
>>>>>=0A=
>>>>=0A=
>>>> When I tested 32MB chunk read with O_DIRECT in android, all pages of 3=
2MB=0A=
>>>> is merged into a bio structure.=0A=
>>>> And elapsed time to merge complete was about 2ms.=0A=
>>>> It means first bio-submit is after 2ms.=0A=
>>>> If bio size is limited with 1MB with this patch, first bio-submit is a=
bout=0A=
>>>> 100us by bio_full operation.=0A=
>>>=0A=
>>> bio_submit() will split the large BIO case into multiple requests while=
 the=0A=
>>> small BIO case will likely result one or two requests only. That likely=
 explain=0A=
>>> the time difference here. However, for the large case, the 2ms will iss=
ue ALL=0A=
>>> requests needed for processing the entire 32MB user IO while the 1MB bi=
o case=0A=
>>> will need 32 different bio_submit() calls. So what is the actual total =
latency=0A=
>>> difference for the entire 32MB user IO ? That is I think what needs to =
be=0A=
>>> compared here.=0A=
>>>=0A=
>>> Also, what is your device max_sectors_kb and max queue depth ?=0A=
>>>=0A=
>>=0A=
>> 32MB total latency is about 19ms including merge time without this patch=
.=0A=
>> But with this patch, total latency is about 17ms including merge time to=
o.=0A=
> =0A=
> 19ms looks too big just for preparing one 32MB sized bio, which isn't=0A=
> supposed to=0A=
> take so long.  Can you investigate where the 19ms is taken just for=0A=
> preparing one=0A=
> 32MB sized bio?=0A=
=0A=
Changheun mentioned that the device side IO latency is 16.7ms out of the 19=
ms=0A=
total. So the BIO handling, submission+completion takes about 2.3ms, and=0A=
Changheun points above to 2ms for the submission part.=0A=
=0A=
> =0A=
> It might be iov_iter_get_pages() for handling page fault. If yes, one sug=
gestion=0A=
> is to enable THP(Transparent HugePage Support) in your application.=0A=
=0A=
But if that was due to page faults, the same large-ish time would be taken =
for=0A=
the preparing the size-limited BIOs too, no ? No matter how the BIOs are di=
ced,=0A=
all 32MB of pages of the user IO are referenced...=0A=
=0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
