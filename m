Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DAFC6FA86
	for <linux-block@archiver.kernel.org>; Fri, 23 Sep 2022 08:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIWIQ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Sep 2022 04:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiIWIQ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Sep 2022 04:16:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C780121664;
        Fri, 23 Sep 2022 01:16:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22E0DB821C3;
        Fri, 23 Sep 2022 08:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFE6C433C1;
        Fri, 23 Sep 2022 08:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663920982;
        bh=qQQawoyo8Ms4rX1gVkbqT0fErkXp61RRShIVeBDKDKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o9+tOWYJSpa68OMyolen1G+5DULplrdUjy4vXQ2W5eZ0I6oOtsDqosgxCxyn5Uxg+
         +redHmE741xCg+64+6lVvrTSCeBcS3CZKLk7kCE53NVX586JI8bIsLA2Z/BPLeOB/Y
         kVm7JeJmU3M/nPyA8FAHfVzZlG18ryXif+fvcTo0=
Date:   Fri, 23 Sep 2022 10:16:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v10 0/8] Userspace P2PDMA with O_DIRECT NVMe devices
Message-ID: <Yy1rUyTlJZU6U6Nh@kroah.com>
References: <20220922163926.7077-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922163926.7077-1-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 22, 2022 at 10:39:18AM -0600, Logan Gunthorpe wrote:
> Hi,
> 
> This is the latest P2PDMA userspace patch set. This version includes
> some cleanup from feedback of the last posting[1].
> 
> This patch set enables userspace P2PDMA by allowing userspace to mmap()
> allocated chunks of the CMB. The resulting VMA can be passed only
> to O_DIRECT IO on NVMe backed files or block devices. A flag is added
> to GUP() in Patch 1, then Patches 2 through 6 wire this flag up based
> on whether the block queue indicates P2PDMA support. Patches 7
> creates the sysfs resource that can hand out the VMAs and Patch 8
> adds brief documentation for the new interface.
> 
> Feedback welcome.
> 
> This series is based on v6.0-rc6. A git branch is available here:
> 
>   https://github.com/sbates130272/linux-p2pmem/  p2pdma_user_cmb_v10

Looks good to me, thanks for sticking with it.

greg k-h
