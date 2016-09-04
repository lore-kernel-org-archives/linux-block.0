Return-Path: <mst@redhat.com>
Date: Sun, 4 Sep 2016 07:18:22 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Paul Mackerras <paulus@samba.org>, linux-mtd@lists.infradead.org,
        "Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 09/15] virtio-blk: Pass attribute group to device_add_disk
Message-ID: <20160904041822.wxab7bsq4pnj4spr@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
 <1471418115-3654-10-git-send-email-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471418115-3654-10-git-send-email-famz@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 17, 2016 at 03:15:09PM +0800, Fam Zheng wrote:
> Previously after device_add_disk returns, the KOBJ_ADD uevent is already
> emitted. Adding attributes after that is a poor usage of kobject, and
> in practice may result in race conditions with userspace, for
> example udev checks availability of certain attributes and initializes
> /dev entries conditionally.
> 
> device_add_disk can handle adding attribute group better, so use it.
> 
> Meanwhile, handle error of device_add_disk.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>

Feel free to merge this with the rest of patchset
Acked-by: Michael S. Tsirkin <mst@redhat.com>



> ---
>  drivers/block/virtio_blk.c | 38 +++++++++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 4564df5..ff60d82 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -522,10 +522,10 @@ virtblk_cache_type_show(struct device *dev, struct device_attribute *attr,
>  	return snprintf(buf, 40, "%s\n", virtblk_cache_types[writeback]);
>  }
>  
> -static const struct device_attribute dev_attr_cache_type_ro =
> +static struct device_attribute dev_attr_cache_type_ro =
>  	__ATTR(cache_type, S_IRUGO,
>  	       virtblk_cache_type_show, NULL);
> -static const struct device_attribute dev_attr_cache_type_rw =
> +static struct device_attribute dev_attr_cache_type_rw =
>  	__ATTR(cache_type, S_IRUGO|S_IWUSR,
>  	       virtblk_cache_type_show, virtblk_cache_type_store);
>  
> @@ -550,6 +550,26 @@ static struct blk_mq_ops virtio_mq_ops = {
>  static unsigned int virtblk_queue_depth;
>  module_param_named(queue_depth, virtblk_queue_depth, uint, 0444);
>  
> +static struct attribute *virtblk_attrs_ro[] = {
> +	&dev_attr_serial.attr,
> +	&dev_attr_cache_type_ro.attr,
> +	NULL
> +};
> +
> +static struct attribute *virtblk_attrs_rw[] = {
> +	&dev_attr_serial.attr,
> +	&dev_attr_cache_type_rw.attr,
> +	NULL
> +};
> +
> +static struct attribute_group virtblk_attr_group_ro = {
> +	.attrs		= virtblk_attrs_ro,
> +};
> +
> +static struct attribute_group virtblk_attr_group_rw = {
> +	.attrs		= virtblk_attrs_rw,
> +};
> +
>  static int virtblk_probe(struct virtio_device *vdev)
>  {
>  	struct virtio_blk *vblk;
> @@ -560,6 +580,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	u32 v, blk_size, sg_elems, opt_io_size;
>  	u16 min_io_size;
>  	u8 physical_block_exp, alignment_offset;
> +	struct attribute_group *attr_group;
>  
>  	if (!vdev->config->get) {
>  		dev_err(&vdev->dev, "%s failure: config access disabled\n",
> @@ -719,19 +740,14 @@ static int virtblk_probe(struct virtio_device *vdev)
>  
>  	virtio_device_ready(vdev);
>  
> -	device_add_disk(&vdev->dev, vblk->disk, NULL);
> -	err = device_create_file(disk_to_dev(vblk->disk), &dev_attr_serial);
> -	if (err)
> -		goto out_del_disk;
> -
>  	if (virtio_has_feature(vdev, VIRTIO_BLK_F_CONFIG_WCE))
> -		err = device_create_file(disk_to_dev(vblk->disk),
> -					 &dev_attr_cache_type_rw);
> +		attr_group = &virtblk_attr_group_rw;
>  	else
> -		err = device_create_file(disk_to_dev(vblk->disk),
> -					 &dev_attr_cache_type_ro);
> +		attr_group = &virtblk_attr_group_ro;
> +	err = device_add_disk(&vdev->dev, vblk->disk, attr_group);
>  	if (err)
>  		goto out_del_disk;
> +
>  	return 0;
>  
>  out_del_disk:
> -- 
> 2.7.4
