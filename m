Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AD5C4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 14:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiKBORI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiKBORG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 10:17:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE18D24F17
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 07:17:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E1C7A68AA6; Wed,  2 Nov 2022 15:17:00 +0100 (CET)
Date:   Wed, 2 Nov 2022 15:17:00 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH 8/7] block: don't claim devices that are not live in
 bd_link_disk_holder
Message-ID: <20221102141700.GA4442@lst.de>
References: <20221102064854.GA8950@lst.de> <1dc5c1d0-72b6-5455-0b05-5c755ad69045@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1dc5c1d0-72b6-5455-0b05-5c755ad69045@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 02, 2022 at 08:17:37PM +0800, Yu Kuai wrote:
> I think this is still not safe 🤔

Indeed - wrong open_mutex.

> +       /*
> +        * del_gendisk drops the initial reference to bd_holder_dir, so we 
> need
> +        * to keep our own here to allow for cleanup past that point.
> +        */
> +       mutex_lock(&bdev->bd_disk->open_mutex);
> +       if (!disk_live(bdev->bd_disk)) {
> +               ret = -ENODEV;
> +               mutex_unlock(&bdev->bd_disk->open_mutex);
> +               goto out_unlock;
> +       }

I think this needs to be done before taking disk->open_mutex, otherwise
we create a lock order dependency.  Also the comment seems to overflow
the usual 80 character limit, and as you noted in the next mail this
needs more unwinding.  But yes, otherwise this is the right thing to
do.  Do you want to send a replacement for this patch?
