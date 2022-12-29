Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C75C4332F
	for <linux-block@archiver.kernel.org>; Thu, 29 Dec 2022 08:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiL2ILW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Dec 2022 03:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiL2ILO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Dec 2022 03:11:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01D5BE6
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 00:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672301427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B3YjoszznLFklLTfwtR5BXbJfmJOzEircr2M/sDATMk=;
        b=HRQQitf/F4Sy2/RAxg1Kbgn4h/mbyxJwyClcnUd4j+F87xfeX80g8hMM8JMTLKGwAxj6Ye
        8IbXYgV67LJFEGBY17rEzwbv6l/h0ENt/2Hatcbl+CjIiv8VCyOLfxayIW4dgVg4rSYaMM
        IUgoOg0xX91jT++seWzE7b/ftt5iyZU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-330-a0zc2TTmN22lOmsQHjIxPw-1; Thu, 29 Dec 2022 03:10:24 -0500
X-MC-Unique: a0zc2TTmN22lOmsQHjIxPw-1
Received: by mail-wm1-f72.google.com with SMTP id i7-20020a05600c354700b003d62131fe46so12307954wmq.5
        for <linux-block@vger.kernel.org>; Thu, 29 Dec 2022 00:10:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3YjoszznLFklLTfwtR5BXbJfmJOzEircr2M/sDATMk=;
        b=feYq4y1XOPk0xJZdfxxfoRhagUkHOU9uj5TJqP2pHIcpEroxnKmAEmN/dUhiq04b/g
         ZPkkQhKjy7s0wfYfJOTsFsXe8yRaDbzU2wJVoH90MPv7k14B5fvHfo/g20jd+u5F5kF4
         RnSYMEwo+8FYexXyuepyxlpyD8U7j7O+K7GrD2lOYmzc5dIxHFRfigZzWQU+4SC+01ah
         qX/lNm4Qh6vIhrDa6RtXEof0TcLtyLl5V0t3f2Z89qXETA3YV/EJ6/HVNRDNJwBQTdwD
         H+5Uoup5ylfBhmaSOwOj+mYaFinNVNjyxrTvqPl9SHkpPXzlwaTvnPNEoVQIRuwoXB+b
         pAVg==
X-Gm-Message-State: AFqh2kqyyQ+q+qmKN3OOyYVpRYvF75AwhgjaHIRzY+kIyLTvgC2QcU14
        d8jYDk9NhyB4wY/RsHy/AiGbE2MXeT267//HvvEZv9z2p9RvyigyjI/Z2YGk6VKmBIgJ7cfJCwO
        Y+R0EPVSGD4RFvM3/6OhhsDU=
X-Received: by 2002:a05:600c:1d1d:b0:3cf:81af:8b73 with SMTP id l29-20020a05600c1d1d00b003cf81af8b73mr19417756wms.23.1672301420325;
        Thu, 29 Dec 2022 00:10:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsdyjNAxEIcjWRVz7IPBxuq2db4McF4Hr2893bchPb3h1HzJQku8xVgut7yyhIFClftc8onVg==
X-Received: by 2002:a05:600c:1d1d:b0:3cf:81af:8b73 with SMTP id l29-20020a05600c1d1d00b003cf81af8b73mr19417741wms.23.1672301420003;
        Thu, 29 Dec 2022 00:10:20 -0800 (PST)
Received: from redhat.com ([2.52.151.85])
        by smtp.gmail.com with ESMTPSA id n41-20020a05600c3ba900b003d358beab9dsm26356063wms.47.2022.12.29.00.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 00:10:19 -0800 (PST)
Date:   Thu, 29 Dec 2022 03:10:16 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v5] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221229030850-mutt-send-email-mst@kernel.org>
References: <20221219122155.333099-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219122155.333099-1-alvaro.karsz@solid-run.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 19, 2022 at 02:21:55PM +0200, Alvaro Karsz wrote:
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


So due to my mistake this got pushed out to next linux release.
Sorry :(
I'd like to use this opportunity to write a new better
interface that actually works with modern backends,
and add it to the virtio spec.

Do you think you can take up this task?


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
> 
> v5:
> 	- Rebase patch on top of mst tree.
> 	- Add a comment explaining the capable(CAP_SYS_ADMIN) part.
> --
> ---
>  MAINTAINERS                           |   1 +
>  drivers/block/virtio_blk.c            | 102 +++++++++++++++++++++++++-
>  include/uapi/linux/virtio_blk.h       |  28 +++++++
>  include/uapi/linux/virtio_blk_ioctl.h |  44 +++++++++++
>  4 files changed, 173 insertions(+), 2 deletions(-)
>  create mode 100644 include/uapi/linux/virtio_blk_ioctl.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4aee796cc..3250f7753 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21724,6 +21724,7 @@ F:	drivers/block/virtio_blk.c
>  F:	drivers/scsi/virtio_scsi.c
>  F:	drivers/vhost/scsi.c
>  F:	include/uapi/linux/virtio_blk.h
> +F:	include/uapi/linux/virtio_blk_ioctl.h
>  F:	include/uapi/linux/virtio_scsi.h
>  
>  VIRTIO CONSOLE DRIVER
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 3c9dae237..1e03bfa9f 100644
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
> @@ -112,6 +113,18 @@ struct virtblk_req {
>  	struct scatterlist sg[];
>  };
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
>  static inline blk_status_t virtblk_result(u8 status)
>  {
>  	switch (status) {
> @@ -840,6 +853,90 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
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
> +	/* It's not clear whether exposing lifetime info to userspace
> +	 * has any security implications but out of abundance of caution
> +	 * we limit it to privileged users.
> +	 */
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
> +	vbr->out_hdr.sector = 0;
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
> @@ -853,6 +950,7 @@ static const struct block_device_operations virtblk_fops = {
>  	.owner  	= THIS_MODULE,
>  	.getgeo		= virtblk_getgeo,
>  	.free_disk	= virtblk_free_disk,
> +	.ioctl		= virtblk_ioctl,
>  	.report_zones	= virtblk_report_zones,
>  };
>  
> @@ -1582,7 +1680,7 @@ static unsigned int features_legacy[] = {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> -	VIRTIO_BLK_F_SECURE_ERASE,
> +	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_LIFETIME,
>  }
>  ;
>  static unsigned int features[] = {
> @@ -1590,7 +1688,7 @@ static unsigned int features[] = {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> -	VIRTIO_BLK_F_SECURE_ERASE,
> +	VIRTIO_BLK_F_SECURE_ERASE, VIRTIO_BLK_F_LIFETIME,
>  #ifdef CONFIG_BLK_DEV_ZONED
>  	VIRTIO_BLK_F_ZONED,
>  #endif /* CONFIG_BLK_DEV_ZONED */
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index 3744e4da1..f4d5ee7c6 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -40,6 +40,7 @@
>  #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
>  #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
>  #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
> +#define VIRTIO_BLK_F_LIFETIME	15	/* Storage lifetime information is supported */
>  #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
>  #define VIRTIO_BLK_F_ZONED		17	/* Zoned block device */
>  
> @@ -176,6 +177,9 @@ struct virtio_blk_config {
>  /* Get device ID command */
>  #define VIRTIO_BLK_T_GET_ID    8
>  
> +/* Get lifetime information command */
> +#define VIRTIO_BLK_T_GET_LIFETIME 10
> +
>  /* Discard command */
>  #define VIRTIO_BLK_T_DISCARD	11
>  
> @@ -304,6 +308,30 @@ struct virtio_blk_discard_write_zeroes {
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
> index 000000000..f87afb6be
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

