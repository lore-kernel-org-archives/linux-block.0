Return-Path: <hch@lst.de>
Date: Mon, 19 Mar 2018 20:58:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 05/11] block: sed-opal: print failed function address
Message-ID: <20180319195850.GG3380@lst.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de> <9c333dc3b35cf9c43061567837de32bf154c2fe4.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9c333dc3b35cf9c43061567837de32bf154c2fe4.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 19, 2018 at 07:36:47PM +0100, Jonas Rabenstein wrote:
> Add function address (and if available its symbol) to the message if a
> step function fails.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
