Return-Path: <SRS0=wI0I=WY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5076DC3A5A1
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 07:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1877B22CF5
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 07:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BZSlNRb1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NCLQdkiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbfH1Hld (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:41:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51732 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbfH1Hld (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Aug 2019 03:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566978131; x=1598514131;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ItMPrDgE9YHqWKSFhjaPPZqVHpWv1A17WDH1zWY4y40=;
  b=BZSlNRb1N6xWo61l40Gj348LaWKGuhaPS2j9j/I5NH1kBsxJaB4GGi04
   ymrUDhVWAyA2V9Zztf44Tle2NopgfNNikuGMxUjth+p2+M6Tb3HsON99m
   0y+U5ZcBgKbreMBKd447BgHpgl8yazC6RUbVBqfamdVC6oVmBJ9dvj6kF
   rCQvM9SretXg3WERg81rB7XEbdN2CeeZBPzwlmVNEHyXY5QMkGbCOblHP
   62LYCBqLkNCktuC5x3qkj9aGOe+VZDfMn4oI5GVemFL+DfSHQ7caellCd
   Hu73YmTpdPI2/iWNKL6NsvsQjietmQGKklhZh/l0m2d2POH04C5qndq8b
   g==;
IronPort-SDR: eD8B3DGEdcJnuyrWykEyKwNRjtxivjVXsHgL7qg0+EURDPId0x/LzAFG37nMeVLkQShuE3ZfGf
 kkYzw8ifpg/JUAD3r+v1/6O7i8CdzmHOHp/ew3bXLvcsZd+jbYPOV8Vjj+a0YBpNKq+XWuLlRu
 prARhsrb0EtETjDcdz2CoSqvnA7dVkg1/KkyjxVNuOzx/ZD98hflR2l9pDy7hlqJKOVjlySMct
 eEVhq9qM6SqJhYVcP+GSHXxrwcVowweavOAgSxCV4NviP+redyM6Uro3g/IuYY6Ze0jfqAJBUO
 RKY=
X-IronPort-AV: E=Sophos;i="5.64,440,1559491200"; 
   d="scan'208";a="217346550"
Received: from mail-sn1nam01lp2058.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.58])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2019 15:42:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7P+WUgK4O1XzC4AOSgUHTpX177i6nAP5AEohMFxdHfX4SxH9Sc41rqDaV2yhM6zRYSyGrBbxfXMoh7pYqrcrlnGpBITLXWAC2y7vXo6gNRYViGsVPPR+ovjGaawWKiSP8C0G4Bw8iPbOULQxvkhJ7EaiZr+ZtGPX8EWDm4CV4LvEc75A27gMzz2zuCwu9HrmXviae15FODwNhiueIILsTUQpKYGuQTibi6xJo6DKt8iT6j6ubho79hD2pw3veyPbCOTm3toSc6UzGogryMsDD4rRHO2AiCpgB7bIqzgQfr7/ZsqYxE6OuaWNZ9IY39jjjU/86WE7WoMMM+UGGY1lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruO1wDnRd6bSCaH2yilDDjyxbhqvudBSjOOUDwgvH6E=;
 b=hX9oNF8/DIVd5SvfUvmwlwX/uQWLShiNLn2eCDF93Jbugwwd0UUdXepsNNzmzSbZvw6ewHL4/yPnVelir4VUBQA9nuOLVL+qep/U43TJlw2A4mpcxuOa2EcGMdxS5+idWFEG3PvlcnZ8svcAkGlgdFmkzC8tep4j0etyKmwEf15HNEZnQXp4UAqxAORWT/uxubwdHNTk5mS+fVMZlWWeKRY5hPVlRyBN6ZLMOE3peQ2WPG0HLyrbNw3826dbLc9JLBvCKGcwFSV2L/Cx/aeECQlap0Lvnc/cuxJSdS2JE55pqWgvep9jnf5A4584lhmS1MNFA7FXCqLKk61GA7F1SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruO1wDnRd6bSCaH2yilDDjyxbhqvudBSjOOUDwgvH6E=;
 b=NCLQdkiEG5D7PsLZ5KblJ9Eyq/0kp4n7UGYzZaBJLWykraMMuT0MHm8wFeoCztaFxr67W0xxEaYMNaybZUqg7MvULLxh7QDfl6bxPqeCHdM/RoCLAg8igFBsFhtyH+kLztb/Tcj+9cNDRMKsnJCkWUzKAiimdsHKkQV44zh9DhA=
Received: from SN6PR04MB3886.namprd04.prod.outlook.com (52.135.81.151) by
 SN6PR04MB4350.namprd04.prod.outlook.com (52.135.72.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 28 Aug 2019 07:41:28 +0000
Received: from SN6PR04MB3886.namprd04.prod.outlook.com
 ([fe80::296a:3ec3:9fc5:ba8d]) by SN6PR04MB3886.namprd04.prod.outlook.com
 ([fe80::296a:3ec3:9fc5:ba8d%7]) with mapi id 15.20.2178.023; Wed, 28 Aug 2019
 07:41:28 +0000
From:   Hans Holmberg <Hans.Holmberg@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: mq-deadline: Fix queue restart handling
Thread-Topic: [PATCH] block: mq-deadline: Fix queue restart handling
Thread-Index: AQHVXVq9pUqnNzh290qoKoCvw8GekQ==
Date:   Wed, 28 Aug 2019 07:41:28 +0000
Message-ID: <SN6PR04MB38864ED05BEEAB9773F0C8DAEBA30@SN6PR04MB3886.namprd04.prod.outlook.com>
References: <20190828044020.23915-1-damien.lemoal@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Hans.Holmberg@wdc.com; 
x-originating-ip: [129.253.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36a052e0-a94c-49c8-4adf-08d72b8b22e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4350;
x-ms-traffictypediagnostic: SN6PR04MB4350:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4350B441FC54FDBE07749169EBA30@SN6PR04MB4350.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 014304E855
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(189003)(199004)(102836004)(486006)(86362001)(53936002)(76176011)(256004)(52536014)(14444005)(81166006)(186003)(26005)(81156014)(8936002)(6246003)(6436002)(305945005)(7696005)(7736002)(6116002)(8676002)(53546011)(33656002)(99286004)(25786009)(74316002)(476003)(3846002)(446003)(66556008)(55016002)(9686003)(66476007)(5660300002)(2906002)(110136005)(316002)(71190400001)(2501003)(71200400001)(66946007)(6506007)(64756008)(76116006)(91956017)(66446008)(14454004)(229853002)(66066001)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4350;H:SN6PR04MB3886.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ujJUhgdVjTXxaanHfGe2FT9II0Yw6kf+ysObaT8XE1mKf/T/yqpUT+/oGbI43IH6UreeHv4lVVIOyrfySuf1ZuqZEq5ItoBHXvnYKpWKN0aOdA3sQm/JpdovtjQAW0YN95M9NjZUQhUySTnD+BU7JQy2NgrXXZXjkZOYesmVpL1D9z8t+kkWZ/OVZ4KpJ1xBe2MWGhaXnZWTNWaWAVGjxxCq6qgS44So+xYFFBBRzRCeD77K7B1tuthyBd6T5KopyLs+zeIQXhslTZHlWK03BOIenZlHDTru78sUkBgpY5cP7bkh9vk8fjhOiZro0XTcSUCO5g4fxYv4H0BL5ghgS9h2ql9RfKFpxanxLVFtyyLaiEy8zcLfkbBwiH76sHEEXE7Ak7jWNA1RRhadcN+q12cuIofb9RWHJocK1Cm0CEE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a052e0-a94c-49c8-4adf-08d72b8b22e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2019 07:41:28.0563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1xeUj5cfYt1qCRjxbvhLBPY6rx3rvQyfSMoI+3AXOmMWiG9ckCuiJI2P7NDXyZ+Najjf2H69Z32cyd9FNrh3iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4350
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019-08-28 06:40, Damien Le Moal wrote:=0A=
> Commit 7211aef86f79 ("block: mq-deadline: Fix write completion=0A=
> handling") added a call to blk_mq_sched_mark_restart_hctx() in=0A=
> dd_dispatch_request() to make sure that write request dispatching does=0A=
> not stall when all target zones are locked. This fix left a subtle race=
=0A=
> when a write completion happens during a dispatch execution on another=0A=
> CPU:=0A=
> =0A=
> CPU 0: Dispatch			CPU1: write completion=0A=
> =0A=
> dd_dispatch_request()=0A=
>      lock(&dd->lock);=0A=
>      ...=0A=
>      lock(&dd->zone_lock);	dd_finish_request()=0A=
>      rq =3D find request		lock(&dd->zone_lock);=0A=
>      unlock(&dd->zone_lock);=0A=
>      				zone write unlock=0A=
> 				unlock(&dd->zone_lock);=0A=
> 				...=0A=
> 				__blk_mq_free_request=0A=
>                                        check restart flag (not set)=0A=
> 				      -> queue not run=0A=
>      ...=0A=
>      if (!rq && have writes)=0A=
>          blk_mq_sched_mark_restart_hctx()=0A=
>      unlock(&dd->lock)=0A=
> =0A=
> Since the dispatch context finishes after the write request completion=0A=
> handling, marking the queue as needing a restart is not seen from=0A=
> __blk_mq_free_request() and blk_mq_sched_restart() not executed leading=
=0A=
> to the dispatch stall under 100% write workloads.=0A=
> =0A=
> Fix this by moving the call to blk_mq_sched_mark_restart_hctx() from=0A=
> dd_dispatch_request() into dd_finish_request() under the zone lock to=0A=
> ensure full mutual exclusion between write request dispatch selection=0A=
> and zone unlock on write request completion.=0A=
> =0A=
> Fixes: 7211aef86f79 ("block: mq-deadline: Fix write completion handling")=
=0A=
> Cc: stable@vger.kernel.org=0A=
> Reported-by: Hans Holmberg <Hans.Holmberg@wdc.com>=0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> ---=0A=
>   block/mq-deadline.c | 19 +++++++++----------=0A=
>   1 file changed, 9 insertions(+), 10 deletions(-)=0A=
> =0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index a17466f310f4..b490f47fd553 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -377,13 +377,6 @@ static struct request *__dd_dispatch_request(struct =
deadline_data *dd)=0A=
>    * hardware queue, but we may return a request that is for a=0A=
>    * different hardware queue. This is because mq-deadline has shared=0A=
>    * state for all hardware queues, in terms of sorting, FIFOs, etc.=0A=
> - *=0A=
> - * For a zoned block device, __dd_dispatch_request() may return NULL=0A=
> - * if all the queued write requests are directed at zones that are alrea=
dy=0A=
> - * locked due to on-going write requests. In this case, make sure to mar=
k=0A=
> - * the queue as needing a restart to ensure that the queue is run again=
=0A=
> - * and the pending writes dispatched once the target zones for the ongoi=
ng=0A=
> - * write requests are unlocked in dd_finish_request().=0A=
>    */=0A=
>   static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)=
=0A=
>   {=0A=
> @@ -392,9 +385,6 @@ static struct request *dd_dispatch_request(struct blk=
_mq_hw_ctx *hctx)=0A=
>   =0A=
>   	spin_lock(&dd->lock);=0A=
>   	rq =3D __dd_dispatch_request(dd);=0A=
> -	if (!rq && blk_queue_is_zoned(hctx->queue) &&=0A=
> -	    !list_empty(&dd->fifo_list[WRITE]))=0A=
> -		blk_mq_sched_mark_restart_hctx(hctx);=0A=
>   	spin_unlock(&dd->lock);=0A=
>   =0A=
>   	return rq;=0A=
> @@ -561,6 +551,13 @@ static void dd_prepare_request(struct request *rq, s=
truct bio *bio)=0A=
>    * spinlock so that the zone is never unlocked while deadline_fifo_requ=
est()=0A=
>    * or deadline_next_request() are executing. This function is called fo=
r=0A=
>    * all requests, whether or not these requests complete successfully.=
=0A=
> + *=0A=
> + * For a zoned block device, __dd_dispatch_request() may have stopped=0A=
> + * dispatching requests if all the queued requests are write requests di=
rected=0A=
> + * at zones that are already locked due to on-going write requests. To e=
nsure=0A=
> + * write request dispatch progress in this case, mark the queue as needi=
ng a=0A=
> + * restart to ensure that the queue is run again after completion of the=
=0A=
> + * request and zones being unlocked.=0A=
>    */=0A=
>   static void dd_finish_request(struct request *rq)=0A=
>   {=0A=
> @@ -572,6 +569,8 @@ static void dd_finish_request(struct request *rq)=0A=
>   =0A=
>   		spin_lock_irqsave(&dd->zone_lock, flags);=0A=
>   		blk_req_zone_write_unlock(rq);=0A=
> +		if (!list_empty(&dd->fifo_list[WRITE]))=0A=
> +			blk_mq_sched_mark_restart_hctx(rq->mq_hctx);=0A=
>   		spin_unlock_irqrestore(&dd->zone_lock, flags);=0A=
>   	}=0A=
>   }=0A=
> =0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Hans Holmberg <hans.holmberg@wdc.com>=0A=
=0A=
