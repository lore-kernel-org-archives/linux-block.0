Return-Path: <BATV+f764a039e38d8f16f694+5542+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 26 Oct 2018 01:26:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Daniel Verkamp <dverkamp@chromium.org>,
	Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
	Changpeng Liu <changpeng.liu@intel.com>
Subject: Re: [PATCH v8] virtio_blk: add discard and write zeroes support
Message-ID: <20181026082640.GA1147@infradead.org>
References: <1528258740-6581-1-git-send-email-changpeng.liu@intel.com>
 <20181012210628.226361-1-dverkamp@chromium.org>
 <20181015092740.GA3964@infradead.org>
 <486afcff-a8bd-a05b-e331-e395d4d14853@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <486afcff-a8bd-a05b-e331-e395d4d14853@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 26, 2018 at 01:28:54AM +0200, Paolo Bonzini wrote:
> On 15/10/2018 11:27, Christoph Hellwig wrote:
> > There is some issues in this spec.  For one using the multiple ranges
> > also for write zeroes is rather inefficient.  Write zeroes really should
> > use the same format as read and write.
> 
> What makes it inefficient?

We require a memory allocation for each write zeroes instead of encoding
the lba/len in the command.
