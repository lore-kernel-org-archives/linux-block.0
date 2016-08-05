Return-Path: <BATV+30674e279389b978d3d5+4730+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 5 Aug 2016 00:53:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, kbuild test robot <lkp@intel.com>,
	Mike Christie <mchristi@redhat.com>, kbuild-all@01.org,
	ross.zwisler@linux.intel.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	minchan@kernel.org, ngupta@vflare.org, vishal.l.verma@intel.com
Subject: Re: [PATCH 1/1] mm/block: convert rw_page users to bio op use
Message-ID: <20160805075335.GA20445@infradead.org>
References: <201608050158.hllBWy4G%fengguang.wu@intel.com>
 <38523086-1436-fdbf-bd89-9f31ad134bed@kernel.dk>
 <20160805021854.GV12670@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160805021854.GV12670@dastard>
List-ID: <linux-block@vger.kernel.org>

On Fri, Aug 05, 2016 at 12:18:55PM +1000, Dave Chinner wrote:
> Give this is being spread all over the kernel way outside the block
> layer and IO path, shouldn't this have some kind of namespace
> component to the name? i.e "req_op_is_write()"?

The READ/WRITE #defines alias to the request ops, so this helper is
rather global as well.  Not that I like it, but it will take a while
to clean that up, including making various things __bitwise annotated
enums to get proper sparse type checking.
