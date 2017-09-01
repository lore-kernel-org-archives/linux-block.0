Return-Path: <axboe@kernel.dk>
Subject: Re: non-blocking buffered reads V5
To: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk
Cc: Milosz Tanski <milosz@adfin.com>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
 mgorman@suse.de, Volker.Lendecke@sernet.de, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20170829141321.4482-1-hch@lst.de> <20170901081354.GA23335@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <eb53fe76-07df-d19b-9e51-67673db3a7e4@kernel.dk>
Date: Fri, 1 Sep 2017 08:58:31 -0600
MIME-Version: 1.0
In-Reply-To: <20170901081354.GA23335@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/01/2017 02:13 AM, Christoph Hellwig wrote:
> Given that we got all the reviews is there as chance to get
> this picked up for 4.14?  The last round of nowait bits went
> through the block tree, and this one has the block bits as well,
> so maybe we should go for that again?

If Al is happy with it, it's not a problem for me.

-- 
Jens Axboe
