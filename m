Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744FFC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 15:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44DCD20862
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 15:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DCD20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbeK0C3F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:29:05 -0500
Received: from mga17.intel.com ([192.55.52.151]:43195 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbeK0C3F (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 21:29:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 07:34:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,282,1539673200"; 
   d="scan'208";a="111662587"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga002.jf.intel.com with ESMTP; 26 Nov 2018 07:34:36 -0800
Date:   Mon, 26 Nov 2018 08:31:35 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org,
        Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv3 2/3] scsi: Do not rely on blk-mq for double completions
Message-ID: <20181126153135.GN26707@localhost.localdomain>
References: <20181115175820.13391-1-keith.busch@intel.com>
 <20181115175820.13391-3-keith.busch@intel.com>
 <20181119085815.GB29626@infradead.org>
 <20181119151859.GB23062@localhost.localdomain>
 <20181121131212.GA7251@infradead.org>
 <913ec33d-9aff-2c48-362f-9252ed111451@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <913ec33d-9aff-2c48-362f-9252ed111451@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 08:32:45AM -0700, Jens Axboe wrote:
> On 11/21/18 6:12 AM, Christoph Hellwig wrote:
> > On Mon, Nov 19, 2018 at 08:19:00AM -0700, Keith Busch wrote:
> >> On Mon, Nov 19, 2018 at 12:58:15AM -0800, Christoph Hellwig wrote:
> >>>> index 5d83a162d03b..c1d5e4e36125 100644
> >>>> --- a/drivers/scsi/scsi_lib.c
> >>>> +++ b/drivers/scsi/scsi_lib.c
> >>>> @@ -1635,8 +1635,11 @@ static blk_status_t scsi_mq_prep_fn(struct request *req)
> >>>>  
> >>>>  static void scsi_mq_done(struct scsi_cmnd *cmd)
> >>>>  {
> >>>> +	if (unlikely(test_and_set_bit(__SCMD_COMPLETE, &cmd->flags)))
> >>>> +		return;
> >>>>  	trace_scsi_dispatch_cmd_done(cmd);
> >>>> -	blk_mq_complete_request(cmd->request);
> >>>> +	if (unlikely(!blk_mq_complete_request(cmd->request)))
> >>>> +		clear_bit(__SCMD_COMPLETE, &cmd->flags);
> >>>>  }
> >>>
> >>> This looks a little odd to me.  If we didn't complete the command
> >>> someone else did.  Why would we clear the bit in this case?
> >>
> >> It's only to go along with the fake timeout. If we don't clear the bit,
> >> then then scsi timeout handler will believe it has nothing to do because
> >> scsi did its required part. The block layer just pretends the LLD didn't
> >> do its part, so scsi has to play along too.
> > 
> > This just looks way to magic to me.  In other word - it needs a big fat
> > comment explaining the situation.
> > 
> >>>> +#define __SCMD_COMPLETE		3
> >>>> +#define SCMD_COMPLETE		(1 << __SCMD_COMPLETE)
> >>>
> >>> This mixing of atomic and non-atomic bitops looks rather dangerous
> >>> to me.  Can you add a new atomic_flags just for the completed flag,
> >>> and always use the bitops on it for now? I think we can eventually
> >>> kill most of the existing flags except for SCMD_TAGGED over the
> >>> next merge window or two and then move that over as well.
> >>
> >> The only concurrent access is completion + timeout, otherwise access is
> >> single-threaded. I'm using the atomic operations only where it is
> >> needed.
> >>
> >> We implicitly clear the SCMD_COMPLETED flag along with SCMD_TAGGED in
> >> scsi_init_command() too, and I didn't want to add new overhead with
> >> new atomics.
> > 
> > In general mixing access types on a single field (nevermind bit)
> > is going to cause us problems further down the road sooner or later.
> > 
> > I'd be much happier with a separate field.
> 
> Keith, will you please respin with the separate field? Would be nice
> to get this merged for 4.21.

I'll send out a new version today.
