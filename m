Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CD1C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E0621871
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ro3PfMHp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gHvdKPpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbfCOQLv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:11:51 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25994 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729562AbfCOQLv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 12:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1552666310; x=1584202310;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Z6nNkkUY4THAhzAoTMYRxviAX4GpPl7k25k3leQWzkc=;
  b=ro3PfMHp6++oBHBzy+zZbAzh+CfG/56LqQGLN5ICoGEZ1mc73qtnWW2O
   MQFJakh1J+8mZpOaUxShvBMRGaZRTC2xvAyvyY5AxCqjtok+EeLKoCXOU
   nTZLTnEJdIy0/xdPNp8Zm3E+00VH+1No1CrnH3XF2RxZgKqgARmMH0BB/
   +qT6kx5FRzqoMGclhsRE3RTG92uvfNwxQhD7dXDwqCzC6bZqOfHHz6aRq
   fQnAa6eGuW9eF41C98lOqqUuQOkn8TgzKmIfYMU17Todi5Z1RJ12O6JfY
   xArCpP6DKJYRDLPGajtAJG3y7pG5B9FEZ5XWgfWMfs42B90tOi/mDLDEV
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,482,1544457600"; 
   d="scan'208";a="104870648"
Received: from mail-sn1nam01lp2051.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.51])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2019 00:11:50 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQ9cuys9KAUAwkvx49N08SjqS/vi581/IsWnTEfy/PM=;
 b=gHvdKPpN2dZ/uR6HjUcMdxqqzDpGtfdLT1pW7fDnzdszuhoJ92ga5irBSEy+b3jwmqbvARYgg5efirzgARiadEG98uAU+vI+rwvgBR8hnlECickmQjtInmZFHqugK5g0cj8hQG3J3NebeiuP4NP2EJIeUbjMQrWTSZVk3G0BdyU=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB6102.namprd04.prod.outlook.com (20.178.234.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 16:11:48 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::7c30:6437:71e2:e32e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::7c30:6437:71e2:e32e%3]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 16:11:48 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Yufen Yu <yuyufen@huawei.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "marcos.souza.org@gmail.com" <marcos.souza.org@gmail.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v3] block: add a new flag BLK_MQ_POLL_CLASSIC for hybrid
 poll
Thread-Topic: [PATCH v3] block: add a new flag BLK_MQ_POLL_CLASSIC for hybrid
 poll
Thread-Index: AQHU2uZVtIf1OyCQr0aVw2/wHmC0+A==
Date:   Fri, 15 Mar 2019 16:11:47 +0000
Message-ID: <BYAPR04MB5816CEE30DB10CCF6CBE9906E7440@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190315042400.107549-1-yuyufen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 032ca97f-8d1c-49e8-d887-08d6a960ed33
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB6102;
x-ms-traffictypediagnostic: BYAPR04MB6102:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB610286161CD84F09EBF3CFD1E7440@BYAPR04MB6102.namprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(366004)(136003)(346002)(189003)(199004)(97736004)(478600001)(53546011)(66066001)(52536014)(86362001)(6436002)(53936002)(2501003)(2201001)(7736002)(476003)(446003)(5660300002)(14454004)(99286004)(7696005)(76176011)(6116002)(55016002)(3846002)(229853002)(68736007)(8676002)(14444005)(33656002)(25786009)(81166006)(6506007)(110136005)(71200400001)(71190400001)(9686003)(186003)(2906002)(316002)(305945005)(105586002)(74316002)(106356001)(102836004)(4326008)(6246003)(256004)(81156014)(26005)(72206003)(486006)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6102;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y67Ui9p2Y3qoXFv3VGwqNZigYI1eS2C3dc/vvIQ5ftO8Kq9xidl1Zrzc17vQQl2t7byXxoSCfZVxr5NZyJmYLxWNQTWFnQuk++sSqMLQ0hgjuxPuJHUfPoekpisBiAjy4isIH7fGFFzrkni3IHoHZNv2EKvkipQ5Le9XKKPybAVRw7Wln8mSRNV2tzaKO9tBiwA1aXDu+VSZhkzy4/98YmLRRlplbHdSMWNBZVoV86cxXYJRpGGtSyxBnGTXIJwjnOvhRlXKLPDWnnYoi6OL656rcwd8WtIYuej0nm+P+XrPU05NusQ8V0JsOSmyHwqlG7Y7XSqcrwD15v9Llk5AX0Hq6SJCbCsJ3HNanI+L9T9KCXuD+W5d9F6i2woRycpBaO2elgJe/B/eDtzbrAMaOKb9T1SDfaImohtD5as3XXY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032ca97f-8d1c-49e8-d887-08d6a960ed33
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 16:11:47.9555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6102
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/03/14 21:19, Yufen Yu wrote:=0A=
> For q->poll_nsec =3D=3D -1, means doing classic poll, not hybrid poll.=0A=
> We introduce a new flag BLK_MQ_POLL_CLASSIC to replace -1, which=0A=
> may make code much easier to read.=0A=
> =0A=
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>=0A=
> ---=0A=
>  block/blk-mq.c         | 4 ++--=0A=
>  block/blk-sysfs.c      | 8 ++++----=0A=
>  include/linux/blkdev.h | 3 +++=0A=
>  3 files changed, 9 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index a9c181603cbd..1c588e5c4a02 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -2857,7 +2857,7 @@ struct request_queue *blk_mq_init_allocated_queue(s=
truct blk_mq_tag_set *set,=0A=
>  	/*=0A=
>  	 * Default to classic polling=0A=
>  	 */=0A=
> -	q->poll_nsec =3D -1;=0A=
> +	q->poll_nsec =3D BLK_MQ_POLL_CLASSIC;=0A=
>  =0A=
>  	blk_mq_init_cpu_queues(q, set->nr_hw_queues);=0A=
>  	blk_mq_add_queue_tag_set(set, q);=0A=
> @@ -3392,7 +3392,7 @@ static bool blk_mq_poll_hybrid(struct request_queue=
 *q,=0A=
>  {=0A=
>  	struct request *rq;=0A=
>  =0A=
> -	if (q->poll_nsec =3D=3D -1)=0A=
> +	if (q->poll_nsec =3D=3D BLK_MQ_POLL_CLASSIC)=0A=
>  		return false;=0A=
>  =0A=
>  	if (!blk_qc_t_is_internal(cookie))=0A=
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c=0A=
> index 59685918167e..cd127067998a 100644=0A=
> --- a/block/blk-sysfs.c=0A=
> +++ b/block/blk-sysfs.c=0A=
> @@ -360,8 +360,8 @@ static ssize_t queue_poll_delay_show(struct request_q=
ueue *q, char *page)=0A=
>  {=0A=
>  	int val;=0A=
>  =0A=
> -	if (q->poll_nsec =3D=3D -1)=0A=
> -		val =3D -1;=0A=
> +	if (q->poll_nsec =3D=3D BLK_MQ_POLL_CLASSIC)=0A=
> +		val =3D BLK_MQ_POLL_CLASSIC;=0A=
>  	else=0A=
>  		val =3D q->poll_nsec / 1000;=0A=
>  =0A=
> @@ -380,8 +380,8 @@ static ssize_t queue_poll_delay_store(struct request_=
queue *q, const char *page,=0A=
>  	if (err < 0)=0A=
>  		return err;=0A=
>  =0A=
> -	if (val =3D=3D -1)=0A=
> -		q->poll_nsec =3D -1;=0A=
> +	if (val =3D=3D BLK_MQ_POLL_CLASSIC)=0A=
> +		q->poll_nsec =3D BLK_MQ_POLL_CLASSIC;=0A=
>  	else=0A=
>  		q->poll_nsec =3D val * 1000;=0A=
=0A=
You are not handling negative values other than -1 here as we discussed. An=
y=0A=
reason for not adding the check ?=0A=
=0A=
>  =0A=
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
> index 0de92b29f589..5c58a3b2bf00 100644=0A=
> --- a/include/linux/blkdev.h=0A=
> +++ b/include/linux/blkdev.h=0A=
> @@ -50,6 +50,9 @@ struct blk_stat_callback;=0A=
>  /* Must be consistent with blk_mq_poll_stats_bkt() */=0A=
>  #define BLK_MQ_POLL_STATS_BKTS 16=0A=
>  =0A=
> +/* Doing classic polling */=0A=
> +#define BLK_MQ_POLL_CLASSIC -1=0A=
> +=0A=
>  /*=0A=
>   * Maximum number of blkcg policies allowed to be registered concurrentl=
y.=0A=
>   * Defined here to simplify include dependency.=0A=
> =0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
