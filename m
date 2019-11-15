Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C03FC432C3
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 02:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD207206D6
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 02:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a0nc/dg7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CGRvGb3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfKOCNd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Nov 2019 21:13:33 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30896 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfKOCNd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Nov 2019 21:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573784013; x=1605320013;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yiuVgiPzSlQrNY+uHBTuH7/ln0QaFiTuTWj/EANPpVQ=;
  b=a0nc/dg70Oy3ohA6NAfANHvIsqK+gGAjwpEu+1B4e8DRcf01rSPOXtaD
   S6Mi3phXT/6fnEw8mt9xGSkeNFIMHLbKVvH/iCnfhjvHY0smiy8wJI8pA
   SiJSgG5OuqwKsH8UDalFSVge3esr1TE4C/tztBeQjpU38sHovqPNA03+d
   iEqhPpViBS+ftZqSfrydnIkeD1c94RiEw9R2voK73UgrhuwTLpvqQlgI+
   5yZK04Ndq+yq7kZMRf4lZ6D7C7NWBG2kXHPKnVuLy1bDKh5/7/ABhfbsO
   xHOf7EJ8Lcgxu1dVyO22aH4Eh6tkhOVrfa1VYkuUd322LxYILVAvME/Dh
   A==;
IronPort-SDR: dwN4GaUF89rzVtLm9mPFjYW4OYKTOmG8pdU9MpNFiUmLxYBf1QcmMQ3ANPrP9H5u2LrGsqMJiO
 VwXkWI5vuz8rkAhqYxPQkAYy322nKmkt0mG/ZoaXNkeAwJOY27b+7MVfB5UgKXZ9aeTgsVNeDq
 moMpDNCBR6L7yT9kP6jxR/ZsN9BQdUHB7r5ZNvFdr+5Rclwh5JR3TZJ6+ouTIyVUmmi54yjgAy
 qqeZbXYQP230BgrawlQH6vF2D78pqgz2zpoP7SWC4MQzb28/vhmfh05h69IrwrFNw/vhFHUBbz
 gEM=
X-IronPort-AV: E=Sophos;i="5.68,306,1569254400"; 
   d="scan'208";a="123837943"
Received: from mail-sn1nam04lp2058.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.58])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2019 10:13:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpkrnlAEv3GHWXuNzohCDqVItvpjh7XYIDcddUU7ZSXYN8hOcEUqgf7PNC/1N9JHIw08ngEEghjH9JGi0oKo1d2Ce3yiojZT1LXaVLx8qrCd8lMDkveAMCpcPrKazBNNjbIm4GNqPWJisLvzDgdHpkYkS9AlHezHVwzu4AN8W2R73qfCYjNS3PFxm274ZFFKhMFKDpXduJ9tGabPEZhOueC7OS2ennHjLspnrsJs4GqOwuj8mTQS2HlltwkpqxdtOIdUL6TeobU2V9Lajr81t2UHKiQqxHM3f/RENtfeW0M2ZLadBXgs6lC9D6TEaJChUJDHZ/lwvIWLNUpNgy6Qsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fucLoAmBfsr9nCESF9UsSwdKZylW0bCrrR2xq7b185o=;
 b=ALpvhNekJSExKyvb+xPmeuNj2/icKpf5zqVevhYvkHxqJTsDqKwCIy5VGxJY9lNKifbH748AynzzcRnnW/UHZoKv6uRSDOOVK/NsHA8ada+fOL35FkOwR4xhZ7nDN4uaBN2h43Q5pH9UigayeFxU8UBBiPtGnjMK6A1g64netCUzhmiqoFy3JL8VcHcYDpPN8GiZ1ni8HzApIyK+SijTYmzdS9XU/U+JCSOan7+OWOuGdH7G3AekkYezudmfDLWsR2bj32pYrs6EiZz4BXUk5Bq+blyS8oATBYCQCsS6eIMIEi4kDcfOAOye8w6bUzeSHfs2X4XnHsxtGyj/fM5uqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fucLoAmBfsr9nCESF9UsSwdKZylW0bCrrR2xq7b185o=;
 b=CGRvGb3+mSgda3rgDyEsRMJ+V4UsNPTbziYz0hXCP5ETYaL6Dr+2Be/lwAE345dwe3yr1D9Bsg69DobDbQgNa6ZT53sTsuVwBqBLyReMKvu6JYhgnquYpZpZzxf10smHlEW/y5KPg6NiwFe+15fciuPm1tX2OUtQMbg/Lo91+Gg=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5974.namprd04.prod.outlook.com (20.178.235.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Fri, 15 Nov 2019 02:13:29 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40%7]) with mapi id 15.20.2430.028; Fri, 15 Nov 2019
 02:13:29 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>
Subject: Re: [PATCH] blk-mq: avoid repeatedly scheduling the same work to run
 hardware queue
Thread-Topic: [PATCH] blk-mq: avoid repeatedly scheduling the same work to run
 hardware queue
Thread-Index: AQHVmz4UK1WchWvq4UCn2IWDjskncw==
Date:   Fri, 15 Nov 2019 02:13:29 +0000
Message-ID: <BYAPR04MB5816F14C06B4D2AC71A2FED9E7700@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <1573771884-38879-1-git-send-email-longli@linuxonhyperv.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bafb6dc4-8660-4e25-081d-08d769716829
x-ms-traffictypediagnostic: BYAPR04MB5974:
x-microsoft-antispam-prvs: <BYAPR04MB5974DB3A78954894502C0849E7700@BYAPR04MB5974.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(376002)(136003)(346002)(39860400002)(189003)(199004)(7736002)(476003)(99286004)(305945005)(478600001)(74316002)(6116002)(3846002)(66066001)(14454004)(256004)(14444005)(5660300002)(110136005)(446003)(486006)(71190400001)(71200400001)(81156014)(66476007)(81166006)(52536014)(102836004)(76176011)(2501003)(8936002)(6436002)(66946007)(7696005)(66446008)(2906002)(25786009)(316002)(2201001)(66556008)(33656002)(64756008)(186003)(86362001)(4326008)(53546011)(9686003)(8676002)(229853002)(26005)(6506007)(91956017)(76116006)(6246003)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5974;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KnVEiu6DInZ4OnO7VdcIY7/WXAxAGvQOHznZ6e1AuiLidQodIc1hAnKE7L55VW+MB6o//sgGEtwSA0AyCvz2dXFvgICnrhKO8PxSYh/67B4PJKpesZPlRTLHhUguPbI8ncPKomBAvn940KBLGV/3ss++BiXHpiowOBNLMtbr+KFGvwnqzLU/8VJRvz+16SONc7ZZ1pE4xE+RlKBToArnYrtmMC0GQFPNmH7548LCvb97Z2Mj6BWnu7dQN6NoX6vhazyR+uYac6qp8o/EZ/8GEhfdz8GDzj0U8Fr74hwh3xSfXHe1LaGZLdvgbIS0neWRsAJIHy4UTWjILEReT1pSOJlbOynr022WfP/lYFSoIJ+4/xMVR32laxzkXM7QvYpc40ymI/zSzHqqgVMMntVxuCrCtqp3ruavtQcrSiiMnPQMZatufVshgchexKM/ExSO
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafb6dc4-8660-4e25-081d-08d769716829
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 02:13:29.3786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ic5bE31D4GgPvBECGFTeERh53um1M6rPdWarx7oeoiegXrnHXeuyqOKRWnzJQ8eR5xNjdNZ3BrqaJ+we/hJ8zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5974
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/11/15 7:51, longli@linuxonhyperv.com wrote:=0A=
> From: Long Li <longli@microsoft.com>=0A=
> =0A=
> SCSI layer calls blk_mq_run_hw_queues() in scsi_end_request(), for every=
=0A=
> completed I/O. blk_mq_run_hw_queues() in turn schedules some works to run=
=0A=
> the hardware queues.=0A=
> =0A=
> The actual work is queued by mod_delayed_work_on(), it turns out the cost=
 of=0A=
> this function is high on locking and CPU usage, when the I/O workload has=
=0A=
> high queue depth. Most of these calls are not necessary since the queue i=
s=0A=
> already scheduled to run, and has not run yet.=0A=
> =0A=
> This patch tries to solve this problem by avoiding scheduling work when i=
t's=0A=
> already scheduled.=0A=
> =0A=
> Benchmark results:=0A=
> The following tests are run on a RAM backed virtual disk on Hyper-V, with=
 8=0A=
> FIO jobs with 4k random read I/O. The test numbers are for IOPS.=0A=
> =0A=
> queue_depth	pre-patch	after-patch	improvement=0A=
> 16		190k		190k		0%=0A=
> 64		235k		240k		2%=0A=
> 256		180k		256k		42%=0A=
> 1024		156k		250k		60%=0A=
> =0A=
> Signed-off-by: Long Li <longli@microsoft.com>=0A=
> ---=0A=
>  block/blk-mq.c         | 12 ++++++++++++=0A=
>  include/linux/blk-mq.h |  1 +=0A=
>  2 files changed, 13 insertions(+)=0A=
> =0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index ec791156e9cc..a882bd65167a 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -1476,6 +1476,16 @@ static void __blk_mq_delay_run_hw_queue(struct blk=
_mq_hw_ctx *hctx, bool async,=0A=
>  		put_cpu();=0A=
>  	}=0A=
>  =0A=
> +	/*=0A=
> +	 * Queue a work to run queue. If this is a non-delay run and the=0A=
> +	 * work is already scheduled, avoid scheduling the same work again.=0A=
> +	 */=0A=
> +	if (!msecs) {=0A=
> +		if (test_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state))=0A=
> +			return;=0A=
=0A=
With this change, if the kblockd work is already scheduled with a delay,=0A=
then the current no-delay run request will incur a delay because=0A=
kblockd_mod_delayed_work_on() is not called, implying that=0A=
__queue_delayed_work() does not execute __queue_work() as mandated by=0A=
the 0 delay. The work is *not* started immediately.=0A=
=0A=
While your results show improvements of IOPS at high queue depth,=0A=
doesn't this change degrade IOPS and especially latency at low queue depth =
?=0A=
=0A=
> +		set_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state);=0A=
> +	}=0A=
> +=0A=
>  	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work=
,=0A=
>  				    msecs_to_jiffies(msecs));=0A=
>  }=0A=
> @@ -1561,6 +1571,7 @@ void blk_mq_stop_hw_queue(struct blk_mq_hw_ctx *hct=
x)=0A=
>  	cancel_delayed_work(&hctx->run_work);=0A=
>  =0A=
>  	set_bit(BLK_MQ_S_STOPPED, &hctx->state);=0A=
> +	clear_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state);=0A=
>  }=0A=
>  EXPORT_SYMBOL(blk_mq_stop_hw_queue);=0A=
>  =0A=
> @@ -1626,6 +1637,7 @@ static void blk_mq_run_work_fn(struct work_struct *=
work)=0A=
>  	struct blk_mq_hw_ctx *hctx;=0A=
>  =0A=
>  	hctx =3D container_of(work, struct blk_mq_hw_ctx, run_work.work);=0A=
> +	clear_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state);=0A=
>  =0A=
>  	/*=0A=
>  	 * If we are stopped, don't run the queue.=0A=
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h=0A=
> index 0bf056de5cc3..98269d3fd141 100644=0A=
> --- a/include/linux/blk-mq.h=0A=
> +++ b/include/linux/blk-mq.h=0A=
> @@ -234,6 +234,7 @@ enum {=0A=
>  	BLK_MQ_S_STOPPED	=3D 0,=0A=
>  	BLK_MQ_S_TAG_ACTIVE	=3D 1,=0A=
>  	BLK_MQ_S_SCHED_RESTART	=3D 2,=0A=
> +	BLK_MQ_S_WORK_QUEUED	=3D 3,=0A=
>  =0A=
>  	BLK_MQ_MAX_DEPTH	=3D 10240,=0A=
>  =0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
