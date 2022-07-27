Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A2BC19F2B
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 16:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbiG0QVs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 12:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiG0QVq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 12:21:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766964BD36
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 09:21:36 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id EF30168AA6; Wed, 27 Jul 2022 18:21:32 +0200 (CEST)
Date:   Wed, 27 Jul 2022 18:21:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 1/5] ublk_drv: avoid to leak ublk device in case
 that add_disk fails
Message-ID: <20220727162132.GA18969@lst.de>
References: <20220727141628.985429-1-ming.lei@redhat.com> <20220727141628.985429-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727141628.985429-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

maybe s/avoid/don't/ in the subject?

> -	get_device(&ub->cdev_dev);
>  	ret = add_disk(disk);
>  	if (ret) {
>  		put_disk(disk);
>  		goto out_unlock;

Maybe just add a put_device here in the error branch to keep
things simple?
