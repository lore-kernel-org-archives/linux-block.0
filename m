Return-Path: <SRS0=ACpf=VH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589ACC74A2B
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 16:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A4A52064A
	for <linux-block@archiver.kernel.org>; Wed, 10 Jul 2019 16:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JBwaY1N3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfGJQh6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Jul 2019 12:37:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38964 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbfGJQh6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jul 2019 12:37:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Fkk5CQrvbQmz910+nDarH8dT3fgvW9p14CpAtY4KGJg=; b=JBwaY1N3f2V0ERIPruimAIsDx
        uQtYAZFbfhu6AQ+Yl+yprPoIQ5gXzB0ok9j5VPbSYtRSToFH/2RacDxcTCCqeU4F+UfHrbVjSPztB
        njwFC2GsgZNayKi/UdafoEP9Cut/ZbNN6Y5f3ZcHYKEduoZ3ZLiz8Ov37g48dmQMqkMPiQSOyS7ux
        mdECyWgVxhRJC0J2y50WmNUImvHn71GIcMR1PesLsmCVLmbgRJ4swNECWEQssWvDt1VtGLLlUpzkN
        /LM5K69LbC26qhbEtkzvXkGJtI81DajUzNJy3u9mXcvx87/4ujvS4Kz94IfGURtTMHD4EmmC2sJHm
        Dp1HjPw2Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hlFbP-0001oy-Ch; Wed, 10 Jul 2019 16:37:55 +0000
Date:   Wed, 10 Jul 2019 09:37:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2] block: Disable write plugging for zoned block devices
Message-ID: <20190710163755.GA6119@infradead.org>
References: <20190710155447.11112-1-damien.lemoal@wdc.com>
 <71be2c3f-2e26-dfd4-72de-2eabdddd311f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71be2c3f-2e26-dfd4-72de-2eabdddd311f@kernel.dk>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 10, 2019 at 09:57:05AM -0600, Jens Axboe wrote:
> On 7/10/19 9:54 AM, Damien Le Moal wrote:
> > diff --git a/block/blk-mq.h b/block/blk-mq.h
> > index 633a5a77ee8b..c9195a2cd670 100644
> > --- a/block/blk-mq.h
> > +++ b/block/blk-mq.h
> > @@ -238,4 +238,14 @@ static inline void blk_mq_clear_mq_map(struct blk_mq_queue_map *qmap)
> >   		qmap->mq_map[cpu] = 0;
> >   }
> >   
> > +static inline struct blk_plug *blk_mq_plug(struct request_queue *q,
> > +					   struct bio *bio)
> > +{
> > +	if (!blk_queue_is_zoned(q) || !op_is_write(bio_op(bio)))
> > +		return current->plug;
> > +
> > +	/* Zoned block device write case: do not plug the BIO */
> > +	return NULL;
> > +}
> > +
> >   #endif
> 
> Folks are going to look at that and be puzzled, I think that function
> deserves a comment.

Agreed.  Also I'd reformat the conditionals to make the default
case more obvious:

	if (blk_queue_is_zoned(q) && op_is_write(bio_op(bio)))
		return NULL;
	return current->plug;
