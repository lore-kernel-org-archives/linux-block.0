Return-Path: <hch@lst.de>
Date: Fri, 1 Sep 2017 10:13:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk, axboe@kernel.dk
Cc: Milosz Tanski <milosz@adfin.com>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
	mgorman@suse.de, Volker.Lendecke@sernet.de,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: non-blocking buffered reads V5
Message-ID: <20170901081354.GA23335@lst.de>
References: <20170829141321.4482-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170829141321.4482-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Given that we got all the reviews is there as chance to get
this picked up for 4.14?  The last round of nowait bits went
through the block tree, and this one has the block bits as well,
so maybe we should go for that again?
