Return-Path: <BATV+77ddf8e9b1b344f28472+5381+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 18 May 2018 09:06:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: adam.manzanares@wdc.com
Cc: viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
	bcrl@kvack.org, mingo@kernel.org, peterz@infradead.org,
	pombredanne@nexb.com, gregkh@linuxfoundation.org,
	bigeasy@linutronix.de, rgoldwyn@suse.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aio@kvack.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v4 3/3] fs: Add aio iopriority support for block_dev
Message-ID: <20180518160636.GH22791@infradead.org>
References: <20180517203803.2664-1-adam.manzanares@wdc.com>
 <20180517203803.2664-4-adam.manzanares@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180517203803.2664-4-adam.manzanares@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Looks fine, although I'd split it into a aio and block_dev patch.

Also please wire this up for the fs/iomap.c direct I/O code, it should
be essentially the same sniplet as in the block_dev.c code.
