Return-Path: <hch@lst.de>
Date: Fri, 3 Feb 2017 09:22:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jason Wang <jasowang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, mst@redhat.com, axboe@kernel.dk,
	pbonzini@redhat.com, virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] virtio_pci: remove struct virtio_pci_vq_info
Message-ID: <20170203082250.GA26800@lst.de>
References: <1485504997-17584-1-git-send-email-hch@lst.de> <1485504997-17584-2-git-send-email-hch@lst.de> <a5568074-d92e-8322-6955-19c640006fda@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <a5568074-d92e-8322-6955-19c640006fda@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Feb 03, 2017 at 03:54:36PM +0800, Jason Wang wrote:
>> +	list_for_each_entry(vq, &vp_dev->vdev.vqs, list) {
>> +		if (vq->callback && vring_interrupt(irq, vq) == IRQ_HANDLED)
>
> The check of vq->callback seems redundant, we will check it soon in 
> vring_interrupt().

Good point - I wanted to keep things exactly as-is and dіdn't notice
we were already protected.
