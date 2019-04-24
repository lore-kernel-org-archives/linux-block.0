Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551ACC282CE
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 14:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD50218FD
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 14:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbfDXOhV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:37:21 -0400
Received: from verein.lst.de ([213.95.11.211]:54254 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730645AbfDXOhU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 10:37:20 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B28AB67358; Wed, 24 Apr 2019 16:37:04 +0200 (CEST)
Date:   Wed, 24 Apr 2019 16:37:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH V2 1/2] scsi: core: avoid to pre-allocate big chunk for
 protection meta data
Message-ID: <20190424143704.GC21209@lst.de>
References: <20190424093540.15526-1-ming.lei@redhat.com> <20190424093540.15526-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424093540.15526-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> -	if (scsi_prot_sg_count(cmd))
> -		sg_free_table_chained(&cmd->prot_sdb->table, true);
> +	if (scsi_prot_sg_count(cmd) && cmd->prot_sdb->table.sgl !=
> +			scsi_prot_inline_sg(cmd))
> +		sg_free_table_chained(&cmd->prot_sdb->table, false);

Nipick: I usually find it easier to read if we break around conditions
instead of inside them:

	if (scsi_prot_sg_count(cmd) &&
	    cmd->prot_sdb->table.sgl != scsi_prot_inline_sg(cmd))

> +		if (ivecs <= SCSI_INLINE_PROT_SG_CNT) {
> +			scsi_init_inline_sg_table(&prot_sdb->table,
> +						  scsi_prot_inline_sg(cmd),
> +						  SCSI_INLINE_PROT_SG_CNT);
> +		} else if (sg_alloc_table_chained(&prot_sdb->table,
> +						  ivecs, NULL)) {

Hmm.  Maybe we just need to pass an nr_inline_vecs argument
to sg_alloc_table_chained to replace the SG_CHUNK_SIZE argument instead
of open coding this logic?

If we'd also pass it to sg_free_table_chained we could also simplify
those checks in all callers.
