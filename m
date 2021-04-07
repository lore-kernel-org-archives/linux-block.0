Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E19C433ED
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 10:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C2F3613A7
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 10:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbhDGKag (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 06:30:36 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:22781 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233988AbhDGKaf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Apr 2021 06:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617791427; x=1649327427;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YHLwIt2Q8k0dD/J8cY4zElBwN+MrLdvGevZMoriFsGg=;
  b=DA99CeHKExnapLt7OqLpzeXWb2GwDcP+/Cio8/2SEO+t6iBim5A3JvxB
   pooCVkAazCmPBcKTHeIDh/Jg4PWrMA8tGzOcxUNT9kzW9DtLdb1wvsySV
   xNKkxPPAQKtsjnFIWAwU2NLHGT8miDLwWyjNxRy+25BxXgbaBwpJTSKPa
   +MYsdUebyigs/lBnp/yXUUBPKqNh9X4137stLz9ou/mRPe7XJO82akpCY
   0Xvwe7gWi9NNq/JZUV6FqkFKvtnw9OrRtgRX/xs5JAjk9bBzNuKFqwQ10
   eb8xgxejJ9WM2FjDaVnuifCbiHF98naMoLOri/HYFKEHySn6mfS/2SC1d
   Q==;
IronPort-SDR: KiIVsBYGoZ/J2+VOoGnGMAI6/zOtZNLmFkQirrQnLxRqe6zA6QkJTSG98lrjqZYFFZVVgGeVcE
 2tDAMECyq6rV5vmHzAQa63N+a1FTmegOXQvgi2mefV88eNtd1ZhE42oMc3JcfopZl/pEcn3bBM
 D4kgkNxT+8NDGv/fcv7NnSlNIklBkncrFKXdnigtR5zUGPkqmKMItlEIzAaME3OxcZYahdqO/p
 mNvTBJqRiPdolp9eoeRRDv7QM/WDM5HPIv8/MUiEq1JG9H8F8zGg00mDn6fLxkYOyDy/E4TnX6
 5/o=
X-IronPort-AV: E=Sophos;i="5.82,203,1613404800"; 
   d="scan'208";a="164994607"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 07 Apr 2021 18:28:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaETmIMHMbFbT/Yh9mToXw/8U3bDmZTt1gpYqAAOTftOORu4qRTUOSTFck3Zz6MF8+OiM4S4LKB68rwMhYsISpyQOuAwX0X62GpYbGlkioKTTiZtrQRwM0oYaJY5INFq1H2y6E/HRtb86Ct08+pe0H9GDseGN8YaTNo9XzxBHv3ms/ECCooQgdbyye5Zf94Lts4EfY03EhGs8ffOJhdcNwxm0XNuA5zvyutYvPZUkonaKvldrTvmjGum3lGcuHQZzD6nU4QKE8NFGO+/vOCSszdJrnFC0JNiuPLMqkcKSP/wPieU7YiPiJn/Qoli3pWuUw11A9/4BtNyWc/tACN5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P8ceVyc1G36KsOPhhyZfx2KMkAAVyzoI0D4NyurVs8=;
 b=msOOyckTrQZ+oMmba+u4HHFdQI53hmjXygnaOU/e2QaNWxFHrP476uIEN7TBSP/Vd6axzJmsndk8Iyp44KZiT83YsCulkKYnqe4BhOdgMqNj+T6h6hQTf3gDKZybLxY9xaPw7WzcLgBLFkVkbvRD/0hX1sjtKx0i8JkGfxERIV7tjf8W/DjpVVhMJUaTWI9j9GsquvHlQVQbgNYt8DY8XzdafCFeDuPiA7o++tWbVK683dbKKVDSZ+Fj4XYdFkUhCH1R8UmWlAGknhTKGsqNhBRRaOkRcAk83eKrj0NGCinyZNjfv3ixMvLu9Wjiwr/a8M+AA9YTKnrffKCJ1JeZTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P8ceVyc1G36KsOPhhyZfx2KMkAAVyzoI0D4NyurVs8=;
 b=aB6vaYcMVvfAGQTYiRGjFWh+TgBBs8OklZpe83juipFjtE3ZIPgjQ71OK3Zw6kEV7vxe4MgjG/K0w2ockXZ1YXxLcTRwujXpMX42eKgssKlGj0nD9UVOIYaQL24w7irWzucy6UrfLCbPxmDxHuViToUUYGGD34kr9DDnW+TAv8A=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6446.namprd04.prod.outlook.com (2603:10b6:208:1aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Wed, 7 Apr
 2021 10:27:57 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3999.032; Wed, 7 Apr 2021
 10:27:57 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Changheun Lee <nanich.lee@samsung.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "asml.silence@gmail.com" <asml.silence@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
        "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "mj0123.lee@samsung.com" <mj0123.lee@samsung.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "patchwork-bot@kernel.org" <patchwork-bot@kernel.org>,
        "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
        "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "tom.leiming@gmail.com" <tom.leiming@gmail.com>,
        "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
        "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>
Subject: Re: [RESEND,v5,1/2] bio: limit bio max size
Thread-Topic: [RESEND,v5,1/2] bio: limit bio max size
Thread-Index: AQHXK5LimbigZS3dMEyF4qJ0Ir0lcg==
Date:   Wed, 7 Apr 2021 10:27:57 +0000
Message-ID: <BL0PR04MB65146F70831B61CB6B9AFE7CE7759@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <YG1iC944hUkBniDM@kroah.com>
 <CGME20210407094610epcas1p472207e8d3ca0e5e697974c993a2a34f7@epcas1p4.samsung.com>
 <20210407092836.13016-1-nanich.lee@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f060:aa0a:9ee0:dfa8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b29dc3b-80af-4e58-d037-08d8f9afcff7
x-ms-traffictypediagnostic: MN2PR04MB6446:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6446188549278B92D9BD8D5AE7759@MN2PR04MB6446.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: euxLMjcZciVy6oNk0MMivOvbTRy8faaUAxBn2tGzgkbPu8gZaq/IBPsJCsypk6Kk0v3LnMqqtXF539N48UG0fXPQGJDXwS5gWULZORfESieXINa4F55HXRVm0aaVun9EASlB4Sjrev2qXuDziy8GFyHjnfN+sIgFzO+/tlNb3sUXUW03wTJ9tszRwcqvuz9MZVjZuO6No+wF0DhHX0RRMbo6u8KqCh7vuQQivlrp/63X7gafWxTyHZL1KyqGoVEEj9WkmhJA/YYEqIxlNGWwJXP4OHguFTIgvDsnqdtj1sPyrvoL/xsGzROR+WlJfzZcu2V5SdklRRRc+r3fHuzHSyJ9of0sgO2GunafpPClniVab5iluxuJREq7VkAIXg4i5JfL52evb21F71P2hHUsIcbwMNM4yzR9yndLqGlmQ283JBt2dSP1Hpe7v2bCwCzTDtPoDXMt8t7e5lwOhIinRAf6680+tXSZU0MIcBy5o3PIkt+docbOvVFQ504ge8cnourwItKALhkjuiq/9Diu0NElyGn4iwEM+JR+AtrPzd1KM45b5P0Tv54q6hbHA9OlHQdb8YQKwsfN4Xgjk/phza3CYX1M2QVnQL7khyYsiERaguQSSf5OlwHgDXdiSSuFuzYh9hSgwyg5+S9nwHXUNR6L4QG1NkpuuJ9H5k4tcg0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(71200400001)(6506007)(478600001)(53546011)(110136005)(64756008)(8936002)(7416002)(7696005)(186003)(66556008)(66946007)(52536014)(33656002)(86362001)(316002)(9686003)(54906003)(4326008)(2906002)(55016002)(91956017)(76116006)(83380400001)(38100700001)(8676002)(66446008)(5660300002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?f/3B02F/gCp///mD4R8Gg1kembuFk5MZM/jGeJlhk9DRcu23jArWD0py9rsi?=
 =?us-ascii?Q?mP2SjvDTmCbQ4DL/nDI86ln9+2dcUNzVjF0OpC6CVl47A/E9s8AVjFkvBOtX?=
 =?us-ascii?Q?UIa2UuHQ1SLtTMedJNl8aud700HOlmuP2hkFYY615mhE7RJOo2HW7LHK+KEt?=
 =?us-ascii?Q?6Om42ftGBXfcU3h6kl1WhzsB6OO9yTMcdb03vGLIfTcD3yyA50TmYdllF1K8?=
 =?us-ascii?Q?f+s0LO0VFjxfOO6V2mVQ7IEl1iKszqXb+FPdJRbfswfGsgO6/seB4vm1Cozc?=
 =?us-ascii?Q?BCDKEGGPjLCgplFokqK+plD49tc7WdRrLAMQaoZ/jS2eWTTqjqVPtlsG+LS/?=
 =?us-ascii?Q?lR4YK5tVcG7Q4TXKOKw8f3bwahFWlVkJzOS09wlJxTCokJdDJUHaY/A+C5lu?=
 =?us-ascii?Q?gV/WOe0xxgVq/dfM7JmIVoaKKpOh20MfQ3LeVPelAAHjxNeK+e3TTthPk2hA?=
 =?us-ascii?Q?ikQtVrM+wlZG3Olh3ydroSFOU6MTVG9/9BkBp+3Na7DZX3LmVsOJfnTtKmqd?=
 =?us-ascii?Q?+gLYUfUoWwKlJFHiYOE7HHwKzPJao8RXpdMLQRmfneGAazANttyUk8tQarAr?=
 =?us-ascii?Q?lK+OMLl1p2nf8prwQ+hFb891eVFPdlZNOL+7wqnreeHWkbVxle5hzDo51s3O?=
 =?us-ascii?Q?hYpXeTe88303kn6y4dx0/jFQFfOPlYHmw+79vD8CSlhJi7lk9kUfbk7yTct5?=
 =?us-ascii?Q?zD/xbF8sc3i6zUEaOUJvTffvsyd5GiUHQfwHhnbnh6EiqMb3x3wTWYyvT19m?=
 =?us-ascii?Q?yWuqtoVKSWwnQQSW9VmbsWWcs8dbt9ouKzT/KpGmidY8yTNMB2GmcWNOinTn?=
 =?us-ascii?Q?CXurPo+xJjJ+HPJMbOdYzggI3KtX20sS1DPplu+RuU9C8mwq99J92pYZ/Xu2?=
 =?us-ascii?Q?YXv7EyOkR3KPoVbzZtcWFkWNF4rxAkdeJWFKPtNVyIAd1wsa51xJm9eDIFxY?=
 =?us-ascii?Q?BagOADe8+HVbK2B8QvrOP4jVZCo6ZT+H0S26U9Hby3PEoKLH4OPs2+R/ioAW?=
 =?us-ascii?Q?wUP+s5nbkJ/CwB94Wk4dnSJdDtgIPLfxCgc/pSc6l5H7TaFmh8shmDbgoJlG?=
 =?us-ascii?Q?kgGg+zlyL9sXuJmHChV7lcGB09oCMmR63sGB1Lja+PK+ziGXjemPPLXZvxHd?=
 =?us-ascii?Q?lNOIBa0DGxTWLV+YOVTsXkVhgODagTW6q+2zbaXkSA9WusaL0ujvBhunQEh1?=
 =?us-ascii?Q?sGRHQ9muGeVOjCtBaDcWi6z/XiAmD7vIII0M5lYhmypii5hbJkfht3HhS9yF?=
 =?us-ascii?Q?zvqbtO9T+Ss4bIh7nexffu1i66+yOMhJUtdeR+97VSYg38yuHU3wx3eEWnjK?=
 =?us-ascii?Q?Zb0D4fKuEL/eK+kLP+4443ODgx22Ayjf8Tmdvwse1/PsrVeH+ZdSIRRY+ERg?=
 =?us-ascii?Q?2h2DhfBP2ekfKJE34dkaAQuL97mPKXdTyKmjWVDDxgrCHTKHaQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b29dc3b-80af-4e58-d037-08d8f9afcff7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 10:27:57.4342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cn0uKrAqVuWGzsujX+1Tu3bvOiagW1wapCe6UOruV6Evw0WicF8MA/fV6sM0AukCvgIOiDFy6tJYIX80VhG6zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6446
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/04/07 18:46, Changheun Lee wrote:=0A=
>> On Wed, Apr 07, 2021 at 03:55:07PM +0900, Changheun Lee wrote:=0A=
>>>> On Wed, Apr 07, 2021 at 02:06:33PM +0900, Changheun Lee wrote:=0A=
>>>>>> On Wed, Apr 07, 2021 at 09:16:12AM +0900, Changheun Lee wrote:=0A=
>>>>>>>> On Tue, Apr 06, 2021 at 10:31:28AM +0900, Changheun Lee wrote:=0A=
>>>>>>>>>> bio size can grow up to 4GB when muli-page bvec is enabled.=0A=
>>>>>>>>>> but sometimes it would lead to inefficient behaviors.=0A=
>>>>>>>>>> in case of large chunk direct I/O, - 32MB chunk read in user spa=
ce -=0A=
>>>>>>>>>> all pages for 32MB would be merged to a bio structure if the pag=
es=0A=
>>>>>>>>>> physical addresses are contiguous. it makes some delay to submit=
=0A=
>>>>>>>>>> until merge complete. bio max size should be limited to a proper=
 size.=0A=
>>>>>>>>>>=0A=
>>>>>>>>>> When 32MB chunk read with direct I/O option is coming from users=
pace,=0A=
>>>>>>>>>> kernel behavior is below now in do_direct_IO() loop. it's timeli=
ne.=0A=
>>>>>>>>>>=0A=
>>>>>>>>>>  | bio merge for 32MB. total 8,192 pages are merged.=0A=
>>>>>>>>>>  | total elapsed time is over 2ms.=0A=
>>>>>>>>>>  |------------------ ... ----------------------->|=0A=
>>>>>>>>>>                                                  | 8,192 pages m=
erged a bio.=0A=
>>>>>>>>>>                                                  | at this time,=
 first bio submit is done.=0A=
>>>>>>>>>>                                                  | 1 bio is spli=
t to 32 read request and issue.=0A=
>>>>>>>>>>                                                  |--------------=
->=0A=
>>>>>>>>>>                                                   |-------------=
-->=0A=
>>>>>>>>>>                                                    |------------=
--->=0A=
>>>>>>>>>>                                                               ..=
....=0A=
>>>>>>>>>>                                                                 =
   |--------------->=0A=
>>>>>>>>>>                                                                 =
    |--------------->|=0A=
>>>>>>>>>>                           total 19ms elapsed to complete 32MB re=
ad done from device. |=0A=
>>>>>>>>>>=0A=
>>>>>>>>>> If bio max size is limited with 1MB, behavior is changed below.=
=0A=
>>>>>>>>>>=0A=
>>>>>>>>>>  | bio merge for 1MB. 256 pages are merged for each bio.=0A=
>>>>>>>>>>  | total 32 bio will be made.=0A=
>>>>>>>>>>  | total elapsed time is over 2ms. it's same.=0A=
>>>>>>>>>>  | but, first bio submit timing is fast. about 100us.=0A=
>>>>>>>>>>  |--->|--->|--->|---> ... -->|--->|--->|--->|--->|=0A=
>>>>>>>>>>       | 256 pages merged a bio.=0A=
>>>>>>>>>>       | at this time, first bio submit is done.=0A=
>>>>>>>>>>       | and 1 read request is issued for 1 bio.=0A=
>>>>>>>>>>       |--------------->=0A=
>>>>>>>>>>            |--------------->=0A=
>>>>>>>>>>                 |--------------->=0A=
>>>>>>>>>>                                       ......=0A=
>>>>>>>>>>                                                  |--------------=
->=0A=
>>>>>>>>>>                                                   |-------------=
-->|=0A=
>>>>>>>>>>         total 17ms elapsed to complete 32MB read done from devic=
e. |=0A=
>>>>>>>>>>=0A=
>>>>>>>>>> As a result, read request issue timing is faster if bio max size=
 is limited.=0A=
>>>>>>>>>> Current kernel behavior with multipage bvec, super large bio can=
 be created.=0A=
>>>>>>>>>> And it lead to delay first I/O request issue.=0A=
>>>>>>>>>>=0A=
>>>>>>>>>> Signed-off-by: Changheun Lee <nanich.lee@samsung.com>=0A=
>>>>>>>>>> ---=0A=
>>>>>>>>>>  block/bio.c            | 13 ++++++++++++-=0A=
>>>>>>>>>>  include/linux/bio.h    |  2 +-=0A=
>>>>>>>>>>  include/linux/blkdev.h |  3 +++=0A=
>>>>>>>>>>  3 files changed, 16 insertions(+), 2 deletions(-)=0A=
>>>>>>>>>>=0A=
>>>>>>>>>> diff --git a/block/bio.c b/block/bio.c=0A=
>>>>>>>>>> index 1f2cc1fbe283..c528e1f944c7 100644=0A=
>>>>>>>>>> --- a/block/bio.c=0A=
>>>>>>>>>> +++ b/block/bio.c=0A=
>>>>>>>>>> @@ -287,6 +287,17 @@ void bio_init(struct bio *bio, struct bio_v=
ec *table,=0A=
>>>>>>>>>>  }=0A=
>>>>>>>>>>  EXPORT_SYMBOL(bio_init);=0A=
>>>>>>>>>>  =0A=
>>>>>>>>>> +unsigned int bio_max_size(struct bio *bio)=0A=
>>>>>>>>>> +{=0A=
>>>>>>>>>> +	struct request_queue *q =3D bio->bi_disk->queue;=0A=
>>>>>>>>>> +=0A=
>>>>>>>>>> +	if (blk_queue_limit_bio_size(q))=0A=
>>>>>>>>>> +		return blk_queue_get_max_sectors(q, bio_op(bio))=0A=
>>>>>>>>>> +			<< SECTOR_SHIFT;=0A=
>>>>>>>>>> +=0A=
>>>>>>>>>> +	return UINT_MAX;=0A=
>>>>>>>>>> +}=0A=
>>>>>>>>>> +=0A=
>>>>>>>>>>  /**=0A=
>>>>>>>>>>   * bio_reset - reinitialize a bio=0A=
>>>>>>>>>>   * @bio:	bio to reset=0A=
>>>>>>>>>> @@ -877,7 +888,7 @@ bool __bio_try_merge_page(struct bio *bio, s=
truct page *page,=0A=
>>>>>>>>>>  		struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];=0A=
>>>>>>>>>>  =0A=
>>>>>>>>>>  		if (page_is_mergeable(bv, page, len, off, same_page)) {=0A=
>>>>>>>>>> -			if (bio->bi_iter.bi_size > UINT_MAX - len) {=0A=
>>>>>>>>>> +			if (bio->bi_iter.bi_size > bio_max_size(bio) - len) {=0A=
>>>>>>>>>>  				*same_page =3D false;=0A=
>>>>>>>>>>  				return false;=0A=
>>>>>>>>>>  			}=0A=
>>>>>>>>>> diff --git a/include/linux/bio.h b/include/linux/bio.h=0A=
>>>>>>>>>> index 1edda614f7ce..13b6f6562a5b 100644=0A=
>>>>>>>>>> --- a/include/linux/bio.h=0A=
>>>>>>>>>> +++ b/include/linux/bio.h=0A=
>>>>>>>>>> @@ -113,7 +113,7 @@ static inline bool bio_full(struct bio *bio,=
 unsigned len)=0A=
>>>>>>>>>>  	if (bio->bi_vcnt >=3D bio->bi_max_vecs)=0A=
>>>>>>>>>>  		return true;=0A=
>>>>>>>>>>  =0A=
>>>>>>>>>> -	if (bio->bi_iter.bi_size > UINT_MAX - len)=0A=
>>>>>>>>>> +	if (bio->bi_iter.bi_size > bio_max_size(bio) - len)=0A=
>>>>>>>>>>  		return true;=0A=
>>>>>>>>>>  =0A=
>>>>>>>>>>  	return false;=0A=
>>>>>>>>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
>>>>>>>>>> index f94ee3089e01..3aeab9e7e97b 100644=0A=
>>>>>>>>>> --- a/include/linux/blkdev.h=0A=
>>>>>>>>>> +++ b/include/linux/blkdev.h=0A=
>>>>>>>>>> @@ -621,6 +621,7 @@ struct request_queue {=0A=
>>>>>>>>>>  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns=
 */=0A=
>>>>>>>>>>  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx i=
s active */=0A=
>>>>>>>>>>  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */=
=0A=
>>>>>>>>>> +#define QUEUE_FLAG_LIMIT_BIO_SIZE 30	/* limit bio size */=0A=
>>>>>>>>>>  =0A=
>>>>>>>>>>  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\=
=0A=
>>>>>>>>>>  				 (1 << QUEUE_FLAG_SAME_COMP) |		\=0A=
>>>>>>>>>> @@ -667,6 +668,8 @@ bool blk_queue_flag_test_and_set(unsigned in=
t flag, struct request_queue *q);=0A=
>>>>>>>>>>  #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_f=
lags)=0A=
>>>>>>>>>>  #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED,=
 &(q)->queue_flags)=0A=
>>>>>>>>>>  #define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->q=
ueue_flags)=0A=
>>>>>>>>>> +#define blk_queue_limit_bio_size(q)	\=0A=
>>>>>>>>>> +	test_bit(QUEUE_FLAG_LIMIT_BIO_SIZE, &(q)->queue_flags)=0A=
>>>>>>>>>>  =0A=
>>>>>>>>>>  extern void blk_set_pm_only(struct request_queue *q);=0A=
>>>>>>>>>>  extern void blk_clear_pm_only(struct request_queue *q);=0A=
>>>>>>>>>> -- =0A=
>>>>>>>>>> 2.28.0=0A=
>>>>>>>>>>=0A=
>>>>>>>>>=0A=
>>>>>>>>> Please feedback to me if more modification is needed to apply. :)=
=0A=
>>>>>>>>=0A=
>>>>>>>> You are adding code that tests for a value to be set, yet you neve=
r set=0A=
>>>>>>>> it in this code so why is it needed at all?=0A=
>>>>>>>=0A=
>>>>>>> This patch is a solution for some inefficient case of multipage bve=
c like=0A=
>>>>>>> as current DIO scenario. So it's not set as a default.=0A=
>>>>>>> It will be set when bio size limitation is needed in runtime.=0A=
>>>>>>=0A=
>>>>>> Set where?=0A=
>>>>>=0A=
>>>>> In my environment, set it on init.rc file like as below.=0A=
>>>>> "echo 1 > /sys/block/sda/queue/limit_bio_size"=0A=
>>>>=0A=
>>>> I do not see any sysfs file in this patch, and why would you ever want=
=0A=
>>>> to be forced to manually do this?  The hardware should know the limits=
=0A=
>>>> itself, and should automatically tune things like this, do not force a=
=0A=
>>>> user to do it as that's just not going to go well at all.=0A=
>>>=0A=
>>> Patch for sysfs is sent "[RESEND,v5,2/2] bio: add limit_bio_size sysfs"=
.=0A=
>>> Actually I just suggested constant - 1MB - value to limit bio size at f=
irst.=0A=
>>> But I got a feedback that patch will be better if it's optional, and=0A=
>>> getting meaningful value from device queue on patchwork.=0A=
>>> There are some differences for each system environment I think.=0A=
>>>=0A=
>>> But there are inefficient logic obviously by applying of multipage bvec=
.=0A=
>>> So it will be shown in several system environment.=0A=
>>> Currently providing this patch as a option would be better to select=0A=
>>> according to each system environment, and policy I think.=0A=
>>>=0A=
>>> Please, revisit applying this patch.=0A=
>>>=0A=
>>>>=0A=
>>>> So if this patch series is forcing a new option to be configured by=0A=
>>>> sysfs only, that's not acceptable, sorry.=0A=
>>>=0A=
>>> If it is not acceptable ever with current, may I progress review again=
=0A=
>>> with default enabled?=0A=
>>=0A=
>> I am sorry, I can not parse this, can you rephrase this?=0A=
>>=0A=
>> thanks,=0A=
>>=0A=
>> greg k-h=0A=
>>=0A=
> =0A=
> I'll prepare new patch as you recommand. It will be added setting of=0A=
> limit_bio_size automatically when queue max sectors is determined.=0A=
=0A=
Please do that in the driver for the HW that benefits from it. Do not do th=
is=0A=
for all block devices.=0A=
=0A=
> =0A=
> =0A=
> Thanks,=0A=
> =0A=
> Changheun Lee=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
