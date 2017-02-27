Return-Path: <hch@lst.de>
Date: Mon, 27 Feb 2017 09:48:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>,
	jasowang@redhat.com, axboe@kernel.dk, pbonzini@redhat.com,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: automatic IRQ affinity for virtio V3
Message-ID: <20170227084832.GA22373@lst.de>
References: <20170205171526.6224-1-hch@lst.de> <20170209135031.GA5771@infradead.org> <20170209180130-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170209180130-mutt-send-email-mst@kernel.org>
List-ID: <linux-block@vger.kernel.org>

On Thu, Feb 09, 2017 at 06:01:57PM +0200, Michael S. Tsirkin wrote:
> > Any chance to get this in for 4.11 after I got reviews from Jason
> > for most of the patches?
> 
> Absolutely, I intend to merge it.

So, what is the plan for virtio this merge window?  No changes seem
to have made it into linux-next before the merge window, never mind
a week into it.
