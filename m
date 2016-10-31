Return-Path: <linux-block-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:33968 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755005AbcJaOAH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2016 10:00:07 -0400
Date: Mon, 31 Oct 2016 09:59:43 -0400
From: Theodore Ts'o <tytso@mit.edu>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Christie <mchristi@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH 45/60] block: bio: introduce
 bio_for_each_segment_all_rd() and its write pair
Message-ID: <20161031135943.36crigad55hwmmrl@thunk.org>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
 <1477728600-12938-46-git-send-email-tom.leiming@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477728600-12938-46-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Oct 29, 2016 at 04:08:44PM +0800, Ming Lei wrote:
> This patches introduce bio_for_each_segment_all_rd() and
> bio_for_each_segment_all_wt().
> 
> bio_for_each_segment_all_rd() is for replacing
> bio_for_each_segment_all() in case the bvec from bio->bi_io_vec
> is accessed as readonly.
> 
> bio_for_each_segment_all_wt() is for replacing
> bio_for_each_segment_all() in case the bvec from bio->bi_io_vec
> need to be updated.

What is _rd and _wt supposed to stand for?  And speaking more
generally, could you write up some more detailed notes about all of
the various new functions they have been added, when they should be
used, and some kind of roadmap about how things are supposed to work
beyond the very high-level description in the introduction in your
patch series?  Ideally it would go into the Documentation directory,
so that after this patch set gets applied, people will be able to
refer to it to understand how things are supposed to work.

Thanks!!

						- Ted
