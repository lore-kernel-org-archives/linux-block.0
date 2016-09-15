Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:55779 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbcIOOmP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Sep 2016 10:42:15 -0400
Date: Thu, 15 Sep 2016 16:42:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>, tglx@linutronix.de,
        agordeev@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: blk-mq: allow passing in an external queue mapping V3
Message-ID: <20160915144212.GA26430@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de> <20160915144050.GD16556@localhost.localdomain> <20160915143202.GA26221@lst.de> <de5c219e-fe1f-7524-6054-995ae2f734ae@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <de5c219e-fe1f-7524-6054-995ae2f734ae@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 15, 2016 at 08:34:42AM -0600, Jens Axboe wrote:
> I was going to ask about splitting it, but that looks fine, I can pull
> that in.
>
> The series looks fine to me. My only real concern is giving drivers the
> flexibility to define mappings, I don't want that to evolve into drivers
> (again) doing stupid things wrt mappings. As long as we keep it strictly
> as a tunnel for passing mappings defined by the (previous blk-mq) core
> code, then that's fine.

So my earlier versions just passed in the affinity mask and left
all the mapping in the core.  This doesn't really work anymore with
the sibling aware code so I had to add a method.  That being said there
are some drivers that might want slightly different mappings.

For example skd (if converted to blk-mq) has MSI-X vectors for it's up
to four queues, but it also has MSI-X vectors for misc book keeping
before those, so we'd need a version of our PCI mapping that adds an
offset to add to queue number when assining the MSI-X vectors.

That being said I structured the map_queues interface so it can't do
anything crazy - it can just build up the cpu to queue mapping array
so there isn't exactly a whole lot of crazy things a driver could do.

