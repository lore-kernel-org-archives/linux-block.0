Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9735C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 02:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822FD2146D
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 02:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z7h8SVQ8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XczmE7Ln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 822FD2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeKUMrB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 07:47:01 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41808 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeKUMrB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 07:47:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542766529; x=1574302529;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9CJQrQZSPpi1rN5B3moverWVEaE9/ERQcWSQOCQ3jDY=;
  b=Z7h8SVQ8/d6C7Y/+tZp45xRKxydHzA/RLjYgkbL05BCT0Mm+/Z0EzH0T
   T16SQDxeSgh9yt5Kmzz3DjEX7NUj25TRaSex221mfrBpvygkEV8WMTbqO
   MwbstFAIn6X8RewLLAsNRrBL0AznITLGG20NRG9a5AXiMgVWbwZ2eK3SO
   AEiER3Byu8Dv7wte1Ds10hm+DcwEyHQmphuHN+m8E/KgHUNKgGMoETjdF
   MEmsDSF2NSTgn8q8hYqKE7t2ceNIuWr7Fsuyu8q0S7vgjy0SVTubjeLot
   GE31RzfR94EMZyNaPgQsD/vVEeSTsF2ZwSar4z0y57oJ08ERNEJHai8vZ
   A==;
X-IronPort-AV: E=Sophos;i="5.56,259,1539619200"; 
   d="scan'208";a="192554606"
Received: from mail-by2nam03lp0048.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([216.32.180.48])
  by ob1.hgst.iphmx.com with ESMTP; 21 Nov 2018 10:15:27 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iChqJsKBrfH1XmCTHWtu+I1hKJKnrqIEEioopOFFuWU=;
 b=XczmE7Ln1tF5Fh+/y4ZJh0Sm+8xOKm0UYY6O4aGMbcGm8gEOraJhB9t9S/w3TDbPqT9UNS/H68CLNwQYELKuODIRsafAWUc/GpPZ5rd59VGpBXmTNBmfZYURrEVfN+lFnwK2tyNUxtqUwx53anu6Aaw2O7ZLMVgoDYHe3ipa+AY=
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com (10.163.41.30) by
 BN3PR0401MB1605.namprd04.prod.outlook.com (10.163.36.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.28; Wed, 21 Nov 2018 02:14:38 +0000
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164]) by BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164%5]) with mapi id 15.20.1339.027; Wed, 21 Nov 2018
 02:14:38 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/7] block: Remove bio->bi_ioc
Thread-Topic: [PATCH 2/7] block: Remove bio->bi_ioc
Thread-Index: AQHUf7tEoRMSe3tInEucKAoqKOcuBg==
Date:   Wed, 21 Nov 2018 02:14:38 +0000
Message-ID: <BN3PR0401MB1640612C3B59743A8886E67BE7DA0@BN3PR0401MB1640.namprd04.prod.outlook.com>
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
x-microsoft-exchange-diagnostics: 1;BN3PR0401MB1605;6:u/uc7YAIGmPvvHhoSuyfcRz/yRYZQU8vQKUUxJ2AX32/z924NQtW3cY8JcLIqRjEj6Q89bfT7+5xzs0l6apD9TG7aRvhtkn4n8h5mu02MtIAdpz11sEvOWHZdCxXqjpuwniqf5EplrOFjD62UF0OleZxkqav/AhCTLIQjO1U+FpZrhzQKHe4Ob6qmudEAixugdMDI/U+ZqTEMBRaqkti94TSsJNJGKXvljD0+Yb1vfhQCso++sm5IykB8taNHRWv1iCsuGqH+aWDPLPeEgnMb+LdfblJXX7LR11M+kjEwCOhOjFi4aO7LAnFUJwqUHNiiOgNU3Cc3pUwW+3vbjU0ysBAseXdYpTVErtZ1StbyXJRsc4CZqeL6Am1iia3aLgHFXLUsXaZ55BY/Wyj22yn266iy2zcZyaSrsApsMUfig4HxWIR0tHMEB68TCTPB3laQ2TbmnhA2tAnQSrszKHHhQ==;5:1258PrWIAItmHauiI3/mGZfaMS40vWypNF3aAFV7NOiJ5L0YRQjytBPAtKfG4fo8k0uyc8c24JJ7MjguFc/QH0I9P7PoVLhsh0jSAMv8kHI5wr9P3JDnRY7COJK9F7vBMB2N1ygu8KEym22F8oFjZ+ZfnfjJ9WI9yJQaZNRGoR4=;7:+gpNLXSyG6Uh+0RBO8g1taTcmz0GACNv6WglM9MyeyOUIrzpIe13jQ+vp7fquaL1bJMfRSFDCJs8e9zZIbazwWc3vcw+PStVkmGRe8O1th1o83QDY45svaQjRNgnxC2VbnM3ZgwIFfkbOy3sg89/wQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 770ad72c-0cf8-4f1b-75e9-08d64f57171e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN3PR0401MB1605;
x-ms-traffictypediagnostic: BN3PR0401MB1605:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR0401MB1605E03BF9C60CB704CDEADBE7DA0@BN3PR0401MB1605.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231442)(944501410)(52105112)(3002001)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BN3PR0401MB1605;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0401MB1605;
x-forefront-prvs: 08635C03D4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(136003)(376002)(346002)(39860400002)(189003)(199004)(6246003)(99286004)(72206003)(71190400001)(93886005)(14454004)(71200400001)(2906002)(478600001)(3846002)(26005)(6506007)(53546011)(186003)(76176011)(102836004)(446003)(6116002)(476003)(25786009)(66066001)(7696005)(486006)(55016002)(256004)(316002)(14444005)(106356001)(105586002)(74316002)(305945005)(2900100001)(5660300001)(33656002)(6436002)(229853002)(8676002)(68736007)(97736004)(4326008)(8936002)(81156014)(9686003)(110136005)(81166006)(53936002)(86362001)(7736002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0401MB1605;H:BN3PR0401MB1640.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: nRaaH0TDWw8c4eKcrijYWYQKOG9iTlVOw3tClj540mNFIKTk7S5hcZx2WfJE+QQdyBEygmnfVAyJ8FNgRA9ABvM4DXH96H346SthySU447flUF2GpZlHXeWHSQYQqJm0CF8a5+YehZBXc1Hwr0W1bHd98sQY5r95LGolR9+1MZ4NVClSk2ZXKdZHQulCovGQLTfPZJM9kR01c8ZdujrSO4HfsxK+tm0wHYCBD2QttFmFVuVQldWGtqv6n1/U2ORsbv4lXH8q3RxQvgfv8nn6xZjQF1LlKgohdZq/sMGIEIVdUAz/uGyHZu7yCS0tWW0VetcztYqh3LaJCwSiPuZMU1++5l2jCU6ZAdV/f9A/zME=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770ad72c-0cf8-4f1b-75e9-08d64f57171e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2018 02:14:38.7094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0401MB1605
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
=0A=
Arg ! Yes, I missed this. My apologies.=0A=
=0A=
> Please run blktests on a series. Always. There's no excuse not to.=0A=
=0A=
I did run my usual tests exercising drives with various fio workloads. But =
I did=0A=
not run blktests itself. I will fix my workflow to include it.=0A=
=0A=
Thanks.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
