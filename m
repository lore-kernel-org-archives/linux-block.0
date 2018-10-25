Return-Path: <paolo.bonzini@gmail.com>
Return-Path: <paolo.bonzini@gmail.com>
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH v8] virtio_blk: add discard and write zeroes support
To: Christoph Hellwig <hch@infradead.org>,
 Daniel Verkamp <dverkamp@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Changpeng Liu <changpeng.liu@intel.com>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
 <20181012210628.226361-1-dverkamp@chromium.org>
 <20181015092740.GA3964@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <486afcff-a8bd-a05b-e331-e395d4d14853@redhat.com>
Date: Fri, 26 Oct 2018 01:28:54 +0200
MIME-Version: 1.0
In-Reply-To: <20181015092740.GA3964@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 15/10/2018 11:27, Christoph Hellwig wrote:
> There is some issues in this spec.  For one using the multiple ranges
> also for write zeroes is rather inefficient.  Write zeroes really should
> use the same format as read and write.

What makes it inefficient?

> Second the unmap flag isn't properly specified at all, as nothing
> says the device may not unmap without the unmap flag.  Please take
> a look at the SCSI or NVMe ѕpec for some guidance.

Thanks, I'll submit a patch for this.

Paolo
