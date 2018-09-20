Return-Path: <hch@lst.de>
Date: Thu, 20 Sep 2018 08:31:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-block <linux-block@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
Message-ID: <20180920063129.GB12913@lst.de>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 19, 2018 at 05:15:43PM +0800, Ming Lei wrote:
> 1) does kmalloc-N slab guarantee to return N-byte aligned buffer?  If
> yes, is it a stable rule?

This is the assumption in a lot of the kernel, so I think if somethings
breaks this we are in a lot of pain.
