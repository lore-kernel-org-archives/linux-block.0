Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84739C11D2F
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 11:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520862080D
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 11:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DDYa7iyR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nn3cW907"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgBXLAZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:00:25 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28144 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgBXLAZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 06:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582542028; x=1614078028;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hZVhsDbUOVzEJsD7uhUQzzDne98U3L0QJIFTj5HZSyI=;
  b=DDYa7iyRG/y/inhHGin46wGCk3Z3LEYA6A1ym5cL7HGkoe/OOTXBm6t+
   OGQXCZfhgtiYtR16sVWzV3XMxZH+59CoVnikgB/mY+b8XFEgYZ1RfOjBI
   B0tMu4eP7p98fcjP/hVIDxVai3v1911SzLj7jzeCVlRevR2em0yxgSWwR
   Wu8GfRswxW7NOSYehC7Q+0hEjDnua26Fjka1B7QZ+p4BK5z021200axyE
   WzdP3+LUZCeKdtjgSPgZbZlI3xnNeBqXwfLnbr2vOjb421BWu+VlwDuoT
   LWxkPWz9RoSPpK7U68V6zvw9DDgD7/LtDRTdx8Hm+4EdgGdugeR7y3a9t
   g==;
IronPort-SDR: /FRBaZwlPYWe9XS9C2UMcozLi2zT6l386rNRtdHXPR91Dj8m1HKF1/lWB5TziyBJ64d7YeWWG+
 yisFgW9ZxVL1X+rh31RDNa7+fyxBioCsaKnTLdzhi0Tk/8Lpgtwa6DiDwSTNH5j3IXtjmVae5p
 SAwL2UBJBJEMkbNzj9RmiKsv8BBtPvoBMfJpW/SUqoI4Bba63vq7RpqvRQKKdtunNyen2OCzGo
 mS/kBDtyvrRIismIrzkVJTYnkKrVBDryCofqKknAUbsI3V2Wsf5324gWjH2VRLFPXAF5JiPiQ2
 LpU=
X-IronPort-AV: E=Sophos;i="5.70,479,1574092800"; 
   d="scan'208";a="232469079"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2020 19:00:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=az5j00O380NpZ7zfOerSBdKfmYFV/82P0R6f6wUSuRiOkbUJ4A2C8i0GjjgXOQWv+jPbA9GPwUNkmwpCScAoZoAI8Jl5SgWY4SaFeEQPLNDt6K9g4f8+yMRi+Jh+I931fjSX83sHuFEk27RO20UrsAPZ8XgNOzw8AjgXgy8R+fflzfZVlaOEpjhio1DBtBDC6nbKIcub7GfLU91K4FUZhBEqqsA+G7slaWrotDbX8n5Sa7ojtMw6GjLE+cvHAZtb2tx0p5FC2lEx4sGhfcx2g4MsRlAsQmXytfCLsKV8cH5XyA1VMEl4tnvM3B0OI+7VaPC62891G8SyKp4Kc9gV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN7dIOkgQx81t5VSjE7JiufBk6FGsP7gzaDbUaCMmcw=;
 b=VuNg/DQnY5q650ejp2WDvR3K39ttwPVMwNqMrNIQ9Aij4fehZH8iopUWfRKLq7agWeb3UWIEbvRKpHscyaXdqapJlwKsHJ5GHBh3t7N+ak6xAHu+ANqaXkZgqilLGvDNe+/awZUjIea0viO8ogcIFOgq3dpwj8K4PtttwuEHRZOG96hz6KNyCvECwIdo57TxqXbNtzXOl+2IlF4wOYnZPKBW4bAD2sbjgdxDG+n5u3yITAuat54D/V7BHiygd/SSyqKvhnmMmchD0TucxQNDmAmtETvu528ExiH4nKQXHrOPu0HYetFXvEpNOwvVTT9CIHdNvNJiWLwEt8RLvjrRcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN7dIOkgQx81t5VSjE7JiufBk6FGsP7gzaDbUaCMmcw=;
 b=nn3cW907xs7gaiFrBag+qe2Nb1CemuBhEenbY6FMN15EnDjqHKF1pW6TCQYvhl0CZNhpRfhAjNgW/V+NgdXjMLwyXCYuqE1ypO6wmNy2bmuMqHD7/7dYoI7+ACFwcGM08nG96dKXjm+x51ueJaaxGjrTPjDEDJOBxrdXtBBXHKs=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB5509.namprd04.prod.outlook.com (2603:10b6:a03:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Mon, 24 Feb
 2020 11:00:23 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 11:00:23 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        "syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com" 
        <syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3 2/8] blk-mq: Keep set->nr_hw_queues and
 set->map[].nr_queues in sync
Thread-Topic: [PATCH v3 2/8] blk-mq: Keep set->nr_hw_queues and
 set->map[].nr_queues in sync
Thread-Index: AQHV6GY66/xcHZksHke0l1ZyFul4Tw==
Date:   Mon, 24 Feb 2020 11:00:22 +0000
Message-ID: <BYAPR04MB5749742903B31A3ABF26580586EC0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200221032243.9708-1-bvanassche@acm.org>
 <20200221032243.9708-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [71.6.111.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9bac4ef0-557b-4d75-c749-08d7b918bef9
x-ms-traffictypediagnostic: BYAPR04MB5509:
x-microsoft-antispam-prvs: <BYAPR04MB550975D5ED993543DB47A0F386EC0@BYAPR04MB5509.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(199004)(189003)(2906002)(5660300002)(52536014)(9686003)(8676002)(4326008)(186003)(86362001)(81156014)(81166006)(316002)(110136005)(8936002)(26005)(6506007)(54906003)(53546011)(478600001)(71200400001)(55016002)(33656002)(7696005)(66446008)(76116006)(66946007)(64756008)(66476007)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5509;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SjGzs4D3kkP8LTLkXJnNXZU0n87F9fgN72RW3KtLEptmEgMu08KNeeTvKk3+U8O0TZBU7z21S2bo2oRcMzocx9MpqqwCAKbrwtzrwxy8voiB6/s5T9syArgrBoy+5aUKsXZ3LZIriA9CVOeiBOwFxZmxCG0VUAA8v1FFVV7Mg5XjZ4NtrWa8G/c5PhV936q0Hl2JLd5WESSAJ3NemBP5SEi56ygt0LtT/BRW1jSl8Z7qyfnDzI51EKxd5pJgxr3LyR7tg1Jl4Zu7iYFaZ0kvIsdpd53y+Yy9+KLJiSriSg9TJ1gBf7x30A/ocyTDO3XVKM//XMOpCUKMQJVqe+e61wzjSEeG2JqM03VOv7s+Gby+lUw/vwqQlral9vvrg1hiHmtNgvKwfidocZ0c7PTh8b2Bdh02XCdLcQYILM1Uti9OwDMR/YOF2y3DCdzWntuR
x-ms-exchange-antispam-messagedata: pexUGAA3IWLH6Shle7D3Mvzlka5SxPMCjfF74FHnFOHXkzfPt0oqhDbWFYjI88qKo49Z0k5vBpA/PhIHl016NcusmKqtr8WIk9DCnhWqHTuGqi1ZM69RBWNrNLAjIjvxP2E11RIxFPNa/mxnqtsL5w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bac4ef0-557b-4d75-c749-08d7b918bef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 11:00:22.8949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3jNReDaSmnWhZh5uTqMWbF1+b+WMlh/10hI3UrYJvkLEiPIQkK2DJQQGb+EpZXtDTDcX+/w+uzQEvC+dVsWoQcM1iG7QaptlvrwGOQHuUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5509
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This comment is very useful, thanks for this patch.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 2/20/20 7:23 PM, Bart Van Assche wrote:=0A=
> blk_mq_map_queues() and multiple .map_queues() implementations expect tha=
t=0A=
> set->map[HCTX_TYPE_DEFAULT].nr_queues is set to the number of hardware=0A=
> queues. Hence set .nr_queues before calling these functions. This patch=
=0A=
> fixes the following kernel warning:=0A=
>=0A=
> WARNING: CPU: 0 PID: 2501 at include/linux/cpumask.h:137=0A=
> Call Trace:=0A=
>  blk_mq_run_hw_queue+0x19d/0x350 block/blk-mq.c:1508=0A=
>  blk_mq_run_hw_queues+0x112/0x1a0 block/blk-mq.c:1525=0A=
>  blk_mq_requeue_work+0x502/0x780 block/blk-mq.c:775=0A=
>  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269=0A=
>  worker_thread+0x98/0xe40 kernel/workqueue.c:2415=0A=
>  kthread+0x361/0x430 kernel/kthread.c:255=0A=
>=0A=
> Cc: Christoph Hellwig <hch@infradead.org>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Cc: Hannes Reinecke <hare@suse.com>=0A=
> Cc: Johannes Thumshirn <jth@kernel.org>=0A=
> Reported-by: syzbot+d44e1b26ce5c3e77458d@syzkaller.appspotmail.com=0A=
> Fixes: ed76e329d74a ("blk-mq: abstract out queue map") # v5.0=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
=0A=
=0A=
