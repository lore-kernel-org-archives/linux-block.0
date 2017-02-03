Return-Path: <jasowang@redhat.com>
Subject: Re: [PATCH 4/9] virtio_pci: simplify MSI-X setup
To: Christoph Hellwig <hch@lst.de>, mst@redhat.com
References: <1485504997-17584-1-git-send-email-hch@lst.de>
 <1485504997-17584-5-git-send-email-hch@lst.de>
Cc: axboe@kernel.dk, pbonzini@redhat.com,
        virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f91fa4dd-c1c3-2b8d-5111-f21aa747f07e@redhat.com>
Date: Fri, 3 Feb 2017 15:57:03 +0800
MIME-Version: 1.0
In-Reply-To: <1485504997-17584-5-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 2017年01月27日 16:16, Christoph Hellwig wrote:
> Try to grab the MSI-X vectors early and fall back to the shared one
> before doing lots of allocations.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Jason Wang <jasowang@redhat.com>

>   drivers/virtio/virtio_pci_common.c | 58 +++++++++++++++++++-------------------
>   1 file changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index 9c4ad7d3f..74ff74c0 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -142,32 +142,39 @@ void vp_del_vqs(struct virtio_device *vdev)
>   }
>   
>   static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
> -			      struct virtqueue *vqs[],
> -			      vq_callback_t *callbacks[],
> -			      const char * const names[],
> -			      bool per_vq_vectors)
> +		struct virtqueue *vqs[], vq_callback_t *callbacks[],
> +		const char * const names[])
>   {
>   	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>   	const char *name = dev_name(&vp_dev->vdev.dev);
>   	int i, err = -ENOMEM, allocated_vectors, nvectors;
> +	bool shared = false;
>   	u16 msix_vec;
>   
> -	if (per_vq_vectors) {
> -		/* Best option: one for change interrupt, one per vq. */
> -		nvectors = 1;
> -		for (i = 0; i < nvqs; ++i)
> -			if (callbacks[i])
> -				++nvectors;
> -	} else {
> -		/* Second best: one for change, shared for all vqs. */
> +	nvectors = 1;
> +	for (i = 0; i < nvqs; i++) {
> +		if (callbacks[i])
> +			nvectors++;
> +	}
> +
> +	/* Try one vector per queue first. */
> +	err = pci_alloc_irq_vectors(vp_dev->pci_dev, nvectors, nvectors,
> +			PCI_IRQ_MSIX);
> +	if (err < 0) {
> +		/* Fallback to one vector for config, one shared for queues. */
> +		shared = true;
>   		nvectors = 2;
> +		err = pci_alloc_irq_vectors(vp_dev->pci_dev, nvectors, nvectors,
> +				PCI_IRQ_MSIX);
> +		if (err < 0)
> +			return err;
>   	}
>   
>   	vp_dev->msix_vectors = nvectors;
>   	vp_dev->msix_names = kmalloc_array(nvectors,
>   			sizeof(*vp_dev->msix_names), GFP_KERNEL);
>   	if (!vp_dev->msix_names)
> -		return err;
> +		goto out_free_irq_vectors;
>   
>   	vp_dev->msix_affinity_masks = kcalloc(nvectors,
>   			sizeof(*vp_dev->msix_affinity_masks), GFP_KERNEL);
> @@ -180,18 +187,13 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>   			goto out_free_msix_affinity_masks;
>   	}
>   
> -	err = pci_alloc_irq_vectors(vp_dev->pci_dev, nvectors, nvectors,
> -			PCI_IRQ_MSIX);
> -	if (err < 0)
> -		goto out_free_msix_affinity_masks;
> -
>   	/* Set the vector used for configuration */
>   	snprintf(vp_dev->msix_names[0], sizeof(*vp_dev->msix_names),
>   		 "%s-config", name);
>   	err = request_irq(pci_irq_vector(vp_dev->pci_dev, 0), vp_config_changed,
>   			0, vp_dev->msix_names[0], vp_dev);
>   	if (err)
> -		goto out_free_irq_vectors;
> +		goto out_free_msix_affinity_masks;
>   
>   	/* Verify we had enough resources to assign the vector */
>   	if (vp_dev->config_vector(vp_dev, 0) == VIRTIO_MSI_NO_VECTOR) {
> @@ -241,7 +243,11 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>   		}
>   		vp_dev->msix_vector_map[i] = msix_vec;
>   
> -		if (per_vq_vectors)
> +		/*
> +		 * Use a different vector for each queue if they are available,
> +		 * else share the same vector for all VQs.
> +		 */
> +		if (!shared)
>   			allocated_vectors++;
>   	}
>   
> @@ -254,8 +260,6 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>   	vp_dev->config_vector(vp_dev, VIRTIO_MSI_NO_VECTOR);
>   out_free_config_irq:
>   	free_irq(pci_irq_vector(vp_dev->pci_dev, 0), vp_dev);
> -out_free_irq_vectors:
> -	pci_free_irq_vectors(vp_dev->pci_dev);
>   out_free_msix_affinity_masks:
>   	for (i = 0; i < nvectors; i++) {
>   		if (vp_dev->msix_affinity_masks[i])
> @@ -264,6 +268,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>   	kfree(vp_dev->msix_affinity_masks);
>   out_free_msix_names:
>   	kfree(vp_dev->msix_names);
> +out_free_irq_vectors:
> +	pci_free_irq_vectors(vp_dev->pci_dev);
>   	return err;
>   }
>   
> @@ -308,15 +314,9 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
>   {
>   	int err;
>   
> -	/* Try MSI-X with one vector per queue. */
> -	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true);
> -	if (!err)
> -		return 0;
> -	/* Fallback: MSI-X with one vector for config, one shared for queues. */
> -	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false);
> +	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names);
>   	if (!err)
>   		return 0;
> -	/* Finally fall back to regular interrupts. */
>   	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names);
>   }
>   
