Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f194.google.com ([209.85.217.194]:34438 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdDNL0Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2017 07:26:24 -0400
Received: by mail-ua0-f194.google.com with SMTP id u59so6339666uau.1
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2017 04:26:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170413160626.14635-1-ming.lei@redhat.com>
References: <20170413160626.14635-1-ming.lei@redhat.com>
From: Johannes Thumshirn <morbidrsa@gmail.com>
Date: Fri, 14 Apr 2017 13:26:23 +0200
Message-ID: <CAGH8bx4F3qptbxyLevB49NUBRw7rG5U7Yn4NNW9-MtA3mFc8aQ@mail.gmail.com>
Subject: Re: [PATCH] block: fix bio_will_gap()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Apr 13, 2017 at 6:06 PM, Ming Lei <ming.lei@redhat.com> wrote:
> Now commit 729204ef49ec("block: relax check on sg gap")
> allows us to merge bios if both are physically contiguous,
> this change can merge huge of small bios in use case of mkfs,
> for example, mkfs.ntfs running time can be decreased to ~1/10.
>
> But if one rq starts with non-aligned buffer(the 1st bvec's
> bv_offset isn't zero) and if we allow to merge, it is quite
> difficult to respect sg gap limit, especially the segment
> can't be at maximum segment size, otherwise the segment
> ends in unaligned virt boundary. This patch trys to avoid the
> issue by not allowing to merge if the req starts with non-aligned
> buffer.
>
> Also add comments to explain why the merged segment can't
> end in unaligned virt boundary.
>
> Fixes: 729204ef49ec ("block: relax check on sg gap")
> Tested-by: Johannes Thumshirn <jthumshirn@suse.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---


Hi Jens and Omar,

I know Jens is currently on vacation, but can maybe Omar get this fix to Linus
before v4.11? This would be highly appreciated.

Thanks a lot,
        Johannes
