Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F06C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 15:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F2820870
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 15:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F2820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbeKTBqL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:46:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:21830 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729483AbeKTBqK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 20:46:10 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 07:22:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,252,1539673200"; 
   d="scan'208";a="281221510"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 19 Nov 2018 07:22:16 -0800
Date:   Mon, 19 Nov 2018 08:19:00 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv3 2/3] scsi: Do not rely on blk-mq for double completions
Message-ID: <20181119151859.GB23062@localhost.localdomain>
References: <20181115175820.13391-1-keith.busch@intel.com>
 <20181115175820.13391-3-keith.busch@intel.com>
 <20181119085815.GB29626@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119085815.GB29626@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 19, 2018 at 12:58:15AM -0800, Christoph Hellwig wrote:
> > index 5d83a162d03b..c1d5e4e36125 100644
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -1635,8 +1635,11 @@ static blk_status_t scsi_mq_prep_fn(struct request *req)
> >  
> >  static void scsi_mq_done(struct scsi_cmnd *cmd)
> >  {
> > +	if (unlikely(test_and_set_bit(__SCMD_COMPLETE, &cmd->flags)))
> > +		return;
> >  	trace_scsi_dispatch_cmd_done(cmd);
> > -	blk_mq_complete_request(cmd->request);
> > +	if (unlikely(!blk_mq_complete_request(cmd->request)))
> > +		clear_bit(__SCMD_COMPLETE, &cmd->flags);
> >  }
> 
> This looks a little odd to me.  If we didn't complete the command
> someone else did.  Why would we clear the bit in this case?

It's only to go along with the fake timeout. If we don't clear the bit,
then then scsi timeout handler will believe it has nothing to do because
scsi did its required part. The block layer just pretends the LLD didn't
do its part, so scsi has to play along too.

> >  static void scsi_mq_put_budget(struct blk_mq_hw_ctx *hctx)
> > @@ -1701,6 +1704,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
> >  			goto out_dec_host_busy;
> >  		req->rq_flags |= RQF_DONTPREP;
> >  	} else {
> > +		cmd->flags &= ~SCMD_COMPLETE;
> >  		blk_mq_start_request(req);
> >  	}
> >  
> > diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
> > index d6fd2aba0380..ded7c7194a28 100644
> > --- a/include/scsi/scsi_cmnd.h
> > +++ b/include/scsi/scsi_cmnd.h
> > @@ -58,6 +58,9 @@ struct scsi_pointer {
> >  #define SCMD_TAGGED		(1 << 0)
> >  #define SCMD_UNCHECKED_ISA_DMA	(1 << 1)
> >  #define SCMD_INITIALIZED	(1 << 2)
> > +
> > +#define __SCMD_COMPLETE		3
> > +#define SCMD_COMPLETE		(1 << __SCMD_COMPLETE)
> 
> This mixing of atomic and non-atomic bitops looks rather dangerous
> to me.  Can you add a new atomic_flags just for the completed flag,
> and always use the bitops on it for now? I think we can eventually
> kill most of the existing flags except for SCMD_TAGGED over the
> next merge window or two and then move that over as well.

The only concurrent access is completion + timeout, otherwise access is
single-threaded. I'm using the atomic operations only where it is
needed.

We implicitly clear the SCMD_COMPLETED flag along with SCMD_TAGGED in
scsi_init_command() too, and I didn't want to add new overhead with
new atomics.

> Otherwise the concept looks fine to me.
