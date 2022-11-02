Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0557EC4332F
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 20:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiKBU0F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 16:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKBU0F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 16:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA652BEF
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 13:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667420703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iPegLr4PnIokyKc5uiyahD2WzehkyWVLUeg7l62VKXM=;
        b=B0XZ8VZXhVwy9L/TVM+STynlcKsFK8nPjrPY6LchhPCeWyaSTq2MKuqljWx4IzV3IxAwED
        z9C6rDOJrF0YeZCHC22F02ig/pL5a3xNgt5lchpwCMrjuFiS5gYNWBB7TeGB14ko3tnJy0
        h/N8FJ8tDsZQESo1gCYPXSO+Pv+HdUg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-veNu0fTMMeyv94cBot5-xA-1; Wed, 02 Nov 2022 16:24:58 -0400
X-MC-Unique: veNu0fTMMeyv94cBot5-xA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DD152A5955A;
        Wed,  2 Nov 2022 20:24:57 +0000 (UTC)
Received: from localhost (unknown [10.39.192.88])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B58E940C6E14;
        Wed,  2 Nov 2022 20:24:56 +0000 (UTC)
Date:   Wed, 2 Nov 2022 16:24:54 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>,
        virtio-dev@lists.oasis-open.org
Subject: Re: [virtio-dev] [PATCH v4 2/2] virtio-blk: add support for zoned
 block devices
Message-ID: <Y2LSFhg58PTHrmLo@fedora>
References: <20221030043545.974223-1-dmitry.fomichev@wdc.com>
 <20221030043545.974223-3-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+hnGzeQbkMcGAqTs"
Content-Disposition: inline
In-Reply-To: <20221030043545.974223-3-dmitry.fomichev@wdc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--+hnGzeQbkMcGAqTs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 30, 2022 at 12:35:45AM -0400, Dmitry Fomichev wrote:
> This patch adds support for Zoned Block Devices (ZBDs) to the kernel
> virtio-blk driver.
>=20
> The patch accompanies the virtio-blk ZBD support draft that is now
> being proposed for standardization. The latest version of the draft is
> linked at
>=20
> https://github.com/oasis-tcs/virtio-spec/issues/143 .
>=20
> The QEMU zoned device code that implements these protocol extensions
> has been developed by Sam Li and it is currently in review at the QEMU
> mailing list.
>=20
> A number of virtblk request structure changes has been introduced to
> accommodate the functionality that is specific to zoned block devices
> and, most importantly, make room for carrying the Zoned Append sector
> value from the device back to the driver along with the request status.
>=20
> The zone-specific code in the patch is heavily influenced by NVMe ZNS
> code in drivers/nvme/host/zns.c, but it is simpler because the proposed
> virtio ZBD draft only covers the zoned device features that are
> relevant to the zoned functionality provided by Linux block layer.
>=20
> Co-developed-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  drivers/block/virtio_blk.c      | 438 ++++++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_blk.h | 105 ++++++++
>  2 files changed, 524 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 3efe3da5f8c2..03b5302fac6e 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -15,6 +15,7 @@
>  #include <linux/blk-mq.h>
>  #include <linux/blk-mq-virtio.h>
>  #include <linux/numa.h>
> +#include <linux/vmalloc.h>
>  #include <uapi/linux/virtio_ring.h>
> =20
>  #define PART_BITS 4
> @@ -80,22 +81,51 @@ struct virtio_blk {
>  	int num_vqs;
>  	int io_queues[HCTX_MAX_TYPES];
>  	struct virtio_blk_vq *vqs;
> +
> +	/* For zoned device */
> +	unsigned int zone_sectors;
>  };
> =20
>  struct virtblk_req {
> +	/* Out header */
>  	struct virtio_blk_outhdr out_hdr;
> -	u8 status;
> +
> +	/* In header */
> +	union {
> +		struct {
> +			u8 status;
> +		} common;
> +
> +		/*
> +		 * The zone append command has an extended in header.
> +		 * The status field in zone_append_in_hdr must always
> +		 * be the last byte.
> +		 */
> +		struct {
> +			__virtio64 sector;
> +			u8 status;
> +		} zone_append;
> +	} in_hdr;
> +
> +	size_t in_hdr_len;
> +
>  	struct sg_table sg_table;
>  	struct scatterlist sg[];
>  };
> =20
> -static inline blk_status_t virtblk_result(struct virtblk_req *vbr)
> +static inline blk_status_t virtblk_result(u8 status)
>  {
> -	switch (vbr->status) {
> +	switch (status) {
>  	case VIRTIO_BLK_S_OK:
>  		return BLK_STS_OK;
>  	case VIRTIO_BLK_S_UNSUPP:
>  		return BLK_STS_NOTSUPP;
> +	case VIRTIO_BLK_S_ZONE_OPEN_RESOURCE:
> +		return BLK_STS_ZONE_OPEN_RESOURCE;
> +	case VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE:
> +		return BLK_STS_ZONE_ACTIVE_RESOURCE;
> +	case VIRTIO_BLK_S_IOERR:
> +	case VIRTIO_BLK_S_ZONE_UNALIGNED_WP:
>  	default:
>  		return BLK_STS_IOERR;
>  	}
> @@ -111,11 +141,11 @@ static inline struct virtio_blk_vq *get_virtio_blk_=
vq(struct blk_mq_hw_ctx *hctx
> =20
>  static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
>  {
> -	struct scatterlist hdr, status, *sgs[3];
> +	struct scatterlist out_hdr, in_hdr, *sgs[3];
>  	unsigned int num_out =3D 0, num_in =3D 0;
> =20
> -	sg_init_one(&hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
> -	sgs[num_out++] =3D &hdr;
> +	sg_init_one(&out_hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
> +	sgs[num_out++] =3D &out_hdr;
> =20
>  	if (vbr->sg_table.nents) {
>  		if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
> @@ -124,8 +154,8 @@ static int virtblk_add_req(struct virtqueue *vq, stru=
ct virtblk_req *vbr)
>  			sgs[num_out + num_in++] =3D vbr->sg_table.sgl;
>  	}
> =20
> -	sg_init_one(&status, &vbr->status, sizeof(vbr->status));
> -	sgs[num_out + num_in++] =3D &status;
> +	sg_init_one(&in_hdr, &vbr->in_hdr.common.status, vbr->in_hdr_len);
> +	sgs[num_out + num_in++] =3D &in_hdr;
> =20
>  	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
>  }
> @@ -214,21 +244,22 @@ static blk_status_t virtblk_setup_cmd(struct virtio=
_device *vdev,
>  				      struct request *req,
>  				      struct virtblk_req *vbr)
>  {
> +	size_t in_hdr_len =3D sizeof(vbr->in_hdr.common.status);
>  	bool unmap =3D false;
>  	u32 type;
> +	u64 sector =3D 0;
> =20
> -	vbr->out_hdr.sector =3D 0;
> +	/* Set fields for all request types */
> +	vbr->out_hdr.ioprio =3D cpu_to_virtio32(vdev, req_get_ioprio(req));
> =20
>  	switch (req_op(req)) {
>  	case REQ_OP_READ:
>  		type =3D VIRTIO_BLK_T_IN;
> -		vbr->out_hdr.sector =3D cpu_to_virtio64(vdev,
> -						      blk_rq_pos(req));
> +		sector =3D blk_rq_pos(req);
>  		break;
>  	case REQ_OP_WRITE:
>  		type =3D VIRTIO_BLK_T_OUT;
> -		vbr->out_hdr.sector =3D cpu_to_virtio64(vdev,
> -						      blk_rq_pos(req));
> +		sector =3D blk_rq_pos(req);
>  		break;
>  	case REQ_OP_FLUSH:
>  		type =3D VIRTIO_BLK_T_FLUSH;
> @@ -243,16 +274,42 @@ static blk_status_t virtblk_setup_cmd(struct virtio=
_device *vdev,
>  	case REQ_OP_SECURE_ERASE:
>  		type =3D VIRTIO_BLK_T_SECURE_ERASE;
>  		break;
> -	case REQ_OP_DRV_IN:
> -		type =3D VIRTIO_BLK_T_GET_ID;
> +	case REQ_OP_ZONE_OPEN:
> +		type =3D VIRTIO_BLK_T_ZONE_OPEN;
> +		sector =3D blk_rq_pos(req);
>  		break;
> +	case REQ_OP_ZONE_CLOSE:
> +		type =3D VIRTIO_BLK_T_ZONE_CLOSE;
> +		sector =3D blk_rq_pos(req);
> +		break;
> +	case REQ_OP_ZONE_FINISH:
> +		type =3D VIRTIO_BLK_T_ZONE_FINISH;
> +		sector =3D blk_rq_pos(req);
> +		break;
> +	case REQ_OP_ZONE_APPEND:
> +		type =3D VIRTIO_BLK_T_ZONE_APPEND;
> +		sector =3D blk_rq_pos(req);
> +		in_hdr_len =3D sizeof(vbr->in_hdr.zone_append);
> +		break;
> +	case REQ_OP_ZONE_RESET:
> +		type =3D VIRTIO_BLK_T_ZONE_RESET;
> +		sector =3D blk_rq_pos(req);
> +		break;
> +	case REQ_OP_ZONE_RESET_ALL:
> +		type =3D VIRTIO_BLK_T_ZONE_RESET_ALL;
> +		break;
> +	case REQ_OP_DRV_IN:
> +		/* Out header already filled in, nothing to do */
> +		return 0;
>  	default:
>  		WARN_ON_ONCE(1);
>  		return BLK_STS_IOERR;
>  	}
> =20
> +	/* Set fields for non-REQ_OP_DRV_IN request types */
> +	vbr->in_hdr_len =3D in_hdr_len;
>  	vbr->out_hdr.type =3D cpu_to_virtio32(vdev, type);
> -	vbr->out_hdr.ioprio =3D cpu_to_virtio32(vdev, req_get_ioprio(req));
> +	vbr->out_hdr.sector =3D cpu_to_virtio64(vdev, sector);
> =20
>  	if (type =3D=3D VIRTIO_BLK_T_DISCARD || type =3D=3D VIRTIO_BLK_T_WRITE_=
ZEROES ||
>  	    type =3D=3D VIRTIO_BLK_T_SECURE_ERASE) {
> @@ -263,13 +320,30 @@ static blk_status_t virtblk_setup_cmd(struct virtio=
_device *vdev,
>  	return 0;
>  }
> =20
> +/*
> + * The status byte is always the last byte of the virtblk request
> + * in-header. This helper fetches its value for all in-header formats
> + * that are currently defined.
> + */
> +static inline u8 virtblk_vbr_status(struct virtblk_req *vbr)
> +{
> +	return *((u8 *)&vbr->in_hdr + vbr->in_hdr_len - 1);
> +}
> +
>  static inline void virtblk_request_done(struct request *req)
>  {
>  	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(req);
> +	blk_status_t status =3D virtblk_result(virtblk_vbr_status(vbr));
> +	struct virtio_blk *vblk =3D req->mq_hctx->queue->queuedata;
> =20
>  	virtblk_unmap_data(req, vbr);
>  	virtblk_cleanup_cmd(req);
> -	blk_mq_end_request(req, virtblk_result(vbr));
> +
> +	if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
> +		req->__sector =3D virtio64_to_cpu(vblk->vdev,
> +						vbr->in_hdr.zone_append.sector);
> +
> +	blk_mq_end_request(req, status);
>  }
> =20
>  static void virtblk_done(struct virtqueue *vq)
> @@ -455,6 +529,315 @@ static void virtio_queue_rqs(struct request **rqlis=
t)
>  	*rqlist =3D requeue_list;
>  }
> =20
> +#ifdef CONFIG_BLK_DEV_ZONED
> +static void *virtblk_alloc_report_buffer(struct virtio_blk *vblk,
> +					  unsigned int nr_zones,
> +					  unsigned int zone_sectors,
> +					  size_t *buflen)
> +{
> +	struct request_queue *q =3D vblk->disk->queue;
> +	size_t bufsize;
> +	void *buf;
> +
> +	nr_zones =3D min_t(unsigned int, nr_zones,
> +			 get_capacity(vblk->disk) >> ilog2(zone_sectors));
> +
> +	bufsize =3D sizeof(struct virtio_blk_zone_report) +
> +		nr_zones * sizeof(struct virtio_blk_zone_descriptor);
> +	bufsize =3D min_t(size_t, bufsize,
> +			queue_max_hw_sectors(q) << SECTOR_SHIFT);
> +	bufsize =3D min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);
> +
> +	while (bufsize >=3D sizeof(struct virtio_blk_zone_report)) {
> +		buf =3D __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
> +		if (buf) {
> +			*buflen =3D bufsize;
> +			return buf;
> +		}
> +		bufsize >>=3D 1;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int virtblk_submit_zone_report(struct virtio_blk *vblk,
> +				       char *report_buf, size_t report_len,
> +				       sector_t sector)
> +{
> +	struct request_queue *q =3D vblk->disk->queue;
> +	struct request *req;
> +	struct virtblk_req *vbr;
> +	int err;
> +
> +	req =3D blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
> +	if (IS_ERR(req))
> +		return PTR_ERR(req);
> +
> +	vbr =3D blk_mq_rq_to_pdu(req);
> +	vbr->in_hdr_len =3D sizeof(vbr->in_hdr.common.status);
> +	vbr->out_hdr.type =3D cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_ZONE_REP=
ORT);
> +	vbr->out_hdr.sector =3D cpu_to_virtio64(vblk->vdev, sector);
> +
> +	err =3D blk_rq_map_kern(q, req, report_buf, report_len, GFP_KERNEL);
> +	if (err)
> +		goto out;
> +
> +	blk_execute_rq(req, false);
> +	err =3D blk_status_to_errno(virtblk_result(vbr->in_hdr.common.status));
> +out:
> +	blk_mq_free_request(req);
> +	return err;
> +}
> +
> +static int virtblk_parse_zone(struct virtio_blk *vblk,
> +			       struct virtio_blk_zone_descriptor *entry,
> +			       unsigned int idx, unsigned int zone_sectors,
> +			       report_zones_cb cb, void *data)
> +{
> +	struct blk_zone zone =3D { };
> +
> +	zone.start =3D virtio64_to_cpu(vblk->vdev, entry->z_start);
> +	zone.capacity =3D virtio64_to_cpu(vblk->vdev, entry->z_cap);
> +
> +	switch (entry->z_type) {
> +	case VIRTIO_BLK_ZT_SWR:
> +		zone.type =3D BLK_ZONE_TYPE_SEQWRITE_REQ;
> +		break;
> +	case VIRTIO_BLK_ZT_SWP:
> +		zone.type =3D BLK_ZONE_TYPE_SEQWRITE_PREF;
> +		break;
> +	case VIRTIO_BLK_ZT_CONV:
> +		zone.type =3D BLK_ZONE_TYPE_CONVENTIONAL;
> +		break;
> +	default:
> +		dev_err(&vblk->vdev->dev, "zone %llu: invalid type %#x\n",
> +			zone.start, entry->z_type);
> +		return -EINVAL;
> +	}
> +
> +	switch (entry->z_state) {
> +	case VIRTIO_BLK_ZS_EMPTY:
> +		zone.cond =3D BLK_ZONE_COND_EMPTY;
> +		break;
> +	case VIRTIO_BLK_ZS_CLOSED:
> +		zone.cond =3D BLK_ZONE_COND_CLOSED;
> +		break;
> +	case VIRTIO_BLK_ZS_FULL:
> +		zone.cond =3D BLK_ZONE_COND_FULL;
> +		break;
> +	case VIRTIO_BLK_ZS_EOPEN:
> +		zone.cond =3D BLK_ZONE_COND_EXP_OPEN;
> +		break;
> +	case VIRTIO_BLK_ZS_IOPEN:
> +		zone.cond =3D BLK_ZONE_COND_IMP_OPEN;
> +		break;
> +	case VIRTIO_BLK_ZS_NOT_WP:
> +		zone.cond =3D BLK_ZONE_COND_NOT_WP;
> +		break;
> +	case VIRTIO_BLK_ZS_RDONLY:
> +		zone.cond =3D BLK_ZONE_COND_READONLY;
> +		break;
> +	case VIRTIO_BLK_ZS_OFFLINE:
> +		zone.cond =3D BLK_ZONE_COND_OFFLINE;
> +		break;
> +	default:
> +		dev_err(&vblk->vdev->dev, "zone %llu: invalid condition %#x\n",
> +			zone.start, entry->z_state);
> +		return -EINVAL;
> +	}
> +
> +	zone.len =3D zone_sectors;
> +	if (zone.cond =3D=3D BLK_ZONE_COND_FULL)
> +		zone.wp =3D zone.start + zone.len;

Is this correct on devices where the last zone !=3D zone_sectors? Maybe it
doesn't matter?

> +	else
> +		zone.wp =3D virtio64_to_cpu(vblk->vdev, entry->z_wp);

Is a sanity check needed here? The device is not trusted and must not be
able to trigger out-of-bounds accesses based on zone.wp or similar.

> +
> +	return cb(&zone, idx, data);
> +}
> +
> +static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
> +				 unsigned int nr_zones, report_zones_cb cb,
> +				 void *data)
> +{
> +	struct virtio_blk *vblk =3D disk->private_data;
> +	struct virtio_blk_zone_report *report;
> +	unsigned long long nz, i;
> +	size_t buflen;
> +	unsigned int zone_sectors =3D vblk->zone_sectors;
> +	int ret, zone_idx =3D 0;
> +
> +	if (WARN_ON_ONCE(!vblk->zone_sectors))
> +		return -EOPNOTSUPP;
> +
> +	report =3D virtblk_alloc_report_buffer(vblk, nr_zones,
> +					     zone_sectors, &buflen);
> +	if (!report)
> +		return -ENOMEM;
> +
> +	while (zone_idx < nr_zones && sector < get_capacity(vblk->disk)) {

Why is zone_idx a signed int while nr_zones is an unsigned int?

> +		memset(report, 0, buflen);
> +
> +		ret =3D virtblk_submit_zone_report(vblk, (char *)report,
> +						 buflen, sector);
> +		if (ret) {
> +			if (ret > 0)
> +				ret =3D -EIO;
> +			goto out_free;
> +		}
> +		nz =3D min(virtio64_to_cpu(vblk->vdev, report->nr_zones),
> +			 (u64)nr_zones);
> +		if (!nz)
> +			break;
> +
> +		for (i =3D 0; i < nz && zone_idx < nr_zones; i++) {
> +			ret =3D virtblk_parse_zone(vblk, &report->zones[i],
> +						 zone_idx, zone_sectors, cb, data);
> +			if (ret)
> +				goto out_free;
> +
> +			sector =3D virtio64_to_cpu(vblk->vdev,
> +						 report->zones[i].z_start) +
> +				 zone_sectors;
> +			zone_idx++;
> +		}
> +	}
> +
> +	if (zone_idx > 0)
> +		ret =3D zone_idx;
> +	else
> +		ret =3D -EINVAL;
> +out_free:
> +	kvfree(report);
> +	return ret;
> +}
> +
> +static void virtblk_revalidate_zones(struct virtio_blk *vblk)
> +{
> +	u8 model;
> +
> +	if (!vblk->zone_sectors)
> +		return;
> +
> +	virtio_cread(vblk->vdev, struct virtio_blk_config,
> +		     zoned.model, &model);

model is unused? If used, then it needs to be validated like in
virtblk_probe_zoned_device().

> +	if (!blk_revalidate_disk_zones(vblk->disk, NULL))
> +		set_capacity_and_notify(vblk->disk, 0);
> +}
> +
> +static int virtblk_probe_zoned_device(struct virtio_device *vdev,
> +				       struct virtio_blk *vblk,
> +				       struct request_queue *q)
> +{
> +	u32 v, wg;
> +	u8 model;
> +	int ret;
> +
> +	virtio_cread(vdev, struct virtio_blk_config,
> +		     zoned.model, &model);
> +
> +	switch (model) {
> +	case VIRTIO_BLK_Z_NONE:
> +		return 0;
> +	case VIRTIO_BLK_Z_HM:
> +		break;
> +	case VIRTIO_BLK_Z_HA:
> +		/*
> +		 * Present the host-aware device as a regular drive.
> +		 * TODO It is possible to add an option to make it appear
> +		 * in the system as a zoned drive.
> +		 */
> +		return 0;
> +	default:
> +		dev_err(&vdev->dev, "unsupported zone model %d\n", model);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(&vdev->dev, "probing host-managed zoned device\n");
> +
> +	disk_set_zoned(vblk->disk, BLK_ZONED_HM);
> +	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
> +
> +	virtio_cread(vdev, struct virtio_blk_config,
> +		     zoned.max_open_zones, &v);
> +	disk_set_max_open_zones(vblk->disk, v);
> +
> +	dev_dbg(&vdev->dev, "max open zones =3D %u\n", v);
> +
> +	virtio_cread(vdev, struct virtio_blk_config,
> +		     zoned.max_active_zones, &v);
> +	disk_set_max_active_zones(vblk->disk, v);
> +	dev_dbg(&vdev->dev, "max active zones =3D %u\n", v);
> +
> +	virtio_cread(vdev, struct virtio_blk_config,
> +		     zoned.write_granularity, &wg);
> +	if (!wg) {
> +		dev_warn(&vdev->dev, "zero write granularity reported\n");
> +		return -ENODEV;
> +	}
> +	blk_queue_physical_block_size(q, wg);
> +	blk_queue_io_min(q, wg);
> +
> +	dev_dbg(&vdev->dev, "write granularity =3D %u\n", wg);
> +
> +	/*
> +	 * virtio ZBD specification doesn't require zones to be a power of
> +	 * two sectors in size, but the code in this driver expects that.
> +	 */
> +	virtio_cread(vdev, struct virtio_blk_config, zoned.zone_sectors,
> +		     &vblk->zone_sectors);
> +	if (vblk->zone_sectors =3D=3D 0 || !is_power_of_2(vblk->zone_sectors)) {
> +		dev_err(&vdev->dev,
> +			"zoned device with non power of two zone size %u\n",
> +			vblk->zone_sectors);
> +		return -ENODEV;
> +	}
> +	dev_dbg(&vdev->dev, "zone sectors =3D %u\n", vblk->zone_sectors);
> +
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
> +		dev_warn(&vblk->vdev->dev,
> +			 "ignoring negotiated F_DISCARD for zoned device\n");
> +		blk_queue_max_discard_sectors(q, 0);
> +	}
> +
> +	ret =3D blk_revalidate_disk_zones(vblk->disk, NULL);
> +	if (!ret) {
> +		virtio_cread(vdev, struct virtio_blk_config,
> +			     zoned.max_append_sectors, &v);
> +		if (!v) {
> +			dev_warn(&vdev->dev, "zero max_append_sectors reported\n");
> +			return -ENODEV;
> +		}
> +		if ((v << SECTOR_SHIFT) < wg) {
> +			dev_err(&vdev->dev,
> +				"write granularity %u exceeds max_append_sectors %u limit\n",
> +				wg, v);
> +			return -ENODEV;
> +		}
> +
> +		blk_queue_max_zone_append_sectors(q, v);
> +		dev_dbg(&vdev->dev, "max append sectors =3D %u\n", v);
> +	}
> +
> +	return ret;
> +}
> +
> +#else
> +
> +/*
> + * Zoned block device support is not configured in this kernel.
> + * We only need to define a few symbols to avoid compilation errors.
> + */
> +#define virtblk_report_zones       NULL
> +static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
> +{
> +}
> +static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
> +			struct virtio_blk *vblk, struct request_queue *q)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_BLK_DEV_ZONED */
> +
>  /* return id (s/n) string for *disk to *id_str
>   */
>  static int virtblk_get_id(struct gendisk *disk, char *id_str)
> @@ -462,18 +845,24 @@ static int virtblk_get_id(struct gendisk *disk, cha=
r *id_str)
>  	struct virtio_blk *vblk =3D disk->private_data;
>  	struct request_queue *q =3D vblk->disk->queue;
>  	struct request *req;
> +	struct virtblk_req *vbr;
>  	int err;
> =20
>  	req =3D blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
>  	if (IS_ERR(req))
>  		return PTR_ERR(req);
> =20
> +	vbr =3D blk_mq_rq_to_pdu(req);
> +	vbr->in_hdr_len =3D sizeof(vbr->in_hdr.common.status);
> +	vbr->out_hdr.type =3D cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
> +	vbr->out_hdr.sector =3D 0;
> +
>  	err =3D blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL=
);
>  	if (err)
>  		goto out;
> =20
>  	blk_execute_rq(req, false);
> -	err =3D blk_status_to_errno(virtblk_result(blk_mq_rq_to_pdu(req)));
> +	err =3D blk_status_to_errno(virtblk_result(vbr->in_hdr.common.status));
>  out:
>  	blk_mq_free_request(req);
>  	return err;
> @@ -524,6 +913,7 @@ static const struct block_device_operations virtblk_f=
ops =3D {
>  	.owner  	=3D THIS_MODULE,
>  	.getgeo		=3D virtblk_getgeo,
>  	.free_disk	=3D virtblk_free_disk,
> +	.report_zones	=3D virtblk_report_zones,

Does virtblk_report_zones() need:

  mutex_lock(&vblk->vdev_mutex);

  if (!vblk->vdev) {
      ret =3D -ENXIO;
      goto out;
  }

  ...

  mutex_unlock(&vblk->vdev_mutex);
  return ret;

?

This is necessary when vblk->vdev is access by code that is reachable
after virtblk_remove() has been called (e.g. PCI hot unplug). In this
case the block device still exists and userspace processes may have file
descriptors open, but the underlying virtio-blk device is gone.

I think this may be necessary since ioctl(BLKREPORTZONE) can still be
called after virtblk_remove()?

See the vdev_mutex field doc comment for more information.

Stefan

--+hnGzeQbkMcGAqTs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmNi0hYACgkQnKSrs4Gr
c8iMoQf+P7OTmnHKZbvBLN/bJtcTMJNwa4POdN8vRhHkCw9cQ8kJRJK9ZOCO1mrW
lMX+zepvBKc+UoY5oWnjeaDl6AXfVmyXsm0akZcvih4q7Y8u4PIAevumUBVADcKl
Jm+v5Dt5HTszCeS/xn/J/SHlmLhXTeYloVEvprKn71fdptM75gFWMSPxeLLQOhGI
3Jnl69Atw4gjRYcsghwupkPYNT0hMXQ6V75lGJbXCxKQZ88Ud2K4HZZeAeqsXNGC
TK8clSfQJt75XBnJrQwVHrOBsoh/bNY6JUCVE7a4rujqSsJukqrZNDnMtgVr5eFd
9pXPb6fUEqKsr+Qz2mFIHfJxxA19jw==
=47it
-----END PGP SIGNATURE-----

--+hnGzeQbkMcGAqTs--

