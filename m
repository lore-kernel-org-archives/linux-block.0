Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410ACC43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 18:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158C020661
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 18:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfCHSPU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 13:15:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:14676 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbfCHSPU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Mar 2019 13:15:20 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2019 10:15:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,456,1544515200"; 
   d="scan'208";a="132438933"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2019 10:15:19 -0800
Date:   Fri, 8 Mar 2019 11:15:51 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>, t@localhost.localdomain
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/5] blk-mq: Export reading mq request state
Message-ID: <20190308181551.GB5214@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <1552068443.45180.24.camel@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552068443.45180.24.camel@acm.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 08, 2019 at 10:07:23AM -0800, Bart Van Assche wrote:
> On Fri, 2019-03-08 at 10:40 -0700, Keith Busch wrote:
> > Drivers may need to know the state of their requets.
> 
> Hi Keith,
> 
> What makes you think that drivers should be able to check the state of their
> requests? Please elaborate.

Patches 4 and 5 in this series.
 
> > diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> > index faed9d9eb84c..db113aee48bb 100644
> > --- a/include/linux/blkdev.h
> > +++ b/include/linux/blkdev.h
> > @@ -241,6 +241,15 @@ struct request {
> >  	struct request *next_rq;
> >  };
> >  
> > +/**
> > + * blk_mq_rq_state() - read the current MQ_RQ_* state of a request
> > + * @rq: target request.
> > + */
> > +static inline enum mq_rq_state blk_mq_rq_state(struct request *rq)
> > +{
> > +	return READ_ONCE(rq->state);
> > +}
> 
> Please also explain how drivers can use this function without triggering a
> race condition with the code that modifies rq->state.

Either queisced or within a timeout handler that already locks the
request lifetime.
