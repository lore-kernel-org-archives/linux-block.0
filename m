Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751515AbdF1Vmw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 17:42:52 -0400
Date: Wed, 28 Jun 2017 14:42:49 -0700
From: Shaohua Li <shli@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        tj@kernel.org, gregkh@linuxfoundation.org, axboe@fb.com,
        rostedt@goodmis.org, lizefan@huawei.com, Kernel-team@fb.com,
        Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V4 10/12] block: call __bio_free in bio_endio
Message-ID: <20170628214249.z42lypwtgzgdzh62@kernel.org>
References: <cover.1498666964.git.shli@fb.com>
 <f1e84225656d403485ac5f1bd8b9f5db42bc74ca.1498666964.git.shli@fb.com>
 <20170628212908.GA19350@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170628212908.GA19350@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 28, 2017 at 11:29:08PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 28, 2017 at 09:30:00AM -0700, Shaohua Li wrote:
> > From: Shaohua Li <shli@fb.com>
> > 
> > bio_free isn't a good place to free cgroup/integrity info. There are a
> > lot of cases bio is allocated in special way (for example, in stack) and
> > never gets called by bio_put hence bio_free, we are leaking memory. This
> > patch moves the free to bio endio, which should be called anyway. The
> > __bio_free call in bio_free is kept, in case the bio never gets called
> > bio endio.
> > 
> > This assumes ->bi_end_io() doesn't access cgroup/integrity info, which
> > seems true in my audit. Otherwise, we probably must add a flag to
> > distinguish if bio will be called by bio_put.
> 
> bio_integrity_endio -> bio_integrity_verify_fn -> bio_integrity_process
> access the integrity data, so I don't think this works as-is.

oh, I probably missed the integrity endio. could we let bio_integrity_verify_fn
free integrity info and and bio_endio free cgroup info?
