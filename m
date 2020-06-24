Return-Path: <SRS0=vHgh=AF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E5EC433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 22:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C867320C09
	for <linux-block@archiver.kernel.org>; Wed, 24 Jun 2020 22:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rBBftV9S";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="E0Avt7uG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389143AbgFXWpI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:45:08 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:19208 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732832AbgFXWpF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jun 2020 18:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593038705; x=1624574705;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kR1zPCtvRTb8QwSRy3RVvMLbXTiVpAC8xFH9Gjvkdec=;
  b=rBBftV9SUW3D1T0ABW32umGx2ahsqWE88LCxwAvkNz6b6apBjT4qvt+J
   rMoHbYt/bHwe/oTF7leBaPVI8k9GfENlWI1RnhWf7Dnx5vJMx96si2Umz
   USWN7V7S+P+eI7CmJFyGbGLB1uNMn5anH3DR2JvZB+OGP5zFeqf2BK606
   tjcRI19OIJ4xk+Gp3qi3WMtN6+eSJMAH8IZ8UGQ1ZeEeHiUzFgWM/lVpy
   2kgn4TVXiaDlhYzAME8EELoOL+VAq0QRBQRzZHPaD2eDI8u6vnwP9f4/h
   3JduqS1c7dz3WwVOQj/dohaRI/KfKUViwZPR48DYfeibLOm34p8xeWRfV
   w==;
IronPort-SDR: 74PQLI+uqz1xA0twDFY5nrzAQSFh8pJUpSNUYaLI6cuJFaneeG55E6nljBHR9vqsRx9ZT+jdX8
 uzbgplUjnEl1e2cXlwWtZ4L9OnsV4VSwY2wP8zYobDuAwfmNeSddwKPTZ6w4FlhxkofgYP/36e
 361Jzw5DcIQ83l2Nm/vNzN9mivm8uqvBfxDY6QeL3RmxOGGuefm0Ug/n0IssmqggBfXoQRJKA7
 /weN1UwQVueUkvz3FPq1WLzghC3gv3wXbMKFmlNMiIOLIUwgapsmPrRPxKmWsZoROGpIXLaqps
 Qx4=
X-IronPort-AV: E=Sophos;i="5.75,276,1589212800"; 
   d="scan'208";a="141083698"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2020 06:45:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gY+XQ45Hg62+HfK1ysy9is925KGVdwvQG/c3gMrM06Drg19LvJ0rQwBZsRUbAof4Kd2AQQLc3qVejANZ257ux6mcND8K0nitw3CSNGXt0OQJS71pqzAlp4ZzPLNyS3qNNBy1O1Je6zpiqKHnVrpysCLr6y7oHrl1Vwaim9DqngnwKal0FBwhaHiGBjDfmA4MebyCoGSF6No7uDdAz8OPsI8Zfg+UqSoQtcwy7bl0qggspklwfQBcE9lRHE2z75pgRPfoCZu1kY2uPTsa5nR5+SfiY9Wyo6ReB/f0hjP55ikKyiInNudpHmcnxNSZA2jPE4+7AZTi9sqQMTHnimi5FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7Vv79/MNCgxDNDUWoUZZfSGk6/yKOjKVwNM85htwdM=;
 b=bZb36d9fj7Un3/9Rmv5ZFUJw+ANh012Xnv7NA+tqQg+E9XXW4DW2e6sWQo0aMCNO52AlHCjLeOOTtCubxSX4GMEUDThwr4g0BTNf5U3m/w5r/8qz1mDC/AJi6B+GAWJn2Hq+lu2Og4RAmkjJBd4tkkDFy+n/JdoFvf9pc5VfbgOYSk+E9QaoTjuR9KT/BmjYkw/NuPT16MiNkMYj24eM+IE72xedif3xILD5jGm4Sk2W80CJWWn4Voj6dTHPIFfgqN+SJ70+L9qDJQWTeZLyZm59w8cYZivOffP9HYGOBETwPt9xCKM/QRooWQJ/HL3oFrtXiVd2y6X6vF0YK/L0FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7Vv79/MNCgxDNDUWoUZZfSGk6/yKOjKVwNM85htwdM=;
 b=E0Avt7uGBTBW68pun5R1JmyF0SCeaoShvbYCeYFxzP4qwlc20QPcaVnORKN0KXXgaHblfv/hc4i7dI1BNIqoBhubpI7HEnGPeslOlNskRtLvf9AKhDCXFIaw7u/KaVzPrrKRxQ2qWULWat1RXBaLB+cjUCZw6hLgdgWs3drXong=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5688.namprd04.prod.outlook.com (2603:10b6:a03:104::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 24 Jun
 2020 22:45:02 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 22:45:02 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: Re: [PATCH RFC] block: blktrace framework cleanup
Thread-Topic: [PATCH RFC] block: blktrace framework cleanup
Thread-Index: AQHWSdd4UnyRRkLaf0OG0GWCqlwTUQ==
Date:   Wed, 24 Jun 2020 22:45:02 +0000
Message-ID: <BYAPR04MB49653212CE32249C65C0A7F486950@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200624032752.4177-1-chaitanya.kulkarni@wdc.com>
 <20200624064820.GA17964@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2da5678c-a5a1-4c07-896a-08d818903bbc
x-ms-traffictypediagnostic: BYAPR04MB5688:
x-microsoft-antispam-prvs: <BYAPR04MB5688F1049F95C98C268A176A86950@BYAPR04MB5688.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j+4MxcY8WnjKsKUmBlapaUWawqEinfy/gEFO/vNGPDPwD/kP7uu14AqUgbWYf2eX31WSRDF/EO+6+7uKn0pjGWX8LhR+0x92EgWlborF8GUtsi7A4oaN0MCE8Ql4H1wfhPUrnTodW1B5LDkUPh8YxzVzKwS13C85bMDLKq/3I/ErLL8txTEBAJiKwlsZdI6mQ/hU619q2gHsqWmQzNZc7JeNyv5X4Wk3Vva4ANCI1UZbc4iKuLjjfrtlegt9ofM4vMOQhe3/byglQSqFv5+eOqeVZ/mQu6ED0ioRmdeEmapEuElrK75C72PFNuQNeCLyzQ4+SDwg1qi0r8akcSD7aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(52536014)(6506007)(53546011)(6916009)(186003)(86362001)(76116006)(5660300002)(66946007)(83380400001)(26005)(7416002)(66476007)(66556008)(2906002)(33656002)(64756008)(478600001)(66446008)(4326008)(8936002)(8676002)(9686003)(54906003)(55016002)(7696005)(71200400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xRH6Hl8/x2ZZfWilyMV6N26FwonUzrqzknUQKEb3Roqkv7brqIg05UlRFM+Aqq8WSECPQJz00mbEBBEq8ZEDMvX0m42WlqgEIRgvmQ5mTT3MNrOa/DEoo2kcY8LrPdRCswFsMoZsoKYXv3gW/4noY7dhqNLodxGHpx/bN1+MRCcqoNWKvoRPaPICZbMxtBG8TPxf1H8HEn4XuZeDu5C6uddcghlTn3kLjHE6z4VZuOGuq1YolmCPcyowiC2+cmm4h0hidOTtZwlkWYFv8xHZPcP8KYzJmUcQ2t+xEgVkic3/Ew6SEC1uOshqTemDUEFy5MUqPHevbI+7SHQYkuY58frr/2bJXIgHvcIXN9YOir4U+oSmezCxozPCtRLC9ycxyEdNdgRwFcaOJnJudihbcTEl0GX4ola+HVZjA9gPl4eHRBpJjZ9fe4rXTNgb3BWs3lseHhaoyN5nrO3lWHZJDd4usYGiT3NvBp+980PrjHA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da5678c-a5a1-4c07-896a-08d818903bbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 22:45:02.7545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tTyo8GSALl26+0AKJVSJs4rKDBoz9rSaWieJTbPZS39R8+uKq/9ivDr1ObZk+HasXQP/YByN3KaH9i9zwiABF9nJBi2ZNzrAHZXP+4jrA+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5688
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/20 11:48 PM, Christoph Hellwig wrote:=0A=
> =0A=
> =0A=
> On Tue, Jun 23, 2020 at 08:27:52PM -0700, Chaitanya Kulkarni wrote:=0A=
>> There are many places where trace API accepts the struct request_queue*=
=0A=
>> parameter which can be derived from other function parameters.=0A=
>>=0A=
>> This patch removes the struct request queue parameter from the=0A=
>> blktrace framework and adjusts the tracepoints definition and usage=0A=
>> along with the tracing API itself.=0A=
> =0A=
> Good idea, and I had a half-ready patch for this already as well.=0A=
> =0A=
Well, I sent out the reply to your suggestion didn't get any response so =
=0A=
I decided to send a patch, if you want we can merge it I'll keep you as =0A=
an author for the right reasons.=0A=
> One issue, and two extra requests below:=0A=
> =0A=
> =0A=
>>   	if (bio->bi_disk && bio_flagged(bio, BIO_TRACE_COMPLETION)) {=0A=
>> -		trace_block_bio_complete(bio->bi_disk->queue, bio);=0A=
>> +		trace_block_bio_complete(bio);=0A=
> =0A=
> This one can also be called for a different queue than=0A=
> bio->bi_disk->queue, so for this one particular tracepoint we'll need=0A=
> to keep the request_queue argument.=0A=
> =0A=
Yes, we should.=0A=
>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c=0A=
>> index fdcc2c1dd178..a3cade16ef80 100644=0A=
>> --- a/block/blk-mq-sched.c=0A=
>> +++ b/block/blk-mq-sched.c=0A=
>> @@ -409,7 +409,7 @@ EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);=0A=
>>   =0A=
>>   void blk_mq_sched_request_inserted(struct request *rq)=0A=
>>   {=0A=
>> -	trace_block_rq_insert(rq->q, rq);=0A=
>> +	trace_block_rq_insert(rq);=0A=
>>   }=0A=
>>   EXPORT_SYMBOL_GPL(blk_mq_sched_request_inserted);=0A=
> =0A=
> As a follow on patch we should also remove this function.=0A=
> =0A=
Okay will make it is a 2nd patch.=0A=
>>   	}=0A=
>>   =0A=
>>   	spin_lock(&ctx->lock);=0A=
>> @@ -2111,7 +2111,7 @@ blk_qc_t blk_mq_make_request(struct request_queue =
*q, struct bio *bio)=0A=
>>   		goto queue_exit;=0A=
>>   	}=0A=
>>   =0A=
>> -	trace_block_getrq(q, bio, bio->bi_opf);=0A=
>> +	trace_block_getrq(bio, bio->bi_opf);=0A=
> =0A=
> The second argument can be removed as well.  Maybe as another patch.=0A=
Okay I'll make it in a 3rd patch.=0A=
> =0A=
=0A=
