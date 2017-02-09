Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38257 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751318AbdBIQIv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Feb 2017 11:08:51 -0500
Subject: Re: [PATCH 1/1] dm-zoned: Zoned block device target
To: Damien Le Moal <damien.lemoal@wdc.com>, dm-devel@redhat.com,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
References: <20170209041849.30964-1-damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d2353e66-183c-1f71-7a64-52e4b862bc17@suse.de>
Date: Thu, 9 Feb 2017 17:07:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170209041849.30964-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/09/2017 05:18 AM, Damien Le Moal wrote:
> The dm-zoned device mapper target provides transparent write access
> to zoned block devices (ZBC and ZAC compliant block devices).
> dm-zoned hides to the device user (a file system or an application
> doing raw block device accesses) any constraint imposed on write
> requests by the device. Write requests are processed using a
> combination of on-disk buffering using the device conventional zones,
> allowing any random write access to be safely executed, or direct in-place
> processing for requests aligned on a zone sequential write pointer position.
> A background reclaim process ensures that some conventional zones are always
> available for executing unaligned write requests. The reclaim process
> overhead is minimized by managing buffer zones in a least-recently-written
> order and first targeting the oldest buffer zones. Doing so, blocks under
> regular write access (such as metadata blocks of an FS) remain stored in
> conventional zones, resulting in no apparent write overhead.
> 
[ .. ]
> +/*
> + * CRC32
> + */
> +static u32 dmz_sb_crc32(u32 crc, const void *buf, size_t length)
> +{
> +	unsigned char *p = (unsigned char *)buf;
> +	int i;
> +
> +#define CRCPOLY_LE 0xedb88320
> +
> +	while (length--) {
> +		crc ^= *p++;
> +		for (i = 0; i < 8; i++)
> +			crc = (crc >> 1) ^ ((crc & 1) ? CRCPOLY_LE : 0);
> +	}
> +
> +	return crc;
> +}
> +
Why do you insist on your own CRC32 implementations?
Don't we have enough already?

[ .. ]
> +/*
> + * Write blocks.
> + */
> +static int dmz_reclaim_write(struct dm_zoned_target *dzt,
> +			     struct dm_zone *zone,
> +			     struct dm_zoned_ioreg **ioregs,
> +			     unsigned int nr_ioregs)
> +{
> +	struct dm_zoned_ioreg *ioreg;
> +	sector_t chunk_block;
> +	int i, ret = 0;
> +
> +	for (i = 0; i < nr_ioregs; i++) {
> +
> +		ioreg = ioregs[i];
> +
> +		/* Wait for the read I/O to complete */
> +		wait_for_completion_io(&ioreg->wait);
> +
> +		if (ret || ioreg->err) {
> +			if (ret == 0)
> +				ret = ioreg->err;
> +			dmz_reclaim_free_ioreg(ioreg);
> +			ioregs[i] = NULL;
> +			continue;
> +		}
> +
> +		chunk_block = ioreg->chunk_block;
> +
> +		dmz_dev_debug(dzt,
> +			      "Reclaim: Write %s zone %u, block %llu+%u\n",
> +			      dmz_is_rnd(zone) ? "RND" : "SEQ",
> +			      dmz_id(dzt, zone),
> +			      (unsigned long long)chunk_block,
> +			      ioreg->nr_blocks);
> +
> +		/*
> +		 * If we are writing in a sequential zones,
> +		 * we must make sure that writes are sequential. So
> +		 * fill up any eventual hole between writes.
> +		 */
> +		if (dmz_is_seq(zone)) {
> +			ret = dmz_reclaim_align_wp(dzt, zone, chunk_block);
> +			if (ret)
> +				break;
> +		}
> +
> +		/* Do write */
> +		dmz_reclaim_submit_ioreg(dzt, zone, ioreg, REQ_OP_WRITE);
> +		wait_for_completion_io(&ioreg->wait);
> +
> +		ret = ioreg->err;
> +		if (ret) {
> +			dmz_dev_err(dzt, "Reclaim: Write failed\n");
> +		} else {
> +			if (dmz_is_seq(zone))
> +				zone->wp_block += ioreg->nr_blocks;
> +			ret = dmz_validate_blocks(dzt, zone, chunk_block,
> +						  ioreg->nr_blocks);
> +		}
> +
> +		ioregs[i] = NULL;
> +		dmz_reclaim_free_ioreg(ioreg);
> +
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Move valid blocks of src_zone into dst_zone.
> + */
> +static int dmz_reclaim_copy_zone(struct dm_zoned_target *dzt,
> +				 struct dm_zone *src_zone,
> +				 struct dm_zone *dst_zone)
> +{
> +	struct dm_zoned_ioreg *ioregs[DMZ_RECLAIM_MAX_IOREGS];
> +	struct dm_zoned_ioreg *ioreg;
> +	sector_t chunk_block = 0;
> +	sector_t first_block, end_block;
> +	int nr_ioregs = 0, i, ret;
> +
> +	if (dmz_is_seq(src_zone))
> +		end_block = src_zone->wp_block;
> +	else
> +		end_block = dzt->zone_nr_blocks;
> +
> +	while (chunk_block < end_block) {
> +
> +		/* Read valid regions from source zone */
> +		nr_ioregs = 0;
> +		first_block = chunk_block;
> +		while (nr_ioregs < DMZ_RECLAIM_MAX_IOREGS &&
> +		       chunk_block < end_block) {
> +
> +			ioreg = dmz_reclaim_read(dzt, src_zone, chunk_block);
> +			if (IS_ERR(ioreg)) {
> +				ret = PTR_ERR(ioreg);
> +				goto err;
> +			}
> +			if (!ioreg)
> +				break;
> +
> +			chunk_block = ioreg->chunk_block + ioreg->nr_blocks;
> +			ioregs[nr_ioregs] = ioreg;
> +			nr_ioregs++;
> +
> +		}
> +
> +		/* Are we done ? */
> +		if (!nr_ioregs)
> +			break;
> +
> +		/* Write in destination zone */
> +		ret = dmz_reclaim_write(dzt, dst_zone, ioregs, nr_ioregs);
> +		if (ret != 0) {
> +			dmz_invalidate_blocks(dzt, dst_zone,
> +					      first_block,
> +					      end_block - first_block);
> +			goto err;
> +		}
> +
> +	}
> +
> +	return 0;
> +
> +err:
> +	for (i = 0; i < nr_ioregs; i++) {
> +		ioreg = ioregs[i];
> +		if (ioreg) {
> +			wait_for_completion_io(&ioreg->wait);
> +			dmz_reclaim_free_ioreg(ioreg);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
Have you looked at using dm-kcopyd for doing the reclaim?
What's inhibiting you from using it?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
