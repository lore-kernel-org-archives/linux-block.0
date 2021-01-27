Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AE5C433DB
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 07:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A25F2072C
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 07:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhA0HQs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 02:16:48 -0500
Received: from verein.lst.de ([213.95.11.211]:51671 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232946AbhA0HOa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 02:14:30 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4CD2467373; Wed, 27 Jan 2021 08:13:44 +0100 (CET)
Date:   Wed, 27 Jan 2021 08:13:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@fb.com, hch@lst.de, kbusch@kernel.org
Subject: Re: [PATCH] nvme-core: check bdev value for NULL
Message-ID: <20210127071344.GA21223@lst.de>
References: <20210127053738.4922-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127053738.4922-1-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Jens, can you pick this up as it fixes an issue I introduced in
for-5.12/block?

On Tue, Jan 26, 2021 at 09:37:38PM -0800, Chaitanya Kulkarni wrote:
> The nvme-core sets the bdev to NULL when admin comamnd is issued from
> IOCTL in the following path e.g. nvme list :-
> 
> block_ioctl()
>  blkdev_ioctl()
>   nvme_ioctl()
>    nvme_user_cmd()
>     nvme_submit_user_cmd()
> 
> The commit 309dca309fc3 ("block: store a block_device pointer in struct bio")
> now uses bdev unconditionally in the macro bio_set_dev() and assumes
> that bdev value is not NULL which results in the following crash in
> since thats where bdev is actually accessed :-
> 
> void bio_associate_blkg_from_css(struct bio *bio,
> 				 struct cgroup_subsys_state *css)
> {
> 	if (bio->bi_blkg)
> 		blkg_put(bio->bi_blkg);
> 
> 	if (css && css->parent) {
> 		bio->bi_blkg = blkg_tryget_closest(bio, css);
> 	} else {
> -------------->	blkg_get(bio->bi_bdev->bd_disk->queue->root_blkg);
> 		bio->bi_blkg = bio->bi_bdev->bd_disk->queue->root_blkg;
> 	}
> }
> EXPORT_SYMBOL_GPL(bio_associate_blkg_from_css);
> 
> <1>[  345.385947] BUG: kernel NULL pointer dereference, address: 0000000000000690
> <1>[  345.387103] #PF: supervisor read access in kernel mode
> <1>[  345.387894] #PF: error_code(0x0000) - not-present page
> <6>[  345.388756] PGD 162a2b067 P4D 162a2b067 PUD 1633eb067 PMD 0
> <4>[  345.389625] Oops: 0000 [#1] SMP NOPTI
> <4>[  345.390206] CPU: 15 PID: 4100 Comm: nvme Tainted: G           OE     5.11.0-rc5blk+ #141
> <4>[  345.391377] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba52764
> <4>[  345.393074] RIP: 0010:bio_associate_blkg_from_css.cold.47+0x58/0x21f
> 
> <4>[  345.396362] RSP: 0018:ffffc90000dbbce8 EFLAGS: 00010246
> <4>[  345.397078] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000027
> <4>[  345.398114] RDX: 0000000000000000 RSI: ffff888813be91f0 RDI: ffff888813be91f8
> <4>[  345.399039] RBP: ffffc90000dbbd30 R08: 0000000000000001 R09: 0000000000000001
> <4>[  345.399950] R10: 0000000064c66670 R11: 00000000ef955201 R12: ffff888812d32800
> <4>[  345.401031] R13: 0000000000000000 R14: ffff888113e51540 R15: ffff888113e51540
> <4>[  345.401976] FS:  00007f3747f1d780(0000) GS:ffff888813a00000(0000) knlGS:0000000000000000
> <4>[  345.402997] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> <4>[  345.403737] CR2: 0000000000000690 CR3: 000000081a4bc000 CR4: 00000000003506e0
> <4>[  345.404685] Call Trace:
> <4>[  345.405031]  bio_associate_blkg+0x71/0x1c0
> <4>[  345.405649]  nvme_submit_user_cmd+0x1aa/0x38e [nvme_core]
> <4>[  345.406348]  nvme_user_cmd.isra.73.cold.98+0x54/0x92 [nvme_core]
> <4>[  345.407117]  nvme_ioctl+0x226/0x260 [nvme_core]
> <4>[  345.407707]  blkdev_ioctl+0x1c8/0x2b0
> <4>[  345.408183]  block_ioctl+0x3f/0x50
> <4>[  345.408627]  __x64_sys_ioctl+0x84/0xc0
> <4>[  345.409117]  do_syscall_64+0x33/0x40
> <4>[  345.409592]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> <4>[  345.410233] RIP: 0033:0x7f3747632107
> 
> <4>[  345.413125] RSP: 002b:00007ffe461b6648 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
> <4>[  345.414086] RAX: ffffffffffffffda RBX: 00000000007b7fd0 RCX: 00007f3747632107
> <4>[  345.414998] RDX: 00007ffe461b6650 RSI: 00000000c0484e41 RDI: 0000000000000004
> <4>[  345.415966] RBP: 0000000000000004 R08: 00000000007b7fe8 R09: 00000000007b9080
> <4>[  345.416883] R10: 00007ffe461b62c0 R11: 0000000000000206 R12: 00000000007b7fd0
> <4>[  345.417808] R13: 0000000000000000 R14: 0000000000000003 R15: 0000000000000000
> 
> Add a NULL check before we set the bdev for bio.
> 
> This issue is found on block/for-next tree.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>  drivers/nvme/host/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ba5df80881ea..1a3cdc6b1036 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1133,7 +1133,8 @@ static int nvme_submit_user_cmd(struct request_queue *q,
>  		if (ret)
>  			goto out;
>  		bio = req->bio;
> -		bio_set_dev(bio, bdev);
> +		if (bdev)
> +			bio_set_dev(bio, bdev);
>  		if (bdev && meta_buffer && meta_len) {
>  			meta = nvme_add_user_metadata(bio, meta_buffer, meta_len,
>  					meta_seed, write);
> -- 
> 2.22.1
---end quoted text---
