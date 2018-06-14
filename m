Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:54476 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752420AbeFNGTI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jun 2018 02:19:08 -0400
Date: Wed, 13 Jun 2018 23:18:59 -0700
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
Subject: Re: [PATCH V6 00/30] block: support multipage bvec
Message-ID: <20180614061858.GA3336@infradead.org>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180611164806.GA7452@infradead.org>
 <20180612034242.GC26412@ming.t460p>
 <20180613144253.GA4693@infradead.org>
 <20180614011852.GA19828@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180614011852.GA19828@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jun 14, 2018 at 09:18:58AM +0800, Ming Lei wrote:
> This one may cause confusing, since we iterate over pages via
> bio_for_each_segment(), but the _all version takes another name
> of page, still iterate over pages.
> 
> So could we change it in the following way?
> 
>  OLD:	    bio_for_each_segment_all
>  NEW(page): bio_for_each_segment_all (update prototype in one tree-wide &
>  			big patch, to be renamed bio_for_each_page_all)
>  NEW(bvec):  (no bvec version needed once bcache is fixed up)	

Fine with me, but I thought Jens didn't like that sweeping change?
