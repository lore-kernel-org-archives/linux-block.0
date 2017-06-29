Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:56710 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751661AbdF2UYF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2017 16:24:05 -0400
Date: Thu, 29 Jun 2017 22:24:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shaohua Li <shli@fb.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@fb.com,
        Kernel-team@fb.com
Subject: Re: [PATCH] block: call __bio_free in bio_endio
Message-ID: <20170629202403.GB416@lst.de>
References: <a4ff33f2c114d0d0e1d1f41b7524078d2e9fd3f0.1498762065.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a4ff33f2c114d0d0e1d1f41b7524078d2e9fd3f0.1498762065.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 29, 2017 at 11:54:17AM -0700, Shaohua Li wrote:
> bio_free isn't a good place to free cgroup info. There are a
> lot of cases bio is allocated in special way (for example, in stack) and
> never gets called by bio_put hence bio_free, we are leaking memory. This
> patch moves the free to bio endio, which should be called anyway. The
> __bio_free call in bio_free is kept, in case the bio never gets called
> bio endio.

Jens already renamed __bio_free to bio_uninit in Linus' tree.

That being said I think we should just kill __bio_free once all
the work is in.  But I think we should defer this post the
initial pull for 4.12-rc to reduce the merge pain.
