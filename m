Return-Path: <BATV+253d158279d9b4f3ffaf+4992+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 24 Apr 2017 08:24:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-cifs@vger.kernel.org, linux-mm@kvack.org,
	jfs-discussion@lists.sourceforge.net, linux-xfs@vger.kernel.org,
	cluster-devel@redhat.com, linux-f2fs-devel@lists.sourceforge.net,
	v9fs-developer@lists.sourceforge.net, osd-dev@open-osd.org,
	linux-nilfs@vger.kernel.org, linux-block@vger.kernel.org,
	dhowells@redhat.com, akpm@linux-foundation.org, hch@infradead.org,
	ross.zwisler@linux.intel.com, mawilcox@microsoft.com, jack@suse.com,
	viro@zeniv.linux.org.uk, corbet@lwn.net, neilb@suse.de, clm@fb.com,
	tytso@mit.edu, axboe@kernel.dk
Subject: Re: [PATCH v3 07/20] nilfs2: set the mapping error when calling
 SetPageError on writeback
Message-ID: <20170424152419.GG9112@infradead.org>
References: <20170424132259.8680-1-jlayton@redhat.com>
 <20170424132259.8680-8-jlayton@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170424132259.8680-8-jlayton@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
