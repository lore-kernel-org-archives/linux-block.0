Return-Path: <SRS0=SuLc=OA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242B4C43441
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DE5214C4
	for <linux-block@archiver.kernel.org>; Wed, 21 Nov 2018 13:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B1uNtGnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7DE5214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbeKUXqc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:46:32 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54122 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeKUXqc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Nov 2018 18:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/2IGolipt7iMZwOSiSPhHOrxkeULUg7KkhIguirXgN8=; b=B1uNtGnx9z90HBQ/eUceZq5Dk
        ihEF5R+Es8tOpnof3L5CaYBYHh3NOQarXHEZ3gc+WgyMXGM2MmhW1YPquTDvy8lgkuZjnMOuUikYz
        3tb3jBR6JL0w2eQufZRGWUZOwYYaqm3LnTTRt19MJfldBkAuCav6OmCJt0Q9jF5yOvHxEPtyFOis5
        dNj8cQDJbViyIGJjRtR1aHpGlC15tb5zzNTJUCtEoyXbGI0/VaYIodGtdg5cpn5DeZHVvhjM0Tm9l
        DOqKuUsPIZVrJYEADulFAfrrYO1H/j+yfWOsDPxj+26tjol4uLfZasXhDt56F90D2Q+wgWeUqp3aH
        v8pip6r0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPSIe-0003bH-72; Wed, 21 Nov 2018 13:12:12 +0000
Date:   Wed, 21 Nov 2018 05:12:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv3 2/3] scsi: Do not rely on blk-mq for double completions
Message-ID: <20181121131212.GA7251@infradead.org>
References: <20181115175820.13391-1-keith.busch@intel.com>
 <20181115175820.13391-3-keith.busch@intel.com>
 <20181119085815.GB29626@infradead.org>
 <20181119151859.GB23062@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119151859.GB23062@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 19, 2018 at 08:19:00AM -0700, Keith Busch wrote:
> On Mon, Nov 19, 2018 at 12:58:15AM -0800, Christoph Hellwig wrote:
> > > index 5d83a162d03b..c1d5e4e36125 100644
> > > --- a/drivers/scsi/scsi_lib.c
> > > +++ b/drivers/scsi/scsi_lib.c
> > > @@ -1635,8 +1635,11 @@ static blk_status_t scsi_mq_prep_fn(struct request *req)
> > >  
> > >  static void scsi_mq_done(struct scsi_cmnd *cmd)
> > >  {
> > > +	if (unlikely(test_and_set_bit(__SCMD_COMPLETE, &cmd->flags)))
> > > +		return;
> > >  	trace_scsi_dispatch_cmd_done(cmd);
> > > -	blk_mq_complete_request(cmd->request);
> > > +	if (unlikely(!blk_mq_complete_request(cmd->request)))
> > > +		clear_bit(__SCMD_COMPLETE, &cmd->flags);
> > >  }
> > 
> > This looks a little odd to me.  If we didn't complete the command
> > someone else did.  Why would we clear the bit in this case?
> 
> It's only to go along with the fake timeout. If we don't clear the bit,
> then then scsi timeout handler will believe it has nothing to do because
> scsi did its required part. The block layer just pretends the LLD didn't
> do its part, so scsi has to play along too.

This just looks way to magic to me.  In other word - it needs a big fat
comment explaining the situation.

> > > +#define __SCMD_COMPLETE		3
> > > +#define SCMD_COMPLETE		(1 << __SCMD_COMPLETE)
> > 
> > This mixing of atomic and non-atomic bitops looks rather dangerous
> > to me.  Can you add a new atomic_flags just for the completed flag,
> > and always use the bitops on it for now? I think we can eventually
> > kill most of the existing flags except for SCMD_TAGGED over the
> > next merge window or two and then move that over as well.
> 
> The only concurrent access is completion + timeout, otherwise access is
> single-threaded. I'm using the atomic operations only where it is
> needed.
> 
> We implicitly clear the SCMD_COMPLETED flag along with SCMD_TAGGED in
> scsi_init_command() too, and I didn't want to add new overhead with
> new atomics.

In general mixing access types on a single field (nevermind bit)
is going to cause us problems further down the road sooner or later.

I'd be much happier with a separate field.
