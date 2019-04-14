Return-Path: <SRS0=vbI/=SQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B23C10F13
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 21:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CFB20870
	for <linux-block@archiver.kernel.org>; Sun, 14 Apr 2019 21:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qnwTL4sk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="g93R2URu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfDNVCQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Apr 2019 17:02:16 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40945 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfDNVCQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Apr 2019 17:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555275736; x=1586811736;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BPARcDoZ8nLH8ecvuDCqn6KdeY3AzY41pzWz+UUGEpo=;
  b=qnwTL4sk1F8HOckvKzJdYit5gV86+ozJQ7XpzNdHkygMdV/OivtSvluR
   kQWw2XLGn346Is8sMHC5j1nlMDJP/azwIJfBC9FExGWRvskv0i4KqpP9O
   ay+e7yu/3p4u/ViGAABL+WIcX9nxFapib/buBjlv9ztYHG5ScQIDY5xkh
   FxStwqDPFE5u2LoSz9dE5MNFtShUzgGPNmhuzxbVmxFXFD2/L/yYjqVZ7
   5t2zh0AIKN3qJj0InyP0aQLqzhlI4WQVEdSI6xwVtqFizmWyGrBUe8Ovy
   EA7lrdiIIEBvNSr39o5dfJtk1V0mP+wJYTyG4S4bUAly9OiIF6cVXNerO
   g==;
X-IronPort-AV: E=Sophos;i="5.60,350,1549900800"; 
   d="scan'208";a="110901807"
Received: from mail-bl2nam02lp2057.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.57])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2019 05:02:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9RQj9aO4A6wfcXGdSIhXUirOV08G/RxwSewwJERwGvU=;
 b=g93R2URuFKaytL0DK5q/TA1QFoa4HkR8A+3VZ7uS709ipCBOh+0YT7Nvz3Ur2OhHkXIVXkL24JEtWaq7kidlraOizZxv2xlZt6oPuhLvCqCmN8CLcQvxQGIHYeeKEpxxW07IONxGPXsvHar9hM4PQsL9mwVOPE+Xp1741DnJqzk=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4639.namprd04.prod.outlook.com (52.135.120.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Sun, 14 Apr 2019 21:02:13 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1792.018; Sun, 14 Apr 2019
 21:02:13 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/3] blk-mq.c: Rework documention of blk_mq_init_sq_queue
 function
Thread-Topic: [PATCH 2/3] blk-mq.c: Rework documention of blk_mq_init_sq_queue
 function
Thread-Index: AQHU8m/QnMu0zSMJMUiIqzfjhj8aFA==
Date:   Sun, 14 Apr 2019 21:02:13 +0000
Message-ID: <SN6PR04MB4527248A7EC22784AE6C0836862A0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190414031055.26350-1-marcos.souza.org@gmail.com>
 <20190414031055.26350-2-marcos.souza.org@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.175]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e701d00-e94a-47c0-57ed-08d6c11c77d8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4639;
x-ms-traffictypediagnostic: SN6PR04MB4639:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4639BCF0E629DA672B289206862A0@SN6PR04MB4639.namprd04.prod.outlook.com>
x-forefront-prvs: 00073DB75F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(7696005)(2906002)(86362001)(76176011)(99286004)(102836004)(72206003)(26005)(53546011)(186003)(256004)(14444005)(478600001)(71190400001)(71200400001)(2501003)(6506007)(97736004)(68736007)(446003)(6116002)(3846002)(55016002)(53936002)(33656002)(9686003)(6246003)(476003)(486006)(74316002)(5660300002)(110136005)(54906003)(4326008)(229853002)(66066001)(106356001)(25786009)(305945005)(8676002)(81166006)(81156014)(7736002)(316002)(8936002)(6436002)(105586002)(52536014)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4639;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3oaerI0P/CsjfVaTrsu0UhxUMiUKD+Ff6gi1S7GtFX8RL35XWDFk9lxXAjcHnupiBhv5qH/J+gZt7Ok6RBgSP74EVnPAyShsT/7RH20MFvALI/RQ0+90AczSNdi9jELgAfE5MQYJvLqTj3+RfVhlocLLY+P9umgBeLQ7S3GdfGWp1RHmkkJeZYK4msDx9lTpBCd0BqCwRiUjghnFPdR2GYgiUiWjvuZW47kyuZe9stuQv71XLj/qIFI9KAbNJXAMVi5fXj5hS3F/MAbgCo3xU837I+sS7NSzhqEYP+PzfPDyztZnCtgAU5vGtN3KOt+gxehIoUTuZvXOhLwxMXbr22FLyWuW1TVJCjXoK5eQyfb2xAWKuFGtnmsoKXOIv9eTUC4+y6l42Cp8xbRMKQ8wXS5Ldaxy2seufORUKq/Y9ls=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e701d00-e94a-47c0-57ed-08d6c11c77d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2019 21:02:13.2185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4639
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/19 8:11 PM, Marcos Paulo de Souza wrote:=0A=
> Describing better what the function does, and what the arguments are=0A=
> meant for.=0A=
> =0A=
> Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>=0A=
> ---=0A=
>   block/blk-mq.c | 17 ++++++++++++++---=0A=
>   1 file changed, 14 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index 4a8277a54c03..fd0bf89b8a73 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -2675,9 +2675,20 @@ struct request_queue *blk_mq_init_queue(struct blk=
_mq_tag_set *set)=0A=
>   }=0A=
>   EXPORT_SYMBOL(blk_mq_init_queue);=0A=
>   =0A=
> -/*=0A=
> - * Helper for setting up a queue with mq ops, given queue depth, and=0A=
> - * the passed in mq ops flags.=0A=
> +/**=0A=
Is following line beyond 80 columns ?=0A=
> + * blk_mq_init_sq_queue - Create a new request queue with a SQ queue and=
 tag set=0A=
It will be great if we describe what SQ in the above line, otherwise we =0A=
stating just obvious here.=0A=
> + * @set: tag set to be associated by the newly created request queue=0A=
> + * @ops: operations to be associated with @set=0A=
> + * @queue_depth: number of tags of @set=0A=
> + * @set_flags: flags of @set=0A=
> + *=0A=
> + * Description:=0A=
> + * @set is initialized using @ops, @queue_depth, @set_flags, and using o=
nly one=0A=
> + * hw_queue (SQ). Later on blk_mq_alloc_tag_set() is called to validate =
and/or=0A=
> + * adjust values of the tag set. blk_mq_init_queue() is called passing @=
set as=0A=
> + * argument, returning a new request queue with @set associated.=0A=
> + *=0A=
> + * Returns the newly created request queue on success, or ERR_PTR() on f=
ailure.=0A=
>    */=0A=
>   struct request_queue *blk_mq_init_sq_queue(struct blk_mq_tag_set *set,=
=0A=
>   					   const struct blk_mq_ops *ops,=0A=
> =0A=
=0A=
