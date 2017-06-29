Return-Path: <BATV+a3f5f3e6054314e6ea5e+5058+infradead.org+hch@bombadil.srs.infradead.org>
Date: Thu, 29 Jun 2017 07:12:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: jlayton@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Al Viro <viro@ZenIV.linux.org.uk>, Jan Kara <jack@suse.cz>,
	tytso@mit.edu, axboe@kernel.dk, mawilcox@microsoft.com,
	ross.zwisler@linux.intel.com, corbet@lwn.net,
	Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
	David Sterba <dsterba@suse.com>,
	"Darrick J . Wong" <darrick.wong@oracle.com>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Eryu Guan <eguan@redhat.com>, David Howells <dhowells@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Liu Bo <bo.li.liu@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v8 17/18] xfs: minimal conversion to errseq_t writeback
 error reporting
Message-ID: <20170629141235.GB17251@infradead.org>
References: <20170629131954.28733-1-jlayton@kernel.org>
 <20170629131954.28733-18-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629131954.28733-18-jlayton@kernel.org>
List-ID: <linux-block@vger.kernel.org>

Nice and simple, this looks great!

Reviewed-by: Christoph Hellwig <hch@lst.de>
