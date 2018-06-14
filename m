Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754838AbeFNSMr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jun 2018 14:12:47 -0400
Date: Thu, 14 Jun 2018 14:12:46 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: NeilBrown <neilb@suse.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Ming Lei <ming.lei@redhat.com>
Subject: Re: why does __split_and_process_bio use bio_clone_bioset?
Message-ID: <20180614181245.GA1161@redhat.com>
References: <20180614081947.GA23375@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180614081947.GA23375@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 14 2018 at  4:19am -0400,
Christoph Hellwig <hch@infradead.org> wrote:

> Hi Neil,
> 
> In commit 18a25da8 ("dm: ensure bio submission follows a depth-first
> tree walk") you've added a call to bio_clone_bioset to
> __split_and_process_bio.  Unlike all other bio splitting code this
> actually allocates a new bio_vec array instead of just splitting the bio
> and the iterator.  I can't actually find a good reason for that either
> in a cursory review of the code, the commit or the comments.
>
> Do you remember why this can't just use bio_clone_fast?

Your question caused me to revisit this code and it is suspect for a
couple reasons:

1) I'm also not seeing why we need bio_clone_bioset()
   - could be quirk of how the code is constructing shallow chains (all
     chained to the same parent) but even that doesn't seem to explain
     it.  I'll just test using bio_clone_fast() and see what happens ;)
2) The final dm.c:end_io_acct() in terms of the smaller and smaller
   clone bio looks prone to insufficient IO accounting.
3) I'm really not liking the mix of bio_chain refcount and DM's own
   io->io_count in the DM endio path.

I'll work through all of this some more and let you know what I find
(hopefully by end of tomorrow).

Mike
