Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E6CC10F03
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 00:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C70218D3
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 00:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbfDXAqg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:46:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40862 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbfDXAqf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 20:46:35 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A9627C7C31;
        Wed, 24 Apr 2019 00:46:35 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2435916BE5;
        Wed, 24 Apr 2019 00:46:27 +0000 (UTC)
Date:   Wed, 24 Apr 2019 08:46:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 1/2] scsi: core: avoid to pre-allocate big chunk for
 protection meta data
Message-ID: <20190424004621.GA634@ming.t460p>
References: <20190423103240.29864-1-ming.lei@redhat.com>
 <20190423103240.29864-2-ming.lei@redhat.com>
 <1556033627.161891.120.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556033627.161891.120.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 24 Apr 2019 00:46:35 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 23, 2019 at 08:33:47AM -0700, Bart Van Assche wrote:
> On Tue, 2019-04-23 at 18:32 +0800, Ming Lei wrote:
> > +/*
> > + * Size of integrity meta data size is usually small, 1 inline sg
>                         ^^^^^^^^^^^^^^
> Please change this into "metadata". Mentioning "size" twice is not
> useful.

OK

> > + * should cover normal cases.
> > + */
> > +#define  SCSI_INLINE_PROT_SG_CNT  1
> > +
> >  static struct kmem_cache *scsi_sdb_cache;
> >  static struct kmem_cache *scsi_sense_cache;
> >  static struct kmem_cache *scsi_sense_isadma_cache;
> > @@ -553,12 +559,21 @@ static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
> >         }
> >  }
> >  
> > +static inline bool scsi_prot_use_inline_sg(struct scsi_cmnd *cmd)
> > +{
> > +       if (!scsi_prot_sglist(cmd))
> > +               return false;
> 
> Since scsi_prot_use_inline_sg() is only called if scsi_prot_sg_count() > 0,
> is the above test necessary?

Yeah, the check can be removed.

> 
> > +       return cmd->prot_sdb->table.sgl ==
> > +               (struct scatterlist *)(cmd->prot_sdb + 1);
> > +}
> > +
> >  static void scsi_mq_free_sgtables(struct scsi_cmnd *cmd)
> >  {
> >         if (cmd->sdb.table.nents)
> >                 sg_free_table_chained(&cmd->sdb.table, true);
> > -       if (scsi_prot_sg_count(cmd))
> > -               sg_free_table_chained(&cmd->prot_sdb->table, true);
> > +       if (scsi_prot_sg_count(cmd) && !scsi_prot_use_inline_sg(cmd))
> > +               sg_free_table_chained(&cmd->prot_sdb->table, false);
> >  }
> >  
> >  static void scsi_mq_uninit_cmd(struct scsi_cmnd *cmd)
> > @@ -1044,9 +1059,11 @@ blk_status_t scsi_init_io(struct scsi_cmnd *cmd)
> >                 }
> >  
> >                 ivecs = blk_rq_count_integrity_sg(rq->q, rq->bio);
> > -
> > -               if (sg_alloc_table_chained(&prot_sdb->table, ivecs,
> > -                               prot_sdb->table.sgl)) {
> > +               if (ivecs <= SCSI_INLINE_PROT_SG_CNT)
> > +                       prot_sdb->table.nents = prot_sdb->table.orig_nents =
> > +                               SCSI_INLINE_PROT_SG_CNT;
> 
> Please call sg_init_table() instead of open-coding it.

OK.

Thanks,
Ming
