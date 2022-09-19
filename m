Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A394DECAAD3
	for <linux-block@archiver.kernel.org>; Mon, 19 Sep 2022 13:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiISNln (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Sep 2022 09:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiISNlm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2022 09:41:42 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA31511C22
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 06:41:40 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1274ec87ad5so61953669fac.0
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 06:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=1ZDO6px2oAyvYdf8zfQASjU9lsasSELd32zfLD8mc/o=;
        b=pjPXWaHvdyWyPZXLXRaLpfFRm4La91h+EUV7X56jCmOk8H8/KzdjYS/LhkxLz5cG9B
         vUOJMmUpbZJOTFDpVoPKYR3b3za/2pAkF4cUKdiuQCzPIWWrNJzD3G7du8GCZKBFmDWV
         b93m7SCqgp4gWktgnRP6Jt/DhJHCZUQETCvTYGkOjyZCSzxkOBDuTDrc2+DK+zfUX7bh
         jSHm7fp+9I76ttCRVIw1EJMP7nNJZG/5GXDiTnfiDE7YdssJ/lAyhRT+VEd3OiTI3eFx
         CucEMj5+LDjjRwQmJEXEq03i8C49vYPqg+mpsl0kPazrDF+cVcpfacAj9Ut+iWLnn8Ph
         QU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1ZDO6px2oAyvYdf8zfQASjU9lsasSELd32zfLD8mc/o=;
        b=HDDvHyKbpuZ6T470olhXUm+faBSOb0R6WXkIsSrHh8BAkHAxk7Ye0Lldm09F5naUxE
         FxQecsN/cyAxgrtjiKrUMfIFIgoAh02WijcA8ydP56mhNCl5HzBmKwTL5FySv3JYHghL
         7VAoOSP+9AFZfkZ6k46SWjZV/ff6UvfrX+XczivMpbG4ZxU7TIrlJFNRhWUpQqFpaxjW
         vhSZDdlTC9x8uPHKm+7Ik6XdYVUfAWZHl+/ADSsW/4z7I6Yr/PzDSc4CoWYXOXoygAyp
         cwwswchcgccV6RNDhzkzCtVW0MMJZN5ws+sxSchrXz1BaMSookMbQwDMrn72MK7WJFfu
         6utg==
X-Gm-Message-State: ACrzQf3wja8QnaWSnMNVwVi2kT8Ry8Dc/1ucdrXgGj2mp76gURuHKKq4
        TkNTE3n4KY+IxS9kj0aXG5I=
X-Google-Smtp-Source: AMsMyM68rtwiv9AR+AM4X4xNycS0ZVnqBLkyFjsIuAEJffxz6+raUOUAqc5LAjocnLKPDcSwWAs+0w==
X-Received: by 2002:a05:6870:a101:b0:12b:82e6:9954 with SMTP id m1-20020a056870a10100b0012b82e69954mr9831478oae.231.1663594900029;
        Mon, 19 Sep 2022 06:41:40 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id m7-20020a9d6447000000b00616d25dc933sm14021171otl.69.2022.09.19.06.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 06:41:39 -0700 (PDT)
Date:   Mon, 19 Sep 2022 15:41:33 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>, linux-block@vger.kernel.org,
        virtio-dev@lists.oasis-open.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>,
        k.jensen@samsung.com
Subject: Re: [PATCH 3/3] virtio-blk: add support for zoned block devices
Message-ID: <20220919133853.2xsamyvr66qeogko@quentin>
References: <20220919022921.946344-1-dmitry.fomichev@wdc.com>
 <20220919022921.946344-4-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919022921.946344-4-dmitry.fomichev@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Dmitry,

On Sun, Sep 18, 2022 at 10:29:21PM -0400, Dmitry Fomichev wrote:
> The zone-specific code in the patch is heavily influenced by NVMe ZNS
> code in drivers/nvme/host/zns.c, but it is simpler because the proposed
> virtio ZBD draft only covers the zoned device features that are
> relevant to the zoned functionality provided by Linux block layer.
> 
There is a parallel work going on to support non-po2 zone sizes in Linux
block layer and drivers[1]. I don't see any reason why we shouldn't make
the calculations generic here instead of putting the constraint on zone
sectors to be po2 as the virtio spec also supports it.

I took a quick look, and changing the calculations from po2 specific to
generic will not be in the hot path and can be trivially changed. I have
suggested the changes inline to make the virtio blk driver zone size 
agnostic. I haven't tested the changes but it is very
similar to the changes I did in the drivers/nvme/host/zns.c in my patch
series[2].

[1] https://lore.kernel.org/linux-block/20220912082204.51189-1-p.raghav@samsung.com/
[2] https://lore.kernel.org/linux-block/20220912082204.51189-6-p.raghav@samsung.com/

> Co-developed-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> ---
>  drivers/block/virtio_blk.c      | 381 ++++++++++++++++++++++++++++++--
>  include/uapi/linux/virtio_blk.h | 106 +++++++++
>  2 files changed, 469 insertions(+), 18 deletions(-)
> 
<snip>
> +#ifdef CONFIG_BLK_DEV_ZONED
> +static void *virtblk_alloc_report_buffer(struct virtio_blk *vblk,
> +					  unsigned int nr_zones,
> +					  unsigned int zone_sectors,
> +					  size_t *buflen)
> +{
> +	struct request_queue *q = vblk->disk->queue;
> +	size_t bufsize;
> +	void *buf;
> +
-	nr_zones = min_t(unsigned int, nr_zones,
-			 get_capacity(vblk->disk) >> ilog2(zone_sectors));

+	nr_zones = min_t(unsigned int, nr_zones,
+			 div64_u64(get_capacity(vblk->disk), zone_sectors));

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
> +	vbr->in_hdr_len = sizeof(vbr->status);
> +	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_ZONE_REPORT);
> +	vbr->out_hdr.sector = cpu_to_virtio64(vblk->vdev, sector);
> +
> +	err = blk_rq_map_kern(q, req, report_buf, report_len, GFP_KERNEL);
> +	if (err)
> +		goto out;
> +
> +	blk_execute_rq(req, false);
> +	err = blk_status_to_errno(virtblk_result(vbr->status));
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
> +	struct blk_zone zone = { };
> +
> +	if (entry->z_type != VIRTIO_BLK_ZT_SWR &&
> +	    entry->z_type != VIRTIO_BLK_ZT_SWP &&
> +	    entry->z_type != VIRTIO_BLK_ZT_CONV) {
> +		dev_err(&vblk->vdev->dev, "invalid zone type %#x\n",
> +			entry->z_type);
> +		return -EINVAL;
> +	}
> +
> +	zone.type = entry->z_type;
> +	zone.cond = entry->z_state;
> +	zone.len = zone_sectors;
> +	zone.capacity = le64_to_cpu(entry->z_cap);
> +	zone.start = le64_to_cpu(entry->z_start);
> +	if (zone.cond == BLK_ZONE_COND_FULL)
> +		zone.wp = zone.start + zone.len;
> +	else
> +		zone.wp = le64_to_cpu(entry->z_wp);
> +
> +	return cb(&zone, idx, data);
> +}
> +
> +static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
> +				 unsigned int nr_zones, report_zones_cb cb,
> +				 void *data)
> +{
> +	struct virtio_blk *vblk = disk->private_data;
> +	struct virtio_blk_zone_report *report;
> +	unsigned int zone_sectors = vblk->zone_sectors;
> +	unsigned int nz, i;
> +	int ret, zone_idx = 0;
> +	size_t buflen;
+	u64 remainder;
> +
> +	if (WARN_ON_ONCE(!vblk->zone_sectors))
> +		return -EOPNOTSUPP;
> +
> +	report = virtblk_alloc_report_buffer(vblk, nr_zones,
> +					     zone_sectors, &buflen);
> +	if (!report)
> +		return -ENOMEM;
> +
-	sector &= ~(zone_sectors - 1);

+	div64_u64_rem(sector, zone_sectors, &remainder);
+	sector -= remainder;
> +	while (zone_idx < nr_zones && sector < get_capacity(vblk->disk)) {
> +		memset(report, 0, buflen);
> +
> +		ret = virtblk_submit_zone_report(vblk, (char *)report,
> +						 buflen, sector);
> +		if (ret) {
> +			if (ret > 0)
> +				ret = -EIO;
> +			goto out_free;
> +		}
> +
> +		nz = min((unsigned int)le64_to_cpu(report->nr_zones), nr_zones);
> +		if (!nz)
> +			break;
> +
> +		for (i = 0; i < nz && zone_idx < nr_zones; i++) {
> +			ret = virtblk_parse_zone(vblk, &report->zones[i],
> +						 zone_idx, zone_sectors, cb, data);
> +			if (ret)
> +				goto out_free;
> +			zone_idx++;
> +		}
> +
> +		sector += zone_sectors * nz;
> +	}
> +
> +	if (zone_idx > 0)
> +		ret = zone_idx;
> +	else
> +		ret = -EINVAL;
> +out_free:
> +	kvfree(report);
> +	return ret;
> +}
> +
<snip>
> +static int virtblk_probe_zoned_device(struct virtio_device *vdev,
> +				       struct virtio_blk *vblk,
> +				       struct request_queue *q)
> +{
<snip>
> +	blk_queue_physical_block_size(q, le32_to_cpu(v));
> +	blk_queue_io_min(q, le32_to_cpu(v));
> +
> +	dev_dbg(&vdev->dev, "write granularity = %u\n", le32_to_cpu(v));
> +
-	/*
-	 * virtio ZBD specification doesn't require zones to be a power of
-	 * two sectors in size, but the code in this driver expects that.
-	 */
-	virtio_cread(vdev, struct virtio_blk_config, zoned.zone_sectors, &v);
-	if (v == 0 || !is_power_of_2(v)) {
-		dev_err(&vdev->dev,
-			"zoned device with non power of two zone size %u\n", v);
-		return -ENODEV;
-	}
> +
> +	dev_dbg(&vdev->dev, "zone sectors = %u\n", le32_to_cpu(v));
> +	vblk->zone_sectors = le32_to_cpu(v);
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
> +		blk_queue_max_zone_append_sectors(q, le32_to_cpu(v));
> +		dev_dbg(&vdev->dev, "max append sectors = %u\n", le32_to_cpu(v));
> +
> +	}
> +
> +	return ret;
> +}
> +

-- 
Pankaj Raghav
