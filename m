Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF802C432C3
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 23:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5D720723
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 23:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GXQOfi/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfKOXZR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 18:25:17 -0500
Received: from mail-eopbgr760120.outbound.protection.outlook.com ([40.107.76.120]:2726
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727056AbfKOXZQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 18:25:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8s09YNn5fnD2P51ET9s2PFDT0KJZhuovdpEPtlTEjxjgwreckr+na/UBLnDp72VY9TTEExtyOuNncyoN7D0tUK3/sP5zr7XjGgGbhyaARud1dtKPnWmp5ANqLiVzY4sE1TADCAfV1lPu1NBjdkyuM7xWTKbECCofp1gdh9FVwonNJvS94XfeLwDBK883uacx/WvignBxpkbnghMc4/l8eOcGHXxwkWasnql7RnJYxSNYt8EROtBgS84DXn0vuoXwDfDVCzaC1+/+kJW/go8U6/Vj18ovww3etokPaXuNiGUbHxqgZu1e802QWp/gqBF2jupgPNXKA+a2xFBUsjzBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAKNRfQgssSYLB6eJy9iGvG11+Cf2pTVROIa2Ya8F20=;
 b=cMd/bLvnXg2ndcxWFwHMc6j+cy0bnaO+KIFNGWfIJtfiPRkjnGkJ3x26YvzM2AyJlQrXn5Yi3Sc0bEY6JJRfxVoef7VvtFx9BWrP60uDW1g9B/XJah4zx2y5hKAYQpQuMsUsZj4Fm+rRYZ0fZml4Yh3rMPGEhZCHz8gixnUcZnn3nktlTuDjbHgd6exRBDxR2ZfMtTqAeJnNmX6rlrIlU9B6y2ZzZ75nBPYxDa7xwFkZ9BH/F8bKFIzV90HsxJBTy9T0BWkTUlA2SipogYUAfa4L8QHN8ZQxD7pTBzdjkaz+i5Mkj+D5ElwxyNHzLDZ3qzS0J+hEJT74d77bZaK7eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAKNRfQgssSYLB6eJy9iGvG11+Cf2pTVROIa2Ya8F20=;
 b=GXQOfi/CVMq0s9s2Qzi1eX2NRKC/oCzW3PdVWNwNip7/4JKyhuEeAXapPtrrPa8DMNOkH9sq7IW3gON9AIt/BjJc4E37VKb+yE9FSkef9gUe9DMJFbswQe8wBa3wConjZDDBsS/MCpFuErOJKHEnWltQ88XwVtZslnppbXfUKFw=
Received: from BL0PR2101MB1123.namprd21.prod.outlook.com (52.132.20.151) by
 BL0PR2101MB1105.namprd21.prod.outlook.com (52.132.24.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.5; Fri, 15 Nov 2019 23:25:13 +0000
Received: from BL0PR2101MB1123.namprd21.prod.outlook.com
 ([fe80::18a7:20ab:be1b:bbd4]) by BL0PR2101MB1123.namprd21.prod.outlook.com
 ([fe80::18a7:20ab:be1b:bbd4%9]) with mapi id 15.20.2474.009; Fri, 15 Nov 2019
 23:25:13 +0000
From:   Long Li <longli@microsoft.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] blk-mq: avoid repeatedly scheduling the same work to run
 hardware queue
Thread-Topic: [PATCH] blk-mq: avoid repeatedly scheduling the same work to run
 hardware queue
Thread-Index: AQHVmz4TqQ91Pi79cEuXS8Pqo/p+fKeM3FCA
Date:   Fri, 15 Nov 2019 23:25:13 +0000
Message-ID: <BL0PR2101MB1123D0597E3759918F3A0B11CE700@BL0PR2101MB1123.namprd21.prod.outlook.com>
References: <1573771884-38879-1-git-send-email-longli@linuxonhyperv.com>
 <BYAPR04MB5816F14C06B4D2AC71A2FED9E7700@BYAPR04MB5816.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB5816F14C06B4D2AC71A2FED9E7700@BYAPR04MB5816.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=longli@microsoft.com; 
x-originating-ip: [2001:4898:80e8:2:edec:db5c:c6fe:798]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61445097-43c7-4c24-cca2-08d76a2310bb
x-ms-traffictypediagnostic: BL0PR2101MB1105:
x-microsoft-antispam-prvs: <BL0PR2101MB110572C4F7A27AB1581C3953CE700@BL0PR2101MB1105.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02229A4115
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(39860400002)(136003)(346002)(199004)(189003)(9686003)(186003)(11346002)(76176011)(7696005)(55016002)(52536014)(2501003)(81156014)(229853002)(74316002)(305945005)(8990500004)(8676002)(33656002)(2201001)(86362001)(7736002)(5660300002)(14444005)(256004)(476003)(478600001)(10090500001)(10290500003)(486006)(2906002)(81166006)(14454004)(8936002)(46003)(446003)(6246003)(66946007)(6436002)(102836004)(6116002)(110136005)(316002)(66446008)(64756008)(66556008)(66476007)(76116006)(25786009)(71190400001)(6506007)(22452003)(71200400001)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1105;H:BL0PR2101MB1123.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1M8LGtu4JSZr1CVsG2ZmhRZSESTGJsfWWiLTcIlRzbDn75rnwJ2zfgv/F8pU8uAanlc3bmrUir8IEl0s+TcLaldYv8sqqSxKwpZVK7EHiV5FdnitEMgU7JnqwhHmlFMScLAs9XPakl8kywedHQJYIv8x3KhxSxXVH5FTF4iW6JX2QIIUAJa0iF7moNMjKixDU9CPlORK7yCn3HYRFLeEHi6Y6iDhclDVEBtK324/VgmNAivBDR32050aF5fB0cp7bb/2hQ92YDHLjtY2FNJPWq5WDSpm1JccU9/pedeVeOZWtGZ8YF5wskw30SroT4e8YcCZc9WZ4AFg0aO2UuJV6JvRewCAowNxgqhrEJrUeK5fuLdPSNWu6liQzzW8wNIvE08X1glVicBsZOQ0NLzF5C7hlHAN6xGcQXFY0f2dbGviGEDCYJuQZjMaefP3kCnp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61445097-43c7-4c24-cca2-08d76a2310bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2019 23:25:13.2324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFX09KLvAGU5EIZVaU3Et7xgQbPw4CPcPCU7toBg/ZwrfceqWo/FVweaEKKrNMdZbB5paemGeOHOy/f4BELSxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1105
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>Subject: Re: [PATCH] blk-mq: avoid repeatedly scheduling the same work to
>run hardware queue
>
>On 2019/11/15 7:51, longli@linuxonhyperv.com wrote:
>> From: Long Li <longli@microsoft.com>
>>
>> SCSI layer calls blk_mq_run_hw_queues() in scsi_end_request(), for
>> every completed I/O. blk_mq_run_hw_queues() in turn schedules some
>> works to run the hardware queues.
>>
>> The actual work is queued by mod_delayed_work_on(), it turns out the
>> cost of this function is high on locking and CPU usage, when the I/O
>> workload has high queue depth. Most of these calls are not necessary
>> since the queue is already scheduled to run, and has not run yet.
>>
>> This patch tries to solve this problem by avoiding scheduling work
>> when it's already scheduled.
>>
>> Benchmark results:
>> The following tests are run on a RAM backed virtual disk on Hyper-V,
>> with 8 FIO jobs with 4k random read I/O. The test numbers are for IOPS.
>>
>> queue_depth	pre-patch	after-patch	improvement
>> 16		190k		190k		0%
>> 64		235k		240k		2%
>> 256		180k		256k		42%
>> 1024		156k		250k		60%
>>
>> Signed-off-by: Long Li <longli@microsoft.com>
>> ---
>>  block/blk-mq.c         | 12 ++++++++++++
>>  include/linux/blk-mq.h |  1 +
>>  2 files changed, 13 insertions(+)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c index
>> ec791156e9cc..a882bd65167a 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -1476,6 +1476,16 @@ static void
>__blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
>>  		put_cpu();
>>  	}
>>
>> +	/*
>> +	 * Queue a work to run queue. If this is a non-delay run and the
>> +	 * work is already scheduled, avoid scheduling the same work again.
>> +	 */
>> +	if (!msecs) {
>> +		if (test_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state))
>> +			return;
>
>With this change, if the kblockd work is already scheduled with a delay, t=
hen
>the current no-delay run request will incur a delay because
>kblockd_mod_delayed_work_on() is not called, implying that
>__queue_delayed_work() does not execute __queue_work() as mandated
>by the 0 delay. The work is *not* started immediately.

BLK_MQ_S_WORK_QUEUED is not touched if this is for a delayed kblockd work, =
so the following non-delayed runs will get immediately scheduled.

But I think you have raised a valid point for delayed runs, consider the fo=
llowing sequence with three calls with quick succession.

1. __blk_mq_delay_run_hw_queue with no delay (this will set BLK_MQ_S_WORK_Q=
UEUED)
2. __blk_mq_delay_run_hw_queue with a delay (this will modify the kblockd w=
ork if the work is not fired)
3. __blk_mq_delay_run_hw_queue with no delay (this will not do anything sin=
ce BLK_MQ_S_WORK_QUEUED is already set)

This sequence can potentially wait until 2 fires. Ideally it should fire im=
mediately at step 3.

I will send v2 to address this.

>
>While your results show improvements of IOPS at high queue depth, doesn't
>this change degrade IOPS and especially latency at low queue depth ?

Here are additional tests done in Azure and Hyper-v, with the patch:
NVMe showed little difference at all queue depths. (Samsung P983 and P963)
SCSI showed little difference when queue depth <64. (RAM disk and local VHD=
)


Long

>
>> +		set_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state);
>> +	}
>> +
>>  	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
>&hctx->run_work,
>>  				    msecs_to_jiffies(msecs));
>>  }
>> @@ -1561,6 +1571,7 @@ void blk_mq_stop_hw_queue(struct
>blk_mq_hw_ctx *hctx)
>>  	cancel_delayed_work(&hctx->run_work);
>>
>>  	set_bit(BLK_MQ_S_STOPPED, &hctx->state);
>> +	clear_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state);
>>  }
>>  EXPORT_SYMBOL(blk_mq_stop_hw_queue);
>>
>> @@ -1626,6 +1637,7 @@ static void blk_mq_run_work_fn(struct
>work_struct *work)
>>  	struct blk_mq_hw_ctx *hctx;
>>
>>  	hctx =3D container_of(work, struct blk_mq_hw_ctx, run_work.work);
>> +	clear_bit(BLK_MQ_S_WORK_QUEUED, &hctx->state);
>>
>>  	/*
>>  	 * If we are stopped, don't run the queue.
>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h index
>> 0bf056de5cc3..98269d3fd141 100644
>> --- a/include/linux/blk-mq.h
>> +++ b/include/linux/blk-mq.h
>> @@ -234,6 +234,7 @@ enum {
>>  	BLK_MQ_S_STOPPED	=3D 0,
>>  	BLK_MQ_S_TAG_ACTIVE	=3D 1,
>>  	BLK_MQ_S_SCHED_RESTART	=3D 2,
>> +	BLK_MQ_S_WORK_QUEUED	=3D 3,
>>
>>  	BLK_MQ_MAX_DEPTH	=3D 10240,
>>
>>
>
>
>--
>Damien Le Moal
>Western Digital Research
