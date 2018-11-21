Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F101C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 02:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE41F21104
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 02:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hBqe6Na4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ei97vqHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE41F21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeKUNWe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 08:22:34 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7792 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbeKUNWd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 08:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542768611; x=1574304611;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=s/tyhDklZtzxVQFjedlOrzWBaINHZbgVZlCBP8gfncQ=;
  b=hBqe6Na40WGzaFmf0bpVzJf60LgSbeMjveLZhVcfm72r4fzGdTk/d98B
   0yB5r3qXixzEaD37/ExQQj/WbTYBKjCqx9vD6ltG3D9eNMjZbREOLRqJ8
   5dwZmJtXYm8nC1Am5RckC1graRjHN/k3BgOWQPeTnr4DeNcn0mktRa9vZ
   uxjt81imPn1Tkhwhhlrjax8ItY/Mo07rk4o5EKWukY+iFGXLeuoLw6age
   eHTYqa6bbw+aIKcj0w8icrOPQxrjY+zVrA6AG73LYH2yJz9q0n+Ll7XXe
   CZXfWJS0xXg9sBJu1/naKVFdqjKC0N7OX4GI4o+PFvEUJkgfup30kDR8S
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,259,1539619200"; 
   d="scan'208";a="94760860"
Received: from mail-by2nam03lp0047.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([216.32.180.47])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2018 10:50:10 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FcLxhYXlMwBFyERO5pDRVYOSbM43mIPZ7RHJRnue3s=;
 b=ei97vqHkwOyrBOkTz3QcCHTDXJuj5Y75PYZsPc2euTbxAxY5F5baCffNqvg5a65zLwtNuKASXQh34npNn6o+ozyIFnUxDkKhQINO2axyIvfeQRq0LkOLKl6DiuXtWUKCXosNGDaoJWyZRO3mM0U1DpGdiUaNp/5ODiHAn9t9biY=
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com (10.163.41.30) by
 BN3PR0401MB1511.namprd04.prod.outlook.com (10.163.38.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.21; Wed, 21 Nov 2018 02:50:05 +0000
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164]) by BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164%5]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 02:50:05 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/7] block: Remove bio->bi_ioc
Thread-Topic: [PATCH 2/7] block: Remove bio->bi_ioc
Thread-Index: AQHUf7tEoRMSe3tInEucKAoqKOcuBg==
Date:   Wed, 21 Nov 2018 02:50:05 +0000
Message-ID: <BN3PR0401MB1640DB79C564E859FDE82A2BE7DA0@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
 <20181119035131.11255-3-damien.lemoal@wdc.com>
 <20181120172126.GA28169@ming.t460p>
 <c132f449-b45f-aab8-1b57-1a45e43d22f4@kernel.dk>
 <BN3PR0401MB164000EE62FE6BFF2ABE0069E7D90@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <68806243-0094-5cbb-39fe-cea697f40b1c@kernel.dk>
 <BN3PR0401MB1640389B8B28086F0185CE2EE7DA0@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <9d7f5e60-f2cb-e257-95c0-61ec117304b2@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0401MB1511;6:QlQ6VbqdpbK+LA9AN23HnGWTSSe6yHl/21Lzz8BUKIjcr40+Mq2r+bLPgKlsSCZJYHQhA8omAlTOMM6WisB1RhcVBaysNseMOf7845tT9LCjnz1c/QmkQeScc8FYVfCGfDCRgsAtk/u6/LDo4pfHikVwgcJ4XZ+O0o1fEbCt+95CJMHDiHi7pmiH8mfIX/Rx3qcAvhecWLh9sZpopqwXKZimmsjD256MrEgi5rlQIpE5sup919hcfBqdIoKBASJ6LU8jsZAMEEHVKtaOkJMAW/PhleMlZaAnFNaOlznF7TRE4/uP5v1NUyfHHzMxV3CYx3jcWzOC/wByhsIqSaNKJFvPaF6BP+F6a4P/k+u5XmArxSo8mc20f1BK1aDeZsfg4nX6PI/UL8lNgbEqyjK2IWJktP1X3X8QMppe42m+1rIiq+kNQTxijGaXOUzEaoKpgcwq6CkhrVJINnNL3to3sg==;5:691LmICEXo+TqFwyWgGFP2thOYi9qnrm97CsIMaGSV7p+5BOTLll3bzYjSoPnlb3mYhMJha+HMv6/jTwK6jBMTEWsRgNPPqutq4HJrzWehhadwgOT2bdznRATq928+A+exsxO0yrC2Xz96Fbg8Qg31hJu39QQ+vuHfKuAu+w7cw=;7:ItFpJq0Ekr1NAibHK8G+BG03Wwfr2CuFBkU6IP/LvZYBIqcGR+UOD+anC6aHctNM50QCsSkBVVdtI04s8VdCpF3bxQYEJCJzwTvK60U68G+EyjS3hdSyf44mvREctA9bbgzBdEy6exzicLEHw/WMMg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: cee0602f-a13c-4636-ea58-08d64f5c0ac8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN3PR0401MB1511;
x-ms-traffictypediagnostic: BN3PR0401MB1511:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR0401MB1511E6966A3C00FF9DF0FF7BE7DA0@BN3PR0401MB1511.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231442)(944501410)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN3PR0401MB1511;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0401MB1511;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(346002)(396003)(376002)(189003)(199004)(110136005)(54906003)(305945005)(7736002)(316002)(74316002)(102836004)(7696005)(6506007)(76176011)(53546011)(99286004)(68736007)(93886005)(72206003)(8676002)(5660300001)(14454004)(81156014)(81166006)(8936002)(2906002)(105586002)(106356001)(86362001)(4326008)(9686003)(25786009)(14444005)(229853002)(446003)(476003)(6116002)(97736004)(478600001)(3846002)(6246003)(53936002)(186003)(66066001)(2900100001)(71200400001)(256004)(26005)(486006)(55016002)(6436002)(71190400001)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0401MB1511;H:BN3PR0401MB1640.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: No0j9sWY8Xl2OkPbZZE9yiV8xH5Uiax9n5EnNUefQrfXYRUW/rlcymt4ESgoXX+5k+heOMxluEsfmpYEBJLElT1R28NV16MljfUDi9j3PQbr6noZuiDXpKLgG//hT7RDdDRI/q6UNMlqpXvYeAr5kCMzY6qi6pPgmNsA92vNMlJfbqZtqA9W5haYuWpu99K0kMoMzcdJJgDJo8Bie4tWtrbpSDBOvGr3xGAptyi+XzIpM19k3/YKRpgq8z2H98izE1qE4TTG2MugMTT47pN+15zGMldeziMMAfxfvhRFvsS3f4FLaue65EiNHSgS4cVWwkgaZ3qcqQyNHR+ppTpeWNWr1MzAt8+bj/pqotWZYew=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee0602f-a13c-4636-ea58-08d64f5c0ac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 02:50:05.5618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0401MB1511
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2018/11/21 11:49, Jens Axboe wrote:=0A=
> On 11/20/18 7:45 PM, Damien Le Moal wrote:=0A=
>> On 2018/11/21 11:11, Jens Axboe wrote:=0A=
>>> On 11/20/18 4:58 PM, Damien Le Moal wrote:=0A=
>>>> On 2018/11/21 2:31, Jens Axboe wrote:=0A=
>>>>> I think the below should fix it, we haven't necessarily setup an=0A=
>>>>> ioc if we're just doing as passthrough request.=0A=
>>>>>=0A=
>>>>>=0A=
>>>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c=0A=
>>>>> index 13b8dc332541..f096d8989773 100644=0A=
>>>>> --- a/block/blk-mq-sched.c=0A=
>>>>> +++ b/block/blk-mq-sched.c=0A=
>>>>> @@ -34,9 +34,16 @@ EXPORT_SYMBOL_GPL(blk_mq_sched_free_hctx_data);=0A=
>>>>>  void blk_mq_sched_assign_ioc(struct request *rq)=0A=
>>>>>  {=0A=
>>>>>  	struct request_queue *q =3D rq->q;=0A=
>>>>> -	struct io_context *ioc =3D current->io_context;=0A=
>>>>> +	struct io_context *ioc;=0A=
>>>>>  	struct io_cq *icq;=0A=
>>>>>  =0A=
>>>>> +	/*=0A=
>>>>> +	 * May not have an IO context if it's a passthrough request=0A=
>>>>> +	 */=0A=
>>>>> +	ioc =3D current->io_context;=0A=
>>>>> +	if (!ioc)=0A=
>>>>> +		return;=0A=
>>>>> +=0A=
>>>>>  	spin_lock_irq(&q->queue_lock);=0A=
>>>>>  	icq =3D ioc_lookup_icq(ioc, q);=0A=
>>>>>  	spin_unlock_irq(&q->queue_lock);=0A=
>>>>=0A=
>>>> This seems reasonable to me, but I wonder why this problem was not tri=
ggering=0A=
>>>> before. The previous code getting the ioc with the rq_ioc(bio) call wa=
s=0A=
>>>> essentially the same and there was no "if (!ioc) return;" in=0A=
>>>> blk_mq_sched_assign_ioc() before the patch.=0A=
>>>> Any idea why this is popping up now ?=0A=
>>>>=0A=
>>>> Ming,=0A=
>>>>=0A=
>>>> Is this a new test your are running ? If this same problem triggers on=
 stable=0A=
>>>> kernels, Jens patch needs to go to stable too.=0A=
>>>=0A=
>>> No, it's definitely introduced in your patches:=0A=
>>>=0A=
>>> -                       if (e->type->icq_cache && rq_ioc(bio))=0A=
>>> -                               blk_mq_sched_assign_ioc(rq, bio);=0A=
>>> +                       if (e->type->icq_cache)=0A=
>>> +                               blk_mq_sched_assign_ioc(rq);=0A=
>>>=0A=
>>> Please run blktests on a series. Always. There's no excuse not to.=0A=
>>=0A=
>> By the way, should I send an updated patch 2 to include your fix ?=0A=
>> Or will you add an incremental fix ?=0A=
> =0A=
> I had to add the incremental fix, I already merged your patches=0A=
> earlier. It's all pushed out now.=0A=
=0A=
Thank you.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
