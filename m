Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838C8C433F5
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 13:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C086103C
	for <linux-block@archiver.kernel.org>; Wed, 10 Nov 2021 13:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhKJNFV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Nov 2021 08:05:21 -0500
Received: from verein.lst.de ([213.95.11.211]:54415 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231151AbhKJNFS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Nov 2021 08:05:18 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 503CE68AA6; Wed, 10 Nov 2021 14:02:28 +0100 (CET)
Date:   Wed, 10 Nov 2021 14:02:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
        czhong@redhat.com
Subject: Re: [PATCH] block: avoid to touch unloaded module instance when
 opening bdev
Message-ID: <20211110130228.GB25614@lst.de>
References: <20211110095511.294645-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110095511.294645-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The technical change looks good, but this comment not only has quite
a few of grammar issues, but also seems rather pointless:

> +	/*
> +	 * New open() will be failed since disk becomes not alive, and old
> +	 * open() has either grabbed the module refcnt or been failed in
> +	 * case of deleting from module_exit(), so disk->fops->owner won't
> +	 * be unloaded if the disk is opened.
> +	 */
>  	mutex_lock(&disk->open_mutex);
>  	remove_inode_hash(disk->part0->bd_inode);
>  	blk_drop_partitions(disk);
> -- 
> 2.31.1
---end quoted 
