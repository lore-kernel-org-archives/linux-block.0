Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAE3C2BB47
	for <linux-block@archiver.kernel.org>; Mon, 15 Aug 2022 20:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245427AbiHOUNV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Aug 2022 16:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiHOUJg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Aug 2022 16:09:36 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1832083F36
        for <linux-block@vger.kernel.org>; Mon, 15 Aug 2022 11:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660589766; x=1692125766;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V1iJTH7GEzKcPtxfy/9tnWQGVGcg7nbx15/9pWEV0IM=;
  b=M4OUBAWhP+zNC6rwmtUSMsR5jL0HTQMTjlANEHVbn4mpnOwcf04iLpta
   tNSB+oFVbdPJIQnSLIwaR+yB6fTRmRaRRRIFpXWJN8BbiAoSZ3w8R9/IH
   gfdPPgBvkhIiIvna6o6LXcZL80gXK5RrSkq0C4gTgEEfryZg9DgOHnBVt
   nPvbD/kHtdAfo4wweYjmdVQ8FLDsFs2h7v0D1uPd51+e/2dTIm0QT2m9/
   qu0x9DyDFQUojXEd2VNdObtEOV3mXR9PjzTWaOx/XH2t9o6Uj4YJZXM6U
   7qAJVUslkrIT75YxSuLDSp3mhLED843wYEMeZMPTjSmh8lCbOFnwWptoV
   A==;
X-IronPort-AV: E=Sophos;i="5.93,239,1654531200"; 
   d="scan'208";a="320854675"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Aug 2022 02:56:04 +0800
IronPort-SDR: 7HZ5LXL2gAoG0pdHHnmUo/4yeIfSkQTpMuC78CTiTug5Q4leqOWsyzgmajN1pnWbMme2dg6bee
 vmgulLMHkdw4odHgQoueIAzXFQQLIJMkP+/bk0pEbGUxQiCwOe0ndZfDn3aNRPGGYFilO7YUQi
 CNKkPUY898t5XA+kRpHTihokD2L1fqktixM4s419JjiIgzxXwonJ39OHwjOzg2u1U79aC2kDx2
 yey9ckvjJUSXR708jDQuJGFMM1SGCfQjR7yxBc+ipp3SbAg5GP3ZUroAvhOnuKOpzqMkeQV0Tt
 38LkhxHa2YEfPAKgQh7N0ayN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Aug 2022 11:11:34 -0700
IronPort-SDR: it0Ij43nFfWwAkDU2o6MsHomvgEBPtpDr+vkPVexKV+3kbY3lTwoYsJCWh1P516z6XmWT4uy07
 Wh4u9L0ut7m5AyTr5SJ0yWtaHZ6NYFas0lcCc/uEq2fZrjU0jpPANNQRJlGd/IKEYscqh72FDP
 KuSYi8i5NPESSDtgZ8Tdl1AZwAVG1WkJ9FOqbPtIvgz8OOvhq4b0vg/IYxcgpNn112MT40gr+X
 UEBp0WyWAojtDemBrlTqwdIRY09UgOkcGeUbzS0zx4ffMz10vrPOAS7Pn9O/ckVQWg17TCXshy
 bso=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Aug 2022 11:56:05 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M63QX24Vrz1Rws6
        for <linux-block@vger.kernel.org>; Mon, 15 Aug 2022 11:56:04 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660589762; x=1663181763; bh=V1iJTH7GEzKcPtxfy/9tnWQGVGcg7nbx15/
        9pWEV0IM=; b=FybXYp1ALxH8su0UB9BiMrQ9FGplM2lM4boxmp9iIb67GTukLEE
        q/18G2s8GHSb65ilJqnkr+RqSdfIVNDRHMoQK900+rR+hX0XeKEIehbrGWem50hy
        cLNZaGabb5X1Uj0uxcGNEplCVSlM3UXYgOxQ/lPMVq5nK3yRK6Sn3DkRG+xpaarY
        rdOwHipxVgJwPB3e62aDX3iJlgPE9Yr50g/sWg8weQMWE8HhYNu5Np4xawbzmGP7
        mdDkzAuC6yRf9jmFzJre+LcW21AM+Gdd/jb+SVbtiLCOznw6lNaKozLS9bs8Oom6
        xlB7rhAckE627gXVoksyJVZ0Jg3CxAUxonQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Xi_o3SJle11I for <linux-block@vger.kernel.org>;
        Mon, 15 Aug 2022 11:56:02 -0700 (PDT)
Received: from [10.11.46.122] (c02drav6md6t.sdcorp.global.sandisk.com [10.11.46.122])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M63QT4j3Gz1RtVk;
        Mon, 15 Aug 2022 11:56:01 -0700 (PDT)
Message-ID: <d4735d9e-31b6-0872-82a7-acbbd0cb5af5@opensource.wdc.com>
Date:   Mon, 15 Aug 2022 11:56:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v10 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, snitzer@kernel.org,
        axboe@kernel.dk, hch@lst.de, agk@redhat.com
Cc:     linux-block@vger.kernel.org, Johannes.Thumshirn@wdc.com,
        bvanassche@acm.org, matias.bjorling@wdc.com, hare@suse.de,
        gost.dev@samsung.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, pankydev8@gmail.com,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Joel Granados <j.granados@samsung.com>
References: <20220811143043.126029-1-p.raghav@samsung.com>
 <CGME20220811143058eucas1p247291685ffff7a75186947fd30b5c13f@eucas1p2.samsung.com>
 <20220811143043.126029-14-p.raghav@samsung.com>
 <bb4ab1f2-7e16-15a7-58b1-d37f6f3822fd@opensource.wdc.com>
 <b98ab80d-1bc0-a378-d438-09ef8b375836@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <b98ab80d-1bc0-a378-d438-09ef8b375836@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/08/15 6:38, Pankaj Raghav wrote:
> Hi Damien,
> 
>>> +static int dm_po2z_map_read_emulated_area(struct dm_po2z_target *dmh,
>>> +					  struct bio *bio)
>>
>> This really should be called dm_po2z_handle_read() since it handles both cases
>> of read commands, with and without the accept partial. Note that this is
>> retesting the need for a split after that was already tested in dm_po2z_map()
>> with bio_across_emulated_zone_area(). So the code should be better organized to
>> avoid that repetition.
>>
>> You can simplify the code by having bio_across_emulated_zone_area() return 0 for
>> a bio that does not cross the zone capacity and return the number of sectors up
>> to the zone capacity from the bio start if there is a cross. That value can then
> The offset will also be zero if the BIO starts at the zone capacity and
> dm_po2z_map will assume that the bio did not cross the emulated zone boundary.
> 
>> be used to call dm_accept_partial_bio() directly in dm_po2z_map() for read
>> commands. That will make this function much simpler and essentially turn it into
>> dm_po2z_read_zeroes().
>>
>>> +{
> 
> What about something like this? We have one function:
> bio_in_emulated_zone_area() that checks if a BIO is partly or completely in the
> emulated zone area and also returns the offset from bio to the emulated zone
> boundary (zone capacity of the device).
> 
> /**
>  * bio_in_emulated_zone_area - check if bio is in the emulated zone area
>  * @dmh:	pozone target data
>  * @bio:	bio
>  * @offset:	bio offset to emulated zone boundary
>  *
>  * Check if a @bio is partly or completely in the emulated zone area. If the
>  * @bio is partly in the emulated zone area, @offset
>  * can be used to split the @bio across the emulated zone boundary. @offset
>  * will be negative if the @bio completely lies in the emulated area.
>  *  */
> static bool bio_in_emulated_zone_area(struct dm_po2z_target *dmh,
> 					  struct bio *bio, int *offset)
> {
> 	unsigned int zone_idx = po2_zone_no(dmh, bio->bi_iter.bi_sector);
> 	sector_t nr_sectors = bio->bi_iter.bi_size >> SECTOR_SHIFT;
> 	sector_t relative_sect_in_zone =

Nit: Could simply call this sector_offset.

> 		bio->bi_iter.bi_sector - (zone_idx << dmh->zone_size_po2_shift);
> 
> 	*offset = dmh->zone_size - relative_sect_in_zone;
> 
> 	return (relative_sect_in_zone + nr_sectors) > dmh->zone_size;

No need for the parenthesis.

> }
> 
> static int dm_po2z_read_zeroes(struct bio *bio)

Make that an inline.

> {
> 	zero_fill_bio(bio);
> 	bio_endio(bio);
> 	return DM_MAPIO_SUBMITTED;
> }
> 
> static int dm_po2z_remap_sector(struct dm_po2z_target *dmh, struct bio *bio)

Inline this one too.

> {
> 	bio->bi_iter.bi_sector =
> 		target_to_device_sect(dmh, bio->bi_iter.bi_sector);
> 	return DM_MAPIO_REMAPPED;
> }
> 
> static int dm_po2z_map(struct dm_target *ti, struct bio *bio)
> {
> 	struct dm_po2z_target *dmh = ti->private;
> 
> 	bio_set_dev(bio, dmh->dev->bdev);
> 	if (bio_sectors(bio) || op_is_zone_mgmt(bio_op(bio))) {
> 		int split_io_pos;

Blank line needed here.

> 		if (!bio_in_emulated_zone_area(dmh, bio, &split_io_pos)) {
> 			return dm_po2z_remap_sector(dmh, bio);
> 		}

No need for the curly brackets.

> 		/*
> 		 * Read operation on the emulated zone area (between zone capacity
> 		 * and zone size) will fill the bio with zeroes. Any other operation
> 		 * in the emulated area should return an error.
> 		 */
> 		if (bio_op(bio) == REQ_OP_READ) {
> 			if (split_io_pos > 0) {
> 				dm_accept_partial_bio(bio, split_io_pos);
> 				return dm_po2z_remap_sector(dmh, bio);
> 			}
> 			return dm_po2z_read_zeroes(bio);
> 		}
> 		return DM_MAPIO_KILL;
> 	}
> 	return DM_MAPIO_REMAPPED;
> }
> 
> Let me know what you think.

I think this is way better. But I would still reorganize this like this:

static int dm_po2z_map(struct dm_target *ti, struct bio *bio)
{
        struct dm_po2z_target *dmh = ti->private;
        int split_io_pos;

        bio_set_dev(bio, dmh->dev->bdev);

        if (op_is_zone_mgmt(bio_op(bio)))
                return dm_po2z_remap_sector(dmh, bio);

        if (!bio_sectors(bio))
                return DM_MAPIO_REMAPPED;

        /*
         * Read operation on the emulated zone area (between zone capacity
         * and zone size) will fill the bio with zeroes. Any other operation
         * in the emulated area should return an error.
         */
        if (!bio_in_emulated_zone_area(dmh, bio, &split_io_pos))
                return dm_po2z_remap_sector(dmh, bio);

        if (bio_op(bio) == REQ_OP_READ) {
                if (split_io_pos > 0) {
                        dm_accept_partial_bio(bio, split_io_pos);
                        return dm_po2z_remap_sector(dmh, bio);
                }
                return dm_po2z_read_zeroes(bio);
        }

        return DM_MAPIO_KILL;
}

I find the code easier to follow this way.



-- 
Damien Le Moal
Western Digital Research
