Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AAE2C6FA82
	for <linux-block@archiver.kernel.org>; Mon, 19 Sep 2022 23:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiISX7b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Sep 2022 19:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiISX7X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2022 19:59:23 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E40520A3
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663631957; x=1695167957;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cEVZ92IUthHU1udbHEvnHa/hWAI5exdOeev5CQ+ALEQ=;
  b=FP1dlfanUffBtEgz4uWdkekEZLXk6Updcry4bMH3WnvHHWo47jdAyLY0
   v/+ifD0e9EEWrcQVyWf7/81XsQL+h7Y3vr+T81MV6wjGXSfVmwwD4cJOd
   xrZeEcfOj0V3S4zJlH7ylrLzQsd/scWfkzyjMi3nKXVn1fhqUX3zF9YHX
   cdUqR3QB8XOeXRReEcyhpeT0XA+MBWRHhS+LFSUpZxg8p7vNmTEeUQ+qZ
   2Giup05L5WZtxA0WDNZQ7V1TYE02pn45ibkGePmi/gdbzMJ/cW9+3Aij9
   Tjq8Of78EdkuXWNmRukeqbBrFhbtsxG0RHw/mRCGqqBIuQuuIWU5M4Mqt
   w==;
X-IronPort-AV: E=Sophos;i="5.93,329,1654531200"; 
   d="scan'208";a="316037985"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2022 07:59:16 +0800
IronPort-SDR: DacpeMaHrrN/GThsY+Av/s6u8eXtM0iN5EswZcdji37ubuKPCUEIQGLUJz0qR8ZUUZGXr1QXPx
 Kbmfp9kKoQ/zE1gjLUieloBrn3TXyKAK8hgtbaQA5gXncl8Vjag/xUBhByNswR5zgSyAtRlGVz
 lvnZgSJswWZXkOZgHjSk6nnjFwUQJxMNzW3xWexdqSjWdoVTKD5VzrNOFE77xc5YP7tbibqhIh
 Mrl6DyDMgQlyN5mbtw7DnMQ4rM600T1cRAKi49nm7DUHKn63SkxpPisTJK27Ir1jUQyDcAXnkw
 OaKWPbtOS7wfxBxwyVIx31Vz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2022 16:19:23 -0700
IronPort-SDR: Pob1X/2KkQaLdBU1FDDhT33b2ex7XkcK4nzdR0BcXZvCUNjtwPhF7BDAvGjUI1atDNnNfVTfvx
 jHgddOIhlSmjqYEEHxENq4EVVtJvNtraDZlnKNvVTGeBb0PM6Y0Y5OLYaPzm5YsaM7oClE9Kap
 9PSAZnRe5Rlx26A6GZFRbre+BWf5xUz4BDp5Sz0YEivt2DIVA67qoVAUfAmR48+VthDjdK0LbN
 HDXvE7CQh50Dwtx1AmExDT83e0hYp/hMiJhNA7sOqh+wy+4Z5vevlElYtIFOR0ahS+0d4qNcJe
 P/M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2022 16:59:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MWhVD3zt1z1Rwtl
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2022 16:59:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663631955; x=1666223956; bh=cEVZ92IUthHU1udbHEvnHa/hWAI5exdOeev
        5CQ+ALEQ=; b=LIwnSk2O812DQo1Xx1WJrdwCpbgoTRr6PsEoFA+L1CjbSaDhlwl
        tjrq0QWYB/xZjDrZCnrFTFO2IbxEk7KQpXQ8jQcBMqpwL/ZHacovF2L9tD2tB6KI
        moCSQYDeCHQBaBRqZTKfb+n3Y5MdIvUbOeQNGzPW+2SVNsPIn3UBBeb0XBYA+00a
        gLeDWXFQQHZgvrhthow0tDNzcsGfeRiy44Jtlop0iJzNGHzAd+S/r/N94OBRO8s4
        gIKQb5U4A0AhwOgBMeDsjSHuWC9FlaDSpd0AcuWMdFJpm3OjbWnu6bCqoTrkSHuX
        qYkpiLvlD87YjrwsTplzEo9EDRAmiB7gy0Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9NWJTJ9rxMMH for <linux-block@vger.kernel.org>;
        Mon, 19 Sep 2022 16:59:15 -0700 (PDT)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MWhV744XZz1RvLy;
        Mon, 19 Sep 2022 16:59:11 -0700 (PDT)
Message-ID: <44dfb47f-a59f-b236-03bf-5d25d7f206b5@opensource.wdc.com>
Date:   Tue, 20 Sep 2022 08:59:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 3/3] virtio-blk: add support for zoned block devices
Content-Language: en-US
To:     Pankaj Raghav <pankydev8@gmail.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Stefan Hajnoczi <stefanha@gmail.com>,
        Hannes Reinecke <hare@suse.de>,
        Sam Li <faithilikerun@gmail.com>, linux-block@vger.kernel.org,
        virtio-dev@lists.oasis-open.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        k.jensen@samsung.com
References: <20220919022921.946344-1-dmitry.fomichev@wdc.com>
 <20220919022921.946344-4-dmitry.fomichev@wdc.com>
 <20220919133853.2xsamyvr66qeogko@quentin>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220919133853.2xsamyvr66qeogko@quentin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/19/22 22:41, Pankaj Raghav wrote:
> Hi Dmitry,
> 
> On Sun, Sep 18, 2022 at 10:29:21PM -0400, Dmitry Fomichev wrote:
>> The zone-specific code in the patch is heavily influenced by NVMe ZNS
>> code in drivers/nvme/host/zns.c, but it is simpler because the proposed
>> virtio ZBD draft only covers the zoned device features that are
>> relevant to the zoned functionality provided by Linux block layer.
>>
> There is a parallel work going on to support non-po2 zone sizes in Linux
> block layer and drivers[1]. I don't see any reason why we shouldn't make
> the calculations generic here instead of putting the constraint on zone
> sectors to be po2 as the virtio spec also supports it.

That series is not upstream, so implementing against would not be the
correct approach, especially given that this would also impact qemu code.

> 
> I took a quick look, and changing the calculations from po2 specific to
> generic will not be in the hot path and can be trivially changed. I have
> suggested the changes inline to make the virtio blk driver zone size 
> agnostic. I haven't tested the changes but it is very
> similar to the changes I did in the drivers/nvme/host/zns.c in my patch
> series[2].
> 
> [1] https://lore.kernel.org/linux-block/20220912082204.51189-1-p.raghav@samsung.com/
> [2] https://lore.kernel.org/linux-block/20220912082204.51189-6-p.raghav@samsung.com/
> 
>> Co-developed-by: Stefan Hajnoczi <stefanha@gmail.com>
>> Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
>> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>
>> ---
>>  drivers/block/virtio_blk.c      | 381 ++++++++++++++++++++++++++++++--
>>  include/uapi/linux/virtio_blk.h | 106 +++++++++
>>  2 files changed, 469 insertions(+), 18 deletions(-)
>>
> <snip>
>> +#ifdef CONFIG_BLK_DEV_ZONED
>> +static void *virtblk_alloc_report_buffer(struct virtio_blk *vblk,
>> +					  unsigned int nr_zones,
>> +					  unsigned int zone_sectors,
>> +					  size_t *buflen)
>> +{
>> +	struct request_queue *q = vblk->disk->queue;
>> +	size_t bufsize;
>> +	void *buf;
>> +
> -	nr_zones = min_t(unsigned int, nr_zones,
> -			 get_capacity(vblk->disk) >> ilog2(zone_sectors));
> 
> +	nr_zones = min_t(unsigned int, nr_zones,
> +			 div64_u64(get_capacity(vblk->disk), zone_sectors));
> 
>> +
>> +	bufsize = sizeof(struct virtio_blk_zone_report) +
>> +		nr_zones * sizeof(struct virtio_blk_zone_descriptor);
>> +	bufsize = min_t(size_t, bufsize,
>> +			queue_max_hw_sectors(q) << SECTOR_SHIFT);
>> +	bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);
>> +
>> +	while (bufsize >= sizeof(struct virtio_blk_zone_report)) {
>> +		buf = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
>> +		if (buf) {
>> +			*buflen = bufsize;
>> +			return buf;
>> +		}
>> +		bufsize >>= 1;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static int virtblk_submit_zone_report(struct virtio_blk *vblk,
>> +				       char *report_buf, size_t report_len,
>> +				       sector_t sector)
>> +{
>> +	struct request_queue *q = vblk->disk->queue;
>> +	struct request *req;
>> +	struct virtblk_req *vbr;
>> +	int err;
>> +
>> +	req = blk_mq_alloc_request(q, REQ_OP_DRV_IN, 0);
>> +	if (IS_ERR(req))
>> +		return PTR_ERR(req);
>> +
>> +	vbr = blk_mq_rq_to_pdu(req);
>> +	vbr->in_hdr_len = sizeof(vbr->status);
>> +	vbr->out_hdr.type = cpu_to_virtio32(vblk->vdev, VIRTIO_BLK_T_ZONE_REPORT);
>> +	vbr->out_hdr.sector = cpu_to_virtio64(vblk->vdev, sector);
>> +
>> +	err = blk_rq_map_kern(q, req, report_buf, report_len, GFP_KERNEL);
>> +	if (err)
>> +		goto out;
>> +
>> +	blk_execute_rq(req, false);
>> +	err = blk_status_to_errno(virtblk_result(vbr->status));
>> +out:
>> +	blk_mq_free_request(req);
>> +	return err;
>> +}
>> +
>> +static int virtblk_parse_zone(struct virtio_blk *vblk,
>> +			       struct virtio_blk_zone_descriptor *entry,
>> +			       unsigned int idx, unsigned int zone_sectors,
>> +			       report_zones_cb cb, void *data)
>> +{
>> +	struct blk_zone zone = { };
>> +
>> +	if (entry->z_type != VIRTIO_BLK_ZT_SWR &&
>> +	    entry->z_type != VIRTIO_BLK_ZT_SWP &&
>> +	    entry->z_type != VIRTIO_BLK_ZT_CONV) {
>> +		dev_err(&vblk->vdev->dev, "invalid zone type %#x\n",
>> +			entry->z_type);
>> +		return -EINVAL;
>> +	}
>> +
>> +	zone.type = entry->z_type;
>> +	zone.cond = entry->z_state;
>> +	zone.len = zone_sectors;
>> +	zone.capacity = le64_to_cpu(entry->z_cap);
>> +	zone.start = le64_to_cpu(entry->z_start);
>> +	if (zone.cond == BLK_ZONE_COND_FULL)
>> +		zone.wp = zone.start + zone.len;
>> +	else
>> +		zone.wp = le64_to_cpu(entry->z_wp);
>> +
>> +	return cb(&zone, idx, data);
>> +}
>> +
>> +static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
>> +				 unsigned int nr_zones, report_zones_cb cb,
>> +				 void *data)
>> +{
>> +	struct virtio_blk *vblk = disk->private_data;
>> +	struct virtio_blk_zone_report *report;
>> +	unsigned int zone_sectors = vblk->zone_sectors;
>> +	unsigned int nz, i;
>> +	int ret, zone_idx = 0;
>> +	size_t buflen;
> +	u64 remainder;
>> +
>> +	if (WARN_ON_ONCE(!vblk->zone_sectors))
>> +		return -EOPNOTSUPP;
>> +
>> +	report = virtblk_alloc_report_buffer(vblk, nr_zones,
>> +					     zone_sectors, &buflen);
>> +	if (!report)
>> +		return -ENOMEM;
>> +
> -	sector &= ~(zone_sectors - 1);
> 
> +	div64_u64_rem(sector, zone_sectors, &remainder);
> +	sector -= remainder;
>> +	while (zone_idx < nr_zones && sector < get_capacity(vblk->disk)) {
>> +		memset(report, 0, buflen);
>> +
>> +		ret = virtblk_submit_zone_report(vblk, (char *)report,
>> +						 buflen, sector);
>> +		if (ret) {
>> +			if (ret > 0)
>> +				ret = -EIO;
>> +			goto out_free;
>> +		}
>> +
>> +		nz = min((unsigned int)le64_to_cpu(report->nr_zones), nr_zones);
>> +		if (!nz)
>> +			break;
>> +
>> +		for (i = 0; i < nz && zone_idx < nr_zones; i++) {
>> +			ret = virtblk_parse_zone(vblk, &report->zones[i],
>> +						 zone_idx, zone_sectors, cb, data);
>> +			if (ret)
>> +				goto out_free;
>> +			zone_idx++;
>> +		}
>> +
>> +		sector += zone_sectors * nz;
>> +	}
>> +
>> +	if (zone_idx > 0)
>> +		ret = zone_idx;
>> +	else
>> +		ret = -EINVAL;
>> +out_free:
>> +	kvfree(report);
>> +	return ret;
>> +}
>> +
> <snip>
>> +static int virtblk_probe_zoned_device(struct virtio_device *vdev,
>> +				       struct virtio_blk *vblk,
>> +				       struct request_queue *q)
>> +{
> <snip>
>> +	blk_queue_physical_block_size(q, le32_to_cpu(v));
>> +	blk_queue_io_min(q, le32_to_cpu(v));
>> +
>> +	dev_dbg(&vdev->dev, "write granularity = %u\n", le32_to_cpu(v));
>> +
> -	/*
> -	 * virtio ZBD specification doesn't require zones to be a power of
> -	 * two sectors in size, but the code in this driver expects that.
> -	 */
> -	virtio_cread(vdev, struct virtio_blk_config, zoned.zone_sectors, &v);
> -	if (v == 0 || !is_power_of_2(v)) {
> -		dev_err(&vdev->dev,
> -			"zoned device with non power of two zone size %u\n", v);
> -		return -ENODEV;
> -	}
>> +
>> +	dev_dbg(&vdev->dev, "zone sectors = %u\n", le32_to_cpu(v));
>> +	vblk->zone_sectors = le32_to_cpu(v);
>> +
>> +	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
>> +		dev_warn(&vblk->vdev->dev,
>> +			 "ignoring negotiated F_DISCARD for zoned device\n");
>> +		blk_queue_max_discard_sectors(q, 0);
>> +	}
>> +
>> +	ret = blk_revalidate_disk_zones(vblk->disk, NULL);
>> +	if (!ret) {
>> +		virtio_cread(vdev, struct virtio_blk_config,
>> +			     zoned.max_append_sectors, &v);
>> +		if (!v) {
>> +			dev_warn(&vdev->dev, "zero max_append_sectors reported\n");
>> +			return -ENODEV;
>> +		}
>> +		blk_queue_max_zone_append_sectors(q, le32_to_cpu(v));
>> +		dev_dbg(&vdev->dev, "max append sectors = %u\n", le32_to_cpu(v));
>> +
>> +	}
>> +
>> +	return ret;
>> +}
>> +
> 

-- 
Damien Le Moal
Western Digital Research

