Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70016F917
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332008; cv=none; b=R23mZpmJkzAU2qQTn0SU8vd2e3djF+EhlzLGnbacxqWBW90P5BDWF8+eJGQp63WIUVmltu0vlINcBiF3RDBaF/f8G0vpk7ztp1x19pHAUilesdUw2pv6PYVSjLDFUU76WDQxjqn8xK3nz0hgZ9K86usx0Ub0to6zGy+K3VRMlBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332008; c=relaxed/simple;
	bh=jUADTu38D03I4Ry2sPtTsYlXDDX8IthBPUcAPHRcmC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0Juagn0enE7PFm8Jj8BOAW4VNsw5/EYULuR9WkFFuLecEeRa3zNYPK0eKXOLhZPyhs0aG3S1TfpClpecQjPGVHjGQK/RJHzzz4hibPP367C5RrpUi5VPvGGbaEx4/0R5dvxhsCFN3ZxSYL7KnZt8loyazMRYDzPkxLFrcvwra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4345f35daa7so2091021cf.0
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2024 08:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712332006; x=1712936806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rbAxhTU3trm8omv2Bw7/7acDjs036CDj3MB035wsvw=;
        b=N311vjMT68iHgtnyTyQk2JxA5P5O9wAqYZeH9v6lYrJ+cqRiMZnr+N4oea9l6nWHyi
         bkbZ6gfSzKb1LIGOl2WmnWyXa/9NOkMLKZSUsZosUpDEkn6GNhovn6EfNGWZv322FNsV
         2DCPWdNHRX5TtfYlFW6CAyT+sDrZxbvKdzFxNutSAu376oYlVRBAaRzUN86DdMfTumtZ
         J8UNMHd/yso+35qpOUmztGuhDhZHtCPkJGDiPgN8c0UDmkzWrb7JBJ+Y1TtUL7B2kEmR
         pE4JaIjVUh0qqhMUZnUzT7nuaeEHst5Htoo/89nSBQT9g48VntH3/Z5vOfe1Kt50RC3w
         F2rw==
X-Gm-Message-State: AOJu0YwukLqQObjH8jkq2I23dQUNUUnFey56VAyNetFfH/qedQd2llo7
	gLGZ7+F+beoQhjPV73uybsFlHPIVYQ36rmTT8GCUDeAKnuogBcHLG4xZqBWsxUudH5U8kFWc3gY
	=
X-Google-Smtp-Source: AGHT+IEXwj4lJiAs5E/QO+Sa6vdj5AXAThaYh2DQXIrBkzcrcg7oaujlyRW+rioUqrlHYgkWfdpcnQ==
X-Received: by 2002:a05:622a:5e8d:b0:434:61bc:9e22 with SMTP id er13-20020a05622a5e8d00b0043461bc9e22mr1787408qtb.24.1712332005953;
        Fri, 05 Apr 2024 08:46:45 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id bw9-20020a05622a098900b004330090b874sm852109qtb.95.2024.04.05.08.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:46:45 -0700 (PDT)
Date: Fri, 5 Apr 2024 11:46:44 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 12/28] dm: Use the block layer zone append emulation
Message-ID: <ZhAc5JL9KwoDdiOO@redhat.com>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
 <20240405044207.1123462-13-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405044207.1123462-13-dlemoal@kernel.org>

On Fri, Apr 05 2024 at 12:41P -0400,
Damien Le Moal <dlemoal@kernel.org> wrote:

> For targets requiring zone append operation emulation with regular
> writes (e.g. dm-crypt), we can use the block layer emulation provided by
> zone write plugging. Remove DM implemented zone append emulation and
> enable the block layer one.
> 
> This is done by setting the max_zone_append_sectors limit of the
> mapped device queue to 0 for mapped devices that have a target table
> that cannot support native zone append operations (e.g. dm-crypt).
> Such mapped devices are flagged with the DMF_EMULATE_ZONE_APPEND flag.
> dm_split_and_process_bio() is modified to execute
> blk_zone_write_plug_bio() for such device to let the block layer
> transform zone append operations into regular writes.  This is done
> after ensuring that the submitted BIO is split if it straddles zone
> boundaries. Both changes are implemented unsing the inline helpers
> dm_zone_write_plug_bio() and dm_zone_bio_needs_split() respectively.
> 
> dm_revalidate_zones() is also modified to use the block layer provided
> function blk_revalidate_disk_zones() so that all zone resources needed
> for zone append emulation are initialized by the block layer without DM
> core needing to do anything. Since the device table is not yet live when
> dm_revalidate_zones() is executed, enabling the use of
> blk_revalidate_disk_zones() requires adding a pointer to the device
> table in struct mapped_device. This avoids errors in
> dm_blk_report_zones() trying to get the table with dm_get_live_table().
> The mapped device table pointer is set to the table passed as argument
> to dm_revalidate_zones() before calling blk_revalidate_disk_zones() and
> reset to NULL after this function returns to restore the live table
> handling for user call of report zones.
> 
> All the code related to zone append emulation is removed from
> dm-zone.c. This leads to simplifications of the functions __map_bio()
> and dm_zone_endio(). This later function now only needs to deal with
> completions of real zone append operations for targets that support it.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Mike Snitzer <snitzer@kernel.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
> ---
>  drivers/md/dm-core.h |   2 +-
>  drivers/md/dm-zone.c | 476 ++++---------------------------------------
>  drivers/md/dm.c      |  72 ++++---
>  drivers/md/dm.h      |   4 +-
>  4 files changed, 94 insertions(+), 460 deletions(-)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index eb9832b22b14..174fda0a301c 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -226,41 +154,32 @@ static int dm_zone_revalidate_cb(struct blk_zone *zone, unsigned int idx,
>  static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
>  {
>  	struct gendisk *disk = md->disk;
> -	unsigned int noio_flag;
>  	int ret;
>  
> -	/*
> -	 * Check if something changed. If yes, cleanup the current resources
> -	 * and reallocate everything.
> -	 */
> +	/* Revalidate ionly if something changed. */

Just noticed this ionly typo ^ Please fix.

Thanks,
Mike
