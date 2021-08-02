Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FABC4338F
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 22:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E081960EB5
	for <linux-block@archiver.kernel.org>; Mon,  2 Aug 2021 22:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbhHBWwL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Aug 2021 18:52:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33646 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhHBWwL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Aug 2021 18:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1627944721; x=1659480721;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QjbHJVRUPIMxfXLjqGTbf1KPQwFYJdXoUVgTVrZc/cM=;
  b=coJcfVjLI/QlRndHCDHSBchWfdUYUEcvTTGhm82jUzlteRlwl0TgY9ks
   sYfEymnSsOX8SlN+zXxR2AHYaUljfo0T5ycua9ua14Mk1jmTWmh7i8DnP
   9jOQ5U446m9DM0NYW9mpkGrvPKWexe16QJjgSe1pODJWfjvz4Y4RXbLV+
   B7EX8NtEQDe9K29DnkOQ8d+VYiVORbNYaCY2lTsYaQ3HaQaTde9VnChEX
   P4sNsjUMWxavDVBzPxGJKCVnyrhe+iZmy4GC1i/d8zx/LvJ2HWEutKHxo
   ux2VQfOMpn6cmpNe0T1yUVkqla7QJPSPfTD7s+UrrbkXTvAsu26ZKB7X7
   A==;
X-IronPort-AV: E=Sophos;i="5.84,290,1620662400"; 
   d="scan'208";a="175350412"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2021 06:52:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWBE9IHrwD7PGU1mC0O8eZeB/kgVFJ+9H/pFw8Est2Tte4hnkhcN1WONMDiVIPpTKjWiT2Lc4cvMd73HCFoGRLXCW5S+07wVMzeAhkS2NFw011Qa39mZwJJvisOQwRHQK5IOjJdBlydg+WU4zUTpBhpe/2IdQ6kAAQsX9YTs9xYdWpziRxVqbAofSvA/58537kSkf8jkvXzzFq2jkDF3OhfziVoRtWDduW6NBuGl2IMOQEC/jIiAOw+tEK5F3BW3RSH2/sdbp36bx5ZV8A5JG4g8g9ctHF9NF1CnuB3Cjvz1l0dBB/n4OJkfFuw8uNRz9R/HaGdlG6GM3nBqPK+yTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njHfOo7ScKnGINgnfc3LflPPxzya2JQyEnx/iQjSMyk=;
 b=G80oUZVfd+DGd/eoNBxrEgr6ibq58liwbuRnYTuHC5lnXEQLIjXHPbt0/LqNwC91Q0Rx4X2RP2e3xtJUyqSguL55WIvWyjGDwDuPYCK31J1mzQdPH3f5Fjqf8AjNLrXbMOhEamtMmZuuBSTVltXTYC3RSpgZ/YxLzls16EYk3/+i7r/EOuVDwEo/ZUEWLUfhYpUNvhMnzDaKCFHOccGZ3JnP2XYWUAIlMbS336tZ3jeM35I7tf88eLkeV91+kolIZ1kxDkqatp3bB9IMUBlDxfG09XBy+hIQATh9oJMS6JEMttKVfKk5WvUhTqO4jbMTCkbbr98rhVoUvpqhDoI3ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njHfOo7ScKnGINgnfc3LflPPxzya2JQyEnx/iQjSMyk=;
 b=tiCJsMOqJWI7KweUGHiBoij6lMURGJnF5sN1UMIYnKplKMIu3l9XNprDCueUoCYXMOpZbJooABunLtHrQUjgtcthCRwdFf7ftAMz/yB3bzoGBeuaXubw+g+POBYWiT+uETnyO+rYCYDRyQRoeBV67qp/wvz30XX1PYOhpI7p7zg=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6777.namprd04.prod.outlook.com (2603:10b6:5:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Mon, 2 Aug
 2021 22:51:59 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::44e6:14cc:4aab:3028]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::44e6:14cc:4aab:3028%9]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 22:51:59 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH 2/3] block: fix ioprio interface
Thread-Topic: [PATCH 2/3] block: fix ioprio interface
Thread-Index: AQHXh3/dGCmgRHz54EyLUiPZnqeIWA==
Date:   Mon, 2 Aug 2021 22:51:59 +0000
Message-ID: <DM6PR04MB7081B9F0283D4D3C9EC5A19AE7EF9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210802092157.1260445-1-damien.lemoal@wdc.com>
 <20210802092157.1260445-3-damien.lemoal@wdc.com>
 <68044a9e-c268-79a0-f880-766cfc6e1f7f@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c08cd8e-7ee5-4f02-48d3-08d956082324
x-ms-traffictypediagnostic: DM6PR04MB6777:
x-microsoft-antispam-prvs: <DM6PR04MB6777624CF296205E637C491FE7EF9@DM6PR04MB6777.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qc4kIZF+HoRGVHzbcTD0X2U14VrA01Hq56eh3twLl/QqfM7+J2xmft7l7VIhQCznCHg1ZB5oxmq25U2gQsFFzMBuo8MbDZ3jR0hH0s9AS1ukEFICWTRRnBfAqafIZUCAJkikBqq+sB3QQGOfpvnILgQwDRbcgJP1PwUpyauW54XtfOwVmcVgF/j25bmAbKCDoijlpfK7w1mjt2Vy89pR6wp/Kz8O7e+QYYObZGemoa/mvT2+eCbGQUCehMgPSmcKtTOTEv1l9DTvmVSwnKbfo3McvZ54wyIBMBBTH5b/TkMixEGiYzQoE8sE0ZQ0yjLmqxy0aq+q5JwNXPD+ffLi2A7liv4OGK/vE5ZppF5QSBMPCoKMcFf13p+YfQLDyOTGCqleKnLPQef9Tz337fLheGie/C5G2a2vfSIBLLygPShkR0OeYDMlBa5qd+4PLYhdmH13FuFXDm8apu+X1iZOiBpsoezi1fv+59xYRolybVSjBWR/6w/qk8lCV1afkLXXzYK/AjH+b0QWFr8qWGoj+IQudbCOU48g4rOtplkQ54afyAgrLUy/qwegex5VoOA/TTe6igr88nrazZR1GnrDXo4spFvKRnbCivJe/VKj/2sH6HMQzLpKkSbgp6yv3EkCmX+SVBGzu61JNqkT9H3OniZRftCEZ7tSmu/RHnpCfUfS8SzT2FNuOgqLoK/ijud6F92EA5KpcPj+QQqetzuxgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(122000001)(66946007)(76116006)(91956017)(38100700002)(8676002)(86362001)(55016002)(6506007)(53546011)(7696005)(38070700005)(508600001)(186003)(316002)(66556008)(64756008)(66476007)(5660300002)(66446008)(8936002)(110136005)(9686003)(2906002)(71200400001)(26005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?skrdhoQ9Xus7zDrej6zlhheSlcy3IQrogWu9WFGLKQtxaVQfWXez9LVFT6Jr?=
 =?us-ascii?Q?iL9LS0U8EwJlJsTGxvR17kf9Eap9Yn4wbMWfOvXZQdO/W5J6e9zzI+do2u2e?=
 =?us-ascii?Q?p1DV/to2OsT/pXwPK371NwJakVmB0WQfTsrGD5m+wSK3MfDH/jgW9mpszKuH?=
 =?us-ascii?Q?43ZpWl907FVTvajdw9cMi+AHjfAMEJq1nuQPZ5S6UINwCh9f3vmhXfId25KW?=
 =?us-ascii?Q?b8HkLKBywwjY2xcvWPe/WgtTVUhq6qJzlu9G1JvIHB6awNKAy3g+BWOVng68?=
 =?us-ascii?Q?UrMvVPLbESVzVDFQAV+BofSLvCKNKdnGV21FmGc/QR7vzcrUAvxeVxpjVuAk?=
 =?us-ascii?Q?wAeYzk7kzUdXubsDJN+esRg56lNfQop8WKiV8U2rnHUi7WFAScsfkKFLH04r?=
 =?us-ascii?Q?h/GYCQafT61yfDnGjYNwzpOgbTpghOyzNLiSYz6l2f3ayNTPDd2hB1LSJEL0?=
 =?us-ascii?Q?5hadgTeySlUEIgJVAW0lOE0NHVV/osWPUFa/kh6rXImYR+9oKXlFRs0yB27z?=
 =?us-ascii?Q?yCJgj3Az1QvrkxIg9R+5nC0WNo5cbq8TEjy0r6yopRQY46a0SzV+uKcyiEO1?=
 =?us-ascii?Q?Y/nw+2JGydjDA7ZMpXz3vRsMmyb5fsgZx2HgCA+JSNXBff9mtU6vW2VTKuhw?=
 =?us-ascii?Q?F5SKYG7lea9C8Bgsf4OyVbLba9HpQsjrM27ckLYDyhTIfhcxrLZN409u5UbB?=
 =?us-ascii?Q?NJ0R4x2+IfBrxPljUluZR+KRtaL52r1hplJuqM45K3rSHkbnLfbBYBwg7LfO?=
 =?us-ascii?Q?J2nwjJfQhxHWlaogMNmhoYorwKVTGvLRHZIFwKLx4n/9p9j9Kweggk8D5/aK?=
 =?us-ascii?Q?dvxQc5JslGq8u1dqI6HMMkjvH303OPJ8ybwkqS35QHWGiR8K0k4ZyA8/0wUX?=
 =?us-ascii?Q?aIe+nPenoTnqkl49XhdAavJuLwMCD4N5+997XdPhShQ1NpyX4HOjJFX4TbDI?=
 =?us-ascii?Q?quE5cFVwAGyiBZ3bX+gUff/6nA2I3ugwqyP0F8Hf7UuuEtevc2gMsd6B84F2?=
 =?us-ascii?Q?lqxRA8iEteFbiPA/HAtW1J5/a71oQdCA5S3/VhecQ56fUJukgJRE09HIyg2T?=
 =?us-ascii?Q?FBr3chU4OJ8mmecJ7edKdFuomBVGd6RBFL6UYL66uWMxcPQh31Nmzlo5Q5t9?=
 =?us-ascii?Q?T8DS2iXspB+wa6OtG/vMeXNQfpaQe2B1QoREoovnobVza4uuJR/LHpTTVVJ9?=
 =?us-ascii?Q?9Yrl542I4pERzWO1hrF6aA7yXE/fktruO1Kl3N0QHqBvT4/17cMnzzio2On6?=
 =?us-ascii?Q?Tf3eucXuq3vsaPUmgt2y9FaiCBGx2uPuN8w/W5CxWhgKTxc2NuwwccS5hlr8?=
 =?us-ascii?Q?h9c04fahPK2up3gCvan9bFBpoJmuNha8TZliLLWE/KEaYw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c08cd8e-7ee5-4f02-48d3-08d956082324
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2021 22:51:59.8117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXchfrddCfosk8MCgnkg1HQT4KzkdwDjWdrWVN6NzhmNTCEQt5HMIckA51fwgPTxsnKuUreyv+LPTDOoCObaGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6777
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/08/03 0:58, Bart Van Assche wrote:=0A=
> On 8/2/21 2:21 AM, Damien Le Moal wrote:=0A=
>> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h=
=0A=
>> index 77b17e08b0da..27dc7fb0ba12 100644=0A=
>> --- a/include/uapi/linux/ioprio.h=0A=
>> +++ b/include/uapi/linux/ioprio.h=0A=
>> @@ -6,10 +6,12 @@=0A=
>>    * Gives us 8 prio classes with 13-bits of data for each class=0A=
>>    */=0A=
>>   #define IOPRIO_CLASS_SHIFT	(13)=0A=
>> +#define IOPRIO_CLASS_MASK	(0x07)=0A=
>>   #define IOPRIO_PRIO_MASK	((1UL << IOPRIO_CLASS_SHIFT) - 1)=0A=
>>   =0A=
>> -#define IOPRIO_PRIO_CLASS(mask)	((mask) >> IOPRIO_CLASS_SHIFT)=0A=
>> -#define IOPRIO_PRIO_DATA(mask)	((mask) & IOPRIO_PRIO_MASK)=0A=
>> +#define IOPRIO_PRIO_CLASS(val)	\=0A=
>> +	(((val) >> IOPRIO_CLASS_SHIFT) & IOPRIO_CLASS_MASK)=0A=
>> +#define IOPRIO_PRIO_DATA(val)	((val) & IOPRIO_PRIO_MASK)=0A=
>>   #define IOPRIO_PRIO_VALUE(class, data)	(((class) << IOPRIO_CLASS_SHIFT=
) | data)=0A=
>>   =0A=
>>   /*=0A=
>> @@ -23,9 +25,16 @@ enum {=0A=
>>   	IOPRIO_CLASS_RT,=0A=
>>   	IOPRIO_CLASS_BE,=0A=
>>   	IOPRIO_CLASS_IDLE,=0A=
>> +=0A=
>> +	IOPRIO_CLASS_MAX,=0A=
>>   };=0A=
>>   =0A=
>> -#define ioprio_valid(mask)	(IOPRIO_PRIO_CLASS((mask)) !=3D IOPRIO_CLASS=
_NONE)=0A=
>> +static inline bool ioprio_valid(unsigned short ioprio)=0A=
>> +{=0A=
>> +	unsigned short class =3D IOPRIO_PRIO_CLASS(ioprio);=0A=
>> +=0A=
>> +	return class > IOPRIO_CLASS_NONE && class < IOPRIO_CLASS_MAX;=0A=
>> +}=0A=
>>   =0A=
>>   /*=0A=
>>    * 8 best effort priority levels are supported=0A=
> =0A=
> Are there any plans to use ioprio_valid() in user space applications? If =
=0A=
> not, should this function perhaps be defined in a kernel-only header?=0A=
=0A=
Good point. I wondered the same. I think it may be better to leave that one=
 in=0A=
include/linux/ioprio.h instead of moving it to the uapi header.=0A=
=0A=
Jens,=0A=
=0A=
Thoughts ?=0A=
=0A=
> =0A=
> Thanks,=0A=
> =0A=
> Bart.=0A=
> =0A=
> =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
