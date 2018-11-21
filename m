Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564B0C43610
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 01:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28C4213A2
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 01:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LUTTweaF";
	dkim=temperror (0-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SRwJ4Wqd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28C4213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbeKUMEL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 07:04:11 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12873 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUMEL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 07:04:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542763924; x=1574299924;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yb3cMF94zHrNoRkK4alseAp5alLg2FSdoGV8B991Aq4=;
  b=LUTTweaFG0zKsuGmMQ74cQWMxafRcn5UwBsoY63GUp3Eo1aH2VGeL6P9
   kFjU699rOXUh5eNRJyIC4eV2iOcEShGwjlvtwYP0pNBao2n55pkAnSq5f
   PUnJOZ1/NG2krXOSKeoT1doi7PVWq2sgEw7N9C6NzpZCSUL6RGfKb/4JW
   Yuquxw8i+g+mvljIdavAwG5bSz6Mx7w44H3zep3fUOg37nw7UvwvXn30O
   R2LEVdgZY3bIX3CG8mpOfW6t7IZ3vYRC1+Q6zE4Z81M3MoCpxK66K47fs
   nnm31qArAcFthYQ9osA2HnNjE/Qj4WyIJb8I/27QCNzg+zDErPO9XIraY
   g==;
X-IronPort-AV: E=Sophos;i="5.56,259,1539619200"; 
   d="scan'208";a="94754990"
Received: from mail-bn3nam04lp0117.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([216.32.180.117])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2018 09:31:56 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv2sh9GK7BSEKt42wKWVWe+H6MXQDMwnlp//TrqYLDc=;
 b=SRwJ4WqdlVqEtPWcnhrBX5s3LCCN+kERgXyQu9rlCStCwrc3RFMbRwcIDSSQtqqbG8/gks7TOy5waD7s60+shOgUE0EE6Rpmkxpwxpko4bdeuMTOJfD0tD6E6Fg0V6o7OYNSlwqyNc1DdL00V0O7xlc32J3+6VDroCcolgrIeAw=
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com (10.163.41.30) by
 BN3PR0401MB1412.namprd04.prod.outlook.com (10.161.210.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Wed, 21 Nov 2018 01:31:54 +0000
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164]) by BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164%5]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 01:31:54 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/7] block: Remove bio->bi_ioc
Thread-Topic: [PATCH 2/7] block: Remove bio->bi_ioc
Thread-Index: AQHUf7tEoRMSe3tInEucKAoqKOcuBg==
Date:   Wed, 21 Nov 2018 01:31:53 +0000
Message-ID: <BN3PR0401MB1640F0C9CC86FCC277520F21E7DA0@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
 <20181119035131.11255-3-damien.lemoal@wdc.com>
 <20181120172126.GA28169@ming.t460p>
 <c132f449-b45f-aab8-1b57-1a45e43d22f4@kernel.dk>
 <BN3PR0401MB164000EE62FE6BFF2ABE0069E7D90@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <20181121012433.GD31748@ming.t460p>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0401MB1412;6:y6bSUDtYQUIDwTHg2yOHplMTWgH505jIQ9bp3o8bHIc3FpPa9HOkUW2wqK7zcIip8aGLTt1Zyhsaj18hi5SEFu/sACAn1Nfc0T3Bc26PvdF/82HO7s20cQ98bQr1lN7/4XOPugEtsD925CS5FFMUV/0AYH8MY8foK2AfrwIP52ebEjwmhYoZHik4HAyyb9DzR2xS8TDd/y8V3j+eQ27XBhtI/dgVldin8ieiR39dM+J5ohTZQeSubqkHgH8r39D9D+T2IpwIHHJsDgTBkGxkXQR8K9FPsUrVepTx3/FhxjgitnTtKzZQuRHzCY3Fw2PwxSjeVIrDmJX33o6Vy87nPjep/DLCOgVSi+ZYrH9n3VQv84Oq9EtMq1cnryuTxMi6aUILRBKqJbyK5VmacDFJdZlnwA22FuUzUiqrBTOr/mh9J4CzexadG3cacKWnjgscqmjiiITk8Hd8VpIgBOcfDw==;5:h/O7sw8wojo/0eymfVY3ZPU9ntgDQn+GqklpnWOPvXnjxx0zhC2d9fUvRshgfP9fqEsaNLeRP3x0r+sJIwtA8ogooKFlILOIgJsieqZXIcIDAWZqlrXjS/oU5Gvpn2bza3csvcYi/qYU1iCV1DbrCEH4Jo4yXM2HZD+RpwPhSWs=;7:Oxg55PZCE+dRa126dKnQ4bxpAiHUexYC/gM0dKseh4o85Gu9YJwXLAia99sdFo4horFhVhPpaWOSMfE1b5hBD076TK1TxHqDzg1a7fBMDM/mWDWW9iobhnxvWOmHsG6J6DDKQDpv8eNpLHzZQp/zNA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 856557a2-e862-45f1-dcc8-08d64f511e6c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN3PR0401MB1412;
x-ms-traffictypediagnostic: BN3PR0401MB1412:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR0401MB141272CCF0DDC88AA591A362E7DA0@BN3PR0401MB1412.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BN3PR0401MB1412;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0401MB1412;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(39860400002)(366004)(199004)(51914003)(189003)(53936002)(68736007)(305945005)(86362001)(229853002)(9686003)(5660300001)(2900100001)(6306002)(486006)(76176011)(6436002)(71190400001)(71200400001)(99286004)(6246003)(81156014)(66066001)(81166006)(8936002)(4326008)(55016002)(2906002)(446003)(8676002)(6916009)(7736002)(3846002)(105586002)(72206003)(93886005)(33656002)(74316002)(6116002)(54906003)(106356001)(478600001)(476003)(102836004)(97736004)(25786009)(966005)(256004)(7696005)(14454004)(316002)(53546011)(186003)(14444005)(26005)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0401MB1412;H:BN3PR0401MB1640.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 6duWuyNDObLhOGVRYQy/kUL2iGUEVRTI3MsPJtzU/TOCa3/3H/XbmGErZITadc8HcYbd3k3V454+kQbjO9BpiVV7povjxjz+rdvwhZzPU5disEfoS54+pI4NjvedCvTBWb7RFugEj2A8+G12uJvUUJUsxKDnIdpbpzb++Plb9584HGcz8YIWG4K4KgD6r4jxbf8R6WoV6aUWuHLhaewelq4ymVXF3SyL4OGfQBDUlvbdjrMQnoNT8KiKVhZLQ2GHZ7raQd+G8kVt4WaPirxLk+VrpZeaUsQzZs01X6qkXclrSvWucLv1hxRUq6EJtUnYcnLtfkZjrd4WZQm0VTENnlRHIPwauKFqMsoAJQ52jCI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856557a2-e862-45f1-dcc8-08d64f511e6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 01:31:53.9188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0401MB1412
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2018/11/21 10:24, Ming Lei wrote:=0A=
> On Tue, Nov 20, 2018 at 11:58:09PM +0000, Damien Le Moal wrote:=0A=
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
> No, I run daily block related tests on block for-next, and this issue is=
=0A=
> just triggered when your patches landed.=0A=
> =0A=
> You may find the test script:=0A=
> =0A=
> https://people.redhat.com/minlei/tests/tools/elv-switch=0A=
=0A=
Thanks for the information. I will look into what else caused the behavior =
change.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
