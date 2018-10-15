Return-Path: <BATV+d906faeb8e2e46e3163e+5531+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 15 Oct 2018 02:27:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Changpeng Liu <changpeng.liu@intel.com>
Subject: Re: [PATCH v8] virtio_blk: add discard and write zeroes support
Message-ID: <20181015092740.GA3964@infradead.org>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
 <20181012210628.226361-1-dverkamp@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181012210628.226361-1-dverkamp@chromium.org>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 12, 2018 at 02:06:28PM -0700, Daniel Verkamp wrote:
> From: Changpeng Liu <changpeng.liu@intel.com>
> 
> In commit 88c85538, "virtio-blk: add discard and write zeroes features
> to specification" (https://github.com/oasis-tcs/virtio-spec), the virtio

There is some issues in this spec.  For one using the multiple ranges
also for write zeroes is rather inefficient.  Write zeroes really should
use the same format as read and write.

Second the unmap flag isn't properly specified at all, as nothing
says the device may not unmap without the unmap flag.  Please take
a look at the SCSI or NVMe ѕpec for some guidance.

> +static inline int virtblk_setup_discard_write_zeroes(struct request *req,
> +						bool unmap)

Why is this an inline function?
