Return-Path: <mst@redhat.com>
Date: Tue, 31 Jul 2018 18:11:59 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
	Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 6/6] virtio-blk: modernize sysfs attribute creation
Message-ID: <20180731181145-mutt-send-email-mst@kernel.org>
References: <20180730071227.22887-1-hare@suse.de>
 <20180730071227.22887-7-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730071227.22887-7-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 30, 2018 at 09:12:27AM +0200, Hannes Reinecke wrote:
> Use new-style DEVICE_ATTR_RO/DEVICE_ATTR_RW to create the sysfs attributes
> and register the disk with default sysfs attribute groups.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> Cc: Michael Tsirkin <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

what's the right tree to merge this?

> ---
>  drivers/block/virtio_blk.c | 68 ++++++++++++++++++++++++++--------------------
>  1 file changed, 39 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index fe80560000a1..086c6bb12baa 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -351,8 +351,8 @@ static int minor_to_index(int minor)
>  	return minor >> PART_BITS;
>  }
>  
> -static ssize_t virtblk_serial_show(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> +static ssize_t serial_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
>  {
>  	struct gendisk *disk = dev_to_disk(dev);
>  	int err;
> @@ -371,7 +371,7 @@ static ssize_t virtblk_serial_show(struct device *dev,
>  	return err;
>  }
>  
> -static DEVICE_ATTR(serial, 0444, virtblk_serial_show, NULL);
> +static DEVICE_ATTR_RO(serial);
>  
>  /* The queue's logical block size must be set before calling this */
>  static void virtblk_update_capacity(struct virtio_blk *vblk, bool resize)
> @@ -545,8 +545,8 @@ static const char *const virtblk_cache_types[] = {
>  };
>  
>  static ssize_t
> -virtblk_cache_type_store(struct device *dev, struct device_attribute *attr,
> -			 const char *buf, size_t count)
> +cache_type_store(struct device *dev, struct device_attribute *attr,
> +		 const char *buf, size_t count)
>  {
>  	struct gendisk *disk = dev_to_disk(dev);
>  	struct virtio_blk *vblk = disk->private_data;
> @@ -564,8 +564,7 @@ virtblk_cache_type_store(struct device *dev, struct device_attribute *attr,
>  }
>  
>  static ssize_t
> -virtblk_cache_type_show(struct device *dev, struct device_attribute *attr,
> -			 char *buf)
> +cache_type_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	struct gendisk *disk = dev_to_disk(dev);
>  	struct virtio_blk *vblk = disk->private_data;
> @@ -575,12 +574,38 @@ virtblk_cache_type_show(struct device *dev, struct device_attribute *attr,
>  	return snprintf(buf, 40, "%s\n", virtblk_cache_types[writeback]);
>  }
>  
> -static const struct device_attribute dev_attr_cache_type_ro =
> -	__ATTR(cache_type, 0444,
> -	       virtblk_cache_type_show, NULL);
> -static const struct device_attribute dev_attr_cache_type_rw =
> -	__ATTR(cache_type, 0644,
> -	       virtblk_cache_type_show, virtblk_cache_type_store);
> +static DEVICE_ATTR_RW(cache_type);
> +
> +static struct attribute *virtblk_attrs[] = {
> +	&dev_attr_serial.attr,
> +	&dev_attr_cache_type.attr,
> +	NULL,
> +};
> +
> +static umode_t virtblk_attrs_are_visible(struct kobject *kobj,
> +		struct attribute *a, int n)
> +{
> +	struct device *dev = container_of(kobj, struct device, kobj);
> +	struct gendisk *disk = dev_to_disk(dev);
> +	struct virtio_blk *vblk = disk->private_data;
> +	struct virtio_device *vdev = vblk->vdev;
> +
> +	if (a == &dev_attr_cache_type.attr &&
> +	    !virtio_has_feature(vdev, VIRTIO_BLK_F_CONFIG_WCE))
> +		return S_IRUGO;
> +
> +	return a->mode;
> +}
> +
> +static const struct attribute_group virtblk_attr_group = {
> +	.attrs = virtblk_attrs,
> +	.is_visible = virtblk_attrs_are_visible,
> +};
> +
> +static const struct attribute_group *virtblk_attr_groups[] = {
> +	&virtblk_attr_group,
> +	NULL,
> +};
>  
>  static int virtblk_init_request(struct blk_mq_tag_set *set, struct request *rq,
>  		unsigned int hctx_idx, unsigned int numa_node)
> @@ -780,24 +805,9 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	virtblk_update_capacity(vblk, false);
>  	virtio_device_ready(vdev);
>  
> -	device_add_disk(&vdev->dev, vblk->disk, NULL);
> -	err = device_create_file(disk_to_dev(vblk->disk), &dev_attr_serial);
> -	if (err)
> -		goto out_del_disk;
> -
> -	if (virtio_has_feature(vdev, VIRTIO_BLK_F_CONFIG_WCE))
> -		err = device_create_file(disk_to_dev(vblk->disk),
> -					 &dev_attr_cache_type_rw);
> -	else
> -		err = device_create_file(disk_to_dev(vblk->disk),
> -					 &dev_attr_cache_type_ro);
> -	if (err)
> -		goto out_del_disk;
> +	device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
>  	return 0;
>  
> -out_del_disk:
> -	del_gendisk(vblk->disk);
> -	blk_cleanup_queue(vblk->disk->queue);
>  out_free_tags:
>  	blk_mq_free_tag_set(&vblk->tag_set);
>  out_put_disk:
> -- 
> 2.12.3
