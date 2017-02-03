Return-Path: <jasowang@redhat.com>
Subject: Re: [PATCH 1/9] virtio_pci: remove struct virtio_pci_vq_info
To: Christoph Hellwig <hch@lst.de>, mst@redhat.com
References: <1485504997-17584-1-git-send-email-hch@lst.de>
 <1485504997-17584-2-git-send-email-hch@lst.de>
Cc: axboe@kernel.dk, pbonzini@redhat.com,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a5568074-d92e-8322-6955-19c640006fda@redhat.com>
Date: Fri, 3 Feb 2017 15:54:36 +0800
MIME-Version: 1.0
In-Reply-To: <1485504997-17584-2-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 2017年01月27日 16:16, Christoph Hellwig wrote:
> We don't really need struct virtio_pci_vq_info, as most field in there
> are redundant:
>
>   - the vq backpointer is not strictly neede to start with
>   - the entry in the vqs list is not needed - the generic virtqueue already
>     has list, we only need to check if it has a callback to get the same
>     semantics
>   - we can use a simple array to look up the MSI-X vec if needed.
>   - That simple array now also duoble serves to replace the per_vq_vectors
>     flag
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/virtio/virtio_pci_common.c | 117 +++++++++++--------------------------
>   drivers/virtio/virtio_pci_common.h |  25 +-------
>   drivers/virtio/virtio_pci_legacy.c |   6 +-
>   drivers/virtio/virtio_pci_modern.c |   6 +-
>   4 files changed, 39 insertions(+), 115 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 186cbab..a3376731 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -62,16 +62,13 @@ static irqreturn_t vp_config_changed(int irq, void *opaque)
>   static irqreturn_t vp_vring_interrupt(int irq, void *opaque)
>   {
>   	struct virtio_pci_device *vp_dev = opaque;
> -	struct virtio_pci_vq_info *info;
>   	irqreturn_t ret = IRQ_NONE;
> -	unsigned long flags;
> +	struct virtqueue *vq;
>   
> -	spin_lock_irqsave(&vp_dev->lock, flags);
> -	list_for_each_entry(info, &vp_dev->virtqueues, node) {
> -		if (vring_interrupt(irq, info->vq) == IRQ_HANDLED)
> +	list_for_each_entry(vq, &vp_dev->vdev.vqs, list) {
> +		if (vq->callback && vring_interrupt(irq, vq) == IRQ_HANDLED)

The check of vq->callback seems redundant, we will check it soon in 
vring_interrupt().

Thanks
