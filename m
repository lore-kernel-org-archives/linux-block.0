Return-Path: <SRS0=DCcP=XU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C78C432C2
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 23:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16CB21D7B
	for <linux-block@archiver.kernel.org>; Wed, 25 Sep 2019 23:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ekMQcWNm";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WtlNpLF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbfIYXig (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Sep 2019 19:38:36 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:58060 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbfIYXif (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Sep 2019 19:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1569454715; x=1600990715;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dZU1dt2CuAPZGcLai+I0TodAgCowwOMtqybKMDsbmUg=;
  b=ekMQcWNmZ12Y1wGMd1DOHAREtjP6WseoXsF6UKRUwYF8Ou2szsYZqk3b
   FJSBY3SWYiXlKH5TiyQ1++AF24hiGJfJIWJXQcXZtfvPHTzkYcjQ0QkBz
   DC4DTDid19i93+jEpzpVO434dJ6tkL4wDM8a5ZATF4BMEGI8l+zbQMQRm
   3AnUMDTm9FKMmQwnnvQMgKOokfhAmZSxfAW+mn2TWf4tdsjoHw9Ei4I0Q
   JUKr1unjOdOaHtFL4ABmkEdB2ZdE0+ecuTdY2dDUEfeI4n33gEFKM0q0M
   jEJtDrsR76kX4fTp5AftC0bJs6jEtP8FUA6TYF/pFLABuQGfw1vxgRJAO
   g==;
IronPort-SDR: ZK8anENhQWcxUsZ/8s7Z4hS2KrYGCnruSbbs+05MlZmMlE9fwjfhFkRFPVusbdwv4v1rfI+zlK
 9WgLIUOKbgKZ9X6pZf+GwoJjOk3SPlFhJeg+Skk1mP1jBlciA0HjKFeJAUDszNcK7i7j1TgQ7H
 8U++7XKck462oZA2YTCOApjtvrJ2/eZMqtqsJzT9HND9k5YE+wXs7Wqm1PRdcJOJenaLoq176U
 QTZVbA4xAkOpU9M3km/0Ofeg+ktjrzgvXKu6wI4D+tSZRYvOKFVAP4NDFJ4LpKtx/whdtgKbKV
 Zdo=
X-IronPort-AV: E=Sophos;i="5.64,549,1559491200"; 
   d="scan'208";a="225961304"
Received: from mail-by2nam05lp2057.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.57])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2019 07:38:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aa2Z//MtDfXFQf+bK8VD/fBcsm4PwFlJ+NPLj4Ut3LVsn9zOUgwc1Grhwjw58QZmFYJEElKqR6knpZgXgluQijqYptXhvNJD/kWHeDt0jqHV0qyUCfinJN0dod35sAseLnvaB980/P5/4GlzqiM4zSlSMdRxF1tL5J4Lpa8IzUZkSXI2yLZ+EIY7jp7onff7bqLrV+bFKsGw1N+8//ZcH8RbdqbennZ27tvzM1R48Ff6puU3gh1wJ8Onnogxze4Nn4eWKTp/mZGRIGGvM+5P3rv+6khZmNW+Ppjn9iYsz2heKS2qbm5kKGV6l6Zqu1YzMSlKzjhpRdK6PdPwyaRaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXlBz34/coDwro0QFk2OiNZuxJ3CGwBo6rm+RhiT0NU=;
 b=TrGEI1JSyh0yhUWefW5jqfCvMyzUe62VGvEVeB7g8Rp/cBrlpUez/v4aNpZ4Gq2Ttf7G1jwOhRBrlWXa9v5JTcypLLMXrv+ShNEAtEX3k9UZV/hOPDDaYbGil837AFKUxxUiYd4daEcLscu8pfbYydnzlUlq9araKdEpXS3byjGSdABRtds2PSFAHpCD8e+cRvjUaWxatKHpRhUJi3dG2LBhwsDG3wjZJJ8GyOjUI1w8KssK1gseuReQ/eHSr69PwaViUBUwON4CMFTtb4BI58nFOqxK3KprxElOwOxZmBhkWq+3gmER3aMHkiFIDE5wStXy3F0Sif/Q4gM4hnlIdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OXlBz34/coDwro0QFk2OiNZuxJ3CGwBo6rm+RhiT0NU=;
 b=WtlNpLF2GH2BYm3l8/G+1Qcs6A7SIGxMlMmlwm0gazYD8N+16KLy8yWwSm9FaROP/qt/BZFqY9eEASAOSGxrObqvTfefvFG4A2yzs9zKsSqsCPr2KqE42LfsAqXCEGsiXnm82uKB3Yi95or9t8JpMSTxL4MeuCY5boIZyrFKfSc=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4342.namprd04.prod.outlook.com (52.135.203.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Wed, 25 Sep 2019 23:38:34 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117%3]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 23:38:34 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "syzbot+da3b7677bb913dc1b737@syzkaller.appspotmail.com" 
        <syzbot+da3b7677bb913dc1b737@syzkaller.appspotmail.com>
Subject: Re: [PATCH] blk-mq: move lockdep_assert_held() into elevator_exit
Thread-Topic: [PATCH] blk-mq: move lockdep_assert_held() into elevator_exit
Thread-Index: AQHVc+/xPtUH/Dfxe0C6DzIg4T0SIA==
Date:   Wed, 25 Sep 2019 23:38:33 +0000
Message-ID: <BYAPR04MB5816A08ABECFFCB042C6CD3BE7870@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190925222354.26152-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fcc245d-76d5-49ba-8c68-08d742117aef
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: BYAPR04MB4342:
x-microsoft-antispam-prvs: <BYAPR04MB4342C4AEB19713FD38CE30B6E7870@BYAPR04MB4342.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(199004)(189003)(486006)(305945005)(186003)(7736002)(6116002)(3846002)(71200400001)(52536014)(6246003)(66476007)(71190400001)(229853002)(8936002)(5660300002)(76116006)(54906003)(74316002)(102836004)(66556008)(64756008)(66446008)(66946007)(316002)(446003)(25786009)(256004)(476003)(33656002)(14454004)(110136005)(478600001)(6436002)(26005)(9686003)(55016002)(2906002)(8676002)(66066001)(81166006)(81156014)(76176011)(53546011)(6506007)(4326008)(99286004)(7696005)(14444005)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4342;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vqZW9xd6SPxVLtv0e25SZMv0v8X1CHfAuxkeA4lAwH5Zco78r2egOQE/1SbVHC08241B9ndJD2zNuTkMLnKEAl6MZojIOpNMsQ/hyX3J+CSci4XxpwQ6OVRRQBhuaeWJIj+CyBXKudqrI8udvgd5enfLaHU/GQD3SgAG8KsFUNQDGqmKJ6w5SvTY5o+weHJptK1nSwBWkCApnwhknJhMWNJ+u40UZ2cJg6Dr6IZeL3md5FARseYF0aNaAB5piHGGb8Hz3LE1i2xczNrYlQLzPdrBb5QQSZVeJ9Y/etih/wf+v9U1jpoxX1AoAbfV6PhvxeUnVQQkwx6xnorIzviI/aGk+BGJfChO0JOAV0B5MiMinXgFzVKj3utbwfTPvnAORrYaPINegeM01rMlwkFxQw/zMrzcJvoEuwF8+M50DjU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcc245d-76d5-49ba-8c68-08d742117aef
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 23:38:33.9841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LSJOyoZBB65kZ+oj5JYCx8kPElRlStrqO1z12g6473s5LHsFlEnnTScKbH/VcjYT5o/r+vUPmyLlj4Qd7C0bIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4342
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/09/25 15:24, Ming Lei wrote:=0A=
> Commit c48dac137a62 ("block: don't hold q->sysfs_lock in elevator_init_mq=
")=0A=
> removes q->sysfs_lock from elevator_init_mq(), but forgot to deal with=0A=
> lockdep_assert_held() called in blk_mq_sched_free_requests() which is=0A=
> run in failure path of elevator_init_mq().=0A=
> =0A=
> blk_mq_sched_free_requests() is called in the following 3 functions:=0A=
> =0A=
> 	elevator_init_mq()=0A=
> 	elevator_exit()=0A=
> 	blk_cleanup_queue()=0A=
> =0A=
> In blk_cleanup_queue(), blk_mq_sched_free_requests() is followed exactly=
=0A=
> by 'mutex_lock(&q->sysfs_lock)'.=0A=
> =0A=
> So moving the lockdep_assert_held() from blk_mq_sched_free_requests()=0A=
> into elevator_exit() for fixing the report by syzbot.=0A=
> =0A=
> Cc: Bart Van Assche <bvanassche@acm.org>=0A=
> Cc: Damien Le Moal <Damien.LeMoal@wdc.com>=0A=
> Reported-by: syzbot+da3b7677bb913dc1b737@syzkaller.appspotmail.com=0A=
> Fixed: c48dac137a62 ("block: don't hold q->sysfs_lock in elevator_init_mq=
")=0A=
> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
> ---=0A=
>  block/blk-mq-sched.c | 2 --=0A=
>  block/blk.h          | 2 ++=0A=
>  2 files changed, 2 insertions(+), 2 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c=0A=
> index c9d183d6c499..ca22afd47b3d 100644=0A=
> --- a/block/blk-mq-sched.c=0A=
> +++ b/block/blk-mq-sched.c=0A=
> @@ -555,8 +555,6 @@ void blk_mq_sched_free_requests(struct request_queue =
*q)=0A=
>  	struct blk_mq_hw_ctx *hctx;=0A=
>  	int i;=0A=
>  =0A=
> -	lockdep_assert_held(&q->sysfs_lock);=0A=
> -=0A=
>  	queue_for_each_hw_ctx(q, hctx, i) {=0A=
>  		if (hctx->sched_tags)=0A=
>  			blk_mq_free_rqs(q->tag_set, hctx->sched_tags, i);=0A=
> diff --git a/block/blk.h b/block/blk.h=0A=
> index ed347f7a97b1..25773d668ec0 100644=0A=
> --- a/block/blk.h=0A=
> +++ b/block/blk.h=0A=
> @@ -194,6 +194,8 @@ void elv_unregister_queue(struct request_queue *q);=
=0A=
>  static inline void elevator_exit(struct request_queue *q,=0A=
>  		struct elevator_queue *e)=0A=
>  {=0A=
> +	lockdep_assert_held(&q->sysfs_lock);=0A=
> +=0A=
>  	blk_mq_sched_free_requests(q);=0A=
>  	__elevator_exit(q, e);=0A=
>  }=0A=
> =0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
