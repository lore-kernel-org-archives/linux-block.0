Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2D0C07E99
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 10:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CB3613F7
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 10:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhGEK1f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jul 2021 06:27:35 -0400
Received: from verein.lst.de ([213.95.11.211]:56421 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhGEK1e (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Jul 2021 06:27:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9FCEF68AFE; Mon,  5 Jul 2021 12:24:55 +0200 (CEST)
Date:   Mon, 5 Jul 2021 12:24:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guoqing Jiang <jiangguoqing@kylinos.cn>
Cc:     syzbot <syzbot+9ca43ff47167c0ee3466@syzkaller.appspotmail.com>,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        hch@lst.de
Subject: Re: [syzbot] general protection fault in blk_mq_run_hw_queues
Message-ID: <20210705102455.GA13497@lst.de>
References: <0000000000005093cb05c659dae4@google.com> <79eae2c8-3540-f257-6068-2620570fa7f7@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79eae2c8-3540-f257-6068-2620570fa7f7@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 05, 2021 at 02:00:17PM +0800, Guoqing Jiang wrote:
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index 614d82e7fae4..d2548d36bf21 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -222,8 +222,8 @@ static void nbd_dev_remove(struct nbd_device *nbd)
>
>         if (disk) {
>                 del_gendisk(disk);
> -               blk_mq_free_tag_set(&nbd->tag_set);
>                 blk_cleanup_disk(disk);
> +               blk_mq_free_tag_set(&nbd->tag_set);
>         }
>
> Also paride/pd.c needs the same change, is my understanding correct? 
> Christoph.

Yes.  Do you have a patch or should I send one?
