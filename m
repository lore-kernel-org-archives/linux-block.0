Return-Path: <BATV+18407e09be20ac120074+5053+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sat, 24 Jun 2017 04:59:46 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@ZenIV.linux.org.uk>, Jan Kara <jack@suse.cz>,
	tytso@mit.edu, axboe@kernel.dk, mawilcox@microsoft.com,
	ross.zwisler@linux.intel.com, corbet@lwn.net,
	Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
	David Sterba <dsterba@suse.com>,
	"Darrick J . Wong" <darrick.wong@oracle.com>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Eryu Guan <eguan@redhat.com>, David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v7 16/22] block: convert to errseq_t based writeback
 error tracking
Message-ID: <20170624115946.GA22561@infradead.org>
References: <20170616193427.13955-1-jlayton@redhat.com>
 <20170616193427.13955-17-jlayton@redhat.com>
 <20170620123544.GC19781@infradead.org>
 <1497980684.4555.16.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497980684.4555.16.camel@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 20, 2017 at 01:44:44PM -0400, Jeff Layton wrote:
> In order to query for errors with errseq_t, you need a previously-
> sampled point from which to check. When you call
> filemap_write_and_wait_range though you don't have a struct file and so
> no previously-sampled value.

So can we simply introduce variants of them that take a struct file?
That would be:

 a) less churn
 b) less code
 c) less chance to get data integrity wrong
