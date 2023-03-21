Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B6EC6FD1C
	for <linux-block@archiver.kernel.org>; Tue, 21 Mar 2023 00:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCUAOf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 20:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjCUAOc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 20:14:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894A2305D5
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 17:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uJJ5qoyiiYukjB1RuIr6CC+GKM2fOt8JKRfTntjwfPo=; b=3ryA8j+1wz0jJpk7+fELS+hhMV
        aDNscpNjK7SV7RqqbCnvO/MupTjLLVdrtfHrML+k+HHOyxFpPBlbX1KjLshUjG+Un9hTX7t/58uNZ
        80ni49Jq7HJzevcyWV2ePcR9Aebt67eteqoklIVHV4IiZWqCaR5Saq9+SrYqwkDh0gAUXscS3Q51e
        CvwVUm/n+JmCiqgNlUjI0+UxVgq3gZ2+kcmIG0MhBlIGV0wP2nMxvuVs6IIpFprZsQDAZxboUqm30
        vUDBUjFfZoz3jT8zAcnUX6/VxqIiwzIcPyxxdTNtGUqq526fMPhIoEX/VHjA7xHaQhGtsPaLX4JsG
        sgsrmhhA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pePdo-00Ark3-0p;
        Tue, 21 Mar 2023 00:14:16 +0000
Date:   Mon, 20 Mar 2023 17:14:16 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Dan Helmick <dan.helmick@samsung.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Keith Busch <kbusch@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Boaz Harrosh <boazh@netapp.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH 3/5] brd: make sector size configurable
Message-ID: <ZBj22Ls4tVAz1ugA@bombadil.infradead.org>
References: <20230306120127.21375-1-hare@suse.de>
 <20230306120127.21375-4-hare@suse.de>
 <ZAlOqMMKWhyIzmlN@bombadil.infradead.org>
 <ZBjjlLTxWIp9rY7J@bombadil.infradead.org>
 <yq18rfrt3gp.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq18rfrt3gp.fsf@ca-mkp.ca.oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 20, 2023 at 07:40:44PM -0400, Martin K. Petersen wrote:
> 
> Luis,
> 
> > /sys/block/<disk>/queue/minimum_io_size
> >
> > The documentation suggests " For disk drives this is often the
> > physical block size."
> >
> > /sys/block/<disk>/queue/optimal_io_size
> >
> > The documentation suggests this is "This is rarely reported for disk
> > drives."
> 
> min_io and opt_io are used to key mkfs.xfs' sunit/swidth. So if you're
> using a hardware RAID, MD, or DM, we'll attempt to align allocations on
> stripe boundaries.
> 
> Back when that "rarely reported" blurb was written (2009), we did not
> have any individual disk drives which reported min_io/opt_io. Reporting
> those parameters was mostly a storage array thing. These days it's
> fairly common for both disk drives and SSDs to fill out these fields.

Glad you mentioned this, I followed up in my review of these and I see
even the names, swidth, sunit, are all "stripe" indicative. Based on
what you are saying, it seems we may need to update docs to reflect
actual / new uses.

> > From my review of xfs's mkfs is we essentially use the physical block
> > size as a default sector size if set, otherwise we use the device's
> > logical block size if set otherwise xfsprog's default and so 4096.
> 
> Yep.

The use case for swidth / sunit on mkfs.xfs seemed pretty tied to
striping, and it was not obvious or clear / if using it for hints could be used
today as perhaps intended. At least all the naming and validation stuff
seems to make it very "stripy" still.

  Luis
