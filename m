Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EF8C11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 21:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4049661474
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 21:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhF3V7g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 17:59:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:18241 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbhF3V7g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 17:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625090225; x=1656626225;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=C872W2AuYXSR2//da74rW15u4jn5IldapRlt/c3Zl5I=;
  b=LNaCrfN83IHVRwefLeaW0JN6oOGKO010k1Ciff3Xd5CVwznrTCtp9Fex
   UsA8fUk7jvxv7VhJJFYIP+tJ7ZkxKJPNx8h6agDFdKwTXMxUPB7ayz8t6
   zUlymshImW8z60b+jcAUDTRIRdL9IAyont5OtbUF5XzajbdcroIMjG+Bc
   20zSYOSz2rISaYqKCw7UvNLOwo9tEPPAt9STKtjQMgFif5eJoRGfihNFl
   TRQru3wzmXqw95XjUjh9t7Qc0HO7ldFE7TlXBH3wMMKBan3+8KLkVyAG5
   HmRxXIO4y3NzFpW+nMtx88Y/FekDdZTgDyTrd0AzQsJgv+UZe7DE8M2Jr
   Q==;
IronPort-SDR: wCqkYi604dENsDjsTmKzoWhmZMLyeDBFw79eY18kH/I/aOKe4YBT5Zvpdc7ZmCxSMRmFf8GC+2
 mxCSPnHbJ3jha1ysEHEqNeB0RVqMrLW498G/9PZtioexImhOu5khEqut+VKiyC363aPnyIdbs0
 +Vw6sB6bnpdsgYdllzktG3e7proa/JlwBJRSsIi08NiIgEU5kIKi1fr0i0QV57yb0qa2D3c+M0
 U8PomSSuSb4lhK670omNszuiIiGCJf/KrR734oeCfbUWkLWHIdwHNs0UBjIntBowr4DfLyO3Vm
 Dqo=
X-IronPort-AV: E=Sophos;i="5.83,312,1616428800"; 
   d="scan'208";a="178171326"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2021 05:57:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBqWO+Eld9WP3EudfAHVyOWTYwbkwxScUYqN2L99gJZvH9RqOg3Cj3vkgd+ipEB9sKHJfwlXnXJbG3qsPbzrGAjOau8po+8MoDFFt2UVQ0MpeC62/l2tr7UiecCw3X3f8Mem5M0BW/vzbWtVB3lGXZ3iJ5NxdydNJrbFqS11BYcSv5X3e45ur7FlxEyuDRHv6obknEhhzEuCnJy1bPU4jpSwAuswp3/XhfxWP81i6APZ9x7uXCygdw6Dq2iYeQQtVHSkZfeUgdLMqhMlPHz2TMp6+Ajds8NImXGJoLEd/P7SdTbROGVOZmPoINidVAzmhqW+Gzy+QmLHaI3euHScrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7OD9fcvTBiZJeUYMSMcVQcOYHt2cM+XrWGc/pS+qlQ=;
 b=SGt/RZrJ5MLvtzr20pISmI0bXP3ocuND8RIi2vP02So7apwMjoGwRRRD9dLnsjwF7yKr9cmRO+0eZ+Y9C56J0GFF4sJdUf0jI/X6ct1pXCiFRGTPfujvtLL1s9Ngu70k+/4Ani1LMgWLPj+eW3Hq+ZvwXQCRqLyL7/sm8kSnGd075SGZVQSU7zV63o58/VAj61CPQiEMSa/GjEIy/IbginjSJZgRv+IE6lz41QumEPqIEUJ4zmXQVgrAT5bcKfVAZ6TAfNM/3p60I9PJyJP6GPvASnuH4WYUkdzJWDCtrlwBl0esbUsnn6nIhsi5VC1jUwzfU96+rR7/Tk9zXUlldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7OD9fcvTBiZJeUYMSMcVQcOYHt2cM+XrWGc/pS+qlQ=;
 b=lkN6l+BettuB4ReIvxw+bCiC43TeXAdYTvDJIGYfLnzQ7K/bkpAWRoJLj8Mm/UWvxQ2lE2KmYTSIS2G/FX4BWrMteF8tHbLHSTiEga0pq0gBOakD9bKC1zjtUxmLifDqJrqBPh7uEoGLqk9gTzKMWKGDbbvVC7ZqeIwB+Xu3EMI=
Received: from CH2PR04MB7078.namprd04.prod.outlook.com (2603:10b6:610:98::9)
 by CH2PR04MB6776.namprd04.prod.outlook.com (2603:10b6:610:93::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 21:57:05 +0000
Received: from CH2PR04MB7078.namprd04.prod.outlook.com
 ([fe80::752e:44a9:8d23:9f6]) by CH2PR04MB7078.namprd04.prod.outlook.com
 ([fe80::752e:44a9:8d23:9f6%3]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 21:57:05 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
CC:     Daniel Wagner <dwagner@suse.de>, Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't use
 managed irq
Thread-Topic: [PATCH 1/2] blk-mq: not deactivate hctx if the device doesn't
 use managed irq
Thread-Index: AQHXbLtuHkNoWHYc2kOLK+PDH01yww==
Date:   Wed, 30 Jun 2021 21:57:05 +0000
Message-ID: <CH2PR04MB70781FC64AC0621F7E55B408E7019@CH2PR04MB7078.namprd04.prod.outlook.com>
References: <20210629074951.1981284-1-ming.lei@redhat.com>
 <20210629074951.1981284-2-ming.lei@redhat.com>
 <DM6PR04MB70814885C27FF97CFC02A456E7029@DM6PR04MB7081.namprd04.prod.outlook.com>
 <0f8be11b-c6de-1c2b-323b-1e059c2ac4f8@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f1c6:7d03:7c7b:49e2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 853dfe03-57e0-44a8-d62e-08d93c11ffcb
x-ms-traffictypediagnostic: CH2PR04MB6776:
x-microsoft-antispam-prvs: <CH2PR04MB6776DE2051CCFA26D7BDC58BE7019@CH2PR04MB6776.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uiXtTu6PRDW0tBpMrzSVt3mGfHbYPz4eO/KLBjJkPZ6uoND4Kzf556BJr/LxfvYDfM/pxSxqDyWEAWx7PH+QyJAzPsfy4jPKVqxZ/7gycnPf9LvZj0nXsC2VtjiRuuTDAR6kaOp7BOsnuCDUJQC6mo5tPXgKgVWRttyILnqUm+/sHuc2QpKMhjD52cF63MJRvgD3nkgrY/rySjmI7d+5SEkA5P4LRb92b9qnqadGT0eJ5R1dXgDpcG+5ICHbYWhAsBP3cd15Xsmi7KPuEucIBJGrehRH6q9LYA1h6ReiES/ZUkBmh2zamI6TSTuYjgybi6n618QFIr/7ZNn1cy4321tCeuw0YEVyjl4o9N0xai5W4oPiwN7CgS2VkIASBGINtrGBHzN7OQAQdvZeb4rZ9Pc8nV8YjU6/hi5UrdHWagDJvLSA1NvZSxCXwpzb3VKTaRoxZqh+N2+O4cOhwvpxv+oPQjff5Pe6xEXhESTvRd3QOevhFmE/hi1zuW3WWYqK5OzgjTz14SW2+Y4XY3Q89fQIeGQ8M1eMYWBd9q4EgXbTG4pZFQPirem0KmpzrJpW7x4J9kRX+GTaGgxsE/UUJIls83DOLmTmToPrei64To05TwFDcXZiTG7ZDIZQHha48Nl9pvRiy5XUrco0Mr8Hbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB7078.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(64756008)(38100700002)(478600001)(316002)(7696005)(66476007)(54906003)(33656002)(66446008)(6506007)(66556008)(110136005)(122000001)(66946007)(8936002)(52536014)(5660300002)(53546011)(55016002)(4326008)(9686003)(2906002)(86362001)(76116006)(91956017)(186003)(8676002)(71200400001)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J5jK6yVEGR6SEX0W+hp1ydAZZvStTiR91bpYi9/5wN+RMAaEovd/EVfiE+2i?=
 =?us-ascii?Q?wyrPOqFjXdGeu/TtVSsWGzRhX2z6fpxZjeevHl74IRbBRU03z+a76+o2jKdK?=
 =?us-ascii?Q?QAaB5BB7kbOLZ87y34QTRFY6ZuN2MMJqZp7EbX5U/6DRdlGB5FZgmf+p4VX5?=
 =?us-ascii?Q?v+EChOo09cn74wEm0uv9s51/1JeKCClrfqSmX2F5maFXX6+8Kr+pBAVsAkmH?=
 =?us-ascii?Q?mYKBaXJ3LiEfFmdyo7I8vZRMFetBtK2mXB6dY1Y6VZvWRRNDPGB/KvzLOXkW?=
 =?us-ascii?Q?iYqy2hvoKHIgIMd45P9RpsG3khLEJdF1pPXiCtIbdREh+hXBUbmz1GYXDNN0?=
 =?us-ascii?Q?QPqPb6KI72q3LNffjYbZkfes+ZXyaBGoWhO/MiMLBxaBYQRc6dyqHB0mlezP?=
 =?us-ascii?Q?6pUPr3HQER8sJST9sHSRnrERUoOKobTtK5cjBMHefPe7WBTtW/rM8vvfiqrW?=
 =?us-ascii?Q?2sq7JsWBVoFAbdvGfXl1joJj0WroNxT7Ep6vy8BenPRHpcdYDtksS4UZlcgo?=
 =?us-ascii?Q?CXz9LxcItwyBSghsEpVfq1O8jQZ854MTBThn5bk8a3TFYpQsOwQcfTU2vHqt?=
 =?us-ascii?Q?wjfym0AeaoiWacVALzqfQH/OJIg0p0Jc5R9ugdZVOzsa4qh0XVJcLqf5lsoA?=
 =?us-ascii?Q?tc13u8U1YygQhALEFxo5Mr1pi8I/HFS7Nry6LGWSagfs/Q20Qxdrp2jlWk+n?=
 =?us-ascii?Q?j7j3n/jdKVP6MbCNl5E7fp85k+PDVN5mJbPmepp4W8ZemX7+vd6xTKj7Ajra?=
 =?us-ascii?Q?DLDuwRrzTJhrcjp3gJ3vxT3Z0cYIrSijfhF6sZcuDoXqCi81FJnNmb/jX+Xa?=
 =?us-ascii?Q?hH4pck34gnmwOHPGZsyIb2ijMi803Ayklk+6prsOpk/dL0DGoG6LqJQq95iC?=
 =?us-ascii?Q?NDyt0UGsHz19/mvFiPn4KWCFbCMlxEIEKMKpg5BHyEwAvN4XvQGpuhK57S3g?=
 =?us-ascii?Q?MMluDU6DdVH9X/Bzcio/RAY3gA4FVbk+1XhVGrR6UEDnbYJ08QZ3QkuyXYVD?=
 =?us-ascii?Q?I6hmf9IykMVBN5Iz+ePMEdb9hM3gAXyPBBn3wnSkDVQUeizJ2aZu+GIBz3bD?=
 =?us-ascii?Q?34a+RCX4PfcvCXcv0vw01gw9JxYAOewmKdZWe63UvCt28+Xa6B9Ge4ULUvCR?=
 =?us-ascii?Q?DtAtkb+YbesAOTsykgh/rFFfyrDAfxEUfaCf8ddkcnfQBOh0iWTDooHb25by?=
 =?us-ascii?Q?CGCKswKJnNYUZntn27fLma8Ah4kB7xSxYlVZ5f/Oy03IlMre3ZtmbVflAowp?=
 =?us-ascii?Q?uh/ITkkHnE018FyRdL7xWus5LF5HT9+HAcndLyFVzzhDPWRGHktgrj5iSd5e?=
 =?us-ascii?Q?rQMnmVB0PYW2TYZ7a1aPmwpTIO5tGZQH2ntisx5yrl8gd+FGTRQ41cSWPWtw?=
 =?us-ascii?Q?gIXhrZCW1inIU0pe60re3dSBPIAFA1JWfTo5lgBDmOf+6m+uEA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB7078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853dfe03-57e0-44a8-d62e-08d93c11ffcb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 21:57:05.2110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6sUzJhNZ+pMCn44B1eW+FFKUtukgp5H5/PrPk3zcU6oH2dP49KNgARJ59X+eSdBItXuqJk0lUmAlpJ9qntMKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6776
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/07/01 3:58, Sagi Grimberg wrote:=0A=
> =0A=
>>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h=0A=
>>> index 21140132a30d..600c5dd1a069 100644=0A=
>>> --- a/include/linux/blk-mq.h=0A=
>>> +++ b/include/linux/blk-mq.h=0A=
>>> @@ -403,6 +403,7 @@ enum {=0A=
>>>   	 */=0A=
>>>   	BLK_MQ_F_STACKING	=3D 1 << 2,=0A=
>>>   	BLK_MQ_F_TAG_HCTX_SHARED =3D 1 << 3,=0A=
>>> +	BLK_MQ_F_NOT_USE_MANAGED_IRQ =3D 1 << 4,=0A=
>>=0A=
>> My 2 cents: BLK_MQ_F_NO_MANAGED_IRQ may be a better/shorter name.=0A=
> =0A=
> Maybe BLK_MQ_F_UNMANAGED_IRQ?=0A=
=0A=
Even better :)=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
