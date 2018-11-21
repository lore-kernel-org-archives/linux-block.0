Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB05C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 02:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7D32146D
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 02:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qEbLaheP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oAMz6RAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD7D32146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeKUNSU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 08:18:20 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:7512 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeKUNSU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 08:18:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542768358; x=1574304358;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3RkKfJCxaPT2ateM8EW/ZPH+vEYO5IylT5QxnwHVNIc=;
  b=qEbLahePsLUpE2ItNO9VLollS3w1tqw//we6GDIvYPVtETYf4CdWkS9u
   sC4AI/PJqwjRKu2lq7AYrlJPpRwYwglaD38nEQBKt8G2/AuF7M/N4rBDn
   SvYtvhmTh1siyJye8qy2RUkb/Y0SqD870tCezQ5nyo5QQMPmc7+YEA0/j
   dwXgwRNirucCAVEpxrYWI6xTnq++1Og0r+l9rX70/XYYVYSJqAyb2ftUf
   puendisSe8IKn3GcFU6/VPh0xesqHgrSFnGylKUJmIlJtw7x7ubff2fSp
   jH0MdA04c0lHQwEO/F8LerUdHNy7X1UYfbkSZUMDG00av84aVWKdDWwWO
   w==;
X-IronPort-AV: E=Sophos;i="5.56,259,1539619200"; 
   d="scan'208";a="94760507"
Received: from mail-sn1nam01lp0120.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([207.46.163.120])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2018 10:45:55 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgJsyUoZ21erW9F5vyCsHMEY4/0IVfXCBwZMePw1DiM=;
 b=oAMz6RAWyxXzyvOyBBbWZFIPigXhxcM9rOLVl3IKYE5ZCcBIRPoadFriQp7tSn5qQu+PNNivOn3U1dxC0I9jPQPN5N2ScyUSCSWFUaH2EGkvjSZUIYVmhLbWo8YdJPiVNmpEO7GLizIiNp5cR3ko1tCXHxvGKM1M+x6LxOOeaUc=
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com (10.163.41.30) by
 BN3PR0401MB1345.namprd04.prod.outlook.com (10.161.208.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Wed, 21 Nov 2018 02:45:53 +0000
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164]) by BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164%5]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 02:45:53 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/7] block: Remove bio->bi_ioc
Thread-Topic: [PATCH 2/7] block: Remove bio->bi_ioc
Thread-Index: AQHUf7tEoRMSe3tInEucKAoqKOcuBg==
Date:   Wed, 21 Nov 2018 02:45:53 +0000
Message-ID: <BN3PR0401MB1640389B8B28086F0185CE2EE7DA0@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
 <20181119035131.11255-3-damien.lemoal@wdc.com>
 <20181120172126.GA28169@ming.t460p>
 <c132f449-b45f-aab8-1b57-1a45e43d22f4@kernel.dk>
 <BN3PR0401MB164000EE62FE6BFF2ABE0069E7D90@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <68806243-0094-5cbb-39fe-cea697f40b1c@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0401MB1345;6:9qaktX9cc8elardlufjda6kM+I6BojlGjQvKyADvTumnSE/73b3blQ4PtJqRAhV0ptVtIzQdZJZ3f+w7KrRR9AjKtH45oWD1B9XFiaDh6vqB1XeumftzrEb15KuTwywn16CWYyaoR3PjsCfnlVg1HAlembEH2Wm0URzv1Ewt5Q3rPCUql1pqkKXhVBKH+oh+LBI2+R/zMHjuRUMJcb9G+4s5bNNkRlYpNagehGLlZt5u7C5D9c31Dy0xx9/jSoKiea4YkV/M/jKV2dyMxFXcpUObFrsyw1KHMeKNaqS7sj3Z9E+vVSdOrOBufut3QPYlrlppnu7ozsABtAhmmZ3Q57h5/pnFx1w5I4zqweKupiRB8LJK9sGQa+V5RwQ6fVGJopzgt3erePQHcgl2rdIVpREBvtsdMJFlNau1hfSmpa7GAbIpRNOrFoDPeSidA1+dsVoX34wtIj1aSHiwIdqwxg==;5:aqDmHXTG0FJFwCshrfZvnNio4KVurquiCSAES0ntDpIZ9SxtdLDrXtvwHRwvRW8knRGt7C2wI54+VrC9dEdkc03OoAANrqMlgEJkjp81T1GsMLCk9CesYTNm4OH/sl5N6fW2VYAXSDMK0jan7jo5RMDJDmAuoxCoo7VZQXaCGF0=;7:zhE1O9WEV87Lr8rnLvdbXj/9eMOgmG35GY18vrTUSxrWx43yiwP7MOaPH7TFmVy3nowzFi7c4pYwKrQBCgn2r6F12qr/TIcl8wc3T7vzm/o7OxY0DmmTwE9PCVzOw9Tu7v9neKPEFfeyr/tqMxp/RQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 6914e132-fc00-4969-1f51-08d64f5b74a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN3PR0401MB1345;
x-ms-traffictypediagnostic: BN3PR0401MB1345:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR0401MB13450ED39F6160826963537CE7DA0@BN3PR0401MB1345.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN3PR0401MB1345;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0401MB1345;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(366004)(396003)(346002)(189003)(199004)(71200400001)(106356001)(4326008)(6116002)(97736004)(256004)(3846002)(105586002)(14444005)(99286004)(2906002)(7696005)(76176011)(110136005)(8676002)(316002)(8936002)(81166006)(6506007)(71190400001)(68736007)(54906003)(81156014)(5660300001)(53546011)(25786009)(305945005)(102836004)(74316002)(53936002)(72206003)(33656002)(478600001)(26005)(186003)(55016002)(93886005)(7736002)(9686003)(14454004)(66066001)(86362001)(229853002)(446003)(6246003)(6436002)(486006)(2900100001)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0401MB1345;H:BN3PR0401MB1640.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: V+uR1U/WsVFkYH7+OozRi7H7EuTCzSADPOa1X/uclhqN0kD2ymts2xKp7ZSoK8JVJymd++Q5zNxiuglnV5Aeu5teXFFQVBS7cuoVAX2XR8Oi93TaCFoUNsMjzXOSuU/XjlsEh61pJgiudVXJY//31GWLMBpayq/L7cvepb1tkiWp28cVWM9Ax94hn8fsroFgj1zNwBo6qYPKLdH2cwA5jCwEuOCIFzRxYs1NpwDkjRHBc1gtzxeeKykDXgcLhqaRIc4rYOc8JLfXyWRLS+L2Z4zDmUvGfb2yGimZzdk+3UuJLOOJTIrPk7fw26mwQdvebEDBbqHBmaWfWsYSGmCfjUvzqw/RAYDfUzN3CmvdfdM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6914e132-fc00-4969-1f51-08d64f5b74a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 02:45:53.6674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0401MB1345
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2018/11/21 11:11, Jens Axboe wrote:=0A=
> On 11/20/18 4:58 PM, Damien Le Moal wrote:=0A=
>> On 2018/11/21 2:31, Jens Axboe wrote:=0A=
>>> I think the below should fix it, we haven't necessarily setup an=0A=
>>> ioc if we're just doing as passthrough request.=0A=
>>>=0A=
>>>=0A=
>>> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c=0A=
>>> index 13b8dc332541..f096d8989773 100644=0A=
>>> --- a/block/blk-mq-sched.c=0A=
>>> +++ b/block/blk-mq-sched.c=0A=
>>> @@ -34,9 +34,16 @@ EXPORT_SYMBOL_GPL(blk_mq_sched_free_hctx_data);=0A=
>>>  void blk_mq_sched_assign_ioc(struct request *rq)=0A=
>>>  {=0A=
>>>  	struct request_queue *q =3D rq->q;=0A=
>>> -	struct io_context *ioc =3D current->io_context;=0A=
>>> +	struct io_context *ioc;=0A=
>>>  	struct io_cq *icq;=0A=
>>>  =0A=
>>> +	/*=0A=
>>> +	 * May not have an IO context if it's a passthrough request=0A=
>>> +	 */=0A=
>>> +	ioc =3D current->io_context;=0A=
>>> +	if (!ioc)=0A=
>>> +		return;=0A=
>>> +=0A=
>>>  	spin_lock_irq(&q->queue_lock);=0A=
>>>  	icq =3D ioc_lookup_icq(ioc, q);=0A=
>>>  	spin_unlock_irq(&q->queue_lock);=0A=
>>=0A=
>> This seems reasonable to me, but I wonder why this problem was not trigg=
ering=0A=
>> before. The previous code getting the ioc with the rq_ioc(bio) call was=
=0A=
>> essentially the same and there was no "if (!ioc) return;" in=0A=
>> blk_mq_sched_assign_ioc() before the patch.=0A=
>> Any idea why this is popping up now ?=0A=
>>=0A=
>> Ming,=0A=
>>=0A=
>> Is this a new test your are running ? If this same problem triggers on s=
table=0A=
>> kernels, Jens patch needs to go to stable too.=0A=
> =0A=
> No, it's definitely introduced in your patches:=0A=
> =0A=
> -                       if (e->type->icq_cache && rq_ioc(bio))=0A=
> -                               blk_mq_sched_assign_ioc(rq, bio);=0A=
> +                       if (e->type->icq_cache)=0A=
> +                               blk_mq_sched_assign_ioc(rq);=0A=
> =0A=
> Please run blktests on a series. Always. There's no excuse not to.=0A=
=0A=
By the way, should I send an updated patch 2 to include your fix ?=0A=
Or will you add an incremental fix ?=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
