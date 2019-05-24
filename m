Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9C5C072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 16:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE9E2070D
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 16:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o3BgbtBg";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="H03/lwor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391113AbfEXQuS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 12:50:18 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2353 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390346AbfEXQuS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 12:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1558716618; x=1590252618;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2GTwkBALN+hOHtFafj0H0sbztItQxFHmgqPF3/MhXD0=;
  b=o3BgbtBgLq08RjRYc104y3KWwM19GnppA6b72PkEo6t+BHgwxRaic5Rl
   CLT1DPKnJYgvG7J6SM4lSJ/q4z3NgkiCANNxWcDIx2NS9NyaBVbPgiktO
   pXPBESWXTzObx0Dbq0UCF0rcFBJmfsIdh3OMo4J2C1tsApzNtdlBbGm8d
   cI015apMu+9BkBo0xsanM85xjt7PL6HvIFz7MVRd7hpr/OXigJ+uvrPjx
   jiZQN0ntv2b0CYPEVpAzXly+KT1cC/Qm8kzbUgdUA5ZKReS0w7SJT1VMS
   nrVriztHy/S32maAP2o/y1CoNFllOFCWJqCwW8orojn6n8g9qzWhsFTOV
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,507,1549900800"; 
   d="scan'208";a="110727358"
Received: from mail-sn1nam01lp2057.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.57])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2019 00:50:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM+/qoiRYyBINy4kAh1SIj4Iv+JITY1M/79gFLDdJvw=;
 b=H03/lworPl5r6HO8VtLav/NVjMT9YDXJ+7a0sNmDkEtcPngDsFYM/aKZAVgRgsnqOqSwrZ711o+25esiVrZUTHKlvAP0Q4/Vkvdzhnc6EUQPLc3l5tRDo4TX2NFMPHY3hNxqFqzBcjmAxynTa/47t0YTKLmyQTkT4HR2rHcAXHA=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB6117.namprd04.prod.outlook.com (20.178.234.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Fri, 24 May 2019 16:50:15 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::ad42:af4b:a53b:80f5%4]) with mapi id 15.20.1922.013; Fri, 24 May 2019
 16:50:15 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     John Pittman <jpittman@redhat.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "djeffery@redhat.com" <djeffery@redhat.com>
Subject: Re: [PATCH] block: print offending values when cloned rq limits are
 exceeded
Thread-Topic: [PATCH] block: print offending values when cloned rq limits are
 exceeded
Thread-Index: AQHVEbFzUNDIy+caP02hj5K05Bz0IQ==
Date:   Fri, 24 May 2019 16:50:14 +0000
Message-ID: <BYAPR04MB5749C6907333D8869917774186020@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190523214939.30277-1-jpittman@redhat.com>
 <BYAPR04MB5749B68BB9E3BD3B19F006D986020@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CA+RJvhyLihk0tgSG5nAVMGNgBQTPnOCv==A886L_ca3q1aqMPQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [24.19.218.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 104db053-6326-4db1-4a6e-08d6e067e541
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB6117;
x-ms-traffictypediagnostic: BYAPR04MB6117:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB611790D36195F9E7723DD7FD86020@BYAPR04MB6117.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 0047BC5ADE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(346002)(136003)(376002)(199004)(189003)(74316002)(86362001)(66066001)(7696005)(446003)(476003)(99286004)(81156014)(14444005)(53546011)(486006)(76176011)(8676002)(256004)(68736007)(26005)(53936002)(54906003)(9686003)(6246003)(81166006)(55016002)(6436002)(33656002)(4326008)(72206003)(14454004)(229853002)(25786009)(8936002)(5660300002)(478600001)(66556008)(305945005)(66476007)(76116006)(73956011)(6506007)(6916009)(52536014)(66946007)(102836004)(2906002)(7736002)(71200400001)(71190400001)(64756008)(66446008)(3846002)(6116002)(186003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6117;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mBuzVnl8m4GxgC29ULLcGp3c+vqKAWExtnFu+6PP7Oj6H4aFmP4Rk93GabZSlEXbKAofKxE+gfI/lo3XQEsG3827OrVbxBa5pJxaRDmjnlRz2bPAB7s4NMqP67/AvLevIcDRtEv8a33qKVfpBSnEYZTnkTRYCtCQuhbllIkRkxlcLFh5M44I5qmGwaTQ3Ine/wHqPp2d4qlGcvwR/JFE7x9VPk4WjvwZi12xnIvXR4AoTRCFVyN8pdEi4Ep5tgm0uJRBq1DNmrxdNa4DTrI1hGTdv2EDn/w/5UVDE7flBo0ol7VfpQlzfn4Exw3HbZv4+IyWE2B1nmEX/Tuy1r/WZc9jjMpG2rUzHoeFoupDin0p/h7e2sPvq4Aqamq/PsqQv4GZth6qsY2+XBARcgXLA/Hn19eJp+7vONH8mh53ELA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104db053-6326-4db1-4a6e-08d6e067e541
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2019 16:50:15.0119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6117
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Let's leave it to Jens.=0A=
=0A=
On 5/24/19 5:19 AM, John Pittman wrote:=0A=
> Thanks Chaitanya for the review.  I was not sure what Jens would think=0A=
> about the checkpatch warning, so I left it as it was so he could=0A=
> decide.  I tried to model the value output after that old 'bio too=0A=
> big' error.  Thanks again.=0A=
> =0A=
> On Thu, May 23, 2019 at 9:17 PM Chaitanya Kulkarni=0A=
> <Chaitanya.Kulkarni@wdc.com> wrote:=0A=
>>=0A=
>> I think it will be useful to print the information along with the error.=
=0A=
>>=0A=
>> Do we want to address the checkpatch warnings ?=0A=
>>=0A=
>> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then=0A=
>> dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...=0A=
>> #20: FILE: block/blk-core.c:1202:=0A=
>> +               printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",=
=0A=
>>=0A=
>> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then=0A=
>> dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...=0A=
>> #31: FILE: block/blk-core.c:1216:=0A=
>> +               printk(KERN_ERR "%s: over max segments limit. (%hu > %hu=
)\n",=0A=
>>=0A=
>> In either case,=0A=
>>=0A=
>> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com> .=0A=
>>=0A=
>> On 5/23/19 2:49 PM, John Pittman wrote:=0A=
>>> While troubleshooting issues where cloned request limits have been=0A=
>>> exceeded, it is often beneficial to know the actual values that=0A=
>>> have been breached.  Print these values, assisting in ease of=0A=
>>> identification of root cause of the breach.=0A=
>>>=0A=
>>> Signed-off-by: John Pittman <jpittman@redhat.com>=0A=
>>> ---=0A=
>>>    block/blk-core.c | 7 +++++--=0A=
>>>    1 file changed, 5 insertions(+), 2 deletions(-)=0A=
>>>=0A=
>>> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
>>> index 419d600e6637..af62150bb1ba 100644=0A=
>>> --- a/block/blk-core.c=0A=
>>> +++ b/block/blk-core.c=0A=
>>> @@ -1199,7 +1199,9 @@ static int blk_cloned_rq_check_limits(struct requ=
est_queue *q,=0A=
>>>                                      struct request *rq)=0A=
>>>    {=0A=
>>>        if (blk_rq_sectors(rq) > blk_queue_get_max_sectors(q, req_op(rq)=
)) {=0A=
>>> -             printk(KERN_ERR "%s: over max size limit.\n", __func__);=
=0A=
>>> +             printk(KERN_ERR "%s: over max size limit. (%u > %u)\n",=
=0A=
>>> +                     __func__, blk_rq_sectors(rq),=0A=
>>> +                     blk_queue_get_max_sectors(q, req_op(rq)));=0A=
>>>                return -EIO;=0A=
>>>        }=0A=
>>>=0A=
>>> @@ -1211,7 +1213,8 @@ static int blk_cloned_rq_check_limits(struct requ=
est_queue *q,=0A=
>>>         */=0A=
>>>        blk_recalc_rq_segments(rq);=0A=
>>>        if (rq->nr_phys_segments > queue_max_segments(q)) {=0A=
>>> -             printk(KERN_ERR "%s: over max segments limit.\n", __func_=
_);=0A=
>>> +             printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)=
\n",=0A=
>>> +                     __func__, rq->nr_phys_segments, queue_max_segment=
s(q));=0A=
>>>                return -EIO;=0A=
>>>        }=0A=
>>>=0A=
>>>=0A=
>>=0A=
> =0A=
=0A=
