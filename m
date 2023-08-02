Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96494C001E0
	for <linux-block@archiver.kernel.org>; Wed,  2 Aug 2023 12:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjHBMaQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Aug 2023 08:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjHBMaP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Aug 2023 08:30:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD709B
        for <linux-block@vger.kernel.org>; Wed,  2 Aug 2023 05:30:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3BE1868AA6; Wed,  2 Aug 2023 14:30:11 +0200 (CEST)
Date:   Wed, 2 Aug 2023 14:30:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, axboe@kernel.dk,
        linux-block@vger.kernel.org
Subject: Re: [PATCH V2 1/1] pmem: set QUEUE_FLAG_NOWAIT
Message-ID: <20230802123010.GB30792@lst.de>
References: <20230731224617.8665-1-kch@nvidia.com> <20230731224617.8665-2-kch@nvidia.com> <x491qgmwzuv.fsf@segfault.boston.devel.redhat.com> <20230801155943.GA13111@lst.de> <x49wmyevej2.fsf@segfault.boston.devel.redhat.com> <0a2d86d6-34a1-0c8d-389c-1dc2f886f108@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a2d86d6-34a1-0c8d-389c-1dc2f886f108@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Given that pmem simply loops over an arbitrarily large bio I think
we also need a threshold for which to allow nowait I/O.  While it
won't block for giant I/Os, doing all of them in the submitter
context isn't exactly the idea behind the nowait I/O.

I'm not really sure what a good theshold would be, though.

Btw, please also always add linux-block to the Cc list for block
driver patches that are even the slightest bit about the block
layer interface.
