Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935583AbeFNCB5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jun 2018 22:01:57 -0400
Date: Thu, 14 Jun 2018 10:01:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 15/30] block: introduce bio_clone_chunk_bioset()
Message-ID: <20180614020137.GF19828@ming.t460p>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180609123014.8861-16-ming.lei@redhat.com>
 <20180613145654.GE4693@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180613145654.GE4693@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 13, 2018 at 07:56:54AM -0700, Christoph Hellwig wrote:
> On Sat, Jun 09, 2018 at 08:29:59PM +0800, Ming Lei wrote:
> > There is one use case(DM) which requires to clone bio chunk by
> > chunk, so introduce this API.
> 
> I don't think DM is the special case here.  The special case is the
> bounce code that only wants single page bios.  Between that, and the
> fact that we only have two callers and one of them is inside the
> block layer I would suggest to fold in the following patch to make
> bio_clone_bioset clone in multi-page bvecs and make the bounce code
> use the low-level interface directly:

Bounce limits the max pages as 256 will do bio splitting, so won't need
this change.


Thanks,
Ming
