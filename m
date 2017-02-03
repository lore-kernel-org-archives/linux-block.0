Return-Path: <jasowang@redhat.com>
Subject: Re: [PATCH 6/9] virtio: provide a method to get the IRQ affinity mask
 for a virtqueue
To: Christoph Hellwig <hch@lst.de>, mst@redhat.com
References: <1485504997-17584-1-git-send-email-hch@lst.de>
 <1485504997-17584-7-git-send-email-hch@lst.de>
Cc: axboe@kernel.dk, pbonzini@redhat.com,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ce408222-03fd-b269-e6d5-439f1c37aa44@redhat.com>
Date: Fri, 3 Feb 2017 16:02:20 +0800
MIME-Version: 1.0
In-Reply-To: <1485504997-17584-7-git-send-email-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 2017年01月27日 16:16, Christoph Hellwig wrote:
> This basically passed up the pci_irq_get_affinity information through
> virtio through an optional get_vq_affinity method.  It is only implemented
> by the PCI backend for now, and only when we use per-virtqueue IRQs.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Jason Wang <jasowang@redhat.com>

>   drivers/virtio/virtio_pci_common.c | 11 +++++++++++
>   drivers/virtio/virtio_pci_common.h |  2 ++
>   drivers/virtio/virtio_pci_legacy.c |  1 +
>   drivers/virtio/virtio_pci_modern.c |  2 ++
>   include/linux/virtio_config.h      |  3 +++
>   5 files changed, 19 insertions(+)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index c244212..31ba259 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -361,6 +361,17 @@ int vp_set_vq_affinity(struct virtqueue *vq, int cpu)
>   	return 0;
>   }
>   
> +const struct cpumask *vp_get_vq_affinity(struct virtio_device *vdev, int index)
> +{
> +	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +	unsigned int *map = vp_dev->msix_vector_map;
> +
> +	if (!map || map[index] == VIRTIO_MSI_NO_VECTOR)
> +		return NULL;
> +
> +	return pci_irq_get_affinity(vp_dev->pci_dev, map[index]);
> +}
> +
>   #ifdef CONFIG_PM_SLEEP
>   static int virtio_pci_freeze(struct device *dev)
>   {
> diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
> index a6ad9ec..ac8c9d7 100644
> --- a/drivers/virtio/virtio_pci_common.h
> +++ b/drivers/virtio/virtio_pci_common.h
> @@ -108,6 +108,8 @@ const char *vp_bus_name(struct virtio_device *vdev);
>    */
>   int vp_set_vq_affinity(struct virtqueue *vq, int cpu);
>   
> +const struct cpumask *vp_get_vq_affinity(struct virtio_device *vdev, int index);
> +
>   #if IS_ENABLED(CONFIG_VIRTIO_PCI_LEGACY)
>   int virtio_pci_legacy_probe(struct virtio_pci_device *);
>   void virtio_pci_legacy_remove(struct virtio_pci_device *);
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index 2ab6aee..f7362c5 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -190,6 +190,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>   	.finalize_features = vp_finalize_features,
>   	.bus_name	= vp_bus_name,
>   	.set_vq_affinity = vp_set_vq_affinity,
> +	.get_vq_affinity = vp_get_vq_affinity,
>   };
>   
>   /* the PCI probing function */
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index a7a0981..7bc3004 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -437,6 +437,7 @@ static const struct virtio_config_ops virtio_pci_config_nodev_ops = {
>   	.finalize_features = vp_finalize_features,
>   	.bus_name	= vp_bus_name,
>   	.set_vq_affinity = vp_set_vq_affinity,
> +	.get_vq_affinity = vp_get_vq_affinity,
>   };
>   
>   static const struct virtio_config_ops virtio_pci_config_ops = {
> @@ -452,6 +453,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
>   	.finalize_features = vp_finalize_features,
>   	.bus_name	= vp_bus_name,
>   	.set_vq_affinity = vp_set_vq_affinity,
> +	.get_vq_affinity = vp_get_vq_affinity,
>   };
>   
>   /**
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index 2ebe506..8355bab 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -58,6 +58,7 @@ struct irq_affinity;
>    *      This returns a pointer to the bus name a la pci_name from which
>    *      the caller can then copy.
>    * @set_vq_affinity: set the affinity for a virtqueue.
> + * @get_vq_affinity: get the affinity for a virtqueue (optional).
>    */
>   typedef void vq_callback_t(struct virtqueue *);
>   struct virtio_config_ops {
> @@ -77,6 +78,8 @@ struct virtio_config_ops {
>   	int (*finalize_features)(struct virtio_device *vdev);
>   	const char *(*bus_name)(struct virtio_device *vdev);
>   	int (*set_vq_affinity)(struct virtqueue *vq, int cpu);
> +	const struct cpumask *(*get_vq_affinity)(struct virtio_device *vdev,
> +			int index);
>   };
>   
>   /* If driver didn't advertise the feature, it will never appear. */
