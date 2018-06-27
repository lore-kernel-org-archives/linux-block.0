Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56762 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752144AbeF0NRN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jun 2018 09:17:13 -0400
Date: Wed, 27 Jun 2018 09:17:11 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH V7 01/24] dm: use bio_split() when splitting out the
 already processed bio
Message-ID: <20180627131711.GA11531@redhat.com>
References: <20180627124548.3456-1-ming.lei@redhat.com>
 <20180627124548.3456-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180627124548.3456-2-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 27 2018 at  8:45am -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> From: Mike Snitzer <snitzer@redhat.com>
> 
> Use of bio_clone_bioset() is inefficient if there is no need to clone
> the original bio's bio_vec array.  Best to use the bio_clone_fast()
> variant.  Also, just using bio_advance() is only part of what is needed
> to properly setup the clone -- it doesn't account for the various
> bio_integrity() related work that also needs to be performed (see
> bio_split).
> 
> Address both of these issues by switching from bio_clone_bioset() to
> bio_split().
> 
> Fixes: 18a25da8 ("dm: ensure bio submission follows a depth-first tree walk")
> Cc: stable@vger.kernel.org
> Reported-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: NeilBrown <neilb@suse.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>

FYI, I'll be sending this to Linus tomorrow.

Mike
