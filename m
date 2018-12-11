Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC95C04EB8
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 02:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3EC20645
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 02:02:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3EC20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeLKCCw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 21:02:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45280 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbeLKCCw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 21:02:52 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B33CD5AFE9;
        Tue, 11 Dec 2018 02:02:51 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 78FC55D73F;
        Tue, 11 Dec 2018 02:02:44 +0000 (UTC)
Date:   Tue, 11 Dec 2018 10:02:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Juergen Gross <jgross@suse.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/9] scsi: introduce a max_segment_size host_template
 parameters
Message-ID: <20181211020237.GB27651@ming.t460p>
References: <20181206155258.11465-1-hch@lst.de>
 <20181206155258.11465-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206155258.11465-3-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 11 Dec 2018 02:02:51 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 06, 2018 at 07:52:51AM -0800, Christoph Hellwig wrote:
> This allows the host driver to indicate the maximum supported
> segment size in a nice an easy way, so that the driver doesn't
> have to worry about DMA-layer imposed limitations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/be2iscsi/be_main.c | 8 +-------
>  drivers/scsi/hosts.c            | 5 +++++
>  drivers/scsi/scsi_debug.c       | 2 +-
>  drivers/scsi/scsi_lib.c         | 3 ++-
>  include/scsi/scsi_host.h        | 6 ++++++
>  5 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/scsi/be2iscsi/be_main.c b/drivers/scsi/be2iscsi/be_main.c
> index c4108b17d5ab..39f3820572b4 100644
> --- a/drivers/scsi/be2iscsi/be_main.c
> +++ b/drivers/scsi/be2iscsi/be_main.c
> @@ -214,12 +214,6 @@ static char const *cqe_desc[] = {
>  	"CXN_KILLED_IMM_DATA_RCVD"
>  };
>  
> -static int beiscsi_slave_configure(struct scsi_device *sdev)
> -{
> -	blk_queue_max_segment_size(sdev->request_queue, 65536);
> -	return 0;
> -}
> -
>  static int beiscsi_eh_abort(struct scsi_cmnd *sc)
>  {
>  	struct iscsi_task *abrt_task = (struct iscsi_task *)sc->SCp.ptr;
> @@ -393,7 +387,6 @@ static struct scsi_host_template beiscsi_sht = {
>  	.proc_name = DRV_NAME,
>  	.queuecommand = iscsi_queuecommand,
>  	.change_queue_depth = scsi_change_queue_depth,
> -	.slave_configure = beiscsi_slave_configure,
>  	.target_alloc = iscsi_target_alloc,
>  	.eh_timed_out = iscsi_eh_cmd_timed_out,
>  	.eh_abort_handler = beiscsi_eh_abort,
> @@ -404,6 +397,7 @@ static struct scsi_host_template beiscsi_sht = {
>  	.can_queue = BE2_IO_DEPTH,
>  	.this_id = -1,
>  	.max_sectors = BEISCSI_MAX_SECTORS,
> +	.max_segment_size = 65536,
>  	.cmd_per_lun = BEISCSI_CMD_PER_LUN,
>  	.vendor_id = SCSI_NL_VID_TYPE_PCI | BE_VENDOR_ID,
>  	.track_queue_depth = 1,
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index ea4b0bb0c1cd..e8148ba414a3 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -464,6 +464,11 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
>  	else
>  		shost->max_sectors = SCSI_DEFAULT_MAX_SECTORS;
>  
> +	if (sht->max_segment_size)
> +		shost->max_segment_size = sht->max_segment_size;
> +	else
> +		shost->max_segment_size = BLK_MAX_SEGMENT_SIZE;
> +
>  	/*
>  	 * assume a 4GB boundary, if not set
>  	 */
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 53ba417bef8a..57d418d7d74e 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -3973,7 +3973,6 @@ static int scsi_debug_slave_configure(struct scsi_device *sdp)
>  			return 1;  /* no resources, will be marked offline */
>  	}
>  	sdp->hostdata = devip;
> -	blk_queue_max_segment_size(sdp->request_queue, -1U);
>  	if (sdebug_no_uld)
>  		sdp->no_uld_attach = 1;
>  	config_cdb_len(sdp);
> @@ -5851,6 +5850,7 @@ static struct scsi_host_template sdebug_driver_template = {
>  	.sg_tablesize =		SG_MAX_SEGMENTS,
>  	.cmd_per_lun =		DEF_CMD_PER_LUN,
>  	.max_sectors =		-1U,
> +	.max_segment_size =	-1U,
>  	.module =		THIS_MODULE,
>  	.track_queue_depth =	1,
>  };
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index f6900e0b3024..2d4fd6b4bd92 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -2227,7 +2227,8 @@ void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
>  	blk_queue_segment_boundary(q, shost->dma_boundary);
>  	dma_set_seg_boundary(dev, shost->dma_boundary);
>  
> -	blk_queue_max_segment_size(q, dma_get_max_seg_size(dev));
> +	blk_queue_max_segment_size(q,
> +		min(shost->max_segment_size, dma_get_max_seg_size(dev)));
>  
>  	if (shost->use_clustering == DISABLE_CLUSTERING)
>  		q->limits.cluster = 0;
> diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
> index 7dc534c794dc..834204681ca3 100644
> --- a/include/scsi/scsi_host.h
> +++ b/include/scsi/scsi_host.h
> @@ -364,6 +364,11 @@ struct scsi_host_template {
>  	 */
>  	unsigned int max_sectors;
>  
> +	/*
> +	 * Maximum size in bytes of a single segment.
> +	 */
> +	unsigned int max_segment_size;
> +
>  	/*
>  	 * DMA scatter gather segment boundary limit. A segment crossing this
>  	 * boundary will be split in two.
> @@ -603,6 +608,7 @@ struct Scsi_Host {
>  	short unsigned int sg_tablesize;
>  	short unsigned int sg_prot_tablesize;
>  	unsigned int max_sectors;
> +	unsigned int max_segment_size;
>  	unsigned long dma_boundary;
>  	/*
>  	 * In scsi-mq mode, the number of hardware queues supported by the LLD.
> -- 
> 2.19.1
> 

Just one concern, max segment size is often related with one specific
controller's DMA capability.

Is it possible that HBAs have different segment size, but all are driven
by same driver(shared scsi_host_template)?

If yes, this way may not be a correct abstract, at least defining 
'max_segment_size' from 'scsi_host_template'.

Thanks,
Ming
