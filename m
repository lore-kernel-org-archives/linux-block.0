Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:51629 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751551AbdF1V3J (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 17:29:09 -0400
Date: Wed, 28 Jun 2017 23:29:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shaohua Li <shli@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH V4 10/12] block: call __bio_free in bio_endio
Message-ID: <20170628212908.GA19350@lst.de>
References: <cover.1498666964.git.shli@fb.com> <f1e84225656d403485ac5f1bd8b9f5db42bc74ca.1498666964.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f1e84225656d403485ac5f1bd8b9f5db42bc74ca.1498666964.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 28, 2017 at 09:30:00AM -0700, Shaohua Li wrote:
> From: Shaohua Li <shli@fb.com>
> 
> bio_free isn't a good place to free cgroup/integrity info. There are a
> lot of cases bio is allocated in special way (for example, in stack) and
> never gets called by bio_put hence bio_free, we are leaking memory. This
> patch moves the free to bio endio, which should be called anyway. The
> __bio_free call in bio_free is kept, in case the bio never gets called
> bio endio.
> 
> This assumes ->bi_end_io() doesn't access cgroup/integrity info, which
> seems true in my audit. Otherwise, we probably must add a flag to
> distinguish if bio will be called by bio_put.

bio_integrity_endio -> bio_integrity_verify_fn -> bio_integrity_process
access the integrity data, so I don't think this works as-is.
