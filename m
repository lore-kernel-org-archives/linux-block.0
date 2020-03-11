Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id 758627DE57
	for <lwn-linux-block@archive.lwn.net>; Wed, 11 Mar 2020 15:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbgCKPzC (ORCPT <rfc822;lwn-linux-block@archive.lwn.net>);
        Wed, 11 Mar 2020 11:55:02 -0400
Received: from verein.lst.de ([213.95.11.211]:60118 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730053AbgCKPzC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 11:55:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 90D1268B05; Wed, 11 Mar 2020 16:54:58 +0100 (CET)
Date:   Wed, 11 Mar 2020 16:54:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     He Zhe <zhe.he@windriver.com>
Cc:     Christoph Hellwig <hch@lst.de>, jack@suse.cz,
        Jens Axboe <axboe@kernel.dk>, viro@zeniv.linux.org.uk,
        bvanassche@acm.org, keith.busch@intel.com, tglx@linutronix.de,
        mwilck@suse.com, yuyufen@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: disk revalidation updates and OOM
Message-ID: <20200311155458.GA24376@lst.de>
References: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com> <20200310074018.GB26381@lst.de> <75865e17-48f8-a63a-3a29-f995115ffcfc@windriver.com> <20200310162647.GA6361@lst.de> <f48683d9-7854-ba5f-da3a-7ef987a539b8@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f48683d9-7854-ba5f-da3a-7ef987a539b8@windriver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/linux-block/20200311155458.GA24376@lst.de/>
List-Archive: <http://archive.lwn.net:8080/linux-block/>
List-Post: <mailto:linux-block@vger.kernel.org>

On Wed, Mar 11, 2020 at 12:03:43PM +0800, He Zhe wrote:
> >> 979c690d block: move clearing bd_invalidated into check_disk_size_change
> >> f0b870d block: remove (__)blkdev_reread_part as an exported API
> >> 142fe8f block: fix bdev_disk_changed for non-partitioned devices
> >> a1548b6 block: move rescan_partitions to fs/block_dev.c
> > Just to make sure we are on the same page:  if you revert all four it
> > works, if you rever all but
> >
> > a1548b6 block: move rescan_partitions to fs/block_dev.c
> >
> > it doesn't?
> 
> After reverting 142fe8f, rescan_partitions would be called in block/ioctl.c
> and cause a build failure. So I need to also revert a1548b6 to provide
> rescan_partitions.
> 
> OR if I manually add the following diff instead of reverting a1548b6, then yes,
> it works too.

Ok, so 142fe8f is good except for the build failure.

Do 142fe8f and 979c690d work with the build fix applied? (f0b870d
shouldn't be interesting for this case).
