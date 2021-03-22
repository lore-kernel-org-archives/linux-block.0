Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67699C433C1
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 00:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E4CE6148E
	for <linux-block@archiver.kernel.org>; Mon, 22 Mar 2021 00:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhCVAnE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Mar 2021 20:43:04 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24849 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVAme (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Mar 2021 20:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616373754; x=1647909754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6NseOB8Adpimx+aruj3qoVvEG5kliMCcLjAjdSQvrxo=;
  b=lGJOvCRw+8K2ZLpUPDhewrCm1Cwi2oSqN2imLjXJq7Ik2Jupdo9H0h2z
   7+/A76oAJWr+aGMmuJGlEd0XmaUlnfcnDT46L7mQLNxg7HN7Oag5BO40H
   c7c+/SAkttSstaFOSE19m30/ZL/egiCHVebFfRFSU5TlKWksC5nvZpFjD
   6l+3PILc1xvpCv2FSa2KlpDdiaG7vRlB2LMu1sD+xltDPfkwpxaoyYZHH
   N5ZWhld3TX4WKIi+ev0DnfxcHy2ydkAO93ESqYvsq5gLqIpDe9B1ZVYLV
   QKCrejPm9EvyyeRaQnpBaq+yE3C2TB0LNIme/H2neiTIVd0jo4Og3z45X
   Q==;
IronPort-SDR: QbrE1L0LNiXvxvxaziQ8sBYe/YJ4UXuuKE77eJ8m01aHiN7i6Zel6YJDiZ8jinpag89cTAbTRZ
 k/gDRz6h0Tv72qa0BQsLVCPUtnT6LHmHwv9mUTaEle2vm5WYRCl+YBqBV8QXJIL2GLXl84w5dD
 nbAX5LLNYps3wqBr4yjLg8MSUDl1H+wcnoLPvlErSkc4T3xGqhiVZvhPBFCvKoec8IxqiFNzSH
 yffQQznU+ADOT9nM0M0D5MRZx9KgZPpX5/JpfV7WnVF8eU9uo3osWJRI541iUODamjneLUrfKM
 7UE=
X-IronPort-AV: E=Sophos;i="5.81,266,1610380800"; 
   d="scan'208";a="162656855"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2021 08:42:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PncCMtTuewUW8M5+IOjr4XJEc0MPGqTfoMtTZi9SD2O14FaksaKB77mBjDPOeANKJVsMXVR3ZyNC9HD5y1wnAH//anERmo1i7AzyCyBFlQTp0fTzUc9H5lRixPHQJum8SrrcX39JIFdH4gfqeE7OT9z/CZHVH+X05KFzC9BvaTOxlS6aWjYpwXeXvF36C+uodygT+bw3C5NsQkDThsTmREiVX8XFsvOBZdhWrl4mF+CEyGyVgnBc3NfRIT+48/Cqg9tfcMZE+d+0T9XAoLfequJ/+qLQz2Ne3qK4pumWonxltdIUVtNfEY3/E57Q55cUIL9g28FexjMLJ/dAeBq/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7XThzmEP1jcnYd3ASHUyLTv20HttMYi3oQrdKpccaU=;
 b=TZPFwxdrccZoUnI0IPdi9mXe2v+/CjHejZi+X74GMj4bwFUfKMQfKtixFT6dB3ljdoWkiLVuuo4w3dwOc4xcyIyuUQMLbx1lLgmyYyZ7AF/wOjTr68rpgkkCk7+jbOZtU60D/VjibFYITWQRCqI41E8H7a25FMSjNOvZCDH4R/+B3TUyZKEzpk3/CtpSG6/VY3hoOiOxfYlSEvK6/ii0/TEMdrw9m89XIS5TQOZAHkFmh9K8u2IuEH5WTM6w5h4i7KqP0B45kVc90X1PsIriYvUfQ0wZotc21Ep3NkB30yZV5ho7sn9t+0ogKnmSibggr4mkHUtPeq7efg5L6CHf0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7XThzmEP1jcnYd3ASHUyLTv20HttMYi3oQrdKpccaU=;
 b=aOkWQ2CSbVaEKqqalTt7qmvfVtrSEXg0ev50F7CHPruqt/VyPUhaJeagxD+zfwXMntF23VLT4lIXqma05KumtpqRLM6Ia1eF1r7fVIK3gFbLqn1eFuvLaIr38K+USQXv5IkO9N7h8JPawBakJa8FyzM3rmEifiwg5J+93abD77w=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BYAPR04MB6133.namprd04.prod.outlook.com (2603:10b6:a03:e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Mon, 22 Mar
 2021 00:42:30 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::61ad:9cbe:7867:6972]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::61ad:9cbe:7867:6972%7]) with mapi id 15.20.3890.041; Mon, 22 Mar 2021
 00:42:29 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Khazhy Kumykov <khazhy@google.com>
Subject: Re: [PATCH] blk-mq: Fix races between iterating over requests and
 freeing requests
Thread-Topic: [PATCH] blk-mq: Fix races between iterating over requests and
 freeing requests
Thread-Index: AQHXHFs9uEKqA8rA90CKQnfi1LVUbKqPL8EA
Date:   Mon, 22 Mar 2021 00:42:29 +0000
Message-ID: <20210322004228.ufkrlkkcng22iosl@shindev.dhcp.fujisawa.hgst.com>
References: <20210319010009.10041-1-bvanassche@acm.org>
In-Reply-To: <20210319010009.10041-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2c8aa40f-d25f-4196-7b16-08d8eccb5f93
x-ms-traffictypediagnostic: BYAPR04MB6133:
x-microsoft-antispam-prvs: <BYAPR04MB6133A61032604C47DD93F0A2ED659@BYAPR04MB6133.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jhUjVmhDIP0ceZNUa6JTriWiWldudjI+JwSkeD9TATWsVN2WHbUNWwMQNWJsRU7GPKhps5z106VFgpNbSNtFkFWa7eOOz1nPWk3aiAOLnKbf5jUxR7eM8NGm6HNmWwxgTEc0qaXx2KjAiIaCaQcGbpRv4n//7Mi7Nro+sHYIrVq94OOs4yXXuJyLTonImoJ+tZWG6qhNr7FE5hGXYW+ZdDVtI5uj1vUa8pTKvQ58290ShkCReR2TmIIBQAuRlFPALzTtB4TXJssL/LN7nydk1midihlzHAq+EAwtKMyUol0axNJk5X6lImPyLKqJvkNwdNrOQAgwtBz9rw9DMAQCnb8kqTuWo/WeiWqYbdv3ddOQ1BDwHBDcFMRExdJQnnxH19veEPnagElTXoKwnBceCWgW+T7yZY41uxMVl3dQpF9S1cMRNz4u4qWilYC6QtKXYNLRx/QxMPkFr9Nha/fX7VZIFdPcy7/qqPQN67NOGgj5wmzo7PPVTyTmbypSBpuelSfIQhp8etWZg45NTSbcYnr6TTRivHRG3BaZSfF9acC4XJyapMdr8HQlfIs5SCecmGWB2W4Nbs99JYsCBbOBKxtc8KNfMJTyfqmA0CQF7AvjFrm2Q2TTlEg5tnoDqaZnsP1BeD+nsKAbtc/ZczfBxm9b0T9AgdBiU1k6oj7gKiM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(26005)(66946007)(71200400001)(8936002)(6916009)(1076003)(38100700001)(54906003)(316002)(5660300002)(186003)(8676002)(478600001)(966005)(86362001)(6506007)(6486002)(6512007)(83380400001)(44832011)(76116006)(66556008)(64756008)(4326008)(9686003)(66476007)(2906002)(66446008)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9gajOdShv6cxGpgEP4CCgGHqPaKVabo3/xpvWMpD58XwS2eQ+qUd6mTpW9pm?=
 =?us-ascii?Q?gahGGNMqfoypCoxg8txyibB7scMNrZ95QAslxRuH5L9SjEKKt4BQw6YNRvYF?=
 =?us-ascii?Q?03iVYgNxP4M4/9Cvhj1PufF+HN25/wyJDY/+wcF3Rqjs4NsooAHyHI4mze73?=
 =?us-ascii?Q?iDAHCWgqPAQpTe8jQS3xbmXxyuUITGf12MnbgbomF+MOj4CEAMpb53jJkBOP?=
 =?us-ascii?Q?VZBkieE+oAr2Hm1h1LZwynwnzHZ6Fw11kmjr2O5xk8QG5hwjViwYa5YFvOWE?=
 =?us-ascii?Q?ETRP/t9ZLogkS0JWDtmtrO7dWjf7avaKe8ydaQl2MIFxf+LzlHtX6P2HSXYc?=
 =?us-ascii?Q?ZnegavFqCvW6sZDfAHl/t5OlIdDkGTQF1TUhxFD3zVPARx+xU0rz96zMmGiZ?=
 =?us-ascii?Q?11EDocvrv4XtuLfa55RtlnD6GSKDGNLsk0tnOu3wTxTswWjKFRPJIrCr+Eh1?=
 =?us-ascii?Q?zgs0bv89dEjDjz+r2/1T35VBKduoe94iHfjdrZBcqrt8tnXCCZygyKwD+aap?=
 =?us-ascii?Q?/Rb3C/eQe8N87LkZprCQqubEOcwBIHJT7Z/XWkIGFTI9wylzhQKEvf4qmv4x?=
 =?us-ascii?Q?+1W7lbiCBetBSzNt0/44tPJn0HyJzclgdBWOrZA/M0Lkn6MzWs24JZR0epFE?=
 =?us-ascii?Q?nyj+QjwG+lbs56cZRRx/z6A4h6L3htVU/Qi77hcko/m5ArmxsdWhg8ohcWr/?=
 =?us-ascii?Q?OSb/GcAeLZjj9jOzrANXlKTGlGzDUWhNnq8IDE9iEz8G5g3dY1PS1hIEFE0c?=
 =?us-ascii?Q?5kfnSIs3XDYKuBwTud2Gn/hfYxceXr2sPEFUYEGyHcwmWJO+2UeAgG4UTn9T?=
 =?us-ascii?Q?EcZya/H9hASu402L0YaS1rq6DM3b5gig/Ksjx58UwqNwnGk+Q5446/eGE0yu?=
 =?us-ascii?Q?ka7TTGCH0nUhgjAAOXpOSrU4IrKprotSGOfvm4eNuUng16FfCYmd11L5JWVu?=
 =?us-ascii?Q?7AVzJn92b7WTn0vmKXD1tWl5bSWu97NoEcVk9CBeTsGSl3rkqNkJfgVnmSJ0?=
 =?us-ascii?Q?OcXiwTZQBOfxSWHrMxMGGcuDDCcmBONjlprbXAiaXR2jqETUG1OsB5klVyqB?=
 =?us-ascii?Q?XaexDOJZQs45VXAfflbA2HnroeVD5ANBbzoJhNWQPwBgpEHzlioOx/65Yjjh?=
 =?us-ascii?Q?audw+G/WNyrT+23fO3w8SZRB5aRh6ZFld/li+wH6eRW+gB0FmfBbe4dKbBKS?=
 =?us-ascii?Q?vbXboGJ6sciVvij1f86QdW43dLYbrUObx07R7flIAGhdjlJ+hRfP8G9CpRwe?=
 =?us-ascii?Q?AhMEJPdqtb6HnU+zunJ47sCweWj7wEKyVBtaI2hyezGGZw7wYGI1w8xzkv+M?=
 =?us-ascii?Q?4aYzLmeULQ4lKN5cmzRARtt10dsvKJBgjwKRR/H2w3EF7g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AD4BE44EB0BAA94E99C1D6DB5305F2BA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8aa40f-d25f-4196-7b16-08d8eccb5f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 00:42:29.7153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9BBTvT/cjdKh2A1ucKTkFZXi9SkohF3WlT89jChLTh8cqYCjrxrrKye8Ws9cLpOUja3ZzehkyeFsXj6ceiKEqJtfqveuqRcDUlOE6gT6JE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6133
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 18, 2021 / 18:00, Bart Van Assche wrote:
> Multiple users have reported use-after-free complaints similar to the
> following (see also https://lore.kernel.org/linux-block/1545261885.185366=
.488.camel@acm.org/):
>=20
> BUG: KASAN: use-after-free in bt_iter+0x86/0xf0
> Read of size 8 at addr ffff88803b335240 by task fio/21412
>=20
> CPU: 0 PID: 21412 Comm: fio Tainted: G        W         4.20.0-rc6-dbg+ #=
3
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/0=
1/2014
> Call Trace:
>  dump_stack+0x86/0xca
>  print_address_description+0x71/0x239
>  kasan_report.cold.5+0x242/0x301
>  __asan_load8+0x54/0x90
>  bt_iter+0x86/0xf0
>  blk_mq_queue_tag_busy_iter+0x373/0x5e0
>  blk_mq_in_flight+0x96/0xb0
>  part_in_flight+0x40/0x140
>  part_round_stats+0x18e/0x370
>  blk_account_io_start+0x3d7/0x670
>  blk_mq_bio_to_request+0x19c/0x3a0
>  blk_mq_make_request+0x7a9/0xcb0
>  generic_make_request+0x41d/0x960
>  submit_bio+0x9b/0x250
>  do_blockdev_direct_IO+0x435c/0x4c70
>  __blockdev_direct_IO+0x79/0x88
>  ext4_direct_IO+0x46c/0xc00
>  generic_file_direct_write+0x119/0x210
>  __generic_file_write_iter+0x11c/0x280
>  ext4_file_write_iter+0x1b8/0x6f0
>  aio_write+0x204/0x310
>  io_submit_one+0x9d3/0xe80
>  __x64_sys_io_submit+0x115/0x340
>  do_syscall_64+0x71/0x210
>=20
> When multiple request queues share a tag set and when switching the I/O
> scheduler for one of the request queues that uses this tag set, the
> following race can happen:
> * blk_mq_tagset_busy_iter() calls bt_tags_iter() and bt_tags_iter() assig=
ns
>   a pointer to a scheduler request to the local variable 'rq'.
> * blk_mq_sched_free_requests() is called to free hctx->sched_tags.
> * blk_mq_tagset_busy_iter() dereferences 'rq' and triggers a use-after-fr=
ee.
>=20
> Fix this race as follows:
> * Use rcu_assign_pointer() and srcu_dereference() to access hctx->tags->r=
qs[].
> * Protect hctx->tags->rqs[] reads with an SRCU read-side lock.
> * Call srcu_barrier() before freeing scheduler requests.
>=20
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Khazhy Kumykov <khazhy@google.com>
> Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

I confirmed that this patch avoids the KASAN use-after-free message observe=
d
during blktests block/005 run on HDDs behind SAS-HBA. Looks good from testi=
ng
point of view.

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Best Regards,
Shin'ichiro Kawasaki=
