Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740CAC10F11
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 08:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502A420656
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 08:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfDXIl7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:41:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45228 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfDXIl7 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 04:41:59 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D6D498765E;
        Wed, 24 Apr 2019 08:41:58 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A14151001DD0;
        Wed, 24 Apr 2019 08:41:51 +0000 (UTC)
Date:   Wed, 24 Apr 2019 16:41:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/2] scsi: core: avoid to pre-allocate big chunk for sg
 list
Message-ID: <20190424084145.GB32345@ming.t460p>
References: <20190423103240.29864-1-ming.lei@redhat.com>
 <20190423103240.29864-3-ming.lei@redhat.com>
 <20190424055317.GF12136@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424055317.GF12136@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 24 Apr 2019 08:41:58 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 24, 2019 at 07:53:17AM +0200, Christoph Hellwig wrote:
> On Tue, Apr 23, 2019 at 06:32:40PM +0800, Ming Lei wrote:
> > big, the whole pre-allocation for sg list can consume huge memory.
> > For example of lpfc, nr_hw_queues can be 70, each queue's depth
> > can be 3781, so the pre-allocation for data sg list can be 70*3781*2k
> > =517MB for single HBA.
> 
> We should probably limit the number of queues to something actually
> useful, independent of your patch..
> 
> > +static bool scsi_use_inline_sg(struct scsi_cmnd *cmd)
> > +{
> > +	struct scatterlist *sg = (void *)cmd + sizeof(struct scsi_cmnd) +
> > +		cmd->device->host->hostt->cmd_size;
> > +
> > +	return cmd->sdb.table.sgl == sg;
> > +}
> 
> It might make more sense to have a helper to calculate the inline
> sg address and use that for the comparism in scsi_mq_free_sgtables
> and any other place that wants the address.

Good idea, and the helper can be used in scsi_mq_prep_fn() too.

> 
> > +	if (cmd->sdb.table.nents && !scsi_use_inline_sg(cmd))
> > +		sg_free_table_chained(&cmd->sdb.table, false);
> 
> This removes the last use of the first_chunk paramter to
> sg_free_table_chained, please remove the paramter in an additional
> patch.

NVMe FC/RDMA still uses first_chunk.

> 
> > +	if (nr_segs <= SCSI_INLINE_SG_CNT)
> > +		sdb->table.nents = sdb->table.orig_nents =
> > +			SCSI_INLINE_SG_CNT;
> 
> Don't we need a sg_init_table here?

Will do it in V2.

> 
> > +	else if (unlikely(sg_alloc_table_chained(&sdb->table, nr_segs,
> > +					NULL)))
> >  		return BLK_STS_RESOURCE;
> 
> We should probably also be able to drop the last parameter to
> sg_alloc_table_chained now.

NVMe FC/RDMA still uses first_chunk.

Thanks,
Ming
