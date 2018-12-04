Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E611C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 21:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2FB20834
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 21:24:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D2FB20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbeLDVYD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:24:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:26872 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726425AbeLDVYC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 16:24:02 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 13:24:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,315,1539673200"; 
   d="scan'208";a="127098453"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga001.fm.intel.com with ESMTP; 04 Dec 2018 13:24:01 -0800
Date:   Tue, 4 Dec 2018 14:21:17 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     James Smart <james.smart@broadcom.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] blk-mq: Export iterating all tagged requests
Message-ID: <20181204212117.GC16751@localhost.localdomain>
References: <20181130202635.11145-1-keith.busch@intel.com>
 <823fc3bf-78a4-c8fb-c80c-e3944f320af0@kernel.dk>
 <20181201164804.GB19557@lst.de>
 <9346f289-f265-e2ee-2d2c-c97973b45e23@suse.de>
 <8cd9a950-6605-6387-e4d4-4346a46da781@grimberg.me>
 <20181204154559.GJ14775@localhost.localdomain>
 <11e02aa5-b0cb-b4cf-0af4-da3db8db9e36@grimberg.me>
 <20181204174806.GA16751@localhost.localdomain>
 <b5b306cd-7341-7ce3-f2dc-fe98a01327fe@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5b306cd-7341-7ce3-f2dc-fe98a01327fe@broadcom.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 04, 2018 at 11:33:33AM -0800, James Smart wrote:
> 
> 
> On 12/4/2018 9:48 AM, Keith Busch wrote:
> > On Tue, Dec 04, 2018 at 09:38:29AM -0800, Sagi Grimberg wrote:
> > > > > > Yes, I'm very much in favour of this, too.
> > > > > > We always have this IMO slightly weird notion of stopping the queue, set
> > > > > > some error flags in the driver, then _restarting_ the queue, just so
> > > > > > that the driver then sees the error flag and terminates the requests.
> > > > > > Which I always found quite counter-intuitive.
> > > > > What about requests that come in after the iteration runs? how are those
> > > > > terminated?
> > > > If we've reached a dead state, I think you'd want to start a queue freeze
> > > > before running the terminating iterator.
> > > Its not necessarily dead, in fabrics we need to handle disconnections
> > > that last for a while before we are able to reconnect (for a variety of
> > > reasons) and we need a way to fail I/O for failover (or requeue, or
> > > block its up to the upper layer). Its less of a "last resort" action
> > > like in the pci case.
> > > 
> > > Does this guarantee that after freeze+iter we won't get queued with any
> > > other request? If not then we still need to unfreeze and fail at
> > > queue_rq.
> > It sounds like there are different scenarios to consider.
> > 
> > For the dead controller, we call blk_cleanup_queue() at the end which
> > ends callers who blocked on entering.
> > 
> > If you're doing a failover, you'd replace the freeze with a current path
> > update in order to prevent new requests from entering.
> and if you're not multipath ?    I assume you want the io queues to be
> frozen so they queue there - which can block threads such as ns
> verification. It's good to have them live, as todays checks bounce the io,
> letting the thread terminate as its in a reset/reconnect state, which allows
> those threads to exit out or finish before a new reconnect kicks them off
> again. We've already been fighting deadlocks with the reset/delete/rescan
> paths and these io paths. suspending the queues completely over the
> reconnect will likely create more issues in this area.
> 
> 
> > In either case, you don't need checks in queue_rq. The queue_rq check
> > is redundant with the quiesce state that blk-mq already provides.
> 
> I disagree.  The cases I've run into are on the admin queue - where we are
> sending io to initialize the controller when another error/reset occurs, and
> the checks are required to identify/reject the "old" initialization
> commands, with another state check allowing them to proceed on the "new"
> initialization commands.  And there are also cases for ioctls and other
> things that occur during the middle of those initialization steps that need
> to be weeded out.   The Admin queue has to be kept live to allow the
> initialization commands on the new controller.
> 
> state checks are also needed for those namespace validation cases....
> 
> > 
> > Once quiesced, the proposed iterator can handle the final termination
> > of the request, perform failover, or some other lld specific action
> > depending on your situation.
> 
> I don't believe they can remain frozen, definitely not for the admin queue.
> -- james

Quiesced and frozen carry different semantics.

My understanding of the nvme-fc implementation is that it returns
BLK_STS_RESOURCE in the scenario you've described where the admin
command can't be executed at the moment. That just has the block layer
requeue it for later resubmission 3 milliseconds later, which will
continue to return the same status code until you're really ready for
it.

What I'm proposing is that instead of using that return code, you may
have nvme-fc control when to dispatch those queued requests by utilizing
the blk-mq quiesce on/off states. Is there a reason that wouldn't work?
