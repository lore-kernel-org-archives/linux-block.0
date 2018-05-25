Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Fri, 25 May 2018 00:53:06 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>
Subject: Re: [RESEND PATCH V5 00/33] block: support multipage bvec
Message-ID: <20180525045306.GB8740@kmo-pixel>
References: <20180525034621.31147-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180525034621.31147-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri, May 25, 2018 at 11:45:48AM +0800, Ming Lei wrote:
> Hi,
> 
> This patchset brings multipage bvec into block layer:

patch series looks sane to me. goddamn that's a lot of renaming.

Things are going to get interesting when we start sticking compound pages in the
page cache, there'll be some interesting questions of semantics to deal with
then but I think getting this will only help w.r.t. plumbing that through and
not dealing with 4k pages unnecessarily - but I think even if we were to decide
that merging in bio_add_page() is not the way to go when the upper layers are
passing compound pages around already, this patch series helps because
regardless at some point everything under generic_make_request() is going to
have to deal with segments that are more than one page, and this patch series
makes that happen. So incremental progress.

Jens, any objections to getting this in?
