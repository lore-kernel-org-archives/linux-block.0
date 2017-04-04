Return-Path: <BATV+d3eb45c623920cebad2c+4972+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 3 Apr 2017 23:49:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.com, hch@infradead.org,
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
	sagi@grimberg.me, avi@scylladb.com, axboe@kernel.dk,
	linux-api@vger.kernel.org, willy@infradead.org,
	tom.leiming@gmail.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 5/8] nowait aio: return on congested block device
Message-ID: <20170404064934.GC21942@infradead.org>
References: <20170403185307.6243-1-rgoldwyn@suse.de>
 <20170403185307.6243-6-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170403185307.6243-6-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

Please make this a REQ_* flag so that it can be passed in the bio,
the request and as an argument to the get_request functions instead
of testing for a bio.
