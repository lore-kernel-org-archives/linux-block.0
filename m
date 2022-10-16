Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E09C4332F
	for <linux-block@archiver.kernel.org>; Sun, 16 Oct 2022 22:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJPWXt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Oct 2022 18:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiJPWXs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Oct 2022 18:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107B8371BC
        for <linux-block@vger.kernel.org>; Sun, 16 Oct 2022 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665959026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iysMUd3n0erGjyM9FGGhaNjzbUgVd0FPkKkns7ekEXQ=;
        b=JDuTdFZ3YkA5LY5svSxJLxw4LB6bXJLzxm7lQkpwy+Sq0hONqwnOjXNS3x9E1BoYqV6nQc
        DG5wf9kTyUrNCeC9l1Z1wNGziGWQN8n4vmPHSbzbHsgTxR01+CHprbUfU2hBU+NTYfXaIQ
        hnKyiISfaxzAj06+tjJjaY2evFDv5pY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-7co83syqNmKF89u4xF3HCQ-1; Sun, 16 Oct 2022 18:23:40 -0400
X-MC-Unique: 7co83syqNmKF89u4xF3HCQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AF14185A792;
        Sun, 16 Oct 2022 22:23:33 +0000 (UTC)
Received: from localhost (unknown [10.39.192.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FA3B1111C8E;
        Sun, 16 Oct 2022 22:23:26 +0000 (UTC)
Date:   Sun, 16 Oct 2022 18:23:13 -0400
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>,
        virtio-dev@lists.oasis-open.org
Subject: Re: [virtio-dev] [PATCH v2 2/2] virtio-blk: add support for zoned
 block devices
Message-ID: <Y0yEURF2s6l0PPPs@fedora>
References: <20221016034127.330942-1-dmitry.fomichev@wdc.com>
 <20221016034127.330942-3-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iNtgf2Q1eTp+A/ob"
Content-Disposition: inline
In-Reply-To: <20221016034127.330942-3-dmitry.fomichev@wdc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--iNtgf2Q1eTp+A/ob
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 15, 2022 at 11:41:27PM -0400, Dmitry Fomichev wrote:
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
>  drivers/block/virtio_blk.c      | 377 ++++++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_blk.h | 105 +++++++++
>  2 files changed, 464 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 3efe3da5f8c2..c9ad590816f8 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -80,22 +80,51 @@ struct virtio_blk {
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
> +		u8 status;
> +
> +		/*
> +		 * The zone append command has an extended in header.
> +		 * The status field in zone_append_in_hdr must have
> +		 * the same offset in virtblk_req as the non-zoned
> +		 * status field above.
> +		 */
> +		struct {
> +			u8 status;
> +			u8 reserved[7];
> +			u64 append_sector;
> +		} zone_append_in_hdr;
> +	};

This layout is not finalized yet. In the last revision of the spec patch
I suggested making the status byte the last byte so that devices that
don't know about zone append can still complete the request with
status=3DVIRTIO_BLK_S_UNSUPP at the correct offset.

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
> @@ -111,11 +140,11 @@ static inline struct virtio_blk_vq *get_virtio_blk_=
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
> @@ -124,8 +153,8 @@ static int virtblk_add_req(struct virtqueue *vq, stru=
ct virtblk_req *vbr)
>  			sgs[num_out + num_in++] =3D vbr->sg_table.sgl;
>  	}
> =20
> -	sg_init_one(&status, &vbr->status, sizeof(vbr->status));
> -	sgs[num_out + num_in++] =3D &status;
> +	sg_init_one(&in_hdr, &vbr->status, vbr->in_hdr_len);
> +	sgs[num_out + num_in++] =3D &in_hdr;
> =20
>  	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
>  }
> @@ -214,21 +243,22 @@ static blk_status_t virtblk_setup_cmd(struct virtio=
_device *vdev,
>  				      struct request *req,
>  				      struct virtblk_req *vbr)
>  {
> +	size_t in_hdr_len =3D sizeof(vbr->status);
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
> @@ -243,16 +273,42 @@ static blk_status_t virtblk_setup_cmd(struct virtio=
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
> +		in_hdr_len =3D sizeof(vbr->zone_append_in_hdr);
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
> @@ -266,10 +322,15 @@ static blk_status_t virtblk_setup_cmd(struct virtio=
_device *vdev,
>  static inline void virtblk_request_done(struct request *req)
>  {
>  	struct virtblk_req *vbr =3D blk_mq_rq_to_pdu(req);
> +	int status =3D virtblk_result(vbr->status);
> =20
>  	virtblk_unmap_data(req, vbr);
>  	virtblk_cleanup_cmd(req);
> -	blk_mq_end_request(req, virtblk_result(vbr));
> +
> +	if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
> +		req->__sector =3D le64_to_cpu(vbr->zone_append_in_hdr.append_sector);

Not sure if it's correct to set __sector upon error, maybe if (... &&
status =3D=3D BLK_STS_OK)? A quick look at the nvme driver shows no check
was performed there either.

> +
> +	blk_mq_end_request(req, status);
>  }
> =20
>  static void virtblk_done(struct virtqueue *vq)
> @@ -455,6 +516,266 @@ static void virtio_queue_rqs(struct request **rqlis=
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
> +	vbr->in_hdr_len =3D sizeof(vbr->status);
> +	vbr->out_hdr.type =3D cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_ZONE_REP=
ORT);
> +	vbr->out_hdr.sector =3D cpu_to_virtio64(vblk->vdev, sector);
> +
> +	err =3D blk_rq_map_kern(q, req, report_buf, report_len, GFP_KERNEL);
> +	if (err)
> +		goto out;
> +
> +	blk_execute_rq(req, false);
> +	err =3D blk_status_to_errno(virtblk_result(vbr->status));
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
> +	if (entry->z_type !=3D VIRTIO_BLK_ZT_SWR &&
> +	    entry->z_type !=3D VIRTIO_BLK_ZT_SWP &&
> +	    entry->z_type !=3D VIRTIO_BLK_ZT_CONV) {
> +		dev_err(&vblk->vdev->dev, "invalid zone type %#x\n",
> +			entry->z_type);
> +		return -EINVAL;
> +	}
> +
> +	zone.type =3D entry->z_type;
> +	zone.cond =3D entry->z_state;
> +	zone.len =3D zone_sectors;
> +	zone.capacity =3D le64_to_cpu(entry->z_cap);
> +	zone.start =3D le64_to_cpu(entry->z_start);
> +	if (zone.cond =3D=3D BLK_ZONE_COND_FULL)
> +		zone.wp =3D zone.start + zone.len;
> +	else
> +		zone.wp =3D le64_to_cpu(entry->z_wp);
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
> +	unsigned int zone_sectors =3D vblk->zone_sectors;
> +	unsigned int nz, i;
> +	int ret, zone_idx =3D 0;
> +	size_t buflen;
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
> +		memset(report, 0, buflen);
> +
> +		ret =3D virtblk_submit_zone_report(vblk, (char *)report,
> +						 buflen, sector);
> +		if (ret) {
> +			if (ret > 0)
> +				ret =3D -EIO;
> +			goto out_free;
> +		}
> +		nz =3D min((unsigned int)le64_to_cpu(report->nr_zones), nr_zones);
> +		if (!nz)
> +			break;
> +
> +		for (i =3D 0; i < nz && zone_idx < nr_zones; i++) {
> +			ret =3D virtblk_parse_zone(vblk, &report->zones[i],
> +						 zone_idx, zone_sectors, cb, data);
> +			if (ret)
> +				goto out_free;
> +			sector =3D le64_to_cpu(report->zones[i].z_start) + zone_sectors;
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
> +	if (!blk_revalidate_disk_zones(vblk->disk, NULL))
> +		set_capacity_and_notify(vblk->disk, 0);
> +}
> +
> +static int virtblk_probe_zoned_device(struct virtio_device *vdev,
> +				       struct virtio_blk *vblk,
> +				       struct request_queue *q)
> +{
> +	u32 v;
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
> +	disk_set_max_open_zones(vblk->disk, le32_to_cpu(v));
> +
> +	dev_dbg(&vdev->dev, "max open zones =3D %u\n", le32_to_cpu(v));
> +
> +	virtio_cread(vdev, struct virtio_blk_config,
> +		     zoned.max_active_zones, &v);
> +	disk_set_max_active_zones(vblk->disk, le32_to_cpu(v));
> +	dev_dbg(&vdev->dev, "max active zones =3D %u\n", le32_to_cpu(v));
> +
> +	virtio_cread(vdev, struct virtio_blk_config,
> +		     zoned.write_granularity, &v);
> +	if (!v) {
> +		dev_warn(&vdev->dev, "zero write granularity reported\n");
> +		return -ENODEV;
> +	}
> +	blk_queue_physical_block_size(q, le32_to_cpu(v));
> +	blk_queue_io_min(q, le32_to_cpu(v));
> +
> +	dev_dbg(&vdev->dev, "write granularity =3D %u\n", le32_to_cpu(v));
> +
> +	/*
> +	 * virtio ZBD specification doesn't require zones to be a power of
> +	 * two sectors in size, but the code in this driver expects that.
> +	 */
> +	virtio_cread(vdev, struct virtio_blk_config, zoned.zone_sectors, &v);
> +	vblk->zone_sectors =3D le32_to_cpu(v);
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
> +		blk_queue_max_zone_append_sectors(q, le32_to_cpu(v));
> +		dev_dbg(&vdev->dev, "max append sectors =3D %u\n", le32_to_cpu(v));
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
> @@ -462,18 +783,24 @@ static int virtblk_get_id(struct gendisk *disk, cha=
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
> +	vbr->in_hdr_len =3D sizeof(vbr->status);
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
> +	err =3D blk_status_to_errno(virtblk_result(vbr->status));
>  out:
>  	blk_mq_free_request(req);
>  	return err;
> @@ -524,6 +851,7 @@ static const struct block_device_operations virtblk_f=
ops =3D {
>  	.owner  	=3D THIS_MODULE,
>  	.getgeo		=3D virtblk_getgeo,
>  	.free_disk	=3D virtblk_free_disk,
> +	.report_zones	=3D virtblk_report_zones,
>  };
> =20
>  static int index_to_minor(int index)
> @@ -594,6 +922,7 @@ static void virtblk_config_changed_work(struct work_s=
truct *work)
>  	struct virtio_blk *vblk =3D
>  		container_of(work, struct virtio_blk, config_work);
> =20
> +	virtblk_revalidate_zones(vblk);
>  	virtblk_update_capacity(vblk, true);
>  }
> =20
> @@ -1150,6 +1479,15 @@ static int virtblk_probe(struct virtio_device *vde=
v)
>  	virtblk_update_capacity(vblk, false);
>  	virtio_device_ready(vdev);
> =20
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
> +		err =3D virtblk_probe_zoned_device(vdev, vblk, q);
> +		if (err)
> +			goto out_cleanup_disk;
> +	}
> +
> +	dev_info(&vdev->dev, "blk config size: %zu\n",
> +		sizeof(struct virtio_blk_config));
> +
>  	err =3D device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
>  	if (err)
>  		goto out_cleanup_disk;
> @@ -1251,6 +1589,9 @@ static unsigned int features[] =3D {
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
>  	VIRTIO_BLK_F_SECURE_ERASE,
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	VIRTIO_BLK_F_ZONED,
> +#endif /* CONFIG_BLK_DEV_ZONED */
>  };
> =20
>  static struct virtio_driver virtio_blk =3D {
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_=
blk.h
> index 58e70b24b504..3744e4da1b2a 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -41,6 +41,7 @@
>  #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
>  #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
>  #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
> +#define VIRTIO_BLK_F_ZONED		17	/* Zoned block device */
> =20
>  /* Legacy feature bits */
>  #ifndef VIRTIO_BLK_NO_LEGACY
> @@ -137,6 +138,16 @@ struct virtio_blk_config {
>  	/* Secure erase commands must be aligned to this number of sectors. */
>  	__virtio32 secure_erase_sector_alignment;
> =20
> +	/* Zoned block device characteristics (if VIRTIO_BLK_F_ZONED) */
> +	struct virtio_blk_zoned_characteristics {
> +		__virtio32 zone_sectors;
> +		__virtio32 max_open_zones;
> +		__virtio32 max_active_zones;
> +		__virtio32 max_append_sectors;
> +		__virtio32 write_granularity;
> +		__u8 model;
> +		__u8 unused2[3];
> +	} zoned;
>  } __attribute__((packed));
> =20
>  /*
> @@ -174,6 +185,27 @@ struct virtio_blk_config {
>  /* Secure erase command */
>  #define VIRTIO_BLK_T_SECURE_ERASE	14
> =20
> +/* Zone append command */
> +#define VIRTIO_BLK_T_ZONE_APPEND    15
> +
> +/* Report zones command */
> +#define VIRTIO_BLK_T_ZONE_REPORT    16
> +
> +/* Open zone command */
> +#define VIRTIO_BLK_T_ZONE_OPEN      18
> +
> +/* Close zone command */
> +#define VIRTIO_BLK_T_ZONE_CLOSE     20
> +
> +/* Finish zone command */
> +#define VIRTIO_BLK_T_ZONE_FINISH    22
> +
> +/* Reset zone command */
> +#define VIRTIO_BLK_T_ZONE_RESET     24
> +
> +/* Reset All zones command */
> +#define VIRTIO_BLK_T_ZONE_RESET_ALL 26
> +
>  #ifndef VIRTIO_BLK_NO_LEGACY
>  /* Barrier before this op. */
>  #define VIRTIO_BLK_T_BARRIER	0x80000000
> @@ -193,6 +225,72 @@ struct virtio_blk_outhdr {
>  	__virtio64 sector;
>  };
> =20
> +/*
> + * Supported zoned device models.
> + */
> +
> +/* Regular block device */
> +#define VIRTIO_BLK_Z_NONE      0
> +/* Host-managed zoned device */
> +#define VIRTIO_BLK_Z_HM        1
> +/* Host-aware zoned device */
> +#define VIRTIO_BLK_Z_HA        2
> +
> +/*
> + * Zone descriptor. A part of VIRTIO_BLK_T_ZONE_REPORT command reply.
> + */
> +struct virtio_blk_zone_descriptor {
> +	/* Zone capacity */
> +	__virtio64 z_cap;
> +	/* The starting sector of the zone */
> +	__virtio64 z_start;
> +	/* Zone write pointer position in sectors */
> +	__virtio64 z_wp;
> +	/* Zone type */
> +	__u8 z_type;
> +	/* Zone state */
> +	__u8 z_state;
> +	__u8 reserved[38];
> +};
> +
> +struct virtio_blk_zone_report {
> +	__virtio64 nr_zones;
> +	__u8 reserved[56];
> +	struct virtio_blk_zone_descriptor zones[];
> +};
> +
> +/*
> + * Supported zone types.
> + */
> +
> +/* Conventional zone */
> +#define VIRTIO_BLK_ZT_CONV         1
> +/* Sequential Write Required zone */
> +#define VIRTIO_BLK_ZT_SWR          2
> +/* Sequential Write Preferred zone */
> +#define VIRTIO_BLK_ZT_SWP          3
> +
> +/*
> + * Zone states that are available for zones of all types.
> + */
> +
> +/* Not a write pointer (conventional zones only) */
> +#define VIRTIO_BLK_ZS_NOT_WP       0
> +/* Empty */
> +#define VIRTIO_BLK_ZS_EMPTY        1
> +/* Implicitly Open */
> +#define VIRTIO_BLK_ZS_IOPEN        2
> +/* Explicitly Open */
> +#define VIRTIO_BLK_ZS_EOPEN        3
> +/* Closed */
> +#define VIRTIO_BLK_ZS_CLOSED       4
> +/* Read-Only */
> +#define VIRTIO_BLK_ZS_RDONLY       13
> +/* Full */
> +#define VIRTIO_BLK_ZS_FULL         14
> +/* Offline */
> +#define VIRTIO_BLK_ZS_OFFLINE      15
> +
>  /* Unmap this range (only valid for write zeroes command) */
>  #define VIRTIO_BLK_WRITE_ZEROES_FLAG_UNMAP	0x00000001
> =20
> @@ -219,4 +317,11 @@ struct virtio_scsi_inhdr {
>  #define VIRTIO_BLK_S_OK		0
>  #define VIRTIO_BLK_S_IOERR	1
>  #define VIRTIO_BLK_S_UNSUPP	2
> +
> +/* Error codes that are specific to zoned block devices */
> +#define VIRTIO_BLK_S_ZONE_INVALID_CMD     3
> +#define VIRTIO_BLK_S_ZONE_UNALIGNED_WP    4
> +#define VIRTIO_BLK_S_ZONE_OPEN_RESOURCE   5
> +#define VIRTIO_BLK_S_ZONE_ACTIVE_RESOURCE 6
> +
>  #endif /* _LINUX_VIRTIO_BLK_H */
> --=20
> 2.34.1
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20

--iNtgf2Q1eTp+A/ob
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmNMhFEACgkQnKSrs4Gr
c8hvRggAi1ZEyQ2DAe6WGk432v+8tckb7VprCVyuV5VjcaQwV1tCtB7UDcNcWuMN
4lQngy6YpFA0gDKKHNvelJtMj1VyNhRKNkAmt+eJ+t2RNYRYAFWGpVbOMBraHYdo
9OsBkKhOTbhWwLdfuC4E/rSEEa6IoX0Z/TpMz5JL1MLzMM56GZQop6wRglRvhCiZ
NAm5mWm/U4AGN7PjkKKZ+fq+Dvy+JRpKKC2m/HGKA6xQolVEeLTjc/4uLjKxo6iC
Yib/GHmHs92TkDA2EYE+835MbsBRPJHwye5KQpKjxDlgNgOUt0F20zAfpjUrIrwW
lmotjgeE7mnw9mwmLFCnaQ0QtdS4rg==
=vbn0
-----END PGP SIGNATURE-----

--iNtgf2Q1eTp+A/ob--

