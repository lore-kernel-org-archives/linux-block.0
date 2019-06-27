Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF09C48BD7
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 14:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE96D2085A
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 14:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfF0OQv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 10:16:51 -0400
Received: from verein.lst.de ([213.95.11.210]:39044 "EHLO newverein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726370AbfF0OQv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 10:16:51 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id EB65768C7B; Thu, 27 Jun 2019 16:09:00 +0200 (CEST)
Date:   Thu, 27 Jun 2019 16:09:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V5 2/3] sd_zbc: Fix report zones buffer allocation
Message-ID: <20190627140900.GB6209@lst.de>
References: <20190627092944.20957-1-damien.lemoal@wdc.com> <20190627092944.20957-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627092944.20957-3-damien.lemoal@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> @@ -79,6 +80,7 @@ static int sd_zbc_do_report_zones(struct scsi_disk *sdkp, unsigned char *buf,
>  	put_unaligned_be32(buflen, &cmd[10]);
>  	if (partial)
>  		cmd[14] = ZBC_REPORT_ZONE_PARTIAL;
> +
>  	memset(buf, 0, buflen);
>  
>  	result = scsi_execute_req(sdp, cmd, DMA_FROM_DEVICE,

Spurious whitespace change.

> +static void *sd_zbc_alloc_report_buffer(struct request_queue *q,
> +					unsigned int nr_zones, size_t *buflen,
> +					gfp_t gfp_mask)
> +{
> +	size_t bufsize;
> +	void *buf;
> +
> +	/*
> +	 * Report zone buffer size should be at most 64B times the number of
> +	 * zones requested plus the 64B reply header, but should be at least
> +	 * SECTOR_SIZE for ATA devices.
> +	 * Make sure that this size does not exceed the hardware capabilities.
> +	 * Furthermore, since the report zone command cannot be split, make
> +	 * sure that the allocated buffer can always be mapped by limiting the
> +	 * number of pages allocated to the HBA max segments limit.
> +	 */
> +	nr_zones = min(nr_zones, SD_ZBC_REPORT_MAX_ZONES);
> +	bufsize = roundup((nr_zones + 1) * 64, 512);
> +	bufsize = min_t(size_t, bufsize,
> +			queue_max_hw_sectors(q) << SECTOR_SHIFT);
> +	bufsize = min_t(size_t, bufsize, queue_max_segments(q) << PAGE_SHIFT);
> +
> +	buf = __vmalloc(bufsize, gfp_mask, PAGE_KERNEL);

__vmalloc is odd in that it takes a gfp parameter, but can't actually
use it for the page table allocations.  So you'll need to do
memalloc_noio_save here, or even better do that in the block layer and
remove the gfp_t parameter from ->report_zones.

