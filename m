Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935530AbeFNBVP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jun 2018 21:21:15 -0400
Date: Thu, 14 Jun 2018 09:20:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 00/30] block: support multipage bvec
Message-ID: <20180614012052.GB19828@ming.t460p>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180613145908.GB17340@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180613145908.GB17340@kmo-pixel>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 13, 2018 at 10:59:08AM -0400, Kent Overstreet wrote:
> On Sat, Jun 09, 2018 at 08:29:44PM +0800, Ming Lei wrote:
> > Hi,
> > 
> > This patchset brings multipage bvec into block layer:
> 
> Ming, what's going on with the chunk naming? I haven't been paying attention
> because it feels like it's turned into bike shedding, but I just saw something
> about a 3rd way of iterating over bios? (page/segment/chunk...?)

This patchset takes the chunk naming.

And 'chunk' represents multipage bvec, and 'segment' represents singlepage bvec
basically.

Thanks,
Ming
