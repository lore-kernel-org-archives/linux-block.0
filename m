Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F405FC433DB
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 07:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4E16520C
	for <linux-block@archiver.kernel.org>; Tue,  9 Mar 2021 07:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhCIHbo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Mar 2021 02:31:44 -0500
Received: from verein.lst.de ([213.95.11.211]:58639 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230150AbhCIHbO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 9 Mar 2021 02:31:14 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id AEA8B68B05; Tue,  9 Mar 2021 08:31:10 +0100 (CET)
Date:   Tue, 9 Mar 2021 08:31:10 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        kernel test robot <lkp@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] libnvdimm: Let revalidate_disk() revalidate region
 read-only
Message-ID: <20210309073110.GA3140@lst.de>
References: <161527286194.446794.5215036039655765042.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161527286194.446794.5215036039655765042.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 08, 2021 at 10:54:22PM -0800, Dan Williams wrote:
> Previous kernels allowed the BLKROSET to override the disk's read-only
> status. With that situation fixed the pmem driver needs to rely on
> revalidate_disk() to clear the disk read-only status after the host
> region has been marked read-write.
> 
> Recall that when libnvdimm determines that the persistent memory has
> lost persistence (for example lack of energy to flush from DRAM to FLASH
> on an NVDIMM-N device) it marks the region read-only, but that state can
> be overridden by the user via:
> 
>    echo 0 > /sys/bus/nd/devices/regionX/read_only
> 
> ...to date there is no notification that the region has restored
> persistence, so the user override is the only recovery.

I've just resent my series to kill of ->revalidate_disk for good, so this
obvious makes me a little unhappy.  Given that ->revalidate_disk
only ends up beeing called from the same path that ->open is called,
why can't you just hook this up from the open method?

Also any reason the sysfs attribute can't just directly propagate the
information to the disk?
