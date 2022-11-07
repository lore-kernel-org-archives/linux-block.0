Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385C0C4332F
	for <linux-block@archiver.kernel.org>; Mon,  7 Nov 2022 19:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiKGT5k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiKGT5j (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Nov 2022 14:57:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E8E20BF1
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 11:57:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50A2D612BC
        for <linux-block@vger.kernel.org>; Mon,  7 Nov 2022 19:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C84EC433D6;
        Mon,  7 Nov 2022 19:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667851057;
        bh=po+t5+xDRaTUQDY66K6YsG/GXCxUYIAj4XzIMMd17Bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TkyXwXFFimB7zpzESyeDzseo0OCClnZ7/8Z62duyQt3TZLRuJnmrd3+GnlcxdvUhV
         pmAUR0WemH0BV87DuzAt0I7dtjTPSF8LElieF6RWe5XXi931gxlnzW+PChamlcQ24E
         0qnEwwwH68c9ZiboegccMvaV2Z6PAOXjL8FZ3BQJyq2/H1cYQ2OvxKAwdK1snvMiJZ
         XKayRHgJ+LEI4k1l4um4YRAVtnqv98ICvL2HrtJXbYo1GjdqKXVptACUxhUPJrh77t
         hHP4YgYvwfhE69QfnPAjET81EhqvgcpS8E8TmYmrxsR0nB8m7razuE7p73+J0MTT+w
         k7NiFKCbT+HuQ==
Date:   Mon, 7 Nov 2022 11:57:36 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] block: untangle request_queue refcounting from sysfs
Message-ID: <Y2ljMMNLLy3lG8VA@sol.localdomain>
References: <20221105080815.775721-1-hch@lst.de>
 <20221105080815.775721-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105080815.775721-2-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 05, 2022 at 09:08:14AM +0100, Christoph Hellwig wrote:
> @@ -811,7 +772,8 @@ int blk_register_queue(struct gendisk *disk)
>  
>  	mutex_lock(&q->sysfs_dir_lock);
>  
> -	ret = kobject_add(&q->kobj, &disk_to_dev(disk)->kobj, "queue");
> +	kobject_init(&disk->queue_kobj, &blk_queue_ktype);
> +	ret = kobject_add(&disk->queue_kobj, &disk_to_dev(disk)->kobj, "queue");

Use kobject_init_and_add()?  Also, kobject_put() needs to be called on error.

- Eric
