Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D3719A;
	Thu,  7 Dec 2023 07:19:20 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46A52227A87; Thu,  7 Dec 2023 16:19:17 +0100 (CET)
Date: Thu, 7 Dec 2023 16:19:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Li Feng <fengli@smartx.com>,
	Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:VIRTIO BLOCK AND SCSI DRIVERS" <virtualization@lists.linux.dev>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Message-ID: <20231207151917.GA20401@lst.de>
References: <20231207043118.118158-1-fengli@smartx.com> <20231207145159.GB2147383@fedora> <CABgObfYJUH0hF8QfNUAZS9ztR7LqeHGOXeTa0JO904svJw23_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfYJUH0hF8QfNUAZS9ztR7LqeHGOXeTa0JO904svJw23_g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 07, 2023 at 03:55:17PM +0100, Paolo Bonzini wrote:
> > This seems similar to commit f8b12e513b95 ("virtio_blk: revert
> > QUEUE_FLAG_VIRT addition") where changing the default sounded good in
> > theory but exposed existing users to performance regressions. [...]
> > I don't want to be overly conservative. The virtio_blk driver has
> > undergone changes in this regard from the legacy block layer to blk-mq
> > (without an I/O scheduler) to blk-mq (mq-deadline).
> 
> IIRC there were also regressions in both virtio-blk and virtio-scsi
> when switching from the legacy block layer to blk-mq. So perhaps I
> *am* a bit more conservative, but based on past experience, this patch
> seems not to be a great idea for practical use cases.

Agreed.  I'm in fact not exactly happy about the rather odd
BLK_MQ_F_NO_SCHED_BY_DEFAULT flag to start with.
