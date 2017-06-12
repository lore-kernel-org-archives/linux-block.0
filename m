Return-Path: <BATV+db5541eadd89fe7a50e5+5041+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 12 Jun 2017 05:45:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@ZenIV.linux.org.uk>, Jan Kara <jack@suse.cz>,
	tytso@mit.edu, axboe@kernel.dk, mawilcox@microsoft.com,
	ross.zwisler@linux.intel.com, corbet@lwn.net,
	Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
	David Sterba <dsterba@suse.com>,
	"Darrick J . Wong" <darrick.wong@oracle.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v6 12/20] fs: add a new fstype flag to indicate how
 writeback errors are tracked
Message-ID: <20170612124513.GC18360@infradead.org>
References: <20170612122316.13244-1-jlayton@redhat.com>
 <20170612122316.13244-15-jlayton@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170612122316.13244-15-jlayton@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 12, 2017 at 08:23:06AM -0400, Jeff Layton wrote:
> Add a new FS_WB_ERRSEQ flag to the fstype. Later patches will set and
> key off of that to decide what behavior should be used.

Please invert this so that only file systems that keep the old semantics
need a flag.
