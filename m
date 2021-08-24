Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAD9C4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 21:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C4461374
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 21:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhHXVes (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:34:48 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:28037 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhHXVes (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 17:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629840844; x=1661376844;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sx1/lRTobES4+meH6tvg1QF/WJKfYZCBWN/LFabZAyc=;
  b=CnMtlT5nHXMFGjAxhzBuhaIM3U7+m4KxiUlqY1B4QCj34upATDEGO+OB
   bTg9KWCBj+AVEB927JDmYWUp9vAZY3eBWPLihzXFfHnfrcIbhvWfLeUBO
   QdO4f2vb8uUMSwxfH+ZhmFAf7uq1rUptho3BxepTKGqVFTfew/lKQRIpt
   xkmG1Wf7FH04GwXVI381az3QCqff7Flu3IBkHDSzyqfgbm8Yyz9U6cPeF
   mK07Xh5PeECOdauRsefZXIMqDZ9ZTEJJG8sNoZ0pruvUunWPodJVQuc2K
   P9xFU/7XTx6utxwUzPiysNm0Io56Bhp1MYa9fMZuOAI1zZD8dNB3NasL2
   A==;
X-IronPort-AV: E=Sophos;i="5.84,348,1620662400"; 
   d="scan'208";a="178840250"
Received: from mail-bn8nam08lp2044.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.44])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2021 05:34:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVhXcn0OlfDuqw47aj09x2s8o5r+2Gu0R47xkCiJviNU0NuUdKBLkX01eT2X5aXLwqzG7sSgL3CN/FJ5pleWpuLka1M61otYYnz70OdfJXmAMnYAZKSzeLq/pzrSHfvKe8Ym591baJMcwoecGVtQsj4Gwp/A6y2P5XSk89ae4+WolzQWiMoygxlJxjp0t4Ym6nqfGd7WotbuobNT2pa+6QPHgZtqxVwAz4lPwo3OzVRJYIyDR4II0/xuYEPi0PWXVqTkvjY31pdFm6fvdQHgFiHPBM7H5LSc3zH0z/g6dGuMZbSUQn1JVHntz8I6OS9HNRlNUlMIBhgkuJuOXZHJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDi2S5PpecFzf6IaRJYfXN1qQESn15rHsCEKqiwe5kc=;
 b=l3KLwkN9OJVtRRIlXd/su0gl2J5WxS1T85st4v5GiUpaFVJ1Qgl73ndlemzYMRDBZdVRFm5rOZbtwHFO/g5rrz9IVmF9uVp2snbK56P5RYwF3QXR7UDXAG66ZZ5xvhVvizYZmTfOpZ3gePDlVr6uip5DPHwoDonbjjDjK5Twt5Uokj8Sl9fbRnyP+wGoLlKRDWc/FE0/HLin8pUERF8SsRXpH9jHv/M2erxWFvh3RtwpvmDghec7xke+cb8oqTSxjv4eBv+eWwAu6H7vBdFzdiwWw+1bJq4rltHQVk76B9k26Z/guWYeBSt2+78FhKRplODWerMQ1FWLnYhs2ltRkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDi2S5PpecFzf6IaRJYfXN1qQESn15rHsCEKqiwe5kc=;
 b=AWuysBr0+fD7T/RNQBqLyPLxvyMxn2ItRpD+DmPw4OzRqqVAP2LWFWVaDTLX3bSu3IrtAzcRc0Z8Dp4YMmWQfBCMaJBqV15c9pkIQjOPNr4xIw9Q/wvBP8YMyTcjvIM5WZVToniFSz1fCkVcdVd8GqZphgeSxA/BZHzMTPnUesI=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7304.namprd04.prod.outlook.com (2603:10b6:510:d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Tue, 24 Aug
 2021 21:33:58 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9%8]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 21:33:58 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v3 16/16] block/mq-deadline: Prioritize high-priority
 requests
Thread-Topic: [PATCH v3 16/16] block/mq-deadline: Prioritize high-priority
 requests
Thread-Index: AQHXlVysvcZeBwZKNkSbW/SgpyhLO6t8sO0AgABT/oCAAAlKAIADqkMAgAChy4CAAdqAgA==
Date:   Tue, 24 Aug 2021 21:33:58 +0000
Message-ID: <YSVlxRutpVkfo7W/@x1-carbon>
References: <20210618004456.7280-1-bvanassche@acm.org>
 <20210618004456.7280-17-bvanassche@acm.org> <YR77J/aE6sWZ6Els@x1-carbon>
 <5aa99b39-c342-abd4-00a4-dc0fbfac96aa@acm.org> <YSA1JWt9soMSs23Z@x1-carbon>
 <e94f62c4-a329-398d-5003-d369506d7f89@acm.org> <YSNQAu9uXrmEteXc@x1-carbon>
 <b6131780-8b67-8efb-a942-e40b68df082e@acm.org>
In-Reply-To: <b6131780-8b67-8efb-a942-e40b68df082e@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7dc8ac93-bc31-440f-ca0e-08d96746e1f7
x-ms-traffictypediagnostic: PH0PR04MB7304:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7304C66EADB21F3EFDD92C0AF2C59@PH0PR04MB7304.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tTtqncPVyjcCQ0ld4Atba6czzufoylPaXdkSlJBXeqh7slDWURypEFj3AZTtz8TgelO+acGhh2UjyFKIMiU1e0bWLJ+iOfgUdayW6THhOVKQSJz3Ip9QlhayxuZxiW6FisojNAHPgQAWQbfmMi1KYbWoCGOgdIsh05rbHdiLuWVwAGf2e9I/Uh/ibBZUuIIlMiFaBUSrUXSp6oBunpnLskoBL2QhGtGgL4VyAOEcJnSomaTVqRDGsKysxwv8m7TfR6wBx4h2cOAhyYVtq0ul9p2kSwq7wuOh53XytoN2ADHa+DkNv3O82yC/yvGMxyf+d7XzgAMCIOa6MVCECafvP5wyuDibHpeae+vl5xL+VRy1ZpxJeFz/FfQS8zsFv6n8b5YujE2maMZC11N5lCTlCRPJWQqTB/4YqzC4uo7bPaI79+yDYT1LwlpuFV+NXILqwtNZczT/nN2ZpyTzirGhsNqwnSQ/Dj3uozwwEGb+brviGb0kealXehBpJJBub+Bq7mJ01HpOPyXD8uDXvvd8o9HlFUMTHySIn/UTl/tzj9ZlBOTzdvGUOEL98On6SuHMU1QZdN9F0n9d4E8cjl9aBt6ndRFtFxBIh+oHsIPJt4Ty/7srveGQOxxdjsDda6aNjnNWsTJ5CVvX+zllG3QbfZaYBbkacQAwAF4lD8ws6urSFLYf3aCHbJ4WjbxYkjFlxeGe+HZV7UFlztIbgUIcgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(376002)(366004)(396003)(39860400002)(136003)(54906003)(38100700002)(8936002)(6916009)(478600001)(26005)(8676002)(38070700005)(122000001)(316002)(83380400001)(33716001)(66446008)(66946007)(64756008)(91956017)(66476007)(76116006)(66556008)(2906002)(6512007)(9686003)(6486002)(5660300002)(4326008)(53546011)(6506007)(186003)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?M6Wr2NaIfnL6oSyfVgA6EpLIffxrDItvFfZXHBjs0ENPugR/AI0TMRxXwYMB?=
 =?us-ascii?Q?25whxwIeWbUqzo0t5zWiSAXorDYVqRmFrRRmIuTARinvtomdsCb1tVyzXSwU?=
 =?us-ascii?Q?al1TTFURmonHKj78n0Znpe2Jt34P87Am1Sp/71iUGx95fE3qtfjgrSv62q0b?=
 =?us-ascii?Q?JB/kUGoXckKdMWDhFB0yykdU9iLlEcITbok5w9Zglne/UQlaLAnYHiqYS8up?=
 =?us-ascii?Q?Ico0DJOQlgX6Kw7P/z1gCi0yqfMaWK7mYVJcLJ+zBZ5gtlFKmiYAMab2Ollj?=
 =?us-ascii?Q?6W9KkhmXcKRu+Cw3iWL/7bdiku7n0wfjPTO4qsZVvJriD7dvB7+nVvL8hftT?=
 =?us-ascii?Q?ITUhQoVuittKLafycv0OXxtWAlOrielyFPllFQEiwnUHoRLkHvoWJ2mxxVMW?=
 =?us-ascii?Q?MNMjOp3xO9Hl+cYCivuAaAj2JjYUmti/OfFk+JNlpmPBlz4T7mjej7PEKG2H?=
 =?us-ascii?Q?bGMMEXrsTBTYgXZzjN4L8ADvk1X+y7XvCfJpHAeNV56mtmkg52mb0wnh3iDX?=
 =?us-ascii?Q?WV49GZHIO/JtWv8GkAoF09S8w9MoqBCmecSijKNMqO05rFdCKSm7FTu1s/DB?=
 =?us-ascii?Q?69Lh//WHdddEsGZacBwhtzlTpK0dyw9gxRHGuHdL8qx/6VSdTZZ0q7sAiKRI?=
 =?us-ascii?Q?gv/3mDbuv0EWPvfJWcQHFrcNYm4zU7dWIghizDnGG56Fj0EmieeI4VcPzFmu?=
 =?us-ascii?Q?rp7zXie3Qjsk5RPFpJcRXA4Ogm7wvkJM607285ZqYeGVwZChm2zhlUSqvUsY?=
 =?us-ascii?Q?qkbo5yJAukYyrfDkn4edZRpczb0hAaW66ZBWV308ZJ3AJ1o3t4+w/YT0L3bO?=
 =?us-ascii?Q?P0BNfD3gh506RbqeJO8+eGQlHC13HkEXnvRGTR+QJY9ORxWMTERuHdm7TNSS?=
 =?us-ascii?Q?Acx4LJ8+ysonye6wkifkU2zQthJC3OfNjFK+DsL7mxVM7Sj7ZIXxFXtAjSPb?=
 =?us-ascii?Q?w6Tk5hjcH3Yx6fZYZAaSslFYwCjg6CKSp39+75kU0xlbiJMwQ7noq39RUgRh?=
 =?us-ascii?Q?MGbuOn5PTXiIrveV3x8T3ktDZZFvgZBv9qmyEBCVgcvMTNVfyMjPmWdfX25b?=
 =?us-ascii?Q?oeZcfcnrMgiOA9dec3RMDa/j4IupPw5AIbC7P/GBjw3bD68g+pvSF1IKAhzT?=
 =?us-ascii?Q?Jfe7uQrRCGMZx3eUOS+6BXZORsJIVoS74xHVttxgz2LyfVd/s9kyT5auLZTw?=
 =?us-ascii?Q?1x3PFZI1O6fZz1anrIMk0MeY6g8f8Nr0LaCbs58+G5MBzscmv1VSKd08ktWc?=
 =?us-ascii?Q?9T8AoZa1PMITP2L6q2XTweOY04mAZD0gYImHEH3gTop+jI63B+wU8UwY6ea+?=
 =?us-ascii?Q?sXZkUp8Ci47QA0/+SWIHQAqvBCa/cbetVklsllzbO2i0bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47822B4D31899043931C44AEBFD303E1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc8ac93-bc31-440f-ca0e-08d96746e1f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 21:33:58.4089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SzfgUrerCed+/ZdbrNxW4/7dFijNfGUdmq4Te/jvGoJRTBrlBWQUJ8Sl7Wp6dmfERwoLgmlcjf9VfWMJhZA9bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7304
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 23, 2021 at 10:15:39AM -0700, Bart Van Assche wrote:
> On 8/23/21 12:36 AM, Niklas Cassel wrote:
> > I was mainly thinking that it should be possible to do a generic fix,
> > such that we eventually won't need a similar fix as yours in all the
> > different I/O schedulers.
>=20
> Coming up with a generic fix would be great but I have not yet found an
> elegant approach ...
>=20
> Another question is what the impact is of scheduler bypass on zoned block
> devices? Is the zone locking performed by the mq-deadline scheduler for
> writes to zoned block devices compatible with I/O scheduler bypass?

If anyone is curious of how the stack trace looks:

#0  dd_finish_request (rq=3D0xffff8881051b0000) at block/mq-deadline.c:790
#1  0xffffffff81741fcf in blk_mq_free_request (rq=3Drq@entry=3D0xffff888105=
1b0000)
    at block/blk-mq.c:516
#2  0xffffffff8172e4fa in blk_put_request (req=3Dreq@entry=3D0xffff8881051b=
0000)
    at block/blk-core.c:644
#3  0xffffffff819c51c2 in __scsi_execute (sdev=3D0xffff888106064000,
    cmd=3Dcmd@entry=3D0xffffc900002c78d8 "", data_direction=3Ddata_directio=
n@entry=3D3,
    buffer=3Dbuffer@entry=3D0x0 <fixed_percpu_data>, bufflen=3Dbufflen@entr=
y=3D0,
    sense=3Dsense@entry=3D0x0 <fixed_percpu_data>, sshdr=3D0xffffc900002c78=
78, timeout=3D30000, retries=3D5,
    flags=3D0, rq_flags=3D0, resid=3D0x0 <fixed_percpu_data>) at drivers/sc=
si/scsi_lib.c:260
#4  0xffffffff819e12b6 in scsi_execute_req (resid=3D0x0 <fixed_percpu_data>=
, retries=3D5,
    timeout=3D30000, sshdr=3D0xffffc900002c7878, bufflen=3D0, buffer=3D0x0 =
<fixed_percpu_data>,
    data_direction=3D3, cmd=3D0xffffc900002c78d8 "", sdev=3D<optimized out>=
)
    at ./include/scsi/scsi_device.h:463
#5  sd_spinup_disk (sdkp=3D<optimized out>) at drivers/scsi/sd.c:2177
#6  sd_revalidate_disk (disk=3D<optimized out>) at drivers/scsi/sd.c:3302
#7  0xffffffff819e479d in sd_open (bdev=3D0xffff888102b45800, mode=3D1) at =
drivers/scsi/sd.c:1443
#8  0xffffffff81422285 in blkdev_get_whole (bdev=3Dbdev@entry=3D0xffff88810=
2b45800, mode=3Dmode@entry=3D1)
    at fs/block_dev.c:1253
#9  0xffffffff8142348a in blkdev_get_by_dev (dev=3D<optimized out>, mode=3D=
mode@entry=3D1,
    holder=3Dholder@entry=3D0x0 <fixed_percpu_data>) at fs/block_dev.c:1417
#10 0xffffffff8175632c in disk_scan_partitions (disk=3D0xffff88810514dc00) =
at block/genhd.c:388
#11 register_disk (groups=3D<optimized out>, disk=3D0xffff88810514dc00, par=
ent=3D0xffff888106064268)
    at block/genhd.c:435
#12 __device_add_disk (parent=3Dparent@entry=3D0xffff888106064268, disk=3Dd=
isk@entry=3D0xffff88810514dc00,
    groups=3Dgroups@entry=3D0x0 <fixed_percpu_data>, register_queue=3Dregis=
ter_queue@entry=3Dtrue)
    at block/genhd.c:527
#13 0xffffffff8175640f in device_add_disk (parent=3Dparent@entry=3D0xffff88=
8106064268,
    disk=3Ddisk@entry=3D0xffff88810514dc00, groups=3Dgroups@entry=3D0x0 <fi=
xed_percpu_data>)
    at block/genhd.c:548
#14 0xffffffff819e4d0f in sd_probe (dev=3D0xffff888106064268) at drivers/sc=
si/sd.c:3581


This stack trace is simply the first one, it can be traced back to
sd_revalidate_disk(). All the other dd_finish_request() calls (which doesn'=
t
have a matching insert) also originate from sd_revalidate_disk().

Like we suspected, this is because of scheduler bypass.

E.g.
sd_revalidate_disk() -> read_capacity_16() -> __scsi_execute() ->
blk_execute_rq() -> blk_execute_rq_nowait() -> blk_mq_sched_insert_request(=
)
-> blk_mq_sched_bypass_insert() -> blk_mq_request_bypass_insert()

__scsi_execute() sets req op to REQ_OP_DRV_OUT or REQ_OP_DRV_IN.

blk_mq_sched_insert_request() bypasses the scheduler when
blk_mq_sched_bypass_insert() returns true, which it does if
blk_rq_is_passthrough().
blk_rq_is_passthrough() returns true if req op is REQ_OP_DRV_OUT
or REQ_OP_DRV_IN.

Basically __scsi_execute() is the equivalent of __nvme_submit_sync_cmd(),
but with a worse name :)


"Is the zone locking performed by the mq-deadline scheduler for
writes to zoned block devices compatible with I/O scheduler bypass?"

Since sd_revalidate_disk() doesn't do any writes, everything is fine.
(And like Damien said, if any kernel code did passthrough writes,
we would have seen errors from the drive a long time ago.)

Yes, a user submitting passthrough writes can of course do "bad things",
but that is expected :)


Kind regards,
Niklas=
