Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAE4C76190
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 18:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C26422BE8
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 18:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564078105;
	bh=KiiFegUHU5GPihsnRiipJWlk+KirWCXeCrKP7PJ9rpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=llldaMBAgXJsBEH+luhcm2HGq/GtUFUQjMA9Ujw6CEzdC7fO8MFt7Y/3Zdoosy187
	 f3vgvmJF+YIbh00RbSJjR0nWqtoUb4tmIQZ7DC4m0cN6O64fWWGU7zFA7MQLQB7uLS
	 BqMRh6lF/LcPrgaoBE2ezibU0v0NOV6uwBX2B7a8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfGYSIT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfGYSIT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jul 2019 14:08:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BE45218F0;
        Thu, 25 Jul 2019 18:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564078098;
        bh=KiiFegUHU5GPihsnRiipJWlk+KirWCXeCrKP7PJ9rpc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oA295ozAwbkkLgAao5fN+JRSaJrf6L0LtcY2aIsVs0zCTwQM8QLvcoR8WRWwy1so+
         mwzUu3WkwpFOFBjZRDEAf6HHDVMsAeyHgloYzHJbK820PXzKfUm1RJHEcE0XsUrf/z
         f9CpVOxFp+taewZCX44SLRKoCnk4t3R7S7hi27bY=
Date:   Thu, 25 Jul 2019 20:08:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v6 02/16] chardev: introduce cdev_get_by_path()
Message-ID: <20190725180816.GA32305@kroah.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-3-logang@deltatee.com>
 <20190725174032.GA27818@kroah.com>
 <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682ff89f-04e0-7a94-5aeb-895ac65ee7c9@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 25, 2019 at 11:53:20AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-07-25 11:40 a.m., Greg Kroah-Hartman wrote:
> > On Thu, Jul 25, 2019 at 11:23:21AM -0600, Logan Gunthorpe wrote:
> >> cdev_get_by_path() attempts to retrieve a struct cdev from
> >> a path name. It is analagous to blkdev_get_by_path().
> >>
> >> This will be necessary to create a nvme_ctrl_get_by_path()to
> >> support NVMe-OF passthru.
> > 
> > Ick, why?  Why would a cdev have a "pathname"?
> 
> So we can go from "/dev/nvme0" (which points to a char device) to its
> struct cdev and eventually it's struct nvme_ctrl. Doing it this way also
> allows supporting symlinks that might be created by udev rules.

Why do you have a "string" within the kernel and are not using the
normal open() call from userspace on the character device node on the
filesystem in your namespace/mount/whatever?

Where is this random string coming from?  Why is this so special that no
one else has ever needed it?

thanks,

greg k-h
