Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D780C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 15:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiBPPuI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 10:50:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbiBPPuI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 10:50:08 -0500
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10075.outbound.protection.outlook.com [40.107.1.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C0D2A7979
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 07:49:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Scr1E6hko0fVnSYbjpZKH06JPAoMpbpiwmv8a9ZIZQBUu1Z6l7FvPH2jkd9E6vTTw3IrcjGGGKv/oy+U1xqwtHJB0d6IlV7COcSpKSAqSj3U+G6bv55ebpd2vc/DlagNP+DW7IxRZDEJ/bPbeG616VjavUlhxY3I6J7sEzPoexPlORaLINs2AyvbBliVE8OeDaChIs25dQnk2gifc4ep/qOIonxHVLk013XzKjoGfXuXZHGKSam02qf5wnCxcs61bdfqUf7iUkx5s9srw6Qv8DaPClQMHgdRhTV+sGzyoV8GoDEnGX7QeljBp2ByHTDudY8pTA4gkcauSF3qwSf1bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKywRAq5K/g/QXuPzIqveOi4zKJP+GUdDKussXUYKwE=;
 b=XoUIRqYAZZDJbx3nQ9OYhICwluUvWexKfz+yFp6g8uPM7cjG5frs4NGrr/D6LTwMAo0HvZPNJ+XnJTKmugZ8SxjXvsAODAkMgk0wc73x05hlopg4733lfg79fn6NQWyVkgLU9dCu/8qcIEX4fNqYKUgonGm8gizWn7FEakAHM8ux5FFq52ngiX101KZJx2KCqE35B2LBoZkYLgVnG1URbo7MDaqBsPR9LRvaHIkboxeha+NGXYBMWICFV1brF7FIGWGZC6Mrk75iGrQME21MUt+69ju6xAdpE4Dh7s4rG5619gArEW7OcVe6YQ321zc3dSNBL3IQVIeMjK4sNy3lww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ipetronik.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKywRAq5K/g/QXuPzIqveOi4zKJP+GUdDKussXUYKwE=;
 b=Oj+rjL3vjp/VgkkjP+XXRg7qkwoQIAvDQhc2ngDjHNnxB2c9xaIy9da1ydzQyK3aqrGb0s9ZLafMymMTzrp+Y0Q4hVGzmEYimZ7Z/yysXwrIbUj1I/eN3wY1LijpqknOsq/siYyBEnYZYNifR2XbjkdXOTA7Zuu8ny5dcL7O3N4dPcrJ3hQcfucMbwzYQ0OiXOyoH8KSTfJkM4A+ocFfI+AWoEckJRPimgcW4gnI/ohvhNAK8AQMleNXC8XYMI5XVRWW5v+73ZY6tMEmmbOoJZqlwuWnHQeHFJjYGzv/Ij3ZC6UX4IxwC91Pk4uqYLK1uf9SWdAgvK0sPQoI6CPkjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ipetronik.com;
Received: from AM9P193MB1572.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:307::12)
 by AM6P193MB0406.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:4f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Wed, 16 Feb
 2022 15:49:51 +0000
Received: from AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 ([fe80::f127:41d:4d91:9dc0]) by AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 ([fe80::f127:41d:4d91:9dc0%8]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 15:49:51 +0000
Date:   Wed, 16 Feb 2022 16:49:50 +0100
From:   Markus =?utf-8?Q?Bl=C3=B6chl?= <Markus.Bloechl@ipetronik.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, kbusch@kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: fix surprise removal for drivers calling
 blk_set_queue_dying
Message-ID: <20220216154950.q3uit4ucl6xupvhe@ipetronik.com>
References: <20220216150901.4166235-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216150901.4166235-1-hch@lst.de>
X-ClientProxiedBy: AM0PR05CA0094.eurprd05.prod.outlook.com
 (2603:10a6:208:136::34) To AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:307::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f86f113e-b8ed-49f9-2022-08d9f163f7ab
X-MS-TrafficTypeDiagnostic: AM6P193MB0406:EE_
X-Microsoft-Antispam-PRVS: <AM6P193MB04062CDE72587E7EEF3888BC92359@AM6P193MB0406.EURP193.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +w0sDUNKF1qqCwNRP8ICbr0mg+5BPWJPb++WGa6wEgCVMs7xf0biAoIpdAoXyz9KFsFQD5L7xCvdYcaiMyb0c8gR7fVK98bcVvMfq/KKevGu3Fw6XvhEOTkc+3kCkQ2WesyHw4YcXzslVYR3Z3xuM6p4qB1dAoJv/w67ODLUS8WCQv+K7AUKMpTIAYrqmGLmVIP7Y/8sXi5U6xqU999T21Ws5B5SG+piMovuj4/ZpTb0gm5xrGY27gHHP9JpsJzeEue5jHXZa8A7n/aCKL65DO8xOHla0FCg6W8WPn8wzSqSDoM7mtcKoUm3iNdEn52sFV8kbjejDIliWeGLHaaz0APtpR5BViNeahn5HZvRx8EwfU4THfg7lNieNQOFPXfwEQyKaqDsuk9mFyReZIuOSvg4WW0zapGVZzLNKwz06DQDa5V2y3tzNa9GFiCxOGcsK3fe8CGe1DRkILtWypFq9b8rg3V5zMplpplhedW98qEW7Wu4FwOUs/dHaeNCgNl4OfuH6sxWsgQr+83TaTfvsI5Iz9X+n0EWvTwK6IxwMFydA1HAZELGmO0x3gCsLbOvmXFSFC7QpN/9WJeRmzZX6kkQmBl2/JoE4nVct4qArpJ2wMjOBo6427VbUs4TmLno6h5ZQuQJkabq2DhoOav34A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P193MB1572.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(66946007)(316002)(38100700002)(4326008)(86362001)(36756003)(6486002)(66476007)(1076003)(186003)(6916009)(2616005)(66574015)(6512007)(2906002)(508600001)(52116002)(8676002)(6506007)(8936002)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mjl5SWxqcTdSUy9Kd0MrdXBMNC9rNlZ2aTk2MjltVURKSWN3M25KRi9iRmVj?=
 =?utf-8?B?eUlHUzIvNzcyY1NHUEZBdjhqMW9JZ1R6MW4xR3V1ZFdrMVNLNzBkZFFMaDlL?=
 =?utf-8?B?djNEcVNqbEttTnYzVGwyM1pQTXNBS2dPZ0I1WlRDVDcreURuSGtackN5UFdu?=
 =?utf-8?B?anFJWVhKMjdyZkx4Unk2VnZDQWwxYkRVdTNkSytsS3BFS3k4SkZlOWVLRW9F?=
 =?utf-8?B?ZmVWNlpiWUNnT05NdFNJZXNQK3NhcC9yeHdZVDAxaUNzUnM0L2VMa0tTSzhq?=
 =?utf-8?B?Vysvdm5hbkpEeitVNmpjKzFmeHlmQ1AwWk4xSk9Sbklxei83N0NCTjBqZjVo?=
 =?utf-8?B?M1JaTTd4U3lPODkzck1CNXhzMnJROGhqa1BYTmVhNHNmaTBIelZQbS9sU1Bl?=
 =?utf-8?B?MWpiWW16UWlSM2JuSDl1SVlnRGZNRHozLzc4bS9hYVJqd3F0cGdmT2xCbzNW?=
 =?utf-8?B?bytWOHNaM1A4Mm5CRitXWUt5TXdGN0VKNkVhWDFadEo5Q3dqY3dYaG5tL1N5?=
 =?utf-8?B?RDJKbklLSU52ZGhqT3MwRHl1ZWIvcXc4SzlMRjQ4UTZmbGFxWWdyTjhwOWNN?=
 =?utf-8?B?NCtDK3ZGdEFzNDZUczh1NmV6SUdzc2h5aENrakZuZy93TWxodDhBZ01oYjVZ?=
 =?utf-8?B?TmFISnRCU2puSXRVRFQvUzRERytGMHlNdVNTUmN1Vmo5NmVxWXN3UTRxNnVL?=
 =?utf-8?B?UzErcFhMaEtlMWhROUViMlMwVXhqVnE1V1lrRDI2dGNYOElsdCtHY2NUMlEx?=
 =?utf-8?B?L095aHVIekU5SGxzcEhLdlovZTRIaFVZQzhVaHU4dTZLZGdhRzl6SXpuYmZ2?=
 =?utf-8?B?dzdHUTlvSm1TV29ZOEYzdjJmUVZYUWw0eFdmeXZ2bVcxK3FiV1E4NnVmVWEz?=
 =?utf-8?B?L3RHNEdpYmc3NUR6bWYxS24xcXFVcWdFUFI2eVptK0RpN1BKT09BdHlaVlRX?=
 =?utf-8?B?eGpsNVUvRFZMWDFGajBybmFkREh3SnIvL0tIY3Y4UGFXYjh5ZEJ3aXJRNXk0?=
 =?utf-8?B?cmFmUTJRa2g5MXlVbk1ZTy9BUnkyMEs3eFhTZk14eVFSU2hwekxwWjBZOVRl?=
 =?utf-8?B?cGhTcWZkMnF6K1dpTVBhU3RXZnNIa29XN1hudkE0Q21zMnRwV3Z6TGRBWldx?=
 =?utf-8?B?aHVtbm9tYTFybmliQm9MYWZhSmtJY2VMK0tLaFNVSS9Ra2JTVEJ3UDlGaEpj?=
 =?utf-8?B?NE00akkwRUd0bmhTbzRtdGtXMkt4OHBkdVdXcm9LV0p4ZjlQLzlzVy84OWxm?=
 =?utf-8?B?MURJdVdxcXViSDZtN1dWTkU2SUd6RVoxUUtFMjJyLzZFOEhNUitKSGRYZnJk?=
 =?utf-8?B?MEJzUmNsb21tNDMxaVpMSlR1dmgrczVVVnk1ZU13U3hSL1J4SllWRVo1VUQy?=
 =?utf-8?B?M3NtcUF3MTdkZzNzZ05zSFdRb3VxZ2F0cTB2V2piRFk0anMyNzljcXc5NlpO?=
 =?utf-8?B?ZFNLQjVmNXZEdzU5QU1hbVNveGZkbnNNN2ZReWt0eGRuazRkUVVzTUJpM2RY?=
 =?utf-8?B?V0NQU25qODNXcFAxbnNUaDdsZ0xLb01oY2FxYkU2Uy9sRHdaRDVrL3JCOUJt?=
 =?utf-8?B?RmsxdzNoYnVJWEh0S2ROMDFDZU95eVhubm5OVkRzM2RXeEpGRWJnUURqL1lT?=
 =?utf-8?B?aWZ3ZjNJL2dLdjBOa05hTncxdDdHMGd2aFdOUEhiaXJYWllxSEczNlFTNmll?=
 =?utf-8?B?S3k0NmVUR1dmZjE3WnZSWFNoMTFOUEg5WUNRNm91Tk40SDF4SElEbHFGTndk?=
 =?utf-8?B?M1hFN3NZQWdsamJYVzZ2NEJFaTg5U3J2R3V4aktiR3RUZXhGR0cvTXQ3MmdH?=
 =?utf-8?B?YzJYOGxWSDI4QzIycjFuLzRiU2JSNWdORytFWUV3cnMvQ3E1MGwxUmJ2NUVJ?=
 =?utf-8?B?SnB4V1h1enB4R0dCVzhVdlNuYnhLRHJkb2l2YkZMekJrME1YZmhrTTZ4amp3?=
 =?utf-8?B?V1lZeW9mRnpRN1RrNDU2cTNHK25PQkRzOEpzSFE1c2lMR1dUVGlwU0Jxck5z?=
 =?utf-8?B?QlFZbWQ5WHY1c2pMdzZZOTdjTUJsSUNXU1IwWk1SYWtiUmxQTlZUWlFmRSsw?=
 =?utf-8?B?VFRaeHMxOUdZQUh3NkZBaFpXYy82MVU4bjRScFBzb1YvdllqeEV6cysxTjA1?=
 =?utf-8?B?RlJYdUJSUnVpUnA3aFlPQnZLTzJzQXRsdmlIQUduZDJOOFlTVVd3NVhsQkpy?=
 =?utf-8?B?NHNIU3N3VGZHaXlLNlRFT1FoK2lsbEpEdUc5d05oZ01aZnNsbXQ2aHhrMGor?=
 =?utf-8?B?VDhBNVpqdmNNUndtVkJBazJyYlZlcUd2TGdMaEprTEFPOE9XU3lKSGRGOEd4?=
 =?utf-8?B?akVRWDNpUW9JRFZGQzVHSmIrb3MxV1MrdFhObkhDQ0tldVBaOVlyWWJWTGJK?=
 =?utf-8?Q?8F7CfuCeQiVm0jUI=3D?=
X-OriginatorOrg: ipetronik.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86f113e-b8ed-49f9-2022-08d9f163f7ab
X-MS-Exchange-CrossTenant-AuthSource: AM9P193MB1572.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 15:49:50.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 982fe058-7d80-4936-bdfa-9bed4f9ae127
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKH00SHedBVj26uEH90yuYvViDxoUR8H/iTELtU6ZyvEH8AEJsPjf8jNiysX6sFZUArYlMIAcglPsh/n3ENaUTngzVzMGW0jn+7XfT3w7Bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P193MB0406
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 16, 2022 at 04:09:00PM +0100, Christoph Hellwig wrote:
> Various block drivers call blk_set_queue_dying to mark a disk as dead due
> to surprise removal events, but since commit 8e141f9eb803 that doesn't
> work given that the GD_DEAD flag needs to be set to stop I/O.
> 
> Replace the driver calls to blk_set_queue_dying with a new (and properly
> documented) blk_mark_disk_dead API, and fold blk_set_queue_dying into the
> only remaining caller.
> 
> Fixes: 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
> Reported-by: Markus Blöchl <markus.bloechl@ipetronik.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c                  | 18 +++++++++++++-----
>  drivers/block/mtip32xx/mtip32xx.c |  2 +-
>  drivers/block/rbd.c               |  2 +-
>  drivers/block/xen-blkfront.c      |  2 +-
>  drivers/md/dm.c                   |  2 +-
>  drivers/nvme/host/core.c          |  2 +-
>  drivers/nvme/host/multipath.c     |  2 +-
>  include/linux/blkdev.h            |  3 ++-
>  8 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index d93e3bb9a769b..15d5c5ba5bbe5 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -284,12 +284,19 @@ void blk_queue_start_drain(struct request_queue *q)
>  	wake_up_all(&q->mq_freeze_wq);
>  }
>  
> -void blk_set_queue_dying(struct request_queue *q)
> +/**
> + * blk_set_disk_dead - mark a disk as dead
> + * @disk: disk to mark as dead
> + *
> + * Mark as disk as dead (e.g. surprise removed) and don't accept any new I/O
> + * to this disk.
> + */
> +void blk_mark_disk_dead(struct gendisk *disk)
>  {
> -	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
> -	blk_queue_start_drain(q);
> +	set_bit(GD_DEAD, &disk->state);
> +	blk_queue_start_drain(disk->queue);
>  }
> -EXPORT_SYMBOL_GPL(blk_set_queue_dying);
> +EXPORT_SYMBOL_GPL(blk_mark_disk_dead);

I might have missed something here, but assuming I am a driver which
employs multiple different queues, some with a disk attached to them,
some without (Is that possible? The admin queue e.g.?)
and I just lost my connection and want to notify everything below me
that their connection is dead.
Would I really want to kill disk queues differently from non-disk
queues?

How is the admin queue killed? Is it even?

>  
>  /**
>   * blk_cleanup_queue - shutdown a request queue
> @@ -308,7 +315,8 @@ void blk_cleanup_queue(struct request_queue *q)
>  	WARN_ON_ONCE(blk_queue_registered(q));
>  
>  	/* mark @q DYING, no new request or merges will be allowed afterwards */
> -	blk_set_queue_dying(q);
> +	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
> +	blk_queue_start_drain(q);
>  
>  	blk_queue_flag_set(QUEUE_FLAG_NOMERGES, q);
>  	blk_queue_flag_set(QUEUE_FLAG_NOXMERGES, q);
> diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
> index e6005c2323281..2b588b62cbbb2 100644
> --- a/drivers/block/mtip32xx/mtip32xx.c
> +++ b/drivers/block/mtip32xx/mtip32xx.c
> @@ -4112,7 +4112,7 @@ static void mtip_pci_remove(struct pci_dev *pdev)
>  			"Completion workers still active!\n");
>  	}
>  
> -	blk_set_queue_dying(dd->queue);
> +	blk_mark_disk_dead(dd->disk);

This driver is weird, I did find are reliably hint that dd->disk always
exists here. At least mtip_block_remove() has an extra check for that.

It also only set QUEUE_FLAG_DEAD if it detects a surprise removal and
not QUEUE_FLAG_DYING.

>  	set_bit(MTIP_DDF_REMOVE_PENDING_BIT, &dd->dd_flag);
>  
>  	/* Clean up the block layer. */
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 4203cdab8abfd..b844432bad20b 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -7185,7 +7185,7 @@ static ssize_t do_rbd_remove(struct bus_type *bus,
>  		 * IO to complete/fail.
>  		 */
>  		blk_mq_freeze_queue(rbd_dev->disk->queue);
> -		blk_set_queue_dying(rbd_dev->disk->queue);
> +		blk_mark_disk_dead(rbd_dev->disk);
>  	}
>  
>  	del_gendisk(rbd_dev->disk);
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index ccd0dd0c6b83c..ca71a0585333f 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -2126,7 +2126,7 @@ static void blkfront_closing(struct blkfront_info *info)
>  
>  	/* No more blkif_request(). */
>  	blk_mq_stop_hw_queues(info->rq);
> -	blk_set_queue_dying(info->rq);
> +	blk_mark_disk_dead(info->gd);
>  	set_capacity(info->gd, 0);
>  
>  	for_each_rinfo(info, rinfo, i) {
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index dcbd6d201619d..997ace47bbd54 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -2077,7 +2077,7 @@ static void __dm_destroy(struct mapped_device *md, bool wait)
>  	set_bit(DMF_FREEING, &md->flags);
>  	spin_unlock(&_minor_lock);
>  
> -	blk_set_queue_dying(md->queue);
> +	blk_mark_disk_dead(md->disk);
>  
>  	/*
>  	 * Take suspend_lock so that presuspend and postsuspend methods
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 79005ea1a33e3..469f23186159c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4574,7 +4574,7 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
>  	if (test_and_set_bit(NVME_NS_DEAD, &ns->flags))
>  		return;
>  
> -	blk_set_queue_dying(ns->queue);
> +	blk_mark_disk_dead(ns->disk);
>  	nvme_start_ns_queue(ns);
>  
>  	set_capacity_and_notify(ns->disk, 0);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index f8bf6606eb2fc..ff775235534cf 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -848,7 +848,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
>  {
>  	if (!head->disk)
>  		return;
> -	blk_set_queue_dying(head->disk->queue);
> +	blk_mark_disk_dead(head->disk);
>  	/* make sure all pending bios are cleaned up */
>  	kblockd_schedule_work(&head->requeue_work);
>  	flush_work(&head->requeue_work);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index f35aea98bc351..16b47035e4b06 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -748,7 +748,8 @@ extern bool blk_queue_can_use_dma_map_merging(struct request_queue *q,
>  
>  bool __must_check blk_get_queue(struct request_queue *);
>  extern void blk_put_queue(struct request_queue *);
> -extern void blk_set_queue_dying(struct request_queue *);
> +
> +void blk_mark_disk_dead(struct gendisk *disk);
>  
>  #ifdef CONFIG_BLOCK
>  /*
> -- 
> 2.30.2
> 

