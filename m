Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:46756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752761AbeFNGji (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jun 2018 02:39:38 -0400
Date: Wed, 13 Jun 2018 23:39:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@fb.com>,
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
Message-ID: <20180614063920.GA10284@infradead.org>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180609123014.8861-16-ming.lei@redhat.com>
 <20180613145654.GE4693@infradead.org>
 <20180614020137.GF19828@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180614020137.GF19828@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 14, 2018 at 10:01:38AM +0800, Ming Lei wrote:
> Bounce limits the max pages as 256 will do bio splitting, so won't need
> this change.

Behavior for the bounce code does not change with my patch.

The important points are:

 - the default interface (bio_clone_bioset in this case) should always
   operate on full biosets
 - if the bounce code needs bioves limited to single pages it should
   be treated as the special case
 - given that the bounce code is inside the block layer using the
   __-prefixed internal interface is perfectly fine
 - last but not least I think the parameter switching the behavior
   needs a much more descriptive name as suggested in my patch
