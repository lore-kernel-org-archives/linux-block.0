Return-Path: <BATV+30674e279389b978d3d5+4730+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 5 Aug 2016 00:57:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Christie <mchristi@redhat.com>
Cc: ross.zwisler@linux.intel.com, linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	david@fromorbit.com, minchan@kernel.org, ngupta@vflare.org,
	vishal.l.verma@intel.com, axboe@kernel.dk
Subject: Re: [PATCH 1/1] mm/block: convert rw_page users to bio op use
Message-ID: <20160805075756.GA28577@infradead.org>
References: <1470331056-796-1-git-send-email-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470331056-796-1-git-send-email-mchristi@redhat.com>
List-ID: <linux-block@vger.kernel.org>

> 
> The rw_page users were not converted to use bio/req ops. As a result
> bdev_write_page is not passing down REQ_OP_WRITE and the IOs will
> be sent down as reads.

Can we just get rid of REQ_OP_WRITE enum for the ->rw_page interface
and pass a 'bool write'?  If not I'd prefer to avoid using op_is_write
as much as possible - it's a confusing interface if we really want
to do a switch on read vs write vs invalid.
