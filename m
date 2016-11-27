Return-Path: <mst@redhat.com>
Date: Sun, 27 Nov 2016 05:37:04 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: automatic IRQ affinity for virtio
Message-ID: <20161127053515-mutt-send-email-mst@kernel.org>
References: <1479379403-27880-1-git-send-email-hch@lst.de>
 <20161125072538.GA732@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161125072538.GA732@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Nov 25, 2016 at 08:25:38AM +0100, Christoph Hellwig wrote:
> Btw, what's the best way to get any response to this series?
> But this and the predecessor seem to have completly fallen on deaf
> ears.

I'm sorry, I intend to review soon and if OK merge it.

The fact that it depends on tip means I can't put
it in my first pull request (until tip is merged)
so I deferred review somewhat.
