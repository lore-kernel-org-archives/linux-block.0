Return-Path: <jasowang@redhat.com>
Subject: Re: [PATCH 2/9] virtio_pci: use shared interrupts for virtqueues
To: Christoph Hellwig <hch@lst.de>, mst@redhat.com
References: <1485504997-17584-1-git-send-email-hch@lst.de>
 <1485504997-17584-3-git-send-email-hch@lst.de>
Cc: axboe@kernel.dk, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Jason Wang <jasowang@redhat.com>
Message-ID: <da34883b-1069-2cfc-aaa3-6aaf3ee0ebf2@redhat.com>
Date: Fri, 3 Feb 2017 15:54:54 +0800
MIME-Version: 1.0
In-Reply-To: <1485504997-17584-3-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 2017年01月27日 16:16, Christoph Hellwig wrote:
> +		snprintf(vp_dev->msix_names[i + 1],
> +			 sizeof(*vp_dev->msix_names), "%s-%s",
>   			 dev_name(&vp_dev->vdev.dev), names[i]);
>   		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> -				  vring_interrupt, 0,
> -				  vp_dev->msix_names[msix_vec],
> -				  vqs[i]);
> +				  vring_interrupt, IRQF_SHARED,
> +				  vp_dev->msix_names[i + 1], vqs[i]);

Do we need to check per_vq_vectors before dereferencing msix_names[i + 1] ?

Thanks
