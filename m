Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734E1C10F1B
	for <linux-block@archiver.kernel.org>; Mon, 19 Dec 2022 10:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbiLSKfg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Dec 2022 05:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiLSKfe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Dec 2022 05:35:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF1C63B4
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2022 02:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671446093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MExHpuuhQYCTJXGp5HCPC8JoK68/o4CTdhPI1nGGBCc=;
        b=Vp6STS9PohTNg2qmtswqNxmAe4xtQVAxwwhnXIFcKaYzbxUBpol1uKdbKiQXTeYQDNeBy8
        hVGwtH3OQF8zbwuFbqduBdvlEP13ED8GlbU580T4gEJxj8CcJ2h3403vjgMHg+t+1x2kmp
        2qG0Tsi+3GFB3gRMi+zmyW4EsujfNks=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-290-KoSW6cw4MAeYOwpGYsVy1g-1; Mon, 19 Dec 2022 05:34:51 -0500
X-MC-Unique: KoSW6cw4MAeYOwpGYsVy1g-1
Received: by mail-qv1-f72.google.com with SMTP id qf9-20020a0562144b8900b004c71efc3528so5416694qvb.22
        for <linux-block@vger.kernel.org>; Mon, 19 Dec 2022 02:34:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MExHpuuhQYCTJXGp5HCPC8JoK68/o4CTdhPI1nGGBCc=;
        b=6detTGF09LlperEzxP6CKUwLkvzwfupWBODQY2WQqOpZ5xRtyya7G3qkXTlJh17ZPV
         zCqrqhcJVUW0Io3r1c+Hwvo/0v4JP8IzGYJaAe9Fx1k7m/8Bakmvc9Iu2cyoXTGms7jg
         5q5W/N1v+c3+g15Nh/GxRHRkh7QuDNjV5WHqBrrOTZH5x3zz0m6KNbDh7uuSFKLQUpWP
         qDWKRkkXnXsg6ygDxNutff23+e3G2xqiVe2W2M8qC2MF2Ydeuc9sbYqX8LCXi39EL0Fz
         ++CLvQTY6txhGSSAXUR7VOPZHtRdQkk3rK7/rAkehdaRKBrrOYbO8iJLtebzFzvUcJ4d
         x3zQ==
X-Gm-Message-State: AFqh2kqhzbeU5be/IINjvNHBkqHuRSs59mWiTE1g9NaTAnN1PzqSE7OD
        Lo81jC3rSpNbX6QY9y58r2n0MfHuqSk/LKXhj56I1+8scVjNIn5MdBNJy0VoHdka10hKXnhEUEM
        pHCaG2FxY9WcWlIWQ3FDCLME=
X-Received: by 2002:ac8:480a:0:b0:3a5:2704:d4c0 with SMTP id g10-20020ac8480a000000b003a52704d4c0mr12875348qtq.31.1671446091167;
        Mon, 19 Dec 2022 02:34:51 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuU8Q0zFAvQQlpZtICL6HHlUyfxsvufzIKmgMnE08JzncxHu9djN+1BfC7kA6OtQWVeQzoTGA==
X-Received: by 2002:ac8:480a:0:b0:3a5:2704:d4c0 with SMTP id g10-20020ac8480a000000b003a52704d4c0mr12875314qtq.31.1671446090795;
        Mon, 19 Dec 2022 02:34:50 -0800 (PST)
Received: from redhat.com ([45.144.113.29])
        by smtp.gmail.com with ESMTPSA id bj30-20020a05620a191e00b006cbe3be300esm6823870qkb.12.2022.12.19.02.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 02:34:50 -0800 (PST)
Date:   Mon, 19 Dec 2022 05:34:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221219053022-mutt-send-email-mst@kernel.org>
References: <20221219101307.131279-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219101307.131279-1-alvaro.karsz@solid-run.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 19, 2022 at 12:13:06PM +0200, Alvaro Karsz wrote:
> Implement the VIRTIO_BLK_F_LIFETIME feature for Virtio block devices.
> 
> This commit introduces a new ioctl command, VIRTIO_BLK_IOCTL_GET_LIFETIME.
> 
> VIRTIO_BLK_IOCTL_GET_LIFETIME ioctl asks for the block device to provide
> lifetime information by sending a VIRTIO_BLK_T_GET_LIFETIME command to
> the device.
> 
> lifetime information fields:
> 
> - pre_eol_info: specifies the percentage of reserved blocks that are
> 		consumed.
> 		optional values following virtio spec:
> 		*) 0 - undefined.
> 		*) 1 - normal, < 80% of reserved blocks are consumed.
> 		*) 2 - warning, 80% of reserved blocks are consumed.
> 		*) 3 - urgent, 90% of reserved blocks are consumed.
> 
> - device_lifetime_est_typ_a: this field refers to wear of SLC cells and
> 			     is provided in increments of 10used, and so
> 			     on, thru to 11 meaning estimated lifetime
> 			     exceeded. All values above 11 are reserved.
> 
> - device_lifetime_est_typ_b: this field refers to wear of MLC cells and is
> 			     provided with the same semantics as
> 			     device_lifetime_est_typ_a.
> 
> The data received from the device will be sent as is to the user.
> No data check/decode is done by virtblk.
> 
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Since you repin it anyway, do you mind rebasing on top of my tree?


> --
> v2:
> 	- Remove (void *) casting.
> 	- Fix comments format in virtio_blk.h.
> 	- Set ioprio value for legacy devices for REQ_OP_DRV_IN
> 	  operations.
> 
> v3:
> 	- Initialize struct virtio_blk_lifetime to 0 instead of memset.
> 	- Rename ioctl from VBLK_LIFETIME to VBLK_GET_LIFETIME.
> 	- Return EOPNOTSUPP insted of ENOTTY if ioctl is not supported.
> 	- Check if process is CAP_SYS_ADMIN capable in lifetime ioctl.
> 	- Check if vdev is not NULL before accessing it in lifetime ioctl.
> 
> v4:
> 	- Create a dedicated virtio_blk_ioctl.h header for the ioctl command
> 	  and add this file to MAINTAINERS.
> 	- Rename the ioctl to VIRTIO_BLK_IOCTL_GET_LIFETIME.
> 	- Document in virtio_blk_ioctl.h which backend device can supply
> 	  this lifetime information.
> --
> ---
>  MAINTAINERS                           |   1 +
>  drivers/block/virtio_blk.c            | 107 ++++++++++++++++++++++++--
>  include/uapi/linux/virtio_blk.h       |  28 +++++++
>  include/uapi/linux/virtio_blk_ioctl.h |  44 +++++++++++
>  4 files changed, 175 insertions(+), 5 deletions(-)
>  create mode 100644 include/uapi/linux/virtio_blk_ioctl.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f4d9dcb760..0368a903483 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21917,6 +21917,7 @@ F:	drivers/block/virtio_blk.c
>  F:	drivers/scsi/virtio_scsi.c
>  F:	drivers/vhost/scsi.c
>  F:	include/uapi/linux/virtio_blk.h
> +F:	include/uapi/linux/virtio_blk_ioctl.h
>  F:	include/uapi/linux/virtio_scsi.h
>  
>  VIRTIO CONSOLE DRIVER
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 68bd2f7961b..a0431d3ad07 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -9,6 +9,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/virtio.h>
>  #include <linux/virtio_blk.h>
> +#include <linux/virtio_blk_ioctl.h>
>  #include <linux/scatterlist.h>
>  #include <linux/string_helpers.h>
>  #include <linux/idr.h>
> @@ -101,6 +102,18 @@ static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
>  	}
>  }
>  
> +static inline int virtblk_ioctl_result(struct virtblk_req *vbr)
> +{
> +	switch (vbr->status) {
> +	case VIRTIO_BLK_S_OK:
> +		return 0;
> +	case VIRTIO_BLK_S_UNSUPP:
> +		return -EOPNOTSUPP;
> +	default:
> +		return -EIO;
> +	}
> +}
> +
>  static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx)
>  {
>  	struct virtio_blk *vblk = hctx->queue->queuedata;
> @@ -218,6 +231,7 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  	u32 type;
>  
>  	vbr->out_hdr.sector = 0;
> +	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
>  
>  	switch (req_op(req)) {
>  	case REQ_OP_READ:
> @@ -244,15 +258,14 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  		type = VIRTIO_BLK_T_SECURE_ERASE;
>  		break;
>  	case REQ_OP_DRV_IN:
> -		type = VIRTIO_BLK_T_GET_ID;
> -		break;
> +		/* type is set in virtblk_get_id/virtblk_ioctl_lifetime */
> +		return 0;
>  	default:
>  		WARN_ON_ONCE(1);
>  		return BLK_STS_IOERR;
>  	}
>  
>  	vbr->out_hdr.type = cpu_to_virtio32(vdev, type);
> -	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
>  
>  	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES ||
>  	    type == VIRTIO_BLK_T_SECURE_ERASE) {
> @@ -459,12 +472,16 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
>  	struct virtio_blk *vblk = disk->private_data;
>  	struct request_queue *q = vblk->disk->queue;
>  	struct request *req;
> +	struct virtblk_req *vbr;
>  	int err;
>  
>  	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
>  
> +	vbr = blk_mq_rq_to_pdu(req);
> +	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
> +
>  	err = blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
>  	if (err)
>  		goto out;
> @@ -508,6 +525,85 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  	return ret;
>  }
>  
> +/* Get lifetime information from device */
> +static int virtblk_ioctl_lifetime(struct virtio_blk *vblk, unsigned long arg)
> +{
> +	struct request_queue *q = vblk->disk->queue;
> +	struct request *req = NULL;
> +	struct virtblk_req *vbr;
> +	struct virtio_blk_lifetime lifetime = {};
> +	int ret;
> +

I would maybe add a comment

/*
 It's not clear whether exposing lifetime info to userspace
 has any security implications but out of abundance of caution
 we limit it to privileged users.
*/
  
> process like a database or key-value store accesses. Can the untrusted
> process read the lifetime information of the entire device?


> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;



> +
> +	/* The virtio_blk_lifetime struct fields follow virtio spec.
> +	 * There is no check/decode on values received from the device.
> +	 * The data is sent as is to the user.
> +	 */
> +
> +	/* This ioctl is allowed only if VIRTIO_BLK_F_LIFETIME
> +	 * feature is negotiated.
> +	 */
> +	if (!virtio_has_feature(vblk->vdev, VIRTIO_BLK_F_LIFETIME))
> +		return -EOPNOTSUPP;
> +
> +	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
> +	if (IS_ERR(req))
> +		return PTR_ERR(req);
> +
> +	/* Write the correct type */
> +	vbr = blk_mq_rq_to_pdu(req);
> +	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_LIFETIME);
> +
> +	ret = blk_rq_map_kern(q, req, &lifetime, sizeof(lifetime), GFP_KERNEL);
> +	if (ret)
> +		goto out;
> +
> +	blk_execute_rq(req, false);
> +
> +	ret = virtblk_ioctl_result(blk_mq_rq_to_pdu(req));
> +	if (ret)
> +		goto out;
> +
> +	/* Pass the data to the user */
> +	if (copy_to_user((void __user *)arg, &lifetime, sizeof(lifetime))) {
> +		ret = -EFAULT;
> +		goto out;
> +	}
> +
> +out:
> +	blk_mq_free_request(req);
> +	return ret;
> +}
> +
> +static int virtblk_ioctl(struct block_device *bd, fmode_t mode,
> +			 unsigned int cmd, unsigned long arg)
> +{
> +	struct virtio_blk *vblk = bd->bd_disk->private_data;
> +	int ret;
> +
> +	mutex_lock(&vblk->vdev_mutex);
> +
> +	if (!vblk->vdev) {
> +		ret = -ENXIO;
> +		goto exit;
> +	}
> +
> +	switch (cmd) {
> +	case VIRTIO_BLK_IOCTL_GET_LIFETIME:
> +		ret = virtblk_ioctl_lifetime(vblk, arg);
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +exit:
> +	mutex_unlock(&vblk->vdev_mutex);
> +	return ret;
> +}
> +
>  static void virtblk_free_disk(struct gendisk *disk)
>  {
>  	struct virtio_blk *vblk = disk->private_data;
> @@ -520,6 +616,7 @@ static void virtblk_free_disk(struct gendisk *disk)
>  static const struct block_device_operations virtblk_fops = {
>  	.owner  	= THIS_MODULE,
>  	.getgeo		= virtblk_getgeo,
> +	.ioctl		= virtblk_ioctl,
>  	.free_disk	= virtblk_free_disk,
>  };
>  
> @@ -1239,7 +1336,7 @@ static unsigned int features_legacy[] = {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> -	VIRTIO_BLK_F_SECURE_ERASE,
> +	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_LIFETIME,
>  }
>  ;
>  static unsigned int features[] = {
> @@ -1247,7 +1344,7 @@ static unsigned int features[] = {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> -	VIRTIO_BLK_F_SECURE_ERASE,
> +	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_LIFETIME,
>  };
>  
>  static struct virtio_driver virtio_blk = {
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index 58e70b24b50..b1360eab36a 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -40,6 +40,7 @@
>  #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
>  #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
>  #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
> +#define VIRTIO_BLK_F_LIFETIME	15 /* Storage lifetime information is supported */
>  #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
>  
>  /* Legacy feature bits */
> @@ -165,6 +166,9 @@ struct virtio_blk_config {
>  /* Get device ID command */
>  #define VIRTIO_BLK_T_GET_ID    8
>  
> +/* Get lifetime information command */
> +#define VIRTIO_BLK_T_GET_LIFETIME 10
> +
>  /* Discard command */
>  #define VIRTIO_BLK_T_DISCARD	11
>  
> @@ -206,6 +210,30 @@ struct virtio_blk_discard_write_zeroes {
>  	__le32 flags;
>  };
>  
> +/* Get lifetime information struct for each request */
> +struct virtio_blk_lifetime {
> +	/*
> +	 * specifies the percentage of reserved blocks that are consumed.
> +	 * optional values following virtio spec:
> +	 * 0 - undefined
> +	 * 1 - normal, < 80% of reserved blocks are consumed
> +	 * 2 - warning, 80% of reserved blocks are consumed
> +	 * 3 - urgent, 90% of reserved blocks are consumed
> +	 */
> +	__le16 pre_eol_info;
> +	/*
> +	 * this field refers to wear of SLC cells and is provided in increments of 10used,
> +	 * and so on, thru to 11 meaning estimated lifetime exceeded. All values above 11
> +	 * are reserved
> +	 */
> +	__le16 device_lifetime_est_typ_a;
> +	/*
> +	 * this field refers to wear of MLC cells and is provided with the same semantics as
> +	 * device_lifetime_est_typ_a
> +	 */
> +	__le16 device_lifetime_est_typ_b;
> +};
> +
>  #ifndef VIRTIO_BLK_NO_LEGACY
>  struct virtio_scsi_inhdr {
>  	__virtio32 errors;
> diff --git a/include/uapi/linux/virtio_blk_ioctl.h b/include/uapi/linux/virtio_blk_ioctl.h
> new file mode 100644
> index 00000000000..f87afb6be00
> --- /dev/null
> +++ b/include/uapi/linux/virtio_blk_ioctl.h
> @@ -0,0 +1,44 @@
> +#ifndef _LINUX_VIRTIO_BLK_IOCTL_H
> +#define _LINUX_VIRTIO_BLK_IOCTL_H
> +/* This header is BSD licensed so anyone can use the definitions to implement
> + * compatible drivers/servers.
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + *    notice, this list of conditions and the following disclaimer.
> + * 2. Redistributions in binary form must reproduce the above copyright
> + *    notice, this list of conditions and the following disclaimer in the
> + *    documentation and/or other materials provided with the distribution.
> + * 3. Neither the name of IBM nor the names of its contributors
> + *    may be used to endorse or promote products derived from this software
> + *    without specific prior written permission.
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS ``AS IS'' AND
> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED.  IN NO EVENT SHALL IBM OR CONTRIBUTORS BE LIABLE
> + * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
> + * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
> + * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
> + * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
> + * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
> + * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> + * SUCH DAMAGE.
> + */
> +
> +#include <linux/ioctl.h>
> +#include <linux/virtio_blk.h>
> +
> +/*
> + * The virtio_blk_lifetime fields can be reported by eMMC and UFS storage devices,
> + * which can predict and measure wear over time.
> + * eMMC/UFS storage devices are common in embedded systems, making this ioctl beneficial mostly
> + * for embedded systems using these type of storage as virtio-blk backend.
> + *
> + * Please note that virtio_blk_lifetime fields are little endian as defined in the virtio spec.
> + * Caller must convert the fields to the cpu endianness.
> + */
> +#define VIRTIO_BLK_IOCTL_GET_LIFETIME   _IOR('r', 0, struct virtio_blk_lifetime)
> +
> +#endif /* _LINUX_VIRTIO_BLK_IOCTL_H */
> -- 
> 2.32.0

