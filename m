Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB894C38142
	for <linux-block@archiver.kernel.org>; Wed,  1 Feb 2023 06:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBAGWb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Feb 2023 01:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBAGW3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Feb 2023 01:22:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6D34DCDC
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 22:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sYrTjFA5vUG5JbQoV9XO4Uliia0C9fm2z0aDTT6urnw=; b=NhauvDpj6sFBiiQUzDXFz5FDmI
        A4yb5Crddt7Zi/TvMe1GKGw8RevTsfSCJMEp0OeclBfd/yHXYxKyinqG1wh421s1972Pvg/lSmv3c
        0AQmVLvjOvTdRXMnEY5b7yI9VsfalfXMY8nEpDvQ2M/qSm2D63FeDqyeyzc37+Y2QCUPJQSidVpBB
        djrNFCGyP4GAB2twgXIb/mss/uCejvkCj204G5shSlpnuDL+7MRpHiDhyl1uHpSfoti/rVOTKEC0G
        tzrnRO2eIJGqD6l+PVpXNXUE5I71EdDcGBX/CSxlW5Jm2NZV3Gi9pvuCaqgL2/VuY21/ny4UsPAOM
        CrvPmzog==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pN6Vi-00ARyw-H2; Wed, 01 Feb 2023 06:22:22 +0000
Date:   Tue, 31 Jan 2023 22:22:22 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
Message-ID: <Y9oFHssFz2obv83W@infradead.org>
References: <20221130175653.24299-1-jack@suse.cz>
 <ada13b1b-dd2a-8be0-3b12-3470a086bbf6@huaweicloud.com>
 <Y9kiltmuPSbRRLsO@infradead.org>
 <92d53d6b-f83d-0767-4f6a-1b897b33b227@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92d53d6b-f83d-0767-4f6a-1b897b33b227@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 01, 2023 at 09:04:12AM +0800, Yu Kuai wrote:
> > +	if (test_bit(GD_NEED_PART_SCAN, &disk->state) && !bdev->bd_holder)
> >   		bdev_disk_changed(disk, false);
> 
> I think this is wrong here... We should at least allow the exclusively
> opener to scan partition, right?

bd_holder is only set in bd_finish_claiming, which is called after
the partition rescan.
