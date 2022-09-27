Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AC3C6FA82
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 21:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiI0ViD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 17:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiI0ViC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 17:38:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85E8107DC8
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664314679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D5ZIksmGurvYC/iOAqtPVWbeUblsOdJ5xwGtu/IzOWI=;
        b=YBIfZafXPewAOPCwMwlF2w2DlDD21qltDYr2cFEMVrVtmC51dGFTeKdAXiJtPaqx9yq9Cp
        1HrshBShVhgvqNhy5iLFSavwN+Xt14nTLUwA6xhnRIjgMImWL1QeLhi/5X4kCLAk1uzMhj
        MZTuB/yV+8ihcPCiACSikzeV3XfNNVk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-53-egD9NGNUOECQNh_K_Obmvg-1; Tue, 27 Sep 2022 17:37:58 -0400
X-MC-Unique: egD9NGNUOECQNh_K_Obmvg-1
Received: by mail-wr1-f69.google.com with SMTP id j16-20020adfa550000000b0022cbdfcea2dso938276wrb.19
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 14:37:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=D5ZIksmGurvYC/iOAqtPVWbeUblsOdJ5xwGtu/IzOWI=;
        b=IFEItgIe9LvLX7h37MKb4wIBXQbiGFWZZNwTauyIayImAu8DpA1nYAPFH7a0Vv9oDc
         pmiz13zrE9S5CKVrq6krbYDravB2I1QGfBtJcF9bjJ4QHKYWsOeNHF21jXQXUVMamwLD
         Yfbrqbpj1YhAk00Wj2aGZ2Y0JnhKT7Pz8hyzBlRsT5Fep5nigPn4BZVONp6DMWQyN7w+
         IC9m+CojD7+lsEdphl+TMle9WBgmYIoVVKJ7KIS415YdhBjDHNsxC3RyNsgQ/5Kr6Gfa
         r3ozh21i/N84a8ARBOyswTvT8FbEdAM8WRAUxAaGiRYBeqE/UDdpa25r7tOP+iBhVXje
         KwVw==
X-Gm-Message-State: ACrzQf3o/X1ycyOd0/C3qTG/RgzD01iBMgaCIAnH0t6pF/DbUyQAy7eR
        FNNXpXcHmJl/c6U9PBJ0iSiwghrHtI/9YsY2+/wf2+ZSur/y0hY1ouiL/4C9WmcdcMA+LkSwAJS
        V2R/biwLa6TBJXkPJh7mAYMc=
X-Received: by 2002:a05:6000:2ce:b0:22a:f2dc:1531 with SMTP id o14-20020a05600002ce00b0022af2dc1531mr18614999wry.370.1664314677240;
        Tue, 27 Sep 2022 14:37:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM75GZrpOIjx3Y8daQH5gD30RRG235Fd/YqvwBOi/XGXrLC5i+WLs9D44hdtjOnyVVgkm68Sog==
X-Received: by 2002:a05:6000:2ce:b0:22a:f2dc:1531 with SMTP id o14-20020a05600002ce00b0022af2dc1531mr18614976wry.370.1664314677008;
        Tue, 27 Sep 2022 14:37:57 -0700 (PDT)
Received: from redhat.com ([2.55.47.213])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4203000000b0022acb7195aesm2708029wrq.33.2022.09.27.14.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 14:37:56 -0700 (PDT)
Date:   Tue, 27 Sep 2022 17:37:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Jens Axboe <axboe@kernel.dk>, Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        Evan Green <evgreen@google.com>,
        Gwendal Grignou <gwendal@google.com>
Subject: Re: [PATCH RFC 3/8] virtio_blk: Add support for provision requests
Message-ID: <20220927173658-mutt-send-email-mst@kernel.org>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-4-sarthakkukreti@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915164826.1396245-4-sarthakkukreti@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 15, 2022 at 09:48:21AM -0700, Sarthak Kukreti wrote:
> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> 
> Adds support for provision requests. Provision requests act like
> the inverse of discards.
> 
> Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
> ---
>  drivers/block/virtio_blk.c      | 48 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_blk.h |  9 +++++++
>  2 files changed, 57 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 30255fcaf181..eacc2bffe1d1 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -178,6 +178,39 @@ static int virtblk_setup_discard_write_zeroes(struct request *req, bool unmap)
>  	return 0;
>  }
>  
> +static int virtblk_setup_provision(struct request *req)
> +{
> +	unsigned short segments = blk_rq_nr_discard_segments(req);
> +	unsigned short n = 0;
> +
> +	struct virtio_blk_discard_write_zeroes *range;
> +	struct bio *bio;
> +	u32 flags = 0;
> +
> +	range = kmalloc_array(segments, sizeof(*range), GFP_ATOMIC);
> +	if (!range)
> +		return -ENOMEM;
> +
> +	__rq_for_each_bio(bio, req) {
> +		u64 sector = bio->bi_iter.bi_sector;
> +		u32 num_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> +
> +		range[n].flags = cpu_to_le32(flags);
> +		range[n].num_sectors = cpu_to_le32(num_sectors);
> +		range[n].sector = cpu_to_le64(sector);
> +		n++;
> +	}
> +
> +	WARN_ON_ONCE(n != segments);
> +
> +	req->special_vec.bv_page = virt_to_page(range);
> +	req->special_vec.bv_offset = offset_in_page(range);
> +	req->special_vec.bv_len = sizeof(*range) * segments;
> +	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
> +
> +	return 0;
> +}
> +
>  static void virtblk_unmap_data(struct request *req, struct virtblk_req *vbr)
>  {
>  	if (blk_rq_nr_phys_segments(req))
> @@ -243,6 +276,9 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  	case REQ_OP_DRV_IN:
>  		type = VIRTIO_BLK_T_GET_ID;
>  		break;
> +	case REQ_OP_PROVISION:
> +		type = VIRTIO_BLK_T_PROVISION;
> +		break;
>  	default:
>  		WARN_ON_ONCE(1);
>  		return BLK_STS_IOERR;
> @@ -256,6 +292,11 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  			return BLK_STS_RESOURCE;
>  	}
>  
> +	if (type == VIRTIO_BLK_T_PROVISION) {
> +		if (virtblk_setup_provision(req))
> +			return BLK_STS_RESOURCE;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1075,6 +1116,12 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		blk_queue_max_write_zeroes_sectors(q, v ? v : UINT_MAX);
>  	}
>  
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_PROVISION)) {
> +		virtio_cread(vdev, struct virtio_blk_config,
> +			     max_provision_sectors, &v);
> +		q->limits.max_provision_sectors = v ? v : UINT_MAX;
> +	}
> +
>  	virtblk_update_capacity(vblk, false);
>  	virtio_device_ready(vdev);
>  
> @@ -1177,6 +1224,7 @@ static unsigned int features[] = {
>  	VIRTIO_BLK_F_RO, VIRTIO_BLK_F_BLK_SIZE,
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
> +	VIRTIO_BLK_F_PROVISION,
>  };
>  
>  static struct virtio_driver virtio_blk = {
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index d888f013d9ff..184f8cf6d185 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -40,6 +40,7 @@
>  #define VIRTIO_BLK_F_MQ		12	/* support more than one vq */
>  #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
>  #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
> +#define VIRTIO_BLK_F_PROVISION	15	/* provision is supported */
>  
>  /* Legacy feature bits */
>  #ifndef VIRTIO_BLK_NO_LEGACY
> @@ -120,6 +121,11 @@ struct virtio_blk_config {
>  	 */
>  	__u8 write_zeroes_may_unmap;
>  
> +	/*
> +	 * The maximum number of sectors in a provision request.
> +	 */
> +	__virtio32 max_provision_sectors;
> +
>  	__u8 unused1[3];
>  } __attribute__((packed));
>  
> @@ -155,6 +161,9 @@ struct virtio_blk_config {
>  /* Write zeroes command */
>  #define VIRTIO_BLK_T_WRITE_ZEROES	13
>  
> +/* Provision command */
> +#define VIRTIO_BLK_T_PROVISION	14
> +
>  #ifndef VIRTIO_BLK_NO_LEGACY
>  /* Barrier before this op. */
>  #define VIRTIO_BLK_T_BARRIER	0x80000000


Feature bit has to be reserved in the virtio spec.
Pls do this through the virtio TC mailing list.

> -- 
> 2.31.0

