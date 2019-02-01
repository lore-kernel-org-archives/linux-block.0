Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670D7C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2A521872
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbfBAPND (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:13:03 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:44988 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbfBAPND (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Fri, 1 Feb 2019 10:13:03 -0500
Received: from apollon.fritz.box (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Fri, 01 Feb 2019 08:12:52 -0700
Message-ID: <377ae0bfe01ce2c328ce62e2b66074184280f881.camel@suse.com>
Subject: Re: [PATCH 1/4] block: disk_events: introduce event flags
From:   Martin Wilck <mwilck@suse.com>
To:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>
Cc:     James Bottomley <jejb@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi@vger.kernel.org
Date:   Fri, 01 Feb 2019 16:12:48 +0100
In-Reply-To: <8ae008d68e4c532af57a5065a9ff96280e81e309.camel@suse.com>
References: <20190118213207.2309-1-mwilck@suse.com>
         <20190118213207.2309-2-mwilck@suse.com>
         <be93f1f5-cb79-04b2-5fc1-140678245197@suse.de>
         <8ae008d68e4c532af57a5065a9ff96280e81e309.camel@suse.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hannes, all,

On Mon, 2019-01-28 at 14:54 +0100, Martin Wilck wrote:
> On Sat, 2019-01-26 at 11:09 +0100, Hannes Reinecke wrote:
> > On 1/18/19 10:32 PM, Martin Wilck wrote:
> > > Currently, an empty disk->events field tells the block layer not
> > > to
> > > forward
> > > media change events to user space. This was done in commit
> > > 7c88a168da80 ("block:
> > > don't propagate unlisted DISK_EVENTs to userland") in order to
> > > avoid events
> > > from "fringe" drivers to be forwarded to user space. By doing so,
> > > the block
> > > layer lost the information which events were supported by a
> > > particular
> > > block device, and most importantly, whether or not a given device
> > > supports
> > > media change events at all.
> > > 
> > > Prepare for not interpreting the "events" field this way in the
> > > future any
> > > more. This is done by adding two flag bits that can be set to
> > > have
> > > the
> > > device treated like one that has the "events" field set to a non-
> > > zero value
> > > before. This applies only to the sd and sr drivers, which are
> > > changed to
> > > set the new flags.
> > > 
> > > The new flags are DISK_EVENT_FLAG_POLL to enforce polling of the
> > > device for
> > > synchronous events, and DISK_EVENT_FLAG_UEVENT to tell the
> > > blocklayer to
> > > generate udev events from kernel events. They can easily be fit
> > > in
> > > the int
> > > reserved for event bits.
> > > 
> > > This patch doesn't change behavior.
> > > 
> > > Signed-off-by: Martin Wilck <mwilck@suse.com>
> > > ---
> > >   block/genhd.c         | 22 ++++++++++++++++------
> > >   drivers/scsi/sd.c     |  3 ++-
> > >   drivers/scsi/sr.c     |  3 ++-
> > >   include/linux/genhd.h |  7 +++++++
> > >   4 files changed, 27 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/block/genhd.c b/block/genhd.c
> > > index 1dd8fd6..bcd16f6 100644
> > > --- a/block/genhd.c
> > > +++ b/block/genhd.c
> > > @@ -1631,7 +1631,8 @@ static unsigned long
> > > disk_events_poll_jiffies(struct gendisk *disk)
> > >   	 */
> > >   	if (ev->poll_msecs >= 0)
> > >   		intv_msecs = ev->poll_msecs;
> > > -	else if (disk->events & ~disk->async_events)
> > > +	else if (disk->events & DISK_EVENT_FLAG_POLL
> > > +		 && disk->events & ~disk->async_events)
> > >   		intv_msecs = disk_events_dfl_poll_msecs;
> > >   
> > >   	return msecs_to_jiffies(intv_msecs);
> > Hmm. That is an ... odd condition.
> > Clearly it's pointless to have the event bit set in the ->events
> > mask
> > if 
> > it's already part of the ->async_events mask.
> 
> The "events" bit has to be set in that case. "async_events" is
> defined
> as a subset of "events", see genhd.h. You can trivially verify that
> this is currently true, as NO driver that sets any bit in the
> "async_events" field. I was wondering if "async_events" can't be
> ditched completely, but I didn't want to make that aggressive a
> change
> in this patch set.
> 
> > But shouldn't we better _prevent_ this from happening, ie refuse to
> > set
> > DISK_EVENT_FLAG_POLL in events if it's already in ->async_events?
> > Then the above check would be simplified.
> 
> Asynchronous events need not be polled for, therefore setting the
> POLL
> flag in async_events makes no sense. My intention was to use these
> "flag" bits in the "events" field only. Perhaps I should have
> expressed
> that more clearly?
> 
> Anyway, unless I'm really blind, the condition above is actually the
> same as before, just that I now require the POLL flag to be set as
> well, which is the main point of the patch.

Does this response make sense? If yes, can we get the set merged?
If no, what do I need to change? Should I add a patch that does away
with the unused async_events field?

Thanks
Martin


-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)


