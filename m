Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35A9C10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 09:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA38920685
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 09:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfDYJhm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:37:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43536 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbfDYJhl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 05:37:41 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8CC3E86671;
        Thu, 25 Apr 2019 09:37:41 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 711741001E7D;
        Thu, 25 Apr 2019 09:37:35 +0000 (UTC)
Date:   Thu, 25 Apr 2019 17:37:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH V2 1/2] scsi: core: avoid to pre-allocate big chunk for
 protection meta data
Message-ID: <20190425093729.GB28630@ming.t460p>
References: <20190424093540.15526-1-ming.lei@redhat.com>
 <20190424093540.15526-2-ming.lei@redhat.com>
 <20190424143704.GC21209@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424143704.GC21209@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 25 Apr 2019 09:37:41 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 24, 2019 at 04:37:04PM +0200, Christoph Hellwig wrote:
> > -	if (scsi_prot_sg_count(cmd))
> > -		sg_free_table_chained(&cmd->prot_sdb->table, true);
> > +	if (scsi_prot_sg_count(cmd) && cmd->prot_sdb->table.sgl !=
> > +			scsi_prot_inline_sg(cmd))
> > +		sg_free_table_chained(&cmd->prot_sdb->table, false);
> 
> Nipick: I usually find it easier to read if we break around conditions
> instead of inside them:
> 
> 	if (scsi_prot_sg_count(cmd) &&
> 	    cmd->prot_sdb->table.sgl != scsi_prot_inline_sg(cmd))

OK.

> 
> > +		if (ivecs <= SCSI_INLINE_PROT_SG_CNT) {
> > +			scsi_init_inline_sg_table(&prot_sdb->table,
> > +						  scsi_prot_inline_sg(cmd),
> > +						  SCSI_INLINE_PROT_SG_CNT);
> > +		} else if (sg_alloc_table_chained(&prot_sdb->table,
> > +						  ivecs, NULL)) {
> 
> Hmm.  Maybe we just need to pass an nr_inline_vecs argument
> to sg_alloc_table_chained to replace the SG_CHUNK_SIZE argument instead
> of open coding this logic?

We can do that, however the current scatterlist code assumes that size
of each SGL is fixed. We may change the logic to support this feature,
seems not too difficult to do that.

Please let us know if you are fine to change the scatterlist code for
supporting customized size of the 1st SGL.


Thanks,
Ming
