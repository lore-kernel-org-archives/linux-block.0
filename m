Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:56260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751298AbdBOTUA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Feb 2017 14:20:00 -0500
Date: Wed, 15 Feb 2017 11:19:56 -0800
From: Shaohua Li <shli@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v2 0/5] md: use bio_clone_fast()
Message-ID: <20170215191956.bdeusjyi3mazerbe@kernel.org>
References: <1487086143-10255-1-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487086143-10255-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Feb 14, 2017 at 11:28:58PM +0800, Ming Lei wrote:
> Hi,
> 
> This patches replaces bio_clone() with bio_fast_clone() in
> bio_clone_mddev() because:
> 
> 1) bio_clone_mddev() is used in raid normal I/O and isn't in
> resync I/O path, and all the direct access to bvec table in
> raid happens on resync I/O only except for write behind of raid1.
> Write behind is treated specially, so the replacement is safe.
> 
> 2) for write behind, bio_clone() is kept, but this patchset
> introduces bio_clone_bioset_partial() to just clone one specific 
> bvecs range instead of whole table. Then write behind is improved
> too.
> 
> V2:
> 	1) move 3rd patch into 2nd one
> 	2) kill  bio_clone_mddev() and use  bio_clone_fast() directly
> 	3) define local variable 'offset' as sector_t in raid1_write_request()
> 
> V1:
> 	1) don't introduce bio_clone_slow_mddev_partial()
> 	2) return failure if mddev->bio_set can't be created
> 	3) remove check in bio_clone_mddev() as suggested by
> 	Christoph Hellwig.
> 	4) rename bio_clone_mddev() as bio_clone_fast_mddev()

Applied, thanks!
 
> Ming Lei (5):
>   block: introduce bio_clone_bioset_partial()
>   md: fail if mddev->bio_set can't be created
>   md/raid1: use bio_clone_bioset_partial() in case of write behind
>   md: remove unnecessary check on mddev
>   md: fast clone bio in bio_clone_mddev()
> 
>  block/bio.c         | 61 +++++++++++++++++++++++++++++++++++++++++------------
>  drivers/md/faulty.c |  2 +-
>  drivers/md/md.c     | 15 ++++---------
>  drivers/md/md.h     |  2 --
>  drivers/md/raid1.c  | 28 +++++++++++++++++-------
>  drivers/md/raid10.c | 11 +++++-----
>  drivers/md/raid5.c  |  4 ++--
>  include/linux/bio.h | 11 ++++++++--
>  8 files changed, 89 insertions(+), 45 deletions(-)
> 
> -- 
> 2.7.4
> 
