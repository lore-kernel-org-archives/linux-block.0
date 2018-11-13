Return-Path: <SRS0=aXbO=NY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26152C43441
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 19:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E098D216FD
	for <linux-block@archiver.kernel.org>; Tue, 13 Nov 2018 19:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E098D216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeKNFsX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:48:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:14282 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeKNFsX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 00:48:23 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 11:48:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,229,1539673200"; 
   d="scan'208";a="104089199"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga002.fm.intel.com with ESMTP; 13 Nov 2018 11:48:45 -0800
Date:   Tue, 13 Nov 2018 12:45:17 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: Do not rely on blk-mq for double completions
Message-ID: <20181113194517.GA10134@localhost.localdomain>
References: <20181113185712.10063-1-keith.busch@intel.com>
 <b2d9c646-3311-9f85-6e8b-de3ddf295899@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2d9c646-3311-9f85-6e8b-de3ddf295899@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 13, 2018 at 12:20:46PM -0700, Jens Axboe wrote:
> On 11/13/18 11:57 AM, Keith Busch wrote:
> >  static void scsi_mq_done(struct scsi_cmnd *cmd)
> >  {
> > +	if (test_and_set_bit(__SCMD_COMPLETE, &cmd->flags))
> > +		return;
> >  	trace_scsi_dispatch_cmd_done(cmd);
> >  	blk_mq_complete_request(cmd->request);
> > +
> > +#ifdef CONFIG_FAIL_IO_TIMEOUT
> > +	/*
> > +	 * Clearing complete here serves only to allow the desired recovery to
> > +	 * escalate on blk_rq_should_fake_timeout()'s error injection.
> > +	 */
> > +	clear_bit(__SCMD_COMPLETE, &cmd->flags);
> > +#endif
> >  }
> 
> We could have this be:
> 
> static void scsi_mq_done(struct scsi_cmnd *cmd)
> {
> 	if (test_and_set_bit(__SCMD_COMPLETE, &cmd->flags))
> 		return;
>  	trace_scsi_dispatch_cmd_done(cmd);
> 
>  	if (blk_mq_complete_request(cmd->request)) {
> 		/*
> 		 * Clearing complete here serves only to allow the
> 		 * desired recovery to escalate on
> 		 * blk_rq_should_fake_timeout()'s error injection.
> 		 */
> 		clear_bit(__SCMD_COMPLETE, &cmd->flags);
> 	}
> }
> 
> with
> 
> bool blk_mq_complete_request(struct request *rq)
> {
> 	if (unlikely(blk_should_fake_timeout(rq->q)))
> 		return true;
> 	__blk_mq_complete_request(rq);
> 	return false;
> }
> 
> and not have this CONFIG_FAIL_IO_TIMEOUT dependency, but that'd be a bit
> more expensive.

I was trying to avoid every cost no matter how negligable (those are the
only types of costs left as far as I can see), but I think your proposal
might actually be necessary: if a timeout wasn't faked, clearing the
completion flag unconditionally might have a problem with a real timeout
racing with the real completion. :(
