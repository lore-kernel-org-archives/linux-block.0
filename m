Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C8FC433E6
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31FD64F60
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhBBJKi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:10:38 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42934 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbhBBJHC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 04:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612256821; x=1643792821;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kBcYQsXYpDOzHdaJRMEWt71HVC5xVMDQxiAm7/8rlwg=;
  b=Fap/c/ldg5SI6bT9p17V5YDm9JLV+V8F6BBye+hIic8wqSDKhq49HJpo
   X0et40S28W/p4WJ02VvCYJ3snZ5QLzDVxRS58BNJlTX8hlxHdUt7fP2z1
   lEyJlprsx3lN4BPyMRg0+buDgtQo8EbLPjKOJUZkQlk0e3FYWjp3uAwkX
   mk+htG+rKjJIENoIHZY1V17D5nCIz8b5ngP5K5UWvCWqp7b1VXGQpYC4I
   tbNpym8zNAkxKWprzHOBPWiGHbErGN5kjbP6/bLQVjWFOQLd8v+sc+l+/
   M+pPbeSamo54iWKo7M0+zB0RsLFiaXv4t+QISNV6J4pAUV4gQO8o7e1yi
   A==;
IronPort-SDR: paRQmCR96qOu+yp+w26s6KaUTZ5YvwuvVvymL3OfT9Dwzp7P13LtChR+Xi0EwADUNX0ib1Ibcc
 lt1YkzTvvvz2PWdZe/owCFgL0BTYFa28rhyGArpeTb1ymrwE4c3+xqpq0ni128V8N9AgBUCE0Y
 kCTGL8v7bLTrlsuAYRG/Bw8zjkZbJpXZLJBOvOPRHJjlpoBCH9JP9D80QLfd8Q6rwIgcFDpdRi
 kvuXRrpZlW02+bBFFWWfQEAsTcoa3H6eWF76qX3yvguIUazVKhGewY7D8h6FJmTFg1myWQxs5y
 Szg=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="158902719"
Received: from mail-bl2nam02lp2057.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.57])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 17:05:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S54zVNoNAUXIsfP1f5SUwSV0ozY0jIWvnB4pYEVqBFn8SCffc7Ua8DSaIx4mVRD1n2tysH3R234YXXFCUljUaM9vGcLd4S+ITkHwwWQrlUaNj3HL5BNnqEA71xc/xRC4P6YyL3RD/ZYElm0/UZe8i1jRm2c6nyha7YI6yjCyTXD5yx5NQ6JzivZzFuiKrh+gIh0D5Olr1vbFeBpdlT5O5VRFTCodOGsUA5vp2oYdvEdGiXb3OLEF3dNNCufVV8DyUrmgyHWJStJ9JTwzTqcVrIo/ulGKTDI7jkIct5OiqbGWxtDkgfKrVU4kcfRGRDARvsEDnt6kKKJVQz9AqcL6ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0klMsUfe2MQ9NX4KaOvJL1CX8JSVl/rVJ4/avBhjhY=;
 b=JhE2s51DUMTq6RkYPDZA8r65olH0Y9uojY85yW8b4lOS/gepiWrkZS19qLSokG3qsD4+yrk2N8BeRgeq+kUqtslR5IC+cMxzT7g5MrE++CHISvAfY3Q6eMpmOtQKa7Xh7+lxfJJ4zYd4id1nItOEYRQ7KQwcR5oLKVK4ViGhCivkA4TEMIYU7DYMJSWuFLqPnZ/NUiXCDWploZVXKr3pO+0+52NvX887F2fJpEtA2+7MneeWaDbV7v/R6igb2zTs7/BoweTuKY5sKonzOwFrKN7D7wx0Mi62V3BZiF5uEhJePGOBSQ8xVdnyx03SSa8+HlgOWDNVanR6n7h08YmIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0klMsUfe2MQ9NX4KaOvJL1CX8JSVl/rVJ4/avBhjhY=;
 b=L+AiJIjV+VUKcn87NVsaewDov1VDWAqi/FoSzK/Uwa3xWVyfGtItkADctV+mdUB3HWdbyM++OhHQ/AfIFZ6Oew7y3+KodxQbyXkYFCGx9f7QySfTCCGPeZAkVF/UYkr6XDqrg1wV9C7EUxCYyauckqDDFsQoYv2vWNbusP0It9w=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4641.namprd04.prod.outlook.com (2603:10b6:208:26::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 09:05:47 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 09:05:47 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hare@suse.de" <hare@suse.de>, "colyli@suse.de" <colyli@suse.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 5/7] block: get rid of the trace rq insert wrapper
Thread-Topic: [PATCH 5/7] block: get rid of the trace rq insert wrapper
Thread-Index: AQHW+SP75nTo6wX1zEKCrOUPHnQl9Q==
Date:   Tue, 2 Feb 2021 09:05:47 +0000
Message-ID: <BL0PR04MB65142541D90FA3359DE64D71E7B59@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
 <20210202052544.4108-6-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:38be:e4f3:6636:91ce]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f2eda879-2553-4e43-68cc-08d8c759baf2
x-ms-traffictypediagnostic: BL0PR04MB4641:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4641B56B62449E3BF9613684E7B59@BL0PR04MB4641.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:397;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwksQ2qC/qp4WCWvAeJxnjb1Y0yj3fW+Fbn+SIgkP9DLLPVyIS8Bjiliz7wCAOY0fjJq0XyUij8qen3hOA2XgbItMKVzpu03s27RJqPWww9Ii7Mkph9Atvt+NOVwEAe2zy4t8S3igDob9SOuSFhGH7bmHKo6Qxk2fws5w3F+K2u8Y/VaXZb69yJ9oKPYKCzUePF3lTuu63noSoS66iv2UAZzjBO9C0U1ya58kWdI/WrcWraWPDw1KwA0Xf1cdTsQkEa3iR2TKQKuRm645dP33q8TghH+SHrXLGYllN/Kw+FSUx6QaD8WxSsaP1oVwscACVSiM+R0PRI8kiTUAxEQ7DJWho5ycITCo5a11dN0asrpWg9aZahnX2BGSlgEm2wPoN2jFTcBa0ZWCbENJ3gV096SOnAgLKYlMia/4tJ7SspmzsKpPEPUGJ9P/GBoolSB2a9hT0r8eIfDxmY9lXmlkInPreFnrxXETnt+QgWUqWGgzmTvwPF0KlHRWuazg6MUgT+uhVfYk8MGIJw1PCUN0y9f0OIwpQ2FIUohjV7/dPk8Ary+VO6O0YKrcxU3+CAo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(316002)(8936002)(7416002)(5660300002)(54906003)(71200400001)(7696005)(33656002)(110136005)(9686003)(83380400001)(86362001)(4326008)(53546011)(2906002)(6506007)(52536014)(66946007)(66476007)(8676002)(66446008)(66556008)(91956017)(55016002)(186003)(64756008)(478600001)(76116006)(26583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pRCRjVQ4FaPRqW22C/x4s/vk2yGgoDvxHVvcuDk942Q8zD0PpIr3CbH4e3a7?=
 =?us-ascii?Q?DggDTwDf2PIbr/zM0YMiJYsimxam77Ov4LJX7ylM9cQeh61bgoLLYGPWhQHV?=
 =?us-ascii?Q?fz3I5FEwSm3yExWyFicpmUh9p4SGGMqmquCnw+pYf+AP7KNq6R5w4D1PZNpL?=
 =?us-ascii?Q?4XV9oDi/MkGJe93ADrYWHHApdXxxXQuV7fv5jIP9fyxori42EW7IUejoLQAv?=
 =?us-ascii?Q?kbqCprJPZW2wbBlmNmH39xq94uoEs9Jb0K2ESWIMwbYoj0LCySxZ55taFn4t?=
 =?us-ascii?Q?qifSdj7z8uROZGjM6nssZnq7KoXKbybhgWByQMH+/eMSw8Yx4qeSH5DgUSoV?=
 =?us-ascii?Q?QMAlDBFJrKul3gnKJhSSCaLS8k4aeJUm7kAenQZCqihybdPpWAW/oDrUVvAO?=
 =?us-ascii?Q?kyJSDVd2zNC8BIOyVWlkNXLCbPCb/BVyZIBt+9pR2D1XQ6MgHUS44Sg5OR5d?=
 =?us-ascii?Q?PAUZkwheG+EDsiFzwuGcizd0tvmnfNltcfiNlBZsuwpFp2/NgzzmBl5jDwHx?=
 =?us-ascii?Q?u9oGwdGAkQdAGd6nEBHvYvMHjuN/QwBmWXfJcOQ8/dHiLEaSnh5/AU6juFOb?=
 =?us-ascii?Q?MgBDJVvqtHGsCf46OEbamYtP0Y9ep2z+iPG9rBQgCisXxYtkxRPzLmTDND6U?=
 =?us-ascii?Q?HcmYWPRgAELKqMsdGRsaqV+VR8il7YE/3jJ2TJ8x7HP/2j7NbNu2EOogGY7o?=
 =?us-ascii?Q?Xy3Jl9EM8JKAtcHdcPxg9FCA3Q5uN1/tJj2VPD1WwkGQDjNlu594RCxR1qS/?=
 =?us-ascii?Q?Hi5yhRUcBdfLGpqtEwigTZo8i7Jc1IolB2T++L0JdlGzFVAv5YExFTMfCbgN?=
 =?us-ascii?Q?quw1T+GIwHCHFpJ2w1BGOW6N5ttvO8qrphJN4PxZ+9pPQJoNrlsJtWXSA7+1?=
 =?us-ascii?Q?WPNsej/ee/gEiXs1EHf8n/xMcugp8FauhnT+MQSO2Z8XIIS2YYm8GCNUJWya?=
 =?us-ascii?Q?DbU4+I6T6UPsgUXxXFzZZqPw9mU19vh5mIGbI+QjyHDo0dI9w6yjLGDNVNFU?=
 =?us-ascii?Q?TIDq8SQqspn3muhXTL/2E2MIYeYVuTNmikdwPLeqXHHtBFAtaJOPXUVT1U19?=
 =?us-ascii?Q?AJBTX2jvShFHBz/caVZiS3HDCR6xN537CMopwLHN47r/+YIFQDtnJwJV4RbN?=
 =?us-ascii?Q?Ugo8B7qbLIfneiYsmORzRHet5UYIVyYDNQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2eda879-2553-4e43-68cc-08d8c759baf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:05:47.4733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RYIIrh9fQzkfzLXK5VyJyCjvdMk+uRfc29B+eXjeL/peLMKGkQ14+adU7HHdou4bVnIf7GnqGxalU94b40YVLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4641
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/02 14:26, Chaitanya Kulkarni wrote:=0A=
> Get rid of the wrapper for trace_block_rq_insert() and call the function=
=0A=
> directly.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  block/bfq-iosched.c     | 4 +++-=0A=
>  block/blk-mq-sched.c    | 6 ------=0A=
>  block/blk-mq-sched.h    | 1 -=0A=
>  block/kyber-iosched.c   | 4 +++-=0A=
>  block/mq-deadline.c     | 4 +++-=0A=
>  kernel/trace/blktrace.c | 1 +=0A=
>  6 files changed, 10 insertions(+), 10 deletions(-)=0A=
> =0A=
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c=0A=
> index dfa87e360d71..da5e1f620625 100644=0A=
> --- a/block/bfq-iosched.c=0A=
> +++ b/block/bfq-iosched.c=0A=
> @@ -125,6 +125,8 @@=0A=
>  #include <linux/delay.h>=0A=
>  #include <linux/backing-dev.h>=0A=
>  =0A=
> +#include <trace/events/block.h>=0A=
> +=0A=
>  #include "blk.h"=0A=
>  #include "blk-mq.h"=0A=
>  #include "blk-mq-tag.h"=0A=
> @@ -5621,7 +5623,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx=
 *hctx, struct request *rq,=0A=
>  =0A=
>  	spin_unlock_irq(&bfqd->lock);=0A=
>  =0A=
> -	blk_mq_sched_request_inserted(rq);=0A=
> +	trace_block_rq_insert(rq);=0A=
>  =0A=
>  	spin_lock_irq(&bfqd->lock);=0A=
>  	bfqq =3D bfq_init_rq(rq);=0A=
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c=0A=
> index deff4e826e23..ddb65e9e6fd9 100644=0A=
> --- a/block/blk-mq-sched.c=0A=
> +++ b/block/blk-mq-sched.c=0A=
> @@ -384,12 +384,6 @@ bool blk_mq_sched_try_insert_merge(struct request_qu=
eue *q, struct request *rq)=0A=
>  }=0A=
>  EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);=0A=
>  =0A=
> -void blk_mq_sched_request_inserted(struct request *rq)=0A=
> -{=0A=
> -	trace_block_rq_insert(rq);=0A=
> -}=0A=
> -EXPORT_SYMBOL_GPL(blk_mq_sched_request_inserted);=0A=
> -=0A=
>  static bool blk_mq_sched_bypass_insert(struct blk_mq_hw_ctx *hctx,=0A=
>  				       bool has_sched,=0A=
>  				       struct request *rq)=0A=
> diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h=0A=
> index 0476360f05f1..5b18ab915c65 100644=0A=
> --- a/block/blk-mq-sched.h=0A=
> +++ b/block/blk-mq-sched.h=0A=
> @@ -7,7 +7,6 @@=0A=
>  =0A=
>  void blk_mq_sched_assign_ioc(struct request *rq);=0A=
>  =0A=
> -void blk_mq_sched_request_inserted(struct request *rq);=0A=
>  bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,=0A=
>  		unsigned int nr_segs, struct request **merged_request);=0A=
>  bool __blk_mq_sched_bio_merge(struct request_queue *q, struct bio *bio,=
=0A=
> diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c=0A=
> index c25c41d0d061..f13da10953bf 100644=0A=
> --- a/block/kyber-iosched.c=0A=
> +++ b/block/kyber-iosched.c=0A=
> @@ -13,6 +13,8 @@=0A=
>  #include <linux/module.h>=0A=
>  #include <linux/sbitmap.h>=0A=
>  =0A=
> +#include <trace/events/block.h>=0A=
> +=0A=
>  #include "blk.h"=0A=
>  #include "blk-mq.h"=0A=
>  #include "blk-mq-debugfs.h"=0A=
> @@ -602,7 +604,7 @@ static void kyber_insert_requests(struct blk_mq_hw_ct=
x *hctx,=0A=
>  			list_move_tail(&rq->queuelist, head);=0A=
>  		sbitmap_set_bit(&khd->kcq_map[sched_domain],=0A=
>  				rq->mq_ctx->index_hw[hctx->type]);=0A=
> -		blk_mq_sched_request_inserted(rq);=0A=
> +		trace_block_rq_insert(rq);=0A=
>  		spin_unlock(&kcq->lock);=0A=
>  	}=0A=
>  }=0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index b57470e154c8..f3631a287466 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -18,6 +18,8 @@=0A=
>  #include <linux/rbtree.h>=0A=
>  #include <linux/sbitmap.h>=0A=
>  =0A=
> +#include <trace/events/block.h>=0A=
> +=0A=
>  #include "blk.h"=0A=
>  #include "blk-mq.h"=0A=
>  #include "blk-mq-debugfs.h"=0A=
> @@ -496,7 +498,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,=0A=
>  	if (blk_mq_sched_try_insert_merge(q, rq))=0A=
>  		return;=0A=
>  =0A=
> -	blk_mq_sched_request_inserted(rq);=0A=
> +	trace_block_rq_insert(rq);=0A=
>  =0A=
>  	if (at_head || blk_rq_is_passthrough(rq)) {=0A=
>  		if (at_head)=0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index 1a931afcf5c4..259635217a53 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -852,6 +852,7 @@ static void blk_add_trace_rq_issue(void *ignore, stru=
ct request *rq)=0A=
>  	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_ISSUE,=0A=
>  			 blk_trace_request_get_cgid(rq));=0A=
>  }=0A=
> +EXPORT_TRACEPOINT_SYMBOL_GPL(block_rq_insert);=0A=
>  =0A=
>  static void blk_add_trace_rq_merge(void *ignore, struct request *rq)=0A=
>  {=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
