Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF39C433FE
	for <linux-block@archiver.kernel.org>; Wed,  9 Nov 2022 05:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiKIFiZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Nov 2022 00:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiKIFiZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Nov 2022 00:38:25 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4B6B34
        for <linux-block@vger.kernel.org>; Tue,  8 Nov 2022 21:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667972302; x=1699508302;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KSlMYQMMwIkESafRv7uWnhDukhU04opG0Jf3L7/yoYM=;
  b=n2SWry210c2CRzNWdzFJZ1W5Ri8nODNUV7W9FTCkicQEyL9efVBAVvcq
   +KASpehSE/KAGcaClQQzqiIIU8SxHGOFf2TdbjpNYpHtP5XhZ/zNX0zb+
   QQbKp8LSTGACTDjeIOA1jN4xlugckmVBqEhtcVKtm0SEBO2vaqGB0SZj3
   HODs4N3MPSGVJLl4j8WocHel5o+pjGTCHfnMMXuqskw5WoQuP6EUImCO9
   xC0rXB1Lctm6325FC6CbuPbJNTj4LkRITh5Cg+z5e3cJEYYaDFrU5omVZ
   zZBe5bRAlx0Mkr/c3USIuIt1gOPU37fGEh0mJwCZf4jZB3dI2D7dC/bmI
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,149,1665417600"; 
   d="scan'208";a="320166321"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2022 13:38:22 +0800
IronPort-SDR: dZlacQk9XomlCq7Mvjz+dlLDK7U54nADSOIXRx6HGb71E8/jNAHNT2Yw5I8JXRNVDm2WbGZlK1
 5PXn+hONheQ9LsAdSjCFTnCVRSzCGT+Pod+EKpWw9VonCrHWChiD6iZHzlrw5ISlQojr/HB+m4
 /WBlRBpZPkpm8d3AdQMKL3FScNn7tLSY0YR/HePluPToo/T+wPgIgLQHSZIs/rRJ1AsEkxgoky
 dZILGjE8jocI97RqcnazNxFVT+kHyB9mGruLgAdozmEygbJPewjcwuoT29Lz/5wXQKr2jQyh6w
 NPQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2022 20:51:41 -0800
IronPort-SDR: gMkfvyQ/FAjzplfWObsLz+Kfz/TB4DywgQbahtOk97n+ks8SPjGI1rwQ+CGmtGyyF10oIlY/JW
 W01zV8BEicNvRsqi6Bi9wbBDTuzCfRQBR4KYX/UYd11FP5ckXLNcB1/6k+OK7NgRvaCSWb90xK
 K+xYUN0LKiDywAfsvgQmEfY37d3GuvwT7D65kndJPSl0wlhhCgB+5zmlHLXD3PF2inQPT7vnNv
 jajQpj88Goagq6IX/H08sweJalA1vgLLQ/XcxwBuso1SVCE458A1O0DvavnqvkBpDp5VivK8D8
 U+k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2022 21:38:21 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4N6YfN35x9z1RwtC
        for <linux-block@vger.kernel.org>; Tue,  8 Nov 2022 21:38:20 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1667972297; x=1670564298; bh=KSlMYQMMwIkESafRv7uWnhDukhU04opG0Jf
        3L7/yoYM=; b=tShB9HdLmA5R/zeOFNLBWsBgAVouppne2cLxzBpHfMRWDb/q2tn
        T7nfNp6gMnlgWMS702Kr4m6ibNK1rufsDOevuTQNpl745M4yK5XBzuK17HdkjtGM
        M3rY/vf05pSdQRb9YGUqIZvMXGrhtXjXoHbKsgtfQBH2c8xvDrB4QT7hgkVnFuRy
        AIUunb+bWbhjckxsNmBoaYQjrd8hw3+6a92kBtuogpfXybaz1fHbnVDdw9yg2VCs
        H/Z3qNxp6clK0it/jTGEXRRZuAzi67IPQdt6heJ7B2F98Tij9L2IN1jp9BM0j3LQ
        hSu8UV0x3DyRMco9BMgNVq8085aEczFauVQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ak6Fdd_x3Wvg for <linux-block@vger.kernel.org>;
        Tue,  8 Nov 2022 21:38:17 -0800 (PST)
Received: from [10.225.163.37] (unknown [10.225.163.37])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4N6YfJ3SSPz1RvLy;
        Tue,  8 Nov 2022 21:38:16 -0800 (PST)
Message-ID: <e11ef806-93a9-7e88-0a82-c9c5b64bab61@opensource.wdc.com>
Date:   Wed, 9 Nov 2022 14:38:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v6 2/2] virtio-blk: add support for zoned block devices
Content-Language: en-US
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>
Cc:     virtio-dev@lists.oasis-open.org
References: <20221109044632.3121790-1-dmitry.fomichev@wdc.com>
 <20221109044632.3121790-3-dmitry.fomichev@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221109044632.3121790-3-dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/9/22 13:46, Dmitry Fomichev wrote:
> This patch adds support for Zoned Block Devices (ZBDs) to the kernel
> virtio-blk driver.
> 
> The patch accompanies the virtio-blk ZBD support draft that is now
> being proposed for standardization. The latest version of the draft is
> linked at
> 
> https://github.com/oasis-tcs/virtio-spec/issues/143 .
> 
> The QEMU zoned device code that implements these protocol extensions
> has been developed by Sam Li and it is currently in review at the QEMU
> mailing list.
> 
> A number of virtblk request structure changes has been introduced to
> accommodate the functionality that is specific to zoned block devices
> and, most importantly, make room for carrying the Zoned Append sector
> value from the device back to the driver along with the request status.
> 
> The zone-specific code in the patch is heavily influenced by NVMe ZNS
> code in drivers/nvme/host/zns.c, but it is simpler because the proposed
> virtio ZBD draft only covers the zoned device features that are
> relevant to the zoned functionality provided by Linux block layer.
> 
> Co-developed-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/block/virtio_blk.c      | 456 ++++++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_blk.h | 105 ++++++++
>  2 files changed, 542 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 3efe3da5f8c2..ef1494f2e3ea 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -15,6 +15,7 @@
>  #include <linux/blk-mq.h>
>  #include <linux/blk-mq-virtio.h>
>  #include <linux/numa.h>
> +#include <linux/vmalloc.h>
>  #include <uapi/linux/virtio_ring.h>
>  
>  #define PART_BITS 4
> @@ -80,22 +81,51 @@ struct virtio_blk {
>  	int num_vqs;
>  	int io_queues[HCTX_MAX_TYPES];
>  	struct virtio_blk_vq *vqs;
> +
> +	/* For zoned device */
> +	unsigned int zone_sectors;
>  };
>  
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
>  
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
> @@ -111,11 +141,11 @@ static inline struct virtio_blk_vq *get_virtio_blk_vq(struct blk_mq_hw_ctx *hctx
>  
>  static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
>  {
> -	struct scatterlist hdr, status, *sgs[3];
> +	struct scatterlist out_hdr, in_hdr, *sgs[3];
>  	unsigned int num_out = 0, num_in = 0;
>  
> -	sg_init_one(&hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
> -	sgs[num_out++] = &hdr;
> +	sg_init_one(&out_hdr, &vbr->out_hdr, sizeof(vbr->out_hdr));
> +	sgs[num_out++] = &out_hdr;
>  
>  	if (vbr->sg_table.nents) {
>  		if (vbr->out_hdr.type & cpu_to_virtio32(vq->vdev, VIRTIO_BLK_T_OUT))
> @@ -124,8 +154,8 @@ static int virtblk_add_req(struct virtqueue *vq, struct virtblk_req *vbr)
>  			sgs[num_out + num_in++] = vbr->sg_table.sgl;
>  	}
>  
> -	sg_init_one(&status, &vbr->status, sizeof(vbr->status));
> -	sgs[num_out + num_in++] = &status;
> +	sg_init_one(&in_hdr, &vbr->in_hdr.common.status, vbr->in_hdr_len);
> +	sgs[num_out + num_in++] = &in_hdr;
>  
>  	return virtqueue_add_sgs(vq, sgs, num_out, num_in, vbr, GFP_ATOMIC);
>  }
> @@ -214,21 +244,22 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  				      struct request *req,
>  				      struct virtblk_req *vbr)
>  {
> +	size_t in_hdr_len = sizeof(vbr->in_hdr.common.status);
>  	bool unmap = false;
>  	u32 type;
> +	u64 sector = 0;
>  
> -	vbr->out_hdr.sector = 0;
> +	/* Set fields for all request types */
> +	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
>  
>  	switch (req_op(req)) {
>  	case REQ_OP_READ:
>  		type = VIRTIO_BLK_T_IN;
> -		vbr->out_hdr.sector = cpu_to_virtio64(vdev,
> -						      blk_rq_pos(req));
> +		sector = blk_rq_pos(req);
>  		break;
>  	case REQ_OP_WRITE:
>  		type = VIRTIO_BLK_T_OUT;
> -		vbr->out_hdr.sector = cpu_to_virtio64(vdev,
> -						      blk_rq_pos(req));
> +		sector = blk_rq_pos(req);
>  		break;
>  	case REQ_OP_FLUSH:
>  		type = VIRTIO_BLK_T_FLUSH;
> @@ -243,16 +274,45 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  	case REQ_OP_SECURE_ERASE:
>  		type = VIRTIO_BLK_T_SECURE_ERASE;
>  		break;
> -	case REQ_OP_DRV_IN:
> -		type = VIRTIO_BLK_T_GET_ID;
> +	case REQ_OP_ZONE_OPEN:
> +		type = VIRTIO_BLK_T_ZONE_OPEN;
> +		sector = blk_rq_pos(req);
>  		break;
> +	case REQ_OP_ZONE_CLOSE:
> +		type = VIRTIO_BLK_T_ZONE_CLOSE;
> +		sector = blk_rq_pos(req);
> +		break;
> +	case REQ_OP_ZONE_FINISH:
> +		type = VIRTIO_BLK_T_ZONE_FINISH;
> +		sector = blk_rq_pos(req);
> +		break;
> +	case REQ_OP_ZONE_APPEND:
> +		type = VIRTIO_BLK_T_ZONE_APPEND;
> +		sector = blk_rq_pos(req);
> +		in_hdr_len = sizeof(vbr->in_hdr.zone_append);
> +		break;
> +	case REQ_OP_ZONE_RESET:
> +		type = VIRTIO_BLK_T_ZONE_RESET;
> +		sector = blk_rq_pos(req);
> +		break;
> +	case REQ_OP_ZONE_RESET_ALL:
> +		type = VIRTIO_BLK_T_ZONE_RESET_ALL;
> +		break;
> +	case REQ_OP_DRV_IN:
> +		/*
> +		 * Out header has already been prepared by the caller (virtblk_get_id()
> +		 * or virtblk_submit_zone_report()), nothing to do here.
> +		 */
> +		return 0;

Nit: Given that support for the zone code is guarded with
CONFIG_BLK_DEV_ZONED, it would be nice to have the same for the above
operations. But may be it is cleaner to add something like:

	if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
	    op_is_zone_mgmt(req_op(req)))
		return error;

at the beginning of this function. Not that this should ever happen...

>  	default:
>  		WARN_ON_ONCE(1);
>  		return BLK_STS_IOERR;
>  	}
>  
> +	/* Set fields for non-REQ_OP_DRV_IN request types */
> +	vbr->in_hdr_len = in_hdr_len;
>  	vbr->out_hdr.type = cpu_to_virtio32(vdev, type);
> -	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
> +	vbr->out_hdr.sector = cpu_to_virtio64(vdev, sector);
>  
>  	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES ||
>  	    type == VIRTIO_BLK_T_SECURE_ERASE) {
> @@ -263,13 +323,30 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
>  	return 0;
>  }
>  
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
>  	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
> +	blk_status_t status = virtblk_result(virtblk_vbr_status(vbr));
> +	struct virtio_blk *vblk = req->mq_hctx->queue->queuedata;
>  
>  	virtblk_unmap_data(req, vbr);
>  	virtblk_cleanup_cmd(req);
> -	blk_mq_end_request(req, virtblk_result(vbr));
> +
> +	if (req_op(req) == REQ_OP_ZONE_APPEND)
> +		req->__sector = virtio64_to_cpu(vblk->vdev,
> +						vbr->in_hdr.zone_append.sector);
> +
> +	blk_mq_end_request(req, status);
>  }
>  
>  static void virtblk_done(struct virtqueue *vq)
> @@ -455,6 +532,330 @@ static void virtio_queue_rqs(struct request **rqlist)
>  	*rqlist = requeue_list;
>  }
>  
> +#ifdef CONFIG_BLK_DEV_ZONED
> +static void *virtblk_alloc_report_buffer(struct virtio_blk *vblk,
> +					  unsigned int nr_zones,
> +					  unsigned int zone_sectors,

This argument is always vblk->zone_sectors so it is not needed.

> +					  size_t *buflen)
> +{
> +	struct request_queue *q = vblk->disk->queue;
> +	size_t bufsize;
> +	void *buf;
> +
> +	nr_zones = min_t(unsigned int, nr_zones,
> +			 get_capacity(vblk->disk) >> ilog2(zone_sectors));
> +
> +	bufsize = sizeof(struct virtio_blk_zone_report) +
> +		nr_zones * sizeof(struct virtio_blk_zone_descriptor);
> +	bufsize = min_t(size_t, bufsize,
> +			queue_max_hw_sectors(q) << SECTOR_SHIFT);
> +	bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);
> +
> +	while (bufsize >= sizeof(struct virtio_blk_zone_report)) {
> +		buf = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
> +		if (buf) {
> +			*buflen = bufsize;
> +			return buf;
> +		}
> +		bufsize >>= 1;
> +	}
> +
> +	return NULL;
> +}
> +
> +static int virtblk_submit_zone_report(struct virtio_blk *vblk,
> +				       char *report_buf, size_t report_len,
> +				       sector_t sector)
> +{
> +	struct request_queue *q = vblk->disk->queue;
> +	struct request *req;
> +	struct virtblk_req *vbr;
> +	int err;
> +
> +	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
> +	if (IS_ERR(req))
> +		return PTR_ERR(req);
> +
> +	vbr = blk_mq_rq_to_pdu(req);
> +	vbr->in_hdr_len = sizeof(vbr->in_hdr.common.status);
> +	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_ZONE_REPORT);
> +	vbr->out_hdr.sector = cpu_to_virtio64(vblk->vdev, sector);
> +
> +	err = blk_rq_map_kern(q, req, report_buf, report_len, GFP_KERNEL);
> +	if (err)
> +		goto out;
> +
> +	blk_execute_rq(req, false);
> +	err = blk_status_to_errno(virtblk_result(vbr->in_hdr.common.status));
> +out:
> +	blk_mq_free_request(req);
> +	return err;
> +}
> +
> +static int virtblk_parse_zone(struct virtio_blk *vblk,
> +			       struct virtio_blk_zone_descriptor *entry,
> +			       unsigned int idx, unsigned int zone_sectors,

zone_sectors argument is always vblk->zone_sectors, so it is not needed.

> +			       report_zones_cb cb, void *data)
> +{
> +	struct blk_zone zone = { };
> +
> +	zone.start = virtio64_to_cpu(vblk->vdev, entry->z_start);
> +	if (zone.start + zone_sectors <= get_capacity(vblk->disk))
> +		zone.len = zone_sectors;
> +	else
> +		zone.len = get_capacity(vblk->disk) - zone.start;
> +	zone.capacity = virtio64_to_cpu(vblk->vdev, entry->z_cap);
> +	zone.wp = virtio64_to_cpu(vblk->vdev, entry->z_wp);
> +
> +	switch (entry->z_type) {
> +	case VIRTIO_BLK_ZT_SWR:
> +		zone.type = BLK_ZONE_TYPE_SEQWRITE_REQ;
> +		break;
> +	case VIRTIO_BLK_ZT_SWP:
> +		zone.type = BLK_ZONE_TYPE_SEQWRITE_PREF;
> +		break;
> +	case VIRTIO_BLK_ZT_CONV:
> +		zone.type = BLK_ZONE_TYPE_CONVENTIONAL;
> +		break;
> +	default:
> +		dev_err(&vblk->vdev->dev, "zone %llu: invalid type %#x\n",
> +			zone.start, entry->z_type);
> +		return -EIO;
> +	}
> +
> +	switch (entry->z_state) {
> +	case VIRTIO_BLK_ZS_EMPTY:
> +		zone.cond = BLK_ZONE_COND_EMPTY;
> +		break;
> +	case VIRTIO_BLK_ZS_CLOSED:
> +		zone.cond = BLK_ZONE_COND_CLOSED;
> +		break;
> +	case VIRTIO_BLK_ZS_FULL:
> +		zone.cond = BLK_ZONE_COND_FULL;
> +		zone.wp = zone.start + zone.len;
> +		break;
> +	case VIRTIO_BLK_ZS_EOPEN:
> +		zone.cond = BLK_ZONE_COND_EXP_OPEN;
> +		break;
> +	case VIRTIO_BLK_ZS_IOPEN:
> +		zone.cond = BLK_ZONE_COND_IMP_OPEN;
> +		break;
> +	case VIRTIO_BLK_ZS_NOT_WP:
> +		zone.cond = BLK_ZONE_COND_NOT_WP;
> +		break;
> +	case VIRTIO_BLK_ZS_RDONLY:
> +		zone.cond = BLK_ZONE_COND_READONLY;
> +		zone.wp = zone.start + zone.len;
> +		break;
> +	case VIRTIO_BLK_ZS_OFFLINE:
> +		zone.cond = BLK_ZONE_COND_OFFLINE;
> +		zone.wp = zone.start + zone.len;

Nit: may be better to set wp to total garbage, e.g. -1 ?

> +		break;
> +	default:
> +		dev_err(&vblk->vdev->dev, "zone %llu: invalid condition %#x\n",
> +			zone.start, entry->z_state);
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * The callback below checks the validity of the reported
> +	 * entry data, no need to further validate it here.
> +	 */
> +	return cb(&zone, idx, data);
> +}
> +
> +static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
> +				 unsigned int nr_zones, report_zones_cb cb,
> +				 void *data)
> +{
> +	struct virtio_blk *vblk = disk->private_data;
> +	struct virtio_blk_zone_report *report;
> +	unsigned long long nz, i;
> +	size_t buflen;
> +	unsigned int zone_sectors = vblk->zone_sectors, zone_idx = 0;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!vblk->zone_sectors))
> +		return -EOPNOTSUPP;
> +
> +	report = virtblk_alloc_report_buffer(vblk, nr_zones,
> +					     zone_sectors, &buflen);
> +	if (!report)
> +		return -ENOMEM;
> +
> +	mutex_lock(&vblk->vdev_mutex);
> +
> +	if (!vblk->vdev) {
> +		ret = -ENXIO;
> +		goto fail_report;
> +	}
> +
> +	while (zone_idx < nr_zones && sector < get_capacity(vblk->disk)) {
> +		memset(report, 0, buflen);
> +
> +		ret = virtblk_submit_zone_report(vblk, (char *)report,
> +						 buflen, sector);
> +		if (ret)
> +			goto fail_report;
> +
> +		nz = min_t(u64, virtio64_to_cpu(vblk->vdev, report->nr_zones),
> +			   nr_zones);
> +		if (!nz)
> +			break;
> +
> +		for (i = 0; i < nz && zone_idx < nr_zones; i++) {
> +			ret = virtblk_parse_zone(vblk, &report->zones[i],
> +						 zone_idx, zone_sectors, cb, data);
> +			if (ret)
> +				goto fail_report;
> +
> +			sector = virtio64_to_cpu(vblk->vdev,
> +						 report->zones[i].z_start) +
> +				 zone_sectors;
> +			zone_idx++;
> +		}
> +	}
> +
> +	if (zone_idx > 0)
> +		ret = zone_idx;
> +	else
> +		ret = -EINVAL;
> +fail_report:
> +	mutex_unlock(&vblk->vdev_mutex);
> +	kvfree(report);
> +	return ret;
> +}
> +
> +static void virtblk_revalidate_zones(struct virtio_blk *vblk)
> +{
> +	u8 model;
> +
> +	virtio_cread(vblk->vdev, struct virtio_blk_config,
> +		     zoned.model, &model);
> +	switch (model) {
> +	default:
> +		dev_err(&vblk->vdev->dev, "unknown zone model %d\n", model);
> +		fallthrough;
> +	case VIRTIO_BLK_Z_NONE:
> +	case VIRTIO_BLK_Z_HA:
> +		disk_set_zoned(vblk->disk, BLK_ZONED_NONE);
> +		return;
> +	case VIRTIO_BLK_Z_HM:
> +		WARN_ON_ONCE(!vblk->zone_sectors);
> +		if (!blk_revalidate_disk_zones(vblk->disk, NULL))
> +			set_capacity_and_notify(vblk->disk, 0);
> +	}
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
> +	case VIRTIO_BLK_Z_HA:
> +		/* Present the host-aware device as non-zoned */
> +		return 0;
> +	case VIRTIO_BLK_Z_HM:
> +		break;
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
> +	dev_dbg(&vdev->dev, "max open zones = %u\n", v);
> +
> +	virtio_cread(vdev, struct virtio_blk_config,
> +		     zoned.max_active_zones, &v);
> +	disk_set_max_active_zones(vblk->disk, v);
> +	dev_dbg(&vdev->dev, "max active zones = %u\n", v);
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
> +	dev_dbg(&vdev->dev, "write granularity = %u\n", wg);
> +
> +	/*
> +	 * virtio ZBD specification doesn't require zones to be a power of
> +	 * two sectors in size, but the code in this driver expects that.
> +	 */
> +	virtio_cread(vdev, struct virtio_blk_config, zoned.zone_sectors,
> +		     &vblk->zone_sectors);
> +	if (vblk->zone_sectors == 0 || !is_power_of_2(vblk->zone_sectors)) {
> +		dev_err(&vdev->dev,
> +			"zoned device with non power of two zone size %u\n",
> +			vblk->zone_sectors);
> +		return -ENODEV;
> +	}
> +	dev_dbg(&vdev->dev, "zone sectors = %u\n", vblk->zone_sectors);
> +
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
> +		dev_warn(&vblk->vdev->dev,
> +			 "ignoring negotiated F_DISCARD for zoned device\n");
> +		blk_queue_max_discard_sectors(q, 0);
> +	}
> +
> +	ret = blk_revalidate_disk_zones(vblk->disk, NULL);
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
> +		dev_dbg(&vdev->dev, "max append sectors = %u\n", v);
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
> @@ -462,18 +863,24 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
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
> +	vbr->in_hdr_len = sizeof(vbr->in_hdr.common.status);
> +	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_GET_ID);
> +	vbr->out_hdr.sector = 0;
> +
>  	err = blk_rq_map_kern(q, req, id_str, VIRTIO_BLK_ID_BYTES, GFP_KERNEL);
>  	if (err)
>  		goto out;
>  
>  	blk_execute_rq(req, false);
> -	err = blk_status_to_errno(virtblk_result(blk_mq_rq_to_pdu(req)));
> +	err = blk_status_to_errno(virtblk_result(vbr->in_hdr.common.status));
>  out:
>  	blk_mq_free_request(req);
>  	return err;
> @@ -524,6 +931,7 @@ static const struct block_device_operations virtblk_fops = {
>  	.owner  	= THIS_MODULE,
>  	.getgeo		= virtblk_getgeo,
>  	.free_disk	= virtblk_free_disk,
> +	.report_zones	= virtblk_report_zones,
>  };
>  
>  static int index_to_minor(int index)
> @@ -594,6 +1002,7 @@ static void virtblk_config_changed_work(struct work_struct *work)
>  	struct virtio_blk *vblk =
>  		container_of(work, struct virtio_blk, config_work);
>  
> +	virtblk_revalidate_zones(vblk);
>  	virtblk_update_capacity(vblk, true);
>  }
>  
> @@ -861,7 +1270,7 @@ static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>  		struct request *req = blk_mq_rq_from_pdu(vbr);
>  
>  		found++;
> -		if (!blk_mq_add_to_batch(req, iob, vbr->status,
> +		if (!blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
>  						virtblk_complete_batch))
>  			blk_mq_complete_request(req);
>  	}
> @@ -1150,6 +1559,12 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	virtblk_update_capacity(vblk, false);
>  	virtio_device_ready(vdev);
>  
> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
> +		err = virtblk_probe_zoned_device(vdev, vblk, q);
> +		if (err)
> +			goto out_cleanup_disk;
> +	}
> +
>  	err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);
>  	if (err)
>  		goto out_cleanup_disk;
> @@ -1251,6 +1666,9 @@ static unsigned int features[] = {
>  	VIRTIO_BLK_F_FLUSH, VIRTIO_BLK_F_TOPOLOGY, VIRTIO_BLK_F_CONFIG_WCE,
>  	VIRTIO_BLK_F_MQ, VIRTIO_BLK_F_DISCARD, VIRTIO_BLK_F_WRITE_ZEROES,
>  	VIRTIO_BLK_F_SECURE_ERASE,
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	VIRTIO_BLK_F_ZONED,
> +#endif /* CONFIG_BLK_DEV_ZONED */
>  };
>  
>  static struct virtio_driver virtio_blk = {
> diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_blk.h
> index 58e70b24b504..3744e4da1b2a 100644
> --- a/include/uapi/linux/virtio_blk.h
> +++ b/include/uapi/linux/virtio_blk.h
> @@ -41,6 +41,7 @@
>  #define VIRTIO_BLK_F_DISCARD	13	/* DISCARD is supported */
>  #define VIRTIO_BLK_F_WRITE_ZEROES	14	/* WRITE ZEROES is supported */
>  #define VIRTIO_BLK_F_SECURE_ERASE	16 /* Secure Erase is supported */
> +#define VIRTIO_BLK_F_ZONED		17	/* Zoned block device */
>  
>  /* Legacy feature bits */
>  #ifndef VIRTIO_BLK_NO_LEGACY
> @@ -137,6 +138,16 @@ struct virtio_blk_config {
>  	/* Secure erase commands must be aligned to this number of sectors. */
>  	__virtio32 secure_erase_sector_alignment;
>  
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
>  
>  /*
> @@ -174,6 +185,27 @@ struct virtio_blk_config {
>  /* Secure erase command */
>  #define VIRTIO_BLK_T_SECURE_ERASE	14
>  
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
>  
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
>  
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

-- 
Damien Le Moal
Western Digital Research

