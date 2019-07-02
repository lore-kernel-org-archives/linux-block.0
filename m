Return-Path: <SRS0=exTe=U7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E91C5B57D
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 05:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EB42146F
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 05:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c4Ojf4LL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pVYs5dQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbfGBFEr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 01:04:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23367 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfGBFEr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 01:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562043914; x=1593579914;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WVd8iKnwTJhyH0+tMGBgAPny5cjHvAu8bBwCgOU5K8E=;
  b=c4Ojf4LLDvfbsKK7nEXBbdLdbrrq2SSByZ2Gi1I9++sjx/2X4MslITFX
   6CUnmMJu9ML9HpsOZd1M5uh0RmK8JUuBOgUHTWzejBGU0uIVRLKU4Zv+p
   YndYpGws9VwDq4w0H4F9aOmtK0byRY0W4cU0Yzt7giYQcpDdAdwuNTg4v
   6RZp/gtuvRrG3bnyVsMuJeoV7nutvNQ4ZnJgtWWUPvwXZdxcDUrcnv9hw
   TKd8qtzHstYYDSlhTWt+N2kWLZi6jh5kGxqwUhrV5Byi02qImRxyHgVe7
   qP8POojUbS1Osq25Un7m/jogMg7dutf6JwIKBKlJdguRJsbLzX0NzMRyk
   g==;
IronPort-SDR: Us4pqmTYFLiO0cRbSQh8CyEnoQIfX7/aNy76h2GNOwTJ6WnqAxMpumNVSlRJJzidu2mfGsA2ou
 DYGuX771ZVIu7MI7qOXeeifzTeBW6TkS7lliCkvCFl6VJppfaN6kSxNagLJtksPIPfVbW9VAHx
 WqY8egbnNiX5a/B67ZB0xtnw1wkrEApzwmV2m2DHPi/rJ7uFt410Al93cE9hYFABfaVLfA4zZw
 eJxLEucuYO9YFv1PtS5PXMgD5jfAUEwwHRXUgSUpjYTb//9gDul04Z2NAaAeb/LM2W6gPwmI8e
 c58=
X-IronPort-AV: E=Sophos;i="5.63,442,1557158400"; 
   d="scan'208";a="211864786"
Received: from mail-sn1nam01lp2054.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.54])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2019 13:04:58 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArkydkSqYdxQomD09XXqlq38WxQkn45Y5qw5VxdfqIc=;
 b=pVYs5dQ1FB8dsTvXim7IE7sqS5Tlazqqjyw/mhVpwpPHyqPPUwMqwpumXlWks2SClGvPQxQdlauYtZwcQuYnFn2QfUbabURHxO45HvAnObaw8jyjWUkeuYoRTBa5E21ErVjWTlkMUUrM49yBsuKyJm5N4hENDSpjiryINN0Zz7k=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4392.namprd04.prod.outlook.com (20.176.252.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 05:04:34 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 05:04:34 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Florian Knauf <florian.knauf@stud.uni-hannover.de>
CC:     "linux-kernel@i4.cs.fau.de" <linux-kernel@i4.cs.fau.de>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Ewert <christian.ewert@stud.uni-hannover.de>
Subject: Re: [PATCH v2] drivers/block/loop: Replace deprecated function in
 option parsing code
Thread-Topic: [PATCH v2] drivers/block/loop: Replace deprecated function in
 option parsing code
Thread-Index: AQHVK386Ta6SMRAy8UW37kTixSPwpqazD5KAgAPAtgc=
Date:   Tue, 2 Jul 2019 05:04:33 +0000
Message-ID: <AF943092-D561-4257-A035-9E2F53F1E347@wdc.com>
References: <BYAPR04MB574936B98A60EB42B9A7C97886E30@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20190625175517.31133-1-florian.knauf@stud.uni-hannover.de>
 <BYAPR04MB574963E31CE0DB5581F5311F86E30@BYAPR04MB5749.namprd04.prod.outlook.com>,<eb0b0981-aba3-93dc-5ae5-d36f1f728024@stud.uni-hannover.de>
In-Reply-To: <eb0b0981-aba3-93dc-5ae5-d36f1f728024@stud.uni-hannover.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [76.89.205.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30c86c33-1b0c-46a5-e88b-08d6feaac60d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4392;
x-ms-traffictypediagnostic: BYAPR04MB4392:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB4392E265148976391CDA254686F80@BYAPR04MB4392.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(189003)(199004)(14454004)(966005)(86362001)(81156014)(8676002)(486006)(305945005)(7736002)(11346002)(476003)(446003)(14444005)(5024004)(2616005)(4326008)(2906002)(72206003)(478600001)(25786009)(68736007)(81166006)(76176011)(6246003)(36756003)(66946007)(186003)(76116006)(26005)(5660300002)(66476007)(66556008)(64756008)(73956011)(102836004)(3846002)(53936002)(6116002)(53546011)(6506007)(66066001)(8936002)(99286004)(66446008)(54906003)(6916009)(6486002)(6306002)(229853002)(6512007)(316002)(6436002)(256004)(71200400001)(71190400001)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4392;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Its5Y9tR+d7B32eBAgM1c/HD6Q7c6ex7qo+xZ3DGZbMZxCTKpDtKlsZXT64EKXB1GXpyQ2dR6EMOh8m0rlQffbsp0jsdDkecLb4jwxT5fDmg9GKQyNsPNU8HjQi2H/dZrSNAKcQqIAoRDRzcPKL/9gXeWJNO2tUXmYdCvFI4zWOsUw7IqL6X7BhjCam9xAJwKoTIzm0IsVuCstBWvEJDwAeFA3woBuX4nMWayDfTr0CNOdFfYRlg2YFUVs03S2soYSbnAuHk8XHlGSvPbAqZwWWyXc3MKTUoYlLho6GO6F0i9EKTMkOuqU8cWjn/cDIsVG8FgSSjKZEgSF3P6Je5NxZ58cHD4Zxmv8MXwgTlT0LiBH02w28eH2fbJ12rvahMTRc35C+NsifVAwOKyle+FiJCCVUq54wyuc850srxacs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c86c33-1b0c-46a5-e88b-08d6feaac60d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 05:04:33.8190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4392
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

You are welcome.
> On Jun 29, 2019, at 12:46 PM, Florian Knauf <florian.knauf@stud.uni-hanno=
ver.de> wrote:
>=20
> I have now, on the latest staging master (test log attached, everything g=
reen), and also learned a lesson about looking more thoroughly for automate=
d test cases. That's a mea culpa, I suppose. :P
>=20
> Before this I'd only found the Linux Test Project, which (if I'm not mist=
aken) contains tests that use loopback devices but no tests that specifical=
ly test the loopback driver itself. Given the small scope of the change, we=
 then considered it sufficient to test manually that the loop device still =
worked and that the max_loop parameter was handled correctly. Of course, th=
e blktests way is better.
>=20
> Thanks for taking the time to answer and review.
>=20
>> Am 25.06.19 um 21:24 schrieb Chaitanya Kulkarni:
>> I believe you have tested this patch with loop testcases present in the
>> :- https://github.com/osandov/blktests/tree/master/tests/loop.
>> With that, looks good.
>> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>.
>>> On 06/25/2019 10:55 AM, Florian Knauf wrote:
>>> This patch removes the deprecated simple_strtol function from the optio=
n
>>> parsing logic in the loopback device driver. Instead kstrtoint is used =
to
>>> parse int max_loop, to ensure that input values it cannot represent are
>>> ignored.
>>>=20
>>> Signed-off-by: Florian Knauf <florian.knauf@stud.uni-hannover.de>
>>> Signed-off-by: Christian Ewert <christian.ewert@stud.uni-hannover.de>
>>> ---
>>> Thank you for your feedback.
>>>=20
>>> There's no specific reason to use kstrtol, other than the fact that we
>>> weren't yet aware that kstrtoint exists. (We're new at this, I'm afraid=
.)
>>>=20
>>> We've amended the patch to make use of kstrtoint, which is of course mu=
ch
>>> more straightforward.
>>>=20
>>> drivers/block/loop.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>>> index 102d79575895..adfaf4ad37d1 100644
>>> --- a/drivers/block/loop.c
>>> +++ b/drivers/block/loop.c
>>> @@ -2289,7 +2289,7 @@ module_exit(loop_exit);
>>>   #ifndef MODULE
>>>   static int __init max_loop_setup(char *str)
>>>   {
>>> -    max_loop =3D simple_strtol(str, NULL, 0);
>>> +    kstrtoint(str, 0, &max_loop);
>>>       return 1;
>>>   }
>>>=20
>>>=20
> <check.log>
